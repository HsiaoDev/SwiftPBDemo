//
//  EDSocketViewController2.swift
//  SwiftPBDemo
//
//  Created by XW on 2020/4/16.
//  Copyright © 2020 XW. All rights reserved.
//

import UIKit

class EDSocketViewController2: UIViewController, EDSocketProtocol {

    let urlString = "ws://123.207.136.134:9010/ajaxchattest"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.green
        
        testEDSocket()
    }
    

    func testEDSocket()-> (){
        EDSocket.sharedSocket().connect(to: urlString, by: .tradeSocket, delegate: self)
    }
    
    func EDSocketdidReceive() {
        print("\(self) EDSocketDelegate")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("控制器消失")
        EDSocket.sharedSocket().disConnect()
        print(EDSocket.sharedSocket().tradeSocket ?? "tradeSocket=nil")
        print(EDSocket.sharedSocket().marketSocket ?? "marketSocket = nil")
    }
    
}
