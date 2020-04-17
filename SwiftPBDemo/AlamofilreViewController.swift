//
//  AlamofilreViewController.swift
//  SwiftPBDemo
//
//  Created by XW on 2020/4/9.
//  Copyright © 2020 XW. All rights reserved.
//

import UIKit
import Alamofire

class AlamofilreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        prepareUI()
        
        testAF()
    }
    
    //MARK: - 初始化UI
    func prepareUI() -> Void {
        view.backgroundColor = UIColor.magenta
        navigationItem.title = "AlamoFire"
    }
    
    //MARK:测试Alamofire
    func testAF() {
        Alamofire.request("http://httpbin.org/get").responseJSON { (response) in
            guard let result =  response.result.value else {
                print(response.result.error!)
                return
            }
            
            print(result)
        }
        
    }
    
    //TODO的使用
    //TODO: 详细使用AF
    
    //FIXME的使用
    //FIXME: 返回值的处理有误

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
