Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045B267F461
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 04:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjA1Dl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 22:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1DlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 22:41:24 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C564A8B7AC;
        Fri, 27 Jan 2023 19:41:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m15so4717060wms.4;
        Fri, 27 Jan 2023 19:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQ+81Fws2lq/NhKgavsg4624xh5ot56CxL/cmzyR1Ik=;
        b=MvXtvmjfVc/SHBbD1rHRW+NK4dG+TFqTK7wZIK9pjgCV8jp15Va45IX4lJqf50pphK
         5s+gPC6BdB4m4nmnkHI32g7Z+61PlfOA+A9f9dl5QyrOxTcWsUBLU4V9jpohvA4nGkZy
         HNATFvbr8JQEbEhCSWtfEriXBGXYbzVsMwUXBjYvy1a/9Ou4ypS7EYPLoB6qRKkJnM31
         T2ifsPknUxZbltTAaFQOJjFAmSa35igzNU2L+Ln8vQ5UbtO7teKVN2i/11uoxuy3XNTO
         WqipjGUoT7hUgQYjd/TmCSlFPp2AioURk9mYi4xyEKeULavJFr+YBTR7Cm3Bpy5altZ+
         5N+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQ+81Fws2lq/NhKgavsg4624xh5ot56CxL/cmzyR1Ik=;
        b=M1qgsKEXsbK3uQBSv0Dnwcdldc6Cu1pA8OY4TT66UpeJ8t9iHXGb6g/8XSGGNz21SK
         aN8dPuQCDL0X0UVsOVCblDcLXo7JSVC6Zj+mJg3l2TXqSPaxQeHVI8lHIGxZNUMleao1
         xYtmt8jeJzhecUZF5jGF7AVy80mbiGtBvgxdRC1F+5sqljB8Q9h3adw+lEs+2TQsFkVT
         VK3r3yGLVA0Kx12EOGy/jbSgWKck/rUx2SkPIv/bS7W5jaoh8Qo4JXDDjBpyywFizmge
         99aNNDNaoUIp3pB2cS+B9ILn/t5hKDJfU7ZH6Fm96hIgVcbq2kJtKEvAQimYYgnpk5y6
         RfuQ==
X-Gm-Message-State: AFqh2krhsBgMhtMpBzCeAMSMSoPbqpLKji8drVRonJqOsnb4JWmR0lNt
        5T2PP5lfIRgA3B3j9eZ3tzRiAzdA93eUxA==
X-Google-Smtp-Source: AMrXdXv2vQnMLTbdyIBercQfamwgwIDJ2zbeFEPCDI+PtAq7MglcMlYKeCEJ5JgxN437oVtwhfWIzQ==
X-Received: by 2002:a05:600c:4e94:b0:3db:bc5:b2ae with SMTP id f20-20020a05600c4e9400b003db0bc5b2aemr38694812wmq.41.1674877282313;
        Fri, 27 Jan 2023 19:41:22 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b002be2f18938csm5221169wrt.41.2023.01.27.19.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 19:41:21 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] media: rc: add keymap for Beelink Mini MXIII remote
Date:   Sat, 28 Jan 2023 03:41:17 +0000
Message-Id: <20230128034117.3983105-1-christianshewitt@gmail.com>
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

Add a keymap and bindings for the simple IR (NEC) remote used with
the Beelink Mini MXIII Android STB device.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../devicetree/bindings/media/rc.yaml         |  1 +
 drivers/media/rc/keymaps/Makefile             |  1 +
 drivers/media/rc/keymaps/rc-beelink-mxiii.c   | 54 +++++++++++++++++++
 include/media/rc-map.h                        |  1 +
 4 files changed, 57 insertions(+)
 create mode 100644 drivers/media/rc/keymaps/rc-beelink-mxiii.c

diff --git a/Documentation/devicetree/bindings/media/rc.yaml b/Documentation/devicetree/bindings/media/rc.yaml
index 266f1d5cae51..f390a5d2c82d 100644
--- a/Documentation/devicetree/bindings/media/rc.yaml
+++ b/Documentation/devicetree/bindings/media/rc.yaml
@@ -39,6 +39,7 @@ properties:
       - rc-avertv-303
       - rc-azurewave-ad-tu700
       - rc-beelink-gs1
+      - rc-beelink-mxiii
       - rc-behold
       - rc-behold-columbus
       - rc-budget-ci-old
diff --git a/drivers/media/rc/keymaps/Makefile b/drivers/media/rc/keymaps/Makefile
index ec0361b0b758..03bc9a8d355e 100644
--- a/drivers/media/rc/keymaps/Makefile
+++ b/drivers/media/rc/keymaps/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_RC_MAP) += \
 			rc-avertv-303.o \
 			rc-azurewave-ad-tu700.o \
 			rc-beelink-gs1.o \
+			rc-beelink-mxiii.o \
 			rc-behold-columbus.o \
 			rc-behold.o \
 			rc-budget-ci-old.o \
diff --git a/drivers/media/rc/keymaps/rc-beelink-mxiii.c b/drivers/media/rc/keymaps/rc-beelink-mxiii.c
new file mode 100644
index 000000000000..09b77295e0a3
--- /dev/null
+++ b/drivers/media/rc/keymaps/rc-beelink-mxiii.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2019 Christian Hewitt <christianshewitt@gmail.com>
+
+#include <media/rc-map.h>
+#include <linux/module.h>
+
+//
+// Keytable for the Beelink Mini MXIII remote control
+//
+
+static struct rc_map_table beelink_mxiii[] = {
+	{ 0xb2dc, KEY_POWER },
+
+	{ 0xb288, KEY_MUTE },
+	{ 0xb282, KEY_HOME },
+
+	{ 0xb2ca, KEY_UP },
+	{ 0xb299, KEY_LEFT },
+	{ 0xb2ce, KEY_OK },
+	{ 0xb2c1, KEY_RIGHT },
+	{ 0xb2d2, KEY_DOWN },
+
+	{ 0xb2c5, KEY_MENU },
+	{ 0xb29a, KEY_BACK },
+
+	{ 0xb281, KEY_VOLUMEDOWN },
+	{ 0xb280, KEY_VOLUMEUP },
+};
+
+static struct rc_map_list beelink_mxiii_map = {
+	.map = {
+		.scan     = beelink_mxiii,
+		.size     = ARRAY_SIZE(beelink_mxiii),
+		.rc_proto = RC_PROTO_NEC,
+		.name     = RC_MAP_BEELINK_MXIII,
+	}
+};
+
+static int __init init_rc_map_beelink_mxiii(void)
+{
+	return rc_map_register(&beelink_mxiii_map);
+}
+
+static void __exit exit_rc_map_beelink_mxiii(void)
+{
+	rc_map_unregister(&beelink_mxiii_map);
+}
+
+module_init(init_rc_map_beelink_mxiii)
+module_exit(exit_rc_map_beelink_mxiii)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com");
diff --git a/include/media/rc-map.h b/include/media/rc-map.h
index 5178dcae5ff7..dadd4d27a760 100644
--- a/include/media/rc-map.h
+++ b/include/media/rc-map.h
@@ -225,6 +225,7 @@ struct rc_map *rc_map_get(const char *name);
 #define RC_MAP_AVERTV_303                "rc-avertv-303"
 #define RC_MAP_AZUREWAVE_AD_TU700        "rc-azurewave-ad-tu700"
 #define RC_MAP_BEELINK_GS1               "rc-beelink-gs1"
+#define RC_MAP_BEELINK_MXIII             "rc-beelink-mxiii"
 #define RC_MAP_BEHOLD                    "rc-behold"
 #define RC_MAP_BEHOLD_COLUMBUS           "rc-behold-columbus"
 #define RC_MAP_BUDGET_CI_OLD             "rc-budget-ci-old"
-- 
2.34.1

