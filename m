Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811BA6893E5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjBCJe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBCJeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:34:18 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E66199E7;
        Fri,  3 Feb 2023 01:34:15 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h16so4054391wrz.12;
        Fri, 03 Feb 2023 01:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSoTwx1PKMizxi9LAMpHct689dKl++Ljc1WejA3R234=;
        b=Pp9YxhI2qTs1Ndc4oqJQuEdBmEBREjpiN6XzEwREp/cqRxoBkXkKBkeSgzFJqfdEig
         pIE6i3z/KsUnj16djI+tn99hvcxNS+Y1gxSPSZXoZFVPg7TnmVQ6VNGG0UNxMyxo6Dak
         NyliJdqe8chami4pMcp8uIBx8WakiB3BGEdLVxPb1Z5HFbQPtemWUnclSHLpiwcv22O1
         KWP2OJ4F3VjTZ3pHmZCVCcbaU2kmNcWRQQK6vLpHBc2XZjg43SAfUyXh9Y/bz7IYuqCE
         gNWYJUGJdpPHfOvlwfM5hscl8WzJO228KP4npE/amS/ezlLZUcDoTdWf99FpR/qseMHn
         9eBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSoTwx1PKMizxi9LAMpHct689dKl++Ljc1WejA3R234=;
        b=vKNpmZVIIaSHy0eL5xXimCqvMHLlPPsse7ZWgxlVBZJiR1Xn8M0Bt2FjFPDReP3K3g
         mV7eSQWlevR15efMTssXyWd7UpnmS0P2AhkjyDNlXlC1ylAuSMkw3UWyQlZgdxhJ2YUP
         viHwfzgOcLCXdnKTwkrIVugV0xVGhLbzaJu1eZ0CI0V7YOCvqI1lCmEV2gvF84E48nov
         Ob4tpSYu1sGrAJSkTCLPZzmKwXjMGiR3yGEfWiFEaS8JUiMepGX0p71HyC4O+yenXywp
         1HH9/awUqPnFemvtuw9NjCH/MfTMcdm6Q0RhVApEET9bVRkkkYXrNbwLgdXgZEzd97bb
         vO8A==
X-Gm-Message-State: AO0yUKVIT/GhsirDvN7iS4B481pRktGIuIefNMdDAzNmnDAR9/EfUZs1
        OQVyrlb++fu7d6BEfhntxj8=
X-Google-Smtp-Source: AK7set81xiyjdAF1z+7pV/SU4pJcojclru0lcW6uW6JzgCsdEJA/GlgCxzvp3oadsMaW4A4y4S5PYQ==
X-Received: by 2002:adf:a28d:0:b0:2bf:c0d3:430c with SMTP id s13-20020adfa28d000000b002bfc0d3430cmr8122291wra.11.1675416854084;
        Fri, 03 Feb 2023 01:34:14 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r7-20020adff107000000b002c285b4d2b5sm1533259wro.101.2023.02.03.01.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 01:34:13 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Emanuel Strobel <emanuel.strobel@yahoo.com>
Subject: [PATCH v2 2/2] media: rc: add common keymap for Dreambox RC10/RC0 and RC20/RC-BT remotes
Date:   Fri,  3 Feb 2023 09:34:05 +0000
Message-Id: <20230203093405.1616564-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203093405.1616564-1-christianshewitt@gmail.com>
References: <20230203093405.1616564-1-christianshewitt@gmail.com>
MIME-Version: 1.0
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

From: Emanuel Strobel <emanuel.strobel@yahoo.com>

Add a common keymap for the RC10/RC0 and RC20/RC-BT remotes used with
the Dreambox One and Dreambox Two DVB-S/T boxes. The maps are combined
since the IR codes do not conflict and both boxes have shipped with
both remote designs over time.

Both remote types can be programmed to control TVs, so include non-IR
keys that are used to switch-to or toggle the remote mode:

- DREAM in RC10/RC0 switches to (Dreambox) STB control mode
- TV in RC10/RC0 switches to TV control mode
- MODE in RC20/RC-BT toggles between STB/TV/BT control modes

In the RC20 keymap the Android MIC (voice search) key maps to KEY_HELP
and EXIT is mapped to KEY_ESC to replicate the go-backwards navigation
behaviour in the Android vendor OS that ships on Dreambox devices.

Signed-off-by: Emanuel Strobel <emanuel.strobel@yahoo.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/media/rc/keymaps/Makefile      |   1 +
 drivers/media/rc/keymaps/rc-dreambox.c | 151 +++++++++++++++++++++++++
 include/media/rc-map.h                 |   1 +
 3 files changed, 153 insertions(+)
 create mode 100644 drivers/media/rc/keymaps/rc-dreambox.c

diff --git a/drivers/media/rc/keymaps/Makefile b/drivers/media/rc/keymaps/Makefile
index f513ff5caf4e..6931c89fca99 100644
--- a/drivers/media/rc/keymaps/Makefile
+++ b/drivers/media/rc/keymaps/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_RC_MAP) += \
 			rc-dm1105-nec.o \
 			rc-dntv-live-dvb-t.o \
 			rc-dntv-live-dvbt-pro.o \
+			rc-dreambox.o \
 			rc-dtt200u.o \
 			rc-dvbsky.o \
 			rc-dvico-mce.o \
diff --git a/drivers/media/rc/keymaps/rc-dreambox.c b/drivers/media/rc/keymaps/rc-dreambox.c
new file mode 100644
index 000000000000..dea024fa3a22
--- /dev/null
+++ b/drivers/media/rc/keymaps/rc-dreambox.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2021 Emanuel Strobel <emanuel.strobel@yahoo.com>
+ */
+
+#include <media/rc-map.h>
+#include <linux/module.h>
+
+/*
+ * Keytable for Dreambox RC10/RC0 and RC20/RC-BT remote controls
+ *
+ * Keys that are not IR addressable:
+ *
+ * // DREAM switches to STB control mode
+ * // TV switches to TV control mode
+ * // MODE toggles STB/TV/BT control modes
+ *
+ */
+
+static struct rc_map_table dreambox[] = {
+	/* Dreambox RC10/RC0/RCU-BT remote */
+	{ 0x3200, KEY_POWER },
+
+	// DREAM
+	{ 0x3290, KEY_HELP },
+	// TV
+
+	{ 0x3201, KEY_1 },
+	{ 0x3202, KEY_2 },
+	{ 0x3203, KEY_3 },
+	{ 0x3204, KEY_4 },
+	{ 0x3205, KEY_5 },
+	{ 0x3206, KEY_6 },
+	{ 0x3207, KEY_7 },
+	{ 0x3208, KEY_8 },
+	{ 0x3209, KEY_9 },
+	{ 0x320a, KEY_PREVIOUS },
+	{ 0x320b, KEY_0 },
+	{ 0x320c, KEY_NEXT },
+
+	{ 0x321f, KEY_RED },
+	{ 0x3220, KEY_GREEN },
+	{ 0x3221, KEY_YELLOW },
+	{ 0x3222, KEY_BLUE },
+
+	{ 0x3210, KEY_INFO },
+	{ 0x3212, KEY_MENU },
+	{ 0x320e, KEY_AUDIO },
+	{ 0x3218, KEY_PVR },
+
+	{ 0x3213, KEY_LEFT },
+	{ 0x3211, KEY_UP },
+	{ 0x3215, KEY_RIGHT },
+	{ 0x3217, KEY_DOWN },
+	{ 0x3214, KEY_OK },
+
+	{ 0x3219, KEY_VOLUMEUP },
+	{ 0x321c, KEY_VOLUMEDOWN },
+
+	{ 0x321d, KEY_ESC }, // EXIT
+	{ 0x321a, KEY_MUTE },
+
+	{ 0x321b, KEY_PAGEUP },
+	{ 0x321e, KEY_PAGEDOWN },
+
+	{ 0x3223, KEY_PREVIOUSSONG },
+	{ 0x3224, KEY_PLAYPAUSE },
+	{ 0x3225, KEY_STOP },
+	{ 0x3226, KEY_NEXTSONG },
+
+	{ 0x3227, KEY_TV },
+	{ 0x3228, KEY_RADIO },
+	{ 0x3229, KEY_TEXT },
+	{ 0x322a, KEY_RECORD },
+
+	/* Dreambox RC20/RC-BT */
+	{ 0x3407, KEY_MUTE },
+	// MODE
+	{ 0x3401, KEY_POWER },
+
+	{ 0x3432, KEY_PREVIOUSSONG },
+	{ 0x3433, KEY_PLAYPAUSE },
+	{ 0x3435, KEY_NEXTSONG },
+
+	{ 0x3436, KEY_RECORD },
+	{ 0x3434, KEY_STOP },
+	{ 0x3425, KEY_TEXT },
+
+	{ 0x341f, KEY_RED },
+	{ 0x3420, KEY_GREEN },
+	{ 0x3421, KEY_YELLOW },
+	{ 0x3422, KEY_BLUE },
+
+	{ 0x341b, KEY_INFO },
+	{ 0x341c, KEY_MENU },
+	{ 0x3430, KEY_AUDIO },
+	{ 0x3431, KEY_PVR },
+
+	{ 0x3414, KEY_LEFT },
+	{ 0x3411, KEY_UP },
+	{ 0x3416, KEY_RIGHT },
+	{ 0x3419, KEY_DOWN },
+	{ 0x3415, KEY_OK },
+
+	{ 0x3413, KEY_VOLUMEUP },
+	{ 0x3418, KEY_VOLUMEDOWN },
+
+	{ 0x3412, KEY_ESC }, // EXIT
+	{ 0x3426, KEY_HELP }, // MIC
+
+	{ 0x3417, KEY_PAGEUP },
+	{ 0x341a, KEY_PAGEDOWN },
+
+	{ 0x3404, KEY_1 },
+	{ 0x3405, KEY_2 },
+	{ 0x3406, KEY_3 },
+	{ 0x3408, KEY_4 },
+	{ 0x3409, KEY_5 },
+	{ 0x340a, KEY_6 },
+	{ 0x340c, KEY_7 },
+	{ 0x340d, KEY_8 },
+	{ 0x340e, KEY_9 },
+	{ 0x340b, KEY_PREVIOUS },
+	{ 0x3410, KEY_0 },
+	{ 0x340f, KEY_NEXT },
+};
+
+static struct rc_map_list dreambox_map = {
+	.map = {
+		.scan     = dreambox,
+		.size     = ARRAY_SIZE(dreambox),
+		.rc_proto = RC_PROTO_NEC,
+		.name     = RC_MAP_DREAMBOX,
+	}
+};
+
+static int __init init_rc_map_dreambox(void)
+{
+	return rc_map_register(&dreambox_map);
+}
+
+static void __exit exit_rc_map_dreambox(void)
+{
+	rc_map_unregister(&dreambox_map);
+}
+
+module_init(init_rc_map_dreambox)
+module_exit(exit_rc_map_dreambox)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Emanuel Strobel <emanuel.strobel@yahoo.com>");
diff --git a/include/media/rc-map.h b/include/media/rc-map.h
index 793b54342dff..94ee968d4722 100644
--- a/include/media/rc-map.h
+++ b/include/media/rc-map.h
@@ -241,6 +241,7 @@ struct rc_map *rc_map_get(const char *name);
 #define RC_MAP_DM1105_NEC                "rc-dm1105-nec"
 #define RC_MAP_DNTV_LIVE_DVB_T           "rc-dntv-live-dvb-t"
 #define RC_MAP_DNTV_LIVE_DVBT_PRO        "rc-dntv-live-dvbt-pro"
+#define RC_MAP_DREAMBOX                  "rc-dreambox"
 #define RC_MAP_DTT200U                   "rc-dtt200u"
 #define RC_MAP_DVBSKY                    "rc-dvbsky"
 #define RC_MAP_DVICO_MCE		 "rc-dvico-mce"
-- 
2.34.1

