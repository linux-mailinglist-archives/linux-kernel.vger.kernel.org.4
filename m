Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69CC6078E8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiJUNxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJUNx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:53:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFAA2770B5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:53:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n12so4885108wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sslu/1q//zEYvcpbzunTvlX/VVMO0tprETrDXDkshr4=;
        b=WiOfUebR7ADOel6GtJvHVo1pgjNB1AIYxByjmjwG4paz63Kix556UBQCGEfhR8a9sc
         LwEcyWrf3y1S6fHal5THXdFcFvBvGydPQW7nyF6nkvRraX5igFNLBoSkso/EbGw5JdAt
         Q0JUvQ6ws55sFCECcghw8jB+JCo2+v1Zn6r+4/K/0tp0WB3Xw6v5Nz3sl1FCxn26o8dQ
         WbivOuUTwQSoIWgYD2QUmIjvqJDR9XYHJfMfLu42jZ2Xsa69iWA1LeSTt1vtW73zI2uS
         N6uDHbu117MHSVnlAy//O3rOtQxKI/si4L5X6mzjir95INtJZARQ0K53SZP9u8BkSPzT
         GqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sslu/1q//zEYvcpbzunTvlX/VVMO0tprETrDXDkshr4=;
        b=jRmaRt1uv1vXEDPmB6nWXpA0elDq5sAxZmKqQmLbAyttuIV3pQdaEp7hYI6iu4MtCc
         lPKwwn46+sZPB5TSrL10PcMCSmhZjStLrrTpl0aWEL9oYzcxWwnKnEQnB+047neJdVpl
         WY22zeMOYwakBTBukahQEGjy8nrZGYbRnewr1N7/37sMRI2yaqBcyFHt7q+IUTUne8fU
         VKfmY4cTPZ6caYVjyzPskxR53saNXHJ9f8msUsvziLjhMkwtgPnMw2/hPWFVwBH1eYmh
         RRKYYLRv2gWLqX8N9mQMkjnmr3BXAJH33p3UQOOX+dmiHBMzR3wbW7T6TcThE7FcCL2U
         G8og==
X-Gm-Message-State: ACrzQf22wOeFQTtSZioFLBKUJJDbS5n6gCLuqoEQXEGjNIdaeLlRUc2q
        7XWNb33n8OI5NBxwlD3R9Po=
X-Google-Smtp-Source: AMsMyM7wHa4nL+3KgfojH+FeRPe/IaiYdtGx1sSS1FlPkxooZ+zwXNbBzJoPvmXYn3SKONCEDS9RmA==
X-Received: by 2002:a05:6000:4086:b0:236:55a8:8abd with SMTP id da6-20020a056000408600b0023655a88abdmr1880892wrb.157.1666360404398;
        Fri, 21 Oct 2022 06:53:24 -0700 (PDT)
Received: from localhost.localdomain ([117.102.55.205])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c4e4600b003bfaba19a8fsm2610959wmq.35.2022.10.21.06.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:53:24 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     samuel.thibault@ens-lyon.org
Cc:     gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] Accessiblity: speakup_audptr: specifying the default driver parameters among the module params
Date:   Fri, 21 Oct 2022 18:53:09 +0500
Message-Id: <20221021135309.251891-1-osmtendev@gmail.com>
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

Adding default variables to the speakup_audptr module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
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

