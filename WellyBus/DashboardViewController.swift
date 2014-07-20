//
//  DashboardViewController.swift
//  WellyBus
//
//  Created by Chris Hawkins on 19/07/14.
//  Copyright (c) 2014 Chris. All rights reserved.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
   
    @IBOutlet
    var tableView: UITableView
    var user:User!
    
    var refreshControl:UIRefreshControl!
    
    init(coder aDecoder: NSCoder!){
        super.init(coder: aDecoder)


    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = User()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        //refreshing thign
        self.refreshControl = UIRefreshControl()
        self.refreshControl.backgroundColor = UIColor.purpleColor()
        self.refreshControl.tintColor = UIColor.whiteColor()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return self.user.favStops[section].name
        
    }
    
    func refresh(sender:AnyObject){
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Table view data source

     func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.user.favStops.count
    }
    


     func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.user.favStops[section].favouriteIncoming.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        var cell:myArrivaCelll = self.tableView.dequeueReusableCellWithIdentifier("dashboardCell") as myArrivaCelll
        
        var stop:BusStop = self.user.favStops[indexPath.section]
        var arrival:Arrival = stop.favouriteIncoming[indexPath.row]
        
        cell.nameLabel.text = arrival.route.name
        cell.numberLabel.text = String(arrival.route.number)
        cell.numberLabel.textColor = arrival.route.color
        cell.timeLabel.text = arrival.time
//        cell.text = arrival.description

        return cell
    }

    
    @IBAction func goToFavs(){
        self.performSegueWithIdentifier("goToFavs", sender: nil)

    }
    
    @IBAction func reload(){
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!){
        if segue.identifier=="goToFavs"{
            let destination:AllStopsViewController = segue.destinationViewController as AllStopsViewController
            
            destination.user = self.user
        }
    }
    /*
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView?, moveRowAtIndexPath fromIndexPath: NSIndexPath?, toIndexPath: NSIndexPath?) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView?, canMoveRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
