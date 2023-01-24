//
//  LoadedImage.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 24/01/2023.
//

import SwiftUI

struct LoadedImage: View {
    
    let url : String
    
    var body: some View {
        AsyncImage(url: URL(string: url), transaction: Transaction(animation: .spring())) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
            case .failure:
                IconView(systemName: "camera.circle.fill")
            default:
                ProgressView()
            }
        }
    }
}

struct LoadedImage_Previews: PreviewProvider {
    static var previews: some View {
        LoadedImage(url: Song.mock.image)
    }
}
