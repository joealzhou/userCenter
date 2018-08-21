//
//  CategoryView.swift
//  UserCenterTableViewDemo
//
//  Created by 周强 on 2018/8/20.
//  Copyright © 2018年 周强. All rights reserved.
//

import UIKit
@objc protocol CategorySelectProtocol {
    func categorySelectedWith(index: Int)
}

class CategoryView: UIView {
    var delegate: CategorySelectProtocol?
    static let h: CGFloat = 50
    fileprivate var btns = [UIButton]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CategoryView {
    fileprivate func createViews() {
        let stackView = UIStackView(frame: bounds)
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        let btn1 = UIButton()
        btn1.tag = 1000
        btn1.isSelected = true
        btn1.setTitle("one", for: .normal)
        btn1.setTitleColor(UIColor.lightGray, for: .normal)
        btn1.setTitleColor(UIColor.orange, for: .selected)
        btn1.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        
        let btn2 = UIButton()
        btn2.tag = 1001
        btn2.setTitle("two", for: .normal)
        btn2.setTitleColor(UIColor.lightGray, for: .normal)
        btn2.setTitleColor(UIColor.orange, for: .selected)
        btn2.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        
        stackView.addArrangedSubview(btn1)
        stackView.addArrangedSubview(btn2)
        
        btns = [btn1, btn2]
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: bounds.height - 0.5, width: bounds.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        layer.addSublayer(bottomLine)
    }
    
    @objc fileprivate func btnClick(btn: UIButton) {
        if btn.isSelected {
            return
        }
        let _ = btns.map { $0.isSelected = false }
        btn.isSelected = true
        delegate?.categorySelectedWith(index: btn.tag - 1000)
    }
}

extension CategoryView {
    func selectedBtn(index: Int) {
        for (i, btn) in btns.enumerated() {
            if i == index {
                btn.isSelected = true
            } else {
                btn.isSelected = false
            }
        }
    }
}
