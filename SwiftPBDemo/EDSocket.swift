//
//  EDSocket.swift
//  SwiftPBDemo
//
//  Created by XW on 2020/4/14.
//  Copyright © 2020 XW. All rights reserved.
//

import UIKit
import Starscream


/**
 1、行情socket
 2、交易socket
 */

enum SocketType{
    case tradeSocket //交易
    case marketSocket //行情
}

typealias callback = (() -> ())

///MARK: - 声明协议
protocol EDSocketProtocol : NSObjectProtocol{
    func EDSocketdidReceive()
}

class EDSocket: NSObject, WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
    


    ///
    var marketSocket : WebSocket! //行情socket
    var tradeSocket : WebSocket!  //交易socket
    public weak var delegate: EDSocketProtocol?
    var socketType:SocketType?
    var isConnected = false
    
    //MARK: - 单例
    private static let instance : EDSocket = EDSocket()
    static func sharedSocket()->EDSocket{
        return instance
    }
    
    //MARK: - 初始化
    private override init() {
        self.socketType = nil
    }
    
    //MARK: - 建立连接
    func connect(to urlString: String, by type: SocketType, delegate d : AnyObject, timeoutInterval t: TimeInterval = 5.0) -> () {
        
        /**
         调用connect的controller作为socket的代理
         控制器需实现EDSocketProtocol中的方法
        */
        delegate = d as? EDSocketProtocol
        
        guard !urlString.isEmpty else{
            //urlString is empty
            print("urlString is empty")
            return
        }
        var request = URLRequest(url:URL(string:urlString)!)
        request.timeoutInterval = t



        if type == .marketSocket {
            marketSocket = WebSocket.init(request: request)
            print(Mems.ptr(ofVal: &marketSocket))
            marketSocket.delegate = self
            marketSocket.connect()
        }else if type == .tradeSocket{
            tradeSocket = WebSocket.init(request: request)
            tradeSocket.delegate = self
            tradeSocket.connect()
        }
    
        
        
    }
    
    
    //MARK: - 重新连接
    func reConnect() -> () {
        
    }
    
    
    //MARK: - 发送数据
    func sendMessage() -> () {

    }
    
    //MARK: - 发送数据2
    func send(data d:Data, response:callback?){
        
        marketSocket.write(data: d, completion: response)
    }
    
    //MARK: - 断开连接
    func disConnect() -> () {
       
        if marketSocket != nil {
            marketSocket.disconnect()
            marketSocket = nil
        }
        
        if tradeSocket != nil {
            tradeSocket.disconnect()
            tradeSocket = nil
        }
        
        //销毁心跳
        destoryHeartBeat()
        
    }
    
    
    
    //-----------------内部方法-----------------
    
    //MARK: - 建立心跳
    func initHeartBeat() {
        
        print("发送心跳。。。")
        /**
         dispatch_main_async_safe(^{
             [self destoryHeartBeat];
             //心跳设置为3分钟，NAT超时一般为5分钟
             self.heartBeat = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(sentheart) userInfo:nil repeats:YES];
             //和服务端约定好发送什么作为心跳标识，尽可能的减小心跳包大小
             [[NSRunLoop currentRunLoop] addTimer:self.heartBeat forMode:NSRunLoopCommonModes];
         })
         */
    }
    
    //MARK: - 销毁心跳
    func destoryHeartBeat() {
        
        print("销毁心跳！！！")
        /**
        dispatch_main_async_safe(^{
            if (self.heartBeat) {
                if ([self.heartBeat respondsToSelector:@selector(isValid)]){
                    if ([self.heartBeat isValid]){
                        [self.heartBeat invalidate];
                        self.heartBeat = nil;
                    }
                }
            }
        })
        */
    }
    
    
    
//    //MARK: 收到socket数据 - 分发给代理对象处理
//    func didReceive(event: WebSocketEvent, client: WebSocket) {
//
//        /**
//
//         */
////        print("event = \(event)")
////        print("client = \(client)")
////        print("EDSocket.delegate = \(String(describing: delegate))")
//
//        print("event = \(event)")
//
//        switch event {
//        case .connected(let headers):
//            /**
//             连接成功
//             - 发送心跳
//             */
////            isConnected = true
//            print("websocket is connected: \(headers)")
//
//            initHeartBeat()
//
//            if delegate != nil {
//
//                //调用代理方法
//                delegate?.EDSocketdidReceive()
//
//            }
//        case .disconnected(let reason, let code):
//            /**
//             连接断开
//             - 销毁心跳
//             */
//            isConnected = false
//            print("websocket is disconnected: \(reason) with code: \(code)")
//        case .text(let string):
//            /**
//             收到 text
//             -
//             */
//            print("Received text: \(string)")
//        case .binary(let data):
//            /**
//            收到 binary
//            -
//            */
//            print("Received data: \(data.count)")
//        case .ping(_):
//            /**
//            收到 pong 心跳
//            -
//            */
//            break
//        case .pong(_):
//            /**
//            收到 pong 心跳
//            -
//            */
//            break
//        case .viabilityChanged(_):
//            break
//        case .reconnectSuggested(_):
//            /**
//            收到 重连建议
//            -重连
//            */
//            break
//        case .cancelled:
//            /**
//            收到 连接取消
//            -
//            */
//            isConnected = false
//        case .error(let error):
//            isConnected = false
//            handleError(error)
//        }
//
////        delegate?.EDSocketdidReceive()
//    }
    
    
    
    //MARK: 错误处理 - 可能需要重新连接
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        }else if let e = error{
            print("websocket encountered an error: \(e.localizedDescription)")
        }else {
            print("websocket encountered an error")
        }
    }
    
    
}
