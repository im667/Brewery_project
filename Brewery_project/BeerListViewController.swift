//
//  ViewController.swift
//  Brewery_project
//
//  Created by mac on 2022/04/22.
//

import UIKit
import SnapKit
import Kingfisher

class BeerListViewController: UITableViewController {
    
    var beerList = [Beer]()
    var dataTasks = [URLSessionTask]()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "패캠브루어리"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
        
        
        tableView.register(BeerListCell.self, forCellReuseIdentifier: BeerListCell.identifier)
        tableView.rowHeight  = 150
    }


}


extension BeerListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerListCell.identifier, for: indexPath) as? BeerListCell else {
            return UITableViewCell()
        }
                
                let beer = beerList[indexPath.row]
                cell.configure(with: beer)
                
                return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer =  beerList[indexPath.row]
        let detailViewController = BeerDetailViewController()
        
        detailViewController.beer = selectedBeer
        self.show(detailViewController, sender: nil)
    }
}

