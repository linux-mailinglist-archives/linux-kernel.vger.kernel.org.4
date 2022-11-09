Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B666162361A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiKIVwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiKIVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:51:53 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9C62FFE3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:51:52 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bk15so27814995wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwFfJkgLBMsG8X68BTthTYj/FVRMJ4sv5Wum1nW3dsU=;
        b=HptzlRgoLjPgDZhtwo5vAmPxJU0r+CbQBAxr4NnD1htXFtLC2WCPTPDZ2NJbk607B4
         XhLjIl11DtQPIYvLrrceO1EQLt3rUBC2pa1/HR9DrVGHlE4SYV5tDUb93nwIuLawJFJB
         YhKLGP6Yj/R18FxRdwoNme1ZE7dArYcz3W/J533AOeaTEqdmEg8JnnJUA8HfXYGaCU1m
         kJhpr6veI63/V22VzG9qpOVOI3x09XpW2vKPDmSHaIk0xDLb/5mlqzNX3jBbQTjjIjZu
         w8L1CPOWPtD+JTv5o3AMRQJYRjhbLT5qQp0JGJ4NG8Nk4M6q8cUFeZTXJEFNUBeURbvB
         CEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwFfJkgLBMsG8X68BTthTYj/FVRMJ4sv5Wum1nW3dsU=;
        b=knx4IsfN8UB2W6OnR2vue4HSDaMPt/a1dh+bONSPu5AvEVaJ+Ao7otnAjuFiuWvGNE
         JW/wC5tnFtYDXd0RVM+cK/cowcj0yJKsL+rWjScmhM3ndBNCndxfk3AGhTZXVkKM1MiT
         nJSiYnGTnh/bkGHyS03Kr4BZu51/lX2BxT02zumlDf4xx/uKDA5NiH0mrOIU735OXjDJ
         LolO1ISdw9pZlyWtBS2gfQZxqU9IppiwLtmSXDLrMiV/8HV9wRmlC5NcMztGR12Zx44u
         D9e9a5avcTwAWX2HqygO+iCeG0xHtZ32LUJiq7n2a3b+NUq2giRkThWl6f0xHJQVVDQA
         I6OQ==
X-Gm-Message-State: ACrzQf0ZoTZo1hfvhWQP1ZiuBb4G7Hi0GVgZ9Wa8FdkFHZVGobRkjTTt
        FXzUarzUnxGe6jsAPoHJGGY=
X-Google-Smtp-Source: AMsMyM4r1o8irvC//cjMIhErJrK3qMgW9joCpaheFD4CHqzl0fqNiO5caGOQhli4k4VZ2wo7g7RafQ==
X-Received: by 2002:adf:ec8b:0:b0:236:6f30:924f with SMTP id z11-20020adfec8b000000b002366f30924fmr40045465wrn.230.1668030710817;
        Wed, 09 Nov 2022 13:51:50 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:51:50 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 03/15] Accessiblity: speakup_audptr: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:50:56 +0500
Message-Id: <20221109215108.7933-4-osmtendev@gmail.com>
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

Adding a default variables to the speakup_audptr module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 .../accessibility/speakup/speakup_audptr.c    | 42 +++++++++++++++----
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_audptr.c b/drivers/accessibility/speakup/speakup_audptr.c
index 4d16d60db9b2..55813f3e40ff 100644
--- a/drivers/accessibility/speakup/speakup_audptr.c
+++ b/drivers/accessibility/speakup/speakup_audptr.c
@@ -19,15 +19,24 @@
 static int synth_probe(struct spk_synth *synth);
 static void synth_flush(struct spk_synth *synth);
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\x05[f99]" } },
-	{ CAPS_STOP, .u.s = {"\x05[f80]" } },
-	{ RATE, .u.n = {"\x05[r%d]", 10, 0, 20, 100, -10, NULL } },
-	{ PITCH, .u.n = {"\x05[f%d]", 80, 39, 4500, 0, 0, NULL } },
-	{ VOL, .u.n = {"\x05[g%d]", 21, 0, 40, 0, 0, NULL } },
-	{ TONE, .u.n = {"\x05[s%d]", 9, 0, 63, 0, 0, NULL } },
-	{ PUNCT, .u.n = {"\x05[A%c]", 0, 0, 3, 0, 0, "nmsa" } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID,
+	VOL_ID, TONE_ID, PUNCT_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\x05[f99]" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\x05[f80]" } },
+	[RATE_ID] = { RATE, .u.n = {"\x05[r%d]", 10, 0, 20, 100, -10, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"\x05[f%d]", 80, 39, 4500, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"\x05[g%d]", 21, 0, 40, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\x05[s%d]", 9, 0, 63, 0, 0, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"\x05[A%c]", 0, 0, 3, 0, 0, "nmsa" } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -158,10 +167,25 @@ static int synth_probe(struct spk_synth *synth)
 module_param_named(ser, synth_audptr.ser, int, 0444);
 module_param_named(dev, synth_audptr.dev_name, charp, 0444);
 module_param_named(start, synth_audptr.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
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
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
 
 module_spk_synth(synth_audptr);
 
-- 
2.25.1

