//
//  FlashCard.swift
//  Flash Cards
//
//  Created by sam mceachern on 23/10/22.
//

import SwiftUI

class FlashCard {
    var contentSide1 = Content()
    var contentSide2 = Content()
    
    struct Content {
        var text: String = ""
    }
    
    public func GetView(flipped: Bool) -> some View {
        print(flipped)
        return
            TextField(
                (self.getCurrentContent(flipped: flipped).text == "") ? "Enter Text Here" : self.getCurrentContent(flipped: flipped).text,
                text: self.getCurrentContentWritable(flipped: flipped).text
            )
            .multilineTextAlignment(.center)
            .padding(0.0)
    }
    
    private func getCurrentContent(flipped: Bool) -> Content {
        if (flipped == true) {
            return self.contentSide2
        }
    
        return self.contentSide1
    }
    
    private func getCurrentContentWritable(flipped: Bool) -> Binding<Content> {
        if (flipped == true) {
            return Binding(get: {self.contentSide2}, set: {self.contentSide2 = $0})
        }
    
        return Binding(get: {self.contentSide1}, set: {self.contentSide1 = $0})
    }
}
