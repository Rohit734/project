import sys

board = {"f1": 1, "f2": 2, "f3": 3,
         "f4": 4, "f5": 5, "f6": 6,
         "f7": 7, "f8": 8, "f9": 9}


def display():
    """
    displays the board
    """
    print(f"\t{board['f1']}|\t{board['f2']}|\t{board['f3']}")
    print("  -------|-------|-------")
    print(f"\t{board['f4']}|\t{board['f5']}|\t{board['f6']}")
    print("  -------|-------|-------")
    print(f"\t{board['f7']}|\t{board['f8']}|\t{board['f9']}")


def player_x():
    """
    calculate points for player 1
    """
    point = 0
    if board['f1'] == board['f2'] == board['f3'] == '#':
        point = 1
    elif board['f4'] == board['f5'] == board['f6'] == '#':
        point = 1
    elif board['f7'] == board['f8'] == board['f9'] == '#':
        point = 1
    elif board['f7'] == board['f5'] == board['f3'] == '#':
        point = 1
    elif board['f9'] == board['f5'] == board['f1'] == '#':
        point = 1
    elif board['f1'] == board['f4'] == board['f7'] == '#':
        point = 1
    elif board['f2'] == board['f5'] == board['f8'] == '#':
        point = 1
    elif board['f3'] == board['f6'] == board['f9'] == '#':
        point = 1
    else:
        point = 0
    return point


def player_o():
    """
        calculate points for player 2
    """
    point = 0
    if board['f1'] == board['f2'] == board['f3'] == '*':
        point = 1
    elif board['f4'] == board['f5'] == board['f6'] == '*':
        point = 1
    elif board['f7'] == board['f8'] == board['f9'] == '*':
        point = 1
    elif board['f7'] == board['f5'] == board['f3'] == '*':
        point = 1
    elif board['f9'] == board['f5'] == board['f1'] == '*':
        point = 1
    elif board['f1'] == board['f4'] == board['f7'] == '*':
        point = 1
    elif board['f2'] == board['f5'] == board['f8'] == '*':
        point = 1
    elif board['f3'] == board['f6'] == board['f9'] == '*':
        point = 1
    else:
        point = 0
    return point


def insert(player, x, z):
    """
    this function will make change in board according to user
    """
    if board['f' + str(x)] == "O" or board['f' + str(x)] == "X":
        print("you can't change try again")
        x = input(f'player {z} Enter your position\n')
        board['f' + str(x)] = player
    else:
        board['f' + str(x)] = player


def inputFromUse(z, y=0):
    """
    take input from user and checks if the input is equal to zero or greater than 9
    """
    while y == 0 or y > 9:
        print(f"player {z} Enter your position ")
        y = int(input())
        if y == 0 or y > 9:
            print("invalid value \nenter another value")
    return y


def start_game():
    Range = 10
    display()
    while True:
        for x in range(1, Range):
            if x % 2 == 0:
                z = 'X'
                y = inputFromUse(z)
                insert("X", y, z)
                display()
                player1 = player_x()
                if player1 > 0:
                    print('player X is winner')
                    sys.exit()
            elif x % 2 != 0:
                z = "O"
                y = inputFromUse(z)
                insert("O", y, z)
                player2 = player_o()
                display()
                if player2 > 0:
                    print('\tplayer O is winner')
                    sys.exit()
            else:
                print("out of range please try again")
                Range += 1
        else:
            print("\tDRAW")
            break


start_game()
