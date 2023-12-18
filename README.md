# api-integration

Built handler for syncing inventory for defined fetching periods. 

Handler ensures the rate limit of the fetch api is never breached.

Application is hosted. URL : `https://api-integration-wg09.onrender.com`

Slots endpoint : `https://api-integration-wg09.onrender.com/api/v1/experience/<productID>/slots?date=<YYYY-MM-DD>`

Dates endpoint : `https://api-integration-wg09.onrender.com/api/v1/experience/<productID>/dates/`


`<productID>` is either 14 or 15. Dates are valid for the next 60 days.
