Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A7E68A8D8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 08:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjBDHpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 02:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjBDHpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 02:45:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CBE38020;
        Fri,  3 Feb 2023 23:45:10 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a2so6129419wrd.6;
        Fri, 03 Feb 2023 23:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GrWfKS7SerZY/lGE1D1hxrXTkhfUTJa7ypO3DIe71A=;
        b=hFw6noisZaNwEWUCwFX4Tz6tGU+TctnskOSD/jYBoQCjW1JeehQG87M0FZU7VXyUZP
         j2T6Vsal7AA+G55Zi/hwugtiKz0Ki01fx9ccr6rZ649qlgPHNqg5dhXNG0CnOiMXQ1FX
         kfoOEYlOS8D/GlHI89XLB8a5LYrirtNgUjcyDm1m62pkP73lVnkc5hateVWgVui5JKrx
         MEbOD3qmJG6Kf/carSAlUQx8J/uons2hd2yJBeCG3Ovk8rA/O6s8xFydrSPyOIQRitzP
         g+06VqfOxICR9tpUNVbcM4Fp3yteT674BCGhCnUcQ2Ns2GENR0S3FDbaXXa7PEoSzFOn
         XrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GrWfKS7SerZY/lGE1D1hxrXTkhfUTJa7ypO3DIe71A=;
        b=mVr+vVEJm4xRs3xAu9bE39BIbdWc6AntTyeOAnA8I4wNpfCuI9kQp0fo5qZyXbgybC
         LxTd7aofs+ealej4MJD+kdMPH0kFRpCpVeOO/qPBX6Q0L88sp3e9kNPXspthJ4Prmfs7
         KPTaSf4mWSjxGc1nD+SC366GGVxc2xJKRwieIKifvfvphy7TxEnYx2pfBeTZJl39KWIw
         9ExHODloXJcvh78H+dG0IHH23tiSY4GQJP5j0U2642P52Fg/WKorgeXSQa4TJ6cD6Dqh
         8ji3FHRkP9l34QPqgWslXdExsSsNh7boN51+Jo6tPzLsHcXYNLb/la5eHR3CvFSeCpFH
         oKhw==
X-Gm-Message-State: AO0yUKWcvo2jIILoRhrRLwwAyda0T4agGdnPb09VIGdi+N0rtyHYB8ae
        KEKrP5+PaZKWqlW2KfG1HO0=
X-Google-Smtp-Source: AK7set8tBEaOtFnrLPN482KjR1YLZ/EHtnaLctHVhouIhDa9lHWHBnvbeDK4TjTgW3+vpQ3qVWl9SQ==
X-Received: by 2002:a5d:5643:0:b0:2c0:227d:ca48 with SMTP id j3-20020a5d5643000000b002c0227dca48mr10022457wrw.63.1675496710007;
        Fri, 03 Feb 2023 23:45:10 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b00267bcb1bbe5sm3735814wrt.56.2023.02.03.23.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 23:45:09 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 2/2] media: rc: add Beelink Mini MXIII keymap
Date:   Sat,  4 Feb 2023 07:45:01 +0000
Message-Id: <20230204074501.3421910-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230204074501.3421910-1-christianshewitt@gmail.com>
References: <20230204074501.3421910-1-christianshewitt@gmail.com>
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

Add a keymap for the simple IR (NEC) remote used with the Beelink
Mini MXIII Android STB device.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/media/rc/keymaps/Makefile           |  1 +
 drivers/media/rc/keymaps/rc-beelink-mxiii.c | 57 +++++++++++++++++++++
 include/media/rc-map.h                      |  1 +
 3 files changed, 59 insertions(+)
 create mode 100644 drivers/media/rc/keymaps/rc-beelink-mxiii.c

diff --git a/drivers/media/rc/keymaps/Makefile b/drivers/media/rc/keymaps/Makefile
index 6931c89fca99..f19558fdab0c 100644
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
index 000000000000..01180cd92205
--- /dev/null
+++ b/drivers/media/rc/keymaps/rc-beelink-mxiii.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Christian Hewitt <christianshewitt@gmail.com>
+ *
+ */
+
+#include <media/rc-map.h>
+#include <linux/module.h>
+
+/*
+ * Keytable for the Beelink Mini MXIII remote control
+ *
+ */
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
index 94ee968d4722..4676545ffd8f 100644
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

