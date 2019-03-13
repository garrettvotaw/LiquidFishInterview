//
//  EmailController.swift
//  LiquidFishInterview
//
//  Created by Garrett Votaw on 3/13/19.
//  Copyright © 2019 Garrett Votaw. All rights reserved.
//

import UIKit

class EmailController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    
    let networkManager = JSONDownloader()
    var fishName: Fish!
    var month: Month!
    var count: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = "\(count!) \(fishName!) caught in \(month!.rawValue) months"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendPushed() {
        guard let email = emailTextField.text else {
            return
        }
        networkManager.postFishNumber(email: email, fishType: fishName, total: count, month: month) { (didComplete, error) in
            if didComplete {
                let alert = UIAlertController(title: "Success", message: "Data Shared!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else if let error = error {
                let alert = UIAlertController(title: "\(error.rawValue)", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
