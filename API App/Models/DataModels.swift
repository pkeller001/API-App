//
//  DataModels.swift
//  API App
//
//  Created by Pat Keller on 11/19/21.
//

import Foundation

struct APIarrayMap: Codable {
    let entries: [APIitemMap]
}

struct APIitemMap: Codable {
    let API: String
    let Description: String
    let Auth: String
    let HTTPS: Bool
    let Cors: String
    let Link: String?
    let Category: String
}

struct APIarray {
    var apiEntries: [APIentry]
}

struct APIentry {
    var apiName: String
    var apiDesc: String
    var keyReqd: String
    var httpsreqd: Bool
    var corsreqd: String
    var siteURL: String?
    var apiCategory: String
}
