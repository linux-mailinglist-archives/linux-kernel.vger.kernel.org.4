Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF3E730BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 01:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjFNXyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 19:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjFNXyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:54:44 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2050.outbound.protection.outlook.com [40.92.75.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D691BC;
        Wed, 14 Jun 2023 16:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuI+fR6XHruOdGgFcND1mXBrMPjceAzOBYNOWtpYsCU2s2VQaVBXdq2iA7atfEosalFVNzyCISycNldwRKYDJ1z7xXZRCKbrX5Oq3gyBUv63mt3dONwxaz5hPfGFC4u/UFGRWSITPpEZ/zF431XZgogD4T+7BHLZMwqkPKwYFScHsL8Z0fPQHc+rciGBsWZcCiorA2d2US06laH1CFuUCHbDXFrHzJ83PFHeyZRi6hv88nFQ3uOmoXp38Ds42VzjjowYzIKKKo2RK2LIqJu2JZy2bSCjl2AheFvV2387IWpLXRBxrhAoIqpzDDaPvlnyYPMXusYRMAc87B5zuDPh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1LDLSmfskdmSNuh/yoHOIPOPeChdqsXh+9kKgl5NSA=;
 b=IGpxep0+gbkAMlX1XFH4lmsMWZRoAxlOO8zafkVY0x7IOGPGMz4hHf13uCsYnH6tMg38Y0Snv6h1aJeZGL+EjkxGDFGFIT9SkEp+isjfKzwunGEObhMjdOShfcuC3oEdSIdsO8RaISMAg3HyirsEZbw8LzzcwCjt5AUZ9B8Q4Pa6zPgfB4sphujuFbb1iG5TciKbAv1F1mTiwBv2XCS5cDCVCFQjCaqjF1MDLqHLQJPrOXJ+uXUxl3WrfkRKjrNpHht8A2Q8LFne+6zrB3e85CyhQ+TuVItFgRdFPVWrLFQr+uc1ZOVXDdXOgrxHsM66eJwYPmg4Xvibt3vavb8aCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1LDLSmfskdmSNuh/yoHOIPOPeChdqsXh+9kKgl5NSA=;
 b=b9MB9mu5Iq1S5y3TAy7jvfLR6erIFFcs0ealVrEgJQNRru9T/YeRyI5XPnMDLS1Btc9IzNxqKw8jJHY3lZ4DBrlEmm7RV04rdNvBlRACBMWcSvArOT2eRv3elTwUhBBSsvvTe6UMCEneqTlZ7JBF6lRHyugcRaEFzmrMsuvwUILQNzQ+4P/+z2rBsjYdA3mu0Dj86SQOjrl3FWDSlUcUTk68bdILWt8dDqF2kUznf47axWTC4dd8Tqrai0hr6toypYk2br1GbeCWXHqchDH8+QBNtECWUZ06gIv3WzJjeweeGQNgTOIDlr1aIms7RL5jxHTQvGxGrviq86IsV3rCUg==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by VI1PR10MB3744.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 23:54:40 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 23:54:40 +0000
Message-ID: <DB4PR10MB6261C86DEE5F4008B20C5033925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Date:   Thu, 15 Jun 2023 07:54:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] hwmon: (sht3x)remove sht3x_platform_data
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
References: <DB4PR10MB6261D79FE16EC2BBD5316B91925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
 <6d1209e9-0d40-c2ba-b94c-6590e98070d7@roeck-us.net>
 <DB4PR10MB626134E4213F378A430E5EED925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
 <45c8771d-47c1-c007-1cd5-97eebedef147@roeck-us.net>
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
In-Reply-To: <45c8771d-47c1-c007-1cd5-97eebedef147@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [TXUOwQ+eK6eXPHAoEAMrbE7fz5cEZ9ar]
X-ClientProxiedBy: TYWP286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::20) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <aec48853-f984-4a7d-0f42-908f4e078785@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|VI1PR10MB3744:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c6f753-20d5-4a21-fde9-08db6d32b774
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXjmRk2mZ6D3aLuyodQOZ6LvUN0yi7/aZ16UGOCXUm8koUgamvZqPOtP2WaGfYVD8BWLIoF6SZ4UqrDNc4GhU1RThv5syXD8OA4q/E8KnbQ2mBHIJXsjBMGZHOvNltcKiBRqurTolcqFLOS5r5b2AXlj8X4Qz27mTAS7miuk23FEJ/Nb6wg1LS+oWRx+paz+i9vd4ebROxohXQLvrJJuh35FwvpwlkSAX/JEGvV28/uLtdHAshwAGG8NMqIP4m6c/rdR+KFc72/IXREbC0szvzObZ1a/PwixmQirziJZBwlsguih/bdT8iwlsk5Pgkfhht32jdDR8rNCqd2EMRR3mTblhgJPzz7PxUqHwf8jWn5E2/xGYI53dNVNw719N1JNVltOE4X/+AzBthQnyY/+dY4wd0bPxReVbCyWXl69UH2DdPY15SFdoAFAxy8SiVWlMjOVTA+44eWqWcdk4owp/9dVtEl7TB0hHBIUHiKZsxg1fG062akKcOyIF/GUBaziXMAwqnmBkHpf6ptIhIO0b04K/lFbKFG784F0qzx1SdekOt6IKEIGu1LBBzA8SqbXrj25Q5g1En2B02sngIW40BTEGWkFiBenJyLXw6IVb8JinO+ZxdRsxmODPC6Ufv0O
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkwwSmVHM1dHOSs1R3ZJTVMyV0lUb09GNGt6WlhGNlN1UGdoL1MyR2xIcHVP?=
 =?utf-8?B?d3JBNHdlVWlOaVVLRGI5WlMwVTlyMUVmVXpOUGE5U0wzS25mTHp6U0Evc2o5?=
 =?utf-8?B?c1h5WmVvZ0szQU53QzU3VFlSSlNHUmtrdTliTnlpRmtOdEFPYk5LSXFUd2E0?=
 =?utf-8?B?b1E2YUoxUWpNYjNTZzRHNFJiNUFKS2s4eDFSbWhUeUpOd0RXSWtmbmtmUmV2?=
 =?utf-8?B?bW5hVGU2ZDhLOWpnUVI1SzVZNjFKRmxVSmhtR1Vya0JNRTVOWCt6UmNSSmxO?=
 =?utf-8?B?NmFRYzZENUhnemZBanpnVWZCYng5QWVWRnBDN2xGdHA1SjFnYzNTY0F3V3ZC?=
 =?utf-8?B?YVhMRXNld3JuUE8zclRNL1Bha2Z1dXRPNGcxaDBGV2tJdDBrWVZwcnZKdUVy?=
 =?utf-8?B?U0ZpZUJ1QWxjbGFBU2s1NzVUUXRQTHk0a3lJcDlhc0FzUWowYnZxMnRvQzN4?=
 =?utf-8?B?SDZLRDF0MVA1VzZ0MklaY2JZZ1Y0enFKYmh1aHR2NTBwWjJmSzhLTFVHMEdv?=
 =?utf-8?B?ZDlEcnFsQ2hjM25HY3QyQXptSjdpQU96T1U3dXpwSVFzMEZIN0xERHF6OFdO?=
 =?utf-8?B?SngwNVRtaXd1dU54L2lRM0FJekdGN1huU0IwUDA1dis4MFBPOXBqaXp6bVcz?=
 =?utf-8?B?VzBDY1ovbit5ak1uUVB2U2tIY3ZiVXhmUUFyUzJ2WmhKRFZCcW8wQ3ZoL0VD?=
 =?utf-8?B?OWRZL2pHRm1xWTJ6bnFMOThlK3RJOWtjRnd2LzI5SDE0VTYweHV5bVZ0ZVFt?=
 =?utf-8?B?ejJUcm9wSksvSGVxVFZnZytTSEFCbFFLcFpqWU54RS9GSHdQMUFLektJYXdN?=
 =?utf-8?B?WkJQN2h0MGJqN1VNc3M1RU5WRXZtWWtYaUVIZjRVSkQ5Qmk3bFpCcmd1Z1FW?=
 =?utf-8?B?b25IU1hsV05jZk9qYjFLL0dmemwyVVhVSG50azBiWEk5Y1hyYXZyYzYyeVpO?=
 =?utf-8?B?ZGd4WDh3QnczY01Rall1T0FYWS90eW9IcmZNRWpWZDBTUDNHV3krMWNKOUZE?=
 =?utf-8?B?aGF2bS9rcXN6N2VnRi9rOVo0aWNKdCtCUzcrQkVVc0QxSTE3Njd2c0pjN1Rt?=
 =?utf-8?B?M0VDUlU3U096RFNJR0lKOXZxYkpRZVhOZ3hvKzB2VjRWcGdBMTRDVWNoOWQ5?=
 =?utf-8?B?U0REakVjRGdVYnk5K1lTWTc5b1ZEZlR5ZnJyVENDWFY0YUVDQlo1OFFYN0lv?=
 =?utf-8?B?cjRudlB0L3phNFA1bGxZaDZDVHBFSjl2T3FJQ3BNQk9DbU1nSjZpSEhsZzd6?=
 =?utf-8?B?NHE4UGFqTXRyaUM4SFdEWkNNbVdRMC9HSnJtWXZlZ0loSHJVUVJWMHJ1R3pI?=
 =?utf-8?B?RXM1L3B2emxLVGFSWDBKWjZ5ZFRvMDNSWXhWUUhiT2R6ZDBWdmpMUFhzR0lw?=
 =?utf-8?B?MkxaaHFacHJ6a2RyZ1dTL0FqVlFKQzNLNTlEQVlYSUw4RlRYVGE3Q05lRzhI?=
 =?utf-8?B?VHdUS0pJcUtSclEwME1jMEhhd003bFVqUEZidmhqL2RXa1NGUHBYWWlTYlk2?=
 =?utf-8?B?a1gwMW1LYVl6L3JPWTAvVis2RGlTL0wyNENJVUlIS1h1OWZFU1JKUkg5NFZo?=
 =?utf-8?B?a2Y5L2M0ZEkzaGNmKzdHMSs1enBtTjBBNmtrWVc4a002eTNtdjVUK21sTFQv?=
 =?utf-8?Q?7yAq81jFp4Ek6Djkpexf09WUlP0V3H1eM2HucSlN1WFc=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c6f753-20d5-4a21-fde9-08db6d32b774
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 23:54:40.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3744
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/6/15 3:15, Guenter Roeck 写道:
> On 6/14/23 08:02, JuenKit Yip wrote:
>>
>> 在 2023/6/14 20:57, Guenter Roeck 写道:
>>> On 6/13/23 23:24, JuenKit Yip wrote:
>>>> Since no in-tree driver supports it, the sht3x_platform_data was
>>>> removed.
>>>>
>>>> - "blocking_io" property and its related code have been removed, and
>>>> Single-Shot mode should be blocking in default.
>>>>
>>>> - "high-precision" property has been replaced to "repeatability" for
>>>> matching datasheet.
>>>>
>>>
>>> That needs to be three patches.
>>
>> Patch 1: remove sht3x_platform_data and its header file
>>
>> Patch 2: move "blocking_io" to struct sht3x_data
>>
> Essentially merge it with update_interval==0 since (if I understand
> correctly) blocking mode and update_interval==0 will be equivalent.
> With that in mind, a separate "blocking_io" variable should no
> longer be needed.
>
I reviewed the datasheet again, update_interval == 0 means Single-Shot

mode which owns blocking(clock strench) and non-blocking(non-clock strench)

options. If master supports clock-strench( I don't know how to detect it),

the property may be reserved.

>> Patch 3: replace "high-precision" property to "repeatability"
>
> precision -> reliability would apply to both high and low
> precision. I think "low repeatability" is currently called
> "low power mode", so you'll want to update that as well.
> I also see "high accuracy" and "low accuracy" use in the
> documentation, but I see you removed that already below.
>
>>
>> Is it correct or I am misunderstand your statement?
>>
>
> Yes, that is what I meant.
>
> Thanks,
> Guenter
>
>> Thanks for your instruction
>>
>>>
>>>> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
>>>> ---
>>>>   Documentation/hwmon/sht3x.rst       | 12 +++++------
>>>>   drivers/hwmon/sht3x.c               | 32 
>>>> ++++++++++++-----------------
>>>>   include/linux/platform_data/sht3x.h | 15 --------------
>>>>   3 files changed, 18 insertions(+), 41 deletions(-)
>>>>   delete mode 100644 include/linux/platform_data/sht3x.h
>>>>
>>>> diff --git a/Documentation/hwmon/sht3x.rst 
>>>> b/Documentation/hwmon/sht3x.rst
>>>> index 95a850d5b..2c87c8f58 100644
>>>> --- a/Documentation/hwmon/sht3x.rst
>>>> +++ b/Documentation/hwmon/sht3x.rst
>>>> @@ -28,28 +28,26 @@ The device communicates with the I2C protocol. 
>>>> Sensors can have the I2C
>>>>   addresses 0x44 or 0x45, depending on the wiring. See
>>>>   Documentation/i2c/instantiating-devices.rst for methods to 
>>>> instantiate the device.
>>>>   -There are two options configurable by means of sht3x_platform_data:
>>>> +This driver supports block and non-block mode:
>>>>   -1. blocking (pull the I2C clock line down while performing the 
>>>> measurement) or
>>>> +   blocking (pull the I2C clock line down while performing the 
>>>> measurement) or
>>>>      non-blocking mode. Blocking mode will guarantee the fastest 
>>>> result but
>>>>      the I2C bus will be busy during that time. By default, 
>>>> non-blocking mode
>>>>      is used. Make sure clock-stretching works properly on your 
>>>> device if you
>>>>      want to use blocking mode.
>>>> -2. high or low accuracy. High accuracy is used by default and 
>>>> using it is
>>>> -   strongly recommended.
>>>>     The sht3x sensor supports a single shot mode as well as 5 
>>>> periodic measure
>>>>   modes, which can be controlled with the update_interval sysfs 
>>>> interface.
>>>>   The allowed update_interval in milliseconds are as follows:
>>>>   -    ===== ======= ====================
>>>> -       0          single shot mode
>>>> +    ===== ======= ==========================
>>>> +       0          single shot mode(blocking)
>>>>       2000   0.5 Hz periodic measurement
>>>>       1000   1   Hz periodic measurement
>>>>        500   2   Hz periodic measurement
>>>>        250   4   Hz periodic measurement
>>>>        100  10   Hz periodic measurement
>>>> -    ===== ======= ====================
>>>> +    ===== ======= ==========================
>>>>     In the periodic measure mode, the sensor automatically triggers 
>>>> a measurement
>>>>   with the configured update interval on the chip. When a 
>>>> temperature or humidity
>>>> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
>>>> index 8305e44d9..5bc0001b1 100644
>>>> --- a/drivers/hwmon/sht3x.c
>>>> +++ b/drivers/hwmon/sht3x.c
>>>> @@ -20,13 +20,12 @@
>>>>   #include <linux/module.h>
>>>>   #include <linux/slab.h>
>>>>   #include <linux/jiffies.h>
>>>> -#include <linux/platform_data/sht3x.h>
>>>>   -/* commands (high precision mode) */
>>>> +/* commands (high repeatability mode) */
>>>>   static const unsigned char sht3x_cmd_measure_blocking_hpm[] = { 
>>>> 0x2c, 0x06 };
>>>>   static const unsigned char sht3x_cmd_measure_nonblocking_hpm[] = 
>>>> { 0x24, 0x00 };
>>>>   -/* commands (low power mode) */
>>>> +/* commands (low repeatability mode) */
>>>>   static const unsigned char sht3x_cmd_measure_blocking_lpm[] = { 
>>>> 0x2c, 0x10 };
>>>>   static const unsigned char sht3x_cmd_measure_nonblocking_lpm[] = 
>>>> { 0x24, 0x16 };
>>>>   @@ -69,9 +68,14 @@ enum sht3x_limits {
>>>>       limit_min_hyst,
>>>>   };
>>>>   +enum sht3x_repeatability {
>>>> +    low_repeatability,
>>>> +    high_repeatability,
>>>> +};
>>>> +
>>>>   DECLARE_CRC8_TABLE(sht3x_crc8_table);
>>>>   -/* periodic measure commands (high precision mode) */
>>>> +/* periodic measure commands (high repeatability mode) */
>>>>   static const char 
>>>> periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
>>>>       /* 0.5 measurements per second */
>>>>       {0x20, 0x32},
>>>> @@ -85,7 +89,7 @@ static const char 
>>>> periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
>>>>       {0x27, 0x37},
>>>>   };
>>>>   -/* periodic measure commands (low power mode) */
>>>> +/* periodic measure commands (low repeatability mode) */
>>>>   static const char 
>>>> periodic_measure_commands_lpm[][SHT3X_CMD_LENGTH] = {
>>>>       /* 0.5 measurements per second */
>>>>       {0x20, 0x2f},
>>>> @@ -132,12 +136,11 @@ struct sht3x_data {
>>>>       struct mutex data_lock; /* lock for updating driver data */
>>>>         u8 mode;
>>>> +    enum sht3x_repeatability repeatability;
>>>>       const unsigned char *command;
>>>>       u32 wait_time;            /* in us*/
>>>>       unsigned long last_update;    /* last update in periodic mode*/
>>>>   -    struct sht3x_platform_data setup;
>>>> -
>>>>       /*
>>>>        * cached values for temperature and humidity and limits
>>>>        * the limits arrays have the following order:
>>>> @@ -441,13 +444,8 @@ static void sht3x_select_command(struct 
>>>> sht3x_data *data)
>>>>       if (data->mode > 0) {
>>>>           data->command = sht3x_cmd_measure_periodic_mode;
>>>>           data->wait_time = 0;
>>>> -    } else if (data->setup.blocking_io) {
>>>> -        data->command = data->setup.high_precision ?
>>>> -                sht3x_cmd_measure_blocking_hpm :
>>>> -                sht3x_cmd_measure_blocking_lpm;
>>>> -        data->wait_time = 0;
>>>
>>> If update_interval is 0, those would presumably still be needed.
>>> I don't know if the current code updating the interval is wrong
>>> (that may well be), but removing this code entirely seems wrong.
>>
>> update_interval "0" means Single-Shot mode and respectively 
>> data->command
>>
>> should be in blocking mode.
>>
>> Thanks for your correctness.
>>
>>>
>>>>       } else {
>>>> -        if (data->setup.high_precision) {
>>>> +        if (data->repeatability == high_repeatability) {
>>>>               data->command = sht3x_cmd_measure_nonblocking_hpm;
>>>>               data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_HPM;
>>>>           } else {
>>>> @@ -595,7 +593,7 @@ static ssize_t update_interval_store(struct 
>>>> device *dev,
>>>>       }
>>>>         if (mode > 0) {
>>>> -        if (data->setup.high_precision)
>>>> +        if (data->repeatability == high_repeatability)
>>>>               command = periodic_measure_commands_hpm[mode - 1];
>>>>           else
>>>>               command = periodic_measure_commands_lpm[mode - 1];
>>>> @@ -690,16 +688,12 @@ static int sht3x_probe(struct i2c_client 
>>>> *client)
>>>>       if (!data)
>>>>           return -ENOMEM;
>>>>   -    data->setup.blocking_io = false;
>>>> -    data->setup.high_precision = true;
>>>> +    data->repeatability = high_repeatability;
>>>>       data->mode = 0;
>>>>       data->last_update = jiffies - msecs_to_jiffies(3000);
>>>>       data->client = client;
>>>>       crc8_populate_msb(sht3x_crc8_table, SHT3X_CRC8_POLYNOMIAL);
>>>>   -    if (client->dev.platform_data)
>>>> -        data->setup = *(struct sht3x_platform_data 
>>>> *)dev->platform_data;
>>>> -
>>>>       sht3x_select_command(data);
>>>>         mutex_init(&data->i2c_lock);
>>>> diff --git a/include/linux/platform_data/sht3x.h 
>>>> b/include/linux/platform_data/sht3x.h
>>>> deleted file mode 100644
>>>> index 14680d2a9..000000000
>>>> --- a/include/linux/platform_data/sht3x.h
>>>> +++ /dev/null
>>>> @@ -1,15 +0,0 @@
>>>> -/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> -/*
>>>> - * Copyright (C) 2016 Sensirion AG, Switzerland
>>>> - * Author: David Frey <david.frey@sensirion.com>
>>>> - * Author: Pascal Sachs <pascal.sachs@sensirion.com>
>>>> - */
>>>> -
>>>> -#ifndef __SHT3X_H_
>>>> -#define __SHT3X_H_
>>>> -
>>>> -struct sht3x_platform_data {
>>>> -    bool blocking_io;
>>>> -    bool high_precision;
>>>> -};
>>>> -#endif /* __SHT3X_H_ */
>>>
>
