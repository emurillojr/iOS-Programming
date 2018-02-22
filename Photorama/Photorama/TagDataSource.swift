//
//  TagDataSource.swift
//  Photorama
//
//  Created by user135340 on 2/22/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

//import Foundation

import UIKit
import CoreData
class TagDataSource: NSObject, UITableViewDataSource {
    var tags: [Tag] = []
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                                 for: indexPath)
        let tag = tags[indexPath.row]
        cell.textLabel?.text = tag.name
        cell.accessibilityHint = "Double tap to toggle selected"
        return cell }    
    
}
