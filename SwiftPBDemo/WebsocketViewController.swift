//
//  WebsocketViewController.swift
//  SwiftPBDemo
//
//  Created by XW on 2020/4/9.
//  Copyright © 2020 XW. All rights reserved.
//
// websocket测试地址 ws://123.207.136.134:9010/ajaxchattest
// http://www.websocket-test.com/

import UIKit
import Starscream

class WebsocketViewController: UIViewController, EDSocketProtocol {
    
    var socket : WebSocket!
    var isConnected = false
//    let server = WebSocketServer()
    var textView :UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var request = URLRequest(url:URL(string:"ws://123.207.136.134:9010/ajaxchattest")!)
//        request.timeoutInterval = 5
//
//        socket = WebSocket(request: request)
//        socket.delegate = self
//        socket.connect()
        
        
        prepareUI()
        
        
    }
    
    func testEDSocket() {
        EDSocket.sharedSocket().connect(to: "ws://123.207.136.134:9010/ajaxchattest", by: .marketSocket, delegate: self)
    }
    
    func prepareUI()  {
        
        
        let bbi = UIBarButtonItem.init(title: "连接", style: .plain, target: self, action: #selector(bbiClick))
        navigationItem.rightBarButtonItem = bbi
        
        view.backgroundColor = UIColor.yellow
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = UIColor.blue
        btn.setTitle("发送", for: .normal)
        btn.frame = CGRect.init(x: 20, y: 100, width: 200, height: 33)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(btnDidClick(_:)), for: .touchUpInside)
        
        textView = UITextView.init(frame: CGRect.init(x: 10, y: 200, width: 300, height: 300))
        textView.backgroundColor = UIColor.orange
        view.addSubview(textView)
        
        
    }
    
    @objc func bbiClick(){
        print("点击了BBI")
        
        testEDSocket()
        
    }
    
    @objc func btnDidClick(_ sender: UIButton)  {
        
//        writeText(sender)
        writeData()
        
    }
    
//    //MARK: 收到socket数据
//    func didReceive(event: WebSocketEvent, client: WebSocket) {
//        switch event {
//        case .connected(let headers):
//            isConnected = true
//            print("websocket is connected: \(headers)")
//        case .disconnected(let reason, let code):
//            isConnected = false
//            print("websocket is disconnected: \(reason) with code: \(code)")
//        case .text(let string):
//            print("Received text: \(string)")
//        case .binary(let data):
//            print("Received data: \(data.count)")
//        case .ping(_):
//            break
//        case .pong(_):
//            break
//        case .viabilityChanged(_):
//            break
//        case .reconnectSuggested(_):
//            break
//        case .cancelled:
//            isConnected = false
//        case .error(let error):
//            isConnected = false
//            handleError(error)
//        }
//    }
//    
//    //MARK: 错误处理
//    func handleError(_ error: Error?) {
//        if let e = error as? WSError {
//            print("websocket encountered an error: \(e.message)")
//        }else if let e = error{
//            print("websocket encountered an error: \(e.localizedDescription)")
//        }else {
//            print("websocket encountered an error")
//        }
//    }
//    
//    //MARK: 写数据
//    func writeText(_ sender: UIButton)   {
//        socket.write(string: textView.text) {
//            print("socket send done!")
//        }
//    }
//    
    func writeData()  {
        var p = PersonInfo.init()
        p.name = "艾德"
        p.id = 1
        p.address = "彩讯科创中心16层"
        
        
        //1、转data
        guard let personData :Data = try? p.serializedData() else {
            print("error");
            return
        }
        print(personData.description)
//        print(Mems.ptr(ofRef: personData))
//        print((Mems.memBytes(ofRef: personData)))
        print(Mems.memStr(ofRef: personData))
        
//        socket.write(data: personData) {
//            print("socket.write done!")
//        }
        
        
        EDSocket.sharedSocket().send(data: personData) {
            print("发送数据之后在这处理")
        }
        
        
    }
    
    //MARK: 断开连接
    func disconnect(_ sender: UIButton)  {
        if isConnected {
            sender.setTitle("Connect", for: .normal)
            socket.disconnect()
        } else {
            sender.setTitle("Disconnect", for: .normal)
            socket.connect()
        }
    }
    
    func EDSocketdidReceive() {
        print("代理方法")
    }
    
}
