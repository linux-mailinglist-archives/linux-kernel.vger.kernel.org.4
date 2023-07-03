Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3B6745E2A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjGCOJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjGCOIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:08:55 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2022.outbound.protection.outlook.com [40.92.50.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C93E51;
        Mon,  3 Jul 2023 07:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nw9zEjyoZgY40sNNpMcOuKi3chnUdBr72aCIZ0w6z68kASMFoNleMcFwiYuY8GBSwYJ5PlZT5UHhf20RK4TO74J5/yDp9HyhS2o5bnGKhfdoLfl7S859+2VAcQ7UkMmUuIE85l7DC8Pjs4H8mVuZBeU+x7nz2GMSR2Dlo5DUdrXAGDkwDoPyVmlnwv0qQbA1y1KG4EnTQHrd19U57i1wTD60PMSpjueysk4AYctJKam2tZkbnQupqTvIbaIU9WhhBm3yZPj/qk8GCdazwP1OJKAiUGqvk2KLSl2JkXqeNqGW2O3m4xpt35qgti9DEKMJW9Kes4gkusNsrdX1J0MCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MH4UASRDqFQ9DY4me5+MmlBWpQR4CnGo1y5RsW1RbPM=;
 b=hB/oXOuT5Gwhe04daBTOKot4NPMk8XHJm9DbhwXF34cj4FSJJu4kp8qwBNJKNc72lz8iWcVsA6V+qGe5LNtXuzhe/+ZFPRQE8hEe+qULKZQ0bhz8acc0DhVE1hl+3wHkQ87r1tPuoV75h8NRHd2Md9ypxbSqFdsb+GsBDki7SEKrKn4htMxbX453bNhDp0447kgK9xcC4hJzunZDH6QlnlCYsojxpExJAXX4BvB1xGpo9a/PTea5+W4GkL9LzertyZJfcU/8D1er62gEY5xG244Fps2zqPvZ0Az38J+BWuPsvYyWl0AnND6mIHbDkIFn3RuYnJh2OTfjO9XKUs/xcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH4UASRDqFQ9DY4me5+MmlBWpQR4CnGo1y5RsW1RbPM=;
 b=mZrnG7u6Jz7FBaTm9hVfvo1c7jGxar3l6Ly9Hp3S7JJKGJ5ezjFTK7cJtIpsPn0hyBXzYug4AFmG98N5O2JGd0C1ejKxlGTUZy9XoQsHYeOQdirx5N9jES7v5x/v6SmrmZO6M7qZcbC88MrP8n1jQfqURH9R87MsvPNHTFGTENqbWQ1kYAINpfx/+4hdxKG8WvcQXibJBA4GeZvPbc5LgMgqJ4KwZlpPJkGGEr59AnBLbPSPKSZL9Aw3cat/rA5cQnzCy/5rz8V3D1D/TDXFeaEZioIkO/Va8lvnX55n45jFSzD77TExgJbpkheKEwB39zIk7jm76lH/dyFsqX8DwQ==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AM7PR10MB3891.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 14:08:48 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 14:08:48 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH v3 1/3] hwmon: (sht3x) convert some of sysfs interface to hwmon
Date:   Mon,  3 Jul 2023 22:08:16 +0800
Message-ID: <DB4PR10MB626157BC697F2CD6100431359229A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Eom2vxoQ2KQuIEMUiHlIZXI4g4Omz3SMU2pFpx/rb0cjb/AJGlGt0HcnfTZG/hYA]
X-ClientProxiedBy: TYCP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::10) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230703140818.427403-1-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AM7PR10MB3891:EE_
X-MS-Office365-Filtering-Correlation-Id: 85099b45-f119-44f1-b59c-08db7bcf0507
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmqqpqVHbY8r+bVyFie8RCx7QcXdaLZxSqgR1+KYztYDyaucLvnC5WTizlrLluRO5TOCKeUJWX+nLIe2byXWAVQKxBMZA3Dl11na6rowsbNxVhGuaF6pfLEDm+DIAxamlMXETTcj7QuDnWk1MyHl71+uxk5pXkCMniAya/3JxYYDxXYVsyfszwg8A690tBUKW9qlT2W6J6meHOFZ7T3gPYObxuSMJAo9ZinfDI/lDcqnQfEf1ZMFFxOg4nOPWGiRhUo2A30ZOk7IIYovLJ5PAhvHLH5SdqmI3f/e+ppnQLEAoNSxiH89aAf1BvZAPxfOM4861w+cDl4ncx5uuPjxVsgQWCKT/pjumRZief/vff1XSWXDlGgjiP36FGYMci+zbpNDhmnajA4RVNh6R2LMweE5XeowD1NRhvPBo9jDurWBAlFAYr/0FRnZUIaR+vLyjbPJ/0KkoWXDwQGi+AQ3Lugp4uNAsRBLmZRgic8pWxgkhOPNfrZbraQIqC3xKb0U20xF89iEbBsdwvASuEBwqMTt56FjxlFvXNJ2pBOtJd9DiLq3PEozlkqEhYXXFse5wE6w8dojHUDoPK/tHdVFqIaRvYTnJAWPXmUVc8tu0jEC6/ayUeKQkS5yD7mKHTepVi55Y9ZOxwbauLma3s049XACqdJlcGOKtcmANMSohfnXUbs6knF3ev9EpUmP5HLGHGxQ0ix0QnsrzuMKQsLohvn6wF3tbhw3HDvJyN05p54XqhvXPrNIk5kl87miC+ql3SU=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uh16J2+O2JaCLAjDZPm1vj4GPlxNrQ/X8FnjQiXrliYQXLPDSODvs9uqzEYWii02DQtJuKY230E9JZACICdNLNEhVrtfPnjMB2AFd2hnHR8Y8PFyd8nzb3ornZQMm/a4SSnsxbMGz7QBESsuhmyWwgWkluHxXsPpCJVRUwDb0vOAPzQSohAQfpJLxQhiJPGxY3GsUuSZMOdh5MsIAdkvX4umBUQEunXgQZdS+xO71azgvUgsAZeB/n8ntNhLqLF7vvNsbvzElKB1Gy8JSIb89TTIZ23l6Wce/Y4c73BGyFFUw5BZNtT7eCxJo7XO6MudmVFmCTvG4MkKB/uUcz/7YlAEmxl3lYAlto1IIRGvxyaJdb2C8RUrCeLXHl91iiJrZBPXz8XL+8sJp1nob54ZBsadibY1T4CmWl85N7jr0cqRsHekVFKR/icCu5kJjwOwEJm2BTeDHkL9FB85/hBwfwAx3vcAVE8cBrxG4+exnMPHYZb3s3W1gWkgMipxqPPXZsstVUBOBQHjXUO8tKB8uir+TKfOgeqk5JnmCHuxMQ3Q2Yczq/TGWiymxcwBLRLQav5Bya/jjNG4PvzW82nE9UAfblpNmnMlyHqvFFbu+NCERJrUTlrOQa2AfHHdq4s1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q4/IinVRxO1oKd2sHBgZjIB5OuoOTV/OxO2m8YcO1Q8uvQBqWa/jL6w3um78?=
 =?us-ascii?Q?n0fcocfmuFJnZ/cGGcsvUNwlkAOyoz7pzPdvBzA2lY1/w/5csGZU4wzm135P?=
 =?us-ascii?Q?+qVteZA2m9aY5OO9gWwg7wwKsLio3DPFPq5mzHrqW6qkpUpiUyEUjNsfKdQB?=
 =?us-ascii?Q?TWH/eRZEn5Bj6C/2XtpleQyzbJfmNaBecqNWsPvGGBmHtU33MYJKlku3uLcj?=
 =?us-ascii?Q?ilJ75ePCKxSOKkTBJnoOZpEnDRlIS4rEIoxc+ZHSDwO3mOHwC7B7iWNgIWGv?=
 =?us-ascii?Q?Vgwh1cUpa+8JPFE6cwAue51dwVSJ/jhx3xSTBmdr2wkfJJmjfrz9TDbPgzLw?=
 =?us-ascii?Q?SQ+D9i00sXETuvPXcJH/19ImpRg2luO/Y1A1fSEwbMB9ymfYUUkB9//gpyuL?=
 =?us-ascii?Q?/abyww7VenuouZM2jLF6qeOmv4yNwKch4ENNAq2OSffj/VGc5n5eVq8YtWMR?=
 =?us-ascii?Q?OhCEJT2fXbS7xi3KpNMIFq0w9QUSpH+J1Fuj+itS7TOYoFv9E3OxeHUZk+uX?=
 =?us-ascii?Q?pgOi7sjY8qXim8Ry/jQ69C3rO27qTzxzdanonxLSh+YvflL93E/MytFj1NtE?=
 =?us-ascii?Q?tRmn6BIevw39RVp3wWuy887AsCmhL40Ix/OJdwQkea0wCRDnQlgMu46TgUFT?=
 =?us-ascii?Q?hA5UyVuarywdg3e26pGqUVgW8DYZUeDzHbgnBkUSHhlFLMgQeNzb2RCpSudM?=
 =?us-ascii?Q?pDYVGqD717cSPseEY3VMq1z/l9zoln5k+Kh3iAbAGFz8FDcCLVlQO7Rq3mRI?=
 =?us-ascii?Q?UK6sfuhG7mHIAZ+/OG1p9rr5ovG6K8tuK/svMkmn1/YttGg4dVLlaPx3CX/9?=
 =?us-ascii?Q?c4xuHGPUHGb9nS3lusqJlBhF5k3VYlSloKRQL1N4NT9+l97+8GlDK01l1moA?=
 =?us-ascii?Q?/0Zf3ifErsprQ+gheKXhmBEStVaaxfBBkXO6xhyIOqOSxRk/qFiQe/k4yhZQ?=
 =?us-ascii?Q?RzMThJrBL0TyVOpA5jGcOre5ZK5+iCcrXAnnuOO0fqBz4Kpxv+0DfdfRNen6?=
 =?us-ascii?Q?3Hlb9y6wgQh27wWi7Hyw3c7shPlYYwEJK5eLOnmlfqWDQTripXN1eAiVcFBy?=
 =?us-ascii?Q?kdgQc7BhmYRdU/Os7C6B2gYWyRnmiMvYAFiFe2FGEiWcv72NH9HeyreChBER?=
 =?us-ascii?Q?LMN3HZGk3bx/5a2qKyIV2VuA0A4DA0rI8Xsb+2XFyC+iga4u96sPxsPM5Sm7?=
 =?us-ascii?Q?EqLrxfLz0Ik1jLdrGYV7mx6gGxzID10aifPMRAwnWBoz9sMH6XCVftMdAG0n?=
 =?us-ascii?Q?qAwxr7X9uEIpa8ukzZAkcc4VZzsMJJGkvwyLTZNJ3l+2418J5b1kuF3o9Kl8?=
 =?us-ascii?Q?1M4=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 85099b45-f119-44f1-b59c-08db7bcf0507
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 14:08:48.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_interval, temperature/humidity max/min and hyst
were moved to new hwmon interface, and only heater and
repeatability were reserved as non-stardard sysfs interface.

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
v2:
  - remove forward declearation
  - fix switch statement about "return 0" and "break" for consistency
  - convert type of "val" from string to numeric value
  - store chip type in struct sht3x_data
v3:
  - restore original documention of sht3x
  - fix xxx_write prototype

 drivers/hwmon/sht3x.c | 387 +++++++++++++++++++++++++++---------------
 1 file changed, 251 insertions(+), 136 deletions(-)

diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index bf18630619e0..79657910b79e 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -147,8 +147,20 @@ static const u16 mode_to_update_interval[] = {
 	 100,
 };
 
+static const struct hwmon_channel_info * const sht3x_channel_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MIN |
+				HWMON_T_MIN_HYST | HWMON_T_MAX |
+				HWMON_T_MAX_HYST | HWMON_T_ALARM),
+	HWMON_CHANNEL_INFO(humidity, HWMON_H_INPUT | HWMON_H_MIN |
+				HWMON_H_MIN_HYST | HWMON_H_MAX |
+				HWMON_H_MAX_HYST | HWMON_H_ALARM),
+	NULL,
+};
+
 struct sht3x_data {
 	struct i2c_client *client;
+	enum sht3x_chips chip_id;
 	struct mutex i2c_lock; /* lock for sending i2c commands */
 	struct mutex data_lock; /* lock for updating driver data */
 
@@ -276,27 +288,24 @@ static struct sht3x_data *sht3x_update_client(struct device *dev)
 	return data;
 }
 
-/* sysfs attributes */
-static ssize_t temp1_input_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static int temp1_input_read(struct device *dev)
 {
 	struct sht3x_data *data = sht3x_update_client(dev);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return sprintf(buf, "%d\n", data->temperature);
+	return data->temperature;
 }
 
-static ssize_t humidity1_input_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static int humidity1_input_read(struct device *dev)
 {
 	struct sht3x_data *data = sht3x_update_client(dev);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return sprintf(buf, "%u\n", data->humidity);
+	return data->humidity;
 }
 
 /*
@@ -332,33 +341,24 @@ static int limits_update(struct sht3x_data *data)
 	return ret;
 }
 
-static ssize_t temp1_limit_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
+static int temp1_limit_read(struct device *dev, int index)
 {
 	struct sht3x_data *data = dev_get_drvdata(dev);
-	u8 index = to_sensor_dev_attr(attr)->index;
-	int temperature_limit = data->temperature_limits[index];
 
-	return sysfs_emit(buf, "%d\n", temperature_limit);
+	return data->temperature_limits[index];
 }
 
-static ssize_t humidity1_limit_show(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static int humidity1_limit_read(struct device *dev, int index)
 {
 	struct sht3x_data *data = dev_get_drvdata(dev);
-	u8 index = to_sensor_dev_attr(attr)->index;
-	u32 humidity_limit = data->humidity_limits[index];
 
-	return sysfs_emit(buf, "%u\n", humidity_limit);
+	return data->humidity_limits[index];
 }
 
 /*
- * limit_store must only be called with data_lock held
+ * limit_write must only be called with data_lock held
  */
-static size_t limit_store(struct device *dev,
-			  size_t count,
+static size_t limit_write(struct device *dev,
 			  u8 index,
 			  int temperature,
 			  u32 humidity)
@@ -379,7 +379,7 @@ static size_t limit_store(struct device *dev,
 	 * ST = (T + 45) / 175 * 2^16
 	 * SRH = RH / 100 * 2^16
 	 * adapted for fixed point arithmetic and packed the same as
-	 * in limit_show()
+	 * in limit_read()
 	 */
 	raw = ((u32)(temperature + 45000) * 24543) >> (16 + 7);
 	raw |= ((humidity * 42950) >> 16) & 0xfe00;
@@ -400,50 +400,35 @@ static size_t limit_store(struct device *dev,
 
 	data->temperature_limits[index] = temperature;
 	data->humidity_limits[index] = humidity;
-	return count;
+
+	return 0;
 }
 
-static ssize_t temp1_limit_store(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf,
-				 size_t count)
+static int temp1_limit_write(struct device *dev, int index, int val)
 {
 	int temperature;
 	int ret;
 	struct sht3x_data *data = dev_get_drvdata(dev);
-	u8 index = to_sensor_dev_attr(attr)->index;
 
-	ret = kstrtoint(buf, 0, &temperature);
-	if (ret)
-		return ret;
-
-	temperature = clamp_val(temperature, SHT3X_MIN_TEMPERATURE,
+	temperature = clamp_val(val, SHT3X_MIN_TEMPERATURE,
 				SHT3X_MAX_TEMPERATURE);
 	mutex_lock(&data->data_lock);
-	ret = limit_store(dev, count, index, temperature,
+	ret = limit_write(dev, index, temperature,
 			  data->humidity_limits[index]);
 	mutex_unlock(&data->data_lock);
 
 	return ret;
 }
 
-static ssize_t humidity1_limit_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t count)
+static int humidity1_limit_write(struct device *dev, int index, int val)
 {
 	u32 humidity;
 	int ret;
 	struct sht3x_data *data = dev_get_drvdata(dev);
-	u8 index = to_sensor_dev_attr(attr)->index;
-
-	ret = kstrtou32(buf, 0, &humidity);
-	if (ret)
-		return ret;
 
-	humidity = clamp_val(humidity, SHT3X_MIN_HUMIDITY, SHT3X_MAX_HUMIDITY);
+	humidity = clamp_val(val, SHT3X_MIN_HUMIDITY, SHT3X_MAX_HUMIDITY);
 	mutex_lock(&data->data_lock);
-	ret = limit_store(dev, count, index, data->temperature_limits[index],
+	ret = limit_write(dev, index, data->temperature_limits[index],
 			  humidity);
 	mutex_unlock(&data->data_lock);
 
@@ -474,7 +459,6 @@ static void sht3x_select_command(struct sht3x_data *data)
 }
 
 static int status_register_read(struct device *dev,
-				struct device_attribute *attr,
 				char *buffer, int length)
 {
 	int ret;
@@ -487,34 +471,30 @@ static int status_register_read(struct device *dev,
 	return ret;
 }
 
-static ssize_t temp1_alarm_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
+static int temp1_alarm_read(struct device *dev)
 {
 	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
 	int ret;
 
-	ret = status_register_read(dev, attr, buffer,
+	ret = status_register_read(dev, buffer,
 				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
 	if (ret)
 		return ret;
 
-	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x04));
+	return !!(buffer[0] & 0x04);
 }
 
-static ssize_t humidity1_alarm_show(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static int humidity1_alarm_read(struct device *dev)
 {
 	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
 	int ret;
 
-	ret = status_register_read(dev, attr, buffer,
+	ret = status_register_read(dev, buffer,
 				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
 	if (ret)
 		return ret;
 
-	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x08));
+	return !!(buffer[0] & 0x08);
 }
 
 static ssize_t heater_enable_show(struct device *dev,
@@ -524,7 +504,7 @@ static ssize_t heater_enable_show(struct device *dev,
 	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
 	int ret;
 
-	ret = status_register_read(dev, attr, buffer,
+	ret = status_register_read(dev, buffer,
 				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
 	if (ret)
 		return ret;
@@ -560,39 +540,28 @@ static ssize_t heater_enable_store(struct device *dev,
 	return ret;
 }
 
-static ssize_t update_interval_show(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static int update_interval_read(struct device *dev)
 {
 	struct sht3x_data *data = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%u\n",
-			 mode_to_update_interval[data->mode]);
+	return mode_to_update_interval[data->mode];
 }
 
-static ssize_t update_interval_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t count)
+static int update_interval_write(struct device *dev, int val)
 {
-	u16 update_interval;
 	u8 mode;
 	int ret;
 	const char *command;
 	struct sht3x_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 
-	ret = kstrtou16(buf, 0, &update_interval);
-	if (ret)
-		return ret;
-
-	mode = get_mode_from_update_interval(update_interval);
+	mode = get_mode_from_update_interval(val);
 
 	mutex_lock(&data->data_lock);
 	/* mode did not change */
 	if (mode == data->mode) {
 		mutex_unlock(&data->data_lock);
-		return count;
+		return 0;
 	}
 
 	mutex_lock(&data->i2c_lock);
@@ -634,7 +603,7 @@ static ssize_t update_interval_store(struct device *dev,
 	if (ret != SHT3X_CMD_LENGTH)
 		return ret < 0 ? ret : -EIO;
 
-	return count;
+	return 0;
 }
 
 static ssize_t repeatability_show(struct device *dev,
@@ -668,60 +637,219 @@ static ssize_t repeatability_store(struct device *dev,
 	return count;
 }
 
-static SENSOR_DEVICE_ATTR_RO(temp1_input, temp1_input, 0);
-static SENSOR_DEVICE_ATTR_RO(humidity1_input, humidity1_input, 0);
-static SENSOR_DEVICE_ATTR_RW(temp1_max, temp1_limit, limit_max);
-static SENSOR_DEVICE_ATTR_RW(humidity1_max, humidity1_limit, limit_max);
-static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, temp1_limit, limit_max_hyst);
-static SENSOR_DEVICE_ATTR_RW(humidity1_max_hyst, humidity1_limit,
-			     limit_max_hyst);
-static SENSOR_DEVICE_ATTR_RW(temp1_min, temp1_limit, limit_min);
-static SENSOR_DEVICE_ATTR_RW(humidity1_min, humidity1_limit, limit_min);
-static SENSOR_DEVICE_ATTR_RW(temp1_min_hyst, temp1_limit, limit_min_hyst);
-static SENSOR_DEVICE_ATTR_RW(humidity1_min_hyst, humidity1_limit,
-			     limit_min_hyst);
-static SENSOR_DEVICE_ATTR_RO(temp1_alarm, temp1_alarm, 0);
-static SENSOR_DEVICE_ATTR_RO(humidity1_alarm, humidity1_alarm, 0);
 static SENSOR_DEVICE_ATTR_RW(heater_enable, heater_enable, 0);
-static SENSOR_DEVICE_ATTR_RW(update_interval, update_interval, 0);
 static SENSOR_DEVICE_ATTR_RW(repeatability, repeatability, 0);
 
 static struct attribute *sht3x_attrs[] = {
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_humidity1_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_max.dev_attr.attr,
-	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_humidity1_max.dev_attr.attr,
-	&sensor_dev_attr_humidity1_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_min.dev_attr.attr,
-	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
-	&sensor_dev_attr_humidity1_min.dev_attr.attr,
-	&sensor_dev_attr_humidity1_min_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
-	&sensor_dev_attr_humidity1_alarm.dev_attr.attr,
 	&sensor_dev_attr_heater_enable.dev_attr.attr,
-	&sensor_dev_attr_update_interval.dev_attr.attr,
 	&sensor_dev_attr_repeatability.dev_attr.attr,
 	NULL
 };
 
-static struct attribute *sts3x_attrs[] = {
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_max.dev_attr.attr,
-	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_min.dev_attr.attr,
-	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
-	&sensor_dev_attr_heater_enable.dev_attr.attr,
-	&sensor_dev_attr_update_interval.dev_attr.attr,
-	&sensor_dev_attr_repeatability.dev_attr.attr,
-	NULL
+ATTRIBUTE_GROUPS(sht3x);
+
+static umode_t sht3x_is_visible(const void *data, enum hwmon_sensor_types type,
+				u32 attr, int channel)
+{
+	const struct sht3x_data *chip_data = data;
+
+	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_update_interval:
+			return 0644;
+		default:
+			break;
+		}
+		break;
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+		case hwmon_temp_alarm:
+			return 0444;
+		case hwmon_temp_max:
+		case hwmon_temp_max_hyst:
+		case hwmon_temp_min:
+		case hwmon_temp_min_hyst:
+			return 0644;
+		default:
+			break;
+		}
+		break;
+	case hwmon_humidity:
+		if (chip_data->chip_id == sts3x)
+			break;
+		switch (attr) {
+		case hwmon_humidity_input:
+		case hwmon_humidity_alarm:
+			return 0444;
+		case hwmon_humidity_max:
+		case hwmon_humidity_max_hyst:
+		case hwmon_humidity_min:
+		case hwmon_humidity_min_hyst:
+			return 0644;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
+		      u32 attr, int channel, long *val)
+{
+	enum sht3x_limits index;
+
+	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_update_interval:
+			*val = update_interval_read(dev);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			*val = temp1_input_read(dev);
+			break;
+		case hwmon_temp_alarm:
+			*val = temp1_alarm_read(dev);
+			break;
+		case hwmon_temp_max:
+			index = limit_max;
+			*val = temp1_limit_read(dev, index);
+			break;
+		case hwmon_temp_max_hyst:
+			index = limit_max_hyst;
+			*val = temp1_limit_read(dev, index);
+			break;
+		case hwmon_temp_min:
+			index = limit_min;
+			*val = temp1_limit_read(dev, index);
+			break;
+		case hwmon_temp_min_hyst:
+			index = limit_min_hyst;
+			*val = temp1_limit_read(dev, index);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case hwmon_humidity:
+		switch (attr) {
+		case hwmon_humidity_input:
+			*val = humidity1_input_read(dev);
+			break;
+		case hwmon_humidity_alarm:
+			*val = humidity1_alarm_read(dev);
+			break;
+		case hwmon_humidity_max:
+			index = limit_max;
+			*val = humidity1_limit_read(dev, index);
+			break;
+		case hwmon_humidity_max_hyst:
+			index = limit_max_hyst;
+			*val = humidity1_limit_read(dev, index);
+			break;
+		case hwmon_humidity_min:
+			index = limit_min;
+			*val = humidity1_limit_read(dev, index);
+			break;
+		case hwmon_humidity_min_hyst:
+			index = limit_min_hyst;
+			*val = humidity1_limit_read(dev, index);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int sht3x_write(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, long val)
+{
+	enum sht3x_limits index;
+
+	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_update_interval:
+			return update_interval_write(dev, val);
+		default:
+			return -EOPNOTSUPP;
+		}
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_max:
+			index = limit_max;
+			break;
+		case hwmon_temp_max_hyst:
+			index = limit_max_hyst;
+			break;
+		case hwmon_temp_min:
+			index = limit_min;
+			break;
+		case hwmon_temp_min_hyst:
+			index = limit_min_hyst;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		return temp1_limit_write(dev, index, val);
+	case hwmon_humidity:
+		switch (attr) {
+		case hwmon_humidity_max:
+			index = limit_max;
+			break;
+		case hwmon_humidity_max_hyst:
+			index = limit_max_hyst;
+			break;
+		case hwmon_humidity_min:
+			index = limit_min;
+			break;
+		case hwmon_humidity_min_hyst:
+			index = limit_min_hyst;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		return humidity1_limit_write(dev, index, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_ops sht3x_ops = {
+	.is_visible = sht3x_is_visible,
+	.read = sht3x_read,
+	.write = sht3x_write,
 };
 
-ATTRIBUTE_GROUPS(sht3x);
-ATTRIBUTE_GROUPS(sts3x);
+static const struct hwmon_chip_info sht3x_chip_info = {
+	.ops = &sht3x_ops,
+	.info = sht3x_channel_info,
+};
+
+/* device ID table */
+static const struct i2c_device_id sht3x_ids[] = {
+	{"sht3x", sht3x},
+	{"sts3x", sts3x},
+	{}
+};
 
-static const struct i2c_device_id sht3x_ids[];
+MODULE_DEVICE_TABLE(i2c, sht3x_ids);
 
 static int sht3x_probe(struct i2c_client *client)
 {
@@ -730,7 +858,6 @@ static int sht3x_probe(struct i2c_client *client)
 	struct device *hwmon_dev;
 	struct i2c_adapter *adap = client->adapter;
 	struct device *dev = &client->dev;
-	const struct attribute_group **attribute_groups;
 
 	/*
 	 * we require full i2c support since the sht3x uses multi-byte read and
@@ -753,6 +880,7 @@ static int sht3x_probe(struct i2c_client *client)
 	data->mode = 0;
 	data->last_update = jiffies - msecs_to_jiffies(3000);
 	data->client = client;
+	data->chip_id = i2c_match_id(sht3x_ids, client)->driver_data;
 	crc8_populate_msb(sht3x_crc8_table, SHT3X_CRC8_POLYNOMIAL);
 
 	sht3x_select_command(data);
@@ -771,15 +899,11 @@ static int sht3x_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	if (i2c_match_id(sht3x_ids, client)->driver_data == sts3x)
-		attribute_groups = sts3x_groups;
-	else
-		attribute_groups = sht3x_groups;
-
-	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
-							   client->name,
-							   data,
-							   attribute_groups);
+	hwmon_dev = devm_hwmon_device_register_with_info(dev,
+							 client->name,
+							 data,
+							 &sht3x_chip_info,
+							 sht3x_groups);
 
 	if (IS_ERR(hwmon_dev))
 		dev_dbg(dev, "unable to register hwmon device\n");
@@ -787,15 +911,6 @@ static int sht3x_probe(struct i2c_client *client)
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
-/* device ID table */
-static const struct i2c_device_id sht3x_ids[] = {
-	{"sht3x", sht3x},
-	{"sts3x", sts3x},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, sht3x_ids);
-
 static struct i2c_driver sht3x_i2c_driver = {
 	.driver.name = "sht3x",
 	.probe       = sht3x_probe,
-- 
2.39.2

