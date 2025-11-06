import SwiftUI

enum SubscriptionCategory: String, CaseIterable, Identifiable {
    case subscription = "Subscription"
    case utility = "Utility"
    case cardPayment = "Card Payment"
    case loan = "Loan"
    case rent = "Rent"
    var id: String { rawValue }
    var iconName: String {
        switch self {
        case .subscription: return "subscription_category"
        case .utility: return "utility_category"
        case .cardPayment: return "payment_category"
        case .loan: return "loan_category"
        case .rent: return "rent_category"
        }
    }
}

enum SubscriptionFrequency: String, CaseIterable, Identifiable {
    case weekly = "Weekly"
    case monthly = "Monthly"
    case annually = "Annually"
    var id: String { rawValue }
}

struct SubscriptionService: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let logoName: String
    let amount: String
}

struct SubscriptionModel {
    var service: SubscriptionService?
    var name: String
    var amount: String
    var category: SubscriptionCategory
    var startDate: Date
    var frequency: SubscriptionFrequency
    var isActive: Bool
}
