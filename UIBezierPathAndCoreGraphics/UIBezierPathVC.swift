//
//  UIBezierPathVC.swift
//  UIBezierPathAndCoreGraphics
//
//  Created by xuanze on 2019/6/11.
//  Copyright © 2019 xuanze. All rights reserved.
//

import UIKit
class UIBezierPathVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
//        self.drawImage()
//        self.coreGraphicMethod()
//        self.drawCornerBox()
//        self.draw1()
//        self.CAShaperLayerMethod()
        self.draw1Animation()
    }
    
    //MARK:UIBezierPath画箭头
    func drawImage() {
        UIGraphicsBeginImageContext(CGSize(width: 200, height: 105))
        
        let p = UIBezierPath()
        // 绘制一个黑色的垂直黑色线，作为箭头的杆子
        p.move(to: CGPoint(x: 100, y: 100))
        p.addLine(to: CGPoint(x: 100, y: 19))
        p.lineWidth = 20
        p.stroke()
        // 绘制一个红色三角形箭头
        UIColor.red.set()
        p.removeAllPoints()
        p.move(to: CGPoint(x: 80, y: 25))
        p.addLine(to: CGPoint(x: 100, y: 0))
        p.addLine(to: CGPoint(x: 120, y: 25))
        p.fill()
        //底下缺口
        p.removeAllPoints()
        p.move(to: CGPoint(x: 90, y: 101))
        p.addLine(to: CGPoint(x: 100, y: 90))
        p.addLine(to: CGPoint(x: 110, y: 101))
        p.fill(with: .clear, alpha: 1)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let myImageView = UIImageView()
        myImageView.image = image
        myImageView.frame = CGRect(x: 0, y: 100, width: 200, height: 105)
        self.view.addSubview(myImageView)
        UIGraphicsEndImageContext()
    }
    
    //MARK: coreGraphic画箭头
    func coreGraphicMethod()  {
        UIGraphicsBeginImageContext(CGSize(width: 200, height: 105))
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: 100, y: 100))
        context?.addLine(to: CGPoint(x: 100, y: 19))
        context?.setLineWidth(20)
        context?.strokePath()
        
        context?.setFillColor(UIColor.red.cgColor)
        context?.move(to: CGPoint(x: 80, y: 25))
        context?.addLine(to: CGPoint(x: 100, y: 0))
        context?.addLine(to: CGPoint(x: 120, y: 25))
        context?.fillPath()
        
        context?.move(to: CGPoint(x: 90, y: 101))
        context?.addLine(to: CGPoint(x: 100, y: 90))
        context?.addLine(to: CGPoint(x: 110, y: 101))
        context?.setBlendMode(.clear)
        context?.fillPath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let myImageView = UIImageView()
        myImageView.image = image
        myImageView.frame = CGRect(x: 0, y: 205, width: 200, height: 105)
        self.view.addSubview(myImageView)
        UIGraphicsEndImageContext()
    }
    
    //MARK:左上 右上 有圆角的矩型
    func drawCornerBox() {
        UIGraphicsBeginImageContext(CGSize(width: 200, height: 100))
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineWidth(3)
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 100, height: 100), byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 100, height: 100))
        path.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let myImageView = UIImageView()
        myImageView.image = image
        myImageView.frame = CGRect(x: 0, y: 310, width: 200, height: 100)
        self.view.addSubview(myImageView)
        UIGraphicsEndImageContext()
    }
    
    //MARK: 绘制三次贝塞尔曲线
    func draw1() {
        UIGraphicsBeginImageContext(CGSize(width: 200, height: 200))
        
        UIColor.red.set()
        let path = UIBezierPath()
        path.lineWidth = 2
        path.move(to: CGPoint(x: 0, y: 200))
        path.addCurve(to: CGPoint(x: 200, y: 100), controlPoint1: CGPoint(x: 100, y: 10), controlPoint2: CGPoint(x: 150, y: 100))
        path.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let myImageView = UIImageView()
        myImageView.image = image
        myImageView.frame = CGRect(x: 0, y: 410, width: 200, height: 200)
        self.view.addSubview(myImageView)
        UIGraphicsEndImageContext()
    }
    
    //MARK: CAShaperLayer DEMO
    func CAShaperLayerMethod() {
        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 50, y: 660, width: 100, height: 100)
        layer.backgroundColor = UIColor.cyan.cgColor
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.red.cgColor
        self.view.layer.addSublayer(layer)

        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 100, height: 100))
        layer.path = path.cgPath
    }
    
    //MARK: 绘制三次贝塞尔曲线动画
    func draw1Animation() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 200))
        path.addCurve(to: CGPoint(x: 200, y: 100), controlPoint1: CGPoint(x: 100, y: 10), controlPoint2: CGPoint(x: 150, y: 100))
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 5
        animation.fromValue = 0
        animation.toValue = 1
        animation.repeatCount = 100
        
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.white.cgColor
        layer.frame = CGRect(x: 200, y: 410, width: 200, height: 200)
        
        self.view.layer.addSublayer(layer)
        
        layer.path = path.cgPath
        layer.lineWidth = 2
        layer.strokeStart = 0
        layer.strokeEnd = 1
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            layer.add(animation, forKey: nil)
        }
        
    }

}
