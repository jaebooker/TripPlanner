//
//  ViewController.swift
//  TripPlanner
//
//  Created by Jaeson Booker on 4/3/19.
//  Copyright © 2019 Jaeson Booker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let trips: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTripSegue" {
            let navigationController = segue.destination as! UINavigationController
            let addTripTableController = navigationController.topViewController as! AddTripTableViewController
            //addTripTableController.delegate = self
        } else if segue.identifier == "ViewTripSegue" {
            let navigationController = segue.destination as! UINavigationController
            let viewTripTableController = navigationController.topViewController as! ViewTripTableViewController
            //viewTripTableController.delegate = self
            let indexPath = sender as! NSIndexPath
            let trip = trips[indexPath.row]
            //viewTripTableController.item = "trippy"//trip.text!
            //viewTripTableController.indexPath = indexPath
        }
    }

}

