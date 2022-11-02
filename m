Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A585616E38
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKBUDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiKBUD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:03:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EA4BF8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:03:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b2so13742eja.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDnrSW+2135+Xqb7eTyI0FY4hstVp+d9eOCLWyHr250=;
        b=gCvOUF5kPz358SzEWhcIlHuAGTOF/oPvE9is9fj0H1d5LVVPLp+tJcHtlKKYGafmm5
         kKPmZSM6PCXwG4zAF5fh2naeS5xI4vbk+9vBEfV2fqu0RMFXtL4UL7fOTMDCijqoraOQ
         NGpG5OjEIHg1j3ma9noCF4Q8qROcR8JLSmH5Rgh6hE4vipunr8aS2bVfPR0cPBLJIZjH
         3b8wsxTJwYrIaBLWqvFwlv4J0hF1m3PCuwkmGhYg/LM1qU2sPm1aKRECFkTNDgzwCF9n
         XKEB50M3PWfXe8HFnJevp0nBSGgvN1ykspoF3TAUZXt1/8kHmke4UVB58mOu7FQOYb4/
         EbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDnrSW+2135+Xqb7eTyI0FY4hstVp+d9eOCLWyHr250=;
        b=29EKiSU12Qj3R7OFOPUxsedoD5jtfrSwlzRQRVwwG3IB0M1wg/AsWL/fadPnVSxxNA
         Ayue0Bt2rgwtggLOLwArUGCwiGReXUxeZ+6oVW86wgyS6Eb7OUZ0Ded+jCSL5G1qPmTx
         2R20MDyR/m5dHbaG4AZN//f87MmXI85mh1XdxNkyWnZukRIjklDy/M0usWYVhfCrJIK1
         hBOpuk3HgaQeYMp/4+dT4K7oWEOgamD44qOA/A/Hg7FiMADMQIMZ9QvI7xdBPn3w+CuP
         2bGeQHs1VsJwupFmrLCgv9vz8RWAif+kUU6RWBaJ2t1zvJR/z+GPGFjLXZFst7ND99mI
         eoIw==
X-Gm-Message-State: ACrzQf3DHDDKuWSY1nTpl/BiHjpcWSEKF9fUBDhU8Ia+fNdC8NUwHy5w
        pH1GBof+U2bTVfrQcLw5d64=
X-Google-Smtp-Source: AMsMyM4mrW5FGAdWh0XXYf6GbrwWeEVYGtq6S+ZebIemMpHR0alzU5UP+UBv46vWVo3qw/K7+NJuUA==
X-Received: by 2002:a17:906:8a57:b0:7ad:69fb:3a with SMTP id gx23-20020a1709068a5700b007ad69fb003amr25232087ejc.179.1667419406921;
        Wed, 02 Nov 2022 13:03:26 -0700 (PDT)
Received: from ZBook.localdomain (86-90-194-80.fixed.kpn.net. [86.90.194.80])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b0079e552fd860sm5752239ejm.152.2022.11.02.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:03:26 -0700 (PDT)
From:   Jerom van der Sar <jerom.vandersar@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jerom van der Sar <jerom.vandersar@gmail.com>
Subject: [PATCH v4] staging: rtl8192e: space formatting fixes in rtl_cam.c
Date:   Wed,  2 Nov 2022 21:00:58 +0100
Message-Id: <20221102200057.397-1-jerom.vandersar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y2IbI8ib5+k+bVRo@kroah.com>
References: <Y2IbI8ib5+k+bVRo@kroah.com>
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

Fixed a few coding style issues in rtl_cam.c: two times lack of
spaces around binary operators. Some other warnings still remain.
These issues were found by scripts/checkpatch.pl.

This patch helps clean up the rtl8192e driver in staging, making it
easier to read and maintain.

Signed-off-by: Jerom van der Sar <jerom.vandersar@gmail.com>
---
Changes in v4:
 - Reverted more double blank line formatting fixes to make the patch
   even smaller.

Changes in v3:
  - Fixed faulty dot at the end of the patch sign-off.

Changes in v2:
  - Reverted some formatting fixes to make the diff easier to review.

 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index 41faeb4b9b9b..41bff46d1b3a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -17,7 +17,7 @@ void rtl92e_cam_reset(struct net_device *dev)
 {
 	u32 ulcommand = 0;
 
-	ulcommand |= BIT31|BIT30;
+	ulcommand |= BIT31 | BIT30;
 	rtl92e_writel(dev, RWCAM, ulcommand);
 }
 
@@ -107,7 +107,7 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 
 	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
 		TargetCommand  = i + CAM_CONTENT_COUNT * EntryNo;
-		TargetCommand |= BIT31|BIT16;
+		TargetCommand |= BIT31 | BIT16;
 
 		if (i == 0) {
 			TargetContent = (u32)(*(MacAddr+0)) << 16 |
-- 
2.34.1

