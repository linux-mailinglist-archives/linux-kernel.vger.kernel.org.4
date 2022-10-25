Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED43A60D804
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiJYXiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiJYXhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:37:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D31FB726
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b1so25301226lfs.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvzDdjgKAe+oes/kVBvMNsXTWZdcaXY0ZRcD0jQY8yg=;
        b=fwDJ67ST9phJ0pIN6h32/XH28ITv4wBSvmFIhh0/Taru1JR1IOMseZr6BUxyXiCQ3h
         RwGlBox7+c5CX7u+WaW1P1qF+8vNq1cicgHbplrZk82my8PF67KiRkDwwSRq1lIql2U6
         TgbzV1CS0ESIx5ecgDtMrdJSxvV0IK+oRCvxLpMRfy3czhUivYFJDNHyjhA4evezp1T8
         Fmdo3dUiXSPZE9FGyAIxUqYWLoo1ulQO7RyXIOPw+icvlLL6WNOzsy/xyHHjbgfEnLLO
         LlBhJvLLbg62YPESgVS7zrH8JKxBXmA0Ol6eNoL+jmL5SkEBYMP3EGc92DaxjNfPZKo7
         02rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvzDdjgKAe+oes/kVBvMNsXTWZdcaXY0ZRcD0jQY8yg=;
        b=rf+0lYjAM5sgcxz4HsrC8eefrNrG3oc/NHeU1U+J//LC/z+SjsamdJ7yTKidq4bYr7
         2fGMPgpWh8/i18TT1N6YF1o9bNt2VyPwyaBheRv+w3fek0ykGVCizSu9xg0Yu1UGC6ba
         tiTlMEkT7bx98o/30W+lavEVGUeaQmH+S1eGXlH+t+Yc2x3Y+x6zvbHOzJ9n4Y3UInC3
         BQoaziJt9WttZQmakSl53IHEnxHb0UU6eNnpXp4ukBU1yHHVfwEnsKyv9Pa8aF+RKPsi
         lSHBQVPLAJ7Oh4IcbN2voUN16KPLjfk7qgngm3jkFMAmVnLJifbqk91zmcM/OMVm3gbp
         IHnQ==
X-Gm-Message-State: ACrzQf3+KyozJ6uMvj0X6hbc5oxu7197e0RqRKzrIZtqskvJwgQOhztZ
        eKj4kIMQzGAj+JyidtYIVi4=
X-Google-Smtp-Source: AMsMyM7RE+Rj0Up1g0yO21JUDQGmnpJDHAbWaEDa5n+77EmbpR9eKVrKxQPSI4I5bONLiwy8H5ciCQ==
X-Received: by 2002:ac2:5f51:0:b0:4a4:5e1f:fce1 with SMTP id 17-20020ac25f51000000b004a45e1ffce1mr16121943lfz.130.1666741067149;
        Tue, 25 Oct 2022 16:37:47 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:37:46 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 04/17] staging: vt6655: changed variable name: byPktType
Date:   Tue, 25 Oct 2022 23:37:00 +0000
Message-Id: <7b7d78fcab2941fc5af1220c627d4b77afe03ab0.1666740522.git.tanjubrunostar0@gmail.com>
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

	change variable names byPktType to meet the
        linux coding standard, as it says to avoid using camelCase naming
        style. Cought by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 222 +++++++++++++++++-----------------
 1 file changed, 111 insertions(+), 111 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 3565f5608790..2cac8f3882df 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -86,7 +86,7 @@ static const unsigned short w_fb_opt_1[2][5] = {
 
 /*---------------------  Static Functions  --------------------------*/
 static void s_v_fill_rts_head(struct vnt_private *p_device,
-			      unsigned char byPktType,
+			      unsigned char by_pkt_type,
 			      void *pvRTS,
 			      unsigned int	cbFrameLength,
 			      bool bNeedAck,
@@ -96,7 +96,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			      unsigned char byFBOption);
 
 static void s_vGenerateTxParameter(struct vnt_private *p_device,
-				   unsigned char byPktType,
+				   unsigned char by_pkt_type,
 				   struct vnt_tx_fifo_head *,
 				   void *pvRrvTime,
 				   void *pvRTS,
@@ -108,13 +108,13 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 				   unsigned short wCurrentRate);
 
 static unsigned int
-s_cbFillTxBufHead(struct vnt_private *p_device, unsigned char byPktType,
+s_cbFillTxBufHead(struct vnt_private *p_device, unsigned char by_pkt_type,
 		  unsigned char *pbyTxBufferAddr,
 		  unsigned int uDMAIdx, struct vnt_tx_desc *pHeadTD,
 		  unsigned int uNodeIndex);
 
 static __le16 s_uFillDataHead(struct vnt_private *p_device,
-			      unsigned char byPktType,
+			      unsigned char by_pkt_type,
 			      void *pTxDataHead,
 			      unsigned int cbFrameLength,
 			      unsigned int uDMAIdx,
@@ -134,20 +134,20 @@ static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
 							[rate % MAX_RATE]);
 }
 
-/* byPktType : PK_TYPE_11A     0
+/* by_pkt_type : PK_TYPE_11A     0
  * PK_TYPE_11B     1
  * PK_TYPE_11GB    2
  * PK_TYPE_11GA    3
  */
 static unsigned int s_uGetTxRsvTime(struct vnt_private *p_device,
-				    unsigned char byPktType,
+				    unsigned char by_pkt_type,
 				    unsigned int cbFrameLength,
 				    unsigned short wRate,
 				    bool bNeedAck)
 {
 	unsigned int uDataTime, uAckTime;
 
-	uDataTime = bb_get_frame_time(p_device->preamble_type, byPktType, cbFrameLength, wRate);
+	uDataTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, cbFrameLength, wRate);
 
 	if (!bNeedAck)
 		return uDataTime;
@@ -156,8 +156,8 @@ static unsigned int s_uGetTxRsvTime(struct vnt_private *p_device,
 	 * CCK mode  - 11b
 	 * OFDM mode - 11g 2.4G & 11a 5G
 	 */
-	uAckTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
-				     byPktType == PK_TYPE_11B ?
+	uAckTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
+				     by_pkt_type == PK_TYPE_11B ?
 				     p_device->byTopCCKBasicRate :
 				     p_device->byTopOFDMBasicRate);
 
@@ -222,7 +222,7 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
 static unsigned int s_uGetDataDuration(struct vnt_private *p_device,
 				       unsigned char byDurType,
 				       unsigned int cbFrameLength,
-				       unsigned char byPktType,
+				       unsigned char by_pkt_type,
 				       unsigned short wRate,
 				       bool bNeedAck,
 				       unsigned int uFragIdx,
@@ -245,7 +245,7 @@ static unsigned int s_uGetDataDuration(struct vnt_private *p_device,
 	case DATADUR_B:    /* DATADUR_B */
 		if (bNeedAck) {
 			uAckTime = bb_get_frame_time(p_device->preamble_type,
-						     byPktType, 14,
+						     by_pkt_type, 14,
 						     p_device->byTopCCKBasicRate);
 		}
 		/* Non Frag or Last Frag */
@@ -254,7 +254,7 @@ static unsigned int s_uGetDataDuration(struct vnt_private *p_device,
 				return 0;
 		} else {
 			/* First Frag or Mid Frag */
-			uNextPktTime = s_uGetTxRsvTime(p_device, byPktType,
+			uNextPktTime = s_uGetTxRsvTime(p_device, by_pkt_type,
 						       len, wRate, bNeedAck);
 		}
 
@@ -263,7 +263,7 @@ static unsigned int s_uGetDataDuration(struct vnt_private *p_device,
 	case DATADUR_A:    /* DATADUR_A */
 		if (bNeedAck) {
 			uAckTime = bb_get_frame_time(p_device->preamble_type,
-						     byPktType, 14,
+						     by_pkt_type, 14,
 						     p_device->byTopOFDMBasicRate);
 		}
 		/* Non Frag or Last Frag */
@@ -272,7 +272,7 @@ static unsigned int s_uGetDataDuration(struct vnt_private *p_device,
 				return 0;
 		} else {
 			/* First Frag or Mid Frag */
-			uNextPktTime = s_uGetTxRsvTime(p_device, byPktType,
+			uNextPktTime = s_uGetTxRsvTime(p_device, by_pkt_type,
 						       len, wRate, bNeedAck);
 		}
 
@@ -282,7 +282,7 @@ static unsigned int s_uGetDataDuration(struct vnt_private *p_device,
 	case DATADUR_A_F1:    /* DATADUR_A_F1 */
 		if (bNeedAck) {
 			uAckTime = bb_get_frame_time(p_device->preamble_type,
-						     byPktType, 14,
+						     by_pkt_type, 14,
 						     p_device->byTopOFDMBasicRate);
 		}
 		/* Non Frag or Last Frag */
@@ -303,7 +303,7 @@ static unsigned int s_uGetDataDuration(struct vnt_private *p_device,
 			else
 				wRate = w_fb_opt_1[FB_RATE0][wRate];
 
-			uNextPktTime = s_uGetTxRsvTime(p_device, byPktType,
+			uNextPktTime = s_uGetTxRsvTime(p_device, by_pkt_type,
 						       len, wRate, bNeedAck);
 		}
 
@@ -320,7 +320,7 @@ static unsigned int s_uGetDataDuration(struct vnt_private *p_device,
 static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 				   unsigned char byDurType,
 				   unsigned int cbFrameLength,
-				   unsigned char byPktType,
+				   unsigned char by_pkt_type,
 				   unsigned short wRate,
 				   bool bNeedAck,
 				   unsigned char byFBOption)
@@ -329,83 +329,83 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 
 	switch (byDurType) {
 	case RTSDUR_BB:    /* RTSDuration_bb */
-		uCTSTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
+		uCTSTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
 					     p_device->byTopCCKBasicRate);
 		uDurTime = uCTSTime + 2 * p_device->uSIFS +
-			s_uGetTxRsvTime(p_device, byPktType, cbFrameLength, wRate, bNeedAck);
+			s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case RTSDUR_BA:    /* RTSDuration_ba */
-		uCTSTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
+		uCTSTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
 					     p_device->byTopCCKBasicRate);
 		uDurTime = uCTSTime + 2 * p_device->uSIFS +
-			s_uGetTxRsvTime(p_device, byPktType, cbFrameLength, wRate, bNeedAck);
+			s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case RTSDUR_AA:    /* RTSDuration_aa */
-		uCTSTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
+		uCTSTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
 					     p_device->byTopOFDMBasicRate);
 		uDurTime = uCTSTime + 2 * p_device->uSIFS +
-			s_uGetTxRsvTime(p_device, byPktType, cbFrameLength, wRate, bNeedAck);
+			s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case CTSDUR_BA:    /* CTSDuration_ba */
-		uDurTime = p_device->uSIFS + s_uGetTxRsvTime(p_device, byPktType,
+		uDurTime = p_device->uSIFS + s_uGetTxRsvTime(p_device, by_pkt_type,
 							    cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case RTSDUR_BA_F0: /* RTSDuration_ba_f0 */
-		uCTSTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
+		uCTSTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
 					     p_device->byTopCCKBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
-				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
+				s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength,
 						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
-				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
+				s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength,
 						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], bNeedAck);
 
 		break;
 
 	case RTSDUR_AA_F0: /* RTSDuration_aa_f0 */
-		uCTSTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
+		uCTSTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
 					     p_device->byTopOFDMBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
-				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
+				s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength,
 						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
-				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
+				s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength,
 						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], bNeedAck);
 
 		break;
 
 	case RTSDUR_BA_F1: /* RTSDuration_ba_f1 */
-		uCTSTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
+		uCTSTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
 					     p_device->byTopCCKBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
-				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
+				s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength,
 						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
-				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
+				s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength,
 						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], bNeedAck);
 
 		break;
 
 	case RTSDUR_AA_F1: /* RTSDuration_aa_f1 */
-		uCTSTime = bb_get_frame_time(p_device->preamble_type, byPktType, 14,
+		uCTSTime = bb_get_frame_time(p_device->preamble_type, by_pkt_type, 14,
 					     p_device->byTopOFDMBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
-				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
+				s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength,
 						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * p_device->uSIFS +
-				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
+				s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength,
 						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], bNeedAck);
 
 		break;
@@ -413,11 +413,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 	case CTSDUR_BA_F0: /* CTSDuration_ba_f0 */
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = p_device->uSIFS +
-				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
+				s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength,
 						w_fb_opt_0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = p_device->uSIFS +
-				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
+				s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength,
 						w_fb_opt_1[FB_RATE0][wRate - RATE_18M], bNeedAck);
 
 		break;
@@ -425,11 +425,11 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 	case CTSDUR_BA_F1: /* CTSDuration_ba_f1 */
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = p_device->uSIFS +
-				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
+				s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength,
 						w_fb_opt_0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = p_device->uSIFS +
-				s_uGetTxRsvTime(p_device, byPktType, cbFrameLength,
+				s_uGetTxRsvTime(p_device, by_pkt_type, cbFrameLength,
 						w_fb_opt_1[FB_RATE1][wRate - RATE_18M], bNeedAck);
 
 		break;
@@ -442,7 +442,7 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *p_device,
 }
 
 static __le16 s_uFillDataHead(struct vnt_private *p_device,
-			      unsigned char byPktType,
+			      unsigned char by_pkt_type,
 			      void *pTxDataHead,
 			      unsigned int cbFrameLength,
 			      unsigned int uDMAIdx,
@@ -459,7 +459,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 	if (!pTxDataHead)
 		return 0;
 
-	if (byPktType == PK_TYPE_11GB || byPktType == PK_TYPE_11GA) {
+	if (by_pkt_type == PK_TYPE_11GB || by_pkt_type == PK_TYPE_11GA) {
 		/* Auto Fallback */
 		struct vnt_tx_datahead_g_fb *buf = pTxDataHead;
 
@@ -467,7 +467,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 			struct vnt_tx_datahead_g *buf = pTxDataHead;
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(p_device, cbFrameLength, wCurrentRate,
-					  byPktType, &buf->a);
+					  by_pkt_type, &buf->a);
 
 			vnt_get_phy_field(p_device, cbFrameLength,
 					  p_device->byTopCCKBasicRate,
@@ -483,7 +483,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 				buf->duration_a =
 					cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A,
 									    cbFrameLength,
-									    byPktType,
+									    by_pkt_type,
 									    wCurrentRate, bNeedAck,
 									    uFragIdx,
 									    cbLastFragmentSize,
@@ -509,14 +509,14 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 
 		/* Get SignalField, ServiceField & Length */
 		vnt_get_phy_field(p_device, cbFrameLength, wCurrentRate,
-				  byPktType, &buf->a);
+				  by_pkt_type, &buf->a);
 
 		vnt_get_phy_field(p_device, cbFrameLength,
 				  p_device->byTopCCKBasicRate,
 				  PK_TYPE_11B, &buf->b);
 		/* Get Duration and TimeStamp */
 		buf->duration_a = cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A,
-								      cbFrameLength, byPktType,
+								      cbFrameLength, by_pkt_type,
 								      wCurrentRate, bNeedAck,
 								      uFragIdx, cbLastFragmentSize,
 								      uMACfragNum, byFBOption));
@@ -527,13 +527,13 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 								      cbLastFragmentSize,
 								      uMACfragNum, byFBOption));
 		buf->duration_a_f0 = cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F0,
-									 cbFrameLength, byPktType,
+									 cbFrameLength, by_pkt_type,
 									 wCurrentRate, bNeedAck,
 									 uFragIdx,
 									 cbLastFragmentSize,
 									 uMACfragNum, byFBOption));
 		buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F1,
-									 cbFrameLength, byPktType,
+									 cbFrameLength, by_pkt_type,
 									 wCurrentRate, bNeedAck,
 									 uFragIdx,
 									 cbLastFragmentSize,
@@ -544,7 +544,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 
 		return buf->duration_a;
 		  /* if (byFBOption == AUTO_FB_NONE) */
-	} else if (byPktType == PK_TYPE_11A) {
+	} else if (by_pkt_type == PK_TYPE_11A) {
 		struct vnt_tx_datahead_ab *buf = pTxDataHead;
 
 		if (byFBOption != AUTO_FB_NONE) {
@@ -552,24 +552,24 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 			struct vnt_tx_datahead_a_fb *buf = pTxDataHead;
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(p_device, cbFrameLength, wCurrentRate,
-					  byPktType, &buf->a);
+					  by_pkt_type, &buf->a);
 
 			/* Get Duration and TimeStampOff */
 			buf->duration =
 				cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A,
-								    cbFrameLength, byPktType,
+								    cbFrameLength, by_pkt_type,
 								    wCurrentRate, bNeedAck,
 								    uFragIdx, cbLastFragmentSize,
 								    uMACfragNum, byFBOption));
 			buf->duration_f0 =
 				cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F0,
-								    cbFrameLength, byPktType,
+								    cbFrameLength, by_pkt_type,
 								    wCurrentRate, bNeedAck,
 								    uFragIdx, cbLastFragmentSize,
 								    uMACfragNum, byFBOption));
 			buf->duration_f1 =
 				cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A_F1,
-								    cbFrameLength, byPktType,
+								    cbFrameLength, by_pkt_type,
 								    wCurrentRate, bNeedAck,
 								    uFragIdx, cbLastFragmentSize,
 								    uMACfragNum, byFBOption));
@@ -579,7 +579,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 
 		/* Get SignalField, ServiceField & Length */
 		vnt_get_phy_field(p_device, cbFrameLength, wCurrentRate,
-				  byPktType, &buf->ab);
+				  by_pkt_type, &buf->ab);
 
 		if (is_pspoll) {
 			__le16 dur = cpu_to_le16(p_device->current_aid | BIT(14) | BIT(15));
@@ -589,7 +589,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 			/* Get Duration and TimeStampOff */
 			buf->duration =
 				cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_A,
-								    cbFrameLength, byPktType,
+								    cbFrameLength, by_pkt_type,
 								    wCurrentRate, bNeedAck,
 								    uFragIdx, cbLastFragmentSize,
 								    uMACfragNum, byFBOption));
@@ -601,7 +601,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 
 	/* Get SignalField, ServiceField & Length */
 	vnt_get_phy_field(p_device, cbFrameLength, wCurrentRate,
-			  byPktType, &buf->ab);
+			  by_pkt_type, &buf->ab);
 
 	if (is_pspoll) {
 		__le16 dur = cpu_to_le16(p_device->current_aid | BIT(14) | BIT(15));
@@ -611,7 +611,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 		/* Get Duration and TimeStampOff */
 		buf->duration =
 			cpu_to_le16((u16)s_uGetDataDuration(p_device, DATADUR_B, cbFrameLength,
-							    byPktType, wCurrentRate, bNeedAck,
+							    by_pkt_type, wCurrentRate, bNeedAck,
 							    uFragIdx, cbLastFragmentSize,
 							    uMACfragNum, byFBOption));
 	}
@@ -621,7 +621,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 }
 
 static void s_v_fill_rts_head(struct vnt_private *p_device,
-			      unsigned char byPktType,
+			      unsigned char by_pkt_type,
 			      void *pvRTS,
 			      unsigned int cbFrameLength,
 			      bool bNeedAck,
@@ -646,7 +646,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 	 * so we don't need to take them into account.
 	 * Otherwise, we need to modify codes for them.
 	 */
-	if (byPktType == PK_TYPE_11GB || byPktType == PK_TYPE_11GA) {
+	if (by_pkt_type == PK_TYPE_11GB || by_pkt_type == PK_TYPE_11GA) {
 		if (byFBOption == AUTO_FB_NONE) {
 			struct vnt_rts_g *buf = pvRTS;
 			/* Get SignalField, ServiceField & Length */
@@ -656,7 +656,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 
 			vnt_get_phy_field(p_device, uRTSFrameLen,
 					  p_device->byTopOFDMBasicRate,
-					  byPktType, &buf->a);
+					  by_pkt_type, &buf->a);
 			/* Get Duration */
 			buf->duration_bb =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BB,
@@ -665,12 +665,12 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 						     bNeedAck, byFBOption);
 			buf->duration_aa =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->duration_ba =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BA,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 
@@ -691,7 +691,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 
 			vnt_get_phy_field(p_device, uRTSFrameLen,
 					  p_device->byTopOFDMBasicRate,
-					  byPktType, &buf->a);
+					  by_pkt_type, &buf->a);
 			/* Get Duration */
 			buf->duration_bb =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BB,
@@ -700,32 +700,32 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 						     bNeedAck, byFBOption);
 			buf->duration_aa =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->duration_ba =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BA,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->rts_duration_ba_f0 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BA_F0,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->rts_duration_aa_f0 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F0,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->rts_duration_ba_f1 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_BA_F1,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->rts_duration_aa_f1 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F1,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->data.duration = buf->duration_aa;
@@ -737,17 +737,17 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			ether_addr_copy(buf->data.ra, hdr->addr1);
 			ether_addr_copy(buf->data.ta, hdr->addr2);
 		} /* if (byFBOption == AUTO_FB_NONE) */
-	} else if (byPktType == PK_TYPE_11A) {
+	} else if (by_pkt_type == PK_TYPE_11A) {
 		if (byFBOption == AUTO_FB_NONE) {
 			struct vnt_rts_ab *buf = pvRTS;
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(p_device, uRTSFrameLen,
 					  p_device->byTopOFDMBasicRate,
-					  byPktType, &buf->ab);
+					  by_pkt_type, &buf->ab);
 			/* Get Duration */
 			buf->duration =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->data.duration = buf->duration;
@@ -763,21 +763,21 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(p_device, uRTSFrameLen,
 					  p_device->byTopOFDMBasicRate,
-					  byPktType, &buf->a);
+					  by_pkt_type, &buf->a);
 			/* Get Duration */
 			buf->duration =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->rts_duration_f0 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F0,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->rts_duration_f1 =
 				s_uGetRTSCTSDuration(p_device, RTSDUR_AA_F1,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 			buf->data.duration = buf->duration;
@@ -789,7 +789,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			ether_addr_copy(buf->data.ra, hdr->addr1);
 			ether_addr_copy(buf->data.ta, hdr->addr2);
 		}
-	} else if (byPktType == PK_TYPE_11B) {
+	} else if (by_pkt_type == PK_TYPE_11B) {
 		struct vnt_rts_ab *buf = pvRTS;
 		/* Get SignalField, ServiceField & Length */
 		vnt_get_phy_field(p_device, uRTSFrameLen,
@@ -798,7 +798,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 		/* Get Duration */
 		buf->duration =
 			s_uGetRTSCTSDuration(p_device, RTSDUR_BB, cbFrameLength,
-					     byPktType, wCurrentRate, bNeedAck,
+					     by_pkt_type, wCurrentRate, bNeedAck,
 					     byFBOption);
 
 		buf->data.duration = buf->duration;
@@ -813,7 +813,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 
 static void s_vFillCTSHead(struct vnt_private *p_device,
 			   unsigned int uDMAIdx,
-			   unsigned char byPktType,
+			   unsigned char by_pkt_type,
 			   void *pvCTS,
 			   unsigned int cbFrameLength,
 			   bool bNeedAck,
@@ -833,7 +833,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 		uCTSFrameLen -= 4;
 	}
 
-	if (byPktType == PK_TYPE_11GB || byPktType == PK_TYPE_11GA) {
+	if (by_pkt_type == PK_TYPE_11GB || by_pkt_type == PK_TYPE_11GA) {
 		if (byFBOption != AUTO_FB_NONE &&
 		    uDMAIdx != TYPE_ATIMDMA &&
 		    uDMAIdx != TYPE_BEACONDMA) {
@@ -846,21 +846,21 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 
 			buf->duration_ba =
 				s_uGetRTSCTSDuration(p_device, CTSDUR_BA,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 
 			/* Get CTSDuration_ba_f0 */
 			buf->cts_duration_ba_f0 =
 				s_uGetRTSCTSDuration(p_device, CTSDUR_BA_F0,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 
 			/* Get CTSDuration_ba_f1 */
 			buf->cts_duration_ba_f1 =
 				s_uGetRTSCTSDuration(p_device, CTSDUR_BA_F1,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 
@@ -889,7 +889,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 			/* Get CTSDuration_ba */
 			buf->duration_ba =
 				s_uGetRTSCTSDuration(p_device, CTSDUR_BA,
-						     cbFrameLength, byPktType,
+						     cbFrameLength, by_pkt_type,
 						     wCurrentRate, bNeedAck,
 						     byFBOption);
 
@@ -932,7 +932,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
  * unsigned int cbFrameSize, Hdr+Payload+FCS
  */
 static void s_vGenerateTxParameter(struct vnt_private *p_device,
-				   unsigned char byPktType,
+				   unsigned char by_pkt_type,
 				   struct vnt_tx_fifo_head *tx_buffer_head,
 				   void *pvRrvTime,
 				   void *pvRTS,
@@ -960,51 +960,51 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 	if (!pvRrvTime)
 		return;
 
-	if (byPktType == PK_TYPE_11GB || byPktType == PK_TYPE_11GA) {
+	if (by_pkt_type == PK_TYPE_11GB || by_pkt_type == PK_TYPE_11GA) {
 		if (pvRTS) { /* RTS_need */
 			/* Fill RsvTime */
 			struct vnt_rrv_time_rts *buf = pvRrvTime;
 
-			buf->rts_rrv_time_aa = get_rtscts_time(p_device, 2, byPktType, cbFrameSize,
-							       wCurrentRate);
-			buf->rts_rrv_time_ba = get_rtscts_time(p_device, 1, byPktType, cbFrameSize,
-							       wCurrentRate);
-			buf->rts_rrv_time_bb = get_rtscts_time(p_device, 0, byPktType, cbFrameSize,
-							       wCurrentRate);
-			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(p_device, byPktType, cbFrameSize,
+			buf->rts_rrv_time_aa = get_rtscts_time(p_device, 2, by_pkt_type,
+							       cbFrameSize, wCurrentRate);
+			buf->rts_rrv_time_ba = get_rtscts_time(p_device, 1, by_pkt_type,
+							       cbFrameSize, wCurrentRate);
+			buf->rts_rrv_time_bb = get_rtscts_time(p_device, 0, by_pkt_type,
+							       cbFrameSize, wCurrentRate);
+			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(p_device, by_pkt_type, cbFrameSize,
 								wCurrentRate, bNeedACK);
 			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cbFrameSize,
 								p_device->byTopCCKBasicRate,
 								bNeedACK);
 
-			s_v_fill_rts_head(p_device, byPktType, pvRTS, cbFrameSize, bNeedACK,
+			s_v_fill_rts_head(p_device, by_pkt_type, pvRTS, cbFrameSize, bNeedACK,
 					  bDisCRC, psEthHeader, wCurrentRate, byFBOption);
 		} else {/* RTS_needless, PCF mode */
 			struct vnt_rrv_time_cts *buf = pvRrvTime;
 
-			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(p_device, byPktType, cbFrameSize,
+			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(p_device, by_pkt_type, cbFrameSize,
 								wCurrentRate, bNeedACK);
 			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cbFrameSize,
 								p_device->byTopCCKBasicRate,
 								bNeedACK);
-			buf->cts_rrv_time_ba = get_rtscts_time(p_device, 3, byPktType, cbFrameSize,
-							       wCurrentRate);
+			buf->cts_rrv_time_ba = get_rtscts_time(p_device, 3, by_pkt_type,
+							       cbFrameSize, wCurrentRate);
 
 			/* Fill CTS */
-			s_vFillCTSHead(p_device, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK,
+			s_vFillCTSHead(p_device, uDMAIdx, by_pkt_type, pvCTS, cbFrameSize, bNeedACK,
 				       bDisCRC, wCurrentRate, byFBOption);
 		}
-	} else if (byPktType == PK_TYPE_11A) {
+	} else if (by_pkt_type == PK_TYPE_11A) {
 		if (pvRTS) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rts_rrv_time = get_rtscts_time(p_device, 2, byPktType, cbFrameSize,
+			buf->rts_rrv_time = get_rtscts_time(p_device, 2, by_pkt_type, cbFrameSize,
 							    wCurrentRate);
-			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, byPktType, cbFrameSize,
+			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, by_pkt_type, cbFrameSize,
 							      wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_v_fill_rts_head(p_device, byPktType, pvRTS, cbFrameSize, bNeedACK,
+			s_v_fill_rts_head(p_device, by_pkt_type, pvRTS, cbFrameSize, bNeedACK,
 					  bDisCRC, psEthHeader, wCurrentRate, byFBOption);
 		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
@@ -1012,17 +1012,17 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11A, cbFrameSize,
 							      wCurrentRate, bNeedACK);
 		}
-	} else if (byPktType == PK_TYPE_11B) {
+	} else if (by_pkt_type == PK_TYPE_11B) {
 		if (pvRTS) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
-			buf->rts_rrv_time = get_rtscts_time(p_device, 0, byPktType, cbFrameSize,
+			buf->rts_rrv_time = get_rtscts_time(p_device, 0, by_pkt_type, cbFrameSize,
 							    wCurrentRate);
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cbFrameSize,
 							      wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_v_fill_rts_head(p_device, byPktType, pvRTS, cbFrameSize, bNeedACK,
+			s_v_fill_rts_head(p_device, by_pkt_type, pvRTS, cbFrameSize, bNeedACK,
 					  bDisCRC, psEthHeader, wCurrentRate, byFBOption);
 		} else { /* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
@@ -1034,7 +1034,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 }
 
 static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
-				      unsigned char byPktType,
+				      unsigned char by_pkt_type,
 				      unsigned char *pbyTxBufferAddr,
 				      unsigned int uDMAIdx,
 				      struct vnt_tx_desc *pHeadTD,
@@ -1097,7 +1097,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 
 	/* Set RrvTime/RTS/CTS Buffer */
 	wTxBufSize = sizeof(struct vnt_tx_fifo_head);
-	if (byPktType == PK_TYPE_11GB || byPktType == PK_TYPE_11GA) {/* 802.11g packet */
+	if (by_pkt_type == PK_TYPE_11GB || by_pkt_type == PK_TYPE_11GA) {/* 802.11g packet */
 
 		if (byFBOption == AUTO_FB_NONE) {
 			if (bRTS) {/* RTS_need */
@@ -1218,12 +1218,12 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 	memset((void *)(pbyTxBufferAddr + wTxBufSize), 0, (cbHeaderLength - wTxBufSize));
 
 	/* Fill FIFO,RrvTime,RTS,and CTS */
-	s_vGenerateTxParameter(p_device, byPktType, tx_buffer_head, pvRrvTime, pvRTS, pvCTS,
+	s_vGenerateTxParameter(p_device, by_pkt_type, tx_buffer_head, pvRrvTime, pvRTS, pvCTS,
 			       cbFrameSize, bNeedACK, uDMAIdx, hdr, p_device->wCurrentRate);
 	/* Fill DataHead */
-	uDuration = s_uFillDataHead(p_device, byPktType, pvTxDataHd, cbFrameSize, uDMAIdx, bNeedACK,
-				    0, 0, uMACfragNum, byFBOption, p_device->wCurrentRate,
-				    is_pspoll);
+	uDuration = s_uFillDataHead(p_device, by_pkt_type, pvTxDataHd, cbFrameSize, uDMAIdx,
+				    bNeedACK, 0, 0, uMACfragNum, byFBOption,
+				    p_device->wCurrentRate, is_pspoll);
 
 	hdr->duration_id = uDuration;
 
-- 
2.34.1

