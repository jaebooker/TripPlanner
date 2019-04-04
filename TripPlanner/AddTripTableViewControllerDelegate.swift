//
//  AddTripTableViewControllerDelegate.swift
//  TripPlanner
//
//  Created by Jaeson Booker on 4/3/19.
//  Copyright © 2019 Jaeson Booker. All rights reserved.
//

import Foundation
protocol AddTripViewControllerDelegate: class {
    func tripSaved(by controller: AddTripViewController, with text: String, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: AddTripViewController)
}
