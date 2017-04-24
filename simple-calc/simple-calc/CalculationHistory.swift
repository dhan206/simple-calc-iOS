//
//  CalculationHistory.swift
//  simple-calc
//
//  Created by Derek Han on 4/23/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import UIKit

protocol DataEnteredDelegate: class {
    func userDidEnterInformation(info: [String])
}

class CalculationHistory: UIViewController,  UITableViewDataSource {
    
    var CalculationHistory = [String]()
    
    weak var delegate: DataEnteredDelegate? = nil
    
    @IBAction func sendCalculationHistoryBack(_ sender: Any) {
        delegate?.userDidEnterInformation(info: CalculationHistory)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CalculationHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let calculation = CalculationHistory[indexPath.row]
        
        cell.textLabel?.text = calculation
        return cell
    }
}
