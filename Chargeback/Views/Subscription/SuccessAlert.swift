import SwiftUI
struct SuccessAlertView: View {
    let title: String
    let buttonTitle: String
    @Binding var isVisible: Bool
    let onButtonTap: () -> Void

    @State private var presented = false
    @State private var pulse = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            VStack(spacing: 24) {
                Text(title)
                    .font(AppFont.medium(size: 20))
                    .foregroundColor(AppColors.primaryText)
                    .padding(.top, 32)
                    .opacity(presented ? 1 : 0)
                    .scaleEffect(presented ? 1.0 : 0.9)

                Image(AppImages.largeTick)
                    .resizable()
                    .frame(width: 90, height: 90)
                    .scaleEffect(pulse ? 1.15 : 0.9)
                    .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                               value: pulse)

                Button(action: onButtonTap) {
                    Text(buttonTitle)
                        .font(AppFont.medium(size: 18))
                        .foregroundColor(.white)
                        .frame(width: 172, height: 50)
                        .background(AppColors.buttonColor)
                        .cornerRadius(16)
                }
                .padding(.bottom, 32)
                .buttonStyle(PlainButtonStyle())
            }
            .frame(maxWidth: 300)
            .background(Color.white)
            .cornerRadius(24)
            .shadow(radius: 24)
            .opacity(presented ? 1 : 0)
            .scaleEffect(presented ? 1.0 : 0.85)
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                presented = true
            }
            pulse = true
        }
    }
}
