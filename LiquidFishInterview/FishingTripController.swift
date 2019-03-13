//
//  FishingTripController.swift
//  LiquidFishInterview
//
//  Created by Garrett Votaw on 3/13/19.
//  Copyright © 2019 Garrett Votaw. All rights reserved.
//

import UIKit

struct CellData {
    let name: String
    let count: Int
}

class FishingTripController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var fishingTypeTableView: UITableView!
    
    let networkManager = JSONDownloader()
    var data: [String:Int] = [:] {
        didSet {
            convertDictToObject()
        }
    }
    var rawData = [FishingTrip]()
    var dataArray = [CellData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fishingTypeTableView.dataSource = self
        fishingTypeTableView.delegate = self
        networkManager.getFishingTrip { [unowned self] (fishingTrips, networkError) in
            if let fishingTrips = fishingTrips {
                self.data = self.formatData(data: fishingTrips)
                self.rawData = fishingTrips
                self.fishingTypeTableView.reloadData()
            } else if let error = networkError {
                let alert = UIAlertController(title: "\(error.rawValue)", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: TABLEVIEW METHODS
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FishingTypeCell") as! FishingTypeCell
        cell.fishName.text = dataArray[indexPath.row].name
        cell.countLabel.text = String(dataArray[indexPath.row].count)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showMonthController", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: PREPARE FOR SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! MonthViewController
        nextVC.fishTapped = dataArray[fishingTypeTableView.indexPathForSelectedRow!.row]
        nextVC.rawData = rawData
    }
    
    
    
    //MARK: HELPER FUNCTIONS
    func formatData(data: [FishingTrip]) -> [String: Int] {
        
        var result = [String:Int]()
        for trip in data {
            let filteredFishCaught = Set(trip.fishCaught)
            for fish in filteredFishCaught {
                if result.keys.contains(fish) {
                    guard var fishCount = result[fish] else {return [:]}
                    fishCount += 1
                    result[fish] = fishCount
                } else {
                    result[fish] = 1
                }
            }
        }
        print(result)
        return result
    }
    
    func convertDictToObject() {
        for (key, value) in data {
            dataArray.append(CellData(name: key, count: value))
        }
        dataArray.sort { $0.count > $1.count }
    }
    
}
