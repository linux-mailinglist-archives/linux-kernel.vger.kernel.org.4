Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5975C60D810
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiJYXkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiJYXjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:39:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAF330E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:39:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bp15so25263852lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gmfQ841LKpP9QCVyPPMnd2eQzGH1p8rgK8Y5XRomgo=;
        b=YTmuRZFIcZVli7zhVelVT0g3PfnT8wjxDyEkrrLfyX+5+HGECvthmVBGulRNFLMoCo
         eSusTOBklBWWHLazqKRF9Z0ksJUaCQ/PdBuZKmnY1Uu2AZ9PuLXlx9+w0ORQZpu3aiJ+
         Luac4gPX2tInIseUdN1qHkoUaljhESq15Bm/V6lBVPTbj3fza9rhaK6tbnKdmNQ7/U9t
         dkUPVnC26YINzefoOmjFhtrypAgFmrtxOYl1JlDdNQ/HF1oNxKTaG1UfrW50H/6vtJ1H
         sUOMkq73xvpNUY/lD/kBWflPyN9xmKCe9sVKAZV/3Ute3dhwsSylSADqqGASqWVUAdk0
         gXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gmfQ841LKpP9QCVyPPMnd2eQzGH1p8rgK8Y5XRomgo=;
        b=V1kdIlmqkuW7DEyBbMjP2GKPjsBV7cV84uUFr1ZSnXNMc1B4N3brhHiMcAgNF26DH7
         kRQ6A+kXYu0nrvrbt/RFEL31hmm4yEjzT1QB92WcVfEz06gGHWA2r8W0tmARskbtL/hn
         asViJIKsfgk/haqhDaZOv916N7PcYOw+YraAKkak8H7suao06N2664RL2uBmz6eiKn4H
         CPTJ8YVMp87CInrgcYdmrJlFXjAe5c0ZuycRlb0iMwsDpyO9Fln6On7B/y2FlV2r+HqX
         g3nyX4qCPiXtZTAApezzQthOHYqI0KByhocLcW6dVFbdySA776LdWVVGHWCTDYEUrtJO
         XWBA==
X-Gm-Message-State: ACrzQf2Muo/a+Y3oJtqbrOXJpVZ5I3sdE1oBPRe+QGmaXv3AeIlux4eR
        AZj8m7XrOs/37AMMSJCOBr0=
X-Google-Smtp-Source: AMsMyM7xnOhYklUk/L6qn+lAmcei5pXO3NUS6ORAguJHkjet9pjpysYnr5824VxiKOFXUeyqvIjDyg==
X-Received: by 2002:a05:6512:340f:b0:4a2:a946:613e with SMTP id i15-20020a056512340f00b004a2a946613emr16309543lfr.230.1666741162864;
        Tue, 25 Oct 2022 16:39:22 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:39:20 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 16/17] staging: vt6655: changed variable name: s_cbFillTxBufHead
Date:   Tue, 25 Oct 2022 23:37:12 +0000
Message-Id: <f1e8c3693937ab4d2d7c9765cea1432fa6000df1.1666740522.git.tanjubrunostar0@gmail.com>
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

change variable names s_cbFillTxBufHead to meet the
linux coding standard, as it says to avoid using camelCase naming
style. Cought by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 6a54f234261a..90e7330680d9 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -15,7 +15,7 @@
  *      cbGetFragCount - Calculate fragment number count
  *      csBeacon_xmit - beacon tx function
  *      csMgmt_xmit - management tx function
- *      s_cbFillTxBufHead - fulfill tx dma buffer header
+ *      s_cb_fill_tx_buf_head - fulfill tx dma buffer header
  *      s_uGetDataDuration - get tx data required duration
  *      s_uFillDataHead- fulfill tx data duration header
  *      s_uGetRTSCTSDuration- get rtx/cts required duration
@@ -107,12 +107,12 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 				     void *ps_eth_header,
 				     unsigned short wCurrentRate);
 
-static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
-				      unsigned char by_pkt_type,
-				      unsigned char *pbyTxBufferAddr,
-				      unsigned int u_dma_idx,
-				      struct vnt_tx_desc *pHeadTD,
-				      unsigned int uNodeIndex);
+static unsigned int s_cb_fill_tx_buf_head(struct vnt_private *p_device,
+					  unsigned char by_pkt_type,
+					  unsigned char *pbyTxBufferAddr,
+					  unsigned int u_dma_idx,
+					  struct vnt_tx_desc *pHeadTD,
+					  unsigned int uNodeIndex);
 
 static __le16 s_uFillDataHead(struct vnt_private *p_device,
 			      unsigned char by_pkt_type,
@@ -1043,12 +1043,12 @@ static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
 	}
 }
 
-static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
-				      unsigned char by_pkt_type,
-				      unsigned char *pbyTxBufferAddr,
-				      unsigned int u_dma_idx,
-				      struct vnt_tx_desc *pHeadTD,
-				      unsigned int is_pspoll)
+static unsigned int s_cb_fill_tx_buf_head(struct vnt_private *p_device,
+					  unsigned char by_pkt_type,
+					  unsigned char *pbyTxBufferAddr,
+					  unsigned int u_dma_idx,
+					  struct vnt_tx_desc *pHeadTD,
+					  unsigned int is_pspoll)
 {
 	struct vnt_td_info *td_info = pHeadTD->td_info;
 	struct sk_buff *skb = td_info->skb;
@@ -1442,8 +1442,8 @@ int vnt_generate_fifo_header(struct vnt_private *priv, u32 dma_idx,
 
 	tx_buffer_head->frag_ctl |= cpu_to_le16(FRAGCTL_NONFRAG);
 
-	s_cbFillTxBufHead(priv, pkt_type, (u8 *)tx_buffer_head,
-			  dma_idx, head_td, is_pspoll);
+	s_cb_fill_tx_buf_head(priv, pkt_type, (u8 *)tx_buffer_head,
+			      dma_idx, head_td, is_pspoll);
 
 	if (info->control.hw_key) {
 		tx_key = info->control.hw_key;
-- 
2.34.1

