//  ImageSearchDemo
//
//  created by Suman on 11/25/17.
//  Copyright © 2017 suman. All rights reserved.


import Foundation

import ObjectMapper
import Alamofire
import AlamofireObjectMapper

/*
 Model class to map the API response for Google image search
 */

class GoogleAPIModel: Mappable{

    var items:[SearchItemModel]?

    required init?(map: Map){

    }

    func mapping(map: Map) {

        items <- map["items"]
    }
}

class SearchItemModel: Mappable{

    var title: String?
    var imageLink: String?
    var imageModel: ImageModel?

    required init?(map: Map){

    }

    func mapping(map: Map) {

        imageLink <- map["link"]
        title <- map["title"]
        imageModel <- map["image"]

    }
}


class ImageModel: Mappable{

    var thumbnailLink: String?

    required init?(map: Map){

    }

    func mapping(map: Map) {

        thumbnailLink <- map["thumbnailLink"]
    }
}
