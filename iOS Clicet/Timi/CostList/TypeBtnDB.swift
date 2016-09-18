//
//  TypeBtnDB.swift
//  Timi
//
//  Created by 田子瑶 on 16/8/30.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit
import FMDB

class btnModel: NSObject {
    var ID : Int
    var imageName : NSString
    var iconTitle : NSString
    
    init(ID:Int, imageName:NSString, iconTitle: NSString){
        self.ID = ID
        self.imageName = imageName
        self.iconTitle = iconTitle
    }
}

class TypeBtnDB: NSObject {
    
    
    //取得数据库文件
    class func getDB()->FMDatabase{
        
        //创建文件路径“TypeBtn.db”
        let btnPath = String.createFilePathInDocumentWith("DatabaseDoc/TypeBtn.db") ?? ""
        
        //创建filemanager
        let fileManager = NSFileManager.defaultManager()
        //不存在要创建的文件则进入创建操作
        if fileManager.fileExistsAtPath(btnPath) == false {
            //创建.db文件
            let db = FMDatabase(path: btnPath)
            //判断是否创建成功
            if (db != nil){
                if db.open() == true{
                    let sql_stmt = "CREATE TABLE IF NOT EXISTS btnDB(ID INTEGER PRIMARY KEY , IMAGENAME TEXT, ICONTITLE TEXT)"
                    if db.executeStatements(sql_stmt) == false  {
                        //执行语句错误
                        print("Error: \(db.lastErrorMessage())")
                    }
                    db.close()
                }
                else{
                    //打不开文件
                    print("Error: \(db.lastErrorMessage())")
                }
            }
            else{
                //文件创建不成功
                print("Error: \(db.lastErrorMessage())")
            }
        }
        return FMDatabase(path: btnPath)
    }
    //插入数据
    class func insertData(item:btnModel){
        let sql_stmt = "INSERT INTO btnDB(ID, IMAGENAME, ICONTITLE) VALUES(?,?,?)"
        let db = self.getDB()
        db.open()
        db.executeUpdate(sql_stmt, withArgumentsInArray: [item.ID,item.imageName, item.iconTitle])
        db.close()
    }
    
    //更新数据
    class func updateData(item:btnModel){
        let sql_stmt = "UPDATE btnDB SET IMAGENAME=?, ICONTITLE=? WHERE ID=?"
        let db = self.getDB()
        db.open()
        db.executeUpdate(sql_stmt, withArgumentsInArray: [item.imageName, item.iconTitle, item.ID])
        db.close()
    }
    
    //删除数据
    class func deleteData(item:btnModel){
        let sql_stmt = "DELETE FROM btnDB WHERE ID=?"
        let db = self.getDB()
        db.open()
        db.executeUpdate(sql_stmt, withArgumentsInArray: [item.ID])
        db.close()
    }
    
    //查询数据
    class func selectData(id:Int)->btnModel{
        let sql_stmt = "SELECT * FROM btnDB WHERE ID=?"
        let db = self.getDB()
        db.open()
        let rs = db.executeQuery(sql_stmt, withArgumentsInArray: [id])
        let item = btnModel(ID: 1, imageName: "", iconTitle: "")
        while rs.next(){
            item.ID = Int(rs.intForColumn("ID"))
            item.imageName = rs.stringForColumn("IMAGENAME")
            item.iconTitle = rs.stringForColumn("ICONTITLE")
        }
        db.close()
        return item
    }
    
}