[toc]

### 目录



#### Apple官方`swift-protobuf`

>  首先要配置github的SHH key

* 首先cd到某个文件夹 如：`/Users/imac/Desktop/ED/iOS/ProtocolBuffer`
* 下载官方的`swift-protobuf` : `git clone https://github.com/apple/swift-protobuf.git`
* 进入下载后的`swift-protobuf`文件夹 :  `cd swift-protobuf`
* 查看版本：`git tag -l` 👇
* 选择最新版本执行 ： `git checkout tags/1.8.0`
* 创建`protoc-gen-swift`文件 : `swift build -c release`
* 路径`/Users/imac/Desktop/ED/iOS/ProtocolBuffer/swift-protobuf/.build/x86_64-apple-macosx/release/protoc-gen-swift `

#### 生成`.pb.swift`文件

* cd到某个文件夹创建`.proto`文件 : `touch test.proto`

* 编辑文件👇

  ```
  syntax = "proto3";
  
  message EDUserInfo {
     int64 id = 1;
     string name = 2;
     string address = 3;
  }
  ```

* 使用指令生成`.proto.swift`文件 ： `protoc --swift_out=. Test.proto`

  > 生成的文件名为`Test.proto.swift`，将该文件拖到项目中即可使用

  