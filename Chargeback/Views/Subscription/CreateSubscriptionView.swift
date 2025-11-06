import SwiftUI
import Combine

struct CreateSubscriptionView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = CreateSubscriptionViewModel()
    @State private var showCategoryPicker = false
    @State private var showDatePicker = false
    @State private var showFrequencyPicker = false
    @State private var showServicePicker = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(AppImages.closeCircle)
                            .resizable()
                            .frame(width: 44, height: 44)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                    Text(AppConstants.createSubscriptionTitle)
                        .font(AppFont.medium(size: 18))
                        .foregroundColor(AppColors.primaryText)
                    Spacer()
                    Button(action: {
                        Task {
                            await viewModel.saveSubscriptionWithDelay()
                        }
                    }) {
                        Text(AppConstants.saveButton)
                            .font(AppFont.medium(size: 18))
                            .foregroundColor(viewModel.isSaveEnabled ? AppColors.buttonColor : AppColors.buttonDisabledColor)
                    }
                    .disabled(!viewModel.isSaveEnabled)
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
                Button(action: { showServicePicker = true }) {
                    HStack(spacing: 16) {
                        if let service = viewModel.service {
                            Image(service.logoName)
                                .resizable()
                                .frame(width: 48, height: 48)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            VStack(alignment: .leading, spacing: 4) {
                                Text(service.name)
                                    .font(AppFont.medium(size: 18))
                                    .foregroundColor(AppColors.primaryText)
                                Text(service.amount)
                                    .font(AppFont.regular(size: 16))
                                    .foregroundColor(AppColors.lightTextColor)
                            }
                        } else {
                            Image(AppImages.plusCircle)
                                .resizable()
                                .frame(width: 48, height: 48)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(AppConstants.chooseService)
                                    .font(AppFont.regular(size: 18))
                                    .foregroundColor(AppColors.buttonDisabledColor)
                                Text(AppConstants.defaultAmount)
                                    .font(AppFont.regular(size: 16))
                                    .foregroundColor(AppColors.lightTextColor)
                            }
                        }
                        Spacer()
                    }
                    .padding(22)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
                    .padding(.horizontal, 20)
                    .padding(.top, 18)
                }
                
                VStack(spacing: 12) {
                    FieldRow(title: AppConstants.nameField, value: viewModel.name.isEmpty ? AppConstants.chooseService : viewModel.name, icon: viewModel.service?.logoName) {
                        showServicePicker = true
                    }
                    Divider()
                    FieldRow(title: AppConstants.amountField, value: viewModel.amount, icon: nil){}
                    Divider()
                    FieldRow(title: AppConstants.categoryField, value: viewModel.category?.rawValue ?? AppConstants.emptyString, icon: AppImages.subscriptionIcon) {
                        showCategoryPicker = true
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
                .padding(.horizontal, 20)
                .padding(.top, 18)

                VStack(spacing: 12) {
                    FieldRow(title: AppConstants.startDateField, value: viewModel.formattedDate(viewModel.startDate), icon: nil) {
                        showDatePicker = true
                    }
                    Divider()
                    FieldRow(title: AppConstants.frequencyField, value: viewModel.frequency.rawValue, icon: nil) {
                        showFrequencyPicker = true
                    }
                    Divider()
                    HStack {
                        Text(AppConstants.activeField)
                            .font(AppFont.regular(size: 16))
                            .foregroundColor(AppColors.secondaryText)
                        Spacer()
                        Toggle(AppConstants.emptyString, isOn: $viewModel.isActive)
                            .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                    }
                    .padding(.bottom, 4)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
                Spacer()
            }
            .background(AppColors.background)
            .sheet(isPresented: $showCategoryPicker) {
                CategoryPicker(
                    selected: $viewModel.category,
                    categories: SubscriptionCategory.allCases,
                    title: AppConstants.categoryPickerTitle,
                    doneButton: AppConstants.doneButton
                ) { category in
                    viewModel.category = category
                }
            }
            .sheet(isPresented: $showDatePicker) {
                DatePickerSheet(
                    selectedDate: $viewModel.startDate,
                    title: AppConstants.datePickerTitle,
                    doneButton: AppConstants.doneButton
                ) { date in
                    viewModel.startDate = date
                }
            }
            .sheet(isPresented: $showFrequencyPicker) {
                FrequencyPicker(
                    selected: $viewModel.frequency,
                    frequencies: SubscriptionFrequency.allCases,
                    title: AppConstants.frequencyPickerTitle,
                    doneButton: AppConstants.doneButton
                ) { frequency in
                    if let frequency = frequency {
                        viewModel.frequency = frequency
                    }
                }
            }
            .sheet(isPresented: $showServicePicker) {
                ServicePicker(selected: $viewModel.service, services: viewModel.services, title: AppConstants.servicePickerTitle, searchPlaceholder: AppConstants.searchPlaceholder, doneButton: AppConstants.doneButton) { service in
                    if let service = service {
                        viewModel.selectService(service)
                    }
                }
            }
            if viewModel.isLoading {
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
                ProgressView()
                    .scaleEffect(1.8)
                    .progressViewStyle(CircularProgressViewStyle(tint: AppColors.buttonColor))
            }
            if viewModel.showSuccessAlert {
                SuccessAlertView(
                    title: AppConstants.successAlertTitle,
                    buttonTitle: AppConstants.backToHomeButton,
                    isVisible: $viewModel.showSuccessAlert
                ) {
                    viewModel.showSuccessAlert = false
                    dismiss()
                }
            }
        }
    }
}
