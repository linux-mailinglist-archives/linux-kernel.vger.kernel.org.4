Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95F2612473
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 18:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJ2Qaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 12:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJ2Qaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 12:30:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5F849B6A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 09:30:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so8299470wme.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSxCGUJ2fS47/D5KQNutWHx6IqYinz5fCVnWfoUaNh4=;
        b=NNB+j7ovS20wgFCS3LKpn7ZIfvCQH882G1PISCxKthqgKtxL6MewW7kolSgbo8N5xv
         rpQaKMBLpl/ypz9W2fj5OQ4syq/tJs6IoJXV+yvwektecUpkD4W4sA3CDjA+pBmyKdt8
         EDiWBNlz+UChXA/VlSYvFR430I10m4sk26DuM3005yoaXdeXDdySOAPxL1BxEniT+nM/
         +qzhVyR4E+qVoKlYWp7wXpNSPBZ8oZKeELGgqScgz7tlpKKv0y0bydg9fgAo3itHdy0Q
         4U14xQ0YfaShKP9SZ8LXiYTQLHh6wVBKDeBbJDFc3AAZkkf/Q1EGTjgMbTJ1hhRz3Llf
         StxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSxCGUJ2fS47/D5KQNutWHx6IqYinz5fCVnWfoUaNh4=;
        b=hHJWam1/QzyAWww2no10GrraaWik3kZ2U0MHukzmPk0shP3K+BIASrGGZ7REnxiwsU
         w7XzbAkh9jMoDmrFJm/dIIAqXNd2lj7yYPau2omF/Fb7cGoBxjpCtT36OeT5dcUD7IIC
         It8vu9wzjZeGNBEhIFIOsoN/Pu4V19YCs+LxxUVLz9Xfm3tnU8W+ueiBFX5YE9cB/mwb
         hrG+cyWieHeV6dI9A+VWse9XqClz/RKJy/r+CKFLVev5jL9Ab2RbQsziCz6QRuAsbXvc
         o20s2jOjb4phmdlxnGIzzkQOaJuIBA1kpfyl/IJa2yAPeKbw03dWeeSHI5D9/p/GHXAC
         TTSA==
X-Gm-Message-State: ACrzQf1y6t2IkqL8Ytw8azB8bn8+KF4hoCjGLBw8hZ01ZzqVRepLtOhJ
        FThlBHN6Llu2slGrZrk2Hhs=
X-Google-Smtp-Source: AMsMyM4RxAJCS8QHD/Ad91l/iYUypGOD9Xexasu+SVgpMMeF7iqFqGU24AoGws7gNjpHQESYfiO6gA==
X-Received: by 2002:a05:600c:1e26:b0:3cf:5238:13fc with SMTP id ay38-20020a05600c1e2600b003cf523813fcmr9321919wmb.151.1667061043217;
        Sat, 29 Oct 2022 09:30:43 -0700 (PDT)
Received: from localhost.localdomain ([111.88.98.191])
        by smtp.gmail.com with ESMTPSA id cc6-20020a5d5c06000000b002364835caacsm1860417wrb.112.2022.10.29.09.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 09:30:42 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Accessiblity: speakup_txprt: specifying the default driver parameters among the module params
Date:   Sat, 29 Oct 2022 21:30:33 +0500
Message-Id: <20221029163033.18337-1-osmtendev@gmail.com>
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

Adding default variables to the speakup_txprt module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
 drivers/accessibility/speakup/speakup_txprt.c | 45 +++++++++++++++----
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_txprt.c b/drivers/accessibility/speakup/speakup_txprt.c
index 9e781347f7eb..4d0a0d4c41f0 100644
--- a/drivers/accessibility/speakup/speakup_txprt.c
+++ b/drivers/accessibility/speakup/speakup_txprt.c
@@ -16,14 +16,29 @@
 #define SYNTH_CLEAR 0x18
 #define PROCSPEECH '\r' /* process speech char */
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\x05P8" } },
-	{ CAPS_STOP, .u.s = {"\x05P5" } },
-	{ RATE, .u.n = {"\x05R%d", 5, 0, 9, 0, 0, NULL } },
-	{ PITCH, .u.n = {"\x05P%d", 5, 0, 9, 0, 0, NULL } },
-	{ VOL, .u.n = {"\x05V%d", 5, 0, 9, 0, 0, NULL } },
-	{ TONE, .u.n = {"\x05T%c", 12, 0, 25, 61, 0, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+
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
+
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\x05P8" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\x05P5" } },
+	[RATE_ID] = { RATE, .u.n = {"\x05R%d", 5, 0, 9, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"\x05P%d", 5, 0, 9, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"\x05V%d", 5, 0, 9, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\x05T%c", 12, 0, 25, 61, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 	 };
 
@@ -112,10 +127,24 @@ static struct spk_synth synth_txprt = {
 module_param_named(ser, synth_txprt.ser, int, 0444);
 module_param_named(dev, synth_txprt.dev_name, charp, 0444);
 module_param_named(start, synth_txprt.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
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
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
+
 
 module_spk_synth(synth_txprt);
 
-- 
2.25.1

