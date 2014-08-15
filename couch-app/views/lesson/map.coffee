(doc) ->

  return unless doc.collection is "patient-records" or doc.collection is "incident"

  emit [doc.subject, doc.grade, doc.week, doc.day], null