//
//  ItuneItemRaw.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import Foundation

struct ItuneItemRaw : Codable {
    let artistId, collectionId, trackId: Int?
    let wrapperType, kind: String?
    let artistName, collectionName, trackName, collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewUrl, collectionViewUrl, trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country, currency, primaryGenreName: String?
}
