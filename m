Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ABF60E228
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiJZN2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiJZN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:28:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50745C90FC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:28:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bk15so26312520wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=362GiQRK/ggfijI20XZPkwAi0Vc05CKDZeDSFgTHZxQ=;
        b=XoRQ75UU1dBgr5mhEUJi9FyE1+fro4oJHq3/Ahf1cOrH2+OL64W8E8UZk8SJOERPrk
         RacBtuhnOgRgZlR4TviySaHqvJBKwWiYwEHSnV+HL1JL8vB8AZZa4ED3f8IGEVWB/AKA
         Ry3B/6eDbVJTgURgqsro3NovZ0B3BysOIThWrwgUTOKB+FIIAXK0wO8na7Ys1tXOy08p
         /ZvfTnJXuVW6pjSToSzsvRBcf9sgAN7Q53BlcEBBvnBTifSBAZjzI+VKZwsAt7B50q5m
         +Tjg3zlbaMVNGm7vh5KCvOXphPwoZSBg/8hMbJtCXc8d4hqiiKZX8ysK9nHaHEoUFlHc
         +sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=362GiQRK/ggfijI20XZPkwAi0Vc05CKDZeDSFgTHZxQ=;
        b=r/o4ivg+dZft6uM6Qlo7lmvoZ0PeoOXnj3ZYMilgOAanDxgapMIV2p5TR76agKk9Jt
         Fv/twDnLgtk9yXeBZSstEYInbBtje1yDwahi+fdGTpq8Zvqmibgm+GMqo1xBrwMBMVrS
         0rtBDEO58bFv158ZmYglSz1y2VvMDn2enGQMUM8b3/v9kMiX8zG70RwUzxiKm6yYDh1/
         nwRaU83di6ytspIMqfQiSYq1Pr/fvsR+oxp4xZOtFPEfCZK4CACTj26nlc59m6VnRmh7
         GT8sFgjMG5LMAas44d66Z7ZcMFUddpLHfch/jR/AJBehqQYYIvQzAj7njkUzXXhBOomR
         lqQA==
X-Gm-Message-State: ACrzQf3nbcK0nQShm9/f3WUfi85DcGQ9KSQW3GJ7mq436D6hYBghKG4/
        rSEq5fynGo+Hd5JnTvyhdPQ=
X-Google-Smtp-Source: AMsMyM6EGHbN5gYc2cvhx5AyxH/90RVhEU0tzjL/zYfjp3pmzX0zPLSVK2q4S0xEbteb8eGDfgnSlA==
X-Received: by 2002:a05:6000:1f01:b0:236:64ae:ad19 with SMTP id bv1-20020a0560001f0100b0023664aead19mr13436527wrb.523.1666790878935;
        Wed, 26 Oct 2022 06:27:58 -0700 (PDT)
Received: from localhost.localdomain ([111.88.96.240])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c150500b003c6c5a5a651sm1805352wmg.28.2022.10.26.06.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:27:58 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Accessiblity: speakup_dectlk: specifying the default driver parameters among the module params
Date:   Wed, 26 Oct 2022 18:27:53 +0500
Message-Id: <20221026132753.10186-1-osmtendev@gmail.com>
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

Adding default variables to the speakup_dectlk module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
 .../accessibility/speakup/speakup_dectlk.c    | 45 ++++++++++++++-----
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_dectlk.c b/drivers/accessibility/speakup/speakup_dectlk.c
index 2a7e8d727904..56334405d865 100644
--- a/drivers/accessibility/speakup/speakup_dectlk.c
+++ b/drivers/accessibility/speakup/speakup_dectlk.c
@@ -40,16 +40,24 @@ static int is_flushing;
 static DEFINE_SPINLOCK(flush_lock);
 static DECLARE_WAIT_QUEUE_HEAD(flush);
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"[:dv ap 160] " } },
-	{ CAPS_STOP, .u.s = {"[:dv ap 100 ] " } },
-	{ RATE, .u.n = {"[:ra %d] ", 180, 75, 650, 0, 0, NULL } },
-	{ PITCH, .u.n = {"[:dv ap %d] ", 122, 50, 350, 0, 0, NULL } },
-	{ INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
-	{ VOL, .u.n = {"[:dv g5 %d] ", 86, 60, 86, 0, 0, NULL } },
-	{ PUNCT, .u.n = {"[:pu %c] ", 0, 0, 2, 0, 0, "nsa" } },
-	{ VOICE, .u.n = {"[:n%c] ", 0, 0, 9, 0, 0, "phfdburwkv" } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID, INFLECTION_ID,
+	VOL_ID, PUNCT_ID, VOICE_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID,
+};
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"[:dv ap 160] " } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"[:dv ap 100 ] " } },
+	[RATE_ID] = { RATE, .u.n = {"[:ra %d] ", 180, 75, 650, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"[:dv ap %d] ", 122, 50, 350, 0, 0, NULL } },
+	[INFLECTION_ID] = { INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"[:dv g5 %d] ", 86, 60, 86, 0, 0, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"[:pu %c] ", 0, 0, 2, 0, 0, "nsa" } },
+	[VOICE_ID] = { VOICE, .u.n = {"[:n%c] ", 0, 0, 9, 0, 0, "phfdburwkv" } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -306,10 +314,27 @@ static void synth_flush(struct spk_synth *synth)
 module_param_named(ser, synth_dectlk.ser, int, 0444);
 module_param_named(dev, synth_dectlk.dev_name, charp, 0444);
 module_param_named(start, synth_dectlk.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(inflection, vars[INFLECTION_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
+
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(inflection, "Set the inflection variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(punct, "Set the punct variable on load.");
+MODULE_PARM_DESC(voice, "Set the voice variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
 
 module_spk_synth(synth_dectlk);
 
-- 
2.25.1

