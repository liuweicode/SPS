//
//  UserAPIManger.swift
//  isflyer
//
//  Created by 楼顶 on 15/6/29.
//  Copyright (c) 2015年 楼顶. All rights reserved.
//

import Foundation


class UserAPIManger : BaseAPIManager {
    
    // MARK:-  修改用户资料
    class func api_s_editaccount(#uid:Int,token:String,user : User, success:()->Void, relogin:()->Void,failed:(errorCode:Int,errorMsg:String)->Void){
        var params: [String : AnyObject] = [
            "uid" : "\(uid)",
            "token": token
        ]
        
        POST(getApiURL("/api/s/editaccount"), params: params, success: { (responseData) -> Void in
            
            success()
            
        }) { (errorCode, errorMsg) -> Void in
            
            if errorCode == CommonResponseMessage.sign_token_error.rawValue {
                relogin()
            }else{
                failed(errorCode: errorCode, errorMsg: errorMsg)
            }
        }
        
    }
    
   
}
