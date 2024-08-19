import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var isPushed : Bool = false
    @State private var searchText : String = ""
    var body: some View {
        TabView {
            NavigationStack {
                ScrollView(.vertical) {
                    VStack(spacing: -10, content: {
                        SegmentControlView()
                        LazyVStack(spacing: -10) {
                            ForEach(viewModel.data) { item in
                                DoctorCardView(docData: item, isPushed: $isPushed)
                            }
                        }
                    })
                }
                .navigationTitle("Педиатры")
                .navigationBarTitleDisplayMode(.inline)
                .frame(maxWidth: .infinity)
                .searchable(text: $searchText, prompt: "Look for you doc")
            }
            .tabItem {
                Image(systemName: "house")
                Text("Главная")
            }
            .onAppear() {
                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
                viewModel.getLocalDoctors()
            }
            
            Text("Receptions")
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Приёмы")
                }
            
            Text("Chat")
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Чат")
                }
                .badge(1)
            
            Text("Profile")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Профиль")
                }
        }
        .tint(.appPink)
    }
}

#Preview {
    MainView()
}
