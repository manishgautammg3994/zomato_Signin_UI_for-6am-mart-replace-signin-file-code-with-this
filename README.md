# zomato_Signin_UI_for-6am-mart-replace-signin-file-code-with-this
# sorry for TYPEOS
REmember You Will Tell Me the Response Status Code Like 200(Success) , 404 (not found) .....

## Full Alorithm for All 3 new Api's (ALL 3 API ENDPOINS)
* Check User Exists
* Send OTP 
* Verify OTP and Login

# Listen Read me First  this Part just Cover what we have to do or How we will Create the Endpoins that is Required
## we will not modify any Old Api endpoint but we will create our new endpoinas you said
## A New cocept for Login With Phone And OTP Considering Default TimeOut for OTP in App is 60 Second After that we can Request New  (Taking 4 Character in OTP)
: Check User Exists
* First Visit Or Create A New Endpoint To Check Whether the Phone Exists In DB
```
/api/v1/auth/isregistred
```
* Type Of Request GET 
* query parameter 
```
{'phone': "+919876543210"} //Phone No with country code and + in String format , hope you got
```
* Response Needed Should be =>Response Body should  have
```
"is_phone_exists" : "exists"
```
OR
```
"is_phone_exists" : "not_exists"
```
or
```
error case whatever you like but remember tell me first because i will pass that as it is in APP (Like Banned / Limited)
```

## I think above Concept can be done Easly it is Just a cRud for DB, Lets Proceed For Further Part means Verifying OTP  , Also I want to Know How Much Character That OTP Has 4 or 6
* As i Found There is 4 Character in OTP So Four Boxes will be there (Input Box in App For OTP )


//////////////////////////////////////////////
: Send OTP (consdering above ERROR Case say Limited or Blocked) This Is Just a Backend Call to generate OTP from Backend And Send on SIM Mobile
or Say Contact Number (Remember don't Send OTP IN RESPONSE)
```
/api/v1/auth/generateotp
```
* type of Request GET
```
{'phone': "+919876543210"} //Phone No with country code and + in String format , hope you got
```
* Response Needed Should be =>Response Body should  have
```
"issent" : "true"
```
OR
```
"issent" : "false" // with Error Case if SO some are below
```

```
error case whatever you like but remember tell me first because i will pass that as it is in APP (Like Banned / Limited)

/////////////////////////////////////////////////////
Verify OTP and Login
```
api/v1/auth/verify-otp
```

* Type Of Request POST
POST REQUEST body parameters
```
{'phone': "+919876543210", 'otp': "1234"}  //what ever the 4 digit otp is but in String Format like Phone
```
* the response can contain Error case if we enter wrong OTP and also If USER is not Registered Already say SignUp'ed







/////// I will Tell THIS Later/// the Response of post if Otp is Valid then =>
"token", "f_name", "l_name" and other stuffs




```

# //////////////////////At Total
error case response Starts With
```
{errors: [{code:')
```
message Starts with
```
{message'
```
