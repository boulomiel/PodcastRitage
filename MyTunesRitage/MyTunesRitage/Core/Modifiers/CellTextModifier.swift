//
//  CellTextModifier.swift
//  MyTunesRitage
//
//  Created by Ruben Mimoun on 24/01/2023.
//

import Foundation
import SwiftUI

struct CellTextModifier : ViewModifier {
    
    var font : Font
    
    func body(content : Content) -> some View {
        content
            .font(font)
            .frame(width: 200,height: 20, alignment:.leading)
            .bold()
    }
}

extension View {
    func cellStyle(font : Font) -> some View {
        modifier(CellTextModifier(font: font))
    }
}
