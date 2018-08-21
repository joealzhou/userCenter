//
//  HeaderView.swift
//  UserCenterTableViewDemo
//
//  Created by 周强 on 2018/8/20.
//  Copyright © 2018年 周强. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    static let h: CGFloat = 200
    fileprivate var imgv: UIImageView!
    fileprivate var imageFrame: CGRect!
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgv = UIImageView(frame: bounds)
        imgv.image = #imageLiteral(resourceName: "lufei.jpg")
        imgv.clipsToBounds = true
        imgv.contentMode = .scaleAspectFill
        addSubview(imgv)
        
        imageFrame = imgv.frame
    }
    
    func scrollViewDidScroll(contentOffsetY: CGFloat) {
        var frame = imageFrame ?? .zero
        frame.size.height -= contentOffsetY
        frame.origin.y = contentOffsetY
        imgv.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
