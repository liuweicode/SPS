//
//  BaseAPIManager.swift
//  isflyer
//
//  Created by 刘伟 on 15/6/21.
//  Copyright (c) 2015年 楼顶. All rights reserved.
//

import UIKit
import Alamofire
import JSONHelper


enum CommonResponseMessage: Int{
    
    case ok = 0                 // 操作成功
    case sign_token_error = 1   // 登陆token失效
    case network = -999         //网络错误
    
    func message() -> String
    {
        if self.rawValue == ok.rawValue
        {
            return "操作成功"
        }else if self.rawValue == sign_token_error.rawValue
        {
            return "登录失效,请重新登录。"
        }
        else if self.rawValue == network.rawValue
        {
            return "网络失败，请重试！"
        }
        return "未知错误"
    }
}


class BaseAPIManager: NSObject {
   
    //是否能够连接服务器
    private class func isHostReachabled() -> Bool
    {
        return Reachability(hostName: HOST).isReachable()
    }
    
    
    // MARK: - 请求接口的方法
    
    /**
        POST接口
    
        :param: url    接口地址
        :param: params 接口参数
    */
    class func POST(url:String,params:[String : AnyObject]?,success:(responseData:[String : AnyObject])->Void, failed:(errorCode:Int,errorMsg:String)->Void)
    {
        println("请求:\(url) 参数: \(params!)")
        
        if isHostReachabled()
        {
            Alamofire.request(.POST, url, parameters: params!, encoding: .JSON).responseJSON {
                (req, res, json, error) -> Void in
                
                if let e = error
                {
                    println("接口请求失败: \(e)")
                    
                    failed(errorCode: CommonResponseMessage.network.rawValue, errorMsg: CommonResponseMessage.network.message())
                    
                }else{
                    
                    var responseData: [String : AnyObject] = json as! [String:AnyObject]
                    println("获取到数据:\(responseData)")
                    var ret:Int?
                    
                    ret <-- responseData["ret"]
                    
                    if ret == CommonResponseMessage.ok.rawValue
                    {
                        success(responseData:responseData)
                        
                    }else{
                        var msg: String?
                        msg <-- responseData["msg"]
                        failed(errorCode: ret!, errorMsg: msg!)
                    }
                }
            }
        }else{
            println("无网络连接")
            failed(errorCode: CommonResponseMessage.network.rawValue, errorMsg: CommonResponseMessage.network.message())
        }
    }
    
    
    class func POST(url:String,params:[String : AnyObject]?,success:(responseData:[String : AnyObject])->Void, relogin:()->Void, failed:(errorCode:Int,errorMsg:String)->Void)
    {
        POST(url, params: params, success: { (responseData) -> Void in
            success(responseData: responseData)
        }) { (errorCode, errorMsg) -> Void in
            if errorCode == CommonResponseMessage.sign_token_error.rawValue {
                relogin()
            }else{
                failed(errorCode: errorCode, errorMsg: errorMsg)
            }
        }
    }
    
    /**
        GET接口
    
        :param: url    接口地址
        :param: params 接口参数
    */
    class func GET(url:String,params:[String : AnyObject],success:(responseData:[String : AnyObject])->Void, failed:(errorCode:Int,errorMsg:String)->Void)
    {
        println("请求:\(url) 参数: \(params)")
        
        if isHostReachabled()
        {
            Alamofire.request(.GET, url, parameters: params, encoding: .JSON).responseJSON {
                (req, res, json, error) -> Void in
                
                if let e = error
                {
                    println("接口请求失败: \(e)")
                    
                    failed(errorCode: CommonResponseMessage.network.rawValue, errorMsg: CommonResponseMessage.network.message())
                    
                }else{
                    
                    var responseData: [String : AnyObject] = json as! [String:AnyObject]
                    println("获取到数据:\(responseData)")
                    var ret:Int?
                    
                    ret <-- responseData["ret"]
                    
                    if ret == CommonResponseMessage.ok.rawValue
                    {
                        success(responseData:responseData)
                        
                    }else{
                        var msg: String?
                        msg <-- responseData["msg"]
                        failed(errorCode: ret!, errorMsg: msg!)
                    }
                }
            }
        }else{
            println("无网络连接")
            failed(errorCode: CommonResponseMessage.network.rawValue, errorMsg: CommonResponseMessage.network.message())
        }
    }
    
    /**
        上传文件
    
        :param: fileURL 文件URL
    */
    class func upload(url:String,fileURL:NSURL,progress:(bytesWritten:Int64, totalBytesWritten:Int64, totalBytesExpectedToWrite:Int64)->Void,success:(responseData:[String : AnyObject])->Void, failed:(errorCode:Int,errorMsg:String)->Void)
    {
        println("上传文件:\(url) 本地文件: \(fileURL)")
        if isHostReachabled()
        {
            Alamofire.upload(.POST, url, file:fileURL).progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                
                //println("bytesWritten:\(bytesWritten)   totalBytesWritten:\(totalBytesWritten)   totalBytesExpectedToWrite:\(totalBytesExpectedToWrite)")
                
                progress(bytesWritten: bytesWritten, totalBytesWritten: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite)
                
                }.responseJSON {
                    (request, response, json, error) in
                    
                    if let e = error
                    {
                        println("接口请求失败: \(e)")
                        
                        failed(errorCode: CommonResponseMessage.network.rawValue, errorMsg: CommonResponseMessage.network.message())
                        
                    }else{
                        
                        var responseData: [String : AnyObject] = json as! [String:AnyObject]
                        println("获取到数据:\(responseData)")
                        var ret:Int?
                        
                        ret <-- responseData["ret"]
                        
                        if ret == CommonResponseMessage.ok.rawValue
                        {
                            success(responseData:responseData)
                            
                        }else{
                            var msg: String?
                            msg <-- responseData["msg"]
                            failed(errorCode: ret!, errorMsg: msg!)
                        }
                    }
            }
        }else{
            println("无网络连接")
            failed(errorCode: CommonResponseMessage.network.rawValue, errorMsg: CommonResponseMessage.network.message())
        }

    }
    
    /**
    文件下载
    :param: url      下载地址
    :param: progress 进度
    :param: success  成功返回下载文件的临时地址
    */
    class func download(url:String,progress:(bytesRead:Int64, totalBytesRead:Int64, totalBytesExpectedToRead:Int64)->Void,success:(savedPath:NSURL)->Void, failed:(errorCode:Int,errorMsg:String)->Void)
    {
        println("下载url:\(url)")
        
        if isHostReachabled()
        {
            var savedPath : NSURL!
            
            let destination : (NSURL, NSHTTPURLResponse) -> NSURL = { (temporaryURL, response) in
                var dateformat = NSDateFormatter()
                dateformat.dateFormat = "yyyyMMddHHmmssSSS"
                let pathComponent = dateformat.stringFromDate(NSDate())
                savedPath = NSURL(fileURLWithPath: NSTemporaryDirectory().stringByAppendingPathComponent(pathComponent))!
                return savedPath
            }
            
            Alamofire.download(.GET, url, destination:destination).progress(closure: { (bytesRead, totalBytesRead, totalBytesExpectedToRead) -> Void in
                
                progress(bytesRead: bytesRead, totalBytesRead: totalBytesRead, totalBytesExpectedToRead: totalBytesExpectedToRead)
                
            }).response({ (request, response, _, error) -> Void in
                
                if error != nil {
                    println("下载文件失败: \(error)")
                    failed(errorCode: CommonResponseMessage.network.rawValue, errorMsg: CommonResponseMessage.network.message())
                }else{
                    println("下载文件成功: \(savedPath)")
                    success(savedPath: savedPath)
                }
            })
        }else{
            println("无网络连接")
            failed(errorCode: CommonResponseMessage.network.rawValue, errorMsg: CommonResponseMessage.network.message())
        }
    }
    
    
    /**
    模拟表单提交，目前仅支持一个文件
    :param: urlString      提交地址
    :param: parameters     参数
    :param: fileParamName  通常为固定字符串"file"，这个类似HTML里面的<input type="file" name="file"/>标签
    :param: filename       文件本身的名称，上传成功后，服务端可能会重命名，因此如果没有特殊要求，改参数的值可随意设置 如0000.png
    :param: imageData      图片数据
    :param: progress       上传文件过程中更新进度条
    :param: success        提交表单成功后的回调
    :param: failed         提交表单失败后的回调
    */
    class func formSubmit(url:String, params:[String : AnyObject],fileParamName:String,filename:String, fileData:NSData, progress:(bytesWritten:Int64, totalBytesWritten:Int64, totalBytesExpectedToWrite:Int64)->Void,success:(responseData:[String : AnyObject]) -> Void, failed:(errorCode:Int,errorMsg:String)->Void)
    {
        
        println("表单提交 : \(url) \n 参数:\(params)")
        
        if isHostReachabled()
        {
            var urlRequest = urlRequestWithComponents(url, parameters: params, fileParamName: fileParamName, filename: filename, fileData: fileData)
            
            Alamofire.upload(urlRequest.0, data: urlRequest.1).progress{(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                
                println("bytesWritten:\(bytesWritten)   totalBytesWritten:\(totalBytesWritten)   totalBytesExpectedToWrite:\(totalBytesExpectedToWrite)")
                
                progress(bytesWritten: bytesWritten, totalBytesWritten: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite)
                
                }.responseJSON { (request, response, json, error) in
                    if let e = error
                    {
                        println("接口请求失败: \(e)")
                        
                        failed(errorCode: CommonResponseMessage.network.rawValue, errorMsg: CommonResponseMessage.network.message())
                        
                    }else{
                        
                        var responseData: [String : AnyObject] = json as! [String:AnyObject]
                        println("获取到数据:\(responseData)")
                        var ret:Int?
                        
                        ret <-- responseData["ret"]
                        
                        if ret == CommonResponseMessage.ok.rawValue
                        {
                            success(responseData:responseData)
                            
                        }else{
                            var msg: String?
                            msg <-- responseData["msg"]
                            failed(errorCode: ret!, errorMsg: msg!)
                        }
                    }
            }
        }else{
            println("无网络连接")
            failed(errorCode: CommonResponseMessage.network.rawValue, errorMsg: CommonResponseMessage.network.message())
        }
    }
    
    // MARK: - Private Method
    
    /**
    模拟表单提交的请求组件
    :param: urlString      提交地址
    :param: parameters     参数
    :param: fileParamName  通常为固定字符串"file"，这个类似HTML里面的<input type="file" name="file"/>标签
    :param: filename       文件本身的名称，上传成功后，服务端可能会重命名，因此如果没有特殊要求，改参数的值可随意设置 如0000.png
    :param: imageData      图片数据
    */
    internal class func urlRequestWithComponents(urlString:String, parameters:Dictionary<String, AnyObject>, fileParamName:String, filename:String, fileData:NSData) -> (URLRequestConvertible, NSData) {
        
        // create url request to send
        var mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        mutableURLRequest.HTTPMethod = Method.POST.rawValue
        let boundaryConstant = "Louding";
        let contentType = "multipart/form-data;boundary="+boundaryConstant
        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        
        
        // create upload data to send
        let uploadData = NSMutableData()
        
        // add image
        uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData("Content-Disposition: form-data; name=\"\(fileParamName)\"; filename=\"\(filename)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData("Content-Type: \(contentType)\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        uploadData.appendData(fileData)
        
        // add parameters
        for (key, value) in parameters {
            uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
            uploadData.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        uploadData.appendData("\r\n--\(boundaryConstant)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        // return URLRequestConvertible and NSData
        return (ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0, uploadData)
    }
}
