//
//  ViewController.swift
//  UserCenterTableViewDemo
//
//  Created by 周强 on 2018/8/20.
//  Copyright © 2018年 周强. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }

    @IBAction func pushUserCenterVC(_ sender: Any) {
        let vc = UserCenterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

