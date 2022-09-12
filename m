Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AD75B6451
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiILXq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiILXq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:46:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D98A13FB9;
        Mon, 12 Sep 2022 16:46:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k9so18124994wri.0;
        Mon, 12 Sep 2022 16:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ybIVHt4WXBhuhxJn6Pk+VE/aCygxmevKebdL2p1Gp1Y=;
        b=OOPMZ4jlsmvkw3sWvJU2LHx0VdAI8UHbPmV+h0N3khSevzsz6mKYmohawNccSGVNQM
         zFYg357ONmGmAJGp9g0lXRitZBNFbdRun/EBo8RkJ9FQajVR2JfPCfHcj8Jw7WEly3fl
         zPLj+VY7vkNgD5yZCBG39FO1xZRNHUC51uDvgm406kXfDKi1Hr9cbGPhsXRvw6OKnrlL
         wwXapAPBW+A5SaMt1454JFBJnksxtWOgqG9fe9t93A5Q77VbBUvfUPIOr3oYh1H976B9
         xCfpj44NpJ1dDaGz2MMpPXZiu994IKZfcTojjg36Y+eCvRUCN5v7kzioA34pliYtl9Ko
         KExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ybIVHt4WXBhuhxJn6Pk+VE/aCygxmevKebdL2p1Gp1Y=;
        b=RwpCq1dkNikTKXj/qFXoE2pGgikWmhu75w64vu0Y/JX8NlTJ4ggQSLG74wgfhVuLSq
         Zf4RcQiqO7z2KoVYYPbaxC3d8LdhkjIT4EyJbQ8GN6DmNHAiOzW4nRKF3nG0tU2c2SnT
         w1l9AknT1ox2DSLaBeYg8alxL4Z1QFUtUASZKfpiO08rRvxPjcBG0Z+VxW9RgHFyrwNK
         McqGmtOWJo41qM0aYJmfFzZaVsFtg+IQ1jPCzq33K6Ngg0IcaB9yTFZbsZECwJw/I+0x
         If5R8wZzPzLD2t2QeR/ra3bxDpFa19Tnfvw3SrGyFMKtQ1rG3XQZJscB5Q6WRcjn6Bxl
         P8fw==
X-Gm-Message-State: ACgBeo0KHwo4S/jGbfp25BgF3AAs0ogkxh0DPDu04d6vlYCmlqEDSsW5
        7cU7PL1Z+YTjGaHzVgUcsEXCkJXnhtQ=
X-Google-Smtp-Source: AA6agR6xzm0lDHWrUKfS62iKjy/DztQSHHO/eQtwuYOfW2rb88WGn1/gaGffTzw+subzcArgd/Qe7w==
X-Received: by 2002:a5d:64e5:0:b0:22a:3cae:93bf with SMTP id g5-20020a5d64e5000000b0022a3cae93bfmr10632548wri.323.1663026384571;
        Mon, 12 Sep 2022 16:46:24 -0700 (PDT)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id i5-20020a05600011c500b0022a2de05876sm8547736wrx.97.2022.09.12.16.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 16:46:24 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/9] iio: pressure: bmp280: use FIELD_GET, FIELD_PREP and GENMASK
Date:   Tue, 13 Sep 2022 01:45:49 +0200
Message-Id: <3cbe56f29c2a46bc5dc23c5b72e1b43c9207f44d.1663025017.git.ang.iglesiasg@gmail.com>
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

Cleaned and simplified register values construction and extraction
converting to use FIELD_PREP and FIELD_GET macros.

Replaced hardcoded bit masks with GENMASK macro.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 25 ++++++----
 drivers/iio/pressure/bmp280.h      | 78 ++++++++++++++++--------------
 2 files changed, 57 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 42b29f30e9d1..0ba4ff999f33 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -16,6 +16,8 @@
 
 #define pr_fmt(fmt) "bmp280: " fmt
 
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -242,7 +244,7 @@ static int bmp280_read_calib(struct bmp280_data *data,
 		dev_err(dev, "failed to read H5 comp value\n");
 		return ret;
 	}
-	calib->H5 = sign_extend32(((le16_to_cpu(l16) >> 4) & 0xfff), 11);
+	calib->H5 = sign_extend32(FIELD_GET(BMP280_COMP_H5_MASK, le16_to_cpu(l16)), 11);
 
 	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
 	if (ret < 0) {
@@ -346,7 +348,7 @@ static int bmp280_read_temp(struct bmp280_data *data,
 		return ret;
 	}
 
-	adc_temp = be32_to_cpu(tmp) >> 12;
+	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, be32_to_cpu(tmp));
 	if (adc_temp == BMP280_TEMP_SKIPPED) {
 		/* reading was skipped */
 		dev_err(data->dev, "reading temperature skipped\n");
@@ -385,7 +387,7 @@ static int bmp280_read_press(struct bmp280_data *data,
 		return ret;
 	}
 
-	adc_press = be32_to_cpu(tmp) >> 12;
+	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, be32_to_cpu(tmp));
 	if (adc_press == BMP280_PRESS_SKIPPED) {
 		/* reading was skipped */
 		dev_err(data->dev, "reading pressure skipped\n");
@@ -611,8 +613,8 @@ static const struct iio_info bmp280_info = {
 
 static int bmp280_chip_config(struct bmp280_data *data)
 {
-	u8 osrs = BMP280_OSRS_TEMP_X(data->oversampling_temp + 1) |
-		  BMP280_OSRS_PRESS_X(data->oversampling_press + 1);
+	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
+		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
 	int ret;
 
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
@@ -654,7 +656,7 @@ static const struct bmp280_chip_info bmp280_chip_info = {
 
 static int bme280_chip_config(struct bmp280_data *data)
 {
-	u8 osrs = BMP280_OSRS_HUMIDITIY_X(data->oversampling_humid + 1);
+	u8 osrs = FIELD_PREP(BMP280_OSRS_HUMIDITY_MASK, data->oversampling_humid + 1);
 	int ret;
 
 	/*
@@ -711,7 +713,7 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 		if (!ret)
 			dev_err(data->dev, "timeout waiting for completion\n");
 	} else {
-		if (ctrl_meas == BMP180_MEAS_TEMP)
+		if (FIELD_GET(BMP180_MEAS_CTRL_MASK, ctrl_meas) == BMP180_MEAS_TEMP)
 			delay_us = 4500;
 		else
 			delay_us =
@@ -736,7 +738,9 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 	__be16 tmp;
 	int ret;
 
-	ret = bmp180_measure(data, BMP180_MEAS_TEMP);
+	ret = bmp180_measure(data,
+			     FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_TEMP) |
+			     BMP180_MEAS_SCO);
 	if (ret)
 		return ret;
 
@@ -833,7 +837,10 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 	__be32 tmp = 0;
 	int ret;
 
-	ret = bmp180_measure(data, BMP180_MEAS_PRESS_X(oss));
+	ret = bmp180_measure(data,
+			     FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_PRESS) |
+			     FIELD_PREP(BMP180_OSRS_PRESS_MASK, oss) |
+			     BMP180_MEAS_SCO);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 57ba0e85db91..4a501836d27a 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -13,6 +13,9 @@
 #define BMP280_REG_PRESS_LSB		0xF8
 #define BMP280_REG_PRESS_MSB		0xF7
 
+/* Helper mask to truncate excess 12 bits on pressure and temp readings */
+#define BMP280_MEAS_TRIM_MASK		GENMASK(31, 12)
+
 #define BMP280_REG_CONFIG		0xF5
 #define BMP280_REG_CTRL_MEAS		0xF4
 #define BMP280_REG_STATUS		0xF3
@@ -32,44 +35,43 @@
 #define BMP280_REG_COMP_PRESS_START	0x8E
 #define BMP280_COMP_PRESS_REG_COUNT	18
 
-#define BMP280_FILTER_MASK		(BIT(4) | BIT(3) | BIT(2))
+#define BMP280_COMP_H5_MASK		GENMASK(15, 4)
+
+#define BMP280_FILTER_MASK		GENMASK(4, 2)
 #define BMP280_FILTER_OFF		0
-#define BMP280_FILTER_2X		BIT(2)
-#define BMP280_FILTER_4X		BIT(3)
-#define BMP280_FILTER_8X		(BIT(3) | BIT(2))
-#define BMP280_FILTER_16X		BIT(4)
+#define BMP280_FILTER_2X		1
+#define BMP280_FILTER_4X		2
+#define BMP280_FILTER_8X		3
+#define BMP280_FILTER_16X		4
 
-#define BMP280_OSRS_HUMIDITY_MASK	(BIT(2) | BIT(1) | BIT(0))
-#define BMP280_OSRS_HUMIDITIY_X(osrs_h)	((osrs_h) << 0)
+#define BMP280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
 #define BMP280_OSRS_HUMIDITY_SKIP	0
-#define BMP280_OSRS_HUMIDITY_1X		BMP280_OSRS_HUMIDITIY_X(1)
-#define BMP280_OSRS_HUMIDITY_2X		BMP280_OSRS_HUMIDITIY_X(2)
-#define BMP280_OSRS_HUMIDITY_4X		BMP280_OSRS_HUMIDITIY_X(3)
-#define BMP280_OSRS_HUMIDITY_8X		BMP280_OSRS_HUMIDITIY_X(4)
-#define BMP280_OSRS_HUMIDITY_16X	BMP280_OSRS_HUMIDITIY_X(5)
+#define BMP280_OSRS_HUMIDITY_1X		1
+#define BMP280_OSRS_HUMIDITY_2X		2
+#define BMP280_OSRS_HUMIDITY_4X		3
+#define BMP280_OSRS_HUMIDITY_8X		4
+#define BMP280_OSRS_HUMIDITY_16X	5
 
-#define BMP280_OSRS_TEMP_MASK		(BIT(7) | BIT(6) | BIT(5))
+#define BMP280_OSRS_TEMP_MASK		GENMASK(7, 5)
 #define BMP280_OSRS_TEMP_SKIP		0
-#define BMP280_OSRS_TEMP_X(osrs_t)	((osrs_t) << 5)
-#define BMP280_OSRS_TEMP_1X		BMP280_OSRS_TEMP_X(1)
-#define BMP280_OSRS_TEMP_2X		BMP280_OSRS_TEMP_X(2)
-#define BMP280_OSRS_TEMP_4X		BMP280_OSRS_TEMP_X(3)
-#define BMP280_OSRS_TEMP_8X		BMP280_OSRS_TEMP_X(4)
-#define BMP280_OSRS_TEMP_16X		BMP280_OSRS_TEMP_X(5)
-
-#define BMP280_OSRS_PRESS_MASK		(BIT(4) | BIT(3) | BIT(2))
+#define BMP280_OSRS_TEMP_1X		1
+#define BMP280_OSRS_TEMP_2X		2
+#define BMP280_OSRS_TEMP_4X		3
+#define BMP280_OSRS_TEMP_8X		4
+#define BMP280_OSRS_TEMP_16X		5
+
+#define BMP280_OSRS_PRESS_MASK		GENMASK(4, 2)
 #define BMP280_OSRS_PRESS_SKIP		0
-#define BMP280_OSRS_PRESS_X(osrs_p)	((osrs_p) << 2)
-#define BMP280_OSRS_PRESS_1X		BMP280_OSRS_PRESS_X(1)
-#define BMP280_OSRS_PRESS_2X		BMP280_OSRS_PRESS_X(2)
-#define BMP280_OSRS_PRESS_4X		BMP280_OSRS_PRESS_X(3)
-#define BMP280_OSRS_PRESS_8X		BMP280_OSRS_PRESS_X(4)
-#define BMP280_OSRS_PRESS_16X		BMP280_OSRS_PRESS_X(5)
-
-#define BMP280_MODE_MASK		(BIT(1) | BIT(0))
+#define BMP280_OSRS_PRESS_1X		1
+#define BMP280_OSRS_PRESS_2X		2
+#define BMP280_OSRS_PRESS_4X		3
+#define BMP280_OSRS_PRESS_8X		4
+#define BMP280_OSRS_PRESS_16X		5
+
+#define BMP280_MODE_MASK		GENMASK(1, 0)
 #define BMP280_MODE_SLEEP		0
-#define BMP280_MODE_FORCED		BIT(0)
-#define BMP280_MODE_NORMAL		(BIT(1) | BIT(0))
+#define BMP280_MODE_FORCED		1
+#define BMP280_MODE_NORMAL		3
 
 /* BMP180 specific registers */
 #define BMP180_REG_OUT_XLSB		0xF8
@@ -79,13 +81,15 @@
 #define BMP180_REG_CALIB_START		0xAA
 #define BMP180_REG_CALIB_COUNT		22
 
+#define BMP180_MEAS_CTRL_MASK		GENMASK(4, 0)
+#define BMP180_MEAS_TEMP		0x0E
+#define BMP180_MEAS_PRESS		0x14
 #define BMP180_MEAS_SCO			BIT(5)
-#define BMP180_MEAS_TEMP		(0x0E | BMP180_MEAS_SCO)
-#define BMP180_MEAS_PRESS_X(oss)	((oss) << 6 | 0x14 | BMP180_MEAS_SCO)
-#define BMP180_MEAS_PRESS_1X		BMP180_MEAS_PRESS_X(0)
-#define BMP180_MEAS_PRESS_2X		BMP180_MEAS_PRESS_X(1)
-#define BMP180_MEAS_PRESS_4X		BMP180_MEAS_PRESS_X(2)
-#define BMP180_MEAS_PRESS_8X		BMP180_MEAS_PRESS_X(3)
+#define BMP180_OSRS_PRESS_MASK		GENMASK(7, 6)
+#define BMP180_MEAS_PRESS_1X		0
+#define BMP180_MEAS_PRESS_2X		1
+#define BMP180_MEAS_PRESS_4X		2
+#define BMP180_MEAS_PRESS_8X		3
 
 /* BMP180 and BMP280 common registers */
 #define BMP280_REG_CTRL_MEAS		0xF4
-- 
2.37.3

