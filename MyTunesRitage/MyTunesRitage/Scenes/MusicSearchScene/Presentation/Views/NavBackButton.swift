//
//  NavBackButton.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 24/01/2023.
//

import SwiftUI

struct NavBackButton: View {
    
    enum BackType {
        case navback
        case close
    }
    
    var backType : BackType
    var dismiss: DismissAction? = nil

    var body: some View {
        Button {
            dismiss?()
        } label: {
            IconView(systemName: backType == .close ? "xmark" : "chevron.left")
        }
    }
}

struct NavBackButton_Previews: PreviewProvider {
    static var previews: some View {
        NavBackButton(backType: .close)
    }
}
