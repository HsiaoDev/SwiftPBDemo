//
//  ViewController.swift
//  SwiftPBDemo
//
//  Created by XW on 2020/4/8.
//  Copyright © 2020 XW. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        testPB()
    }

    
    func testPB()  {
        var person = PersonInfo()
        person.id = 001
        person.name = "艾德一站通"
        person.address = "彩讯科创中心16层"
        print("person = \(person)")
        /**
         person = SwiftPBDemo.PersonInfo:
         id: 1
         name: "艾德一站通"
         address: "彩讯科创中心16层"
         */
        
        //1、转data
        guard let person2Data :Data = try? person.serializedData() else {
            print("error");
            return
        }
        print("1、转data \n person2Data : \(person2Data)")
        /**
         person2Data : 44 bytes
         */
        
        
        //2、data回转pb
        guard let data2Person = try? PersonInfo(serializedData: person2Data) else {
             print("error")
             return
        }
        print("2、data回转pb\n personFromData : \(data2Person)")
        /**
        personFromData : SwiftPBDemo.PersonInfo:
        id: 1
        name: "艾德一站通"
        address: "彩讯科创中心16层"
        */
        
        
        
        //3、jsonString转PB
        let jsonString = "{\"id\":888,\"name\":\"jsonString\",\"address\":\"json address\"}"
        guard let jsonString2Person = try? PersonInfo(jsonString: jsonString) else {
             print("error")
            return
        }
        print("3、jsonString转PB\n jsonString2Person : \(jsonString2Person)")
        /**
         jsonString2Person : SwiftPBDemo.PersonInfo:
         id: 888
         name: "jsonString"
         address: "json address"
         */
        
        //4、pb转jsonString
        guard let person2JsonString = try? jsonString2Person.jsonString() else{
            print("error")
            return
        }
        print("4、pb转jsonString\n person2JsonString = \(person2JsonString)")
        /**
         person2JsonString = {"id":"888","name":"jsonPerson","address":"json address"}
         */
        
        
        //5、pb转jsonUTF8
        guard let person2jsonUTF8 = try? person.jsonUTF8Data() else {
            print("Error")
            return
        }
        print("5、pb转jsonUTF8\n person2jsonUTF8 = \(person2jsonUTF8)")
        /**
         person2jsonUTF8 = 71 bytes
         */
        
        //6、jsonUTF8Data转pb
        guard let jsonUTF8ToPerson = try? PersonInfo(jsonUTF8Data: person2jsonUTF8) else{
            print("error")
            return
        }
        print("6、jsonUTF8Data转pb\n jsonUTF8ToPerson = \(jsonUTF8ToPerson)")
        /**
         jsonUTF8ToPerson = SwiftPBDemo.PersonInfo:
         id: 1
         name: "艾德一站通"
         address: "彩讯科创中心16层"
         */
    }

}

