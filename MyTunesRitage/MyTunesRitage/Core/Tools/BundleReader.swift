//
//  File.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 24/01/2023.
//

import Foundation

struct BundleReader {
    
    static func read<T : Decodable>(_ filename : String, ext : String = "json") -> T{
        let url    = Bundle.main.url(forResource: filename, withExtension: ext)!
        let data   =  try! Data(contentsOf: url)
        return try! JSONDecoder().decode( T.self, from: data)
    }
}
