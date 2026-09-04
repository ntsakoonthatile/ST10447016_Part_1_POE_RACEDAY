# ST10447016_Part_1_POE_RACEDAY
RaceDay
#  System Description

RaceDay is an online event management platform created for the road running, walking, and cycling community in South Africa. Event planners can develop and manage events, categories, participant enrolments and outcomes with this system. Participants can go through the events that are offered, select a category, sign up for activities and see their own outcomes. Planning the system design and creating the relational database that will support the RaceDay application are the main topics of Part 1.

# Organiser

An Organiser is responsible for managing events on the RaceDay system. The Organiser can:

* Create events.
* Edit event information.
* Delete events.
* Create and manage event categories.
* View participant enrolments.
* Capture participant results.

# Participant

A Participant uses RaceDay to find and enter events. The Participant can:

* Create an account and log in.
* View and update their profile.
* Browse available events.
* View event categories.
* Enrol in an event by selecting a category.
* View their own enrolments.
* View their own results.

Role-based access will be used in the later API and MVC parts of the project to ensure that users can only access functions appropriate to their role.

#  Part 1 Documents

The docs folder contains the main planning and database documents for Part 1:

* RaceDay_ERD.png – Entity Relationship Diagram showing the database entities, attributes, primary keys, foreign keys and relationships.
* RaceDay_API_Endpoint_Plan.md – RESTful API endpoint plan covering authentication, user profiles, events, categories, enrolments and results.
* RaceDay_Database.sql – SQL Server database script containing the database schema, constraints and sample data.

#  Database Design

The RaceDay database contains six main entities:

1. Users
2. EventTypes
3. Events
4. Categories
5. Enrolments
6. Results

The Users entity stores both Organiser and Participant accounts. Events are linked to the organiser who created them and to an event type. Each event can have multiple categories and participant enrolments. Results are linked to enrolments so that participant performance can be recorded.

The database uses primary keys to uniquely identify records and foreign keys to maintain relationships between related entities.

#  Sample Data

The database script includes sample data to demonstrate that the design works correctly. The sample data includes:

* 2 Organisers.
* 2 Participants.
* 3 Events.
* Event types for Run, Walk and Cycle.
* Categories for each event.
* Sample participant enrolments.
* Sample participant results.

The sample events use South African locations such as Soweto, Cape Town and Durban.

#  API Planning

The API endpoint plan was created before implementation so that the expected communication between the future application and database could be clearly defined.

The planned endpoints cover:

* User registration and login.
* User profiles.
* Event viewing and management.
* Event types.
* Event categories.
* Participant enrolments.
* Participant results.


#  Technologies

The following technologies and tools are used for Part 1:

* SQL Server
* SQL Server Management Studio (SSMS)
* GitHub
* GitHub Actions
* Draw.io / diagramming software
* Markdown


#  GitHub Actions

A GitHub Actions workflow is included to check that the required Part 1 repository structure and planning documents are present.

The video demonstrates:

* The RaceDay planning documents.
* The ERD and the reasons for the selected relationships.
* The API endpoint plan.
* The SQL database design.
* Running the SQL script in SQL Server Management Studio (SSMS).

YouTube Video: https://youtu.be/7VQySOVY9JI?feature=shared

Part 1 provides the foundation for the RaceDay system. The ERD defines the database structure, the API endpoint plan defines how the future application will communicate with the system, and the SQL script implements the planned relational database. These planning documents will be used as the basis for the REST API in Part 2 and the MVC application in Part 3.
