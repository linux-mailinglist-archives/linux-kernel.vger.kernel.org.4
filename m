Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D60F69CA52
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjBTLwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjBTLwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:52:46 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF81BAD8;
        Mon, 20 Feb 2023 03:52:39 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cp9so2245238pjb.0;
        Mon, 20 Feb 2023 03:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1j1FKfM6XLDo8DpqH6IBQb+6Fi1rImq4WOngf4sVck=;
        b=ZkB8/qj5apmbQeV6Lg9NVc5tnZIO9bgYnzBsITR3NBZgnGESz4A4vuHyTy9j+tUuKc
         9l5K0KBCTbmbJBbdKnpagibYkEdEoEkrU9ST5NTbPPHRxAjyDHa+FNRtF+HWYR/ZJsLh
         np74BEXbbDdSfm9EdOWVhea0KT/hFDL4v42yxn9OguIbz7mwdcH7F16/peC8nlijrpAX
         MR/7AwhOSP6b2GHX++S5FWI52F8lo1494S71qnwtYH1wvJQYu0Vp3pEm2UJwbBTSHsKd
         7OsVwzZZYUvCLucklnvgwcXzBXyu8s1xKh86K28UWD2y+MMXDxCo1rZjuTYwbN5Y3iiA
         x8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1j1FKfM6XLDo8DpqH6IBQb+6Fi1rImq4WOngf4sVck=;
        b=QLvnJPp0dzSYJDmglPcfBurMmQYfloWEAnGpk2sNvINhY6BRw3wGjaFB6ROBVKpeit
         SluwDm28Wvee/SaqFeD3y8BysMcWVbL80q/Kr2T8bohckXs3aWlpe822ujs27A3akSzz
         x73WlMl5luS+xK4ByATK1WYlgG9KQvIrfhyzXr58I7Z5ONLmw3uOwhM2pwfAg4MqPS9O
         MoSKUuYKjHpP5KXw0DPsJy9OcTF3k+9Vbuusm5ZAfXoGDGnSYJPLznsHeeGfAtmgGjTy
         35wN/xs08epnydJDYWKQKvhwinMTgVP/zpXAPGiWcYdYHwOjxVwCwGIBhboaSeRPMZE5
         uv8Q==
X-Gm-Message-State: AO0yUKV3cp37S3rcKqpwid9L0WuaaaKUdV3cKIZx6dv/1O3ZOdNxRrZf
        4E+/1ecwFeBg84LXkGgfTk33LAIespD7Hw==
X-Google-Smtp-Source: AK7set/jwUbpJXB5JRY8GNvLj/SXJtRpRtJZyzWFruXuuqxHVmRhLTTCEaLMTWvASaBDbU276RN1hg==
X-Received: by 2002:a17:903:124a:b0:196:8445:56be with SMTP id u10-20020a170903124a00b00196844556bemr669339plh.42.1676893959117;
        Mon, 20 Feb 2023 03:52:39 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001962858f990sm955297plb.164.2023.02.20.03.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 03:52:38 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     linux-doc@vger.kernel.org, linux-input@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 2/2] HID: hid-apple-magic-backlight: Add driver for keyboard backlight on internal Magic Keyboards
Date:   Mon, 20 Feb 2023 22:52:03 +1100
Message-Id: <20230220115203.76154-3-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230220115203.76154-1-orlandoch.dev@gmail.com>
References: <20230220115203.76154-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver adds support for the keyboard backlight on Intel T2 Macs
with internal Magic Keyboards (MacBookPro16,x and MacBookAir9,1)

Co-developed-by: Kerem Karabay <kekrby@gmail.com>
Signed-off-by: Kerem Karabay <kekrby@gmail.com>
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
---
v4->v5:
- use <tab><space><space> for help in Kconfig
- prepend "hid-" to filename in MAINTAINERS
 MAINTAINERS                             |   6 ++
 drivers/hid/Kconfig                     |  13 +++
 drivers/hid/Makefile                    |   1 +
 drivers/hid/hid-apple-magic-backlight.c | 120 ++++++++++++++++++++++++
 4 files changed, 140 insertions(+)
 create mode 100644 drivers/hid/hid-apple-magic-backlight.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a47510d1592..e004217a12eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9201,6 +9201,12 @@ F:	include/linux/pm.h
 F:	include/linux/suspend.h
 F:	kernel/power/
 
+HID APPLE MAGIC BACKLIGHT DRIVER
+M:	Orlando Chamberlain <orlandoch.dev@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-apple-magic-backlight.c
+
 HID CORE LAYER
 M:	Jiri Kosina <jikos@kernel.org>
 M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index e2a5d30c8895..226210c6293c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -130,6 +130,19 @@ config HID_APPLE
 	Say Y here if you want support for keyboards of	Apple iBooks, PowerBooks,
 	MacBooks, MacBook Pros and Apple Aluminum.
 
+config HID_APPLE_MAGIC_BACKLIGHT
+	tristate "Apple Magic Keyboard Backlight"
+	depends on USB_HID
+	depends on LEDS_CLASS
+	depends on NEW_LEDS
+	help
+	  Say Y here if you want support for the keyboard backlight on Macs with
+	  the magic keyboard (MacBookPro16,x and MacBookAir9,1). Note that this
+	  driver is not for external magic keyboards.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-apple-magic-backlight.
+
 config HID_APPLEIR
 	tristate "Apple infrared receiver"
 	depends on (USB_HID)
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index e8014c1a2f8b..dc8df002bc86 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_HID_ACCUTOUCH)	+= hid-accutouch.o
 obj-$(CONFIG_HID_ALPS)		+= hid-alps.o
 obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
 obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
+obj-$(CONFIG_HID_APPLE_MAGIC_BACKLIGHT)	+= hid-apple-magic-backlight.o
 obj-$(CONFIG_HID_APPLEIR)	+= hid-appleir.o
 obj-$(CONFIG_HID_CREATIVE_SB0540)	+= hid-creative-sb0540.o
 obj-$(CONFIG_HID_ASUS)		+= hid-asus.o
diff --git a/drivers/hid/hid-apple-magic-backlight.c b/drivers/hid/hid-apple-magic-backlight.c
new file mode 100644
index 000000000000..f0fc02ff3b2d
--- /dev/null
+++ b/drivers/hid/hid-apple-magic-backlight.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Apple Magic Keyboard Backlight Driver
+ *
+ * For Intel Macs with internal Magic Keyboard (MacBookPro16,1-4 and MacBookAir9,1)
+ *
+ * Copyright (c) 2022 Kerem Karabay <kekrby@gmail.com>
+ * Copyright (c) 2023 Orlando Chamberlain <orlandoch.dev@gmail.com>
+ */
+
+#include <linux/hid.h>
+#include <linux/leds.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <dt-bindings/leds/common.h>
+
+#include "hid-ids.h"
+
+#define HID_USAGE_MAGIC_BL	0xff00000f
+
+#define APPLE_MAGIC_REPORT_ID_POWER 3
+#define APPLE_MAGIC_REPORT_ID_BRIGHTNESS 1
+
+struct apple_magic_backlight {
+	struct led_classdev cdev;
+	struct hid_report *brightness;
+	struct hid_report *power;
+};
+
+static void apple_magic_backlight_report_set(struct hid_report *rep, s32 value, u8 rate)
+{
+	rep->field[0]->value[0] = value;
+	rep->field[1]->value[0] = 0x5e; /* Mimic Windows */
+	rep->field[1]->value[0] |= rate << 8;
+
+	hid_hw_request(rep->device, rep, HID_REQ_SET_REPORT);
+}
+
+static void apple_magic_backlight_set(struct apple_magic_backlight *backlight,
+				     int brightness, char rate)
+{
+	apple_magic_backlight_report_set(backlight->power, brightness ? 1 : 0, rate);
+	if (brightness)
+		apple_magic_backlight_report_set(backlight->brightness, brightness, rate);
+}
+
+static int apple_magic_backlight_led_set(struct led_classdev *led_cdev,
+					 enum led_brightness brightness)
+{
+	struct apple_magic_backlight *backlight = container_of(led_cdev,
+			struct apple_magic_backlight, cdev);
+
+	apple_magic_backlight_set(backlight, brightness, 1);
+	return 0;
+}
+
+static int apple_magic_backlight_probe(struct hid_device *hdev,
+				       const struct hid_device_id *id)
+{
+	struct apple_magic_backlight *backlight;
+	int rc;
+
+	rc = hid_parse(hdev);
+	if (rc)
+		return rc;
+
+	/*
+	 * Ensure this usb endpoint is for the keyboard backlight, not touchbar
+	 * backlight.
+	 */
+	if (hdev->collection[0].usage != HID_USAGE_MAGIC_BL)
+		return -ENODEV;
+
+	backlight = devm_kzalloc(&hdev->dev, sizeof(*backlight), GFP_KERNEL);
+	if (!backlight)
+		return -ENOMEM;
+
+	rc = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (rc)
+		return rc;
+
+	backlight->brightness = hid_register_report(hdev, HID_FEATURE_REPORT,
+			APPLE_MAGIC_REPORT_ID_BRIGHTNESS, 0);
+	backlight->power = hid_register_report(hdev, HID_FEATURE_REPORT,
+			APPLE_MAGIC_REPORT_ID_POWER, 0);
+
+	if (!backlight->brightness || !backlight->power) {
+		rc = -ENODEV;
+		goto hw_stop;
+	}
+
+	backlight->cdev.name = ":white:" LED_FUNCTION_KBD_BACKLIGHT;
+	backlight->cdev.max_brightness = backlight->brightness->field[0]->logical_maximum;
+	backlight->cdev.brightness_set_blocking = apple_magic_backlight_led_set;
+
+	apple_magic_backlight_set(backlight, 0, 0);
+
+	return devm_led_classdev_register(&hdev->dev, &backlight->cdev);
+
+hw_stop:
+	hid_hw_stop(hdev);
+	return rc;
+}
+
+static const struct hid_device_id apple_magic_backlight_hid_ids[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLIGHT) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, apple_magic_backlight_hid_ids);
+
+static struct hid_driver apple_magic_backlight_hid_driver = {
+	.name = "hid-apple-magic-backlight",
+	.id_table = apple_magic_backlight_hid_ids,
+	.probe = apple_magic_backlight_probe,
+};
+module_hid_driver(apple_magic_backlight_hid_driver);
+
+MODULE_DESCRIPTION("MacBook Magic Keyboard Backlight");
+MODULE_AUTHOR("Orlando Chamberlain <orlandoch.dev@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.39.2

