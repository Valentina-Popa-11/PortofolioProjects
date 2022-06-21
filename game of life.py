LIVING_CELL = '1'
DEAD_CELL = '.'

#Get the alive cells from the user
def getBoard(rows, cols, boardList):
   myList = [[0]*cols for i in range(rows)]

   while True:

        aliveRows = input("Please enter a row of a cell to turn on (or q to exit): ")
        if aliveRows == 'q':
            break
        aliveCols = input("Please enter a column for that cell: ")
        print()
        myList[int(aliveRows)][int(aliveCols)] = 1
   return myList

#next board cells
def getNxtIter(cols, rows, cur, nxt):
    for i in range(rows):
        for j in range(cols):
            nxt[i][j] = getNeighbors(i, j, cur)

def getNeighbors(x, y, boardList):
    rows, cols = len(boardList), len(boardList[0])
    nCount = 0
    for j in range(y-1,y+2):
        for i in range(x-1,x+2):
            if not(i == x and j == y):
                itest, jtest = i, j
                if itest == rows:
                    itest = 0
                if jtest == cols:
                    jtest = 0
                nCount += boardList[itest][jtest]
    if boardList[x][y] == 1 and nCount < 2:
        return 0
    if boardList[x][y] == 1 and nCount == 3:
       return 1
    if boardList[x][y] == 1 and nCount == 2:
       return 1
    if boardList[x][y] == 1 and nCount > 3:
        return 0
    if boardList[x][y] == 0 and nCount == 3:
        return 1
    else:
        return boardList[x][y]

#Printing and forming the actual board
def printBoard(cols, rows, boardList):
    for i in range(rows):
        for j in range(cols):
            if boardList[i][j] == -1:
                print(DEAD_CELL, end=" ")
            elif boardList[i][j] == 1:
                print(LIVING_CELL, end=" ")
            else:
               print(DEAD_CELL, end=" ")
        print()

def main():
#Getting and validating the number of rows and columns
    r = 1
    while r ==1:

        rows = int(input("Please enter the number of rows: "))
        if rows < 0:
            print("Number of rows sould be greater than 0.")
            r = 1
        elif rows> 50:
            print("Number of rows should be less than 50")
            r = 1
        else:
            r =0

    c = 1
    while c == 1:
        cols = int(input("Please enter the number of columns: "))
        if cols < 0:
            print("Number of columns sould be greater than 0.")
            c = 1
        elif cols > 50:
            print("Number of columns should be less than 50")
            c = 1
        else:
            c = 0

    boardList = []
    newBoardList = []
    boardList = getBoard(rows, cols, boardList)
    newBoardList = [r[:] for r in boardList]

    print() 

#Getting iterations to run, and validating if <= 0
    a = 1
    while a == 1:
        iterations = int(input("How many iterations should I run? "))+1
        if iterations <= 0:
            print("Number of iterations should be greater than 0.")
            a = 1
        else:
            a = 0
    for count in range(iterations):
        print("Iteration:", count)
        printBoard(cols, rows, boardList)
        getNxtIter(cols, rows, boardList, newBoardList)
        boardList = [x[:] for x in newBoardList]
        newBoardList = [x[:] for x in boardList]
main()