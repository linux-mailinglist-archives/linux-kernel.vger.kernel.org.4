Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912FE612471
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 18:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJ2Q3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ2Q3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 12:29:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7264D26C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 09:29:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o4so10291432wrq.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 09:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SIY6GLYaHDZmy7etaMcL0/7BjyXmuxjM0bd/7D8L/Cg=;
        b=JYTE9L5nDYMNnQf5Dks4XB6MupqJC+0khTiyAmjqlLPNkLTopv9HXPfP+O9AjZEstT
         bRLXsTaGlH6pOa2IEJr7/vmCSygAHIBaX+1jH4NhPIRigoed+QCinJtIZfsyREyhLP+H
         juY6h2GLc3d1nX0X7lXxgTtGM+KQc7ADMn/IdAo9RjmmDHGFGPFZxOcd0YPZgJo6ViuY
         kIt046HZzq1dRkZtjJE0k4BblkKedGcNNEq0+PNAuwML9X3v5GUx0G4jSCOiLkottHRM
         TwPSa3zQiF8sfO5c5jHuzY0gG0za3Sin2/W0UVm3UOOG4+WdqKxgDdm8geoBSXlJwQUU
         u75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIY6GLYaHDZmy7etaMcL0/7BjyXmuxjM0bd/7D8L/Cg=;
        b=Mz0S2767uKN56r4pnU8jVzTPonA07/eepTJi88gfMSNT15NIzl6rdVmhkNKtIk2wRT
         Zg2RkvV0MiDvqKCQqYS7pNWTLKJhCLPhU6J5SFo4VAFQl0XnyJ/gs86qTe0eux1sBBI7
         6Sh3pVF7IQOe57yqEI/HoSq4PopCz3PFfB/e5tEhnZYCXt6XY0xi0+2v19N1yWgiMep1
         UlZBz6qR8dK+qiehx2vetQ1CLkYTp0bWsDGdUJpsas5xWdk+uoz6kMlXJJPthdhDjP3B
         2LHplHnsDJtaslciIhqYUwnnYXo8+OOPbJbPx3dJvGNiWZlRlR0iR4DPjsKCoIoU9+m+
         V+JA==
X-Gm-Message-State: ACrzQf1fcHoZRb1HKGnwUn9W9npPVQvlbtQsasL/oqdPMtMMFZPqKuTb
        EuZiLLrrnMtNYAN16FBRkDQ=
X-Google-Smtp-Source: AMsMyM78EFSaleBqVapLmMfx1p4PUCdfZmARAdlHguN5Jr6zeICrXvALhhy4fU8PjY4ea8PdJGI3GQ==
X-Received: by 2002:a5d:6d89:0:b0:236:6e52:4fa with SMTP id l9-20020a5d6d89000000b002366e5204famr2742000wrs.395.1667060959307;
        Sat, 29 Oct 2022 09:29:19 -0700 (PDT)
Received: from localhost.localdomain ([111.88.98.191])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c410d00b003c6bd12ac27sm2078868wmi.37.2022.10.29.09.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 09:29:18 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Accessiblity: speakup_spkout: specifying the default driver parameters among the module params
Date:   Sat, 29 Oct 2022 21:29:13 +0500
Message-Id: <20221029162913.17967-1-osmtendev@gmail.com>
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

Adding default variables to the speakup_spkout module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
 .../accessibility/speakup/speakup_spkout.c    | 43 +++++++++++++++----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_spkout.c b/drivers/accessibility/speakup/speakup_spkout.c
index 5e3bb3aa98b6..d3f26095b0ee 100644
--- a/drivers/accessibility/speakup/speakup_spkout.c
+++ b/drivers/accessibility/speakup/speakup_spkout.c
@@ -18,15 +18,26 @@
 
 static void synth_flush(struct spk_synth *synth);
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\x05P+" } },
-	{ CAPS_STOP, .u.s = {"\x05P-" } },
-	{ RATE, .u.n = {"\x05R%d", 7, 0, 9, 0, 0, NULL } },
-	{ PITCH, .u.n = {"\x05P%d", 3, 0, 9, 0, 0, NULL } },
-	{ VOL, .u.n = {"\x05V%d", 9, 0, 9, 0, 0, NULL } },
-	{ TONE, .u.n = {"\x05T%c", 8, 0, 25, 65, 0, NULL } },
-	{ PUNCT, .u.n = {"\x05M%c", 0, 0, 3, 0, 0, "nsma" } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID,
+	VOL_ID, TONE_ID, PUNCT_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\x05P+" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\x05P-" } },
+	[RATE_ID] = { RATE, .u.n = {"\x05R%d", 7, 0, 9, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"\x05P%d", 3, 0, 9, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"\x05V%d", 9, 0, 9, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\x05T%c", 8, 0, 25, 65, 0, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"\x05M%c", 0, 0, 3, 0, 0, "nsma" } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -124,10 +135,24 @@ static void synth_flush(struct spk_synth *synth)
 module_param_named(ser, synth_spkout.ser, int, 0444);
 module_param_named(dev, synth_spkout.dev_name, charp, 0444);
 module_param_named(start, synth_spkout.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
+
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(tone, "Set the tone variable on load.");
+MODULE_PARM_DESC(punct, "Set the punct variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
+
 
 module_spk_synth(synth_spkout);
 
-- 
2.25.1

