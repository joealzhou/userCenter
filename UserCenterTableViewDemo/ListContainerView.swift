//
//  ListContainerView.swift
//  UserCenterTableViewDemo
//
//  Created by 周强 on 2018/8/20.
//  Copyright © 2018年 周强. All rights reserved.
//

import UIKit
@objc protocol ListContainerScrollProtocol {
    func scrollTo(index: Int)
}

class ListContainerView: UIView {
    var delegate: ListContainerScrollProtocol?
    fileprivate var collectionView: UICollectionView!
    var currentScrollView: UIScrollView?
    weak var mainTableView: UITableView?
    var listViews = [ListBaseView]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
}

extension ListContainerView {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func scrollToIndex(index: Int) {
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    fileprivate func createViews() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self 
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "collectionCell")
        self.addSubview(collectionView)
    }
    
    
}

extension ListContainerView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listViews.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let listView = listViews[indexPath.row]
        listView.frame = cell.contentView.bounds
        cell.contentView.addSubview(listView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return bounds.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.mainTableView?.isScrollEnabled = true
        let index = scrollView.contentOffset.x / bounds.width
        delegate?.scrollTo(index: Int(index))
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.mainTableView?.isScrollEnabled = true
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.mainTableView?.isScrollEnabled = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.mainTableView?.isScrollEnabled = false
        
    }
}

