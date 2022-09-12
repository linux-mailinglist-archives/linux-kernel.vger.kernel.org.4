Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21835B644F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiILXp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiILXpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:45:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2A913D7D;
        Mon, 12 Sep 2022 16:45:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bq9so18080495wrb.4;
        Mon, 12 Sep 2022 16:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Je74ISkjKuqmYbxBR4pABNa6asr1zFtT31m2iJGIDn0=;
        b=aulZcGlLQQToD0/WX54mgGcKXSfBvkxt2mxLOdvS1f12Iz1cURNVBVtnqt2PI31xyz
         d/7aHHacqYBvjq+BYF4uuXGege2hHbSwm2M7qHxlygTH/4Lrsr+K6M9CTXad1xBFAjhc
         3hFIfkAtN2Y4idORFUVZlSsSMCh5osxvouHaASt3sY+M9YbHV4RPWS656+WIbPm7Yx+b
         sT8c/cfXyxPbIAzpA69hheuF1froYSASBBWnLBqrWjnSHw6Laaj4a3X8NR8Q1fsc8wNK
         dqByy3uWoVAxivOQONTeeQ6L+WLuHWZzjF5rzc9Sp5zZN1lVcdZZjlxWpc/GClzUHAZy
         QcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Je74ISkjKuqmYbxBR4pABNa6asr1zFtT31m2iJGIDn0=;
        b=L5AkDE1TXXvohn0a569tUsXyfVx89aWD/VScYBfgF8+7w5SRzz8tMfOeJ++kI4pM8/
         tJrY2klUczAtfHUJjGMFZ3HIpstw9XmLs+urNOmI/Q9lJygg8wYPhXS3SxogTuFQhITS
         JtrIUuVzmmIiv/VQz9gfA5N36PZMCfW+hLXiFARVCE0URnHSPI1WTlTS4bQLJgVV6s9w
         4mpis9jXscBCY6BReq7u9hmJubxHwYramIsYg1AH0gjkP0xxJdqgBrd6fgcyl85HKY9y
         MSJYcOdiHpzpQBwjpvpIbWWyxzga1ipWbkVW0zdyKY2BBurddcughkwl7226Onqi0iU0
         TJLQ==
X-Gm-Message-State: ACgBeo0QFXptgm7NhytDbffmIsSPazkvw9u2bxvFBjSQ/x0FO8pmjVon
        aztmLS9cN06qhLyWvhi2yNw+WiifuE8=
X-Google-Smtp-Source: AA6agR7UUeHkH4Yv2qfOFgwGbLd7LEBPQbSvSUcEvZMyXLphB7eB0fQKk+ve9cFPvvz0aTxphwZ9Dg==
X-Received: by 2002:a05:6000:1886:b0:22a:2944:a09 with SMTP id a6-20020a056000188600b0022a29440a09mr14762387wri.391.1663026320572;
        Mon, 12 Sep 2022 16:45:20 -0700 (PDT)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c1c9000b003b492338f45sm3202943wms.39.2022.09.12.16.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 16:45:20 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/9] iio: pressure: bmp280: reorder local variables following reverse xmas tree
Date:   Tue, 13 Sep 2022 01:44:52 +0200
Message-Id: <363a106afbfe30ce590b80b1494c8b3322870f8a.1663025017.git.ang.iglesiasg@gmail.com>
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

Reordered definitions of local variables following the reverse christmas
tree convention.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 65 +++++++++++++++---------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe7aa81e7cc9..42b29f30e9d1 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -151,13 +151,14 @@ static int bmp280_read_calib(struct bmp280_data *data,
 			     struct bmp280_calib *calib,
 			     unsigned int chip)
 {
-	int ret;
+	__le16 p_buf[BMP280_COMP_PRESS_REG_COUNT / 2];
+	__le16 t_buf[BMP280_COMP_TEMP_REG_COUNT / 2];
+	struct device *dev = data->dev;
 	unsigned int tmp;
 	__le16 l16;
 	__be16 b16;
-	struct device *dev = data->dev;
-	__le16 t_buf[BMP280_COMP_TEMP_REG_COUNT / 2];
-	__le16 p_buf[BMP280_COMP_PRESS_REG_COUNT / 2];
+	int ret;
+
 
 	/* Read temperature calibration values. */
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
@@ -261,8 +262,8 @@ static int bmp280_read_calib(struct bmp280_data *data,
 static u32 bmp280_compensate_humidity(struct bmp280_data *data,
 				      s32 adc_humidity)
 {
-	s32 var;
 	struct bmp280_calib *calib = &data->calib.bmp280;
+	s32 var;
 
 	var = ((s32)data->t_fine) - (s32)76800;
 	var = ((((adc_humidity << 14) - (calib->H4 << 20) - (calib->H5 * var))
@@ -286,8 +287,8 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
 static s32 bmp280_compensate_temp(struct bmp280_data *data,
 				  s32 adc_temp)
 {
-	s32 var1, var2;
 	struct bmp280_calib *calib = &data->calib.bmp280;
+	s32 var1, var2;
 
 	var1 = (((adc_temp >> 3) - ((s32)calib->T1 << 1)) *
 		((s32)calib->T2)) >> 11;
@@ -309,8 +310,8 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
 static u32 bmp280_compensate_press(struct bmp280_data *data,
 				   s32 adc_press)
 {
-	s64 var1, var2, p;
 	struct bmp280_calib *calib = &data->calib.bmp280;
+	s64 var1, var2, p;
 
 	var1 = ((s64)data->t_fine) - 128000;
 	var2 = var1 * var1 * (s64)calib->P6;
@@ -335,9 +336,9 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 static int bmp280_read_temp(struct bmp280_data *data,
 			    int *val)
 {
-	int ret;
-	__be32 tmp = 0;
 	s32 adc_temp, comp_temp;
+	__be32 tmp = 0;
+	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB, &tmp, 3);
 	if (ret < 0) {
@@ -368,10 +369,10 @@ static int bmp280_read_temp(struct bmp280_data *data,
 static int bmp280_read_press(struct bmp280_data *data,
 			     int *val, int *val2)
 {
-	int ret;
+	u32 comp_press;
 	__be32 tmp = 0;
 	s32 adc_press;
-	u32 comp_press;
+	int ret;
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
 	ret = bmp280_read_temp(data, NULL);
@@ -400,10 +401,10 @@ static int bmp280_read_press(struct bmp280_data *data,
 
 static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 {
+	u32 comp_humidity;
+	s32 adc_humidity;
 	__be16 tmp;
 	int ret;
-	s32 adc_humidity;
-	u32 comp_humidity;
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
 	ret = bmp280_read_temp(data, NULL);
@@ -433,8 +434,8 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
 {
-	int ret;
 	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret;
 
 	pm_runtime_get_sync(data->dev);
 	mutex_lock(&data->lock);
@@ -490,9 +491,9 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
 					       int val)
 {
-	int i;
 	const int *avail = data->chip_info->oversampling_humid_avail;
 	const int n = data->chip_info->num_oversampling_humid_avail;
+	int i;
 
 	for (i = 0; i < n; i++) {
 		if (avail[i] == val) {
@@ -507,9 +508,9 @@ static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
 static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
 					       int val)
 {
-	int i;
 	const int *avail = data->chip_info->oversampling_temp_avail;
 	const int n = data->chip_info->num_oversampling_temp_avail;
+	int i;
 
 	for (i = 0; i < n; i++) {
 		if (avail[i] == val) {
@@ -524,9 +525,9 @@ static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
 static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
 					       int val)
 {
-	int i;
 	const int *avail = data->chip_info->oversampling_press_avail;
 	const int n = data->chip_info->num_oversampling_press_avail;
+	int i;
 
 	for (i = 0; i < n; i++) {
 		if (avail[i] == val) {
@@ -542,8 +543,8 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
 {
-	int ret = 0;
 	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret = 0;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -610,9 +611,9 @@ static const struct iio_info bmp280_info = {
 
 static int bmp280_chip_config(struct bmp280_data *data)
 {
-	int ret;
 	u8 osrs = BMP280_OSRS_TEMP_X(data->oversampling_temp + 1) |
 		  BMP280_OSRS_PRESS_X(data->oversampling_press + 1);
+	int ret;
 
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
 				 BMP280_OSRS_TEMP_MASK |
@@ -653,8 +654,8 @@ static const struct bmp280_chip_info bmp280_chip_info = {
 
 static int bme280_chip_config(struct bmp280_data *data)
 {
-	int ret;
 	u8 osrs = BMP280_OSRS_HUMIDITIY_X(data->oversampling_humid + 1);
+	int ret;
 
 	/*
 	 * Oversampling of humidity must be set before oversampling of
@@ -687,10 +688,10 @@ static const struct bmp280_chip_info bme280_chip_info = {
 
 static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 {
-	int ret;
 	const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
 	unsigned int delay_us;
 	unsigned int ctrl;
+	int ret;
 
 	if (data->use_eoc)
 		reinit_completion(&data->done);
@@ -751,9 +752,9 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 static int bmp180_read_calib(struct bmp280_data *data,
 			     struct bmp180_calib *calib)
 {
+	__be16 buf[BMP180_REG_CALIB_COUNT / 2];
 	int ret;
 	int i;
-	__be16 buf[BMP180_REG_CALIB_COUNT / 2];
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START, buf,
 			       sizeof(buf));
@@ -793,8 +794,8 @@ static int bmp180_read_calib(struct bmp280_data *data,
  */
 static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
 {
-	s32 x1, x2;
 	struct bmp180_calib *calib = &data->calib.bmp180;
+	s32 x1, x2;
 
 	x1 = ((adc_temp - calib->AC6) * calib->AC5) >> 15;
 	x2 = (calib->MC << 11) / (x1 + calib->MD);
@@ -805,8 +806,8 @@ static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
 
 static int bmp180_read_temp(struct bmp280_data *data, int *val)
 {
-	int ret;
 	s32 adc_temp, comp_temp;
+	int ret;
 
 	ret = bmp180_read_adc_temp(data, &adc_temp);
 	if (ret)
@@ -828,9 +829,9 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val)
 
 static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 {
-	int ret;
-	__be32 tmp = 0;
 	u8 oss = data->oversampling_press;
+	__be32 tmp = 0;
+	int ret;
 
 	ret = bmp180_measure(data, BMP180_MEAS_PRESS_X(oss));
 	if (ret)
@@ -852,11 +853,11 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
  */
 static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
 {
+	struct bmp180_calib *calib = &data->calib.bmp180;
+	s32 oss = data->oversampling_press;
 	s32 x1, x2, x3, p;
 	s32 b3, b6;
 	u32 b4, b7;
-	s32 oss = data->oversampling_press;
-	struct bmp180_calib *calib = &data->calib.bmp180;
 
 	b6 = data->t_fine - 4000;
 	x1 = (calib->B2 * (b6 * b6 >> 12)) >> 11;
@@ -883,9 +884,9 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
 static int bmp180_read_press(struct bmp280_data *data,
 			     int *val, int *val2)
 {
-	int ret;
-	s32 adc_press;
 	u32 comp_press;
+	s32 adc_press;
+	int ret;
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
 	ret = bmp180_read_temp(data, NULL);
@@ -990,11 +991,11 @@ int bmp280_common_probe(struct device *dev,
 			const char *name,
 			int irq)
 {
-	int ret;
 	struct iio_dev *indio_dev;
 	struct bmp280_data *data;
-	unsigned int chip_id;
 	struct gpio_desc *gpiod;
+	unsigned int chip_id;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
-- 
2.37.3

