Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC1660D800
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiJYXhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiJYXho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:37:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD12FBCEF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g12so14793003lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXPNjur9hX3brkcnEBIrqKBooU3Q3eUrz/4SzAXBpVA=;
        b=jzl5YR81A7lYG73Lf+1XMTb9CoEJEJPlwnkeCDFtkp+RHRHEdxQPxse1+hFdP8aiBg
         XzzMFi7VIzEJE6Xlc7+0pfm6HjDJkCW8qWW/cSrVWUrEyFdrFjpJxnqAOW/jmL931n38
         jBpRezQxT80yh9/PQhFaxjJrkp1HIcwV2dvrqDHGSS/2mkCz05I/yKszlAxJkYNSQdCv
         kABXCygbrACSUxeIyKlhhfrdc+sxqiNzrCgsJAOT4uhfMM/kt6/WgCm4Bed8HmSNVibG
         UnlfhUSmv4rAo+BF83Kk6YlyQ0AZjjtC5smmxBiLxmFIkpLLBv724IKBCrTHOWkFRssQ
         8W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXPNjur9hX3brkcnEBIrqKBooU3Q3eUrz/4SzAXBpVA=;
        b=jvV/XVR90Tn+fOd4LsuSUMULjU+Egrw4FRkK25/qRppiOSjLLrOlmw0kxO8kiQ3EaA
         o7tOa7xgJRuMB85ickCcf1cVTvdZoW9XNEGI1/8knJtWDfTsKUt5DNSYkOPJZQq90nPW
         iIgIGieKatKNCZ0aqM3pCHRP7qW10Vndnw0Gs+Lx/euyXIqE3TjukFvpSLDOnnCUD90T
         e799y5sqZ2IzHtLtwM0PjLOi+6Y/sRmBGOjSH1Cpv3Qyzn23zfUkUVm6N781PSoXSQPo
         ZBtzhTy5u7VNbSP8qbphCVwZYPGBZMifY+6GaWzRZmJFhYeAagEzjS7NZ5uT3OIvTmpu
         ZDAA==
X-Gm-Message-State: ACrzQf2F4qpswNKXnKmOG9cA4DgDPAb9haroGdEGvm/ek1cCO/Pz5YU7
        xntavLh3Yu3m0lUegSX0zz0=
X-Google-Smtp-Source: AMsMyM7Pe031fV6dLsDcFE0Y71MlktJu3nQOGADKKYnctZQOfUBTA4Qf79fVkJ1h1EUx8GGiTuV08w==
X-Received: by 2002:a05:6512:34d4:b0:4a4:20da:7538 with SMTP id w20-20020a05651234d400b004a420da7538mr16228447lfr.371.1666741061836;
        Tue, 25 Oct 2022 16:37:41 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:37:41 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 01/17] staging: vt6655: changed variable names: wFB_Opt0
Date:   Tue, 25 Oct 2022 23:36:57 +0000
Message-Id: <62f69eddc9641ac9eb045edf8a9453bf36a02b36.1666740522.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666740522.git.tanjubrunostar0@gmail.com>
References: <cover.1666740522.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change variable names wFB_Opt0 and wFB_Opt1 to meet the
linux coding standard, as it says to avoid using camelCase naming style.
Cought by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index d585435520b3..ac9b3402be4f 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -59,12 +59,12 @@ static const unsigned short wTimeStampOff[2][MAX_RATE] = {
 	{384, 192, 130, 113, 54, 43, 37, 31, 28, 25, 24, 23}, /* Short Preamble */
 };
 
-static const unsigned short wFB_Opt0[2][5] = {
+static const unsigned short w_fb_opt_0[2][5] = {
 	{RATE_12M, RATE_18M, RATE_24M, RATE_36M, RATE_48M}, /* fallback_rate0 */
 	{RATE_12M, RATE_12M, RATE_18M, RATE_24M, RATE_36M}, /* fallback_rate1 */
 };
 
-static const unsigned short wFB_Opt1[2][5] = {
+static const unsigned short w_fb_opt_1[2][5] = {
 	{RATE_12M, RATE_18M, RATE_24M, RATE_24M, RATE_36M}, /* fallback_rate0 */
 	{RATE_6M,  RATE_6M,  RATE_12M, RATE_12M, RATE_18M}, /* fallback_rate1 */
 };
@@ -299,9 +299,9 @@ static unsigned int s_uGetDataDuration(struct vnt_private *pDevice,
 			wRate -= RATE_18M;
 
 			if (byFBOption == AUTO_FB_0)
-				wRate = wFB_Opt0[FB_RATE0][wRate];
+				wRate = w_fb_opt_0[FB_RATE0][wRate];
 			else
-				wRate = wFB_Opt1[FB_RATE0][wRate];
+				wRate = w_fb_opt_1[FB_RATE0][wRate];
 
 			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType,
 						       len, wRate, bNeedAck);
@@ -360,11 +360,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *pDevice,
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
 				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
-						wFB_Opt0[FB_RATE0][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
 				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
-						wFB_Opt1[FB_RATE0][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], bNeedAck);
 
 		break;
 
@@ -374,11 +374,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *pDevice,
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
 				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
-						wFB_Opt0[FB_RATE0][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
 				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
-						wFB_Opt1[FB_RATE0][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], bNeedAck);
 
 		break;
 
@@ -388,11 +388,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *pDevice,
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
 				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
-						wFB_Opt0[FB_RATE1][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
 				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
-						wFB_Opt1[FB_RATE1][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], bNeedAck);
 
 		break;
 
@@ -402,11 +402,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *pDevice,
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
 				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
-						wFB_Opt0[FB_RATE1][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
 				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
-						wFB_Opt1[FB_RATE1][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], bNeedAck);
 
 		break;
 
@@ -414,11 +414,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *pDevice,
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = pDevice->uSIFS +
 				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
-						wFB_Opt0[FB_RATE0][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = pDevice->uSIFS +
 				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
-						wFB_Opt1[FB_RATE0][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], bNeedAck);
 
 		break;
 
@@ -426,11 +426,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *pDevice,
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = pDevice->uSIFS +
 				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
-						wFB_Opt0[FB_RATE1][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = pDevice->uSIFS +
 				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
-						wFB_Opt1[FB_RATE1][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], bNeedAck);
 
 		break;
 
-- 
2.34.1

