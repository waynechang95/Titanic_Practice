# TITANIC - MACHINE LEARNING FROM DIASATER ( R PRACTICE )
* Exploratory Data Analysis
  * Variables
* Data Processing
  * One-hot-encoding
  * Missing Value
  * Standardized
  * Pincipal Component Analysis
* Modeling
  * Logistic Regression
  * Decision Tree
  * Randon Forest
* Evaluation
* Result

## EXPLORATORY DATA ANALYSIS
### Variables
| Variable | Definition | Key | Class |
|:-----:|:------|:------|:------|
| Survival   |  是否存活  |   0 = No, 1 = Yes | int |
| pclass   |  船票等級  |   1 = 1st, 2 = 2nd, 3 = 3rd | int |
| sex   |  性別  |    | Factor |
| Age   |  年齡  |    | num |
| sibsp   |  兄弟或伴侶也在船上的數量  |    | int |
| parch   |  父母或子女也在船上的數量  |    | int |
| ticket   |  船票號碼  |    | Factor |
| fare   |  乘客費用  |    | num |
| cabin   |  船艙號碼  |    | Factor |
| embarked   |  登船的港口  |   C = Cherbourg, Q = Queenstown, S = Southampton | Factor |

* Continuous Variable: Age / sibsp / parch / fare

|  | Age | sibsp | parch | fare |
|---|:---:|:---:|:---:|:---:|
|Min.|0.42|0|0|0|
|1st Qu.|20.12|0|0|79.1|
|Median|28|0|0|14.45|
|Mean|29.7|0.523|0.382|32.2|
|3rd Qu.|38|1|0|31|
|Max.|80|8|6|512.33|
|NA's|177|0|0|0|

#### Age
![image](Boxplot/Rplot_Age_hist.jpeg)
![image](Boxplot/Rplot_Age_box.jpeg)
![image](Plot/Rplot_Age_Survived.jpeg)

年齡的分布趨近於常態分佈，平均年齡為29.7歲，在65歲以上的部分存在少數離群值，但整體來看不影響分布情形。
#### SibSp
![image](Boxplot/Rplot_SibSp_hist.jpeg)
![image](Boxplot/Rplot_SibSp_box.jpeg)
![image](Plot/Rplot_SibSp_Survived.jpeg)
#### Parch
![image](Boxplot/Rplot_Parch_hist.jpeg)
![image](Boxplot/Rplot_Parch_box.jpeg)
![image](Plot/Rplot_Parch_Survived.jpeg)
#### Fare
![image](Boxplot/Rplot_Fare_hist.jpeg)
![image](Boxplot/Rplot_Fare_box.jpeg)
![image](Plot/Rplot_Fare_Survived.jpeg)

兄弟或伴侶也在船上的數量、父母或子女也在船上的數量以及乘客費用的分布皆呈現右偏的情形，而在分別觀察存活人數及死亡人數的分布後，兩者間並沒有存在著明顯不同的分布。

* Categorical Variable : Survival / pclass / sex / ticket / cabin / embarked

#### Pclass

![image](Rplot_Pclass.jpeg)
#### Sex

![image](Rplot_Sex.jpeg)
#### Embarked

![image](Rplot_Embarked.jpeg)

#### Survival

![image](Rplot_Survived_Pclass.jpeg)

由各船票等級佔存活及死亡的人數比例當中可以發現，第三等級的人數佔整體人數超過一半，且死亡率相較於其他兩級有顯著的增加。

![image](Rplot_Survived_Sex.jpeg)

由各性別佔存活及死亡的人數比例當中可以發現，男性人數佔比超過一半，且男性的死亡率明顯高於女性。

![image](Rplot_Survived_Embarked.jpeg)

由各登船港口佔存活及死亡的人數比例當中可以發現，在Southampton登船的人數佔整體大約三分之二，但在各登船港口間的死亡率並無顯著不同。

## DATA PROCESSING
### One-Hot-Encoding

### Standardized


## MODELING

## EVALUATION

## RESULT

## REFERENCE
<https://www.kaggle.com/c/titanic/overview>


