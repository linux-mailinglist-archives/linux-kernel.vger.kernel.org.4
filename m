Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AC25F69C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiJFOib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJFOi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:38:26 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79286A7AAB;
        Thu,  6 Oct 2022 07:38:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id t16so2484030ljh.3;
        Thu, 06 Oct 2022 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=eco4ZiARK5LR0wbC4L4/RZiSnshqEV9jDY+kWkowvJs=;
        b=HCsM99Ppc/mBtAyEEvyzCKmlxylFmwQaAqtsEnTXd3NGZLHztFhqNsKs+DMbS1ovJr
         vpLv9TuarfdvOa7n+55mWNDZ9V8Y99PB57xx3ZporNBl7f8EJEsIGMW3bSrv6d8b6ENd
         KfXlWw/fhWtsQlpar+QWwhE56Yh6KsaB0WOTm6QtoVox0BXKFFyiWTBwNXvQvCvxv7sU
         Z0SzO/yIMor3I2krCMwzIcMu1HebxQu40lEmI7kmGub8rERdTYlkIMRs17ZOhvpnajFe
         n3Q1XnIE4tEN6AWMmxIb9KFi7kCSyznuQXH6Yf7E+/qGxJzBsLKQVjNKj7ssx5rTlrLM
         c/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=eco4ZiARK5LR0wbC4L4/RZiSnshqEV9jDY+kWkowvJs=;
        b=Pyl+z2RWHZt+FVh0CLuyEm1rtWRoR1twbedETw0IkbwueKpNLJ6P/0Z9xSVYhCrEyJ
         8EjEBn2ci1R5uSZpt8W3CYFwsTvw2RyBRLvKraw9AY2oOnlkb+b62RcBJzuwGAfnPlQK
         F1d+0JhHxXTpsXr8QH/cr1Mi57G8XhVpR+IXhONR2+GZYhPP9YCO3e/3ryVxVDqSUIiY
         NZp/uVUonitcOux0vWIIFG2niobT7Fwz7UnpCFNO9VYriNnE2xZto0qN7uwxHFxdFIgF
         9WYpgCGYjRXJtE1Pm8DPQwYUJLA8dXOWRhNE/Myh70bXYYbzMFuigFsIzAgB0hf4TMAR
         i/JA==
X-Gm-Message-State: ACrzQf0MCEZ8nShccLeVgWLM7k8fFkruGLs0QFEXJcdMaSuyLnW90bru
        P39VPwcbzkeQJ4ITaBqt36U=
X-Google-Smtp-Source: AMsMyM4LjiQyfCK/zvSzWyomrXody66hUuB2ZeCPgsqfKSbXxpU04lUBupIDG6r53pEz773gPxi9Vw==
X-Received: by 2002:a2e:8e70:0:b0:26c:549b:dd0d with SMTP id t16-20020a2e8e70000000b0026c549bdd0dmr1913ljk.172.1665067101423;
        Thu, 06 Oct 2022 07:38:21 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id p20-20020ac24ed4000000b004a2588520f5sm274273lfr.166.2022.10.06.07.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:38:20 -0700 (PDT)
Date:   Thu, 6 Oct 2022 17:38:14 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sNDPMW1OK3xaueiz"
Content-Disposition: inline
In-Reply-To: <cover.1665066397.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sNDPMW1OK3xaueiz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

KX022A is a 3-axis accelerometer from ROHM/Kionix. The senosr features
include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
tap/motion detection, wake-up & back-to-sleep events, four acceleration
ranges (2, 4, 8 and 16g) and probably some other cool features.

Add support for the basic accelerometer features such as getting the
acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
using the WMI IRQ).

Important things to be added include the double-tap, motion
detection and wake-up as well as the runtime power management.

NOTE: Filling-up the hardware FIFO should be avoided. During my testing
I noticed that filling up the hardware FIFO might mess-up the sample
count. My sensor ended up in a state where the amount of data in FIFO was
reported to be 0xff bytes, which equals to 42,5 samples. Specification
says the FIFO can hold a maximum of 41 samples in HiRes mode. Also, at
least once the FIFO was stuck in a state where reading data from
hardware FIFO did not decrease the amount of data reported to be in the
FIFO - eg. FIFO was "stuck". The code has now an error count and 10
reads with invalid FIFO data count will cause the fifo contents to be
dropped.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
RFCv1 =3D> v2 (mostly based on feedback from Jonathan):
- Fix bunch of typos from the commit message.
- Add missing break; to the kx022a_write_raw()
- Fix SPI driver to use of_match_table
- Fix indentiation in I2C driver
- Drop struct kx022a_trigger
- Drop cross references from Kconfig
- Use /* */ also in file header comments
- Misc minor styling
- Do sensor-reset at probe
- Support both IRQ pins
- Implement read_avail callback
- Use dma aligned buffers for bulk-reads
- Use iio_trigger_poll_chained()
- Use devm consistently
- Drop inclusion of device.h
- Add SPI device ID for module loading
- Add module param for hw fifo / watermark IRQ usage
- Fix io-vdd-supply name to match one in the bindings
---
 drivers/iio/accel/Kconfig             |   21 +
 drivers/iio/accel/Makefile            |    3 +
 drivers/iio/accel/kionix-kx022a-i2c.c |   53 ++
 drivers/iio/accel/kionix-kx022a-spi.c |   59 ++
 drivers/iio/accel/kionix-kx022a.c     | 1138 +++++++++++++++++++++++++
 drivers/iio/accel/kionix-kx022a.h     |   81 ++
 6 files changed, 1355 insertions(+)
 create mode 100644 drivers/iio/accel/kionix-kx022a-i2c.c
 create mode 100644 drivers/iio/accel/kionix-kx022a-spi.c
 create mode 100644 drivers/iio/accel/kionix-kx022a.c
 create mode 100644 drivers/iio/accel/kionix-kx022a.h

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 35798712f811..43f1090e8c59 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -409,6 +409,27 @@ config IIO_ST_ACCEL_SPI_3AXIS
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
+	  accelerometer connected to I2C interface.
+
+config IIO_KX022A_I2C
+	tristate "Kionix KX022A tri-axis digital accelerometer"
+	depends on I2C
+	select IIO_KX022A
+	select REGMAP_I2C
+	help
+	  Say Y here to enable support for the Kionix KX022A digital tri-axis
+	  accelerometer connected to I2C interface.
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
index 000000000000..6dd5b4a56401
--- /dev/null
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 ROHM Semiconductors
+ *
+ * ROHM/KIONIX KX022A accelerometer driver
+ */
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
+	return kx022a_probe_internal(dev);
+}
+
+static const struct of_device_id kx022a_of_match[] =3D {
+	{ .compatible =3D "kionix,kx022a", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, kx022a_of_match);
+
+static struct i2c_driver kx022a_i2c_driver =3D {
+	.driver =3D {
+		.name  =3D "kx022a-i2c",
+		.of_match_table =3D kx022a_of_match,
+	  },
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
index 000000000000..59944b7b49b3
--- /dev/null
+++ b/drivers/iio/accel/kionix-kx022a-spi.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 ROHM Semiconductors
+ *
+ * ROHM/KIONIX KX022A accelerometer driver
+ */
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
+	return kx022a_probe_internal(dev);
+}
+
+static const struct spi_device_id kx022a_id[] =3D {
+	{ "kx022a" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, kx022a_id);
+
+static const struct of_device_id kx022a_of_match[] =3D {
+	{ .compatible =3D "kionix,kx022a", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, kx022a_of_match);
+
+static struct spi_driver kx022a_spi_driver =3D {
+	.driver =3D {
+		.name   =3D "kx022a-spi",
+		.of_match_table =3D kx022a_of_match,
+	},
+	.probe =3D kx022a_spi_probe,
+	.id_table =3D kx022a_id,
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
index 000000000000..37d47def5927
--- /dev/null
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -0,0 +1,1138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 ROHM Semiconductors
+ *
+ * ROHM/KIONIX KX022A accelerometer driver
+ */
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
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/units.h>
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
+#define KX022A_SOFT_RESET_WAIT_TIME_US (5 * KILO)
+#define KX022A_SOFT_RESET_TOTAL_WAIT_TIME_US (500 * KILO)
+
+static bool g_kx022a_use_buffer;
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
+		/* The reset bit will be cleared by sensor */
+		.range_min =3D KX022A_REG_CNTL2,
+		.range_max =3D KX022A_REG_CNTL2,
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
+struct kx022a_data {
+	int irq;
+	int inc_reg;
+	int ien_reg;
+	struct regmap *regmap;
+	struct iio_trigger *trig;
+	bool trigger_enabled;
+
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
+	s16 buffer[8] __aligned(IIO_DMA_MINALIGN);
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
+		.info_mask_shared_by_type_available =3D			\
+					BIT(IIO_CHAN_INFO_SCALE) |	\
+					BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+		.ext_info =3D kx022a_ext_info,				\
+		.address =3D KX022A_REG_##axis##OUT_L,			\
+		.scan_index =3D index,					\
+		.scan_type =3D {                                          \
+			.sign =3D 's',					\
+			.realbits =3D 16,					\
+			.storagebits =3D 16,				\
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
+static const int kx022a_accel_samp_freq_table[][2] =3D {
+	[0] =3D { 0, 780000 },
+	[1] =3D { 1, 563000 },
+	[2] =3D { 3, 125000 },
+	[3] =3D { 6, 250000 },
+	[4] =3D { 12, 500000 },
+	[5] =3D { 25, 0 },
+	[6] =3D { 50, 0 },
+	[7] =3D { 100, 0 },
+	[8] =3D { 200, 0 }
+};
+
+static const unsigned int kx022a_odrs[] =3D { 1282051282, 639795266, 320 *=
 MEGA,
+	 160 * MEGA, 80 * MEGA, 40 * MEGA, 20 * MEGA, 10 * MEGA, 5 * MEGA };
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
+static const int kx022a_scale_table[][2] =3D {
+	[0] =3D { 598, 550415 },
+	[1] =3D { 1197, 100830 },
+	[2] =3D { 2394, 201660 },
+	[3] =3D { 4788, 403320 }
+};
+
+static int kx022a_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals =3D (const int *)kx022a_accel_samp_freq_table;
+		*length =3D ARRAY_SIZE(kx022a_accel_samp_freq_table) * 2;
+		*type =3D IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*vals =3D (const int *)kx022a_scale_table;
+		*length =3D ARRAY_SIZE(kx022a_scale_table) * 2;
+		*type =3D IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+#define KX022A_DEFAULT_PERIOD_NS (20 * MEGA)
+
+static void kx022a_reg2freq(unsigned int val,  int *val1, int *val2)
+{
+	*val1 =3D kx022a_accel_samp_freq_table[val & KX022A_MASK_ODR][0];
+	*val2 =3D kx022a_accel_samp_freq_table[val & KX022A_MASK_ODR][1];
+}
+
+static void kx022a_reg2scale(unsigned int val, unsigned int *val1,
+			     unsigned int *val2)
+{
+	val &=3D KX022A_MASK_GSEL;
+	val >>=3D KX022A_GSEL_SHIFT;
+
+	*val1 =3D kx022a_scale_table[val][0];
+	*val2 =3D kx022a_scale_table[val][1];
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
+	ret =3D iio_device_claim_direct_mode(idev);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+	{
+		int n =3D ARRAY_SIZE(kx022a_accel_samp_freq_table);
+
+		while (n-- > 0)
+			if (val =3D=3D kx022a_accel_samp_freq_table[n][0] &&
+			    kx022a_accel_samp_freq_table[n][1] =3D=3D val2)
+				break;
+		if (n < 0) {
+			ret =3D -EINVAL;
+			goto unlock_out;
+		}
+		ret =3D kx022a_turn_off_lock(data);
+		if (ret)
+			break;
+
+		ret =3D regmap_update_bits(data->regmap,
+					 KX022A_REG_ODCNTL,
+					 KX022A_MASK_ODR, n);
+		data->odr_ns =3D kx022a_odrs[n];
+		kx022a_turn_on_unlock(data);
+		break;
+	}
+	case IIO_CHAN_INFO_SCALE:
+	{
+		int n =3D ARRAY_SIZE(kx022a_scale_table);
+
+		while (n-- > 0)
+			if (val =3D=3D kx022a_scale_table[n][0] &&
+			    kx022a_scale_table[n][1] =3D=3D val2)
+				break;
+		if (n < 0) {
+			ret =3D -EINVAL;
+			goto unlock_out;
+		}
+
+		ret =3D kx022a_turn_off_lock(data);
+		if (ret)
+			break;
+
+		ret =3D regmap_update_bits(data->regmap, KX022A_REG_CNTL,
+					 KX022A_MASK_GSEL,
+					 n << KX022A_GSEL_SHIFT);
+		kx022a_turn_on_unlock(data);
+		break;
+	}
+	default:
+		ret =3D -EINVAL;
+	}
+
+unlock_out:
+	iio_device_release_direct_mode(idev);
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
+static int kx022a_get_axis(struct kx022a_data *data,
+			   struct iio_chan_spec const *chan,
+			   int *val)
+{
+	int ret;
+
+	ret =3D regmap_bulk_read(data->regmap, chan->address, &data->buffer,
+			       sizeof(s16));
+	if (ret)
+		return ret;
+
+	*val =3D data->buffer[0];
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
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret =3D iio_device_claim_direct_mode(idev);
+		if (ret)
+			return ret;
+
+		mutex_lock(&data->mutex);
+		ret =3D kx022a_get_axis(data, chan, val);
+		mutex_unlock(&data->mutex);
+
+		iio_device_release_direct_mode(idev);
+		break;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret =3D regmap_read(data->regmap, KX022A_REG_ODCNTL, &regval);
+		if (ret)
+			return ret;
+
+		if ((regval & KX022A_MASK_ODR) >
+		    ARRAY_SIZE(kx022a_accel_samp_freq_table)) {
+			dev_err(data->dev, "Invalid ODR\n");
+			return -EINVAL;
+		}
+
+		kx022a_reg2freq(regval, val, val2);
+		ret =3D IIO_VAL_INT_PLUS_MICRO;
+
+		break;
+
+	case IIO_CHAN_INFO_SCALE:
+		ret =3D regmap_read(data->regmap, KX022A_REG_CNTL, &regval);
+		if (ret < 0)
+			return ret;
+
+		kx022a_reg2scale(regval, val, val2);
+
+		ret =3D IIO_VAL_INT_PLUS_MICRO;
+		break;
+	}
+
+	return ret;
+};
+
+static int kx022a_validate_trigger(struct iio_dev *idev,
+				   struct iio_trigger *trig)
+{
+	struct kx022a_data *data =3D iio_priv(idev);
+
+	if (data->trig =3D=3D trig)
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
+	/* Let's not overflow if we for some reason get bogus value from i2c */
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
+	fifo_bytes =3D count * KX022A_FIFO_SAMPLES_SIZE_BYTES;
+	ret =3D regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
+				buffer, fifo_bytes);
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
+	.read_avail =3D &kx022a_read_avail,
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
+	int mask =3D KX022A_MASK_IEN | KX022A_MASK_IPOL |
+		   KX022A_MASK_ITYP;
+	int val =3D KX022A_MASK_IEN | KX022A_IPOL_LOW |
+		  KX022A_ITYP_LEVEL;
+	int ret;
+
+	ret =3D regmap_update_bits(data->regmap, data->inc_reg, mask, val);
+	if (ret)
+		return ret;
+
+	/* We enable WMI to IRQ pin only at buffer_enable */
+	mask =3D KX022A_MASK_INS2_DRDY /*| KX122_MASK_INS2_WMI */;
+
+	return regmap_set_bits(data->regmap, data->ien_reg, mask);
+}
+
+static int kx022a_fifo_disable(struct kx022a_data *data)
+{
+	int ret =3D 0;
+
+	ret =3D kx022a_turn_off_lock(data);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_clear_bits(data->regmap, data->ien_reg,
+				KX022A_MASK_WMI);
+	if (ret)
+		goto unlock_out;
+
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
+	/* Update watermark to HW */
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
+	ret =3D regmap_set_bits(data->regmap, data->ien_reg,
+			      KX022A_MASK_WMI);
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
+	 * If we use data-ready trigger, then the IRQ masks should be handled by
+	 * trigger enable and the hardware buffer is not used but we just update
+	 * results to the IIO fifo when data-ready triggers.
+	 */
+	if (iio_device_get_current_mode(idev) =3D=3D INDIO_BUFFER_TRIGGERED)
+		return 0;
+
+	/*
+	 * Filling up the HW-FIFO can cause nasty problems. Thus we do not
+	 * enable the fifo unless it is explicitly requested by a module param.
+	 * If you are _sure_ your system can serve the interrupts in time you
+	 * can enable the HW fifo. I do not recommend it for sample frequencies
+	 * higher than 2 Hz - and even in that case I would set the watermark
+	 * somewhere near 20 samples (HI-RES) to have magnitude of 10 sec
+	 * safety-margin.
+	 */
+	if (!g_kx022a_use_buffer) {
+		dev_err(data->dev, "Neither trigger set nor hw-fifo enabled\n");
+
+		return -EINVAL;
+	}
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
+	ret =3D regmap_bulk_read(data->regmap, KX022A_REG_XOUT_L, data->buffer,
+			       KX022A_FIFO_SAMPLES_SIZE_BYTES);
+	if (ret < 0)
+		goto err_read;
+
+	iio_push_to_buffers_with_timestamp(idev, data->buffer, pf->timestamp);
+err_read:
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
+
+	data->old_timestamp =3D data->timestamp;
+	data->timestamp =3D iio_get_time_ns(idev);
+
+	if (data->state & KX022A_STATE_FIFO || data->trigger_enabled)
+		return IRQ_WAKE_THREAD;
+
+	return IRQ_NONE;
+}
+
+/*
+ * WMI and data-ready IRQs are acked when results are read. If we add
+ * TILT/WAKE or other IRQs - then we may need to implement the acking
+ * (which is racy).
+ */
+static irqreturn_t kx022a_irq_thread_handler(int irq, void *private)
+{
+	struct iio_dev *idev =3D private;
+	struct kx022a_data *data =3D iio_priv(idev);
+	int ret =3D IRQ_NONE;
+
+	mutex_lock(&data->mutex);
+
+	if (data->trigger_enabled) {
+		iio_trigger_poll_chained(data->trig);
+		ret =3D IRQ_HANDLED;
+	}
+
+	if (data->state & KX022A_STATE_FIFO) {
+		ret =3D __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
+		if (ret > 0)
+			ret =3D IRQ_HANDLED;
+	}
+
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int kx022a_trigger_set_state(struct iio_trigger *trig,
+				    bool state)
+{
+	struct kx022a_data *data =3D iio_trigger_get_drvdata(trig);
+	int ret =3D 0;
+
+	mutex_lock(&data->mutex);
+
+	if (data->trigger_enabled =3D=3D state)
+		goto unlock_out;
+
+	ret =3D __kx022a_turn_off_unlocked(data);
+	if (ret)
+		goto unlock_out;
+
+	data->trigger_enabled =3D state;
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
+
+static const struct iio_trigger_ops kx022a_trigger_ops =3D {
+	.set_trigger_state =3D kx022a_trigger_set_state,
+};
+
+static int kx022a_chip_init(struct kx022a_data *data)
+{
+	int ret, val;
+
+	/* Reset the senor */
+	ret =3D regmap_write(data->regmap, KX022A_REG_CNTL2, KX022A_MASK_SRST);
+	if (ret)
+		return ret;
+
+	/*
+	 * I've seen I2C read failures if we poll too fast after the sensor
+	 * reset. Slight delay gives I2C block the time to recover.
+	 */
+	msleep(1);
+
+	ret =3D regmap_read_poll_timeout(data->regmap, KX022A_REG_CNTL2, val,
+				       !(val & KX022A_MASK_SRST),
+				       KX022A_SOFT_RESET_WAIT_TIME_US,
+				       KX022A_SOFT_RESET_TOTAL_WAIT_TIME_US);
+	if (ret) {
+		dev_err(data->dev, "Sensor reset %s\n",
+			val & KX022A_MASK_SRST ? "timeout" : "fail#");
+		return ret;
+	}
+
+	ret =3D regmap_reinit_cache(data->regmap, &kx022a_regmap);
+	if (ret) {
+		dev_err(data->dev, "Failed to reinit reg cache\n");
+		return ret;
+	}
+
+	/* set data res 16bit */
+	ret =3D regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
+			      KX022A_MASK_BRES16);
+	if (ret) {
+		dev_err(data->dev, "Failed to set data resolution\n");
+		return ret;
+	}
+
+	return kx022a_prepare_irq_pin(data);
+}
+
+int kx022a_probe_internal(struct device *dev)
+{
+	static const char * const regulator_names[] =3D {"io-vdd", "vdd"};
+	struct iio_trigger *indio_trig;
+	struct kx022a_data *data;
+	struct regmap *regmap;
+	unsigned int chip_id;
+	struct iio_dev *idev;
+	int ret, irq;
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
+		dev_err_probe(dev, ret, "Failed to access sensor\n");
+		return ret;
+	}
+
+	if (chip_id !=3D KX022A_ID) {
+		dev_err(dev, "unsupported device 0x%x\n", chip_id);
+		return -EINVAL;
+	}
+
+	irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
+	if (irq > 0) {
+		data->inc_reg =3D KX022A_REG_INC1;
+		data->ien_reg =3D KX022A_REG_INC4;
+	} else {
+		irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
+		if (irq < 0)
+			return dev_err_probe(dev, irq, "No suitable IRQ\n");
+
+		data->inc_reg =3D KX022A_REG_INC5;
+		data->ien_reg =3D KX022A_REG_INC6;
+	}
+
+	data->regmap =3D regmap;
+	data->dev =3D dev;
+	data->irq =3D irq;
+	data->odr_ns =3D KX022A_DEFAULT_PERIOD_NS;
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
+	if (ret) {
+		mutex_unlock(&data->mutex);
+		return ret;
+	}
+
+	ret =3D kx022a_turn_on_unlock(data);
+	if (ret)
+		return ret;
+
+	udelay(100);
+	ret =3D devm_iio_triggered_buffer_setup_ext(dev, idev,
+						  &iio_pollfunc_store_time,
+						  kx022a_trigger_handler,
+						  IIO_BUFFER_DIRECTION_IN,
+						  &kx022a_buffer_ops,
+						  kx022a_fifo_attributes);
+
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "iio_triggered_buffer_setup_ext FAIL %d\n",
+				     ret);
+	indio_trig =3D devm_iio_trigger_alloc(dev, "%sdata-rdy-dev%d", idev->name,
+					    iio_device_id(idev));
+	if (!indio_trig)
+		return -ENOMEM;
+
+	data->trig =3D indio_trig;
+
+	indio_trig->ops =3D &kx022a_trigger_ops;
+	iio_trigger_set_drvdata(indio_trig, data);
+
+	ret =3D devm_iio_trigger_register(dev, indio_trig);
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
+module_param(g_kx022a_use_buffer, bool, 0);
+MODULE_PARM_DESC(g_kx022a_use_buffer,
+		 "Buffer samples. Use at own risk. Fifo must not overflow");
+
+MODULE_DESCRIPTION("ROHM/Kionix KX022A accelerometer driver");
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-k=
x022a.h
new file mode 100644
index 000000000000..0899fd52fa55
--- /dev/null
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -0,0 +1,81 @@
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
+#include <linux/regmap.h>
+
+#define KX022A_REG_WHO		0x0f
+#define KX022A_ID		0xc8
+
+#define KX022A_REG_CNTL2	0x19
+#define KX022A_MASK_SRST	BIT(7)
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
+#define KX022A_MASK_BRES16	BIT(6)
+#define KX022A_REG_BUF_STATUS_1	0x3c
+#define KX022A_REG_BUF_STATUS_2	0x3d
+#define KX022A_REG_BUF_CLEAR	0x3e
+#define KX022A_REG_BUF_READ	0x3f
+#define KX022A_MASK_ODR		GENMASK(3, 0)
+#define KX022A_ODR_SHIFT	3
+#define KX022A_FIFO_MAX_WMI_TH	41
+
+#define KX022A_REG_INC1		0x1c
+#define KX022A_REG_INC5		0x20
+#define KX022A_REG_INC6		0x21
+#define KX022A_MASK_IEN		BIT(5)
+#define KX022A_MASK_IPOL	BIT(4)
+#define KX022A_IPOL_LOW		0
+#define KX022A_IPOL_HIGH	KX022A_MASK_IPOL1
+#define KX022A_MASK_ITYP	BIT(3)
+#define KX022A_ITYP_PULSE	KX022A_MASK_ITYP
+#define KX022A_ITYP_LEVEL	0
+
+#define KX022A_REG_INC4		0x1f
+#define KX022A_MASK_WMI		BIT(5)
+
+#define KX022A_REG_SELF_TEST	0x60
+#define KX022A_MAX_REGISTER	0x60
+
+struct device;
+
+int kx022a_probe_internal(struct device *dev);
+extern const struct regmap_config kx022a_regmap;
+
+#endif
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

--sNDPMW1OK3xaueiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM+6FYACgkQeFA3/03a
ocVFkAf4wTO6tOVk0ziX6D3eiWAzkCz2iaChBODNmdMC3qtsBUPjWoFwn36FD9AY
L9G1HcKdkrgk1TQBM7L9JfIfCpYOwNVVJA7aHkMWID4N5LjdByV68LOZf4sBkKJu
dlDbjhNpOPrDm108X9A41kobt7ilBOL+O6v+dxj1PuOQbGJNyEjnfgQHr8m5Lblp
KkvfOYh56s29ua4tQmSrKRlqrDkVMDvCaYWs48kLdAHip2crDfHAjOST4vDY1svK
Sas26n+uRS0sepfU9Agnh9Klft7WFzMr6PZf8/V5AE3vamdvvdUtB7P58Qw5W4N3
FLZv2I8FsFUqiOcQ1ywEMqlo8Q09
=wrQT
-----END PGP SIGNATURE-----

--sNDPMW1OK3xaueiz--
