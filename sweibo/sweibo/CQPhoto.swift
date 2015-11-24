//
//  CQPhoto.swift
//  sweibo
//
//  Created by y on 15/11/21.
//  Copyright © 2015年 y. All rights reserved.
//


class CQPhoto: NSObject {
    // url
    var thumbnail_pic:NSURL?
    static func getPhoto(dic:NSDictionary) -> CQPhoto {
        let photo = CQPhoto()
        photo.thumbnail_pic = NSURL.init(string: dic["thumbnail_pic"] as! String)
        return photo
    }
}
