//
//  Astronomy.swift
//  astronomy
//
//  Created by dada on 2021/7/20.
//

import Foundation
import UIKit
// response 參數 decode用
struct AstronomyModel: Decodable {
    var description: String?
    var copyright: String?
    var title: String?
    var url: String?
    var apod_site: String?
    var media_type: String?
    var hdurl: String?
    var date: String?
    private enum AstronomyModel: String, CodingKey {
        case description
        case copyright
        case title
        case url
        case apod_site
        case media_type
        case hdurl
        case date
    }
}
