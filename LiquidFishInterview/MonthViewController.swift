//
//  MonthViewController.swift
//  LiquidFishInterview
//
//  Created by Garrett Votaw on 3/13/19.
//  Copyright © 2019 Garrett Votaw. All rights reserved.
//

import UIKit

struct MonthData {
    let month: Month
    let count: Int
}

class MonthViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fishTapped: CellData!
    var rawData = [FishingTrip]()
    var formattedData = [Month:Int]()
    var monthData = [MonthData]()
    @IBOutlet weak var monthTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monthTableView.dataSource = self
        monthTableView.delegate = self
        self.navigationItem.title = "Top 5 Months for \(fishTapped.name)"
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        formattedData = formatData()
        monthData = convertDataToObject()
        monthTableView.reloadData()
    }
    
    //MARK: TABLEVIEW METHODS
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FishingTypeCell") as! FishingTypeCell
        cell.fishName.text = monthData[indexPath.row].month.rawValue
        cell.countLabel.text = String(monthData[indexPath.row].count)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showEmailVC", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: HELPER METHODS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! EmailController
        nextVC.fishName = fishTapped.name
        nextVC.month = monthData[monthTableView.indexPathForSelectedRow!.row].month
        nextVC.count = monthData[monthTableView.indexPathForSelectedRow!.row].count
    }
    
    
    func formatData() -> [Month:Int] {
        var dict = [Month:Int]()
        for trip in rawData {
            if dict.keys.contains(trip.formattedDate) {
                guard var counter = dict[trip.formattedDate] else {return [:]}
                for fish in trip.fishCaught {
                    if fish == fishTapped.name {
                        counter += 1
                    }
                }
                dict[trip.formattedDate] = counter
                
            } else {
                var counter = 0
                for fish in trip.fishCaught {
                    if fish == fishTapped.name {
                        counter += 1
                    }
                }
                dict[trip.formattedDate] = counter
            }
        }
        return dict
    }
    
    func convertDataToObject() -> [MonthData]{
        var result = [MonthData]()
        for (key, value) in formattedData {
            result.append(MonthData(month: key, count: value))
        }
        result.sort {$0.count > $1.count}
        return result
    }
    
}
