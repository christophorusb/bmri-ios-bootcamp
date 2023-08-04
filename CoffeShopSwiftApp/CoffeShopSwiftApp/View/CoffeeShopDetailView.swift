//
//  EmojiDetailsView.swift
//  FindingEmoji
//
//  Created by laptop MCO on 03/08/23.
//

import SwiftUI

struct CoffeeShopDetailView: View {
    
    @State var dynamicWidth: CGFloat = 300
    @State var dynamicHeight: CGFloat = 300
    
    let coffeeShopDetails: Coffeeshop
    var body: some View {
        VStack{
            Image("\(coffeeShopDetails.image)")
                .resizable()
                .frame(width: dynamicWidth, height: dynamicHeight)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Spacer()
                .frame(height: 80)
            
            Text(coffeeShopDetails.name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.white)
                
            
            Text(coffeeShopDetails.location)
                .font(.system(size:18, design: .rounded))
                .lineSpacing(4)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                
            Divider()
                .background(Color.white)
            
            
            Text(coffeeShopDetails.review)
                .font(.system(size:18, design: .rounded))
                .lineSpacing(4)
                .multilineTextAlignment(.leading)
                .foregroundColor(.white)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom)
                )
        .edgesIgnoringSafeArea(.all)
    }
}

struct EmojiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeShopDetailView(coffeeShopDetails: Coffeeshop(image: "brewery", name: "El Lanevo Cafe", location: "Jakarta", review: "Unity heritage and modern concept and live music performance every weekend"))
    }
}
