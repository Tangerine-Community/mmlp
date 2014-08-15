#
# Constants
#

Mmlp = Mmlp || {}

Mmlp.$db = $.couch.db("mmlp")

Mmlp.enum =
  subjects :
    1 : "English"
    2 : "Kiswahili"
  iSubjects :
    "English": "1"
    "Kiswahili" : "2"

