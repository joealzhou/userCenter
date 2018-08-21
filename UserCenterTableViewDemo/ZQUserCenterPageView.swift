//
//  ZQUserCenterPageView.swift
//  UserCenterTableViewDemo
//
//  Created by 周强 on 2018/8/21.
//  Copyright © 2018年 周强. All rights reserved.
//

import UIKit

@objc protocol ZQUserCenterPageViewProtocol {
    
    /// 列表页
    func pageViewOfListViews() -> [ListBaseView]
    
    func tableHeaderView() -> UIView?
    
    func tableHeaderViewHeight() -> CGFloat
    
    func sectionHeaderView() -> UIView?
    
    func sectionHeaderViewHeight() -> CGFloat
    
    func mainTableViewDidScroll(_ scrollView: UIScrollView)
    
    func categoryScrollTo(index: Int)
}

/// 用户中心主页面
class ZQUserCenterPageView: UIView {
    var currentScrollView: UIScrollView?
    unowned var delegate: ZQUserCenterPageViewProtocol
    fileprivate var mainTableView: UITableView!
    fileprivate var listContainerView: ListContainerView!
    
    init(delegate: ZQUserCenterPageViewProtocol) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainTableView.frame = bounds
    }
    
}

extension ZQUserCenterPageView {
    func listViewDidScroll(_ scrollView: UIScrollView) {
        currentScrollView  = scrollView
        
        if (mainTableView.contentOffset.y < delegate.tableHeaderViewHeight()) {
            //mainTableView的header还没有消失，让listScrollView一直为0
            scrollView.contentOffset = CGPoint.zero
            scrollView.showsVerticalScrollIndicator = false
        } else {
            //mainTableView的header刚好消失，固定mainTableView的位置，显示listScrollView的滚动条
            mainTableView.contentOffset = CGPoint(x: 0, y: delegate.tableHeaderViewHeight())
            scrollView.showsVerticalScrollIndicator = true
        }
        
        if scrollView.contentOffset == .zero {
            for listView in delegate.pageViewOfListViews() {
                listView.scrollView.contentOffset = .zero
            }
        }
    }
    
    func listScrollTo(index: Int) {
        listContainerView.scrollToIndex(index: index)
    }
}

extension ZQUserCenterPageView {
    fileprivate func createViews() {
        mainTableView = MainTableView(frame: bounds, style: .plain)
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.delegate = self
        mainTableView.dataSource = self
        addSubview(mainTableView)
        
        mainTableView.tableHeaderView = delegate.tableHeaderView()
        
        listContainerView = ListContainerView(frame: CGRect.zero)
        listContainerView.delegate = self
        listContainerView.mainTableView = mainTableView
        listContainerView.listViews = delegate.pageViewOfListViews()
    }
}

extension ZQUserCenterPageView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        listContainerView.frame = cell.contentView.bounds
        cell.contentView.addSubview(listContainerView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowH = bounds.height - delegate.sectionHeaderViewHeight()
        return rowH
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return delegate.sectionHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return delegate.sectionHeaderViewHeight()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        delegate.mainTableViewDidScroll(scrollView)
        
        if (currentScrollView != nil && currentScrollView!.contentOffset.y > 0) {
            //mainTableView的header已经滚动不见，开始滚动某一个listView，那么固定mainTableView的contentOffset，让其不动
            self.mainTableView.contentOffset = CGPoint(x: 0, y: HeaderView.h)
        }
        
        if (self.mainTableView.contentOffset.y < HeaderView.h) {
            //mainTableView的header还没有消失，让listScrollView一直为0
            for listView in listContainerView.listViews {
                listView.scrollView.contentOffset = .zero
                listView.scrollView.showsVerticalScrollIndicator = false
            }
        } else {
            //mainTableView的header刚好消失，固定mainTableView的位置，显示listScrollView的滚动条
            self.mainTableView.contentOffset = CGPoint(x: 0, y: HeaderView.h);
            currentScrollView?.showsVerticalScrollIndicator = true
        }
    }
}

extension ZQUserCenterPageView: ListContainerScrollProtocol {
    func scrollTo(index: Int) {
        delegate.categoryScrollTo(index: index)
    }
}
