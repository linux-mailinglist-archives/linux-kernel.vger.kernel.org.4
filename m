Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C306A8088
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCBK6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCBK6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:58:31 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D492BF1A;
        Thu,  2 Mar 2023 02:58:25 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id h3so17132741lja.12;
        Thu, 02 Mar 2023 02:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDgTKtiduYCW5/6l2s7b/SmWdVQXOKdkDpLUTl2oOCY=;
        b=cKxAU+KqIMrEjw2H8oWQiv6nkWGdlIEr1JQrRF9P4wbUjKnttVfSkD4g5FCvIcmdJr
         Osh8ah0Ovdj+hDzRw4sLIAc5YT8vX/OiWO3bhSBWGtHupHyhb+Hey/Q6uYW0S9Jafob+
         vVPI3ZswThVSKvKitBTGiAVfxJ7aIb7XVWRlX9uR61M9Q3pvQDQzqAtf5CVdpO5flSqD
         FJwBnt+hBbxbSeCe72Jv9Ib7HZ7jcglIXF+QDac2yR/1lHE1BNezNupQbCixicJuP8ie
         a/K65CVTLnU31/G3VpurP7hVfY3CXj5ABzsGS47fytke6WeLuFQVzJXRFSpnmyRxCMBi
         ixTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDgTKtiduYCW5/6l2s7b/SmWdVQXOKdkDpLUTl2oOCY=;
        b=lOdmMMsheTy4T00Gcq4uQFR6Ac/ixJMv5MzKR1JtCunUifSS5P/+yWWvXtZyap42Bi
         kTBF7pMEEYuw7UAYzG0WFF/hdMwOb5B09kuYeEpeDFkoUxSf4brSxrDxJ2w2ThtgTd0u
         vuPFOEMMo/6pfDTdSxGCVeYEE5oAqSAUz/jOEvmxjdEPPi2rp135K0enGGI8+sM0nbCA
         yRCkxDeieEVMof87kH3iwTcvVXSqTrNhVkKXRpPfVtfWb0IZPv+zfXMd9acAnz9YcQei
         Y5BCBlqIIdgOjdbUV1U4qJKBcYq8pIf3ISEnfLQ4Z+IUcv8c7fDFkn+R6r75FdI5VbEa
         BAAQ==
X-Gm-Message-State: AO0yUKWka0VPA21aOm1+u0WU2dc+Bhv2eIrVk6Yf62NJDST6TrLEdh98
        /hAss8UiYICW5RgOC7PbacE=
X-Google-Smtp-Source: AK7set/2oUQ58vLuHXFM+8MlzHC2wxYPriiFIIqXGUGKej6HaSAuIl8lVS3WKjILqt2iMEeHbaBsEw==
X-Received: by 2002:a05:651c:237:b0:293:54b8:c01e with SMTP id z23-20020a05651c023700b0029354b8c01emr3295377ljn.26.1677754703216;
        Thu, 02 Mar 2023 02:58:23 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id v11-20020a2ea44b000000b002935632b3f8sm2062814ljn.14.2023.03.02.02.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 02:58:22 -0800 (PST)
Date:   Thu, 2 Mar 2023 12:58:17 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 3/6] iio: test: test gain-time-scale helpers
Message-ID: <2a73f2d2a56b1cf7c8e4c0a32ad4993043a11ae0.1677750859.git.mazziesaccount@gmail.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="I8LcFxdtLahVc+gg"
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


--I8LcFxdtLahVc+gg
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
Changes since RFCv1
- add tests for available scales/times helpers
- adapt to renamed iio-gts-helpers.h header
---
 drivers/iio/test/Kconfig        |  15 +
 drivers/iio/test/Makefile       |   1 +
 drivers/iio/test/iio-test-gts.c | 537 ++++++++++++++++++++++++++++++++
 3 files changed, 553 insertions(+)
 create mode 100644 drivers/iio/test/iio-test-gts.c

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 0b6e4e278a2f..b57f1fc440e6 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -4,6 +4,19 @@
 #
=20
 # Keep in alphabetical order
+config IIO_GTS_KUNIT_TEST
+	tristate "Test IIO formatting functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	select IIO_GTS_HELPER
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
@@ -27,3 +40,5 @@ config IIO_FORMAT_KUNIT_TEST
 	  to the KUnit documentation in Documentation/dev-tools/kunit/.
=20
 	  If unsure, say N.
+
+
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
index 000000000000..7b5370c3e09a
--- /dev/null
+++ b/drivers/iio/test/iio-test-gts.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Unit tests for IIO light sensor gain-time-scale helpers
+ *
+ * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/iio/types.h>
+
+#include "../light/iio-gts-helper.h"
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
+static int test_init_iio_gain_scale(struct iio_gts *gts, int max_scale_int,
+				int max_scale_nano)
+{
+	int ret;
+
+	ret =3D iio_init_iio_gts(max_scale_int, max_scale_nano, gts_test_gains,
+			       ARRAY_SIZE(gts_test_gains), gts_test_itimes,
+			       ARRAY_SIZE(gts_test_itimes), gts);
+
+	return ret;
+}
+
+static void test_iio_gts_find_gain_for_scale_using_time(struct kunit *test)
+{
+	struct iio_gts gts;
+	int ret, gain;
+
+	ret =3D test_init_iio_gain_scale(&gts, TEST_SCALE_1X, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	if (ret)
+		return;
+
+	ret =3D iio_gts_find_gain_for_scale_using_time(&gts, TEST_TSEL_100,
+						     TEST_SCALE_8X, 0, &gain);
+	/*
+	 * Meas time 100 =3D> gain by time 2x
+	 * TEST_SCALE_8X matches total gain 8x
+	 * =3D> required HWGAIN 4x
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, 4, gain);
+
+	ret =3D iio_gts_find_gain_for_scale_using_time(&gts, TEST_TSEL_200, 0,
+						TEST_SCALE_NANO_256X, &gain);
+	/*
+	 * Meas time 200 =3D> gain by time 4x
+	 * TEST_SCALE_256X matches total gain 256x
+	 * =3D> required HWGAIN 256/4 =3D> 64x
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, 64, gain);
+
+	/* Min time, Min gain */
+	ret =3D iio_gts_find_gain_for_scale_using_time(&gts, TEST_TSEL_X_MIN,
+						TEST_SCALE_MIN_X, 0, &gain);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, 1, gain);
+
+	/* Max time, Max gain */
+	ret =3D iio_gts_find_gain_for_scale_using_time(&gts, TEST_TSEL_X_MAX, 0,
+						TEST_SCALE_NANO_MAX_X, &gain);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, 4096, gain);
+
+	ret =3D iio_gts_find_gain_for_scale_using_time(&gts, TEST_TSEL_100, 0,
+						TEST_SCALE_NANO_256X, &gain);
+	/*
+	 * Meas time 100 =3D> gain by time 2x
+	 * TEST_SCALE_256X matches total gain 256x
+	 * =3D> required HWGAIN 256/2 =3D> 128x (not in gain-table - unsupported)
+	 */
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	ret =3D iio_gts_find_gain_for_scale_using_time(&gts, TEST_TSEL_200, 0,
+						TEST_SCALE_NANO_MAX_X, &gain);
+	/* We can't reach the max gain with integration time smaller than MAX */
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	ret =3D iio_gts_find_gain_for_scale_using_time(&gts, TEST_TSEL_50, 0,
+						TEST_SCALE_NANO_MAX_X, &gain);
+	/* We can't reach the max gain with integration time smaller than MAX */
+	KUNIT_EXPECT_NE(test, 0, ret);
+}
+
+static void test_iio_gts_find_time_and_gain_sel_for_scale(struct kunit *te=
st)
+{
+	struct iio_gts gts;
+	int ret, gain_sel, time_sel;
+
+	ret =3D test_init_iio_gain_scale(&gts, TEST_SCALE_1X, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	if (ret)
+		return;
+
+	ret =3D iio_gts_find_time_and_gain_sel_for_scale(&gts, 0,
+			TEST_SCALE_NANO_256X, &gain_sel, &time_sel);
+	/*
+	 * We should find time 400 (8x) and gain 256/8 =3D> 32x because the
+	 * time 400 is listed first
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_32, gain_sel);
+	KUNIT_EXPECT_EQ(test, TEST_TSEL_400, time_sel);
+
+	ret =3D iio_gts_find_time_and_gain_sel_for_scale(&gts, TEST_SCALE_64X,
+						       0, &gain_sel, &time_sel);
+	/*
+	 * We should find time 200 (4x) and gain 64/4 =3D> 16x. The most
+	 * preferred time 400 (8x) would require gain 8x - which is not
+	 * "supported".
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_16, gain_sel);
+	KUNIT_EXPECT_EQ(test, TEST_TSEL_200, time_sel);
+
+	/* Min gain */
+	ret =3D iio_gts_find_time_and_gain_sel_for_scale(&gts, TEST_SCALE_MIN_X,
+						0, &gain_sel, &time_sel);
+	/*
+	 * We should find time 400 (8x) and gain 256/8 =3D> 32x because the
+	 * time 400 is listed first
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_1, gain_sel);
+	KUNIT_EXPECT_EQ(test, TEST_TSEL_50, time_sel);
+
+	/* Max gain */
+	ret =3D iio_gts_find_time_and_gain_sel_for_scale(&gts, 0,
+			TEST_SCALE_NANO_MAX_X, &gain_sel, &time_sel);
+	/*
+	 * We should find time 400 (8x) and gain 256/8 =3D> 32x because the
+	 * time 400 is listed first
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_X_MAX, gain_sel);
+	KUNIT_EXPECT_EQ(test, TEST_TSEL_X_MAX, time_sel);
+}
+
+static void test_iio_gts_get_total_gain_by_sel(struct kunit *test)
+{
+	struct iio_gts gts;
+	int ret, gain_sel, time_sel;
+
+	ret =3D test_init_iio_gain_scale(&gts, TEST_SCALE_1X, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	if (ret)
+		return;
+
+	/* gain x32, time x4 =3D> total gain 32 * 4 =3D 128 */
+	gain_sel =3D TEST_GSEL_32;
+	time_sel =3D TEST_TSEL_200;
+
+	ret =3D iio_gts_get_total_gain_by_sel(&gts, gain_sel, time_sel);
+	/* gain x32, time x8 =3D> total gain 32 * 4 =3D 128 */
+	KUNIT_EXPECT_EQ(test, 128, ret);
+
+	gain_sel =3D TEST_GSEL_X_MAX;
+	time_sel =3D TEST_TSEL_X_MAX;
+	ret =3D iio_gts_get_total_gain_by_sel(&gts, gain_sel, time_sel);
+	KUNIT_EXPECT_EQ(test, TOTAL_GAIN_MAX, ret);
+
+	gain_sel =3D TEST_GSEL_X_MIN;
+	time_sel =3D TEST_TSEL_X_MIN;
+	ret =3D iio_gts_get_total_gain_by_sel(&gts, gain_sel, time_sel);
+	KUNIT_EXPECT_EQ(test, 1, ret);
+}
+
+static void test_iio_gts_find_new_gain_sel_by_old_gain_time(struct kunit *=
test)
+{
+	struct iio_gts gts;
+	int ret, old_gain, new_gain, old_time_sel, new_time_sel;
+
+	ret =3D test_init_iio_gain_scale(&gts, TEST_SCALE_1X, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
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
+}
+
+static void test_iio_find_closest_gain_low(struct kunit *test)
+{
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
+	ret =3D test_init_iio_gain_scale(&gts, TEST_SCALE_1X, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
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
+	ret =3D iio_init_iio_gts(TEST_SCALE_1X, 0, gts_test_gains_gain_low,
+			       ARRAY_SIZE(gts_test_gains_gain_low),
+			       gts_test_itimes, ARRAY_SIZE(gts_test_itimes),
+			       &gts);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	if (ret)
+		return;
+
+	ret =3D iio_find_closest_gain_low(&gts, 3, &in_range);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+	KUNIT_EXPECT_EQ(test, false, in_range);
+}
+
+static void test_iio_gts_total_gain_to_scale(struct kunit *test)
+{
+	struct iio_gts gts;
+	int ret, scale_int, scale_nano;
+
+	ret =3D test_init_iio_gain_scale(&gts, TEST_SCALE_1X, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
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
+	struct iio_gts gts;
+	int ret;
+	int type, len;
+	const int *vals;
+
+	ret =3D test_init_iio_gain_scale(&gts, TEST_SCALE_1X, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	if (ret)
+		return;
+
+	ret =3D iio_gts_build_avail_tables(&gts);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	if (ret)
+		return;
+
+	/* test table building for times and iio_gts_avail_times() */
+	ret =3D iio_gts_avail_times(&gts, &vals, &type, &len);
+	KUNIT_EXPECT_EQ(test, IIO_AVAIL_LIST, ret);
+	if (ret)
+		return;
+
+	KUNIT_EXPECT_EQ(test, IIO_VAL_INT, type);
+	KUNIT_EXPECT_EQ(test, 4, len);
+	if (len < 4)
+		return;
+
+	test_iio_gts_chk_times(test, vals);
+
+	/* Test table building for all scales and iio_gts_all_avail_scales() */
+	ret =3D iio_gts_all_avail_scales(&gts, &vals, &type, &len);
+	KUNIT_EXPECT_EQ(test, IIO_AVAIL_LIST, ret);
+	if (ret)
+		return;
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
+		return;
+
+	KUNIT_EXPECT_EQ(test, IIO_VAL_INT_PLUS_NANO, type);
+	test_iio_gts_chk_scales_t200(test, &gts, vals, len);
+
+	iio_gts_purge_avail_tables(&gts);
+}
+
+static struct kunit_case iio_gts_test_cases[] =3D {
+		KUNIT_CASE(test_iio_gts_find_gain_for_scale_using_time),
+		KUNIT_CASE(test_iio_gts_find_time_and_gain_sel_for_scale),
+		KUNIT_CASE(test_iio_gts_get_total_gain_by_sel),
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

--I8LcFxdtLahVc+gg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQAgUkACgkQeFA3/03a
ocU1sgf9Ez5rbe49IbuzQfzKp/lF91WBJhQl98vOhYUzq5hajhpsZYYaF478anyt
wHQ8rD56fF7z8usr6mhZKuedDSZI6iQbsHcwG018VL9724llpjCGukDerV/EEpxC
cV/HO8FClSvYbBPSFkqotDm95qw0/gn9Bp3VSF2CHxT7tCoeuyTt4eg93JuAnnC2
Ay/xvbLBTltZHpjsJuELiorDX2ix9iNs4Nfmi5xfP5p/KnGvH3awTh2UVuwzGMNT
GpeCoiEqBRlx3hIMQpThumfuK55O5xRS7c1qCbbCB/XtofHwc1Tut8HMpyhYra+H
dwJQgVuC637/cBb6vHduTvB35Xampg==
=stAr
-----END PGP SIGNATURE-----

--I8LcFxdtLahVc+gg--
