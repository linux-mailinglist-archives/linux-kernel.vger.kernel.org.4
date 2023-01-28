Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EFD67F457
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 04:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjA1Dg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 22:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1DgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 22:36:24 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1717E699;
        Fri, 27 Jan 2023 19:36:22 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso4784529wmq.5;
        Fri, 27 Jan 2023 19:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q5K4HXiAI9WMBlWj6fUm1a3om0emz0NBz8cWVPc3cRU=;
        b=P1KjKsIK1K1STfus6HblxCdlDsLUa9wL9AtzhhxAd19pXIVoJD0adgKdUPUryQURR2
         rI1E2cT5g97WWY6AphKheGah2INvWVA9IcsAdBPqq51hfsPUQeKvam9TnHHZrOv+dGYM
         2cZIN4Spn+T5oxk1ulVXnuBQB0jBKXkpWETo4baU8Kwa70JYcm9e32kMwrmM8GQT+13I
         0n/GTedNbagI4T7nGry/t3pDxRnB773vG3dAUHDdIfvd3tWBmvKgkIbygjl5rI/pRCuZ
         nMnzCmEIFcDGrFeD3OAUs8Qg3/lq3kcqtJtd3sh9nu8Zi2iqPZzq7CjFH6eQ/+dgO2At
         Wm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5K4HXiAI9WMBlWj6fUm1a3om0emz0NBz8cWVPc3cRU=;
        b=d+HPzwaXrzYUO0NkP5eEljOQWW09bPy56xmBZj9d/KrYcLp9sBWgcbs2w64u8/iaTN
         jFM3yHQPwKb0N+PSk0oM357AVl/4DRBAmpNnFwSgTmuvucjxgopFUGNLA4APk5Od4rXV
         4B0BUFo4y3NBT1CL9zEec+VtxLIOr7HiebOVtG1h1ABhlId7P5P4GX2Sfh+9A2dF/XeW
         eK2+9jmEFU97TNFaxqi/bCUQJMy6mck2KhxoWUg3Js/r3psJ0JgloJxlgRVVAaUlSdK6
         4dAsyH54rfqWRsF2hUn8RXx2fwbe/xbcH/1prYTbIYixfsnmjn8o4cwicx57pVsH18wo
         cvPA==
X-Gm-Message-State: AFqh2kqaxkY+nobSVrEGNKos3x6FKmQNM/RC7HDXoUxLNkb9Dl8TQTwt
        bu+cG8ONzBMiQERDhFOQ2BE=
X-Google-Smtp-Source: AMrXdXtxwZ0VY3zU3ARpeczt2cftyfRWjU3uHu9nrbOgsJOwXg4VlvXmJTvKemlIrHYoONnvycmtHA==
X-Received: by 2002:a05:600c:1c1f:b0:3db:2d7e:1204 with SMTP id j31-20020a05600c1c1f00b003db2d7e1204mr32308648wms.27.1674876981192;
        Fri, 27 Jan 2023 19:36:21 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id v2-20020a05600c214200b003dc4a47605fsm341316wml.8.2023.01.27.19.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 19:36:20 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Emanuel Strobel <emanuel.strobel@yahoo.com>
Subject: [PATCH] media: rc: add common keymap for Dreambox RC10 and RC20/RC-BT remotes
Date:   Sat, 28 Jan 2023 03:36:16 +0000
Message-Id: <20230128033616.3982911-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add a common keymap and bindings for the RC10 and RC20/RC-BT remotes
used with the Dreambox One and Dreambox Two DVB-S/T boxes. The maps
are combined since the IR codes do not conflict and both boxes have
shipped with both remote designs.

Signed-off-by: Emanuel Strobel <emanuel.strobel@yahoo.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../devicetree/bindings/media/rc.yaml         |   1 +
 drivers/media/rc/keymaps/Makefile             |   1 +
 drivers/media/rc/keymaps/rc-dreambox.c        | 147 ++++++++++++++++++
 include/media/rc-map.h                        |   1 +
 4 files changed, 150 insertions(+)
 create mode 100644 drivers/media/rc/keymaps/rc-dreambox.c

diff --git a/Documentation/devicetree/bindings/media/rc.yaml b/Documentation/devicetree/bindings/media/rc.yaml
index d4ef523cb3d5..f390a5d2c82d 100644
--- a/Documentation/devicetree/bindings/media/rc.yaml
+++ b/Documentation/devicetree/bindings/media/rc.yaml
@@ -56,6 +56,7 @@ properties:
       - rc-dm1105-nec
       - rc-dntv-live-dvb-t
       - rc-dntv-live-dvbt-pro
+      - rc-dreambox
       - rc-dtt200u
       - rc-dvbsky
       - rc-dvico-mce
diff --git a/drivers/media/rc/keymaps/Makefile b/drivers/media/rc/keymaps/Makefile
index 77d8b5a69815..03bc9a8d355e 100644
--- a/drivers/media/rc/keymaps/Makefile
+++ b/drivers/media/rc/keymaps/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_RC_MAP) += \
 			rc-dm1105-nec.o \
 			rc-dntv-live-dvb-t.o \
 			rc-dntv-live-dvbt-pro.o \
+			rc-dreambox.o \
 			rc-dtt200u.o \
 			rc-dvbsky.o \
 			rc-dvico-mce.o \
diff --git a/drivers/media/rc/keymaps/rc-dreambox.c b/drivers/media/rc/keymaps/rc-dreambox.c
new file mode 100644
index 000000000000..0ccbed367ea3
--- /dev/null
+++ b/drivers/media/rc/keymaps/rc-dreambox.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2021 Emanuel Strobel <emanuel.strobel@yahoo.com>
+
+#include <media/rc-map.h>
+#include <linux/module.h>
+
+//
+// Keytable for the Dreabox RC10 and RC20/RC-BT remote controls
+//
+
+static struct rc_map_table dreambox[] = {
+
+	/* Dreambox RC10 remote */
+
+	{ 0x3401, KEY_POWER },
+
+	// DREAM
+	{ 0x3426, KEY_HELP },
+	// TV
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
+	{ 0x3407, KEY_MUTE },
+
+	{ 0x3417, KEY_PAGEUP },
+	{ 0x341a, KEY_PAGEDOWN },
+
+	{ 0x3432, KEY_PREVIOUSSONG },
+	{ 0x3433, KEY_PLAYPAUSE },
+	{ 0x3434, KEY_STOP },
+	{ 0x3435, KEY_NEXTSONG },
+
+	// TV
+	// RADIO
+	{ 0x3425, KEY_TEXT },
+	{ 0x3436, KEY_RECORD },
+
+	/* Dreambox RC20/RC-BT */
+
+	{ 0x321a, KEY_MUTE },
+	// MODE
+	{ 0x3200, KEY_POWER },
+
+	{ 0x3223, KEY_PREVIOUSSONG },
+	{ 0x3224, KEY_PLAYPAUSE },
+	{ 0x3226, KEY_NEXTSONG },
+
+	{ 0x322a, KEY_RECORD },
+	{ 0x3225, KEY_STOP },
+	{ 0x3229, KEY_TEXT },
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
+	{ 0x3290, KEY_HELP },
+
+	{ 0x321b, KEY_PAGEUP },
+	{ 0x321e, KEY_PAGEDOWN },
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
index 43d254930daa..dadd4d27a760 100644
--- a/include/media/rc-map.h
+++ b/include/media/rc-map.h
@@ -242,6 +242,7 @@ struct rc_map *rc_map_get(const char *name);
 #define RC_MAP_DM1105_NEC                "rc-dm1105-nec"
 #define RC_MAP_DNTV_LIVE_DVB_T           "rc-dntv-live-dvb-t"
 #define RC_MAP_DNTV_LIVE_DVBT_PRO        "rc-dntv-live-dvbt-pro"
+#define RC_MAP_DREAMBOX                  "rc-dreambox"
 #define RC_MAP_DTT200U                   "rc-dtt200u"
 #define RC_MAP_DVBSKY                    "rc-dvbsky"
 #define RC_MAP_DVICO_MCE		 "rc-dvico-mce"
-- 
2.34.1

