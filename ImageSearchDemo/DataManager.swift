//  DataManager
//
//  ImageSearchDemo
//
//  created by Suman on 11/25/17.
//  Copyright © 2017 suman. All rights reserved.


import Foundation
import Alamofire
import AlamofireObjectMapper

class DataManager {
    
    static let sampleJSONModel = false

    class func setCommonHeader(for method:String, request: inout URLRequest) {

        request.httpMethod = method;
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("SyntoyAppCryptic123", forHTTPHeaderField: "X-API-Key")
        
    }



    class func fetchImages(completionBlock:@escaping (GoogleAPIModel?)->()) {

        let urlString: String = Constants.GoogleAPI

        var request = URLRequest(url: try! urlString.asURL())
        setCommonHeader(for: "GET", request: &request)

        print("url = \(urlString)")

        Alamofire.request(request).responseObject { (response: DataResponse<GoogleAPIModel>) in


            guard let aPIModel: GoogleAPIModel = response.result.value else {
                //handle error
                completionBlock(nil)
                return
            }

            completionBlock(aPIModel)

        }
    }

    

}
