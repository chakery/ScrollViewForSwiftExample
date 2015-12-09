//
//  CGYScrollView.swift
//  Example
//
//  Created by Chakery on 15/12/2.
//  Copyright © 2015年 Chakery. All rights reserved.
//

import UIKit

protocol CGYScrollViewDelegate {
    /**
     图片点击的协议方法
     
     - parameter index:     被点击的图片的下标值
     - parameter image:     被点击的图片对象
     - parameter urlString: 被点击的图片链接字符串
     */
    func imageDidSelected (index: NSInteger, image: UIImage, urlString: String)
}

class CGYScrollView: UIView, UIScrollViewDelegate {
    private let scrollView: UIScrollView
    private let pageControl: UIPageControl
    private var currentPage: Int // 当前页
    private var timer: NSTimer?
    var delegate: CGYScrollViewDelegate? // 代理
    var imageArray: [String] // 图片StringURL的数组
    var time: Double // 时间，－1表示不执行定时滚动
    
    /**
    初始化
    
    - parameter frame:      frame值
    - parameter imageArray: 图片数组, 字符串数组
    - parameter time:       定时滚动, －1表示关闭定时器
    
    - returns: 
    */
    init(frame: CGRect, imageArray: [String], time: Double) {
        self.scrollView = UIScrollView(frame: frame)
        self.pageControl = UIPageControl()
        self.imageArray = [String]()
        self.imageArray.append(imageArray.last!)
        self.imageArray += imageArray
        self.imageArray.append(imageArray.first!)
        self.time = time
        self.currentPage = 0
        super.init(frame: frame)
        setScrollView()
        setPageControl()
        setTimer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     设置ScrollView
     */
    func setScrollView () {
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true
        self.scrollView.bounces = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        // 设置scrollView大小
        if self.imageArray.count > 0 {
            self.scrollView.contentSize = CGSizeMake(self.frame.size.width * CGFloat(self.imageArray.count), self.frame.size.height)
        }
        
        // 设置开始的第一个界面
        self.scrollView.setContentOffset(CGPointMake(self.frame.size.width, 0), animated: false)
        
        // 添加图片
        for i in 0..<imageArray.count {
            let imageView: UIImageView = UIImageView(frame: CGRectMake(CGFloat(i) * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height))
            imageView.tag = 100 + i
            imageView.userInteractionEnabled = true
            imageView.kf_setImageWithURL(NSURL(string: imageArray[i])!)
            //单点手势
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "imageDidselected:")
            imageView.addGestureRecognizer(tap)
            scrollView.addSubview(imageView)
        }
        self.addSubview(scrollView)
    }
    
    /**
     图片单点手势
     */
    func imageDidselected (tap: UITapGestureRecognizer) {
        let tempView = tap.view
        let image: UIImage = ((tempView as? UIImageView)?.image)!
        delegate?.imageDidSelected(tempView!.tag%100, image: image, urlString: imageArray[tempView!.tag%100])
    }
    
    /**
     设置页面控制器
     */
    func setPageControl () {
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.userInteractionEnabled = false
        self.pageControl.numberOfPages = self.imageArray.count - 2
        self.pageControl.currentPage = 0
        self.addSubview(pageControl)
        //约束
        let layout1 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[pageControl]-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["pageControl":pageControl])
        let layout2 = NSLayoutConstraint.constraintsWithVisualFormat("V:[pageControl(10)]-20-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["pageControl":pageControl])
        self.addConstraints(layout1)
        self.addConstraints(layout2)
    }

    /**
     定时器
     */
    func setTimer () {
        if self.time <= 0 {
            return
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(self.time, target: self, selector: "timerChangeImagePosition", userInfo: nil, repeats: true)
    }
    
    /**
     定时滚动
     */
    func timerChangeImagePosition () {
        self.scrollView.scrollRectToVisible(CGRectMake(self.scrollView.contentOffset.x + self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height), animated: true)
    }
    
    /**
     改变滚动图片的位置
     */
    func changeImagePosition () {
        if self.currentPage == 0 {
            self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * CGFloat(self.imageArray.count - 2), 0)
            changeCurrentAndPageControl()
        } else if self.currentPage == self.imageArray.count - 1 {
            self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0)
            changeCurrentAndPageControl()
        }
    }
    
    /**
     修改当前页的、页面控制器
    */
    func changeCurrentAndPageControl () {
        self.currentPage = Int(self.scrollView.contentOffset.x / self.scrollView.frame.size.width)
        self.pageControl.currentPage = self.currentPage - 1
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        print("----1")
        changeCurrentAndPageControl()
        changeImagePosition()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("-----2")
        changeCurrentAndPageControl()
        changeImagePosition()
        setTimer()
    }
}
    

