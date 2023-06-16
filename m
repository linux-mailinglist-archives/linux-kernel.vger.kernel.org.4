Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7D573354D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbjFPQA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjFPQAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:00:54 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2103.outbound.protection.outlook.com [40.92.58.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D14A30E1;
        Fri, 16 Jun 2023 09:00:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2Ts6HK3zRVRselOactB2t83NYUG9Jyel//UWZUgReY7oShoSLKjLTQwsP0XHj0xQcjR3yP4iH9Jo6/+OhAIFejNDrSaiYxby8Uk42sNnY8aJhjIJNe604yLyIBoUWg4sQ9hWRaydJTdWGVbHtzcSddul/ICTDPFMueFmonjBr9BN7Hioun/9lMqvv75nlK4fLzXC0Wm2+hsTu/VPWDvQFUSZi4ywQJLolX6ybJ+Cebj+y3NeuEMnZ/1Kq07Afy/qynNoynhO4VGPFwBb2jE3gkEhuX/1dKHkYlgSrGC7L3d1hf5i8pK5qMkfD/MaPZDqnB1SHjNS1rtY3dldSJbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BrAIRCuOeDynpskuZWGk3ST1Q83K2Ra3b6M01Mplrk=;
 b=GLQio8/ehngca0s1gWndf+OgvFkhE1ySj88P9R5JQrf/PPo7F/iqTlzlm+U6vCMS50xOr7RYZAsqZF+FzbHGHYJ8SkoH+dotE5EvQCzg5lMul+vmSBLSeDNu9wfN/JTcgJfellswv/Z8ASvv5naC1md3hGo4QGR5tJbDB2XA44DwIEABCFnJshYYfrzvW3+TYyzO1j0NfZXbHtS8HYKdWgl6RgT9a11L7OPcZJo9r2kn+6GGsuFeA2h8ruy9TMRot2/Mfl08v8LQWG7As/NXlB0MxMQcQUrVucdYkq0l13tgI6YUp1iERZVYCwJhJnVrifyB4/5GFPPq75f8SlTydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BrAIRCuOeDynpskuZWGk3ST1Q83K2Ra3b6M01Mplrk=;
 b=GDrYfJvUFAVFyOABL4VC90q1B28VtWlfe5pBFPEzhvv2+G7hTL7gaHWJsmddR8xyw1vlWcU4bFz+y7tM3BgA5P9yQBDCovRhObBajgfNHWoOTlCKgfoEMS9bMNWcziqJ+qOxQJriJdzZimYgouk8DlBI5X4ZLN9nzCM57VzwU20fF51z8f6nDsU2Mps9OE3Veew+KmCBrEbQt/irnogX80AJdRt/W9swCJNuOfzZrkDx/v7M5jJKTYAtI8kQwp/nH3EP/IVExubc0ugtMdm/2UP8IK40hZSuYIZapxCjofrT07kDjmivcFJEdlwZKYHCpfdOYKVRJl7liK0OnzKz6g==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AS1PR10MB7959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 16:00:50 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 16:00:50 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH v2 1/6] hwmon: (sht3x) remove sht3x_platform_data
Date:   Sat, 17 Jun 2023 00:00:12 +0800
Message-ID: <DB4PR10MB626126FB7226D5AF341197449258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [qRkT3yNQMXNXYm4KR2fV2kna12xvbb4T]
X-ClientProxiedBy: TY2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:404:f6::21) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AS1PR10MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ed9e3d-eb7d-4e94-5c3c-08db6e82dac7
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrST/aUJU0/QQB6BlKfxJxwRhS+efwxDM36yKh/25osQbTJTDnwhVK/GkeGFJggNiTfO4ncpxmO3oG37yBJkrobIfPAGc0qieiz3tgannIUByEFfZvfkxgQBOt/94O2pjHqyy+ybrY7EHE7m+B42XMp/2+w4dSoV64eqrrflV56nXxjBPZSt+7flhP7TtnR0pf4bpFnCt2iWhu+Q7s6V2HP3YOive+BwIfj8suROU5iYc1Sax0aheePmB4PgBTpSEy3sjuSGmA9iJS5kHJlih8Tk86+UbrxxvlIRF1Rqm3oKKKBKMxSBTmJhGSy0LW1j36tKC0lQ3FMiiz2gjsF/yTLFBmM2aI6QSwKFpS49HPSvGDUo5CzPxbPamA5tcsS0bc7HMbsD42m90p9l30WMXpQoXE+jYmlhOg5Tsgrj1Ob6pcmgrHb/ZWosr9m4I2/ZXuE8t7uNJiEW1aG6YCGDjiVWzNxuwQz89LCuTA6J8xbrVj6rsIbY8K/r5O/M1RIkJWQK2d5akO1S+BG2HmwJ+5YZVO3XslRrzfhltzAj4VRhsKH7Fxdn0SfdHuoNldy7a9Iv6TQrXqb0vu6NFtF4HBaOSyC5c7xd96lbHYvyP2xoGvobfNqZlosi0DoC0RQGRL7Zzy5QrwMGqtoL5aE3OSO3RQYVG4YDhU+iss8HVgxEESoopoxdlv2zmpsPlKkXgbKGftpgfsIhbrCYpZUje/pfCMeeJ4bKfKD0Q4Thld/RjrSuvLpWKBluOqCarrnSR4=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvBsVJvwCY+62xpQUsCNbCNEu7FjPjk2D2gquoIcqOfhFCYbxQVg3frjYouK1CnK6FJbUq7lAcREwGc0xwODNtn7M1t9SNcDYd9UtysnaR77yvwvc5vwKH5xnOEFZBVWb9oGchIkuggmLhgSD1h5K4EufDxP99lO+RegmXjEgnj9745wkiOtXu7UQfZH0qI7dqS0w4+2u0WZUebXyWeuO5cbzaWl3S9bLqLG9bKJuYIkkEiqrOjuHHtbraLjrto722Esct7Pq4uvVfH7K/GvmPzp5sZ7d6pW2NI4AHNDMx9JA3ILy8fw8zjbQNpUVMlR0E0WAGljxwoKF4ZqFBesqq1Gl+GHvwiTV6y2L0lLIQ/UBm/MHzb7GFGg1mIsxCa8H5jiYxFft6dch1CavrOVLrxB+GWUXKbUp8rtWh5zb92BBsW0QtNp+PxdszTn7tNHaKtSawcUaXBSnhHSOieYnIaVocQ6mKfQgjWvhME6YwiM/tNcI7aW/ADXnNUePprDT6xDV9O4wmyF96RIEZ5VPPBdbhCw6NlrW8Ix88l6RCd2DtwFiNFD1Rx7T4cJE/ZKx8tgd+GIFGF+X2zolcSk6hmXXIrNrKOIqNP+ffCspZdxfnljsTXG3HOPht6AR4fV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iiHqTj/lGoee/N/L/Qm2Ke8gMP88zkiYsS6ADwPH/YuCviUTVnx0Qo3/2ze2?=
 =?us-ascii?Q?q2qRAphLbnu+Buy9KYM/tuidpKU+EHAWPqkVGNqF7m6bLgPQu9KOEtz3IZ8X?=
 =?us-ascii?Q?HjKzJegrK8Z66svfigIM3N3WSk87lMQBBuRR0yfbIU6fOfMJBThiGlqz3IwW?=
 =?us-ascii?Q?0Mf/78cFetbvIPRzl5XpIwqmKM1UY3U109fYfEe6Zhin8e/50AKmwAkhfoOP?=
 =?us-ascii?Q?6ou3/9odvtyZATl6xYSHHPDnoB5SNqj/TJgBBzdIO8MdaUD/noznhlT0G0e8?=
 =?us-ascii?Q?lp0JTC0pIGCF+wRdUXP1DwFUL7B2yHQ6XQXCRfflGHdwxGMq6XdZgZSbtpHE?=
 =?us-ascii?Q?jQMcY3LAX1NG2BGjRZU+v8zLEX1fOO2FUygrZ+HAcjFbfe+zB3RZ1dDRy5Nh?=
 =?us-ascii?Q?aNAGQ8qKcLsD69F+DvDYe12B+ioIArw5L1z/ZY+l0wLHZ0I6zIx4tS9G4cmO?=
 =?us-ascii?Q?jigg24n0k/y8cIwvD9pH6vZldf1lk26aXmf3qsAbMk+S3Xj6YgB4Hne1eKCp?=
 =?us-ascii?Q?hc0QJhLhdF+Y2JbXq3lzg3pFpdw3MpDMAgRrZ7fX0UTsqTqlk81KbcJS2tbH?=
 =?us-ascii?Q?nfqGtMrHInVMn1kv9VPHEwIDWi6Ii8A9oDR74OXvpy7rt7efo1DwnGzISgGz?=
 =?us-ascii?Q?rP90bJ4J3MOAitVaTO06BNEl0lYE2uYBKHI5947EETsiqTZNgwsQE11n5S/1?=
 =?us-ascii?Q?aygsGHzfAn75vHanMuTm4KT38f9XuWXOOxxqkJyLMCbcPnj9/FbNjyTViZZi?=
 =?us-ascii?Q?TYThs558jhR6M7NzY+KlODtAweSPkaRYm6Zb2lfDczXLAC0T+gRZb4iFWSb2?=
 =?us-ascii?Q?FPaYdSpAkLERqVW1lMHAmYNLvxEtyYl2gnYv4pT+WVdtJ9KKYW8EHpuaOAZT?=
 =?us-ascii?Q?Tl8pnqGC5N5VyyQCDm/anjtVt+NLuUqxTylk5HGzD3iPv2mY0+CtBsnoVWIL?=
 =?us-ascii?Q?viLDa/qKMYDqruTdjpv4zentJHqMKupVHWf6z4UJEAjpYYEHQhbAw7G5ILXP?=
 =?us-ascii?Q?janussEHW+WfyWfO2tJDEf7F8dmub/n/2VsyhSsry/EzF4zHO2tzIBkw0mCU?=
 =?us-ascii?Q?jH25DZqLxz+GxIG8nXgGuXDYjYTGgfYCxkAnaQGTG8fL9y93YUe3tqYPh909?=
 =?us-ascii?Q?8svshMqxX0zbCbVcgASLKmDfM42ypeEWAZn1/oMol/kSlQqu0a+yDtk1k4wO?=
 =?us-ascii?Q?xYe/94gai4SevsnJYojb25atI51/ePBQTiY5fNOrYGSYJEZSMC9JAb0ia9g?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ed9e3d-eb7d-4e94-5c3c-08db6e82dac7
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 16:00:50.2758
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

Since no in-tree driver supports it, sht3x_platform_data has been
removed and the relevant properties have been moved to sht3x_data.

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
 Documentation/hwmon/sht3x.rst       |  2 +-
 drivers/hwmon/sht3x.c               | 20 ++++++++------------
 include/linux/platform_data/sht3x.h | 15 ---------------
 3 files changed, 9 insertions(+), 28 deletions(-)
 delete mode 100644 include/linux/platform_data/sht3x.h

diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
index 95a850d5b..31fd36b14 100644
--- a/Documentation/hwmon/sht3x.rst
+++ b/Documentation/hwmon/sht3x.rst
@@ -28,7 +28,7 @@ The device communicates with the I2C protocol. Sensors can have the I2C
 addresses 0x44 or 0x45, depending on the wiring. See
 Documentation/i2c/instantiating-devices.rst for methods to instantiate the device.
 
-There are two options configurable by means of sht3x_platform_data:
+There are two options configurable by means of sht3x_data:
 
 1. blocking (pull the I2C clock line down while performing the measurement) or
    non-blocking mode. Blocking mode will guarantee the fastest result but
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 8305e44d9..580704d93 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -20,7 +20,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
-#include <linux/platform_data/sht3x.h>
 
 /* commands (high precision mode) */
 static const unsigned char sht3x_cmd_measure_blocking_hpm[]    = { 0x2c, 0x06 };
@@ -135,8 +134,8 @@ struct sht3x_data {
 	const unsigned char *command;
 	u32 wait_time;			/* in us*/
 	unsigned long last_update;	/* last update in periodic mode*/
-
-	struct sht3x_platform_data setup;
+	bool blocking_io;
+	bool high_precision;
 
 	/*
 	 * cached values for temperature and humidity and limits
@@ -441,13 +440,13 @@ static void sht3x_select_command(struct sht3x_data *data)
 	if (data->mode > 0) {
 		data->command = sht3x_cmd_measure_periodic_mode;
 		data->wait_time = 0;
-	} else if (data->setup.blocking_io) {
-		data->command = data->setup.high_precision ?
+	} else if (data->blocking_io) {
+		data->command = data->high_precision ?
 				sht3x_cmd_measure_blocking_hpm :
 				sht3x_cmd_measure_blocking_lpm;
 		data->wait_time = 0;
 	} else {
-		if (data->setup.high_precision) {
+		if (data->high_precision) {
 			data->command = sht3x_cmd_measure_nonblocking_hpm;
 			data->wait_time = SHT3X_NONBLOCKING_WAIT_TIME_HPM;
 		} else {
@@ -595,7 +594,7 @@ static ssize_t update_interval_store(struct device *dev,
 	}
 
 	if (mode > 0) {
-		if (data->setup.high_precision)
+		if (data->high_precision)
 			command = periodic_measure_commands_hpm[mode - 1];
 		else
 			command = periodic_measure_commands_lpm[mode - 1];
@@ -690,16 +689,13 @@ static int sht3x_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	data->setup.blocking_io = false;
-	data->setup.high_precision = true;
+	data->blocking_io = false;
+	data->high_precision = true;
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

