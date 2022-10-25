Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7460D812
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiJYXkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiJYXjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:39:52 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC035AC7A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:39:29 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bn35so10736266ljb.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE7Qn2LJBw8oRGNZ8jZhcTnY/ucTu/x/xnasCdttkZM=;
        b=FmDhoxwjDUlKlmkONPUz9V7W3/Kwk0CBFEgESZq6/unF/EzolZFw+WJN5jVxi3Ncwl
         hLZjdLWocl5LUzVeJiAqU/2Jwlk9XboIG23o6O/wP1Abgst+20FdUElcenuWVkDZQNir
         DErLib+eOebSw+m7fLcoKhGlP9Bwsmj84kbpwu+OyYLiBMlNz4v6POnqzw0pai5ubyfx
         mQAcFCjpsvRvtfkPiaizKl10eJm3kXvtRRjrlietGwLqcFTr37kcasY/sxq0sld2sDla
         2fiFeQn3B3CZyKo/Ssdv6prq5LOxQcsHcBe9BfVmiHh2is/1eU80o1Wh2uBk9bkrT7tx
         u4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE7Qn2LJBw8oRGNZ8jZhcTnY/ucTu/x/xnasCdttkZM=;
        b=VFgawYwi80p78EcB1plvxuxBGCX9T2L0FJYclRGHpGL46cAokLyp1bjNgNQD0nLgg0
         HcJpzJzn2A/ykp6u6GVHOXOnMYv1QhBKiEUFPDwRSkxhnjupXhrN91/3kBkca0nCQLcd
         YAeTq9hV7pPXPe6tFvf9zhFjNswbfapFJtEU1L+KYP+9LX/rumxLdMgMSRWSmindsUUi
         OtpbeJMuNzn7+nl2vZq98UDaub+9WUAfAWHhxw5Tg4q9JECcFzZgg5BvFUw5srhPmkRo
         P5PbHc2/RVBn86SOKb2GQvyy2OmRSp6WkZnlaShQNzRvjQE2B2JuaGsq3QG0td6nT06K
         Q1fA==
X-Gm-Message-State: ACrzQf3FC6xHyWgT//W8go/3A6lbl7blD4Y3lEecTviKYkCxPkHwSkIp
        t6EixnBA/4Tt7ajHNP5LspE=
X-Google-Smtp-Source: AMsMyM4zV0sl9A0tncbG1gM7BRs6RzCO70UrswQmq/m/SFoU/pIu57Jkzx8UI4lMGwYc2N/JLwTcWA==
X-Received: by 2002:a05:651c:547:b0:26f:d2ef:bccc with SMTP id q7-20020a05651c054700b0026fd2efbcccmr15973015ljp.272.1666741168006;
        Tue, 25 Oct 2022 16:39:28 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:39:25 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 17/17] staging: vt6655: changed variable name: pbyTxBufferAddr
Date:   Tue, 25 Oct 2022 23:37:13 +0000
Message-Id: <c9b3f6bf5a2956613a18071328e693a479638d90.1666740522.git.tanjubrunostar0@gmail.com>
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

change variable names pbyTxBufferAddr to meet the
linux coding standard, as it says to avoid using camelCase naming
style. Cought by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 66 +++++++++++++++++------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 90e7330680d9..da75ae573a00 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -109,7 +109,7 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 
 static unsigned int s_cb_fill_tx_buf_head(struct vnt_private *p_device,
 					  unsigned char by_pkt_type,
-					  unsigned char *pbyTxBufferAddr,
+					  unsigned char *pby_tx_buffer_addr,
 					  unsigned int u_dma_idx,
 					  struct vnt_tx_desc *pHeadTD,
 					  unsigned int uNodeIndex);
@@ -1045,7 +1045,7 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 
 static unsigned int s_cb_fill_tx_buf_head(struct vnt_private *p_device,
 					  unsigned char by_pkt_type,
-					  unsigned char *pbyTxBufferAddr,
+					  unsigned char *pby_tx_buffer_addr,
 					  unsigned int u_dma_idx,
 					  struct vnt_tx_desc *pHeadTD,
 					  unsigned int is_pspoll)
@@ -1111,26 +1111,26 @@ static unsigned int s_cb_fill_tx_buf_head(struct vnt_private *p_device,
 
 		if (by_fb_option == AUTO_FB_NONE) {
 			if (bRTS) {/* RTS_need */
-				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
-				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rrv_time = (void *)(pby_tx_buffer_addr + wTxBufSize);
+				pMICHDR = (struct vnt_mic_hdr *)(pby_tx_buffer_addr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_rts));
-				pv_rts = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rts = (void *)(pby_tx_buffer_addr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_rts) + cbMICHDR);
 				pv_cts = NULL;
-				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pvTxDataHd = (void *)(pby_tx_buffer_addr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_rts) +
 						      cbMICHDR + sizeof(struct vnt_rts_g));
 				cbHeaderLength = wTxBufSize + sizeof(struct vnt_rrv_time_rts) +
 							cbMICHDR + sizeof(struct vnt_rts_g) +
 							sizeof(struct vnt_tx_datahead_g);
 			} else { /* RTS_needless */
-				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
-				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rrv_time = (void *)(pby_tx_buffer_addr + wTxBufSize);
+				pMICHDR = (struct vnt_mic_hdr *)(pby_tx_buffer_addr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_cts));
 				pv_rts = NULL;
-				pv_cts = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pv_cts = (void *)(pby_tx_buffer_addr + wTxBufSize +
 						  sizeof(struct vnt_rrv_time_cts) + cbMICHDR);
-				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pvTxDataHd = (void *)(pby_tx_buffer_addr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_cts) + cbMICHDR +
 						      sizeof(struct vnt_cts));
 				cbHeaderLength = wTxBufSize + sizeof(struct vnt_rrv_time_cts) +
@@ -1140,26 +1140,26 @@ static unsigned int s_cb_fill_tx_buf_head(struct vnt_private *p_device,
 		} else {
 			/* Auto Fall Back */
 			if (bRTS) {/* RTS_need */
-				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
-				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rrv_time = (void *)(pby_tx_buffer_addr + wTxBufSize);
+				pMICHDR = (struct vnt_mic_hdr *)(pby_tx_buffer_addr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_rts));
-				pv_rts = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rts = (void *)(pby_tx_buffer_addr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_rts) + cbMICHDR);
 				pv_cts = NULL;
-				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pvTxDataHd = (void *)(pby_tx_buffer_addr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_rts) +
 					cbMICHDR + sizeof(struct vnt_rts_g_fb));
 				cbHeaderLength = wTxBufSize + sizeof(struct vnt_rrv_time_rts) +
 					cbMICHDR + sizeof(struct vnt_rts_g_fb) +
 					sizeof(struct vnt_tx_datahead_g_fb);
 			} else { /* RTS_needless */
-				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
-				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rrv_time = (void *)(pby_tx_buffer_addr + wTxBufSize);
+				pMICHDR = (struct vnt_mic_hdr *)(pby_tx_buffer_addr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_cts));
 				pv_rts = NULL;
-				pv_cts = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pv_cts = (void *)(pby_tx_buffer_addr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_cts) + cbMICHDR);
-				pvTxDataHd = (void  *)(pbyTxBufferAddr + wTxBufSize +
+				pvTxDataHd = (void  *)(pby_tx_buffer_addr + wTxBufSize +
 						       sizeof(struct vnt_rrv_time_cts) +
 					cbMICHDR + sizeof(struct vnt_cts_fb));
 				cbHeaderLength = wTxBufSize + sizeof(struct vnt_rrv_time_cts) +
@@ -1171,25 +1171,25 @@ static unsigned int s_cb_fill_tx_buf_head(struct vnt_private *p_device,
 
 		if (by_fb_option == AUTO_FB_NONE) {
 			if (bRTS) {
-				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
-				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rrv_time = (void *)(pby_tx_buffer_addr + wTxBufSize);
+				pMICHDR = (struct vnt_mic_hdr *)(pby_tx_buffer_addr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_ab));
-				pv_rts = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rts = (void *)(pby_tx_buffer_addr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_ab) + cbMICHDR);
 				pv_cts = NULL;
-				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pvTxDataHd = (void *)(pby_tx_buffer_addr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_ab) + cbMICHDR +
 						      sizeof(struct vnt_rts_ab));
 				cbHeaderLength = wTxBufSize + sizeof(struct vnt_rrv_time_ab) +
 					cbMICHDR + sizeof(struct vnt_rts_ab) +
 					sizeof(struct vnt_tx_datahead_ab);
 			} else { /* RTS_needless, need MICHDR */
-				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
-				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rrv_time = (void *)(pby_tx_buffer_addr + wTxBufSize);
+				pMICHDR = (struct vnt_mic_hdr *)(pby_tx_buffer_addr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_ab));
 				pv_rts = NULL;
 				pv_cts = NULL;
-				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pvTxDataHd = (void *)(pby_tx_buffer_addr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_ab) + cbMICHDR);
 				cbHeaderLength = wTxBufSize + sizeof(struct vnt_rrv_time_ab) +
 					cbMICHDR + sizeof(struct vnt_tx_datahead_ab);
@@ -1197,25 +1197,25 @@ static unsigned int s_cb_fill_tx_buf_head(struct vnt_private *p_device,
 		} else {
 			/* Auto Fall Back */
 			if (bRTS) { /* RTS_need */
-				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
-				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rrv_time = (void *)(pby_tx_buffer_addr + wTxBufSize);
+				pMICHDR = (struct vnt_mic_hdr *)(pby_tx_buffer_addr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_ab));
-				pv_rts = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rts = (void *)(pby_tx_buffer_addr + wTxBufSize +
 						 sizeof(struct vnt_rrv_time_ab) + cbMICHDR);
 				pv_cts = NULL;
-				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pvTxDataHd = (void *)(pby_tx_buffer_addr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_ab) + cbMICHDR +
 						      sizeof(struct vnt_rts_a_fb));
 				cbHeaderLength = wTxBufSize + sizeof(struct vnt_rrv_time_ab) +
 					cbMICHDR + sizeof(struct vnt_rts_a_fb) +
 					sizeof(struct vnt_tx_datahead_a_fb);
 			} else { /* RTS_needless */
-				pv_rrv_time = (void *)(pbyTxBufferAddr + wTxBufSize);
-				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
+				pv_rrv_time = (void *)(pby_tx_buffer_addr + wTxBufSize);
+				pMICHDR = (struct vnt_mic_hdr *)(pby_tx_buffer_addr + wTxBufSize +
 								 sizeof(struct vnt_rrv_time_ab));
 				pv_rts = NULL;
 				pv_cts = NULL;
-				pvTxDataHd = (void *)(pbyTxBufferAddr + wTxBufSize +
+				pvTxDataHd = (void *)(pby_tx_buffer_addr + wTxBufSize +
 						      sizeof(struct vnt_rrv_time_ab) + cbMICHDR);
 				cbHeaderLength = wTxBufSize + sizeof(struct vnt_rrv_time_ab) +
 					cbMICHDR + sizeof(struct vnt_tx_datahead_a_fb);
@@ -1225,7 +1225,7 @@ static unsigned int s_cb_fill_tx_buf_head(struct vnt_private *p_device,
 
 	td_info->mic_hdr = pMICHDR;
 
-	memset((void *)(pbyTxBufferAddr + wTxBufSize), 0, (cbHeaderLength - wTxBufSize));
+	memset((void *)(pby_tx_buffer_addr + wTxBufSize), 0, (cbHeaderLength - wTxBufSize));
 
 	/* Fill FIFO,RrvTime,RTS,and CTS */
 	s_vgenerate_tx_parameter(p_device, by_pkt_type, tx_buffer_head, pv_rrv_time, pv_rts, pv_cts,
-- 
2.34.1

