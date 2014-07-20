//
//  Parser.swift
//  WellyBus
//
//  Created by Chris Hawkins on 18/07/14.
//  Copyright (c) 2014 Chris. All rights reserved.
//

import Foundation
import UIKit
//get url
//        var nurl:NSURL = NSURL.URLWithString(urlString)
//        var murlr:NSMutableURLRequest = NSMutableURLRequest(URL: nurl)
//
//        //change user agent of url header to load desktop site
//        var myHeaderString = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.76.4 (KHTML, like Gecko) Version/7.0.4 Safari/537.76.4"
//        murlr.addValue(myHeaderString, forHTTPHeaderField: "User-Agent")


//get page data
//        var response :AutoreleasingUnsafePointer<NSURLResponse?> = nil
//        var error : AutoreleasingUnsafePointer<NSError?> = nil
//        var data :NSData = NSURLConnection.sendSynchronousRequest(murlr, returningResponse: response, error:error)

class Parser{
    class func readStop(stopNumber:Int)->BusStop?{
        
        //assemble URL
        let urlBase = "http://metlink.org.nz/stop/"
        var urlString = urlBase+String(stopNumber)
        var url:NSURL = NSURL.URLWithString(urlString)
        
        //fetch page data
        print("start")
        var data:NSData = NSData.dataWithContentsOfURL(url, options: nil, error: nil)
        print("read")
        
        var parser:TFHpple = TFHpple.hppleWithHTMLData(data)
        
        //search html for name of stop
        var queryStopName = "//div[@id='stopHeader']//span[@class='name']"
        var nodesStop:TFHppleElement[] = parser.searchWithXPathQuery(queryStopName)as TFHppleElement[]
        var stopName = "no name found"
        
        //get from node the stop name
        for node in nodesStop{
            var name:String? = node.firstChild.content
            if name{
                stopName = name!
            }
        }

        var arrivals:Arrival[] = getWeekdayRoutes(parser)
        
        var busStop:BusStop = BusStop(number: stopNumber, name: stopName,arrivals:arrivals)
        return busStop
    }
    
    class func getWeekdayRoutes(parser:TFHpple)->Arrival[]{
        var arrivals:Arrival[] = []
        //search html for name of stop
        var queryStopName = "//div[@id='weekday-services']//tr"
        var nodesStop:TFHppleElement[] = parser.searchWithXPathQuery(queryStopName)as TFHppleElement[]
        
        //get from node the stop name
        for node in nodesStop{
            
            //get number
            
            var numStr = node.attributes["data-code"]
            var num:Int!

            
            if numStr{
                num = (numStr as String).toInt()!
                println(num)
            }else{
                continue
            }
            
            //get color
            var c:TFHppleElement = node.children[0] as TFHppleElement
            var cc = c.children[1] as TFHppleElement
            var ccc = cc.children[1] as TFHppleElement
//            print(ccc)
            
            var fullColStr = ccc.attributes["style"] as String
            println(fullColStr)
            var colStr = fullColStr.componentsSeparatedByString("#")[1]
            println(colStr)
//            var col:UIColor = UIColor(colStr)
//            var redStr = "0x\(colStr.substringToIndex(2))"
//            println(redStr)
//            println(redStr.)
//            var redFloat:CGFloat = CGFloat(redStr.toInt()!)
//            
//            var greenStr = colStr.substringFromIndex(2).substringToIndex(4)
//            var greenFloat:CGFloat = CGFloat(greenStr.toInt()!)
//            
//            var blueStr = colStr.substringFromIndex(4)
//            var blueFloat:CGFloat = CGFloat(blueStr.toInt()!)
//            
//            var col:UIColor = UIColor(red: redFloat, green: greenFloat, blue: blueFloat, alpha: CGFloat(0))
//
//            print(col)
            //get name
            var name = node.children[2].firstChild!.content

            
            //get time
            var timeString = node.children[4].firstChild!.content
            
            var route:Route = Route(number:num,name:name,color:UIColor.orangeColor())
            var date:NSDate = NSDate.date()
            var arrival:Arrival = Arrival(time: timeString, route: route)
            arrivals.append(arrival)


            
            
            println()
            println()
            println()
            println()
            println()
//            
//            println(node.firstChild)
//            println()
//            println()
//            println()
//            println()
//            println()
//            
//            println(node.firstChild.firstChild)
//            println()
//            println()
//            println()
//            println()
//            println()
//            
//            println(node.firstChild.firstChild.firstChild)
//            println()
//            println()
//            println()
//            println()
//            println()
//            
//            println(node.firstChild.firstChild.firstChild.firstChild)
//            println()
//            println()
//            println()
//            println()
//            println()
//            break
        }
        return arrivals
    }
    
    class func getLiveRoutes(parser:TFHpple){
        //serach hrml for arrivals
        var queryDepartures = "//div[@id='live-departures']"
        var nodesDepartures:TFHppleElement[] = parser.searchWithXPathQuery(queryDepartures)as TFHppleElement[]
        
        //print to console for debugging
        for node in nodesDepartures{
            println(node)
        }
    }
    
    
    class func turnToDec(hexNumberString str:String)->Int{
        var sum:Int = 0
        var col = 1

        var charCount = str.utf16count
        
        for col in 0..charCount{
            var strSegment = str.substringFromIndex(col).substringToIndex(col+1)
            var colFactor = Int(pow(Double(16), Double(charCount-col-1)))
            if let numVal = strSegment.toInt(){
                sum += colFactor*numVal
            }else{
                var numVal:Int!
                switch(strSegment){
                    case "a" : numVal = 10
                    case "b" : numVal = 11
                    case "c" : numVal = 12
                    case "d" : numVal = 13
                    case "e" : numVal = 14
                    case "f" : numVal = 15
                    default  : numVal = 10
                }
                sum+=numVal*colFactor
            }
        }

        return sum
    }
    
    
    
    
}