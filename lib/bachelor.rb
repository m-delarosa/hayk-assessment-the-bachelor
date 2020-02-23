#The method should return the first name of that season's winner. 
#Hint: you'll need to do some string manipulation to return only the first name of the winning lady.
require 'pry'

data = JSON.parse(File.read('spec/fixtures/contestants.json')) 

# target data[season][1]["status"]
def get_first_name_of_season_winner(data, season)
  data[season].find do |contestant| 
    contestant["status"].downcase == "winner".downcase
    return contestant["name"].split(" ").first
  end
end

def all_season_contestants(data)
  data.values.flatten
end

def get_contestant_name(data, occupation)
  all_season_contestants(data).find do |contestant|
    if contestant["occupation"] == occupation
     return contestant["name"]
    end
  end 
end

#Ahmed's Solution
def get_contesttant_name(data, occupation)
  all_contestants_ever = data.values.flatten
  contestant_with_occupation = all_contestants_ever.find do |contestant|
    contestant["occupation"] == occupation
  end
  contestant_with_occupation["name"]
end

def all_contestants_ever(data)
  data.values.flatten
end

#Each method, returns an integer
def count_contestants_by_hometown(data, hometown)
  # counter = 0

  # all_season_contestants(data.each) do |contestant|
  #   if contestant["hometown"] == hometown
  #     counter += 1
  #   end
  # end
  # counter

  all_contestants_ever(data).reduce(0) do |counter, contestant|
    if contestant["hometown"] == hometown
      counter + 1
    else
      counter
    end
  end
end

# returns the occupation of the first contestant
# who hails from that hometown.
def get_occupation(data, hometown)
  contestant = {}
  
  contestant = all_contestants_ever(data).find do |contestant|
    contestant["hometown"].downcase == hometown.downcase
  end
  contestant["occupation"]
end

# returns 26 when passed the data and the string 'season 10'
def get_average_age_for_season(data, season)
  age_array = data[season].map do |contestant|
    contestant["age"].to_i
  end
  sum = age_array.reduce(0) {|total, age| total + age}
  (sum.to_f / age_array.length).round
end
