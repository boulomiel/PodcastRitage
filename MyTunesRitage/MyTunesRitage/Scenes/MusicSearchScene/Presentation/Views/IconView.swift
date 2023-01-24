//
//  IconView.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 24/01/2023.
//

import SwiftUI

struct IconView: View {
    
    var systemName : String
    var scale : CGFloat = 1
    var color : Color = .white
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .scaleEffect(scale)
            .foregroundColor(color)
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(systemName: "play.fill")
    }
}
