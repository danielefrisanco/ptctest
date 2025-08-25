# ptctest
Acme Widget Co  
Acme Widget Co are the leading provider of made up widgets and they’ve contracted you to  create a proof of concept for their new sales system.  
They sell three products – 
Product 
Code 
Price
Red Widget 
R01 
$32.95
Green Widget 
G01 
$24.95
Blue Widget 
B01 
$7.95

To incentivise customers to spend more, delivery costs are reduced based on the amount  spent. Orders under $50 cost $4.95. For orders under $90, delivery costs $2.95. Orders of $90 or more have free delivery.  
They are also experimenting with special offers. The initial offer will be “buy one red widget, get the second half price”.  
Your job is to implement the basket which needs to have the following interface – 
It is initialised with the product catalogue, delivery charge rules, and offers (the format of how these are passed it up to you)  
It has an add method that takes the product code as a parameter.
It has a total method that returns the total cost of the basket, taking into account  the delivery and offer rules. 
Here are some example baskets and expected totals to help you check your  implementation.  
Products 
Total
B01, G01 
$37.85
R01, R01 
$54.37
R01, G01 
$60.85
B01, B01, R01, R01, R01 
$98.27


What we expect to see – 
A solution written in easy to understand Ruby code 
A README file explaining how it works and any assumptions you’ve made
Pushed to a public Github repo 



# Assumptions
- No Database
- Initialize with hash data
- On the same product you can get a single offer, and on a discounted product you cannot get an offer
- The final total is truncated
- Delivery charge is otherwise 0

# Explanation
The code is divided in data models, offer strategies and the basket class

## Data models
Contains the data and its logic
### Product
The product is just a container for the product data
### Catalogue
It contains the list of products and the logic to search them
### Delivery charge rule
It contains the logic to calculate the charge according to the rules passed

## Offers
One class for each type of offer that holds its own logic and it is independent from the data
Every new kind of offer will need a new class.

## Basket
Given a possible catalogue, the offers to apply to it and the delivery charge rule it manages the list of products added and calculates the total.
The logic for calculation of offers and delivery charge is not in this class

# Explanation
If an offer or the delivery charge is changed the basket does not get affected.

Classes are small and the public interfaces are minimal

The basket have dependencies that are passed in the initialize, so different baskets can be created with different set of offers and catalogues and delivery charges.

The offers are strategies that the basket uses, so you can create new offers and delivery rules to change the behaviour of the basket.


# TEST

```bash
# Install dependencies
bundle install
# Run tests
rspec
```

# RUN

You can try it this way 
```bash
ruby init.rb 
```
