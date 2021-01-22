module EventsFixtures
  USERS = [
    {
      id: 5427,
      name: "August Andrews",
    },
    {
      id: 5414,
      name: "Sloan Best",
    },
    {
      id: 5433,
      name: "Sophie Booker",
    },
    {
      id: 5438,
      name: "Malia Boyer",
    },
    {
      id: 5420,
      name: "Post Butler",
    },
    {
      id: 5416,
      name: "Parker Chase",
    },
    {
      id: 5411,
      name: "Ember Combs",
    },
    {
      id: 5437,
      name: "Malakai Dalton",
    },
    {
      id: 5425,
      name: "Makenna Elliot",
    },
    {
      id: 5421,
      name: "Annie Goodman",
    },
  ].freeze

  ASSET_TYPES = {
    account: ["outcomes"],
    assignment: [],
    calendar_event: [],
    course: [
      "assignments",
      "files",
      "grades",
      "conferences",
      "syllabus",
      "pages",
      "modules",
      "roster",
      "calendar_feed",
      "home",
      "outcomes",
      "speed_grader",
      "announcements",
      "topics",
      "collaborations",
      "quizzes",
    ],
    enrollment: [],
    group: [
      "conferences",
      "calendar_feed",
      "files",
      "pages",
      "announcements",
      "topics",
      "roster",
      "collaborations",
    ],
    learning_outcome: [],
    user: [
      "calendar_feed",
      "files",
    ],
    collaboration: [],
    "quizzes:quiz": [],
    context_external_tool: [], # (this type is used to identify all LTI versions except LTI 2.0 launches)
    "lti/tool_proxy": [], # (this type is used to identify LTI 2.0 launches)
    web_conference: [],
    wiki_page: [],
    content_tag: [],
    discussion_topic: [],
    attachment: [],
  }
end
