Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEA3632AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKURYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKURYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:24:30 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150072.outbound.protection.outlook.com [40.107.15.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C5713FB8;
        Mon, 21 Nov 2022 09:24:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8HRVMLBK83AezmZCcSbgHvdp26eyOZhtjHZuXExpqhpfoczel/8aiDvTLvXLVgZTUqdgCuIJg/9fR07Z4r1Xa4MGJUaLmh1+BdvpXJ7mtsHEeKCRShy9AuyGGN1mB5BDqTW15jVddt4+QDzBGDxvw4Mmo3QPWCjgek2/k7rIO0sV6OhQMEvpxfm4EiRq1x8eBikkBc4KTUqZn8Bu7BrV8dR20JORP+Dttm9tNMfk39bqvLYDxEARNvfx6IMpsiXmD1U5VtYh9vQ0a812jRYioNnpEZrDsxQxdYjxiIvAHQKJxyNWuxGfqdhDD2f3QGQDknGW1gJVi2HsNSVHIZzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6tx/Hs9wq90Xc81LLwTot2kdqxYDLo7kz59lA1teQo=;
 b=JoxT2nYGrkJgXPYXBju7+uBfxjmQ0hyTsVn/4/vQ9nrhA1/fQsyylS/DPwXJOZ9sygqxBt2rXqvErwXjxHG0sT0SAlHJZq0XcQpeJhrSjs2+c+IDMaBvrbQqMrIuixaaxObx1AFg04AftlPp3YmB80v8qqhyrtUVJd8F4qWJo7kUV+UI0L8nbgRJqNZa66I3KFkygW7NRHDuAuhSyzxaBPZkLmFrEJ0aBVBX1HwZr2jr5jGp+3QywnskQSqr3g1cF9dWIzo+pLfCy6lcNdTqUcSGBpVOVSvBJ98lulS6frdtnDh9o3sxF7Y/oXWizu3beKiVeXgEZtu+4nP/CqgD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6tx/Hs9wq90Xc81LLwTot2kdqxYDLo7kz59lA1teQo=;
 b=AN9MVPmqgSsBbdtXvRKxDE3CEOU6Vrbp7FBpyFuPyl4EPBfUQ/w/fEitbmmyuZQQs/iT6q9a7eAfMRkFmcr6rmGj1l61BV10tEpMSMvJDDXyByLuij6bPLn8BGEqlTQwdeVoe9Kp61YG4FKBA1Xk79qPX1YimMswy5iTFEsdLgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DBBPR08MB4539.eurprd08.prod.outlook.com (2603:10a6:10:cf::22)
 by GV1PR08MB8177.eurprd08.prod.outlook.com (2603:10a6:150:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Mon, 21 Nov
 2022 17:24:24 +0000
Received: from DBBPR08MB4539.eurprd08.prod.outlook.com
 ([fe80::accc:569b:7a2c:6eba]) by DBBPR08MB4539.eurprd08.prod.outlook.com
 ([fe80::accc:569b:7a2c:6eba%7]) with mapi id 15.20.5857.017; Mon, 21 Nov 2022
 17:24:24 +0000
Message-ID: <96a632c2-7ac1-7b9d-0cb0-9874ae21a8eb@wolfvision.net>
Date:   Mon, 21 Nov 2022 18:24:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add ti tmag5273 driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20221121123542.1322367-1-gerald.loacker@wolfvision.net>
 <20221121123542.1322367-3-gerald.loacker@wolfvision.net>
 <Y3uFWH5GV/x7UDcP@smile.fi.intel.com>
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <Y3uFWH5GV/x7UDcP@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0103.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::32) To DBBPR08MB4539.eurprd08.prod.outlook.com
 (2603:10a6:10:cf::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB4539:EE_|GV1PR08MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 471ee5c8-4af1-4fdf-c4d3-08dacbe53bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGgle5zDR8Zk+ozZkJ+ZB8R6V29Krz8DeCNdm6iCmjZs/h+kbwxNbUOX46m4W+1ffyb1/tHWIrAVvXFKh51Qjkn9vLis6VeUFTZPXre3DXUF1/0dhjP8y6INsDP+o6LbmW8h/vL3yyhAcmvZuP9FPQF84BqG8zuva/iRCDE5bTp99Ck9S8YPQKwRQdnSvKokoBpyM9HDgTXzP0k3OwHM+FppXjO2Aq0mQxScDfW/c3k7+4evUD3Ef860hjPY2UCMzl0dQEDposQ+PUDZ2k/kK+sW+wqhS6GmwnHV+0mKpQdp0ACW0E5bL6ZGiICboRA2qpDxi2xwJ3aG3u0RRrAK5Tyf1TSBkBtAXKGr4Pza3mmZkPP4mP+VsRHi3ysjvtFCcGDH/s6LRnLFgHeQxfkGpgmxQ3M0FETPh7YeRjIJyutdnlpIDUhKDd4UMC5JSo5H8ZGyiuRLoa0X4PWJxTFyOU4gvk0ZKWPamcMNgfVJoCawoBDnr9BOLhvKD0S8MlP6YRwSDMx7ppDycYze3DgdlDO9Apg91H79JIqlEB0kQbUTlpSjXD83SMzMyMb6YwDD7DjKzApYeS4qDmV85dhXZG8rnAluWBxBXP87F/ELM9z2V88Qyiyfft+n7PZSEuYjCfGoH4EJ8YIFNAgaFS+OtLpfhBaF3ly3i7jHzfw/VIUwtdNQcP04obNDtIBM1Q2KT3EA3kThPBydar3TtWZLeEu3J5ZlwBWjciHKiX/L4C9faJJIqwpVkPbGYAbqU4So
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4539.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39850400004)(376002)(366004)(396003)(451199015)(2906002)(31686004)(6666004)(6512007)(6506007)(478600001)(52116002)(6486002)(36916002)(83380400001)(8936002)(44832011)(7416002)(5660300002)(107886003)(41300700001)(86362001)(31696002)(38350700002)(26005)(38100700002)(186003)(6916009)(2616005)(54906003)(316002)(66556008)(36756003)(8676002)(4326008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnpPVGJlSWE2SmlRd3dsd1FkTGhJQzVPekUzdlJTNmJSTW9SUUdyTWNEekd6?=
 =?utf-8?B?MTFTNnFLUXhTNE9oMjR3ZmU1RTdJMkpTM2Nkd0dmQXhLclB3bkhPWW12OEIz?=
 =?utf-8?B?bnFMbWZvT1FYN2FQYk9EVzJOcmh0UVZPTFk0cDBmZWpDU09aWFNyWmlQQkZu?=
 =?utf-8?B?cU5ERGppbXRLMDRzUmZqdGI1eEN0T2ZOY3FJUVdkSEs0QkFtdlJTTm4zdzNr?=
 =?utf-8?B?UWx0N2lPSzJYQ0xXSklVZWFKS3lOM2xkUXMxeHh2a095dWR1aEo0enpnREJI?=
 =?utf-8?B?N2ZMSCtRYzlxNHYrSmxwVEJybFdDdEtVVklzcTlKN1c1bzlsZzZYSVJCMjhS?=
 =?utf-8?B?anJIVmI3L0hPcGN1NFNaUXlnc0YydEovSlhEaGpiUGs2T1Frb0NBdi80dTVE?=
 =?utf-8?B?VmFlMVdwNHhkdXlkNExlWlJkc0I3ZDZBQjdzbE9lcHhFWjdCVEFtUGp0SFVM?=
 =?utf-8?B?cUpnS2xOd09NQzZsTmJ0SUZ5ZHJtaTM1UTMxVDVFdjJMUGdsUnRyb1lWNVVE?=
 =?utf-8?B?bkJreXhSazYrQVQ3ZVBnRmV4RFFIdVIvcnkrWVZ0ZFhlc2c2ODRsRk0rcUVO?=
 =?utf-8?B?amxON1lFN3BrekZHYWFFd2kvL1BJaWEvbHdpbXBpQ24vM0Q2Q0hZVStRQTA2?=
 =?utf-8?B?YTdEVERSdm9sWWV6RWZ5SGpJa1Zxc3JUc0tsWngxQUJZU1YzMXZWYUswVXho?=
 =?utf-8?B?cnlnYzMxVjZTa2pGOXNXOUNEcjZubHEyTHNqV3A2NFF6RXI3WnQzbUpzczVu?=
 =?utf-8?B?eFJtb3pQTzRUbG5mK2RNU3Q5QU90Q3RRbFFkaEdUVm9DL1ljQU9MSTZ1TUFJ?=
 =?utf-8?B?cWNGTmlFOGoxMHdXY0w3ZjVPOU5MY255YnpwNTg5QktsRVg3WW9YaFE3bGJl?=
 =?utf-8?B?c2JHOWxkVXRqTkVSYlFUT1NmMXRVZU5ST2lNSGljYzdtYWw2bGtXTjJ6QytD?=
 =?utf-8?B?SkFTVVlpRWNMRVpWZ3VEQXRFV2JsVTNuMzEwcWJvL0hOY0gydlM2NGVHL04z?=
 =?utf-8?B?YzExcXpHaDdmdlhrakVMbmlZSVlvR0JvQjRmNm1vK1BmMlRxQjY3SkFCQU1D?=
 =?utf-8?B?V0NZQ01JdGZqVzZUUFI1cXBPZ3hzVzY5OHhmQzlwWVdQQTRqdkRjVUZhcXlk?=
 =?utf-8?B?cEZTN2cyaW5NaFlKcUZYTFlOZE5xRDlEQUEvSURsa3B0WU1NaDV0WDVNZHV3?=
 =?utf-8?B?MGxQa2MyM2wycGFsRnBrMklnM0JvZXU2NmxpQ0RlZThGLzE4RG5hQWdLWGg1?=
 =?utf-8?B?dWdPeCsrOTFnZEZHZERIVGUwRDZJdlpORzB2S0dpa2c1Tmpyem0xS2pCNGZl?=
 =?utf-8?B?UVVJcE0vRi9sengvUERvbjV4LytZWEw3NlN4czBGNWhmYVJ4cUxJcmFuY0J1?=
 =?utf-8?B?L2x2ZHJyTXRlNTFLb2J3U3ZGNDJza0Nqazg3OVZvWUlBUnk1NjRuVERuMnpD?=
 =?utf-8?B?MlpJVkZaRmNhNGZadXI3dWFvZXBZVGorRjdUK0R6RjR5SkpablRIOWNVTVJa?=
 =?utf-8?B?bmVQMzFmdE1GNGVLUmkxbHFQYy96cXJ1Njc4dUNhREJrK0FINmxnd3FnakRq?=
 =?utf-8?B?dmFxYlJvOFBpVytGbWgvWWtNaVhuZUV3WHZadllvTWZEVnJabTdPU2dDSVFW?=
 =?utf-8?B?SXZpMVRLWWJkTEowTElYc2s3NWFCRE5jbDdSY2xxMEhaUjNsWm4ybk8rRTQ0?=
 =?utf-8?B?WmVDMTNBZ01tUW9PUkFxWEs2VStYQWZYbzhJY3ZTL3YvMkkra3RvekNpeG10?=
 =?utf-8?B?UDgvR0RQN2NQamlzaE9odDkweXk3Nytoc3hNbnNRUlhCSlNoZlI3QzFZeVJj?=
 =?utf-8?B?SG5iaDF2YThhQUVpcXMrK3F0RnFnZjBIUnpFMFprVnVSNFRsbWlmNFB1cjZs?=
 =?utf-8?B?K2dUUEY0ZXhqcDZ4VFpkcXlrU0FwNnZaUXVvWVlteEdlOWR4VzJFelJlYWwz?=
 =?utf-8?B?S2lXYyszZG90RzRCZjZPZk5SQWVZR3gvbGZ1YjRIcVRYUEVtSlAySWEyM2Rj?=
 =?utf-8?B?QUdNWUZQdWRBcVV6STFkY2JBT1VubmVXWG45eUZLTWROb1JNTzQ3NW9ORXZw?=
 =?utf-8?B?dG5uUEhGaWRIVXBTaXoveFIwenhOLzNRWUQ1R1puOE0zWmVrNkJqcjg4Y05p?=
 =?utf-8?B?QTA0UUxsWElQOW1oRmZuZFBpSmE4WE41ZTJHQ1JwdkpRcGlLQU1xMUErVXJE?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 471ee5c8-4af1-4fdf-c4d3-08dacbe53bf3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4539.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 17:24:24.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3isQJIo74+FTYTNqcIS7DXEzUZ7t1AdhX/strnBy7s+pVs+NJgyoWU1crsZrnMbrur2upx6EyfB4Y1MvIZ2XeXbaRhWbW/4pfa+quBRPzRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 21.11.2022 um 15:04 schrieb Andy Shevchenko:
> On Mon, Nov 21, 2022 at 01:35:42PM +0100, Gerald Loacker wrote:
>> Add support for TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor.
>> Additionally to temperature and magnetic X, Y and Z-axes the angle and
>> magnitude are reported.
>> The sensor is operating in continuous measurement mode and changes to sleep
>> mode if not used for 5 seconds.
> 
> Thank you for an update! My comments below.
> (I believe the next version will be ready for inclusion)
> 
> ...
> 
>> +/*
>> + * bits in the TMAG5273_MANUFACTURER_ID_LSB / MSB register
>> + * 16-bit read-only unique manufacturer ID
> 
> Is it ASCII or not? ('TI' suggests something...)
> If it is, please put it in the comments explicitly in ASCII.
> 

Ok, got it.

>> + */
>> +#define TMAG5273_MANUFACTURER_ID	 0x5449
> 
> ...
> 
>> +#define TMAG5273_MAG_CH_EN_X_Y_Z	 0x07
> 
> This is hexadecimal, while below you are using decimal values.
> Also if this is like above, isn't it a bit mask? (Otherwise
> using decimal value hints that it's probably not)
> 

Ok, I will use decimal value. It's not a bit mask, as there are special
modes (XYX, ...) defined as well. I didn't want to list all 12 configs,
but this could clarify this.

> 
> ...
> 
>> +static const struct {
>> +	unsigned int scale_int;
>> +	unsigned int scale_micro;
> 
> Can we have a separate patch to define this one eventually in the (one of) IIO
> generic headers? It's a bit pity that every new driver seems to reinvent the
> wheel.
> 

I'll try to find a solution.

>> +} tmag5273_scale_table[4][2] = {
>> +	{ { 0, 0 }, { 0, 0 } },
>> +	{ { 0, 12200 }, { 0, 24400 } },
>> +	{ { 0, 40600 }, { 0, 81200 } },
>> +	{ { 0, 0 }, { 0, 0 } },
>> +};
> 
> You probably can reformat there to have fixed-width columns to see better the
> pairs of the values. And as I told you before, 4 is not needed (AFAIR, or 2 in
> the square brackets).
> 

Ok, got it.

>> +			for (i = 0; i < ARRAY_SIZE(tmag5273_scale_table[0]);
>> +			     i++) {
> 
> I would definitely go with one line here.
> 
>> +				if (tmag5273_scale_table[data->version][i]
>> +					    .scale_micro == val2)
> 
> Ugly indentation.
> 

You're right, best to rename tmag5273_scale_table to tmag5273_scale.

> ...
> 
>> +	if (!device_property_read_string(data->dev, "ti,angle-measurement",
>> +					 &angle_measurement)) {
>> +		if (!strcmp(angle_measurement, "off"))
>> +			data->angle_measurement = TMAG5273_ANGLE_EN_OFF;
>> +		else if (!strcmp(angle_measurement, "x-y"))
>> +			data->angle_measurement = TMAG5273_ANGLE_EN_X_Y;
>> +		else if (!strcmp(angle_measurement, "y-z"))
>> +			data->angle_measurement = TMAG5273_ANGLE_EN_Y_Z;
>> +		else if (!strcmp(angle_measurement, "x-z"))
>> +			data->angle_measurement = TMAG5273_ANGLE_EN_X_Z;
>> +		else
>> +			dev_warn(data->dev,
>> +				 "failed to read angle-measurement\n");
> 
> Can't you use match_string()?
> 

Yes, I will use match_string().

> And you actually can do a bit differently, can you?
> 
> 	angle_measurement = "...default...";
> 	if (device_property_...)
> 		dev_warn(data->dev, "failed to read angle-measurement\n");

I think we shouldn't warn here, as angle_measurement isn't a required
property. Besides that I will do it this way.

> 	ret = match_string();
> 	if (ret < 0)
> 		dev_warn(data->dev, "invalid angle-measurement value\n");
> 	else
> 		data->angle_measurement = ret;
> 
>> +	}
> 
> ...
> 
>> +	switch (data->devid) {
>> +	case TMAG5273_MANUFACTURER_ID:
>> +		snprintf(data->name, sizeof(data->name), "tmag5273x%1u",
> 
> There is a difference between %1u and %.1u. And I believe you wanted the
> latter, but...
> 

%1u works fine for me. Can you point me to the documentation for %.1u?

>> +			 data->version);
>> +		if (data->version < 1 || data->version > 2)
>> +			dev_warn(data->dev, "Unsupported device version 0x%x\n",
>> +				 data->version);
> 
> ...with the current approach you may replace above with
> 
> 			dev_warn(data->dev, "Unsupported device %s\n", data->name);
> 

Ok, fine.

>> +		break;
>> +	default:
>> +		dev_warn(data->dev, "Unknown device ID 0x%x\n", data->devid);
>> +		break;
>> +	}
> 
> ...
> 

Others are clear.

Thanks,
Gerald
