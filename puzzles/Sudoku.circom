pragma circom 2.1.6;

//Puzzle 20: Sudoku Solver
include "circomlib/comparators.circom";
//gist: https://gist.github.com/0kage-eth/9aad3cd682874088824d7c11b53f6ff2
template Multiply() {

    signal input a;
    signal input b;

    signal output c;

    c <== a*b;
}

template ValidSudokuNumber() {

    signal input val;
    
    component equalChk1 = IsEqual();
    equalChk1.in[0] <== val;
    equalChk1.in[1] <== 1;

    component equalChk2 = IsEqual();
    equalChk2.in[0] <== val;
    equalChk2.in[1] <== 2;

    component equalChk3 = IsEqual();
    equalChk3.in[0] <== val;
    equalChk3.in[1] <== 3;

    component equalChk4 = IsEqual();            
    equalChk4.in[0] <== val;
    equalChk4.in[1] <== 4;

    equalChk1.out + equalChk2.out + equalChk3.out + equalChk4.out === 1; // value has to be one of 1/2/3/4
}

template CheckUnique(N) {
    signal input a[N];
    signal output out;

    component equalChk[N*(N-1)/2];

    var indx = 0;
    var outVal =1;

    for(var i=0; i<N; i++){
        for(var j=i+1; j<N; j++){
            equalChk[indx] = IsEqual();
            equalChk[indx].in[0] <== a[i];
            equalChk[indx].in[1] <== a[j];
            outVal *= (1 - equalChk[indx].out);
            indx ++;
        }
    }

    component eqChk = IsEqual();
    eqChk.in[0] <-- outVal;
    eqChk.in[1] <-- 1;

    out <== eqChk.out; // out = 1 if all elements are unique, 0 otherwise
}

/*
    Given a 4x4 sudoku board with array signal input "question" and "solution", check if the solution is correct.

    "question" is a 16 length array. Example: [0,4,0,0,0,0,1,0,0,0,0,3,2,0,0,0] == [0, 4, 0, 0]
                                                                                   [0, 0, 1, 0]
                                                                                   [0, 0, 0, 3]
                                                                                   [2, 0, 0, 0]

    "solution" is a 16 length array. Example: [1,4,3,2,3,2,1,4,4,1,2,3,2,3,4,1] == [1, 4, 3, 2]
                                                                                   [3, 2, 1, 4]
                                                                                   [4, 1, 2, 3]
                                                                                   [2, 3, 4, 1]

    "out" is the signal output of the circuit. "out" is 1 if the solution is correct, otherwise 0.                                                                               
*/


template Sudoku () {
    // Question Setup 
    signal input  question[16];
    signal input solution[16];
    signal output out;
    
    // Checking if the question is valid
    for(var v = 0; v < 16; v++){
        log(solution[v],question[v]);
        assert(question[v] == solution[v] || question[v] == 0); //@note known points of puzzle, question must match solution
    }
    
    var m = 0 ;
    component row1[4];
    for(var q = 0; q < 4; q++){
        row1[m] = IsEqual();
        row1[m].in[0]  <== question[q];
        row1[m].in[1] <== 0;
        m++;
    }
    3 === row1[3].out + row1[2].out + row1[1].out + row1[0].out; //@note checks there are 3 zeroes in row 1 of question

    m = 0;
    component row2[4];
    for(var q = 4; q < 8; q++){
        row2[m] = IsEqual();
        row2[m].in[0]  <== question[q];
        row2[m].in[1] <== 0;
        m++;
    }
    3 === row2[3].out + row2[2].out + row2[1].out + row2[0].out; //@note checks there are 3 zeroes in row 2 of question

    m = 0;
    component row3[4];
    for(var q = 8; q < 12; q++){
        row3[m] = IsEqual();
        row3[m].in[0]  <== question[q];
        row3[m].in[1] <== 0;
        m++;
    }
    3 === row3[3].out + row3[2].out + row3[1].out + row3[0].out; //@note checks there are 3 zeroes in row 3 of question

    m = 0;
    component row4[4];
    for(var q = 12; q < 16; q++){
        row4[m] = IsEqual();
        row4[m].in[0]  <== question[q];
        row4[m].in[1] <== 0;
        m++;
    }
    3 === row4[3].out + row4[2].out + row4[1].out + row4[0].out; //@note checks there are 3 zeroes in row 4 of question

    // Write your solution from here.. Good Luck!

    // first check validity of numbers in solution
    component validVals[16];
    for(var i =0; i<16; i++){
        validVals[i] = ValidSudokuNumber();
        validVals[i].val <== solution[i];
    } // this checks if all the values in solution array are legit 

    // next check rows/columns and 2*2 boxes add upto 10
    signal row_sum[4]; // checks row sum for 4 rows
    signal col_sum[4]; // checks col sum for 4 columns
    signal box_sum[4]; // checks box sum for 4 non-overlapping boxes
    // @note there are technically 9 ((N-1)*(N-1) for 4 number sudoku) 2*2 boxes. But checking for all 9 is not necessary
    // @note checking for 4 non-overlapping boxes will cover each of the 16 boxes

    signal row_vals[4][4]; // row values needed to check for uniqueness
    signal col_vals[4][4]; // row values needed to check for uniqueness

    component row_sum_chk[4];
    component col_sum_chk[4];
    component box_sum_chk[4];    

    component unique_row_chk[4];
    component unique_col_chk[4];
  
    // 1. each row -> values should be unique and sum should add to 10
    for(var row_indx =0; row_indx < 4; row_indx++){    
        var rowSum = 0;

        for (var col_indx=0; col_indx < 4; col_indx++){
            rowSum += solution[row_indx*4 + col_indx ];
            row_vals[row_indx][col_indx] <-- solution[row_indx*4 + col_indx ];
        }

        unique_row_chk[row_indx] = CheckUnique(4);
        unique_row_chk[row_indx].a <== row_vals[row_indx];

        row_sum[row_indx] <== rowSum;
        row_sum_chk[row_indx] = IsEqual();
        row_sum_chk[row_indx].in[0] <== row_sum[row_indx];
        row_sum_chk[row_indx].in[1] <== 10;
    }

    // 2. each column -> sum should add to 10
    for(var col_indx =0; col_indx < 4; col_indx++){    
        var colSum = 0;
        
        for (var row_indx=0; row_indx < 4; row_indx++){
            colSum += solution[col_indx + row_indx*4];
            col_vals[col_indx][row_indx] <-- solution[col_indx + row_indx*4];            
        }

        unique_col_chk[col_indx] = CheckUnique(4);
        unique_col_chk[col_indx].a <== col_vals[col_indx];

        col_sum[col_indx] <== colSum;
        col_sum_chk[col_indx] = IsEqual();
        col_sum_chk[col_indx].in[0] <== col_sum[col_indx];
        col_sum_chk[col_indx].in[1] <== 10;
    }

    // 3. box sum -> sums the 4 non overlapping boxes
        var boxSum0 = solution[0] + solution[1] + solution[4] + solution[5];
        var boxSum1 = solution[2] + solution[3] + solution[6] + solution[7];
        var boxSum2 = solution[8] + solution[9] + solution[12] + solution[13];        
        var boxSum3 = solution[10] + solution[11] + solution[14] + solution[15];        

        box_sum_chk[0] = IsEqual();
        box_sum_chk[0].in[0] <== boxSum0;
        box_sum_chk[0].in[1] <== 10;

        box_sum_chk[1] = IsEqual();
        box_sum_chk[1].in[0] <== boxSum1;
        box_sum_chk[1].in[1] <== 10;        

        box_sum_chk[2] = IsEqual();
        box_sum_chk[2].in[0] <== boxSum2;
        box_sum_chk[2].in[1] <== 10;        

        box_sum_chk[3] = IsEqual();
        box_sum_chk[3].in[0] <== boxSum3;
        box_sum_chk[3].in[1] <== 10;                



    var colOutput =1;
    var rowOutput =1;
    var boxOutput =1;

    var uniqueColOutput = 1;
    var uniqueRowOutput = 1;    

    for(var indx=0; indx<4;indx++){
        rowOutput *= row_sum_chk[indx].out;
        colOutput *= col_sum_chk[indx].out;        
        boxOutput *= box_sum_chk[indx].out;
        uniqueColOutput *= unique_col_chk[indx].out;                
        uniqueRowOutput *= unique_row_chk[indx].out;                        
    }

    component mul = Multiply();
    mul.a <-- rowOutput;
    mul.b <-- colOutput;

    component mul2 = Multiply();
    mul2.a <-- mul.c;
    mul2.b <-- boxOutput;

    component mul3 = Multiply();
    mul3.a <-- mul2.c;
    mul3.b <-- uniqueRowOutput;

    component mulFinal = Multiply();
    mulFinal.a <-- mul3.c;
    mulFinal.b <-- uniqueColOutput;



    out <== mulFinal.c;
}


component main = Sudoku();

/*
INPUT = {
    "question": ["0","4","0","0","0","0","1","0","0","0","0","3","2","0","0","0"],
    "solution": ["1","4","3","2","3","2","1","4","4","1","2","3","2","3","4","1"]    
}
*/