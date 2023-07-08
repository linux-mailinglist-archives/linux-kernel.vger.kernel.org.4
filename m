Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F335174BE76
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjGHQah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 12:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGHQaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 12:30:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2040.outbound.protection.outlook.com [40.92.75.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD2CE50;
        Sat,  8 Jul 2023 09:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5wsCdEAcMG3eRHriwK3O6t9THax2kP7qqpTzYxSxb/6wxo3CfzntUVM2YujxyqSaIfAdLHpphgS6WMstrWqKF0cgPtbiv14SGtQHiZAgDS/LD2c1UeTa55F50nHYWYS5guwx0BoJSM5/2i/t46rPMqLlJDbh7OZTvHpHq9P32tFYjo0UUQKDP5/2yraSsgyQQG9ltB/QtOdKniiuUY/uBXuKUa9Fu9K+Exe6Ofzsb4a79jkt89ShtUtJS6w3gVDHoqHVJejfx7xR3aR49djb9kzjJRtLKQ/qL3IprIOJuU+C7JjPBwaIVAjCe/t+e5mjaJ57lYxcp6QK6dp4HV+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V995M87ADLIoEiQ8YTgxLfN421Cq1IEei0UToNC7O6g=;
 b=Js3cDURIKdALYc3X50WlWHaivELjbI33gaQ5wz3MfqbCpxK7FE6ENFMqtshFHMhWtHYEZWmDoKsE+I8TslQKlF9TaSVCgBcJNWL0VXtHxMb113Sezr6s7LqG71H6V+S4ia+LT0+MD608nbVWoXIArizyKm34iJQXSDD4g3BdETIgMbFCukG0ZZqa6huVokq/N2q3r2Z/asFCv0JjLaMk3v8te3VnZxVnTCRasag8crLtKOi14KXxiQ2W/1nTyY5FDmc8Bxe3rtPjU6F2FKKVLZP/Zmp1RtW+8EMWf6n3VdJB2GSmB7toWwl059BCEMRt5JWqZ5oi2wRSxPklD4b7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V995M87ADLIoEiQ8YTgxLfN421Cq1IEei0UToNC7O6g=;
 b=TJKeI0EXC4gWgfbJ7hvgXH4As1imapVt30g2YwXAdTGNAgI+MdkAqBDKl3LoZTRakggN2QH3sA4eELa7S6EOdmZjpdK+OV30pzYRAGKxq0Ch1mRizxmO3uOAetQJqSMxFqWCnxjFAfSfBwAF2VEbuYXzyYeGnUhCt+v4+j8YSmpCSa0PLZflCFwlCPB7r3lm/VtMVxocXVxylxdOe0Dozn/yCEBq24z1MqIk/JalnRWqOvG7XOf+A83migtFicvePDpCwgqgzsluzmu+iTxyj07dX0MUQU7wb/Eg+6rTW9PHrhJvQfFvK0JEhJk9ZvAfUi31kzcXGogfY175sYfOMQ==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AS2PR10MB7081.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 16:30:31 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6544.024; Sat, 8 Jul 2023
 16:30:31 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH v1] staging: iio: ad7816: add iio interface
Date:   Sun,  9 Jul 2023 00:29:58 +0800
Message-ID: <DB4PR10MB6261ADF6C8845AF66AB292989232A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [uyDRepYRGJD4Ubg1ogFbwnBM0GnxQIc8tpbl5Zp5GI5YAXDTngDq8lvDUFySNUik]
X-ClientProxiedBy: TY2PR01CA0001.jpnprd01.prod.outlook.com
 (2603:1096:404:a::13) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230708162958.518594-1-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AS2PR10MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 523e32f9-b325-44d6-2308-08db7fd0a57f
X-MS-Exchange-SLBlob-MailProps: PHS9e/w+tWL9MQbwWfVXN5PhRFoLpvXhLxnjOaCgkALnG1mS/if9qgtaq5CnFv5m3FIW4g/gBF0vOHC8EYJHm8qfo3zIMjc3X0/gmwgKsXZKNAlvg1Nievjthmx6dzpdrUjlDRO7XfY9Ye6Ac4OxHCdD5jMeCk4Ct7+z+N/80nRh43suPIks05Y/yT4RWW+cph/g+90UQIx8ZXQcrTCra9V8UgKHCWXjAy9027ArxgVBfZW41rosFnWpdT0yXIpdvBoqw+O8X6uxSoiXJue9hojCcCs60WF/Te/og8Kr4wFz52yhWvBM48VsjiC7RfFe/b3QrrV2aJ/qqA9fH+pNcJO+O/ozhPeGJ5E9hlboGwFBwR0tZDm+aO5s7/Z2g/nR42Isd8DY2+uUs9t6ycQR3o4oqeTDOZXm5wXbiaTMdHGSBzc5U5PQWSq6cmtboNCrzT3kMW4WSbs94/z6dMbWIsZl99G/grxVVdTBvh3vq3KlByf94xaCv+pZhqPNnyuQolqJZd8KsjNs9lKmlpUJguwZ0IOMY3uPuufU8FKnFW2ovQShKyD6hCk4HTOwH7Xo/eT/tOvOvUN+ST0bu6K0O8xaJmNq6Z3i00EeErEArRNsk7ur32Bhup5aGvT7MyZtZ07aoUTFHNjbdD0Mej8bxxRA9V4pUs4dMjeP71OzI9oLzr9O7Yfdi43Lhn6BAZYB+yVCYe6a5V1qqPSG7bAwvg==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJ+lBDix2t3gi8Q4phlC3pDRGbzSPTIk/c6CvxUaP87a0GuYsuSYY/BnAJL4ZyGhvQ212NfEOj/QihOD8LpE2rsg9d40dQ6ORyCTqGCUvCrSNX3Oiu/E86cqjJ3KnEyJy7LmV9OEJv1IOxlGh9pYGISWB+uQSbZs7OyYakTNlSzvHFzIHhavz3SD3N4KPz/vs2+4tgpMfZXCRwuE0n4mwRi03i5fJebYcVSJOj5ctNUc9VfwC00RLe73Ek0ktKaTZRvPX3Pawf431fG3dpjLVaWHiTBNZ5ISJPQQSpIYXS4vsRXpOMAgR1RdeyJOzkWq5KHFfwxzKnYRZGd+f0Ntrma18FFr9XBmNvrhQBh8df8dWmUCxH1yPOi+b7aFoMsJJA5dd6lghD+BuNEg/VBUB+CKFqnrePQgktfh2dBMxr0t2AwIXkeIvfkux9ObW23DSgQhdrZMSBFbTBnaWiiO1nhQSAam2AB5Hw0O3sRNunr7Hy/lpZKxl3WiGYX25pmYP1Rbq9H1CNrHOsl4rzOlGClJm2hJGTqWnxyNjw0wxfMRhh2G2HJUBqL5EQsZ397g3IXwCgTr0ROv6c1vp4KG8xl8JJ4r25SJsUcZlyN3dXaDrO3yllWgkZNZBAjQSGMQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cZ8LcT+G9hJQCictzoUJ4JoTk4omtfmQZ0OR2V7MStEwApjZO43IYqJRe2/o?=
 =?us-ascii?Q?+C+dHwjJElGdUZnq9jOgqePetYL1NpnlSjto7cHlzYvnRsvTEBdw2yqK73yM?=
 =?us-ascii?Q?y1aT4MEqiUQ9el/jHeuFxnoBgxd1Tae3s64ikZbbiMcmGzaYVRrOeqrTdiG3?=
 =?us-ascii?Q?jb7GbWwCBN+p3GG8SMsleCY2I7CqENvUNmBkU7Uhlson+wp+Hawbxg0kflUF?=
 =?us-ascii?Q?ltHoYcRe8CSGJcnUx4Gp53d91QZHDisIGw8R7GjAMTS6mccBZsE1iQ4M9Voz?=
 =?us-ascii?Q?n37CyAgMRTC1Y03iAk+1Bzov2sq/C2RCAhRqhZ6JEeXoUym7WQ4wlE4JlDLf?=
 =?us-ascii?Q?6l+xJdswGs6GZedNinATDuET9cMHT1N49qdkhuNEaz4BEeoqRGeK/RVd9YCI?=
 =?us-ascii?Q?i7Awk2KrhDzyw0kyioR5WJrOUfvQSR9Bht63QQBPvalnR3NWz5J3+w5nmJxM?=
 =?us-ascii?Q?wKIKP00NqcWpkvy5BkHiD5rCCY6CsKMflTfYVUHviQ2MLS8uYmcuKOH75548?=
 =?us-ascii?Q?jVRvklIzuMiD/zAZ/el15kNcwxsNmX6Uri4NYXMN6xAby0yNI8sPRz+1ziJA?=
 =?us-ascii?Q?a2rQt5FjWp3Z05hjSffV+qtXFYjnrs1poEx6j7N/DI9Mi83CuWup0NG7r0K8?=
 =?us-ascii?Q?hb4h2WgwODrFeVvYAfkhRW1q1W0enpA8rGUYhOOIjDi/He4hpr9KEKzqPJ5i?=
 =?us-ascii?Q?152ziOJkhxGK4FmncqL2NaWHc7B0WAcT1y/pLIBdL7TrSK0Hv3ybFzsgXCX3?=
 =?us-ascii?Q?NlQ71GyyNa3cDUc8aeSx/rlzWgMLvFi68ooQR6IkpCngkdga5L+vkk1MPGWx?=
 =?us-ascii?Q?M7YyMyk64QDhZVeCM6jNS7Kv58rxNj8WFZjsP/tfSR8z6I3nRbCHgO6UB2S/?=
 =?us-ascii?Q?rhxDOuYtDs597c4B+OW7sx9womDwscYd2fWPeZ69Cr1m4RlOikolKR4QT+v/?=
 =?us-ascii?Q?OzdF6WYjeVXLOkRhZrZxKjKSnNmjV3Z4IkOWbRF7kVai0Uc+KvHbYumsiAlL?=
 =?us-ascii?Q?xGkBcq99FVsPY+4WzLyxU7tQZZKvfqgwEvVbA0qEPqXM4BFHRTl00pSgZrBK?=
 =?us-ascii?Q?jPFeMyqy7CnwOpsn19VLCJeaQjVYmeTd3Sz85UGVdzryinkVKRZ/ph6GRqfr?=
 =?us-ascii?Q?wS8wjzaBks1aUEWh1PZ7rVQBnRLd6kBU/bbo0LTVwcREtVB1Rh6GTPeXyh2d?=
 =?us-ascii?Q?GgP9lo/j6aaqqYHlVh+1PSTFAeekpsPT9jx4p8wPzuMAP5SNMALU7rFSvHke?=
 =?us-ascii?Q?0e94IMYbu+Rsc0QmFtojZBBN9WiIZQVmN1dgK2cK7Lv5GtsOxC2LkpmgmYhM?=
 =?us-ascii?Q?3ek=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 523e32f9-b325-44d6-2308-08db7fd0a57f
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 16:30:31.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add iio interface for 4 channels, replacing the previous sysfs
interface

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 122 +++++++++++++++----------------
 1 file changed, 59 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 6c14d7bcdd67..8af117b6ae11 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -162,64 +162,17 @@ static ssize_t ad7816_show_available_modes(struct device *dev,
 static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
 			NULL, 0);
 
-static ssize_t ad7816_show_channel(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
+static int ad7816_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
-
-	return sprintf(buf, "%d\n", chip->channel_id);
-}
-
-static ssize_t ad7816_store_channel(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
-	unsigned long data;
-	int ret;
-
-	ret = kstrtoul(buf, 10, &data);
-	if (ret)
-		return ret;
-
-	if (data > AD7816_CS_MAX && data != AD7816_CS_MASK) {
-		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
-			data, indio_dev->name);
-		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1) {
-		dev_err(&chip->spi_dev->dev,
-			"Invalid channel id %lu for ad7818.\n", data);
-		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0) {
-		dev_err(&chip->spi_dev->dev,
-			"Invalid channel id %lu for ad7816.\n", data);
-		return -EINVAL;
-	}
-
-	chip->channel_id = data;
-
-	return len;
-}
-
-static IIO_DEVICE_ATTR(channel, 0644,
-		ad7816_show_channel,
-		ad7816_store_channel,
-		0);
-
-static ssize_t ad7816_show_value(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 	u16 data;
-	s8 value;
 	int ret;
 
+	chip->channel_id = (u8)chan->channel;
 	ret = ad7816_spi_read(chip, &data);
 	if (ret)
 		return -EIO;
@@ -227,22 +180,21 @@ static ssize_t ad7816_show_value(struct device *dev,
 	data >>= AD7816_VALUE_OFFSET;
 
 	if (chip->channel_id == 0) {
-		value = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
-		data &= AD7816_TEMP_FLOAT_MASK;
-		if (value < 0)
-			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
-		return sprintf(buf, "%d.%.2d\n", value, data * 25);
+		*val = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
+		*val2 = (data & AD7816_TEMP_FLOAT_MASK) * 25;
+		if (*val < 0)
+			*val2 = BIT(AD7816_TEMP_FLOAT_OFFSET) - *val2;
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
-	return sprintf(buf, "%u\n", data);
-}
 
-static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
+	*val = data;
+
+	return IIO_VAL_INT;
+}
 
 static struct attribute *ad7816_attributes[] = {
 	&iio_dev_attr_available_modes.dev_attr.attr,
 	&iio_dev_attr_mode.dev_attr.attr,
-	&iio_dev_attr_channel.dev_attr.attr,
-	&iio_dev_attr_value.dev_attr.attr,
 	NULL,
 };
 
@@ -341,10 +293,47 @@ static const struct attribute_group ad7816_event_attribute_group = {
 };
 
 static const struct iio_info ad7816_info = {
+	.read_raw = ad7816_read_raw,
 	.attrs = &ad7816_attribute_group,
 	.event_attrs = &ad7816_event_attribute_group,
 };
 
+static const struct iio_chan_spec ad7816_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+};
+
+static const struct iio_chan_spec ad7817_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 2,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 3,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+};
+
 /*
  * device probe and remove
  */
@@ -367,6 +356,13 @@ static int ad7816_probe(struct spi_device *spi_dev)
 		chip->oti_data[i] = 203;
 
 	chip->id = spi_get_device_id(spi_dev)->driver_data;
+	if (chip->id == ID_AD7816) {
+		indio_dev->channels = ad7816_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ad7816_channels);
+	} else {
+		indio_dev->channels = ad7817_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ad7817_channels);
+	}
 	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
 	if (IS_ERR(chip->rdwr_pin)) {
 		ret = PTR_ERR(chip->rdwr_pin);
-- 
2.39.2

