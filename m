Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768176140E3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJaWw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJaWwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:52:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679362DC2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:52:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ud5so33101145ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UJIs643oAL5c/63LTolWUa5z+l7GDyqyf25JL0+db0E=;
        b=mBFIrX7TMv9ObbTZdo12IujkhmRytwBezp5HbgU1xl8eyQ7ss1XehZrk9Oc58S5xcp
         IuijQcvHRlMLRvTPbyd2+QX7iVyaecue/RyDvEry2UydgycpwAO1W5cyfxg9N/UM8vsN
         jlb+z5rmAnyVRtPzbT3mGLMzw417S/KO8wKEjwSbBjzSeDN7Wm/6BK+smBJ8h1K2aMK2
         MbzXMd3jNG5w+lh2sekm4NTNohB5X9shwYTvYEMLkpkXKddMKGm/Ir19zitmEmwa2UXF
         Sm9KfWkYejUwbqAKh1WSmp7u9iIG0uAPA8o5qlt3xf7ql7tTRt+QsMUqQC0nQnYVr0w/
         uEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJIs643oAL5c/63LTolWUa5z+l7GDyqyf25JL0+db0E=;
        b=c6icTMCb2ZsVY6e7REDZVdU2VSAags5S2Bm3h0snMHkQhM5Bx6rX5j31GjzE3OJeQ4
         RNk0W+ASCZNK5Kgb1KfjvgZaeqVbuc48rqVCHQNKSTEx1VDQpNWUBTOIyYorhzO4iF4p
         kzcJhO1eLsLDs+iIiY44nE/+r5hH3sMAfPNTO4SBqXA9ulepQPKm3m+8aWaLZzjtJRDe
         IRuMLexYJNo4Ccy7oKLwR7W7t2yaRZ28KLBJHf/iO7XY6sHjMPR5wPvXuIAlwncz3+ab
         hqD/vm8Hw65JKAmHzskgZiT0oE3a/ybh0ILpuDhjLK/7wV2Bf+IblBVEhn67cjhG/7kC
         cKZA==
X-Gm-Message-State: ACrzQf3W67Hy9NY+CszY5NxaEJCfxutk/hnHZvFTNxFrzsGg8VQ/q9nc
        MIDI2QYhzxwKxZWHJBlCHJLM59IFMeHDfw==
X-Google-Smtp-Source: AMsMyM7w8AzoadH2iGc6rbisb33dUQKpQylrnzfErOQ3aori+DoHmWVMutfUtFCxETGVgzKP5oMNSw==
X-Received: by 2002:a17:907:761b:b0:7a3:86dd:d330 with SMTP id jx27-20020a170907761b00b007a386ddd330mr15142348ejc.34.1667256771828;
        Mon, 31 Oct 2022 15:52:51 -0700 (PDT)
Received: from ZBook.localdomain (86-90-194-80.fixed.kpn.net. [86.90.194.80])
        by smtp.gmail.com with ESMTPSA id ux8-20020a170907cf8800b0078194737761sm3462098ejc.124.2022.10.31.15.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:52:51 -0700 (PDT)
From:   Jerom van der Sar <jerom.vandersar@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philip.g.hortmann@gmail.com, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jerom van der Sar <jerom.vandersar@gmail.com>
Subject: [PATCH] staging: rtl8192e: cleanup coding style issues with spacing
Date:   Mon, 31 Oct 2022 23:51:55 +0100
Message-Id: <20221031225155.15678-1-jerom.vandersar@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fixed several coding style issues in rtl_cam.c such as double blank lines
and lack of spaces around binary operators. It passes without trivial
warnings about spaces. Some other warnings still remain.

Signed-off-by: Jerom van der Sar <jerom.vandersar@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c | 25 +++++++++------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index 41faeb4b9b9b..aeef735679db 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -17,7 +17,7 @@ void rtl92e_cam_reset(struct net_device *dev)
 {
 	u32 ulcommand = 0;
 
-	ulcommand |= BIT31|BIT30;
+	ulcommand |= BIT31 | BIT30;
 	rtl92e_writel(dev, RWCAM, ulcommand);
 }
 
@@ -40,7 +40,6 @@ void rtl92e_enable_hw_security_config(struct net_device *dev)
 		SECR_value |= SCR_TxUseDK;
 	}
 
-
 	ieee->hwsec_active = 1;
 	if ((ieee->pHTInfo->iot_action & HT_IOT_ACT_PURE_N_MODE) || !hwwep) {
 		ieee->hwsec_active = 0;
@@ -100,33 +99,32 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 	}
 
 	if (DefaultKey)
-		usConfig |= BIT15 | (KeyType<<2);
+		usConfig |= BIT15 | (KeyType << 2);
 	else
-		usConfig |= BIT15 | (KeyType<<2) | KeyIndex;
-
+		usConfig |= BIT15 | (KeyType << 2) | KeyIndex;
 
 	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
 		TargetCommand  = i + CAM_CONTENT_COUNT * EntryNo;
-		TargetCommand |= BIT31|BIT16;
+		TargetCommand |= BIT31 | BIT16;
 
 		if (i == 0) {
-			TargetContent = (u32)(*(MacAddr+0)) << 16 |
-				(u32)(*(MacAddr+1)) << 24 |
+			TargetContent = (u32)(*(MacAddr + 0)) << 16 |
+				(u32)(*(MacAddr + 1)) << 24 |
 				(u32)usConfig;
 
 			rtl92e_writel(dev, WCAMI, TargetContent);
 			rtl92e_writel(dev, RWCAM, TargetCommand);
 		} else if (i == 1) {
-			TargetContent = (u32)(*(MacAddr+2)) |
-				(u32)(*(MacAddr+3)) <<  8 |
-				(u32)(*(MacAddr+4)) << 16 |
-				(u32)(*(MacAddr+5)) << 24;
+			TargetContent = (u32)(*(MacAddr + 2)) |
+				(u32)(*(MacAddr + 3)) <<  8 |
+				(u32)(*(MacAddr + 4)) << 16 |
+				(u32)(*(MacAddr + 5)) << 24;
 			rtl92e_writel(dev, WCAMI, TargetContent);
 			rtl92e_writel(dev, RWCAM, TargetCommand);
 		} else {
 			if (KeyContent != NULL) {
 				rtl92e_writel(dev, WCAMI,
-					      (u32)(*(KeyContent+i-2)));
+					      (u32)(*(KeyContent + i - 2)));
 				rtl92e_writel(dev, RWCAM, TargetCommand);
 				udelay(100);
 			}
@@ -152,7 +150,6 @@ void rtl92e_cam_restore(struct net_device *dev)
 
 	if ((priv->rtllib->pairwise_key_type == KEY_TYPE_WEP40) ||
 	    (priv->rtllib->pairwise_key_type == KEY_TYPE_WEP104)) {
-
 		for (EntryId = 0; EntryId < 4; EntryId++) {
 			MacAddr = CAM_CONST_ADDR[EntryId];
 			if (priv->rtllib->swcamtable[EntryId].bused) {
-- 
2.34.1

