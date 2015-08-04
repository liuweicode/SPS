//
//  Config.swift
//  Exercise
//
//  Created by 楼顶 on 15/7/29.
//  Copyright (c) 2015年 楼顶. All rights reserved.
//

import UIKit
import SSKeychain

let kService            =       "Louding"   // SSKeychain Service
let kAccount            =       "account"   // 登录帐号
let kPortrait           =       "portrait"  // 登录用户头像


/* API接口的IP/端口 */
let HTTP = "http"
let HOST = "key.louding.com"
let PORT = 3023

let IMHOST = "key.louding.com"
let IMPORT = 3334

/* 数据库名称 */
let DBNAME = "SPS.db"
/* 数据库是否初始化成功 */
let kIsDatabaseInitialized = "IsDatabaseInitialized"


@objc class  LoginUser: NSCoding {
    
    var accountId:Int?                           //用户ID
    var gender : UserGender = .Female            //用户性别，默认为0
    
    required init(coder aDecoder: NSCoder) {
        accountId = aDecoder.decodeIntegerForKey("accountId")
        gender = UserGender(rawValue: aDecoder.decodeIntegerForKey("gender"))!
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(accountId! , forKey: "accountId")
        aCoder.encodeInteger(gender.rawValue, forKey: "gender")
    }
    
    
}

class Config: NSObject {
    
    // MARK : - 与API 相关
    //API地址
    class func getApiURL(action:String) ->  String
    {
        return "\(HTTP)://\(HOST):\(PORT)\(action)"
    }
    
    // MARK : - 与用户相关
    // 保存当前用户的账号
    class func saveOwnAccount(#account:String,password:String)
    {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(account, forKey: kAccount)
        userDefaults.synchronize()
        SSKeychain.setPassword(password, forService: kService, account: account)
    }
    
    // 获取当前登录用户的账号和密码
    class func getOwnAccountAndPassword() -> (String,String)?
    {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let account = userDefaults.stringForKey(kAccount)
        {
            var password = SSKeychain.passwordForService(kService, account: account)
            
            return (account,password)
        }
        return nil
    }
    
    //保存当前用户的头像
    class func savePortrait(portrait:UIImage)
    {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(UIImagePNGRepresentation(portrait), forKey: kPortrait)
        userDefaults.synchronize()
    }
    
    /// 获取当前用户头像
    class func getPortrait() -> UIImage?
    {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        if let data:NSData = userDefaults.objectForKey(kPortrait) as? NSData
        {
            var portrait = UIImage(data: data)
        }
        return nil
    }
    
    // MARK : - 保存/删除/获取当前用户
    class func saveLoginUser(loginUser:LoginUser)
    {
        var documentDirPath:String = DirectoryUtils.documentsDirectory.path!
        
        var callerConfigFilePath = documentDirPath.stringByAppendingPathComponent("LoginUser.txt")
        
        var fileManage = NSFileManager.defaultManager()
        
        if (fileManage.fileExistsAtPath(callerConfigFilePath)) {
            fileManage.removeItemAtPath(callerConfigFilePath, error: nil)
        }
        
        var loginUserData:NSData = NSKeyedArchiver.archivedDataWithRootObject(loginUser)
        
        loginUserData.writeToFile(callerConfigFilePath, atomically: true)
    }
    
    class func currentLoginUser() -> LoginUser?
    {
        var documentDirPath:String = DirectoryUtils.documentsDirectory.path!
        
        var callerConfigFilePath = documentDirPath.stringByAppendingPathComponent("LoginUser.txt")
        
        if let callerData = NSData(contentsOfFile: callerConfigFilePath)
        {
            return NSKeyedUnarchiver.unarchiveObjectWithData(callerData) as? LoginUser
        }
        return nil
    }
    
    class func removeLoginUser()
    {
        var documentDirPath:String = DirectoryUtils.documentsDirectory.path!
        
        var callerConfigFilePath = documentDirPath.stringByAppendingPathComponent("LoginUser.txt")
        
        var fileManage = NSFileManager.defaultManager()
        
        if (fileManage.fileExistsAtPath(callerConfigFilePath)) {
            fileManage.removeItemAtPath(callerConfigFilePath, error: nil)
        }
    }
    
}
