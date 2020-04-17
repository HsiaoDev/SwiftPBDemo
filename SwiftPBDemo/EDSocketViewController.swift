//
//  EDSocketViewController.swift
//  SwiftPBDemo
//
//  Created by XW on 2020/4/14.
//  Copyright © 2020 XW. All rights reserved.
//

import UIKit


class EDSocketViewController: UIViewController, EDSocketProtocol {
    
    let urlString = "ws://121.40.165.18:8800"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //"http://www.websocket-test.com/"
        
        view.backgroundColor = UIColor.yellow
        
        testMarketSocket()
        
    }
    

    func testMarketSocket() -> () {
        
//        EDSocket.sharedEDSocket().connect(to: "ws://123.207.136.134:9010/ajaxchattest", by: .marketSocket, d: self)
        
//        EDSocket.sharedSocket().connect(to: "ws://123.207.136.134:9010/ajaxchattest", by: .marketSocket, delegate: self)
        
        EDSocket.sharedSocket().connect(to: urlString, by: .marketSocket, delegate: self)
        
    }
    
    
    

    ///MARK: - EDSocket代理方法
    func EDSocketdidReceive() {
        print("\(self) EDSocketDelegate")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("控制器消失")
        EDSocket.sharedSocket().disConnect()
        print(EDSocket.sharedSocket().tradeSocket as Any)
        print(EDSocket.sharedSocket().marketSocket as Any)
    }
}
