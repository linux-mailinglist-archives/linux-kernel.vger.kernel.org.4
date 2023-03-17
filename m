Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF93A6BEB91
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCQOmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCQOmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:42:42 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4413F2A9BC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:42:40 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id z5so5315430ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679064158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UGy7oNS94ufYKednhkXhlJ35f2xeVGrjXtmL/TmdAmU=;
        b=UGEIY1Truue6z82ReZqcgi14hxPvGrZO5KlhxsHlIX6C1wTBXMm2obt2RCu4mK5BiD
         V9YDocoX8kwS0N2Ob6lozTqfoKLxuBSvOhP9AnvnVwq1k+AwqvK2Q+zYfP5KdXKVgC8w
         q5FSfwkdW8zPo3Owai1Voz1u/gDO8sJ2PZOxe53V3b+9uNVgxo/xggHe1XmqUfxHq+vF
         fQ26riHH/IX5JnZAHKJMq/SlqRAG/pvv1Yjp8KK8FVTmo348bo0N6burD62msiM6qUXO
         fg5hRWjVAJg3xPElpIIXmoiVG7XtaUMq/NXoeyqjBlu6X4N4Q46nxiJnwNprHezKlw2n
         SBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679064158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGy7oNS94ufYKednhkXhlJ35f2xeVGrjXtmL/TmdAmU=;
        b=YgxCHs4aMNslLJtUdUmebaSIpa+C4HE5NhYRa010+hSVWfZww6YD7gTKWXKshwiw/C
         fsPgY9ZfoNlpLeGaG9QtH4CzY7R4rrwmna3OPve15zR1NnJVWOkEn0PPL79fiXYOB+6+
         qCIoG55O613kb78l8jWOQQHVM8bN2AdYGFEPXT9nGbbwY0jicW0740/5SLLbQ2ZqAmfJ
         IHOm4QLtezDnQOGRszz7+bfOFTKWKoN3KCyqP4sNKC4RTOdNnh344sF1+VDQ8FT6L3e0
         RxmUXLyakc1gtOMtelXHtUHlxp0ozFFzhPu8hqYS0aIbwncAybLR7vJBfhPCct451ynh
         YSSg==
X-Gm-Message-State: AO0yUKVfaddZMQlaorGQhs44e5kLsufpXZxjTzNs0VwGf4wp3lg9jMhN
        nokdUmFXFxLaOBqqFlp+dQM=
X-Google-Smtp-Source: AK7set9S6DHfGamLo7j9AmtJ+HWLFQ3IYF0aIIPJRIhXyv/QP/zTwC+8n4viSNWjbSlMUZwZdnCtOg==
X-Received: by 2002:a05:651c:19a7:b0:298:a124:dd8c with SMTP id bx39-20020a05651c19a700b00298a124dd8cmr4534321ljb.38.1679064158295;
        Fri, 17 Mar 2023 07:42:38 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c14-20020a2e680e000000b00295735991edsm438209lja.38.2023.03.17.07.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 07:42:37 -0700 (PDT)
Date:   Fri, 17 Mar 2023 16:42:25 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v4 2/8] kunit: drm/tests: move generic helpers
Message-ID: <1abd47784b08939ff08ff03d3d4f60449e87625f.1679062529.git.mazziesaccount@gmail.com>
References: <cover.1679062529.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0DWFbZ8eEtrWvxBl"
Content-Disposition: inline
In-Reply-To: <cover.1679062529.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0DWFbZ8eEtrWvxBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The creation of a dummy device in order to test managed interfaces is a
generally useful test feature. The drm test helpers
test_kunit_helper_alloc_device() and test_kunit_helper_free_device()
are doing exactly this. It makes no sense that each and every component
which intends to be testing managed interfaces will create similar
helpers.

Move these functions to place where it is more obvious they can be used
also by other subsystems but drm.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

Please note that there's something similat ongoing in the CCF:
https://lore.kernel.org/all/20230302013822.1808711-1-sboyd@kernel.org/

I do like the simplicity of these DRM-originated helpers so I think
they're worth. I do equally like the Stephen's idea of having the
"dummy platform device" related helpers under drivers/base and the
header being in include/kunit/platform_device.h which is similar to real
platform device under include/linux/platform_device.h - so, in the end
of the day I hope Stephen's changes as well as the changes this patch
introduces to end up in those files. This, however, will require some
co-operation to avoid conflicts.
---
 drivers/base/test/Kconfig                     |  5 ++
 drivers/base/test/Makefile                    |  2 +
 drivers/base/test/test_kunit_device.c         | 83 +++++++++++++++++++
 drivers/gpu/drm/Kconfig                       |  2 +
 .../gpu/drm/tests/drm_client_modeset_test.c   |  1 +
 drivers/gpu/drm/tests/drm_kunit_helpers.c     | 69 ---------------
 drivers/gpu/drm/tests/drm_managed_test.c      |  1 +
 drivers/gpu/drm/tests/drm_modes_test.c        |  1 +
 drivers/gpu/drm/tests/drm_probe_helper_test.c |  1 +
 drivers/gpu/drm/vc4/Kconfig                   |  1 +
 drivers/gpu/drm/vc4/tests/vc4_mock.c          |  1 +
 .../gpu/drm/vc4/tests/vc4_test_pv_muxing.c    |  1 +
 include/drm/drm_kunit_helpers.h               |  3 -
 13 files changed, 99 insertions(+), 72 deletions(-)
 create mode 100644 drivers/base/test/test_kunit_device.c

diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 610a1ba7a467..642b5b183c10 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -1,4 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
+
+config TEST_KUNIT_DEVICE_HELPERS
+	depends on KUNIT
+	tristate
+
 config TEST_ASYNC_DRIVER_PROBE
 	tristate "Build kernel module to test asynchronous driver probing"
 	depends on m
diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index 7f76fee6f989..49926524ec6f 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+=3D test_async_driver_probe.o
=20
+obj-$(CONFIG_TEST_KUNIT_DEVICE_HELPERS) +=3D test_kunit_device.o
+
 obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) +=3D property-entry-test.o
 CFLAGS_property-entry-test.o +=3D $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/base/test/test_kunit_device.c b/drivers/base/test/test=
_kunit_device.c
new file mode 100644
index 000000000000..75790e15b85c
--- /dev/null
+++ b/drivers/base/test/test_kunit_device.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * These helpers have been extracted from drm test code at
+ * drm_kunit_helpers.c which was authored by
+ * Maxime Ripard <maxime@cerno.tech>
+ */
+
+#include <linux/device.h>
+#include <linux/platform_device.h>
+
+#include <kunit/platform_device.h>
+
+#define KUNIT_DEVICE_NAME	"test-kunit-mock-device"
+
+static int fake_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int fake_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver fake_platform_driver =3D {
+	.probe	=3D fake_probe,
+	.remove	=3D fake_remove,
+	.driver =3D {
+		.name	=3D KUNIT_DEVICE_NAME,
+	},
+};
+
+/**
+ * test_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
+ * @test: The test context object
+ *
+ * This allocates a fake struct &device to create a mock for a KUnit
+ * test. The device will also be bound to a fake driver. It will thus be
+ * able to leverage the usual infrastructure and most notably the
+ * device-managed resources just like a "real" device.
+ *
+ * Callers need to make sure test_kunit_helper_free_device() on the
+ * device when done.
+ *
+ * Returns:
+ * A pointer to the new device, or an ERR_PTR() otherwise.
+ */
+struct device *test_kunit_helper_alloc_device(struct kunit *test)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	ret =3D platform_driver_register(&fake_platform_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	pdev =3D platform_device_alloc(KUNIT_DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	ret =3D platform_device_add(pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	return &pdev->dev;
+}
+EXPORT_SYMBOL_GPL(test_kunit_helper_alloc_device);
+
+/**
+ * test_kunit_helper_free_device - Frees a mock device
+ * @test: The test context object
+ * @dev: The device to free
+ *
+ * Frees a device allocated with test_kunit_helper_alloc_device().
+ */
+void test_kunit_helper_free_device(struct kunit *test, struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&fake_platform_driver);
+}
+EXPORT_SYMBOL_GPL(test_kunit_helper_free_device);
+
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index dc0f94f02a82..0ee8ebe64f57 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -66,6 +66,7 @@ config DRM_USE_DYNAMIC_DEBUG
 config DRM_KUNIT_TEST_HELPERS
 	tristate
 	depends on DRM && KUNIT
+	select TEST_KUNIT_DEVICE_HELPERS
 	help
 	  KUnit Helpers for KMS drivers.
=20
@@ -80,6 +81,7 @@ config DRM_KUNIT_TEST
 	select DRM_BUDDY
 	select DRM_EXPORT_FOR_TESTS if m
 	select DRM_KUNIT_TEST_HELPERS
+	select TEST_KUNIT_DEVICE_HELPERS
 	default KUNIT_ALL_TESTS
 	help
 	  This builds unit tests for DRM. This option is not useful for
diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/=
drm/tests/drm_client_modeset_test.c
index 27ab03d1c518..d7eaa0938eb4 100644
--- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
+++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2022 Maxime Ripard <mripard@kernel.org>
  */
=20
+#include <kunit/platform_device.h>
 #include <kunit/test.h>
=20
 #include <drm/drm_connector.h>
diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/te=
sts/drm_kunit_helpers.c
index ec93b0300f03..ae84d0ed8744 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -9,78 +9,9 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
=20
-#define KUNIT_DEVICE_NAME	"drm-kunit-mock-device"
-
 static const struct drm_mode_config_funcs drm_mode_config_funcs =3D {
 };
=20
-static int fake_probe(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int fake_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static struct platform_driver fake_platform_driver =3D {
-	.probe	=3D fake_probe,
-	.remove	=3D fake_remove,
-	.driver =3D {
-		.name	=3D KUNIT_DEVICE_NAME,
-	},
-};
-
-/**
- * test_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
- * @test: The test context object
- *
- * This allocates a fake struct &device to create a mock for a KUnit
- * test. The device will also be bound to a fake driver. It will thus be
- * able to leverage the usual infrastructure and most notably the
- * device-managed resources just like a "real" device.
- *
- * Callers need to make sure test_kunit_helper_free_device() on the
- * device when done.
- *
- * Returns:
- * A pointer to the new device, or an ERR_PTR() otherwise.
- */
-struct device *test_kunit_helper_alloc_device(struct kunit *test)
-{
-	struct platform_device *pdev;
-	int ret;
-
-	ret =3D platform_driver_register(&fake_platform_driver);
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
-	pdev =3D platform_device_alloc(KUNIT_DEVICE_NAME, PLATFORM_DEVID_NONE);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
-
-	ret =3D platform_device_add(pdev);
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
-	return &pdev->dev;
-}
-EXPORT_SYMBOL_GPL(test_kunit_helper_alloc_device);
-
-/**
- * test_kunit_helper_free_device - Frees a mock device
- * @test: The test context object
- * @dev: The device to free
- *
- * Frees a device allocated with test_kunit_helper_alloc_device().
- */
-void test_kunit_helper_free_device(struct kunit *test, struct device *dev)
-{
-	struct platform_device *pdev =3D to_platform_device(dev);
-
-	platform_device_unregister(pdev);
-	platform_driver_unregister(&fake_platform_driver);
-}
-EXPORT_SYMBOL_GPL(test_kunit_helper_free_device);
-
 struct drm_device *
 __drm_kunit_helper_alloc_drm_device_with_driver(struct kunit *test,
 						struct device *dev,
diff --git a/drivers/gpu/drm/tests/drm_managed_test.c b/drivers/gpu/drm/tes=
ts/drm_managed_test.c
index 53f870493577..6b39d2cde164 100644
--- a/drivers/gpu/drm/tests/drm_managed_test.c
+++ b/drivers/gpu/drm/tests/drm_managed_test.c
@@ -4,6 +4,7 @@
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_managed.h>
=20
+#include <kunit/platform_device.h>
 #include <kunit/resource.h>
=20
 #include <linux/device.h>
diff --git a/drivers/gpu/drm/tests/drm_modes_test.c b/drivers/gpu/drm/tests=
/drm_modes_test.c
index 1bd8540086e9..addc4d923a26 100644
--- a/drivers/gpu/drm/tests/drm_modes_test.c
+++ b/drivers/gpu/drm/tests/drm_modes_test.c
@@ -7,6 +7,7 @@
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_modes.h>
=20
+#include <kunit/platform_device.h>
 #include <kunit/test.h>
=20
 #include <linux/units.h>
diff --git a/drivers/gpu/drm/tests/drm_probe_helper_test.c b/drivers/gpu/dr=
m/tests/drm_probe_helper_test.c
index bc4b271bec09..f23213464d34 100644
--- a/drivers/gpu/drm/tests/drm_probe_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_probe_helper_test.c
@@ -13,6 +13,7 @@
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_probe_helper.h>
=20
+#include <kunit/platform_device.h>
 #include <kunit/test.h>
=20
 struct drm_probe_helper_test_priv {
diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
index 91dcf8d174d6..a4bd96445315 100644
--- a/drivers/gpu/drm/vc4/Kconfig
+++ b/drivers/gpu/drm/vc4/Kconfig
@@ -39,6 +39,7 @@ config DRM_VC4_KUNIT_TEST
 	tristate "KUnit tests for VC4" if !KUNIT_ALL_TESTS
 	depends on DRM_VC4 && KUNIT
 	select DRM_KUNIT_TEST_HELPERS
+	select TEST_KUNIT_DEVICE_HELPERS
 	default KUNIT_ALL_TESTS
 	help
 	  This builds unit tests for the VC4 DRM/KMS driver. This option is
diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock.c b/drivers/gpu/drm/vc4/tes=
ts/vc4_mock.c
index 5bb1fa828a3f..29eb045b0db1 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock.c
@@ -3,6 +3,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_kunit_helpers.h>
=20
+#include <kunit/platform_device.h>
 #include <kunit/test.h>
=20
 #include "vc4_mock.h"
diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/gpu/d=
rm/vc4/tests/vc4_test_pv_muxing.c
index 8b373fa76d6f..64b90e2e3706 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
@@ -12,6 +12,7 @@
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_plane.h>
=20
+#include <kunit/platform_device.h>
 #include <kunit/test.h>
=20
 #include "../vc4_drv.h"
diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helper=
s.h
index 8e3aae6a5ed5..ab438d97aed3 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -8,9 +8,6 @@
 struct drm_device;
 struct kunit;
=20
-struct device *test_kunit_helper_alloc_device(struct kunit *test);
-void test_kunit_helper_free_device(struct kunit *test, struct device *dev);
-
 struct drm_device *
 __drm_kunit_helper_alloc_drm_device_with_driver(struct kunit *test,
 						struct device *dev,
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

--0DWFbZ8eEtrWvxBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQUfFEACgkQeFA3/03a
ocXgxwgAzsdRWVuEW6vVufZxnZxF6s1cT/3JBzS16rIHm7qaAHZU51mairOWiSBS
b/xppgfhBqNdzUz9Xt+lLnMnue4MH/n9h5XQBQvIePeSFflQqen9Rhco5NPg3sDx
fn/hVPoeAxYlK07mO/roZjiwJmnG1MoaQ4OYv55sMzrjvh7BXSngqNohCou6lmjT
hk7iYe4NnuOmYZg8iCjZUelAH9x5PxwNVOGS7GgxbwqFNxJbeM3vV/TFFkRdt2Hp
gAND9dt9Tq6/mDTH49ul7C/PHMCojApiaSpAcITVpzaNetPZ2NX6OmuW9SHtP0cu
wJ7WYyxrmcJgiazqyIIkRG7ryPCbeg==
=Vccr
-----END PGP SIGNATURE-----

--0DWFbZ8eEtrWvxBl--
