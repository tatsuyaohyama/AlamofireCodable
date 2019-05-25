//
//  ResultsViewController.swift
//  APISample
//
//  Created by tatsuya ohyama on 2019/05/10.
//  Copyright © 2019 tatsuya.ohyama. All rights reserved.
//

import UIKit
import Alamofire
import SafariServices

struct Event: Codable{
    let title: String
    let event_url: String
}
struct Events: Codable{
    let events: [Event]
}

class ResultsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var events: Events?
    var categoryTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getevents()
    }

    func getevents() {
        Alamofire.request("https://connpass.com/api/v1/event/?keyword=\(self.categoryTitle)")
            .responseJSON{ res in
                guard let json = res.data else{
                    return
                }
                self.events = try! JSONDecoder().decode(Events.self, from: json)
                self.tableView.reloadData()
        }
    }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let event = self.events?.events.count{
            return event
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "events", for: indexPath)
        if let event = self.events?.events[indexPath.row] {
            cell.textLabel?.text = event.title
            cell.detailTextLabel?.text = event.event_url
        }
        return cell
    }
}

extension ResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let event = events?.events[indexPath.row] {
            let webPage = event.event_url
            let safariVC = SFSafariViewController(url: URL(string: webPage)!)
            present(safariVC, animated: true, completion: nil)
        }
        return
    }
}
