Welcome to your new dbt project!

### Task 1

Please see models > 3_marts > mart_trip.sql for the data model that I have developed.

Here are my thoughts on how I got there:
- I stored the json data in object storage (CloudStorage) and read it from dbt via BigQuery's external tables feature, which is also available with Redshift and S3.
- Probably best for long term performance to avoid directly reading the external table and instead ingesting it into a data warehouse first.
- I stored the remaining GSheet data in a BigQuery data warehouse to speed things up and get started with modeling.

- I realized that additional data would be helpful to answer some of the key business questions at hand and downloaded data on world cities to obtain country, latitude and longitude for each origin/destination city in the trip table
    - I am using a static dataset, a long term solution would ensure that no new cities are missed by for example integrating with a city API
- I calculated distance of each trip in km, which can further be used for grouping and investing long-distance vs. short-distance flights. Alternatively, we could use start and end times of each trip.
- We can use city and country to investigate which routes are working.
- I calculated booked revenue and number of booked seats for each trip. 
    - Number of booked seat can be contrasted with maximum seats per airplane model to make a statement about the flight utilization.
    - We can derive average price per seat and make a statement on low-cost vs. premium-cost flights (might require extra consideration of the flight length)

If I had more time, I would:
- Not hard code definitions for business metrics in my data model, but instead leverage a semantic layer (e.g. Looker)
- Make sure data is flowing efficiently between dbt layers, by for example leveraging incremental loads for the trip table
- Ensure slowly changing dimensions are treated appropriately (e.g. trip.status)
- Obtain more data:
    - data on airport's continents to separate inter-continental flights
    - info on competing flight routes on the same day
    - pricing of Air Boltic (maybe there is demand but the pricing is just not competitive? We only see who has booked but not who tried and didn't.)

### Task 2

In an ideal world with unlimited resources and tooling, I would set up a robust CI/CD process that mirrors best practices in software and data engineering:
- Maintain separate development, staging and production environments.
- Follow git-based workflow with clear branching strategy.
- Automate CI/CD pipeline:
    - 1. Open/Update PR to merge into staging: Validate code, tests and logic
    - 2. Merge PR into staging: Run CD to deploy changes to staging
    - 3. Open/Update PR to merge into production: Staging QA
    - 3. Merge PR into production: Run CD to deploy changes to production
- Add key data tests (e.g. no negative flight duration allowed).
- Document all data models and metrics.
- Set up monitoring and alerts for model failures, freshness issues and schema drift.

In the real world, I would prioritize the abovelisted list.

It usually makes sense to start small and add more complexity down the road as the business evolves:
1. Git-based workflow with dbt Cloud and dbt's built-in testing framework.
2. Define branching strategy and require code review.
3. Add monitoring via dbt artifacts and --store-failures.
4. Add staging environment with masked production data.
5. Implement data contracts.
6. Centralize metric definitions in a semantic layer (e.g. Cube, LookML, dbt Semantic Layer).
7. Add tools to track full lineage and expand alerting (e.g. MonteCarlo)

At my last company, we started with just Fivetran, dbt Cloud and GitHub. 
I set up a simple CI pipeline that ran dbt run and dbt test on every PR. 
As we scaled, I added staging datasets and built a testing framework for key metrics. 
Right now I am building monitoring with dbt artifacts that requires data producing teams 
to fix detected data quality issues in different source systems as they occur.