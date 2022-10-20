Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D116605E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJTK4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJTK4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:56:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F8B1DF42F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:56:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p8so6683588lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tEmNh4R0QJOPxLimqEC/Xs1kq2UBfm/vuBxLtj1a2rk=;
        b=FzDOPEbcl6MLFkqFsxogyoko0ePdQin24WYBfDNjGcQIJ8Y+uGJKaxHeCIbKQ8epTL
         is3Kr8df9p/UKPWbCQIpA2JJCZGs5owrfOmU0zXIlqoSQvwxWtcK49S6ghZU/BETxSgE
         xK9i3Hmf2flYAtoy9JkR3o0mTTYiK30gONRIV1FaUhNeS9Jt2ZD3ErCbww23P52W2ZwJ
         VysRHseEJaGUmdOszO+C3G6lK0dLYerwbH3ara1+TNqIcOYdT8oxnDQeqyGMJM7sCqvS
         pvSPEQlMzqIxu2usXj4Z4iyPrRnC0tVuuwStUK3EzM+zZwco3NllNe4EOQs+Yl+YnwII
         S6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEmNh4R0QJOPxLimqEC/Xs1kq2UBfm/vuBxLtj1a2rk=;
        b=3KBZ9RIRi7hbGwUkBLWBP3RvkCtxBwt5Kz9eNfBr++bHIBrFOmKfL51Fce5oVrluhT
         Ec04OYijEB1gc4qPpRKilwJ0yapmun2gpsFxsGrNGCgZKtXDmIkWd07ZRo2ZPL0vYdVV
         /ZUHMm6ebW2k1L36iD4F0NecQmnyJgk3lcE7bLVsfoVUNnbOTngWItBxjnNfkXdIMiux
         JqZQb2Vh3OTsmchLaal71uLD/nHpa6lxzsyEzDgIZzNZK7yB/Pm2vTaUYbWHcStGLjdZ
         54a8UIkL2Sp/AYzFrG8W2YXJgpxRh4m/7RNZDigNiu3BcpWRnnIDjcCkhUqtSM2rBL5f
         J/9w==
X-Gm-Message-State: ACrzQf2hNVHGpzlJN58B7i14kiRHIHUWiUbsj7f3pLE1ulfxS1Dai0ig
        v6XXrVA2oVLOvP4rqtQ6qLsE51oHbipiKkFC
X-Google-Smtp-Source: AMsMyM4NjRYVbyF9c0UBDUWKKZYrkmDQVLMRNszxHlNWlpezD6//ODWPGs5a8o9KnZIyZclvbCcZBA==
X-Received: by 2002:ac2:47fc:0:b0:4a2:4e9a:64f5 with SMTP id b28-20020ac247fc000000b004a24e9a64f5mr4803257lfp.434.1666263394979;
        Thu, 20 Oct 2022 03:56:34 -0700 (PDT)
Received: from elroy-temp-vm ([20.240.130.248])
        by smtp.gmail.com with ESMTPSA id bf38-20020a2eaa26000000b0026fdecfa6ebsm2447081ljb.15.2022.10.20.03.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 03:56:34 -0700 (PDT)
Date:   Thu, 20 Oct 2022 10:56:33 +0000
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     outreachy@lists.linux.dev, greg@kroah.com,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: vt6655: Fix Lines should not end with a '('
Message-ID: <Y1EpYbkrau17uhDI@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code style warnings reported by checkpatch.
Improve the layout of a function header:
Put the first parameter immediately after the '(' and align the other
parameters underneath it.

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>

---
v2: put static and void on the same line and adjusted the indentation as
suggested by Greg KH
---
 drivers/staging/vt6655/rxtx.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 5bdb5176772c..d987f7dff02a 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -85,10 +85,8 @@ static const unsigned short wFB_Opt1[2][5] = {
 #define DATADUR_A_F1    13
 
 /*---------------------  Static Functions  --------------------------*/
-static
-void
-s_vFillRTSHead(
-	struct vnt_private *pDevice,
+static void
+s_vFillRTSHead(struct vnt_private *pDevice,
 	unsigned char byPktType,
 	void *pvRTS,
 	unsigned int	cbFrameLength,
@@ -96,13 +94,10 @@ s_vFillRTSHead(
 	bool bDisCRC,
 	struct ieee80211_hdr *hdr,
 	unsigned short wCurrentRate,
-	unsigned char byFBOption
-);
+	unsigned char byFBOption);
 
-static
-void
-s_vGenerateTxParameter(
-	struct vnt_private *pDevice,
+static void
+s_vGenerateTxParameter(struct vnt_private *pDevice,
 	unsigned char byPktType,
 	struct vnt_tx_fifo_head *,
 	void *pvRrvTime,
@@ -112,8 +107,7 @@ s_vGenerateTxParameter(
 	bool bNeedACK,
 	unsigned int	uDMAIdx,
 	void *psEthHeader,
-	unsigned short wCurrentRate
-);
+	unsigned short wCurrentRate);
 
 static unsigned int
 s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
-- 
2.34.1

