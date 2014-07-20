
//
//  BusStop.swift
//  iOS8 Table Views
//
//  Created by Chris Hawkins on 15/07/14.
//  Copyright (c) 2014 Andrei Puni. All rights reserved.
//


import Foundation
class BusStop:Printable{
    let number:Int!
    let name:String!
    var incomingBuses:Arrival[] = []
    var servicingRoutes:Array<Route>{
        //TODO remove assumption that all next x hours represents all routes
        var routes:Array<Route> = []
        for arrival in incomingBuses{
            var exists = false
            for route in routes{
                if arrival.route.number==route.number{
                    exists = true
                }
            }
            
            if(!exists){
                routes.append(arrival.route)
            }
        }
            
            //sort
            routes.sort({ $0.number < $1.number })
            return routes
    }
    
    var favouriteRoutes:Set<Route> = Set<Route>()
    
    var favouriteIncoming:Arrival[]{
        var arrivals:Arrival[] = []
            for arrival in incomingBuses{
                if favouriteRoutes.containsElement(arrival.route){
                    arrivals.append(arrival)
                }
            }
        return arrivals
    }

    var description:String{
        return "stop number \(number) (\(name))"
    }
    
    init(number n :Int, name :String="new stop"){
        self.name = name
        self.number = n
        
        //make some dummy arrivals
        var numDummies = Int(arc4random_uniform(6))+1
//        
//        while incomingBuses.count<numDummies{
//            incomingBuses.append(Arrival.getDummyArrival())
//        }
    }
    
    init(number n:Int,name:String,arrivals:Arrival[]){
        self.number = n
        self.name = name
        self.incomingBuses = arrivals
    }
    
}