Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26D360F32B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiJ0JGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbiJ0JGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:06:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C276DAFD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:06:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b2so1449587lfp.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFb+mglUFPvXWdrJsvsz1Oyw5hvEWlHP8+gxdLuuI4Y=;
        b=g+cvxjlbRwdElvqiXxKi2flixNbnssacEf9zbwDTKGiDHAOK9a97wvxgnNz2V/i8ku
         rN6R90RYV4yk192Ffi5YKkFWTQ+X+vy//SoY7BC+J8bUjx2eeL//0Z7oGp3s6VhiLSSr
         UD3BGk/e8+GWcBMF8Cwzi2KBqvVXvK6nzZqL13ZpQb0Q79A2uoYOjw/YxY9XPnaU2dtd
         rnEoYgd23QPrGw6MY0pSJVdqsHauhz3leKvwMKRnFwVWC2us6zUBYVYErrtRALyfZb8J
         AxKoRg4qHT1KGpC78aVan6AEjjSuU+SP3BLODYfoPcltYqcZzfc6GBPG6kIrr9h1vSfg
         0RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFb+mglUFPvXWdrJsvsz1Oyw5hvEWlHP8+gxdLuuI4Y=;
        b=1hJyRsET62BVAfXV0nK3A6Gm5Xal+ooaMaF5bL38p3+iGqgCKubVfWqxKOgUNYvIBa
         VsB3dRwJDOUWV5QY54euYh0erKQUTwWOpJAI6c1npYlqvfCeFIsu39upPGFPB0WWM0x1
         4h928mVpkgwA/WdeFES7A7odeTHiCcKArcSfPrUIaiqcf3gtzgw0t4t/6lwkVfXxWENv
         nQoZPLGhdfc66r0zH3pracULDYgIpRqLPXjoEiDPaE/yPAjHcsqKFOuTRATUEgQQMKWd
         FkDXf8jl/YMGSs/X7a2VLGnTYu7tNi9/4ExFr0lxOdPdhKWhIhwL4+8Z5TNJrESPybbD
         ZL4Q==
X-Gm-Message-State: ACrzQf2jDjRa8c+8EGGw1Q/wJDtITFfxy5khtDjK3/3vzAuxtpe1mDeJ
        vRE8e8f1eaBfI64qlPHILLHWT758lDvM2Q==
X-Google-Smtp-Source: AMsMyM7og6m45TfrUFhbQjjXJt7uK5vmrHnxih2t56CnMjTAcchJu1e742d9f0FViytiNOO3SUyyHQ==
X-Received: by 2002:a05:6512:2350:b0:4a2:2447:9c42 with SMTP id p16-20020a056512235000b004a224479c42mr16039008lfu.260.1666861566428;
        Thu, 27 Oct 2022 02:06:06 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id d9-20020a2e96c9000000b0026f9cb6d10fsm153273ljj.45.2022.10.27.02.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 02:06:06 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v6 2/6] staging: vt6655: refactor code in s_uGetRTSCTSDuration
Date:   Thu, 27 Oct 2022 09:05:51 +0000
Message-Id: <0e6a307052d3a354a850a502e509f46baccdbe1e.1666849707.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666849707.git.tanjubrunostar0@gmail.com>
References: <cover.1666849707.git.tanjubrunostar0@gmail.com>
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

refactor long lines of code in the function: s_uGetRTSCTSDuration

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 108 ++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 7eb7c6eb5cf0..8e56a7ee8035 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -186,20 +186,29 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
 
 	data_time = bb_get_frame_time(priv->preamble_type, pkt_type, frame_length, current_rate);
 	if (rts_rsvtype == 0) { /* RTSTxRrvTime_bb */
-		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20, priv->byTopCCKBasicRate);
-		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
+		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20,
+					     priv->byTopCCKBasicRate);
+		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14,
+					     priv->byTopCCKBasicRate);
 		cts_time = ack_time;
 	} else if (rts_rsvtype == 1) { /* RTSTxRrvTime_ba, only in 2.4GHZ */
-		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20, priv->byTopCCKBasicRate);
-		cts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
-		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopOFDMBasicRate);
+		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20,
+					     priv->byTopCCKBasicRate);
+		cts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14,
+					     priv->byTopCCKBasicRate);
+		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14,
+					     priv->byTopOFDMBasicRate);
 	} else if (rts_rsvtype == 2) { /* RTSTxRrvTime_aa */
-		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20, priv->byTopOFDMBasicRate);
-		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopOFDMBasicRate);
+		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20,
+					     priv->byTopOFDMBasicRate);
+		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14,
+					     priv->byTopOFDMBasicRate);
 		cts_time = ack_time;
 	} else if (rts_rsvtype == 3) { /* CTSTxRrvTime_ba, only in 2.4GHZ */
-		cts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
-		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopOFDMBasicRate);
+		cts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14,
+					     priv->byTopCCKBasicRate);
+		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14,
+					     priv->byTopOFDMBasicRate);
 		rrv_time = cts_time + ack_time + data_time + 2 * priv->uSIFS;
 		return cpu_to_le16((u16)rrv_time);
 	}
@@ -320,73 +329,108 @@ static __le16 s_uGetRTSCTSDuration(struct vnt_private *pDevice,
 
 	switch (byDurType) {
 	case RTSDUR_BB:    /* RTSDuration_bb */
-		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
-		uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
+		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
+					     pDevice->byTopCCKBasicRate);
+		uDurTime = uCTSTime + 2 * pDevice->uSIFS +
+			s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case RTSDUR_BA:    /* RTSDuration_ba */
-		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
-		uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
+		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
+					     pDevice->byTopCCKBasicRate);
+		uDurTime = uCTSTime + 2 * pDevice->uSIFS +
+			s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case RTSDUR_AA:    /* RTSDuration_aa */
-		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopOFDMBasicRate);
-		uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
+		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
+					     pDevice->byTopOFDMBasicRate);
+		uDurTime = uCTSTime + 2 * pDevice->uSIFS +
+			s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case CTSDUR_BA:    /* CTSDuration_ba */
-		uDurTime = pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
+		uDurTime = pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType,
+							    cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case RTSDUR_BA_F0: /* RTSDuration_ba_f0 */
-		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
+					     pDevice->byTopCCKBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE0][wRate - RATE_18M], bNeedAck);
+			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
+				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+						wFB_Opt0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt1[FB_RATE0][wRate - RATE_18M], bNeedAck);
+			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
+				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+						wFB_Opt1[FB_RATE0][wRate - RATE_18M], bNeedAck);
 
 		break;
 
 	case RTSDUR_AA_F0: /* RTSDuration_aa_f0 */
-		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopOFDMBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
+					     pDevice->byTopOFDMBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE0][wRate - RATE_18M], bNeedAck);
+			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
+				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+						wFB_Opt0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt1[FB_RATE0][wRate - RATE_18M], bNeedAck);
+			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
+				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+						wFB_Opt1[FB_RATE0][wRate - RATE_18M], bNeedAck);
 
 		break;
 
 	case RTSDUR_BA_F1: /* RTSDuration_ba_f1 */
-		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
+					     pDevice->byTopCCKBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE1][wRate - RATE_18M], bNeedAck);
+			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
+				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+						wFB_Opt0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt1[FB_RATE1][wRate - RATE_18M], bNeedAck);
+			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
+				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+						wFB_Opt1[FB_RATE1][wRate - RATE_18M], bNeedAck);
 
 		break;
 
 	case RTSDUR_AA_F1: /* RTSDuration_aa_f1 */
-		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopOFDMBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
+					     pDevice->byTopOFDMBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE1][wRate - RATE_18M], bNeedAck);
+			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
+				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+						wFB_Opt0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt1[FB_RATE1][wRate - RATE_18M], bNeedAck);
+			uDurTime = uCTSTime + 2 * pDevice->uSIFS +
+				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+						wFB_Opt1[FB_RATE1][wRate - RATE_18M], bNeedAck);
 
 		break;
 
 	case CTSDUR_BA_F0: /* CTSDuration_ba_f0 */
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE0][wRate - RATE_18M], bNeedAck);
+			uDurTime = pDevice->uSIFS +
+				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+						wFB_Opt0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt1[FB_RATE0][wRate - RATE_18M], bNeedAck);
+			uDurTime = pDevice->uSIFS +
+				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+						wFB_Opt1[FB_RATE0][wRate - RATE_18M], bNeedAck);
 
 		break;
 
 	case CTSDUR_BA_F1: /* CTSDuration_ba_f1 */
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE1][wRate - RATE_18M], bNeedAck);
+			uDurTime = pDevice->uSIFS +
+				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+						wFB_Opt0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
-			uDurTime = pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt1[FB_RATE1][wRate - RATE_18M], bNeedAck);
+			uDurTime = pDevice->uSIFS +
+				s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength,
+						wFB_Opt1[FB_RATE1][wRate - RATE_18M], bNeedAck);
 
 		break;
 
-- 
2.34.1

