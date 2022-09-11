Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9741E5B4B01
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 02:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiIKAlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 20:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiIKAlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 20:41:37 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B5E40E02;
        Sat, 10 Sep 2022 17:41:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 546C05C0094;
        Sat, 10 Sep 2022 20:41:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 10 Sep 2022 20:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harrystern.net;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662856893; x=1662943293; bh=M90mpLmhh8
        9IpWYmWfG4M1STa7CV73N3cCiudARxij0=; b=OD8xCwHhD6z9YV4jo1RRFmD/R6
        Kj18FjQmP7jLSMcXCo6+UrzSoJGi+oNXhxzXaQiDjLpKhG1YcpPKkslgPL1GJw5S
        Z+q1iGb2pZgoKuAPMYhZmKYGCCsAT1vtKVD92ooYL8qx43LiNOobs37tNA3hNRTs
        1TUcdC80h748b3Gobtlhrbgeo9/V4caXqfWcZTuKVzoV50dSIjrMH/9nJkZNJ2Ou
        OouECl8mSfVRObeUOEEmyEWypp0lKLL2T+Juk3LJMe+vbEfmuRCLjKb/eZbvzN1J
        ld0BGHz8/PCXQgRgfjSWDmqaguTsrFYpaNukhlQo9E6z9pY+J8MR73gZdtJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1662856893; x=1662943293; bh=M90mpLmhh89IpWYmWfG4M1STa7CV73N3cCi
        udARxij0=; b=s+YoYuZ+wnTsHMrHWrZmu72eZDrKbpqCrW/MHOQgWH97DO4TKIq
        iERttKEQUjEBKEKLF26zrjR/L/gQ5UuOkIIOH8Pw1XZUSjx0GBtayGr9DbRlO4xJ
        WXRr8+oujZIGQJ6ry0cMIxnwzHOaOTCKhNpiqG1x6l962/dWGkHMMQ/Mp03hSQVq
        1XssHg0t5Aa33cofe29e48eagTMSok0itTLch5b+wkJV/x4q6KsBQZNCAD+1jfK+
        xmAgDiK7OKQIHvPoeS6XVF7LNe/+2KpIxvSfW/IVbJRHSbmXzvmoOOtAzF1stWeO
        8a8YLISFaIW4IBftB7eUvqvSNyZlb+KIu+Q==
X-ME-Sender: <xms:vS4dYyD6UAEJFH8S1x_E0evdoSQ4hYtYkXbxfw9wGt7e20KsV1ZhxA>
    <xme:vS4dY8hbqe3Iy7sf5FTniU1yXLvVgHZYQkSU--obM_F8p9Wpn10UBMw6ScjWMxvVb
    qrzi94oDjsG8sbTyA>
X-ME-Received: <xmr:vS4dY1kcUl3EMw-ilSXCgYOZreNKQSR22RWTi0jdsm-i64bT2lSms81kBNb-QSXr1Sgk1an0PCRcEuYK1Yd5hvWmpCeTSRadpIcRdryQUPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnegoteeftdduqddtudculdduhedm
    necujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepjfgrrhhrhi
    cuufhtvghrnhcuoehhrghrrhihsehhrghrrhihshhtvghrnhdrnhgvtheqnecuggftrfgr
    thhtvghrnheplefgtdffteeigfduiefgteeugefgudeujeevueettdekhefhteevteegie
    etgefhnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhgrrhhrhieshhgrrhhrhi
    hsthgvrhhnrdhnvght
X-ME-Proxy: <xmx:vS4dYwx0XRZbXkjtThdSf-5Bcw_0lYUovslrHEsuNYbqoFFFw7xalw>
    <xmx:vS4dY3T1YBtFeZmhXGXyFBJMj7xWFeSGnETenipeVQ85ujZFPHoNqA>
    <xmx:vS4dY7ZWpSSJTqtTiP4EpgVdFNXnPQIlfGaV7LCth5iaExOC7jXQ5Q>
    <xmx:vS4dYxedIeJH5BEokW69YZf2lQxDwy39kEMTxkcXZwsMLe-P8eGg5Q>
Feedback-ID: if19944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Sep 2022 20:41:32 -0400 (EDT)
From:   Harry Stern <harry@harrystern.net>
Cc:     Harry Stern <harry@harrystern.net>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] hid: topre: Add driver fixing report descriptor
Date:   Sat, 10 Sep 2022 20:36:13 -0400
Message-Id: <20220911003614.297613-1-harry@harrystern.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Topre REALFORCE R2 firmware incorrectly reports that interface
descriptor number 1, input report descriptor 2's events are array events
rather than variable events. That particular report descriptor is used
to report keypresses when there are more than 6 keys held at a time.
This bug prevents events from this interface from being registered
properly, so only 6 keypresses (from a different interface) can be
registered at once, rather than full n-key rollover.

This commit fixes the bug by setting the correct value in a report_fixup
function.

The original bug report can be found here:
Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/804

Thanks to Benjamin Tissoires for diagnosing the issue with the report
descriptor.

Signed-off-by: Harry Stern <harry@harrystern.net>
---
 drivers/hid/Kconfig     |  6 +++++
 drivers/hid/Makefile    |  1 +
 drivers/hid/hid-ids.h   |  3 +++
 drivers/hid/hid-topre.c | 49 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)
 create mode 100644 drivers/hid/hid-topre.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 6ce92830b..c4308d498 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1141,6 +1141,12 @@ config HID_TOPSEED
 	Say Y if you have a TopSeed Cyberlink or BTC Emprex or Conceptronic
 	CLLRCMCE remote control.
 
+config HID_TOPRE
+	tristate "Topre REALFORCE keyboards"
+	depends on HID
+	help
+	  Say Y for N-key rollover support on Topre REALFORCE R2 108 key keyboards.
+
 config HID_THINGM
 	tristate "ThingM blink(1) USB RGB LED"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index b0bef8098..bccaec0d7 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_HID_GREENASIA)	+= hid-gaff.o
 obj-$(CONFIG_HID_THRUSTMASTER)	+= hid-tmff.o hid-thrustmaster.o
 obj-$(CONFIG_HID_TIVO)		+= hid-tivo.o
 obj-$(CONFIG_HID_TOPSEED)	+= hid-topseed.o
+obj-$(CONFIG_HID_TOPRE)	+= hid-topre.o
 obj-$(CONFIG_HID_TWINHAN)	+= hid-twinhan.o
 obj-$(CONFIG_HID_U2FZERO)	+= hid-u2fzero.o
 hid-uclogic-objs		:= hid-uclogic-core.o \
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f80d6193f..50bab12d9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1231,6 +1231,9 @@
 #define USB_DEVICE_ID_TIVO_SLIDE	0x1201
 #define USB_DEVICE_ID_TIVO_SLIDE_PRO	0x1203
 
+#define USB_VENDOR_ID_TOPRE			0x0853
+#define USB_DEVICE_ID_TOPRE_REALFORCE_R2_108			0x0148
+
 #define USB_VENDOR_ID_TOPSEED		0x0766
 #define USB_DEVICE_ID_TOPSEED_CYBERLINK	0x0204
 
diff --git a/drivers/hid/hid-topre.c b/drivers/hid/hid-topre.c
new file mode 100644
index 000000000..88a91cdad
--- /dev/null
+++ b/drivers/hid/hid-topre.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  HID driver for Topre REALFORCE Keyboards
+ *
+ *  Copyright (c) 2022 Harry Stern <harry@harrystern.net>
+ *
+ *  Based on the hid-macally driver
+ */
+
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+MODULE_AUTHOR("Harry Stern <harry@harrystern.net>");
+MODULE_DESCRIPTION("REALFORCE R2 Keyboard driver");
+MODULE_LICENSE("GPL");
+
+/*
+ * Fix the REALFORCE R2's non-boot interface's report descriptor to match the
+ * events it's actually sending. It claims to send array events but is instead
+ * sending variable events.
+ */
+static __u8 *topre_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+				 unsigned int *rsize)
+{
+	if (*rsize >= 119 && rdesc[69] == 0x29 && rdesc[70] == 0xe7 &&
+						 rdesc[71] == 0x81 && rdesc[72] == 0x00) {
+		hid_info(hdev,
+			"fixing up Topre REALFORCE keyboard report descriptor\n");
+		rdesc[72] = 0x02;
+	}
+	return rdesc;
+}
+
+static const struct hid_device_id topre_id_table[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPRE,
+			 USB_DEVICE_ID_TOPRE_REALFORCE_R2_108) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, topre_id_table);
+
+static struct hid_driver topre_driver = {
+	.name			= "topre",
+	.id_table		= topre_id_table,
+	.report_fixup		= topre_report_fixup,
+};
+
+module_hid_driver(topre_driver);
-- 
2.37.3

