Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3212D62361E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiKIVwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiKIVwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:52:03 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CE831369
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:52:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso2167313wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w++/tXblOqGFmx3bqppileXsaaO1BbiJ5A3Ui/Ogtio=;
        b=VFzInThIOnxnwzogl29fhAmjdZ8YH+KjpjDxYXtEEfDvB7NowUS8kvqaIaFIUZN3iZ
         8KR1VglFfcrh1AaURIy48JIa3lvP+MiZ5QM8Hc/kqrumj7Da4PEgiDsE8ba03GJT5HyS
         WoUXyGWjvRHHVAJ3m54hS9UgSxrmvXWHvY4NODj5h5XshQVQYpw3+tgN/A37S5kmXyNO
         FxXMed8QTT8Udaghjj28Uv8LSQ+x1AtS3ksDqt6R5+i/2OEXiO5ArnCFxuZPc3xV7W3V
         silH+h85OumthKLoaT4kkzBRSTmT6kWmUkeGQeUtl/xkmVWfkaFg8eD88860pZ9HQGMQ
         30UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w++/tXblOqGFmx3bqppileXsaaO1BbiJ5A3Ui/Ogtio=;
        b=gHrkYH47eJvvh0uUlEyaSwPvOeznm/8e4MfR5/RWwI32TqhRv05B6hHpGbziwKCVOG
         a98GDygsLZ5h83aeC3qy8DV/Vl/eKsOiIh/qm4N1GoCOd2fb3d25UQqLPdl7Iuo6MAP1
         P/LnXz2NVRGGv98UXNYNBPGgbQqbrMQpgsyZBqRhB2PPEZ+dL23EeCGiicl0WiFpCnwr
         e96h+yxWqGhf7Fiqz+FPQ7dRhibYC4C7Qart/l7bFb94z5dxAIC/CnOpSAASvTUxQX9h
         alyzTK9eKTmSvMeDP+tUxNdVefzSO0k/s9ze0zzwj8U4if7rQbW7vntcC45fBp/M35X7
         uR8Q==
X-Gm-Message-State: ANoB5plu9eT4kd2Fvyze2dWfevXBqqIcblCPSWcRRMi4Q1bU8kyXpq/t
        efVWqh4KsXG/+zcN+PI2Wk5/qUoIeZc=
X-Google-Smtp-Source: AA0mqf4A9sLYhn7MPg6z1stEIgkITPbYEJRBWXBVDv5AAPsXD6NuPyMIGvBEgfnt1ZLLWztsrHaV1Q==
X-Received: by 2002:a1c:f710:0:b0:3cf:b079:df13 with SMTP id v16-20020a1cf710000000b003cfb079df13mr10402799wmh.16.1668030720711;
        Wed, 09 Nov 2022 13:52:00 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:52:00 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 07/15] Accessiblity: speakup_dectlk: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:51:00 +0500
Message-Id: <20221109215108.7933-8-osmtendev@gmail.com>
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

Adding a default variables to the speakup_dectlk module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 .../accessibility/speakup/speakup_dectlk.c    | 45 ++++++++++++++-----
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_dectlk.c b/drivers/accessibility/speakup/speakup_dectlk.c
index 2a7e8d727904..56334405d865 100644
--- a/drivers/accessibility/speakup/speakup_dectlk.c
+++ b/drivers/accessibility/speakup/speakup_dectlk.c
@@ -40,16 +40,24 @@ static int is_flushing;
 static DEFINE_SPINLOCK(flush_lock);
 static DECLARE_WAIT_QUEUE_HEAD(flush);
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"[:dv ap 160] " } },
-	{ CAPS_STOP, .u.s = {"[:dv ap 100 ] " } },
-	{ RATE, .u.n = {"[:ra %d] ", 180, 75, 650, 0, 0, NULL } },
-	{ PITCH, .u.n = {"[:dv ap %d] ", 122, 50, 350, 0, 0, NULL } },
-	{ INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
-	{ VOL, .u.n = {"[:dv g5 %d] ", 86, 60, 86, 0, 0, NULL } },
-	{ PUNCT, .u.n = {"[:pu %c] ", 0, 0, 2, 0, 0, "nsa" } },
-	{ VOICE, .u.n = {"[:n%c] ", 0, 0, 9, 0, 0, "phfdburwkv" } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID, INFLECTION_ID,
+	VOL_ID, PUNCT_ID, VOICE_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID,
+};
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"[:dv ap 160] " } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"[:dv ap 100 ] " } },
+	[RATE_ID] = { RATE, .u.n = {"[:ra %d] ", 180, 75, 650, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"[:dv ap %d] ", 122, 50, 350, 0, 0, NULL } },
+	[INFLECTION_ID] = { INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"[:dv g5 %d] ", 86, 60, 86, 0, 0, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"[:pu %c] ", 0, 0, 2, 0, 0, "nsa" } },
+	[VOICE_ID] = { VOICE, .u.n = {"[:n%c] ", 0, 0, 9, 0, 0, "phfdburwkv" } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -306,10 +314,27 @@ static void synth_flush(struct spk_synth *synth)
 module_param_named(ser, synth_dectlk.ser, int, 0444);
 module_param_named(dev, synth_dectlk.dev_name, charp, 0444);
 module_param_named(start, synth_dectlk.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(inflection, vars[INFLECTION_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
+
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(inflection, "Set the inflection variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(punct, "Set the punct variable on load.");
+MODULE_PARM_DESC(voice, "Set the voice variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
 
 module_spk_synth(synth_dectlk);
 
-- 
2.25.1

