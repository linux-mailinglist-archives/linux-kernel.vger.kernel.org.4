Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ECF608E63
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJVQOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJVQOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:14:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEF613E17
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:14:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so7167927wma.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9PbpSrnNj4RAelQRv7F+Nb0NTeaodlXg2sLrAl+yuPA=;
        b=pXdYB3AiwLuXqcmpd7sCCKRV91JonK2vmQxLfiWTBhXpBnpFLiteCrciY1DgBu6JaE
         9yyktXeDOKtEdGQ3jz1Pb2jKAVa1awKy0D0BlrLRKs30B/1ONZ1vnDJCVzCIXqE0Jph5
         Y+VsAZuqkf7uBw6C7aU17U8AKZu9a7vMfYZIv5VlvosrzuRFmWET8eW/4IZcInMcsrQH
         a7vhtuDhLte8JDMQrnQjvhgMMsw6Nr6+vY8rlL7MFoOh81GPGuG8Td6VORlbudNEC7ZV
         pBtVKTIEKjYxRlNtJefWAL/2gLVdk1S/yH/4wErhYEIfbRGnNWuzRQoH4sMD1Jm7P6j7
         TYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PbpSrnNj4RAelQRv7F+Nb0NTeaodlXg2sLrAl+yuPA=;
        b=sFL55Uk42wAVeANwfEhrPhH7gxpjWqv9vIfP0isY5KKQHEko1TviyUBIDATUmiLpSe
         ldFZyF7Eu5xxWU+qMW3SnMCWCcxrSxbBwVyTIkRhcb6gUBSZiLMN/ICUarNngf9Xy3uJ
         ufFL0RhGRCLIbpmKbR2c7HcfOBpF7BlgPHzTxvF/QX8MzMPEgD/OWAXUiOCGzbX+LvDI
         L8THNiwPiktPxpr1TDP91BwifmwE2dLYTWiF1ype2IiV4iW2QBh/tn1Em+mT+qULL58+
         bSAoms/fDxO02KCQWDeDxCcxuf4WZ+4FjzR/uv6DQIAPcyUZ+nPBMd2zSIW/pJngj4Zq
         6p5A==
X-Gm-Message-State: ACrzQf1S8ebF4ELggU5JEJU3ozLb3+cCRTmZffBuEd7aYvKlselz0eea
        a/N9tAU2AGbKKM/a2XQ08TY=
X-Google-Smtp-Source: AMsMyM4ADjocQXR/cgHp2CaKTGgdZURIh7Y55t9LvGbmaVhatKEKePuY6uXEmOJYZ/SfeBIok3sVdw==
X-Received: by 2002:a7b:c5c2:0:b0:3c4:fd96:fb68 with SMTP id n2-20020a7bc5c2000000b003c4fd96fb68mr16635598wmk.36.1666455272600;
        Sat, 22 Oct 2022 09:14:32 -0700 (PDT)
Received: from localhost.localdomain ([117.102.55.205])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b003a6a3595edasm6387582wmo.27.2022.10.22.09.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 09:14:32 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Accessiblity: speakup: specifying the default driver parameters among the module params
Date:   Sat, 22 Oct 2022 21:14:21 +0500
Message-Id: <20221022161421.30453-1-osmtendev@gmail.com>
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


Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>


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

