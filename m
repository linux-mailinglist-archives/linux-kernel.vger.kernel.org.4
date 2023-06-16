Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6C573354F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjFPQBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345700AbjFPQBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:01:01 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2067.outbound.protection.outlook.com [40.92.58.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D362630E3;
        Fri, 16 Jun 2023 09:00:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mV0UG12F2k9aLiDlT6+hcH2jc2H2yD6rKbUNjsFY8wCgTJ4/8P/vxA6UoxnwYwOehc0CYy2epMndkHNMKYUQK0ilU6HuHhhpAN1qe4zgQW4669SabGvq6pFsREgGLZu7IJUiI+wdAPQa3bVxYkambMYQ/mjc7Gc2ZdxKyBzqBmu8ebs6EnVijbzAc5uvB6iK8HZimDrJfajL6HEBLwjVcmYnVMDovPnwadKdYFbb2XcbX1L8PuFdt5+L2WSFt8u/Z3WHlkdM3pgAHsaffkuZlps5RVxySx2VByr9hXXhSxXfoxXUtxh330XYx3zn4yGqUh55LGbe8zuZcav4ti3uVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUjnQSrCoyHWD5oHNZu1W6aWvRlBuJ/UIoaxRYbWuBI=;
 b=f6AoY28j8MC4DmXvQJxPnSbQpxo34Z3qcMqTljje8HcDjaeF93sOriIvRai1x6ytHKQY2BxbsF/LQIyTP8roLPT0gFImIMyVUxBYUrHllA3mqXxNXNujb5ZUbFlxa1PoWwEHiCKgdWAGC8P2WV9DDgtmZrypB///lj+OcyH8C8zha06TNJL2/Of8NrOhok8kzLPSR4irFjijnj8Gm66kMihlLOeJm0L6ZqrFNz9YN02cR/ml6qRIjoyODCRto+H8IhA0oes68KcHV7C+fSg3vsOJa8/S68FY3eupznhaMcqEgy4DllzBeHf4oAKx5nJCFGnXf3LxSWC6n/QJ6Rjenw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUjnQSrCoyHWD5oHNZu1W6aWvRlBuJ/UIoaxRYbWuBI=;
 b=s37f9VP40Hjh6906o8I36pOt1s4q53x0KtKTtCa5v0qVR5G+NBo8ZeaiAAsYmirD7nUcNLtbD2Mqyorgk5STCq74PK4vdewf1jjZZlhUGrChild1GzkH3dpFCnlUHEmojqOjtvXwirpsKl7F2smuTkEWHSGvYOcezFw+gqP7le3e5vFWnYh8syjah2tMXlH5Ps+KUgTB10W9llSly/hDMtxPXMeKBHEGmxCcXGgU0Ep3rZt9njoeE8mhAoX62MCLGTloBGCvbJ672Atw1e8cZb18TulRkJotJx9xU1iazjYHQsaC5w3xlSkRBQ7cTOiPALltrEDewWuiQTRQbfxebQ==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AS1PR10MB7959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 16:00:56 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 16:00:56 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH v2 2/6] hwmon: (sht3x)remove blocking_io property
Date:   Sat, 17 Jun 2023 00:00:13 +0800
Message-ID: <DB4PR10MB6261DA9202AF37B4F6ECDD6C9258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
References: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [f8TUa61pu9CL6hb+xCuc4MYEa/ca/+2H]
X-ClientProxiedBy: TY2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:404:f6::21) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230616160017.21228-2-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AS1PR10MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: bac18c3f-a56f-457b-c422-08db6e82deca
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrST/aUJU0/QQB6BlKfxJxwtL/a5+V7Wlmi3WmM+yesaGcSi1CYG5tytDB3PyIfnFVav7kv3kkdfWd5qkKpE+4tbOipqdSpYeZJI8qWL3xu39rtxhF9clk08WVj1P4cpioz6To60Ox/yaqVr1BLDU5Rw4lRbpTUJ40Szb85j1pQ9VryUDbWC7rYdBxyhhFcurpQRAQi5WC6pSe12A041WeBc0XgJrzNtuucm3LyQECJYibTwdylyQMjurM9K8M+jz4I4WymvKP6iWjOJ8b3BwJjc4pLTXqo28PpQl7oYx/A5Cd/WNMkZEyP6InJptRVzaAli6AkQMdCY2aon6bgtFBiHuG4/B3mvV5LiKephry/eTIqui8B9tvtPfWRK/PTr0GbjPe7PbY+whyuLGdKbq3Z6Imja3ink6Wut+cAbQJGzqwZWGBWB43t62MQB9+NYtxyZsAgjM0p9Mt8KJD4mMNP6m2FoKyDkaf/7lRS0YuySXeGy46YHZLEo/qn7m2vckhTSWTueRqA5eDkbusvOIbjsX95silZ/dL+ARLYdkwBgpCoM5MGxkv8UHXrowMoGpeILin1I5QZJ0jBAXlJnH+GZ+FlytgIYjeBBm2U/Ff+slvimNiYn9LeLLjZr0tdN6ZAl/+6FPOjLDfYNtPCZOm/hBrW95EcqBstZzdxwbSaWwK9yp7cFPHKe5w4HCERAElkoD/eSl2eE8FyT0o1KvgI9uBbtZhGq5yizYHp/f6pxISggHFJv2J3BwzpAKevEnc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynVyVQLVzyhcJ74hqPF1lTKPR+VRhDEyL/mx/jWH4OGuXJx5oKVWpeDQ+k6p9WIDAazzvLCWkjfzWAbWxVN7V7NcFEzlWWUeU1bfsMbaKv1cMYpY0sOWs/mzvaiCybgZ7ULMqFb3vBUtOUf44s3ecP2Cxhf5wejm8w7HHvT/5oclcglgX/BBOHJdybDR2irXw4y5W8kuFltaeaySnez86h3lGYjXGAzvOqCHHu+qSDhwE8opNanxPDqEVZLhdr8Qt1Uua3Y2N+5tz9C9yZnajzF1ZOsWOP4pj88ZAzqK7WV5anvbHgOI3yoMvxC9+9M+VlO4G4fhnQ3pG8P+ZVv1KfLjnZoDFHMPnT0Sa8E/92/bXcfZmTVhlaUMUIwtYzgADMGWEwwf2ro7Tkoz1H67uYbz9Tqyl1o6gCsvBlAeoN0fHd5kWabPSAbE+HqnvGABuPEBKC1BAsT7RIf3Q2BO+MiaN1fJUy2wa2E2mE3OTprUuVTfGxZq7Twc5TiOtDkroYmkepezCWTOmJOpzlojM078Yjd2PxZviZNcgC6HmrN541iIX0HzFpDKuOpo7hT7HHYnGbibkHBQXuHqRZiJegkCPkwJr6SKALNQ6FIXgn9CWwjHMy3R+ZHGzO5TV90v
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fZoUcULFZwZkNkiJri59m45+qRHtDJGtwCoCeZuSdOd19wVkAdIgNstv5vLW?=
 =?us-ascii?Q?fl6lvCikrpzZP3daCaYXdfJWw0NZmTiOq56cS6we0jNf/iKptnQIM8aYSHK6?=
 =?us-ascii?Q?vzlKBCvmGHqkWl6AuBxFen2spiBBKh40nUDTWrVBBoU3spONnC5xspyVUGMp?=
 =?us-ascii?Q?IZEJOn2taOr+NHiS2mh5zia/A9jt+ujr7ujhCBf/rWfNwCLkDOb5viaIpzxB?=
 =?us-ascii?Q?AAS2iXp4M8JMycabffYcq+138MBNn8SPCH7qjQThh+f0ps9gHuxjBMJJWmeV?=
 =?us-ascii?Q?ZPBB7+D6Iq3FICKH8mP4Nf4ekucwSIKHooTUlOVlrX5WadcRjRJHvZKqAe0d?=
 =?us-ascii?Q?FRxGSPrL/pR0UDP0D6xAhgcml+UHmDXNFtnXyiZ/K1NJCFZCEnSsW1gLHr6h?=
 =?us-ascii?Q?yD2OCioN0HUmNs3CVVJ7iIPIFjbSF8LLuBrxk3RsPPrVhexVk5GUggHE9yZP?=
 =?us-ascii?Q?5ED3JKZAPAQLWzzaEaS3ApRzRnfFdBBTwV8J+RlAg2soAhRuF1RpaGC+4cgO?=
 =?us-ascii?Q?TGgciFilShrqC6PT22rUd6GICBorJGH7Lp8P1BkZ5mcsAjbJlv3ZfVOov3qZ?=
 =?us-ascii?Q?WaCkWQlTm3pgd8MG+i6dFs8UB+0s86hIZ/yp0TwdF8IA/9/SD/gMsuR4tRuH?=
 =?us-ascii?Q?bO4qXiX+bM6gzK9+TDHqPk3x1ESvmDs4cozAj2FJKhPBiw0YsAGXFOdWm4NP?=
 =?us-ascii?Q?Yvs91t6JJIWxtCIFnZEIQHoBKsnxvjq6TJ4pazCiTfQ1DfRbZvDLVg0J9ELt?=
 =?us-ascii?Q?FlC1sBqRRTZbadXYyBuiFEvd2Ojjg105RRc40tNl2iWLDz7gciVtcHe0Kk/o?=
 =?us-ascii?Q?75q0UZQd8q7pNOVCOL2HStJmDEohNgyK43blsSzGXoPBoCGSKhjn685+IAW8?=
 =?us-ascii?Q?ohRxib+O/KdQqADBVdJcu+Ujy3UInMsFEqDlEmUreaeBZQ4RyQo/62OFYmr2?=
 =?us-ascii?Q?0R2h4mk+OptWhuxDcyZBgMQU6efRzpHtwq/xOK7uuUiHPaQqNQ0rNL1a/QPb?=
 =?us-ascii?Q?OmqOLEjCXhpNriTDRR6pruicIDJmSDh0FYyCFo57t9E1V2pEwGQEmBs1v7g+?=
 =?us-ascii?Q?b97O10q7xmigrgtco9eYRRcLpx5OfZ99LaN80XKxTyjxyJnk8wKwIYE1hVL3?=
 =?us-ascii?Q?l/9UMgrrM68jeTHaA4vFAB9nWsci+9v/RNpnMB0THBqACLu7qiFJXhYGi0NP?=
 =?us-ascii?Q?Hxni/JoFu8FYGYwAb6cNomlNFFSGQwi2ozNoGYgul9DpqXmGdKnU31CSyYY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bac18c3f-a56f-457b-c422-08db6e82deca
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 16:00:56.8462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7959
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to no support on clock-strench, blocking mode was removed and
now single-shot mode only uses non-blocking mode.

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
 Documentation/hwmon/sht3x.rst | 14 ++++++--------
 drivers/hwmon/sht3x.c         | 33 +++++++++++----------------------
 2 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
index 31fd36b14..be70e2543 100644
--- a/Documentation/hwmon/sht3x.rst
+++ b/Documentation/hwmon/sht3x.rst
@@ -28,16 +28,14 @@ The device communicates with the I2C protocol. Sensors can have the I2C
 addresses 0x44 or 0x45, depending on the wiring. See
 Documentation/i2c/instantiating-devices.rst for methods to instantiate the device.
 
-There are two options configurable by means of sht3x_data:
-
-1. blocking (pull the I2C clock line down while performing the measurement) or
-   non-blocking mode. Blocking mode will guarantee the fastest result but
-   the I2C bus will be busy during that time. By default, non-blocking mode
-   is used. Make sure clock-stretching works properly on your device if you
-   want to use blocking mode.
-2. high or low accuracy. High accuracy is used by default and using it is
+There is only one option configurable by means of sht3x_data:
+
+   high or low accuracy. High accuracy is used by default and using it is
    strongly recommended.
 
+Even if sht3x sensor supports clock-strech(blocking mode) and non-strench
+(non-blocking mode) in single-shot mode, this driver only supports the latter.
+
 The sht3x sensor supports a single shot mode as well as 5 periodic measure
 modes, which can be controlled with the update_interval sysfs interface.
 The allowed update_interval in milliseconds are as follows:
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 580704d93..bbe556f44 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -22,12 +22,10 @@
 #include <linux/jiffies.h>
 
 /* commands (high precision mode) */
-static const unsigned char sht3x_cmd_measure_blocking_hpm[]    = { 0x2c, 0x06 };
-static const unsigned char sht3x_cmd_measure_nonblocking_hpm[] = { 0x24, 0x00 };
+static const unsigned char sht3x_cmd_measure_single_hpm[] = { 0x24, 0x00 };
 
 /* commands (low power mode) */
-static const unsigned char sht3x_cmd_measure_blocking_lpm[]    = { 0x2c, 0x10 };
-static const unsigned char sht3x_cmd_measure_nonblocking_lpm[] = { 0x24, 0x16 };
+static const unsigned char sht3x_cmd_measure_single_lpm[] = { 0x24, 0x16 };
 
 /* commands for periodic mode */
 static const unsigned char sht3x_cmd_measure_periodic_mode[]   = { 0xe0, 0x00 };
@@ -41,9 +39,9 @@ static const unsigned char sht3x_cmd_heater_off[]              = { 0x30, 0x66 };
 static const unsigned char sht3x_cmd_read_status_reg[]         = { 0xf3, 0x2d };
 static const unsigned char sht3x_cmd_clear_status_reg[]        = { 0x30, 0x41 };
 
-/* delays for non-blocking i2c commands, both in us */
-#define SHT3X_NONBLOCKING_WAIT_TIME_HPM  15000
-#define SHT3X_NONBLOCKING_WAIT_TIME_LPM   4000
+/* delays for single-shot mode i2c commands, both in us */
+#define SHT3X_SINGLE_WAIT_TIME_HPM  15000
+#define SHT3X_SINGLE_WAIT_TIME_LPM   4000
 
 #define SHT3X_WORD_LEN         2
 #define SHT3X_CMD_LENGTH       2
@@ -134,7 +132,6 @@ struct sht3x_data {
 	const unsigned char *command;
 	u32 wait_time;			/* in us*/
 	unsigned long last_update;	/* last update in periodic mode*/
-	bool blocking_io;
 	bool high_precision;
 
 	/*
@@ -432,26 +429,19 @@ static ssize_t humidity1_limit_store(struct device *dev,
 static void sht3x_select_command(struct sht3x_data *data)
 {
 	/*
-	 * In blocking mode (clock stretching mode) the I2C bus
-	 * is blocked for other traffic, thus the call to i2c_master_recv()
-	 * will wait until the data is ready. For non blocking mode, we
-	 * have to wait ourselves.
+	 * For single-shot mode, only non blocking mode is support,
+	 * we have to wait ourselves for result.
 	 */
 	if (data->mode > 0) {
 		data->command = sht3x_cmd_measure_periodic_mode;
 		data->wait_time = 0;
-	} else if (data->blocking_io) {
-		data->command = data->high_precision ?
-				sht3x_cmd_measure_blocking_hpm :
-				sht3x_cmd_measure_blocking_lpm;
-		data->wait_time = 0;
 	} else {
 		if (data->high_precision) {
-			data->command = sht3x_cmd_measure_nonblocking_hpm;
-			data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_HPM;
+			data->command = sht3x_cmd_measure_single_hpm;
+			data->wait_time = SHT3X_SINGLE_WAIT_TIME_HPM;
 		} else {
-			data->command = sht3x_cmd_measure_nonblocking_lpm;
-			data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_LPM;
+			data->command = sht3x_cmd_measure_single_lpm;
+			data->wait_time = SHT3X_SINGLE_WAIT_TIME_LPM;
 		}
 	}
 }
@@ -689,7 +679,6 @@ static int sht3x_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	data->blocking_io = false;
 	data->high_precision = true;
 	data->mode = 0;
 	data->last_update = jiffies - msecs_to_jiffies(3000);
-- 
2.30.2

