//
//  CategoryViewController.swift
//  APISample
//
//  Created by tatsuya ohyama on 2019/05/10.
//  Copyright © 2019 tatsuya.ohyama. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let categoryArray = ["Swift", "Kotlin", "Flutter", "Firebase"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "カテゴリ一覧"
    }
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    
        let storyboard: UIStoryboard = UIStoryboard(name: "Results", bundle: nil)
        if let resultVC = storyboard.instantiateViewController(withIdentifier: "results") as? ResultsViewController {
            resultVC.categoryTitle = categoryArray[indexPath.row]
            navigationController?.pushViewController(resultVC, animated: true)
        }
    }
}
