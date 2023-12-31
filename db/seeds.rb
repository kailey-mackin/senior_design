# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# db/seeds.rb

# Function to extract ratings from filename (assuming filenames are like "g1_r2_b3_a4_s5.wav")
def extract_ratings(line)
  # Match ratings to line in rating_file
  # line example: "BL01,GRBAS Asthenia,1,0,0,,0,0,0,,0.166666667,Normal,BL01,GRBAS Breathiness,0,0,0,,0,0,0,,0,Normal,BL01,GRBAS Grade,1,1,0,,1,1,0,,0.666666667,Mild,BL01,GRBAS Roughness,0,1,0,,1,1,0,,0.5,Normal,BL01,GRBAS Strain,0,0,0,,0,0,0,,0,Normal"
  line = line.split(',')
  {
    g_rating: line[34].to_i,
    r_rating: line[46].to_i,
    b_rating: line[22].to_i,
    a_rating: line[10].to_i,
    s_rating: line[58].to_i
  }
end

# Folder path containing .wav files
audio_folder = 'public/data/audio/'

# Get a list of .wav files in the folder
wav_files = Dir.glob("#{audio_folder}*.wav")
rating_file = File.new('public/data/ratings/combinedRatingData.csv', "r")
rating_file_lines = rating_file.readlines

# Seed the database with sounds
wav_files.each do |wav_file|
  filename = File.basename(wav_file)
  filename = filename[0..-5] # Remove .wav extension
  # Match filename to line in rating_file
  filename.to_s.downcase!
  match_data = rating_file_lines.find { |line|
    line.downcase!
    line.match(filename)
  }
  if match_data.nil?
    puts "No match found for #{filename}"
    next
  end
  ratings = extract_ratings(match_data)
  # Remove public/ from wav_file path
  wav_file = wav_file[7..-1]
  Sound.create(
    db_file_name: filename,
    audio_file_path: wav_file,
    **ratings
  )
  puts "Created sound #{filename}"
end

users = [{:email => "kaileymackin@gmail.com", :password => "password", :password_confirmation => "password", :name => "Kailey Mackin"},
         {:email => "testuser@gmail.com", :password => "password", :password_confirmation => "password", :name => "Test User"},
         {:email => "crazycats@catlady.com", :password => "password", :password_confirmation => "password", :name => "Crazy Cats"}]

users.each do |user|
  User.create!(user)
end