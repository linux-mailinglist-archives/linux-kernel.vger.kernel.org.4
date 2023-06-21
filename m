Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF09737A00
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjFUEAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFUEAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:00:12 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2059.outbound.protection.outlook.com [40.92.65.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA265F1;
        Tue, 20 Jun 2023 21:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0dPgE31vzcOIOKgrl0aUnOIwWeXUmNZChwnA6afvuEWL3EPRFUz/SdUjAIjDWdCJV6bs0SdYIMtGGyKf2nCInfZPbCgf/VhSK6YFIdBs9e3Bxr1znG6iYUw+Tvfupnkrz5VOfZiGEPafhaTYGO9NjGOAd+mzpIHtYHm3UuIp+DszRzaMjzNrzd3Rd/HG2ueHr69/Nl7W2qjcLNLdkOmS+JtVx1VunZGSpIyMRfL522Y+9kuL7UdTpNp6KOOd4qFduc8A1PEdPaKH5nCKMeSBP2ac/54EN1VMgiS8+wD3G7vdxoyRhJ9pYH91j/u6zsIi0cdpcKNlMu5RP7vnlLBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUr5yetam0NNd0nQX1RP4szLeW+WqUcCdYaU09teZBU=;
 b=L05h/2nGpKsknMru6GQZM9YOtzT78rP926t8FSc+YsBCRh3MZxKb3zkAfeFuC7QwCxZtJbWEa53sv5gQ+yyoKYGcJQiIpsCIauDCaGrf90XRONRIYBrLcj23Szf+QLkRHc7oXfcxfJ81dAaYjjnInvBD7GpDY+XF5byVkE3jzS9v6MLCFWGSIaUlMtpIjbzcVAjz/4Hqcyl/H32hUzTszFlCH7EE0BuREofkAtviHt+hmU87b7gqJ8EtWG/6Uj7B8OzHlGVLoAb1CqgjGclQtOvckXe6WH9aqC0/8odOom+fsYQDpvBTJnstplY8z0/3lK1+KT+2FNq2+DbyctiSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUr5yetam0NNd0nQX1RP4szLeW+WqUcCdYaU09teZBU=;
 b=uFN8EB851k7HW+m5mIjMQMafnPL/ec0sRtdM67ziEiR6kONvE24ThkgCdX+itr20B7jVrfyqI0k2nzqh22UoNvpSxKvsx0xh/f786dbfr8sKpZnc+/E2ywK2VyDlgDa33PvPA5812Scn9/TEhgqe1T4cuXJo6+05LGHtc2YS5I1SziR6f73XUQ0LdAST0S6GrTpaaPyp7VVwt4p9xFltG74oUU3C7O7Ke/13jPwjNMbf6dbtYLi15YDuwXibSqL2pvEaC0o0TCorHm9wwFkN4KfNQI6loWmgTm+96PyNW/ptGVIPvQ/aokfc7X40NIxT/e3Kq1TUc+1jmWJrtWs6Sg==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AS1PR10MB5652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 04:00:07 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 04:00:06 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [RFC PATCH 1/2] hwmon: (sht3x) convert some of sysfs interface to hwmon
Date:   Wed, 21 Jun 2023 11:59:36 +0800
Message-ID: <DB4PR10MB6261A846EADE1C40A340E2C7925DA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [mZuJxxqP3sxDGIS6Ho+ZmT6O9UPHPsAG]
X-ClientProxiedBy: TY2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:404:e2::32) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230621035937.58721-1-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AS1PR10MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c618cf6-d5da-415e-0de9-08db720bffac
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmpXYlgiiriwpiw8n8pZtYyvl/ykg3hI8hGFLPH/3LuVt4eDpr/xOkX4mdC2V2aOjLMuYC+SQzkBFYkmwKisUAMoNGErHWgLPGc3Op3A+u90QFcwnLzPorFw/XP+FGE76Ltts/D5KSvUNJcb7drg3M11TKUxQimFU092xJR9AvcnmcSld2jRrj96qNFMvo4fjoK0TQKmhhQ9fbbvHakGVL/bzKXMsTcLX4ulewgOSqv956VKEQ/PDLz4tb/xtnjqaWHgvcV4BmPvzY+GKDHy5LJNurxzCFfnoK7hYRVW5BZnjM/3TrWDIiHCgcDnrveENXf67QI1HADe6tL2D1TUiCzf0+KUDj9FUDE65qS0f2w+RARxn0VtvcMWIBlC5hEOPd2s6BEg1ORCQnst4iLGjl5Cn1iXhvyz++vKB/KLYMYL8kqiR4wkiaw3awLFRoY/QzNHwcKPdYjNP3OyoAqqoGqcyTcsWy0v1nqCjuPZINEpdmecT3agaNrmRxFhXFBDzLSIM25JYpx9GgE2VOjQFGdA/9EJUOH49oaFus36EbUQ8b2ozJPnJF8igcD5dW9CjVN4+wEGtH8Q+twZ5BhKBFI/WCljuGvBQ7q887URHSKMVzzJa96oW7KevzsPpdXSLYpFQq9niJ4eTz9slgbjDehKyjGHhhITcw3ERaBBSMtTJWGencqHDBIFYfhZPHxDwGrOB7oV+kwoLeAfBavgT8nYVEqegOYgmpxTvm8IUcYnECN05HCmVmxdAnDekKsGRbY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nslPYHtLJWrtcCjuFiwLXqpJ/Cwri7N4wwwh6UUbptdUuvSr+BZ8orWEZc4iKBkkI245JYa15GeO9ZOn+jT/OTPWdv0mGU5+s8X+PBVhRNXzBvWMf/5j6tfZe62sXAx7RlG5oTBrN3K6GD1I+irLybKC226MG01Gcsk2qS97R0g++gAP0euvsh/YOi/5p9e3unZuFr2Utdk4JC5G7EM/KVUL6MMREUsOZjcpoQ8QLFLMhnhD90i1MhfdP+sAEZyDewZC6/1yJ/Voc3XImJVFNOCmNAYsfi+pAK8GFSHb++lErPryxSxrhTDjrC8l3ZV1YouO063DYxu+eG6lmWvb+RA1u420SzSKscPWwiDXv2xqQuc1c2zzz8Sdyvu9IrUEkoosnPmLW3iKRsIUW1uv/CxEQi0dcg0mkQoHB77PXU0HqQ1Tg+y3+kYVskA1Rg0i7Qro15nki3DeQ1quCbcLeF80sZyx055BEYzCoJQmEAROF4snZ4UuaTxtfHPWnG7d8DoqXaMDStQ4bAsHsvgTIvKFY+9GKZ6AF7lgnA0czd6JVCukmgiCKcyoX8rqExYBH1ywQnBI6xEyJrobrdpTCG85iVumaRT8SxAeUXUmbNHOaGIcsZDO6Xaxl3E+OU39
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LWGBMRODcOxg4Pa6Ez2Y55UdWPohvgi857AKSkeUxO5xdP8BRrpRnm3dm6B3?=
 =?us-ascii?Q?Q4fqbjYk1pEKJFHe5WVtEU1tqw1SLieiISRYOAaSHiH8WyUu+hW2clQR+fbI?=
 =?us-ascii?Q?auWkEZ2lHrhmqXRLZjXhgedZuezhfLXWVdQVZ7XMS1urHGllopS1y9kYHYLV?=
 =?us-ascii?Q?QdGD/lL8qt3GramyWOU8uvPLJqPYdQYI0heTwrciZElVU4fYuNgSm2ucBgE0?=
 =?us-ascii?Q?s/MIEdeVWjak0O4sZrQccUyw71c+Rjy4RAUkHz0x1ZrZuFCjtLC3k9qLS+Xa?=
 =?us-ascii?Q?dgB3g+73UkHBQchv4AGsMlzoY74+8AyEc8sHrVrpjwGa+coD4YosnniNhH7l?=
 =?us-ascii?Q?+y61oW7W/gPZVyVBivZHZm+khv1Bh45PhOq/5LnpsdePS72CcaqapJQXU2Rl?=
 =?us-ascii?Q?i4e6kCVvZ8d2UAyexIv/gYrX9jxGFXZvnCqspY2NvAY1AZN6/DYcbyG04K32?=
 =?us-ascii?Q?m8hcrGgoE4l6wONcBsi83zi0W23OpkFzb4pqQQswulroCENTLMJ8lyS7jn1m?=
 =?us-ascii?Q?vkCaO6Ck7ifYawD1jVKVVHfuXjcnsNGU9B2uBIE2wek+RO6xBhBa8Pn9gJCb?=
 =?us-ascii?Q?JS+bO04eUtm62Fw/QUYHciLXeXPl2TBivyVzmquHOcDBil3MrWIzPWWT2V/j?=
 =?us-ascii?Q?Eo7lGeUFh5KkHlIiM0J8gR5kvsCu3PpdP1EovarSUokKSgC+PyoEy7jCYAmI?=
 =?us-ascii?Q?+ce11c7BHQHnIAFAUgbDTi9hyrike6+MdUzV7z4LhJwsgJAQ0+oriwvxIuSn?=
 =?us-ascii?Q?8oh4V6LlAg8YIoPzv+J2oUYRTleL5w2QI6RhQpCD9/dNdv93YElS0iQu1yo7?=
 =?us-ascii?Q?/B1qYSB4sLEui3A7t1JoqVzbebXS6UJ5TfN23+8jRkQYkaGrudfzdhE9ARo7?=
 =?us-ascii?Q?UQteInjpQCXJvwB2UkNL0gWF9L8+jr0A7aBs5C1YiF9PTo0Zr4aR/2BW9zQu?=
 =?us-ascii?Q?ZcDGHxFa4RQeWq5hdxoYLruSouX92Es/K/vV+6k2k6J8LMWCmgYeA20fO62i?=
 =?us-ascii?Q?VufIzx5bKdTqzMbfHhDsn7bnJj2ijx5kyKB2hFy3F5Vn0NZYMn0H098SmimJ?=
 =?us-ascii?Q?NFIW6AOVVYYyHliExLcrHiSsKDNlu3maRGFUmlq3Hfops2OTc9eWwbMZRsRu?=
 =?us-ascii?Q?2bmlMZh94A6pLg/Tfw33PzzgCvzwwXfrlwZRvL3zvb9z97k30P6zx5khnJF1?=
 =?us-ascii?Q?GSidLAIr7pFWdsh2ewDTq/ETw+GMpjmRxFDp0ZBWfq7KGjqDPpw2LSq/a4E?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c618cf6-d5da-415e-0de9-08db720bffac
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 04:00:06.8790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5652
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
 drivers/hwmon/sht3x.c | 351 ++++++++++++++++++++++++++++--------------
 1 file changed, 239 insertions(+), 112 deletions(-)

diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index bf1863061..31013b5b6 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -147,6 +147,37 @@ static const u16 mode_to_update_interval[] = {
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
+static const struct i2c_device_id sht3x_ids[];
+
+static umode_t sht3x_is_visible(const void *data, enum hwmon_sensor_types type,
+				u32 attr, int channel);
+static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
+		      u32 attr, int channel, long *val);
+static int sht3x_write(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, long val);
+
+static const struct hwmon_ops sht3x_ops = {
+	.is_visible = sht3x_is_visible,
+	.read = sht3x_read,
+	.write = sht3x_write,
+};
+
+static const struct hwmon_chip_info sht3x_chip_info = {
+	.ops = &sht3x_ops,
+	.info = sht3x_channel_info,
+};
+
 struct sht3x_data {
 	struct i2c_client *client;
 	struct mutex i2c_lock; /* lock for sending i2c commands */
@@ -277,26 +308,24 @@ static struct sht3x_data *sht3x_update_client(struct device *dev)
 }
 
 /* sysfs attributes */
-static ssize_t temp1_input_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static int temp1_input_show(struct device *dev)
 {
 	struct sht3x_data *data = sht3x_update_client(dev);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return sprintf(buf, "%d\n", data->temperature);
+	return data->temperature;
 }
 
-static ssize_t humidity1_input_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static int humidity1_input_show(struct device *dev)
 {
 	struct sht3x_data *data = sht3x_update_client(dev);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return sprintf(buf, "%u\n", data->humidity);
+	return data->humidity;
 }
 
 /*
@@ -332,33 +361,24 @@ static int limits_update(struct sht3x_data *data)
 	return ret;
 }
 
-static ssize_t temp1_limit_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
+static int temp1_limit_show(struct device *dev, int index)
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
+static ssize_t humidity1_limit_show(struct device *dev, int index)
 {
 	struct sht3x_data *data = dev_get_drvdata(dev);
-	u8 index = to_sensor_dev_attr(attr)->index;
-	u32 humidity_limit = data->humidity_limits[index];
 
-	return sysfs_emit(buf, "%u\n", humidity_limit);
+	return data->humidity_limits[index];
 }
 
 /*
  * limit_store must only be called with data_lock held
  */
 static size_t limit_store(struct device *dev,
-			  size_t count,
 			  u8 index,
 			  int temperature,
 			  u32 humidity)
@@ -400,50 +420,42 @@ static size_t limit_store(struct device *dev,
 
 	data->temperature_limits[index] = temperature;
 	data->humidity_limits[index] = humidity;
-	return count;
+	return 0;
 }
 
-static ssize_t temp1_limit_store(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf,
-				 size_t count)
+static int temp1_limit_store(struct device *dev, int index, const char *val)
 {
 	int temperature;
 	int ret;
 	struct sht3x_data *data = dev_get_drvdata(dev);
-	u8 index = to_sensor_dev_attr(attr)->index;
 
-	ret = kstrtoint(buf, 0, &temperature);
+	ret = kstrtoint(val, 0, &temperature);
 	if (ret)
 		return ret;
 
 	temperature = clamp_val(temperature, SHT3X_MIN_TEMPERATURE,
 				SHT3X_MAX_TEMPERATURE);
 	mutex_lock(&data->data_lock);
-	ret = limit_store(dev, count, index, temperature,
+	ret = limit_store(dev, index, temperature,
 			  data->humidity_limits[index]);
 	mutex_unlock(&data->data_lock);
 
-	return ret;
+	return 0;
 }
 
-static ssize_t humidity1_limit_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t count)
+static ssize_t humidity1_limit_store(struct device *dev, int index, const char *val)
 {
 	u32 humidity;
 	int ret;
 	struct sht3x_data *data = dev_get_drvdata(dev);
-	u8 index = to_sensor_dev_attr(attr)->index;
 
-	ret = kstrtou32(buf, 0, &humidity);
+	ret = kstrtou32(val, 0, &humidity);
 	if (ret)
 		return ret;
 
 	humidity = clamp_val(humidity, SHT3X_MIN_HUMIDITY, SHT3X_MAX_HUMIDITY);
 	mutex_lock(&data->data_lock);
-	ret = limit_store(dev, count, index, data->temperature_limits[index],
+	ret = limit_store(dev, index, data->temperature_limits[index],
 			  humidity);
 	mutex_unlock(&data->data_lock);
 
@@ -474,7 +486,6 @@ static void sht3x_select_command(struct sht3x_data *data)
 }
 
 static int status_register_read(struct device *dev,
-				struct device_attribute *attr,
 				char *buffer, int length)
 {
 	int ret;
@@ -487,34 +498,30 @@ static int status_register_read(struct device *dev,
 	return ret;
 }
 
-static ssize_t temp1_alarm_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
+static int temp1_alarm_show(struct device *dev)
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
+static int humidity1_alarm_show(struct device *dev)
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
@@ -524,7 +531,7 @@ static ssize_t heater_enable_show(struct device *dev,
 	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
 	int ret;
 
-	ret = status_register_read(dev, attr, buffer,
+	ret = status_register_read(dev, buffer,
 				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
 	if (ret)
 		return ret;
@@ -560,20 +567,14 @@ static ssize_t heater_enable_store(struct device *dev,
 	return ret;
 }
 
-static ssize_t update_interval_show(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static int update_interval_show(struct device *dev)
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
+static int update_interval_store(struct device *dev, const char *val)
 {
 	u16 update_interval;
 	u8 mode;
@@ -582,7 +583,7 @@ static ssize_t update_interval_store(struct device *dev,
 	struct sht3x_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 
-	ret = kstrtou16(buf, 0, &update_interval);
+	ret = kstrtou16(val, 0, &update_interval);
 	if (ret)
 		return ret;
 
@@ -592,7 +593,7 @@ static ssize_t update_interval_store(struct device *dev,
 	/* mode did not change */
 	if (mode == data->mode) {
 		mutex_unlock(&data->data_lock);
-		return count;
+		return 0;
 	}
 
 	mutex_lock(&data->i2c_lock);
@@ -634,7 +635,7 @@ static ssize_t update_interval_store(struct device *dev,
 	if (ret != SHT3X_CMD_LENGTH)
 		return ret < 0 ? ret : -EIO;
 
-	return count;
+	return 0;
 }
 
 static ssize_t repeatability_show(struct device *dev,
@@ -668,60 +669,191 @@ static ssize_t repeatability_store(struct device *dev,
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
-	&sensor_dev_attr_repeatability.dev_attr.attr,
-	NULL
-};
-
-static struct attribute *sts3x_attrs[] = {
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_max.dev_attr.attr,
-	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_min.dev_attr.attr,
-	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
-	&sensor_dev_attr_heater_enable.dev_attr.attr,
-	&sensor_dev_attr_update_interval.dev_attr.attr,
 	&sensor_dev_attr_repeatability.dev_attr.attr,
 	NULL
 };
 
 ATTRIBUTE_GROUPS(sht3x);
-ATTRIBUTE_GROUPS(sts3x);
 
-static const struct i2c_device_id sht3x_ids[];
+static umode_t sht3x_is_visible(const void *data, enum hwmon_sensor_types type,
+				u32 attr, int channel)
+{
+	const struct sht3x_data *chip_data = data;
+	struct i2c_client *client = chip_data->client;
+
+	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_update_interval:
+			return 0644;
+		default:
+			return -EINVAL;
+		}
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
+			return -EINVAL;
+		}
+	case hwmon_humidity:
+		if (i2c_match_id(sht3x_ids, client)->driver_data == sts3x)
+			return 0;
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
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
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
+			*val = update_interval_show(dev);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			*val = temp1_input_show(dev);
+			return 0;
+		case hwmon_temp_alarm:
+			*val = temp1_alarm_show(dev);
+			return 0;
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
+			return -EINVAL;
+		}
+		*val = temp1_limit_show(dev, index);
+		return 0;
+	case hwmon_humidity:
+		switch (attr) {
+		case hwmon_humidity_input:
+			*val = humidity1_input_show(dev);
+			return 0;
+		case hwmon_humidity_alarm:
+			*val = humidity1_alarm_show(dev);
+			return 0;
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
+			return -EINVAL;
+		}
+		*val = humidity1_limit_show(dev, index);
+		return 0;
+	default:
+		return -EINVAL;
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
+			return update_interval_store(dev, (const char *)&val);
+		default:
+			return -EINVAL;
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
+			return -EINVAL;
+		}
+		return temp1_limit_store(dev, index, (const char *)&val);
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
+			return -EINVAL;
+		}
+		return humidity1_limit_store(dev, index, (const char *)val);
+	default:
+		return -EINVAL;
+	}
+}
 
 static int sht3x_probe(struct i2c_client *client)
 {
@@ -730,7 +862,6 @@ static int sht3x_probe(struct i2c_client *client)
 	struct device *hwmon_dev;
 	struct i2c_adapter *adap = client->adapter;
 	struct device *dev = &client->dev;
-	const struct attribute_group **attribute_groups;
 
 	/*
 	 * we require full i2c support since the sht3x uses multi-byte read and
@@ -771,15 +902,11 @@ static int sht3x_probe(struct i2c_client *client)
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
-- 
2.30.2

