Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA7A60E223
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiJZN1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiJZN1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:27:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0956B7F57
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:27:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l14so19083800wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=03VqyrssAnWYRCP0pdmk/17TCQCe4Tb4Cliyq7Ue4DU=;
        b=AcakbBd+Jw19mBAgmbFUuo2PwWTbN74rRB77CJHHK6nv3QvkbUMYH5WA3WSl5z2WL5
         jG61S5UEbfQx8InrBj1VMcIBJX5xgQqTwJ3KnzYk7MxMs2ydYw13p4yRTle+UZwKP6eu
         CZE6XpR2Q6HJxskOtIGThUkxGrg7MZVE06QY+dmbagj40X050RZgZXMPuKqOqbZl1Bmm
         AZq/lDszqeBMxbBEVlid55sHWjg1gCtopX8FThiAKlUNw8brYsWnUEcAZr7FRIsVyKhK
         Z5/tkG7J3LyJOz9h43i/XPycPK98n9bUtDU3m0a5vWWm64jwKPkLt5/crhpkmAtGRlKZ
         /6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03VqyrssAnWYRCP0pdmk/17TCQCe4Tb4Cliyq7Ue4DU=;
        b=IdYB5YV8tiwqKB5ov2zFK+p9PUCNaWRKWpxGKwz7Hd1GRE6TJHHcdbpAvkd1AgoXJ0
         KZrF5MnaIDyhmtgr5KZh7qBm5SOtOmPHHkFZVHzhy+2Rh/IXT1XBZ/4NdHSStt8dTVVE
         vj6Gp6v/nFWfuA4UPyg2kf/tlRJC6k3zWafCLR23aBy5sVBNqwUJ2ZDydcduFfh4sRrI
         37S36c0FNGamzzvVFiaH9Wk8oiqHjWa17fvvfGLj24jt9w2Rzt6evIib+jGASIlUGwF5
         rA0n9KARzb9plwAwukSJMfW78Du36T1vT63Jho81yewE598xFjzRsYPXjsrDByjh61ET
         UgGQ==
X-Gm-Message-State: ACrzQf1Kz8LckNwgSj1216PirLFLqNLgPRGzcH3WtU1D0RT6QJC3bqep
        H7K+Xbq4Gyd/vJxa18FB8j6homFxffieqA==
X-Google-Smtp-Source: AMsMyM5vSNcTib7F7qbfY2NVz3RPcmwOSyoKqTc8u6PeVVOblws3MYd8aToQQECLP1HZWj/nRWGC5A==
X-Received: by 2002:a05:6000:228:b0:236:773e:a6c0 with SMTP id l8-20020a056000022800b00236773ea6c0mr9042682wrz.102.1666790842116;
        Wed, 26 Oct 2022 06:27:22 -0700 (PDT)
Received: from localhost.localdomain ([111.88.96.240])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d438b000000b0022cbf4cda62sm6565483wrq.27.2022.10.26.06.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:27:21 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Accessiblity: speakup_decext: specifying the default driver parameters among the module params
Date:   Wed, 26 Oct 2022 18:27:11 +0500
Message-Id: <20221026132711.10071-1-osmtendev@gmail.com>
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

Adding default variables to the speakup_decext module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
 .../accessibility/speakup/speakup_decext.c    | 44 ++++++++++++++-----
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_decext.c b/drivers/accessibility/speakup/speakup_decext.c
index eaebf62300a4..271bcf279bf9 100644
--- a/drivers/accessibility/speakup/speakup_decext.c
+++ b/drivers/accessibility/speakup/speakup_decext.c
@@ -38,16 +38,25 @@ static void synth_flush(struct spk_synth *synth);
 
 static int in_escape;
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"[:dv ap 222]" } },
-	{ CAPS_STOP, .u.s = {"[:dv ap 100]" } },
-	{ RATE, .u.n = {"[:ra %d]", 7, 0, 9, 150, 25, NULL } },
-	{ PITCH, .u.n = {"[:dv ap %d]", 100, 0, 100, 0, 0, NULL } },
-	{ INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
-	{ VOL, .u.n = {"[:dv gv %d]", 13, 0, 16, 0, 5, NULL } },
-	{ PUNCT, .u.n = {"[:pu %c]", 0, 0, 2, 0, 0, "nsa" } },
-	{ VOICE, .u.n = {"[:n%c]", 0, 0, 9, 0, 0, "phfdburwkv" } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID, INFLECTION_ID,
+	VOL_ID, PUNCT_ID, VOICE_ID,
+	DIRECT_ID, V_LAST_ID,
+	NB_ID,
+};
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"[:dv ap 222]" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"[:dv ap 100]" } },
+	[RATE_ID] = { RATE, .u.n = {"[:ra %d]", 7, 0, 9, 150, 25, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"[:dv ap %d]", 100, 0, 100, 0, 0, NULL } },
+	[INFLECTION_ID] = { INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"[:dv gv %d]", 13, 0, 16, 0, 5, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"[:pu %c]", 0, 0, 2, 0, 0, "nsa" } },
+	[VOICE_ID] = { VOICE, .u.n = {"[:n%c]", 0, 0, 9, 0, 0, "phfdburwkv" } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -225,10 +234,25 @@ static void synth_flush(struct spk_synth *synth)
 module_param_named(ser, synth_decext.ser, int, 0444);
 module_param_named(dev, synth_decext.dev_name, charp, 0444);
 module_param_named(start, synth_decext.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(inflection, vars[INFLECTION_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
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
 
 module_spk_synth(synth_decext);
 
-- 
2.25.1

