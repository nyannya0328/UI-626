//
//  Home.swift
//  UI-626
//
//  Created by nyannyan0328 on 2022/08/02.
//

import SwiftUI

struct Home: View {
    @State var tools: [Tool] = [
            .init(icon: "scribble.variable", name: "Scribble", color: .purple),
            .init(icon: "lasso", name: "Lasso", color: .green),
            .init(icon: "plus.bubble", name: "Comment", color: .blue),
            .init(icon: "bubbles.and.sparkles.fill", name: "Enhance", color: .orange),
            .init(icon: "paintbrush.pointed.fill", name: "Picker", color: .pink),
            .init(icon: "rotate.3d", name: "Rotate", color: .indigo),
            .init(icon: "gear.badge.questionmark", name: "Settings", color: .yellow)
        ]
    @State var activeTool : Tool?
    @State var startedToolPostion : CGRect = .zero
    var body: some View {
        VStack{
            
            VStack(alignment: .leading) {
                
                ForEach($tools){$tool in
                    
                    
                    ToolView(tool: $tool)
                }
                
            }
            .padding(.vertical,12)
            .padding(.horizontal,10)
            .background{
             
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .fill(.white.shadow(.drop(color:.black.opacity(0.1),radius: 5,x: 5,y: 5)).shadow(.drop(color:.black.opacity(0.01) ,radius: 5,x: -5,y: -5)))
                
                    .frame(width:70)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
            }
            
              .coordinateSpace(name: "AREA")
              .gesture(
              
                  DragGesture()
                      .onChanged({ value in
                          
                          
                          guard let firstTool = tools.first else{return}
                          
                          if startedToolPostion == .zero{
                              
                              startedToolPostion = firstTool.toolPostion
                          }
                          
                          let location = CGPoint(x: startedToolPostion.midX, y: value.location.y)
                          
                          
                          if let index = tools.firstIndex(where: { tool in
                              
                              
                              tool.toolPostion.contains(location)
                          }),activeTool?.id != tools[index].id{
                              
                              withAnimation(.interactiveSpring(response: 1,dampingFraction: 1,blendDuration: 1)){
                                  
                                  
                                  activeTool = tools[index]
                              }
                              
                              print(index)
                              
                          }
                       
                          
                          
                      })
                      .onEnded({ value in
                          
                          withAnimation(.interactiveSpring(response: 1,dampingFraction: 1,blendDuration: 1)){
                              
                              
                              activeTool = nil
                              startedToolPostion = .zero
                          }
                          
                      })
              
              
              
              
              
              
              
              )
            
        }
  
        .padding(15)
        .padding(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
        
    }
    @ViewBuilder
    func ToolView(tool : Binding<Tool>)->some View{
        
        HStack(spacing:15){
            
            Image(systemName: tool.icon.wrappedValue)
                .font(.title2)
                 .frame(width: 50,height: 50)
                 .padding(.leading,activeTool?.id == tool.id ? 5 : 0)
                 .background{
                  
                     
                     GeometryReader{proxy in
                         
                         Color.clear

                             .preference(key:RectKey.self, value: proxy.frame(in: .named("AREA")))
                             .onPreferenceChange(RectKey.self) { rect in
                                 
                                 tool.wrappedValue.toolPostion = rect
                                 
                             }
                         
                     }
                 }
            
            if activeTool?.id == tool.id{
                Text(tool.name.wrappedValue)
                    .padding(.trailing,15)
                    .foregroundColor(.white)
                
            }
        }
        .background{
         
            RoundedRectangle(cornerRadius: 10,style: .continuous)
                .fill(tool.color.wrappedValue.gradient)
            
        }
        .offset(x:activeTool?.id == tool.wrappedValue.id ? 60 : 0)
        
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct RectKey : PreferenceKey{
    
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        
        value = nextValue()
    }
}
