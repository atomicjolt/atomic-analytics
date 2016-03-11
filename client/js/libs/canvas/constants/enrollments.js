//
// Enrollments
//
// List enrollments
// Depending on the URL given, return either (1) all of the enrollments in
// a course, (2) all of the enrollments in a section or (3) all of a user's
// enrollments. This includes student, teacher, TA, and observer enrollments.
// 
// If a user has multiple enrollments in a context (e.g. as a teacher
// and a student or in multiple course sections), each enrollment will be
// listed separately.
// 
// note: Currently, only an admin user can return other users' enrollments. A
// user can, however, return his/her own enrollments.
//
// API Docs: https://canvas.instructure.com/doc/api/enrollments.html
// API Url: courses/{course_id}/enrollments
//
// Example:
// const query = {
//   type
//   role
//   state
//   user_id
//   grading_period_id
// }
// return canvasRequest(list_enrollments_courses, {course_id}, query);
export const list_enrollments_courses = { type: "LIST_ENROLLMENTS_COURSES", method: "get", reducer: 'enrollments'};

// List enrollments
// Depending on the URL given, return either (1) all of the enrollments in
// a course, (2) all of the enrollments in a section or (3) all of a user's
// enrollments. This includes student, teacher, TA, and observer enrollments.
// 
// If a user has multiple enrollments in a context (e.g. as a teacher
// and a student or in multiple course sections), each enrollment will be
// listed separately.
// 
// note: Currently, only an admin user can return other users' enrollments. A
// user can, however, return his/her own enrollments.
//
// API Docs: https://canvas.instructure.com/doc/api/enrollments.html
// API Url: sections/{section_id}/enrollments
//
// Example:
// const query = {
//   type
//   role
//   state
//   user_id
//   grading_period_id
// }
// return canvasRequest(list_enrollments_sections, {section_id}, query);
export const list_enrollments_sections = { type: "LIST_ENROLLMENTS_SECTIONS", method: "get", reducer: 'enrollments'};

// List enrollments
// Depending on the URL given, return either (1) all of the enrollments in
// a course, (2) all of the enrollments in a section or (3) all of a user's
// enrollments. This includes student, teacher, TA, and observer enrollments.
// 
// If a user has multiple enrollments in a context (e.g. as a teacher
// and a student or in multiple course sections), each enrollment will be
// listed separately.
// 
// note: Currently, only an admin user can return other users' enrollments. A
// user can, however, return his/her own enrollments.
//
// API Docs: https://canvas.instructure.com/doc/api/enrollments.html
// API Url: users/{user_id}/enrollments
//
// Example:
// const query = {
//   type
//   role
//   state
//   grading_period_id
// }
// return canvasRequest(list_enrollments_users, {user_id}, query);
export const list_enrollments_users = { type: "LIST_ENROLLMENTS_USERS", method: "get", reducer: 'enrollments'};

// Enrollment by ID
// Get an Enrollment object by Enrollment ID
//
// API Docs: https://canvas.instructure.com/doc/api/enrollments.html
// API Url: accounts/{account_id}/enrollments/{id}
//
// Example:
// return canvasRequest(enrollment_by_id, {account_id, id});
export const enrollment_by_id = { type: "ENROLLMENT_BY_ID", method: "get", reducer: 'enrollments'};

// Enroll a user
// Create a new user enrollment for a course or section.
//
// API Docs: https://canvas.instructure.com/doc/api/enrollments.html
// API Url: courses/{course_id}/enrollments
//
// Example:
// const query = {
//   enrollment[user_id] (required)
//   enrollment[type] (required)
//   enrollment[role]
//   enrollment[role_id]
//   enrollment[enrollment_state]
//   enrollment[course_section_id]
//   enrollment[limit_privileges_to_course_section]
//   enrollment[notify]
//   enrollment[self_enrollment_code]
//   enrollment[self_enrolled]
// }
// return canvasRequest(enroll_user_courses, {course_id}, query);
export const enroll_user_courses = { type: "ENROLL_USER_COURSES", method: "post", reducer: 'enrollments'};

// Enroll a user
// Create a new user enrollment for a course or section.
//
// API Docs: https://canvas.instructure.com/doc/api/enrollments.html
// API Url: sections/{section_id}/enrollments
//
// Example:
// const query = {
//   enrollment[user_id] (required)
//   enrollment[type] (required)
//   enrollment[role]
//   enrollment[role_id]
//   enrollment[enrollment_state]
//   enrollment[course_section_id]
//   enrollment[limit_privileges_to_course_section]
//   enrollment[notify]
//   enrollment[self_enrollment_code]
//   enrollment[self_enrolled]
// }
// return canvasRequest(enroll_user_sections, {section_id}, query);
export const enroll_user_sections = { type: "ENROLL_USER_SECTIONS", method: "post", reducer: 'enrollments'};

// Conclude or inactivate an enrollment
// Delete, conclude or inactivate an enrollment.
//
// API Docs: https://canvas.instructure.com/doc/api/enrollments.html
// API Url: courses/{course_id}/enrollments/{id}
//
// Example:
// const query = {
//   task
// }
// return canvasRequest(conclude_or_inactivate_enrollment, {course_id, id}, query);
export const conclude_or_inactivate_enrollment = { type: "CONCLUDE_OR_INACTIVATE_ENROLLMENT", method: "delete", reducer: 'enrollments'};

// Re-activate an enrollment
// Activates an inactive enrollment
//
// API Docs: https://canvas.instructure.com/doc/api/enrollments.html
// API Url: courses/{course_id}/enrollments/{id}/reactivate
//
// Example:
// return canvasRequest(re_activate_enrollment, {course_id, id});
export const re_activate_enrollment = { type: "RE_ACTIVATE_ENROLLMENT", method: "put", reducer: 'enrollments'};