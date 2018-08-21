//
//  ListBaseView.swift
//  UserCenterTableViewDemo
//
//  Created by 周强 on 2018/8/20.
//  Copyright © 2018年 周强. All rights reserved.
//

import UIKit
@objc protocol ListViewProtocol {
    func listViewDidScroll(_ scrollView: UIScrollView)
}

@objc protocol ListViewDelegate {
    var scrollView: UIScrollView { get }
}

class ListBaseView: UIView {
    fileprivate var sections: Int = 0
    fileprivate var tableView: UITableView!
    weak var delegate: ListViewProtocol?
    init(frame: CGRect, sections: Int) {
        super.init(frame: frame)
        self.sections = sections
        createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame =  bounds
    }
    
}

extension ListBaseView {
    fileprivate func createViews() {
        tableView = UITableView(frame: bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        addSubview(tableView)
        tableView.reloadData()
        tableView.tableFooterView = UIView()
    }
}

extension ListBaseView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "第\(indexPath.row)个数据"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.listViewDidScroll(scrollView)
    }
}

extension ListBaseView: ListViewDelegate {
    var scrollView: UIScrollView {
        return tableView
    }
}
