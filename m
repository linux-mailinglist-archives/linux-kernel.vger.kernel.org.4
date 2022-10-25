Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8591D60D802
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiJYXhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiJYXhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:37:50 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA80FBCE2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id j14so19404246ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0LhEiNv/k5Hpq27rSC3zc2EE2gi/gZz8EVFap4u7Eg=;
        b=G1Sk9Va7pINmcPV06Ec2PWyBhCpSuw8RimaDz3KNGinY6HUjGMfGYLmcH/8ZCOshY7
         0fdT55wEDFDjNDFpyDGDEbQhk5aj4dkZWZHBYcN6Hd7X6fvUF95TW+w9X1kZ4MG/Dq0d
         ux5xEeTQLpoNuM7Lax0gfxd/tA4YGz6T1x8qOUK0c4oW4SaYg2oOLk+wfFKT7GkREUV4
         //+ysrSX6jRxpzUn1LYTTsXQ29O7Js+E7s/xrRxS8158yeuaHaM7vpYrxLRTtLJ6wzk3
         fiiZIWcVRAa7x9Gucit5T0PKZ20rz56wbwpsLPPvEHxpp7p7t+PBw1vj3NT8S0Nxe3h3
         xHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0LhEiNv/k5Hpq27rSC3zc2EE2gi/gZz8EVFap4u7Eg=;
        b=5kQTDSL56YBHTD8cFML0T3ptV9eqYmtELQN4RPqG+zh5w2E4TziRciS9yUBee1vAtG
         36wai9ZDqKLxMj/cEzdvXvRNrelB/J/O68o5T9h7Aw3Q330w5UJ21+CXB95BJOqsKE0v
         XkFnt9lTgiVyNqDtsjy60K3mEy72KJK5S4vwk2rp4NzHPDLrtJV39rauTTN1TVmvyDzl
         WbNlqEjoVeAM6a1eoV9ThrrAIDIAHBAZBwUj9KCo5HpC2GkGnvYOu4d/3X4GTMyzWvZv
         ffNz2HJreZLvYQbnN7Eq+UFbFOijP89iO3ZPapvTRi4DkNw/phTEVZzjo8Lf3o3MKKzv
         Diow==
X-Gm-Message-State: ACrzQf30yNxHadC/HfKMNLNBxWJaCM4dN5PecVJ5rQLYylrgf3pnaDsd
        T8IvAVehhAEyocboNaQPo3k=
X-Google-Smtp-Source: AMsMyM4P3P32wMJWQOuKMQBH8qv5YS6tsvUmudTzHLRTPWJxXI5b+abToRDPZP0wCMaUJPHDzd1Mjg==
X-Received: by 2002:a2e:92c4:0:b0:25d:9d30:5d61 with SMTP id k4-20020a2e92c4000000b0025d9d305d61mr16117924ljh.202.1666741065436;
        Tue, 25 Oct 2022 16:37:45 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:37:45 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 03/17] staging: vt6655: changed variable name: pDevice
Date:   Tue, 25 Oct 2022 23:36:59 +0000
Message-Id: <1f09760c8f6972b0e2b272060424b60a11166a0d.1666740522.git.tanjubrunostar0@gmail.com>
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

    change variable names pDevice to meet the
    linux coding standard, as it says to avoid using camelCase naming
    style. Cought by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 354 +++++++++++++++++-----------------
 1 file changed, 177 insertions(+), 177 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 8bb06b142748..3565f5608790 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -85,7 +85,7 @@ static const unsigned short w_fb_opt_1[2][5] = {
 #define DATADUR_A_F1    13
 
 /*---------------------  Static Functions  --------------------------*/
-static void s_v_fill_rts_head(struct vnt_private *pDevice,
+static void s_v_fill_rts_head(struct vnt_private *p_device,
 			      unsigned char byPktType,
 			      void *pvRTS,
 			      unsigned int	cbFrameLength,
@@ -95,7 +95,7 @@ static void s_v_fill_rts_head(struct vnt_private *pDevice,
 			      unsigned short wCurrentRate,
 			      unsigned char byFBOption);
 
-static void s_vGenerateTxParameter(struct vnt_private *pDevice,
+static void s_vGenerateTxParameter(struct vnt_private *p_device,
 				   unsigned char byPktType,
 				   struct vnt_tx_fifo_head *,
 				   void *pvRrvTime,
@@ -108,12 +108,12 @@ static void s_vGenerateTxParameter(struct vnt_private *pDevice,
 				   unsigned short wCurrentRate);
 
 static unsigned int
-s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
+s_cbFillTxBufHead(struct vnt_private *p_device, unsigned char byPktType,
 		  unsigned char *pbyTxBufferAddr,
 		  unsigned int uDMAIdx, struct vnt_tx_desc *pHeadTD,
 		  unsigned int uNodeIndex);
 
-static __le16 s_uFillDataHead(struct vnt_private *pDevice,
+static __le16 s_uFillDataHead(struct vnt_private *p_device,
 			      unsigned char byPktType,
 			      void *pTxDataHead,
 			      unsigned int cbFrameLength,
@@ -139,7 +139,7 @@ static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
  * PK_TYPE_11GB    2
  * PK_TYPE_11GA    3
  */
-static unsigned int s_uGetTxRsvTime(struct vnt_private *pDevice,
+static unsigned int s_uGetTxRsvTime(struct vnt_private *p_device,
 				    unsigned char byPktType,
 				    unsigned int cbFrameLength,
 				    unsigned short wRate,
@@ -147,7 +147,7 @@ static unsigned int s_uGetTxRsvTime(struct vnt_private *pDevice,
 {
 	unsigned int uDataTime, uAckTime;
 
-	uDataTime = bb_get_frame_time(pDevice->preamble_type, byPktType, cbFrameLength, wRate);
+	uDataTime = bb_get_frame_time(p_device->preamble_type, byPktType, cbFrameLength, wRate);
 
 	if (!bNeedAck)
 		return uDataTime;
@@ -156,12 +156,12 @@ static unsigned int s_uGetTxRsvTime(struct vnt_private *pDevice,
 	 * CCK mode  - 11b
 	 * OFDM mode - 11g 2.4G & 11a 5G
 	 */
-	uAckTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
+	uAckTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
 				     byPktType == PK_TYPE_11B ?
-				     pDevice->byTopCCKBasicRate :
-				     pDevice->byTopOFDMBasicRate);
+				     p_device->byTopCCKBasicRate :
+				     p_device->byTopOFDMBasicRate);
 
-	return uDataTime + pDevice->uSIFS + uAckTime;
+	return uDataTime + p_device->uSIFS + uAckTime;
 }
 
 static __le16 vnt_rxtx_rsvtime_le16(struct vnt_private *priv, u8 pkt_type,
@@ -219,7 +219,7 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
 }
 
 /* byFreqType 0: 5GHz, 1:2.4Ghz */
-static unsigned int s_uGetDataDuration(struct vnt_private *pDevice,
+static unsigned int s_uGetDataDuration(struct vnt_private *p_device,
 				       unsigned char byDurType,
 				       unsigned int cbFrameLength,
 				       unsigned char byPktType,
@@ -244,9 +244,9 @@ static unsigned int s_uGetDataDuration(struct vnt_private *pDevice,
 	switch (byDurType) {
 	case DATADUR_B:    /* DATADUR_B */
 		if (bNeedAck) {
-			uAckTime = bb_get_frame_time(pDevice->preamble_type,
+			uAckTime = bb_get_frame_time(p_device->preamble_type,
 						     byPktType, 14,
-						     pDevice->byTopCCKBasicRate);
+						     p_device->byTopCCKBasicRate);
 		}
 		/* Non Frag or Last Frag */
 		if ((uMACfragNum == 1) || bLastFrag) {
@@ -254,17 +254,17 @@ static unsigned int s_uGetDataDuration(struct vnt_private *pDevice,
 				return 0;
 		} else {
 			/* First Frag or Mid Frag */
-			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType,
+			uNextPktTime = s_uGetTxRsvTime(p_device, byPktType,
 						       len, wRate, bNeedAck);
 		}
 
-		return pDevice->uSIFS + uAckTime + uNextPktTime;
+		return p_device->uSIFS + uAckTime + uNextPktTime;
 
 	case DATADUR_A:    /* DATADUR_A */
 		if (bNeedAck) {
-			uAckTime = bb_get_frame_time(pDevice->preamble_type,
+			uAckTime = bb_get_frame_time(p_device->preamble_type,
 						     byPktType, 14,
-						     pDevice->byTopOFDMBasicRate);
+						     p_device->byTopOFDMBasicRate);
 		}
 		/* Non Frag or Last Frag */
 		if ((uMACfragNum == 1) || bLastFrag) {
@@ -272,18 +272,18 @@ static unsigned int s_uGetDataDuration(struct vnt_private *pDevice,
 				return 0;
 		} else {
 			/* First Frag or Mid Frag */
-			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType,
+			uNextPktTime = s_uGetTxRsvTime(p_device, byPktType,
 						       len, wRate, bNeedAck);
 		}
 
-		return pDevice->uSIFS + uAckTime + uNextPktTime;
+		return p_device->uSIFS + uAckTime + uNextPktTime;
 
 	case DATADUR_A_F0:    /* DATADUR_A_F0 */
 	case DATADUR_A_F1:    /* DATADUR_A_F1 */
 		if (bNeedAck) {
-			uAckTime = bb_get_frame_time(pDevice->preamble_type,
+			uAckTime = bb_get_frame_time(p_device->preamble_type,
 						     byPktType, 14,
-						     pDevice->byTopOFDMBasicRate);
+						     p_device->byTopOFDMBasicRate);
 		}
 		/* Non Frag or Last Frag */
 		if ((uMACfragNum == 1) || bLastFrag) {
@@ -303,11 +303,11 @@ static unsigned int s_uGetDataDuration(struct vnt_private *pDevice,
 			else
 				wRate = w_fb_opt_1[FB_RATE0][wRate];
 
-			uNextPktTime = s_uGetTxRsvTime(pDevice, byPktType,
+			uNextPktTime = s_uGetTxRsvTime(p_device, byPktType,
 						       len, wRate, bNeedAck);
 		}
 
-		return pDevice->uSIFS + uAckTime + uNextPktTime;
+		return p_device->uSIFS + uAckTime + uNextPktTime;
 
 	default:
 		break;
@@ -317,7 +317,7 @@ static unsigned int s_uGetDataDuration(struct vnt_private *pDevice,
 }
 
 /* byFreqType: 0=>5GHZ 1=>2.4GHZ */
-static __le16 s_uGetRTSCTSDuration(struct vnt_private *pDevice,
+static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 				   unsigned char byDurType,
 				   unsigned int cbFrameLength,
 				   unsigned char byPktType,
@@ -329,107 +329,107 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *pDevice,
 
 	switch (byDurType) {
 	case RTSDUR_BB:    /* RTSDuration_bb */
-		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
-					     pDevice->byTopCCKBasicRate);
-		uDurTime = uCTSTime + 2 * pDevice->uSIFS +
-			s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
+		uCTSTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
+					     p_device->byTopCCKBasicRate);
+		uDurTime = uCTSTime + 2 * p_device->uSIFS +
+			s_uGetTxRsvTime(p_device, byPktType, cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case RTSDUR_BA:    /* RTSDuration_ba */
-		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
-					     pDevice->byTopCCKBasicRate);
-		uDurTime = uCTSTime + 2 * pDevice->uSIFS +
-			s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
+		uCTSTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
+					     p_device->byTopCCKBasicRate);
+		uDurTime = uCTSTime + 2 * p_device->uSIFS +
+			s_uGetTxRsvTime(p_device, byPktType, cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case RTSDUR_AA:    /* RTSDuration_aa */
-		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
-					     pDevice->byTopOFDMBasicRate);
-		uDurTime = uCTSTime + 2 * pDevice->uSIFS +
-			s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
+		uCTSTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
+					     p_device->byTopOFDMBasicRate);
+		uDurTime = uCTSTime + 2 * p_device->uSIFS +
+			s_uGetTxRsvTime(p_device, byPktType, cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case CTSDUR_BA:    /* CTSDuration_ba */
-		uDurTime = pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType,
+		uDurTime = p_device->uSIFS + s_uGetTxRsvTime(p_device, byPktType,
 							    cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case RTSDUR_BA_F0: /* RTSDuration_ba_f0 */
-		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
-					     pDevice->byTopCCKBasicRate);
+		uCTSTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
+					     p_device->byTopCCKBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
-				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+			uDurTime = uCTSTime + 2 * p_device->uSIFS +
+				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
 						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
-				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+			uDurTime = uCTSTime + 2 * p_device->uSIFS +
+				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
 						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], bNeedAck);
 
 		break;
 
 	case RTSDUR_AA_F0: /* RTSDuration_aa_f0 */
-		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
-					     pDevice->byTopOFDMBasicRate);
+		uCTSTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
+					     p_device->byTopOFDMBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
-				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+			uDurTime = uCTSTime + 2 * p_device->uSIFS +
+				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
 						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
-				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+			uDurTime = uCTSTime + 2 * p_device->uSIFS +
+				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
 						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], bNeedAck);
 
 		break;
 
 	case RTSDUR_BA_F1: /* RTSDuration_ba_f1 */
-		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
-					     pDevice->byTopCCKBasicRate);
+		uCTSTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
+					     p_device->byTopCCKBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
-				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+			uDurTime = uCTSTime + 2 * p_device->uSIFS +
+				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
 						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
-				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+			uDurTime = uCTSTime + 2 * p_device->uSIFS +
+				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
 						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], bNeedAck);
 
 		break;
 
 	case RTSDUR_AA_F1: /* RTSDuration_aa_f1 */
-		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
-					     pDevice->byTopOFDMBasicRate);
+		uCTSTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
+					     p_device->byTopOFDMBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
-				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+			uDurTime = uCTSTime + 2 * p_device->uSIFS +
+				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
 						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
-				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+			uDurTime = uCTSTime + 2 * p_device->uSIFS +
+				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
 						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], bNeedAck);
 
 		break;
 
 	case CTSDUR_BA_F0: /* CTSDuration_ba_f0 */
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = pDevice->uSIFS +
-				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+			uDurTime = p_device->uSIFS +
+				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
 						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = pDevice->uSIFS +
-				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+			uDurTime = p_device->uSIFS +
+				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
 						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], bNeedAck);
 
 		break;
 
 	case CTSDUR_BA_F1: /* CTSDuration_ba_f1 */
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = pDevice->uSIFS +
-				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+			uDurTime = p_device->uSIFS +
+				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
 						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = pDevice->uSIFS +
-				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+			uDurTime = p_device->uSIFS +
+				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
 						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], bNeedAck);
 
 		break;
@@ -441,7 +441,7 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *pDevice,
 	return cpu_to_le16((u16)uDurTime);
 }
 
-static __le16 s_uFillDataHead(struct vnt_private *pDevice,
+static __le16 s_uFillDataHead(struct vnt_private *p_device,
 			      unsigned char byPktType,
 			      void *pTxDataHead,
 			      unsigned int cbFrameLength,
@@ -466,22 +466,22 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 		if (byFBOption == AUTO_FB_NONE) {
 			struct vnt_tx_datahead_g *buf = pTxDataHead;
 			/* Get SignalField, ServiceField & Length */
-			vnt_get_phy_field(pDevice, cbFrameLength, wCurrentRate,
+			vnt_get_phy_field(p_device, cbFrameLength, wCurrentRate,
 					  byPktType, &buf->a);
 
-			vnt_get_phy_field(pDevice, cbFrameLength,
-					  pDevice->byTopCCKBasicRate,
+			vnt_get_phy_field(p_device, cbFrameLength,
+					  p_device->byTopCCKBasicRate,
 					  PK_TYPE_11B, &buf->b);
 
 			if (is_pspoll) {
-				__le16 dur = cpu_to_le16(pDevice->current_aid | BIT(14) | BIT(15));
+				__le16 dur = cpu_to_le16(p_device->current_aid | BIT(14) | BIT(15));
 
 				buf->duration_a = dur;
 				buf->duration_b = dur;
 			} else {
 				/* Get Duration and TimeStamp */
 				buf->duration_a =
-					cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
+					cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A,
 									    cbFrameLength,
 									    byPktType,
 									    wCurrentRate, bNeedAck,
@@ -490,57 +490,57 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 									    uMACfragNum,
 									    byFBOption));
 				buf->duration_b =
-					cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B,
+					cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_B,
 									    cbFrameLength,
 									    PK_TYPE_11B,
-									    pDevice->byTopCCKBasicRate,
+									    p_device->byTopCCKBasicRate,
 									    bNeedAck, uFragIdx,
 									    cbLastFragmentSize,
 									    uMACfragNum,
 									    byFBOption));
 			}
 
-			buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
-			buf->time_stamp_off_b = vnt_time_stamp_off(pDevice,
-								   pDevice->byTopCCKBasicRate);
+			buf->time_stamp_off_a = vnt_time_stamp_off(p_device, wCurrentRate);
+			buf->time_stamp_off_b = vnt_time_stamp_off(p_device,
+								   p_device->byTopCCKBasicRate);
 
 			return buf->duration_a;
 		}
 
 		/* Get SignalField, ServiceField & Length */
-		vnt_get_phy_field(pDevice, cbFrameLength, wCurrentRate,
+		vnt_get_phy_field(p_device, cbFrameLength, wCurrentRate,
 				  byPktType, &buf->a);
 
-		vnt_get_phy_field(pDevice, cbFrameLength,
-				  pDevice->byTopCCKBasicRate,
+		vnt_get_phy_field(p_device, cbFrameLength,
+				  p_device->byTopCCKBasicRate,
 				  PK_TYPE_11B, &buf->b);
 		/* Get Duration and TimeStamp */
-		buf->duration_a = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
+		buf->duration_a = cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A,
 								      cbFrameLength, byPktType,
 								      wCurrentRate, bNeedAck,
 								      uFragIdx, cbLastFragmentSize,
 								      uMACfragNum, byFBOption));
-		buf->duration_b = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B,
+		buf->duration_b = cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_B,
 								      cbFrameLength, PK_TYPE_11B,
-								      pDevice->byTopCCKBasicRate,
+								      p_device->byTopCCKBasicRate,
 								      bNeedAck, uFragIdx,
 								      cbLastFragmentSize,
 								      uMACfragNum, byFBOption));
-		buf->duration_a_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0,
+		buf->duration_a_f0 = cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F0,
 									 cbFrameLength, byPktType,
 									 wCurrentRate, bNeedAck,
 									 uFragIdx,
 									 cbLastFragmentSize,
 									 uMACfragNum, byFBOption));
-		buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1,
+		buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F1,
 									 cbFrameLength, byPktType,
 									 wCurrentRate, bNeedAck,
 									 uFragIdx,
 									 cbLastFragmentSize,
 									 uMACfragNum, byFBOption));
 
-		buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
-		buf->time_stamp_off_b = vnt_time_stamp_off(pDevice, pDevice->byTopCCKBasicRate);
+		buf->time_stamp_off_a = vnt_time_stamp_off(p_device, wCurrentRate);
+		buf->time_stamp_off_b = vnt_time_stamp_off(p_device, p_device->byTopCCKBasicRate);
 
 		return buf->duration_a;
 		  /* if (byFBOption == AUTO_FB_NONE) */
@@ -551,76 +551,76 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 			/* Auto Fallback */
 			struct vnt_tx_datahead_a_fb *buf = pTxDataHead;
 			/* Get SignalField, ServiceField & Length */
-			vnt_get_phy_field(pDevice, cbFrameLength, wCurrentRate,
+			vnt_get_phy_field(p_device, cbFrameLength, wCurrentRate,
 					  byPktType, &buf->a);
 
 			/* Get Duration and TimeStampOff */
 			buf->duration =
-				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
+				cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A,
 								    cbFrameLength, byPktType,
 								    wCurrentRate, bNeedAck,
 								    uFragIdx, cbLastFragmentSize,
 								    uMACfragNum, byFBOption));
 			buf->duration_f0 =
-				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0,
+				cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F0,
 								    cbFrameLength, byPktType,
 								    wCurrentRate, bNeedAck,
 								    uFragIdx, cbLastFragmentSize,
 								    uMACfragNum, byFBOption));
 			buf->duration_f1 =
-				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1,
+				cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F1,
 								    cbFrameLength, byPktType,
 								    wCurrentRate, bNeedAck,
 								    uFragIdx, cbLastFragmentSize,
 								    uMACfragNum, byFBOption));
-			buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
+			buf->time_stamp_off = vnt_time_stamp_off(p_device, wCurrentRate);
 			return buf->duration;
 		}
 
 		/* Get SignalField, ServiceField & Length */
-		vnt_get_phy_field(pDevice, cbFrameLength, wCurrentRate,
+		vnt_get_phy_field(p_device, cbFrameLength, wCurrentRate,
 				  byPktType, &buf->ab);
 
 		if (is_pspoll) {
-			__le16 dur = cpu_to_le16(pDevice->current_aid | BIT(14) | BIT(15));
+			__le16 dur = cpu_to_le16(p_device->current_aid | BIT(14) | BIT(15));
 
 			buf->duration = dur;
 		} else {
 			/* Get Duration and TimeStampOff */
 			buf->duration =
-				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
+				cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A,
 								    cbFrameLength, byPktType,
 								    wCurrentRate, bNeedAck,
 								    uFragIdx, cbLastFragmentSize,
 								    uMACfragNum, byFBOption));
 		}
 
-		buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
+		buf->time_stamp_off = vnt_time_stamp_off(p_device, wCurrentRate);
 		return buf->duration;
 	}
 
 	/* Get SignalField, ServiceField & Length */
-	vnt_get_phy_field(pDevice, cbFrameLength, wCurrentRate,
+	vnt_get_phy_field(p_device, cbFrameLength, wCurrentRate,
 			  byPktType, &buf->ab);
 
 	if (is_pspoll) {
-		__le16 dur = cpu_to_le16(pDevice->current_aid | BIT(14) | BIT(15));
+		__le16 dur = cpu_to_le16(p_device->current_aid | BIT(14) | BIT(15));
 
 		buf->duration = dur;
 	} else {
 		/* Get Duration and TimeStampOff */
 		buf->duration =
-			cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength,
+			cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_B, cbFrameLength,
 							    byPktType, wCurrentRate, bNeedAck,
 							    uFragIdx, cbLastFragmentSize,
 							    uMACfragNum, byFBOption));
 	}
 
-	buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
+	buf->time_stamp_off = vnt_time_stamp_off(p_device, wCurrentRate);
 	return buf->duration;
 }
 
-static void s_v_fill_rts_head(struct vnt_private *pDevice,
+static void s_v_fill_rts_head(struct vnt_private *p_device,
 			      unsigned char byPktType,
 			      void *pvRTS,
 			      unsigned int cbFrameLength,
@@ -650,26 +650,26 @@ static void s_v_fill_rts_head(struct vnt_private *pDevice,
 		if (byFBOption == AUTO_FB_NONE) {
 			struct vnt_rts_g *buf = pvRTS;
 			/* Get SignalField, ServiceField & Length */
-			vnt_get_phy_field(pDevice, uRTSFrameLen,
-					  pDevice->byTopCCKBasicRate,
+			vnt_get_phy_field(p_device, uRTSFrameLen,
+					  p_device->byTopCCKBasicRate,
 					  PK_TYPE_11B, &buf->b);
 
-			vnt_get_phy_field(pDevice, uRTSFrameLen,
-					  pDevice->byTopOFDMBasicRate,
+			vnt_get_phy_field(p_device, uRTSFrameLen,
+					  p_device->byTopOFDMBasicRate,
 					  byPktType, &buf->a);
 			/* Get Duration */
 			buf->duration_bb =
-				s_uGetRTSCTSDuration(pDevice, RTSDUR_BB,
+				s_uGetRTSCTSDuration(p_device, RTSDUR_BB,
 						     cbFrameLength, PK_TYPE_11B,
-						     pDevice->byTopCCKBasicRate,
+						     p_device->byTopCCKBasicRate,
 						     bNeedAck, byFBOption);
 			buf->duration_aa =
-				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA,
+				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->duration_ba =
-				s_uGetRTSCTSDuration(pDevice, RTSDUR_BA,
+				s_uGetRTSCTSDuration(p_device, RTSDUR_BA,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
@@ -685,46 +685,46 @@ static void s_v_fill_rts_head(struct vnt_private *pDevice,
 		} else {
 			struct vnt_rts_g_fb *buf = pvRTS;
 			/* Get SignalField, ServiceField & Length */
-			vnt_get_phy_field(pDevice, uRTSFrameLen,
-					  pDevice->byTopCCKBasicRate,
+			vnt_get_phy_field(p_device, uRTSFrameLen,
+					  p_device->byTopCCKBasicRate,
 					  PK_TYPE_11B, &buf->b);
 
-			vnt_get_phy_field(pDevice, uRTSFrameLen,
-					  pDevice->byTopOFDMBasicRate,
+			vnt_get_phy_field(p_device, uRTSFrameLen,
+					  p_device->byTopOFDMBasicRate,
 					  byPktType, &buf->a);
 			/* Get Duration */
 			buf->duration_bb =
-				s_uGetRTSCTSDuration(pDevice, RTSDUR_BB,
+				s_uGetRTSCTSDuration(p_device, RTSDUR_BB,
 						     cbFrameLength, PK_TYPE_11B,
-						     pDevice->byTopCCKBasicRate,
+						     p_device->byTopCCKBasicRate,
 						     bNeedAck, byFBOption);
 			buf->duration_aa =
-				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA,
+				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->duration_ba =
-				s_uGetRTSCTSDuration(pDevice, RTSDUR_BA,
+				s_uGetRTSCTSDuration(p_device, RTSDUR_BA,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->rts_duration_ba_f0 =
-				s_uGetRTSCTSDuration(pDevice, RTSDUR_BA_F0,
+				s_uGetRTSCTSDuration(p_device, RTSDUR_BA_F0,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->rts_duration_aa_f0 =
-				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA_F0,
+				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F0,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->rts_duration_ba_f1 =
-				s_uGetRTSCTSDuration(pDevice, RTSDUR_BA_F1,
+				s_uGetRTSCTSDuration(p_device, RTSDUR_BA_F1,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->rts_duration_aa_f1 =
-				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA_F1,
+				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F1,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
@@ -741,12 +741,12 @@ static void s_v_fill_rts_head(struct vnt_private *pDevice,
 		if (byFBOption == AUTO_FB_NONE) {
 			struct vnt_rts_ab *buf = pvRTS;
 			/* Get SignalField, ServiceField & Length */
-			vnt_get_phy_field(pDevice, uRTSFrameLen,
-					  pDevice->byTopOFDMBasicRate,
+			vnt_get_phy_field(p_device, uRTSFrameLen,
+					  p_device->byTopOFDMBasicRate,
 					  byPktType, &buf->ab);
 			/* Get Duration */
 			buf->duration =
-				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA,
+				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
@@ -761,22 +761,22 @@ static void s_v_fill_rts_head(struct vnt_private *pDevice,
 		} else {
 			struct vnt_rts_a_fb *buf = pvRTS;
 			/* Get SignalField, ServiceField & Length */
-			vnt_get_phy_field(pDevice, uRTSFrameLen,
-					  pDevice->byTopOFDMBasicRate,
+			vnt_get_phy_field(p_device, uRTSFrameLen,
+					  p_device->byTopOFDMBasicRate,
 					  byPktType, &buf->a);
 			/* Get Duration */
 			buf->duration =
-				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA,
+				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->rts_duration_f0 =
-				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA_F0,
+				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F0,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->rts_duration_f1 =
-				s_uGetRTSCTSDuration(pDevice, RTSDUR_AA_F1,
+				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F1,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
@@ -792,12 +792,12 @@ static void s_v_fill_rts_head(struct vnt_private *pDevice,
 	} else if (byPktType == PK_TYPE_11B) {
 		struct vnt_rts_ab *buf = pvRTS;
 		/* Get SignalField, ServiceField & Length */
-		vnt_get_phy_field(pDevice, uRTSFrameLen,
-				  pDevice->byTopCCKBasicRate,
+		vnt_get_phy_field(p_device, uRTSFrameLen,
+				  p_device->byTopCCKBasicRate,
 				  PK_TYPE_11B, &buf->ab);
 		/* Get Duration */
 		buf->duration =
-			s_uGetRTSCTSDuration(pDevice, RTSDUR_BB, cbFrameLength,
+			s_uGetRTSCTSDuration(p_device, RTSDUR_BB, cbFrameLength,
 					     byPktType, wCurrentRate, bNeedAck,
 					     byFBOption);
 
@@ -811,7 +811,7 @@ static void s_v_fill_rts_head(struct vnt_private *pDevice,
 	}
 }
 
-static void s_vFillCTSHead(struct vnt_private *pDevice,
+static void s_vFillCTSHead(struct vnt_private *p_device,
 			   unsigned int uDMAIdx,
 			   unsigned char byPktType,
 			   void *pvCTS,
@@ -840,26 +840,26 @@ static void s_vFillCTSHead(struct vnt_private *pDevice,
 			/* Auto Fall back */
 			struct vnt_cts_fb *buf = pvCTS;
 			/* Get SignalField, ServiceField & Length */
-			vnt_get_phy_field(pDevice, uCTSFrameLen,
-					  pDevice->byTopCCKBasicRate,
+			vnt_get_phy_field(p_device, uCTSFrameLen,
+					  p_device->byTopCCKBasicRate,
 					  PK_TYPE_11B, &buf->b);
 
 			buf->duration_ba =
-				s_uGetRTSCTSDuration(pDevice, CTSDUR_BA,
+				s_uGetRTSCTSDuration(p_device, CTSDUR_BA,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 
 			/* Get CTSDuration_ba_f0 */
 			buf->cts_duration_ba_f0 =
-				s_uGetRTSCTSDuration(pDevice, CTSDUR_BA_F0,
+				s_uGetRTSCTSDuration(p_device, CTSDUR_BA_F0,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 
 			/* Get CTSDuration_ba_f1 */
 			buf->cts_duration_ba_f1 =
-				s_uGetRTSCTSDuration(pDevice, CTSDUR_BA_F1,
+				s_uGetRTSCTSDuration(p_device, CTSDUR_BA_F1,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
@@ -874,7 +874,7 @@ static void s_vFillCTSHead(struct vnt_private *pDevice,
 			buf->reserved2 = 0x0;
 
 			ether_addr_copy(buf->data.ra,
-					pDevice->abyCurrentNetAddr);
+					p_device->abyCurrentNetAddr);
 		} else {
 			/* if (byFBOption != AUTO_FB_NONE &&
 			 * uDMAIdx != TYPE_ATIMDMA &&
@@ -882,13 +882,13 @@ static void s_vFillCTSHead(struct vnt_private *pDevice,
 			 */
 			struct vnt_cts *buf = pvCTS;
 			/* Get SignalField, ServiceField & Length */
-			vnt_get_phy_field(pDevice, uCTSFrameLen,
-					  pDevice->byTopCCKBasicRate,
+			vnt_get_phy_field(p_device, uCTSFrameLen,
+					  p_device->byTopCCKBasicRate,
 					  PK_TYPE_11B, &buf->b);
 
 			/* Get CTSDuration_ba */
 			buf->duration_ba =
-				s_uGetRTSCTSDuration(pDevice, CTSDUR_BA,
+				s_uGetRTSCTSDuration(p_device, CTSDUR_BA,
 						     cbFrameLength, byPktType,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
@@ -902,7 +902,7 @@ static void s_vFillCTSHead(struct vnt_private *pDevice,
 
 			buf->reserved2 = 0x0;
 			ether_addr_copy(buf->data.ra,
-					pDevice->abyCurrentNetAddr);
+					p_device->abyCurrentNetAddr);
 		}
 	}
 }
@@ -914,7 +914,7 @@ static void s_vFillCTSHead(struct vnt_private *pDevice,
  *
  * Parameters:
  *  In:
- *      pDevice         - Pointer to adapter
+ *      p_device         - Pointer to adapter
  *      pTxDataHead     - Transmit Data Buffer
  *      pTxBufHead      - pTxBufHead
  *      pvRrvTime        - pvRrvTime
@@ -931,7 +931,7 @@ static void s_vFillCTSHead(struct vnt_private *pDevice,
  -
  * unsigned int cbFrameSize, Hdr+Payload+FCS
  */
-static void s_vGenerateTxParameter(struct vnt_private *pDevice,
+static void s_vGenerateTxParameter(struct vnt_private *p_device,
 				   unsigned char byPktType,
 				   struct vnt_tx_fifo_head *tx_buffer_head,
 				   void *pvRrvTime,
@@ -965,75 +965,75 @@ static void s_vGenerateTxParameter(struct vnt_private *pDevice,
 			/* Fill RsvTime */
 			struct vnt_rrv_time_rts *buf = pvRrvTime;
 
-			buf->rts_rrv_time_aa = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize,
+			buf->rts_rrv_time_aa = get_rtscts_time(p_device, 2, byPktType, cbFrameSize,
 							       wCurrentRate);
-			buf->rts_rrv_time_ba = get_rtscts_time(pDevice, 1, byPktType, cbFrameSize,
+			buf->rts_rrv_time_ba = get_rtscts_time(p_device, 1, byPktType, cbFrameSize,
 							       wCurrentRate);
-			buf->rts_rrv_time_bb = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize,
+			buf->rts_rrv_time_bb = get_rtscts_time(p_device, 0, byPktType, cbFrameSize,
 							       wCurrentRate);
-			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
+			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(p_device, byPktType, cbFrameSize,
 								wCurrentRate, bNeedACK);
-			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
-								pDevice->byTopCCKBasicRate,
+			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cbFrameSize,
+								p_device->byTopCCKBasicRate,
 								bNeedACK);
 
-			s_v_fill_rts_head(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
-					  psEthHeader, wCurrentRate, byFBOption);
+			s_v_fill_rts_head(p_device, byPktType, pvRTS, cbFrameSize, bNeedACK,
+					  bDisCRC, psEthHeader, wCurrentRate, byFBOption);
 		} else {/* RTS_needless, PCF mode */
 			struct vnt_rrv_time_cts *buf = pvRrvTime;
 
-			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
+			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(p_device, byPktType, cbFrameSize,
 								wCurrentRate, bNeedACK);
-			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
-								pDevice->byTopCCKBasicRate,
+			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cbFrameSize,
+								p_device->byTopCCKBasicRate,
 								bNeedACK);
-			buf->cts_rrv_time_ba = get_rtscts_time(pDevice, 3, byPktType, cbFrameSize,
+			buf->cts_rrv_time_ba = get_rtscts_time(p_device, 3, byPktType, cbFrameSize,
 							       wCurrentRate);
 
 			/* Fill CTS */
-			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK,
+			s_vFillCTSHead(p_device, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK,
 				       bDisCRC, wCurrentRate, byFBOption);
 		}
 	} else if (byPktType == PK_TYPE_11A) {
 		if (pvRTS) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rts_rrv_time = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize,
+			buf->rts_rrv_time = get_rtscts_time(p_device, 2, byPktType, cbFrameSize,
 							    wCurrentRate);
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, byPktType, cbFrameSize,
 							      wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_v_fill_rts_head(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
-					  psEthHeader, wCurrentRate, byFBOption);
+			s_v_fill_rts_head(p_device, byPktType, pvRTS, cbFrameSize, bNeedACK,
+					  bDisCRC, psEthHeader, wCurrentRate, byFBOption);
 		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A, cbFrameSize,
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11A, cbFrameSize,
 							      wCurrentRate, bNeedACK);
 		}
 	} else if (byPktType == PK_TYPE_11B) {
 		if (pvRTS) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rts_rrv_time = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize,
+			buf->rts_rrv_time = get_rtscts_time(p_device, 0, byPktType, cbFrameSize,
 							    wCurrentRate);
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cbFrameSize,
 							      wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_v_fill_rts_head(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
-					  psEthHeader, wCurrentRate, byFBOption);
+			s_v_fill_rts_head(p_device, byPktType, pvRTS, cbFrameSize, bNeedACK,
+					  bDisCRC, psEthHeader, wCurrentRate, byFBOption);
 		} else { /* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cbFrameSize,
 							      wCurrentRate, bNeedACK);
 		}
 	}
 }
 
-static unsigned int s_cbFillTxBufHead(struct vnt_private *pDevice,
+static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 				      unsigned char byPktType,
 				      unsigned char *pbyTxBufferAddr,
 				      unsigned int uDMAIdx,
@@ -1080,7 +1080,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *pDevice,
 
 		cbFrameSize += info->control.hw_key->icv_len;
 
-		if (pDevice->local_id > REV_ID_VT3253_A1) {
+		if (p_device->local_id > REV_ID_VT3253_A1) {
 			/* MAC Header should be padding 0 to DW alignment. */
 			uPadding = 4 - (ieee80211_get_hdrlen_from_skb(skb) % 4);
 			uPadding %= 4;
@@ -1218,11 +1218,11 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *pDevice,
 	memset((void *)(pbyTxBufferAddr + wTxBufSize), 0, (cbHeaderLength - wTxBufSize));
 
 	/* Fill FIFO,RrvTime,RTS,and CTS */
-	s_vGenerateTxParameter(pDevice, byPktType, tx_buffer_head, pvRrvTime, pvRTS, pvCTS,
-			       cbFrameSize, bNeedACK, uDMAIdx, hdr, pDevice->wCurrentRate);
+	s_vGenerateTxParameter(p_device, byPktType, tx_buffer_head, pvRrvTime, pvRTS, pvCTS,
+			       cbFrameSize, bNeedACK, uDMAIdx, hdr, p_device->wCurrentRate);
 	/* Fill DataHead */
-	uDuration = s_uFillDataHead(pDevice, byPktType, pvTxDataHd, cbFrameSize, uDMAIdx, bNeedACK,
-				    0, 0, uMACfragNum, byFBOption, pDevice->wCurrentRate,
+	uDuration = s_uFillDataHead(p_device, byPktType, pvTxDataHd, cbFrameSize, uDMAIdx, bNeedACK,
+				    0, 0, uMACfragNum, byFBOption, p_device->wCurrentRate,
 				    is_pspoll);
 
 	hdr->duration_id = uDuration;
-- 
2.34.1

