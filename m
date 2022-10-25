Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B3B60D80B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiJYXjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiJYXix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:38:53 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111AB102DDF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:38:26 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o4so14576445ljp.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adPsMdFwSL6bN+PRqyEO9NMGmOAYkX+WohB+bU52QsU=;
        b=RFK2lxvoWSgqEP+BdLH+86oCD5XSSSnP+5BCA1qwL2oRjYI7jxPbLa1fHqZu3HW7ug
         T5cl2Gysve1287anMcBHgAO0T5VK0Ha+WUfqer2+fFFjJUDjmHkbmX9r6lQM48jw9C5r
         ZpRDmI+9W7r2Bs1y8I4SypkNluvFh6ohIe2VKPJq9qYQgA8bAi/yeypPnI8SFkq8BgeY
         LE1lMjHwpkr1C39AgU1tvjwfaM7TQwKI1A5ojSrGfwx+6rrTjE7shtO2dV2htdAupmM4
         NsHprC8Wskiy90yuMITwjHBjljESvmFzcnPyi5o5enuoZ5LRGj197yTkemNU9985DYcY
         z05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adPsMdFwSL6bN+PRqyEO9NMGmOAYkX+WohB+bU52QsU=;
        b=K9MHAfrfZxtGSda1omqnPuFYEgefTeM8QUk+YrceXPirAHKO87Cw+gLXiGRuxJ0N3W
         cL9f80BBq1VIuIzQiEvVIcO/EXXtMyxfdLtfCp8BzP4xPhu4mKL2ydxxd+pcp68DS8Ah
         ewqjdHlPZqih+omP8Sd6RKq0WXabDWA6ip+g5umgK+0YeL0bWkETnZMxhaEypltO0vRD
         6YddPQwhYI0ZND8DvC0ZRi+VmiEMD3UNHZ3KPWHS0Q3LFBC2iy+N0ZvHEXhcuCYTXq5G
         ahSlCn3OCRCB4pXnv/GCNWTqviadEBvhkOoZwx49uJddqMOH/JX9rg/eJnoUlB3tGuUo
         3H9A==
X-Gm-Message-State: ACrzQf2pzgekrWW5JIFlhf0gO2WtFt6x282lqoWfnNw4BFlyaNLE3jnk
        6UaGFslxMbG1mX8swEZGc/6L5NXogcnPlw==
X-Google-Smtp-Source: AMsMyM5hn1X3ZBKXJ+eyK8BQPlYTTlzEpspv1PrW4RQrhbe8FF8ovRbSF6A69SmI9FX8ubG/p3lKEQ==
X-Received: by 2002:a05:651c:1601:b0:25d:744b:cdb5 with SMTP id f1-20020a05651c160100b0025d744bcdb5mr15899425ljq.351.1666741104371;
        Tue, 25 Oct 2022 16:38:24 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:38:20 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 11/17] staging: vt6655: changed variable name: pvRrvTime
Date:   Tue, 25 Oct 2022 23:37:07 +0000
Message-Id: <c9bb2cf45daf6ac5b28b96581d7ad10a2e6431a8.1666740522.git.tanjubrunostar0@gmail.com>
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

change variable names pvRrvTime to meet the
linux coding standard, as it says to avoid using camelCase naming
style. Cought by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 74 +++++++++++++++++------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index fa11677ce119..819080b14d5d 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -98,9 +98,9 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 				     unsigned char by_pkt_type,
 				     struct vnt_tx_fifo_head *,
-				     void *pvRrvTime,
+				     void *pv_rrv_time,
 				     void *pv_rts,
-				     void *pvCTS,
+				     void *pv_cts,
 				     unsigned int	cbFrameSize,
 				     bool bNeedACK,
 				     unsigned int	uDMAIdx,
@@ -820,7 +820,7 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 static void s_vFillCTSHead(struct vnt_private *p_device,
 			   unsigned int uDMAIdx,
 			   unsigned char by_pkt_type,
-			   void *pvCTS,
+			   void *pv_cts,
 			   unsigned int cb_frame_length,
 			   bool b_need_ack,
 			   bool b_dis_crc,
@@ -829,7 +829,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 {
 	unsigned int uCTSFrameLen = 14;
 
-	if (!pvCTS)
+	if (!pv_cts)
 		return;
 
 	if (b_dis_crc) {
@@ -844,7 +844,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 		    uDMAIdx != TYPE_ATIMDMA &&
 		    uDMAIdx != TYPE_BEACONDMA) {
 			/* Auto Fall back */
-			struct vnt_cts_fb *buf = pvCTS;
+			struct vnt_cts_fb *buf = pv_cts;
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(p_device, uCTSFrameLen,
 					  p_device->byTopCCKBasicRate,
@@ -886,7 +886,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 			 * uDMAIdx != TYPE_ATIMDMA &&
 			 * uDMAIdx != TYPE_BEACONDMA)
 			 */
-			struct vnt_cts *buf = pvCTS;
+			struct vnt_cts *buf = pv_cts;
 			/* Get SignalField, ServiceField & Length */
 			vnt_get_phy_field(p_device, uCTSFrameLen,
 					  p_device->byTopCCKBasicRate,
@@ -923,7 +923,7 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
  *      p_device         - Pointer to adapter
  *      pTxDataHead     - Transmit Data Buffer
  *      pTxBufHead      - pTxBufHead
- *      pvRrvTime        - pvRrvTime
+ *      pv_rrv_time        - pv_rrv_time
  *      pv_rts            - RTS Buffer
  *      pCTS            - CTS Buffer
  *      cbFrameSize     - Transmit Data Length (Hdr+Payload+FCS)
@@ -940,9 +940,9 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
 static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 				     unsigned char by_pkt_type,
 				     struct vnt_tx_fifo_head *tx_buffer_head,
-				     void *pvRrvTime,
+				     void *pv_rrv_time,
 				     void *pv_rts,
-				     void *pvCTS,
+				     void *pv_cts,
 				     unsigned int cbFrameSize,
 				     bool bNeedACK,
 				     unsigned int uDMAIdx,
@@ -963,13 +963,13 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 	else if (fifo_ctl & FIFOCTL_AUTO_FB_1)
 		by_fb_option = AUTO_FB_1;
 
-	if (!pvRrvTime)
+	if (!pv_rrv_time)
 		return;
 
 	if (by_pkt_type == PK_TYPE_11GB || by_pkt_type == PK_TYPE_11GA) {
 		if (pv_rts) { /* RTS_need */
 			/* Fill RsvTime */
-			struct vnt_rrv_time_rts *buf = pvRrvTime;
+			struct vnt_rrv_time_rts *buf = pv_rrv_time;
 
 			buf->rts_rrv_time_aa = get_rtscts_time(p_device, 2, by_pkt_type,
 							       cbFrameSize, wCurrentRate);
@@ -986,7 +986,7 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
 					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
 		} else {/* RTS_needless, PCF mode */
-			struct vnt_rrv_time_cts *buf = pvRrvTime;
+			struct vnt_rrv_time_cts *buf = pv_rrv_time;
 
 			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(p_device, by_pkt_type, cbFrameSize,
 								wCurrentRate, bNeedACK);
@@ -997,12 +997,12 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 							       cbFrameSize, wCurrentRate);
 
 			/* Fill CTS */
-			s_vFillCTSHead(p_device, uDMAIdx, by_pkt_type, pvCTS, cbFrameSize, bNeedACK,
-				       b_dis_crc, wCurrentRate, by_fb_option);
+			s_vFillCTSHead(p_device, uDMAIdx, by_pkt_type, pv_cts, cbFrameSize,
+				       bNeedACK, b_dis_crc, wCurrentRate, by_fb_option);
 		}
 	} else if (by_pkt_type == PK_TYPE_11A) {
 		if (pv_rts) {/* RTS_need, non PCF mode */
-			struct vnt_rrv_time_ab *buf = pvRrvTime;
+			struct vnt_rrv_time_ab *buf = pv_rrv_time;
 
 			buf->rts_rrv_time = get_rtscts_time(p_device, 2, by_pkt_type, cbFrameSize,
 							    wCurrentRate);
@@ -1013,14 +1013,14 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
 					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
 		} else if (!pv_rts) {/* RTS_needless, non PCF mode */
-			struct vnt_rrv_time_ab *buf = pvRrvTime;
+			struct vnt_rrv_time_ab *buf = pv_rrv_time;
 
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11A, cbFrameSize,
 							      wCurrentRate, bNeedACK);
 		}
 	} else if (by_pkt_type == PK_TYPE_11B) {
 		if (pv_rts) {/* RTS_need, non PCF mode */
-			struct vnt_rrv_time_ab *buf = pvRrvTime;
+			struct vnt_rrv_time_ab *buf = pv_rrv_time;
 
 			buf->rts_rrv_time = get_rtscts_time(p_device, 0, by_pkt_type, cbFrameSize,
 							    wCurrentRate);
@@ -1031,7 +1031,7 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 			s_v_fill_rts_head(p_device, by_pkt_type, pv_rts, cbFrameSize, bNeedACK,
 					  b_dis_crc, psEthHeader, wCurrentRate, by_fb_option);
 		} else { /* RTS_needless, non PCF mode */
-			struct vnt_rrv_time_ab *buf = pvRrvTime;
+			struct vnt_rrv_time_ab *buf = pv_rrv_time;
 
 			buf->rrv_time = vnt_rxtx_rsvtime_le16(p_device, PK_TYPE_11B, cbFrameSize,
 							      wCurrentRate, bNeedACK);
@@ -1065,10 +1065,10 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 	bool bRTS = (bool)(fifo_ctl & FIFOCTL_RTS);
 	struct vnt_tx_desc *ptdCurr;
 	unsigned int cbHeaderLength = 0;
-	void *pvRrvTime = NULL;
+	void *pv_rrv_time = NULL;
 	struct vnt_mic_hdr *pMICHDR = NULL;
 	void *pv_rts = NULL;
-	void *pvCTS = NULL;
+	void *pv_cts = NULL;
 	void *pvTxDataHd = NULL;
 	unsigned short wTxBufSize;   /* FFinfo size */
 	unsigned char by_fb_option = AUTO_FB_NONE;
@@ -1107,12 +1107,12 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 
 		if (by_fb_option == AUTO_FB_NONE) {
 			if (bRTS) {/* RTS_need */
-				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
+				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_rts));
 				pv_rts = (void *)(pbyTxBufferAddr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_rts) + cbMICHDR);
-				pvCTS = NULL;
+				pv_cts = NULL;
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_rts) +
 						      cbMICHDR + sizeof(struct vnt_rts_g));
@@ -1120,11 +1120,11 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 							cbMICHDR + sizeof(struct vnt_rts_g) +
 							sizeof(struct vnt_tx_datahead_g);
 			} else { /* RTS_needless */
-				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
+				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_cts));
 				pv_rts = NULL;
-				pvCTS = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pv_cts = (void *)(pbyTxBufferAddr + wTxBufSize +
 						  sizeof(struct vnt_rrv_time_cts) + cbMICHDR);
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_cts) + cbMICHDR +
@@ -1136,12 +1136,12 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 		} else {
 			/* Auto Fall Back */
 			if (bRTS) {/* RTS_need */
-				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
+				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_rts));
 				pv_rts = (void *)(pbyTxBufferAddr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_rts) + cbMICHDR);
-				pvCTS = NULL;
+				pv_cts = NULL;
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_rts) +
 					cbMICHDR + sizeof(struct vnt_rts_g_fb));
@@ -1149,11 +1149,11 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 					cbMICHDR + sizeof(struct vnt_rts_g_fb) +
 					sizeof(struct vnt_tx_datahead_g_fb);
 			} else { /* RTS_needless */
-				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
+				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_cts));
 				pv_rts = NULL;
-				pvCTS = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pv_cts = (void *)(pbyTxBufferAddr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_cts) + cbMICHDR);
 				pvTxDataHd = (void  *)(pbyTxBufferAddr + wTxBufSize +
 						       sizeof(struct vnt_rrv_time_cts) +
@@ -1167,12 +1167,12 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 
 		if (by_fb_option == AUTO_FB_NONE) {
 			if (bRTS) {
-				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
+				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_ab));
 				pv_rts = (void *)(pbyTxBufferAddr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_ab) + cbMICHDR);
-				pvCTS = NULL;
+				pv_cts = NULL;
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_ab) + cbMICHDR +
 						      sizeof(struct vnt_rts_ab));
@@ -1180,11 +1180,11 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 					cbMICHDR + sizeof(struct vnt_rts_ab) +
 					sizeof(struct vnt_tx_datahead_ab);
 			} else { /* RTS_needless, need MICHDR */
-				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
+				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_ab));
 				pv_rts = NULL;
-				pvCTS = NULL;
+				pv_cts = NULL;
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_ab) + cbMICHDR);
 				cbHeaderLength = wTxBufSize + sizeof(struct vnt_rrv_time_ab) +
@@ -1193,12 +1193,12 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 		} else {
 			/* Auto Fall Back */
 			if (bRTS) { /* RTS_need */
-				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
+				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_ab));
 				pv_rts = (void *)(pbyTxBufferAddr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_ab) + cbMICHDR);
-				pvCTS = NULL;
+				pv_cts = NULL;
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_ab) + cbMICHDR +
 						      sizeof(struct vnt_rts_a_fb));
@@ -1206,11 +1206,11 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 					cbMICHDR + sizeof(struct vnt_rts_a_fb) +
 					sizeof(struct vnt_tx_datahead_a_fb);
 			} else { /* RTS_needless */
-				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
+				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
 				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_ab));
 				pv_rts = NULL;
-				pvCTS = NULL;
+				pv_cts = NULL;
 				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_ab) + cbMICHDR);
 				cbHeaderLength = wTxBufSize + sizeof(struct vnt_rrv_time_ab) +
@@ -1224,7 +1224,7 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 	memset((void *)(pbyTxBufferAddr + wTxBufSize), 0, (cbHeaderLength - wTxBufSize));
 
 	/* Fill FIFO,RrvTime,RTS,and CTS */
-	s_vgenerate_tx_parameter(p_device, by_pkt_type, tx_buffer_head, pvRrvTime, pv_rts, pvCTS,
+	s_vgenerate_tx_parameter(p_device, by_pkt_type, tx_buffer_head, pv_rrv_time, pv_rts, pv_cts,
 				 cbFrameSize, bNeedACK, uDMAIdx, hdr, p_device->wCurrentRate);
 	/* Fill DataHead */
 	uDuration = s_uFillDataHead(p_device, by_pkt_type, pvTxDataHd, cbFrameSize, uDMAIdx,
-- 
2.34.1

