//
//  File.swift
//  iOS8 Table Views
//
//  Created by Chris Hawkins on 15/07/14.
//  Copyright (c) 2014 Andrei Puni. All rights reserved.
//

import Foundation
class Entry:Printable{
    let name:String!
    let children:Entry[]?
    var isLeaf:Bool{
        return children==nil
    }
    
    var description:String{
        var str = name
            if !isLeaf{
                for child in children!{
                    str="\(str)\n-\(child)"
                }
            }
        return str
    }
    
    init(name n :String,children c:Entry[]?){
        self.name = n
        self.children = c
    }
    
}