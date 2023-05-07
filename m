Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0550A6F9886
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 15:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjEGNA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 09:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjEGNA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 09:00:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B7519A7
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 06:00:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-306dbad5182so2199236f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683464423; x=1686056423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2ZLNCEsJLERCJy0gGs5VDu5LaJyymMxQIgFZdzx4Oc=;
        b=UIzAEM0lhWcg0LvT+iLaZZ9z95LJtB1QA58RomVZDdNArnmYi/vFYjhsnuIl2l/47E
         dPnm7ILOBtB3VN1pdoWZ4rC7VcywvLAP5Y1BiGzEo+SMfsiJmw8tnVk7pV2yvKYFDmGo
         bkxDM8icz53z02W8KqRpeI4Ge1f42/8L0UNhEL6KqNleKQ8ImWi2AAx2LJv0L63kSCB0
         xINqTuauYD7REnMO6SdhmJSJ8Uq+tsVRmmUzxijk/FnXpPYSQW2HtnYVfcJBYG5VRrcN
         nZ14K4PYvOttEHK3ZbDajenu+5s/MVsas/0Y2WACfDNZiOrAx4iiMafnpR4np5VhOOI9
         iKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683464423; x=1686056423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2ZLNCEsJLERCJy0gGs5VDu5LaJyymMxQIgFZdzx4Oc=;
        b=J+Z/I0PtrpQkUr34kr9L7biwTq503zlSRW6I4k12y5pEDp3DYK6UtFVogkoiZI2GQ0
         aeXT00yJdRFuW5nYHVoNG2uel2DyepwcDigf/krEvBz2YincBBgPbAKB6rWG/W1u2F6Q
         JVAwMjzJeXgm0BKxHvWx4D/zKGxkkpSzZNOEqXiT/+Pf0cb6zjxRPCpHmpMR4gUJrILf
         kQhvSIBRVVHZ7YvmfroAOmmPgMRbarNzCAMzYX2c1BYWHosU+n5cA4rmr3CGjtl9oB8m
         cHPcjc5S8bl0h4437yALWLqHHV+S3IH843zWxF5RMhvlFIdTs1IT3JSLjWSyyI1C0pBo
         NfdA==
X-Gm-Message-State: AC+VfDx00IyeeQY54ZzUw94xnOWTs2wrh7pgXtlx9nVrWgiduC6hvD4L
        yCEU3IAF47ApPwRnIy/6evk=
X-Google-Smtp-Source: ACHHUZ7BQF8TmLtYLTVOhFy275Vi6INRdqa96cajN2Saxs9+TCMydxCmQl1KPVxKJSME5QtwGfso1w==
X-Received: by 2002:a5d:4146:0:b0:2cf:e747:b0d4 with SMTP id c6-20020a5d4146000000b002cfe747b0d4mr4859241wrq.40.1683464423299;
        Sun, 07 May 2023 06:00:23 -0700 (PDT)
Received: from jack.home ([92.58.200.160])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb11000000b003075428aad5sm7907969wrr.29.2023.05.07.06.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 06:00:23 -0700 (PDT)
From:   jack1989s@gmail.com
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Federico Di Lembo <jack1989s@gmail.com>
Subject: [PATCH] Sound:last.c: fix code syle trailing white space - modify printk()->netdev_dbg() - Possible unnecessary KERN_INFO removed
Date:   Sun,  7 May 2023 15:00:21 +0200
Message-Id: <20230507130021.48112-1-jack1989s@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Federico Di Lembo <jack1989s@gmail.com>

Fixing coding style.

Signed-off-by: Federico Di Lembo <jack1989s@gmail.com>
---
 sound/last.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/last.c b/sound/last.c
index f0bb98780e70..b8cfd6ded95d 100644
--- a/sound/last.c
+++ b/sound/last.c
@@ -11,18 +11,18 @@ static int __init alsa_sound_last_init(void)
 {
 	struct snd_card *card;
 	int idx, ok = 0;
-	
-	printk(KERN_INFO "ALSA device list:\n");
+
+	netdev_dbg("ALSA device list:\n");
 	for (idx = 0; idx < SNDRV_CARDS; idx++) {
 		card = snd_card_ref(idx);
 		if (card) {
-			printk(KERN_INFO "  #%i: %s\n", idx, card->longname);
+			netdev_dbg("  #%i: %s\n", idx, card->longname);
 			snd_card_unref(card);
 			ok++;
 		}
 	}
 	if (ok == 0)
-		printk(KERN_INFO "  No soundcards found.\n");
+		netdev_dbg("  No soundcards found.\n");
 	return 0;
 }
 
-- 
2.34.1

