//
//  ViewController.swift
//  TextKitDemo
//
//  Created by 张亚峰 on 2018/8/31.
//  Copyright © 2018年 zhangyafeng. All rights reserved.
//

import UIKit

/// TextKit 是在7.0之后才有的
class ViewController: UIViewController {
    @IBOutlet weak var label: ZYFLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "张亚峰 http://www.baidu.com"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

