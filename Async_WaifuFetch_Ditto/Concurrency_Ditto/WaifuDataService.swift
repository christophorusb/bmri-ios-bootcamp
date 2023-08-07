//
//  WaifuDataService.swift
//  Concurrency_Ditto
//
//  Created by laptop MCO on 07/08/23.
//
import Foundation

class WaifuDataService: ObservableObject {
    @Published var waifus = [Waifu]()
    @Published var errorMessage = "" // This will hold the error message if something goes wrong

    func fetchWaifus(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL."
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for error in the URLSession.shared.dataTask
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to get data: \(error.localizedDescription)"
                }
                return
            }
            
            // Check for valid HTTP response
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid response: \(httpResponse.statusCode)"
                }
                return
            }
            
            // Check if data was received
            if let data = data {
                do {
                    // Try to decode the received data
                    let decodedData = try JSONDecoder().decode([Waifu].self, from: data)
                    DispatchQueue.main.async {
                        // If the data is successfully decoded, assign it to the 'waifus' property
                        self.waifus = decodedData
                        self.errorMessage = "" // Clear the error message if the request was successful
                    }
                } catch {
                    // Handle parsing error
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to decode data: \(error)"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received."
                }
            }
        }
        task.resume()
    }
}



