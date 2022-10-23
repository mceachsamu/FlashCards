//
//  ContentView.swift
//  Flash Cards
//
//  Created by sam mceachern on 23/10/22.
//

import SwiftUI
import CoreData

struct FlashCardView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>
    var flipped = false;
    var currentCard = FlashCard()
    
    var body: some View {
        currentCard.GetView(flipped: flipped)
    }
}

struct FlashCardNavigator: View {
    @State public var flipped = false;
    @Environment(\.managedObjectContext) private var viewContext

    var flashCards: [FlashCard] = []
    @State var index: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                FlashCardView(flipped: flipped, currentCard: flashCards[index])
            }.toolbar(content: {
                HStack {
                    Button(
                        action: {
                            self.flipCard()
                        }, label: {
                            Text("Add Card")
                        }
                    )
                    Button(
                        action: {
                            self.flipCard()
                        }, label: {
                            Text("Flip Card")
                        }
                    )
                }
            })
        }
        .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                    .onEnded { value in
                        let horizontalAmount = value.translation.width
                        let verticalAmount = value.translation.height

                        self.scrollCard(horizontalAmount: horizontalAmount, verticalAmount: verticalAmount)
                    })
    }
    
    private func scrollCard(horizontalAmount : CGFloat, verticalAmount: CGFloat) {
        if abs(horizontalAmount) > abs(verticalAmount) {
            // next card
            if (index < flashCards.endIndex - 1 && horizontalAmount < 0) {
                index = index + 1
                flipped = false
            }
            
            // previous card
            if (index > 0 && horizontalAmount > 0) {
                index = index - 1
                flipped = false
            }
        }
    }
    
    private func flipCard() {
        self.flipped = !self.flipped
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardNavigator(flipped: false, flashCards: [FlashCard()]).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
