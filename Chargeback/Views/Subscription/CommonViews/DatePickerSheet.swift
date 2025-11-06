import SwiftUI

struct DatePickerSheet: View {
    @Binding var selectedDate: Date
    var title: String
    var doneButton: String
    var onSelect: (Date) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var tempSelected: Date
    
    init(selectedDate: Binding<Date>, title: String, doneButton: String, onSelect: @escaping (Date) -> Void) {
        self._selectedDate = selectedDate
        self.title = title
        self.doneButton = doneButton
        self.onSelect = onSelect
        _tempSelected = State(initialValue: selectedDate.wrappedValue)
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
            DatePicker(AppConstants.emptyString, selection: $tempSelected, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding(.horizontal, 20)
                .padding(.top, 16)
            Spacer()
        }
        .background(Color.white)
        .presentationDetents([.fraction(0.4)])
    }
}
