#!/usr/bin/ruby

require 'prawn'
require "prawn/measurement_extensions"


#################
# Certificate specific values
#######
require_relative 'scout_info'

#################
# Default locations and files
#######
file_name='eagle_scout-' + $scout_name + '.pdf'
image_loc='./images/'
image_loc_badges=image_loc + 'badges/'

image_bsa_medal=image_loc+'bsa_medal.png'
image_eagle_scout=image_loc+'eagle_scout.png'
image_committee_chairman=image_loc+'committee_chairman.png'
image_scout_master=image_loc+'scout_master.png'


#################
# Default dimensions and locations
#######
bottom_margin = 10
left_margin = 72
badge_height = 160
badge_width = 140
badge_scale = 120
font_color = "000000"
font_color_red = "990000"

badge_row_width=8 * badge_width

# Figure out how many/width of bottom row of badges
bottom_row_adjustable_width=badge_row_width - badge_width # want the last badge at the end
bottom_row_badges = $badges.length - 14
bottom_row_badge_width=Float(bottom_row_adjustable_width)/(bottom_row_badges - 1) # want the last badge in the at the end

badge_locations = [
	[left_margin + (badge_width * 0), (bottom_margin + badge_height * 5)],
	[left_margin + (badge_width * 1), (bottom_margin + badge_height * 5)],
	[left_margin + (badge_width * 2), (bottom_margin + badge_height * 5)],
	[left_margin + (badge_width * 3), (bottom_margin + badge_height * 5)],
	[left_margin + (badge_width * 4), (bottom_margin + badge_height * 5)],
	[left_margin + (badge_width * 5), (bottom_margin + badge_height * 5)],
	[left_margin + (badge_width * 6), (bottom_margin + badge_height * 5)],
	[left_margin + (badge_width * 7), (bottom_margin + badge_height * 5)],

	[left_margin + (badge_width * 0), (bottom_margin + badge_height * 4)],
	[left_margin + (badge_width * 7), (bottom_margin + badge_height * 4)],
	[left_margin + (badge_width * 0), (bottom_margin + badge_height * 3)],
	[left_margin + (badge_width * 7), (bottom_margin + badge_height * 3)],
	[left_margin + (badge_width * 0), (bottom_margin + badge_height * 2)],
	[left_margin + (badge_width * 7), (bottom_margin + badge_height * 2)],

	[left_margin + (bottom_row_badge_width * 0), (bottom_margin + badge_height * 1)],
	[left_margin + (bottom_row_badge_width * 1), (bottom_margin + badge_height * 1)],
	[left_margin + (bottom_row_badge_width * 2), (bottom_margin + badge_height * 1)],
	[left_margin + (bottom_row_badge_width * 3), (bottom_margin + badge_height * 1)],
	[left_margin + (bottom_row_badge_width * 4), (bottom_margin + badge_height * 1)],
	[left_margin + (bottom_row_badge_width * 5), (bottom_margin + badge_height * 1)],
	[left_margin + (bottom_row_badge_width * 6), (bottom_margin + badge_height * 1)],
	[left_margin + (bottom_row_badge_width * 7), (bottom_margin + badge_height * 1)]
]


#################
# Let's render some pdf!
#######
$stdout.write("Generating certificate for " + $scout_name)

Prawn::Document.generate(file_name,
	:page_size		=> [19*72, 13*72],
	:info 			=> {
		:Title			=> "Eagle Scout Achievement",
		:Author			=> "Troop 61",
		:Subject		=> "Eagle Scout for " + $scout_name,
		:CreationDate	=> Time.now
		}) do |pdf|


	# Output the badges
	$badges.each_with_index do |badge, index|
		pdf.image image_loc_badges + badge + '.png', :at => badge_locations[index], :width => badge_scale
	end


	# Output the eagle scout badge and the bas medal
	pdf.image image_eagle_scout, :at => [(left_margin + (badge_width * 1.1)), (bottom_margin + badge_height * 3)], :height => 170
	pdf.image image_bsa_medal, :at => [(left_margin + (badge_width * 6)), (bottom_margin + badge_height * 3)], :height => 170


	# Output the text
	pdf.move_down 230

	pdf.font_size 75
	pdf.font "Times-Roman", :style => :italic
	pdf.fill_color font_color_red
	pdf.text $scout_name, :align => :center

	pdf.fill_color font_color
	pdf.font_size 22
	pdf.font "Times-Roman", :style => :normal
	pdf.text "IN RECOGNITION OF\nHIS INVESTITURE AS", :align => :center

	pdf.move_down 10
	pdf.font_size 60
	pdf.font "Times-Roman", :style => :bold
	pdf.text "EAGLE SCOUT", :align => :center

	pdf.font_size 22
	pdf.text "FROM FELLOW SCOUTS OF\nTROOP 61", :align => :center

	pdf.move_down 10
	pdf.font_size 24
	pdf.font "Times-Roman", :style => :italic
	pdf.fill_color font_color_red
	pdf.text $date, :align => :center


	# Output the siganture images
	pdf.image image_scout_master, :at => [250, 275]
	pdf.image image_committee_chairman, :at => [750, 275]


	# Output the lines under the signatures
	pdf.move_down 115
	pdf.stroke do
		pdf.horizontal_line 250, 500
		pdf.horizontal_line 750, 1000
	end


	# Output the titles
	pdf.fill_color font_color
	pdf.font_size 12
	pdf.font "Times-Roman", :style => :normal
	pdf.bounding_box([250, 215], :width => 250, :height=>22) do
		pdf.text "SCOUT MASTER", :align => :center
	end
	pdf.bounding_box([750, 215], :width => 250, :height=>12) do
		pdf.text "COMMITTEE CHAIRMAN", :align => :center
	end
end
