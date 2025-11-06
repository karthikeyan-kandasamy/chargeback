import Foundation
import Combine
import SwiftUI

class CreateSubscriptionViewModel: ObservableObject {
    @Published var service: SubscriptionService? = nil
    @Published var name: String = ""
    @Published var amount: String = "$0"
    @Published var category: SubscriptionCategory? = .subscription
    @Published var startDate: Date = Date()
    @Published var frequency: SubscriptionFrequency = .weekly
    @Published var isActive: Bool = true
    @Published var isSaveEnabled: Bool = false
    @Published var isLoading: Bool = false
    @Published var showSuccessAlert: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    var services: [SubscriptionService] {
        return self._services
    }
    
    private let _services: [SubscriptionService] = [
        SubscriptionService(name: "Netflix", logoName: "netflix_logo", amount: "$15"),
        SubscriptionService(name: "Hulu", logoName: "hulu_logo", amount: "$12"),
        SubscriptionService(name: "Spotify", logoName: "spotify_logo", amount: "$10"),
        SubscriptionService(name: "PlayStation+", logoName: "playstation_logo", amount: "$20"),
        SubscriptionService(name: "Paramount+", logoName: "paramount_logo", amount: "$8"),
        SubscriptionService(name: "YouTube Music", logoName: "youtube_logo", amount: "$9")
    ]
    
    init() {
        setupValidation()
    }
    
    private func setupValidation() {
        Publishers.CombineLatest3($service, $name, $amount)
            .map { service, name, amount in
                service != nil && !name.trimmingCharacters(in: .whitespaces).isEmpty && !amount.trimmingCharacters(in: .whitespaces).isEmpty
            }
            .assign(to: &$isSaveEnabled)
    }
    
    /// Simulates a dummy API call to save the subscription
    @MainActor
    func saveSubscriptionWithDelay() async {
        isLoading = true
        // Simulate network delay (dummy API call)
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        isLoading = false
        showSuccessAlert = true
        // Call actual save logic if needed
    }
    
    func selectService(_ service: SubscriptionService) {
        self.service = service
        self.name = service.name
        self.amount = service.amount
    }
    
    func clearService() {
        self.service = nil
        self.name = ""
        self.amount = "$0"
    }
}

extension CreateSubscriptionViewModel {
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
