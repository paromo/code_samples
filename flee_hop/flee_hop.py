import sys,random,copy


def print_2d(data):
   for i in range(len(data)):
      for j in range(len(data[i])):
         sys.stdout.write(str(data[i][j]) + " ")
      sys.stdout.write('\n')
   sys.stdout.write('\n')

def get_value():
   rnd = random.randint(-1,1)
   return rnd

def get_valid_move(x,y):
   while True:
      x_move = get_value();
      y_move = get_value();
      if (x == 0 and y == 0 and x_move != -1 and y_move != -1 and not(x_move == 0 and y_move == 0)):
         return(x_move,y_move)
      if (x > 0 and x < 14 and y == 0 and y_move != -1 and not(x_move == 0 and y_move == 0)):
         return(x_move,y_move)
      if (x == 14 and y == 0 and x_move != 1 and y_move != -1 and not(x_move == 0 and y_move == 0)):
         return(x_move,y_move)
      if (x == 0 and y > 0 and y < 14 and x_move != -1 and not(x_move == 0 and y_move == 0)):
         return(x_move,y_move)
      if (x > 0 and x < 14 and y > 0 and y < 14 and not(x_move == 0 and y_move == 0)):
         return(x_move,y_move)
      if (x == 14 and y > 0 and y < 14 and x_move != 1 and not(x_move == 0 and y_move == 0)):
         return(x_move,y_move)
      if (x == 0 and y == 14 and x_move != -1 and y_move != 1 and not(x_move == 0 and y_move == 0)):
         return(x_move,y_move)
      if (x > 0 and x < 14 and y == 14 and y_move != 1 and not(x_move == 0 and y_move == 0)):
         return(x_move,y_move)
      if (x == 14 and y == 14 and x_move != 1 and y_move != 1 and not(x_move == 0 and y_move == 0)):
         return(x_move,y_move)

def handle_bugs(x,y,bugs):
   for i in range(0,bugs):
      move_x, move_y = get_valid_move(x,y)
      data[x+move_x][y+move_y] = data[x+move_x][y+move_y] + 1;
      data[x][y] = data[x][y] - 1;


data = [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]]

runs = 0
print("Initial state:")
print_2d(data)

while runs < 101:
   runs += 1
   start_state_data = copy.deepcopy(data)
   for x_t in range(0,15):
      for y_t in range(0,15):
         if start_state_data[x_t][y_t] != 0:
            handle_bugs(x_t,y_t,start_state_data[x_t][y_t])
   if runs == 25 or runs == 50 or runs == 100:
      print("Distribution on run: " + str(runs))
      print_2d(data)

