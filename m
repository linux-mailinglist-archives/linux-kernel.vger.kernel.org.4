Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C975B555A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiILH3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiILH3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:29:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1220BC7A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:29:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 9so7732708plj.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=76Fc8CveDr2A+XmsMO5aUYZ5rkOnd7dGevIsjexozj4=;
        b=F8NP15gZkfBbXBlUfEXn49/A0QpQqs7gTdFVxwsMcYAnddJIIfYigbCy9aOXR/ntIR
         OianP6O0MfCRuxmweOqPokqOViD0/VkCL1x8gaRrlt+3u8VK9vInt1MNLzUSY/xphNC1
         nG3MWclY3ko3xJjNzsOLmwYsvvDzNK7BXm/dY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=76Fc8CveDr2A+XmsMO5aUYZ5rkOnd7dGevIsjexozj4=;
        b=LAHWh661CAQI8hU43e5J+0hGEmoejwDtABKrqLL3df3aCLxhELn0FIr4IvvI3zHsQi
         kQiZ9jBY0Kl9PUDnSbQ27HH3xCdowaUxFZbkKsWQs+E8vfXqJ3AoNXiS41eCAdIvJJOC
         +maJjRujewI99qf8rtZi9jAyofVY1GaNXlXOdOpjNIeRyvxgeof7z46dOPR1EoIPnHOh
         jnglWKb/XT0jFBlHSy2K6EWoEAlDc7N/oCkz5PrIEf9LGQHAN3E8lM7xL+Uj4GN4a/m7
         WuxqVGDIn2ewVY8tZaccxbXwxVwmAdswaJ456+YA5czg0CfI+QAcrU2KMZyVDB1F39WX
         T8LA==
X-Gm-Message-State: ACgBeo2Fk8A17abcOcMzjx8hjon1IuOyGu/DVDbNOzYOV4jOmRy0P3Ga
        P6iSF1jypaAVKXktXhLyKH0YbQ==
X-Google-Smtp-Source: AA6agR7lk1dIw7GQ9Uh3Fk6DXfrdPnmE2WjPA0REhe9qtzk8cXnzGMAKEZkDpBH/CYAawp6iFWxvUA==
X-Received: by 2002:a17:90b:1d8c:b0:202:abf5:4b21 with SMTP id pf12-20020a17090b1d8c00b00202abf54b21mr10438059pjb.162.1662967751568;
        Mon, 12 Sep 2022 00:29:11 -0700 (PDT)
Received: from yjscloudtop.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id n68-20020a622747000000b0053e599d7032sm4612214pfn.54.2022.09.12.00.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 00:29:10 -0700 (PDT)
From:   YJ Lee <yunjunlee@chromium.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        YJ Lee <yunjunlee@chromium.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, yuhsuan@chromium.org,
        whalechang@chromium.org
Subject: [PATCH v1] ALSA: dummy: Fix trailing whitespaces.
Date:   Mon, 12 Sep 2022 15:28:54 +0800
Message-Id: <20220912072854.760824-1-yunjunlee@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl ERROR: trailing whitespaces.

Signed-off-by: YJ Lee <yunjunlee@chromium.org>
---
 sound/drivers/dummy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 2a7fc49c1a7c5..fcf1ee00bd214 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -296,7 +296,7 @@ static void dummy_systimer_callback(struct timer_list *t)
 	struct dummy_systimer_pcm *dpcm = from_timer(dpcm, t, timer);
 	unsigned long flags;
 	int elapsed = 0;
-	
+
 	spin_lock_irqsave(&dpcm->lock, flags);
 	dummy_systimer_update(dpcm);
 	dummy_systimer_rearm(dpcm);
@@ -717,7 +717,7 @@ static int snd_dummy_volume_info(struct snd_kcontrol *kcontrol,
 	uinfo->value.integer.max = 100;
 	return 0;
 }
- 
+
 static int snd_dummy_volume_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
@@ -766,7 +766,7 @@ static const DECLARE_TLV_DB_SCALE(db_scale_dummy, -4500, 30, 0);
   .private_value = addr }
 
 #define snd_dummy_capsrc_info	snd_ctl_boolean_stereo_info
- 
+
 static int snd_dummy_capsrc_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
@@ -1100,7 +1100,7 @@ static int snd_dummy_suspend(struct device *pdev)
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	return 0;
 }
-	
+
 static int snd_dummy_resume(struct device *pdev)
 {
 	struct snd_card *card = dev_get_drvdata(pdev);
-- 
2.37.2.789.g6183377224-goog
