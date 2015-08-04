//
//  UserDao.swift
//  Exercise
//
//  Created by 楼顶 on 15/7/29.
//  Copyright (c) 2015年 楼顶. All rights reserved.
//

import UIKit

class UserDao: BaseDao {
   
    /**
    创建用户表
    
    :param: db 数据库
    
    :returns: 是否创建成功
    */
    override class func createTable(db: FMDatabase) -> Bool {
        var createTableSql = "CREATE TABLE TB_User ( " +
            " accountId INTEGER PRIMARY KEY ," +       //帐号id
            " accountheadpic VARCHAR(200) ," +         //头像地址
            " location VARCHAR(200) ," +               //用户所在地区
            " gender INTEGER DEFAULT 0 ," +            //用户性别，默认为0
            " job VARCHAR(200) ," +                    //用户从事工作
            " nickname VARCHAR(200)  ," +              //用户昵称
            " signature VARCHAR(200) , " +             //用户签名
            " telephone VARCHAR(200) ," +              //用户电话
            " username VARCHAR(200) ," +               //用户名
            " token VARCHAR(200)  " +                  //用户token
        " ) "
        
        if !db.executeUpdate(createTableSql, withArgumentsInArray: []) {
            println("创建用户表失败 failure: \(db.lastError())")
            return false
        }else{
            println("创建用户表成功")
            return true
        }
    }
    
    
    class func save(userInfo:User,db: FMDatabase) -> Bool {
        
        var sql = "replace INTO TB_User (accountId, accountheadpic, location ,gender,job,nickname,signature,telephone,username,token) VALUES ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ) "
        
        var args : [AnyObject] = [userInfo.accountheadpic ?? NSNull() ]
        
        if !db.executeUpdate(sql, withArgumentsInArray: args)
        {
            println("执行SQL:\(sql) 参数:\(args) 报错信息:\(db.lastErrorMessage()) \(db.lastError().description)")
            return false
        }
        return true
    }
    
    
}
