Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD04623620
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiKIVwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiKIVw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:52:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8EC31DD5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:52:06 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so13526wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHsK+KbIO4yH/BIpFol8qX26pgAqv1083y12c/rgkm8=;
        b=dMIvvJler7IaTwTnU9k1E2ZO8+iQHW81ODjdfoCojttLGtxIl9NtMPLJpVRGgd2zsO
         d5Qxma+xkGr+oW263PLt+jrc3tcwfc0FT9luiSDu4CVjYbw9amdFmTBZe9jvNarNFUB/
         fv4HKx427cCb0TeLzBDTfVHJbCfnKLzHfvGBAFsvCJhPIhc7sA9Zul2sL7pWOM9qhoA/
         4IE5aJk9zeOogK11euq0Q5KNqC8q6hQj1PGXKYzdndy5cKP0ljgJVIuQGkopWENQO7uQ
         aSqpfX7z4C86wRZIy8EJqHWXpXzXOdpylNqYawl09juzJsKeZF8dGZcQHOkPd+M69trX
         t3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHsK+KbIO4yH/BIpFol8qX26pgAqv1083y12c/rgkm8=;
        b=3rhhqX3/olesALKv9QopfW4WC7y+lHtyHkW9NyAA5ig9kfg6ot4zH+wZCJKh/+2SD+
         jzyo6Id/HAuuKm14DLYDb00TFldcGOq4BYm4h+1Yuz81DUdsbQTdhRfOFY3VIA6ZAtwK
         4zy2KJ7RtQ1RNu5iZuVHrAJbun1RQ75+nuqvI3iH1LcNLjkQDRzO1BPSok3IEOOzimaN
         n2KasR//rdlV+O15wkz0ycp2Z1DgnxNt6Rlii4THXa1++Mrutr0LLPc8Z9TEgG9K7q9S
         XYv6kYqgbuAbLckozZHtz3AAEGBeOtn62Io/g1g28SZ/9ypAvbNIz73NPUiw6F35Apjj
         KlKg==
X-Gm-Message-State: ACrzQf0D2z1bmKCvMOA5QMGgLyAulPNUOriJ8MpOVozS0EKvX6j5TbZY
        fp0YjVE/vK+UcpINxA0e+0s=
X-Google-Smtp-Source: AMsMyM6PPNF0vnak5uNiDQ+HeELFHPGqrGQ6Vf7oo1BqTDwkLQIq6D5pOegYbPzn2OIO0Qt5XGz/JA==
X-Received: by 2002:a05:600c:3011:b0:3cf:9c3f:3b60 with SMTP id j17-20020a05600c301100b003cf9c3f3b60mr18903333wmh.183.1668030725266;
        Wed, 09 Nov 2022 13:52:05 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:52:04 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 09/15] Accessiblity: speakup_dummy: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:51:02 +0500
Message-Id: <20221109215108.7933-10-osmtendev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109215108.7933-1-osmtendev@gmail.com>
References: <20221109215108.7933-1-osmtendev@gmail.com>
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

Adding default variables to the speakup_dummy module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/accessibility/speakup/speakup_dummy.c | 53 +++++++++++++++----
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_dummy.c b/drivers/accessibility/speakup/speakup_dummy.c
index 56419dbb28d3..52b2c5d44576 100644
--- a/drivers/accessibility/speakup/speakup_dummy.c
+++ b/drivers/accessibility/speakup/speakup_dummy.c
@@ -18,17 +18,30 @@
 #define DRV_VERSION "2.11"
 #define SYNTH_CLEAR '!'
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"CAPS_START\n" } },
-	{ CAPS_STOP, .u.s = {"CAPS_STOP\n" } },
-	{ PAUSE, .u.s = {"PAUSE\n"} },
-	{ RATE, .u.n = {"RATE %d\n", 8, 1, 16, 0, 0, NULL } },
-	{ PITCH, .u.n = {"PITCH %d\n", 8, 0, 16, 0, 0, NULL } },
-	{ INFLECTION, .u.n = {"INFLECTION %d\n", 8, 0, 16, 0, 0, NULL } },
-	{ VOL, .u.n = {"VOL %d\n", 8, 0, 16, 0, 0, NULL } },
-	{ TONE, .u.n = {"TONE %d\n", 8, 0, 16, 0, 0, NULL } },
-	{ PUNCT, .u.n = {"PUNCT %d\n", 0, 0, 3, 0, 0, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	PAUSE_ID,
+	RATE_ID, PITCH_ID, INFLECTION_ID,
+	VOL_ID, TONE_ID, PUNCT_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"CAPS_START\n" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"CAPS_STOP\n" } },
+	[PAUSE_ID] = { PAUSE, .u.s = {"PAUSE\n"} },
+	[RATE_ID] = { RATE, .u.n = {"RATE %d\n", 8, 1, 16, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"PITCH %d\n", 8, 0, 16, 0, 0, NULL } },
+	[INFLECTION_ID] = { INFLECTION, .u.n = {"INFLECTION %d\n", 8, 0, 16, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"VOL %d\n", 8, 0, 16, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"TONE %d\n", 8, 0, 16, 0, 0, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"PUNCT %d\n", 0, 0, 3, 0, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -129,10 +142,28 @@ static struct spk_synth synth_dummy = {
 module_param_named(ser, synth_dummy.ser, int, 0444);
 module_param_named(dev, synth_dummy.dev_name, charp, 0444);
 module_param_named(start, synth_dummy.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(inflection, vars[INFLECTION_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
+
+
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(inflection, "Set the inflection variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(tone, "Set the tone variable on load.");
+MODULE_PARM_DESC(punct, "Set the punct variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
 
 module_spk_synth(synth_dummy);
 
-- 
2.25.1

