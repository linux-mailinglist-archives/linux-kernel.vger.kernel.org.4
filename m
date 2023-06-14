Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165D77302B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245674AbjFNPDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFNPDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:03:20 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2085.outbound.protection.outlook.com [40.92.74.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460451BFF;
        Wed, 14 Jun 2023 08:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Co0linJvpLFh1waPrrxKwniL/urH+gi5qvGqt+vR5wfZqXXtU4Y5GnUNVdbSNSnpqTeujjU62/WGWRCnOTNgkp1O8MjF4Plq4tQtf5BzOWebzHxBphb2gp6UABynC8UCXWjhpV2pA7EQsaTzgHvQBgTEVGZ+Gl90v6+n4y7jBNChxFZjmSt6u99xl6e8X/5N/ZwqkEZNAnGOtsnvpzD9tGXQFItssoE7Eg0Rsz0o79y9t8cX1M+tt4pOE5X/AdSzbXpwDPtMp7Ti4JROpt567Lkt5Feh0cTuyBAE7NXfvVpAuDoVo0ZyB0MQYIS7ZhBTKbGe3VtXX10kiLoIjAFtjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exlBFK27608YIFpZzKGgjEeqPiuR7L4BakSNtZFqlMg=;
 b=W2jEPPTS9bGUM53B+hcKk8wCvqrZE3AwWHPFbn680bhj2eWaJXoKb1Xplh4QrnRDxRfcDLrzukWJ92lZ7LiBUhzyjQDXDriymm52OQZDyVxpvPZMpipWd8kzM2QcqLqNaudRXO1k5HMNkk2jQjiP4Q0TqgPxXNVOmM99oLAGgUNztgKzDacoGHLarlufD7vjbYDH9OgjbU1S0im3rwd8OVXp81ViukeR7DzUoswe/wegBYGGodvgLe/OeYIathirLBpZk4EajE48w45FHEemrhQUu+zQ2BOwlCC1DK+vTB0dsfmFeCtgrxLYG7pK9rWazxCQ5JS1EAYJVIcRxMB5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exlBFK27608YIFpZzKGgjEeqPiuR7L4BakSNtZFqlMg=;
 b=ZrAWO/awNXpynaw6w2Yf3iIPQs+ngieYJZBFmCjlWzj8sVT50UGhjAkXqxVCXxMPd9oU70BhkUSTCXatYpk6A5oolSConD/UriWJvxC2G9IXrsPxrFiPq3yuE4sg2XV5fw6aTyHalD7YWf1Tnq4KOJa3u5WF9lWaZhuuR5+ocwtkDrmXNjQU2Y1jxCik4iUoyMqceTPqncvvUQ8UieVwPEvLavmr3WtO9F3WTYcWVGTPFMI7YFp61tqRLkeYrlC4ynWPHv7uX/SfrN4rbxqsoXxiCIdAuq3zVQmDqxL9+wP9G4eJPoCHCfqWmZ24ofyBYmW/g3LF9QruC6EUBP/hTA==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by PAXPR10MB5183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 15:02:59 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 15:02:59 +0000
Message-ID: <DB4PR10MB626134E4213F378A430E5EED925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Date:   Wed, 14 Jun 2023 23:02:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] hwmon: (sht3x)remove sht3x_platform_data
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
References: <DB4PR10MB6261D79FE16EC2BBD5316B91925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
 <6d1209e9-0d40-c2ba-b94c-6590e98070d7@roeck-us.net>
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
In-Reply-To: <6d1209e9-0d40-c2ba-b94c-6590e98070d7@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [zS04Iwi0RYb+yxwEf0MZ5AINRO8LC55sheMrUfzmvwqK9gZUSTCFne2iE+rtnBotX8eiaIg9TYs=]
X-ClientProxiedBy: TY2PR01CA0024.jpnprd01.prod.outlook.com
 (2603:1096:404:a::36) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <01f88d7e-d461-8d73-6633-5b9060e42c37@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|PAXPR10MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: b64a7cd2-7e7c-4729-6cb2-08db6ce8711c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRSykcnP0/KgZGHDzlITRR9wdrObCXoIVvmW4CTk4fAlOp/tJ6m3cCGv64KIQXo9ueqju9/+zFRaVf3PCHonV0IjQbJ0ayea/p1yhzzfR7dsvo9pMOujhrKAuvp8vqhIAqyHL+jwRvvSPs1JnbCYLSBK68VDA/5RZUYCKQ7Y+J8KCfIAIO5eVIk3rfMbRWtOjv6UgMg/7dQtG0njaybuhQWaYixOr/ug5e+9l7dRvATuZxXiC/gP52o0y5KSySDDjV8ex1ufZc3y/77PqhtNj72S1nFSveHC9A7CM/pGk1hmYdkBbwUe/Q0oq6IQRybd2PIP4I3koxayhkYdxx3EYd19pwBQdO5bqMDCIRZj2HjmHzThP1//1X5Tetc8b0tB0cKxITRPf/EI7GGFHsU7u0MhmJUkTVmH5b4u+F7pS8g2SzgU4gutuNcTId6YmwsCgIT47NluoxWotdM4uOLikUSK3c2UrDGaGW+6ndcsvEtgcte6ga3ZiPOOrdHl6klAIB23z+Zn0JeQAZjfGB9g8xkgMQXkwpa8Rnm3Nra5fHCIWHU2v3n8PYpZdxWUHtyH2Yk1PDMcd5q5JAFAhgyaWrekmkgpgR5VmfsvrewclSxDLHlnQ7MFmVQtEWXKPwU/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXQ3Ymp0VTZGZFJkdFBwb0lFNE5yM25Ld2ZWWmw0VmFsaXUrdXA0VmRVbURK?=
 =?utf-8?B?SUZScXE4SnIxdTFMelpqQTNMK3g3NDJJR1RpUUxoakhKVE85TXA5d1FpZXgr?=
 =?utf-8?B?QnZXMW14cDdIeGRzNzR1NDNjdnpsaFhDWHpYa055cVk2M1N3em4raDQ1ZGV2?=
 =?utf-8?B?NUxmMEpSV0s4b1ZzTitMU3ByMGtyeU43ay84dWZraDhJWjh3TzNxQVVHanMv?=
 =?utf-8?B?c2Z1WUpXd3k3ZW83cE14SElMNmtyd0xrbUlwQW8xSDZRWjlRcFpZVlFHdmE5?=
 =?utf-8?B?cnJLM25sSnd5M29pTjhQQjJ5VjNLaENjYzN3RHRqZE15QS9wb2F0MENNUGdo?=
 =?utf-8?B?VmdnR0YyUFp1WVVvcmpXektXSXczT01LRUxyNThaQjFHVUFhUGI5TnlOamF0?=
 =?utf-8?B?aW1na2ZlTkNhQnpwS0tBazJ2eXpHYU10dXdPTjJldThDd1dzcWZscmloSVNN?=
 =?utf-8?B?aDRaT1dYem0vSVZZT3lpNCt3L1IzcGZ0QUxicWZubzJ3K3NITVdpYnFreEc5?=
 =?utf-8?B?L3ZTdDdZSU1ES2k0ekpkNllMSENRbU04MkVBRlNkWERaTGE2VldWNFgxeW9i?=
 =?utf-8?B?b0xtY0dpYmY3L0VzWWszdGtYV1Bnc2pFR1hPcVAvT0hGNlh2ZlExZ1dURzVG?=
 =?utf-8?B?ZEFpT3IrdFJiaEgzaWM1Y0tTYlMvNXFPaGRIVVBua0dIbHdxb0wrRjJ3YXVH?=
 =?utf-8?B?WEd6Qkt3V3VUTU9WRWFPUFJycVVqSTF2YmgzeFAwUmcvOGNxelRjYkRpQzZX?=
 =?utf-8?B?d3RZUWtTUFBFNzgyZXo1YWxFTDBzb005MEJPU20ySG5MNkMxN3B0Mk1xL01x?=
 =?utf-8?B?YTAvdzFJeGlYZW15Ykp2b25vUWx6VWVJTGgra2pMRXp6OS9Ybk83cTdkTHc4?=
 =?utf-8?B?bUlIUkxDSzVrb0lUUGdmcUt4NlZuNzN2RE00RzBxQ090cEpKSUtEZDZkckpT?=
 =?utf-8?B?Vzhaam1URUZ2R1JoVzlMQ2xJMmZxcjFvUVgyeG5HRUY4RmlVdjQ2RUR1NENV?=
 =?utf-8?B?V2Z4djFCNWp1aDA4VFp5QkhFTytaUmdKUS96ZVBTbU5JUzVsT1R2R2VIUzFk?=
 =?utf-8?B?elMzUnlYMWJjSUljcHBJd1ROUE9WMmdFOVhwRUI2V0JINkt5QTE4S2xUTWh2?=
 =?utf-8?B?Y2tOU3pYUnBGcEdXcDcwVjloMEpCbU1RcTRoUkVoZjJibkxZWnBXcWEwTkFi?=
 =?utf-8?B?S3BpT0ZEdTF0aUcvd0tuM2tjUzE0N2dES2ZXN2JINkZaV2xYTGZlWkE4MUxh?=
 =?utf-8?B?ZStiS0VOMFFjQW1PVUVEL2ZxLzFoWWpDMFhTbWVoTkZkY3YxSkI0djZDUU1T?=
 =?utf-8?B?NFZkWk93ZEtNN3p0SGFPZFZLQVJDNG5lNDZuYU9iaTh0b0hTR1lLR2V4SDlQ?=
 =?utf-8?B?NlFsVVVGNWpROXlKNGt0TE4xa3JScnArTUw4NkFObndhSVhXTXBWQ25wREJi?=
 =?utf-8?B?VG1kV2xvTmJ3bzUra0owYXB5MGt2VGowYWZJUFJJc1h6RGhDN2xCVGU1Tk5M?=
 =?utf-8?B?UjNiYzkreFZRazY3emJNc1J1WVVCeDBWZjVqM3lqcHpSd2xKMUpYeDB2VUE4?=
 =?utf-8?B?TnpzVGZVWk9QMjJISG1JRnlHamxreHkyQVRXUWdydTFteDhWS0YwUWMxckVC?=
 =?utf-8?B?TEIvV1RNQWxXVGpYVGFWVXhzYVk2QlRCVEVUK2gzSHVGRzh6ZGVobVZlMmVT?=
 =?utf-8?B?S0FlNkFVMGxOUHp4ZUxGdm9TOGFpaTdEY2ZDV1E0L3JFT2dvV2t6eGtuRVpO?=
 =?utf-8?Q?nH4DQ3lJEMJgG4XkL0=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b64a7cd2-7e7c-4729-6cb2-08db6ce8711c
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 15:02:59.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5183
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


在 2023/6/14 20:57, Guenter Roeck 写道:
> On 6/13/23 23:24, JuenKit Yip wrote:
>> Since no in-tree driver supports it, the sht3x_platform_data was
>> removed.
>>
>> - "blocking_io" property and its related code have been removed, and
>> Single-Shot mode should be blocking in default.
>>
>> - "high-precision" property has been replaced to "repeatability" for
>> matching datasheet.
>>
>
> That needs to be three patches.

Patch 1: remove sht3x_platform_data and its header file

Patch 2: move "blocking_io" to struct sht3x_data

Patch 3: replace "high-precision" property to "repeatability"

Is it correct or I am misunderstand your statement?

Thanks for your instruction

>
>> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
>> ---
>>   Documentation/hwmon/sht3x.rst       | 12 +++++------
>>   drivers/hwmon/sht3x.c               | 32 ++++++++++++-----------------
>>   include/linux/platform_data/sht3x.h | 15 --------------
>>   3 files changed, 18 insertions(+), 41 deletions(-)
>>   delete mode 100644 include/linux/platform_data/sht3x.h
>>
>> diff --git a/Documentation/hwmon/sht3x.rst 
>> b/Documentation/hwmon/sht3x.rst
>> index 95a850d5b..2c87c8f58 100644
>> --- a/Documentation/hwmon/sht3x.rst
>> +++ b/Documentation/hwmon/sht3x.rst
>> @@ -28,28 +28,26 @@ The device communicates with the I2C protocol. 
>> Sensors can have the I2C
>>   addresses 0x44 or 0x45, depending on the wiring. See
>>   Documentation/i2c/instantiating-devices.rst for methods to 
>> instantiate the device.
>>   -There are two options configurable by means of sht3x_platform_data:
>> +This driver supports block and non-block mode:
>>   -1. blocking (pull the I2C clock line down while performing the 
>> measurement) or
>> +   blocking (pull the I2C clock line down while performing the 
>> measurement) or
>>      non-blocking mode. Blocking mode will guarantee the fastest 
>> result but
>>      the I2C bus will be busy during that time. By default, 
>> non-blocking mode
>>      is used. Make sure clock-stretching works properly on your 
>> device if you
>>      want to use blocking mode.
>> -2. high or low accuracy. High accuracy is used by default and using 
>> it is
>> -   strongly recommended.
>>     The sht3x sensor supports a single shot mode as well as 5 
>> periodic measure
>>   modes, which can be controlled with the update_interval sysfs 
>> interface.
>>   The allowed update_interval in milliseconds are as follows:
>>   -    ===== ======= ====================
>> -       0          single shot mode
>> +    ===== ======= ==========================
>> +       0          single shot mode(blocking)
>>       2000   0.5 Hz periodic measurement
>>       1000   1   Hz periodic measurement
>>        500   2   Hz periodic measurement
>>        250   4   Hz periodic measurement
>>        100  10   Hz periodic measurement
>> -    ===== ======= ====================
>> +    ===== ======= ==========================
>>     In the periodic measure mode, the sensor automatically triggers a 
>> measurement
>>   with the configured update interval on the chip. When a temperature 
>> or humidity
>> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
>> index 8305e44d9..5bc0001b1 100644
>> --- a/drivers/hwmon/sht3x.c
>> +++ b/drivers/hwmon/sht3x.c
>> @@ -20,13 +20,12 @@
>>   #include <linux/module.h>
>>   #include <linux/slab.h>
>>   #include <linux/jiffies.h>
>> -#include <linux/platform_data/sht3x.h>
>>   -/* commands (high precision mode) */
>> +/* commands (high repeatability mode) */
>>   static const unsigned char sht3x_cmd_measure_blocking_hpm[] = { 
>> 0x2c, 0x06 };
>>   static const unsigned char sht3x_cmd_measure_nonblocking_hpm[] = { 
>> 0x24, 0x00 };
>>   -/* commands (low power mode) */
>> +/* commands (low repeatability mode) */
>>   static const unsigned char sht3x_cmd_measure_blocking_lpm[] = { 
>> 0x2c, 0x10 };
>>   static const unsigned char sht3x_cmd_measure_nonblocking_lpm[] = { 
>> 0x24, 0x16 };
>>   @@ -69,9 +68,14 @@ enum sht3x_limits {
>>       limit_min_hyst,
>>   };
>>   +enum sht3x_repeatability {
>> +    low_repeatability,
>> +    high_repeatability,
>> +};
>> +
>>   DECLARE_CRC8_TABLE(sht3x_crc8_table);
>>   -/* periodic measure commands (high precision mode) */
>> +/* periodic measure commands (high repeatability mode) */
>>   static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] 
>> = {
>>       /* 0.5 measurements per second */
>>       {0x20, 0x32},
>> @@ -85,7 +89,7 @@ static const char 
>> periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
>>       {0x27, 0x37},
>>   };
>>   -/* periodic measure commands (low power mode) */
>> +/* periodic measure commands (low repeatability mode) */
>>   static const char periodic_measure_commands_lpm[][SHT3X_CMD_LENGTH] 
>> = {
>>       /* 0.5 measurements per second */
>>       {0x20, 0x2f},
>> @@ -132,12 +136,11 @@ struct sht3x_data {
>>       struct mutex data_lock; /* lock for updating driver data */
>>         u8 mode;
>> +    enum sht3x_repeatability repeatability;
>>       const unsigned char *command;
>>       u32 wait_time;            /* in us*/
>>       unsigned long last_update;    /* last update in periodic mode*/
>>   -    struct sht3x_platform_data setup;
>> -
>>       /*
>>        * cached values for temperature and humidity and limits
>>        * the limits arrays have the following order:
>> @@ -441,13 +444,8 @@ static void sht3x_select_command(struct 
>> sht3x_data *data)
>>       if (data->mode > 0) {
>>           data->command = sht3x_cmd_measure_periodic_mode;
>>           data->wait_time = 0;
>> -    } else if (data->setup.blocking_io) {
>> -        data->command = data->setup.high_precision ?
>> -                sht3x_cmd_measure_blocking_hpm :
>> -                sht3x_cmd_measure_blocking_lpm;
>> -        data->wait_time = 0;
>
> If update_interval is 0, those would presumably still be needed.
> I don't know if the current code updating the interval is wrong
> (that may well be), but removing this code entirely seems wrong.

update_interval "0" means Single-Shot mode and respectively data->command

should be in blocking mode.

Thanks for your correctness.

>
>>       } else {
>> -        if (data->setup.high_precision) {
>> +        if (data->repeatability == high_repeatability) {
>>               data->command = sht3x_cmd_measure_nonblocking_hpm;
>>               data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_HPM;
>>           } else {
>> @@ -595,7 +593,7 @@ static ssize_t update_interval_store(struct 
>> device *dev,
>>       }
>>         if (mode > 0) {
>> -        if (data->setup.high_precision)
>> +        if (data->repeatability == high_repeatability)
>>               command = periodic_measure_commands_hpm[mode - 1];
>>           else
>>               command = periodic_measure_commands_lpm[mode - 1];
>> @@ -690,16 +688,12 @@ static int sht3x_probe(struct i2c_client *client)
>>       if (!data)
>>           return -ENOMEM;
>>   -    data->setup.blocking_io = false;
>> -    data->setup.high_precision = true;
>> +    data->repeatability = high_repeatability;
>>       data->mode = 0;
>>       data->last_update = jiffies - msecs_to_jiffies(3000);
>>       data->client = client;
>>       crc8_populate_msb(sht3x_crc8_table, SHT3X_CRC8_POLYNOMIAL);
>>   -    if (client->dev.platform_data)
>> -        data->setup = *(struct sht3x_platform_data 
>> *)dev->platform_data;
>> -
>>       sht3x_select_command(data);
>>         mutex_init(&data->i2c_lock);
>> diff --git a/include/linux/platform_data/sht3x.h 
>> b/include/linux/platform_data/sht3x.h
>> deleted file mode 100644
>> index 14680d2a9..000000000
>> --- a/include/linux/platform_data/sht3x.h
>> +++ /dev/null
>> @@ -1,15 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0-or-later */
>> -/*
>> - * Copyright (C) 2016 Sensirion AG, Switzerland
>> - * Author: David Frey <david.frey@sensirion.com>
>> - * Author: Pascal Sachs <pascal.sachs@sensirion.com>
>> - */
>> -
>> -#ifndef __SHT3X_H_
>> -#define __SHT3X_H_
>> -
>> -struct sht3x_platform_data {
>> -    bool blocking_io;
>> -    bool high_precision;
>> -};
>> -#endif /* __SHT3X_H_ */
>
