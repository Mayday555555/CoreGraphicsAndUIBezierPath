//
//  CustomView.swift
//  UIBezierPathAndCoreGraphics
//
//  Created by xuanze on 2019/5/24.
//  Copyright © 2019 xuanze. All rights reserved.
//

import UIKit
import CoreGraphics
class CustomView: UIView {

    override func draw(_ rect: CGRect) {
        //MARK:第一种绘图方式
//        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 100, height: 100))
//        UIColor.blue.setFill()
//        path.fill()
        
        //MARK:第二种绘图方式
//        let context = UIGraphicsGetCurrentContext()
//        context?.addEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
//        context?.setFillColor(UIColor.blue.cgColor)
//        context?.fillPath()
    }

    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        //MARK:第三种绘图方式
//        UIGraphicsPushContext(ctx)
//
//        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 100, height: 100))
//        UIColor.blue.setFill()
//        path.fill()
//
//        UIGraphicsPopContext()
        
        //MARK:第四种绘图方式
        ctx.addEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
        ctx.setFillColor(UIColor.blue.cgColor)
        ctx.fillPath()
    }
}
