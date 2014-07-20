//
//  StopViewController.swift
//
//  Created by Chris Hawkins on 15/07/14

import Foundation


import UIKit
import CoreData

class AllStopsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate, UITextFieldDelegate {
    @IBOutlet
    var tableView: UITableView
    
    @IBOutlet
    var dashboardButt:UIButton
    
//    var data: BusStop[] = []
    var inputAlert:UIAlertView!
    
    var user:User!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        self.user = User()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //set up input alert view
        var alert:UIAlertView = UIAlertView()
        alert.delegate = self
        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alert.title = "Enter Stop Number"
        alert.textFieldAtIndex(0).delegate = self
        alert.textFieldAtIndex(0).keyboardType = UIKeyboardType.NumberPad
        alert.textFieldAtIndex(0).sizeThatFits(CGSize(width: 50, height: 20))
        alert.addButtonWithTitle("Cancel")
        alert.addButtonWithTitle("Add")
        alert.tag=666
        self.inputAlert = alert

    }
    
    
    func loadFavs(){
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var fetchRequest = NSFetchRequest(entityName: "BusStop")
        fetchRequest.returnsObjectsAsFaults = false

        var result:AnyObject[] = context.executeFetchRequest(fetchRequest, error: nil)
        println(result)
//        if(result.count<1){
//            println("no results found from fetch of BusStops")
//        }else{
//            for res in result{
//                println(res)
//            }
//        }
    
    }
    
    @IBAction func smile(){
        inputAlert.show()


    }
    
    
    
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        if(alertView.tag==666){
        let buttonTitle = alertView.buttonTitleAtIndex(buttonIndex)

            if(buttonTitle=="Cancel"){
                print("cancelled")
            }else{
                //get index
                var numberString:String = alertView.textFieldAtIndex(0).text
                if let num = numberString.toInt(){
                    var stop = Parser.readStop(num)!
                    
//                    var stop = BusStop(number: num, name: "some stupid stop")
                    
                    self.user.favStops.append(stop)
//                    self.data.append(stop)
                    
                    self.tableView.reloadData()
                    

                    //add to core data
                    storeStop(stop)
                }
                print("okayed")
            }
        }
    }
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        
        //always allow backspace
        if string==""{
            return true
        }
        
        //don't allow longer than four characters
        if textField.text.utf16count>=4{
            return false
        }
        
        //otherwise only allow numbers
        if let num = string.toInt(){
            return true
        }else{
            return false
        }
        
        
    }// return NO to not change text


    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.user.favStops.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("normalCell") as UITableViewCell
        
        cell.textLabel.text = self.user.favStops[indexPath.row].name
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let busStop:BusStop = user.favStops[indexPath.row]
        println("You selected cell #\(indexPath.row)!")
        println("\(busStop)")
        
        //if has children seg out
        self.performSegueWithIdentifier("showDetail", sender: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!){
                if segue.identifier=="showDetail"{
                    let destination:StopViewController = segue.destinationViewController as StopViewController

                    destination.stop = user.favStops[self.tableView.indexPathForSelectedRow().row]
                }
    }
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            user.favStops.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    func storeStop(stop:BusStop){
//        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
//        var context:NSManagedObjectContext = appDel.managedObjectContext
//        
//        var NSMOStop = NSEntityDescription.insertNewObjectForEntityForName("BusStopRecord", inManagedObjectContext: context) as NSManagedObject
//        
//        NSMOStop.setValue(stop.number,forKey: "number")
//        NSMOStop.setValue(stop.name,forKey: "name")
//
//        println("stored \(NSMOStop)")
//        var error :NSErrorPointer = nil
//        context.save(error)
//        if error{
//            println(error)
//            abort()
//        }
        println("object saved")
    }
}

