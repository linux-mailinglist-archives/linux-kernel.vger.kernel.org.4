Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8C623622
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiKIVwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiKIVw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:52:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935E731DE4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:52:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id z14so27887345wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8S0HlohWlYP5GxiObhBs51DVH6bOEt+kedYZZ5xHeU=;
        b=bkj4LkMBhryNiHcUK56hTqvLuVYo2EvyiPwrCQgowlq8CDjpINs8a/Vl2CB9mxBNZu
         U/Whh/VsrqZJfxfGngnfBCzQWcwe0jLVJHQLC7H0ND5YL1KCRkCQhSTFSHEpLl+BuGdA
         +wJtzQ++gEoG4ORuUnQ+tm4vHdpRatUjquQdhFTCElgOTbnkMBiqVedsr2GFOEw0IB7p
         DIJDUQnfW1bvAfKx8g/Kryawr6jfSSMbLGdd8go4C9LUAYtG6ewSCThhesyL8kx2kqlr
         z4CDHwO7UHbrPFVbMbUPotZ1UNlcAPbajDYKtWMQdHligxB2x210y0B+n6qgSp7M2Mfx
         wkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8S0HlohWlYP5GxiObhBs51DVH6bOEt+kedYZZ5xHeU=;
        b=umLEM3dRks9h6/UOAsiAKoNul2ty/sLtUW8bM1FcYM/sxoof0h9BSp2Kc22G2MiRz3
         UNL6jDjIV082/LINvyqMsnoeu3E2i8hSyXi/4sm1guwbCl+REIgmH0JgvBg+nauUlRCo
         QRMbe1/GWI2pgiVXO22NKrX+8KMWivERbyoqbQq5G4JW4idyEtxFo0DOFg7PB7pAmbDv
         M99pGmjJU/ceoqOImrh6n95kNPvXPjsLvU4vaSJCQevT2ID2dtRwOl0kQm7aOwi21Z1v
         pedTyBvY1sH1WuHIda0evwsDShQx+6y5fFtw9w8M9sTzsjN8y4TgKBLKr1PyqbW2XF4U
         iFQQ==
X-Gm-Message-State: ACrzQf1uY+/Br4LL3tiSGT5QBeg9pqbm5dGxGB/dlaAPqbO8/uoSSm5A
        XnbNnd1YcYiMbXeb/NVtLfs=
X-Google-Smtp-Source: AMsMyM7NLiomcqaVFxrTHVCaEOQQlpWjHcSPtO4SJgI3HYe7ZsKqWgTLeACqWIYeVZ5PVTn7KD/x1A==
X-Received: by 2002:a5d:654d:0:b0:235:197d:72d1 with SMTP id z13-20020a5d654d000000b00235197d72d1mr39286734wrv.680.1668030729884;
        Wed, 09 Nov 2022 13:52:09 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:52:09 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 11/15] Accessiblity: speakup_ltlk: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:51:04 +0500
Message-Id: <20221109215108.7933-12-osmtendev@gmail.com>
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

Adding default variables to the speakup_ltlk module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/accessibility/speakup/speakup_ltlk.c | 53 ++++++++++++++++----
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_ltlk.c b/drivers/accessibility/speakup/speakup_ltlk.c
index f885cfaa27c8..1e279ae143bf 100644
--- a/drivers/accessibility/speakup/speakup_ltlk.c
+++ b/drivers/accessibility/speakup/speakup_ltlk.c
@@ -18,17 +18,28 @@
 
 static int synth_probe(struct spk_synth *synth);
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\x01+35p" } },
-	{ CAPS_STOP, .u.s = {"\x01-35p" } },
-	{ RATE, .u.n = {"\x01%ds", 8, 0, 9, 0, 0, NULL } },
-	{ PITCH, .u.n = {"\x01%dp", 50, 0, 99, 0, 0, NULL } },
-	{ VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
-	{ TONE, .u.n = {"\x01%dx", 1, 0, 2, 0, 0, NULL } },
-	{ PUNCT, .u.n = {"\x01%db", 7, 0, 15, 0, 0, NULL } },
-	{ VOICE, .u.n = {"\x01%do", 0, 0, 7, 0, 0, NULL } },
-	{ FREQUENCY, .u.n = {"\x01%df", 5, 0, 9, 0, 0, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID,
+	VOL_ID, TONE_ID, PUNCT_ID,
+	VOICE_ID, FREQUENCY_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\x01+35p" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\x01-35p" } },
+	[RATE_ID] = { RATE, .u.n = {"\x01%ds", 8, 0, 9, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"\x01%dp", 50, 0, 99, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\x01%dx", 1, 0, 2, 0, 0, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"\x01%db", 7, 0, 15, 0, 0, NULL } },
+	[VOICE_ID] = { VOICE, .u.n = {"\x01%do", 0, 0, 7, 0, 0, NULL } },
+	[FREQUENCY_ID] = { FREQUENCY, .u.n = {"\x01%df", 5, 0, 9, 0, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -160,10 +171,30 @@ static int synth_probe(struct spk_synth *synth)
 module_param_named(ser, synth_ltlk.ser, int, 0444);
 module_param_named(dev, synth_ltlk.dev_name, charp, 0444);
 module_param_named(start, synth_ltlk.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
+module_param_named(frequency, vars[FREQUENCY_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
+
+
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(tone, "Set the tone variable on load.");
+MODULE_PARM_DESC(punct, "Set the punct variable on load.");
+MODULE_PARM_DESC(voice, "Set the voice variable on load.");
+MODULE_PARM_DESC(frequency, "Set the frequency variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
 
 module_spk_synth(synth_ltlk);
 
-- 
2.25.1

