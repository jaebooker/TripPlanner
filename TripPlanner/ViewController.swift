//
//  ViewController.swift
//  TripPlanner
//
//  Created by Jaeson Booker on 4/3/19.
//  Copyright © 2019 Jaeson Booker. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UITableViewController, AddTripViewControllerDelegate {
    
    var trips = [TripListItem]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTripSegue" {
            let navigationController = segue.destination as! UINavigationController
            let addTripTableController = navigationController.topViewController as! AddTripViewController
            addTripTableController.delegate = self
            let indexPath = sender as! NSIndexPath
            let trip = trips[indexPath.row]
        } else if segue.identifier == "ViewTripSegue" {
            let navigationController = segue.destination as! UINavigationController
            let viewTripTableController = navigationController.topViewController as! ViewTripTableViewController
            //viewTripTableController.delegate = self
            let indexPath = sender as! NSIndexPath
            let trip = trips[indexPath.row]
            //viewTripTableController.trip = "trippy"//trip.name!
            //viewTripTableController.indexPath = indexPath
        }
    }
    func cancelButtonPressed(by controller: AddTripViewController) {
        print("I am Satan, hear me roar")
        dismiss(animated: true, completion: nil)
    }
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TripListItem")
        do {
            let result = try managedObjectContext.fetch(request)
            trips = result as! [TripListItem]
        } catch {
            print("\(error)")
        }
    }
    func tripSaved(by controller: AddTripViewController, with text: String, at indexPath: NSIndexPath?) {
        print("All are welcome here, my child. And you sent me this very odd message: \(text)")
        if let ip = indexPath {
            let item = trips[ip.row]
            item.name = text
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "TripListItem", into: managedObjectContext) as! TripListItem
            item.name = text
            trips.append(item)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

}

