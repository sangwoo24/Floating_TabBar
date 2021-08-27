# Floating TabBar

    1. 구조
    2. Properties
    3. 예제


<br><br><br>

<div align="center">
          
<img src=https://images.velog.io/images/sangwoo24/post/3b920c9e-56ea-432f-97de-d8647def0648/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202021-08-17%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%204.11.19.png width = "200">

<h4> 사진과 같이 Custom 가능한 Floating TabBar 를 만들어보기</h4></div>

<br><br><br>

## 1. 구조

<div align = "center">
<img src = https://user-images.githubusercontent.com/56511253/129684570-b006d98d-2472-4559-86b2-77bfbd26df08.jpeg height = "300"></div><br>

- TabBar는 ViewController 하나로 구성
- TabBarVC 내부에는 상단 헤더부분의 뷰를 담당하는 `Header`, TabBar Menu Item 들과 Indicator View 를 보여주는 `TabBarMenu`, 각각의 Tab 에 맞는 ViewController 를 보여주기 위한 하단의 `Page` 가 있다.
- TabBar 로 입력되는 ViewController 들의 Title 로 TabBarMenu의 ItemTitle 이 정해진다.
<br><br>

### Header
- 사용하는 개발자가 유연하게 사용할 수 있게 공백의 View 로 설정함.
<br><br>

### TabBarMenuView
- Menu View 에는 각 Tab Item 을 보여주기 위해 UICollectionView를 사용했으며, Indicator 를 보여주기 위해 UIView 를 사용했다.
<br><br>

### PageView
- PageView 는 따로 UIView 로 빼지 않고 TabBarController 에 직접적으로 연결되도록 사용하였고, 각 Page 들은 Scroll, 혹은 Tab 을 이용해 UICollectionView로 화면을 전환한다.
<br><br><br>

## 2. Properties
- tabBarViewControllers: [UIVIewController]
- tabBarHeaderView: UIView
- tabBarMenuTextColor: UIColor
- tabBarIndicatorBackgroundColor: UIColor
<br><br>

## 3. 예제
<br>

#### Default TabBar

<div align="center">
<img src="https://user-images.githubusercontent.com/56511253/131085987-c06e1d5e-ac1c-4b10-9d01-125f59e9c656.gif"></div>
<br>

```swift
let tabBar = CustomTabBarViewController()

let firstVC = FirstViewController()
let secondVC = SecondViewController()
let thirdVC = ThirdViewController()

firstVC.title = "First"
secondVC.title = "Second"
thirdVC.title = "Third"

tabBar.tabBarViewControllers = [firstVC, secondVC, thirdVC]
```
- 해당 Tab 의 제목은 ViewController 의 title 로 지정함.
<br><br><br>

#### HeaderView

<div align="center">
<img src="https://user-images.githubusercontent.com/56511253/131087453-7bbd6666-50e7-4c30-b0e6-b7a9cf7fd609.png" width = "300"></div>

```swift
let testView = UIView()
testView.backgroundColor = .red

let testLabel = UILabel()
testLabel.text = "Text Label"
testLabel.textColor = .white
testLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
testLabel.translatesAutoresizingMaskIntoConstraints = false

testView.addSubview(testLabel)
testLabel.centerXAnchor.constraint(equalTo: testView.centerXAnchor).isActive = true
testLabel.centerYAnchor.constraint(equalTo: testView.centerYAnchor).isActive = true

tabBar.tabBarHeaderView = testView
```
<br><br>
#### Tint Color

<div align = "center">
<img src = "https://user-images.githubusercontent.com/56511253/131104721-7a069040-affd-40c0-9026-d116a6d8fca9.png"></div>
<br>

```swift
tabBar.tabBarMenuTextColor = .blue
tabBar.tabBarIndicatorBackgroundColor = .green
```