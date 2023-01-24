//
//  ItunesItemsRaw.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import Foundation

struct ItunesItemsRaw : Codable {
    let resultCount : Int
    let results : [ItuneItemRaw]    
}
