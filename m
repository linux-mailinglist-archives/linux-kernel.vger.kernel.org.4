Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D60702F28
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbjEOOCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbjEOOCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:02:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8051BCC;
        Mon, 15 May 2023 07:01:54 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52c759b7d45so11783741a12.3;
        Mon, 15 May 2023 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684159293; x=1686751293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRoP5jqWCAmzc8rrXSIbsnSWE9zHZOIDm3FBRH44e6w=;
        b=ZQP6vE+hbTxer4jaN+LsDydMZJljPw2h2se0UxdcQjRWqtvaP+XqGe0xpe8wRnl9iO
         JubtBnEWNYA8OVFpdAhgPez1EQv9Ru58utaAE/TWDKsmCzHTUK4uclMNHUfGNJp3OajH
         VICUCI7EFKcOTN0JpfxFzP9tgiivWsofnDVJsqxKRQh94B4kFDFSsZipA45+6Cavs7c5
         lIsf59Bq9+WwOzorYWRvs0Pxvff4IN9wevK/2ODx3NelFItZNyQ4NfNajm/GYg8n+lhF
         B3sz3W+znF8PWfxcwnkL/b9cyu41sHAnkUTCshDsvYAu6XEt69rlB8M9Rb/re8VsezUs
         ssYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684159293; x=1686751293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRoP5jqWCAmzc8rrXSIbsnSWE9zHZOIDm3FBRH44e6w=;
        b=VjILtQYJ35YBRkRZaGj2xlnynJY2hWodgRl3KJ5H34M1Usq+YGT8s5zSRgUEpDUnbh
         jc6o4/HZ7WBT7GXyOtMs75V0yxPoXpNXvf0IaCiumSlOzXSkZPGkdJE4vkppA2GtAMcj
         MGW7PTTGxxv00Wha5Bc2cPN+p1N1auEmR+TnUQLMsk5PgvYPz6GPK6hrgh2HCpGHkXIN
         2ISBLOoYErEvUwLFi5XV/lZwL/thIJ4GuXteOvCBKf3z/pN6uZQP35sT5FQO9UsJdyRY
         e13bxdOQEdjWOHCF0ZWZWfMe7mmDdiS2b/YychdbpVWrA3S/8kBlFcVPFKy7Jsv9ErGK
         dQSg==
X-Gm-Message-State: AC+VfDybUWQZry3S3TB4MXk6Imt0ZZE4RLCcXjrcWg63YSWBdPqI9TQq
        puzQuVaFA1qX2rpRY5X9Y2s=
X-Google-Smtp-Source: ACHHUZ57WwbmwA3T0tT0zJT+1UICvdFrCcL//NUBElSjAV0S/whbsEqDHbZ6xe8MohJTk3oyKNaDrA==
X-Received: by 2002:a17:902:a604:b0:1ac:b363:83b3 with SMTP id u4-20020a170902a60400b001acb36383b3mr18322825plq.41.1684159291950;
        Mon, 15 May 2023 07:01:31 -0700 (PDT)
Received: from localhost.localdomain ([103.133.201.162])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903120800b001a674fb0dd8sm13520949plh.247.2023.05.15.07.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 07:01:31 -0700 (PDT)
From:   Mubashshir <ahmubashshir@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     huseyinbiyik@hotmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] staging: HID: Add ShanWan USB WirelessGamepad driver
Date:   Mon, 15 May 2023 20:01:22 +0600
Message-Id: <c213f2100e8f99b422b3014f1d5419d06cc61d00.1684159036.git.ahmubashshir@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <39b44678dc54b519fa469b69d80757b36ab3cf25.1681118245.git.ahmubashshir@gmail.com>
References: <39b44678dc54b519fa469b69d80757b36ab3cf25.1681118245.git.ahmubashshir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device has a quirky initialization process.
Depending on how it was initialized, behaves completely differently.
In default mode, it behaves as expected, but in fallback it disables
force-feedback, analog stick configurations and L3/R3.

Different OEMs manufactures joypads with same vid:pid but different
axis/button mapping[1], and I don't know which one has which layout,
so, we'll let hid-core figure that out, and handle only FF here.

 * The one I have has different axis layout than the one of Huseyin.

Signed-off-by: Huseyin BIYIK <huseyinbiyik@hotmail.com>
Signed-off-by: Mubashshir <ahmubashshir@gmail.com>
---
v5: Use hid_{get,set}_drvdata to pass data to `->play()`

 drivers/hid/Kconfig       |  19 +++++
 drivers/hid/Makefile      |   1 +
 drivers/hid/hid-ids.h     |   3 +
 drivers/hid/hid-shanwan.c | 145 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 drivers/hid/hid-shanwan.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4ce012f83253..e6c8aa855252 100644
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
index d79e946acdcb..04c3324dc453 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -627,6 +627,9 @@
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
index 000000000000..c80bfcac5dc7
--- /dev/null
+++ b/drivers/hid/hid-shanwan.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Force feedback support for Shanwan USB WirelessGamepad
+ *
+ * Copyright (c) 2022-2023	Huseyin BIYIK	<huseyinbiyik@hotmail.com>
+ * Copyright (c) 2023	Ahmad Hasan Mubashshir	<ahmubashshir@gmail.com>
+ *
+ */
+
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/string.h>
+
+#include "hid-ids.h"
+
+static bool swap_motors;
+module_param_named(swap, swap_motors, bool, 0);
+MODULE_PARM_DESC(swap, "Swap Weak/Strong Feedback motors");
+
+#ifdef CONFIG_SHANWAN_FF
+static int shanwan_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
+{
+	struct hid_device *hid    = input_get_drvdata(dev);
+	struct hid_report *report = hid_get_drvdata(hid);
+	struct hid_field  *field0 = report->field[0];
+	s32 payload_template[] = {
+		0x02,  // 2 = rumble effect message
+		0x08, // reserved value, always 8
+		0x00, // rumble value
+		0x00, // rumble value
+		0xff  // duration 0-254 (255 = nonstop)
+	};
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	memcpy_and_pad(field0->value,
+		       (sizeof(s32) * 8),
+		       payload_template,
+		       (sizeof(s32) * 4),
+		       0x00);
+
+	if (swap_motors) {
+		/* weak rumble / strong rumble */
+		field0->value[2] = effect->u.rumble.strong_magnitude / 256;
+		field0->value[3] = effect->u.rumble.weak_magnitude / 256;
+	} else {
+		/* strong rumble / weak rumble */
+		field0->value[2] = effect->u.rumble.weak_magnitude / 256;
+		field0->value[3] = effect->u.rumble.strong_magnitude / 256;
+	}
+
+	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+
+	return 0;
+}
+
+static int shanwan_init_ff(struct hid_device *hid)
+{
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
+	hid_set_drvdata(hid, report);
+
+	set_bit(FF_RUMBLE, dev->ffbit);
+	if (input_ff_create_memless(dev, NULL, shanwan_play_effect))
+		return -ENODEV;
+
+	return 0;
+}
+#else
+static int shanwan_init_ff(struct hid_device *hid)
+{
+	return 0;
+}
+#endif
+
+static int shanwan_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		return ret;
+	}
+
+	ret = shanwan_init_ff(hdev);
+	if (ret)
+		hid_warn(hdev, "Failed to enable force feedback support, error: %d\n", ret);
+
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		dev_err(&hdev->dev, "hw open failed\n");
+		hid_hw_stop(hdev);
+		return ret;
+	}
+
+	hid_hw_close(hdev);
+	return ret;
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
+};
+module_hid_driver(shanwan_driver);
+
+MODULE_AUTHOR("Huseyin BIYIK <huseyinbiyik@hotmail.com>");
+MODULE_AUTHOR("Ahmad Hasan Mubashshir <ahmubashshir@gmail.com>");
+MODULE_DESCRIPTION("Force feedback support for Shanwan USB WirelessGamepad");
+MODULE_LICENSE("GPL");
+
+// vim: ts=8:noet
-- 
2.40.1

