# ScrollViewForSwiftExample
##Using
如果你想获得图片的点击响应，那先遵循协议 `CGYScrollViewDelegate`
```swift
let scrollView: CGYScrollView = CGYScrollView(frame: self.view.frame, imageArray: imageArray, time: 3)
scrollView.delegate = self
```
协议方法
```swift
/**
     图片点击的协议方法
     
     - parameter index:     被点击的图片的下标值
     - parameter image:     被点击的图片对象
     - parameter urlString: 被点击的图片链接字符串
     */
    func imageDidSelected(index: NSInteger, image: UIImage, urlString: String) {
        
    }
```
