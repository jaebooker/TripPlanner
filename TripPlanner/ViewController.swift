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
        fetchAllItems()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTripCell", for: indexPath)
        cell.textLabel?.text = trips[indexPath.row].name!
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You have been chosen")
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "ViewTripSegue", sender: indexPath)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let trip = trips[indexPath.row]
        managedObjectContext.delete(trip)
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        trips.remove(at: indexPath.row)
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTripSegue" {
            let navigationController = segue.destination as! UINavigationController
            let addTripTableController = navigationController.topViewController as! AddTripViewController
            addTripTableController.delegate = self
        } else if segue.identifier == "ViewTripSegue" {
            let navigationController = segue.destination as! UINavigationController
            let viewTripTableController = navigationController.topViewController as! ViewTripTableViewController
            //viewTripTableController.delegate = self
            let indexPath = sender as! NSIndexPath
            let trip = trips[indexPath.row]
            //viewTripTableController.trip = "trippy"//trip.name!
            //viewTripTableController.indexPath = indexPath
        }
        else if segue.identifier == "EditTripSegue" {
            let navigationController = segue.destination as! UINavigationController
            let editTripController = navigationController.topViewController as! AddTripViewController
            editTripController.delegate = self
            let indexPath = sender as! NSIndexPath
            let trip = trips[indexPath.row]
            editTripController.trip = trip.name!
            editTripController.indexPath = indexPath
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
            let trip = trips[ip.row]
            trip.name = text
        } else {
            let trip = NSEntityDescription.insertNewObject(forEntityName: "TripListItem", into: managedObjectContext) as! TripListItem
            trip.name = text
            trips.append(trip)
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

