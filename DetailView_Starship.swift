import SwiftUI



struct DetailView_Starship: View {
    let starship: Starships
    var body: some View {
        VStack(alignment: .leading){
            Text(starship.name)
                .font(.largeTitle)
                .bold()
            
            Rectangle()
                .frame(height: 2)
                .frame (maxWidth: .infinity)
                .foregroundColor(.gray)
            
            Group {
                HStack(alignment: .top) {
                    Text("model:")
                        .bold()
                    Text(starship.model)
                }
                
                HStack(alignment: .top){
                    Text("Mnaufacturer")
                        .bold()
                    Text(starship.manufacturer)
                }
                
                HStack(alignment: .top){
                    Text("cost:")
                        .bold()
                    Text(starship.cost_in_credits)
                }
                
                HStack(alignment: .top){
                    Text("lenght:")
                        .bold()
                    Text(starship.lenght)
                }
                
                HStack(alignment: .top){
                    Text("Max atmosphering speed")
                        .bold()
                    Text(starship.max_atmosphering_speed)
                    
                    Spacer()
                    
                    Text("crew:")
                        .bold()
                    Text(starship.crew)
                }
                
                HStack(alignment: .top){
                    Text("passengers:")
                        .bold()
                    Text(starship.passengers)
                }
                
                HStack(alignment: .top){
                    Text("capacity:")
                        .bold()
                    Text(starship.cargo_capacity)
                }
                
                HStack(alignment: .top){
                    Text("consumables:")
                        .bold()
                    Text(starship.consumables)
                }
                HStack(alignment: .top){
                    Text("hyperdrive rating:")
                        .bold()
                    Text(starship.hyperdrive_rating)
                }
                HStack(alignment: .top){
                    Text("MGLT:")
                        .bold()
                    Text(starship.MGLT)
                }
                
            }
            .font(.title2)
            
            VStack{
                HStack(alignment: .top){
                    Text("Class:")
                        .bold()
                    Text(starship.starship_class)
                }
                
                HStack(alignment: .top){
                    Text("pilots:")
                        .bold()
                    Text(starship.pilots)
                }
            }
            
            
            
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func returnStarshipURL() -> String {
        var newName = starship.name.replacingOccurrences(of: " ", with: "-")
        newName = newName.replacingOccurrences(of: "'", with: "")
        return "https://gallaugher.com/wp-content/uploads/2023/04/\(newName).jpg"
    }
}

struct DetailView_Starship_Previews: PreviewProvider {
    static var previews: some View {
        DetailView_Starship(starship: Starships(name: "Swifter", model: "", manufacturer: "Coder", cost_in_credits: "sentient", lenght: "83", max_atmosphering_speed: "175", crew: "Swift", passengers: "sentient", cargo_capacity: "175",consumables: "adwd" ,hyperdrive_rating: "Swift" ,MGLT: "ddaawd",starship_class: "Swift" ,pilots: "Swift"))
    }
}
