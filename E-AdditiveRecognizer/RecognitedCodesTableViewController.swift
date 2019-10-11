//
//  RecognitedCodesTableViewController.swift
//  TextRecognizer
//
//  Created by Виталий Субботин on 03/10/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit

class RecognitedCodesTableViewController: UITableViewController {

    var recognitedAdditives: [Additive]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recognitedAdditives = recognitedAdditives else { return 0 }
        return recognitedAdditives.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if let recognitedAdditives = recognitedAdditives {
            cell.textLabel?.text = recognitedAdditives[indexPath.row].code
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "recognitedDetailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AdditiveDetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow, let recognitedAdditives = recognitedAdditives {
                vc.additive = recognitedAdditives[indexPath.row]
            }
        }
    }


}
