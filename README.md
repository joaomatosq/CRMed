# CRMed - Healthcare Scheduling

A database foundation for hospital appointment management.

This project establishes an Oracle Database architecture designed to the Hospital Sao Rafael as part of a college project and it handles a healthcare scheduling workflows. It serves as the core foundation for a Java Spring Boot API, with focus on data integrity, concurrency readiness, and a schema versioning.

## Key Features

- **Relational Integrity:** Strict enforcment of business rules using primary keys, foreign keys, and unique constraints.
- **Patient Management:** Centralized records with unique medical record identification.
- **Surgeon Scheduling:** Availability and status-driven scheduling workflows.
- **Conflict Prevention:** Schema prepared for future PL/SQL procedures to validate double-booking scenarios.

## Tech Stack

- **Database:** Oracle Database.
- **Versioning:** Flyway integration for schema evolution.
- **Standards:** ANSI SQL and snake_case naming conventions.

## Project Structure

```text
├── sql/
│   ├── migrations/V1_...
└── README.md
```

## Roadmap

- Phase 1: Core schema design (tables, constraints, indexes)
- Phase 2: PL/SQL implementation (stored procedures for scheduling logic)
- Phase 3: Java Spring Boot API integration (REST controllers + JPA/Hibernate)
- Phase 4: Containerization with Docker for local Oracle XE setup

