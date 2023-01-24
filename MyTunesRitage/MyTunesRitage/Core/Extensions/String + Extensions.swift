//
//  String + Extensions.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import Foundation

extension String {
    func date() -> String {
        let formatter =  DateFormatter()
        formatter.dateFormat = Texts.dateFormat
        let date = formatter.date(from: self)!
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    func toSearchQueryFormat() -> String {
        return self.replacingOccurrences(of: " ", with: "+")
    }
}
