//
//  ColorViewController.swift
//  Example
//
//  Created by Takuma Horiuchi on 2018/02/16.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class ColorViewController: UIViewController {

    private var backgroundColor: UIColor = .white

    class func make(backgroundColor: UIColor) -> ColorViewController {
        let viewController = UIStoryboard(name: "ColorViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "ColorViewController") as! ColorViewController
        viewController.backgroundColor = backgroundColor
        return viewController
    }

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
}

extension ColorViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ColorViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.contentView.backgroundColor = backgroundColor
        cell.textLabel?.text = "Row: \(indexPath.row)"
        return cell
    }
}
