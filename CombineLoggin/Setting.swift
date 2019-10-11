//
//  Setting.swift
//  CombineLoggin
//
//  Created by 游宗諭 on 2019/10/8.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import Combine

class Setting {
    
    @UserDefault("Account", defaultValue: "") var keepAccount:String
    @UserDefault("logginDate", defaultValue: []) var logginDate:[String]
    
    var oneTimePublisher: Just<String> {Just(self.keepAccount)}
    var logginDatePublisher:Just<[String]>{Just(self.logginDate)}
}
