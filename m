Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7588D5F2C21
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiJCIkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiJCIjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:39:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8A4B1E4;
        Mon,  3 Oct 2022 01:14:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d6so1341323lfs.10;
        Mon, 03 Oct 2022 01:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uGqOymZTPODu1DT7zCLwpZ7OKWzDoTi3A3ZW4JY2HpQ=;
        b=ODlsb7qaMLHiFVBycFzCnl6KqnnTGj6CY1nPZlMTlsOCoBUYz2PZ/VZ/M6kHW4Efsm
         u8yeIGQrvnqqe3IAj1DP8iwa2CMO9sP9Wx6Rn3SKQwZRqxg52i7fZjt5fjIgrxUmIXG0
         UtHK03xmzDyJEECDBXTpfbSghzgK73g1bC+l3QW/NJiG+SbTETzWs1vjA9q4M0OOM1FL
         Zl7Tjmuj02Q1lFwB0c3HXyZUuqS1rhKIXBLLWaVvT9Z4if8kxASQScN4HKjh5e50ug5e
         K8c6BeVKzUJEPiC5bi/+uSnbXDAet7lPppANhu9iguag9gQcxAFc0pw+2DAlDKMpTQ2a
         pNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uGqOymZTPODu1DT7zCLwpZ7OKWzDoTi3A3ZW4JY2HpQ=;
        b=34RWoP8PdmMQyViG24LS0M2d4bb6IfK65RI6TeKszQ4XXsFgfRuMLMCNc4Ox08Auqt
         o6fUO4Z3nRa0FolXbB55Wgs4MkJW1Q8nIuSZIxDYlAk6BXpec3KG4/6iTNQVOU2qh4Gb
         WcHmBUgkCRME96k52RhUrH96iGrzu3rTCe2eroNwbIwimXIUK7S1eSv55BiqrdTWtad0
         CTYpJdfLkrHz2lb0agPL3g2NZ4CopzlA/Nuo9byZ39dQSL/n2SE1VkLPSJTGMQFTmowC
         Nq0d5XbaSlFv+XcEW8I0ZtrLUsSUgR90fPHqWus8jcru6PT4BkrVKrWbeBfRIRfJrTLy
         lILw==
X-Gm-Message-State: ACrzQf0CsUMncUJWBwlpgkjM9PaCO9nemk1sUOnGjgSKFaU2oJDGQkmW
        NrKnykSJO0FJ9CI8GZsFgvA=
X-Google-Smtp-Source: AMsMyM7gRibqRc0RvoSwcHROeH07rEWf1sd+p5tst+pMr0Z7aKiYJOkZtekHbXLljIvvdRkho4QqKw==
X-Received: by 2002:a19:5f4b:0:b0:49f:a4b7:3f1c with SMTP id a11-20020a195f4b000000b0049fa4b73f1cmr6602776lfj.333.1664784839682;
        Mon, 03 Oct 2022 01:13:59 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05651c230b00b00261e3856abcsm784643ljb.102.2022.10.03.01.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:13:58 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:13:53 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Mihail Chindris <mihail.chindris@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev
Subject: [RFT PATCH v3 10/10] iio: Don't silently expect attribute types
Message-ID: <63f54787a684eb1232f1c5d275a09c786987fe4a.1664782676.git.mazziesaccount@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qC+KnK0kYbir+/sL"
Content-Disposition: inline
In-Reply-To: <cover.1664782676.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qC+KnK0kYbir+/sL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The iio_triggered_buffer_setup_ext() and the
devm_iio_kfifo_buffer_setup_ext() were changed by
commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_=
attr")
to silently expect that all attributes given in buffer_attrs array are
device-attributes. This expectation was not forced by the API - and some
drivers did register attributes created by IIO_CONST_ATTR().

When using IIO_CONST_ATTRs the added attribute "wrapping" does not copy
the pointer to stored string constant and when the sysfs file is read the
kernel will access to invalid location.

Change the function signatures to expect an array of iio_dev_attrs to
avoid similar errors in the future.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v2 =3D> v3:
split the driver fixes to separate patches for easier back port and
adjust the commit message accordinly.

v1 =3D> v2:
fix also industrialio-buffer-dmaengine.c and cros_ec_sensors_core.c

The fix is only superficially tested by a ROHM/kionix KX022A driver.
Proper testing with real in-tree IIO stuff is _highly_ appreciated.
---
 drivers/iio/accel/adxl367.c                          | 10 +++++-----
 drivers/iio/accel/adxl372.c                          | 10 +++++-----
 drivers/iio/accel/bmc150-accel-core.c                | 12 ++++++------
 drivers/iio/adc/at91-sama5d2_adc.c                   | 12 ++++++------
 drivers/iio/buffer/industrialio-buffer-dmaengine.c   |  4 ++--
 drivers/iio/buffer/industrialio-triggered-buffer.c   |  4 ++--
 drivers/iio/buffer/kfifo_buf.c                       |  2 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c    |  6 +++---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c  |  8 ++++----
 drivers/iio/industrialio-buffer.c                    | 11 +++++++----
 include/linux/iio/buffer_impl.h                      |  2 +-
 include/linux/iio/kfifo_buf.h                        |  3 ++-
 include/linux/iio/triggered_buffer.h                 |  6 +++---
 13 files changed, 47 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 47cddd4e98b2..0922ac0fad9e 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -1193,11 +1193,11 @@ static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
 static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
 		       adxl367_get_fifo_enabled, NULL, 0);
=20
-static const struct attribute *adxl367_fifo_attributes[] =3D {
-	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
-	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
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
index 90e1d726b9c5..c4193286eb05 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1006,11 +1006,11 @@ static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
 static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
 		       adxl372_get_fifo_enabled, NULL, 0);
=20
-static const struct attribute *adxl372_fifo_attributes[] =3D {
-	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
-	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
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
index b4a077944896..110591804b4c 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -933,11 +933,11 @@ static IIO_DEVICE_ATTR(hwfifo_enabled, S_IRUGO,
 static IIO_DEVICE_ATTR(hwfifo_watermark, S_IRUGO,
 		       bmc150_accel_get_fifo_watermark, NULL, 0);
=20
-static const struct attribute *bmc150_accel_fifo_attributes[] =3D {
-	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
-	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
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
index dca014d1108f..f994366b0778 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1863,11 +1863,11 @@ static const struct attribute_group at91_adc_attrib=
ute_group =3D {
 	.attrs =3D at91_adc_attributes,
 };
=20
-static const struct attribute *at91_adc_fifo_attributes[] =3D {
-	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
-	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
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

--qC+KnK0kYbir+/sL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM6mcEACgkQeFA3/03a
ocXbngf/QC4mGoId1VGzuHXdy79xprR/3L52ZPFbeOR+qzxVUSl3dlfQCPKcuJmI
fhJxC991JQT+wTF0VlNuquRojq4QqAZqiqSoakUKnwIzELg65L2G1O7B3m3OujYW
uMHmAjV56HwYXKz1uaHINmXreq4mIuNStsJBIxHgzHTvp+lWfMtuV2JBo6fAC3Xn
1Iuti5Np7fiNG1bHzA7Z7XoQwePUJmfkZMtvblmdWQvy61ZnyrIuc/uTXeAZ+/cy
VhHwPY5dpURQB2r36RaWLc5PDgoxOYuvL6vaosgtJ1kBSeLhwsFrbkDdxaU0TZnr
H5+hRnc7D9HfMZLwbvGk63M8pnd0RQ==
=x7K9
-----END PGP SIGNATURE-----

--qC+KnK0kYbir+/sL--
