The sigmoid function finds essential applications in AI chips, specialized hardware designed to accelerate artificial intelligence computations. The sigmoid function plays a vital role in AI chips by serving as an activation function, enabling binary classification, enhancing logistic regression, accelerating neural network training, and improving hardware efficiency. By efficiently computing sigmoid functions, AI chips significantly enhance AI applications' performance, speed, and energy efficiency in various domains. This sigmoid function uses the Zhang approximation proposed by  Zhang, Vassiliadis and Delgado–Frias. They have presented a second-order approximation scheme defined in the interval (-4, 4) that requires only one multiplier.   
Zhang, M., et all.: “Sigmoid generators for neural computing using piecewise approximations”, IEEE Trans. Comput., 45, (9), pp. 1045–1049, 1996.

$y= \frac{1}{2}((x/2^2)-1)^2$ for -4>x<0


$y=1- \frac{1}{2}((x/2^2)-1)^2$ for 4>x>0

**Module Documentation: Sigmoid Module**
Description: The Sigmoid Module is a combinational logic module that takes an 8-bit signed input and produces a 16-bit signed output. It performs a series of calculations to approximate the sigmoid function.


**Inputs:**
x (8-bit signed): The input value to the sigmoid module.

**Outputs:**
out (16-bit signed): The output value produced by the sigmoid module.



**Behavior:**
1. If the most significant bit x[7] is 1, indicating that x is negative, the input x is negated and stored in variable y. Otherwise, y is assigned the value of x.
2. The y value is right-shifted by 2 bits, and the result is stored in variable z.
3. The value of z is added to 240 (8'b1111_0000), and the result is stored in variable sum.
4. The value of sum is squared, and the result is stored in variable sq.
5. The value of sq is right-shifted by 1, and the result is stored in variable sh.
6. If x is negative (i.e., x[7] == 1'b1), the value of sh is assigned to the output variable out. Otherwise, out is assigned the value of 16'b00000001_00000000 minus sh.

**Usage:**
Instantiate the sigmoid module in your design and connect the input (x) and output (out) ports accordingly. Ensure that the input (x) is an 8-bit signed value, and the output (out) is a 16-bit signed value.
The output (out) will be updated whenever there is a change in the input (x). The sigmoid module performs calculations to approximate the sigmoid function, mapping the input range to the output range
Matlab generated


**Prompt used**
1. The sigmoid module takes an 8-bit signed input x and produces a 16-bit signed output out. 
2. Inside the module, there are several registers declared to hold intermediate values. 
3. The always @(*) block represents a combinational logic block that updates the output out whenever the inputs change. 
4. If the most significant bit x[7] is 1, it means x is negative, so y is assigned the negation of x. Otherwise, y is assigned x. The value of y is then right-shifted by 2 bits, storing the result in z. 
5. The value z is added to 8'b1111_0000 (240 in decimal) and stored in sum. 
6. The variable sum is squared, and the result is stored in sq. )The value of sq is right-shifted by 1, storing the result in sh. 
7. If x is negative (i.e., x[7] == 1'b1), the value of sh is assigned to out. Otherwise, out is assigned the value of 16'b0 0000001_00000000 minus sh.

The Schematic of  the  propsed architecure  is  shown  in  the Below figure.
![sigmoid](https://github.com/ajiiit/Sigmoid-Function/assets/63901666/2d117a2d-2bf1-4c52-b227-5283ecbe8b97)

Verification
All  the possible eight  bit  combinations of  input   are  verified.  Screenshot  od  Simulation  is  shown  below.


![sigmoid2](https://github.com/ajiiit/Sigmoid-Function/assets/63901666/e1e3f09f-e770-45f6-9b93-e3c8f150cd59).

To  validate  the   accuracy  of  the  model, simulation  results of   16 bit  eight  bit  precision are  compared  with  original infinite precision  sigmoid function in  Matlab. The  plot  is  shown  below.

![matlab_plot(1)](https://github.com/ajiiit/Sigmoid-Function/assets/63901666/966159a6-d225-4344-b65a-05fe41a46a06)

Maximum deviation, minimum  deviation  and average  deviaion  are  found  to be 0.0215, 0 and 10^(-4).




