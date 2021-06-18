"""this is Responsible for fetch and update data to a database """
import sqlite3

connectCricket = sqlite3.connect("cricketData.db")
cursorCricket = connectCricket.cursor()

data = {}
info = {"TeamName": [], "TotalMatch": []}
match_data = {}


def playerInformation():  # fetch players name and CTG from database when new team is clicked Every time and returns value to
    """Fetch players according to their category"""
    global data
    try:
        sql = 'select player,CTG,value from stats where CTG = "BAT"'
        cursorCricket.execute(sql)
        data["batsmen"] = cursorCricket.fetchall()
        sql = 'select player,CTG,value from stats where CTG = "BWL"'
        cursorCricket.execute(sql)
        data["bowler"] = cursorCricket.fetchall()
        sql = 'select player,CTG,value from stats where CTG = "WK"'
        cursorCricket.execute(sql)
        data["wicketkeeper"] = cursorCricket.fetchall()
        sql = 'select player,CTG,value from stats where CTG = "AR"'
        cursorCricket.execute(sql)
        data["allrounder"] = cursorCricket.fetchall()
        sql = 'select sum(value) from stats'
        cursorCricket.execute(sql)
        data["pointAvailable"] = cursorCricket.fetchall()[0][0]  # fetch total points
        data["allplayer"] = data["wicketkeeper"] + data["allrounder"] + data["batsmen"] + data["bowler"]
    except Exception as e:
        print(e, "From playerInformation")


def saveTeam():  # used to save data when user click on save team
    """Saves Team if its new Else It will update team"""
    global data
    msg = ''
    try:
        if checkTeam():
            msg = "successfully saved"
        else:
            cursorCricket.execute(f'delete from teams where name="{data["teamName"]}";')
            msg = "Team updated"
    except Exception as e:
        print(e)
    finally:
        for player in data["selectedPlayer"]:
            cursorCricket.execute("insert into teams values(?,?,?);", (data["teamName"], player[0], player[2]))
            connectCricket.commit()
    return msg


def checkTeam():  # checks whether  team exist or not
    """Checks whether team exists or not"""
    global data
    try:
        sql = f'select count(name) from teams where name ="{data["teamName"]}"'
        cursorCricket.execute(sql)
        if cursorCricket.fetchall()[0][0] > 0:
            return False
        else:
            return True
    except Exception as e:
        print(e, "From CheckTeam()")


def getInfo(item):  # returns player category
    """Returns tuple(Player_name, player_category, player_value)"""
    global data
    for player in data["allplayer"]:
        if item in player:
            return player


def openTeam():
    """Opens team and fetch teams data """
    try:
        global data
        data["playersName"] = []
        playerInformation()
        sql = f'select players from teams where name = "{data["teamName"]}"'
        cursorCricket.execute(sql)
        [data["playersName"].append(name[0]) for name in cursorCricket.fetchall()]  # gets list of selected player name
        sql = f'select sum(value) from teams where name = "{data["teamName"]}"'
        cursorCricket.execute(sql)
        data["pointUsed"] = cursorCricket.fetchall()[0][0]
        print(data["pointUsed"])
        data["pointAvailable"] = data.get("pointAvailable") - data["pointUsed"]
        data["selectedPlayer"] = []

        for player in data["playersName"]:

            playerinfo = getInfo(player)
            if playerinfo[1] == "BAT":
                data["batsmen"].remove(playerinfo)
                data["selectedPlayer"].append(playerinfo)
                data["count_batsmen"] = data.get("count_batsmen", 0) + 1
            elif playerinfo[1] == "BWL":
                data["bowler"].remove(playerinfo)
                data["selectedPlayer"].append(playerinfo)
                data["count_bowler"] = data.get("count_bowler", 0) + 1
            elif playerinfo[1] == "WK":
                data["wicketkeeper"].remove(playerinfo)
                data["selectedPlayer"].append(playerinfo)
                data["count_wicketkeeper"] = data.get("count_wicketkeeper", 0) + 1
            elif playerinfo[1] == "AR":
                data["allrounder"].remove(playerinfo)
                data["selectedPlayer"].append(playerinfo)
                data["count_allrounder"] = data.get("count_allrounder", 0) + 1

    except Exception as e:
        print(e, "From OpenData()")


def TeamsAndMatch():
    """Fetch all teams name and total match played by player"""
    global info
    sql = 'select distinct name from teams'
    cursorCricket.execute(sql)
    info["TeamName"] = []
    info["TotalMatch"] = []
    [info["TeamName"].append(name[0]) for name in cursorCricket.fetchall()]
    sql = 'select * from totalMatch'
    cursorCricket.execute(sql)
    [info["TotalMatch"].append(match[0]) for match in cursorCricket.fetchall()]


def matchData(teamName, matchID):
    """This function retrieves match details of a player with respect to matchID"""
    global match_data
    players = []
    sql = f'select players from teams where name = "{teamName}"'
    cursorCricket.execute(sql)
    [players.append(name[0]) for name in cursorCricket.fetchall()]

    for name in players:
        sql = f"select Scored, Faced, Fours, Sixes, Bowled, Maiden, Given, Wkts, Catches, Stumping, RO from Match where matchID = '{matchID}' and Player ='{name}' "
        cursorCricket.execute(sql)
        for value in cursorCricket.fetchall():
            match_data[name] = value
