Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4AB60D805
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiJYXiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiJYXhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:37:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD80FBCE4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f37so25279934lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIL7hs0OLEXS53X2Oc0txigmp9eqeR1FsRtjuja64LE=;
        b=SX2PETI8yg6/z0hzhnzoaQ6p83+ugQFMryOzbtKkrGBuF83p6LpQJ+p6i0OTGd2JUV
         vqhWpnQNdYYhJtUBAIhKPKrFWwtYC3wfCLfxhzAEIyG4zKmr5xxun/jFjcwqG7rgTd6W
         vBf+AO22Sz62zJazOq0swtREV8KOo2lYugCmBSvQdX3kxh3E5XOn6Z6wnpc54I8JXe1u
         VC8ErfUEEk4Rgo6QVqJE7iWXDOB6RRw0LQDqLA6mvarw7DVSueDbqnB6iZRml0l/HI2X
         aPrVfBV4jz46hSp4LM7CYq+MaJbdAFrAgRNxnPrxBamPV51a0i9NbEHCbimhhTcCIoRg
         A6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIL7hs0OLEXS53X2Oc0txigmp9eqeR1FsRtjuja64LE=;
        b=kE0UmStH1JmaD3V+dUCkqS8E6ZylrCLWBoNDKmWeOj+SJ77EFjidjx+zHdU15noX/S
         Dcoh1eWaAT6gfmN3xaUoMZXtGdV6F7t6ZFcxfYxSbNoQokO3iztHwpgcpIpahoikACF6
         4AQBnrltI+8yT9DuEJyjna1QJKFP6j7SD699NrltdeUFi1sY15FtwQiAf+Q1VlAtc7Cw
         SwvNI1mD2sv1LpS1IX98x7FGKdYTRa5J2csZ3HU07QBO6tOdGjVrJAYOJlSVTjwfE7uX
         +6JSzYBx3RT8V/Qp3PRTrtcRv5g0KaouBmgDSS9COvTc99BdVrIN9uKOmkSwQ/jYai58
         QQhA==
X-Gm-Message-State: ACrzQf2edhPHWVeHteq2h/RADgeC0mJj9QxPbaUIzzXh9DmAkkKnqaB6
        0OmaiCPsWBNH575FeAxI5zA=
X-Google-Smtp-Source: AMsMyM6m+P1aW4KvgKvgzx5s3B8cYmoIyN5cMvlq6Jg4RBpEQsZnplv+joIkRcnyUNFrC7aOXfS84g==
X-Received: by 2002:a05:6512:2153:b0:4a2:9c69:ab4b with SMTP id s19-20020a056512215300b004a29c69ab4bmr15576767lfr.459.1666741068903;
        Tue, 25 Oct 2022 16:37:48 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:37:48 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 05/17] staging: vt6655: changed variable name: pvRTS
Date:   Tue, 25 Oct 2022 23:37:01 +0000
Message-Id: <47da976cd02d262cebe520b21a0bf2451de6731b.1666740522.git.tanjubrunostar0@gmail.com>
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

	change variable names pvRTS to meet the
        linux coding standard, as it says to avoid using camelCase naming
        style. Cought by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 56 +++++++++++++++++------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 2cac8f3882df..e97cba014adf 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -87,7 +87,7 @@ static const unsigned short w_fb_opt_1[2][5] = {
 /*---------------------  Static Functions  --------------------------*/
 static void s_v_fill_rts_head(struct vnt_private *p_device,
 			      unsigned char by_pkt_type,
-			      void *pvRTS,
+			      void *pv_rts,
 			      unsigned int	cbFrameLength,
 			      bool bNeedAck,
 			      bool bDisCRC,
@@ -99,7 +99,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 				   unsigned char by_pkt_type,
 				   struct vnt_tx_fifo_head *,
 				   void *pvRrvTime,
-				   void *pvRTS,
+				   void *pv_rts,
 				   void *pvCTS,
 				   unsigned int	cbFrameSize,
 				   bool bNeedACK,
@@ -622,7 +622,7 @@ static __le16 s_uFillDataHead(struct vnt_private *p_device,
 
 static void s_v_fill_rts_head(struct vnt_private *p_device,
 			      unsigned char by_pkt_type,
-			      void *pvRTS,
+			      void *pv_rts,
 			      unsigned int cbFrameLength,
 			      bool bNeedAck,
 			      bool bDisCRC,
@@ -632,7 +632,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 {
 	unsigned int uRTSFrameLen = 20;
 
-	if (!pvRTS)
+	if (!pv_rts)
 		return;
 
 	if (bDisCRC) {
@@ -648,7 +648,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 	 */
 	if (by_pkt_type == PK_TYPE_11GB || by_pkt_type == PK_TYPE_11GA) {
 		if (byFBOption == AUTO_FB_NONE) {
-			struct vnt_rts_g *buf = pvRTS;
+			struct vnt_rts_g *buf = pv_rts;
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(p_device, uRTSFrameLen,
 					  p_device->byTopCCKBasicRate,
@@ -683,7 +683,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			ether_addr_copy(buf->data.ra, hdr->addr1);
 			ether_addr_copy(buf->data.ta, hdr->addr2);
 		} else {
-			struct vnt_rts_g_fb *buf = pvRTS;
+			struct vnt_rts_g_fb *buf = pv_rts;
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(p_device, uRTSFrameLen,
 					  p_device->byTopCCKBasicRate,
@@ -739,7 +739,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 		} /* if (byFBOption == AUTO_FB_NONE) */
 	} else if (by_pkt_type == PK_TYPE_11A) {
 		if (byFBOption == AUTO_FB_NONE) {
-			struct vnt_rts_ab *buf = pvRTS;
+			struct vnt_rts_ab *buf = pv_rts;
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(p_device, uRTSFrameLen,
 					  p_device->byTopOFDMBasicRate,
@@ -759,7 +759,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			ether_addr_copy(buf->data.ra, hdr->addr1);
 			ether_addr_copy(buf->data.ta, hdr->addr2);
 		} else {
-			struct vnt_rts_a_fb *buf = pvRTS;
+			struct vnt_rts_a_fb *buf = pv_rts;
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(p_device, uRTSFrameLen,
 					  p_device->byTopOFDMBasicRate,
@@ -790,7 +790,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			ether_addr_copy(buf->data.ta, hdr->addr2);
 		}
 	} else if (by_pkt_type == PK_TYPE_11B) {
-		struct vnt_rts_ab *buf = pvRTS;
+		struct vnt_rts_ab *buf = pv_rts;
 		/* Get SignalField, ServiceField & Length */
 		vnt_get_phy_field(p_device, uRTSFrameLen,
 				  p_device->byTopCCKBasicRate,
@@ -918,7 +918,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
  *      pTxDataHead     - Transmit Data Buffer
  *      pTxBufHead      - pTxBufHead
  *      pvRrvTime        - pvRrvTime
- *      pvRTS            - RTS Buffer
+ *      pv_rts            - RTS Buffer
  *      pCTS            - CTS Buffer
  *      cbFrameSize     - Transmit Data Length (Hdr+Payload+FCS)
  *      bNeedACK        - If need ACK
@@ -935,7 +935,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 				   unsigned char by_pkt_type,
 				   struct vnt_tx_fifo_head *tx_buffer_head,
 				   void *pvRrvTime,
-				   void *pvRTS,
+				   void *pv_rts,
 				   void *pvCTS,
 				   unsigned int cbFrameSize,
 				   bool bNeedACK,
@@ -961,7 +961,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 		return;
 
 	if (by_pkt_type == PK_TYPE_11GB || by_pkt_type == PK_TYPE_11GA) {
-		if (pvRTS) { /* RTS_need */
+		if (pv_rts) { /* RTS_need */
 			/* Fill RsvTime */
 			struct vnt_rrv_time_rts *buf = pvRrvTime;
 
@@ -977,7 +977,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 								p_device->byTopCCKBasicRate,
 								bNeedACK);
 
-			s_v_fill_rts_head(p_device, by_pkt_type, pvRTS, cbFrameSize, bNeedACK,
+			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
 					  bDisCRC, psEthHeader, wCurrentRate, byFBOption);
 		} else {/* RTS_needless, PCF mode */
 			struct vnt_rrv_time_cts *buf = pvRrvTime;
@@ -995,7 +995,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 				       bDisCRC, wCurrentRate, byFBOption);
 		}
 	} else if (by_pkt_type == PK_TYPE_11A) {
-		if (pvRTS) {/* RTS_need, non PCF mode */
+		if (pv_rts) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
 			buf->rts_rrv_time = get_rtscts_time(p_device, 2, by_pkt_type, cbFrameSize,
@@ -1004,16 +1004,16 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 							      wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_v_fill_rts_head(p_device, by_pkt_type, pvRTS, cbFrameSize, bNeedACK,
+			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
 					  bDisCRC, psEthHeader, wCurrentRate, byFBOption);
-		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
+		} else if (!pv_rts) {/* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11A, cbFrameSize,
 							      wCurrentRate, bNeedACK);
 		}
 	} else if (by_pkt_type == PK_TYPE_11B) {
-		if (pvRTS) {/* RTS_need, non PCF mode */
+		if (pv_rts) {/* RTS_need, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
 
 			buf->rts_rrv_time = get_rtscts_time(p_device, 0, by_pkt_type, cbFrameSize,
@@ -1022,7 +1022,7 @@ static void s_vGenerateTxParameter(struct vnt_private *p_device,
 							      wCurrentRate, bNeedACK);
 
 			/* Fill RTS */
-			s_v_fill_rts_head(p_device, by_pkt_type, pvRTS, cbFrameSize, bNeedACK,
+			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
 					  bDisCRC, psEthHeader, wCurrentRate, byFBOption);
 		} else { /* RTS_needless, non PCF mode */
 			struct vnt_rrv_time_ab *buf = pvRrvTime;
@@ -1061,7 +1061,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 	unsigned int cbHeaderLength = 0;
 	void *pvRrvTime = NULL;
 	struct vnt_mic_hdr *pMICHDR = NULL;
-	void *pvRTS = NULL;
+	void *pv_rts = NULL;
 	void *pvCTS = NULL;
 	void *pvTxDataHd = NULL;
 	unsigned short wTxBufSize;   /* FFinfo size */
@@ -1104,7 +1104,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_rts));
-				pvRTS = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rts = (void *)(pbyTxBufferAddr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_rts) + cbMICHDR);
 				pvCTS = NULL;
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
@@ -1117,7 +1117,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_cts));
-				pvRTS = NULL;
+				pv_rts = NULL;
 				pvCTS = (void *)(pbyTxBufferAddr + wTxBufSize +
 						  sizeof(struct vnt_rrv_time_cts) + cbMICHDR);
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
@@ -1133,7 +1133,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_rts));
-				pvRTS = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rts = (void *)(pbyTxBufferAddr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_rts) + cbMICHDR);
 				pvCTS = NULL;
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
@@ -1146,7 +1146,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_cts));
-				pvRTS = NULL;
+				pv_rts = NULL;
 				pvCTS = (void *)(pbyTxBufferAddr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_cts) + cbMICHDR);
 				pvTxDataHd = (void  *)(pbyTxBufferAddr + wTxBufSize +
@@ -1164,7 +1164,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_ab));
-				pvRTS = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rts = (void *)(pbyTxBufferAddr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_ab) + cbMICHDR);
 				pvCTS = NULL;
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
@@ -1177,7 +1177,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_ab));
-				pvRTS = NULL;
+				pv_rts = NULL;
 				pvCTS = NULL;
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_ab) + cbMICHDR);
@@ -1190,7 +1190,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_ab));
-				pvRTS = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rts = (void *)(pbyTxBufferAddr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_ab) + cbMICHDR);
 				pvCTS = NULL;
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
@@ -1203,7 +1203,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_ab));
-				pvRTS = NULL;
+				pv_rts = NULL;
 				pvCTS = NULL;
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_ab) + cbMICHDR);
@@ -1218,7 +1218,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 	memset((void *)(pbyTxBufferAddr + wTxBufSize), 0, (cbHeaderLength - wTxBufSize));
 
 	/* Fill FIFO,RrvTime,RTS,and CTS */
-	s_vGenerateTxParameter(p_device, by_pkt_type, tx_buffer_head, pvRrvTime, pvRTS, pvCTS,
+	s_vGenerateTxParameter(p_device, by_pkt_type, tx_buffer_head, pvRrvTime, pv_rts, pvCTS,
 			       cbFrameSize, bNeedACK, uDMAIdx, hdr, p_device->wCurrentRate);
 	/* Fill DataHead */
 	uDuration = s_uFillDataHead(p_device, by_pkt_type, pvTxDataHd, cbFrameSize, uDMAIdx,
-- 
2.34.1

