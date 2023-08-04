//
//  ContentView.swift
//  CoffeShopSwiftApp
//
//  Created by laptop MCO on 03/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var dynamicWidth: CGFloat = 70
    @State var dynamicHeight: CGFloat = 70
    
    @State private var isTapped = false
    @State private var rippleSize: CGFloat = 0
    
    private var coffeeShopData: [Coffeeshop]{
        let result = CoffeeshopProvider.all()
        
        return result
    }
    
    var body: some View {
        NavigationStack{
            List(coffeeShopData) {
                item in
                NavigationLink(
                    destination: {CoffeeShopDetailView(coffeeShopDetails: item)},
                    label: {
                        HStack{
                            Image("\(item.image)")
                                .resizable()
                                .frame(width: dynamicWidth, height: dynamicHeight)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            VStack(alignment: .leading, spacing: 20){
                                Text(item.name)
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(Color.accentColor)
                                HStack {
                                    Text("\(item.location)")
                                }
                            }
                            .padding()
                        }
                    })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

