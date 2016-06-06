//
//  DataService.swift
//  my-hood-devslopes
//
//  Created by Nam-Anh Vu on 03/06/2016.
//  Copyright © 2016 namdashann. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    
    static let instance = DataService()
    
    let KEY_POSTS = "posts"
    // initialising an empty array
    private var _loadedPosts = [Post]()
    
    // create the getter
    var loadedPosts: [Post] {
        return _loadedPosts
    }
    
    // save all the posts to the hard drive of the iOS device
    func savePosts() {
        // turn loaded posts into data, bits and bytes. Taking our array and turning it into data.
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
        // grab the storage mechnaism, the standard one setting an object and 
        // giving it a key that we can retrieve at a later point in time
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS)
        
        // the postsData array will always go to the same spot. It will replace the array _loadedPosts every time, 
        // we're not going to append it

        // synchonize will save the data to the disk so that it loads posts from the last time you opened the app
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    // function to load posts
    func loadPosts() {
        // here we are saying that we want the storage mechanism to give us the object for this "posts" key
        // and if we got it back, perform some code
        if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData {
            //turn our data back into an array of posts i.e. an object that we can actually read
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post] {
                _loadedPosts = postsArray
            }
        }
        
        // when the posts have loaded lets call the default notification center
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
    }
    
    // save the path not the image itself
    func saveImageAndCreatePath(image: UIImage) -> String {
        // anytime a user gets a snapshot or takes it from their photo library, we're going to
        // turn that image into data, NSData because it has to be archived. We're turning it into a PNG
        let imgData = UIImagePNGRepresentation(image)

        // create a string that takes a unique name
        let imgPath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        
        // get the full path and append the imgPath
        let fullPath = documentsPathForFilename(imgPath)
        imgData?.writeToFile(fullPath, atomically: true)
        
        // return the path of the image to the object that's calling this so we can save it in the NSUserDefaults
        return imgPath
    }
    
    // retrieving images and loading them. This will return a UIImage so we can actually use it
    // (remember the ? after the return is because it may return an image or it may not, e.g. it may be corrupted and not work
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPathForFilename(path)
        let image = UIImage(named: fullPath)
        return image
    }
    
    // add a new post from the addPostVC
    func addPost(post: Post) {
        // whenever we add a post, we know we're going to append it to our posts array
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
    }
    
    // create this function to get the directory for a specific filename
    func documentsPathForFilename(name: String) -> String {
        // this is how you get the directory, this is your personal Documents directory
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        // it's going to return an array so we want the first element of it
        let fullPath = paths[0] as NSString
        return fullPath.stringByAppendingPathComponent(name)
        
    }
    
    
    
}