//
//  ContentView.swift
//  Concurrency_Ditto
//
//  Created by laptop MCO on 07/08/23.
//

import SwiftUI

struct ContentView: View {
    // Instance of the Anime data service
    @StateObject var waifuDataService = WaifuDataService()
    @State private var searchText = ""
    
    var filteredWaifus: [Waifu] {
        if searchText.isEmpty {
            return waifuDataService.waifus
        } else {
            return waifuDataService.waifus.filter { waifu in
                waifu.name.lowercased().contains(searchText.lowercased()) ||
                waifu.anime.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            Text("Waifu List")
                .fontWeight(.bold)
                .font(.title2)
            VStack {
                if !waifuDataService.errorMessage.isEmpty {
                    Text("Error: \(waifuDataService.errorMessage)")
                        .foregroundColor(.red)
                }
                
                
                // A List that displays the fetched Animes
                List(filteredWaifus) { waifu in
                    // A VStack for each Anime in the List
                    VStack(alignment: .leading) {
                        HStack{
                            AsyncImage(url: URL(string: waifu.image)) { phase in
                                phase
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            } placeholder: {
                                // Displays a ProgressView while the image is loading
                                LoadingImageCard()
                            }
                            
                            VStack(alignment: .leading){
                                Text("\(waifu.name)")
                                    .fontWeight(.bold)
                                    .font(.title2)
                                Text("\(waifu.anime)")
                            }
                        }
                    }
                }
            }
            .onAppear {
                // Fetches the Animes when the ContentView appears
                waifuDataService.fetchWaifus(urlString: "https://waifu-generator.vercel.app/api/v1")
            }
        }
        .searchable(text: $searchText)
    }
}

enum APIError: String, Error {
    case noData = "Error: no data available"
    case networkError = "Error: encountered a network error"
    case decodingError = "Error: unable to decode data"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
