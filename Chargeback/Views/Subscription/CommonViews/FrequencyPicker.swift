import SwiftUI

struct FrequencyPicker: View {
    @Binding var selected: SubscriptionFrequency
    let frequencies: [SubscriptionFrequency]
    var title: String
    var doneButton: String
    var onSelect: (SubscriptionFrequency?) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var tempSelected: SubscriptionFrequency
    
    init(selected: Binding<SubscriptionFrequency>, frequencies: [SubscriptionFrequency], title: String, doneButton: String, onSelect: @escaping (SubscriptionFrequency?) -> Void) {
        self._selected = selected
        self.frequencies = frequencies
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
                    ForEach(Array(frequencies.enumerated()), id: \.offset) { index, frequency in
                        Button(action: { tempSelected = frequency }) {
                            HStack {
                                Text(frequency.rawValue)
                                    .font(AppFont.regular(size: 16))
                                    .foregroundColor(AppColors.primaryText)
                                Spacer()
                                if tempSelected == frequency {
                                    Image(AppImages.circleTicked)
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                }
                            }
                            .padding(.vertical, 20)
                            .padding(.horizontal, 20)
                        }
                        if index < frequencies.count - 1 {
                            Divider()
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .padding(.bottom, 8)
        }
        .background(Color.white)
        .presentationDetents([.fraction(0.3)])
    }
}
