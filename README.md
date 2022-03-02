# Titanic - Machine Learning from Disaster ( Practice )
* Data
  * Variables
  * Correlation
  * PCA
* Data Processing
  * One-hot-encoding
  * Standardized
* Modeling
  * Decision Tree
  * Randon Forest
* Evaluation
* Result

## DATA
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

* Categorical Variable : Survival / pclass / sex / ticket / cabin / embarked
  * Survival

  * Pclass

  * Sex

  * Embarked


### Correlation
X1 X2 X3
## Data Processing
### One-Hot-Encoding

### Standardized


`https://www.kaggle.com/c/titanic/overview`


