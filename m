Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54421608F0D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJVS4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 14:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJVS4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 14:56:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7D4139C2B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:56:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pq16so5085453pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SsUz5Lmxm2u4GI85qA0EwHkhFJZyQ2clv/8UaHEwD4A=;
        b=Pap6ai7f3bjclqb30s43izlq3eeBGcQV4B2mjhwWkCzWFPLkO/KIVtzBsKrAhZlyeH
         xjA5CfsfvfivgH/DI6ohxUmmRgrJiEf7SfRZAgI1plj+zkR58KkXkdQ3nBlZgF0/U/LS
         gFdJvGo1GEkEPw3VjtXGzN4Gv+mZb/7R7UTj2rcProSQBaLBcYuii3zCea5oVB4nhW+f
         C7xoy4CU7L8QpFDdLSxaBJVBO7AlH4mjcFKxNsmUruOHF6Rdlx8fLsDaDyzi/03a6w72
         YRzHO6TYopazvQxXTqeFlOsbV5V3Srm0CI3oW9FKrJ9vOlyq0qUsLzcnzqb9VMU32lyh
         uAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsUz5Lmxm2u4GI85qA0EwHkhFJZyQ2clv/8UaHEwD4A=;
        b=OCXjzL3z4aFokvh9x2aSzxorhUZ3l2VWRVNFb8LDjhLlq0E4NVf/vNZre8QRADzkCX
         Q/yRK3Lo5SP+ZI7f45BArDVHNNVsnBCEL8/tN6rHhQbuiHOo/L4IpqXaooiRdWnmRfzr
         o3uZuKcOiJM9yN6kjbaWYAwAhz1tBPBK0t7ChdNeSAazmiJ38/aq7JH4x9qgfHERNc7l
         /Ql5GKtMhf+jAf+/aYV5cFnL0CzaLI0Ecoxyk9zmyWU17FRWECSRAMKdbo4MwG8Fxs3p
         1sQV8TUf4MBqdVqYgJM5FZNlijcmTLiJS9FGLrmb/TZMtBfZ0b6zcpe06nzW4AhFelv1
         n47w==
X-Gm-Message-State: ACrzQf0GbUBU8Zgi6SmAGSTzS4qFpvmcnbGA9Akraz9QqYq6GeoaO8oz
        12a7S0UPy8gtUisWi33hkB5uSaulin2F0w==
X-Google-Smtp-Source: AMsMyM7Dl9OcmOfQIF6m63gPGuMgUEUpwvUc/Htr+aH7X1T/UDtbXYvtuZprKIpfdTL7X8YjE6JHTw==
X-Received: by 2002:a17:90a:a401:b0:20a:da56:b073 with SMTP id y1-20020a17090aa40100b0020ada56b073mr29767464pjp.1.1666464970680;
        Sat, 22 Oct 2022 11:56:10 -0700 (PDT)
Received: from localhost.localdomain ([117.102.55.205])
        by smtp.gmail.com with ESMTPSA id y7-20020a170902b48700b00176a6ba5969sm1767315plr.98.2022.10.22.11.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 11:56:10 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Accessiblity: speakup_bns: specifying the default driver parameters among the module params
Date:   Sat, 22 Oct 2022 23:56:00 +0500
Message-Id: <20221022185600.3989-1-osmtendev@gmail.com>
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

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

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

