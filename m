Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2117872F4C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242719AbjFNG15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242549AbjFNG1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:27:52 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2063.outbound.protection.outlook.com [40.92.90.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547461702;
        Tue, 13 Jun 2023 23:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQR2x2EJnWujb7L8ZNbc1GY4SO/7DSvEJs10lGT5ncCbeS6keE9A3TM9fwt0vy+nooImiofOlvuiC9YLk8vJvfXPar3XqjkNxmxYa74kruk5BvQkJyO6Uh5OJFbvsNxoydI5IyV1zFdmTMgy3osEmqhjottv2gEfEgHto54sMvQT0X7EIUa9T52s2wngseiTzV+pdqSiFT9BB5U7c/CMZgb5NG0vAs6xH9aNl5BC4ntHFRpbNByTtcZ4RtF3gAxBtH4XQTi2gbLpejRFJx8dPnpOYURtweHctm2nCB16NkQ/PMmeUAiXPnI6PpE8ENG8wzd3US8YvKVMPQ0FLR+aXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oOuiYIgBbrGBq2ClEQzloAW/IZrZ+uV4T5YD2V35So=;
 b=a5byp3H/sbLVGVjjQ8n5nsgoKwoPvA8tzt2wq/sa3mj+v8qYPSpOuh69tj0bl1eBqZ2jaF4ml9ecMbu7D4lXnMezUHmXgecrgLLfbRu4AGW6y6syBEVK2qCdlTeL9mwz1b1CIh8dVA5Qb0BX2D7aqsB4z4xCHtMUvtR5a74KmCoFYOhFpGVVodWIG/DfpEW24NKln97bYRhsD49WhvWjWlLXAApUTpCI47bhMVEBUnF0X9EcUuykvU3a7b82tpHQ+ZdBaOnravVWfqmmjCiAG7sddDFgowkL4MmaUi9K7deWS0mHQktVuIO5B6Xh2hcnoWkL1pILQ15Bj75Lpzh44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oOuiYIgBbrGBq2ClEQzloAW/IZrZ+uV4T5YD2V35So=;
 b=jTI5GzPftmxjzYvy9xuCbYxkfWSM4WsFka9fNu8VHDZeNGmf5TT5FdXXU9mMOme9hSICZk2Bq6gtWz/8y+A/W+jCCvkjx3bhSW783yR2Vp8a+Hp0JB9x8x7myp3jmpG6h0MuEhAIPKNJuzIhDMDQgNXQbMsypQRot0S8Yem5ZGNKx+/6APZfboXw9w250QL59NBCuGoSkrPMAeeHk7jIPJjxk2hveIv/0N0GFnTzgyfUwKXfZiiTI1LgNhJKTvLXBTIkzbzKZZEoTUBLszt47YfUHHt4ybpZfE7gxUEdWAzjtfqK6J+eiMspYn8t4fCCSAkHwzj3EtJKjPRzvjhXag==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by GV2PR10MB6981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Wed, 14 Jun
 2023 06:27:49 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 06:27:49 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH 2/3] hwmon: (sht3x) add medium repeatability support
Date:   Wed, 14 Jun 2023 14:27:23 +0800
Message-ID: <DB4PR10MB62615481D91BA8A598234A18925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [T1qJXBObZldXK0pSSwLd58JnLDV85iep]
X-ClientProxiedBy: TYWP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::9) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230614062723.888171-1-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|GV2PR10MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: aaeacb4a-c051-4e16-ef7b-08db6ca07904
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKzwu8YPsqYDy7f7AA4ui0PNriGzB6Pm435daW4chHiPdy5Hpqg7lL0VqiX2x4RnTEZpS4kT1/6Pan/YbJ6XuJ0F77dx4l2D/03gAlSCdeiHEqFLPRcfeTlGaNzQ4e5jWP6BaKa1QmDlEwP3HMr6iJybyq2QeBAxPuHKRDwLbeYVj926JyNpeAdmu/SNbOzYWXkppXJH6MbofqyD/Aj8eRMd9IrNz2YBywii3LSC+wl0b17eP20CwPw7ETzpqMrT4oE/04HLw+F4xLjEM1wlYS0vmJEarI7JdVtD/Hl0LMvHkXqv8UlUzcvEv1Vas1Km7on9ABAM/s5Fh/NTT1owdHPTUDoUOxM3rCeD4cTEf2jTqPMMnt8SYpvjO+QYqHiHgrtECvwn+SDod0g92zRMa/RwezquI9jZ3uvvjmikAyMMCfM4Kx1DWA9dhHZJZ4tjRtGRgOG3/Xu3vMMYMUvsIGDlre3DWPAZx4OMpMHLiV7Pt9b14r7sMxc/ZP4AmLApsB3To+XDdU9XZ+jRYiVkugfSdeMbwg75seacf02ZpzK2Fl+O02XM0g8b+OW7LZD6G7l6qmxbTJO4u7UYX9oO/xVXXHcVZ016IK0mBP0LvHWPTV7rUnh0iQEAu5uj9wJ0o4gm/OipKogFGf2BwX8mitXOCYF/D/vee8MoSVyEPdgSKpfjakfPFyQ2aRRM8FLOzUCqFvE4do3o3iz8YVr1eg+0FxClVG9zm34=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D587KTrSf2RTXN6OVD/RWdTzzja2okmXDYRXPpfWAzOGO8wC2xR7A6EA+C9ZONonBsGIYduWkGcv9r+h8YuU9BJiU/qg82nhOgqy3GhkUJ0tB4KAAdeGysBYfUlMzIxDnvEIkNgATVfr0rJCsQ35/j+EkHmhHjVIqMFtnvh7jv+kzC1w8t5CvzCaPuvY6CPT/V5EavIWd3m937h5pPGlazgHO9UdmdHTFjq0GWgFTVqAHyPgQlROZLEbNUX+NUktOv/Y9YeMqVHuHcnGMqY/GLIWpz2jAdIa1f5AUXKYRU3R72fq4xvJeZBGOHqIzbjup76tZk66Cyk4o+Y4gyjh75yn8SaDLLMSNSqxjUoEOCLUOQefma4jOFie9OWENqjdPOPJiv09Hk7RdasBinziJfGyF6p/8uTXdy92vNKHzytMtZdnqXza5Za1MFNPgs4gx/7eTaRIWWMSzU4cCGWBZGygwWowk079xsxitstaE/4o9xqI9RdoUx0t39RdqLEAvoa469NixUdKmtIdKYFGD+z+4nxzqL3O3wGdcJMU0KmsWJLE3M70pFL7bc+rv2jO6avyLpJIQ+v48CHfuWDZExvJ1H7I1XL6BvWsvzBrDuHbXZT+d4iFA+++IMMdybtI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dTueGx782A9LK4l5mfT3h1UIaT9D1L5+r1RfBPW9D+3Jg3lzBzT0kXazlo0K?=
 =?us-ascii?Q?NxiT+pCPxmHJM2vsRpL1fvRC2gKJ+itpGr8nhSi2F+2VSU28K98wJwjwJfHt?=
 =?us-ascii?Q?Knrwk2OcouMclPMvX+DrBMZy8+hVUE1zsnqx7W4Odt3gbcyjhRWviBFH778p?=
 =?us-ascii?Q?JaJWJrQDXdilEpTf7TkUxJqcLMdiHEAfX+6mS5GbcDRHbF6jVv8/1soaqMzC?=
 =?us-ascii?Q?9noMu9OOouzdbTC7C7Q04B7FpiLYtIOvB04rQdyO2DirAGALgzf/WWuM5AEl?=
 =?us-ascii?Q?2WRGsGWd72f/MWaKPyjDHy/qvofmQoR7ArXOBu1o1qg89IPIhGOChcIQHgb0?=
 =?us-ascii?Q?nX1cL4QvGFP+xu6IeHxLRSR1P0TPRy/92NHjLBFMWg2wwytiCZhbIl3YJ8Ct?=
 =?us-ascii?Q?5dOUhBfhjS5zCTfW3q5ldDwUSjR0AEYHzqwYmSokuzFPhHXMuTnnIc3KBnI4?=
 =?us-ascii?Q?qjAI7fFlOydGyAkugsr3jdsdE66b9UrFRx9YFt6sn+hTZQAaVKAy7MPVFl2Z?=
 =?us-ascii?Q?ODil7FpFa7l5svuDR8WDJsJOZpziiE4gxBpjyuGR7q649tc8oI1E0mfJZCSk?=
 =?us-ascii?Q?JmrdnhC4pquKhUxUeHL/D4W356OGD5uVwgldwur4/mfq8c//o0xAvR9ir2YC?=
 =?us-ascii?Q?Ah8R70VQgsXSL08e7H1ajE0t1Cn7g35F8JxODxC3tMlc8yZlnPE1zDeXqw/J?=
 =?us-ascii?Q?AmjfYuBsMgUYpAGmOwlGRTsra2rNb6Z7Mv0RWK0kD6kEje2NxKW25BpS5y0y?=
 =?us-ascii?Q?d+XNNi5wWRXHBsnzez9rlw1etT6Nu8D1iZ9Ps2/LXrOxTfBxt3oINLbv+Ogb?=
 =?us-ascii?Q?mCzfbP1Gs4N+myr4YAA6BE0RktjaUG9mEmM5CuQBGn3ZZZAf7RcC912LaTMo?=
 =?us-ascii?Q?e7Sh8O+WoOT04mWLs7DIcn7F/wXxoOQeQNr7ZjaKlFiK6qd3q6yg9ni6FGbh?=
 =?us-ascii?Q?Zy5jwsCjxLqFrmjBhipd4FoZSVmUPyodIfOV0XNFhyrB7dxWRlEByNbe2bVR?=
 =?us-ascii?Q?6meJTmYkjXg5B7XOrHyUNQqVh1w31n81fyoTB76Z1uI2MD0oYvEyxbtosiV8?=
 =?us-ascii?Q?0xrrz9LsKS8gL6Dsm6jbdFQe06kd1cafpEmJRNtXb86zyZYre6LRT0vtO4bH?=
 =?us-ascii?Q?usLxdElRvtobiZYeQtB8yIjugDZvrWBl11Z7B8vGUCg3nrBAV/YailIefyD4?=
 =?us-ascii?Q?V/33e1RPt3nD14or/+2/DPNGUdCk0Wq5O6cxf1qPdSR82TWwP9F4hPjnC9E?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: aaeacb4a-c051-4e16-ef7b-08db6ca07904
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 06:27:48.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6981
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add medium repeatability support for matching datasheet

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
 drivers/hwmon/sht3x.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 5bc0001b1..eb968b9d3 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -25,6 +25,10 @@
 static const unsigned char sht3x_cmd_measure_blocking_hpm[]    = { 0x2c, 0x06 };
 static const unsigned char sht3x_cmd_measure_nonblocking_hpm[] = { 0x24, 0x00 };
 
+/* commands (medium repeatability mode) */
+static const unsigned char sht3x_cmd_measure_blocking_mpm[]    = { 0x2c, 0x0d };
+static const unsigned char sht3x_cmd_measure_nonblocking_mpm[] = { 0x24, 0x0b };
+
 /* commands (low repeatability mode) */
 static const unsigned char sht3x_cmd_measure_blocking_lpm[]    = { 0x2c, 0x10 };
 static const unsigned char sht3x_cmd_measure_nonblocking_lpm[] = { 0x24, 0x16 };
@@ -43,6 +47,7 @@ static const unsigned char sht3x_cmd_clear_status_reg[]        = { 0x30, 0x41 };
 
 /* delays for non-blocking i2c commands, both in us */
 #define SHT3X_NONBLOCKING_WAIT_TIME_HPM  15000
+#define SHT3X_NONBLOCKING_WAIT_TIME_MPM   6000
 #define SHT3X_NONBLOCKING_WAIT_TIME_LPM   4000
 
 #define SHT3X_WORD_LEN         2
@@ -69,8 +74,9 @@ enum sht3x_limits {
 };
 
 enum sht3x_repeatability {
-	low_repeatability,
-	high_repeatability,
+	low_repeatability    = 0,
+	medium_repeatability = 1,
+	high_repeatability   = 2,
 };
 
 DECLARE_CRC8_TABLE(sht3x_crc8_table);
@@ -89,6 +95,20 @@ static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
 	{0x27, 0x37},
 };
 
+/* periodic measure commands (medium repeatability) */
+static const char periodic_measure_commands_mpm[][SHT3X_CMD_LENGTH] = {
+	/* 0.5 measurements per second */
+	{0x20, 0x24},
+	/* 1 measurements per second */
+	{0x21, 0x26},
+	/* 2 measurements per second */
+	{0x22, 0x20},
+	/* 4 measurements per second */
+	{0x23, 0x22},
+	/* 10 measurements per second */
+	{0x27, 0x21},
+};
+
 /* periodic measure commands (low repeatability mode) */
 static const char periodic_measure_commands_lpm[][SHT3X_CMD_LENGTH] = {
 	/* 0.5 measurements per second */
@@ -448,6 +468,9 @@ static void sht3x_select_command(struct sht3x_data *data)
 		if (data->repeatability == high_repeatability) {
 			data->command = sht3x_cmd_measure_nonblocking_hpm;
 			data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_HPM;
+		} else if (data->repeatability ==  medium_repeatability) {
+			data->command = sht3x_cmd_measure_nonblocking_mpm;
+			data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_MPM;
 		} else {
 			data->command = sht3x_cmd_measure_nonblocking_lpm;
 			data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_LPM;
@@ -595,6 +618,8 @@ static ssize_t update_interval_store(struct device *dev,
 	if (mode > 0) {
 		if (data->repeatability == high_repeatability)
 			command = periodic_measure_commands_hpm[mode - 1];
+		else if (data->repeatability == medium_repeatability)
+			command = periodic_measure_commands_mpm[mode - 1];
 		else
 			command = periodic_measure_commands_lpm[mode - 1];
 
-- 
2.30.2

