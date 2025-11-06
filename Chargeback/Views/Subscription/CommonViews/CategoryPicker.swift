import SwiftUI

struct CategoryPicker: View {
    @Binding var selected: SubscriptionCategory?
    let categories: [SubscriptionCategory]
    var title: String = AppConstants.emptyString
    var doneButton: String
    var onSelect: (SubscriptionCategory?) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var tempSelected: SubscriptionCategory?
    init(selected: Binding<SubscriptionCategory?>, categories: [SubscriptionCategory], title: String = AppConstants.emptyString, doneButton: String, onSelect: @escaping (SubscriptionCategory?) -> Void) {
        self._selected = selected
        self.categories = categories
        self.title = title
        self.doneButton = doneButton
        self.onSelect = onSelect
        _tempSelected = State(initialValue: selected.wrappedValue)
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
                            onSelect(tempSelected)
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
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(categories.enumerated()), id: \.offset) { index, category in
                        CategoryRow(
                            category: category,
                            isSelected: tempSelected == category,
                            onTap: { tempSelected = category }
                        )
                        if index < categories.count - 1 {
                            Divider()
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .padding(.bottom, 8)
        }
        .background(Color.white)
        .presentationDetents([.fraction(0.5)])
    }
}

struct CategoryRow: View {
    let category: SubscriptionCategory
    let isSelected: Bool
    let onTap: () -> Void
    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(category.iconName)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(.trailing, 8)
                Text(category.rawValue)
                    .font(AppFont.regular(size: 16))
                    .foregroundColor(AppColors.primaryText)
                Spacer()
                if isSelected {
                    Image(AppImages.circleTicked)
                        .resizable()
                        .frame(width: 18, height: 18)
                }
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
        }
    }
}
