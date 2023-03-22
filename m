Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44146C45B2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCVJHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCVJHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:07:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3185CC12;
        Wed, 22 Mar 2023 02:07:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y15so22414466lfa.7;
        Wed, 22 Mar 2023 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679476043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WXdyQFGJMKH7LF/uzYPxb5LGja400NKaxr+OlaN6Dg4=;
        b=hTBZ7wNeGVI1xLa4EzEU8uJCOXRUGDXkwoiFlv/NPn+/saKrBvjrwsX6oBzK2RhBXP
         pXOnzmoyUr9j9cYRePQZqsKoz79aWGCYSMzf7+2rSbdPMdjogAmHvkvlblahTrjeH8Di
         aEnikg4jVOy+z766aXFaX8tBPPHquc13ziqCOhWEhUhwMVn8fncIL81PXHd8lrwbo4oK
         UibAYy+8o+TDUGYsCZIGXmmre/eCXpKNzhXyYMaR8zSzjX//vIb+XRRGxQQ24K7bsObT
         2fQaspPsquy3abxQyEXj/0YpYx0XAHoKfU1KOAGOoNTmrUdg5bmbaaC9LdWzRcsmEsf+
         j15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXdyQFGJMKH7LF/uzYPxb5LGja400NKaxr+OlaN6Dg4=;
        b=R0A/U6J9Ncf02MGTwIP7P7rSBRsyXmUdjbVol4mt5+Df9crorvaFZ2kBl0ovc5h1GP
         pebWIHmhZLRjkjvtMsVQgKzvc0tHiV8px6T8EYGb00BjBN+FW2kd9WZ+sjEv6NkhW5JW
         4GRjXeXa7cG7H9WSB/X9aLSQOdEF7jAS4I9I18622Z2dH+AbGWbFgNfsSkDK4TSSrCX+
         yy7OrX6ypAM6PBeaYeNwJpyHk4WiZDeRK8jhtqYZ2+/TttobMubZD6ek9I8iM0nXnq+v
         3Fv/E73bDzr66Q3v8eR7U74VqVZrde6ZSSsQtawDfTxyvVzd//rnESZcV/asMVmWHDbq
         0Y/A==
X-Gm-Message-State: AO0yUKVes9RlxJYSqOE6eECJMwXXu3iwXgABMDwPYEaquspYEXBwL4Qz
        8QGzhOYClZW0hcmpylTddn4=
X-Google-Smtp-Source: AK7set+mUpMww1UQE7LwlSBo9dl3dc7XmR5BY0yt1wnI5b7WMKYvsDPoH9AX0e16WkKLYMTQxI8z8Q==
X-Received: by 2002:ac2:522c:0:b0:4ca:98ec:7d9a with SMTP id i12-20020ac2522c000000b004ca98ec7d9amr1729403lfl.15.1679476042998;
        Wed, 22 Mar 2023 02:07:22 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id d12-20020ac241cc000000b004cc7026d95asm2529242lfi.259.2023.03.22.02.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:07:22 -0700 (PDT)
Date:   Wed, 22 Mar 2023 11:07:18 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v5 5/8] iio: test: test gain-time-scale helpers
Message-ID: <3f33fc551c0698b4cddb0d39911dddf7599c6317.1679474247.git.mazziesaccount@gmail.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kBHIsKE5d46xWpYs"
Content-Disposition: inline
In-Reply-To: <cover.1679474247.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kBHIsKE5d46xWpYs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some light sensors can adjust both the HW-gain and integration time.
There are cases where adjusting the integration time has similar impact
to the scale of the reported values as gain setting has.

IIO users do typically expect to handle scale by a single writable 'scale'
entry. Driver should then adjust the gain/time accordingly.

It however is difficult for a driver to know whether it should change
gain or integration time to meet the requested scale. Usually it is
preferred to have longer integration time which usually improves
accuracy, but there may be use-cases where long measurement times can be
an issue. Thus it can be preferable to allow also changing the
integration time - but mitigate the scale impact by also changing the gain
underneath. Eg, if integration time change doubles the measured values,
the driver can reduce the HW-gain to half.

The theory of the computations of gain-time-scale is simple. However,
some people (undersigned) got that implemented wrong for more than once.
Hence some gain-time-scale helpers were introduced.

Add some simple tests to verify the most hairy functions.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Changes:
v4 =3D> v5:
- remove empty lines from Kconfig
- adapt to drop of the non devm iio_init
- test also init with couple of invalid tables

v3 =3D> v4:
- use dummy device to test devm interfaces
- adapt to the new header location
- drop tests for dropped interfaces

v2 =3D> v3:
- Use namespace for iio-gts-helpers

RFCv1 =3D> v2:
- add tests for available scales/times helpers
- adapt to renamed iio-gts-helpers.h header
---
 drivers/iio/test/Kconfig        |  14 +
 drivers/iio/test/Makefile       |   1 +
 drivers/iio/test/iio-test-gts.c | 542 ++++++++++++++++++++++++++++++++
 3 files changed, 557 insertions(+)
 create mode 100644 drivers/iio/test/iio-test-gts.c

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 0b6e4e278a2f..33cca49c8058 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -4,6 +4,20 @@
 #
=20
 # Keep in alphabetical order
+config IIO_GTS_KUNIT_TEST
+	tristate "Test IIO formatting functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	select IIO_GTS_HELPER
+	select TEST_KUNIT_DEVICE_HELPERS
+	default KUNIT_ALL_TESTS
+	help
+	  build unit tests for the IIO light sensor gain-time-scale helpers.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N. Keep in alphabetical order
+
 config IIO_RESCALE_KUNIT_TEST
 	tristate "Test IIO rescale conversion functions" if !KUNIT_ALL_TESTS
 	depends on KUNIT && IIO_RESCALE
diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index d76eaf36da82..e9a4cf1ff57f 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -6,4 +6,5 @@
 # Keep in alphabetical order
 obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) +=3D iio-test-rescale.o
 obj-$(CONFIG_IIO_FORMAT_KUNIT_TEST) +=3D iio-test-format.o
+obj-$(CONFIG_IIO_GTS_KUNIT_TEST) +=3D iio-test-gts.o
 CFLAGS_iio-test-format.o +=3D $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/iio/test/iio-test-gts.c b/drivers/iio/test/iio-test-gt=
s.c
new file mode 100644
index 000000000000..fb806a79a08f
--- /dev/null
+++ b/drivers/iio/test/iio-test-gts.c
@@ -0,0 +1,542 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Unit tests for IIO light sensor gain-time-scale helpers
+ *
+ * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#include <kunit/platform_device.h>
+#include <kunit/test.h>
+#include <linux/iio/iio-gts-helper.h>
+#include <linux/iio/types.h>
+
+/*
+ * Please, read the "rant" from the top of the lib/test_linear_ranges.c if
+ * you see a line of helper code which is not being tested.
+ *
+ * Then, please look at the line which is not being tested. Is this line
+ * somehow unusually complex? If answer is "no", then chances are that the
+ * "development inertia" caused by adding a test exceeds the benefits.
+ *
+ * If yes, then adding a test is probably a good idea but please stop for a
+ * moment and consider the effort of changing all the tests when code gets
+ * refactored. Eventually it neeeds to be.
+ */
+
+#define TEST_TSEL_50		1
+#define TEST_TSEL_X_MIN		TEST_TSEL_50
+#define TEST_TSEL_100		0
+#define TEST_TSEL_200		2
+#define TEST_TSEL_400		4
+#define TEST_TSEL_X_MAX		TEST_TSEL_400
+
+#define TEST_GSEL_1		0x00
+#define TEST_GSEL_X_MIN		TEST_GSEL_1
+#define TEST_GSEL_4		0x08
+#define TEST_GSEL_16		0x0a
+#define TEST_GSEL_32		0x0b
+#define TEST_GSEL_64		0x0c
+#define TEST_GSEL_256		0x18
+#define TEST_GSEL_512		0x19
+#define TEST_GSEL_1024		0x1a
+#define TEST_GSEL_2048		0x1b
+#define TEST_GSEL_4096		0x1c
+#define TEST_GSEL_X_MAX		TEST_GSEL_4096
+
+#define TEST_SCALE_1X		64
+#define TEST_SCALE_MIN_X	TEST_SCALE_1X
+#define TEST_SCALE_2X		32
+#define TEST_SCALE_4X		16
+#define TEST_SCALE_8X		8
+#define TEST_SCALE_16X		4
+#define TEST_SCALE_32X		2
+#define TEST_SCALE_64X		1
+
+#define TEST_SCALE_NANO_128X	500000000
+#define TEST_SCALE_NANO_256X	250000000
+#define TEST_SCALE_NANO_512X	125000000
+#define TEST_SCALE_NANO_1024X	62500000
+#define TEST_SCALE_NANO_2048X	31250000
+#define TEST_SCALE_NANO_4096X	15625000
+#define TEST_SCALE_NANO_4096X2	7812500
+#define TEST_SCALE_NANO_4096X4	3906250
+#define TEST_SCALE_NANO_4096X8	1953125
+
+#define TEST_SCALE_NANO_MAX_X TEST_SCALE_NANO_4096X8
+
+static const struct iio_gain_sel_pair gts_test_gains[] =3D {
+	GAIN_SCALE_GAIN(1, TEST_GSEL_1),
+	GAIN_SCALE_GAIN(4, TEST_GSEL_4),
+	GAIN_SCALE_GAIN(16, TEST_GSEL_16),
+	GAIN_SCALE_GAIN(32, TEST_GSEL_32),
+	GAIN_SCALE_GAIN(64, TEST_GSEL_64),
+	GAIN_SCALE_GAIN(256, TEST_GSEL_256),
+	GAIN_SCALE_GAIN(512, TEST_GSEL_512),
+	GAIN_SCALE_GAIN(1024, TEST_GSEL_1024),
+	GAIN_SCALE_GAIN(2048, TEST_GSEL_2048),
+	GAIN_SCALE_GAIN(4096, TEST_GSEL_4096),
+#define HWGAIN_MAX 4096
+};
+
+static const struct iio_itime_sel_mul gts_test_itimes[] =3D {
+	GAIN_SCALE_ITIME_US(400 * 1000, TEST_TSEL_400, 8),
+	GAIN_SCALE_ITIME_US(200 * 1000, TEST_TSEL_200, 4),
+	GAIN_SCALE_ITIME_US(100 * 1000, TEST_TSEL_100, 2),
+	GAIN_SCALE_ITIME_US(50 * 1000, TEST_TSEL_50, 1),
+#define TIMEGAIN_MAX 8
+};
+#define TOTAL_GAIN_MAX	(HWGAIN_MAX * TIMEGAIN_MAX)
+
+struct gts_test {
+	struct kunit *test;
+	struct device *dev;
+};
+
+static int __test_init_iio_gain_scale(struct kunit *test, struct gts_test =
*gt,
+			struct iio_gts *gts, int max_scale_int, int max_scale_nano,
+			const struct iio_gain_sel_pair *g_table, int num_g,
+			const struct iio_itime_sel_mul *i_table, int num_i)
+{
+	int ret;
+
+	gt->test =3D test;
+	gt->dev =3D test_kunit_helper_alloc_device(test);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, gt->dev);
+	if (!gt->dev)
+		return -EINVAL;
+
+	ret =3D devm_iio_init_iio_gts(gt->dev, max_scale_int, max_scale_nano,
+				    g_table, num_g, i_table, num_i, gts);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	if (ret)
+		test_kunit_helper_free_device(gt->test, gt->dev);
+
+	return ret;
+
+}
+
+static void test_free_gts(struct gts_test *gt)
+{
+	test_kunit_helper_free_device(gt->test, gt->dev);
+}
+
+static int test_init_iio_gain_scale(struct kunit *test, struct gts_test *g=
t,
+				    struct iio_gts *gts, int max_scale_int,
+				    int max_scale_nano)
+{
+	return __test_init_iio_gain_scale(test, gt, gts, max_scale_int,
+				max_scale_nano, gts_test_gains,
+				ARRAY_SIZE(gts_test_gains), gts_test_itimes,
+				ARRAY_SIZE(gts_test_itimes));
+}
+
+static void test_init_iio_gts_invalid(struct kunit *test)
+{
+	struct iio_gts gts;
+	struct device *dev;
+	int ret;
+	const struct iio_itime_sel_mul itimes_neg[] =3D {
+		GAIN_SCALE_ITIME_US(-10, TEST_TSEL_400, 8),
+		GAIN_SCALE_ITIME_US(200 * 1000, TEST_TSEL_200, 4),
+	};
+	const struct iio_gain_sel_pair gains_neg[] =3D {
+		GAIN_SCALE_GAIN(1, TEST_GSEL_1),
+		GAIN_SCALE_GAIN(2, TEST_GSEL_4),
+		GAIN_SCALE_GAIN(-2, TEST_GSEL_16),
+	};
+	/* 55555 * 38656 =3D 2147534080 =3D> overflows 32bit int */
+	const struct iio_itime_sel_mul itimes_overflow[] =3D {
+		GAIN_SCALE_ITIME_US(400 * 1000, TEST_TSEL_400, 55555),
+		GAIN_SCALE_ITIME_US(200 * 1000, TEST_TSEL_200, 4),
+	};
+	const struct iio_gain_sel_pair gains_overflow[] =3D {
+		GAIN_SCALE_GAIN(1, TEST_GSEL_1),
+		GAIN_SCALE_GAIN(2, TEST_GSEL_4),
+		GAIN_SCALE_GAIN(38656, TEST_GSEL_16),
+	};
+
+	dev =3D test_kunit_helper_alloc_device(test);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
+	if (!dev)
+		return;
+
+	/* Ok gains, negative time */
+	ret =3D devm_iio_init_iio_gts(dev, TEST_SCALE_1X, 0, gts_test_gains,
+				    ARRAY_SIZE(gts_test_gains), itimes_neg,
+				    ARRAY_SIZE(itimes_neg), &gts);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+
+	/* Ok times, negative gain */
+	ret =3D devm_iio_init_iio_gts(dev, TEST_SCALE_1X, 0, gains_neg,
+				    ARRAY_SIZE(gains_neg), gts_test_itimes,
+				    ARRAY_SIZE(gts_test_itimes), &gts);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+
+	/* gain * time overflow int */
+	ret =3D devm_iio_init_iio_gts(dev, TEST_SCALE_1X, 0, gains_overflow,
+				    ARRAY_SIZE(gains_overflow), itimes_overflow,
+				    ARRAY_SIZE(itimes_overflow), &gts);
+	KUNIT_EXPECT_EQ(test, -EOVERFLOW, ret);
+	test_kunit_helper_free_device(test, dev);
+}
+
+static void test_iio_gts_find_gain_for_scale_using_time(struct kunit *test)
+{
+	struct gts_test gt;
+	struct iio_gts gts;
+	int ret, gain_sel;
+
+	ret =3D test_init_iio_gain_scale(test, &gt, &gts, TEST_SCALE_1X, 0);
+	if (ret)
+		return;
+
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&gts, TEST_TSEL_100,
+						TEST_SCALE_8X, 0, &gain_sel);
+	/*
+	 * Meas time 100 =3D> gain by time 2x
+	 * TEST_SCALE_8X matches total gain 8x
+	 * =3D> required HWGAIN 4x
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_4, gain_sel);
+
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&gts, TEST_TSEL_200, 0,
+						TEST_SCALE_NANO_256X, &gain_sel);
+	/*
+	 * Meas time 200 =3D> gain by time 4x
+	 * TEST_SCALE_256X matches total gain 256x
+	 * =3D> required HWGAIN 256/4 =3D> 64x
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_64, gain_sel);
+
+	/* Min time, Min gain */
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&gts, TEST_TSEL_X_MIN,
+						TEST_SCALE_MIN_X, 0, &gain_sel);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_1, gain_sel);
+
+	/* Max time, Max gain */
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&gts, TEST_TSEL_X_MAX,
+					0, TEST_SCALE_NANO_MAX_X, &gain_sel);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_4096, gain_sel);
+
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&gts, TEST_TSEL_100, 0,
+						TEST_SCALE_NANO_256X, &gain_sel);
+	/*
+	 * Meas time 100 =3D> gain by time 2x
+	 * TEST_SCALE_256X matches total gain 256x
+	 * =3D> required HWGAIN 256/2 =3D> 128x (not in gain-table - unsupported)
+	 */
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&gts, TEST_TSEL_200, 0,
+						TEST_SCALE_NANO_MAX_X, &gain_sel);
+	/* We can't reach the max gain with integration time smaller than MAX */
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&gts, TEST_TSEL_50, 0,
+						TEST_SCALE_NANO_MAX_X, &gain_sel);
+	/* We can't reach the max gain with integration time smaller than MAX */
+	KUNIT_EXPECT_NE(test, 0, ret);
+	test_free_gts(&gt);
+}
+
+static void test_iio_gts_find_new_gain_sel_by_old_gain_time(struct kunit *=
test)
+{
+	struct gts_test gt;
+	struct iio_gts gts;
+	int ret, old_gain, new_gain, old_time_sel, new_time_sel;
+
+	ret =3D test_init_iio_gain_scale(test, &gt, &gts, TEST_SCALE_1X, 0);
+	if (ret)
+		return;
+
+	old_gain =3D 32;
+	old_time_sel =3D TEST_TSEL_200;
+	new_time_sel =3D TEST_TSEL_400;
+
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	/*
+	 * Doubling the integration time doubles the total gain - so old
+	 * (hw)gain must be divided by two to compensate. =3D> 32 / 2 =3D> 16
+	 */
+	KUNIT_EXPECT_EQ(test, 16, new_gain);
+
+	old_gain =3D 4;
+	old_time_sel =3D TEST_TSEL_50;
+	new_time_sel =3D TEST_TSEL_200;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	/*
+	 * gain by time 1x =3D> 4x - (hw)gain 4x =3D> 1x
+	 */
+	KUNIT_EXPECT_EQ(test, 1, new_gain);
+
+	old_gain =3D 512;
+	old_time_sel =3D TEST_TSEL_400;
+	new_time_sel =3D TEST_TSEL_50;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	/*
+	 * gain by time 8x =3D> 1x - (hw)gain 512x =3D> 4096x)
+	 */
+	KUNIT_EXPECT_EQ(test, 4096, new_gain);
+
+	/* Unsupported gain 2x */
+	old_gain =3D 4;
+	old_time_sel =3D TEST_TSEL_200;
+	new_time_sel =3D TEST_TSEL_400;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	/* Too small gain */
+	old_gain =3D 4;
+	old_time_sel =3D TEST_TSEL_50;
+	new_time_sel =3D TEST_TSEL_400;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	/* Too big gain */
+	old_gain =3D 1024;
+	old_time_sel =3D TEST_TSEL_400;
+	new_time_sel =3D TEST_TSEL_50;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	test_free_gts(&gt);
+}
+
+static void test_iio_find_closest_gain_low(struct kunit *test)
+{
+	struct gts_test gt;
+	struct iio_gts gts;
+	bool in_range;
+	int ret;
+
+	const struct iio_gain_sel_pair gts_test_gains_gain_low[] =3D {
+		GAIN_SCALE_GAIN(4, TEST_GSEL_4),
+		GAIN_SCALE_GAIN(16, TEST_GSEL_16),
+		GAIN_SCALE_GAIN(32, TEST_GSEL_32),
+	};
+
+	ret =3D test_init_iio_gain_scale(test, &gt, &gts, TEST_SCALE_1X, 0);
+	if (ret)
+		return;
+
+	ret =3D iio_find_closest_gain_low(&gts, 2, &in_range);
+	KUNIT_EXPECT_EQ(test, 1, ret);
+	KUNIT_EXPECT_EQ(test, true, in_range);
+
+	ret =3D iio_find_closest_gain_low(&gts, 1, &in_range);
+	KUNIT_EXPECT_EQ(test, 1, ret);
+	KUNIT_EXPECT_EQ(test, true, in_range);
+
+	ret =3D iio_find_closest_gain_low(&gts, 4095, &in_range);
+	KUNIT_EXPECT_EQ(test, 2048, ret);
+	KUNIT_EXPECT_EQ(test, true, in_range);
+
+	ret =3D iio_find_closest_gain_low(&gts, 4097, &in_range);
+	KUNIT_EXPECT_EQ(test, 4096, ret);
+	KUNIT_EXPECT_EQ(test, false, in_range);
+
+	test_free_gts(&gt);
+
+	ret =3D __test_init_iio_gain_scale(test, &gt, &gts, TEST_SCALE_1X, 0,
+				gts_test_gains_gain_low,
+				ARRAY_SIZE(gts_test_gains_gain_low),
+				gts_test_itimes, ARRAY_SIZE(gts_test_itimes));
+
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	if (ret)
+		return;
+
+	ret =3D iio_find_closest_gain_low(&gts, 3, &in_range);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+	KUNIT_EXPECT_EQ(test, false, in_range);
+
+	test_free_gts(&gt);
+}
+
+static void test_iio_gts_total_gain_to_scale(struct kunit *test)
+{
+	struct gts_test gt;
+	struct iio_gts gts;
+	int ret, scale_int, scale_nano;
+
+	ret =3D test_init_iio_gain_scale(test, &gt, &gts, TEST_SCALE_1X, 0);
+	if (ret)
+		return;
+
+	ret =3D iio_gts_total_gain_to_scale(&gts, 1, &scale_int, &scale_nano);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_SCALE_1X, scale_int);
+	KUNIT_EXPECT_EQ(test, 0, scale_nano);
+
+	ret =3D iio_gts_total_gain_to_scale(&gts, 1, &scale_int, &scale_nano);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_SCALE_1X, scale_int);
+	KUNIT_EXPECT_EQ(test, 0, scale_nano);
+
+	ret =3D iio_gts_total_gain_to_scale(&gts, 4096 * 8, &scale_int,
+					  &scale_nano);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, 0, scale_int);
+	KUNIT_EXPECT_EQ(test, TEST_SCALE_NANO_4096X8, scale_nano);
+
+	test_free_gts(&gt);
+}
+
+static void test_iio_gts_chk_times(struct kunit *test, const int *vals)
+{
+	static const int expected[] =3D {50000, 100000, 200000, 400000};
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(expected); i++)
+		KUNIT_EXPECT_EQ(test, expected[i], vals[i]);
+}
+
+static void test_iio_gts_chk_scales_all(struct kunit *test, struct iio_gts=
 *gts,
+					const int *vals, int len)
+{
+	static const int gains[] =3D {1, 2, 4, 8, 16, 32, 64, 128, 256, 512,
+				    1024, 2048, 4096, 4096 * 2, 4096 * 4,
+				    4096 * 8};
+
+	int expected[ARRAY_SIZE(gains) * 2];
+	int i, ret;
+	int exp_len =3D ARRAY_SIZE(gains) * 2;
+
+	KUNIT_EXPECT_EQ(test, exp_len, len);
+	if (len !=3D exp_len)
+		return;
+
+	for (i =3D 0; i < ARRAY_SIZE(gains); i++) {
+		ret =3D iio_gts_total_gain_to_scale(gts, gains[i],
+						  &expected[2 * i],
+						  &expected[2 * i + 1]);
+		KUNIT_EXPECT_EQ(test, 0, ret);
+		if (ret)
+			return;
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(expected); i++)
+		KUNIT_EXPECT_EQ(test, expected[i], vals[i]);
+}
+
+static void test_iio_gts_chk_scales_t200(struct kunit *test, struct iio_gt=
s *gts,
+					 const int *vals, int len)
+{
+	/* The gain caused by time 200 is 4x */
+	static const int gains[] =3D {
+		1 * 4,
+		4 * 4,
+		16 * 4,
+		32 * 4,
+		64 * 4,
+		256 * 4,
+		512 * 4,
+		1024 * 4,
+		2048 * 4,
+		4096 * 4
+	};
+	int expected[ARRAY_SIZE(gains) * 2];
+	int i, ret;
+
+	KUNIT_EXPECT_EQ(test, 2 * ARRAY_SIZE(gains), len);
+	if (len < 2 * ARRAY_SIZE(gains))
+		return;
+
+	for (i =3D 0; i < ARRAY_SIZE(gains); i++) {
+		ret =3D iio_gts_total_gain_to_scale(gts, gains[i],
+						  &expected[2 * i],
+						  &expected[2 * i + 1]);
+		KUNIT_EXPECT_EQ(test, 0, ret);
+		if (ret)
+			return;
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(expected); i++)
+		KUNIT_EXPECT_EQ(test, expected[i], vals[i]);
+}
+
+static void test_iio_gts_avail_test(struct kunit *test)
+{
+	struct gts_test gt;
+	struct iio_gts gts;
+	int ret;
+	int type, len;
+	const int *vals;
+
+	ret =3D test_init_iio_gain_scale(test, &gt, &gts, TEST_SCALE_1X, 0);
+	if (ret)
+		return;
+
+	/* test table building for times and iio_gts_avail_times() */
+	ret =3D iio_gts_avail_times(&gts, &vals, &type, &len);
+	KUNIT_EXPECT_EQ(test, IIO_AVAIL_LIST, ret);
+	if (ret)
+		goto drop_testdev;
+
+	KUNIT_EXPECT_EQ(test, IIO_VAL_INT, type);
+	KUNIT_EXPECT_EQ(test, 4, len);
+	if (len < 4)
+		goto drop_testdev;
+
+	test_iio_gts_chk_times(test, vals);
+
+	/* Test table building for all scales and iio_gts_all_avail_scales() */
+	ret =3D iio_gts_all_avail_scales(&gts, &vals, &type, &len);
+	KUNIT_EXPECT_EQ(test, IIO_AVAIL_LIST, ret);
+	if (ret)
+		goto drop_testdev;
+
+	KUNIT_EXPECT_EQ(test, IIO_VAL_INT_PLUS_NANO, type);
+
+	test_iio_gts_chk_scales_all(test, &gts, vals, len);
+
+	/*
+	 * Test table building for scales/time and
+	 * iio_gts_avail_scales_for_time()
+	 */
+	ret =3D iio_gts_avail_scales_for_time(&gts, 200000, &vals, &type, &len);
+	KUNIT_EXPECT_EQ(test, IIO_AVAIL_LIST, ret);
+	if (ret)
+		goto drop_testdev;
+
+	KUNIT_EXPECT_EQ(test, IIO_VAL_INT_PLUS_NANO, type);
+	test_iio_gts_chk_scales_t200(test, &gts, vals, len);
+
+drop_testdev:
+	test_free_gts(&gt);
+}
+
+static struct kunit_case iio_gts_test_cases[] =3D {
+		KUNIT_CASE(test_init_iio_gts_invalid),
+		KUNIT_CASE(test_iio_gts_find_gain_for_scale_using_time),
+		KUNIT_CASE(test_iio_gts_find_new_gain_sel_by_old_gain_time),
+		KUNIT_CASE(test_iio_find_closest_gain_low),
+		KUNIT_CASE(test_iio_gts_total_gain_to_scale),
+		KUNIT_CASE(test_iio_gts_avail_test),
+		{}
+};
+
+static struct kunit_suite iio_gts_test_suite =3D {
+	.name =3D "iio-gain-time-scale",
+	.test_cases =3D iio_gts_test_cases,
+};
+
+kunit_test_suite(iio_gts_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("Test IIO light sensor gain-time-scale helpers");
+MODULE_IMPORT_NS(IIO_GTS_HELPER);
+
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

--kBHIsKE5d46xWpYs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQaxUYACgkQeFA3/03a
ocV5bQf9HLEcHUby/DOM3wrCDZg3NhCMkKyjeHURdh++sDGxe7XVm09GRNuDb+j0
mhHEz8/TzJ7dOA8UmnINSDREqFv14Tx6ociPSPe7ReyUpSIOdEW2L6vPF7tWNlec
GzBfq1vZjRkLZyhzwrSt1Q5n6oy9B9NCxUJ5bOVWbG5dad/8FrW3y4TZ84ADdASk
NVV0ToMD2l6/x9Qn+BADZGhdO3qcvX6ZpJ4RWW1nKWOQSbImuxdR1LiCPDzXemWk
965d6j+eowTmk4dkj+girFctCPrJf8sfvhoQZfLIt1zGmuJi2uIqlHt6WWCX4r4i
o9ukRTBOwZvhaw0YQPa2yRoT89QYwg==
=EZLi
-----END PGP SIGNATURE-----

--kBHIsKE5d46xWpYs--
