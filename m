Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40AE6078E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiJUNyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJUNyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:54:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAEE27815C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:54:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a3so5098603wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry/rifZRITieTKJ31xTgwjDcDeN6enEU+BB2GglAe+8=;
        b=hd8VCpeaMopPymUQTy970OUVmtHPP65e2tZ1Lcr/bywxKgYC5FG1F/n3P64vSL7VYk
         cBeJSAGJBZOf/QBI+YyWuyAMqz0Y4RKnDZBNCi6uGmZYuGCRxHjI20MoDlhzaArxT2l7
         PvtIMznq1Wv9Scq43DbuYPFOeLDPPFHfOnfPjWd5INJ/mMPSXUsAv+kQobz918ZsmicR
         o3Mat4xnQt9qPNdybhawrI9kcVqEEECxdryxD9Hy5Jl+C29Rpay9i9FzX0MH/Ylx64kr
         Y6tEUBtHVQ1zlfGLlxDi8k4i+D3gV/cdTE9bDj0yGA9FPVk3EtK3+bQmM4Vb1g0PS9II
         bjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ry/rifZRITieTKJ31xTgwjDcDeN6enEU+BB2GglAe+8=;
        b=n8sHRJTTb2oY0gHnqrtAQH9qpTaTEMeJP0FejTYjNWDyWAASOQgzfVyuCTMhZrghyn
         7XbYVGWhGeQugaOqk4uI2NGAAFiyHpk2n1vQu7Cd2IPIy6oA4rokptBMGJM/eR8fcfeM
         TSDp3j3IROxP8UHxxzd9NqS2YDVG4tc47DhJMw8SrIYV4eAjHjAYLUA9OOcgN9joVXND
         FBt8WFJiAV7RkRk8C7JignoPiWV/MKvf0Yo4hp+jDHWRww9iDN8glyoSrrBsJPVvvO7J
         fXL903aU8/47z9hNzm425Gn8oqJy/g3Fkyx1g4CTVsmK2OI5tkdxa4ucVJLml7VUQLVH
         3zMQ==
X-Gm-Message-State: ACrzQf12b9cLOwZciRHKRNQEm/VyJ7mCxB9amT8XCuT8jqpH6BonO/3q
        PF9NP+nHSj5yel+1OFwdEkk=
X-Google-Smtp-Source: AMsMyM7vQJD3H1JJd5vAyiRt2ENCDnB3hzVHfFOMIlTQZyriY3uuvxSD7kVUpYU0inQfDnRFeApbcA==
X-Received: by 2002:a5d:45c1:0:b0:22e:6d1f:46d0 with SMTP id b1-20020a5d45c1000000b0022e6d1f46d0mr12425874wrs.557.1666360448564;
        Fri, 21 Oct 2022 06:54:08 -0700 (PDT)
Received: from localhost.localdomain ([117.102.55.205])
        by smtp.gmail.com with ESMTPSA id z23-20020a1cf417000000b003c6b874a0dfsm3216527wma.14.2022.10.21.06.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:54:08 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     samuel.thibault@ens-lyon.org
Cc:     gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] Accessiblity: speakup_bns: specifying the default driver parameters among the module params
Date:   Fri, 21 Oct 2022 18:53:42 +0500
Message-Id: <20221021135342.254016-1-osmtendev@gmail.com>
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

Adding a default variables to the speakup_bns module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/accessibility/speakup/speakup_bns.c | 36 ++++++++++++++++-----
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_bns.c b/drivers/accessibility/speakup/speakup_bns.c
index b8103eb117b8..60507756499c 100644
--- a/drivers/accessibility/speakup/speakup_bns.c
+++ b/drivers/accessibility/speakup/speakup_bns.c
@@ -16,14 +16,23 @@
 #define SYNTH_CLEAR 0x18
 #define PROCSPEECH '\r'
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\x05\x31\x32P" } },
-	{ CAPS_STOP, .u.s = {"\x05\x38P" } },
-	{ RATE, .u.n = {"\x05%dE", 8, 1, 16, 0, 0, NULL } },
-	{ PITCH, .u.n = {"\x05%dP", 8, 0, 16, 0, 0, NULL } },
-	{ VOL, .u.n = {"\x05%dV", 8, 0, 16, 0, 0, NULL } },
-	{ TONE, .u.n = {"\x05%dT", 8, 0, 16, 0, 0, NULL } },
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
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\x05\x31\x32P" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\x05\x38P" } },
+	[RATE_ID] = { RATE, .u.n = {"\x05%dE", 8, 1, 16, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"\x05%dP", 8, 0, 16, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"\x05%dV", 8, 0, 16, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\x05%dT", 8, 0, 16, 0, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -113,10 +122,21 @@ static struct spk_synth synth_bns = {
 module_param_named(ser, synth_bns.ser, int, 0444);
 module_param_named(dev, synth_bns.dev_name, charp, 0444);
 module_param_named(start, synth_bns.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(tone, "Set the tone variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
 
 module_spk_synth(synth_bns);
 
-- 
2.25.1

