### Swift项目使用protobuf

> 官方文档 ： https://github.com/apple/swift-protobuf

* 新建一个文件夹
* 下载官方的`swift-protobuf` : `git clone https://github.com/apple/swift-protobuf.git`
* 进入下载后的`swift-protobuf`文件夹 :  `cd swift-protobuf`
* 查看版本：`git tag -l` **最新版1.8.0**
* 选择最新版本执行 ： `git checkout tags/1.8.0`
* 创建`protoc-gen-swift`文件 : `swift build -c release`
* 路径`/Users/imac/Desktop/ED/iOS/ProtocolBuffer/swift-protobuf/.build/x86_64-apple-macosx/release/protoc-gen-swift `
* 配置`protoc-gen-swift ` 
  * 把 protoc-gen-swift 文件直接拷贝到/usr/local/bin目录下
* 创建`Person.proto`文件
* 使用`protoc`编译的`pb.swift`文件
  * 指令：``protoc --swift_out=. Person.proto``
  * `Person.pb.swift`文件拖入项目中使用
  * `Podfile`中需要使用Apple官方库`pod 'SwiftProtobuf', '~> 1.8.0'`





#### 使用

> Person.proto

```protobuf
syntax = "proto3";

message PersonInfo {
   int64 id = 1;
   string name = 2;
   string address = 3;
}
```



```swift
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
        print("person2Data : \(person2Data)")
        /**
         person2Data : 44 bytes
         */
        
        
        //2、data回转pb
        guard let data2Person = try? PersonInfo(serializedData: person2Data) else {
             print("error")
             return
        }
        print("personFromData : \(data2Person)")
        /**
        personFromData : SwiftPBDemo.PersonInfo:
        id: 1
        name: "艾德一站通"
        address: "彩讯科创中心16层"
        */
        
        
        
        //3、jsonString初始化PB
        let jsonString = "{\"id\":888,\"name\":\"jsonString\",\"address\":\"json address\"}"
        guard let jsonString2Person = try? PersonInfo(jsonString: jsonString) else {
             print("error")
            return
        }
        print("jsonString2Person : \(jsonString2Person)")
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
        print("person2JsonString = \(person2JsonString)")
        /**
         person2JsonString = {"id":"888","name":"jsonPerson","address":"json address"}
         */
        
        
        //5、pb转jsonUTF8
        guard let person2jsonUTF8 = try? person.jsonUTF8Data() else {
            print("Error")
            return
        }
        print("person2jsonUTF8 = \(person2jsonUTF8)")
        /**
         person2jsonUTF8 = 71 bytes
         */
        
        //6、jsonUTF8Data转pb
        guard let jsonUTF8ToPerson = try? PersonInfo(jsonUTF8Data: person2jsonUTF8) else{
            print("error")
            return
        }
        print("jsonUTF8ToPerson = \(jsonUTF8ToPerson)")
        /**
         jsonUTF8ToPerson = SwiftPBDemo.PersonInfo:
         id: 1
         name: "艾德一站通"
         address: "彩讯科创中心16层"
         */
    }
```

