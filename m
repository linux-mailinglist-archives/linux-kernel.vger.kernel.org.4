Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF737615478
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiKAVyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKAVyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:54:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DCB26F4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:54:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t25so40558238ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ifr2udJQaykytNB8WSuWQEM/D/tWuwVDxhVVtYTxuG8=;
        b=WHSj1s3RA0vwjR99/GJ4uAjcFD8u1uXQuvv7saw5RYWmUgG46nLc7CyDa08YDbqYgq
         AiAI0cpKPA+D/InnucH5k3hJ3Azx/IzCVIc4zLpY7WUcV9AATllpBSps+JDcacQCBcTa
         eiCVG6GXxj2G73byshAFtbVg9+oxs37rjEZlfPOH44ejSE8xBR5+wvCFsFGRYDQK8H2Y
         8c0MyFV63Zn9EZ0acrNn6hGS9nMsth6PtAJzXrdPfh6GItbkc/12+2dtLVreenpPt0Mp
         NnQGcRgD4zvf0RRaIgYMzU2mrftJqewg/pTf9+0Sh2eCXTLreM0iZWO0HTb9o0BWvxuk
         sA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ifr2udJQaykytNB8WSuWQEM/D/tWuwVDxhVVtYTxuG8=;
        b=OJaZAY0Lk7dzpXiVlexGXKQQCLYUlXk/duQS4rvVJ4bSLiij4r2x/NRjKT8MaOkK8L
         4fmB49caea5APHWixzj82HmhNelbkhHVP3QJ9SpsR0YMLX81YN3Oe0BmnDGeeRbGwj/q
         J3bIDPE+8Ix0lupqMRQn4jilxWFPHePSERJEGD/h888Dh0srNVwg6J8B2o/cO0Jbg3kQ
         H9K1jfMc6Uuvxrmd1UmK3XaI4IobzYi9EJVcwX5tJ/656BHaOln31C3mTtVUA0sPA/xW
         9M7ukdtyQL//UMrOxbnD1tVqoqi30rEK99J8M3SazrE2N6NInhdOpVTbIsz4ObClIX92
         /M0g==
X-Gm-Message-State: ACrzQf2W5E9S7lPU490O4PbYJ48ESZQ4wsBb817Y3EgphcuktQLvj1do
        7hFxOZShOiyn9io3InYCmQE=
X-Google-Smtp-Source: AMsMyM50IGdCSOamunZKGC5uD89LokM+MpbjYBTKKc038M5wHgwEvNmfkzJyGeY/kDyRtuqZEaO/vA==
X-Received: by 2002:a17:906:4917:b0:7ad:f9d6:9435 with SMTP id b23-20020a170906491700b007adf9d69435mr2270312ejq.238.1667339654824;
        Tue, 01 Nov 2022 14:54:14 -0700 (PDT)
Received: from ZBook.localdomain (86-90-194-80.fixed.kpn.net. [86.90.194.80])
        by smtp.gmail.com with ESMTPSA id cq11-20020a056402220b00b00458478a4295sm692684edb.9.2022.11.01.14.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:54:14 -0700 (PDT)
From:   Jerom van der Sar <jerom.vandersar@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jerom van der Sar <jerom.vandersar@gmail.com>
Subject: [PATCH v2] staging: rtl8192e: space formatting fixes in rtl_cam.c
Date:   Tue,  1 Nov 2022 22:52:47 +0100
Message-Id: <20221101215246.4442-1-jerom.vandersar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7d001a49-4e45-fda2-15fe-b05f2c340eaa@gmail.com>
References: <7d001a49-4e45-fda2-15fe-b05f2c340eaa@gmail.com>
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

Fixed a few coding style issues in rtl_cam.c such as double blank lines
and lack of spaces around binary operators. Some other warnings still
remain. These issues were found by scripts/checkpatch.pl.

This patch helps clean up the rtl8192e driver in staging, making it
easier to read and maintain.

Signed-off-by: Jerom van der Sar <jerom.vandersar@gmail.com>.
---
Changes in v2:
  - Reverted some formatting fixes to make the diff easier to review.

 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index 41faeb4b9b9b..d5aaf24a0ddb 100644
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
@@ -104,10 +103,9 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 	else
 		usConfig |= BIT15 | (KeyType<<2) | KeyIndex;
 
-
 	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
 		TargetCommand  = i + CAM_CONTENT_COUNT * EntryNo;
-		TargetCommand |= BIT31|BIT16;
+		TargetCommand |= BIT31 | BIT16;
 
 		if (i == 0) {
 			TargetContent = (u32)(*(MacAddr+0)) << 16 |
@@ -152,7 +150,6 @@ void rtl92e_cam_restore(struct net_device *dev)
 
 	if ((priv->rtllib->pairwise_key_type == KEY_TYPE_WEP40) ||
 	    (priv->rtllib->pairwise_key_type == KEY_TYPE_WEP104)) {
-
 		for (EntryId = 0; EntryId < 4; EntryId++) {
 			MacAddr = CAM_CONST_ADDR[EntryId];
 			if (priv->rtllib->swcamtable[EntryId].bused) {
-- 
2.34.1

