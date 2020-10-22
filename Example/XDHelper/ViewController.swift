//
//  ViewController.swift
//  XDHelper
//
//  Created by dte2mdj on 04/22/2020.
//  Copyright (c) 2020 dte2mdj. All rights reserved.
//

import UIKit
import XDHelper

class ViewController: UIViewController {
    
    lazy var phoneSpliter: TextInputSpliter = {
        let spliter = TextInputSpliter()
        spliter.separator = "-"
        spliter.splitPattern = [3, 4, 4]
        spliter.maxLength = 11
        spliter.testValidBlock = { $0.xwg.isMatching("\\d*") }
        return spliter
    }()
    
    lazy var bankAccountSpliter: TextInputSpliter = {
        let spliter = TextInputSpliter()
        spliter.separator = " "
        spliter.splitPattern = [4]
        spliter.maxLength = 20
        spliter.testValidBlock = { $0.xwg.isMatching("\\d*") }
        return spliter
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let emoji = """
        😀😁😂😃😄😅😆😉😊😋😎😍😘😗😙😚☺😇😐😑😶😏😣😥😮😯😪😫😴😌😛😜
        😝😒😓😔😕😲😷😖😞😟😤😢😭😦😧😨😬😰😱😳😵😡😠
        """
        for c in emoji where c != "\n" {
            print("\(c): \(c.xwg.isEmoji)")
        }
    }
    
    
}

extension ViewController {
    func testTextInputPhone() {
        
        let tf = UITextField()
        tf.placeholder = "手机号。。。"
        tf.frame = CGRect(x: 10, y: 100, width: view.frame.width - 20, height: 40)
        tf.backgroundColor = .cyan
        tf.delegate = phoneSpliter
        view.addSubview(tf)
    }
    
    func testTextInputBankAccount() {
       
        let tf = UITextView()
        tf.frame = CGRect(x: 10, y: 200, width: view.frame.width - 20, height: 140)
        tf.backgroundColor = .cyan
        tf.delegate = bankAccountSpliter
        view.addSubview(tf)
    }
}

