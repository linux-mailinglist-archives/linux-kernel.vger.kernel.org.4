Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBC45F1AA9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiJAHoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJAHog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:44:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C97BE02;
        Sat,  1 Oct 2022 00:44:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bu25so9997109lfb.3;
        Sat, 01 Oct 2022 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Zrk8mMOYRvMXykPL6+lWBLlUqqbKyepPjX2K1o0c+68=;
        b=XAirTmxE0Nl0p/bhjlJ/6/H54QUXWo3RNAJ+Di38WmOWAm6U2aPEp7V5ZVhwqDt6Tx
         t5X5OBseQSfRrzR7x96+u2NLXpL9wTd+RPmgDzsyex8ANcmcyx4M8cAE8XKH4CqjFqPJ
         ERU1B/KPawyzth1xFXKkpCvxNAhD8qY+KmP30ngWppoHnR+4ODUsnnXw05zlKH3F/Iat
         xgMqpARqHsrmLfzz0p4+DYxW7nVnzSpnRci0As/PUdXFHeelzOSWqjTruYdXql/f5FX4
         /60HNvsPcUteKLz5IvYW6pTLTFF4NK86+0Nr6HEjdgeCWDUGt3gTpXPT462YpHa9596J
         1Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Zrk8mMOYRvMXykPL6+lWBLlUqqbKyepPjX2K1o0c+68=;
        b=YA+Ng202w1bt5yE49iunzfMtO5zW7cl22bH5CSRHFCMOvPbUI25GeF4XPXfWDPdJMs
         4EUW94yM+MuSj4QCEGHGiqRDaFgFpVCMKAXgrRSiXL5Ym0/D2ywkE4FDyv+wsBB6MBUi
         s2SluWPALVK07nMDhVQDJ4Y5VnvxgMCq9jAgkT7Uw8/Lo0vJhJmOAXXrQ0/VLov9sBpv
         3SQ/+658cvXR5bv4Es6WdhaUlAgHEzXP6nxQFaf/d0xlpvxAxZt0Yp0SXGdvm8QvI+i4
         KAIhOntMRLmQBZ83SOCJiSWpw0j/pPe6ic/GBhiZsQT+MLleGqpcLOttSz0+kor1vbMP
         3GLA==
X-Gm-Message-State: ACrzQf2o2ez3QT5qPi1uUnVIMtIM8FSwBiBE2GbMu2jJIelqFFWQRZr4
        gV8aEezvk8rQfI5U3tCnK1I=
X-Google-Smtp-Source: AMsMyM5H4dcrsYnOJ5jK8XPktSdRIVQiTRa3N7ssRVHGPVSMapRIa2WCLECIho8rBf5CcSMaoQwp7w==
X-Received: by 2002:a05:6512:3da1:b0:49f:1b3d:88b9 with SMTP id k33-20020a0565123da100b0049f1b3d88b9mr4235294lfv.67.1664610270436;
        Sat, 01 Oct 2022 00:44:30 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id bi8-20020a0565120e8800b00497ac35ae1esm667328lfb.85.2022.10.01.00.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 00:44:29 -0700 (PDT)
Date:   Sat, 1 Oct 2022 10:44:23 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Mihail Chindris <mihail.chindris@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev
Subject: [RFT PATCH v2 2/2] iio: Fix unsafe buffer attributes
Message-ID: <614bb5336c2922578da60a43570f42018623557a.1664610071.git.mazziesaccount@gmail.com>
References: <cover.1664610071.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2SAsLLwBOL+UwhiY"
Content-Disposition: inline
In-Reply-To: <cover.1664610071.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2SAsLLwBOL+UwhiY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The iio_triggered_buffer_setup_ext() was changed by
commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_=
attr")
to silently expect that all attributes given in buffer_attrs array are
device-attributes. This expectation was not forced by the API - and some
drivers did register attributes created by IIO_CONST_ATTR().

The added attribute "wrapping" does not copy the pointer to stored
string constant and when the sysfs file is read the kernel will access
to invalid location.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_=
attr")

---

v1 =3D> v2:
fix also industrialio-buffer-dmaengine.c and cros_ec_sensors_core.c

The fix is only superficially tested by a ROHM/kionix KX022A driver.
Proper testing with real in-tree IIO stuff is _highly_ appreciated.
---
 drivers/iio/accel/adxl367.c                    | 16 ++++++++--------
 drivers/iio/accel/adxl372.c                    | 16 ++++++++--------
 drivers/iio/accel/bmc150-accel-core.c          | 18 +++++++++---------
 drivers/iio/adc/at91-sama5d2_adc.c             | 16 ++++++++--------
 .../iio/buffer/industrialio-buffer-dmaengine.c |  4 ++--
 .../iio/buffer/industrialio-triggered-buffer.c |  4 ++--
 drivers/iio/buffer/kfifo_buf.c                 |  2 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c     |  6 +++---
 .../common/hid-sensors/hid-sensor-trigger.c    |  8 ++++----
 drivers/iio/industrialio-buffer.c              | 11 +++++++----
 include/linux/iio/buffer_impl.h                |  2 +-
 include/linux/iio/kfifo_buf.h                  |  3 ++-
 include/linux/iio/triggered_buffer.h           |  6 +++---
 13 files changed, 58 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 47feb375b70b..0922ac0fad9e 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -1185,19 +1185,19 @@ static ssize_t adxl367_get_fifo_watermark(struct de=
vice *dev,
 	return sysfs_emit(buf, "%d\n", fifo_watermark);
 }
=20
-static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
-static IIO_CONST_ATTR(hwfifo_watermark_max,
-		      __stringify(ADXL367_FIFO_MAX_WATERMARK));
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
+			     __stringify(ADXL367_FIFO_MAX_WATERMARK));
 static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
 		       adxl367_get_fifo_watermark, NULL, 0);
 static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
 		       adxl367_get_fifo_enabled, NULL, 0);
=20
-static const struct attribute *adxl367_fifo_attributes[] =3D {
-	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
-	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
-	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
-	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+static const struct iio_dev_attr *adxl367_fifo_attributes[] =3D {
+	&iio_dev_attr_hwfifo_watermark_min,
+	&iio_dev_attr_hwfifo_watermark_max,
+	&iio_dev_attr_hwfifo_watermark,
+	&iio_dev_attr_hwfifo_enabled,
 	NULL,
 };
=20
diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index e3ecbaee61f7..c4193286eb05 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -998,19 +998,19 @@ static ssize_t adxl372_get_fifo_watermark(struct devi=
ce *dev,
 	return sprintf(buf, "%d\n", st->watermark);
 }
=20
-static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
-static IIO_CONST_ATTR(hwfifo_watermark_max,
-		      __stringify(ADXL372_FIFO_SIZE));
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
+			     __stringify(ADXL372_FIFO_SIZE));
 static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
 		       adxl372_get_fifo_watermark, NULL, 0);
 static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
 		       adxl372_get_fifo_enabled, NULL, 0);
=20
-static const struct attribute *adxl372_fifo_attributes[] =3D {
-	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
-	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
-	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
-	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+static const struct iio_dev_attr *adxl372_fifo_attributes[] =3D {
+	&iio_dev_attr_hwfifo_watermark_min,
+	&iio_dev_attr_hwfifo_watermark_max,
+	&iio_dev_attr_hwfifo_watermark,
+	&iio_dev_attr_hwfifo_enabled,
 	NULL,
 };
=20
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc1=
50-accel-core.c
index 57e8a8350cd1..110591804b4c 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -925,19 +925,19 @@ static const struct iio_chan_spec_ext_info bmc150_acc=
el_ext_info[] =3D {
 	{ }
 };
=20
-static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
-static IIO_CONST_ATTR(hwfifo_watermark_max,
-		      __stringify(BMC150_ACCEL_FIFO_LENGTH));
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
+			     __stringify(BMC150_ACCEL_FIFO_LENGTH));
 static IIO_DEVICE_ATTR(hwfifo_enabled, S_IRUGO,
 		       bmc150_accel_get_fifo_state, NULL, 0);
 static IIO_DEVICE_ATTR(hwfifo_watermark, S_IRUGO,
 		       bmc150_accel_get_fifo_watermark, NULL, 0);
=20
-static const struct attribute *bmc150_accel_fifo_attributes[] =3D {
-	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
-	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
-	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
-	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+static const struct iio_dev_attr *bmc150_accel_fifo_attributes[] =3D {
+	&iio_dev_attr_hwfifo_watermark_min,
+	&iio_dev_attr_hwfifo_watermark_max,
+	&iio_dev_attr_hwfifo_watermark,
+	&iio_dev_attr_hwfifo_enabled,
 	NULL,
 };
=20
@@ -1665,7 +1665,7 @@ int bmc150_accel_core_probe(struct device *dev, struc=
t regmap *regmap, int irq,
 			    enum bmc150_type type, const char *name,
 			    bool block_supported)
 {
-	const struct attribute **fifo_attrs;
+	const struct iio_dev_attr **fifo_attrs;
 	struct bmc150_accel_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama=
5d2_adc.c
index 279430c1d88c..f994366b0778 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1846,8 +1846,8 @@ static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
 static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
 		       at91_adc_get_watermark, NULL, 0);
=20
-static IIO_CONST_ATTR(hwfifo_watermark_min, "2");
-static IIO_CONST_ATTR(hwfifo_watermark_max, AT91_HWFIFO_MAX_SIZE_STR);
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "2");
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max, AT91_HWFIFO_MAX_SIZE_ST=
R);
=20
 static IIO_CONST_ATTR(oversampling_ratio_available,
 		      __stringify(AT91_OSR_1SAMPLES) " "
@@ -1863,11 +1863,11 @@ static const struct attribute_group at91_adc_attrib=
ute_group =3D {
 	.attrs =3D at91_adc_attributes,
 };
=20
-static const struct attribute *at91_adc_fifo_attributes[] =3D {
-	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
-	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
-	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
-	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+static const struct iio_dev_attr *at91_adc_fifo_attributes[] =3D {
+	&iio_dev_attr_hwfifo_watermark_min,
+	&iio_dev_attr_hwfifo_watermark_max,
+	&iio_dev_attr_hwfifo_watermark,
+	&iio_dev_attr_hwfifo_enabled,
 	NULL,
 };
=20
@@ -1884,7 +1884,7 @@ static int at91_adc_buffer_and_trigger_init(struct de=
vice *dev,
 					    struct iio_dev *indio)
 {
 	struct at91_adc_state *st =3D iio_priv(indio);
-	const struct attribute **fifo_attrs;
+	const struct iio_dev_attr **fifo_attrs;
 	int ret;
=20
 	if (st->selected_trig->hw_trig)
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/i=
io/buffer/industrialio-buffer-dmaengine.c
index f744b62a636a..5f85ba38e6f6 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -142,8 +142,8 @@ static ssize_t iio_dmaengine_buffer_get_length_align(st=
ruct device *dev,
 static IIO_DEVICE_ATTR(length_align_bytes, 0444,
 		       iio_dmaengine_buffer_get_length_align, NULL, 0);
=20
-static const struct attribute *iio_dmaengine_buffer_attrs[] =3D {
-	&iio_dev_attr_length_align_bytes.dev_attr.attr,
+static const struct iio_dev_attr *iio_dmaengine_buffer_attrs[] =3D {
+	&iio_dev_attr_length_align_bytes,
 	NULL,
 };
=20
diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/i=
io/buffer/industrialio-triggered-buffer.c
index 8d4fc97d1005..c7671b1f5ead 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -41,7 +41,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_=
dev,
 	irqreturn_t (*thread)(int irq, void *p),
 	enum iio_buffer_direction direction,
 	const struct iio_buffer_setup_ops *setup_ops,
-	const struct attribute **buffer_attrs)
+	const struct iio_dev_attr **buffer_attrs)
 {
 	struct iio_buffer *buffer;
 	int ret;
@@ -110,7 +110,7 @@ int devm_iio_triggered_buffer_setup_ext(struct device *=
dev,
 					irqreturn_t (*thread)(int irq, void *p),
 					enum iio_buffer_direction direction,
 					const struct iio_buffer_setup_ops *ops,
-					const struct attribute **buffer_attrs)
+					const struct iio_dev_attr **buffer_attrs)
 {
 	int ret;
=20
diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 35d8b4077376..05b285f0eb22 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -270,7 +270,7 @@ static struct iio_buffer *devm_iio_kfifo_allocate(struc=
t device *dev)
 int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
 				    struct iio_dev *indio_dev,
 				    const struct iio_buffer_setup_ops *setup_ops,
-				    const struct attribute **buffer_attrs)
+				    const struct iio_dev_attr **buffer_attrs)
 {
 	struct iio_buffer *buffer;
=20
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/dr=
ivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 05a28d353e34..943e9e14d1e9 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -172,9 +172,9 @@ static ssize_t hwfifo_watermark_max_show(struct device =
*dev,
=20
 static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
=20
-static const struct attribute *cros_ec_sensor_fifo_attributes[] =3D {
-	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
-	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
+static const struct iio_dev_attr *cros_ec_sensor_fifo_attributes[] =3D {
+	&iio_dev_attr_hwfifo_timeout,
+	&iio_dev_attr_hwfifo_watermark_max,
 	NULL,
 };
=20
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/=
iio/common/hid-sensors/hid-sensor-trigger.c
index 1151434038d4..ad8910e6ad59 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -75,9 +75,9 @@ static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
 static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
 		       _hid_sensor_get_fifo_state, NULL, 0);
=20
-static const struct attribute *hid_sensor_fifo_attributes[] =3D {
-	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
-	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+static const struct iio_dev_attr *hid_sensor_fifo_attributes[] =3D {
+	&iio_dev_attr_hwfifo_timeout,
+	&iio_dev_attr_hwfifo_enabled,
 	NULL,
 };
=20
@@ -231,7 +231,7 @@ static const struct iio_trigger_ops hid_sensor_trigger_=
ops =3D {
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 				struct hid_sensor_common *attrb)
 {
-	const struct attribute **fifo_attrs;
+	const struct iio_dev_attr **fifo_attrs;
 	int ret;
 	struct iio_trigger *trig;
=20
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-b=
uffer.c
index acc2b6c05d57..cc7ebafae571 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1599,6 +1599,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct i=
io_buffer *buffer,
 {
 	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
 	struct iio_dev_attr *p;
+	const struct iio_dev_attr *id_attr;
 	struct attribute **attr;
 	int ret, i, attrn, scan_el_attrcount, buffer_attrcount;
 	const struct iio_chan_spec *channels;
@@ -1608,6 +1609,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct i=
io_buffer *buffer,
 		while (buffer->attrs[buffer_attrcount] !=3D NULL)
 			buffer_attrcount++;
 	}
+	buffer_attrcount +=3D ARRAY_SIZE(iio_buffer_attrs);
=20
 	scan_el_attrcount =3D 0;
 	INIT_LIST_HEAD(&buffer->buffer_attr_list);
@@ -1650,7 +1652,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct i=
io_buffer *buffer,
 		}
 	}
=20
-	attrn =3D buffer_attrcount + scan_el_attrcount + ARRAY_SIZE(iio_buffer_at=
trs);
+	attrn =3D buffer_attrcount + scan_el_attrcount;
 	attr =3D kcalloc(attrn + 1, sizeof(*attr), GFP_KERNEL);
 	if (!attr) {
 		ret =3D -ENOMEM;
@@ -1665,10 +1667,11 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct=
 iio_buffer *buffer,
 		attr[2] =3D &dev_attr_watermark_ro.attr;
=20
 	if (buffer->attrs)
-		memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
-		       sizeof(struct attribute *) * buffer_attrcount);
+		for (i =3D 0, id_attr =3D buffer->attrs[i];
+		     (id_attr =3D buffer->attrs[i]); i++)
+			attr[ARRAY_SIZE(iio_buffer_attrs) + i] =3D
+				(struct attribute *)&id_attr->dev_attr.attr;
=20
-	buffer_attrcount +=3D ARRAY_SIZE(iio_buffer_attrs);
 	buffer->buffer_group.attrs =3D attr;
=20
 	for (i =3D 0; i < buffer_attrcount; i++) {
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_imp=
l.h
index e2ca8ea23e19..89c3fd7c29ca 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -123,7 +123,7 @@ struct iio_buffer {
 	struct attribute_group buffer_group;
=20
 	/* @attrs: Standard attributes of the buffer. */
-	const struct attribute **attrs;
+	const struct iio_dev_attr **attrs;
=20
 	/* @demux_bounce: Buffer for doing gather from incoming scan. */
 	void *demux_bounce;
diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
index 8a83fb58232d..22874da0c8be 100644
--- a/include/linux/iio/kfifo_buf.h
+++ b/include/linux/iio/kfifo_buf.h
@@ -5,6 +5,7 @@
 struct iio_buffer;
 struct iio_buffer_setup_ops;
 struct iio_dev;
+struct iio_dev_attr;
 struct device;
=20
 struct iio_buffer *iio_kfifo_allocate(void);
@@ -13,7 +14,7 @@ void iio_kfifo_free(struct iio_buffer *r);
 int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
 				    struct iio_dev *indio_dev,
 				    const struct iio_buffer_setup_ops *setup_ops,
-				    const struct attribute **buffer_attrs);
+				    const struct iio_dev_attr **buffer_attrs);
=20
 #define devm_iio_kfifo_buffer_setup(dev, indio_dev, setup_ops)	\
 	devm_iio_kfifo_buffer_setup_ext((dev), (indio_dev), (setup_ops), NULL)
diff --git a/include/linux/iio/triggered_buffer.h b/include/linux/iio/trigg=
ered_buffer.h
index 7490b05fc5b2..29e1fe146879 100644
--- a/include/linux/iio/triggered_buffer.h
+++ b/include/linux/iio/triggered_buffer.h
@@ -5,8 +5,8 @@
 #include <linux/iio/buffer.h>
 #include <linux/interrupt.h>
=20
-struct attribute;
 struct iio_dev;
+struct iio_dev_attr;
 struct iio_buffer_setup_ops;
=20
 int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
@@ -14,7 +14,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_=
dev,
 	irqreturn_t (*thread)(int irq, void *p),
 	enum iio_buffer_direction direction,
 	const struct iio_buffer_setup_ops *setup_ops,
-	const struct attribute **buffer_attrs);
+	const struct iio_dev_attr **buffer_attrs);
 void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev);
=20
 #define iio_triggered_buffer_setup(indio_dev, h, thread, setup_ops)		\
@@ -28,7 +28,7 @@ int devm_iio_triggered_buffer_setup_ext(struct device *de=
v,
 					irqreturn_t (*thread)(int irq, void *p),
 					enum iio_buffer_direction direction,
 					const struct iio_buffer_setup_ops *ops,
-					const struct attribute **buffer_attrs);
+					const struct iio_dev_attr **buffer_attrs);
=20
 #define devm_iio_triggered_buffer_setup(dev, indio_dev, h, thread, setup_o=
ps)	\
 	devm_iio_triggered_buffer_setup_ext((dev), (indio_dev), (h), (thread),	\
--=20
2.37.3


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--2SAsLLwBOL+UwhiY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM379cACgkQeFA3/03a
ocU/YAf9E+xmD5+qRvjEsmOUMLyARFB4REr9574wP9aOUzdYIC2ma794t+klBUWE
4wT3Mq/DtBhquPOV0Sd0MevTkM057FKRcQ9tpKb3J7ROlXtMoL+EL03Lb3sudMm5
orN7CfP6UBda/8zrED2JmCqpdQQp469Pbvgsto6x/IgbC1AS6uHMeOz6aOwGrhtc
s4x96o+J/o/hNrRaG9pNhnk9/yYIGFdtznVDIu0Apfniviq4nZnkyZlRUQx2sAoq
REw6cahpmbAsh4EX904nuOEJf+OitBnGh0FUDjgLQOvXpURirC6BPRIUQHivLhcT
NxTab75Tax9NmpTAYjmc8mIYel8T+g==
=hyxq
-----END PGP SIGNATURE-----

--2SAsLLwBOL+UwhiY--
