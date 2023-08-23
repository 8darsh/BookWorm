//
//  EmojiView.swift
//  Bookworm
//
//  Created by Adarsh Singh on 21/04/23.
//

import SwiftUI

struct EmojiView: View {
    let rating: Int16
    var body: some View {
        switch rating{
        case 1:
            Text("🤓")
                .font(.largeTitle)
        case 2:
            Text("☺️")
                .font(.largeTitle)
        case 3:
            Text("😊")
                .font(.largeTitle)
        case 4:
            Text("🤩")
                .font(.largeTitle)
        case 5:
            Text("🥳")
                .font(.largeTitle)
        default:
            Text("N/A")
                .font(.largeTitle)
        }
    }
}

struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView(rating: 3)
    }
}
