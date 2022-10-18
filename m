Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4646603403
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJRUd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJRUdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:33:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9884F6BD7C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:33:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so16019876wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GXUxXWnCC0DASuVw/pN70J/V2juc2cG+Uguz1dPYu94=;
        b=JkJLraxX/bMWHMKBT98hvqMcXCeCrOOWGHaU9Z4gy+BiZjEHQIm0qDN9F+aGcxhR+F
         3Ghmv92UF21jGKebL29OI2S/s7zzyv5dNCzdDZ5B5aoFC8inU5wuxmMo/Z4gFfSAEMTt
         Xz81Wxyw5Y7rdWpIoDwYGkWzwqHKjXh1lP0TkvpVpQk/wkJ2Dy2WJIKiIZoHKKGcLqcf
         Ed4k+mRhxp05UP73G6dewFUojcy8ogjL61Ech+woKe4FtL9Lg4xSsQWa4qx24HfpItc3
         xX8y2j8rF5hULH4QQ6cRS7nOQvJd9f/zxS9zVbd+1BPKpGXILt8k8EtWLsZa8YAyYn4H
         Kh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXUxXWnCC0DASuVw/pN70J/V2juc2cG+Uguz1dPYu94=;
        b=HHqybpLqsXDyoZIWXPOZj/qsqaODIQzoxWC/EoH7frLYSsWPTjd0cssUHw1ZeCgCJN
         8oCzzADzYUNpqv1JYUR9GrBz0UhUPXQg5t/oCRGTtCo5AeHaHBoVVX95ANDGkRIx2mr+
         ZK0nRXurzzpPgzVaf0Dr6DbSYwjRP62vsxQLCUmjac3RaPPluxaeXcuQ8b52x7IuegOc
         gtAmxcg/SCC+y5vcH2+3mRj6SVMAKCtbWpd/qY7oxAvwuksktEtkFF1hM0Uy41EZbRs9
         ZpEAj+qKCg6yyuSi1v/XghpEaZBFT91QM2YFvjno7dBWGIAYbOWyhWD4a4Vd/2/fItz2
         gnhQ==
X-Gm-Message-State: ACrzQf3Fm+eW8FtmO2+qOwLJnbiPlCoMx1robS5ik+KeLL4YmzUifBxk
        cUJaEJ3EZyUJRfSP8HKa8xX5UT2gp9aI5w==
X-Google-Smtp-Source: AMsMyM5ANW/LBkAkeIoZ4+yqsjFCn42lrxJBKqcsGe+9VEyMdq1pdXWsUXjuZpIRNRbHNuW3DpW0vA==
X-Received: by 2002:a05:600c:490f:b0:3c6:2c21:97f6 with SMTP id f15-20020a05600c490f00b003c62c2197f6mr23707638wmp.177.1666125230965;
        Tue, 18 Oct 2022 13:33:50 -0700 (PDT)
Received: from localhost.localdomain ([39.34.139.0])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c19ce00b003b477532e66sm4228912wmq.2.2022.10.18.13.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 13:33:49 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     samuel.thibault@ens-lyon.org
Cc:     gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] Accessiblity: speakup: specifying the default driver parameters among the module params
Date:   Wed, 19 Oct 2022 01:33:08 +0500
Message-Id: <20221018203308.6143-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This is an enhancement which allows to specify the default driver
parameters among the module parameters.

Adding default variables to the speakup_acntpc.c and speakup_acntsa.c
module allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 .../accessibility/speakup/speakup_acntpc.c    | 38 +++++++++++++++----
 .../accessibility/speakup/speakup_acntsa.c    | 37 ++++++++++++++----
 2 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_acntpc.c b/drivers/accessibility/speakup/speakup_acntpc.c
index a55b60754eb1..a27e6bbf05da 100644
--- a/drivers/accessibility/speakup/speakup_acntpc.c
+++ b/drivers/accessibility/speakup/speakup_acntpc.c
@@ -34,14 +34,23 @@ static int synth_port_control;
 static int port_forced;
 static unsigned int synth_portlist[] = { 0x2a8, 0 };
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\033P8" } },
-	{ CAPS_STOP, .u.s = {"\033P5" } },
-	{ RATE, .u.n = {"\033R%c", 9, 0, 17, 0, 0, "0123456789abcdefgh" } },
-	{ PITCH, .u.n = {"\033P%d", 5, 0, 9, 0, 0, NULL } },
-	{ VOL, .u.n = {"\033A%d", 5, 0, 9, 0, 0, NULL } },
-	{ TONE, .u.n = {"\033V%d", 5, 0, 9, 0, 0, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID,
+	VOL_ID, TONE_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\033P8" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\033P5" } },
+	[RATE_ID] = { RATE, .u.n = {"\033R%c", 9, 0, 17, 0, 0, "0123456789abcdefgh" } },
+	[PITCH_ID] = { PITCH, .u.n = {"\033P%d", 5, 0, 9, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"\033A%d", 5, 0, 9, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\033V%d", 5, 0, 9, 0, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -305,9 +314,22 @@ static void accent_release(struct spk_synth *synth)
 
 module_param_hw_named(port, port_forced, int, ioport, 0444);
 module_param_named(start, synth_acntpc.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
+
 
 MODULE_PARM_DESC(port, "Set the port for the synthesizer (override probing).");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(tone, "Set the tone variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
 
 module_spk_synth(synth_acntpc);
 
diff --git a/drivers/accessibility/speakup/speakup_acntsa.c b/drivers/accessibility/speakup/speakup_acntsa.c
index 2697c51ed6b5..26bb9f9399d3 100644
--- a/drivers/accessibility/speakup/speakup_acntsa.c
+++ b/drivers/accessibility/speakup/speakup_acntsa.c
@@ -19,14 +19,24 @@
 
 static int synth_probe(struct spk_synth *synth);
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\033P8" } },
-	{ CAPS_STOP, .u.s = {"\033P5" } },
-	{ RATE, .u.n = {"\033R%c", 9, 0, 17, 0, 0, "0123456789abcdefgh" } },
-	{ PITCH, .u.n = {"\033P%d", 5, 0, 9, 0, 0, NULL } },
-	{ VOL, .u.n = {"\033A%d", 9, 0, 9, 0, 0, NULL } },
-	{ TONE, .u.n = {"\033V%d", 5, 0, 9, 0, 0, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID,
+	VOL_ID, TONE_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\033P8" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\033P5" } },
+	[RATE_ID] = { RATE, .u.n = {"\033R%c", 9, 0, 17, 0, 0, "0123456789abcdefgh" } },
+	[PITCH_ID] = { PITCH, .u.n = {"\033P%d", 5, 0, 9, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"\033A%d", 9, 0, 9, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\033V%d", 5, 0, 9, 0, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -129,10 +139,21 @@ static int synth_probe(struct spk_synth *synth)
 module_param_named(ser, synth_acntsa.ser, int, 0444);
 module_param_named(dev, synth_acntsa.dev_name, charp, 0444);
 module_param_named(start, synth_acntsa.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(tone, "Set the tone variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
 
 module_spk_synth(synth_acntsa);
 
-- 
2.25.1

