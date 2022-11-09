Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7164562361D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiKIVwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiKIVwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:52:01 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AA1317C3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:51:59 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o4so27905627wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIKdefUvpamOxQzyWfL+FnFUN2x2wOfn4PYXf6UxhbI=;
        b=NP3BGlaLmUEUrmAc4CxyChQP0QWSp7qtSi4q9oSvvXr4Os66YA2w83efez8movF5lI
         eud7vlZ2aMVuQDRWHKRH5TvlHk9u2h2L+kocOZ+7KxkWQ3qLS20qroexYBR85MLxZaZb
         yiFcNrQAH9a45aErWebMoHs+GKEwvJrqV3gHaKR0mLuwwQxJ6uQLgG1DCAldAn6YqK2N
         3IpkuTV6aFyrka9pdKpzV7Lj3+0uPvVlPDUXyi1PyWB1ZPyaNEbaFzrfNiVZR5DjWp+l
         nyEn+rvs4vTMule1NkA1ZbFaKBmLBeCwFihpCED8LzeA+hKe97VdrofMVI9tftCsGZwt
         oqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIKdefUvpamOxQzyWfL+FnFUN2x2wOfn4PYXf6UxhbI=;
        b=SBxUW1XT4VnAarmTg1nVzaTUOavIjBZl4F6jE8B7ugzlPyShcllX/PweVdiC5gS0Mw
         0/HqureyHPLIM/TqqphfEf+SIbONSr+1puc/ub1RHZ8WLBZfC91ZrfaT2FttdjCUD0zZ
         Yalwgg1dfots0vzLErq1TdY1Zr9BNxqEMblO/z4Tl823HOqZpZGdZGu6RiiuXcZ/uCKo
         QStwSCDGEFL1whVRk9Tu+aN+kOefbGYqulKEely/8JJi7KpTZraMeSQYOMyuBkLqdQ66
         +ldKaegnGPGdTtUURww5pg27dyxlwZCvQPPRU9Z7ojtyX1KW4DVkC19SGm4XE00KTX2f
         yw9w==
X-Gm-Message-State: ACrzQf2XvIF/Wk/YBBxkjlzcBXkVs5TGNRI1qcE8j2kUN9oDRp72deuH
        KyjCRYXsMVsIyRW9mDZDFeXYuVehY5g=
X-Google-Smtp-Source: AMsMyM42RzQ2NjPkz+odfSNpXSBdbAPpyXInYZ9BP7JEZuqTXsrmWVS22UdwElHPRXW5DCKhwS0TxA==
X-Received: by 2002:a05:6000:1f16:b0:238:3fc8:1f11 with SMTP id bv22-20020a0560001f1600b002383fc81f11mr22934411wrb.9.1668030717900;
        Wed, 09 Nov 2022 13:51:57 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:51:57 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 06/15] Accessiblity: speakup_decpc: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:50:59 +0500
Message-Id: <20221109215108.7933-7-osmtendev@gmail.com>
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

Adding default variables to the speakup_decpc module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/accessibility/speakup/speakup_decpc.c | 48 +++++++++++++++----
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_decpc.c b/drivers/accessibility/speakup/speakup_decpc.c
index dec314dee214..083ca9265805 100644
--- a/drivers/accessibility/speakup/speakup_decpc.c
+++ b/drivers/accessibility/speakup/speakup_decpc.c
@@ -134,16 +134,27 @@ static int synth_portlist[] = { 0x340, 0x350, 0x240, 0x250, 0 };
 static int in_escape, is_flushing;
 static int dt_stat, dma_state;
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"[:dv ap 200]" } },
-	{ CAPS_STOP, .u.s = {"[:dv ap 100]" } },
-	{ RATE, .u.n = {"[:ra %d]", 9, 0, 18, 150, 25, NULL } },
-	{ PITCH, .u.n = {"[:dv ap %d]", 80, 0, 100, 20, 0, NULL } },
-	{ INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
-	{ VOL, .u.n = {"[:vo se %d]", 5, 0, 9, 5, 10, NULL } },
-	{ PUNCT, .u.n = {"[:pu %c]", 0, 0, 2, 0, 0, "nsa" } },
-	{ VOICE, .u.n = {"[:n%c]", 0, 0, 9, 0, 0, "phfdburwkv" } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID, INFLECTION_ID,
+	VOL_ID, PUNCT_ID, VOICE_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID,
+};
+
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"[:dv ap 200]" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"[:dv ap 100]" } },
+	[RATE_ID] = { RATE, .u.n = {"[:ra %d]", 9, 0, 18, 150, 25, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"[:dv ap %d]", 80, 0, 100, 20, 0, NULL } },
+	[INFLECTION_ID] = { INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"[:vo se %d]", 5, 0, 9, 5, 10, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"[:pu %c]", 0, 0, 2, 0, 0, "nsa" } },
+	[VOICE_ID] = { VOICE, .u.n = {"[:n%c]", 0, 0, 9, 0, 0, "phfdburwkv" } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -483,8 +494,25 @@ static void dtpc_release(struct spk_synth *synth)
 }
 
 module_param_named(start, synth_dec_pc.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(inflection, vars[INFLECTION_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
+
+
 
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(inflection, "Set the inflection variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(punct, "Set the punct variable on load.");
+MODULE_PARM_DESC(voice, "Set the voice variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
 
 module_spk_synth(synth_dec_pc);
 
-- 
2.25.1

