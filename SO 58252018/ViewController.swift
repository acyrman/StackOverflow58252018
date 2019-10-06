//
//  ViewController.swift
//  SO 58252018
//
//  Created by acyrman on 10/5/19.
//  Copyright © 2019 iCyrman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
  @IBOutlet var table: UITableView!
  
  // Variable to hold the data. Using didSet to reload the TableView
  // when new data arrives
  fileprivate var myData = [Class]() {
    didSet {
      // All UI related stuff must run on the main thread
      DispatchQueue.main.async { [weak self] in
        self?.table.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Set this class as DataSource, not the best practice :)
    table.dataSource = self
    // Load data
    loadData()
  }
  
  fileprivate func loadData() {
    // URL to load data from
    let url = URL(string: "https://pricepointproperty.co.uk/appServices/service.php")
    URLSession.shared.dataTask(with:url!, completionHandler: {[weak self] (data, response, error) in
      guard let data = data, error == nil else { print(error!); return }
      
      let decoder = JSONDecoder()
      // If succesfully decoded just set the data to myData variable
      self?.myData = try! decoder.decode([Class].self, from: data)
    }).resume()
  }
  
  //MARK: TableView data source methods
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return myData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // dequeue cell from table, if this fails return empty cell
    guard let cell = table.dequeueReusableCell(withIdentifier: "CellId") else { return UITableViewCell() }
    // Get data from myData using the table's row index
    let dataRow = myData[indexPath.row]
    // Display data on a detail text type cell
    cell.textLabel?.text = dataRow.prop_location
    cell.detailTextLabel?.text = "Id: \(dataRow.prop_id), price: \(dataRow.prop_price)"
    return cell
  }
}

