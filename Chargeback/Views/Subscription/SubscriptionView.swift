import SwiftUI

struct SubscriptionView: View {
    @State private var showCreateSubscription = false
    var body: some View {
        VStack(spacing: 24) {
            Text(AppConstants.subscriptionsTitle)
                .font(AppFont.medium(size: 24))
                .foregroundColor(AppColors.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 40)
            Spacer()

            Image(AppImages.group)
                .resizable()
                .scaledToFit()
                .frame(width: 208, height: 160)

            VStack(spacing: 16) {
               Text(AppConstants.setupIncomplete)
                    .font(AppFont.medium(size: 20))
                    .foregroundColor(AppColors.primaryText)
                    .foregroundColor(.red)
                
                Text(AppConstants.subscriptionsGroupDescription)
                    .font(AppFont.regular(size: 16))
                    .foregroundColor(AppColors.secondaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Button(action: {
                showCreateSubscription = true
            }) {
                Text(AppConstants.completeSetupButton)
                    .font(AppFont.medium(size: 16))
                    .foregroundColor(.white)
                    .frame(width: 172, height: 50)
                    .background(AppColors.buttonColor)
                    .cornerRadius(16)
            }
            .buttonStyle(PlainButtonStyle())
            .fullScreenCover(isPresented: $showCreateSubscription) {
                CreateSubscriptionView()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
    }
}
