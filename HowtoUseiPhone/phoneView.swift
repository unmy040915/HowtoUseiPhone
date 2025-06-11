import SwiftUI

struct phoneView: View {
    @Binding var selectedTab : Int
    @Binding var task: String
    let names = ["山田太郎", "山田花子"]
    @State private var selectedName: String? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                TaskView(task: $task)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("連絡先")
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                        .padding(.leading, 20)
                        .bold()
                    
                    Divider()
                        .padding(.horizontal)
                        .padding(.top, 5)
                    
                    List {
                        Section(header:
                            Text("や")
                                .font(.title3)
                                .foregroundStyle(.gray)
                        ) {
                            ForEach(sortedNames, id: \.self) { name in
                                Button(action: {
                                    selectedName = name
                                }, label: {
                                    Text(name)
                                })
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.white)
                    .listStyle(PlainListStyle())
                    .listRowInsets(EdgeInsets())
                    .padding(.trailing)
                }
            }
            .navigationDestination(item: $selectedName) { name in
                hanakoView()
            }
        }
    }
    
    var sortedNames: [String] {
        names.sorted {
            $0.localizedStandardCompare($1) == .orderedAscending
        }
    }
}

#Preview {
    phoneView(selectedTab: .constant(3), task: .constant(""))
}

extension String: Identifiable {
    public var id: String { self }
}
