Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04ED60D809
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiJYXij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiJYXiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:38:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4E6FE901
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j16so5707824lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tXQriNIUNQE5KtMY/NQlCVdZ4fNvTwXzlYXOzW4dhc=;
        b=ettj2sD2aHK9+vfsMIHmyHUux1Rhyfj+iM3Aw5R8f7i7opCg9NNmprowG8/Q+h/lIJ
         3VOkslfQQadBPWs63v6Pxq6UoVAgIo1NqJBwtFemPa+7q49IurqtDfgKIb83mFA4hMsB
         E/PqlO8DRCvAeQE7uOpcchdvljlHzvsP6l007OdJuoKtx9AWgzat2gUMnaxP5S2gnFf+
         CrRCN4Hw2nPc7qhBMLJE+Ib/Dgei3chLbMUFi7Sys5wAX+S4l1ADVgEUX93E2/fnNZWe
         1E1aKTc45n4eyG3f3ydgmjVPitaIR444whIhKv+Y7tp1agPpKME77sC+TApUlKEPmiPG
         qcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tXQriNIUNQE5KtMY/NQlCVdZ4fNvTwXzlYXOzW4dhc=;
        b=jzADuxQJQe5meslN4G+dxqtGoyCzsEuJxQpQYp4RkTmE9Na+6U75vzH9AvgIiymM6I
         U9/+hxvmALh75Gk+gZ2dUpvs4KYq+C6vXZsyHMMk6dLyQIryEEQPQuou4ieZiWYh9hZn
         G/tRcSlrPpcFhJnLvqGjvTALniBTb2Ewoq6neha1Gqa9Napt2ffZlgiMhCSH7VjHqB7f
         LkD3c+CXkHa4uIxxdUriQkGMBfLAnHqYzfn2oA7plKzxXvyYNX6ML5Yoc/ljSeJT+wnH
         Zxu0eoikQ2CJMpDQgALK4lf9tvvAwDk1p5pMzYaPfm0kljK54+6Sr0haIEPOpEzVg+tV
         nt1Q==
X-Gm-Message-State: ACrzQf27TFPBG1GKTTmtpM3vi3B0eH3Lq1tTnDVa+RN42MEdXUKQEmKd
        kfqmyX3GayEHDZFX4jnlScAImtGqlhtccw==
X-Google-Smtp-Source: AMsMyM7S4xMS3PRW+xVTY7PuAwa6utl8oN5DRUvLdD3XGJiacmrLuOCkSh52i40Gh5ZlfA2wIIP0vQ==
X-Received: by 2002:ac2:5469:0:b0:4a2:6e4c:35da with SMTP id e9-20020ac25469000000b004a26e4c35damr15941101lfn.191.1666741076273;
        Tue, 25 Oct 2022 16:37:56 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:37:55 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 09/17] staging: vt6655: changed variable name: byFBOption
Date:   Tue, 25 Oct 2022 23:37:05 +0000
Message-Id: <e81e68919371849c962910c8d524eb903582a882.1666740522.git.tanjubrunostar0@gmail.com>
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

change variable names byFBOption to meet the
linux coding standard, as it says to avoid using camelCase naming
style. Cought by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 144 +++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 71 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index cb6d915fe7d0..3d28cbfec618 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -93,7 +93,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			      bool b_dis_crc,
 			      struct ieee80211_hdr *hdr,
 			      unsigned short wCurrentRate,
-			      unsigned char byFBOption);
+			      unsigned char by_fb_option);
 
 static void s_vGenerateTxParameter(struct vnt_private *p_device,
 				   unsigned char by_pkt_type,
@@ -122,7 +122,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 			      unsigned int uFragIdx,
 			      unsigned int cbLastFragmentSize,
 			      unsigned int uMACfragNum,
-			      unsigned char byFBOption,
+			      unsigned char by_fb_option,
 			      unsigned short wCurrentRate,
 			      bool is_pspoll);
 
@@ -228,7 +228,7 @@ static unsigned int s_uGetDataDuration(struct vnt_private *p_device,
 				       unsigned int uFragIdx,
 				       unsigned int cbLastFragmentSize,
 				       unsigned int uMACfragNum,
-				       unsigned char byFBOption)
+				       unsigned char by_fb_option)
 {
 	bool bLastFrag = false;
 	unsigned int uAckTime = 0, uNextPktTime = 0, len;
@@ -298,7 +298,7 @@ static unsigned int s_uGetDataDuration(struct vnt_private *p_device,
 
 			wRate -= RATE_18M;
 
-			if (byFBOption == AUTO_FB_0)
+			if (by_fb_option == AUTO_FB_0)
 				wRate = w_fb_opt_0[FB_RATE0][wRate];
 			else
 				wRate = w_fb_opt_1[FB_RATE0][wRate];
@@ -323,7 +323,7 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 				   unsigned char by_pkt_type,
 				   unsigned short wRate,
 				   bool b_need_ack,
-				   unsigned char byFBOption)
+				   unsigned char by_fb_option)
 {
 	unsigned int uCTSTime = 0, uDurTime = 0;
 
@@ -357,11 +357,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 	case RTSDUR_BA_F0: /* RTSDuration_ba_f0 */
 		uCTSTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
 					     p_device->byTopCCKBasicRate);
-		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		if ((by_fb_option == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
 						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], b_need_ack);
-		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		else if ((by_fb_option == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
 						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], b_need_ack);
@@ -371,11 +371,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 	case RTSDUR_AA_F0: /* RTSDuration_aa_f0 */
 		uCTSTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
 					     p_device->byTopOFDMBasicRate);
-		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		if ((by_fb_option == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
 						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], b_need_ack);
-		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		else if ((by_fb_option == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
 						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], b_need_ack);
@@ -385,11 +385,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 	case RTSDUR_BA_F1: /* RTSDuration_ba_f1 */
 		uCTSTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
 					     p_device->byTopCCKBasicRate);
-		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		if ((by_fb_option == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
 						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], b_need_ack);
-		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		else if ((by_fb_option == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
 						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], b_need_ack);
@@ -399,11 +399,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 	case RTSDUR_AA_F1: /* RTSDuration_aa_f1 */
 		uCTSTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
 					     p_device->byTopOFDMBasicRate);
-		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		if ((by_fb_option == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
 						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], b_need_ack);
-		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		else if ((by_fb_option == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
 						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], b_need_ack);
@@ -411,11 +411,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 		break;
 
 	case CTSDUR_BA_F0: /* CTSDuration_ba_f0 */
-		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		if ((by_fb_option == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
 						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], b_need_ack);
-		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		else if ((by_fb_option == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
 						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], b_need_ack);
@@ -423,11 +423,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 		break;
 
 	case CTSDUR_BA_F1: /* CTSDuration_ba_f1 */
-		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		if ((by_fb_option == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
 						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], b_need_ack);
-		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
+		else if ((by_fb_option == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = p_device->uSIFS +
 				s_uGetTxRsvTime(p_device, by_pkt_type, cb_frame_length,
 						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], b_need_ack);
@@ -450,7 +450,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 			      unsigned int uFragIdx,
 			      unsigned int cbLastFragmentSize,
 			      unsigned int uMACfragNum,
-			      unsigned char byFBOption,
+			      unsigned char by_fb_option,
 			      unsigned short wCurrentRate,
 			      bool is_pspoll)
 {
@@ -463,7 +463,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 		/* Auto Fallback */
 		struct vnt_tx_datahead_g_fb *buf = pTxDataHead;
 
-		if (byFBOption == AUTO_FB_NONE) {
+		if (by_fb_option == AUTO_FB_NONE) {
 			struct vnt_tx_datahead_g *buf = pTxDataHead;
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(p_device, cb_frame_length, wCurrentRate,
@@ -489,7 +489,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 									    uFragIdx,
 									    cbLastFragmentSize,
 									    uMACfragNum,
-									    byFBOption));
+									    by_fb_option));
 				buf->duration_b =
 					cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_B,
 									    cb_frame_length,
@@ -498,7 +498,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 									    b_need_ack, uFragIdx,
 									    cbLastFragmentSize,
 									    uMACfragNum,
-									    byFBOption));
+									    by_fb_option));
 			}
 
 			buf->time_stamp_off_a = vnt_time_stamp_off(p_device, wCurrentRate);
@@ -520,37 +520,39 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 								      cb_frame_length, by_pkt_type,
 								      wCurrentRate, b_need_ack,
 								      uFragIdx, cbLastFragmentSize,
-								      uMACfragNum, byFBOption));
+								      uMACfragNum, by_fb_option));
 		buf->duration_b = cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_B,
 								      cb_frame_length, PK_TYPE_11B,
 								      p_device->byTopCCKBasicRate,
 								      b_need_ack, uFragIdx,
 								      cbLastFragmentSize,
-								      uMACfragNum, byFBOption));
+								      uMACfragNum, by_fb_option));
 		buf->duration_a_f0 = cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F0,
 									 cb_frame_length,
 									 by_pkt_type,
 									 wCurrentRate, b_need_ack,
 									 uFragIdx,
 									 cbLastFragmentSize,
-									 uMACfragNum, byFBOption));
+									 uMACfragNum,
+									 by_fb_option));
 		buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F1,
 									 cb_frame_length,
 									 by_pkt_type,
 									 wCurrentRate, b_need_ack,
 									 uFragIdx,
 									 cbLastFragmentSize,
-									 uMACfragNum, byFBOption));
+									 uMACfragNum,
+									 by_fb_option));
 
 		buf->time_stamp_off_a = vnt_time_stamp_off(p_device, wCurrentRate);
 		buf->time_stamp_off_b = vnt_time_stamp_off(p_device, p_device->byTopCCKBasicRate);
 
 		return buf->duration_a;
-		  /* if (byFBOption == AUTO_FB_NONE) */
+		  /* if (by_fb_option == AUTO_FB_NONE) */
 	} else if (by_pkt_type == PK_TYPE_11A) {
 		struct vnt_tx_datahead_ab *buf = pTxDataHead;
 
-		if (byFBOption != AUTO_FB_NONE) {
+		if (by_fb_option != AUTO_FB_NONE) {
 			/* Auto Fallback */
 			struct vnt_tx_datahead_a_fb *buf = pTxDataHead;
 			/* Get SignalField, ServiceField & Length */
@@ -563,19 +565,19 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 								    cb_frame_length, by_pkt_type,
 								    wCurrentRate, b_need_ack,
 								    uFragIdx, cbLastFragmentSize,
-								    uMACfragNum, byFBOption));
+								    uMACfragNum, by_fb_option));
 			buf->duration_f0 =
 				cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F0,
 								    cb_frame_length, by_pkt_type,
 								    wCurrentRate, b_need_ack,
 								    uFragIdx, cbLastFragmentSize,
-								    uMACfragNum, byFBOption));
+								    uMACfragNum, by_fb_option));
 			buf->duration_f1 =
 				cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F1,
 								    cb_frame_length, by_pkt_type,
 								    wCurrentRate, b_need_ack,
 								    uFragIdx, cbLastFragmentSize,
-								    uMACfragNum, byFBOption));
+								    uMACfragNum, by_fb_option));
 			buf->time_stamp_off = vnt_time_stamp_off(p_device, wCurrentRate);
 			return buf->duration;
 		}
@@ -595,7 +597,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 								    cb_frame_length, by_pkt_type,
 								    wCurrentRate, b_need_ack,
 								    uFragIdx, cbLastFragmentSize,
-								    uMACfragNum, byFBOption));
+								    uMACfragNum, by_fb_option));
 		}
 
 		buf->time_stamp_off = vnt_time_stamp_off(p_device, wCurrentRate);
@@ -616,7 +618,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 			cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_B, cb_frame_length,
 							    by_pkt_type, wCurrentRate, b_need_ack,
 							    uFragIdx, cbLastFragmentSize,
-							    uMACfragNum, byFBOption));
+							    uMACfragNum, by_fb_option));
 	}
 
 	buf->time_stamp_off = vnt_time_stamp_off(p_device, wCurrentRate);
@@ -631,7 +633,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			      bool b_dis_crc,
 			      struct ieee80211_hdr *hdr,
 			      unsigned short wCurrentRate,
-			      unsigned char byFBOption)
+			      unsigned char by_fb_option)
 {
 	unsigned int uRTSFrameLen = 20;
 
@@ -650,7 +652,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 	 * Otherwise, we need to modify codes for them.
 	 */
 	if (by_pkt_type == PK_TYPE_11GB || by_pkt_type == PK_TYPE_11GA) {
-		if (byFBOption == AUTO_FB_NONE) {
+		if (by_fb_option == AUTO_FB_NONE) {
 			struct vnt_rts_g *buf = pv_rts;
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(p_device, uRTSFrameLen,
@@ -665,17 +667,17 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BB,
 						     cb_frame_length, PK_TYPE_11B,
 						     p_device->byTopCCKBasicRate,
-						     b_need_ack, byFBOption);
+						     b_need_ack, by_fb_option);
 			buf->duration_aa =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 			buf->duration_ba =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BA,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 
 			buf->data.duration = buf->duration_aa;
 			/* Get RTS Frame body */
@@ -700,37 +702,37 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BB,
 						     cb_frame_length, PK_TYPE_11B,
 						     p_device->byTopCCKBasicRate,
-						     b_need_ack, byFBOption);
+						     b_need_ack, by_fb_option);
 			buf->duration_aa =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 			buf->duration_ba =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BA,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 			buf->rts_duration_ba_f0 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BA_F0,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 			buf->rts_duration_aa_f0 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F0,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 			buf->rts_duration_ba_f1 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BA_F1,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 			buf->rts_duration_aa_f1 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F1,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 			buf->data.duration = buf->duration_aa;
 			/* Get RTS Frame body */
 			buf->data.frame_control =
@@ -739,9 +741,9 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 
 			ether_addr_copy(buf->data.ra, hdr->addr1);
 			ether_addr_copy(buf->data.ta, hdr->addr2);
-		} /* if (byFBOption == AUTO_FB_NONE) */
+		} /* if (by_fb_option == AUTO_FB_NONE) */
 	} else if (by_pkt_type == PK_TYPE_11A) {
-		if (byFBOption == AUTO_FB_NONE) {
+		if (by_fb_option == AUTO_FB_NONE) {
 			struct vnt_rts_ab *buf = pv_rts;
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(p_device, uRTSFrameLen,
@@ -752,7 +754,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 			buf->data.duration = buf->duration;
 			/* Get RTS Frame body */
 			buf->data.frame_control =
@@ -772,17 +774,17 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 			buf->rts_duration_f0 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F0,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 			buf->rts_duration_f1 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F1,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 			buf->data.duration = buf->duration;
 			/* Get RTS Frame body */
 			buf->data.frame_control =
@@ -802,7 +804,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 		buf->duration =
 			s_uGetRTSCTSDuration(p_device, RTSDUR_BB, cb_frame_length,
 					     by_pkt_type, wCurrentRate, b_need_ack,
-					     byFBOption);
+					     by_fb_option);
 
 		buf->data.duration = buf->duration;
 		/* Get RTS Frame body */
@@ -822,7 +824,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 			   bool b_need_ack,
 			   bool b_dis_crc,
 			   unsigned short wCurrentRate,
-			   unsigned char byFBOption)
+			   unsigned char by_fb_option)
 {
 	unsigned int uCTSFrameLen = 14;
 
@@ -837,7 +839,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 	}
 
 	if (by_pkt_type == PK_TYPE_11GB || by_pkt_type == PK_TYPE_11GA) {
-		if (byFBOption != AUTO_FB_NONE &&
+		if (by_fb_option != AUTO_FB_NONE &&
 		    uDMAIdx != TYPE_ATIMDMA &&
 		    uDMAIdx != TYPE_BEACONDMA) {
 			/* Auto Fall back */
@@ -851,21 +853,21 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 				s_uGetRTSCTSDuration(p_device, CTSDUR_BA,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 
 			/* Get CTSDuration_ba_f0 */
 			buf->cts_duration_ba_f0 =
 				s_uGetRTSCTSDuration(p_device, CTSDUR_BA_F0,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 
 			/* Get CTSDuration_ba_f1 */
 			buf->cts_duration_ba_f1 =
 				s_uGetRTSCTSDuration(p_device, CTSDUR_BA_F1,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 
 			/* Get CTS Frame body */
 			buf->data.duration = buf->duration_ba;
@@ -879,7 +881,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 			ether_addr_copy(buf->data.ra,
 					p_device->abyCurrentNetAddr);
 		} else {
-			/* if (byFBOption != AUTO_FB_NONE &&
+			/* if (by_fb_option != AUTO_FB_NONE &&
 			 * uDMAIdx != TYPE_ATIMDMA &&
 			 * uDMAIdx != TYPE_BEACONDMA)
 			 */
@@ -894,7 +896,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 				s_uGetRTSCTSDuration(p_device, CTSDUR_BA,
 						     cb_frame_length, by_pkt_type,
 						     wCurrentRate, b_need_ack,
-						     byFBOption);
+						     by_fb_option);
 
 			/* Get CTS Frame body */
 			buf->data.duration = buf->duration_ba;
@@ -948,7 +950,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 {
 	u16 fifo_ctl = le16_to_cpu(tx_buffer_head->fifo_ctl);
 	bool b_dis_crc = false;
-	unsigned char byFBOption = AUTO_FB_NONE;
+	unsigned char by_fb_option = AUTO_FB_NONE;
 
 	tx_buffer_head->current_rate = cpu_to_le16(wCurrentRate);
 
@@ -956,9 +958,9 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 		b_dis_crc = true;
 
 	if (fifo_ctl & FIFOCTL_AUTO_FB_0)
-		byFBOption = AUTO_FB_0;
+		by_fb_option = AUTO_FB_0;
 	else if (fifo_ctl & FIFOCTL_AUTO_FB_1)
-		byFBOption = AUTO_FB_1;
+		by_fb_option = AUTO_FB_1;
 
 	if (!pvRrvTime)
 		return;
@@ -981,7 +983,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 								bNeedACK);
 
 			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
-					  b_dis_crc, psEthHeader, wCurrentRate, byFBOption);
+					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
 		} else {/* RTS_needless, PCF mode */
 			struct vnt_rrv_time_cts *buf = pvRrvTime;
 
@@ -995,7 +997,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 
 			/* Fill CTS */
 			s_vFillCTSHead(p_device, uDMAIdx, by_pkt_type, pvCTS, cbFrameSize, bNeedACK,
-				       b_dis_crc, wCurrentRate, byFBOption);
+				       b_dis_crc, wCurrentRate, by_fb_option);
 		}
 	} else if (by_pkt_type == PK_TYPE_11A) {
 		if (pv_rts) {/* RTS_need, non PCF mode */
@@ -1008,7 +1010,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 
 			/* Fill RTS */
 			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
-					  b_dis_crc, psEthHeader, wCurrentRate, byFBOption);
+					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
 		} else if (!pv_rts) {/* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
@@ -1026,7 +1028,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 
 			/* Fill RTS */
 			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
-					  b_dis_crc, psEthHeader, wCurrentRate, byFBOption);
+					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
 		} else { /* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
@@ -1068,7 +1070,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 	void *pvCTS = NULL;
 	void *pvTxDataHd = NULL;
 	unsigned short wTxBufSize;   /* FFinfo size */
-	unsigned char byFBOption = AUTO_FB_NONE;
+	unsigned char by_fb_option = AUTO_FB_NONE;
 
 	cbFrameSize = skb->len + 4;
 
@@ -1094,15 +1096,15 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 	 * Use for AUTO FALL BACK
 	 */
 	if (fifo_ctl & FIFOCTL_AUTO_FB_0)
-		byFBOption = AUTO_FB_0;
+		by_fb_option = AUTO_FB_0;
 	else if (fifo_ctl & FIFOCTL_AUTO_FB_1)
-		byFBOption = AUTO_FB_1;
+		by_fb_option = AUTO_FB_1;
 
 	/* Set RrvTime/RTS/CTS Buffer */
 	wTxBufSize = sizeof(struct vnt_tx_fifo_head);
 	if (by_pkt_type == PK_TYPE_11GB || by_pkt_type == PK_TYPE_11GA) {/* 802.11g packet */
 
-		if (byFBOption == AUTO_FB_NONE) {
+		if (by_fb_option == AUTO_FB_NONE) {
 			if (bRTS) {/* RTS_need */
 				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
@@ -1162,7 +1164,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 		} /* Auto Fall Back */
 	} else {/* 802.11a/b packet */
 
-		if (byFBOption == AUTO_FB_NONE) {
+		if (by_fb_option == AUTO_FB_NONE) {
 			if (bRTS) {
 				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
@@ -1225,7 +1227,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 			       cbFrameSize, bNeedACK, uDMAIdx, hdr, p_device->wCurrentRate);
 	/* Fill DataHead */
 	uDuration = s_uFillDataHead(p_device, by_pkt_type, pvTxDataHd, cbFrameSize, uDMAIdx,
-				    bNeedACK, 0, 0, uMACfragNum, byFBOption,
+				    bNeedACK, 0, 0, uMACfragNum, by_fb_option,
 				    p_device->wCurrentRate, is_pspoll);
 
 	hdr->duration_id = uDuration;
-- 
2.34.1

