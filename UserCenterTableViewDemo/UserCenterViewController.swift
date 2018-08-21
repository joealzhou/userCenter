//
//  UserCenterViewController.swift
//  UserCenterTableViewDemo
//
//  Created by 周强 on 2018/8/20.
//  Copyright © 2018年 周强. All rights reserved.
//

import UIKit

class UserCenterViewController: UIViewController {
    
    fileprivate var pageView: ZQUserCenterPageView!
    fileprivate var headerView: HeaderView!
    fileprivate var sectionView: CategoryView!
    fileprivate var listView = [ListBaseView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        title = "个人中心"
        initViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageView.frame = view.bounds
    }

}

extension UserCenterViewController {
    fileprivate func initViews() {
        listViews()
        
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: HeaderView.h))
        
        sectionView = CategoryView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: CategoryView.h))
        sectionView.delegate = self
        
        pageView = ZQUserCenterPageView(delegate: self)
        view.addSubview(pageView)
    }
    
    fileprivate func listViews() {
        let list1 = ListBaseView(frame: .zero, sections: 40)
        list1.delegate = self
        
        let list2 = ListBaseView(frame: .zero, sections: 6)
        list2.delegate = self
        
        listView = [list1, list2]
    }
}

extension UserCenterViewController: ZQUserCenterPageViewProtocol {
    func pageViewOfListViews() -> [ListBaseView] {
        return listView
    }
    
    func tableHeaderView() -> UIView? {
        return headerView
    }
    
    func tableHeaderViewHeight() -> CGFloat {
        return headerView.bounds.size.height
    }
    
    func sectionHeaderView() -> UIView? {
        return sectionView
    }
    
    func sectionHeaderViewHeight() -> CGFloat {
        return sectionView.bounds.size.height
    }
    
    func mainTableViewDidScroll(_ scrollView: UIScrollView) {
        headerView.scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y)
    }
    
    func categoryScrollTo(index: Int) {
        sectionView.selectedBtn(index: index)
    }
}

extension UserCenterViewController: ListViewProtocol {
    func listViewDidScroll(_ scrollView: UIScrollView) {
        pageView.listViewDidScroll(scrollView)
    }
}

extension UserCenterViewController: CategorySelectProtocol {
    func categorySelectedWith(index: Int) {
        pageView.listScrollTo(index: index)
    }
    
    
}
