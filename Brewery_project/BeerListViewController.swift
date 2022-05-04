//
//  ViewController.swift
//  Brewery_project
//
//  Created by mac on 2022/04/22.
//

import UIKit
import Kingfisher

class BeerListViewController: UITableViewController {
    
    var beerList = [Beer]()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "패캠브루어리"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
        
        
        tableView.register(BeerListCell.self, forCellReuseIdentifier: BeerListCell.identifier)
        tableView.rowHeight  = 150
        
        fetchBeer(of: currentPage)
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

//data Fetching
private extension BeerListViewController {
    
    func fetchBeer(of page:Int){
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                print("error:\(error?.localizedDescription ?? "")")
                
                return
            }
            switch response.statusCode {
            case (200...299):
                self.beerList += beers
                self.currentPage += 1
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case(400...499):
                print("""
                Error: ClientError \(response.statusCode)
                Response:\(response)
                """)
            case(500...599):
                print("""
                Error: ServerError \(response.statusCode)
                Response:\(response)
                """)
            default:
                print("""
                Error: Error \(response.statusCode)
                Response:\(response)
                """)
            }
        
        }
        dataTask.resume()
        
                
    }
    
}
