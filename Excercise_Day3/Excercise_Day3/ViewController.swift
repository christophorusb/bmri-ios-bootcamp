//
//  ViewController.swift
//  Excercise_Day3
//
//  Created by laptop MCO on 02/08/23.
//

import UIKit
import SVGKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var countryFlagData: [CountryFlagModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

        self.countryFlagData = CountryFlagProvider.shared.loadData()
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryFlagData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL_ID", for: indexPath)

        let model = self.countryFlagData[indexPath.row]
        
        cell.textLabel?.text = model.name
        cell.detailTextLabel?.text = model.emoji
        
        downloadSVG(url: model.image){
            image in cell.imageView?.image = image
        }
        
        return cell
    }
    
    func downloadSVG(url: String, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let imageUrl = URL(string: url),
               let data = try? Data(contentsOf: imageUrl){
                
                let svg = SVGKImage(data: data)
                
                DispatchQueue.main.async {
                    completion(svg?.uiImage)
                }
                
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}

//class CustomViewCell: UITableViewCell {
//    @IBOutlet weak var name: UILabel!
//    @IBOutlet weak var emoji: UILabel!
//    @IBOutlet weak var code: UILabel!
//    @IBOutlet weak var unicode: UILabel!
//    @IBOutlet weak var image_: UILabel!
//}



