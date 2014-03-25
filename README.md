Generate Eagle Scout Plaque
===========================

This is a bit of a hack, but it generates a nice PDF with the scout's name and earned merit badges
wrapped around it.

Requirements:
* Ruby 1.9 (http://rubyinstaller.org/)
* prawn ruby library (http://prawn.majesticseacreature.com/)
* png image signatures of the scout master and committee chairman
  * images/scout_master.png
  * images/committee_chairman.png

Steps:
* copy scout_info.rb to first_last.rb and edit it
** change name
** change date
** uncomment badges
* edit eagle scout and change require_relative entry to match
* run the script
** ruby eagle_scout.rb