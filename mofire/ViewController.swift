//
//  ViewController.swift
//  mofire
//
//  Created by Mohamed Kamal on 06/02/2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let cellReuseIdentifier = "cell"
    var titles = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://api.androidhive.info/json/movies.json") else {
                return
            }
        AF.request(url).responseJSON { response in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        do
                        {

                            for try da in data as! [Dictionary<String,Any>]
                            {
                                self.titles.append(da["title"] as! String)
                            }
                                self.tableView.reloadData()
                        }
                        catch let error
                        {
                            print(error)
                        }
                    }
            
                }
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self



    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =
            tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? UITableViewCell
        {
            cell.textLabel!.text = self.titles[indexPath.row]
            return cell
        }
    }
}
