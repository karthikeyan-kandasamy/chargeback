import SwiftUI

struct ServicePicker: View {
    @Binding var selected: SubscriptionService?
    let services: [SubscriptionService]
    var title: String
    var searchPlaceholder: String
    var doneButton: String
    var onSelect: (SubscriptionService?) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = AppConstants.emptyString
    var filteredServices: [SubscriptionService] {
        if searchText.isEmpty { return services }
        return services.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Capsule()
                    .fill(AppColors.dividerColor)
                    .frame(width: 38, height: 6)
                    .padding(.top, 8)
                    .padding(.bottom, 8)

                ZStack {
                    Text(title)
                        .font(AppFont.medium(size: 18))
                        .foregroundColor(AppColors.primaryText)

                    HStack {
                        Spacer()
                        Button(doneButton) {
                            onSelect(selected)
                            dismiss()
                        }
                        .font(AppFont.medium(size: 18))
                        .foregroundColor(AppColors.buttonColor)
                        .padding(.trailing, 20)
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(height: 44)
            }
            HStack {
                Image(systemName: AppImages.searchSystemIcon)
                    .foregroundColor(AppColors.secondaryText)
                    .padding(.leading, 20)
                TextField(searchPlaceholder, text: $searchText)
                    .font(AppFont.regular(size: 16))
                    .foregroundColor(AppColors.secondaryText)
            }
            .frame(height: 44)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(AppColors.buttonColor), lineWidth: 1)
            )
            .shadow(color: AppColors.shadowColor, radius: 8, x: 0, y: 0)
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 16)
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(filteredServices.enumerated()), id: \.offset) { index, service in
                        VStack(spacing: 0) {
                            Button(action: {
                                selected = service
                            }) {
                                HStack {
                                    Image(service.logoName)
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .padding(.trailing, 8)
                                    Text(service.name)
                                        .font(AppFont.regular(size: 16))
                                        .foregroundColor(AppColors.primaryText)
                                    Spacer()
                                    if selected == service {
                                        Image(AppImages.circleTicked)
                                            .resizable()
                                            .frame(width: 18, height: 18)
                                    }
                                }
                                .padding(.vertical, 14)
                                .padding(.horizontal, 20)
                                .frame(maxWidth: .infinity)
                            }
                            if index < filteredServices.count - 1 {
                                Divider()
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 8)
        }
        .background(Color.white)
    }
}
