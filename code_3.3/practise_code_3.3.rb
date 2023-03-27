require 'csv'

def password_config(input_value)
  alphabets = ('a'..'z').to_a + ('A'..'Z').to_a
  numerics = (0..9).to_a.map(&:to_s)
  special_chars = ['!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '=', '+', '[', ']', '{', '}', '|', ';',
                   ':', '<', '>', '.', '?', '/']
  chars = []

  chars += alphabets if input_value.keys == ['alphabets']

  chars += numerics if input_value.keys == ['numbers']

  chars += special_chars if input_value.keys == ['symbols']

  generate_password(input_value, chars)
end

def generate_password(input_value, options)
  password = ''
  input_value.values[0].times do
    password += options.sample
  end

  password
end

def store_in_csv(result, csv_file_path)
  CSV.open(csv_file_path, 'a') do |csv|
    csv << [result]
  end
end

input = 'numbers = 20'
csv_file_path = 'passwords.csv'

generated_hash = { input.split('=')[0].strip => input.split('=')[1].to_i }

password = password_config(generated_hash)

password_exists = false

CSV.foreach(csv_file_path) do |row|
  passwords = row[0]
  if passwords.include? password
    password_exists = true
    break
  end
end

store_in_csv(password, csv_file_path) unless password_exists
