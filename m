Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A93702CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241922AbjEOMnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241968AbjEOMm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:42:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB621728;
        Mon, 15 May 2023 05:42:21 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52c6f81193cso8819844a12.1;
        Mon, 15 May 2023 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684154540; x=1686746540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNroAYIEhODiU4IfDbUB37ARzGbdIXG+BxlHBAZIBfc=;
        b=p9Req20Oju1+wrF5sgk8oeXamSKcNQzeC95z7JxbOVuf2hB86ZBRTJxJN/R1nqKM6w
         WiyPBCOeWgWeBfzFsZ93G57ZCDyaQb7SD9tm/Y5CwMTjMGX9ev832nTUBx2WNoPB3W//
         80ueLGkwle5vP9wf/Jo/aiUBOrTseUcOIL9kS78grxvYSk7UWiyVVYo8vHjDdPvVjMy0
         UQ84DMVhzcnHep+plhds/CHPSz1SsHQogQ51zOeafCCmFRCWr8PNlAQA7YcSi5j41+pW
         7twRWL7EUJ6kEVUNaRr8+bzmNf+a4P6e62dK3UaT1NDtmir9/7pMU0xcb9w4kMkO+fhp
         hjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684154540; x=1686746540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNroAYIEhODiU4IfDbUB37ARzGbdIXG+BxlHBAZIBfc=;
        b=aYJJwGUi5wfYjyxHhColJOeZbHP6n4wEcLQWtyotSBetRZ3YaHb5eNBwPHAEDx7USv
         4fWbNmoR8h4Pkq7NsEw5ZGcLcfxEmutvqSOwvS7W8jeAYp0y+0knmthdDxoJF6O+eYnO
         VODQ0jPoF9j4IT9Xu1TkFDYmbM8hCSvhE/XM33tMpAMWrPUGzlNgVq3ouQ16hVhcQq/y
         mU4jz8hJy2kHOgZjCbx2oBMzNLeJN0M9RP0Ro9IzO2425/c9FanUk5wFI1AwawhNOKMn
         ooWvq4RxjvzFyL1tf6p/usgUA6h2yvjSm+73hBqYhZrsDA//1LtIGJXnV0CQO45+W2+P
         YTeA==
X-Gm-Message-State: AC+VfDxOyHegykc2JOzPDv1n+H+VUCZntQbAdfKL12d6KTOIxN0ifr2h
        yYJk2Mul/xq4URqcpwCyNYS2PEXk8zY=
X-Google-Smtp-Source: ACHHUZ4L25yL3ciJ2BIwjrIES5PVQrq9jWHF5orAxcmgyJmrHkLJlogYiTirZVAzkELk6+t4XYg6SQ==
X-Received: by 2002:a05:6a20:4321:b0:105:b75e:9df6 with SMTP id h33-20020a056a20432100b00105b75e9df6mr5624277pzk.26.1684154540089;
        Mon, 15 May 2023 05:42:20 -0700 (PDT)
Received: from localhost.localdomain ([103.133.201.162])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090a7c0500b0024e4f169931sm21438661pjf.2.2023.05.15.05.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:42:19 -0700 (PDT)
From:   Mubashshir <ahmubashshir@gmail.com>
To:     ahmubashshir@gmail.com, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     huseyinbiyik@hotmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: HID: Add ShanWan USB WirelessGamepad driver
Date:   Mon, 15 May 2023 18:42:10 +0600
Message-Id: <0ad28f3f557342eb485272b57f0e0be71812db38.1684154472.git.ahmubashshir@gmail.com>
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
 drivers/hid/Kconfig       |  19 +++++
 drivers/hid/Makefile      |   1 +
 drivers/hid/hid-ids.h     |   3 +
 drivers/hid/hid-shanwan.c | 155 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 178 insertions(+)
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
index 000000000000..dba969d553ff
--- /dev/null
+++ b/drivers/hid/hid-shanwan.c
@@ -0,0 +1,155 @@
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
+#define SHANWAN_PAYLOAD_LEN(x) (sizeof(s32) * x)
+
+static bool swap_motors;
+module_param_named(swap, swap_motors, bool, 0);
+MODULE_PARM_DESC(swap, "Swap Weak/Strong Feedback motors");
+
+#ifdef CONFIG_SHANWAN_FF
+struct shanwan_device {
+	struct hid_report *report;
+};
+
+static int shanwan_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct shanwan_device *shanwan = data;
+	struct hid_report *report = shanwan->report;
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
+	memcpy_and_pad(field0->value, SHANWAN_PAYLOAD_LEN(8), payload_template, SHANWAN_PAYLOAD_LEN(4), 0x00);
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
-- 
2.40.1

