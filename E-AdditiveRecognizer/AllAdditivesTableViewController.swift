//
//  AdditivesTableViewController.swift
//  TextRecognizer
//
//  Created by Виталий Субботин on 02/10/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit

class AllAdditivesTableViewController: UITableViewController {
    
    var codes: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorInset = .zero
        
        codes = [String](eCodes.keys).sorted { $0.count < $1.count }
        codes = codes?.sorted { $0 < $1 && $0.count == $1.count }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return eCodes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "additiveCell", for: indexPath)
        
        cell.textLabel?.text = codes?[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "allAdditiveDetailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AdditiveDetailViewController, let indexPath = tableView.indexPathForSelectedRow, let codes = codes {
            
            vc.additive = Additive(code: codes[indexPath.row])
        }
    }

}
