;;; DEF CON 33 - Core Sessions Module
;;; Session management for conference tracks, workshops, and villages

(define-module (sessions core)
  #:use-module (ice-9 format)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-19)
  #:export (make-session
            session?
            session-id
            session-title
            session-track
            session-time
            session-duration
            session-speaker
            session-room
            session-capacity
            session-media-url
            list-sessions
            add-session!
            find-session
            sessions-by-track
            sessions-by-time
            upcoming-sessions
            core-sessions))

;;; Session record type
(define-record-type <session>
  (make-session id title track time duration speaker room capacity media-url)
  session?
  (id session-id)
  (title session-title)
  (track session-track)           ; main, village, workshop, skytalks
  (time session-time)              ; SRFI-19 time object
  (duration session-duration)      ; minutes
  (speaker session-speaker)
  (room session-room)
  (capacity session-capacity)
  (media-url session-media-url))   ; streaming/recording URL

;;; Global session registry
(define *sessions* '())

;;; Add a session to the registry
(define (add-session! session)
  (set! *sessions* (cons session *sessions*))
  session)

;;; List all sessions
(define (list-sessions)
  *sessions*)

;;; Find session by ID
(define (find-session id)
  (find (lambda (s) (equal? (session-id s) id)) *sessions*))

;;; Get sessions by track
(define (sessions-by-track track)
  (filter (lambda (s) (equal? (session-track s) track)) *sessions*))

;;; Get sessions at a specific time
(define (sessions-by-time time)
  (filter (lambda (s) 
            (time=? (session-time s) time))
          *sessions*))

;;; Get upcoming sessions (next 2 hours)
(define (upcoming-sessions)
  (let ((now (current-time))
        (two-hours (make-time time-duration 0 7200)))
    (filter (lambda (s)
              (let ((session-start (session-time s)))
                (and (time>? session-start now)
                     (time<? session-start (add-duration now two-hours)))))
            *sessions*)))

;;; Core DEF CON 33 Sessions
;;; These are the main track sessions for tomorrow morning
(define (core-sessions)
  (list
    (make-session 
      "DC33-001"
      "Opening Ceremonies"
      'main
      (make-time time-utc 0 36000)  ; 10:00 AM
      60
      "The Dark Tangent"
      "Track 1"
      5000
      "https://media.defcon.org/DEF%20CON%2033/tracks/main/opening")
    
    (make-session
      "DC33-002"
      "Keynote: The Future of Hacking"
      'main
      (make-time time-utc 0 39600)  ; 11:00 AM
      45
      "TBA"
      "Track 1"
      5000
      "https://media.defcon.org/DEF%20CON%2033/tracks/main/keynote")
    
    (make-session
      "DC33-101"
      "Advanced Exploit Development"
      'main
      (make-time time-utc 0 43200)  ; 12:00 PM
      50
      "Multiple Speakers"
      "Track 2"
      500
      "https://media.defcon.org/DEF%20CON%2033/tracks/main/exploit-dev")
    
    (make-session
      "DC33-102"
      "Infrastructure Hacking: Beyond the Perimeter"
      'main
      (make-time time-utc 0 43200)  ; 12:00 PM
      50
      "Security Team"
      "Track 3"
      500
      "https://media.defcon.org/DEF%20CON%2033/tracks/main/infra-hack")
    
    (make-session
      "DC33-201"
      "Lockpicking Village: Advanced Techniques"
      'village
      (make-time time-utc 0 36000)  ; 10:00 AM
      120
      "TOOOL"
      "Lockpick Village"
      100
      "https://media.defcon.org/DEF%20CON%2033/villages/lockpick/advanced")
    
    (make-session
      "DC33-202"
      "Car Hacking Village: CAN Bus Exploitation"
      'village
      (make-time time-utc 0 36000)  ; 10:00 AM
      180
      "Car Hacking Team"
      "Car Hacking Village"
      75
      "https://media.defcon.org/DEF%20CON%2033/villages/car-hacking/canbus")
    
    (make-session
      "DC33-301"
      "Reverse Engineering Hardware Workshop"
      'workshop
      (make-time time-utc 0 32400)  ; 9:00 AM
      240
      "Hardware Team"
      "Workshop Room A"
      30
      "https://media.defcon.org/DEF%20CON%2033/workshops/hardware-re")
    
    (make-session
      "DC33-401"
      "SkyTalks: 0days and Beyond"
      'skytalks
      (make-time time-utc 0 39600)  ; 11:00 AM
      30
      "Anonymous"
      "SkyTalks Room"
      200
      nil)))  ; SkyTalks are not recorded

;;; Initialize core sessions on module load
(for-each add-session! (core-sessions))

;;; Display helper
(define (display-session session)
  (format #t "~a: ~a~%  Track: ~a | Room: ~a | Duration: ~a min~%  Speaker: ~a~%  Media: ~a~%~%"
          (session-id session)
          (session-title session)
          (session-track session)
          (session-room session)
          (session-duration session)
          (session-speaker session)
          (or (session-media-url session) "Not recorded")))