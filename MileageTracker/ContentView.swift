//
//  ContentView.swift
//  MileageTracker
//
//  Created by Sarthak Agrawal on 03/09/24.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MileageViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Add New Entry")) {
                        DatePicker("Select Date", selection: $viewModel.selectedDate, displayedComponents: .date)
                            .datePickerStyle(CompactDatePickerStyle())
                        
                        TextField("Kilometers", text: $viewModel.currentKilometers)
                            .keyboardType(.decimalPad)
                            .inputAccessoryView {
                                KeyboardToolbar {
                                    hideKeyboard() // Call this function to dismiss the keyboard
                                }
                            }
                        TextField("Petrol in Liters", text: $viewModel.currentPetrol)
                            .keyboardType(.decimalPad)
                        
                        Button(action: viewModel.addEntry) {
                            Text("Add Entry")
                        }
                    }
                }
                Section(header: Text("Mileage Entries")) {
                    List(viewModel.entries) { entry in
                        HStack {
                            Text(formatDate(entry.date))
                            Spacer()
                            Text("\(entry.kilometers, specifier: "%.0f") km")
                            Spacer()
                            Text("\(entry.petrolLiters, specifier: "%.2f") L")
                            Spacer()
                            if let mileage = entry.mileageData.mileage {
                                Text("\(mileage, specifier: "%.2f") kmpl")
                                    .foregroundColor(Color(entry.mileageData.mileageComparisonFromPrevMileage.color)) 
                                    .frame(width: 90, alignment: .leading)
                            } else {
                                Text("-")
                                    .frame(width: 90, alignment: .leading)
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                withAnimation {
                                    viewModel.deleteEntry(entry)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                                    .labelStyle(.iconOnly)
                            }
                            .tint(.red) // Set the background color of the delete button
                        }
                    }
                }
                .navigationTitle("Mileage Tracker")
            }
//            .dismissKeyboardOnTap()
        }
    }
    
    private func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}

struct KeyboardToolbar: UIViewRepresentable {
    var doneAction: (() -> Void)?

    func makeUIView(context: Context) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: context.coordinator, action: #selector(Coordinator.doneTapped))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: false)

        return toolbar
    }

    func updateUIView(_ uiView: UIToolbar, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(doneAction: doneAction)
    }

    class Coordinator: NSObject {
        var doneAction: (() -> Void)?

        init(doneAction: (() -> Void)?) {
            self.doneAction = doneAction
        }

        @objc func doneTapped() {
            doneAction?()
        }
    }
}
extension View {
    func inputAccessoryView<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
        self.background(UIViewControllerWrapper(content: content()))
    }
}

struct UIViewControllerWrapper<Content: View>: UIViewControllerRepresentable {
    let content: Content

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.backgroundColor = .clear
        viewController.addChild(hostingController)
        viewController.view.addSubview(hostingController.view)
        hostingController.view.frame = viewController.view.bounds
        hostingController.didMove(toParent: viewController)
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

#Preview {
    ContentView()
}
