Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6066154F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKAW3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiKAW3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:29:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355421D319
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:29:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id t25so40758623ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G74Wuy6JUbEZeguR9z8D5PigaA7SQEA2iQsub/0ykr4=;
        b=Wh/schGSPH2trCP5hnARhLA/9Na4tDKwK5YAadg5v8IoqogJ7WV1qKrcaEVjDOhax6
         mZ3rNlzr8APzJ28E6BJLyK3LglC94wCYp62W2KuWi6EhiJJE4ywYUex5rEGfP4LiKlyk
         Kn/esG2/3Pv7EVyy2+mnvTBF+F2V4nKAKklHu0GLrHAl6e9PqyVm6M/Jhp4vJZmXvaX6
         EsG6P8+V8W4HCgUgPeFa8+VMBIR+Ba48SzZrsGTRLhB295bEo+vLk7EkdWUaN+QnSafs
         zbTmtzklEQ2RrsI2lNEqQD74g1w9N8h0IBdU2Jsw726yz/T4S3plQmNOEVbmD/JRttHz
         n1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G74Wuy6JUbEZeguR9z8D5PigaA7SQEA2iQsub/0ykr4=;
        b=SkaSUnthnh9RXn54BRmDjNfDAo8r2otjzKmSZtGf/JdMWb/Uok0tUQNJNshNe2dACy
         sIqs1r4wF3fx7mB6M9yZzhf04BxXrnOexHeGTQdDCuBDXtNgaKOJu306l5YIGC/Ie7N6
         +r5NiJxTjFWu4OFs8i4CLjrzYq1u0M/aV6PNRrPliI71t65cnbfFEJVw1Mb9jkMfuepK
         +DPG32Ni0REOu768jcjlVmtwYcB37fcrpXBXcEXVU9uvOTYxam8WpqpetJXe0AvqJdU1
         woSXA1spBclCumOWubzSDqsIA6B+tIFPIbhB5NmCJrLBjOQ5qMRnINXVpjCbPpbukWD/
         pfRA==
X-Gm-Message-State: ACrzQf1gshglr6nmORCEe35G6va69/P4FM05dkZDE00rRSkUP8IWocWp
        XTwsS05aDhyfqkemS4wFasA=
X-Google-Smtp-Source: AMsMyM4f8eMxJOLzvij00f87n2slJuioPe1icpzbqIX3dgqUzFUi38de5v2xR40Tzb4RnYudA6Ek7g==
X-Received: by 2002:a17:906:8477:b0:7ad:9ada:a6a4 with SMTP id hx23-20020a170906847700b007ad9adaa6a4mr20744760ejc.674.1667341770785;
        Tue, 01 Nov 2022 15:29:30 -0700 (PDT)
Received: from ZBook.localdomain (86-90-194-80.fixed.kpn.net. [86.90.194.80])
        by smtp.gmail.com with ESMTPSA id f15-20020a17090631cf00b007a03313a78esm4650773ejf.20.2022.11.01.15.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:29:30 -0700 (PDT)
From:   Jerom van der Sar <jerom.vandersar@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jerom van der Sar <jerom.vandersar@gmail.com>
Subject: [PATCH v3] staging: rtl8192e: space formatting fixes in rtl_cam.c
Date:   Tue,  1 Nov 2022 23:29:00 +0100
Message-Id: <20221101222900.4681-1-jerom.vandersar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f391a7cd-e57a-0643-1ba1-c859bf2f83a6@gmail.com>
References: <f391a7cd-e57a-0643-1ba1-c859bf2f83a6@gmail.com>
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
and lack of spaces around binary operators.Some other warnings still
remain. These issues were found by scripts/checkpatch.pl.

This patch helps clean up the rtl8192e driver in staging, making it
easier to read and maintain.

Signed-off-by: Jerom van der Sar <jerom.vandersar@gmail.com>
---
Changes in v3:
  - Fixed faulty dot at the end of the patch sign-off.

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

