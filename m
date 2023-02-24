Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630436A1513
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBXCuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXCuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:50:01 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2114.outbound.protection.outlook.com [40.107.117.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9535839CC7;
        Thu, 23 Feb 2023 18:49:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xk4PkDtl6w0D0kw45fFJigrjryhxiGSlIlCmOMqTuX4548S0ctLz6EtjvZ+TXCHB8bBIRlckRp0c/ijTqTSks2AamEzLre4VctP6G3B/0EPFAtO7bCkTMHRsm6EMF1BThLheZ90nbbPnWbA7lBl/VByR306SZTpwsTwabvrElT39W2FV7BB/WygbG5w6hUlE1ZUVibUUj5QkQ3HKGwGeuJseSqsb/fTpYiZN67PodaYzmJeUtkkYJTMBn/UT6oreDTMDMQ6RC4z2/xJsImVvZyEoR7TM33j6hCLKw3tBfyFyvFkSdsgph6SRAJG0ht3SoJGex48ZGJ2cW6DoUfD6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCtGoQIfo10m6T50qM/hk3IgQOWrRcdBhUexp+R+X+Y=;
 b=NJVHDb45knuksmPhpdtEzNBikzdAdaPuMQmBXDgWedPXbenNEAiR/3LtCw7MYzz2iJ3R6/XcHqfXcP+8dUhEOmJRMSMXirEG/i+PD5o5gPSz52NP2XnErjdqvOFkilZUe7buEH7aghjlaCP8A47Ua3RdI7UhH66SMyreSqnq3gaG+ShlN+kygGHROgPg7fmZ9pi5DIoSljz1L8Y2q7DnQGBGWBywlJeFZbKg6mywucN64TvrhToc4ux7zZUBnlZdROrb+HZhLVNfZCP0Wygv71xqLnwbN55ObOsMgJ1Wsgc0tfQ/BdM+nZNfrW8f5/f0UBw0cna0bLvBWxW2vJpknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PSAPR03MB6329.apcprd03.prod.outlook.com (2603:1096:301:5a::9)
 by SI2PR03MB5241.apcprd03.prod.outlook.com (2603:1096:4:ed::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21; Fri, 24 Feb 2023 02:49:14 +0000
Received: from PSAPR03MB6329.apcprd03.prod.outlook.com
 ([fe80::f5b8:7820:4802:70fe]) by PSAPR03MB6329.apcprd03.prod.outlook.com
 ([fe80::f5b8:7820:4802:70fe%8]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 02:49:13 +0000
Message-ID: <4deec176-135f-f49f-0b04-f5b45ec691cb@amlogic.com>
Date:   Fri, 24 Feb 2023 10:49:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] clk: meson: vid-pll-div: added meson_vid_pll_div_ops
 support to enable vid_pll_div to meet clock setting requirements, especially
 for late chip
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230223062723.4770-1-yu.tu@amlogic.com>
 <1jv8jsoerm.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jv8jsoerm.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To PSAPR03MB6329.apcprd03.prod.outlook.com (2603:1096:301:5a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR03MB6329:EE_|SI2PR03MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ebcf4fc-5c4e-4fdf-e40f-08db1611b5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ka0qC7skySaSxl93oQSmGyRmTZu6YZGHHr0LFQUTV8ASyaXKFSofAxebRoncn88kO6f8oHgvhagOeDMKokFpvc8Ku4nKb9KNHdgVGIY2T0mrTqQnAkBId3moM6VJESbvW6r8ULBasmdSG8qjQnrGqlnSwCVw5gNDUplheuGU1GVhpGyFcKEG6sV/xuI1QpiI/kYn8svax5vfWp/4AQyzRcDRPKSUKG8ehzAHoVAaj9+69jp58jnloY+UJTEQEEKPCY6oZt7rR4A+HygY4IlN3zhTpYcd6jyEb1mznkZ2ambf6alXzfbCqWOzO8aC/lM6QByu+v2n3NjVDg167JS4n+blVdRu3/Q5c0pD5vnQ+L6jUI8LeYGu5FSqVb65cKudxXBa0wsjjva+oIG7dStqrs5scewIFvKlpapEZ7eSgz1zNRrJdmRJjhV5DrUag9OZxKXIRkl/VKMYUg497F5edJfNOM9OfI722fyCtraRADH73E8UEGR5sPODjnK2Zj1xuGpRWrXxSEkkJSTJ4i2UFernkzwp94neE+Hx4OjVyB/PoKEyulqdetVEnM2f6Pa9Mqm6SO8I58mDS+OvmgmMiFaxl3ipQz4FDCFxce9Ls0OlNw31wPnHezfcQVWsSdrsIW4Ljn936wyMqX6koe8A7rCBzqhhqgAYTvpXoOeT+fNgCucLyYw+X9SdNCS0wgoTvrQKIL31dQBL6bYFqegfK+AE7dZsDCDqVKMgb9fKB+11nV5AchEl1ECXZZKCQqpg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6329.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(396003)(39850400004)(376002)(451199018)(6506007)(6512007)(53546011)(86362001)(316002)(44832011)(31696002)(5660300002)(66556008)(66946007)(66476007)(8936002)(7416002)(4326008)(8676002)(2906002)(6486002)(38100700002)(2616005)(478600001)(31686004)(6666004)(26005)(83380400001)(110136005)(107886003)(41300700001)(186003)(36756003)(921005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUxRZGk2UUF2U3RZc3BIbjE2OU4vci9yeXFEakdGZUY3YTZsbE8zcDlpWXhN?=
 =?utf-8?B?eEs1ZWZnQmU4SERHWFNCdElwV1NFTm8vN0tCYUNlTW1LTlZwdkxXWUtTdTZ1?=
 =?utf-8?B?cnR5b2xxRkFQek8yN016TG1Vdkt5a281Z28ycHpZQ3U4b3NzZmFSb0UvRmYz?=
 =?utf-8?B?NDI2ZGI4dFFHTWk4ZDdFT2lkNHppRlZKVFJ6R1hNbHUrSVdOZEQ0dFViSGRq?=
 =?utf-8?B?L2Q5djY4RFhoSURPQkUyU1FFZ2xQcHYyRXF1NnpJTm1jZWFZWmdCU3Znc3Qz?=
 =?utf-8?B?a2EvMlgySEFnQU8veHc1MmlUYmYvOVIxdmF4L2Z0ckZWQ3Jab3V1ODA3U1Ey?=
 =?utf-8?B?c1FDV0ZEWW5mTHNrTmowU05zb0RGaUs1dHdEWUM0YmVNVkpxcElSMjFzc0tG?=
 =?utf-8?B?ald5anlFbzRSQ3JveEpXL0FXUkhCMlRvWHFXWjA3SUQ2TWFKS21JUXppYWlN?=
 =?utf-8?B?bXM4N0JvdFVBZUozeEU3LzZBRnZEVWtLeXhsNXYrdGUxaW9hOUUvcU16MEZr?=
 =?utf-8?B?UUJkem1vZ2VDcktUMlBoMnlOb2I3bUxYekVEaXkvTDJDQWo2Tk5sK0U0Sm8y?=
 =?utf-8?B?Z3IzSSt1VVdGNTNRd2prODhFYmRwVUlCTm1NR1F5SHJIVDB4dU5VMWZCZXJL?=
 =?utf-8?B?R3M1d0FSYUl1R0phU1ExcHcyN0ZoanhRY05vSjhBYmhKb2x0V0JRb2hHM0xM?=
 =?utf-8?B?UGFlaDEzbGZhUUUwcjN3WVV4SWgxY0RhRFlQUS9TTys3TFJnS2hkNnB4ZFlx?=
 =?utf-8?B?WUtCR3pkdFJ1R2hnWkh6VVVVVUVoSUg5K0x5N0xYVTlxNzBIbmsrQjNwOGFn?=
 =?utf-8?B?T3ZNWURZd25mM0F1RkQ0K0xlcVRtZWhwV044MDFzYjN1d2Y4TzZvNFZLUEVw?=
 =?utf-8?B?dFUzdzJLZUFnTm5zMkhHOU10RUEzM2cyY0NNSERWY3p0ajRxNDhRcjYwMGha?=
 =?utf-8?B?VXBONFNkeXJvTmZBOENrekdwRVhOdmNCaWlsNDlvNDZqNnVHVlZENDdOVEox?=
 =?utf-8?B?eUtia2djcU1aaXZEcWwwcVVTM0RrVkJHRXByVVZ4NmFmK2xhZ0ROOG9lYXJD?=
 =?utf-8?B?ZUlKaGFaRytVNllYRjRhS3R2UUV4ZHFxdERWdjNLUXNVK010enFnalVhd3l6?=
 =?utf-8?B?eDVTcTdaU2Q0SkVVdWRENWlMM245SGJmMVFWNlFRU3pia202N1hKajlXclVi?=
 =?utf-8?B?UGkwV0VxUlhHaUJPbThiaFkzQllLaEIvU1Zzakx0SjlKMERvOGJCT2lodmd3?=
 =?utf-8?B?VXhaYWxva05sUEdoeGU5eHgrc3FBZDdyaWdFZlJadnIvZ2JzL01CbGZlYnJW?=
 =?utf-8?B?RzlLNS9jRGFqUFJRa3pmbVJ3UExhVFhYTklQelZKOXNUSzdTeVJuckh2SGdw?=
 =?utf-8?B?SkR5TE9qZTBmNkQ4cXNndHYveUVKdzA5MVF4UXFkcnFsSFpTczJoQzd5NGlJ?=
 =?utf-8?B?UjFDcFQ2UnVpdnkrYjhHc0xNMnpVb2JzN1MrNDRQZDdzSmZDdG80c3RGMVdE?=
 =?utf-8?B?Lzdkc1hUek9ZYkszQUJFRGpHRWFjcHAwYnRSUXpmS2l1YzgvMmJuVDBMMldl?=
 =?utf-8?B?VDFnclg0LzFUa0FYREtNazIyQllWWFMzYkJDbC9qa0lUY3JCM3ZqdGJKSHJW?=
 =?utf-8?B?Z3RwSXpwQmI2NkZRNzZWVEdnb1lVNXpjQlkrdldaaTJMN0w1YWpxelBlZ2JO?=
 =?utf-8?B?ZE1ZYmJpd3hnUnhDb2RBWFY3RUdQaTgzZGZ4SFoydE4zZEZOcEUrbzRHT0l6?=
 =?utf-8?B?RzVhTWQ3dUNteVhPV2EyTXU0b3N4UmtSL2lmK0VVL05jT2FLdHpCOTUzbzhh?=
 =?utf-8?B?VDVBUllHWFdFZGQxQXpodEpMS0R2Q0tsMG9TenlKRzZEdjhwVW95ZGZXRkE0?=
 =?utf-8?B?V2k1OUNtU3pLQTJ3Z0lxaDJsdi9ScFZ1dkk2N3lNMWgvSXROSXhGVHhMeFBM?=
 =?utf-8?B?NDA3Rkd4SGJiTzdETGNjNmx6Nm1pbTBzK21iZitYS2JlZnl5cGhQMUdSQTdt?=
 =?utf-8?B?Mi9aQ0szMUxjTHBzcnp0eGFlbmJXbGJyTGkwcTFhY3FKTHltWlNRQitWR3lI?=
 =?utf-8?B?MTN6ZzV0OHVYQnBSbGtiTDhWNFdUc2RGakxEYkJzNEx3c3QwUjZYYWo1Uk5y?=
 =?utf-8?Q?37xR473m3TlwSl7EbZ9pkBM/P?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebcf4fc-5c4e-4fdf-e40f-08db1611b5a2
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6329.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 02:49:12.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATmiwDVAAJoFzSoIDb0WDBDknIlT+prp+dOOZPyFs6kb/iHC+yQ17IL0GimeOh82WvWbB9+KmAzC5/El6930ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5241
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/23 18:11, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 

Hi Jerome,

> 
> On Thu 23 Feb 2023 at 14:27, Yu Tu <yu.tu@amlogic.com> wrote:
> 
> Title is way too long, 75 char max

I will change to "clk: meson: vid-pll-div: added meson_vid_pll_div_ops 
support". I wonder if you have a better suggestion, please let me know 
if you have.

> 
>> The previous chip only provides "ro_ops" for the vid_pll_div clock,
> 
> The driver does. Other chip could use RW ops I suppose.

Your suppose is right.

> 
>> which is not satisfied with the operation requirements of the later
>> chip for this clock, so the ops that can be set for the clock is added.
>>
> 
> What requirements ? What "late" chip ? all this is quite vague.

I will change to "Since the previous code only provides "ro_ops" for the 
vid_pll_div clock,In fact, the clock can be set. So add "ops" that can 
set the clock, especially for later chips like S4 SOC and so on."

Is that ok with you?

> 
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   drivers/clk/meson/vid-pll-div.c | 59 +++++++++++++++++++++++++++++++++
>>   drivers/clk/meson/vid-pll-div.h |  1 +
>>   2 files changed, 60 insertions(+)
>>
>> diff --git a/drivers/clk/meson/vid-pll-div.c b/drivers/clk/meson/vid-pll-div.c
>> index daff235bc763..e75fa6f75efe 100644
>> --- a/drivers/clk/meson/vid-pll-div.c
>> +++ b/drivers/clk/meson/vid-pll-div.c
>> @@ -89,6 +89,65 @@ static unsigned long meson_vid_pll_div_recalc_rate(struct clk_hw *hw,
>>   	return DIV_ROUND_UP_ULL(parent_rate * div->multiplier, div->divider);
>>   }
>>   
>> +static int meson_vid_pll_div_determine_rate(struct clk_hw *hw,
>> +					    struct clk_rate_request *req)
>> +{
>> +	unsigned long best = 0, now = 0;
>> +	unsigned int i, best_i = 0;
>> +
>> +	for (i = 0 ; i < ARRAY_SIZE(vid_pll_div_table) ; ++i) {
> 
> It would be nice to actually describe how this vid pll work so we can
> stop using precompute "magic" values and actually use the IP to its full
> capacity.

Thank you for your advice. I'm going to define a macro to represent this 
table size.

> 
>> +		now = DIV_ROUND_CLOSEST_ULL(req->best_parent_rate *
> 
> This effectively stops rate propagation. That's not how determine_rate()
> call back should work. Have a look a clk-divider.c and how it calls
> clk_hw_round_rate().
> 

I understand that this should be changed to
" parent_rate = clk_hw_round_rate(req->best_parent_hw,
				 DIV_ROUND_CLOSEST_ULL(rate * vid_pll_div_table[i].divider, 
vid_pll_div_table[i].multiplier));

now = DIV_ROUND_CLOSEST_ULL(parent_rate * 
vid_pll_div_table[i].multiplier, vid_pll_div_table[i].divider);"

I don't know if it is correct, please give me a comment.

>> +					    vid_pll_div_table[i].multiplier,
>> +					    vid_pll_div_table[i].divider);
>> +		if (req->rate == now) {
>> +			return 0;
>> +		} else if (abs(now - req->rate) < abs(best - req->rate)) {
>> +			best = now;
>> +			best_i = i;
>> +		}
>> +	}
>> +
>> +	if (best_i < ARRAY_SIZE(vid_pll_div_table))
>> +		req->rate = DIV_ROUND_CLOSEST_ULL(req->best_parent_rate *
>> +						  vid_pll_div_table[best_i].multiplier,
>> +						  vid_pll_div_table[best_i].divider);
>> +	else
> 
> What is the point of this 'if' clause ?
> It looks like the 'else' part is dead code.

I'm going to delete these.

> 
>> +		req->rate = meson_vid_pll_div_recalc_rate(hw, req->best_parent_rate);
>> +
>> +	return 0;
>> +}
>> +
>> +static int meson_vid_pll_div_set_rate(struct clk_hw *hw, unsigned long rate,
>> +				      unsigned long parent_rate)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct meson_vid_pll_div_data *pll_div = meson_vid_pll_div_data(clk);
>> +	int i;
>> +
>> +	for (i = 0 ; i < ARRAY_SIZE(vid_pll_div_table) ; ++i) {
>> +		if (DIV_ROUND_CLOSEST_ULL(parent_rate * vid_pll_div_table[i].multiplier,
>> +					  vid_pll_div_table[i].divider) == rate) {
> 
> This assumes the set_rate() is going to have a perfect match and
> otherwise fail. You should not assume that. Have a look at clk-divider.c
> for examples.

Thank you for your advice. I will do a bestdiv match like the 
clk-divider.c file.

> 
>> +			meson_parm_write(clk->map, &pll_div->val, vid_pll_div_table[i].shift_val);
>> +			meson_parm_write(clk->map, &pll_div->sel, vid_pll_div_table[i].shift_sel);
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (i >= ARRAY_SIZE(vid_pll_div_table)) {
>> +		pr_debug("%s: Invalid rate value for vid_pll_div\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +const struct clk_ops meson_vid_pll_div_ops = {
>> +	.recalc_rate	= meson_vid_pll_div_recalc_rate,
>> +	.determine_rate	= meson_vid_pll_div_determine_rate,
>> +	.set_rate	= meson_vid_pll_div_set_rate,
>> +};
>> +EXPORT_SYMBOL_GPL(meson_vid_pll_div_ops);
>> +
>>   const struct clk_ops meson_vid_pll_div_ro_ops = {
>>   	.recalc_rate	= meson_vid_pll_div_recalc_rate,
>>   };
>> diff --git a/drivers/clk/meson/vid-pll-div.h b/drivers/clk/meson/vid-pll-div.h
>> index c0128e33ccf9..3ab729b85fde 100644
>> --- a/drivers/clk/meson/vid-pll-div.h
>> +++ b/drivers/clk/meson/vid-pll-div.h
>> @@ -16,5 +16,6 @@ struct meson_vid_pll_div_data {
>>   };
>>   
>>   extern const struct clk_ops meson_vid_pll_div_ro_ops;
>> +extern const struct clk_ops meson_vid_pll_div_ops;
>>   
>>   #endif /* __MESON_VID_PLL_DIV_H */
>>
>> base-commit: 8a9fbf00acfeeeaac8efab8091bb464bd71b70ea
> 
