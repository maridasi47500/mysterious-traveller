class Relationship < ApplicationRecord

def self.friendly
Relationship.find_by(name: 'Friendly')
end
def self.fun
Relationship.find_by(name: 'Fun')
end
def self.serious
Relationship.find_by(name: 'Serious')
end
end
