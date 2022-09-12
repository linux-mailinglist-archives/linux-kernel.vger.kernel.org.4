Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF975B645C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiILXtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiILXti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:49:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B302F265E;
        Mon, 12 Sep 2022 16:49:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t14so18068664wrx.8;
        Mon, 12 Sep 2022 16:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=P5PFHbEUs7DFdp8mOcB8prmVO+v6b6GmK8BHCtpJJm8=;
        b=eK9VxGy1D+EHJFeW77a4Tn6bs//bBTPCoxjraifG0Q+n/S/hcZXm3PVypfg9VJsITr
         0NVsMaSHCKWCzHSG3lLBeHSeIcuB10DF3Z/z+N8MKPz8E7U/TH/KrC7xxSFbj6MTlepL
         x8vv7qrFha836Is6cbbYxgseO3JifQ7nMJSqi0+UlMKe8YPTBClj9kZHG6g629h+4yTd
         4wvif1JkhzheSs9IppGWEwi3TVMdt5vtU32AUxtnWhvhWnya2xtW4e6uigTp1a3zuwZN
         ZfGBef6jocKLaOnH+TnA9tFtRUFI6Gb+x3a7OAcgK2dUuZZwA7ikm18GVJMfYEI9Z5T6
         ztUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=P5PFHbEUs7DFdp8mOcB8prmVO+v6b6GmK8BHCtpJJm8=;
        b=5t1lUYWs6mFllt82PRLSCGVnnWKpJCOlkanSoRRpM133oCNABO8brD81p3VtcRT2xm
         A/JYtgtgzXbsQa9oEMw/hkGnQt5gK5PSGAVNVJvrbnAhf6DsC1kbx0Ve/wZk4Nj+3cEc
         taWAHbdVpzuyyEWqV/v9QGHHtC0qXyk6IMZJFNYJNJhAeY5q9jNA7j/8KZOpyI6SQEIv
         NepRv6uALXVS8FGes7VnBcgYpgwNcA+IDrXUaqcHOMnhX2fOn1+nAoVRbuUXvx1cajQW
         cBGiqEfVYxcE38GJoTDnk30TkUXVoS+SCj1GWG4Nl/7lsu0VDwNzFPMWj90q48nnZYwT
         l8IQ==
X-Gm-Message-State: ACgBeo3uzXBgaqbh+CtE9K0mMFQlXYJJhiQ2pTT4LQsO/r+j5l8cavHU
        /AKMG3uyp5M+MSBwBWFU4QPxcfO3v+I=
X-Google-Smtp-Source: AA6agR51pLbSTWA6IWQhvMQC38ZrShZsbV8Db4Ty8sNz6WJ8w1AXa9k83B6TOL0b5zh5EXQbKQT2cw==
X-Received: by 2002:a05:6000:81e:b0:228:a17f:92f0 with SMTP id bt30-20020a056000081e00b00228a17f92f0mr17017920wrb.31.1663026569730;
        Mon, 12 Sep 2022 16:49:29 -0700 (PDT)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d5387000000b00228d52b935asm8623227wrv.71.2022.09.12.16.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 16:49:29 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/9] iio: pressure: bmp280: Fix alignment for DMA safety
Date:   Tue, 13 Sep 2022 01:48:21 +0200
Message-Id: <7919793f7f63224d5ce413c66d648029683c17ac.1663025017.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663025017.git.ang.iglesiasg@gmail.com>
References: <cover.1663025017.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds DMA-safe buffers to driver data struct to store raw data from sensors

The multiple buffers used thorough the driver share the same memory
allocated as part of the device data instance. The union containing
the buffers is aligned to allow safe usage with DMA operations, such
as regmap bulk read calls.

Updated measurement and calibration reading functions to use the safe
DMA buffers.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 131 ++++++++++++++++-------------
 drivers/iio/pressure/bmp280.h      |   4 +-
 2 files changed, 76 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 203623d32032..b6a16a580962 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -32,6 +32,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
 
+#include <asm/unaligned.h>
+
 #include "bmp280.h"
 
 /*
@@ -106,6 +108,21 @@ struct bmp280_data {
 	 * calculation.
 	 */
 	s32 t_fine;
+
+	/*
+	 * DMA (thus cache coherency maintenance) may require the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	union {
+		/* Sensor data buffer */
+		u8 buf[3];
+		/* Calibration data buffers */
+		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
+		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
+		/* Miscellaneous, endianess-aware data buffers */
+		__le16 le16;
+		__be16 be16;
+	} __aligned(IIO_DMA_MINALIGN);
 };
 
 struct bmp280_chip_info {
@@ -160,13 +177,12 @@ static const struct iio_chan_spec bmp280_channels[] = {
 static int bmp280_read_calib(struct bmp280_data *data)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
-	__le16 c_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
 	int ret;
 
 
 	/* Read temperature and pressure calibration values. */
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
-			       c_buf, sizeof(c_buf));
+			       data->bmp280_cal_buf, sizeof(data->bmp280_cal_buf));
 	if (ret < 0) {
 		dev_err(data->dev,
 			"failed to read temperature and pressure calibration parameters\n");
@@ -174,23 +190,23 @@ static int bmp280_read_calib(struct bmp280_data *data)
 	}
 
 	/* Toss the temperature and pressure calibration data into the entropy pool */
-	add_device_randomness(c_buf, sizeof(c_buf));
+	add_device_randomness(data->bmp280_cal_buf, sizeof(data->bmp280_cal_buf));
 
 	/* Parse temperature calibration values. */
-	calib->T1 = le16_to_cpu(c_buf[T1]);
-	calib->T2 = le16_to_cpu(c_buf[T2]);
-	calib->T3 = le16_to_cpu(c_buf[T3]);
+	calib->T1 = le16_to_cpu(data->bmp280_cal_buf[T1]);
+	calib->T2 = le16_to_cpu(data->bmp280_cal_buf[T2]);
+	calib->T3 = le16_to_cpu(data->bmp280_cal_buf[T3]);
 
 	/* Parse pressure calibration values. */
-	calib->P1 = le16_to_cpu(c_buf[P1]);
-	calib->P2 = le16_to_cpu(c_buf[P2]);
-	calib->P3 = le16_to_cpu(c_buf[P3]);
-	calib->P4 = le16_to_cpu(c_buf[P4]);
-	calib->P5 = le16_to_cpu(c_buf[P5]);
-	calib->P6 = le16_to_cpu(c_buf[P6]);
-	calib->P7 = le16_to_cpu(c_buf[P7]);
-	calib->P8 = le16_to_cpu(c_buf[P8]);
-	calib->P9 = le16_to_cpu(c_buf[P9]);
+	calib->P1 = le16_to_cpu(data->bmp280_cal_buf[P1]);
+	calib->P2 = le16_to_cpu(data->bmp280_cal_buf[P2]);
+	calib->P3 = le16_to_cpu(data->bmp280_cal_buf[P3]);
+	calib->P4 = le16_to_cpu(data->bmp280_cal_buf[P4]);
+	calib->P5 = le16_to_cpu(data->bmp280_cal_buf[P5]);
+	calib->P6 = le16_to_cpu(data->bmp280_cal_buf[P6]);
+	calib->P7 = le16_to_cpu(data->bmp280_cal_buf[P7]);
+	calib->P8 = le16_to_cpu(data->bmp280_cal_buf[P8]);
+	calib->P9 = le16_to_cpu(data->bmp280_cal_buf[P9]);
 
 	return 0;
 }
@@ -200,8 +216,6 @@ static int bme280_read_calib(struct bmp280_data *data)
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	struct device *dev = data->dev;
 	unsigned int tmp;
-	__le16 l16;
-	__be16 b16;
 	int ret;
 
 	/* Load shared calibration params with bmp280 first */
@@ -226,12 +240,13 @@ static int bme280_read_calib(struct bmp280_data *data)
 	}
 	calib->H1 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2, &l16, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2,
+			       &data->le16, sizeof(data->le16));
 	if (ret < 0) {
 		dev_err(dev, "failed to read H2 comp value\n");
 		return ret;
 	}
-	calib->H2 = sign_extend32(le16_to_cpu(l16), 15);
+	calib->H2 = sign_extend32(le16_to_cpu(data->le16), 15);
 
 	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &tmp);
 	if (ret < 0) {
@@ -240,20 +255,22 @@ static int bme280_read_calib(struct bmp280_data *data)
 	}
 	calib->H3 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4, &b16, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4,
+			       &data->be16, sizeof(data->be16));
 	if (ret < 0) {
 		dev_err(dev, "failed to read H4 comp value\n");
 		return ret;
 	}
-	calib->H4 = sign_extend32(((be16_to_cpu(b16) >> 4) & 0xff0) |
-				  (be16_to_cpu(b16) & 0xf), 11);
+	calib->H4 = sign_extend32(((be16_to_cpu(data->be16) >> 4) & 0xff0) |
+				  (be16_to_cpu(data->be16) & 0xf), 11);
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5, &l16, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5,
+			       &data->le16, sizeof(data->le16));
 	if (ret < 0) {
 		dev_err(dev, "failed to read H5 comp value\n");
 		return ret;
 	}
-	calib->H5 = sign_extend32(FIELD_GET(BMP280_COMP_H5_MASK, le16_to_cpu(l16)), 11);
+	calib->H5 = sign_extend32(FIELD_GET(BMP280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
 
 	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
 	if (ret < 0) {
@@ -348,16 +365,16 @@ static int bmp280_read_temp(struct bmp280_data *data,
 			    int *val)
 {
 	s32 adc_temp, comp_temp;
-	__be32 tmp = 0;
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB, &tmp, 3);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
+			       data->buf, sizeof(data->buf));
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
 	}
 
-	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, be32_to_cpu(tmp));
+	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
 	if (adc_temp == BMP280_TEMP_SKIPPED) {
 		/* reading was skipped */
 		dev_err(data->dev, "reading temperature skipped\n");
@@ -381,7 +398,6 @@ static int bmp280_read_press(struct bmp280_data *data,
 			     int *val, int *val2)
 {
 	u32 comp_press;
-	__be32 tmp = 0;
 	s32 adc_press;
 	int ret;
 
@@ -390,13 +406,14 @@ static int bmp280_read_press(struct bmp280_data *data,
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB, &tmp, 3);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
+			       data->buf, sizeof(data->buf));
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
 	}
 
-	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, be32_to_cpu(tmp));
+	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
 	if (adc_press == BMP280_PRESS_SKIPPED) {
 		/* reading was skipped */
 		dev_err(data->dev, "reading pressure skipped\n");
@@ -414,7 +431,6 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 {
 	u32 comp_humidity;
 	s32 adc_humidity;
-	__be16 tmp;
 	int ret;
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
@@ -422,13 +438,14 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB, &tmp, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
+			       &data->be16, sizeof(data->be16));
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read humidity\n");
 		return ret;
 	}
 
-	adc_humidity = be16_to_cpu(tmp);
+	adc_humidity = be16_to_cpu(data->be16);
 	if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
 		/* reading was skipped */
 		dev_err(data->dev, "reading humidity skipped\n");
@@ -769,7 +786,6 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 
 static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 {
-	__be16 tmp;
 	int ret;
 
 	ret = bmp180_measure(data,
@@ -778,11 +794,12 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, &tmp, 2);
+	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
+			       &data->be16, sizeof(data->be16));
 	if (ret)
 		return ret;
 
-	*val = be16_to_cpu(tmp);
+	*val = be16_to_cpu(data->be16);
 
 	return 0;
 }
@@ -790,36 +807,36 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 static int bmp180_read_calib(struct bmp280_data *data)
 {
 	struct bmp180_calib *calib = &data->calib.bmp180;
-	__be16 buf[BMP180_REG_CALIB_COUNT / 2];
 	int ret;
 	int i;
 
-	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START, buf,
-			       sizeof(buf));
+	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START,
+			       data->bmp180_cal_buf, sizeof(data->bmp180_cal_buf));
 
 	if (ret < 0)
 		return ret;
 
 	/* None of the words has the value 0 or 0xFFFF */
-	for (i = 0; i < ARRAY_SIZE(buf); i++) {
-		if (buf[i] == cpu_to_be16(0) || buf[i] == cpu_to_be16(0xffff))
+	for (i = 0; i < ARRAY_SIZE(data->bmp180_cal_buf); i++) {
+		if (data->bmp180_cal_buf[i] == cpu_to_be16(0) ||
+		    data->bmp180_cal_buf[i] == cpu_to_be16(0xffff))
 			return -EIO;
 	}
 
 	/* Toss the calibration data into the entropy pool */
-	add_device_randomness(buf, sizeof(buf));
-
-	calib->AC1 = be16_to_cpu(buf[AC1]);
-	calib->AC2 = be16_to_cpu(buf[AC2]);
-	calib->AC3 = be16_to_cpu(buf[AC3]);
-	calib->AC4 = be16_to_cpu(buf[AC4]);
-	calib->AC5 = be16_to_cpu(buf[AC5]);
-	calib->AC6 = be16_to_cpu(buf[AC6]);
-	calib->B1 = be16_to_cpu(buf[B1]);
-	calib->B2 = be16_to_cpu(buf[B2]);
-	calib->MB = be16_to_cpu(buf[MB]);
-	calib->MC = be16_to_cpu(buf[MC]);
-	calib->MD = be16_to_cpu(buf[MD]);
+	add_device_randomness(data->bmp180_cal_buf, sizeof(data->bmp180_cal_buf));
+
+	calib->AC1 = be16_to_cpu(data->bmp180_cal_buf[AC1]);
+	calib->AC2 = be16_to_cpu(data->bmp180_cal_buf[AC2]);
+	calib->AC3 = be16_to_cpu(data->bmp180_cal_buf[AC3]);
+	calib->AC4 = be16_to_cpu(data->bmp180_cal_buf[AC4]);
+	calib->AC5 = be16_to_cpu(data->bmp180_cal_buf[AC5]);
+	calib->AC6 = be16_to_cpu(data->bmp180_cal_buf[AC6]);
+	calib->B1 = be16_to_cpu(data->bmp180_cal_buf[B1]);
+	calib->B2 = be16_to_cpu(data->bmp180_cal_buf[B2]);
+	calib->MB = be16_to_cpu(data->bmp180_cal_buf[MB]);
+	calib->MC = be16_to_cpu(data->bmp180_cal_buf[MC]);
+	calib->MD = be16_to_cpu(data->bmp180_cal_buf[MD]);
 
 	return 0;
 }
@@ -868,7 +885,6 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val)
 static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 {
 	u8 oss = data->oversampling_press;
-	__be32 tmp = 0;
 	int ret;
 
 	ret = bmp180_measure(data,
@@ -878,11 +894,12 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, &tmp, 3);
+	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
+			       data->buf, sizeof(data->buf));
 	if (ret)
 		return ret;
 
-	*val = (be32_to_cpu(tmp) >> 8) >> (8 - oss);
+	*val = get_unaligned_be24(data->buf) >> (8 - oss);
 
 	return 0;
 }
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 03a539223417..c9214a7e5cc6 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -13,8 +13,8 @@
 #define BMP280_REG_PRESS_LSB		0xF8
 #define BMP280_REG_PRESS_MSB		0xF7
 
-/* Helper mask to truncate excess 12 bits on pressure and temp readings */
-#define BMP280_MEAS_TRIM_MASK		GENMASK(31, 12)
+/* Helper mask to truncate excess 4 bits on pressure and temp readings */
+#define BMP280_MEAS_TRIM_MASK		GENMASK(24, 4)
 
 #define BMP280_REG_CONFIG		0xF5
 #define BMP280_REG_CTRL_MEAS		0xF4
-- 
2.37.3

