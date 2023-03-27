Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A406CA28F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjC0LfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjC0LfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:35:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC0C4697;
        Mon, 27 Mar 2023 04:34:59 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i13so10976114lfe.9;
        Mon, 27 Mar 2023 04:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679916897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=22J0Gf71T7S8PEOQ0nVFQV8fkzik/RghGlABIJ8Za/4=;
        b=S6Ixcb6Fq+3UqmAhmhlw/bmt5csTGQIxZjD81NHQ/jmi7Xlw0MM07sZMjvHr5S22B5
         SzI3ewNyu9WofaCiVRpLsPRPEoQUBD5+19N+v20TsRmBQ3xqMpyK0Tc1GXMNejvrvftJ
         R3zdznEqQY+0pUhdSsbDcZC1FpAiEanXT/ii/eh40nomNpA3d1kp7se46Uuen7UE5NRR
         Z3dEwqy8/zAzNYuvsJ8PtTf/p6JIAbS1WJE0My8IWNPIXWfzGHBqgFM9susadomVSOXI
         8PJFKdUV9WIf9zSwpKDE+R/rC7WsUhXi8dTFnaIyvzHVo4rKH6fvzBJXDoaEzzxwHiI0
         FH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679916897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22J0Gf71T7S8PEOQ0nVFQV8fkzik/RghGlABIJ8Za/4=;
        b=t8RGx8Xp3xVcGRO8R+UjoGiD5rZBI97YVkNZpJl8dbHvIETUIRJZB2m5KbUYx0J+I3
         seMFtcz0pbzZLPyYGgLSbOwwttn531cJ55WnsuHy6QdocpckqQ6zORshNAZHcMfE4IEu
         /d4CBMEXctgDqAY9CSoZ5CvYbL6w0WMlwZ6qbL+CIL5Crw1TKfMgpxALE3dUtv2c77cp
         CfTZ6kMvbUkCfAo6hzUB4duO3haKGsIQDFKdB9RCDlp0OQGnk53NqRWV9hxXBvsDIYOP
         QjOLif/PixGBjIBW2AjMNyN3CTlJsixnlZvQzHYZbTQzCjlsrL7LaqFkgn9az1sekq0a
         Glsg==
X-Gm-Message-State: AAQBX9dywHkjEdhsYgMRFRQ+esgQR4qWUQoxQrdXSnsWucprq8y3lPi6
        nnitZs1gceY2XMHq+Cgz0jA=
X-Google-Smtp-Source: AKy350Z/6iaPuU8nLbxR2YjQ8LQPisIih4ialTWh7kT9R+wm5k1DFU6lJ/XC9cXbP9KEZ0hi5zkrZw==
X-Received: by 2002:a05:6512:11cc:b0:4ea:fdcf:8f62 with SMTP id h12-20020a05651211cc00b004eafdcf8f62mr3762720lfr.0.1679916897355;
        Mon, 27 Mar 2023 04:34:57 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id p5-20020a19f005000000b004e856a4159bsm4639984lfc.20.2023.03.27.04.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:34:56 -0700 (PDT)
Date:   Mon, 27 Mar 2023 14:34:51 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v6 6/7] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <1b7d3725bf5ae829b12eaf96362204edd29c6966.1679915278.git.mazziesaccount@gmail.com>
References: <cover.1679915278.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lcP5ZVXlDs048Vru"
Content-Disposition: inline
In-Reply-To: <cover.1679915278.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lcP5ZVXlDs048Vru
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BU27034 is an ambient light sensor with 3 channels and 3 photo diodes
capable of detecting a very wide range of illuminance. Typical application
is adjusting LCD and backlight power of TVs and mobile phones.

Add initial  support for the ROHM BU27034 ambient light sensor.

NOTE:
	- Driver exposes 4 channels. One IIO_LIGHT channel providing the
	  calculated lux values based on measured data from diodes #0 and
	  #1. In addition, 3 IIO_INTENSITY channels are emitting the raw
	  register data from all diodes for more intense user-space
	  computations.
	- Sensor has GAIN values that can be adjusted from 1x to 4096x.
	- Sensor has adjustible measurement times of 5, 55, 100, 200 and
	  400 mS. Driver does not support 5 mS which has special
	  limitations.
	- Driver exposes standard 'scale' adjustment which is
	  implemented by:
		1) Trying to adjust only the GAIN
		2) If GAIN adjustment alone can't provide requested
		   scale, adjusting both the time and the gain is
		   attempted.
	- Driver exposes writable INT_TIME property that can be used
	  for adjusting the measurement time. Time adjustment will also
	  cause the driver to try to adjust the GAIN so that the
	  overall scale is kept as close to the original as possible.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v5 =3D> v6:
- Use the multiplication with overflow check from overflow.h
- Use FIELD_PREP()

Changes
v4 =3D> v5:
- spellcheck
- back to mlux again
- lux channel PROCESSED =3D> RAW
- use new devm_init for GTS and drop explicit table building
- styling
- drop unnecessary loop in gain setting
- don't unnecessarily delay returning error
- fix integration time change compensation which was broken by v4 change
  allowing to use the (55 mS) in the time tables. (Rounding error when
  computing new gain based on times not multipliers).

v3 =3D> v4:
- use min_t() for division by zero check
- adapt to new GTS helper header location
- calculate luxes not milli luxes
- drop scale for PROCESSED channel
- comment improvements
- do not allow changing gain (scale) for channel 2.
   - 'tie' channel 2 scale to channel 0 scale
     This is because channel 0 and channel 2 GAIN settings share part of
     the bits in the register. This means that setting one will also
     impact the other. The v3 of the patches attempted to work-around
     this by only disallowing the channel 2 gain setting to set the bits
     which were shared with channel 0 gain. This does not work because
     setting channel 0 gain (which was allowed to set also the shared
     bits) could result unsupported bit combinations for channel 2 gain.
     Thus it is safest to always set also the channel 2 gain to same
     value as channel 0 gain.
- Use the correct integration time (55 mS) in the gain table as the
  calcuations can be done based on the time multiplier.
- styling

v2 =3D> v3:
- commit message update and typofixes
- switch warning messages to dbg
- drop incorrect comment about unchanged scales
- return 'no new data' if valid bit read failed
- shorten the 'div by zero' checks
- don't use u32 pointer when int * is epected in lux calculation
- add a comment clarifying why it is safe to return int from lux calculation
- simplify read_raw() by refactoring the measurement start / stop in
  another function and dropping the goto based unlocking.
- Styling fixes
- select IIO_BUFFER and IIO_KFIFO_BUF
- Alphabetical order of header includes
- Split multipication w/ overflow check to own function
- Do not hang in read_raw() if sensor does not return valid sample
- Spelling fix
- Do not require fwnode
- Use namespace for gts helpers

RFCv1 =3D> v2:
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
 drivers/iio/light/Kconfig        |   14 +
 drivers/iio/light/Makefile       |    1 +
 drivers/iio/light/rohm-bu27034.c | 1496 ++++++++++++++++++++++++++++++
 3 files changed, 1511 insertions(+)
 create mode 100644 drivers/iio/light/rohm-bu27034.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 0d4447df7200..6fa31fcd71a1 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -289,6 +289,20 @@ config JSA1212
 	  To compile this driver as a module, choose M here:
 	  the module will be called jsa1212.
=20
+config ROHM_BU27034
+	tristate "ROHM BU27034 ambient light sensor"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_GTS_HELPER
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
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
index d74d2b5ff14c..985f6feaccd4 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_MAX44009)		+=3D max44009.o
 obj-$(CONFIG_NOA1305)		+=3D noa1305.o
 obj-$(CONFIG_OPT3001)		+=3D opt3001.o
 obj-$(CONFIG_PA12203001)	+=3D pa12203001.o
+obj-$(CONFIG_ROHM_BU27034)	+=3D rohm-bu27034.o
 obj-$(CONFIG_RPR0521)		+=3D rpr0521.o
 obj-$(CONFIG_SI1133)		+=3D si1133.o
 obj-$(CONFIG_SI1145)		+=3D si1145.o
diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
new file mode 100644
index 000000000000..4842a9b66c97
--- /dev/null
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -0,0 +1,1496 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * BU27034 ROHM Ambient Light Sensor
+ *
+ * Copyright (c) 2023, ROHM Semiconductor.
+ * https://fscdn.rohm.com/en/products/databook/datasheet/ic/sensor/light/b=
u27034nuc-e.pdf
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/units.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/iio-gts-helper.h>
+#include <linux/iio/kfifo_buf.h>
+
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
+#define BU27034_MASK_D2_GAIN_HI		GENMASK(7, 6)
+#define BU27034_MASK_D2_GAIN_LO		GENMASK(2, 0)
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
+ * The BU27034 does not have interrupt to trigger the data read when a
+ * measurement has finished. Hence we poll the VALID bit in a thread. We w=
ill
+ * try to wake the thread BU27034_MEAS_WAIT_PREMATURE_MS milliseconds befo=
re
+ * the expected sampling time to prevent the drifting.
+ *
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
+ * risk of losing a sample because things can in a rainy-day scenario be
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
+ *
+ * Other option that was pointed to me would be always sleeping 1/2 of the
+ * measurement time, checking the VALID bit and just sleeping again if the=
 bit
+ * was not set. That should be pretty tolerant against missing samples due=
 to
+ * the scheduling delays while also not wasting much of cycles for polling.
+ * Downside is that the time-stamps would be very inaccurate as the wake-up
+ * would not really be tied to the sensor toggling the valid bit. This wou=
ld also
+ * result 'jumps' in the time-stamps when the delay drifted so that wake-u=
p was
+ * performed during the consecutive wake-ups (Or, when sensor and CPU cloc=
ks
+ * were very different and scheduling the wake-ups was very close to given
+ * timeout - and when the time-outs were very close to the actual sensor
+ * sampling, Eg. once in a blue moon, two consecutive time-outs would occur
+ * without having a sample ready).
+ */
+#define BU27034_MEAS_WAIT_PREMATURE_MS	5
+#define BU27034_DATA_WAIT_TIME_US	1000
+#define BU27034_TOTAL_DATA_WAIT_TIME_US (BU27034_MEAS_WAIT_PREMATURE_MS * =
1000)
+
+#define BU27034_RETRY_LIMIT 18
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
+/* See the data sheet for the "Gain Setting" table */
+#define BU27034_GSEL_1X		0x00 /* 00000 */
+#define BU27034_GSEL_4X		0x08 /* 01000 */
+#define BU27034_GSEL_16X	0x0a /* 01010 */
+#define BU27034_GSEL_32X	0x0b /* 01011 */
+#define BU27034_GSEL_64X	0x0c /* 01100 */
+#define BU27034_GSEL_256X	0x18 /* 11000 */
+#define BU27034_GSEL_512X	0x19 /* 11001 */
+#define BU27034_GSEL_1024X	0x1a /* 11010 */
+#define BU27034_GSEL_2048X	0x1b /* 11011 */
+#define BU27034_GSEL_4096X	0x1c /* 11100 */
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
+	GAIN_SCALE_ITIME_US(55000, BU27034_MEAS_MODE_55MS, 1),
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
+	.indexed =3D 1,							\
+}
+
+static const struct iio_chan_spec bu27034_channels[] =3D {
+	{
+		.type =3D IIO_LIGHT,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
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
+		u32 mlux;
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
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.max_register =3D BU27034_REG_MAX,
+	.cache_type =3D REGCACHE_RBTREE,
+	.volatile_table =3D &bu27034_volatile_regs,
+	.wr_table =3D &bu27034_ro_regs,
+};
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
+		return FIELD_GET(BU27034_MASK_D01_GAIN, val);
+	}
+	case BU27034_CHAN_DATA2:
+	{
+		int d2_lo_bits =3D fls(BU27034_MASK_D2_GAIN_LO);
+
+		ret =3D regmap_read(data->regmap, BU27034_REG_MODE_CONTROL2, &val);
+		if (ret)
+			return ret;
+
+		/*
+		 * The data2 channel gain is composed by 5 non continuous bits
+		 * [7:6], [2:0]. Thus when we combine the 5-bit 'selector'
+		 * from register value we must right shift the high bits by 3.
+		 */
+		return FIELD_GET(BU27034_MASK_D2_GAIN_HI, val) << d2_lo_bits |
+		       FIELD_GET(BU27034_MASK_D2_GAIN_LO, val);
+	}
+	default:
+		return -EINVAL;
+	}
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
+	if (ret)
+		return ret;
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+/* Caller should hold the lock to protect lux reading */
+static int bu27034_write_gain_sel(struct bu27034_data *data, int chan, int=
 sel)
+{
+	static const int reg[] =3D {
+		[BU27034_CHAN_DATA0] =3D BU27034_REG_MODE_CONTROL2,
+		[BU27034_CHAN_DATA1] =3D BU27034_REG_MODE_CONTROL3,
+	};
+	int mask, val;
+
+	if (chan !=3D BU27034_CHAN_DATA0 && chan !=3D BU27034_CHAN_DATA1)
+		return -EINVAL;
+
+	mask =3D BU27034_MASK_D01_GAIN;
+	val =3D FIELD_PREP(mask, sel);
+
+	if (chan =3D=3D BU27034_CHAN_DATA0) {
+		/*
+		 * We keep the same gain for channel 2 as we set for channel 0
+		 * We can't allow them to be individually controlled because
+		 * setting one will impact also the other. Also, if we don't
+		 * always update both gains we may result unsupported bit
+		 * combinations.
+		 *
+		 * This is not nice but this is yet another place where the
+		 * user space must be prepared to surprizes. Namely, see chan 2
+		 * gain changed when chan 0 gain is changed.
+		 *
+		 * This is not fatal for most users though. I don't expect the
+		 * channel 2 to be used in any generic cases - the intensity
+		 * values provided by the sensor for IR area are not openly
+		 * documented. Also, channel 2 is not used for visible light.
+		 *
+		 * So, if there is application which is written to utilize the
+		 * channel 2 - then it is probably specifically targeted to this
+		 * sensor and knows how to utilize those values. It is safe to
+		 * hope such user can also cope with the gain changes.
+		 */
+		mask |=3D  BU27034_MASK_D2_GAIN_LO;
+
+		/*
+		 * The D2 gain bits are directly the lowest bits of selector.
+		 * Just do add those bits to the value
+		 */
+		val |=3D sel & BU27034_MASK_D2_GAIN_LO;
+	}
+
+	return regmap_update_bits(data->regmap, reg[chan], mask, val);
+}
+
+static int bu27034_set_gain(struct bu27034_data *data, int chan, int gain)
+{
+	int ret;
+
+	/*
+	 * We don't allow setting channel 2 gain as it messes up the
+	 * gain for channel 0 - which shares the high bits
+	 */
+	if (chan !=3D BU27034_CHAN_DATA0 && chan !=3D BU27034_CHAN_DATA1)
+		return -EINVAL;
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
+}
+
+/*
+ * We try to change the time in such way that the scale is maintained for
+ * given channels by adjusting gain so that it compensates the time change.
+ */
+static int bu27034_try_set_int_time(struct bu27034_data *data, int time_us)
+{
+	struct bu27034_gain_check gains[] =3D {
+		{ .chan =3D BU27034_CHAN_DATA0 },
+		{ .chan =3D BU27034_CHAN_DATA1 },
+	};
+	int numg =3D ARRAY_SIZE(gains);
+	int ret, int_time_old, i;
+
+	mutex_lock(&data->mutex);
+	ret =3D bu27034_get_int_time(data);
+	if (ret < 0)
+		goto unlock_out;
+
+	int_time_old =3D ret;
+
+	if (!iio_gts_valid_time(&data->gts, time_us)) {
+		dev_err(data->dev, "Unsupported integration time %u\n",
+			time_us);
+		ret =3D -EINVAL;
+
+		goto unlock_out;
+	}
+
+	if (time_us =3D=3D int_time_old) {
+		ret =3D 0;
+		goto unlock_out;
+	}
+
+	for (i =3D 0; i < numg; i++) {
+		ret =3D bu27034_get_gain(data, gains[i].chan, &gains[i].old_gain);
+		if (ret)
+			goto unlock_out;
+
+		ret =3D iio_gts_find_new_gain_by_old_gain_time(&data->gts,
+							     gains[i].old_gain,
+							     int_time_old, time_us,
+							     &gains[i].new_gain);
+		if (ret) {
+			int scale1, scale2;
+			bool ok;
+
+			_bu27034_get_scale(data, gains[i].chan, &scale1, &scale2);
+			dev_dbg(data->dev,
+				"chan %u, can't support time %u with scale %u %u\n",
+				gains[i].chan, time_us, scale1, scale2);
+
+			/*
+			 * If caller requests for integration time change and we
+			 * can't support the scale - then the caller should be
+			 * prepared to 'pick up the pieces and deal with the
+			 * fact that the scale changed'.
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
+				dev_dbg(data->dev,
+					 "Total gain increase. Risk of saturation");
+				ret =3D iio_gts_get_min_gain(&data->gts);
+				if (ret < 0)
+					goto unlock_out;
+			}
+			dev_dbg(data->dev, "chan %u scale changed\n",
+				 gains[i].chan);
+			gains[i].new_gain =3D ret;
+			dev_dbg(data->dev, "chan %u new gain %u\n",
+				gains[i].chan, gains[i].new_gain);
+		}
+	}
+
+	for (i =3D 0; i < numg; i++) {
+		ret =3D bu27034_set_gain(data, gains[i].chan, gains[i].new_gain);
+		if (ret)
+			goto unlock_out;
+	}
+
+	ret =3D bu27034_set_int_time(data, time_us);
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
+	if (chan =3D=3D BU27034_CHAN_DATA2)
+		return -EINVAL;
+
+	if (chan =3D=3D BU27034_CHAN_ALS) {
+		if (val =3D=3D 0 && val2 =3D=3D 1000)
+			return 0;
+
+		return -EINVAL;
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
+		 * Could not support scale with given time. Need to change time.
+		 * We still want to maintain the scale for all channels
+		 */
+		struct bu27034_gain_check gain;
+		int new_time_sel;
+
+		/*
+		 * Populate information for the other channel which should also
+		 * maintain the scale. (Due to the HW limitations the chan2
+		 * gets the same gain as chan0, so we only need to explicitly
+		 * set the chan 0 and 1).
+		 */
+		if (chan =3D=3D BU27034_CHAN_DATA0)
+			gain.chan =3D BU27034_CHAN_DATA1;
+		else if (chan =3D=3D BU27034_CHAN_DATA1)
+			gain.chan =3D BU27034_CHAN_DATA0;
+
+		ret =3D bu27034_get_gain(data, gain.chan, &gain.old_gain);
+		if (ret)
+			goto unlock_out;
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
+			/* Can the other channel(s) maintain scale? */
+			ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(
+				&data->gts, gain.old_gain, time_sel,
+				new_time_sel, &gain.new_gain);
+			if (!ret) {
+				/* Yes - we found suitable time */
+				found =3D true;
+				break;
+			}
+		}
+		if (!found) {
+			dev_dbg(data->dev,
+				"Can't set scale maintaining other channels\n");
+			ret =3D -EINVAL;
+
+			goto unlock_out;
+		}
+
+		ret =3D bu27034_set_gain(data, gain.chan, gain.new_gain);
+		if (ret)
+			goto unlock_out;
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
+static inline u64 gain_mul_div_helper(u64 val, unsigned int gain,
+				      unsigned int div)
+{
+	/*
+	 * Max gain for a channel is 4096. The max u64 (0xffffffffffffffffULL)
+	 * divided by 4096 is 0xFFFFFFFFFFFFF (GENMASK_ULL(51, 0)) (floored).
+	 * Thus, the 0xFFFFFFFFFFFFF is the largest value we can safely multiply
+	 * with the gain, no matter what gain is set.
+	 *
+	 * So, multiplication with max gain may overflow if val is greater than
+	 * 0xFFFFFFFFFFFFF (52 bits set)..
+	 *
+	 * If this is the case we divide first.
+	 */
+	if (val < GENMASK_ULL(51, 0)) {
+		val *=3D gain;
+		do_div(val, div);
+	} else {
+		do_div(val, div);
+		val *=3D gain;
+	}
+
+	return val;
+}
+
+static u64 bu27034_fixp_calc_t1_64bit(unsigned int coeff, unsigned int ch0,
+				      unsigned int ch1, unsigned int gain0,
+				      unsigned int gain1)
+{
+	unsigned int helper;
+	u64 helper64;
+
+	helper64 =3D (u64)coeff * (u64)ch1 * (u64)ch1;
+
+	helper =3D gain1 * gain1;
+	if (helper > ch0) {
+		do_div(helper64, helper);
+
+		return gain_mul_div_helper(helper64, gain0, ch0);
+	}
+
+	do_div(helper64, ch0);
+
+	return gain_mul_div_helper(helper64, gain0, helper);
+
+}
+
+static u64 bu27034_fixp_calc_t1(unsigned int coeff, unsigned int ch0,
+				unsigned int ch1, unsigned int gain0,
+				unsigned int gain1)
+{
+	unsigned int helper, tmp;
+
+	/*
+	 * Here we could overflow even the 64bit value. Hence we
+	 * multiply with gain0 only after the divisions - even though
+	 * it may result loss of accuracy
+	 */
+	helper =3D coeff * ch1 * ch1;
+	tmp =3D helper * gain0;
+
+	helper =3D ch1 * ch1;
+
+	if (check_mul_overflow(helper, coeff, &helper))
+		return bu27034_fixp_calc_t1_64bit(coeff, ch0, ch1, gain0, gain1);
+
+	if (check_mul_overflow(helper, gain0, &tmp))
+		return bu27034_fixp_calc_t1_64bit(coeff, ch0, ch1, gain0, gain1);
+
+	return tmp / (gain1 * gain1) / ch0;
+
+}
+
+static u64 bu27034_fixp_calc_t23(unsigned int coeff, unsigned int ch,
+				 unsigned int gain)
+{
+	unsigned int helper;
+	u64 helper64;
+
+	if (!check_mul_overflow(coeff, ch, &helper))
+		return helper / gain;
+
+	helper64 =3D (u64)coeff * (u64)ch;
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
+			 * the darkness has taken over and we are all doomed! Eh,
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
+	if (ret) {
+		dev_err(data->dev, "Read failed %d\n", ret);
+
+		return false;
+	}
+
+	return val & BU27034_MASK_VALID;
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
+	int ret =3D 0, retry_cnt =3D 0;
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
+		retry_cnt++;
+
+		if (retry_cnt > BU27034_RETRY_LIMIT) {
+			dev_err(data->dev, "No data from sensor\n");
+
+			return -ETIMEDOUT;
+		}
+
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
+	if (chan < BU27034_CHAN_DATA0 || chan > BU27034_CHAN_DATA2)
+		return -EINVAL;
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
+static int bu27034_calc_mlux(struct bu27034_data *data, __le16 *res, int *=
val)
+{
+	unsigned int gain0, gain1, meastime;
+	unsigned int d1_d0_ratio_scaled;
+	u16 ch0, ch1;
+	u64 helper64;
+	int ret;
+
+	/*
+	 * We return 0 lux if calculation fails. This should be reasonably
+	 * easy to spot from the buffers especially if raw-data channels show
+	 * valid values
+	 */
+	*val =3D 0;
+
+	ch0 =3D max_t(u16, 1, le16_to_cpu(res[0]));
+	ch1 =3D max_t(u16, 1, le16_to_cpu(res[1]));
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
+		ret =3D bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 0);
+	else if (d1_d0_ratio_scaled < 100)
+		ret =3D bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 1);
+	else
+		ret =3D bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 2);
+
+	if (ret < 0)
+		return ret;
+
+	*val =3D ret;
+
+	return 0;
+
+}
+
+static int bu27034_get_mlux(struct bu27034_data *data, int chan, int *val)
+{
+	__le16 res[3];
+	int ret;
+
+	ret =3D bu27034_meas_set(data, true);
+	if (ret)
+		return ret;
+
+	ret =3D bu27034_get_result_unlocked(data, &res[0], sizeof(res));
+	if (ret)
+		return ret;
+
+	ret =3D bu27034_calc_mlux(data, res, val);
+	if (ret)
+		return ret;
+
+	ret =3D bu27034_meas_set(data, false);
+	if (ret)
+		dev_err(data->dev, "failed to disable measurement\n");
+
+	return 0;
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
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		return bu27034_get_scale(data, chan->channel, val, val2);
+
+	case IIO_CHAN_INFO_RAW:
+	{
+		int (*result_get)(struct bu27034_data *data, int chan, int *val);
+
+		if (chan->type =3D=3D IIO_INTENSITY)
+			result_get =3D bu27034_get_single_result;
+		else if (chan->type =3D=3D IIO_LIGHT)
+			result_get =3D bu27034_get_mlux;
+		else
+			return -EINVAL;
+
+		/* Don't mess with measurement enabling while buffering */
+		ret =3D iio_device_claim_direct_mode(idev);
+		if (ret)
+			return ret;
+
+		mutex_lock(&data->mutex);
+		/*
+		 * Reading one channel at a time is inefficient but we
+		 * don't care here. Buffered version should be used if
+		 * performance is an issue.
+		 */
+		ret =3D result_get(data, chan->channel, val);
+
+		mutex_unlock(&data->mutex);
+		iio_device_release_direct_mode(idev);
+
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	}
+	default:
+		return -EINVAL;
+
+	}
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
+		return -EINVAL;
+	}
+}
+
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
+				       val, val & BU27034_MASK_VALID,
+				       BU27034_DATA_WAIT_TIME_US,
+				       BU27034_TOTAL_DATA_WAIT_TIME_US);
+	if (ret) {
+		dev_err(data->dev, "data polling %s\n",
+			!(val & BU27034_MASK_VALID) ? "timeout" : "fail");
+
+		return ret;
+	}
+
+	ret =3D regmap_bulk_read(data->regmap, BU27034_REG_DATA0_LO,
+			       &data->scan.channels[0],
+			       sizeof(data->scan.channels));
+	if (ret)
+		return ret;
+
+	bu27034_invalidate_read_data(data);
+
+	return 0;
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
+	wait_ms -=3D BU27034_MEAS_WAIT_PREMATURE_MS;
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
+		if (test_bit(BU27034_CHAN_ALS, idev->active_scan_mask)) {
+			int mlux;
+
+			ret =3D bu27034_calc_mlux(data, &data->scan.channels[0],
+					       &mlux);
+			if (ret)
+				dev_err(data->dev, "failed to calculate lux\n");
+
+			/*
+			 * The maximum Milli lux value we get with gain 1x time
+			 * 55mS data ch0 =3D 0xffff ch1 =3D 0xffff fits in 26 bits
+			 * so there should be no problem returning int from
+			 * computations and casting it to u32
+			 */
+			data->scan.mlux =3D (u32)mlux;
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
+	struct bu27034_data *data;
+	struct regmap *regmap;
+	struct iio_dev *idev;
+	unsigned int part_id, reg;
+	int ret;
+
+	regmap =3D devm_regmap_init_i2c(i2c, &bu27034_regmap);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialize Regmap\n");
+
+	idev =3D devm_iio_device_alloc(dev, sizeof(*data));
+	if (!idev)
+		return -ENOMEM;
+
+	ret =3D devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulator\n");
+
+	data =3D iio_priv(idev);
+
+	ret =3D regmap_read(regmap, BU27034_REG_SYSTEM_CONTROL, &reg);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to access sensor\n");
+
+	part_id =3D FIELD_GET(BU27034_MASK_PART_ID, reg);
+
+	if (part_id !=3D BU27034_ID)
+		dev_warn(dev, "unknown device 0x%x\n", part_id);
+
+	ret =3D devm_iio_init_iio_gts(dev, BU27034_SCALE_1X, 0, bu27034_gains,
+				    ARRAY_SIZE(bu27034_gains), bu27034_itimes,
+				    ARRAY_SIZE(bu27034_itimes), &data->gts);
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
+	if (ret)
+		return dev_err_probe(dev, ret, "buffer setup failed\n");
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
+	{ .compatible =3D "rohm,bu27034" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bu27034_of_match);
+
+static struct i2c_driver bu27034_i2c_driver =3D {
+	.driver =3D {
+		.name =3D "bu27034-als",
+		.of_match_table =3D bu27034_of_match,
+	},
+	.probe_new =3D bu27034_probe,
+};
+module_i2c_driver(bu27034_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("ROHM BU27034 ambient light sensor driver");
+MODULE_IMPORT_NS(IIO_GTS_HELPER);
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

--lcP5ZVXlDs048Vru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQhf1sACgkQeFA3/03a
ocWimgf+JJNmJK/3K8y6hTW3rHSWcLTMqQywDOQ99PmwgzKMS6qhrRmHUMO9BosN
Fk0EbFP+FYX0vDZ9H8jQ7cFEYkupZ6Wz4hM7+iR1mgXn7LBeuo74w3FKaphUmoK7
cb0IBd6kbnM0HPfQ54V0RWdjiinWTsRjWudvVgcrq3Gbwrjfl7VHanf41hjhL4SO
IiA/FY2Ma5BMYawfVC1DzHamPd6gEjk9nd13Glo745TcRmKguDi/3ZuUBKBeNuPf
PE1KdXKHuKOTBc9e9ofeO2Xj1Amen64vKL0XpI+z7aMHMRxsDKoAJglkdeU2qMv2
SswQC6ULIOqEt1GXMM7IRyvFLxdN2Q==
=gocw
-----END PGP SIGNATURE-----

--lcP5ZVXlDs048Vru--
