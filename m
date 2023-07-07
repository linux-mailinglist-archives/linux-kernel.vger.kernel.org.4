Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7106774AF9F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjGGLXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjGGLXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:23:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29792116;
        Fri,  7 Jul 2023 04:23:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso2823405e87.3;
        Fri, 07 Jul 2023 04:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688729008; x=1691321008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=un39hWLwcrkNJt4FRwfT/hbvXv35uSTSiw2O27u8OU0=;
        b=mMKL7i17l++9/UTFaWw9WY4JEzgJHsAGD6qoxPsdapblgXs5mQ2xksBWusUOkA7KpS
         rU1POATqS7IVgM07ho+0Ma8U4YYy+9Dmy9HCCx1juxfDQgOfp44QJd3rpZBbygtj5+Bi
         75aosV8kakVnbIq4TumAuOqmeGtt5iB+MpFLXForlnlYT3gFjgvkzu6n/YCNP+KIi9B4
         tWa+Ep+302N2k7DzBpt/KDz/wC42+VTfczgnEElnrb3rASslJPwuG6T//pCNhwP4u6lE
         h0ke3L0LyoYDrfXRYDVQGQUm3z7aJ3K+Wufyl2aJejx424438ktFsKshW8UC6zR2D7gf
         ZIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688729008; x=1691321008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un39hWLwcrkNJt4FRwfT/hbvXv35uSTSiw2O27u8OU0=;
        b=OIIHsq2jVy0nBjXG7yzaxFCDjy0evMj+Ks2qX+wQMK4i3qz1pGpPOJxSS7UzUXJGFJ
         gGGJtYXu3YtiR5/4+n6uP2EK97/kQfKJyx23VfApkOKV7g0EjAx5V5Gy8HtlLEAsZ89R
         y5UWwe+IZN1ELUxkXYxFsBP/9grt8w4ffWyfuJUbbl438WMYs5Cik2MkJb/KpaodAao1
         qnDshGnwvUYxZKyhklex+/gOTJQVAJRJi2WVvZ7BSkOvF0qq7KWU1njjfADyEXeLAi/X
         /ZHyRu3oRFMlwSAaB2GwB9PsFXkwGVdJNxINwsvcJ5nAZcM7zB7JjPnl031V/GjeKNqe
         Vt3w==
X-Gm-Message-State: ABy/qLY4ttVj7WKT3A2MBUsZgnlAf3RNjuDzJmLxDfM6dhS7hDa0ETc5
        C088Fxeewh7k1JRfVlYpLkg=
X-Google-Smtp-Source: APBJJlHtcL6omUtGHw7rWscrBG0U+P2l8MPFiCHC4xb5Qmw8SZ6cLR9IMKF+TsriovMvq1NLyJLanA==
X-Received: by 2002:a05:6512:78a:b0:4fb:73d1:58e5 with SMTP id x10-20020a056512078a00b004fb73d158e5mr3195938lfr.53.1688729007799;
        Fri, 07 Jul 2023 04:23:27 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id d9-20020ac24c89000000b004fb76438a83sm641602lfl.171.2023.07.07.04.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 04:23:27 -0700 (PDT)
Date:   Fri, 7 Jul 2023 14:23:23 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iio: light: bd27008: Support BD27010 RGB
Message-ID: <f6e2c7dae4de9978c53c46d9b2fade03033ce08e.1688723839.git.mazziesaccount@gmail.com>
References: <cover.1688723839.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eJa48a0eu45PbmvV"
Content-Disposition: inline
In-Reply-To: <cover.1688723839.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eJa48a0eu45PbmvV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BU27010 is an RGBC sensor with a flickering detection FIFO. The
RGBC+IR sensor functionality is largely similar to what the BU27008 has.
There are some notable things though:
  - gain setting is once again new and exotic. Now, there is 6bit gain
    setting where 4 of the bits are common to all channels and 2 bits
    can be configured separately for each channel. The BU27010 has
    similar "1X on other channels vs 2X on IR when selector is 0x0"
    gain design as BU27008 had. So, we use same gain setting policy for
    BU27010 as we did for BU27008 - driver sets same gain selector for all
    channels but shows the gains separately for all channels so users
    can (at least in theory) detect this 1X vs 2X madness...
  - BU27010 has suffled all the control register bitfields to new
    addresses and bit positions while still keeping the register naming
    same.
  - Some more power/reset control is added.
  - FIFO for "flickering detection" is added.

The control register suffling made this slightly nasty. Still, it is
easier for maintenance perspective to add the BU27010 support in BU27008
driver because - even though the bit positions/addresses were changed -
most of the driver structure can be re-used. Writing own driver for
BU27010 would mean plenty of duplicate code albeit a tad more clarity.

The flickering FIFO is not supported by the driver.

Add BU27010 RGBC+IR support to rohm-bu27008 driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - refactor changes so that this patch only adds BU27010 functionality
 - re-order bu27101 chip-data initialization

This is my 4.th re-write. My first idea was to write separate drivers
for the BU27008 and BU27010. I abandoned this as I ended up copying most
of the functions and just changing some of the bit offsets / register
addresses. This felt like a plenty of copy-paste.

So, 2.nd attempt was to combine BU27008 and BU27010. I hit the wall
as I tried to support setting RGBC / IR gains independently for BU27008
and setting the gain independently for each channel on BU27010 when
gains were such that the HW could support them independently. This went
to complete madness.

This is when I asked for a second opinion - which was to clear the mess
by separating the BU27008 and BU27010 in own drivers. After a while it
become obvious that supporting independet gains for the channels when HW
supported it required decisions which could not predictably be done for
all users. There is a comment explaining some of this in
bu27008_write_gain_sel().

After the complexity of shared gain bits was killed, the two separate
drivers started to look like a copy-paste again - and all the bugs had
to be fixed in two places... As a result I again pulled it all in one
driver. As a result of this experimenting, I firmly believe supporting
both ICs in the same driver is a correct design.
---
 drivers/iio/light/rohm-bu27008.c | 303 ++++++++++++++++++++++++++++++-
 1 file changed, 301 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27=
008.c
index 08e2b1194bf4..a88edc373d9b 100644
--- a/drivers/iio/light/rohm-bu27008.c
+++ b/drivers/iio/light/rohm-bu27008.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * BU27008 ROHM Colour Sensor
+ * ROHM Colour Sensor driver for
+ * - BU27008 RGBC sensor
+ * - BU27010 RGBC + Flickering sensor
  *
  * Copyright (c) 2023, ROHM Semiconductor.
  */
@@ -22,6 +24,25 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
=20
+/*
+ * A word about register address and mask definitions.
+ *
+ * At a quick glance to the data-sheet register tables, the BU27010 has al=
l the
+ * registers that the BU27008 has. On top of that the BU27010 adds couple =
of new
+ * ones.
+ *
+ * So, all definitions BU27008_REG_* are there also for BU27010 but none o=
f the
+ * BU27010_REG_* are present on BU27008. This makes sense as BU27010 just =
adds
+ * some features (Flicker FIFO, more power control) on top of the BU27008.
+ *
+ * Unfortunately, some of the wheel has been re-invented. Even though the =
names
+ * of the registers have stayed the same, pretty much all of the functiona=
lity
+ * provided by the registers has changed place. Contents of all MODE_CONTR=
OL
+ * registers on BU27008 and BU27010 are different.
+ *
+ * Chip-specific mapping from register addresses/bits to functionality is =
done
+ * in bu27_chip_data structures.
+ */
 #define BU27008_REG_SYSTEM_CONTROL	0x40
 #define BU27008_MASK_SW_RESET		BIT(7)
 #define BU27008_MASK_PART_ID		GENMASK(5, 0)
@@ -52,6 +73,56 @@
 #define BU27008_REG_MANUFACTURER_ID	0x92
 #define BU27008_REG_MAX BU27008_REG_MANUFACTURER_ID
=20
+/* BU27010 specific definitions */
+
+#define BU27010_MASK_SW_RESET		BIT(7)
+#define BU27010_ID			0x1b
+#define BU27010_REG_POWER		0x3e
+#define BU27010_MASK_POWER		BIT(0)
+
+#define BU27010_REG_RESET		0x3f
+#define BU27010_MASK_RESET		BIT(0)
+#define BU27010_RESET_RELEASE		BU27010_MASK_RESET
+
+#define BU27010_MASK_MEAS_EN		BIT(1)
+
+#define BU27010_MASK_CHAN_SEL		GENMASK(7, 6)
+#define BU27010_MASK_MEAS_MODE		GENMASK(5, 4)
+#define BU27010_MASK_RGBC_GAIN		GENMASK(3, 0)
+
+#define BU27010_MASK_DATA3_GAIN		GENMASK(7, 6)
+#define BU27010_MASK_DATA2_GAIN		GENMASK(5, 4)
+#define BU27010_MASK_DATA1_GAIN		GENMASK(3, 2)
+#define BU27010_MASK_DATA0_GAIN		GENMASK(1, 0)
+
+#define BU27010_MASK_FLC_MODE		BIT(7)
+#define BU27010_MASK_FLC_GAIN		GENMASK(4, 0)
+
+#define BU27010_REG_MODE_CONTROL4	0x44
+/* If flicker is ever to be supported the IRQ must be handled as a field */
+#define BU27010_IRQ_DIS_ALL		GENMASK(1, 0)
+#define BU27010_DRDY_EN			BIT(0)
+#define BU27010_MASK_INT_SEL		GENMASK(1, 0)
+
+#define BU27010_REG_MODE_CONTROL5	0x45
+#define BU27010_MASK_RGB_VALID		BIT(7)
+#define BU27010_MASK_FLC_VALID		BIT(6)
+#define BU27010_MASK_WAIT_EN		BIT(3)
+#define BU27010_MASK_FIFO_EN		BIT(2)
+#define BU27010_MASK_RGB_EN		BIT(1)
+#define BU27010_MASK_FLC_EN		BIT(0)
+
+#define BU27010_REG_DATA_FLICKER_LO	0x56
+#define BU27010_MASK_DATA_FLICKER_HI	GENMASK(2, 0)
+#define BU27010_REG_FLICKER_COUNT	0x5a
+#define BU27010_REG_FIFO_LEVEL_LO	0x5b
+#define BU27010_MASK_FIFO_LEVEL_HI	BIT(0)
+#define BU27010_REG_FIFO_DATA_LO	0x5d
+#define BU27010_REG_FIFO_DATA_HI	0x5e
+#define BU27010_MASK_FIFO_DATA_HI	GENMASK(2, 0)
+#define BU27010_REG_MANUFACTURER_ID	0x92
+#define BU27010_REG_MAX BU27010_REG_MANUFACTURER_ID
+
 /**
  * enum bu27008_chan_type - BU27008 channel types
  * @BU27008_RED:	Red channel. Always via data0.
@@ -117,6 +188,17 @@ static const unsigned long bu27008_scan_masks[] =3D {
  */
 #define BU27008_SCALE_1X 16
=20
+/*
+ * On BU27010 available scales with gain 1x - 4096x,
+ * timings 55, 100, 200, 400 mS. Time impacts to gain: 1x, 2x, 4x, 8x.
+ *
+ * =3D> Max total gain is HWGAIN * gain by integration time (8 * 4096)
+ *
+ * Using NANO precision for scale we must use scale 64x corresponding gain=
 1x
+ * to avoid precision loss.
+ */
+#define BU27010_SCALE_1X 64
+
 /* See the data sheet for the "Gain Setting" table */
 #define BU27008_GSEL_1X		0x00
 #define BU27008_GSEL_4X		0x08
@@ -152,10 +234,44 @@ static const struct iio_gain_sel_pair bu27008_gains_i=
r[] =3D {
 	GAIN_SCALE_GAIN(1024, BU27008_GSEL_1024X),
 };
=20
+#define BU27010_GSEL_1X		0x00	/* 000000 */
+#define BU27010_GSEL_4X		0x08	/* 001000 */
+#define BU27010_GSEL_16X	0x09	/* 001001 */
+#define BU27010_GSEL_64X	0x0e	/* 001110 */
+#define BU27010_GSEL_256X	0x1e	/* 011110 */
+#define BU27010_GSEL_1024X	0x2e	/* 101110 */
+#define BU27010_GSEL_4096X	0x3f	/* 111111 */
+
+static const struct iio_gain_sel_pair bu27010_gains[] =3D {
+	GAIN_SCALE_GAIN(1, BU27010_GSEL_1X),
+	GAIN_SCALE_GAIN(4, BU27010_GSEL_4X),
+	GAIN_SCALE_GAIN(16, BU27010_GSEL_16X),
+	GAIN_SCALE_GAIN(64, BU27010_GSEL_64X),
+	GAIN_SCALE_GAIN(256, BU27010_GSEL_256X),
+	GAIN_SCALE_GAIN(1024, BU27010_GSEL_1024X),
+	GAIN_SCALE_GAIN(4096, BU27010_GSEL_4096X),
+};
+
+static const struct iio_gain_sel_pair bu27010_gains_ir[] =3D {
+	GAIN_SCALE_GAIN(2, BU27010_GSEL_1X),
+	GAIN_SCALE_GAIN(4, BU27010_GSEL_4X),
+	GAIN_SCALE_GAIN(16, BU27010_GSEL_16X),
+	GAIN_SCALE_GAIN(64, BU27010_GSEL_64X),
+	GAIN_SCALE_GAIN(256, BU27010_GSEL_256X),
+	GAIN_SCALE_GAIN(1024, BU27010_GSEL_1024X),
+	GAIN_SCALE_GAIN(4096, BU27010_GSEL_4096X),
+};
+
 #define BU27008_MEAS_MODE_100MS		0x00
 #define BU27008_MEAS_MODE_55MS		0x01
 #define BU27008_MEAS_MODE_200MS		0x02
 #define BU27008_MEAS_MODE_400MS		0x04
+
+#define BU27010_MEAS_MODE_100MS		0x00
+#define BU27010_MEAS_MODE_55MS		0x03
+#define BU27010_MEAS_MODE_200MS		0x01
+#define BU27010_MEAS_MODE_400MS		0x02
+
 #define BU27008_MEAS_TIME_MAX_MS	400
=20
 static const struct iio_itime_sel_mul bu27008_itimes[] =3D {
@@ -165,6 +281,13 @@ static const struct iio_itime_sel_mul bu27008_itimes[]=
 =3D {
 	GAIN_SCALE_ITIME_US(55000, BU27008_MEAS_MODE_55MS, 1),
 };
=20
+static const struct iio_itime_sel_mul bu27010_itimes[] =3D {
+	GAIN_SCALE_ITIME_US(400000, BU27010_MEAS_MODE_400MS, 8),
+	GAIN_SCALE_ITIME_US(200000, BU27010_MEAS_MODE_200MS, 4),
+	GAIN_SCALE_ITIME_US(100000, BU27010_MEAS_MODE_100MS, 2),
+	GAIN_SCALE_ITIME_US(55000, BU27010_MEAS_MODE_55MS, 1),
+};
+
 /*
  * All the RGBC channels share the same gain.
  * IR gain can be fine-tuned from the gain set for the RGBC by 2 bit, but =
this
@@ -268,11 +391,29 @@ static const struct regmap_range bu27008_volatile_ran=
ges[] =3D {
 	},
 };
=20
+static const struct regmap_range bu27010_volatile_ranges[] =3D {
+	{
+		.range_min =3D BU27010_REG_RESET,			/* RSTB */
+		.range_max =3D BU27008_REG_SYSTEM_CONTROL,	/* RESET */
+	}, {
+		.range_min =3D BU27010_REG_MODE_CONTROL5,		/* VALID bits */
+		.range_max =3D BU27010_REG_MODE_CONTROL5,
+	}, {
+		.range_min =3D BU27008_REG_DATA0_LO,
+		.range_max =3D BU27010_REG_FIFO_DATA_HI,
+	},
+};
+
 static const struct regmap_access_table bu27008_volatile_regs =3D {
 	.yes_ranges =3D &bu27008_volatile_ranges[0],
 	.n_yes_ranges =3D ARRAY_SIZE(bu27008_volatile_ranges),
 };
=20
+static const struct regmap_access_table bu27010_volatile_regs =3D {
+	.yes_ranges =3D &bu27010_volatile_ranges[0],
+	.n_yes_ranges =3D ARRAY_SIZE(bu27010_volatile_ranges),
+};
+
 static const struct regmap_range bu27008_read_only_ranges[] =3D {
 	{
 		.range_min =3D BU27008_REG_DATA0_LO,
@@ -283,11 +424,26 @@ static const struct regmap_range bu27008_read_only_ra=
nges[] =3D {
 	},
 };
=20
+static const struct regmap_range bu27010_read_only_ranges[] =3D {
+	{
+		.range_min =3D BU27008_REG_DATA0_LO,
+		.range_max =3D BU27010_REG_FIFO_DATA_HI,
+	}, {
+		.range_min =3D BU27010_REG_MANUFACTURER_ID,
+		.range_max =3D BU27010_REG_MANUFACTURER_ID,
+	}
+};
+
 static const struct regmap_access_table bu27008_ro_regs =3D {
 	.no_ranges =3D &bu27008_read_only_ranges[0],
 	.n_no_ranges =3D ARRAY_SIZE(bu27008_read_only_ranges),
 };
=20
+static const struct regmap_access_table bu27010_ro_regs =3D {
+	.no_ranges =3D &bu27010_read_only_ranges[0],
+	.n_no_ranges =3D ARRAY_SIZE(bu27010_read_only_ranges),
+};
+
 static const struct regmap_config bu27008_regmap =3D {
 	.reg_bits =3D 8,
 	.val_bits =3D 8,
@@ -310,6 +466,17 @@ static const struct regmap_config bu27008_regmap =3D {
 	.disable_locking =3D true,
 };
=20
+static const struct regmap_config bu27010_regmap =3D {
+	.reg_bits	=3D 8,
+	.val_bits	=3D 8,
+
+	.max_register	=3D BU27010_REG_MAX,
+	.cache_type	=3D REGCACHE_RBTREE,
+	.volatile_table =3D &bu27010_volatile_regs,
+	.wr_table	=3D &bu27010_ro_regs,
+	.disable_locking =3D true,
+};
+
 static int bu27008_write_gain_sel(struct bu27008_data *data, int sel)
 {
 	int regval;
@@ -351,6 +518,41 @@ static int bu27008_write_gain_sel(struct bu27008_data =
*data, int sel)
 				  BU27008_MASK_RGBC_GAIN, regval);
 }
=20
+static int bu27010_write_gain_sel(struct bu27008_data *data, int sel)
+{
+	unsigned int regval;
+	int ret, chan_selector;
+
+	/*
+	 * Gain 'selector' is composed of two registers. Selector is 6bit value,
+	 * 4 high bits being the RGBC gain fieild in MODE_CONTROL1 register and
+	 * two low bits being the channel specific gain in MODE_CONTROL2.
+	 *
+	 * Let's take the 4 high bits of whole 6 bit selector, and prepare
+	 * the MODE_CONTROL1 value (RGBC gain part).
+	 */
+	regval =3D FIELD_PREP(BU27010_MASK_RGBC_GAIN, (sel >> 2));
+
+	ret =3D regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL1,
+				  BU27010_MASK_RGBC_GAIN, regval);
+	if (ret)
+		return ret;
+
+	/*
+	 * Two low two bits of the selector must be written for all 4
+	 * channels in the MODE_CONTROL2 register. Copy these two bits for
+	 * all channels.
+	 */
+	chan_selector =3D sel & GENMASK(1, 0);
+
+	regval =3D FIELD_PREP(BU27010_MASK_DATA0_GAIN, chan_selector);
+	regval |=3D FIELD_PREP(BU27010_MASK_DATA1_GAIN, chan_selector);
+	regval |=3D FIELD_PREP(BU27010_MASK_DATA2_GAIN, chan_selector);
+	regval |=3D FIELD_PREP(BU27010_MASK_DATA3_GAIN, chan_selector);
+
+	return regmap_write(data->regmap, BU27008_REG_MODE_CONTROL2, regval);
+}
+
 static int bu27008_get_gain_sel(struct bu27008_data *data, int *sel)
 {
 	int ret;
@@ -377,6 +579,30 @@ static int bu27008_get_gain_sel(struct bu27008_data *d=
ata, int *sel)
 	return 0;
 }
=20
+static int bu27010_get_gain_sel(struct bu27008_data *data, int *sel)
+{
+	int ret, tmp;
+
+	/*
+	 * We always "lock" the gain selectors for all channels to prevent
+	 * unsupported configs. It does not matter which channel is used
+	 * we can just return selector from any of them.
+	 */
+	ret =3D regmap_read(data->regmap, BU27008_REG_MODE_CONTROL2, sel);
+	if (ret)
+		return ret;
+
+	*sel =3D FIELD_GET(BU27010_MASK_DATA0_GAIN, *sel);
+
+	ret =3D regmap_read(data->regmap, BU27008_REG_MODE_CONTROL1, &tmp);
+	if (ret)
+		return ret;
+
+	*sel |=3D FIELD_GET(BU27010_MASK_RGBC_GAIN, tmp) << fls(BU27010_MASK_DATA=
0_GAIN);
+
+	return ret;
+}
+
 static int bu27008_chip_init(struct bu27008_data *data)
 {
 	int ret;
@@ -401,6 +627,78 @@ static int bu27008_chip_init(struct bu27008_data *data)
 	return ret;
 }
=20
+static int bu27010_chip_init(struct bu27008_data *data)
+{
+	int ret;
+
+	ret =3D regmap_write_bits(data->regmap, BU27008_REG_SYSTEM_CONTROL,
+				BU27010_MASK_SW_RESET, BU27010_MASK_SW_RESET);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
+
+	msleep(1);
+
+	/* Power ON*/
+	ret =3D regmap_write_bits(data->regmap, BU27010_REG_POWER,
+				BU27010_MASK_POWER, BU27010_MASK_POWER);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Sensor power-on failed\n");
+
+	msleep(1);
+
+	/* Release blocks from reset */
+	ret =3D regmap_write_bits(data->regmap, BU27010_REG_RESET,
+				BU27010_MASK_RESET, BU27010_RESET_RELEASE);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Sensor powering failed\n");
+
+	msleep(1);
+
+	/*
+	 * The IRQ enabling on BU27010 is done in a peculiar way. The IRQ
+	 * enabling is not a bit mask where individual IRQs could be enabled but
+	 * a field which values are:
+	 * 00 =3D> IRQs disabled
+	 * 01 =3D> Data-ready (RGBC/IR)
+	 * 10 =3D> Data-ready (flicker)
+	 * 11 =3D> Flicker FIFO
+	 *
+	 * So, only one IRQ can be enabled at a time and enabling for example
+	 * flicker FIFO would automagically disable data-ready IRQ.
+	 *
+	 * Currently the driver does not support the flicker. Hence, we can
+	 * just treat the RGBC data-ready as single bit which can be enabled /
+	 * disabled. This works for as long as the second bit in the field
+	 * stays zero. Here we ensure it gets zeroed.
+	 */
+	return regmap_clear_bits(data->regmap, BU27010_REG_MODE_CONTROL4,
+				 BU27010_IRQ_DIS_ALL);
+}
+
+static const struct bu27_chip_data bu27010_chip =3D {
+	.name =3D "bu27010",
+	.chip_init =3D bu27010_chip_init,
+	.get_gain_sel =3D bu27010_get_gain_sel,
+	.write_gain_sel =3D bu27010_write_gain_sel,
+	.regmap_cfg =3D &bu27010_regmap,
+	.gains =3D &bu27010_gains[0],
+	.gains_ir =3D &bu27010_gains_ir[0],
+	.itimes =3D &bu27010_itimes[0],
+	.num_gains =3D ARRAY_SIZE(bu27010_gains),
+	.num_gains_ir =3D ARRAY_SIZE(bu27010_gains_ir),
+	.num_itimes =3D ARRAY_SIZE(bu27010_itimes),
+	.scale1x =3D BU27010_SCALE_1X,
+	.drdy_en_reg =3D BU27010_REG_MODE_CONTROL4,
+	.drdy_en_mask =3D BU27010_DRDY_EN,
+	.meas_en_reg =3D BU27010_REG_MODE_CONTROL5,
+	.meas_en_mask =3D BU27010_MASK_MEAS_EN,
+	.valid_reg =3D BU27010_REG_MODE_CONTROL5,
+	.chan_sel_reg =3D BU27008_REG_MODE_CONTROL1,
+	.chan_sel_mask =3D BU27010_MASK_CHAN_SEL,
+	.int_time_mask =3D BU27010_MASK_MEAS_MODE,
+	.part_id =3D BU27010_ID,
+};
+
 static const struct bu27_chip_data bu27008_chip =3D {
 	.name =3D "bu27008",
 	.chip_init =3D bu27008_chip_init,
@@ -1115,6 +1413,7 @@ static int bu27008_probe(struct i2c_client *i2c)
=20
 static const struct of_device_id bu27008_of_match[] =3D {
 	{ .compatible =3D "rohm,bu27008", .data =3D &bu27008_chip },
+	{ .compatible =3D "rohm,bu27010", .data =3D &bu27010_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bu27008_of_match);
@@ -1129,7 +1428,7 @@ static struct i2c_driver bu27008_i2c_driver =3D {
 };
 module_i2c_driver(bu27008_i2c_driver);
=20
-MODULE_DESCRIPTION("ROHM BU27008 colour sensor driver");
+MODULE_DESCRIPTION("ROHM BU27008 and BU27010 colour sensor driver");
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS(IIO_GTS_HELPER);
--=20
2.40.1


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

--eJa48a0eu45PbmvV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmSn9asACgkQeFA3/03a
ocVZbQgAx19FUEvqh0RSyfaZcOceIhK59Gz23ql3HXvJ1gPGuQvha0YE0F7nTkzJ
DiBth8PvZSXYxH36bN1CLEWcv/iHdPBAFv1lInmYOwltIjpIX+UiocpwZ8LakSTp
y11CD53GAWRV2Z2kCrsT4qMjjC9Hv+FInrVw53OAIC87dqYD54YGzRcUsD+WE8io
0lNw8qTTAeXPSv1L/qW4IDQbs0K67AavMjpJkSVrz9G9Wi7VtyLUY0vGNB5FC3up
9bMxeWWDI7t8V62gLVthLOFhYzL/VUmeGocn7WoyGWd69Dg4ZZ+S28ofVouplbsx
5HgBkmqVANp6fhYxcN4ZEAQo0UCCuw==
=zii3
-----END PGP SIGNATURE-----

--eJa48a0eu45PbmvV--
