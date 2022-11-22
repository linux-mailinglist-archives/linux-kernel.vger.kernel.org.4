Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413636335F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiKVHj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiKVHjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:39:22 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130082.outbound.protection.outlook.com [40.107.13.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E3413F63;
        Mon, 21 Nov 2022 23:39:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPzU67N26Np4zd30zuqaswfzPtKRkSt1fullyhse9qOTtWv1wQLi0jSKkzBsALYa0cn/RU+ZO2Mi7jNdx40YeLzj4eVy7xjD0Z8aSYjHnAytuhKkzDzYsLZGLuOhsj3fxFVQ4q0RkesjnlTFmwpT3cytCizO77z3WZ3x7W6Lgn4VU3etpvebdnN4j8SR2NNEPnhvfnFrNPqOxmle2ui9pqcfkDhmnukQu/VB5TYrEInaAD03pm/pxDqySk8CQUDzYjWE3Rdn4gFjCyWow7NFZMo8VhEGSyv5WkKaSOewj5fhA7RINmba6osmP8f5dXRswpd3ilU87O0/6mdUGV8w+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYXmiK/x2FsdVsmxLWWDay6WlFyS+ouqJ7rm/iUx5pU=;
 b=MyuZnyxpRDIYCcTzCVThsOd5TyWXo/Q324Ty0cxe15sXMlbs/YCLr+dB9DKj0oVPMXxKrhwLd31+vUJNbnzk+GD6d816cz+IMVxajKg9SSs6O3/K4Eh5KiKRC1DG5iCiCx+NVqV/xQEiKQmiQPtQ0VNO0IqzEYSOciiopa1hPokOdhgHfM3dbs+0HX44qfqDLH0B9khfCVn3K9Sl2OhuZM/F/pGFC9nxNdBdMgfDIrVj95xrb8M4cEV/wDOXfITaqbFUjKuVDNwKyFPOo2B9B4xsclP08kHL2E+zZbksr55HMK0sJGU6NlCR9O/Lz9sfZpbazZQ6bTasZXKEh+sN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYXmiK/x2FsdVsmxLWWDay6WlFyS+ouqJ7rm/iUx5pU=;
 b=rgZ9+VR6fZbe7mThV5DTyhCbd0+He6BCcFdY6dzuRL7k3bT6kbrHIcQuHVlnO4BjmV+hAy/nGkua0XDeCuatdF0vnXBF3Gmpsmi9QTm2pizjvQ1aOa+boQNwWdU3NlRmBiJoAhcih0FvXJo/QUEylhJ/tjy8Ud3nVHLbqMSVbrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by DBBPR08MB6313.eurprd08.prod.outlook.com (2603:10a6:10:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Tue, 22 Nov
 2022 07:39:18 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5857.017; Tue, 22 Nov 2022
 07:39:18 +0000
Message-ID: <031c895d-4694-96c2-62bb-e43a49001cd9@wolfvision.net>
Date:   Tue, 22 Nov 2022 08:39:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
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
 <96a632c2-7ac1-7b9d-0cb0-9874ae21a8eb@wolfvision.net>
 <Y3vGNVZcSuILCHxW@smile.fi.intel.com>
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <Y3vGNVZcSuILCHxW@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0195.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::16) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|DBBPR08MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 3088ee10-0c7e-401b-a95a-08dacc5ca98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GujZ/hbIsjWcVemBwu72F+02GOsmA4nNvqKSErtDG+betpxH58LC+0QeDdLtx2cbVqzZt/wF4biKB2dGGcniK6L0FCWc8PTsci2PgZ2A5Ejat5g3CPLhm2XWDvIl/azZn2CWTysKK65KR0IiYlm2wRXAq1BUmD13n80Ys+eNk+N8qCdjvUulncak4uuCb3xbJz0O07lfkHjXV0rovoV/Q6vcqvCPLRE9AIKsc6F96361tEqgOEGkBCQ67cer8+BU7cXgqj5TeRBdvA0klVpso9FQ0LRlb7ptGNl5MTJiXVuVxc0qIzEvPspRXiAdndhwEL3JLV9ciSWRot0R3hAJmNaUVudA6tnOEk1AW7mLQzmyKaYEhgZmX4Om//uUhjPwOVC93lWIguflyKRlJIMzuLBR0O3EYSx/kEWk5vQ83YDjGRFr5unrjKChrLxUOt7TA/WYTXj+sPlmrl3Fzs2NPrGs22AItBlAlc5pIDOPIuOUTLgNixHrJjc1bDXTumx30uHOG2a4mLNDSyy8XfhbrrTfJ48umVIQ6LX1jTp4z+arGO+y00VX3EfI1Tc2r3fjVXOO3P7kOep3Xyn95z7Tc5U0A5wdqFAGFXzxQNmbbCbQZPY5Q7Zt4KlGIeHnW+8n0+h1irR2FneZMn6Oz5KJLAQLLwg7f6hRw3Kvg5qHXI5UP437V6jG2zXksaE+ZFaAmpLvqnk5pMnk/l/fmnZqfNtCnw3fJV1jglYT0d1J/AIS7ApoPuq8KTBv8DTNW8sS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39850400004)(451199015)(41300700001)(31686004)(316002)(7416002)(44832011)(8936002)(6916009)(5660300002)(4326008)(8676002)(66556008)(54906003)(66946007)(66476007)(31696002)(36756003)(6486002)(86362001)(6666004)(478600001)(36916002)(26005)(6506007)(2906002)(6512007)(107886003)(186003)(2616005)(52116002)(38350700002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eS9mRG83R2drY2tEVTJuNmhUR1ZtZllWajlvcSt3dkF2blNFQitBNVJpYi9P?=
 =?utf-8?B?YXM4ZDU0NUVicjMrYjRSc3NpY3VHREZPS2xGS3QyM2dhNDdvOWhocXk3OEVK?=
 =?utf-8?B?akhZUFhzYlhPTDlVUXBIZ3UxOUROdW1raFVaeGJtY2szeW5XOUs2endYNjBz?=
 =?utf-8?B?V0FEZnh2WW95M3V3ZTBIaUFUakhTelltMTFmd2pqQ2J5QXJqQ25pRk1TbFM0?=
 =?utf-8?B?UnZNUHhYR0NHVGdlVEViQ0pHOHdsWFNSR3IySE9DOFhxSVQ0Uko3LzdLOStN?=
 =?utf-8?B?M3NBVXFlSlNzYzc3ZWFBWFFCK3lJazhGOFljRDd4bEp1djlyQkx0aW14QTNW?=
 =?utf-8?B?bkZZVHdFZjVqcmY2d1hHQytHdDJpTE16bXR0b0pHMzcvTkE2eUxZcnN5RXhQ?=
 =?utf-8?B?aEpjNVUwZnV0MkJ2cUxSaDNMTFZBQ29nMW9vQTNvdWtqMmFZWmI2bFhPTm5y?=
 =?utf-8?B?SVhBUEtLMlZLSmRma05tOXNoKzM0M3hOVnB6RnNSc0ZQZ1VtYms2WW1IekZC?=
 =?utf-8?B?aVBkMEZ5OFU4WU91ZjJuRVNMQ1lEWU1FUnl4TzVnYXpsNnlLM0FtWVlOcnhF?=
 =?utf-8?B?dHI1bGVZRXp4VnN5ZWxlNEdzV0VlUFhrY0JKSkRsNkt2M29GTi9ac1UzRnZP?=
 =?utf-8?B?dTM1dWVnUEJld3FvSUdhdkpTS1g2cmE1SHJqVmFHSXR5bFk5YkVSb1hrQXEw?=
 =?utf-8?B?eFhlV1JRcG5aVjAybkprY1FRblFMK2pnVzYxaWY3bkdCZGY3L0kwTkVTSUNG?=
 =?utf-8?B?d211WXlXT3VmZWdsNUg4WFBXRW1nZ2MvWmVNZGF5UjFvY3FkclRhZ0thT3d4?=
 =?utf-8?B?VUw5aHZ6aWI1TWYvazZvZVRPVllEZnJrVzJCWk9NMmRtWmhWbnZobE93a0ND?=
 =?utf-8?B?YzFFdDNTODdBcUZsVk5ZMW56S1VhZ0lIY25hdURlOHV2VmpwczZ3bENuMVhX?=
 =?utf-8?B?UEE3Z2FFWmV3Q1R1OTA3MkN0QUpWaU90WVYyaFNFMkhBL0Nrby9UckpMRHJ5?=
 =?utf-8?B?QVduR01UNGh1c3o2eENWMkFpLzMyQngvVTVtY29LMzFrdmgvRkRsY1lWNFJp?=
 =?utf-8?B?dWcrTXI1NGFFcjF5L2dNdlVpcUVkY0FpYVFETW9jS1kzTGYydlYyUEZWdHJu?=
 =?utf-8?B?Wk5sZWlza1pzMFZDbzJac0I5YXlGcDRoTHlpYXdQa0FFaXBiNU9rK2dOeTBm?=
 =?utf-8?B?dm84WStXWldZN3BrY3hLNW9kQ0lVb2FpcEhLSkg3ZjRQVktMNy9JazhJaVZ3?=
 =?utf-8?B?OTlFK29NKzAyZFh1SXp0YTJEaFIvLzA0NkFRY25ETUhVUHZMRXR2VzgxTkhD?=
 =?utf-8?B?aUVTNHJucTliODdkRFA4dHc0MkNhbk5FS0N4ZWI5TEQrRml6NTV2ZXVkamIx?=
 =?utf-8?B?d0hKb2RwYU5JTS9UTzd0enlILzBJcnlZaFFQMldaQVRSc2U5NTVtUXZnb3lQ?=
 =?utf-8?B?dnhwT0wyVjlRNWVCdm9SalcyeUVhQWFVNlRjU0VIOHVZQS9ScjFGMDg2YjFm?=
 =?utf-8?B?TVNTbmhZcGlOY3ZSOWxTeGtJc210dTZGYXBUWHBkcHNSLzVLVDZYUXlJc2V0?=
 =?utf-8?B?NDdhV0xkR003MzQrOGM2RGlIQVo5Vmw2bllCQU04bHU0M2c3SGRDYmlHT1dY?=
 =?utf-8?B?cTVzckFkNC9Wb1NMQzNKZXZoYnB2cFdvcXhqZGE5TFR5c21YRDJmTW9GQlE4?=
 =?utf-8?B?L1k3aUlHZWk5VXBPUS9tTS9UYkF2T1dRbm9USmRnTU02UGJZMXZ3TVVrSHVn?=
 =?utf-8?B?VlFCcktydmRoeVBkc0pUcHhXdVlUbk5RZThwNXVDMFBtdWZJYmpCYUJIYjJj?=
 =?utf-8?B?VjVjVmliTEIxektQUitDUXIxMzRrOVE5bGg3a2hjeUtQYnYzSGw0OWFZTWNU?=
 =?utf-8?B?eW1IcCtBczloNkdPaXh3V3pjUGhON1pDb3NRWGNjcTBxNGlsa3dka0pyZ3V3?=
 =?utf-8?B?aTRIQWg5SW1JREJOWlp6SXdYVW00d01LcDVzVUFWWVVjYmF1bng1RVhnVU45?=
 =?utf-8?B?U094MFcvbFI3UzU3amlGQmlvdGZCQStoc3ZQeEpoaEE4YWxacFhBbWdrM3Uz?=
 =?utf-8?B?TXI2dVo2Zkh1cGk5NmZBVTdERjAwUzFHSTdKcmF4Y3h6aVhrdHpkeE5ETlQ2?=
 =?utf-8?B?UjNaajUwUmlZYVFpc21rdVh0MEQ0bEdTNTM3VVNhTW1adUYrWkVPZGJobVNM?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3088ee10-0c7e-401b-a95a-08dacc5ca98f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 07:39:18.2824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHoKuEkpEQZ2ggXJ/E9nv5+o7D2fZNAHWAocG9ooaqWdIPHuw2uFJvtGEqWm7mPo5tlgu6e7YZdDK2VD6sucDxSPbYWc7MSImxREcLwuNYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 21.11.2022 um 19:40 schrieb Andy Shevchenko:
> On Mon, Nov 21, 2022 at 06:24:18PM +0100, Gerald Loacker wrote:
>> Am 21.11.2022 um 15:04 schrieb Andy Shevchenko:
>>> On Mon, Nov 21, 2022 at 01:35:42PM +0100, Gerald Loacker wrote:
> 
> ...
> 
>>>> +	if (!device_property_read_string(data->dev, "ti,angle-measurement",
>>>> +					 &angle_measurement)) {
>>>> +		if (!strcmp(angle_measurement, "off"))
>>>> +			data->angle_measurement = TMAG5273_ANGLE_EN_OFF;
>>>> +		else if (!strcmp(angle_measurement, "x-y"))
>>>> +			data->angle_measurement = TMAG5273_ANGLE_EN_X_Y;
>>>> +		else if (!strcmp(angle_measurement, "y-z"))
>>>> +			data->angle_measurement = TMAG5273_ANGLE_EN_Y_Z;
>>>> +		else if (!strcmp(angle_measurement, "x-z"))
>>>> +			data->angle_measurement = TMAG5273_ANGLE_EN_X_Z;
>>>> +		else
>>>> +			dev_warn(data->dev,
>>>> +				 "failed to read angle-measurement\n");
>>>
>>> Can't you use match_string()?
>>>
>>
>> Yes, I will use match_string().
>>
>>> And you actually can do a bit differently, can you?
>>>
>>> 	angle_measurement = "...default...";
>>> 	if (device_property_...)
>>> 		dev_warn(data->dev, "failed to read angle-measurement\n");
>>
>> I think we shouldn't warn here, as angle_measurement isn't a required
>> property. Besides that I will do it this way.
>>
>>> 	ret = match_string();
>>> 	if (ret < 0)
>>> 		dev_warn(data->dev, "invalid angle-measurement value\n");
>>> 	else
>>> 		data->angle_measurement = ret;
>>>
>>>> +	}
> 
> After looking into DT patch I think you can even use
> device_property_match_string(),
> 
> ...
> 

device_property_match_string() is searching only for one string, so here
match_string() you suggested before fits better.

Regards,
Gerald

