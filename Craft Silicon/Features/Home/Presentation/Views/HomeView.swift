//
//  HomeView.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 25/01/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @State var weather: WeatherResponse?
    @State var forecast: ForecastResponse?
    @State var backgroundImage: String?
    @State var searchText: String = "Mombasa"
    
    var body: some View {
        NavigationView{
            VStack{
                SearchBar(search: $searchText)
                    .padding(.top,26)
                    .padding(.horizontal,20)
                
               
                ScrollView(showsIndicators: false){
                    switch weatherViewModel.state{
                    case .good:
                        if weatherViewModel.state != .isLoading{
                            LazyVStack(spacing: 0){
                              

                                VStack{
                                    let image = (weather?.weather.first?.main.contains("Clouds") == true ||
                                                 weather?.weather.first?.main.contains("Clear") == true) ? "test" : "rain"
                                        Image(image)
                                        .padding(.leading,16)
                                        .scaledToFit()
                                        .frame(width: 30,height: 30)
                                        .padding(.top,0)

                                    let tempMaxKelvin = weather?.main.temp ?? 0.0
                                    let tempMaxCelsius = tempMaxKelvin - 273.15
                                    Text("\(Int(tempMaxCelsius))°")
                                        .font(.system(size: 44, weight: .bold, design: .rounded))
                                        .foregroundColor(Color.white)
                                        .padding(.bottom,2)
                                        .padding(.top,56)

                                    Text("\(weather?.weather.first?.description ?? "")")
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .foregroundColor(Color.white)
                                    
                                    HStack{
                                        HStack{
                                            Text("Max:")
                                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                                .foregroundColor(Color.white)
                                                .padding(.bottom, 3)
                                               
                                            let tempMaxKelvin = weather?.main.tempMax ?? 0.0
                                            let tempMaxCelsius = tempMaxKelvin - 273.15
                                            Text("\(Int(tempMaxCelsius))°")
                                                .font(.system(size: 18, weight: .regular, design: .rounded))
                                                .foregroundColor(Color.white)
                                                .padding(.bottom, 3)
                                         
                                        }
                                        
                                        HStack{
                                            Text("Min:")
                                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                                .foregroundColor(Color.white)
                                                .padding(.bottom, 3)
                                                
                                            let tempMaxKelvin = weather?.main.tempMin ?? 0.0
                                            let tempMaxCelsius = tempMaxKelvin - 273.15
                                            Text("\(Int(tempMaxCelsius))°")
                                                .font(.system(size: 18, weight: .regular, design: .rounded))
                                                .foregroundColor(Color.white)
                                                .padding(.bottom, 3)
                                              
                                                
                                        }
                                        .padding(.leading, 10)
                                    
                                    }
                                    .padding(.bottom, 30)
                                    
                                    HStack{
                                        Spacer()

                                        HStack{
                                            Image("one")
                                            .scaledToFit()
                                            
                                            Text("\(weather?.main.humidity ?? 0)")
                                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                                .foregroundColor(Color.white)
                                                .padding(.bottom, 3)
                                        }
                                        Spacer()
                                        
                                        HStack{
                                            Image("two")
                                            .scaledToFit()
                                            Text("\(weather?.clouds.all ?? 0)")
                                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                                .foregroundColor(Color.white)
                                                .padding(.bottom, 3)
                                        }
                                        Spacer()

                                        HStack{
                                            Image("three")
                                            .scaledToFit()
                                            Text("\(String(format: "%.1f", weather?.wind.speed ?? 0.0)) km/h")
                                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                                .foregroundColor(Color.white)
                                                .padding(.bottom, 3)
                                        }
                                        Spacer()

                                    }
                                    
                                    .background(
                                        Image("groupone")
                                    )
                                    .padding(.bottom, 0)
                                    
                                    VStack{
                                        HStack{
                                            Text("Today")
                                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                                .foregroundColor(Color.white)
                                                .padding(.top, 20)
                                                .padding(.leading,30)

                                            
                                            let currentDate = Date()
                                            Spacer()
                                            Text("\(formattedDate(for: currentDate))")
                                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                                .foregroundColor(Color.white)
                                                .padding(.top, 20)
                                                .padding(.trailing,30)

                                        }
                                        Spacer()
                                        
                                        HStack{
                                            ForEach(forecast?.list.prefix(4) ?? [], id: \.dt) { data in
                                                   ZStack {
                                                       if isTimestampNearCurrentTime(data.dt) {
                                                           Image("cardweather")
                                                               .resizable()
                                                               .scaledToFill()
                                                               .clipped()
                                                       }
                                                       
                                                       VStack {
                                                           let tempMaxKelvin = data.main.tempMax ?? 0.0
                                                           let tempMaxCelsius = tempMaxKelvin - 273.15
                                                           Text("\(Int(tempMaxCelsius))°C")
                                                               .font(.system(size: 16, weight: .regular, design: .rounded))
                                                               .foregroundColor(Color.white)
                                                               .padding(.bottom, 10)
                                                           
                                                           let iconName = getWeatherIcon(for: data.weather.description)
                                                                   
                                                                   Image(iconName)
                                                               .resizable()
                                                                                                             .scaledToFill()
                                                                                                             .frame(maxWidth: 50,maxHeight: 50)
                                                           
                                                           Text("\(convertTimestampToTime(data.dt))")
                                                               .font(.system(size: 16, weight: .regular, design: .rounded))
                                                               .foregroundColor(Color.white)
                                                               .padding(.bottom, 10)
                                                       }
                                                       .padding()
                                                   }
                                                   .padding(.bottom, 14)
                                                   .cornerRadius(8)
                                                   .padding(.horizontal,1)
                                               }
                                           
                                        }
                                    }
                                    .padding()
                                    .background(
                                        Image("data")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: .infinity)
                                    )
                                    .padding(.top,10)
                                    
                                    VStack{
                                        HStack{
                                            Text("Next Forecast")
                                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                                .foregroundColor(Color.white)
                                                .padding(.top, 20)
                                                .padding(.leading,30)

                                            
                                            let currentDate = Date()
                                            Spacer()
                                            Text("\(formattedDate(for: currentDate))")
                                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                                .foregroundColor(Color.white)
                                                .padding(.top, 20)
                                                .padding(.trailing,30)

                                        }
                                        Spacer()
                                        
                                        VStack{
                                            ForEach(getNextThreeDaysForecast(from: forecast?.list ?? []), id: \.dt) { data in
                                                
                                                    HStack {
                                                        // Display the day (e.g., "Sunday")
                                                        Text("\(convertTimestampToDay(data.dt))")
                                                            .font(.system(size: 16, weight: .regular, design: .rounded))
                                                            .foregroundColor(Color.white)
                                                            .padding(.bottom, 20)
                                                        Spacer()
                                                        
                                                        let iconName = getWeatherIcon(for: data.weather.description)
                                                                
                                                                Image(iconName)
                                                                    .resizable()
                                                                    .scaledToFill()
                                                                    .frame(width: 40, height: 40)
                                                    
                                                        Spacer()
                                                        
                                                        HStack{
                                                            let tempMaxKelvin = data.main.tempMax ?? 0.0
                                                            let tempMaxCelsius = tempMaxKelvin - 273.15
                                                            Text("\(Int(tempMaxCelsius))°C")
                                                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                                                .foregroundColor(Color.white)
                                                                .padding(.bottom, 20)
                                                            
                                                            let tempMinKelvin = data.main.tempMin ?? 0.0
                                                            let tempMinCelsius = tempMinKelvin - 273.15
                                                            Text("\(Int(tempMinCelsius))°C")
                                                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                                                .foregroundColor(Color.white.opacity(0.5))
                                                                .padding(.bottom, 20)
                                                            
                                                        }

                                                       
                                                    }
                                                    .padding(.horizontal, 20)
                                                
                                                .cornerRadius(8)
                                            }
                                           
                                        }
                                    }
                                    .padding()
                                    .background(
                                        Image("data")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: .infinity)
                                    )
                                    .frame(maxWidth: UIScreen.main.bounds.width)

                                
                                }
                                .padding(.top,100)
                                .frame(maxWidth: .infinity, alignment: .center)
                            }

                        }

                        
                        
                    case .error(let errorMessage):
                        LocationError()
                        
                        
                    case .isLoading:
                        Text("")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                    case .noResults:
                        LocationError()

                    }
                    
                
             
                    
                }

            }
            .onAppear{
                Task{
                    await weatherViewModel.getWeather(city: searchText)
                    await weatherViewModel.getForecast(city: searchText)
                    
                     backgroundImage = (weather?.weather.first?.main.contains("Clouds") == true ||
                                           weather?.weather.first?.main.contains("Clear") == true) ? "front" : "back"

                    print("data is \(weather?.weather.first?.main)")
                }
                
            }
            .onChange(of: searchText){newValue in
                if  newValue.count >= 4{
                    Task{
                        await weatherViewModel.getWeather(city: newValue)
                        await weatherViewModel.getForecast(city: newValue)
                    }
                   
                }
            }
            
            .onChange(of: weather?.weather.first?.main){newValue in
                backgroundImage = (weather?.weather.first?.main.contains("Clouds") == true ||
                                      weather?.weather.first?.main.contains("Clear") == true) ? "front" : "back"
            }
            .onChange(of: weatherViewModel.weatherResponse){newValue in
                print("new value is \(newValue)")
                weather = newValue
            }
            .onChange(of: weatherViewModel.forecastResponse){newValue in
                print("new value is \(newValue)")
                forecast = newValue
            }
            .fullScreenProgressOverlay(
                isShowing: ( weatherViewModel.state == .isLoading),
                text: "Loading..."
            )
            .background(
                
                Image(backgroundImage ?? "")
                   .resizable()
                   .scaledToFill()
                   .ignoresSafeArea()
                   .frame(maxWidth: UIScreen.main.bounds.width,maxHeight: UIScreen.main.bounds.height)
            )
        }
    }
}

#Preview {
    HomeView()
}
