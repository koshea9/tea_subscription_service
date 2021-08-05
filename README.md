# Tea Subscription Service Description
> A back end API for a fictious Tea Subscription application

## Versions
- Ruby 2.5.3

## Database Schema

![Tea_Subscription](https://user-images.githubusercontent.com/24997456/128367696-ce2ea8ab-91f8-4b15-9619-6842ec96bf9d.png)


[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/15482583-9dc40f00-6990-4c1e-9c67-e3fccaffb3ad?action=collection%2Ffork&collection-url=entityId%3D15482583-9dc40f00-6990-4c1e-9c67-e3fccaffb3ad%26entityType%3Dcollection%26workspaceId%3Ddb127735-43ee-4855-a194-4ccf5766f947)

#### GET Customer's Subscriptions (active and cancelled)

##### Resource URL
```
http://localhost:3000/api/v1/customers/:id/subscriptions
```

Example Response:    
```json
{
    "data": [
        {
            "id": "12",
            "type": "subscription",
            "attributes": {
                "title": "Gongmei subscription",
                "price": "13.93",
                "status": "cancelled",
                "frequency": "quarterly"
            }
        },
        {
            "id": "16",
            "type": "subscription",
            "attributes": {
                "title": "Post Test subscription",
                "price": "9.99",
                "status": "active",
                "frequency": "monthly"
            }
        }
    ]
}
```
#### POST Customer's New Subscription 

##### Resource URL
```
http://localhost:3000/api/v1/customers/40/subscriptions
```
Request Parameters:
| Request Parameter | Description | Required? |
| --- | --- | --- |
| **Title** string | Title of subscription | Yes - must be sent in body of request |
| **Price** string | Price of subscription | Yes - must be sent in body of request |
| **Frequency** string | Frequency of subscription (weekly, monthly or quarterly) | Yes - must be sent in body of request |
| **Tea_id** string | Id of tea subscribing to | Yes - must be sent in body of request |
| **Customer_id** string | Id of customer subscribing | Yes - must be sent in body of request |


Example Request:
```json
{
  "title": "Post Test subscription",
  "price": 9.99,
  "frequency": "monthly",
  "tea_id": 12,
  "customer_id": 40
}```

Example Response:
   
```json
{
    "data": {
        "id": "18",
        "type": "subscription",
        "attributes": {
            "title": "Post Test subscription",
            "price": "9.99",
            "status": "active",
            "frequency": "monthly"
        }
    }
}
```
#### PATCH Cancel Customer Subscription

##### Resource URL
```
http://localhost:3000/api/v1/subscriptions/:id
```
Request Parameters:
| Request Parameter | Description | Required? |
| --- | --- | --- |
| **Status** string | cancelled | Yes - must be sent in body of request |


Example Request:
```json
{
  "status": "cancelled"
}
```

Example Response:
    
```json
{
    "data": {
        "id": "19",
        "type": "subscription",
        "attributes": {
            "title": "Post Test 2 subscription",
            "price": "11.99",
            "status": "cancelled",
            "frequency": "monthly"
        }
    }
}
```

## Development setup

1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{create, migrate, seed}`
4. Run test suite with `bundle exec rspec`
