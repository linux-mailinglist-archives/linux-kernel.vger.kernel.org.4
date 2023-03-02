Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BD26A808D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCBK7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCBK7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:59:22 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66362B286;
        Thu,  2 Mar 2023 02:59:06 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f18so21598739lfa.3;
        Thu, 02 Mar 2023 02:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGST/9zr9Lr5RVfKAgpWh8osKpQEc/Z/5EHWh8AWt6c=;
        b=jFe4EVYl9GbE28tdme2B0KV2jzbu4NBW38aHcTEDPxp7gRqq+xm7dXi0SWCt4dAxzd
         vVzDzM5gyhoy62WLrdMYF4Vp90yoVE7QxQ78GKKdHML3WOgEb9zUTwX+G2U3MIBAOWna
         2Zvgs4TRbL/3zt3ELMyYTUcCxuDbzMnyszuR96GaotBeC8coRsPUGSi8ME/LouCpeWst
         ioYB97y1vDLEl6SkwqTLGIRb7Vb9SJlCf9bGvoa2ibSsKjJQm2w3Le+61W+0t5RfTbqL
         RBpSVKvpjXGMEQ1C3JZH4lY54ynQgJkdS3uw1/C04QqYQokJPrTAJLn2Te3OA8/FRzzA
         9Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGST/9zr9Lr5RVfKAgpWh8osKpQEc/Z/5EHWh8AWt6c=;
        b=Z/Alv+3WNfvWO6t/rIi+sYpGQel5c5jO/k+OPu/yzOQGc9znlhNJKqY6uKsAHfTu9Z
         OnWnmCD62VVbc9sKECLK10qLZ5Qat6MnrsshbmfvEnppMlko6I9VPTYPcrPGaBj0KXNe
         1wvm5PtHrWqMTYsurd2EX+f+AIIFSxxpdE1/9xTrlkuk90ptvsgI5lc+i/PL37oUK7f0
         1YguLN+k5xiu/V2Of3x9USM/5/4+/3q3DqbGYD7gmtKtd/SOUbuf/1PyLTetET7hrs0o
         IcBEBK9LE/P+2BGgVV/i/EUL5w0B3JrPRmPhIJSLFRouvAmgVjzb3dmc/gSYyIvQB00P
         9JQw==
X-Gm-Message-State: AO0yUKVJuTak8D2EsoGYctIYijHFjjp83ybAoYNSquAecYTNlyTjYSNV
        ZaQeYx89lEktPx1RxG+iqfQ=
X-Google-Smtp-Source: AK7set93FOvOimelUVKGDZGLDIn2lThU7mFN6kdwhh9EvkPO/mk10WJFP2UVFUTrUwzIPJCBGFC1GQ==
X-Received: by 2002:ac2:5dfb:0:b0:4cb:449a:31f8 with SMTP id z27-20020ac25dfb000000b004cb449a31f8mr2614653lfq.35.1677754744636;
        Thu, 02 Mar 2023 02:59:04 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id q25-20020ac25299000000b004e048852377sm1576795lfm.263.2023.03.02.02.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 02:59:03 -0800 (PST)
Date:   Thu, 2 Mar 2023 12:58:59 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qd9ydqrm8qc3FzX3"
Content-Disposition: inline
In-Reply-To: <cover.1677750859.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qd9ydqrm8qc3FzX3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diodes
capable of detecting a very wide range of illuminance. Typical application
is adjusting LCD and backlight power of TVs and mobile phones.

Add initial  support for the ROHM BU27034 ambient light sensor.

NOTE:
	- Driver exposes 4 channels. One IIO_LIGHT channel providing the
	  calculated lux values based on measured data from diodes #0 and
	  #1. Additionally 3 IIO_INTENSITY channels are emitting the raw
	  register data from all diodes for more intense user-space
	  computations.
	- Sensor has adjustible GAIN values ranging from 1x to 4096x.
	- Sensor has adjustible measurement times 5, 55, 100, 200 and
	  400 mS. Driver does not support 5 mS which has special
	  limitations.
	- Driver exposes standard 'scale' adjustment which is
	  implemented by:
		1) Trying to adjust only the GAIN
		2) If GAIN adjustment only can't provide requested
		   scale, adjusting both the time and the gain is
		   attempted.
	- Driver exposes writable INT_TIME property which can be used
	  for adjusting the measurement time. Time adjustment will also
	  cause the driver to adjust the GAIN so that the overall scale
	  is not changed.
	- Runtime PM is not implemented.
	- Driver starts the measurement on the background when it is
	  probed. This improves the respnse time to read-requests
	  compared to starting the read only when data is requested.
	  When the most accurate 400 mS measurement time is used, data reads
	  would last quite long if measurement was started only on
	  demand. This, however, is not appealing for users who would
	  prefere power saving over measurement response time.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Changes since RFCv1
- (really) protect read-only registers
- fix get and set gain
- buffered mode
- Protect the whole sequences including meas_en/meas_dis to avoid messing
  up the enable / disable order
- typofixes / doc improvements
- change dropped GAIN_SCALE_ITIME_MS() to GAIN_SCALE_ITIME_US()
- use more accurate scale for lux channel (milli lux)
- provide available scales / integration times (using helpers).
- adapt to renamed iio-gts-helpers.h file
- bu27034 - longer lines in Kconfig
- Drop bu27034_meas_en and bu27034_meas_dis wrappers.
- Change device-name from bu27034-als to bu27034
---
 drivers/iio/light/Kconfig        |   12 +
 drivers/iio/light/Makefile       |    1 +
 drivers/iio/light/rohm-bu27034.c | 1491 ++++++++++++++++++++++++++++++
 3 files changed, 1504 insertions(+)
 create mode 100644 drivers/iio/light/rohm-bu27034.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 671d84f98c56..14e03732f57d 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -292,6 +292,18 @@ config JSA1212
 	  To compile this driver as a module, choose M here:
 	  the module will be called jsa1212.
=20
+config ROHM_BU27034
+	tristate "ROHM BU27034 ambient light sensor"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_GTS_HELPER
+	help
+	  Enable support for the ROHM BU27034 ambient light sensor. ROHM BU27034
+	  is an ambient light sesnor with 3 channels and 3 photo diodes capable
+	  of detecting a very wide range of illuminance.
+	  Typical application is adjusting LCD and backlight power of TVs and
+	  mobile phones.
+
 config RPR0521
 	tristate "ROHM RPR0521 ALS and proximity sensor driver"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 82d14ebd3c11..e81c5ce60ccd 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_MAX44009)		+=3D max44009.o
 obj-$(CONFIG_NOA1305)		+=3D noa1305.o
 obj-$(CONFIG_OPT3001)		+=3D opt3001.o
 obj-$(CONFIG_PA12203001)	+=3D pa12203001.o
+obj-$(CONFIG_ROHM_BU27034)	+=3D rohm-bu27034.o
 obj-$(CONFIG_RPR0521)		+=3D rpr0521.o
 obj-$(CONFIG_SENSORS_TSL2563)	+=3D tsl2563.o
 obj-$(CONFIG_SI1133)		+=3D si1133.o
diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
new file mode 100644
index 000000000000..b8ca29af22e7
--- /dev/null
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -0,0 +1,1491 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * BU27034 ROHM Ambient Light Sensor
+ *
+ * Copyright (c) 2023, ROHM Semiconductor.
+ * https://fscdn.rohm.com/en/products/databook/datasheet/ic/sensor/light/b=
u27034nuc-e.pdf
+ */
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
+
+#include "iio-gts-helper.h"
+
+#define BU27034_REG_SYSTEM_CONTROL	0x40
+#define BU27034_MASK_SW_RESET		BIT(7)
+#define BU27034_MASK_PART_ID		GENMASK(5, 0)
+#define BU27034_ID			0x19
+#define BU27034_REG_MODE_CONTROL1	0x41
+#define BU27034_MASK_MEAS_MODE		GENMASK(2, 0)
+
+#define BU27034_REG_MODE_CONTROL2	0x42
+#define BU27034_MASK_D01_GAIN		GENMASK(7, 3)
+#define BU27034_SHIFT_D01_GAIN		3
+#define BU27034_MASK_D2_GAIN_HI		GENMASK(7, 6)
+#define BU27034_MASK_D2_GAIN_LO		GENMASK(2, 0)
+#define BU27034_SHIFT_D2_GAIN		3
+
+#define BU27034_REG_MODE_CONTROL3	0x43
+#define BU27034_REG_MODE_CONTROL4	0x44
+#define BU27034_MASK_MEAS_EN		BIT(0)
+#define BU27034_MASK_VALID		BIT(7)
+#define BU27034_REG_DATA0_LO		0x50
+#define BU27034_REG_DATA1_LO		0x52
+#define BU27034_REG_DATA2_LO		0x54
+#define BU27034_REG_DATA2_HI		0x55
+#define BU27034_REG_MANUFACTURER_ID	0x92
+#define BU27034_REG_MAX BU27034_REG_MANUFACTURER_ID
+
+/*
+ * The BU27034 does not have interrupt or any other mechanism of triggering
+ * the data read when measurement has finished. Hence we poll the VALID bi=
t in
+ * a thread. We will try to wake the thread BU27034_MEAS_WAIT_PREMATURE_MS
+ * milliseconds before the expected sampling time to prevent the drifting.=
 Eg,
+ * If we constantly wake up a bit too late we would eventually skip a samp=
le.
+ * And because the sleep can't wake up _exactly_ at given time this would =
be
+ * inevitable even if the sensor clock would be perfectly phase-locked to =
CPU
+ * clock - which we can't say is the case.
+ *
+ * This is still fragile. No matter how big advance do we have, we will st=
ill
+ * risk of losing a sample because things can in a rainy-day skenario be
+ * delayed a lot. Yet, more we reserve the time for polling, more we also =
lose
+ * the performance by spending cycles polling the register. So, selecting =
this
+ * value is a balancing dance between severity of wasting CPU time and sev=
erity
+ * of losing samples.
+ *
+ * In most cases losing the samples is not _that_ crucial because light le=
vels
+ * tend to change slowly.
+ */
+#define BU27034_MEAS_WAIT_PREMATURE_MS	5
+#define BU27034_DATA_WAIT_TIME_US	1000
+#define BU27034_TOTAL_DATA_WAIT_TIME_US (BU27034_MEAS_WAIT_PREMATURE_MS * =
1000)
+
+
+enum {
+	BU27034_CHAN_ALS,
+	BU27034_CHAN_DATA0,
+	BU27034_CHAN_DATA1,
+	BU27034_CHAN_DATA2,
+	BU27034_NUM_CHANS
+};
+
+static const unsigned long bu27034_scan_masks[] =3D {
+	BIT(BU27034_CHAN_ALS) | BIT(BU27034_CHAN_DATA0) |
+	BIT(BU27034_CHAN_DATA1) | BIT(BU27034_CHAN_DATA2), 0
+};
+
+/*
+ * Available scales with gain 1x - 4096x, timings 55, 100, 200, 400 mS
+ * Time impacts to gain: 1x, 2x, 4x, 8x.
+ *
+ * =3D> Max total gain is HWGAIN * gain by integration time (8 * 4096) =3D=
 32768
+ *
+ * Using NANO precision for scale we must use scale 64x corresponding gain=
 1x
+ * to avoid precision loss. (32x would result scale 976 562.5(nanos).
+ */
+#define BU27034_SCALE_1X	64
+
+#define BU27034_GSEL_1X		0x00
+#define BU27034_GSEL_4X		0x08
+#define BU27034_GSEL_16X	0x0a
+#define BU27034_GSEL_32X	0x0b
+#define BU27034_GSEL_64X	0x0c
+#define BU27034_GSEL_256X	0x18
+#define BU27034_GSEL_512X	0x19
+#define BU27034_GSEL_1024X	0x1a
+#define BU27034_GSEL_2048X	0x1b
+#define BU27034_GSEL_4096X	0x1c
+
+/* Available gain settings */
+static const struct iio_gain_sel_pair bu27034_gains[] =3D {
+	GAIN_SCALE_GAIN(1, BU27034_GSEL_1X),
+	GAIN_SCALE_GAIN(4, BU27034_GSEL_4X),
+	GAIN_SCALE_GAIN(16, BU27034_GSEL_16X),
+	GAIN_SCALE_GAIN(32, BU27034_GSEL_32X),
+	GAIN_SCALE_GAIN(64, BU27034_GSEL_64X),
+	GAIN_SCALE_GAIN(256, BU27034_GSEL_256X),
+	GAIN_SCALE_GAIN(512, BU27034_GSEL_512X),
+	GAIN_SCALE_GAIN(1024, BU27034_GSEL_1024X),
+	GAIN_SCALE_GAIN(2048, BU27034_GSEL_2048X),
+	GAIN_SCALE_GAIN(4096, BU27034_GSEL_4096X),
+};
+
+/*
+ * The IC has 5 modes for sampling time. 5 mS mode is exceptional as it li=
mits
+ * the data collection to data0-channel only and cuts the supported range =
to
+ * 10 bit. It is not supported by the driver.
+ *
+ * "normal" modes are 55, 100, 200 and 400 mS modes - which do have direct
+ * multiplying impact to the register values (similar to gain).
+ *
+ * This means that if meas-mode is changed for example from 400 =3D> 200,
+ * the scale is doubled. Eg, time impact to total gain is x1, x2, x4, x8.
+ */
+#define BU27034_MEAS_MODE_100MS		0
+#define BU27034_MEAS_MODE_55MS		1
+#define BU27034_MEAS_MODE_200MS		2
+#define BU27034_MEAS_MODE_400MS		4
+
+static const struct iio_itime_sel_mul bu27034_itimes[] =3D {
+	GAIN_SCALE_ITIME_US(400000, BU27034_MEAS_MODE_400MS, 8),
+	GAIN_SCALE_ITIME_US(200000, BU27034_MEAS_MODE_200MS, 4),
+	GAIN_SCALE_ITIME_US(100000, BU27034_MEAS_MODE_100MS, 2),
+	GAIN_SCALE_ITIME_US(50000, BU27034_MEAS_MODE_55MS, 1),
+};
+
+#define BU27034_CHAN_DATA(_name, _ch2)					\
+{									\
+	.type =3D IIO_INTENSITY,						\
+	.channel =3D BU27034_CHAN_##_name,				\
+	.channel2 =3D (_ch2),						\
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
+			      BIT(IIO_CHAN_INFO_SCALE),			\
+	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),	\
+	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME),		\
+	.info_mask_shared_by_all_available =3D				\
+					BIT(IIO_CHAN_INFO_INT_TIME),	\
+	.address =3D BU27034_REG_##_name##_LO,				\
+	.scan_index =3D BU27034_CHAN_##_name,				\
+	.scan_type =3D {							\
+		.sign =3D 'u',						\
+		.realbits =3D 16,						\
+		.storagebits =3D 16,					\
+		.endianness =3D IIO_LE,					\
+	},								\
+	.indexed =3D 1							\
+}
+
+static const struct iio_chan_spec bu27034_channels[] =3D {
+	{
+		.type =3D IIO_LIGHT,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.channel =3D BU27034_CHAN_ALS,
+		.scan_index =3D BU27034_CHAN_ALS,
+		.scan_type =3D {
+			.sign =3D 'u',
+			.realbits =3D 32,
+			.storagebits =3D 32,
+			.endianness =3D IIO_CPU,
+		},
+	},
+	/*
+	 * The BU27034 DATA0 and DATA1 channels are both on the visible light
+	 * area (mostly). The data0 sensitivity peaks at 500nm, DATA1 at 600nm.
+	 * These wave lengths are pretty much on the border of colours making
+	 * these a poor candidates for R/G/B standardization. Hence they're both
+	 * marked as clear channels
+	 */
+	BU27034_CHAN_DATA(DATA0, IIO_MOD_LIGHT_CLEAR),
+	BU27034_CHAN_DATA(DATA1, IIO_MOD_LIGHT_CLEAR),
+	BU27034_CHAN_DATA(DATA2, IIO_MOD_LIGHT_IR),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+struct bu27034_data {
+	struct regmap *regmap;
+	struct device *dev;
+	/*
+	 * Protect gain and time during scale adjustment and data reading.
+	 * Protect measurement enabling/disabling.
+	 */
+	struct mutex mutex;
+	struct iio_gts gts;
+	struct task_struct *task;
+	__le16 raw[3];
+	struct {
+		u32 lux;
+		__le16 channels[3];
+		s64 ts __aligned(8);
+	} scan;
+};
+
+struct bu27034_result {
+	u16 ch0;
+	u16 ch1;
+	u16 ch2;
+};
+
+static const struct regmap_range bu27034_volatile_ranges[] =3D {
+	{
+		.range_min =3D BU27034_REG_MODE_CONTROL4,
+		.range_max =3D BU27034_REG_MODE_CONTROL4,
+	}, {
+		.range_min =3D BU27034_REG_DATA0_LO,
+		.range_max =3D BU27034_REG_DATA2_HI,
+	},
+};
+
+static const struct regmap_access_table bu27034_volatile_regs =3D {
+	.yes_ranges =3D &bu27034_volatile_ranges[0],
+	.n_yes_ranges =3D ARRAY_SIZE(bu27034_volatile_ranges),
+};
+
+static const struct regmap_range bu27034_read_only_ranges[] =3D {
+	{
+		.range_min =3D BU27034_REG_DATA0_LO,
+		.range_max =3D BU27034_REG_DATA2_HI,
+	}, {
+		.range_min =3D BU27034_REG_MANUFACTURER_ID,
+		.range_max =3D BU27034_REG_MANUFACTURER_ID,
+	}
+};
+
+static const struct regmap_access_table bu27034_ro_regs =3D {
+	.no_ranges =3D &bu27034_read_only_ranges[0],
+	.n_no_ranges =3D ARRAY_SIZE(bu27034_read_only_ranges),
+};
+
+static const struct regmap_config bu27034_regmap =3D {
+	.reg_bits	=3D 8,
+	.val_bits	=3D 8,
+
+	.max_register	=3D BU27034_REG_MAX,
+	.cache_type	=3D REGCACHE_RBTREE,
+	.volatile_table =3D &bu27034_volatile_regs,
+	.wr_table	=3D &bu27034_ro_regs,
+};
+
+static int bu27034_validate_int_time(struct bu27034_data *data, int time_u=
s)
+{
+	/*
+	 * The BU27034 has 55 mS integration time which is in the vendor tests
+	 * handled as 50 mS in all of the internal computations. We keep same
+	 * approach here.
+	 */
+	if (time_us =3D=3D 55000)
+		return 50000;
+
+	if (iio_gts_valid_time(&data->gts, time_us))
+		return time_us;
+
+	return -EINVAL;
+}
+
+struct bu27034_gain_check {
+	int old_gain;
+	int new_gain;
+	int chan;
+};
+
+static int bu27034_get_gain_sel(struct bu27034_data *data, int chan)
+{
+	int ret, val;
+
+	switch (chan) {
+	case BU27034_CHAN_DATA0:
+	case BU27034_CHAN_DATA1:
+	{
+		int reg[] =3D {
+			[BU27034_CHAN_DATA0] =3D BU27034_REG_MODE_CONTROL2,
+			[BU27034_CHAN_DATA1] =3D BU27034_REG_MODE_CONTROL3,
+		};
+		ret =3D regmap_read(data->regmap, reg[chan], &val);
+		if (ret)
+			return ret;
+
+		val &=3D BU27034_MASK_D01_GAIN;
+		return val >> BU27034_SHIFT_D01_GAIN;
+	}
+	case BU27034_CHAN_DATA2:
+		ret =3D regmap_read(data->regmap, BU27034_REG_MODE_CONTROL2, &val);
+		if (ret)
+			return ret;
+
+		return (val & BU27034_MASK_D2_GAIN_HI) >> BU27034_SHIFT_D2_GAIN
+		       | (val & BU27034_MASK_D2_GAIN_LO);
+	}
+
+	return -EINVAL;
+}
+
+static int bu27034_get_gain(struct bu27034_data *data, int chan, int *gain)
+{
+	int ret, sel;
+
+	ret =3D bu27034_get_gain_sel(data, chan);
+	if (ret < 0)
+		return ret;
+
+	sel =3D ret;
+
+	ret =3D iio_gts_find_gain_by_sel(&data->gts, sel);
+	if (ret < 0) {
+		dev_err(data->dev, "chan %u: unknown gain value 0x%x\n", chan,
+			sel);
+
+		return ret;
+	}
+
+	*gain =3D ret;
+
+	return 0;
+}
+
+static int bu27034_get_int_time(struct bu27034_data *data)
+{
+	int ret, sel;
+
+	ret =3D regmap_read(data->regmap, BU27034_REG_MODE_CONTROL1, &sel);
+	if (ret)
+		return ret;
+
+	return iio_gts_find_int_time_by_sel(&data->gts,
+					    sel & BU27034_MASK_MEAS_MODE);
+}
+
+static int _bu27034_get_scale(struct bu27034_data *data, int channel, int =
*val,
+			      int *val2)
+{
+	int gain, ret;
+
+	ret =3D bu27034_get_gain(data, channel, &gain);
+	if (ret)
+		return ret;
+
+	ret =3D bu27034_get_int_time(data);
+	if (ret < 0)
+		return ret;
+
+	return iio_gts_get_scale(&data->gts, gain, ret, val, val2);
+}
+
+static int bu27034_get_scale(struct bu27034_data *data, int channel, int *=
val,
+			      int *val2)
+{
+	int ret;
+
+	if (channel =3D=3D BU27034_CHAN_ALS) {
+		*val =3D 0;
+		*val2 =3D 1000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	mutex_lock(&data->mutex);
+	ret =3D _bu27034_get_scale(data, channel, val, val2);
+	mutex_unlock(&data->mutex);
+	if (!ret)
+		return IIO_VAL_INT_PLUS_NANO;
+
+	return ret;
+}
+
+/* Caller should hold the lock to protect lux reading */
+static int bu27034_write_gain_sel(struct bu27034_data *data, int chan, int=
 sel)
+{
+	static const int reg[] =3D {
+		[BU27034_CHAN_DATA0] =3D BU27034_REG_MODE_CONTROL2,
+		[BU27034_CHAN_DATA1] =3D BU27034_REG_MODE_CONTROL3,
+		[BU27034_CHAN_DATA2] =3D BU27034_REG_MODE_CONTROL2
+	};
+	int mask;
+
+	if (chan < BU27034_CHAN_DATA0 || chan > BU27034_CHAN_DATA2)
+		return -EINVAL;
+
+	if (chan =3D=3D BU27034_CHAN_DATA0 || chan =3D=3D BU27034_CHAN_DATA1) {
+		sel <<=3D BU27034_SHIFT_D01_GAIN;
+		mask =3D BU27034_MASK_D01_GAIN;
+	} else {
+		/*
+		 * We don't allow setting high bits for DATA2 gain because
+		 * that impacts to DATA0 as well.
+		 */
+		mask =3D  BU27034_MASK_D2_GAIN_LO;
+	}
+
+	return regmap_update_bits(data->regmap, reg[chan], mask, sel);
+}
+
+static int bu27034_set_gain(struct bu27034_data *data, int chan, int gain)
+{
+	int ret;
+
+	ret =3D iio_gts_find_sel_by_gain(&data->gts, gain);
+	if (ret < 0)
+		return ret;
+
+	return bu27034_write_gain_sel(data, chan, ret);
+}
+
+/* Caller should hold the lock to protect data->int_time */
+static int bu27034_set_int_time(struct bu27034_data *data, int time)
+{
+	int ret;
+
+	ret =3D iio_gts_find_sel_by_int_time(&data->gts, time);
+	if (ret < 0)
+		return ret;
+
+	return regmap_update_bits(data->regmap, BU27034_REG_MODE_CONTROL1,
+				 BU27034_MASK_MEAS_MODE, ret);
+
+	return time;
+}
+
+/*
+ * We try to change the time in such way that the scale is maintained for
+ * given channels by adjusting gain so that it compensates the time change.
+ */
+static int bu27034_try_set_int_time(struct bu27034_data *data, int time_us)
+{
+	int ret, int_time_old, int_time_new, i;
+	struct bu27034_gain_check gains[3] =3D {
+		{ .chan =3D BU27034_CHAN_DATA0, },
+		{ .chan =3D BU27034_CHAN_DATA1, },
+		{ .chan =3D BU27034_CHAN_DATA2 }
+	};
+	int numg =3D ARRAY_SIZE(gains);
+
+	mutex_lock(&data->mutex);
+	ret =3D bu27034_get_int_time(data);
+	if (ret < 0)
+		goto unlock_out;
+
+	int_time_old =3D ret;
+
+	ret =3D bu27034_validate_int_time(data, time_us);
+	if (ret < 0) {
+		dev_err(data->dev, "Unsupported integration time %u\n",
+			time_us);
+
+		goto unlock_out;
+	}
+
+	int_time_new =3D ret;
+
+	if (int_time_new =3D=3D int_time_old) {
+		ret =3D 0;
+		goto unlock_out;
+	}
+
+	for (i =3D 0; i < numg; i++) {
+		ret =3D bu27034_get_gain(data, gains[i].chan,
+				       &gains[i].old_gain);
+		if (ret)
+			goto unlock_out;
+
+		gains[i].new_gain =3D gains[i].old_gain * int_time_old /
+				    int_time_new;
+
+		if (!iio_gts_valid_gain(&data->gts, gains[i].new_gain)) {
+			int scale1, scale2;
+			bool ok;
+
+			_bu27034_get_scale(data, gains[i].chan, &scale1, &scale2);
+			dev_dbg(data->dev,
+				"chan %u, can't support time %u with scale %u %u\n",
+				gains[i].chan, time_us, scale1, scale2);
+
+			/*
+			 * As Jonathan put it, if caller requests for
+			 * integration time change and we can't support the
+			 * scale - then the caller should be prepared to
+			 * 'pick up the pieces and deal with the fact that the
+			 * scale changed'.
+			 */
+			ret =3D iio_find_closest_gain_low(&data->gts,
+							gains[i].new_gain, &ok);
+
+			if (!ok) {
+				dev_dbg(data->dev,
+					"optimal gain out of range for chan %u\n",
+					gains[i].chan);
+			}
+			if (ret < 0) {
+				dev_warn(data->dev,
+					 "Total gain increase. Risk of saturation");
+				ret =3D iio_gts_get_min_gain(&data->gts);
+				if (ret < 0)
+					goto unlock_out;
+			}
+			dev_warn(data->dev, "chan %u scale changed\n",
+				 gains[i].chan);
+			gains[i].new_gain =3D ret;
+			dev_dbg(data->dev, "chan %u new gain %u\n",
+				gains[i].chan, gains[i].new_gain);
+		}
+	}
+
+	/*
+	 * The new integration time can be supported while keeping the scale of
+	 * channels intact by tuning the gains.
+	 */
+	for (i =3D 0; i < numg; i++) {
+		ret =3D bu27034_set_gain(data, gains[i].chan, gains[i].new_gain);
+		if (ret)
+			goto unlock_out;
+	}
+
+	ret =3D bu27034_set_int_time(data, int_time_new);
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int bu27034_set_scale(struct bu27034_data *data, int chan,
+			    int val, int val2)
+{
+	int ret, time_sel, gain_sel, i;
+	bool found =3D false;
+
+	if (chan =3D=3D BU27034_CHAN_ALS) {
+		if (val =3D=3D 0 && val2 =3D=3D 1000)
+			return 0;
+		else
+			return -EINVAL;
+	}
+
+	mutex_lock(&data->mutex);
+	ret =3D regmap_read(data->regmap, BU27034_REG_MODE_CONTROL1, &time_sel);
+	if (ret)
+		goto unlock_out;
+
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&data->gts, time_sel,
+						val, val2 * 1000, &gain_sel);
+	if (ret) {
+		/*
+		 * Could'n support scale with given time. Need to change time.
+		 * We still want to maintain the scale for all channels
+		 */
+		int new_time_sel;
+		struct bu27034_gain_check gains[2];
+
+		/*
+		 * Populate information for the two other channels which should
+		 * maintain the scale.
+		 */
+		if (chan =3D=3D BU27034_CHAN_DATA0) {
+			gains[0].chan =3D BU27034_CHAN_DATA1;
+			gains[1].chan =3D BU27034_CHAN_DATA2;
+		} else if (chan =3D=3D BU27034_CHAN_DATA1) {
+			gains[0].chan =3D BU27034_CHAN_DATA0;
+			gains[1].chan =3D BU27034_CHAN_DATA2;
+		} else {
+			gains[0].chan =3D BU27034_CHAN_DATA0;
+			gains[1].chan =3D BU27034_CHAN_DATA1;
+		}
+
+		for (i =3D 0; i < 2; i++) {
+			ret =3D bu27034_get_gain(data, gains[i].chan,
+					       &gains[i].old_gain);
+			if (ret)
+				goto unlock_out;
+		}
+
+		/*
+		 * Iterate through all the times to see if we find one which
+		 * can support requested scale for requested channel, while
+		 * maintaining the scale for other channels
+		 */
+		for (i =3D 0; i < data->gts.num_itime; i++) {
+			new_time_sel =3D data->gts.itime_table[i].sel;
+
+			if (new_time_sel =3D=3D time_sel)
+				continue;
+
+			/* Can we provide requested scale with this time? */
+			ret =3D iio_gts_find_gain_sel_for_scale_using_time(
+				&data->gts, new_time_sel, val, val2 * 1000,
+				&gain_sel);
+			if (ret)
+				continue;
+
+			/* Can the two other channels maintain scales? */
+			ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(
+				&data->gts, gains[0].old_gain, time_sel,
+				new_time_sel, &gains[0].new_gain);
+			if (ret)
+				continue;
+
+			ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(
+				&data->gts, gains[1].old_gain, time_sel,
+				new_time_sel, &gains[1].new_gain);
+			if (!ret) {
+				/* Yes - we found suitable time */
+				found =3D true;
+				break;
+			}
+		}
+		if (!found) {
+			dev_err(data->dev,
+				"Can't set scale maintaining other channels\n");
+			ret =3D -EINVAL;
+
+			goto unlock_out;
+		}
+
+		for (i =3D 0; i < 2; i++) {
+			ret =3D bu27034_set_gain(data, gains[i].chan,
+						gains[i].new_gain);
+			if (ret)
+				goto unlock_out;
+		}
+
+		ret =3D regmap_update_bits(data->regmap, BU27034_REG_MODE_CONTROL1,
+				  BU27034_MASK_MEAS_MODE, new_time_sel);
+		if (ret)
+			goto unlock_out;
+	}
+
+	ret =3D bu27034_write_gain_sel(data, chan, gain_sel);
+unlock_out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+/*
+ * for (D1/D0 < 0.87):
+ * lx =3D 0.004521097 * D1 - 0.002663996 * D0 +
+ *	0.00012213 * D1 * D1 / D0
+ *
+ * =3D>	115.7400832 * ch1 / gain1 / mt -
+ *	68.1982976 * ch0 / gain0 / mt +
+ *	0.00012213 * 25600 * (ch1 / gain1 / mt) * 25600 *
+ *	(ch1 /gain1 / mt) / (25600 * ch0 / gain0 / mt)
+ *
+ * A =3D	0.00012213 * 25600 * (ch1 /gain1 / mt) * 25600 *
+ *	(ch1 /gain1 / mt) / (25600 * ch0 / gain0 / mt)
+ * =3D>	0.00012213 * 25600 * (ch1 /gain1 / mt) *
+ *	(ch1 /gain1 / mt) / (ch0 / gain0 / mt)
+ * =3D>	0.00012213 * 25600 * (ch1 / gain1) * (ch1 /gain1 / mt) /
+ *	(ch0 / gain0)
+ * =3D>	0.00012213 * 25600 * (ch1 / gain1) * (ch1 /gain1 / mt) *
+ *	gain0 / ch0
+ * =3D>	3.126528 * ch1 * ch1 * gain0 / gain1 / gain1 / mt /ch0
+ *
+ * lx =3D (115.7400832 * ch1 / gain1 - 68.1982976 * ch0 / gain0) /
+ *	mt + A
+ * =3D>	(115.7400832 * ch1 / gain1 - 68.1982976 * ch0 / gain0) /
+ *	mt + 3.126528 * ch1 * ch1 * gain0 / gain1 / gain1 / mt /
+ *	ch0
+ *
+ * =3D>	(115.7400832 * ch1 / gain1 - 68.1982976 * ch0 / gain0 +
+ *	  3.126528 * ch1 * ch1 * gain0 / gain1 / gain1 / ch0) /
+ *	  mt
+ *
+ * For (0.87 <=3D D1/D0 < 1.00)
+ * lx =3D (0.001331* D0 + 0.0000354 * D1) * ((D1/D0 =E2=80=93 0.87) * (0.3=
85) + 1)
+ * =3D>	(0.001331 * 256 * 100 * ch0 / gain0 / mt + 0.0000354 * 256 *
+ *	100 * ch1 / gain1 / mt) * ((D1/D0 -  0.87) * (0.385) + 1)
+ * =3D>	(34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
+ *	((D1/D0 -  0.87) * (0.385) + 1)
+ * =3D>	(34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
+ *	(0.385 * D1/D0 - 0.66505)
+ * =3D>	(34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
+ *	(0.385 * 256 * 100 * ch1 / gain1 / mt / (256 * 100 * ch0 / gain0 / mt) =
- 0.66505)
+ * =3D>	(34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
+ *	(9856 * ch1 / gain1 / mt / (25600 * ch0 / gain0 / mt) + 0.66505)
+ * =3D>	13.118336 * ch1 / (gain1 * mt)
+ *	+ 22.66064768 * ch0 / (gain0 * mt)
+ *	+ 8931.90144 * ch1 * ch1 * gain0 /
+ *	  (25600 * ch0 * gain1 * gain1 * mt)
+ *	+ 0.602694912 * ch1 / (gain1 * mt)
+ *
+ * =3D>	[0.3489024 * ch1 * ch1 * gain0 / (ch0 * gain1 * gain1)
+ *	 + 22.66064768 * ch0 / gain0
+ *	 + 13.721030912 * ch1 / gain1
+ *	] / mt
+ *
+ * For (D1/D0 >=3D 1.00)
+ *
+ * lx	=3D (0.001331* D0 + 0.0000354 * D1) * ((D1/D0 =E2=80=93 2.0) * (-0.0=
5) + 1)
+ *	=3D> (0.001331* D0 + 0.0000354 * D1) * (-0.05D1/D0 + 1.1)
+ *	=3D> (0.001331 * 256 * 100 * ch0 / gain0 / mt + 0.0000354 * 256 *
+ *	   100 * ch1 / gain1 / mt) * (-0.05D1/D0 + 1.1)
+ *	=3D> (34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
+ *	   (-0.05 * 256 * 100 * ch1 / gain1 / mt / (256 * 100 * ch0 / gain0 / m=
t) + 1.1)
+ *	=3D> (34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
+ *	   (-1280 * ch1 / (gain1 * mt * 25600 * ch0 / gain0 / mt) + 1.1)
+ *	=3D> (34.0736 * ch0 * -1280 * ch1 * gain0 * mt /( gain0 * mt * gain1 * =
mt * 25600 * ch0)
+ *	    + 34.0736 * 1.1 * ch0 / (gain0 * mt)
+ *	    + 0.90624 * ch1 * -1280 * ch1 *gain0 * mt / (gain1 * mt *gain1 * mt=
 * 25600 * ch0)
+ *	    + 1.1 * 0.90624 * ch1 / (gain1 * mt)
+ *	=3D> -43614.208 * ch1 / (gain1 * mt * 25600)
+ *	    + 37.48096  ch0 / (gain0 * mt)
+ *	    - 1159.9872 * ch1 * ch1 * gain0 / (gain1 * gain1 * mt * 25600 * ch0)
+ *	    + 0.996864 ch1 / (gain1 * mt)
+ *	=3D> [
+ *		- 0.045312 * ch1 * ch1 * gain0 / (gain1 * gain1 * ch0)
+ *		- 0.706816 * ch1 / gain1
+ *		+ 37.48096  ch0 /gain0
+ *	   ] * mt
+ *
+ *
+ * So, the first case (D1/D0 < 0.87) can be computed to a form:
+ *
+ * lx =3D (3.126528 * ch1 * ch1 * gain0 / (ch0 * gain1 * gain1) +
+ *	 115.7400832 * ch1 / gain1 +
+ *	-68.1982976 * ch0 / gain0
+ *	 / mt
+ *
+ * Second case (0.87 <=3D D1/D0 < 1.00) goes to form:
+ *
+ *	=3D> [0.3489024 * ch1 * ch1 * gain0 / (ch0 * gain1 * gain1) +
+ *	    13.721030912 * ch1 / gain1 +
+ *	    22.66064768 * ch0 / gain0
+ *	   ] / mt
+ *
+ * Third case (D1/D0 >=3D 1.00) goes to form:
+ *	=3D> [-0.045312 * ch1 * ch1 * gain0 / (ch0 * gain1 * gain1) +
+ *	    -0.706816 * ch1 / gain1 +
+ *	    37.48096  ch0 /(gain0
+ *	   ] / mt
+ *
+ * This can be unified to format:
+ * lx =3D [
+ *	 A * ch1 * ch1 * gain0 / (ch0 * gain1 * gain1) +
+ *	 B * ch1 / gain1 +
+ *	 C * ch0 / gain0
+ *	] / mt
+ *
+ * For case 1:
+ * A =3D 3.126528,
+ * B =3D 115.7400832
+ * C =3D -68.1982976
+ *
+ * For case 2:
+ * A =3D 0.3489024
+ * B =3D 13.721030912
+ * C =3D 22.66064768
+ *
+ * For case 3:
+ * A =3D -0.045312
+ * B =3D -0.706816
+ * C =3D 37.48096
+ */
+
+struct bu27034_lx_coeff {
+	unsigned int A;
+	unsigned int B;
+	unsigned int C;
+	/* Indicate which of the coefficients above are negative */
+	bool is_neg[3];
+};
+
+static u64 bu27034_fixp_calc_t1(unsigned int coeff, unsigned int ch0,
+				unsigned int ch1, unsigned int gain0,
+				unsigned int gain1)
+{
+	unsigned int helper, tmp;
+	u64 helper64;
+
+	/*
+	 * Here we could overflow even the 64bit value. Hence we
+	 * multiply with gain0 only after the divisions - even though
+	 * it may result loss of accuracy
+	 */
+	helper64 =3D (u64)coeff * (u64)ch1 * (u64)ch1;
+	helper =3D coeff * ch1 * ch1;
+	tmp =3D helper * gain0;
+
+	if (helper =3D=3D helper64 && (tmp / gain0 =3D=3D helper))
+		return tmp / (gain1 * gain1) / ch0;
+
+	helper =3D gain1 * gain1;
+	if (helper > ch0) {
+		do_div(helper64, helper);
+		/*
+		 * Max gain for a channel is 4096. The max u64
+		 * (0xffffffffffffffffULL) divided by 4096 is 0xFFFFFFFFFFFFF
+		 * (floored). Thus, the 0xFFFFFFFFFFFFF is the largest value
+		 * we can safely multiply with the gain, no matter what gain
+		 * is set.
+		 *
+		 * So, multiplication with max gain may overflow
+		 * if helper64 is greater than 0xFFFFFFFFFFFFF.
+		 *
+		 * If this is the case we divide first.
+		 */
+		if (helper64 < 0xFFFFFFFFFFFFFLLU) {
+			helper64 *=3D gain0;
+			do_div(helper64, ch0);
+		} else {
+			do_div(helper64, ch0);
+			helper64 *=3D gain0;
+		}
+
+		return helper64;
+	}
+
+	do_div(helper64, ch0);
+	/* Same overflow check here */
+	if (helper64 < 0xFFFFFFFFFFFFFLLU) {
+		helper64 *=3D gain0;
+		do_div(helper64, helper);
+	} else {
+		do_div(helper64, helper);
+		helper64 *=3D gain0;
+	}
+
+	return helper64;
+}
+
+static u64 bu27034_fixp_calc_t23(unsigned int coeff, unsigned int ch,
+				 unsigned int gain)
+{
+	unsigned int helper;
+	u64 helper64;
+
+	helper64 =3D (u64)coeff * (u64)ch;
+	helper =3D coeff * ch;
+
+	if (helper =3D=3D helper64)
+		return helper / gain;
+
+	do_div(helper64, gain);
+
+	return helper64;
+}
+
+static int bu27034_fixp_calc_lx(unsigned int ch0, unsigned int ch1,
+				unsigned int gain0, unsigned int gain1,
+				unsigned int meastime, int coeff_idx)
+{
+	static const struct bu27034_lx_coeff coeff[] =3D {
+		{
+			.A =3D 31265280,		/* 3.126528 */
+			.B =3D 1157400832,	/*115.7400832 */
+			.C =3D 681982976,		/* -68.1982976 */
+			.is_neg =3D {false, false, true},
+		}, {
+			.A =3D 3489024,		/* 0.3489024 */
+			.B =3D 137210309,		/* 13.721030912 */
+			.C =3D 226606476,		/* 22.66064768 */
+			/* All terms positive */
+		}, {
+			.A =3D 453120,		/* -0.045312 */
+			.B =3D 7068160,		/* -0.706816 */
+			.C =3D 374809600,		/* 37.48096 */
+			.is_neg =3D {true, true, false},
+		}
+	};
+	const struct bu27034_lx_coeff *c =3D &coeff[coeff_idx];
+	u64 res =3D 0, terms[3];
+	int i;
+
+	if (coeff_idx >=3D ARRAY_SIZE(coeff))
+		return -EINVAL;
+
+	terms[0] =3D bu27034_fixp_calc_t1(c->A, ch0, ch1, gain0, gain1);
+	terms[1] =3D bu27034_fixp_calc_t23(c->B, ch1, gain1);
+	terms[2] =3D bu27034_fixp_calc_t23(c->C, ch0, gain0);
+
+	/* First, add positive terms */
+	for (i =3D 0; i < 3; i++)
+		if (!c->is_neg[i])
+			res +=3D terms[i];
+
+	/* No positive term =3D> zero lux */
+	if (!res)
+		return 0;
+
+	/* Then, subtract negative terms (if any) */
+	for (i =3D 0; i < 3; i++)
+		if (c->is_neg[i]) {
+			/*
+			 * If the negative term is greater than positive - then
+			 * the darknes has taken over and we are all doomed! Eh,
+			 * I mean, then we can just return 0 lx and go out
+			 */
+			if (terms[i] >=3D res)
+				return 0;
+
+			res -=3D terms[i];
+		}
+
+	meastime *=3D 10;
+	do_div(res, meastime);
+
+	return (int) res;
+}
+
+static bool bu27034_has_valid_sample(struct bu27034_data *data)
+{
+	int ret, val;
+
+	ret =3D regmap_read(data->regmap, BU27034_REG_MODE_CONTROL4, &val);
+	if (ret)
+		dev_err(data->dev, "Read failed %d\n", ret);
+
+	return (val & BU27034_MASK_VALID);
+}
+
+/*
+ * Reading the register where VALID bit is clears this bit. (So does chang=
ing
+ * any gain / integration time configuration registers) The bit gets
+ * set when we have acquired new data. We use this bit to indicate data
+ * validity.
+ */
+static void bu27034_invalidate_read_data(struct bu27034_data *data)
+{
+	bu27034_has_valid_sample(data);
+}
+
+static int bu27034_read_result(struct bu27034_data *data, int chan, int *r=
es)
+{
+	int reg[] =3D {
+		[BU27034_CHAN_DATA0] =3D BU27034_REG_DATA0_LO,
+		[BU27034_CHAN_DATA1] =3D BU27034_REG_DATA1_LO,
+		[BU27034_CHAN_DATA2] =3D BU27034_REG_DATA2_LO,
+	};
+	int valid, ret;
+	__le16 val;
+
+	ret =3D regmap_read_poll_timeout(data->regmap, BU27034_REG_MODE_CONTROL4,
+				       valid, (valid & BU27034_MASK_VALID),
+				       BU27034_DATA_WAIT_TIME_US, 0);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_bulk_read(data->regmap, reg[chan], &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	*res =3D le16_to_cpu(val);
+
+	return 0;
+}
+
+static int bu27034_get_result_unlocked(struct bu27034_data *data, __le16 *=
res,
+				       int size)
+{
+	int ret =3D 0;
+
+retry:
+	/* Get new value from sensor if data is ready */
+	if (bu27034_has_valid_sample(data)) {
+		ret =3D regmap_bulk_read(data->regmap, BU27034_REG_DATA0_LO,
+				       res, size);
+		if (ret)
+			return ret;
+
+		bu27034_invalidate_read_data(data);
+	} else {
+		/* No new data in sensor. Wait and retry */
+		msleep(25);
+
+		goto retry;
+	}
+
+	return ret;
+}
+
+static int bu27034_meas_set(struct bu27034_data *data, bool en)
+{
+	if (en)
+		return regmap_set_bits(data->regmap, BU27034_REG_MODE_CONTROL4,
+				       BU27034_MASK_MEAS_EN);
+
+	return regmap_clear_bits(data->regmap, BU27034_REG_MODE_CONTROL4,
+				 BU27034_MASK_MEAS_EN);
+}
+
+static int bu27034_get_single_result(struct bu27034_data *data, int chan,
+				     int *val)
+{
+	int ret;
+
+
+	ret =3D bu27034_meas_set(data, true);
+	if (ret)
+		return ret;
+
+	ret =3D bu27034_get_int_time(data);
+	if (ret < 0)
+		return ret;
+
+	msleep(ret / 1000);
+
+	return bu27034_read_result(data, chan, val);
+}
+
+/*
+ * The formula given by vendor for computing luxes out of data0 and data1
+ * (in open air) is as follows:
+ *
+ * Let's mark:
+ * D0 =3D data0/ch0_gain/meas_time_ms * 25600
+ * D1 =3D data1/ch1_gain/meas_time_ms * 25600
+ *
+ * Then:
+ * if (D1/D0 < 0.87)
+ *	lx =3D (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 0.87) * 3.45 + 1)
+ * else if (D1/D0 < 1)
+ *	lx =3D (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 0.87) * 0.385 + 1)
+ * else
+ *	lx =3D (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 2) * -0.05 + 1)
+ *
+ * We use it here. Users who have for example some colored lens
+ * need to modify the calculation but I hope this gives a starting point f=
or
+ * those working with such devices.
+ */
+
+static int bu27034_calc_lux(struct bu27034_data *data, __le16 *res, int *v=
al)
+{
+	unsigned int gain0, gain1, meastime;
+	unsigned int d1_d0_ratio_scaled;
+	u16  ch0, ch1;
+	u64 helper64;
+	int ret;
+
+	/*
+	 * We return 0 luxes if calculation fails. This should be reasonably
+	 * easy to spot from the buffers especially if raw-data channels show
+	 * valid values
+	 */
+	*val =3D 0;
+
+	/*
+	 * Avoid div by zeroi. Not using max() as the data may not be in
+	 * native endianes
+	 */
+	if (!res[0])
+		ch0 =3D 1;
+	else
+		ch0 =3D le16_to_cpu(res[0]);
+
+	if (!res[1])
+		ch1 =3D 1;
+	else
+		ch1 =3D le16_to_cpu(res[1]);
+
+
+	ret =3D bu27034_get_gain(data, BU27034_CHAN_DATA0, &gain0);
+	if (ret)
+		return ret;
+
+	ret =3D bu27034_get_gain(data, BU27034_CHAN_DATA1, &gain1);
+	if (ret)
+		return ret;
+
+	ret =3D bu27034_get_int_time(data);
+	if (ret < 0)
+		return ret;
+
+	meastime =3D ret;
+
+	d1_d0_ratio_scaled =3D (unsigned int)ch1 * (unsigned int)gain0 * 100;
+	helper64 =3D (u64)ch1 * (u64)gain0 * 100LLU;
+
+	if (helper64 !=3D d1_d0_ratio_scaled) {
+		unsigned int div =3D (unsigned int)ch0 * gain1;
+
+		do_div(helper64, div);
+		d1_d0_ratio_scaled =3D helper64;
+	} else {
+		d1_d0_ratio_scaled /=3D ch0 * gain1;
+	}
+
+	if (d1_d0_ratio_scaled < 87)
+		*val =3D bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 0);
+	else if (d1_d0_ratio_scaled < 100)
+		*val =3D bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 1);
+	else
+		*val =3D bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 2);
+
+	return 0;
+
+}
+
+static int bu27034_get_lux(struct bu27034_data *data, int *val)
+{
+	__le16 res[3];
+	int ret;
+
+	ret =3D bu27034_get_result_unlocked(data, &res[0], sizeof(res));
+	if (ret)
+		return ret;
+
+	return bu27034_calc_lux(data, res, val);
+}
+
+static int bu27034_read_raw(struct iio_dev *idev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct bu27034_data *data =3D iio_priv(idev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*val =3D bu27034_get_int_time(data);
+		if (*val < 0)
+			return *val;
+
+		/*
+		 * We use 50000 uS internally for all calculations and only
+		 * convert it to 55000 before returning it to the user.
+		 *
+		 * This is because the data-sheet says the time is 55 mS - but
+		 * vendor provided computations used 50 mS.
+		 */
+		if (*val =3D=3D 50000)
+			*val =3D 55000;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		return bu27034_get_scale(data, chan->channel, val, val2);
+
+	case IIO_CHAN_INFO_RAW:
+	{
+		if (chan->type !=3D IIO_INTENSITY)
+			return -EINVAL;
+
+		if (chan->channel < BU27034_CHAN_DATA0 ||
+		    chan->channel > BU27034_CHAN_DATA2)
+			return -EINVAL;
+
+		/* Don't mess with measurement enabling while buffering */
+		ret =3D iio_device_claim_direct_mode(idev);
+		if (ret)
+			return ret;
+
+		mutex_lock(&data->mutex);
+		/*
+		 * Reading one channel at a time is ineffiecient but we don't
+		 * care here. Buffered version should be used if performance is
+		 * an issue.
+		 */
+		ret =3D bu27034_get_single_result(data, chan->channel, val);
+		if (ret)
+			goto release_err_out;
+
+		mutex_unlock(&data->mutex);
+		iio_device_release_direct_mode(idev);
+
+		return IIO_VAL_INT;
+	}
+
+	case IIO_CHAN_INFO_PROCESSED:
+		if (chan->type !=3D IIO_LIGHT)
+			return -EINVAL;
+
+		/* Don't mess with measurement enabling while buffering */
+		ret =3D iio_device_claim_direct_mode(idev);
+		if (ret)
+			return ret;
+
+		mutex_lock(&data->mutex);
+		ret =3D bu27034_meas_set(data, true);
+		if (ret)
+			goto release_err_out;
+
+		ret =3D bu27034_get_lux(data, val);
+		if (ret)
+			goto release_err_out;
+
+		ret =3D bu27034_meas_set(data, false);
+		if (ret)
+			dev_err(data->dev, "failed to disable measurement\n");
+
+		mutex_unlock(&data->mutex);
+		iio_device_release_direct_mode(idev);
+
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+
+	}
+
+release_err_out:
+	mutex_unlock(&data->mutex);
+	iio_device_release_direct_mode(idev);
+
+	return ret;
+}
+
+static int bu27034_write_raw(struct iio_dev *idev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct bu27034_data *data =3D iio_priv(idev);
+	int ret;
+
+	ret =3D iio_device_claim_direct_mode(idev);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret =3D bu27034_set_scale(data, chan->channel, val, val2);
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		ret =3D bu27034_try_set_int_time(data, val);
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	iio_device_release_direct_mode(idev);
+
+	return ret;
+}
+
+static int bu27034_read_avail(struct iio_dev *idev,
+			      struct iio_chan_spec const *chan, const int **vals,
+			      int *type, int *length, long mask)
+{
+	struct bu27034_data *data =3D iio_priv(idev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		return iio_gts_avail_times(&data->gts, vals, type, length);
+	case IIO_CHAN_INFO_SCALE:
+		return iio_gts_all_avail_scales(&data->gts, vals, type, length);
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+static const struct iio_info bu27034_info =3D {
+	.read_raw =3D &bu27034_read_raw,
+	.write_raw =3D &bu27034_write_raw,
+	.read_avail =3D &bu27034_read_avail,
+};
+
+static int bu27034_chip_init(struct bu27034_data *data)
+{
+	int ret, sel;
+
+	/* Reset */
+	ret =3D regmap_update_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
+			   BU27034_MASK_SW_RESET, BU27034_MASK_SW_RESET);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
+
+	/*
+	 * Delay to allow IC to initialize. We don't care if we delay
+	 * for more than 1 ms so msleep() is Ok. We just don't want to
+	 * block
+	 */
+	msleep(1);
+	/*
+	 * Read integration time here to ensure it is in regmap cache. We do
+	 * this to speed-up the int-time acquisition in the start of the buffer
+	 * handling thread where longer delays could make it more likely we end
+	 * up skipping a sample, and where the longer delays make timestamps
+	 * less accurate.
+	 */
+	ret =3D regmap_read(data->regmap, BU27034_REG_MODE_CONTROL1, &sel);
+	if (ret)
+		dev_err(data->dev, "reading integration time failed\n");
+
+	return 0;
+}
+
+static int bu27034_wait_for_data(struct bu27034_data *data)
+{
+	int ret, val;
+
+	ret =3D regmap_read_poll_timeout(data->regmap, BU27034_REG_MODE_CONTROL4,
+				       val, (val & BU27034_MASK_VALID),
+				       BU27034_DATA_WAIT_TIME_US,
+				       BU27034_TOTAL_DATA_WAIT_TIME_US);
+	if (ret) {
+		dev_err(data->dev, "data polling %s\n",
+			!(val & BU27034_MASK_VALID) ? "timeout" : "fail");
+		return ret;
+	}
+	ret =3D regmap_bulk_read(data->regmap, BU27034_REG_DATA0_LO,
+			       &data->scan.channels[0],
+			       sizeof(data->scan.channels));
+	bu27034_invalidate_read_data(data);
+
+	return ret;
+}
+
+static int bu27034_buffer_thread(void *arg)
+{
+	struct iio_dev *idev =3D arg;
+	struct bu27034_data *data;
+	int wait_ms;
+
+	data =3D iio_priv(idev);
+
+	wait_ms =3D bu27034_get_int_time(data);
+	wait_ms /=3D 1000;
+
+	wait_ms -=3D  BU27034_MEAS_WAIT_PREMATURE_MS;
+
+	while (!kthread_should_stop()) {
+		int ret;
+		int64_t tstamp;
+
+		msleep(wait_ms);
+		ret =3D bu27034_wait_for_data(data);
+		if (ret)
+			continue;
+
+		tstamp =3D iio_get_time_ns(idev);
+
+		if (*idev->active_scan_mask & BIT(BU27034_CHAN_ALS)) {
+			ret =3D bu27034_calc_lux(data, &data->scan.channels[0],
+					       &data->scan.lux);
+			if (ret)
+				dev_err(data->dev, "failed to calculate lux\n");
+		}
+		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
+	}
+
+	return 0;
+}
+
+static int bu27034_buffer_enable(struct iio_dev *idev)
+{
+	struct bu27034_data *data =3D iio_priv(idev);
+	struct task_struct *task;
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret =3D bu27034_meas_set(data, true);
+	if (ret)
+		goto unlock_out;
+
+	task =3D kthread_run(bu27034_buffer_thread, idev,
+				 "bu27034-buffering-%u",
+				 iio_device_id(idev));
+	if (IS_ERR(task)) {
+		ret =3D PTR_ERR(task);
+		goto unlock_out;
+	}
+
+	data->task =3D task;
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int bu27034_buffer_disable(struct iio_dev *idev)
+{
+	struct bu27034_data *data =3D iio_priv(idev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	if (data->task) {
+		kthread_stop(data->task);
+		data->task =3D NULL;
+	}
+
+	ret =3D bu27034_meas_set(data, false);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops bu27034_buffer_ops =3D {
+	.postenable =3D &bu27034_buffer_enable,
+	.predisable =3D &bu27034_buffer_disable,
+};
+
+static int bu27034_probe(struct i2c_client *i2c)
+{
+	struct device *dev =3D &i2c->dev;
+	struct fwnode_handle *fwnode;
+	struct bu27034_data *data;
+	struct regmap *regmap;
+	struct iio_dev *idev;
+	unsigned int part_id;
+	int ret;
+
+	regmap =3D devm_regmap_init_i2c(i2c, &bu27034_regmap);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialize Regmap\n");
+
+	fwnode =3D dev_fwnode(dev);
+	if (!fwnode)
+		return -ENODEV;
+
+	idev =3D devm_iio_device_alloc(dev, sizeof(*data));
+	if (!idev)
+		return -ENOMEM;
+
+	ret =3D devm_regulator_get_enable(dev, "vdd");
+	if (ret && ret !=3D -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get regulator\n");
+
+	data =3D iio_priv(idev);
+
+	ret =3D regmap_read(regmap, BU27034_REG_SYSTEM_CONTROL, &part_id);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to access sensor\n");
+
+	part_id &=3D BU27034_MASK_PART_ID;
+
+	if (part_id !=3D BU27034_ID)
+		dev_warn(dev, "unsupported device 0x%x\n", part_id);
+
+	ret =3D iio_init_iio_gts(BU27034_SCALE_1X, 0, bu27034_gains,
+			       ARRAY_SIZE(bu27034_gains), bu27034_itimes,
+			       ARRAY_SIZE(bu27034_itimes), &data->gts);
+	if (ret)
+		return ret;
+
+	ret =3D devm_iio_gts_build_avail_tables(dev, &data->gts);
+	if (ret)
+		return ret;
+
+	mutex_init(&data->mutex);
+	data->regmap =3D regmap;
+	data->dev =3D dev;
+
+	idev->channels =3D bu27034_channels;
+	idev->num_channels =3D ARRAY_SIZE(bu27034_channels);
+	idev->name =3D "bu27034";
+	idev->info =3D &bu27034_info;
+
+	idev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	idev->available_scan_masks =3D bu27034_scan_masks;
+
+	ret =3D bu27034_chip_init(data);
+	if (ret)
+		return ret;
+
+	ret =3D devm_iio_kfifo_buffer_setup(dev, idev, &bu27034_buffer_ops);
+
+	ret =3D devm_iio_device_register(dev, idev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Unable to register iio device\n");
+
+	return ret;
+}
+
+static const struct of_device_id bu27034_of_match[] =3D {
+	{ .compatible =3D "rohm,bu27034", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bu27034_of_match);
+
+static struct i2c_driver bu27034_i2c_driver =3D {
+	.driver =3D {
+		.name  =3D "bu27034-als",
+		.of_match_table =3D bu27034_of_match,
+	  },
+	.probe_new    =3D bu27034_probe,
+};
+module_i2c_driver(bu27034_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("ROHM BU27034 ambient light sensor driver");
--=20
2.39.2


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

--qd9ydqrm8qc3FzX3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQAgXMACgkQeFA3/03a
ocVxFQf+O6yZKFQN0S3yQvUmdmP7MUl2Fa4TqeOk+UfRCfoONMjpgjJSn+AEYoQz
yAMYjRA0Y1MZgaQcKSt1olldEeWPwWKWyFpSE7GKLtGX/6nSwsKlQxvEEoDAX7ds
UDkG5IykbFQCj4htPsY3yHMHinzen0AcqKCYFqxdEPsnEFb49fvXUH0HusypQl7y
oCxi8rengrYla7YRE1oycN3PPWX9Cw5tos8DMPFi2ep1Im/KTcnZ2D6kD1Snhbis
nOZzkFmKhpDpVuIdfwM4OS18zMF7QiD/voYN5y4r134VhCCEZHcMr6oywBVCZQmm
mB31Zt1pRnjXX1WAaMG3hTm/Iivx+g==
=YCNq
-----END PGP SIGNATURE-----

--qd9ydqrm8qc3FzX3--
