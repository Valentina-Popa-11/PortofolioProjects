# import pulp library as p
import pulp as p 
  
# Create a Linear Programming Minimization problem 
Lp_prob = p.LpProblem('Nurses', p.LpMinimize)  
  
# Create problem's Variables with a lower limit
d_1 = p.LpVariable("Monday_shift", lowBound = 0, cat='Integer')   # Create a variable Monday_shift >= 0 
d_2 = p.LpVariable("Tuesday_shift", lowBound = 0, cat='Integer')   # Create a variable Tuesday_shift >= 0 
d_3 = p.LpVariable("Wednesday_shift", lowBound = 0, cat='Integer') # Create a variable Wednesday_shift >= 0 
d_4 = p.LpVariable("Thursday_shift", lowBound = 0, cat='Integer') # Create a variable Thursday_shift >= 0 
d_5 = p.LpVariable("Friday_shift", lowBound = 0, cat='Integer') # Create a variable Friday_shift >= 0 
d_6 = p.LpVariable("Saturday_shift", lowBound = 0, cat='Integer') # Create a variable Saturday_shift >= 0 
d_7 = p.LpVariable("Sunday_shift", lowBound = 0, cat='Integer') # Create a variable Sunday_shift >= 0 

# Objective Function is add to Lp_prob variable
Lp_prob += d_1 + d_2 + d_3 + d_4 + d_5 + d_6 + d_7, "Minimum number of nurses"   
  
# Constraints: 
Lp_prob += d_1 + d_2 + d_3 + d_4 + d_5 >= 17, "Shift one Monday to Friday"
Lp_prob += d_2 + d_3 + d_4 + d_5 + d_6 >= 13, "Shift two Tuesday to Saturday"
Lp_prob += d_3 + d_4 + d_5 + d_6 + d_7 >= 15, "Shift three Wednesday to Sunday"
Lp_prob += d_4 + d_5 + d_6 + d_7 + d_1 >= 19, "Shift four Thursday to Monday"
Lp_prob += d_5 + d_6 + d_7 + d_1 + d_2 >= 14, "Shift five Friday to Tuesday"
Lp_prob += d_6 + d_7 + d_1 + d_2 + d_3 >= 10, "Shift six Saturday to Wednesday"
Lp_prob += d_7 + d_1 + d_2 + d_3 + d_4 >= 11, "Shift seven Sunday to Thursday"
  
# Display the problem 
print(Lp_prob) 

# solve the problem using pulp's choice of solver
status = Lp_prob.solve() 

# the solution status is displayed
print(p.LpStatus[status])  

# Printing the final solution 
print("Minimum number of nurses needed is: ", p.value(Lp_prob.objective))   



