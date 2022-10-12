Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299215FCC67
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJLUtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJLUts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:49:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FED310F1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:49:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so3097363pjs.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vJfxK7nyPsX8xCGveKTxU6i5T244IBm4LBiNBM+KedY=;
        b=ALRdcpd+V9UPxHvjBAtz6Fhf94Dl+ameX3ExWSlHZTIDzXoTa2E37URxaxw3iaxSRi
         VgnfyvwKdRSilSWvgdnd8vG2RSuPwJPadxXSfz7IW9r2xyATQoTmTyXC79BT41m0WHh+
         axmyCsCB1NDcLT2TVM+vylJVdy4D4cld9VN4XfGfXDcSjOWt+LJIAA+XEd7oZ/XjDPXP
         QiCAMvsEUPnzIxmstK1Ipymp06xYVriqzUbY9RQItaRLEBv5ZOAaYkeevPSeYMLOf2/I
         xNyHpg8DJxjYk6PPUk8VJwm1luKxNmv+FFtzAGH0laocAIplWg/o2YcU6O7J47sJHrvv
         zlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJfxK7nyPsX8xCGveKTxU6i5T244IBm4LBiNBM+KedY=;
        b=d91V2DgiN5FO5rM2ZcbAxe82oG9fJ5Vq3QQN0ZEtcRuVO7bCt9VHi08g5UGwejX5Hf
         cHj4gac7cqoASXWcb8CM6wywc+ya5Mx+Lfm8P+yL+r4C8/lyu3Hr//qB/Xa6RPfeljF3
         a6XBiK6C9Yte9RAZIiJLiXRMY6X3pnGO6emuybNNgvm2KkwkLCF57cuJ7q4osdBf3arW
         rEbAlwtk7EtapGIZw7A3ltdlPmcvrQu1ziHfxAYJ+k5fO/CT9kF2+17Tjb8D1tFSQ1dh
         4HvcB29pMuGeK7tYkkyMHpKgQqNeMo2WGLiwlcOAjAq+xPKsIJjcWUg4qk+dJp7SyBNZ
         ZKkQ==
X-Gm-Message-State: ACrzQf3J4I6LA3N35Tdjh/g0JEfgHcr7q2zjWgeIGXDXcSL5cd2Y0l0Z
        Jt90KoFTcpg9gT22wV1jtbmYtmYeZgQOxkfPyUY=
X-Google-Smtp-Source: AMsMyM4Mqyw0uQlIdivhzfSRvp4T1Yfzi1Okb/19pvoWIteytepKIrGCuSy4Y8njRQcINJS390VFZg==
X-Received: by 2002:a17:902:8601:b0:181:6c26:110d with SMTP id f1-20020a170902860100b001816c26110dmr22266320plo.27.1665607786832;
        Wed, 12 Oct 2022 13:49:46 -0700 (PDT)
Received: from localhost.localdomain ([39.34.128.239])
        by smtp.gmail.com with ESMTPSA id a6-20020aa794a6000000b00562b98da2efsm270403pfl.186.2022.10.12.13.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 13:49:27 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     samuel.thibault@ens-lyon.org
Cc:     gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] Accessiblity: speakup: specifying the default driver parameters among the module params
Date:   Thu, 13 Oct 2022 01:47:23 +0500
Message-Id: <20221012204723.110285-1-osmtendev@gmail.com>
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

Adding a default variables to the speakup_soft module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/accessibility/speakup/speakup_soft.c | 34 +++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
index 28c8f60370cf..fd65dd40616e 100644
--- a/drivers/accessibility/speakup/speakup_soft.c
+++ b/drivers/accessibility/speakup/speakup_soft.c
@@ -33,6 +33,15 @@ static struct miscdevice synth_device, synthu_device;
 static int init_pos;
 static int misc_registered;
 
+
+enum default_vars_id {
+	DIRECT_ID = 0, CAPS_START_ID, CAPS_STOP_ID,
+	PAUSE_ID, RATE_ID, PITCH_ID, INFLECTION_ID,
+	VOL_ID, TONE_ID, PUNCT_ID, VOICE_ID,
+	FREQUENCY_ID,
+};
+
+
 static struct var_t vars[] = {
 	/* DIRECT is put first so that module_param_named can access it easily */
 	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
@@ -451,10 +460,33 @@ static int softsynth_adjust(struct spk_synth *synth, struct st_var_header *var)
 }
 
 module_param_named(start, synth_soft.startup, short, 0444);
-module_param_named(direct, vars[0].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+module_param_named(caps_start, vars[CAPS_START_ID].u.s.default_val, charp, 0444);
+module_param_named(caps_stop, vars[CAPS_STOP_ID].u.s.default_val, charp, 0444);
+module_param_named(pause, vars[PAUSE_ID].u.n.default_val, int, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(inflection, vars[INFLECTION_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
+module_param_named(frequency, vars[FREQUENCY_ID].u.n.default_val, int, 0444);
+
+
 
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
 MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+MODULE_PARM_DESC(caps_start, "Set the caps_start variable on load.");
+MODULE_PARM_DESC(caps_stop, "Set the caps_stop variable on load.");
+MODULE_PARM_DESC(rate, "Sets the rate of the synthesizer.");
+MODULE_PARM_DESC(pitch, "Sets the pitch of the synthesizer.");
+MODULE_PARM_DESC(inflection, "Sets the inflection of the synthesizer.");
+MODULE_PARM_DESC(vol, "Sets the volume of the speech synthesizer.");
+MODULE_PARM_DESC(tone, "Sets the tone of the speech synthesizer.");
+MODULE_PARM_DESC(punct, "Sets the amount of punctuation spoken by the synthesizer.");
+MODULE_PARM_DESC(voice, "Sets the voice used by the synthesizer.");
+MODULE_PARM_DESC(frequency, "Sets the frequency of speech synthesizer.");
 
 module_spk_synth(synth_soft);
 
-- 
2.25.1

