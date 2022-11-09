Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D554623619
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiKIVwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiKIVvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:51:51 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFE031222
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:51:49 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bs21so27887431wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQRstknxPu8NJsilcRcfIhqLjWZkDyWSxLfboGibmPc=;
        b=XFGrgBKd1IHPUyy1nS5cRLwL2RYAWv8/vcd9NuQd8q5w+vBibFqqrxoTIL1sDyJj/+
         yMVh9h7THXkIfrsBuCkzk7jYOYKxa9BanUVoeqX4SIQ68bLqxLQ6yKU8SQFnUDyc9zLf
         HyqYuOFKwvGJCKNET9ox4qOXzZhqMCVKRwkmIzyPOckYvuzcRbjQE0MVmp3sFVrLID5u
         7t2KdQ7d/CRBwadcsmyc5azZsZfKVh11b2THeBkcujZPFHIwfQn5B/gM2Ys/d5UD3rjH
         obUCQ2xDKXfRrNhMsR1WHmPH00DBzcXCO9atB+jv7p/lXVNnB165U0ytfCGxiZEjb6rG
         qZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQRstknxPu8NJsilcRcfIhqLjWZkDyWSxLfboGibmPc=;
        b=ATgiTjAo9kRUQBq1IVA01rsD6fDOHkmK6cFCs/JZIZmjJtXBW2IBbx9WToAeff99OU
         ipYJ1rKUZgh7/lhpJwZLAHXT/0L2i1L+w58vZfxQ6qJ++rgp4a5SowMnVp2BAIc0LFEq
         2BGt2UgPaL9tcfjCgGsqbIYKKHCyErscMEOYaTtE3ukqAH1ySYftPGF8H9Mq1UoYcOHi
         Kzz3PY9eom0aEOPcVwMsB7DYu/RaUdweaqhmnd8JuIeAmw6uBtS++RFAgaVwMiKHeAjU
         dYX6pUFtU4LZYSM3+Nxt//GwtqBntSN6LMlOnbp55s4MBsGfPsxNQUUT+vYuxlML+mX6
         7aJA==
X-Gm-Message-State: ACrzQf1n+zgnUDCFobt7jsAVb3JuguoebpNUoCYwxbKF45/SQ/gnf0Vp
        1zCaNbkMeXaNrEArJz27g+w=
X-Google-Smtp-Source: AMsMyM5e7YM9u+FEDPupDPRYj/k0c476Ln4LY+QzYlOgrP/dv91IOHgXqUOTxqe5qVB778VWZmgpSQ==
X-Received: by 2002:adf:f411:0:b0:236:e5a2:4f64 with SMTP id g17-20020adff411000000b00236e5a24f64mr29054487wro.182.1668030708138;
        Wed, 09 Nov 2022 13:51:48 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:51:47 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 02/15] Accessiblity: speakup_apollo: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:50:55 +0500
Message-Id: <20221109215108.7933-3-osmtendev@gmail.com>
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

Adding default variables to the speakup_apollo module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
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

