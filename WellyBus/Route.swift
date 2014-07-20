//
//  Route.swift
//  iOS8 Table Views
//
//  Created by Chris Hawkins on 16/07/14.
//  Copyright (c) 2014 Andrei Puni. All rights reserved.
//

import Foundation
import UIKit

class Route:Printable,Hashable{
    var number:Int
    var name:String
    var color:UIColor
    
    var hashValue:Int{
        return number
    }
    var description:String{
        return "number \(number) (\(name))"
    }
    
    init(number num:Int,name nam:String,color col:UIColor){
        self.number = num
        self.name = nam
        
        var col:UIColor
        var n = arc4random_uniform(5)
        switch(n){
        case 1:col = UIColor.redColor()
        case 2:col = UIColor.orangeColor()
        case 3:col = UIColor.greenColor()
        case 4:col = UIColor.blueColor()
        default:col = UIColor.purpleColor()
        }
        
        self.color = col
    }
    
    
    class func generateDummyRoute()->Route{
    
    
        var number = Int(arc4random_uniform(40))
        var name = "some made up route"
 
        
        //pick a random color
        var num = arc4random_uniform(5)
        var col:UIColor
        switch(num){
        case 1:col = UIColor.redColor()
        case 2:col = UIColor.orangeColor()
        case 3:col = UIColor.greenColor()
        case 4:col = UIColor.blueColor()
        default:col = UIColor.purpleColor()
        }
        
        var route:Route = Route(number:number,name:name,color:col)

        return route
    }
    
}

func ==(lhs:Route,rhs:Route)->Bool{
    return lhs.number==rhs.number
}