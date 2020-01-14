//
//  ViewController.swift
//  UIBezierPathAndCoreGraphics
//
//  Created by xuanze on 209/5/24.
//  Copyright © 209 xuanze. All rights reserved.
//

import UIKit
import CoreGraphics
import CoreImage
class ViewController: UIViewController {

    var frameY:CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
//        let view = CustomView()
//        view.backgroundColor = UIColor.white
//        view.frame = CGRect(x: 00, y: 00, width: 00, height: 00)
//        self.view.addSubview(view)
        
            //OC
//            let view = MyView()
//            view.frame = CGRect(x: 00, y: 00, width: 00, height: 00)
//            self.view.addSubview(view)
//            view.layer.setNeedsDisplay()
        
        //MARK:第五种绘图方式
//        UIGraphicsBeginImageContextWithOptions(CGSize(width: 00, height: 00), false, 0)
//        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 00, height: 00))
//        UIColor.blue.setFill()
//        path.fill()
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        let imageview = UIImageView(image: image)
//        imageview.frame = CGRect(x: 00, y: 00, width: 00, height: 00)
//        self.view.addSubview(imageview)
//        UIGraphicsEndImageContext()
        
        //MARK:第六种绘图方式
//        UIGraphicsBeginImageContextWithOptions(CGSize(width: 00, height: 00), false, 0)
//        let ctx = UIGraphicsGetCurrentContext()
//        ctx?.addEllipse(in: CGRect(x: 0, y: 0, width: 00, height: 00))
//        ctx?.setFillColor(UIColor.blue.cgColor)
//        ctx?.fillPath()
//
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        let imageview = UIImageView(image: image)
//        imageview.frame = CGRect(x: 00, y: 00, width: 00, height: 00)
//        self.view.addSubview(imageview)
        
        
        //MARK:uiimage的一些操作
        self.methodUIImageMove()
        self.methodUIImageScale()
        self.methodUIImageCut()
        
        //CGImage操作
        self.CGImageMethod1()
        self.CGImageMethod2()
        self.CGImageMethod3()
        
        self.CIImageMethod1()
        self.CIImageMethod2()
        self.CIImageMethod3()
        
        self.SaveGStateMethod()
        
        //PUSHto UIBezierPath
        let btnPush = UIButton(type: .custom)
        btnPush.setTitle("UIBezierPath", for: .normal)
        btnPush.setTitleColor(.blue, for: .normal)
        btnPush.addTarget(self, action: #selector(self.presentToUIBezierPath), for: .touchUpInside)
        btnPush.frame = CGRect(x: 200, y: 100, width: 300, height: 100)
        self.view.addSubview(btnPush)
    }
    
    @objc func presentToUIBezierPath() {
        let bezierVC = UIBezierPathVC()
        self.present(bezierVC, animated: true, completion: nil)
    }
    
    //平移
    func methodUIImageMove() {
        let image = UIImage(named: "icon_label_home_pre")
        let size = image?.size
        UIGraphicsBeginImageContextWithOptions(CGSize(width: (size?.width)! * 2, height: (size?.height)!), false, 1)
        image?.draw(at: CGPoint(x: 0, y: 0))
        image?.draw(at: CGPoint(x: (size?.width)!, y: 0))
        let newimage = UIGraphicsGetImageFromCurrentImageContext()
        
        let myImageView = UIImageView()
        myImageView.image = newimage
        myImageView.frame = CGRect(x: 100, y: frameY, width: (size?.width)! * 2, height: (size?.height)!)
        frameY += (size?.height)!
        frameY += 20
        self.view.addSubview(myImageView)
        UIGraphicsEndImageContext()
    }
    //缩放
    func methodUIImageScale() {
        let image = UIImage(named: "icon_label_home_pre")
        let size = image?.size
        UIGraphicsBeginImageContextWithOptions(CGSize(width: (size?.width)! * 2, height: (size?.height)! * 2), false, 1)
        image?.draw(in: CGRect(x: 0, y: 0, width: (size?.width)! * 2, height: (size?.height)! * 2))
        let newimage = UIGraphicsGetImageFromCurrentImageContext()
        
        let myImageView = UIImageView()
        myImageView.image = newimage
        myImageView.frame = CGRect(x: 100, y: frameY, width: (size?.width)! * 2, height: (size?.height)! * 2)
        frameY += (size?.height)! * 2
        frameY += 20
        self.view.addSubview(myImageView)
        UIGraphicsEndImageContext()
    }
    //裁剪
    func methodUIImageCut() {
        let image = UIImage(named: "icon_label_home_pre")
        let size = image?.size
        UIGraphicsBeginImageContextWithOptions(CGSize(width: (size?.width)! / 2, height: (size?.height)!), false, 1)
        image?.draw(in: CGRect(x: -(size?.width)!/2, y: 0, width: (size?.width)!, height: (size?.height)!))
        let newimage = UIGraphicsGetImageFromCurrentImageContext()
        
        let myImageView = UIImageView()
        myImageView.image = newimage
        myImageView.frame = CGRect(x: 100, y: frameY, width: (size?.width)!/2, height: (size?.height)!)
        frameY += (size?.height)!
        frameY += 20
        self.view.addSubview(myImageView)
        UIGraphicsEndImageContext()
    }
    
    //将图片分成两半 绘制在上下文的两边
    //当前坐标系坐标原点在左上角， 目标上下文坐标系在左下角
    func CGImageMethod1() {
        let image = UIImage(named: "icon_label_home_pre")
        let size = image?.size
        let left = image?.cgImage?.cropping(to: CGRect(x: 0, y: 0, width: (size?.width)! / 2, height: (size?.height)!))
        let right = image?.cgImage?.cropping(to: CGRect(x: (size?.width)! / 2, y: 0, width: (size?.width)! / 2, height: (size?.height)!))
        UIGraphicsBeginImageContextWithOptions(CGSize(width: (size?.width)! * 1.5, height: (size?.height)!), false, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.draw(left!, in: CGRect(x: 0, y: 0, width: (size?.width)! / 2, height: (size?.height)!))
        context?.draw(right!, in: CGRect(x: (size?.width)!, y: 0, width: (size?.width)! / 2, height: (size?.height)!))
        
        let newimage = UIGraphicsGetImageFromCurrentImageContext()
        
        let myImageView = UIImageView()
        myImageView.image = newimage
        myImageView.frame = CGRect(x: 100, y: frameY, width: (newimage?.size.width)!, height: (size?.height)!)
        frameY += (size?.height)!
        frameY += 20
        self.view.addSubview(myImageView)
        UIGraphicsEndImageContext()
    }

    //解决上下颠倒的问题
    
    func CGImageMethod2() {
        let image = UIImage(named: "icon_label_home_pre")
        let size = image?.size
        
        let left = image?.cgImage?.cropping(to: CGRect(x: 0, y: 0, width: (size?.width)! / 2, height: (size?.height)!))
        let right = image?.cgImage?.cropping(to: CGRect(x: (size?.width)! / 2, y: 0, width: (size?.width)! / 2, height: (size?.height)!))
        UIGraphicsBeginImageContextWithOptions(CGSize(width: (size?.width)! * 1.5, height: (size?.height)!), false, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.draw(flip(img: left!), in: CGRect(x: 0, y: 0, width: (size?.width)! / 2, height: (size?.height)!))
        context?.draw(flip(img: right!), in: CGRect(x: (size?.width)!, y: 0, width: (size?.width)! / 2, height: (size?.height)!))
        
        let newimage = UIGraphicsGetImageFromCurrentImageContext()
        
        let myImageView = UIImageView()
        myImageView.image = newimage
        myImageView.frame = CGRect(x: 100, y: frameY, width: (newimage?.size.width)!, height: (size?.height)!)
        frameY += (size?.height)!
        frameY += 20
        self.view.addSubview(myImageView)
        UIGraphicsEndImageContext()
    }
    
    //再调用drawimage方法
    func flip(img: CGImage) -> CGImage {
        let size = CGSize(width: img.width, height: img.height)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: (size.width), height: (size.height)), false, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.draw(img, in: CGRect(x: 0, y: 0, width: (size.width), height: (size.height)))
        let newimage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return (newimage?.cgImage)!
    }
    
    func CGImageMethod3() {
        let image = UIImage(named: "icon_label_home_pre")
        let size = image?.size
        let cgImag = image?.cgImage
        if cgImag != nil {
            let sizeCG = CGSize(width: CGFloat(cgImag!.width), height: CGFloat(cgImag!.height))
            
            let left = image?.cgImage?.cropping(to: CGRect(x: 0, y: 0, width: sizeCG.width / 2, height: sizeCG.height))
            let right = image?.cgImage?.cropping(to: CGRect(x: sizeCG.width / 2, y: 0, width: sizeCG.width / 2, height: sizeCG.height))
            UIGraphicsBeginImageContextWithOptions(CGSize(width: (size?.width)! * 1.5, height: (size?.height)!), false, 1)
            let context = UIGraphicsGetCurrentContext()
            context?.draw(flip(img: left!), in: CGRect(x: 0, y: 0, width: (size?.width)! / 2, height: (size?.height)!))
            context?.draw(flip(img: right!), in: CGRect(x: (size?.width)!, y: 0, width: (size?.width)! / 2, height: (size?.height)!))
            
            let newimage = UIGraphicsGetImageFromCurrentImageContext()
            
            let myImageView = UIImageView()
            myImageView.image = newimage
            myImageView.frame = CGRect(x: 100, y: frameY, width: (newimage?.size.width)!, height: (size?.height)!)
            frameY += (size?.height)!
            frameY += 20
            self.view.addSubview(myImageView)
            UIGraphicsEndImageContext()
        }
        
        
    }
    
    func CIImageMethod1() {
        let image = UIImage(named: "icon_label_home_pre")
        let imageCI = CIImage(cgImage: (image?.cgImage)!)
        let grad = CIFilter(name: "CIRadialGradient")
        let center = CIVector(x: (image?.size.width)! / 2.0, y: (image?.size.height)! / 2.0)
        // 使用setValue：forKey：方法设置滤镜属性
        grad?.setValue(center, forKey: "inputCenter")
        let c = CIContext()
        let moi = c.createCGImage((grad?.outputImage)!, from: imageCI.extent)
        let moi4 = UIImage(cgImage: moi!, scale: (image?.scale)!, orientation: (image?.imageOrientation)!)
        
        let myImageView = UIImageView()
        myImageView.image = moi4
        myImageView.frame = CGRect(x: 100, y: frameY, width: (moi4.size.width), height: (moi4.size.height))
        frameY += (moi4.size.height)
        frameY += 20
        self.view.addSubview(myImageView)
    }
    
    func CIImageMethod2() {
        let image = UIImage(named: "icon_label_home_pre")
        let imageCI = CIImage(cgImage: (image?.cgImage)!)
        let dark = CIFilter(name: "CIDarkenBlendMode",parameters: ["inputImage": imageCI])
        let c = CIContext()
        let moi = c.createCGImage((dark?.outputImage)!, from: imageCI.extent)
        let moi4 = UIImage(cgImage: moi!, scale: (image?.scale)!, orientation: (image?.imageOrientation)!)
        
        let myImageView = UIImageView()
        myImageView.image = moi4
        myImageView.frame = CGRect(x: 100, y: frameY, width: (moi4.size.width), height: (moi4.size.height))
        frameY += (moi4.size.height)
        frameY += 20
        self.view.addSubview(myImageView)
    }
    
    
    func CIImageMethod3() {
        let image = UIImage(named: "icon_label_home_pre")
        let imageCI = CIImage(cgImage: (image?.cgImage)!)
        let grad = CIFilter(name: "CIRadialGradient")
        let center = CIVector(x: (image?.size.width)! / 2.0, y: (image?.size.height)! / 2.0)
        // 使用setValue：forKey：方法设置滤镜属性
        grad?.setValue(center, forKey: "inputCenter")
        // 在指定滤镜名时提供所有滤镜键值对
        let dark = CIFilter(name: "CIDarkenBlendMode", parameters: ["inputImage": imageCI, "inputBackgroundImage": grad?.outputImage])
        let c = CIContext()
        let moi = c.createCGImage((dark?.outputImage)!, from: imageCI.extent)
        let moi4 = UIImage(cgImage: moi!, scale: (image?.scale)!, orientation: (image?.imageOrientation)!)
        
        let myImageView = UIImageView()
        myImageView.image = moi4
        myImageView.frame = CGRect(x: 100, y: frameY, width: (moi4.size.width), height: (moi4.size.height))
        frameY += (moi4.size.height)
        frameY += 20
        self.view.addSubview(myImageView)
    }
    
    func SaveGStateMethod() {
        UIGraphicsBeginImageContext(CGSize(width: 100, height: 100))
        let context = UIGraphicsGetCurrentContext()
        //第一条线
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setLineWidth(2)
        context?.move(to: CGPoint(x: 10, y: 10))
        context?.addLine(to: CGPoint(x: 10, y: 80))
        context?.strokePath()
        context?.saveGState()
        
        //第二条
        context?.setStrokeColor(UIColor.yellow.cgColor)
        context?.setLineWidth(5)
        context?.move(to: CGPoint(x: 30, y: 10))
        context?.addLine(to: CGPoint(x: 30, y: 80))
        context?.strokePath()
        context?.restoreGState()
        
        //第三条
        context?.move(to: CGPoint(x: 70, y: 10))
        context?.addLine(to: CGPoint(x: 70, y: 80))
        context?.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let myImageView = UIImageView()
        myImageView.image = image
        myImageView.frame = CGRect(x: 100, y: frameY, width: 100, height: 100)
        frameY += (100)
        frameY += 20
        self.view.addSubview(myImageView)
        
        UIGraphicsEndImageContext()
    }
}


