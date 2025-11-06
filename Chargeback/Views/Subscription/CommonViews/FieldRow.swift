import SwiftUI

struct FieldRow: View {
    let title: String
    let value: String
    var icon: String? = nil
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(AppFont.regular(size: 16))
                    .foregroundColor(AppColors.secondaryText)
                Spacer()
                if let icon = icon {
                    Image(icon)
                        .resizable()
                        .frame(width: 18, height: 18)
                }
                if title == AppConstants.startDateField {
                    Text(value)
                        .font(AppFont.regular(size: 16))
                        .foregroundColor(AppColors.primaryText)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 8)
                        .background(AppColors.fieldBackground)
                        .cornerRadius(8)
                } else {
                    Text(value)
                        .font(AppFont.regular(size: 16))
                        .foregroundColor(value == AppConstants.chooseService ? AppColors.buttonDisabledColor : AppColors.primaryText)
                        .overlay(
                               Rectangle()
                                   .frame(height: 1)
                                   .foregroundColor(
                                       title != AppConstants.amountField
                                       ? Color.clear
                                       : AppColors.primaryText
                                   )
                                   .offset(y: 6),
                               alignment: .bottom
                           )
                }
                if title != AppConstants.amountField && title != AppConstants.startDateField{
                    Image(AppImages.chevronUpDown)
                        .resizable()
                        .frame(width: 6, height: 12)
                }
            }
            .padding(.vertical, 12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
