Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321DB5BFD25
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiIULpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIULps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:45:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD0188DC2;
        Wed, 21 Sep 2022 04:45:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j16so8766287lfg.1;
        Wed, 21 Sep 2022 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vE9tjMqEQ2e8hncasbyM91Clo6RABGo2iHZ34XvX7kg=;
        b=oWAt8UVKA84oxHOICYMThXQ/rCX9AvtAEj/Adag5nNxlb5UAKyZiGqz5XPbj+2qZmo
         A8rEcU1Tus7QV4CGHQ8wl7D8GFy5Y3DqdewdHyLt3yB2tx5lnw+EBbLMkNVJDx+2vKE+
         lhxELyk+YO8jz3kKYcBT6qsKUZkEah32LHYY+hRPpKDKuEJKuKFwVB6/vZ98kX45qFzJ
         LCpzvp43MWsp/29I00pRHYhTS8yCCpYdBe8hR9ExYhjLp7x33g7cIyLceBVu0YtoXEc5
         74Y+VjqkWtBMN6PRe+kuBTMxlKKAIURt88v9BOT2zd7Gttk7/Qa1L2z5JCj5ofYPKXFA
         6xZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vE9tjMqEQ2e8hncasbyM91Clo6RABGo2iHZ34XvX7kg=;
        b=evsSJaHdUC14rjTdT4PW32w+jAAWzX/EYVkqbsoUwRfrBDD1WJqkdQqiOgt+xaZ/CB
         EQr78TEygohmvrI3AZf7KmkPTnGFiHt4BtHhclE4cM13PdbiTnzvsdOQFbNIjL8/RlF4
         Rz0Q1x1UqP+fGS9ozUfzK15t7HF08OX0wFwLtfyIepmkVcnEdxRW14/LYoE84oS6rcGe
         nLZtfshuWpVrItOws0ywpu2n6y/PbU0K1TMfup+nNA1pI7HfL5URTsNhu59kXHcwE6JY
         wQDXJcMIVD4mKVupGHHA4VGb4b5WVyv3HU32ZwBlBaGUNA6ayf8VfyjqV/HRmH4vjraY
         xdjw==
X-Gm-Message-State: ACrzQf0WK7wacV6CuQ40G+X8uyriOwl7QV8EXF0X060vkzZIXayOQSAI
        Fw4XI1Q7dljvn0wegpNvKnc=
X-Google-Smtp-Source: AMsMyM5ucf479N2qxdPdDxHz8GvYaGfIvO6611X3eSs5tOz5kkOFGYjwv4uetGtwth5cUHlgVF7/vQ==
X-Received: by 2002:a05:6512:3e14:b0:499:1f71:1680 with SMTP id i20-20020a0565123e1400b004991f711680mr9873594lfv.114.1663760741589;
        Wed, 21 Sep 2022 04:45:41 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id o7-20020ac25e27000000b00497a8f04905sm389363lfg.251.2022.09.21.04.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:45:40 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:45:35 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A accelerometer
Message-ID: <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uR/TaYYjTDxGy3zF"
Content-Disposition: inline
In-Reply-To: <cover.1663760018.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uR/TaYYjTDxGy3zF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

KX022A is a 3-axis Accelerometer from ROHM/Kionix. The senor features
include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
tap/motion detection, wake-up & back-to-sleep events, four acceleration
ranges (2, 4, 8 and 16g) and probably some other cool fatures.

Add support for the basic accelerometer features such as getting the
acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
using the WMI IRQ).

Important things to be added include the double-tap, motion
detection and wake-up as well as the runtime power management.

NOTE: Filling-up the hardware FIFO should be avoided. During my testing
I noticed that filling up the hardware FIFO might mess-up the sample
count. My sensor ended up in a state where amount of data in FIFO was
reported to be 0xff bytes, which equals to 42,5 samples. Specification
says the FIFO can hold maximum of 41 samples in HiRes mode. Also, at
least once the FIFO was stuck in a state where reading data from
hwardware FIFO did not decrease the amount of data reported to be in the
FIFO - eg. FIFO was "stuck". The code has now an error count and 10
reads with invalid FIFO data count will cause the fifo contents to be
dropped.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/accel/Kconfig             |   23 +
 drivers/iio/accel/Makefile            |    3 +
 drivers/iio/accel/kionix-kx022a-i2c.c |   52 ++
 drivers/iio/accel/kionix-kx022a-spi.c |   50 ++
 drivers/iio/accel/kionix-kx022a.c     | 1149 +++++++++++++++++++++++++
 drivers/iio/accel/kionix-kx022a.h     |   76 ++
 6 files changed, 1353 insertions(+)
 create mode 100644 drivers/iio/accel/kionix-kx022a-i2c.c
 create mode 100644 drivers/iio/accel/kionix-kx022a-spi.c
 create mode 100644 drivers/iio/accel/kionix-kx022a.c
 create mode 100644 drivers/iio/accel/kionix-kx022a.h

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 35798712f811..12ad6bcb2c76 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -409,6 +409,29 @@ config IIO_ST_ACCEL_SPI_3AXIS
 	  To compile this driver as a module, choose M here. The module
 	  will be called st_accel_spi.
=20
+config IIO_KX022A
+	tristate
+
+config IIO_KX022A_SPI
+	tristate "Kionix KX022A tri-axis digital accelerometer"
+	depends on I2C
+	select IIO_KX022A
+	select REGMAP_SPI
+	help
+	  Say Y here to enable support for the Kionix KX022A digital tri-axis
+	  accelerometer connected to I2C interface. See IIO_KX022A_I2C if
+	  you want to enable support for the KX022A connected via I2C.
+
+config IIO_KX022A_I2C
+	tristate "Kionix KX022A tri-axis digital accelerometer"
+	depends on I2C
+	select IIO_KX022A
+	select REGMAP_I2C
+	help
+	  Say Y here to enable support for the Kionix KX022A digital tri-axis
+	  accelerometer connected to I2C interface. See IIO_KX022A_SPI if
+	  you want to enable support for the KX022A connected via SPI.
+
 config KXSD9
 	tristate "Kionix KXSD9 Accelerometer Driver"
 	select IIO_BUFFER
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 4d8792668838..7bd654b74f42 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -40,6 +40,9 @@ obj-$(CONFIG_FXLS8962AF)	+=3D fxls8962af-core.o
 obj-$(CONFIG_FXLS8962AF_I2C)	+=3D fxls8962af-i2c.o
 obj-$(CONFIG_FXLS8962AF_SPI)	+=3D fxls8962af-spi.o
 obj-$(CONFIG_HID_SENSOR_ACCEL_3D) +=3D hid-sensor-accel-3d.o
+obj-$(CONFIG_IIO_KX022A)	+=3D kionix-kx022a.o
+obj-$(CONFIG_IIO_KX022A_I2C)	+=3D kionix-kx022a-i2c.o
+obj-$(CONFIG_IIO_KX022A_SPI)	+=3D kionix-kx022a-spi.o
 obj-$(CONFIG_KXCJK1013) +=3D kxcjk-1013.o
 obj-$(CONFIG_KXSD9)	+=3D kxsd9.o
 obj-$(CONFIG_KXSD9_SPI)	+=3D kxsd9-spi.o
diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kion=
ix-kx022a-i2c.c
new file mode 100644
index 000000000000..2dbf8a33b84b
--- /dev/null
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (C) 2022 ROHM Semiconductors
+//
+// ROHM/KIONIX KX022A accelerometer driver
+
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "kionix-kx022a.h"
+
+static int kx022a_i2c_probe(struct i2c_client *i2c)
+{
+	struct regmap *regmap;
+	struct device *dev =3D &i2c->dev;
+
+	if (!i2c->irq) {
+		dev_err(dev, "No IRQ configured\n");
+		return -EINVAL;
+	}
+
+	regmap =3D devm_regmap_init_i2c(i2c, &kx022a_regmap);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to initialize Regmap\n");
+
+		return PTR_ERR(regmap);
+	}
+
+	return kx022a_probe_internal(dev, i2c->irq);
+}
+
+static const struct of_device_id kx022a_of_match[] =3D {
+	{ .compatible =3D "kionix,kx022a", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, kx022a_of_match);
+
+static struct i2c_driver kx022a_i2c_driver =3D {
+	.driver =3D {
+			.name  =3D "kx022a-i2c",
+			.of_match_table =3D kx022a_of_match,
+		  },
+	.probe_new    =3D kx022a_i2c_probe,
+};
+
+module_i2c_driver(kx022a_i2c_driver);
+
+MODULE_DESCRIPTION("ROHM/Kionix KX022A accelerometer driver");
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kion=
ix-kx022a-spi.c
new file mode 100644
index 000000000000..007f4b726d8f
--- /dev/null
+++ b/drivers/iio/accel/kionix-kx022a-spi.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (C) 2022 ROHM Semiconductors
+//
+// ROHM/KIONIX KX022A accelerometer driver
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "kionix-kx022a.h"
+
+static int kx022a_spi_probe(struct spi_device *spi)
+{
+	struct device *dev =3D &spi->dev;
+	struct regmap *regmap;
+
+	if (!spi->irq) {
+		dev_err(dev, "No IRQ configured\n");
+		return -EINVAL;
+	}
+
+	regmap =3D devm_regmap_init_spi(spi, &kx022a_regmap);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to initialize Regmap\n");
+
+		return PTR_ERR(regmap);
+	}
+	return kx022a_probe_internal(dev, spi->irq);
+}
+
+static const struct of_device_id kx022a_of_match[] =3D {
+	{ .compatible =3D "kionix,kx022a", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, kx022a_of_match);
+
+static struct spi_driver kx022a_spi_driver =3D {
+	.driver =3D {
+		.name   =3D "kx022a-spi",
+	},
+	.probe	=3D kx022a_spi_probe,
+};
+
+module_spi_driver(kx022a_spi_driver);
+
+MODULE_DESCRIPTION("ROHM/Kionix kx022A accelerometer driver");
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
new file mode 100644
index 000000000000..9f9e0d7efc09
--- /dev/null
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -0,0 +1,1149 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (C) 2022 ROHM Semiconductors
+//
+// ROHM/KIONIX KX022A accelerometer driver
+
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#include "kionix-kx022a.h"
+
+/*
+ * Threshold for deciding our HW fifo is unrecoverably corrupt and should =
be
+ * cleared
+ */
+#define KXO22A_FIFO_ERR_THRESHOLD 10
+#define KX022A_FIFO_LENGTH 41
+/* 3 axis, 2 bytes of data for each of the axis */
+#define KX022A_FIFO_SAMPLES_SIZE_BYTES 6
+#define KX022A_FIFO_MAX_BYTES (KX022A_FIFO_LENGTH *			\
+			       KX022A_FIFO_SAMPLES_SIZE_BYTES)
+
+#define MIN_ODR_INTERVAL_MS 5
+#define MAX_ODR_INTERVAL_MS 1280
+#define NUM_SUPPORTED_ODR 9
+
+enum {
+	KX022A_STATE_SAMPLE,
+	KX022A_STATE_FIFO,
+};
+
+/* Regmap configs */
+static const struct regmap_range kx022a_volatile_ranges[] =3D {
+	{
+		.range_min =3D KX022A_REG_XHP_L,
+		.range_max =3D KX022A_REG_COTR,
+	}, {
+		.range_min =3D KX022A_REG_TSCP,
+		.range_max =3D KX022A_REG_INT_REL,
+	}, {
+		.range_min =3D KX022A_REG_BUF_STATUS_1,
+		.range_max =3D KX022A_REG_BUF_READ,
+	},
+};
+
+static const struct regmap_access_table kx022a_volatile_regs =3D {
+	.yes_ranges =3D &kx022a_volatile_ranges[0],
+	.n_yes_ranges =3D ARRAY_SIZE(kx022a_volatile_ranges),
+};
+
+static const struct regmap_range kx022a_precious_ranges[] =3D {
+	{
+		.range_min =3D KX022A_REG_INT_REL,
+		.range_max =3D KX022A_REG_INT_REL,
+	},
+};
+
+static const struct regmap_access_table kx022a_precious_regs =3D {
+	.yes_ranges =3D &kx022a_precious_ranges[0],
+	.n_yes_ranges =3D ARRAY_SIZE(kx022a_precious_ranges),
+};
+
+/*
+ * The HW does not set WHO_AM_I reg as read-only but we don't want to writ=
e it
+ * so we still include it in the read-only ranges.
+ */
+static const struct regmap_range kx022a_read_only_ranges[] =3D {
+	{
+		.range_min =3D KX022A_REG_XHP_L,
+		.range_max =3D KX022A_REG_INT_REL,
+	}, {
+		.range_min =3D KX022A_REG_BUF_STATUS_1,
+		.range_max =3D KX022A_REG_BUF_STATUS_2,
+	}, {
+		.range_min =3D KX022A_REG_BUF_READ,
+		.range_max =3D KX022A_REG_BUF_READ,
+	},
+};
+
+static const struct regmap_access_table kx022a_ro_regs =3D {
+	.no_ranges =3D &kx022a_read_only_ranges[0],
+	.n_no_ranges =3D ARRAY_SIZE(kx022a_read_only_ranges),
+};
+
+static const struct regmap_range kx022a_write_only_ranges[] =3D {
+	{
+		.range_min =3D KX022A_REG_BTS_WUF_TH,
+		.range_max =3D KX022A_REG_BTS_WUF_TH,
+	}, {
+		.range_min =3D KX022A_REG_MAN_WAKE,
+		.range_max =3D KX022A_REG_MAN_WAKE,
+	}, {
+		.range_min =3D KX022A_REG_SELF_TEST,
+		.range_max =3D KX022A_REG_SELF_TEST,
+	}, {
+		.range_min =3D KX022A_REG_BUF_CLEAR,
+		.range_max =3D KX022A_REG_BUF_CLEAR,
+	},
+};
+
+static const struct regmap_access_table kx022a_wo_regs =3D {
+	.no_ranges =3D &kx022a_write_only_ranges[0],
+	.n_no_ranges =3D ARRAY_SIZE(kx022a_write_only_ranges),
+};
+
+static const struct regmap_range kx022a_noinc_read_ranges[] =3D {
+	{
+		.range_min =3D KX022A_REG_BUF_READ,
+		.range_max =3D KX022A_REG_BUF_READ,
+	},
+};
+
+static const struct regmap_access_table kx022a_nir_regs =3D {
+	.yes_ranges =3D &kx022a_noinc_read_ranges[0],
+	.n_yes_ranges =3D ARRAY_SIZE(kx022a_noinc_read_ranges),
+};
+
+const struct regmap_config kx022a_regmap =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.volatile_table =3D &kx022a_volatile_regs,
+	.rd_table =3D &kx022a_wo_regs,
+	.wr_table =3D &kx022a_ro_regs,
+	.rd_noinc_table =3D &kx022a_nir_regs,
+	.precious_table =3D &kx022a_precious_regs,
+	.max_register =3D KX022A_MAX_REGISTER,
+	.cache_type =3D REGCACHE_RBTREE,
+};
+EXPORT_SYMBOL_GPL(kx022a_regmap);
+
+struct kx022a_data;
+
+struct kx022a_trigger {
+	struct kx022a_data *data;
+	struct iio_trigger *indio_trig;
+	bool enabled;
+	const char *name;
+};
+
+struct kx022a_data {
+	int irq;
+	struct regmap *regmap;
+	struct kx022a_trigger trigger;
+	struct device *dev;
+	unsigned int g_range;
+	struct mutex mutex;
+	unsigned int state;
+
+	int64_t timestamp, old_timestamp;
+	unsigned int odr_ns;
+
+	struct iio_mount_matrix orientation;
+	u8 watermark;
+	/* 3 x 16bit accel data + timestamp */
+	s16 buffer[8];
+	struct {
+		__le16 channels[3];
+		s64 ts __aligned(8);
+	} scan;
+};
+
+static const struct iio_mount_matrix *
+kx022a_get_mount_matrix(const struct iio_dev *idev,
+			const struct iio_chan_spec *chan)
+{
+	struct kx022a_data *data =3D iio_priv(idev);
+
+	return &data->orientation;
+}
+
+enum {
+	AXIS_X,
+	AXIS_Y,
+	AXIS_Z,
+	AXIS_MAX,
+};
+
+static const unsigned long kx022a_scan_masks[] =3D {
+					BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
+					0};
+
+static const struct iio_chan_spec_ext_info kx022a_ext_info[] =3D {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, kx022a_get_mount_matrix),
+	{ },
+};
+
+#define KX022A_ACCEL_CHAN(axis, index)						\
+	{								\
+		.type =3D IIO_ACCEL,					\
+		.modified =3D 1,						\
+		.channel2 =3D IIO_MOD_##axis,				\
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |	\
+					BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+		.ext_info =3D kx022a_ext_info,				\
+		.address =3D KX022A_REG_##axis##OUT_L,				\
+		.scan_index =3D index,					\
+		.scan_type =3D {                                          \
+			.sign =3D 's',					\
+			.realbits =3D 16,					\
+			.storagebits =3D 16,				\
+			.shift =3D 0,					\
+			.endianness =3D IIO_LE,				\
+		},							\
+	}
+
+static const struct iio_chan_spec kx022a_channels[] =3D {
+	KX022A_ACCEL_CHAN(X, 0),
+	KX022A_ACCEL_CHAN(Y, 1),
+	KX022A_ACCEL_CHAN(Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+/*
+ * The sensor HW can support ODR up to 1600 Hz - which is beyond what most=
 of
+ * Linux CPUs can handle w/o dropping samples. Also, the low power mode is=
 not
+ * available for higher sample rates. Thus the driver only supports 200 Hz=
 and
+ * slower ODRs. Slowest being 0.78 Hz
+ */
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.78 1.563 3.125 6.25 12.5 25 50 10=
0 200");
+static IIO_CONST_ATTR(scale_available,
+		      "598.550415 1197.10083 2394.20166 4788.40332");
+
+static struct attribute *kx022a_attributes[] =3D {
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_const_attr_scale_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group kx022a_attrs_group =3D {
+	.attrs =3D kx022a_attributes,
+};
+
+struct kx022a_tuple {
+	int val;
+	int val2;
+};
+
+/*
+ * range is typically +-2G/4G/8G/16G, distributed over the amount of bits.
+ * The scale table can be calculated using
+ *	(range / 2^bits) * g =3D (range / 2^bits) * 9.80665 m/s^2
+ *	=3D> KX022A uses 16 bit (HiRes mode - assume the low 8 bits are zeroed
+ *	in low-power mode(?) )
+ *	=3D> +/-2G  =3D> 4 / 2^16 * 9,80665 * 10^6 (to scale to micro)
+ *	=3D> +/-2G  - 598.550415
+ *	   +/-4G  - 1197.10083
+ *	   +/-8G  - 2394.20166
+ *	   +/-16G - 4788.40332
+ */
+static const struct kx022a_tuple kx022a_scale_table[] =3D {
+	{ 598, 550415 }, { 1197, 100830 }, { 2394, 201660 }, { 4788, 403320 }
+};
+
+/*
+ * ODR (output data rate) table. First value represents the integer portio=
n of
+ * frequency (Hz), and the second value is the decimal part (uHz).
+ * Eg, 0.78 Hz, 1.563 Hz, ...
+ */
+#define KX922A_DEFAULT_PERIOD 20000000
+static const struct kx022a_tuple kx022a_accel_samp_freq_table[] =3D {
+	{ 0, 780000 }, { 1, 563000 }, { 3, 125000 }, { 6, 250000 },
+	{ 12, 500000 }, { 25, 0 }, { 50, 0 }, { 100, 0 }, { 200, 0 }
+};
+static const unsigned int kx022a_odrs[] =3D { 1282051282, 639795266, 32000=
0000,
+	 160000000, 80000000, 40000000, 20000000, 10000000, 5000000 };
+
+/* Find index of tuple matching the given values */
+static int kx022a_find_tuple_index(const struct kx022a_tuple *tuples, int =
n,
+				   int val, int val2)
+{
+	while (n-- > 0)
+		if (val =3D=3D tuples[n].val && tuples[n].val2 =3D=3D val2)
+			return n;
+
+	return -EINVAL;
+}
+
+static void kx022a_reg2freq(unsigned int val,  int *val1, int *val2)
+{
+	*val1 =3D kx022a_accel_samp_freq_table[val & KX022A_MASK_ODR].val;
+	*val2 =3D kx022a_accel_samp_freq_table[val & KX022A_MASK_ODR].val2;
+}
+
+static void kx022a_reg2scale(unsigned int val, unsigned int *val1,
+			     unsigned int *val2)
+{
+	val &=3D KX022A_MASK_GSEL;
+	val >>=3D KX022A_GSEL_SHIFT;
+
+	*val1 =3D kx022a_scale_table[val].val;
+	*val2 =3D kx022a_scale_table[val].val2;
+}
+
+static int __kx022a_turn_on_unlocked(struct kx022a_data *data)
+{
+	int ret;
+
+	ret =3D regmap_set_bits(data->regmap, KX022A_REG_CNTL, KX022A_MASK_PC1);
+	if (ret)
+		dev_err(data->dev, "Turn ON fail %d\n", ret);
+
+	return ret;
+}
+
+static int __kx022a_turn_off_unlocked(struct kx022a_data *data)
+{
+	int ret;
+
+	ret =3D regmap_clear_bits(data->regmap, KX022A_REG_CNTL, KX022A_MASK_PC1);
+	if (ret)
+		dev_err(data->dev, "Turn OFF fail %d\n", ret);
+
+	return ret;
+}
+
+static int kx022a_turn_off_lock(struct kx022a_data *data)
+{
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret =3D __kx022a_turn_off_unlocked(data);
+	if (ret)
+		mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int kx022a_turn_on_unlock(struct kx022a_data *data)
+{
+	int ret;
+
+	ret =3D __kx022a_turn_on_unlocked(data);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int kx022a_write_raw(struct iio_dev *idev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct kx022a_data *data =3D iio_priv(idev);
+	int ret;
+
+	/*
+	 * We should not allow changing scale or frequency when FIFO is running
+	 * as it will mess the timestamp/scale for samples existing in the
+	 * buffer. If this turns out to be an issue we can later change logic
+	 * to internally flush the fifo before reconfiguring so the samples in
+	 * fifo keep matching the freq/scale settings. (Such setup could cause
+	 * issues if users trust the watermark to be reached within known
+	 * time-limit).
+	 */
+	mutex_lock(&data->mutex);
+	if (iio_buffer_enabled(idev)) {
+		ret =3D -EBUSY;
+		goto unlock_out;
+	}
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret =3D kx022a_find_tuple_index(&kx022a_accel_samp_freq_table[0],
+					      ARRAY_SIZE(kx022a_accel_samp_freq_table),
+					      val, val2);
+		/* Configure if we found valid ODR */
+		if (ret >=3D 0) {
+			int odr =3D ret;
+
+			ret =3D __kx022a_turn_off_unlocked(data);
+			if (ret)
+				goto unlock_out;
+
+			ret =3D regmap_update_bits(data->regmap, KX022A_REG_ODCNTL,
+						 KX022A_MASK_ODR, odr);
+			data->odr_ns =3D kx022a_odrs[odr];
+			__kx022a_turn_on_unlocked(data);
+		}
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret =3D kx022a_find_tuple_index(&kx022a_scale_table[0],
+					      ARRAY_SIZE(kx022a_scale_table),
+					      val, val2);
+		/* Configure if we found valid scale */
+		if (ret >=3D 0) {
+			ret =3D __kx022a_turn_off_unlocked(data);
+			if (ret)
+				goto unlock_out;
+
+			ret =3D regmap_update_bits(data->regmap, KX022A_REG_CNTL,
+						 KX022A_MASK_GSEL,
+						 ret << KX022A_GSEL_SHIFT);
+			__kx022a_turn_on_unlocked(data);
+		}
+	default:
+		ret =3D -EINVAL;
+	}
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int kx022a_fifo_set_wmi(struct kx022a_data *data)
+{
+	u8 threshold;
+
+	threshold =3D data->watermark;
+
+	return regmap_update_bits(data->regmap, KX022A_REG_BUF_CNTL1,
+				  KX022A_MASK_WM_TH, threshold);
+}
+
+static int kx022a_fifo_report_data(struct kx022a_data *data, void *buffer,
+				   int samples)
+{
+	int ret, fifo_bytes;
+
+	fifo_bytes =3D samples * KX022A_FIFO_SAMPLES_SIZE_BYTES;
+	ret =3D regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
+			       buffer, fifo_bytes);
+	if (ret)
+		dev_err(data->dev, "FIFO read failed %d\n", ret);
+
+	return ret;
+}
+
+static int kx022a_get_axis(struct kx022a_data *data,
+			   struct iio_chan_spec const *chan,
+			   int *val)
+{
+	u16 raw_val;
+	int ret;
+
+	ret =3D regmap_bulk_read(data->regmap, chan->address, &raw_val,
+			       sizeof(raw_val));
+	if (ret)
+		return ret;
+	*val =3D raw_val;
+
+	return IIO_VAL_INT;
+}
+
+static int kx022a_read_raw(struct iio_dev *idev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct kx022a_data *data =3D iio_priv(idev);
+	unsigned int regval;
+	int ret =3D -EINVAL;
+
+	mutex_lock(&data->mutex);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (iio_buffer_enabled(idev)) {
+			ret =3D -EBUSY;
+			goto error_ret;
+		}
+
+		ret =3D kx022a_get_axis(data, chan, val);
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+	{
+		ret =3D regmap_read(data->regmap, KX022A_REG_ODCNTL, &regval);
+		if (ret)
+			goto error_ret;
+
+		if ((regval & KX022A_MASK_ODR) >
+		    ARRAY_SIZE(kx022a_accel_samp_freq_table)) {
+			dev_err(data->dev, "Invalid ODR\n");
+			ret =3D -EINVAL;
+			goto error_ret;
+		}
+
+		kx022a_reg2freq(regval, val, val2);
+		ret =3D IIO_VAL_INT_PLUS_MICRO;
+
+		break;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		ret =3D regmap_read(data->regmap, KX022A_REG_CNTL, &regval);
+		if (ret < 0)
+			goto error_ret;
+
+		kx022a_reg2scale(regval, val, val2);
+
+		ret =3D IIO_VAL_INT_PLUS_MICRO;
+		break;
+	}
+
+error_ret:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+};
+
+static int kx022a_validate_trigger(struct iio_dev *idev,
+				   struct iio_trigger *trig)
+{
+	struct kx022a_data *data =3D iio_priv(idev);
+
+	if (data->trigger.indio_trig =3D=3D trig)
+		return 0;
+
+	return -EINVAL;
+}
+
+static int kx022a_set_watermark(struct iio_dev *idev, unsigned int val)
+{
+	struct kx022a_data *data =3D iio_priv(idev);
+
+	if (val > KX022A_FIFO_LENGTH)
+		val =3D KX022A_FIFO_LENGTH;
+
+	mutex_lock(&data->mutex);
+	data->watermark =3D val;
+	mutex_unlock(&data->mutex);
+
+	return 0;
+}
+
+static ssize_t kx022a_get_fifo_state(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct iio_dev *idev =3D dev_to_iio_dev(dev);
+	struct kx022a_data *data =3D iio_priv(idev);
+	bool state;
+
+	mutex_lock(&data->mutex);
+	state =3D data->state;
+	mutex_unlock(&data->mutex);
+
+	return sprintf(buf, "%d\n", state);
+}
+
+static ssize_t kx022a_get_fifo_watermark(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct iio_dev *idev =3D dev_to_iio_dev(dev);
+	struct kx022a_data *data =3D iio_priv(idev);
+	int wm;
+
+	mutex_lock(&data->mutex);
+	wm =3D data->watermark;
+	mutex_unlock(&data->mutex);
+
+	return sprintf(buf, "%d\n", wm);
+}
+
+static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
+		       kx022a_get_fifo_state, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
+		       kx022a_get_fifo_watermark, NULL, 0);
+
+static const struct attribute *kx022a_fifo_attributes[] =3D {
+	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
+	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	NULL,
+};
+
+static int kx022a_drop_fifo_contents(struct kx022a_data *data)
+{
+	/*
+	 * We must clear the old time-stamp to avoid computing the timestamps
+	 * based on samples acquired when buffer was last enabled
+	 */
+	data->timestamp =3D 0;
+
+	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0xff);
+}
+
+static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
+			       bool irq)
+{
+	struct kx022a_data *data =3D iio_priv(idev);
+	struct device *dev =3D regmap_get_device(data->regmap);
+	int ret, i;
+	int count, fifo_bytes;
+	u16 buffer[KX022A_FIFO_LENGTH * 3];
+	int64_t tstamp;
+	uint64_t sample_period;
+	static int err_ctr;
+
+	ret =3D regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
+	if (ret < 0) {
+		dev_err(dev, "Error reading buffer status\n");
+		return ret;
+	}
+
+	/* Let's not owerflow if we for some reason get bogus value from i2c */
+	if (fifo_bytes > KX022A_FIFO_MAX_BYTES) {
+		/*
+		 * I've observed a strange behaviour where FIFO may get stuck if
+		 * samples are not read out fast enough. By 'stuck' I mean
+		 * situation where amount of data adverticed by the STATUS_1
+		 * reg is 255 - which equals to 42,5 (sic!) samples and by
+		 * my experimenting there are situations where reading the
+		 * FIFO buffer does not decrease the data count but the same
+		 * fifo sample level (255 bytes of data) is reported
+		 */
+		err_ctr++;
+		dev_warn(data->dev, "Bad amount of data %u\n", fifo_bytes);
+		fifo_bytes =3D KX022A_FIFO_MAX_BYTES;
+	} else if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES) {
+		err_ctr++;
+		dev_err(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
+	} else {
+		err_ctr =3D 0;
+	}
+
+	if (err_ctr > KXO22A_FIFO_ERR_THRESHOLD) {
+		__kx022a_turn_off_unlocked(data);
+		kx022a_drop_fifo_contents(data);
+		__kx022a_turn_on_unlocked(data);
+
+		err_ctr =3D 0;
+
+		return -EINVAL;
+	}
+
+	count =3D fifo_bytes / KX022A_FIFO_SAMPLES_SIZE_BYTES;
+	if (!count)
+		return 0;
+
+	/*
+	 * If we are being called from IRQ handler we know the stored timestamp
+	 * is fairly accurate for the last stored sample. Otherwise, if we are
+	 * called as a result of a read operation from userspace and hence
+	 * before the watermark interrupt was triggered, take a timestamp
+	 * now. We can fall anywhere in between two samples so the error in this
+	 * case is at most one sample period.
+	 */
+	if (!irq) {
+		data->old_timestamp =3D data->timestamp;
+		data->timestamp =3D iio_get_time_ns(idev);
+	}
+
+	/*
+	 * Approximate timestamps for each of the sample based on the sampling
+	 * frequency, timestamp for last sample and number of samples.
+	 *
+	 * We'd better not use the current bandwidth settings to compute the
+	 * sample period. The real sample rate varies with the device and
+	 * small variation adds when we store a large number of samples.
+	 *
+	 * To avoid this issue we compute the actual sample period ourselves
+	 * based on the timestamp delta between the last two flush operations.
+	 */
+	if (data->old_timestamp) {
+		sample_period =3D (data->timestamp - data->old_timestamp);
+		do_div(sample_period, count);
+	} else {
+		sample_period =3D data->odr_ns;
+	}
+	tstamp =3D data->timestamp - (count - 1) * sample_period;
+
+	if (samples && count > samples) {
+		/*
+		 * Here we leave some old samples to the buffer. We need to
+		 * adjust the timestamp to match the first sample in the buffer
+		 * or we will miscalculate the sample_period at next round.
+		 */
+		data->timestamp -=3D (count - samples) * sample_period;
+		count =3D samples;
+	}
+
+	ret =3D kx022a_fifo_report_data(data, buffer, count);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < count; i++) {
+		int bit;
+		u16 *samples =3D &buffer[i * 3];
+
+		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
+			memcpy(&data->scan.channels[bit], &samples[bit],
+			       sizeof(data->scan.channels[0]));
+
+		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
+
+		tstamp +=3D sample_period;
+	}
+
+	return count;
+}
+
+static int kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples)
+{
+	struct kx022a_data *data =3D iio_priv(idev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret =3D __kx022a_fifo_flush(idev, samples, false);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static const struct iio_info kx022a_info =3D {
+	.read_raw =3D &kx022a_read_raw,
+	.write_raw =3D &kx022a_write_raw,
+	.attrs =3D &kx022a_attrs_group,
+
+	.validate_trigger	=3D kx022a_validate_trigger,
+	.hwfifo_set_watermark	=3D kx022a_set_watermark,
+	.hwfifo_flush_to_buffer	=3D kx022a_fifo_flush,
+};
+
+static int kx022a_set_drdy_irq(struct kx022a_data *data, bool en)
+{
+	if (en)
+		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
+				       KX022A_MASK_DRDY);
+
+	return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
+				 KX022A_MASK_DRDY);
+}
+
+static int kx022a_prepare_irq_pin(struct kx022a_data *data)
+{
+	/* Enable IRQ1 pin. Set polarity to active low */
+	int mask =3D KX022A_MASK_IEN1 | KX022A_MASK_IPOL1 |
+		   KX022A_MASK_ITYP;
+	int val =3D KX022A_MASK_IEN1 | KX022A_IPOL_LOW |
+		  KX022A_ITYP_LEVEL;
+	int ret;
+
+	ret =3D regmap_update_bits(data->regmap, KX022A_REG_INC1, mask, val);
+	if (ret)
+		return ret;
+
+	mask =3D KX022A_MASK_INS2_DRDY | KX122_MASK_INS2_WMI;
+
+	return regmap_set_bits(data->regmap, KX022A_REG_INC4, mask);
+}
+
+static int kx022a_fifo_disable(struct kx022a_data *data)
+{
+	int ret =3D 0;
+
+	/* PC1 to 0 */
+	ret =3D kx022a_turn_off_lock(data);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_clear_bits(data->regmap, KX022A_REG_INC4,
+				KX022A_MASK_WMI1);
+	if (ret)
+		goto unlock_out;
+
+	/* disable buffer */
+	ret =3D regmap_clear_bits(data->regmap, KX022A_REG_BUF_CNTL2,
+				KX022A_MASK_BUF_EN);
+	if (ret)
+		goto unlock_out;
+
+	data->state &=3D (~KX022A_STATE_FIFO);
+
+	kx022a_drop_fifo_contents(data);
+
+	return kx022a_turn_on_unlock(data);
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int kx022a_buffer_predisable(struct iio_dev *idev)
+{
+	struct kx022a_data *data =3D iio_priv(idev);
+
+	if (iio_device_get_current_mode(idev) =3D=3D INDIO_BUFFER_TRIGGERED)
+		return 0;
+
+	return kx022a_fifo_disable(data);
+}
+
+static int kx022a_fifo_enable(struct kx022a_data *data)
+{
+	int ret =3D 0;
+
+	ret =3D kx022a_turn_off_lock(data);
+	if (ret)
+		return ret;
+
+	/* Write WMI to HW */
+	ret =3D kx022a_fifo_set_wmi(data);
+	if (ret)
+		goto unlock_out;
+
+	/* Enable buffer */
+	ret =3D regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
+			      KX022A_MASK_BUF_EN);
+	if (ret)
+		goto unlock_out;
+
+	data->state |=3D KX022A_STATE_FIFO;
+	ret =3D regmap_set_bits(data->regmap, KX022A_REG_INC4,
+			      KX022A_MASK_WMI1);
+	if (ret)
+		goto unlock_out;
+
+	return kx022a_turn_on_unlock(data);
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int kx022a_buffer_postenable(struct iio_dev *idev)
+{
+	struct kx022a_data *data =3D iio_priv(idev);
+
+	/*
+	 * If we use triggers, then the IRQs should be handled by trigger
+	 * enable and buffer is not used but we just add results to buffer
+	 * when data-ready triggers.
+	 */
+	if (iio_device_get_current_mode(idev) =3D=3D INDIO_BUFFER_TRIGGERED)
+		return 0;
+
+	return kx022a_fifo_enable(data);
+}
+
+static const struct iio_buffer_setup_ops kx022a_buffer_ops =3D {
+	.postenable =3D kx022a_buffer_postenable,
+	.predisable =3D kx022a_buffer_predisable,
+};
+
+static irqreturn_t kx022a_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf =3D p;
+	struct iio_dev *idev =3D pf->indio_dev;
+	struct kx022a_data *data =3D iio_priv(idev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret =3D regmap_bulk_read(data->regmap, KX022A_REG_XOUT_L, data->buffer,
+			       KX022A_FIFO_SAMPLES_SIZE_BYTES);
+	if (ret < 0)
+		goto err_read;
+
+	iio_push_to_buffers_with_timestamp(idev, data->buffer, pf->timestamp);
+err_read:
+	mutex_unlock(&data->mutex);
+	iio_trigger_notify_done(idev->trig);
+
+	return IRQ_HANDLED;
+}
+
+/* Get timestamps and wake the thread if we need to read data */
+static irqreturn_t kx022a_irq_handler(int irq, void *private)
+{
+	struct iio_dev *idev =3D private;
+	struct kx022a_data *data =3D iio_priv(idev);
+	bool ack =3D false;
+
+	data->old_timestamp =3D data->timestamp;
+	data->timestamp =3D iio_get_time_ns(idev);
+
+	if (data->trigger.enabled) {
+		iio_trigger_poll(data->trigger.indio_trig);
+		ack =3D true;
+	}
+
+	if (data->state & KX022A_STATE_FIFO)
+		return IRQ_WAKE_THREAD;
+
+	if (ack) {
+		/*
+		 * The IRQ is not acked until data is read. We need to disable
+		 * the IRQ in order to schedule the trigger thread. Enabling
+		 * is done in reenable.
+		 *
+		 * It would be possible to set the IRQ to 50uS pulse. If we are
+		 * losing data due to the disabled IRQ we can evaluate the
+		 * option of using edge triggered IRQs with the pulse mode.
+		 */
+		disable_irq_nosync(irq);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+/* Read the data from the fifo and fill IIO buffers */
+static irqreturn_t kx022a_irq_thread_handler(int irq, void *private)
+{
+	struct iio_dev *idev =3D private;
+	struct kx022a_data *data =3D iio_priv(idev);
+	bool ack =3D false;
+	int ret;
+
+	mutex_lock(&data->mutex);
+
+	if (data->state & KX022A_STATE_FIFO) {
+		ret =3D __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
+		if (ret > 0)
+			ack =3D true;
+	}
+	/*
+	 * WMI and data-ready IRQs are acked when results are read. If we add
+	 * TILT/WAKE or other IRQs - then we may need to implement the acking
+	 * (which is racy).
+	 */
+	if (ack)
+		ret =3D IRQ_HANDLED;
+	else
+		ret =3D IRQ_NONE;
+
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int kx022a_trigger_set_state(struct iio_trigger *trig,
+				    bool state)
+{
+	struct kx022a_trigger *t =3D iio_trigger_get_drvdata(trig);
+	struct kx022a_data *data =3D t->data;
+	int ret =3D 0;
+
+	mutex_lock(&data->mutex);
+
+	if (t->enabled =3D=3D state)
+		goto unlock_out;
+
+	ret =3D __kx022a_turn_off_unlocked(data);
+	if (ret)
+		goto unlock_out;
+
+	t->enabled =3D state;
+	ret =3D kx022a_set_drdy_irq(data, state);
+	if (ret)
+		goto unlock_out;
+
+	ret =3D __kx022a_turn_on_unlocked(data);
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+static void kx022a_trig_reen(struct iio_trigger *trig)
+{
+	struct kx022a_trigger *t =3D iio_trigger_get_drvdata(trig);
+	struct kx022a_data *data =3D t->data;
+
+	enable_irq(data->irq);
+}
+
+static const struct iio_trigger_ops kx022a_trigger_ops =3D {
+	.set_trigger_state =3D kx022a_trigger_set_state,
+	.reenable =3D kx022a_trig_reen,
+};
+
+static int kx022a_chip_init(struct kx022a_data *data)
+{
+	int ret, dummy;
+
+	/*
+	 * Disable IRQs because if the IRQs are left on (for example by
+	 * a shutdown which did not deactivate the accelerometer) we do
+	 * most probably end up flooding the system with unhandled IRQs
+	 * and get the line disabled from SOC side.
+	 */
+	ret =3D regmap_write(data->regmap, KX022A_REG_INC4, 0);
+	if (ret) {
+		dev_err(data->dev, "Failed to init IRQ states\n");
+		return ret;
+	}
+
+	ret =3D kx022a_set_drdy_irq(data, false);
+	if (ret) {
+		dev_err(data->dev, "Failed to init DRDY\n");
+		return ret;
+	}
+
+	/* Clear any pending IRQs */
+	ret =3D regmap_read(data->regmap, KX022A_REG_INT_REL, &dummy);
+	if (ret) {
+		dev_err(data->dev, "Failed to ACK IRQs\n");
+		return ret;
+	}
+	/* set data res 16bit */
+	ret =3D regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
+			      KX022A_MASK_BRES);
+	if (ret) {
+		dev_err(data->dev, "Failed to set data resolution\n");
+		return ret;
+	}
+
+	ret =3D kx022a_prepare_irq_pin(data);
+	if (ret) {
+		dev_err(data->dev, "Failed to configure IRQ pin\n");
+		return ret;
+	}
+
+	/* disable buffer */
+	ret =3D regmap_clear_bits(data->regmap, KX022A_REG_BUF_CNTL2,
+			      KX022A_MASK_BUF_EN);
+	if (ret)
+		return ret;
+
+	return kx022a_drop_fifo_contents(data);
+}
+
+int kx022a_probe_internal(struct device *dev, int irq)
+{
+	static const char * const regulator_names[] =3D {"io_vdd", "vdd"};
+	struct iio_trigger *indio_trig;
+	struct kx022a_data *data;
+	struct regmap *regmap;
+	unsigned int chip_id;
+	struct iio_dev *idev;
+	int ret;
+
+	if (WARN_ON(!dev))
+		return -ENODEV;
+
+	regmap =3D dev_get_regmap(dev, NULL);
+	if (!regmap) {
+		dev_err(dev, "no regmap\n");
+
+		return -EINVAL;
+	}
+
+	idev =3D devm_iio_device_alloc(dev, sizeof(*data));
+	if (!idev)
+		return -ENOMEM;
+
+	data =3D iio_priv(idev);
+
+	/*
+	 * VDD is the analog and digital domain voltage supply
+	 * IO_VDD is the digital I/O voltage supply
+	 */
+	ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
+					     regulator_names);
+	if (ret && ret !=3D -ENODEV)
+		return dev_err_probe(dev, ret, "failed to enable regulator\n");
+
+	ret =3D regmap_read(regmap, KX022A_REG_WHO, &chip_id);
+	if (ret) {
+		dev_err(dev, "Failed to access sensor\n");
+		return ret;
+	}
+
+	if (chip_id !=3D KX022A_ID) {
+		dev_err(dev, "unsupported device 0x%x\n", chip_id);
+		return -EINVAL;
+	}
+
+	data->regmap =3D regmap;
+	data->dev =3D dev;
+	data->irq =3D irq;
+	data->odr_ns =3D KX922A_DEFAULT_PERIOD;
+	mutex_init(&data->mutex);
+
+	idev->channels =3D kx022a_channels;
+	idev->num_channels =3D ARRAY_SIZE(kx022a_channels);
+	idev->name =3D "kx022-accel";
+	idev->info =3D &kx022a_info;
+	idev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	idev->available_scan_masks =3D kx022a_scan_masks;
+
+	/* Read the mounting matrix, if present */
+	ret =3D iio_read_mount_matrix(dev, &data->orientation);
+	if (ret)
+		return ret;
+
+	/* The sensor must be turned off for configuration */
+	ret =3D kx022a_turn_off_lock(data);
+	if (ret)
+		return ret;
+
+	ret =3D kx022a_chip_init(data);
+	if (ret)
+		return ret;
+
+	ret =3D kx022a_turn_on_unlock(data);
+	if (ret)
+		return ret;
+
+	udelay(100);
+
+	ret =3D iio_triggered_buffer_setup_ext(idev,
+					     &iio_pollfunc_store_time,
+					     kx022a_trigger_handler,
+					     IIO_BUFFER_DIRECTION_IN,
+					     &kx022a_buffer_ops,
+					     kx022a_fifo_attributes);
+
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "iio_triggered_buffer_setup_ext FAIL %d\n",
+				     ret);
+
+	indio_trig =3D devm_iio_trigger_alloc(dev, "%sdata-rdy-dev%d", idev->name,
+					    iio_device_id(idev));
+	if (!indio_trig)
+		return -ENOMEM;
+
+	data->trigger.indio_trig =3D indio_trig;
+
+	indio_trig->ops =3D &kx022a_trigger_ops;
+	data->trigger.data =3D data;
+	iio_trigger_set_drvdata(indio_trig, &data->trigger);
+
+	ret =3D iio_trigger_register(indio_trig);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Trigger registration failed\n");
+
+	ret =3D devm_iio_device_register(data->dev, idev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Unable to register iio device\n");
+
+	ret =3D devm_request_threaded_irq(data->dev, irq, kx022a_irq_handler,
+					&kx022a_irq_thread_handler,
+					IRQF_ONESHOT, "kx022", idev);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kx022a_probe_internal);
+
+MODULE_DESCRIPTION("ROHM/Kionix KX022A accelerometer driver");
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-k=
x022a.h
new file mode 100644
index 000000000000..ec89e46c6ca8
--- /dev/null
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2022 ROHM Semiconductors
+ *
+ * ROHM/KIONIX KX022A accelerometer driver
+ */
+
+#ifndef _KX022A_H_
+#define _KX022A_H_
+
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+#define KX022A_REG_WHO		0x0f
+#define KX022A_ID		0xc8
+
+#define KX022A_REG_CNTL		0x18
+#define KX022A_MASK_PC1		BIT(7)
+#define KX022A_MASK_RES		BIT(6)
+#define KX022A_MASK_DRDY	BIT(5)
+#define KX022A_MASK_GSEL	GENMASK(4, 3)
+#define KX022A_GSEL_SHIFT	3
+#define KX022A_GSEL_2		0x0
+#define KX022A_GSEL_4		BIT(3)
+#define KX022A_GSEL_8		BIT(4)
+#define KX022A_GSEL_16		GENMASK(4, 3)
+
+#define KX022A_REG_INS2		0x13
+#define KX022A_MASK_INS2_DRDY	BIT(4)
+#define KX122_MASK_INS2_WMI	BIT(5)
+
+#define KX022A_REG_XHP_L	0x0
+#define KX022A_REG_XOUT_L	0x06
+#define KX022A_REG_YOUT_L	0x08
+#define KX022A_REG_ZOUT_L	0x0a
+#define KX022A_REG_COTR		0x0c
+#define KX022A_REG_TSCP		0x10
+#define KX022A_REG_INT_REL	0x17
+
+#define KX022A_REG_ODCNTL	0x1b
+
+#define KX022A_REG_BTS_WUF_TH	0x31
+#define KX022A_REG_MAN_WAKE	0x2c
+
+#define KX022A_REG_BUF_CNTL1	0x3a
+#define KX022A_MASK_WM_TH	GENMASK(6, 0)
+#define KX022A_REG_BUF_CNTL2	0x3b
+#define KX022A_MASK_BUF_EN	BIT(7)
+#define KX022A_MASK_BRES	BIT(6)
+#define KX022A_REG_BUF_STATUS_1	0x3c
+#define KX022A_REG_BUF_STATUS_2	0x3d
+#define KX022A_REG_BUF_CLEAR	0x3e
+#define KX022A_REG_BUF_READ	0x3f
+#define KX022A_MASK_ODR		GENMASK(3, 0)
+#define KX022A_ODR_SHIFT	3
+#define KX022A_FIFO_MAX_WMI_TH	41
+
+#define KX022A_REG_INC1		0x1c
+#define KX022A_MASK_IEN1	BIT(5)
+#define KX022A_MASK_IPOL1	BIT(4)
+#define KX022A_IPOL_LOW		0
+#define KX022A_IPOL_HIGH	KX022A_MASK_IPOL1
+#define KX022A_MASK_ITYP	BIT(3)
+#define KX022A_ITYP_PULSE	KX022A_MASK_ITYP
+#define KX022A_ITYP_LEVEL	0
+
+#define KX022A_REG_INC4		0x1f
+#define KX022A_MASK_WMI1	BIT(5)
+
+#define KX022A_REG_SELF_TEST	0x60
+#define KX022A_MAX_REGISTER	0x60
+
+int kx022a_probe_internal(struct device *dev, int irq);
+extern const struct regmap_config kx022a_regmap;
+
+#endif
--=20
2.37.1


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

--uR/TaYYjTDxGy3zF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmMq+V8ACgkQeFA3/03a
ocVKNQf+JHWs2Pe6JpuydSbWduqpLEcuHO9saBgers1cvVEBGf/ka+OsqRa1pjOq
Gu1BtS2hBGHAblwZ/EiFrrGzFVGlpAcA1P4/31ld21O6kvKN3lO+ArY/TNw24SFq
4hVegFUFJgnyL0ML20JNj+dD+d46qnTnBck+Qg51tjaHd/XsXDef7/bNXPAvk7xe
uT6/2aTYpDjNVxgCR+16FrOw+N2dgrqDYtYSwGbtvVFIXpAFMhFZC8nc2qKg7MmK
L5YdhHht9/W85dcmAI0LZmgJ3LGTHrxQxmZ+mwaQ8LQsrfhLXTyG6uzilbO9wl3d
IjUVvVlqx3Ba6sdnTKhWLNOOyYuK8Q==
=v4Cz
-----END PGP SIGNATURE-----

--uR/TaYYjTDxGy3zF--
