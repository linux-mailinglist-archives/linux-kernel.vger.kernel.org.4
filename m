Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABF172F4BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243142AbjFNGZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243152AbjFNGZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:25:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2054.outbound.protection.outlook.com [40.92.90.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC85C1FCC;
        Tue, 13 Jun 2023 23:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzGniITmJDD0RFo0kKw0Tl3ia0lprwla3wXf2A+hZVQpiTGOsN4Z62wMxiXoXLlSYVH1US1vq4HlcKKYGjguut3XH6vyfQfV/W64k0cjkRDliOL6H9OseYEWuegjpQ7q247ndb2/u/eHJJDTs9Wt6MXH6vXQKkgiCmLLj5HDkjpT50+XniEdfBKd9Tyl6MlRVvGkzBwXTwJ2gCPRtG5i7lC58rrSwBV58KT1bVlHwaAOPVcGsArXP7w0TdWZNedFhC7U9hkQr1fdLqpNSvrW8dtmot/vHb3DUnPNAN7vB41iuI1zzbER9WbjRaGZSGxFYCRPwBqMIwZFfXD8uaStNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3IzD7v21WE0xQQCUNxip81zyG5AIiqCxmyW+1F1OVE=;
 b=jkLR1WCTKJp7G6DYnKpq7IksmLGBGD3a4/epvaMWzclvQmAM1O0+X86rcLLSKLvP0l1nOyvDPRvKCo0dBxWCfBiXFrRkfmGJkklMSU+sWupaoKMvX7iS0NvxxG8JqNOHmWHMSHPjdEWKbNcHbsxZ3L95ql7OWQL0psmcizbfyl+wSGBZydFqMK+D4bCO1QHohH63Xzz3mgFgJYazcGwAGBDIPkvkqwDjHr9j5LB/4pZx7YkSEaK7qIb2DhHvm0ouFBNHHa56D2F3V93dSDQHXwaZGB4mLUOvYb5jrstO44tcsVJfZ5ligg9UsPYgnctcnFaPjiHNqGmaMsDD/gBbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3IzD7v21WE0xQQCUNxip81zyG5AIiqCxmyW+1F1OVE=;
 b=bNmVp6tXYVa33B3O409eOIeM+r6TbMRrB1NVrLgvcRK3KqD5dj04335FOpLwQnZmamO4kFq6IcoCmlaAQGi5uxde/aENeEMsBYlUXD3FCGfSX50l6pRGuFMc3NBTYC8k74L7bHHZQos0k+z21MmNpF4UIVnVwQQ5QwAOHbk6g17ScixCmnlnMLXlFjAvhT7HBOXXYrESd1I1TtGjR1i79MhhsxpEvC7AXPodpZ/hzigG9PtRZ0Tqt7FIgbatTGkPiN2DRlnSTd8LzCLSxKARl3qQ5ezkq8cNPu/jTNl7FbR7IJrsVEtqp54dX2Ooft1VnRae7oE90t/mvcOSSsNxbQ==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Wed, 14 Jun
 2023 06:25:37 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 06:25:37 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH 1/3] hwmon: (sht3x)remove sht3x_platform_data
Date:   Wed, 14 Jun 2023 14:24:54 +0800
Message-ID: <DB4PR10MB6261D79FE16EC2BBD5316B91925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [MhnJGz78fSlRJzCaRQMIb9kTGs/XYyXC]
X-ClientProxiedBy: TYCP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::16) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230614062458.888114-1-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|DB8PR10MB3706:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c43a96-fed6-49ba-45f8-08db6ca02aae
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrOQku+SANv8F+rkkwqOSg82+Nv+s7faFNGAbPvNzLuFT9St7k75w4orUIfh2bzDK8q0oDaRNJRUzSMlhlmLTYMe0HPtDqBrRwi9dT62fDb1FU0Fg2ImX7Ujd8CUSHPMQjWo5nqKBa83Rjq8dUT9a9DDz1QqnrK6+yopG8zY5NlGKp+farf5mSBIK2ATJPmST942VI8XTqr0D1pQRNyZuSivix+nICNFGMU3DePlu/1eGQBtJSvjZgbWBK3yPOSBQIJelhNYv4GEq1misSRgma/kINrLsLnmP0F8ENv7hSOR2zLmAzREuXYlCrY2eq10WkYCAvspth/C+7KvOpvOcoOSK7ZLWCLaCaM+MQhdPz0lxwXoHNG7p1eGh8RlE6eoO+/kWhaMze0+WPE8m3aJyKfwBhXDpyO+YQRzyKXJQt05T05ARxy21tpLDUDpO4hzvNsdl+B3rlrL7UvSJNFdnhnDxFg2uEQXYXXVqQ4TxGQ6OEEevvwSNenSDeoFquKUtsRvP/2TCzn2jbbOTWcWOHZiJo/D57yIGA4NXJrDxFZXVGMjQrgR8QqX8dhDUJpmMQT2F0O2KF9u0A5z4k4ga8CJ0ZWPPKlWL8QqSPgV88/6c3X1EuUwwPEOZPCaQdEDP5f20zgq7f327he2T/ctTBywe/Z3EfoGPQyiAl7ID8FadDeofAkLEPEZ0Jt2jVQ7buZ0D5sBadgL2KH0Omr28IJUD+wcXJaLVezGXXWFMIOAuVCXCeNp6gD8oF0kP/9aDhE=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfB6J/OD5LRrHRzJEa0gp2QAjlUIh9hnPJ0ntkHBOiKTQVenxhm+q4bRrhCiey+wvIwb4kvnlaWHwTlwkj96sCJCwROhNsvnrdmPjooc9XhdjchKopXV2D86BTg6URDTIkvp9ynh/VrkMvJvu18ovdPemF664vX5sfwY9NzlUvj1MOquuVN6Dy1RQkpC+ErRY7HlWgz6dvhIqikGxI+ydg8NEqxNnCCZPjE9i4smzoR+zRnp8hy3AdBFjP66ua294npEoafjPvQejgO+pev3JjWABdBG4gJq7oMU/3A/3frKI+FrfBYY+wlEm/Y5e6Zn4LrSZamrvMFXHjYY9jfYPBIP4QGPn/T4IzyfmwLA6dfrhuoqomARdJC7N/YFr2BQLi5wk1Npk+0Fbqx3D+9N3LVBhlD2NbGtxLkK41V5sET/ntpS37o+JUQOjlUMx8QzTqivuIPR7qCpU6XV3mhTvESkv9Eww44K55FOQXwvPsj5GLZyOm7TwSsmbTwH96BLoPqEsdTxzvd8jqYAjjEK1oyjEDU2z44Csga8Nmh09VkgK/Bv8TV9Wqh9isDzqBgxMzejzTF0i0Bgu6iY5A6T9p5hfRtyML4ftrYlPcwRztRaYaYHGb+mUsOlNo5KRvjm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GSZ7gg/2n8QzIiaPDvqgQpg5CObCRSu/hBWIAoSUkl0gKkwDVviJ3yoVpiQh?=
 =?us-ascii?Q?ydsEjdLHNjOFevwNUuvazYJMoerxU3foTlVx2GAgfe4TXrJ5VBrwyA5hJX9U?=
 =?us-ascii?Q?YbvzILGwvpalvMAQCpmadj9xDaCJKG4gCVjI558/gNU/hbwDAzuhfJ5H3o++?=
 =?us-ascii?Q?+wSDdTitreibqGCYpZyZHW/BKwPY/mW4w9IzXjGH0hM0r+C642QcUW59dkbX?=
 =?us-ascii?Q?9jE31K9dwpR30SUw0mqrQo2vavbeeilYWSpfyAH5uJl2RRLjFUKl65gnK2ab?=
 =?us-ascii?Q?LXfy9PciZsXXJXCZJ9G+f70sic4EDw0N5vJ3i8nUuX1GObyBuDvaFutgo5Eo?=
 =?us-ascii?Q?T0lTYAVR6FUEBMLX21DOkf2e3K8S//L8pDd7DEiwXoDM975PQn+I7XF8jkAs?=
 =?us-ascii?Q?Nl3Wo9PrpPDJ1/oAQwFlwSd3p/5cBiUFxJUj1d50b/0q6lkO4JdmxUIKdf+q?=
 =?us-ascii?Q?aquCpcNhIyy3opzx5OmGK15NSXS6x4SNZmd0eZ5WQZIWKTdAub+WDs8DaPHh?=
 =?us-ascii?Q?zG9uK9EHx7wmeMNLIQ6ibS7WSlUv0DlE5v9KBapg2iN6Nm0quie6cH80NNP8?=
 =?us-ascii?Q?z+5UnAfVcmDzqNdto8vAUWvbArsRbyI4OX6IPeIraEPugSYjZrVuM1/C+xYS?=
 =?us-ascii?Q?2OhSXeVaSE4iWRUFQKrv6xOshgBEFpNmngI+2KlZjhEu3ygpwNT66dAam9eh?=
 =?us-ascii?Q?UEi9z+RnxMzbdCBWu5XD45ha+eMwtsXVNwBR47HZP1/S4pKVhdY8CBWTXKs4?=
 =?us-ascii?Q?L/stsXBftQz8mJtXk1f+MN4698K9QypvxXxtzLO/rcBWk2YmmUBimfXfWv7Z?=
 =?us-ascii?Q?nRZCDfzOJl9LYsyhMCfb69+ZKj6DEgkqsHIqzhzptxGok65ElGhw4nrWTwHs?=
 =?us-ascii?Q?B31CFMDjBOx9QZORLsgq9giQTDja2voBFfBWD7UT1S4ywlE5GgCG35Qq/T1A?=
 =?us-ascii?Q?egwO4Ql6T07hhIDyL5TSssyBcVE+rKeSuHor98sWzz4aotqUQRVWtYPIXh+N?=
 =?us-ascii?Q?CFKnp+vBImXEb2s+VexfnhRIew8gNijCVYKHAOvuQUbFNuoTXNBtUE+Mx1W0?=
 =?us-ascii?Q?9tSeNk/5pppEUX5ysQTqlfpm3Or52+5Biv0PzC23YpM/kr6Lz04v3xO351t7?=
 =?us-ascii?Q?aUnuNA5NJJ0WM8CBZR6Xaew1MgMUvXzTbxZsfokAfhmUeV127jSOba8gJNq1?=
 =?us-ascii?Q?qC4QCLDvuo5qS4byRzP7sU/pTlM2BMuXPkbToXCsAvcYSPsX4O9QMk29T8g?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c43a96-fed6-49ba-45f8-08db6ca02aae
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 06:25:37.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since no in-tree driver supports it, the sht3x_platform_data was
removed.

- "blocking_io" property and its related code have been removed, and
Single-Shot mode should be blocking in default.

- "high-precision" property has been replaced to "repeatability" for
matching datasheet.

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
 Documentation/hwmon/sht3x.rst       | 12 +++++------
 drivers/hwmon/sht3x.c               | 32 ++++++++++++-----------------
 include/linux/platform_data/sht3x.h | 15 --------------
 3 files changed, 18 insertions(+), 41 deletions(-)
 delete mode 100644 include/linux/platform_data/sht3x.h

diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
index 95a850d5b..2c87c8f58 100644
--- a/Documentation/hwmon/sht3x.rst
+++ b/Documentation/hwmon/sht3x.rst
@@ -28,28 +28,26 @@ The device communicates with the I2C protocol. Sensors can have the I2C
 addresses 0x44 or 0x45, depending on the wiring. See
 Documentation/i2c/instantiating-devices.rst for methods to instantiate the device.
 
-There are two options configurable by means of sht3x_platform_data:
+This driver supports block and non-block mode:
 
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
 The allowed update_interval in milliseconds are as follows:
 
-    ===== ======= ====================
-       0          single shot mode
+    ===== ======= ==========================
+       0          single shot mode(blocking)
     2000   0.5 Hz periodic measurement
     1000   1   Hz periodic measurement
      500   2   Hz periodic measurement
      250   4   Hz periodic measurement
      100  10   Hz periodic measurement
-    ===== ======= ====================
+    ===== ======= ==========================
 
 In the periodic measure mode, the sensor automatically triggers a measurement
 with the configured update interval on the chip. When a temperature or humidity
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 8305e44d9..5bc0001b1 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -20,13 +20,12 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
-#include <linux/platform_data/sht3x.h>
 
-/* commands (high precision mode) */
+/* commands (high repeatability mode) */
 static const unsigned char sht3x_cmd_measure_blocking_hpm[]    = { 0x2c, 0x06 };
 static const unsigned char sht3x_cmd_measure_nonblocking_hpm[] = { 0x24, 0x00 };
 
-/* commands (low power mode) */
+/* commands (low repeatability mode) */
 static const unsigned char sht3x_cmd_measure_blocking_lpm[]    = { 0x2c, 0x10 };
 static const unsigned char sht3x_cmd_measure_nonblocking_lpm[] = { 0x24, 0x16 };
 
@@ -69,9 +68,14 @@ enum sht3x_limits {
 	limit_min_hyst,
 };
 
+enum sht3x_repeatability {
+	low_repeatability,
+	high_repeatability,
+};
+
 DECLARE_CRC8_TABLE(sht3x_crc8_table);
 
-/* periodic measure commands (high precision mode) */
+/* periodic measure commands (high repeatability mode) */
 static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
 	/* 0.5 measurements per second */
 	{0x20, 0x32},
@@ -85,7 +89,7 @@ static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
 	{0x27, 0x37},
 };
 
-/* periodic measure commands (low power mode) */
+/* periodic measure commands (low repeatability mode) */
 static const char periodic_measure_commands_lpm[][SHT3X_CMD_LENGTH] = {
 	/* 0.5 measurements per second */
 	{0x20, 0x2f},
@@ -132,12 +136,11 @@ struct sht3x_data {
 	struct mutex data_lock; /* lock for updating driver data */
 
 	u8 mode;
+	enum sht3x_repeatability repeatability;
 	const unsigned char *command;
 	u32 wait_time;			/* in us*/
 	unsigned long last_update;	/* last update in periodic mode*/
 
-	struct sht3x_platform_data setup;
-
 	/*
 	 * cached values for temperature and humidity and limits
 	 * the limits arrays have the following order:
@@ -441,13 +444,8 @@ static void sht3x_select_command(struct sht3x_data *data)
 	if (data->mode > 0) {
 		data->command = sht3x_cmd_measure_periodic_mode;
 		data->wait_time = 0;
-	} else if (data->setup.blocking_io) {
-		data->command = data->setup.high_precision ?
-				sht3x_cmd_measure_blocking_hpm :
-				sht3x_cmd_measure_blocking_lpm;
-		data->wait_time = 0;
 	} else {
-		if (data->setup.high_precision) {
+		if (data->repeatability == high_repeatability) {
 			data->command = sht3x_cmd_measure_nonblocking_hpm;
 			data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_HPM;
 		} else {
@@ -595,7 +593,7 @@ static ssize_t update_interval_store(struct device *dev,
 	}
 
 	if (mode > 0) {
-		if (data->setup.high_precision)
+		if (data->repeatability == high_repeatability)
 			command = periodic_measure_commands_hpm[mode - 1];
 		else
 			command = periodic_measure_commands_lpm[mode - 1];
@@ -690,16 +688,12 @@ static int sht3x_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	data->setup.blocking_io = false;
-	data->setup.high_precision = true;
+	data->repeatability = high_repeatability;
 	data->mode = 0;
 	data->last_update = jiffies - msecs_to_jiffies(3000);
 	data->client = client;
 	crc8_populate_msb(sht3x_crc8_table, SHT3X_CRC8_POLYNOMIAL);
 
-	if (client->dev.platform_data)
-		data->setup = *(struct sht3x_platform_data *)dev->platform_data;
-
 	sht3x_select_command(data);
 
 	mutex_init(&data->i2c_lock);
diff --git a/include/linux/platform_data/sht3x.h b/include/linux/platform_data/sht3x.h
deleted file mode 100644
index 14680d2a9..000000000
--- a/include/linux/platform_data/sht3x.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2016 Sensirion AG, Switzerland
- * Author: David Frey <david.frey@sensirion.com>
- * Author: Pascal Sachs <pascal.sachs@sensirion.com>
- */
-
-#ifndef __SHT3X_H_
-#define __SHT3X_H_
-
-struct sht3x_platform_data {
-	bool blocking_io;
-	bool high_precision;
-};
-#endif /* __SHT3X_H_ */
-- 
2.30.2

