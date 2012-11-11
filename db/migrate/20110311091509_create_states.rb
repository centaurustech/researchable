# coding: utf-8
require 'sexy_pg_constraints'
class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :name, :null => false
      t.string :acronym, :null => false
      t.timestamps
    end
    constrain :states do |t|
      t.name :not_blank => true, :unique => true
      t.acronym :not_blank => true, :unique => true
    end
    execute "INSERT INTO states (name, acronym, created_at, updated_at) VALUES
    ('Alabama','AL',current_timestamp,current_timestamp),
    ('Alaska','AK',current_timestamp,current_timestamp),
    ('Arizona','AZ',current_timestamp,current_timestamp),
    ('Arkansas','AR',current_timestamp,current_timestamp),
    ('California','CA',current_timestamp,current_timestamp),
    ('Colorado','CO',current_timestamp,current_timestamp),
    ('Connecticut','CT',current_timestamp,current_timestamp),
    ('Delaware','DE',current_timestamp,current_timestamp),
    ('Florida','FL',current_timestamp,current_timestamp),
    ('Georgia','GA',current_timestamp,current_timestamp),
    ('Hawaii','HI',current_timestamp,current_timestamp),
    ('Idaho','ID',current_timestamp,current_timestamp),
    ('Illinois','IL',current_timestamp,current_timestamp),
    ('Indiana','IN',current_timestamp,current_timestamp),
    ('Iowa','IA',current_timestamp,current_timestamp),
    ('Kansas','KS',current_timestamp,current_timestamp),
    ('Kentucky','KY',current_timestamp,current_timestamp),
    ('Louisiana','LA',current_timestamp,current_timestamp),
    ('Maine','ME',current_timestamp,current_timestamp),
    ('Maryland','MD',current_timestamp,current_timestamp),
    ('Massachusetts','MA',current_timestamp,current_timestamp),
    ('Michigan','MI',current_timestamp,current_timestamp),
    ('Minnesota','MN',current_timestamp,current_timestamp),
    ('Mississippi','MS',current_timestamp,current_timestamp),
    ('Missouri','MO',current_timestamp,current_timestamp),
    ('Montana','MT',current_timestamp,current_timestamp),
    ('Nebraska','NE',current_timestamp,current_timestamp),
    ('Nevada','NV',current_timestamp,current_timestamp),
    ('New Hampshire','NH',current_timestamp,current_timestamp),
    ('New Jersey','NJ',current_timestamp,current_timestamp),
    ('New Mexico','NM',current_timestamp,current_timestamp),
    ('New York','NY',current_timestamp,current_timestamp),
    ('North Carolina','NC',current_timestamp,current_timestamp),
    ('North Dakota','ND',current_timestamp,current_timestamp),
    ('Ohio','OH',current_timestamp,current_timestamp),
    ('Oklahoma','OK',current_timestamp,current_timestamp),
    ('Oregon','OR',current_timestamp,current_timestamp),
    ('Pennsylvania','PA',current_timestamp,current_timestamp),
    ('Rhode Island','RI',current_timestamp,current_timestamp),
    ('South Carolina','SC',current_timestamp,current_timestamp),
    ('South Dakota','SD',current_timestamp,current_timestamp),
    ('Tennessee','TN',current_timestamp,current_timestamp),
    ('Texas','TX',current_timestamp,current_timestamp),
    ('Utah','UT',current_timestamp,current_timestamp),
    ('Vermont','VT',current_timestamp,current_timestamp),
    ('Virginia','VA',current_timestamp,current_timestamp),
    ('Washington','WA',current_timestamp,current_timestamp),
    ('West Virginia','WV',current_timestamp,current_timestamp),
    ('Wisconsin','WI',current_timestamp,current_timestamp),
    ('Wyoming','WY',current_timestamp,current_timestamp),
    ('Washington DC','DC',current_timestamp,current_timestamp);"
  end

  def self.down
    drop_table :states
  end
end
