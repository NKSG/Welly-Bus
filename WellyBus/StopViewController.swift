//
//  StopViewController.swift
//  iOS8 Table Views
//
//  Created by Chris Hawkins on 15/07/14.
//  Copyright (c) 2014 Andrei Puni. All rights reserved.
//

import Foundation
import UIKit

class StopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet
    var tableView: UITableView
    
    @IBOutlet
    var headerLabel:UILabel
    
    @IBOutlet
    var numberLabel:UILabel
    
    var stop:BusStop!
    var data: Route[] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        data = stop.servicingRoutes

        headerLabel.text = stop.name
        numberLabel.text = String(stop.number)

        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    
    
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.data.count;
//        return 3
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        print("what")
        var cell:myRouteCell!
//        cell = self.tableView.dequeueReusableCellWithIdentifier("favCell") as UITableViewCell

        var route:Route = data[indexPath.row]
        if(stop.favouriteRoutes.containsElement(route)){
            cell = self.tableView.dequeueReusableCellWithIdentifier("favCell") as myRouteCell
        }else{
            cell = self.tableView.dequeueReusableCellWithIdentifier("stopCell") as myRouteCell
        }
        
        cell.nameLabel.text = route.name
        cell.numberLabel.text = String(route.number)
        cell.numberLabel.textColor = route.color
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        //add to favourites
        var route:Route = data[indexPath.row]
        //remove from favs if in favs, else add to favs
        if(stop.favouriteRoutes.containsElement(route)){
            stop.favouriteRoutes.removeElement(route)
    
        }else{
            stop.favouriteRoutes.addElement(data[indexPath.row])
                        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!){
        
    }
}

