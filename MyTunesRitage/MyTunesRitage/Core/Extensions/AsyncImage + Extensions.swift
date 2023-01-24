//
//  AsyncImage + Extensions.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 24/01/2023.
//

import Foundation
import SwiftUI

extension AsyncImage {
    init(url : URL?, transaction : Transaction = .init(animation:.default), content: @escaping (AsyncImagePhase) -> Content) {
        URLCache.shared.memoryCapacity = 10_000_000
        URLCache.shared.diskCapacity = 1_000_000_000
        self.init(url: url, scale: 1.0, transaction: transaction, content: content)
    }
}
