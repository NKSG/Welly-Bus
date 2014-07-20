//
//  Arrival.swift
//  iOS8 Table Views
//
//  Created by Chris Hawkins on 15/07/14.
//  Copyright (c) 2014 Andrei Puni. All rights reserved.
//

import Foundation

class Arrival:Printable{
    var time:String!
//    var number:Int!
//    var routeName:String!
    
    var route:Route
    
    var description:String{
        return "\(route) at \(time)"
    }
    
    init(time t :String,route r:Route){
        self.time = t
        self.route = r
    }
    

//    
//    
//    class func getDummyArrival()->Arrival{
//        
//        //make dummy date
//        var date:NSDate = NSDate.date()
//        var timeInterval:NSTimeInterval = NSTimeInterval(arc4random_uniform(60))
//        date.addTimeInterval(timeInterval)
//        
//        var route = Route.generateDummyRoute()
//        
//        
//        let arrival:Arrival = Arrival(time:date,route:route)
//        return arrival
//    }
}