#
# Boot steps
#
Mmlp.bootSequence = 
  cache : (done) ->
    Mmlp.cache = 
      $window    : $(window)
      $nav       : $('#menu')
      $navSpacer : $('#menu-spacer')
    Mmlp.cache.elTop = Mmlp.cache.$nav.offset().top
    done()

  loadLesson: (done) ->
    Mmlp.$db.view "mmlp/lesson",
      success: (response) =>
        Mmlp.available = []
        for row in response.rows
          subject = Mmlp.enum.subjects[row.key[0]]
          grade   = row.key[1]
          week    = row.key[2]
          day     = row.key[3]
          Mmlp.available.push [subject, grade, week, day]
        if window.location.hash is ""
          window.location.hash = "lesson/#{Mmlp.available[0][0]}/#{Mmlp.available[0][1]}/#{Mmlp.available[0][2]}/#{Mmlp.available[0][3]}"
        done()

  initMenu: (done) ->
    Mmlp.MenuView   = new LessonMenuView available: Mmlp.available
    Mmlp.MenuView.setElement($("#menu")).render()
    done()

  initDisplay: (done) ->
    Mmlp.LessonView = new LessonView
    Mmlp.LessonView.setElement($("#content")).render()
    done()

  freezeNav: (done) ->
    Mmlp.cache.$window.scroll ->
      shouldFreeze = Mmlp.cache.$window.scrollTop() > Mmlp.cache.elTop
      Mmlp.cache.$nav.toggleClass 'sticky-on', shouldFreeze
      Mmlp.cache.$navSpacer.height(Mmlp.cache.$nav.height())
      Mmlp.cache.$navSpacer.toggle shouldFreeze

    done()

  initRouter: (done) ->
    Mmlp.router = new MmlpRouter()
    done()
  
  startBackbone: (done) ->
    Backbone.history.start()

#
# Boot Application
#

$ ->

  boot = [
    Mmlp.bootSequence.cache
    Mmlp.bootSequence.loadLesson
    Mmlp.bootSequence.initMenu
    Mmlp.bootSequence.initDisplay
    Mmlp.bootSequence.freezeNav
    Mmlp.bootSequence.initRouter
    Mmlp.bootSequence.startBackbone
  ]

  runSequence = ->
    if boot.length is 0
      # do nothin
    else
      nextFunction = boot.shift()
      console.log nextFunction
      nextFunction(runSequence)

  runSequence()


