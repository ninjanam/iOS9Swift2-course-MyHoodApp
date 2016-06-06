//
//  Post.swift
//  my-hood-devslopes
//
//  Created by Nam-Anh Vu on 5/25/16.
//  Copyright © 2016 namdashann. All rights reserved.
//

import Foundation

class Post: NSObject, NSCoding {
    
    private var _imagePath: String!
    private var _title: String!
    private var _postDesc: String!
    
    var imagePath: String {
        return _imagePath
    }
    
    var title: String {
        return _title
    }
    
    var postDesc: String {
        return _postDesc
    }
    
    // our own initialiser
    init(imagePath: String, title: String, description: String) {
        self._imagePath = imagePath
        self._title = title
        self._postDesc = description
    }
    
    // basic initialiser function needed for coding
    override init() {
        
    }
    
    //
    required convenience init?(coder aDecoder: NSCoder) {
        // initialise yourself when you're decoding
        self.init()
        // we're saying to aDecoder, when someone is unarchiving you which is going to happen in our singleton
        // all you have to do is grab it from imagePath, just decode it first
        self._imagePath = aDecoder.decodeObjectForKey("imagePath") as? String
        self._title = aDecoder.decodeObjectForKey("title") as? String
        self._postDesc = aDecoder.decodeObjectForKey("description") as? String
    }
    
    // this function is needed to encode. Whenever it says it it will call this to encode
    // you don't call this yourself, whenever you encode date it will call this automatically
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._imagePath, forKey: "imagePath")
        aCoder.encodeObject(self._postDesc, forKey: "description")
        aCoder.encodeObject(self._title, forKey: "title")
    }
}