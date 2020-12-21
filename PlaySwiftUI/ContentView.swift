//
//  ContentView.swift
//  PlaySwiftUI
//
//  Created by apple on 2020/12/21.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State var count = 1;
    
    var body: some View {
        TabView{
            AView().tabItem {
                Text("Label 1")
            }.tag(1)
            
            BView().tabItem {
                Text("Label 2")
            }.tag(2)
            
            CView().tabItem {
                Text("Label 3")
            }.tag(3)

            DView().tabItem {
                Text("Label 4")
            }.tag(4)
//            ForEach(0 ..< 100){ i in
//                CView().tabItem {
//                    Text("Label 3")
//                }.tag(3)
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AView: View {
    @State var switch_togg = false
    var body: some View {

        List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
            Text("Tab Content \(item)").font(switch_togg ? /*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/ : .subheadline)
//            Spacer()
            Button(action:{
                doSomething()
            }){
                Text("Click me")
            }
        }
        
    }
    
    func doSomething(){
        withAnimation(.easeIn(duration: 5.0)){
            switch_togg.toggle()
        }
    }
}

struct BView: View {
    var body: some View {
        List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
            Text("Tab Content 2")
        }
    }
}


struct CView: View {
    var body: some View {
        Menu("Actions") {
            Button("Duplicate", action: {})
            Button("Rename", action: {})
            Button("Delete…", action: {})
            Menu("Copy") {
                Button("Copy", action: {})
                Button("Copy Formatted", action: {})
                Button("Copy Library Path", action: {})
            }
        }
    }
}

struct DView: View {
    @State var index = 1;
    
    var body: some View {
        VStack{
            PageView(selection:$index){
                ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    Text(String(item))
                }
            }
            Text(String(index)).font(.title)
//            Picker(selection: $index, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
//                /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
//                /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
//                Text("3").tag(3)
//                Text("4").tag(4)
//            }
        }
    }
}


struct PageView<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    @State private var selectionInternal: SelectionValue
    @Binding private var selectionExternal: SelectionValue
    private let indexDisplayMode: PageTabViewStyle.IndexDisplayMode
    private let indexBackgroundDisplayMode: PageIndexViewStyle.BackgroundDisplayMode
    private let content: () -> Content

    init(
        selection: Binding<SelectionValue>, //$index
        indexDisplayMode: PageTabViewStyle.IndexDisplayMode = .automatic,
        indexBackgroundDisplayMode: PageIndexViewStyle.BackgroundDisplayMode = .automatic,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._selectionInternal = .init(initialValue: selection.wrappedValue)
        self._selectionExternal = selection
        self.indexDisplayMode = indexDisplayMode
        self.indexBackgroundDisplayMode = indexBackgroundDisplayMode
        self.content = content
    }

    var body: some View {
        TabView(selection: $selectionInternal) {
            content()
        }
        .onChange(of: selectionInternal) {
            selectionExternal = $0
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: indexDisplayMode))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: indexBackgroundDisplayMode))
    }
}

extension PageView where SelectionValue == Int {
    init(
        indexDisplayMode: PageTabViewStyle.IndexDisplayMode = .automatic,
        indexBackgroundDisplayMode: PageIndexViewStyle.BackgroundDisplayMode = .automatic,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._selectionInternal = .init(initialValue: 0)
        self._selectionExternal = .constant(0)
        self.indexDisplayMode = indexDisplayMode
        self.indexBackgroundDisplayMode = indexBackgroundDisplayMode
        self.content = content
    }
}
