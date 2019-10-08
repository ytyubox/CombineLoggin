//
//  ViewController.swift
//  CombineLoggin
//
//  Created by 游宗諭 on 2019/10/8.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var autoLoginSwitch: UISwitch!
    @IBOutlet weak var loginButton: UIButton!
    var set = Set<AnyCancellable>()
    let setting = Setting()
    override func viewDidLoad() {
        super.viewDidLoad()
        let accountPublisher = accountTextField
            .publisher(for: .editingChanged)
            .map(\.text)
            .prepend(setting.keepAccount)
            .replaceNil(with: "")
        let passwordPublisher = passwordTextField
            .publisher(for: .editingChanged)
            .map(\.text)
            .replaceNil(with: "")
        Publishers.CombineLatest(accountPublisher, passwordPublisher)
            .map{$0.0.count > 2 && $0.1.count > 2}
            .assign(to: \UIButton.isEnabled, on: loginButton)
            .store(in: &set)
        setting.oneTimePublisher
            .map{!$0.isEmpty}
            .assign(to: \.isOn, on: autoLoginSwitch)
            .store(in: &set)
       _ = setting.oneTimePublisher
            .map{$0 as String?}
            .assign(to: \.text, on: accountTextField)
            
       _ = autoLoginSwitch.publisher(for: .valueChanged).map(\.isOn).prepend(autoLoginSwitch.isOn)
            .combineLatest(accountPublisher.debounce(for: .seconds(0.5), scheduler: RunLoop.main))
            .map{ $0.0 ? $0.1 : ""}
            .receive(on: RunLoop.main)
            .assign(to: \Setting.keepAccount, on: setting)
            .store(in: &set)
        }
}
