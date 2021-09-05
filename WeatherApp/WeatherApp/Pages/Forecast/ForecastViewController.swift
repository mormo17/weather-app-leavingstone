//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import UIKit

class ForecastViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp(){
        initTableView()
    }
    
    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        registerTableView()
    }
    
    func registerTableView(){
        
        tableView.register(ForecastHeader.nib(), forCellReuseIdentifier: ForecastHeader.identifier)
        
        tableView.register(ForecastDescription.nib(), forCellReuseIdentifier: ForecastDescription.identifier)
        
    }
}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Table view cell")
        var cell = UITableViewCell()
        if indexPath.row % 5 == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: ForecastHeader.identifier, for: indexPath)
            if let tableViewCell = cell as? ForecastDescription{
                
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: ForecastDescription.identifier, for: indexPath)
            if let tableViewCell = cell as? ForecastDescription{
                
            }
        }
        
        
        return cell
    }
}

