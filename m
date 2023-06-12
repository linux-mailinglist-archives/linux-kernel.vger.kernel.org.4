Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A6272BEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjFLKaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjFLK3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:29:37 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2081d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::81d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A665859CB;
        Mon, 12 Jun 2023 03:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw0sMEeeb7ptNEVfkIV2iZFwMQ4P3d5YiG6jVY1xxYPamP1mqR+BAzU6IFW6oj4sJl1z32yM8mnd4hcT6qJgyCnlskzQYkWqpebgekEARkNOY6zK/8jszvNdT8zjht94DwK7AHgCD4c73JjQKaFxe9FPeSyB2qVzJeYjI0KjjACOSEV+rlDfKfKeptT91sx6S2MYZbbu+0lU0wYwKudW8T/f146u+n5n9FRpminKFBsZzUlOkH8BtHPvh8IKtKQkM3W8SElF87/Z4OwkVHCmeukMCTccG2HuzmuaqlFZQZ2j2gjGi1/mYdvj5BYS93NeR4ueV0lE6qdNO/lrtLkB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ax2fZvYllrrvKMLP3FdI8BYSR81LHx4c0bbgVDM0rro=;
 b=W/6w+fjZCzl/4weS3nOEiG8yImGRvBJaWu2odAgF3zvV4KfmRjDVoS6oCTKYO30vfkTSI6w8sipwgIHada7vyWTUIDg0LUMmyylKZTekJ/Q19iIb0xvBNViSQAr1NXYdNsswSsM/MjLqf1neVJ+w53L/+/iPVPlxruHc3dK/YPz5fW3CjD+A/WMdXIJw8PknG+YAIqGXJkdE+C4fyYFe5xhXOSqkM3WPs+9SnTr4q0nDzlxJi9ptsE9xMybrzKbJV2UogwnsMIzzpf6SjWaomT+uS7QT/E3yoQ6Qm9bUMQRXoIrtigT9P6ZYxpwP2s49b7JJHMl6YqE/Ryqq6TRNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ax2fZvYllrrvKMLP3FdI8BYSR81LHx4c0bbgVDM0rro=;
 b=iAP2rcoUHTz0atpgf8MaMSAZX685Adk5+BKbkOubBd182EWT4PZ6W1eAgowp9/gDoRTib9u4EEB4hQaLK7icNlogqvJuZ/Eo8xSEGLFU2JlOPjlJ58NLwgZNEybg8fKG/0BlnhccQbLkC4PHH7pdAhXaG5tbJ2uAXqbgSON2j0x7AOasS7ePiQadgNRXMl1NdYVCHjVC7d/S1q7n9L3YI4MZGb2Y6uq/xdLjQQVpl0Oa/j4S1sB3/yesDu3n24DK1p3TZnDEK2/2mEMS1IFQfkwDrSGood1NTvzeUeaCPBKXY78XRZrS73/tfjIXnBvbCCfMjRJ54YxAhdsL3fGdcg==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 09:58:50 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 09:58:50 +0000
Message-ID: <DB4PR10MB6261BFA04779E6BCFF7A07799254A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Date:   Mon, 12 Jun 2023 17:58:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC] sht3x code modifcation
To:     Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com
References: <DB4PR10MB62612F917CF1BF8FB03927609254A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
 <898a6ebb-b0cc-5a48-30da-c4a5dc19d1a4@roeck-us.net>
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <898a6ebb-b0cc-5a48-30da-c4a5dc19d1a4@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [wJqcl1+luECjRdCN6tdhQuACTQw7mOaG]
X-ClientProxiedBy: TY2PR01CA0011.jpnprd01.prod.outlook.com
 (2603:1096:404:a::23) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <9cf9385f-844f-a477-bd91-27ab804e78aa@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|PA4PR10MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd22303-44ac-42c2-cd99-08db6b2b9ef8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlI0jC5nBsU910yTIfHIuR+Y9BSAK20EKLvpjqD59aSnOlFqUd8E2/Awno5tQ02OtiE4AWnB2t+B+FMFKDH2zIdzXW7ifeNuA8IKN4WE8PwhnPDEV8Ea2+3b7rlHl9+ILwL2HTBbo1IXiC5SyqR/p8aIYXKxeNFl1B84iBoeEyOsuReTXTUD+9s+JVOb8/SNWliwOr97yFFVJiXVaKBtz7A3eRgqLwxj3Q9yJzrU+htzJ3n0J4EnDT0InIyab47+CIgBDPajnlVTdSntSxudQmxRnprbMbYkxLhSFA4hJjg0hpWZ5/UXwjXY67pIeqi0nEv9Tm67tJahorLaiUGvxgSxzfG9PJM7qtD0pCKiqrB02kGvndglqRRd8nUc6J5mD2H6ULyO6iGNf4sWXNP3NhwZrwL1tcDKF4x5DNhMmYz6zuKA/3P1mdHYaHhg6aXjdrwnJA9oCdmsoT82u9rB+TUCOy+OTKdu8gscpXH62Cxrv8z4Jg+OwI8XfKlnKZjzqOmZf95vXaHiAHfYThIuUulf8k6XB13I/r2rofBo0KmT1jbwiYoxnOnfQTmj9UYhpXE9xYzC1gKcWoCgxKnwkF8LEmsNUqe80yofi906kizeLR913JmcJIp+CtGjUz6v
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHF6RXBWb2VCNzFEbithOHl1MG5XWlN2b2M5S1hOWWJIRjZtZlZHZk9NTzRE?=
 =?utf-8?B?VzVZWll6SXJ0L0JKeHVpV0tpcTRJUXFxelRlMER1ci9FdGF5WGQ5VDFEbzVI?=
 =?utf-8?B?bXJ4aHUwVW9kZlBwRnVlc25aRXBVaGp6ZVpzbVVwMjJwQ2EzVW1PTWIveExJ?=
 =?utf-8?B?L0d2NGMzTnlvb056d2hEQUZ5TjVUS0VaUzQzVDZpVEFDVnorWFlOSzJFZXhZ?=
 =?utf-8?B?QXRobDQ2aVY1OFhCTFhZQ2ZScXc2Nlk0L0tDTGxLSXlpdDFaMEp6VzFBK1Ju?=
 =?utf-8?B?KzZFdHU2aHFGaW4rdTY3OWpNTUdheDFUTDJHQ1dSVks5dzkzdnRoVFRyVDlR?=
 =?utf-8?B?eUo5SFJnTEVadWcyRFFoN3hWeHVFdWNlOTVWSWFBdmp6V2JqQUY0blZQMGE1?=
 =?utf-8?B?dXNmMHQ5WVVsZjJVTVExcUQzRU9UdnUyQXVQclIwZThpTi81ZGs4R3NtOEpl?=
 =?utf-8?B?MFUzVGJnVW1CZkYxa0xydlpwNkFQdXREM1Z5WCtCNTdJRkFZUUNyRkMyOWc0?=
 =?utf-8?B?RGQxYUdMUUtpdkZEcUZYWHBrWHpJNVc2d200cXZ4bXNZbURuZ3g0OTd1a2Fu?=
 =?utf-8?B?NW9lM1VUYlg4RFo5SUp3enh6aHpBeVJ4ZTJObFFPRFhNdXhod0NWWDliQ1Zy?=
 =?utf-8?B?dEhteWZZU0hvR0ZnalMrNE55bmQxeWJOZmExMmcwM05qWm9JZEthVUxWN25r?=
 =?utf-8?B?UmtHWXBaTnBTMTM2Y0g3c2VYZ1ZkS05SYUhkNVNGUnVwZWw4bW1nY2hTR2dl?=
 =?utf-8?B?TVZObWNkYlFVaHk4MG1yanRvYU5CUkhKQUdPdXVIZnJzamxTQ3VaMlBnQVdm?=
 =?utf-8?B?aE5QYXUrelhTUm4wc1lxMmlESHo3cm1UWWlQQVJJRWJNenZJbXFFNm1yWnd6?=
 =?utf-8?B?MVZzYS9MYWdZVFArUm51Uk9XeU9uTi9nZEF4RFRnUnpGaFBXSzlnMlNLSlpr?=
 =?utf-8?B?MXZuOWJLZVdaTDYzV0V2Y21CVUZwSHNqRU9la2xTbGFpbWlxeWYzR0EwK1pD?=
 =?utf-8?B?TVJPc2RZbTN6N3FmS2hzWC81VGErM2NHdXJIZHJ4d3pXSDVEVStxeTI0Vm1L?=
 =?utf-8?B?bDZ6VFRlaHIzY0FsVDRrZ3Z0Nk1IdkpQWlg3WGpSOUx2SFNRbDhoUmVENlZ4?=
 =?utf-8?B?WmU4cVpDQ0E5aGpab0FCMDg2R0NwVkhsbkZ1dE9kcDYzeDMzWFdSSWNHUTNs?=
 =?utf-8?B?SDNvaVBjbHBWc3lrT01rT3Z5Nkp2Y2tocFcxL1FKYkRMYUwrb2szdUkxSmFQ?=
 =?utf-8?B?M2xzSWVrWEszdEE5TERnOVVJVFh0aWFsQ0M0L096eEE4b0JvNGVvUHhRT2Q2?=
 =?utf-8?B?amN4MFZuZHBLVjZlZU1DSGlnY1ZJTkpRenlzTVVzbHEzUUQyY3ZWTTdFKzAr?=
 =?utf-8?B?SDJQWkZHZkphSUlsVDFnN1IzeE8zcWtIa3VFdTh5alZZY2tIWGFZUWt3Q2k4?=
 =?utf-8?B?eEc0eitiSUwvdUdkTm5qMWJUc0x5Z3Z0V2NEcnBPMzJQNHNNVHlFNnlWODJ5?=
 =?utf-8?B?czVkNTFoWFQ1T2pyY1Z3MWxBbVg4VVVMckY3M2R4UlZnM21IRVlmeGFyUGRK?=
 =?utf-8?B?SXFOZjkxUmttejhxTTNUbU5PZnBSMWRVWHJkWnl0WlVtUUFNNVorVDFYd0x2?=
 =?utf-8?Q?9+jl14SSURl9kvuvvpHPl3cXDev3anf+8U/prAYDqvFY=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd22303-44ac-42c2-cd99-08db6b2b9ef8
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 09:58:50.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5780
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original code only support two mode: high-precision mode(high repeatability and
10Hz periodic measurement) and low-power mode(low repeatability and 0.5Hz measurement),
but in fact this sensor support 5 periodic measurement duration(and single shot) and
3 repeatability which are not fully implemented.
High-precision mode was defined manually so that I think that we should reserve the
right to user to choose which one repeatability and periodic measurement is the best.
I just put the patch for reference and hope you could give any comments.
Medium-repeatability was not added into code and I hope put it later.

If you have any other further question, kindly contact to me.
Thanks

Juen Kit Yip

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>

---
  Documentation/hwmon/sht3x.rst       |  6 ++----
  drivers/hwmon/sht3x.c               | 27 +++++++++++++++++----------
  include/linux/platform_data/sht3x.h |  1 -
  3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
index 95a850d5b..c6b7a1aa5 100644
--- a/Documentation/hwmon/sht3x.rst
+++ b/Documentation/hwmon/sht3x.rst
@@ -28,15 +28,13 @@ The device communicates with the I2C protocol. Sensors can have the I2C
  addresses 0x44 or 0x45, depending on the wiring. See
  Documentation/i2c/instantiating-devices.rst for methods to instantiate the device.
  
-There are two options configurable by means of sht3x_platform_data:
+There is only one option configurable by means of sht3x_platform_data:
  
-1. blocking (pull the I2C clock line down while performing the measurement) or
+   blocking (pull the I2C clock line down while performing the measurement) or
     non-blocking mode. Blocking mode will guarantee the fastest result but
     the I2C bus will be busy during that time. By default, non-blocking mode
     is used. Make sure clock-stretching works properly on your device if you
     want to use blocking mode.
-2. high or low accuracy. High accuracy is used by default and using it is
-   strongly recommended.
  
  The sht3x sensor supports a single shot mode as well as 5 periodic measure
  modes, which can be controlled with the update_interval sysfs interface.
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 8305e44d9..6065312ae 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -22,11 +22,11 @@
  #include <linux/jiffies.h>
  #include <linux/platform_data/sht3x.h>
  
-/* commands (high precision mode) */
+/* commands (high repeatability mode) */
  static const unsigned char sht3x_cmd_measure_blocking_hpm[]    = { 0x2c, 0x06 };
  static const unsigned char sht3x_cmd_measure_nonblocking_hpm[] = { 0x24, 0x00 };
  
-/* commands (low power mode) */
+/* commands (low repeatability mode) */
  static const unsigned char sht3x_cmd_measure_blocking_lpm[]    = { 0x2c, 0x10 };
  static const unsigned char sht3x_cmd_measure_nonblocking_lpm[] = { 0x24, 0x16 };
  
@@ -69,9 +69,14 @@ enum sht3x_limits {
  	limit_min_hyst,
  };
  
+enum sht3x_repeatability {
+	high_repeatability,
+	low_repeatability,
+};
+
  DECLARE_CRC8_TABLE(sht3x_crc8_table);
  
-/* periodic measure commands (high precision mode) */
+/* periodic measure commands (high repeatability mode) */
  static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
  	/* 0.5 measurements per second */
  	{0x20, 0x32},
@@ -85,7 +90,7 @@ static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
  	{0x27, 0x37},
  };
  
-/* periodic measure commands (low power mode) */
+/* periodic measure commands (low repeatability mode) */
  static const char periodic_measure_commands_lpm[][SHT3X_CMD_LENGTH] = {
  	/* 0.5 measurements per second */
  	{0x20, 0x2f},
@@ -132,6 +137,7 @@ struct sht3x_data {
  	struct mutex data_lock; /* lock for updating driver data */
  
  	u8 mode;
+	enum sht3x_repeatability repeatability;
  	const unsigned char *command;
  	u32 wait_time;			/* in us*/
  	unsigned long last_update;	/* last update in periodic mode*/
@@ -442,12 +448,13 @@ static void sht3x_select_command(struct sht3x_data *data)
  		data->command = sht3x_cmd_measure_periodic_mode;
  		data->wait_time = 0;
  	} else if (data->setup.blocking_io) {
-		data->command = data->setup.high_precision ?
-				sht3x_cmd_measure_blocking_hpm :
-				sht3x_cmd_measure_blocking_lpm;
+		if(data->repeatability == high_repeatability)
+			data->command = sht3x_cmd_measure_blocking_hpm;
+		else if(data->repeatability == low_repeatability)
+			data->command = sht3x_cmd_measure_blocking_lpm;
  		data->wait_time = 0;
  	} else {
-		if (data->setup.high_precision) {
+		if (data->repeatability == high_repeatability) {
  			data->command = sht3x_cmd_measure_nonblocking_hpm;
  			data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_HPM;
  		} else {
@@ -595,7 +602,7 @@ static ssize_t update_interval_store(struct device *dev,
  	}
  
  	if (mode > 0) {
-		if (data->setup.high_precision)
+		if (data->repeatability == high_repeatability)
  			command = periodic_measure_commands_hpm[mode - 1];
  		else
  			command = periodic_measure_commands_lpm[mode - 1];
@@ -691,7 +698,7 @@ static int sht3x_probe(struct i2c_client *client)
  		return -ENOMEM;
  
  	data->setup.blocking_io = false;
-	data->setup.high_precision = true;
+	data->repeatability = high_repeatability;
  	data->mode = 0;
  	data->last_update = jiffies - msecs_to_jiffies(3000);
  	data->client = client;
diff --git a/include/linux/platform_data/sht3x.h b/include/linux/platform_data/sht3x.h
index 14680d2a9..626c1404a 100644
--- a/include/linux/platform_data/sht3x.h
+++ b/include/linux/platform_data/sht3x.h
@@ -10,6 +10,5 @@
  
  struct sht3x_platform_data {
  	bool blocking_io;
-	bool high_precision;
  };
  #endif /* __SHT3X_H_ */
-- 
2.30.2

在 2023/6/12 11:10, Guenter Roeck 写道:
> On 6/11/23 19:16, JuenKit Yip wrote:
>> Hi All,
>>
>> I was using sht3x driver in my linux device but I saw that it should 
>> be put in IIO module properly.
>>
>
> Why ?
>
>> In fact, I am going to add medium-repeatabilty and device-tree 
>> support on it, and planning to add more sysfs interface 
>> "repeatability". The orginal version did not support to modify the 
>> repeatability after device loaded.
>>
>
> I have no idea what you are talking about.
>
> Guenter
>
>> If there is any comment or idea, kindly show it.
>>
>>
>> Thanks
>>
>> Juen Kit Yip
>>
>
