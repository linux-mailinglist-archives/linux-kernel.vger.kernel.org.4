Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB756078E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiJUNwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJUNwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:52:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C73F2770A3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:52:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b4so4999771wrs.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5O7PA/UB0OdXE7dXrXIrsXAZW/RFj0PvgjoW5rSjTWQ=;
        b=f6xY4wXmsxFdeCWN8Gt+tP/hipqP0SEBlgwLm4amn3uZ8snNJv2Hw9gi3xCWG3caOD
         V6vhB3WpxQDiROMGVjzxKAJ1U4C/4pQ7AZOW64SX2pyiWqSarDU2Se4zbX4n6tfm4o6h
         4JBZyxe6wdalJqNg/zSpjVp/dNuOA4npYZI1Ogxd3q5Fva+KOH9Ey+eKuOv4avA5HLaA
         Eus1LnXOClGGQjxoYVgpYngMdAaH/RJ5g1JpBVANuOH4g9qQEw879kCg5cp1Xj8gAy0R
         cs5f8pnfSqg8Uu1r98E0THB4lHg+AKmwOGGf02mbCm1+tiwZZZiL3JbxIawf27Ez/VqM
         FFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5O7PA/UB0OdXE7dXrXIrsXAZW/RFj0PvgjoW5rSjTWQ=;
        b=NUF3/V+CJtpd9w3nWf2QzExF9mrkhC3exiuwrirASOlZrpJSKM+GWDM7heRcYFxbkC
         ESz6uT/b7buQQnmJcwfmcQBRsZmQNSLZswcfkZFsaZiOpgGx23h+iebbdiiR825ZxdJI
         6IEUazON0S0YGZc054fEcP3J9mwxUJkqJj+XpzLEQOSvS6g9piD1Up+pTdZGfCSMr3Lj
         h/OEHrwyQ5Ut2rjjJ+2TYsLujCjeqDHKZD2tgzvof49qPqwU/tLOZ8d1Muz3s/rLq1Ia
         HWEh7OzBPqkPyHxGvdCiHr6Z6xqSi2+viaDvVl2Ux0YJkZelLatcd6Mr5w6n2CyUIsWe
         pNiQ==
X-Gm-Message-State: ACrzQf0EzBlwCRtS3+hUuWXLsp5jLJxRWMhNDibFxX2qqIa3PMckxLuA
        RVzBIvtWNG1F6JmwurIIgro=
X-Google-Smtp-Source: AMsMyM5QMeNQ/E5TkuLkq423LPgBKWzCOhRuxDXIQgm+SLKf2/XYgljrkVNyLjiR5ZqfXCEtNohRyQ==
X-Received: by 2002:a05:6000:2c4:b0:231:1b8:154 with SMTP id o4-20020a05600002c400b0023101b80154mr13343553wry.378.1666360356003;
        Fri, 21 Oct 2022 06:52:36 -0700 (PDT)
Received: from localhost.localdomain ([117.102.55.205])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c0a0600b003c6b7f55673sm3720138wmp.2.2022.10.21.06.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:52:35 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     samuel.thibault@ens-lyon.org
Cc:     gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, okash.khawaja@gmail.com,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] Accessiblity: speakup_apollo: specifying the default driver parameters among the module params
Date:   Fri, 21 Oct 2022 18:52:16 +0500
Message-Id: <20221021135216.249406-1-osmtendev@gmail.com>
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

Adding default variables to the speakup_apollo module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 .../accessibility/speakup/speakup_apollo.c    | 46 +++++++++++++++----
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_apollo.c b/drivers/accessibility/speakup/speakup_apollo.c
index c84a7e0864b7..d2fbb3f57221 100644
--- a/drivers/accessibility/speakup/speakup_apollo.c
+++ b/drivers/accessibility/speakup/speakup_apollo.c
@@ -24,15 +24,28 @@
 
 static void do_catch_up(struct spk_synth *synth);
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"cap, " } },
-	{ CAPS_STOP, .u.s = {"" } },
-	{ RATE, .u.n = {"@W%d", 6, 1, 9, 0, 0, NULL } },
-	{ PITCH, .u.n = {"@F%x", 10, 0, 15, 0, 0, NULL } },
-	{ VOL, .u.n = {"@A%x", 10, 0, 15, 0, 0, NULL } },
-	{ VOICE, .u.n = {"@V%d", 1, 1, 6, 0, 0, NULL } },
-	{ LANG, .u.n = {"@=%d,", 1, 1, 4, 0, 0, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID,
+	VOL_ID, VOICE_ID, LANG_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"cap, " } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"" } },
+	[RATE_ID] = { RATE, .u.n = {"@W%d", 6, 1, 9, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"@F%x", 10, 0, 15, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"@A%x", 10, 0, 15, 0, 0, NULL } },
+	[VOICE_ID] = { VOICE, .u.n = {"@V%d", 1, 1, 6, 0, 0, NULL } },
+	[LANG_ID] = { LANG, .u.n = {"@=%d,", 1, 1, 4, 0, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -193,10 +206,25 @@ static void do_catch_up(struct spk_synth *synth)
 module_param_named(ser, synth_apollo.ser, int, 0444);
 module_param_named(dev, synth_apollo.dev_name, charp, 0444);
 module_param_named(start, synth_apollo.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
+module_param_named(lang, vars[LANG_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(voice, "Set the voice variable on load.");
+MODULE_PARM_DESC(lang, "Set the lang variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
+
 
 module_spk_synth(synth_apollo);
 
-- 
2.25.1

