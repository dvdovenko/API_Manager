//
//  ResultTableViewController.swift
//  APIManager
//
//  Created by Daniel Vdovenko on 09.05.2018.
//  Copyright © 2018 Daniel Vdovenko. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {

    var text: String?
    var sortedDictionary: [(key: Character, value: Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Result"
        self.tableView.allowsSelection = false
        var dictionary: [Character: Int] = [:]
        let finalText = text ?? "undefined"
        for char in finalText {
            if let value = dictionary[char] {
                dictionary.updateValue(value + 1, forKey: char)
            } else {
                dictionary.updateValue(1, forKey: char)
            }
        }
        sortedDictionary = dictionary.sorted(by: { $0.key < $1.key })
        var temporaryDictionary: [(key: Character, value: Int)] = []
        for char in sortedDictionary {
            if (char.key == "A") {
                break
            }
            let special = sortedDictionary.removeFirst()
            temporaryDictionary.append(special)
        }
        for _ in temporaryDictionary {
            sortedDictionary.append(temporaryDictionary.removeLast())
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self as AnyClass, forCellReuseIdentifier: "reuseIdentifier")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedDictionary.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        cell.descriptionLabel.text = "«\(sortedDictionary[indexPath.row].key)» – \(sortedDictionary[indexPath.row].value) times"
        return cell
    }

}
