Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76421730346
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245748AbjFNPRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343668AbjFNPRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:17:00 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2107.outbound.protection.outlook.com [40.92.89.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1A0213F;
        Wed, 14 Jun 2023 08:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nt8b2BSa1aD997EzPnhVEqtzPbfAKp8IUQBiW/Qf7n5RSLHnpHeHRuGfHVxDHARDd1ZhcgdBaDEmJia964y8nqAZAKyuPL4FvXsm9hH8FdcBnOmMozBS+CmTYZ98OzTfcoSjOVB5uAObhdmqm2t04rC9SOO+D01F/JQ+Ht82b8xrU0cLLrXqhC4m6HGhUn5oU58xzIxvu9d/QWA1nxGzZb84MA29e/KChFPm3Zp/MlWU9CJ9YAJqV+JoMyc9j3iASIrBXPeAaN66Ba54df2aeSi21awzRGqeEeZAzN/FT2DwEo7yp4E3fM04o5w21lWo1htyj1xqHFT9dl2yQf9sOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02SyDZYtrf3xHK7EI9F8kB9Q08sLdD5V1gEwFl4tN+Y=;
 b=ViJ3xKTspGwSw0pXuw2sftOO84NahWbSWU3G+eA/E6UDnoTmLhjrgMU/fa5WlSq7gEtlDUVRZOIXIWtIrAmu+UYlGVYwnTCMYK9P1qpv2+6tp4pZ4a5hLIaQvzCrUxB9PikWsJkdroyVScSQZmf/iPph3RYVJgl5bNnyGVlfISZDh/5CzXxOc038zQMY/AxJ+Era9oELZIRTXokoGJRgdDZYnHCMjpw2ODPrp74s5HvnK+WI43nBsNJDTvtMy3A9pCaPZbi8aE5TSRdhQwcXms2DJxF4PCV3lVGE+DUesiLaeHsNt62BNdG0G8HMWZV8zNUk9QpmAZevjduVLTBahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02SyDZYtrf3xHK7EI9F8kB9Q08sLdD5V1gEwFl4tN+Y=;
 b=HfpmtUAXsP7sBagt/CJdHtx099YHIhEladSu2HRVK5qh0g3BF7vvhQqf8WN7YqyBtPcj8gcIvMNU6oFnBo9h0u6fClrcmZgeM9rObxgq5GA3t6qME/0P7gfmO+HlI+0zvF746qnbCowUAWVo9hswgtAPWlEAFXO8ArJ90QWCMZ4vFIhR0XBifKThhrArft4lN3AzBC8NdR//+tKRVgfrftHWY9Nsl/Ls8DqoYdX23XBpb1dqAWOQGiKMruhdDVb40n/Zlk1X4jbuLiK7ehDnkkmxlS0SO0AABmyFB+54oyJj5NBaVlnwNGH0oHXW75LWmc2pE5hf4sgv2mMyfe2THw==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by VI1PR10MB3520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Wed, 14 Jun
 2023 15:16:33 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 15:16:33 +0000
Message-ID: <DB4PR10MB626162AA9BA770E048BA5875925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Date:   Wed, 14 Jun 2023 23:16:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/3] hwmon: (sht3x) add medium repeatability support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
References: <DB4PR10MB62615481D91BA8A598234A18925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
 <9e9a7066-b841-db97-f8a5-44b2bdac124c@roeck-us.net>
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
In-Reply-To: <9e9a7066-b841-db97-f8a5-44b2bdac124c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [+OyvJrCQHGrcyvSk7qNTICwbSM5G95HFXpNqx9a8eQsxYQPMsfzn3kWYBy7mo6HJdde9rrJKgB0=]
X-ClientProxiedBy: TYCPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::15) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <384ffab4-6340-32af-e340-87f1ed9784fd@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|VI1PR10MB3520:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ac5294-04a7-49bc-b0d2-08db6cea5686
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNkqu4dQ4A1CxQ7IrlYvvVvl2/DWDLt/cDffpsbb7LTJBeDrtARjZmxn2ZF+F+rjQSSh7rPYm6z28t8wtan4T0Q5bPe2U7LgdSYPLQrwT3qA6dVgFJ/7Goj2nv9gFCYe3UMC5aLFAIrShYsuSFEQTCNUmSKiAxtwH5/1p5EZV/2+j07uAl7UnuDcQORo2ZzpCMkQqZzIrFMycVS7iXx2Bbdu+wFBBU2uFBOs9Gr8KrCbCBvKA7F8Xr1AVfn9r+sYGiztDA3F/HSBjG6VB/CkB9CZUwEO1BDjpLDVe0wEikQEV1xq+F6Ik48N65Gn5wGvfF5+J1rBdArg0fX0yeWNrUGOzA2SjCIdsQjGJCX44zR5GY/rB+w+hq6pVcKR5fZv9uW4GNX/tDWGXNKKpkKHFi1mTaNtHbcAoHu7vtQRM6tV98mcbHVsq26m2frqAk6NwrBh0AO3x/jPZ4gyjOoXGtNh9vSjKsAbzbMxbWZ1iPqALkMGbTy7i8JlMtH35p4UIAbJacaMAyMDKJiMQiqzQ2zbMx7p91tCK5wJOq4dH3ZpufhmNQItiicPBHn7GOn+18h8zZg5lX/cksGa1gUvKKVOyJDA+KLa5+gy6VuDK3lqyC6qMbSR9HUiPaM2H8Jm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGxDQ1ByR09FQkVmaC8wRVZETDR6QS9GZXZxTkJJS0pQRCtFcjhUWU0vYkpO?=
 =?utf-8?B?WUtIY2ZMYzNNZytOSUFRcGpvRE9TdWpWRURWOUxkUk4yRHBlZEd0VEtZQms0?=
 =?utf-8?B?YWErcndQTkZPYTV5bkxoQzJwM3IxSGtXZFhuMUR1dnBDaGN4ZWFCTjY4WVhR?=
 =?utf-8?B?elNWQVlCdVZiWTY5UEdrYmN6dkQ0UzdMMEozZXU3WjdIaWdtTGR2RUVUZGFF?=
 =?utf-8?B?eUFFQ3EvaEtjU1JYT0VVckZsMGt4dVZqTjFBakZveE5yRDF5a0s3UkdIcmpn?=
 =?utf-8?B?MERUUFdwWlJHSDJFSG12VEF6UWRIVzdhYkt0RVBKVnh1ZHZBcmQxN0xzZ1Nn?=
 =?utf-8?B?RUJmbUM0SXU2ZDhYS0RidWd5WTZ1KzdWbS94eEN6SllxUG96WElkMWdaUmxF?=
 =?utf-8?B?aXRCOTV1Q1dzWU1nd0RTNFJpOXhPcHMrdUI5UWxaM1JSKzA0QzY2aXFzamky?=
 =?utf-8?B?OUJaZ2xickxZQzJNVFpQU1R4aEZVczd2SEkvR1pCdkRiUlNzcGtScXNwN2U4?=
 =?utf-8?B?ZlhyZWNUckdTVW4zUm5DMGI5L0FzcEJOY2ZRd0NMRzI2YUg0L3JvVHhxT2F5?=
 =?utf-8?B?bk9PVzhWMGZabDlZQ3BkUWtJckF4bCthUkxrMVQrQXpub1RKTGJTbWlqbzBY?=
 =?utf-8?B?RktkRG5OOWtPZ3NoQjErRkFtRzd4cTh4NmpxdCtVUWg2aTI5TWhVeWxCdENG?=
 =?utf-8?B?aFpxWkNwNGtkYTh5SzM2dytENUxlRDdOSTl6Mm5jZmw5VG5yT2tyWnlNN0Nn?=
 =?utf-8?B?RWtjMy94dEZBZ1krbkFxR1dSY2pETWpPL1BiM3dXemtDeGwyQ0FVNG80dDZa?=
 =?utf-8?B?YnI0UllxSk9DZVB5T1YzaVhsVi9JSGtVNlI3U1hHYm0veFRKM1FpTHhkd0pS?=
 =?utf-8?B?cVVER1JtcWZCcXlHc2tkaHFlanE3b0s4SDlhTHJtVGlWWWQycVpVeW9aTUhO?=
 =?utf-8?B?K3BBalZMbUZ6RmdwZE8rUU1hWE0wNm5HelRITlZLSmhtVWczSzNjVm93b1c5?=
 =?utf-8?B?MmdGL2pXSTlILzVsbmw2QnJrNVpzWUVadzVIMGhPN1dQSW5scFJ4Zkh0eHBx?=
 =?utf-8?B?b1NlMUs3MENxV2UrM0NpazcyTHRJODlyRGtXOWViWk1HWDBoQjR6cVgranZl?=
 =?utf-8?B?MEJtYWwycGxOdjk1b2t1aUlEd0RZWlBPcytzVWJwanduSW9OL3V0bjVOeWNS?=
 =?utf-8?B?WUFRYkErQUtRdnhRV3JncDZubHU3dm93b3VNSGdFMTlTMkpLWkErMDduTDU1?=
 =?utf-8?B?eGx3N1JqVmtFaTEyQU5IUEk3a1UvdVpoTUJTd3JEZkN5VlpUNGVZam5DSWZ3?=
 =?utf-8?B?cU5FU3h0bXdpa0FOSnlIREkwRlpCckdNd3BlWjJuSXoyalpCOXhLUUVjYU9M?=
 =?utf-8?B?ZjhSekhMdnZwZk9QQ091dnBJNTQzTjFIbTFCM1VmanRBVDBvWW9CVC9SVWVL?=
 =?utf-8?B?UDFlREZSOHRobW9GMWQyd2ZQNlBSNnliSGlpOW9jL00zc0lad2t4Mzkyb3Vq?=
 =?utf-8?B?WWRZaEhjRXZrNytrbFdLOW1xZnFZMzc0SGJISkhRY3BwWHVhMWFnTHNXa080?=
 =?utf-8?B?eG9jc0FzKzZkblZFQ0VkdDZyOS96dC85cDBoYUxqVVByN0JMdkhqQkxxcU1M?=
 =?utf-8?B?U2lLK29QcUlIbE5BSUxUTzBFRnJrbEpXRmtmZnhJR1N0RE5pLzg5cEt3b2M2?=
 =?utf-8?B?QXpQNEJXWW93ZUN2RnNpemJoalpHN0ozMXRPWDVBd1dZeFBIZ0crNUxvUjMx?=
 =?utf-8?Q?dRaBXIUM1ez0Lx2Csg=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ac5294-04a7-49bc-b0d2-08db6cea5686
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 15:16:33.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3520
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

在 2023/6/14 21:00, Guenter Roeck 写道:
> On 6/13/23 23:27, JuenKit Yip wrote:
>> add medium repeatability support for matching datasheet
>>
>> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
>> ---
>>   drivers/hwmon/sht3x.c | 29 +++++++++++++++++++++++++++--
>>   1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
>> index 5bc0001b1..eb968b9d3 100644
>> --- a/drivers/hwmon/sht3x.c
>> +++ b/drivers/hwmon/sht3x.c
>> @@ -25,6 +25,10 @@
>>   static const unsigned char sht3x_cmd_measure_blocking_hpm[] = { 
>> 0x2c, 0x06 };
>>   static const unsigned char sht3x_cmd_measure_nonblocking_hpm[] = { 
>> 0x24, 0x00 };
>>   +/* commands (medium repeatability mode) */
>> +static const unsigned char sht3x_cmd_measure_blocking_mpm[] = { 
>> 0x2c, 0x0d };
>> +static const unsigned char sht3x_cmd_measure_nonblocking_mpm[] = { 
>> 0x24, 0x0b };
>> +
>>   /* commands (low repeatability mode) */
>>   static const unsigned char sht3x_cmd_measure_blocking_lpm[] = { 
>> 0x2c, 0x10 };
>>   static const unsigned char sht3x_cmd_measure_nonblocking_lpm[] = { 
>> 0x24, 0x16 };
>> @@ -43,6 +47,7 @@ static const unsigned char 
>> sht3x_cmd_clear_status_reg[]        = { 0x30, 0x41 };
>>     /* delays for non-blocking i2c commands, both in us */
>>   #define SHT3X_NONBLOCKING_WAIT_TIME_HPM  15000
>> +#define SHT3X_NONBLOCKING_WAIT_TIME_MPM   6000
>>   #define SHT3X_NONBLOCKING_WAIT_TIME_LPM   4000
>>     #define SHT3X_WORD_LEN         2
>> @@ -69,8 +74,9 @@ enum sht3x_limits {
>>   };
>>     enum sht3x_repeatability {
>> -    low_repeatability,
>> -    high_repeatability,
>> +    low_repeatability    = 0,
>> +    medium_repeatability = 1,
>> +    high_repeatability   = 2,
>
> Why the assignments ?
>
Maybe it won't be needed.
>>   };
>>     DECLARE_CRC8_TABLE(sht3x_crc8_table);
>> @@ -89,6 +95,20 @@ static const char 
>> periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
>>       {0x27, 0x37},
>>   };
>>   +/* periodic measure commands (medium repeatability) */
>> +static const char periodic_measure_commands_mpm[][SHT3X_CMD_LENGTH] = {
>
> FWIW, it might make sense to add the command for blocking mode
> (0 measurements per second) into this table to simplify the code.
>
I am trying to do it and review the effects.
>> +    /* 0.5 measurements per second */
>> +    {0x20, 0x24},
>> +    /* 1 measurements per second */
>> +    {0x21, 0x26},
>> +    /* 2 measurements per second */
>> +    {0x22, 0x20},
>> +    /* 4 measurements per second */
>> +    {0x23, 0x22},
>> +    /* 10 measurements per second */
>> +    {0x27, 0x21},
>> +};
>> +
>>   /* periodic measure commands (low repeatability mode) */
>>   static const char periodic_measure_commands_lpm[][SHT3X_CMD_LENGTH] 
>> = {
>>       /* 0.5 measurements per second */
>> @@ -448,6 +468,9 @@ static void sht3x_select_command(struct 
>> sht3x_data *data)
>>           if (data->repeatability == high_repeatability) {
>>               data->command = sht3x_cmd_measure_nonblocking_hpm;
>>               data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_HPM;
>> +        } else if (data->repeatability == medium_repeatability) {
>> +            data->command = sht3x_cmd_measure_nonblocking_mpm;
>> +            data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_MPM;
>>           } else {
>>               data->command = sht3x_cmd_measure_nonblocking_lpm;
>>               data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_LPM;
>> @@ -595,6 +618,8 @@ static ssize_t update_interval_store(struct 
>> device *dev,
>>       if (mode > 0) {
>>           if (data->repeatability == high_repeatability)
>>               command = periodic_measure_commands_hpm[mode - 1];
>> +        else if (data->repeatability == medium_repeatability)
>> +            command = periodic_measure_commands_mpm[mode - 1];
>>           else
>>               command = periodic_measure_commands_lpm[mode - 1];
>
