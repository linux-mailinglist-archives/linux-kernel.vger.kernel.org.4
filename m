Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724E370C763
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjEVT2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjEVT2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:28:51 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20709.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::709])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F267E9;
        Mon, 22 May 2023 12:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/Q4aSvmoO+AlF0pT9UfPRgsvwCbYQF1zvb96e2VkZOMDgY29w5Pu8V6NIPeOYXLyxTQu9nIiOaC2PcmMBnDXs1JYk5ni8ib47ugaTmzPl4WbI/51gNmFeTVgyoMVJa6+go3RSjSirYqZHhk37gmVG0JPQpYQMwYvtcAgmTM6v/02eR5XXz/FzNFdMzf6znpVHrQD5xUA28br/wXf0Jgjfm6Tsb0MvPJ1Rej9RnQEqU8ahZJmE1Gzjo5ekG5wVc5fA4ACG7esp5J8EB/UGPZ88AzryAepRHyX45mlPZ5FnctLjmTDfkbvEw2wiz/mRjsDOEpin2Yy+dfHarXMqRmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPBw7O2WxiADGaddLsCHjZ9gktsyN7O8oZ3G61GILHY=;
 b=X3WzFs9vXBVZsWcnPLNMjQH8OdfB1+v0zua0YSVIhfTIdvmR3g9t5sAGCX1XoELNE99cL28wtGM2ORvxDefLIRkjdEnrOxWPz/qwGoDJYCwKLw9pkbb0IxlUNDTNAxHwSkYtfnou3jx45aeURgxkvahHZb9wpnmiJZl6I1sOk3iKLgw5D6THraP8DiQiKjg7qmyMHxYFLKzIZepFsWYouXC1G0AKYebZACkdvQqJ/kpKUYn1aYQs+zC63c1YAe8sYbf8UbMJo6Tunnh/ZiF4852J0B5QQ9X506wME6OhwgNl7Np5IhfkJx9o7e3wkK5LlK9yLZphM/HaMfyTa8EKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPBw7O2WxiADGaddLsCHjZ9gktsyN7O8oZ3G61GILHY=;
 b=A0OxyF88zXNT8sL/bepMAgC6wc/S2jz6kTAmQL2LDY9Sba9kKD2ZTAzdMv1flJ8hSaE1YsbClrXAjwiFJT/8LY4VhMym44qDf0d9PW4VU7hIrHRHFpDr2XWJw5Wk4azmNgrmEzSAdZJsqFvWwmKgcQuUZVJRJ0uwJKvs076PaqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by GVXPR02MB8301.eurprd02.prod.outlook.com (2603:10a6:150:6d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 19:28:42 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 19:28:42 +0000
Message-ID: <abe0b7f7-19de-605b-e1b1-c62930052894@axentia.se>
Date:   Mon, 22 May 2023 21:28:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: PWM regression causing failures with the pwm-atmel driver
Content-Language: sv-SE
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
References: <7e2cfb55-e39f-2e5c-7f43-e1d275428bb5@axentia.se>
 <20230522172358.bw677efyovbrfwjg@pengutronix.de>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20230522172358.bw677efyovbrfwjg@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0045.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::8)
 To AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|GVXPR02MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: c9135156-700c-4419-a42a-08db5afac09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XU60x6d79tprM+VXzO64iJQkxjfsUzEGwqixSztLS8M+ipLmvYcBzjo9G3XrAHH1TDE+e1hr5J+qMJVXjiL7/HM/5mXnLAqRlOYv8X0vXd3lGiZKZMjMKUztdKbP7tQevWhmNQVaYquLqkZx2y+/tmAcWk+zkOiiKU1PFZ9yvia/SDKKoPrxKY+IzOEEQA0vqY/k2d1iHj6PkjJKEzm1fHsIqgKkHoy3NQlFWg7OR3yokHN9SArGcYYBlkhsoUBgsdyLOE4eEjBLs30hgRvH813HmIkrjA0Ppsp7fztviVEcUG60blvByeLdf8soWAARMbnK4SuYGNah6rJYDCBViapy9eycAmPRtaxv/ImDHo57pIqWBGxhwNbyLH5Y1A87kQACJxC7KiZICLk/BHbRMeYoWo/nUt8fo6JETMFsr9+CHmgfbFKWWE1pFE1PEmjwl+8u+uIMt0ywelMYrtGgjQwIADfpW8HUoRHG4BXEopxLMkUd08i72lb/r80sJYOWCJnX7+AZSiZOTWmII00sdjnqB6aURsdgosHUIwR+iFYQrvGDp88+Qep7VI7kI9ulrrJ6C/HfoV6DhFtT47rvggjrFa7D9C78W/Xazth2+pAsYYRWDHrsQxzb2SEXiU6MtLJ2cBJAo0mJkU3C40xtCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39840400004)(136003)(451199021)(5660300002)(8936002)(8676002)(86362001)(26005)(6512007)(6506007)(2906002)(83380400001)(66574015)(2616005)(36756003)(186003)(6916009)(66556008)(66476007)(4326008)(66946007)(316002)(31686004)(54906003)(478600001)(38100700002)(31696002)(6486002)(41300700001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXBMTndFUmw1Q0JLeVB0WVlRZngxRkExZm4wQ3BDRlkvdTl3SzBGMXl3d1ow?=
 =?utf-8?B?YVo1bjBRekUreWxlZHZYd3ZmOWZzdllXY3I5TUEyQmFMeXJhREFkQStJTnhJ?=
 =?utf-8?B?K1Q1dFAxUlpLdk1td2FMejViUWJZWVFZNVV2aktoWFBUTFp2Q2p6NzlmeFFt?=
 =?utf-8?B?OGFxRWJ5eFlzeHF1NzkxZXl0OGUxZEZNYTJ6dlJ4U1ZBY0M2RCtmTEVqL2JQ?=
 =?utf-8?B?RnpkcEp6OC8xZVRaLzBEbTFSY1E3WTdYVGtNd2t1TUlrYThabTVmaCtrRUt1?=
 =?utf-8?B?SVJaYjd4WWloYkVKbCtpUUZGSUYrM3R4VnVkSVdRaVpqVHFTbnBOR2RpNTBB?=
 =?utf-8?B?VXFrTGdpM284K2RLU0hNbm1rV1V5bmI4ZUhpVitQTkVlRWsvNHJLRTljU3pM?=
 =?utf-8?B?YWgzaWg5bXE1MFVKN3FLVUZUZVRvTEhHTm04L01xR2dzWE1BT09SRVhKdTZk?=
 =?utf-8?B?emVZQnJsazF0K0lUWmp2a0N6eU45ZU83Q3Y2UkI2OVJUczBSVkhweVRxam4r?=
 =?utf-8?B?TnlWOGZxenRvVjFSWDc1RUFrNGZTMTdIaldGc0tEZW1NZ25DSXdCbTdJc0dY?=
 =?utf-8?B?QWVJVGU1Qkh2dTJuWDUwUWFRb2NrZHRhYWZ3eGNBTnVBU3psTjF6ZVN0a2xH?=
 =?utf-8?B?alJzOW9xdXJiMEpMWHF5SEV5SkpFdHpXYUhwVTlBUjhUWjJ1MTlocWhDeGZF?=
 =?utf-8?B?alBmWmo0ZkdvdlJPeE51Tnp2K0tjcDJiY2Nodmw0Y2lPWnJnc1NMTmE3eWFS?=
 =?utf-8?B?YUtpc2FkMTZhMmV1T29oZTZDNUlWN25CMVV3L2pDenRpQW53bU1rVUlSazlq?=
 =?utf-8?B?Tk5MMmlURWRUUWhmdnVRTEpmUU83NTlEYXpnNlI5K2VJQ1lBSzVtUXQySm1G?=
 =?utf-8?B?YVdZTlNjLzNRbHprcEZvcGxPa1ZHR3BLNWRpT0MzVEtRVGlRbFRuYzBGNFNV?=
 =?utf-8?B?SDJXendjaVdDK2dTc0RwUDNTYzFNZmQrQnRSTFA0V2IrdGZsVWlPdmFWQ0lt?=
 =?utf-8?B?L0lPTi9jYWRsTnN3YnZOdE1TTnVYQmcrYlRraWZ2NlAvN29XdGdVN2NrdXZr?=
 =?utf-8?B?ZU9SZ0h1Ynp0amFST0hTTzZNdlcxK1I4c1BSMS95U0NKd0hHWGNLR3J5QjFF?=
 =?utf-8?B?Nk5QZ2J6UkRSNnZJYWtZNG1HV0hkNGdBVTVFWGJFaHBVMDBWOHVuRHNOVXJ0?=
 =?utf-8?B?YUdTQ0xKOHRDZTZUQmxiT0VETVN4czJ3S2RxZ3lWNXhLaGprRlRVUzQ4NXR2?=
 =?utf-8?B?ZDQycXV6L2IwYi96YXJuMThhSWpUREkxcktZWDNLM1R0NVhEMjNjT3FzSkQ0?=
 =?utf-8?B?QUFnK0Z6VzNFRTVNMzNLSHRDSVFEOUg3cDJmSWZmaVdYSzBXUXYzb09lbHRN?=
 =?utf-8?B?UmRiQ1FxOERPL09mdWtFTHg4OTRKWG8wbTVTWTgrZUszWjlaRHRvdDFnQWdY?=
 =?utf-8?B?ODdjZDJLdWxtY1cvejFoY21xWnR3NUJyc0crejBCcHBwMFpJS0E5VjF1RUxN?=
 =?utf-8?B?NjFLekkrcHBJZGozTnpCREkyd0dROU5ZaitOcE16Tks0Y2kvTnVBZzZ3a2JM?=
 =?utf-8?B?eExGa05KN2RqaHV1c1pGMjh1MHU4U0p6MURXbVlDeUNJWHpROHFwVmw2SlFh?=
 =?utf-8?B?VCtrQ0lXeXVqZGRmdFExSTd0Z1E2dDV3OUc0cUNQS3RTSkJYbXdzdkErY3V0?=
 =?utf-8?B?K3RHT01wbC82RTNCdThBWkxaWWtPbnVXZ2IvOUVBU0ZHRmI1R3U0MkRYTDZ4?=
 =?utf-8?B?Um44YkszZlUxTStLSGdjMm1URDdmN3BISjJvUzBHZlZtUnFXa0lWU0FQZHRF?=
 =?utf-8?B?ZklBUStaOE1VVE5vTk5WTUhYNE1IOXdMaFJlaUdBT0NmbE1EVm45NUk5Y1Y3?=
 =?utf-8?B?bmtqSktGTXNBcXVJRFpaM1NxRnF2VlNVNTFSOWg1VE9abFpkYkdvcG5Vbzkv?=
 =?utf-8?B?WUJwdEtJR2ZVSS8yRmUyTkxaQVFnQ25UTUl3SUN3aFFnRWJXYjNBZTJkMk05?=
 =?utf-8?B?MWNxVThYenhsa3Q0N2NRMC9Sa1ZMZldCWkRCdFNqd0JXdUhIaVc2Vk8wd3Ru?=
 =?utf-8?B?VFNONk9lN0dlZmlyQjBvbFJ0NVg3bC9rUEZmdFZTNGY3T09hS1Iwb0k4ZExJ?=
 =?utf-8?Q?FhIMMUvgYtG+5Os8bxjczcC1R?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c9135156-700c-4419-a42a-08db5afac09c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 19:28:42.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQO5y6feW2TJz+WtW85JyXmGMyIPxanLhC7N8hVSQd6N7eDdQ6B+NkqOqXebssJM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB8301
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-05-22 at 19:23, Uwe Kleine-König wrote:
> Hello Peter,
> 
> On Mon, May 22, 2023 at 05:19:43PM +0200, Peter Rosin wrote:
>> I have a device with a "sound card" that has an amplifier that needs
>> an extra boost when high amplification is requested. This extra
>> boost is controlled with a pwm-regulator.
>>
>> As of commit c73a3107624d ("pwm: Handle .get_state() failures") this
>> device no longer works. I have tracked the problem to an unfortunate
>> interaction between the underlying PWM driver and the PWM core.
>>
>> The driver is drivers/pwm/pwm-atmel.c which has difficulties getting
>> the period and/or duty_cycle from the HW when the PWM is not enabled.
>> Because of this, I think, the driver does not fill in .period and
>> .duty_cycle at all in atmel_pwm_get_state() unless the PWM is enabled.
>>
>> However, the PWM core is not expecting these fields to be left as-is,
>> at least not in pwm_adjust_config(), and its local state variable on
>> the stack ends up with whatever crap was on the stack on entry for
>> these fields. That fails spectacularly when the function continues to
>> do math on these uninitialized values.
>>
>> In particular, I find this in the kernel log when a bad kernel runs:
>> pwm-regulator: probe of reg-ana failed with error -22
>>
>> Before commit c73a3107624d this was a silent failure, and the situation
>> "repaired itself" when the PWM was later reprogrammed, at least for my
>> case. After that commit, the failure is fatal and the "sound card"
>> fails to come up at all.
>>
>>
>> I see a couple of adjustments that could be made.
>>
>> 1. Zero out some fields in the driver:
>>
>> @@ -390,4 +390,6 @@ static int atmel_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>  		state->enabled = true;
>>  	} else {
>> +		state->period = 0;
>> +		state->duty_cycle = 0;
>>  		state->enabled = false;
>>  	}
> 
> I don't particularily like that. While state->period is an invalid
> value, IMHO enabled = false is enough information from the driver's POV.

This was the preferred approach of Thierry, and given the number of
call sites for pwm_get_state with a local variable, I can sympathize
with that view. At the same time, fixing drivers one by one is not
a fun game, so I can certainly see that approach 3 also has an appeal.
  
>> 2. Don't try to "adjust" a disabled PWM:
>>
>> @@ -656,7 +656,7 @@ int pwm_adjust_config(struct pwm_device *pwm)
>>  	 * In either case, we setup the new period and polarity, and assign a
>>  	 * duty cycle of 0.
>>  	 */
>> -	if (!state.period) {
>> +	if (!state.enabled || !state.period) {
>>  		state.duty_cycle = 0;
>>  		state.period = pargs.period;
>>  		state.polarity = pargs.polarity;
> 
> In my book code that calls pwm_get_state() should consider .period
> (and .duty_cycle) undefined if .enabled is false. So this hunk is an

I agree fully. This feels like a good hunk.

> improvement. Having said that, I think pwm_adjust_config() has a strange
> semantic. I don't understand when you would want to call it, and it only
> has one caller (i.e. pwm-regulator).

I believe it's for a case where some bootstrap/bootloader has configured
a PWM in order to set up a regulator for some critical component, and the
kernel needs to cake over the responsibility seamlessly, or everything
will take a dive. I deduced that from the description of pwm_adjust_config:

 * This function will adjust the PWM config to the PWM arguments provided
 * by the DT or PWM lookup table. This is particularly useful to adapt
 * the bootloader config to the Linux one.

But what do I know?

> So another option would be
> 
> diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
> index b64d99695b84..418aff0ddbed 100644
> --- a/drivers/regulator/pwm-regulator.c
> +++ b/drivers/regulator/pwm-regulator.c
> @@ -368,10 +368,6 @@ static int pwm_regulator_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = pwm_adjust_config(drvdata->pwm);
> -	if (ret)
> -		return ret;
> -
>  	regulator = devm_regulator_register(&pdev->dev,
>  					    &drvdata->desc, &config);
>  	if (IS_ERR(regulator)) {
> 
> and drop pwm_adjust_config() as a followup?!

As described above, I think that might be too drastic?

>> 3. Zero out the state before calling pwm_get_state:
>>
>> @@ -115,7 +115,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
>>  	}
>>  
>>  	if (pwm->chip->ops->get_state) {
>> -		struct pwm_state state;
>> +		struct pwm_state state = { .enabled = true };
> 
> I wonder why you picked .enabled = true here but = false on all other
> code locations.

Silly typo, soory.

> Also you don't seem to have 1271a7b98e7989ba6bb978e14403fc84efe16e13
> which has the same effect and is included in v6.3 and v6.2.13.

Right, approach 3 felt so ugly and intrusive that I didn't bother to take
it beyond the problematic commit (and hinted at that further down: "It also
needs a rebase from the culprit commit"). Having said that, 1271a7b98e79 is
not enough, or else I would never have noticed the problem in the first
place. I don't think the hunk in pwm_dbg_show() makes any difference for my
case since I heven't enabled debugging, and a double-check confirms it:
After 1271a7b98e79, zeroing "state" in pwm_adjust_config() is enough to kill
this regression.

So, given that approach 3 is already half done, it no longer feels as ugly
and intrusive and more like just following the path forward.

Pros and cons, pros and cons. 1, 2, 3, don't know what to do. But hmm, it's
not some annoying "any two of three" crap, and it's actually possible and
not entirely unreasonable to do all three...

I'll let someonw else pick and choose. I have no strong preference.

Cheers,
Peter
