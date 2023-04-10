Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0546DC675
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjDJL7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjDJL7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:59:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60D930C8;
        Mon, 10 Apr 2023 04:59:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6323df83c50so538560b3a.1;
        Mon, 10 Apr 2023 04:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681127982; x=1683719982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UIApucvTdsmrA1sN1AMkmfsqbCtVTo4X47qbsgXiW4=;
        b=Betc6Aq6WBVUJzvzA46ycIcFmgSdsKjxiNeVyfzAOayxFEJu2UkAZ4N4sj9I38hcXS
         hKb8Jw1ZK5yHXuc5gfefWoaJaAwbcGC2hkTixWNYjpUfyxpWE5ucMFhG4KC2etThpFlm
         zy9OTZ4y2qRQYvqdI67VIXYhrVlttTaRdeKsHeCK7aDqNhyqSK2+wlofX4C5SstQ+30F
         ygjH55kT/2hkAN0ynJ4tZ0k4DYgOC7eNjaUkskNLueb2Gffohsz6vlh9ly3yxDQ0XwjR
         EIDozCgXO3S33FymupZTSkK9p4zusWDacHa4aCKfRBYf3m+szWT+MYm+ziba339g9sbq
         97ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681127982; x=1683719982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UIApucvTdsmrA1sN1AMkmfsqbCtVTo4X47qbsgXiW4=;
        b=mFy6JOu1NjMpHO9upVbu+lr/bQORrkjoRE79hEuMVnaVA9mKlHnn0TcEihT2XMyNbQ
         Q2P8BrZluTW025qk+7nWymklQ211XEUUpM63pAfirl4s/siErWxNXD4PDEezrj5GGIrA
         YtWU0wH9ZpjB3vYNjGV/4oIHob3NI1fnci0GmNMzRrKrGt8tsUUY/r62Bz9p71rode57
         7gfRVQvzH0cm9slgElfMyqVUY1iO7EFr/lyGQ7mCg79Bi/j/ND+h9pkXD3I8sy6r3l9O
         W89QAmM+hO9mpTMNhbyeDU+S+WyijFbvVKMons9hjYGg44VScALCJF1CY7YDxwybDWqj
         hdpQ==
X-Gm-Message-State: AAQBX9fm7f8LjkIYouH67p15xllmIlJTFXEtkbyc/WGOzbavEtedDw5g
        0WBWsdGxelQxGnFYmiV3hPX45q8gCPAQH9/o
X-Google-Smtp-Source: AKy350b7d1voH7EtRs1ONStMh4OKdvLtCPGQTWf4baPARfK0Q3NV2cdQP6SuB3MG9+yj/YATtqm7vA==
X-Received: by 2002:aa7:95a4:0:b0:635:e6fa:88b5 with SMTP id a4-20020aa795a4000000b00635e6fa88b5mr4330445pfk.33.1681127982274;
        Mon, 10 Apr 2023 04:59:42 -0700 (PDT)
Received: from localhost.localdomain ([103.133.200.235])
        by smtp.gmail.com with ESMTPSA id j17-20020aa783d1000000b00639a1f7b54fsm1107438pfn.60.2023.04.10.04.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 04:59:41 -0700 (PDT)
From:   Mubashshir <ahmubashshir@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Huseyin BIYIK <huseyinbiyik@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v2] staging: HID: Add ShanWan USB WirelessGamepad driver
Date:   Mon, 10 Apr 2023 17:59:30 +0600
Message-Id: <f2e84ed47b84847c7e555c871d9851c6d70d6964.1681127968.git.ahmubashshir@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <39b44678dc54b519fa469b69d80757b36ab3cf25.1681118245.git.ahmubashshir@gmail.com>
References: <39b44678dc54b519fa469b69d80757b36ab3cf25.1681118245.git.ahmubashshir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device has a quirky initialization process.
Depending on how it was initialized, behaves completely differently.
In default mode, it behaves as expected, but in fallback it disables
force-feedback, analog stick configurations and L3/R3.

Signed-off-by: Huseyin BIYIK <huseyinbiyik@hotmail.com>
Signed-off-by: Mubashshir <ahmubashshir@gmail.com>
---
 drivers/hid/Kconfig       |  19 +++
 drivers/hid/Makefile      |   1 +
 drivers/hid/hid-ids.h     |   3 +
 drivers/hid/hid-shanwan.c | 256 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 279 insertions(+)
 create mode 100644 drivers/hid/hid-shanwan.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 82f64fb31fda..a17db9c9694c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -990,6 +990,25 @@ config HID_SEMITEK
 	- Woo-dy
 	- X-Bows Nature/Knight
 
+config HID_SHANWAN
+	tristate "ShanWan USB WirelessGamepad"
+	depends on USB_HID
+	help
+	Support for Shanwan USB WirelessGamepad (and clones).
+
+	This device has a quirky initialization process.
+	Depending on how it was initialized, it behaves completely differently.
+	In default mode, it behaves as expected, but in fallback it disables
+	force-feedback, analog stick configurations and L3/R3.
+
+config SHANWAN_FF
+	bool "ShanWan USB WirelessGamepad force feedback support"
+	depends on HID_SHANWAN
+	select INPUT_FF_MEMLESS
+	help
+	Say Y here if you have a ShanWan USB WirelessGamepad and want to enable
+	force feedback support for it.
+
 config HID_SIGMAMICRO
 	tristate "SiGma Micro-based keyboards"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 5d37cacbde33..52878455fc10 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -116,6 +116,7 @@ obj-$(CONFIG_HID_RMI)		+= hid-rmi.o
 obj-$(CONFIG_HID_SAITEK)	+= hid-saitek.o
 obj-$(CONFIG_HID_SAMSUNG)	+= hid-samsung.o
 obj-$(CONFIG_HID_SEMITEK)	+= hid-semitek.o
+obj-$(CONFIG_HID_SHANWAN)	+= hid-shanwan.o
 obj-$(CONFIG_HID_SIGMAMICRO)	+= hid-sigmamicro.o
 obj-$(CONFIG_HID_SMARTJOYPLUS)	+= hid-sjoy.o
 obj-$(CONFIG_HID_SONY)		+= hid-sony.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 63545cd307e5..278914e37eb7 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -623,6 +623,9 @@
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0641	0x0641
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_1f4a	0x1f4a
 
+#define USB_VENDOR_ID_SHANWAN 0x2563
+#define USB_PRODUCT_ID_SHANWAN_USB_WIRELESSGAMEPAD 0x0575
+
 #define USB_VENDOR_ID_HUION		0x256c
 #define USB_DEVICE_ID_HUION_TABLET	0x006e
 #define USB_DEVICE_ID_HUION_TABLET2	0x006d
diff --git a/drivers/hid/hid-shanwan.c b/drivers/hid/hid-shanwan.c
new file mode 100644
index 000000000000..dfe9ec26b31c
--- /dev/null
+++ b/drivers/hid/hid-shanwan.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Force feedback support for Shanwan USB WirelessGamepad
+ *
+ * Copyright (c) 2022-2023	Huseyin BIYIK	<huseyinbiyik@hotmail.com>
+ * Copyright (c) 2023	Ahmad Hasan Mubashshir	<ahmubashshir@gmail.com>
+ *
+ * mapping according to Gamepad Protocol
+ *
+ * Button 01: BTN_SOUTH (CROSS)
+ * Button 02: BTN_EAST(CIRCLE)
+ * Button 03: BTN_NORTH (TRIANGLE)
+ * Button 04: BTN_WEST (SQUARE)
+ * Button 05: BTL_TL (L1)
+ * Button 06: BTM_TR (R1)
+ * Button 07: BTN_TL2 (L2)
+ * Button 08: BTN_TR2 (R2)
+ * Button 09: BTN_SELECT
+ * Button 10: BTN_START
+ * Button 11: BTN_MODE
+ * Button 12: BTN_THUMBL (LS1)
+ * Button 13: BTN_THUMBR (LS1)
+ * LS1: X/Y AXIS
+ * LS2: Rx/Ry AXIS
+ * R2/L2 Touch Sensors: R/Rz
+ */
+
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/moduleparam.h>
+
+#include "hid-ids.h"
+
+#define PID0575_RDESC_ORIG_SIZE 137
+
+static bool swap_motors;
+module_param_named(swap, swap_motors, bool, 0);
+MODULE_PARM_DESC(swap, "Swap Weak/Strong Feedback motors");
+
+static __u8 pid0575_rdesc_fixed[] = {
+	0x05, 0x01, // Usage Page (Generic Desktop Ctrls)
+	0x09, 0x05, // Usage (Game Pad)
+	0xA1, 0x01, // Collection (Application)
+	0x15, 0x00, // Logical Minimum (0)
+	0x25, 0x01, // Logical Maximum (1)
+	0x35, 0x00, // Physical Minimum (0)
+	0x45, 0x01, // Physical Maximum (1)
+	0x75, 0x01, // Report Size (1)
+	0x95, 0x0D, // Report Count (13)
+	0x05, 0x09, // Usage Page (Button)
+	0x09, 0x03, // Usage (BTN_NORTH)
+	0x09, 0x02, // Usage (BTN_EAST)
+	0x09, 0x01, // Usage (BTN_SOUTH)
+	0x09, 0x04, // Usage (BTN_WEST)
+	0x09, 0x05, // Usage (BTN_TL)
+	0x09, 0x06, // Usage (BTN_TR)
+	0x09, 0x07, // Usage (BTN_TL2)
+	0x09, 0x08, // Usage (BTN_TR2)
+	0x09, 0x09, // Usage (BTN_SELECT)
+	0x09, 0x10, // Usage (BTN_START)
+	0x09, 0x12, // Usage (BTN_THUMBL)
+	0x09, 0x13, // Usage (BTN_THUMBR)
+	0x09, 0x11, // Usage (BTN_MODE)
+	0x81, 0x02, // Input (Data,Var,Abs,No Wrap,Linear,PreferredState,NoNullPosition)
+	0x75, 0x01, // Report Size (1)
+	0x95, 0x03, // Report Count (3)
+	0x81, 0x01, // Input (Const,Array,Abs,No Wrap,Linear,PreferredState,NoNullPosition)
+	0x05, 0x01, // Usage Page (Generic Desktop Ctrls)
+	0x25, 0x07, // Logical Maximum (7)
+	0x46, 0x3B, 0x01, // Physical Maximum (315)
+	0x75, 0x04, // Report Size (4)
+	0x95, 0x01, // Report Count (1)
+	0x65, 0x14, // Unit (System: English Rotation, Length: Centimeter)
+	0x09, 0x39, // Usage (Hat switch)
+	0x81, 0x42, // Input (Data,Var,Abs,No Wrap,Linear,PreferredState,NullState)
+	0x65, 0x00, // Unit (None)
+	0x95, 0x01, // Report Count (1)
+	0x81, 0x01, // Input(Const,Array,Abs,NoWrap,Linear,PreferredState,NoNullPosition)
+	0x26, 0xFF, 0x00, // Logical Maximum (255)
+	0x46, 0xFF, 0x00, // Physical Maximum (255)
+	0x09, 0x30, // Usage (X)
+	0x09, 0x31, // Usage (Y)
+	0x09, 0x33, // Usage (Rx)
+	0x09, 0x34, // Usage (Ry)
+	0x75, 0x08, // Report Size (8)
+	0x95, 0x04, // Report Count (4)
+	0x81, 0x02, // Input (Data,Var,Abs,No Wrap,Linear,PreferredState,NoNullPosition)
+	0x95, 0x0A, // Report Count (10)
+	0x81, 0x01, // Input (Const,Array,Abs,No Wrap,Linear,PreferredState,NoNullPosition)
+	0x05, 0x01, // Usage Page (Generic Desktop Ctrls)
+	0x26, 0xFF, 0x00, // Logical Maximum (255)
+	0x46, 0xFF, 0x00, // Physical Maximum (255)
+	0x09, 0x32, // Usage (Z)
+	0x09, 0x35, // Usage (Rz)
+	0x95, 0x02, // Report Count (2)
+	0x81, 0x02, // Input(Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
+	0x95, 0x08, // Report Count (8)
+	0x81, 0x01, // Input(Const,Array,Abs,NoWrap,Linear,PreferredState,NoNullPosition)
+	0x06, 0x00, 0xFF, // Usage Page (Vendor Defined 0xFF00)
+	0xB1, 0x02, // Feature(Data,Var,Abs,No Wrap,Linear,PreferredState,NoNullPosition,!volatile)
+	0x0A, 0x21, 0x26, // Usage (0x2621)
+	0x95, 0x08, // Report Count (8)
+	0x91, 0x02, // Output(Data,Var,Abs,No Wrap,Linear,PreferredState,NoNullPosition,!volatile)
+	0x0A, 0x21, 0x26, // Usage (0x2621)
+	0x95, 0x08, // Report Count (8)
+	0x81, 0x02, // Input(Data,Var,Abs,No Wrap,Linear,Preferred State,NoNullPosition)
+	0xC0,       // End Collection
+};
+
+struct shanwan_device {
+	struct hid_report *report;
+};
+
+#ifdef CONFIG_SHANWAN_FF
+static int shanwan_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct shanwan_device *shanwan = data;
+	struct hid_report *report = shanwan->report;
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	report->field[0]->value[0] = 0x02; /* 2 = rumble effect message */
+	report->field[0]->value[1] = 0x08; /* reserved value, always 8 */
+	if (swap_motors) {
+		/* weak rumble / strong rumble */
+		report->field[0]->value[2] = effect->u.rumble.strong_magnitude / 256;
+		report->field[0]->value[3] = effect->u.rumble.weak_magnitude / 256;
+	} else {
+		/* strong rumble / weak rumble */
+		report->field[0]->value[2] = effect->u.rumble.weak_magnitude / 256;
+		report->field[0]->value[3] = effect->u.rumble.strong_magnitude / 256;
+	}
+	report->field[0]->value[4] = 0xff; /* duration 0-254 (255 = nonstop) */
+	report->field[0]->value[5] = 0x00; /* padding */
+	report->field[0]->value[6] = 0x00; /* padding */
+	report->field[0]->value[7] = 0x00; /* padding */
+	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+
+	return 0;
+}
+
+static int shanwan_init_ff(struct hid_device *hid)
+{
+	struct shanwan_device *shanwan;
+	struct hid_report *report;
+	struct hid_input *hidinput;
+	struct list_head *report_list = &hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct input_dev *dev;
+
+	if (list_empty(&hid->inputs)) {
+		hid_err(hid, "no inputs found\n");
+		return -ENODEV;
+	}
+	hidinput = list_first_entry(&hid->inputs, struct hid_input, list);
+	dev = hidinput->input;
+
+	if (list_empty(report_list)) {
+		hid_err(hid, "no output reports found\n");
+		return -ENODEV;
+	}
+
+	report = list_first_entry(report_list, struct hid_report, list);
+
+	shanwan = kzalloc(sizeof(*shanwan), GFP_KERNEL);
+	if (!shanwan)
+		return -ENOMEM;
+
+	set_bit(FF_RUMBLE, dev->ffbit);
+
+	if (input_ff_create_memless(dev, shanwan, shanwan_play_effect)) {
+		kfree(shanwan);
+		return -ENODEV;
+	}
+
+	shanwan->report = report;
+
+	return 0;
+}
+#else
+static int shanwan_init_ff(struct hid_device *hid)
+{
+	return 0
+}
+#endif
+
+static int shanwan_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int error;
+
+	error = hid_parse(hdev);
+	if (error) {
+		hid_err(hdev, "parse failed\n");
+		return error;
+	}
+
+	error = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
+	if (error) {
+		hid_err(hdev, "hw start failed\n");
+		return error;
+	}
+
+	error = shanwan_init_ff(hdev);
+	if (error)
+		hid_warn(hdev, "Failed to enable force feedback support, error: %d\n", error);
+
+	error = hid_hw_open(hdev);
+	if (error) {
+		dev_err(&hdev->dev, "hw open failed\n");
+		hid_hw_stop(hdev);
+		return error;
+	}
+
+	return 0;
+}
+
+static void shanwan_remove(struct hid_device *hdev)
+{
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static __u8 *shanwan_report_fixup(struct hid_device *hid, __u8 *rdesc, unsigned int *rsize)
+{
+	if (*rsize == PID0575_RDESC_ORIG_SIZE) {
+		rdesc = pid0575_rdesc_fixed;
+		*rsize = sizeof(pid0575_rdesc_fixed);
+	} else {
+		hid_warn(hid, "unexpected rdesc, please submit for review\n");
+	}
+	return rdesc;
+}
+
+static const struct hid_device_id shanwan_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SHANWAN, USB_PRODUCT_ID_SHANWAN_USB_WIRELESSGAMEPAD) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, shanwan_devices);
+
+static struct hid_driver shanwan_driver = {
+	.name			= "shanwan",
+	.id_table		= shanwan_devices,
+	.probe			= shanwan_probe,
+	.report_fixup		= shanwan_report_fixup,
+	.remove			= shanwan_remove,
+};
+module_hid_driver(shanwan_driver);
+
+MODULE_AUTHOR("Huseyin BIYIK <huseyinbiyik@hotmail.com>");
+MODULE_AUTHOR("Ahmad Hasan Mubashshir <ahmubashshir@gmail.com>");
+MODULE_DESCRIPTION("Force feedback support for Shanwan USB WirelessGamepad");
+MODULE_LICENSE("GPL");
-- 
2.40.0

