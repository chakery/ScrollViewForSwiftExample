//
//  ViewController.swift
//  Example
//
//  Created by Chakery on 15/12/2.
//  Copyright © 2015年 Chakery. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CGYScrollViewDelegate,UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageArray = ["http://h.hiphotos.baidu.com/image/pic/item/aa64034f78f0f73610034de60e55b319eac41353.jpg",
            "http://g.hiphotos.baidu.com/image/pic/item/4b90f603738da977c76ab6fab451f8198718e39e.jpg",
            "http://h.hiphotos.baidu.com/image/pic/item/c995d143ad4bd1130c0ee8e55eafa40f4afb0521.jpg"]
        
        
        let myView: CGYScrollView = CGYScrollView(frame: self.view.frame, imageArray: imageArray, time: 3)
        myView.delegate = self
        self.view.addSubview(myView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    /**
     图片点击的协议方法
     
     - parameter index:     被点击的图片的下标值
     - parameter image:     被点击的图片对象
     - parameter urlString: 被点击的图片链接字符串
     */
    func imageDidSelected(index: NSInteger, image: UIImage, urlString: String) {
        print("第\(index)张图片，\(image), \(urlString)")
    }
}

