Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107A460D807
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiJYXiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiJYXiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:38:03 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9447DFC1FA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:54 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u11so7434038ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PdLirpLV6lpEban/gZoe78yVzKjxuzACUa6QXtdzHw=;
        b=F5kYhw4rLKn+wqfXUM9pf+I8wfBQO8SBWO2tV7cNOVc3pnYZh+d1prXQJAeDXB5M+z
         ivpRXsrN2bED857w7QDPzxmcksXIVKvuiQbHR+j6197iTY/qiCR7KeGIGzw/tTKUuahD
         Tf9NzBjDLHXScK6CsITFK/1ABPLgrVvd34MkMR4F83qp//OK/hDRQD4ENsgGaPMh5UpW
         VbEplDnaSKkTn2EqnaCd7FoRBzwJYko1+qTIUBlubcWjFTPaWl4Bqpm8BD2QlLcFtjIh
         1YwlI9/J8qKNcnTydaLBBaA1EcC2MIkEdbCPx7VjSgwMDEqGsGP/8sR6XR5Sq8GbluLI
         2Yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PdLirpLV6lpEban/gZoe78yVzKjxuzACUa6QXtdzHw=;
        b=Bsg8cy5ZCjOpidrlNU6XGfpdEd+rT89fkdBtxcNcgQFMo6ByL1fgiAG9M1NWEygXy8
         0C7CjoHHCKe9V4vdiYDOGxm0Tow3ww0pzAUZ6N7uTIoY2jE9y4D+gp5aFrW7lS0YHH1p
         9KraELx2CIeLxbLY2i6jJGIT6bA3TaI1e+gNiLEaG/Z05Rc7IOlhYwGnV5+rvd4WMkJJ
         Rr8SgdHHy8Kf8moLU0D1kDdDUW7kSkHsMDGK9K01lMC2bk14etK7WQsX5nEBKdtioOHA
         jO7kIrpmju67BYD8G/CMMH3tG5wyaQLwp9pG1GbJTJPIvfcG3pzpmL48j+x4AqY3VN1s
         24Ow==
X-Gm-Message-State: ACrzQf3q+LhtPzpho+CaRlT6o14FB7IR2DAPG9mO0VzaTKr6zV3+88Ub
        MDhBaE/C0/uChwuHOm+ycXmdJzIixeoQ8w==
X-Google-Smtp-Source: AMsMyM5dEKSRQKf5DrOfygOKx1BNR0qrr3KwdJrNNiZIPbd6T4z1GwwcHBQpP4Sy+pM3a1GajKkC5w==
X-Received: by 2002:a2e:a490:0:b0:277:e5b:ec07 with SMTP id h16-20020a2ea490000000b002770e5bec07mr4600417lji.371.1666741072756;
        Tue, 25 Oct 2022 16:37:52 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:37:52 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 07/17] staging: vt6655: changed variable name: b_need_ack
Date:   Tue, 25 Oct 2022 23:37:03 +0000
Message-Id: <3990f2dbe4cf931092a113e3eeb79b9917861cb5.1666740522.git.tanjubrunostar0@gmail.com>
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
 drivers/staging/vt6655/rxtx.c | 129 +++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 699ca2685052..1949a647a443 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -89,7 +89,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			      unsigned char by_pkt_type,
 			      void *pv_rts,
 			      unsigned int	cb_frame_length,
-			      bool bNeedAck,
+			      bool b_need_ack,
 			      bool bDisCRC,
 			      struct ieee80211_hdr *hdr,
 			      unsigned short wCurrentRate,
@@ -118,7 +118,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 			      void *pTxDataHead,
 			      unsigned int cb_frame_length,
 			      unsigned int uDMAIdx,
-			      bool bNeedAck,
+			      bool b_need_ack,
 			      unsigned int uFragIdx,
 			      unsigned int cbLastFragmentSize,
 			      unsigned int uMACfragNum,
@@ -143,13 +143,13 @@ static unsigned int s_uGetTxRsvTime(struct vnt_private *p_device,
 				    unsigned char by_pkt_type,
 				    unsigned int cb_frame_length,
 				    unsigned short wRate,
-				    bool bNeedAck)
+				    bool b_need_ack)
 {
 	unsigned int uDataTime, uAckTime;
 
 	uDataTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, cb_frame_length, wRate);
 
-	if (!bNeedAck)
+	if (!b_need_ack)
 		return uDataTime;
 
 	/*
@@ -224,7 +224,7 @@ static unsigned int s_uGetDataDuration(struct vnt_private *p_device,
 				       unsigned int cb_frame_length,
 				       unsigned char by_pkt_type,
 				       unsigned short wRate,
-				       bool bNeedAck,
+				       bool b_need_ack,
 				       unsigned int uFragIdx,
 				       unsigned int cbLastFragmentSize,
 				       unsigned int uMACfragNum,
@@ -243,51 +243,51 @@ static unsigned int s_uGetDataDuration(struct vnt_private *p_device,
 
 	switch (byDurType) {
 	case DATADUR_B:    /* DATADUR_B */
-		if (bNeedAck) {
+		if (b_need_ack) {
 			uAckTime = bb_get_frame_time(p_device->preamble_type,
 						     by_pkt_type, 14,
 						     p_device->byTopCCKBasicRate);
 		}
 		/* Non Frag or Last Frag */
 		if ((uMACfragNum == 1) || bLastFrag) {
-			if (!bNeedAck)
+			if (!b_need_ack)
 				return 0;
 		} else {
 			/* First Frag or Mid Frag */
 			uNextPktTime = s_uGetTxRsvTime(p_device, by_pkt_type,
-						       len, wRate, bNeedAck);
+						       len, wRate, b_need_ack);
 		}
 
 		return p_device->uSIFS + uAckTime + uNextPktTime;
 
 	case DATADUR_A:    /* DATADUR_A */
-		if (bNeedAck) {
+		if (b_need_ack) {
 			uAckTime = bb_get_frame_time(p_device->preamble_type,
 						     by_pkt_type, 14,
 						     p_device->byTopOFDMBasicRate);
 		}
 		/* Non Frag or Last Frag */
 		if ((uMACfragNum == 1) || bLastFrag) {
-			if (!bNeedAck)
+			if (!b_need_ack)
 				return 0;
 		} else {
 			/* First Frag or Mid Frag */
 			uNextPktTime = s_uGetTxRsvTime(p_device, by_pkt_type,
-						       len, wRate, bNeedAck);
+						       len, wRate, b_need_ack);
 		}
 
 		return p_device->uSIFS + uAckTime + uNextPktTime;
 
 	case DATADUR_A_F0:    /* DATADUR_A_F0 */
 	case DATADUR_A_F1:    /* DATADUR_A_F1 */
-		if (bNeedAck) {
+		if (b_need_ack) {
 			uAckTime = bb_get_frame_time(p_device->preamble_type,
 						     by_pkt_type, 14,
 						     p_device->byTopOFDMBasicRate);
 		}
 		/* Non Frag or Last Frag */
 		if ((uMACfragNum == 1) || bLastFrag) {
-			if (!bNeedAck)
+			if (!b_need_ack)
 				return 0;
 		} else {
 			/* First Frag or Mid Frag */
@@ -304,7 +304,7 @@ static unsigned int s_uGetDataDuration(struct vnt_private *p_device,
 				wRate = w_fb_opt_1[FB_RATE0][wRate];
 
 			uNextPktTime = s_uGetTxRsvTime(p_device, by_pkt_type,
-						       len, wRate, bNeedAck);
+						       len, wRate, b_need_ack);
 		}
 
 		return p_device->uSIFS + uAckTime + uNextPktTime;
@@ -322,7 +322,7 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 				   unsigned int cb_frame_length,
 				   unsigned char by_pkt_type,
 				   unsigned short wRate,
-				   bool bNeedAck,
+				   bool b_need_ack,
 				   unsigned char byFBOption)
 {
 	unsigned int uCTSTime = 0, uDurTime = 0;
@@ -332,26 +332,26 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 		uCTSTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
 					     p_device->byTopCCKBasicRate);
 		uDurTime = uCTSTime + 2 * p_device->uSIFS +
-			s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length, wRate, bNeedAck);
+			s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length, wRate, b_need_ack);
 		break;
 
 	case RTSDUR_BA:    /* RTSDuration_ba */
 		uCTSTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
 					     p_device->byTopCCKBasicRate);
 		uDurTime = uCTSTime + 2 * p_device->uSIFS +
-			s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length, wRate, bNeedAck);
+			s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length, wRate, b_need_ack);
 		break;
 
 	case RTSDUR_AA:    /* RTSDuration_aa */
 		uCTSTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
 					     p_device->byTopOFDMBasicRate);
 		uDurTime = uCTSTime + 2 * p_device->uSIFS +
-			s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length, wRate, bNeedAck);
+			s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length, wRate, b_need_ack);
 		break;
 
 	case CTSDUR_BA:    /* CTSDuration_ba */
 		uDurTime = p_device->uSIFS + s_uGetTxRsvTime(p_device, by_pkt_type,
-							    cb_frame_length, wRate, bNeedAck);
+							    cb_frame_length, wRate, b_need_ack);
 		break;
 
 	case RTSDUR_BA_F0: /* RTSDuration_ba_f0 */
@@ -360,11 +360,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
-						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], b_need_ack);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
-						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], b_need_ack);
 
 		break;
 
@@ -374,11 +374,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
-						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], b_need_ack);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
-						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], b_need_ack);
 
 		break;
 
@@ -388,11 +388,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
-						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], b_need_ack);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
-						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], b_need_ack);
 
 		break;
 
@@ -402,11 +402,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
-						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], b_need_ack);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
-						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], b_need_ack);
 
 		break;
 
@@ -414,11 +414,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
-						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], b_need_ack);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
-						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], b_need_ack);
 
 		break;
 
@@ -426,11 +426,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
-						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], b_need_ack);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
-						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], bNeedAck);
+						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], b_need_ack);
 
 		break;
 
@@ -446,7 +446,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 			      void *pTxDataHead,
 			      unsigned int cb_frame_length,
 			      unsigned int uDMAIdx,
-			      bool bNeedAck,
+			      bool b_need_ack,
 			      unsigned int uFragIdx,
 			      unsigned int cbLastFragmentSize,
 			      unsigned int uMACfragNum,
@@ -484,7 +484,8 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 					cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A,
 									    cb_frame_length,
 									    by_pkt_type,
-									    wCurrentRate, bNeedAck,
+									    wCurrentRate,
+									    b_need_ack,
 									    uFragIdx,
 									    cbLastFragmentSize,
 									    uMACfragNum,
@@ -494,7 +495,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 									    cb_frame_length,
 									    PK_TYPE_11B,
 									    p_device->byTopCCKBasicRate,
-									    bNeedAck, uFragIdx,
+									    b_need_ack, uFragIdx,
 									    cbLastFragmentSize,
 									    uMACfragNum,
 									    byFBOption));
@@ -517,26 +518,26 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 		/* Get Duration and TimeStamp */
 		buf->duration_a = cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A,
 								      cb_frame_length, by_pkt_type,
-								      wCurrentRate, bNeedAck,
+								      wCurrentRate, b_need_ack,
 								      uFragIdx, cbLastFragmentSize,
 								      uMACfragNum, byFBOption));
 		buf->duration_b = cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_B,
 								      cb_frame_length, PK_TYPE_11B,
 								      p_device->byTopCCKBasicRate,
-								      bNeedAck, uFragIdx,
+								      b_need_ack, uFragIdx,
 								      cbLastFragmentSize,
 								      uMACfragNum, byFBOption));
 		buf->duration_a_f0 = cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F0,
 									 cb_frame_length,
 									 by_pkt_type,
-									 wCurrentRate, bNeedAck,
+									 wCurrentRate, b_need_ack,
 									 uFragIdx,
 									 cbLastFragmentSize,
 									 uMACfragNum, byFBOption));
 		buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F1,
 									 cb_frame_length,
 									 by_pkt_type,
-									 wCurrentRate, bNeedAck,
+									 wCurrentRate, b_need_ack,
 									 uFragIdx,
 									 cbLastFragmentSize,
 									 uMACfragNum, byFBOption));
@@ -560,19 +561,19 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 			buf->duration =
 				cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A,
 								    cb_frame_length, by_pkt_type,
-								    wCurrentRate, bNeedAck,
+								    wCurrentRate, b_need_ack,
 								    uFragIdx, cbLastFragmentSize,
 								    uMACfragNum, byFBOption));
 			buf->duration_f0 =
 				cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F0,
 								    cb_frame_length, by_pkt_type,
-								    wCurrentRate, bNeedAck,
+								    wCurrentRate, b_need_ack,
 								    uFragIdx, cbLastFragmentSize,
 								    uMACfragNum, byFBOption));
 			buf->duration_f1 =
 				cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F1,
 								    cb_frame_length, by_pkt_type,
-								    wCurrentRate, bNeedAck,
+								    wCurrentRate, b_need_ack,
 								    uFragIdx, cbLastFragmentSize,
 								    uMACfragNum, byFBOption));
 			buf->time_stamp_off = vnt_time_stamp_off(p_device, wCurrentRate);
@@ -592,7 +593,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 			buf->duration =
 				cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A,
 								    cb_frame_length, by_pkt_type,
-								    wCurrentRate, bNeedAck,
+								    wCurrentRate, b_need_ack,
 								    uFragIdx, cbLastFragmentSize,
 								    uMACfragNum, byFBOption));
 		}
@@ -613,7 +614,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 		/* Get Duration and TimeStampOff */
 		buf->duration =
 			cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_B, cb_frame_length,
-							    by_pkt_type, wCurrentRate, bNeedAck,
+							    by_pkt_type, wCurrentRate, b_need_ack,
 							    uFragIdx, cbLastFragmentSize,
 							    uMACfragNum, byFBOption));
 	}
@@ -626,7 +627,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			      unsigned char by_pkt_type,
 			      void *pv_rts,
 			      unsigned int cb_frame_length,
-			      bool bNeedAck,
+			      bool b_need_ack,
 			      bool bDisCRC,
 			      struct ieee80211_hdr *hdr,
 			      unsigned short wCurrentRate,
@@ -664,16 +665,16 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BB,
 						     cb_frame_length, PK_TYPE_11B,
 						     p_device->byTopCCKBasicRate,
-						     bNeedAck, byFBOption);
+						     b_need_ack, byFBOption);
 			buf->duration_aa =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 			buf->duration_ba =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BA,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 
 			buf->data.duration = buf->duration_aa;
@@ -699,36 +700,36 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BB,
 						     cb_frame_length, PK_TYPE_11B,
 						     p_device->byTopCCKBasicRate,
-						     bNeedAck, byFBOption);
+						     b_need_ack, byFBOption);
 			buf->duration_aa =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 			buf->duration_ba =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BA,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 			buf->rts_duration_ba_f0 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BA_F0,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 			buf->rts_duration_aa_f0 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F0,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 			buf->rts_duration_ba_f1 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BA_F1,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 			buf->rts_duration_aa_f1 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F1,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 			buf->data.duration = buf->duration_aa;
 			/* Get RTS Frame body */
@@ -750,7 +751,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			buf->duration =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 			buf->data.duration = buf->duration;
 			/* Get RTS Frame body */
@@ -770,17 +771,17 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			buf->duration =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 			buf->rts_duration_f0 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F0,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 			buf->rts_duration_f1 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F1,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 			buf->data.duration = buf->duration;
 			/* Get RTS Frame body */
@@ -800,7 +801,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 		/* Get Duration */
 		buf->duration =
 			s_uGetRTSCTSDuration(p_device, RTSDUR_BB, cb_frame_length,
-					     by_pkt_type, wCurrentRate, bNeedAck,
+					     by_pkt_type, wCurrentRate, b_need_ack,
 					     byFBOption);
 
 		buf->data.duration = buf->duration;
@@ -818,7 +819,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 			   unsigned char by_pkt_type,
 			   void *pvCTS,
 			   unsigned int cb_frame_length,
-			   bool bNeedAck,
+			   bool b_need_ack,
 			   bool bDisCRC,
 			   unsigned short wCurrentRate,
 			   unsigned char byFBOption)
@@ -849,21 +850,21 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 			buf->duration_ba =
 				s_uGetRTSCTSDuration(p_device, CTSDUR_BA,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 
 			/* Get CTSDuration_ba_f0 */
 			buf->cts_duration_ba_f0 =
 				s_uGetRTSCTSDuration(p_device, CTSDUR_BA_F0,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 
 			/* Get CTSDuration_ba_f1 */
 			buf->cts_duration_ba_f1 =
 				s_uGetRTSCTSDuration(p_device, CTSDUR_BA_F1,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 
 			/* Get CTS Frame body */
@@ -892,7 +893,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 			buf->duration_ba =
 				s_uGetRTSCTSDuration(p_device, CTSDUR_BA,
 						     cb_frame_length, by_pkt_type,
-						     wCurrentRate, bNeedAck,
+						     wCurrentRate, b_need_ack,
 						     byFBOption);
 
 			/* Get CTS Frame body */
-- 
2.34.1

