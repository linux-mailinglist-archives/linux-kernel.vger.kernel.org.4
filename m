Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8327663A9FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiK1NtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiK1NtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:49:00 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B361EC40;
        Mon, 28 Nov 2022 05:48:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlmiRL9Hhp06em7hhPPqfDiLVEdt39ViYHjC5diVR30/6fR7xzhD/MQkoLuM/Q67nozRJCCNX+fDsbRrzZizXjo4IjwcCb9v2B+JBh5pOSXa2xx1e3a7jUl2eCZpGfYo9CMI/a6Rd+oZdcTFgnGiOfPpBJHUAyewvDw/5RJvRMrpynLwRKSnM1HabBfl2g+3T3VWY/jU2CjNj3N3Au2lEQRHgzq8yerKmNFExUh9rm3iNiH+WNaITPTI9d94rPK0/GrFcnNQSPxwHlX2pRlHCCK63kHzz4bhKwVAQVU3NLI/UYwY1P22YQI9wndQOwpexid+NybpTVqjLiPlyCgNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCqkWY9Tn15NzpkhI/RhVzzqfL12frHJvPa70pOV+/4=;
 b=NALSG0BcqnNlXQQ04I+1K1r2QLjLAnb0hQMyz64fyJPp8uY42DQNXbqoTGEUEW8dckEyFwcZU+dLBpFk9/sz9u3/3YdDl3VR68xEQ0uJpTT3nk/SEZgxXhUMeRBd37wWoWyBC3egw3RmdRtaScz6jQWxnSOrd+jfo2ubaeUtm6jaBOJmnXTC0/wE34c5srbLa+rQjRJlGdd2jDwdEGcLcX7LK+OB2rZJET59/wqei1RkHeRkf7gcaXrsLEDOlc0O57RUiHq3cwNPEthn2Av5lBIGBpL1aD6hLuiTfXjGKFPjosF4kl8MpNtmoCfoYH9HLPE/FOotVZXnJKWBvWGZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCqkWY9Tn15NzpkhI/RhVzzqfL12frHJvPa70pOV+/4=;
 b=DTlvkmK1n/xJ4tPWxYBaRG/CBx884f71uSsyLUDJ/LO6Gj9WWoyxUsnd84BbMPxk03f2hizo4gLFexG4ogJlA0FFP6MdzVH6LkHZFYcExa9miItb00x4IYEjZukyVCc1JZJperN23HS27hqauftpyOIyUaJPqrX8c9P/yaYHUhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS2PR08MB9426.eurprd08.prod.outlook.com (2603:10a6:20b:5ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.7; Mon, 28 Nov
 2022 13:48:53 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637%2]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 13:48:53 +0000
Message-ID: <4d1b0054-efd4-e10e-17a6-d236052afa49@wolfvision.net>
Date:   Mon, 28 Nov 2022 14:48:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/3] iio: add struct declarations for iio types
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
References: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
 <20221125083526.2422900-2-gerald.loacker@wolfvision.net>
 <Y4CcspD1xkmhmWbh@smile.fi.intel.com> <Y4CgiMd4XQMV4KFV@smile.fi.intel.com>
 <a55e73f7-4daf-6892-34dc-61c6f6581d8e@wolfvision.net>
 <Y4S3WnYWVnmiVFc+@smile.fi.intel.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <Y4S3WnYWVnmiVFc+@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0035.eurprd09.prod.outlook.com
 (2603:10a6:802:1::24) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS2PR08MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4cb62e-f422-43b5-d9e2-08dad1474846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpMAFXIndvwQO7UKp1+yJ4uD8KZ2HREQzEVbWyR1aGH5LVJH3gHohF6C5wnXsKJj2+yuBg+Fs/uA6XdF/EZfHSIVzGPRTJiV+a/05kclAispWKu7KZl64YSFsVsDzKdq3nSUWoi+Y0QCXBR3coXlAIb/vPWZy3V9d8YQPjIDhGRClKpq8JC6oRwaRDDgAQIf2hq/5GCBNZSGcuxBLbWDLLSVdh1HnyR8w3n0wUkb+N9f73QDSAJ/g9jW+zbsMJ/qqdA+kqklJM6riKIAFlX0a1ej1DpthOWWjmNWGmEuY8EfkNwr2renk1y4wmqQk8AQHfW2P6CyYq8j6fK9ufMOTCY3lpWHB80Nd1HjXU8B8z9s2WOXCDu2TLfqKImtBY8NldYK7hOeHEb7rwz6XDgZFp4uJEMEQrM+99iprYJ0fbjcn4RZOD6ntdcKF4XpGH+u/SITZTpBzMjtuaH5x0FHrMuGMCfIl7y8HQfHnsfQq+3MbhG8dIBwvA4MkE5HthyLf6vB4qYtgnF2YQhU1ea8fdDexJLakhR1JIcmvhKRlZClhCqGtS9/f0PUf9kXP40hkctlin5or4aFRdnn7sXhEUPjh0RN3pNmdr2IE57IAq6YHieg6rHFhNxhtJDcjbqdsvnGJ4clzgMb6vYID0i9uJtvZHI1pAYdObwHAnE2dc6EbEfaedmKUhA5MaPIEWztUKxvGH+ki1QLY81VUK/U8naCotswvsLF+vOwcNtYR4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39850400004)(366004)(451199015)(31686004)(2906002)(86362001)(66946007)(66476007)(7416002)(8936002)(44832011)(5660300002)(41300700001)(8676002)(4326008)(31696002)(36756003)(316002)(110136005)(6636002)(478600001)(38100700002)(66556008)(6486002)(6512007)(6506007)(2616005)(6666004)(54906003)(52116002)(53546011)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEkySkhIREZWdkt5UDAxK01JTE9HNTZCWFE2cjVlVTE2dFRSckpoNEVPYSsx?=
 =?utf-8?B?dStVaWZCV0ovb0tXVEZPbGdkZVk2bVgvK1I0RXdjcURnNnRsNkJWOXZ3WHdz?=
 =?utf-8?B?eDRsc2FUMDZpYTMzK2RLbEpXbTl6Y3lsVTJYbllMakxqWEpQQVJZaGdyVGNu?=
 =?utf-8?B?MWRrV24yRG5KV2tJUnd4RkM1QmU2RWVuZnRwaFZFcUswQmZMMU5SbzMxQjNL?=
 =?utf-8?B?V09iNkNibmZaOS9MTFdFQ1phVHExR2NIMUtWa3FGZHZ4UlNtMUVTNUJXMzNE?=
 =?utf-8?B?SG9UYUQ3MEFyVnJXM1VCTWVJU0MxWkZaL245MWg5UG5JRmVoRjFJQlZSY0lL?=
 =?utf-8?B?RUg2Tk5GWlZScVJBS3k1MFRRbkFrZzQrblM5S3RGckU4MkNsdW5md2R0ZE9z?=
 =?utf-8?B?WUo5L3FFYWJtSEZXZ3A5TmVYYzFvZ044YUw3eWxuRERBTVR2TnBlSVhtQzNW?=
 =?utf-8?B?dUtpMDl4N1pXdGgwcm5TY2VsWG1BZEJmMXVjS0xWNUR2U2dwNHgzK0NwZEFn?=
 =?utf-8?B?cFZaUEJLcFBXL1JPL28xdXBiYnFzbVBsMytZQVJiRHdSTEE1cHFDRlNuTGVi?=
 =?utf-8?B?N0VMRWV5a2hteDEzWkhQOUJLcmk0SUlzRGVLSDZaZ3pkTDlBd0Vhd1J3SEZ1?=
 =?utf-8?B?cGtLSDRndksvN1ZLQWN3REhEOG1wWTcvU0xFRSt3Z3hIeDJkQ0RlaGQ1MUNr?=
 =?utf-8?B?ZE1oZUEvMytCZEhUUm1YMDZPUTNNV3JBS1JiR25yTmRac2ttbWxzTHJxY2p0?=
 =?utf-8?B?ekJWbWh6T1dNb05ZaWZIZHI0WXd1T1MwdWlmM1UwSnUwdGJEWkdGYlBmK3hr?=
 =?utf-8?B?UkhzWEphZ1JJbjltSXcwVGF6NDN4M3lNSzN0WnFTZWdZcVJPZkRkdHNlUGta?=
 =?utf-8?B?NTVrSEE0UzZ6YkZvN3JjSTE5TTJjODM1cURhUng1YVhCNmtRMjM1b1lVYnVu?=
 =?utf-8?B?YlZuRHFWMC9SSEwyKzhpcCs5TUsvOGNOZW5idXp2dDhUaDlOMWhSZE9PaTJT?=
 =?utf-8?B?TlNGSDVlYTNCMmxxOFhmWmdZbkEyL1lUcC9oMENIdlRPdU1ON0JIVlpDVkJJ?=
 =?utf-8?B?YlJ5ZXZGV0k0cjZwaGd5WStBaXZpbWVPUmpHeDJUWC9YYk5WbUtqSUpkVk03?=
 =?utf-8?B?UHNnUGdXa0E0VnI4TkwybEtOb1k2TU5VTmZrWVVKaUk3M1o0UjFkZlZlOGZj?=
 =?utf-8?B?dGxleGRKd250MzhTSDRzcmM4eDlWY1FGQk5DaFNkMWZ2U09BT3FmRFRtR1lZ?=
 =?utf-8?B?ZVcyN0UvWCs5NWFWYW03ajJ0ZzhvQVFuZU9qNzQrbTZLOUxmaVdSUy81NmVl?=
 =?utf-8?B?NnZOVkVybEJUcmxIZ1JGTU5hL1hpL256YWRjaE42OS83U0ZzZnp1bUNCOStD?=
 =?utf-8?B?S0ZqNW5aRFpwS1lCNEs4NTc0UUhnUEtTR2xZQXRwdC9VZ3cwcW84NXBOblV3?=
 =?utf-8?B?MDBuWk10RTBwUUhvMlJBbnBYUGoreDdTdStUZG1JdnhoOEpQL1dUYTQvaHJl?=
 =?utf-8?B?aWhKbVVpRWt5cDF1UHhBdUhiaTM2YTNHOGV5cG56ZzVYT3gvWCtsRzBBVnpu?=
 =?utf-8?B?cFg5NHh3VTJ6UHQ4dWZ0Tkkwdm9JcjQyT2gyQjc3YXk5KzFHeDJCOG1DbjQ5?=
 =?utf-8?B?Y2pVQmJ2eEkrSUZ2VWQ4RHg2UENFU1NqZHlJbzNrVUtoNHlsdnE5R0dYQ1li?=
 =?utf-8?B?Z251SkEraDNDRDZYeEdZcncxaEZPU0ZsTENSUThDNTRGdE5GZjMvMWhxYWtp?=
 =?utf-8?B?dnZhb3JpZEJXdzlqWHVIRnVuVG9pS2tYNnBqWmtHeVpNOFREU0hwN0ZkQmdi?=
 =?utf-8?B?WXhLcmJLUDE4clZla1Y3TDFkanRsaUpwdXlqQjQ2eEdCanBXME9CVEFqVGRJ?=
 =?utf-8?B?QmNVS1NyU3hrRDgyaG84K3BjU3hOdE9sOGZpT1JQWnBNSmQxR0FWWnpBMER4?=
 =?utf-8?B?OVhqTzlTeHFzL2cwdjltcFo1WkgyUzR4dHhlNGZodVpwNnhHaUtBOHlLNXN1?=
 =?utf-8?B?bjRneVh0c0t3aDgvajk0YUJDLzZld1BDTlVhTUlIQ1NveDFvSlI3dGpVTmJN?=
 =?utf-8?B?cngzVmtQMVhjanIxNE5SeEVzd2FFMk8vY1IybWRkU3pLYnc5cTA2MDNUMCt4?=
 =?utf-8?B?NXNyTFNudXVDTmdZQ2E5QVQ1VDNtTFdpdkN2d3AxeXEvVEF0RjN4c0JzcVJp?=
 =?utf-8?B?QS8xeUUzanV0OUIxWGRwSElIOFo4S0lnRG54d05qQ3kxMlB2U2x3N2YzdTRG?=
 =?utf-8?B?aTZiczhzY0g5Z3RENlpBSWlJSFBnPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4cb62e-f422-43b5-d9e2-08dad1474846
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 13:48:53.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKBeR6siQ+KIc5cCwVwPWYi7y8vHmOx/AT+EEpkSfHI5mOdpffzC1NnTuJTjY1SBbtg0B7KwSyLXrww+hKGkl6PhpkQBtCtN4gVDPRfDU+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9426
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerald, Andy,

On 11/28/22 14:27, Andy Shevchenko wrote:
> On Mon, Nov 28, 2022 at 01:18:04PM +0100, Gerald Loacker wrote:
>> Am 25.11.2022 um 12:01 schrieb Andy Shevchenko:
>>> On Fri, Nov 25, 2022 at 12:45:06PM +0200, Andy Shevchenko wrote:
>>>> On Fri, Nov 25, 2022 at 09:35:24AM +0100, Gerald Loacker wrote:
> 
> ...
> 
>>>>> +struct iio_val_int_plus_micro {
>>>>> +	int val_int;
>>>>> +	int val_micro;
>>>>> +};
>>>
>>> Thinking more about naming, why not drop val_ completely?
>>>
>>> 	int integer;
>>> 	int micro;
>>>
>>> ?
>>
>> Yes, this sounds good to me. I think of adding only
>>
>> 	typedef struct {
>> 		int integer;
>> 		int micro;
>> 	} iio_val_int_plus_micro;

I think we actually want

struct iio_val_int_plus_micro {
	int integer;
	int micro;
};

here, right?

>> for now, and one can add similar structures when needed, like
>>
>> 	typedef struct {
>> 		int integer;
>> 		int nano;
>> 	} iio_val_int_plus_nano;

+1 for introducing things when they are actually used.

> It's a rule to use _t for typedef:s in the kernel. That's why
> I suggested to leave struct definition and only typedef the same structures
> (existing) to new names (if needed).

Andy, excuse our ignorance but we are not sure how this typedef approach
is supposed to look like...

>> or
> 
>> 	typedef iio_val_int_plus_micro iio_val_int_plus_micro_db;

... because

#include <stdio.h>

struct iio_val_int_plus_micro {
	int integer;
	int micro;
};

typedef iio_val_int_plus_micro iio_val_int_plus_micro_db;

int main()
{
  struct iio_val_int_plus_micro a = { .integer = 100, .micro = 10, };
  struct iio_val_int_plus_micro_db b = { .integer = 20, .micro = 10, };
  return 0;
}

won't compile.

> This is better as explained above.
> 
>> If you think it's better to add them all, I can do that, of course.

Anyway, seeing that only struct iio_val_int_plus_micro is used at the
moment, I believe the best path forward is to introduce only this struct
and move on.

Best regards,
Michael

>>>>> +struct iio_val_int_plus_nano {
>>>>> +	int val_int;
>>>>> +	int val_nano;
>>>>> +};
>>>>> +
>>>>> +struct iio_val_int_plus_micro_db {
>>>>> +	int val_int;
>>>>
>>>> 	int val_int_db; ?
>>>>
>>>>> +	int val_micro_db;
>>>>> +};
>>>>
>>>> Actually why can't we simply do
>>>>
>>>> typedef iio_val_int_plus_micro_db iio_val_int_plus_micro;
>>>>
>>>> ?
> 
