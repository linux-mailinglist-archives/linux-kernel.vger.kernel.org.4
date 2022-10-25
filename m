Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4996E60D80A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiJYXjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiJYXip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:38:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF1F101E12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:38:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j4so25421307lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lBB9ttth4eSvyWXw/F4NyKEvhAfegcmcryN6aA811E=;
        b=iWjbB1MkJ8RdSGc1z4wf+4T1ykM7kFl5KvHpIftG9RAiamzCimo1+PPA58KNIfOF9k
         zN/2StTMzeXZg6QWr0FRwCHL75FDBNEwS6V8xSMBJg8ie7w/QlTIjyLcg/k0KjeaTNuU
         an7NAL6mwIXVorwvVF7/MU5qPbPDMmaEucLxXyDPETHvEkkzo9Z/J+SBToqqT42MX1od
         VCuyJ+HSoL1w8774Br39u2PBO26YO22OdM9UBJPBB1xKajeerVm2Jh9FtZN0+6x1e2Nv
         pobkJqamcVygUlnU6Y4uxhHwjW75iL2DUJYnLTFqxJMKr4l8qyFSnsrNuQgws0gn5Bm2
         4GjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lBB9ttth4eSvyWXw/F4NyKEvhAfegcmcryN6aA811E=;
        b=Xu6vT1/CvQrfIsRtn45hY3Dl8ot8ILSMZ+M3ZcrKw/TKGOwPXRNLWKC26px2oLn2vx
         QMtX8pV3RlsnUTomPLKDqtS7If5GVvQFCfkzR7l0O9YsjsHeM1cEmcMd7LPjjcUlUXyS
         5h3Pbuz1iOEq3PatvPuEwV5Yxjpyrkdak9tnAdOSQT4LukOGijRn8e9BBE49OaWaZRVN
         hX9XITJ6PSsq/GZ3BsKYRE1rgRQhQehlmI40+GoqIm71H1ofib9ll5S+NLGDPi8gtuTE
         aztXzk8H7gaPUA7LgeOO5xpGskkO+8HsrzSJyvAmOGDJKyWHJMj+N4KAfPVuPkwtSql7
         i77A==
X-Gm-Message-State: ACrzQf374oH00/nxH+CvhiiUXwJoYcpbHxsBE6SPk4KvdYvty+1apSPg
        BoNxnyc2pAXp7z+NwDGgdwA=
X-Google-Smtp-Source: AMsMyM6hKY1Be5hoWquevsFoyovMmI3SbUuUpyGkvJLYhauoAYKbzJI171InzQXsBuI4ozqn5bZyAQ==
X-Received: by 2002:ac2:5e35:0:b0:4a4:754f:e2d5 with SMTP id o21-20020ac25e35000000b004a4754fe2d5mr16858525lfg.77.1666741099189;
        Tue, 25 Oct 2022 16:38:19 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05651c119100b0026daf4fc0f7sm701969ljo.92.2022.10.25.16.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:37:57 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH 10/17] staging: vt6655: changed variable name: s_vGenerateTxParameter
Date:   Tue, 25 Oct 2022 23:37:06 +0000
Message-Id: <1663fb051fe1a25189bb578e1e6bcde7f9ad39d4.1666740522.git.tanjubrunostar0@gmail.com>
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

change variable names s_vGenerateTxParameter to meet the
linux coding standard, as it says to avoid using camelCase naming
style. Cought by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 63 ++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 3d28cbfec618..fa11677ce119 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -10,7 +10,7 @@
  * Date: May 20, 2003
  *
  * Functions:
- *      s_vGenerateTxParameter - Generate tx dma required parameter.
+ *      s_vgenerate_tx_parameter - Generate tx dma required parameter.
  *      vGenerateMACHeader - Translate 802.3 to 802.11 header
  *      cbGetFragCount - Calculate fragment number count
  *      csBeacon_xmit - beacon tx function
@@ -95,23 +95,24 @@ static void s_v_fill_rts_head(struct vnt_private *p_device,
 			      unsigned short wCurrentRate,
 			      unsigned char by_fb_option);
 
-static void s_vGenerateTxParameter(struct vnt_private *p_device,
-				   unsigned char by_pkt_type,
-				   struct vnt_tx_fifo_head *,
-				   void *pvRrvTime,
-				   void *pv_rts,
-				   void *pvCTS,
-				   unsigned int	cbFrameSize,
-				   bool bNeedACK,
-				   unsigned int	uDMAIdx,
-				   void *psEthHeader,
-				   unsigned short wCurrentRate);
-
-static unsigned int
-s_cbFillTxBufHead(struct vnt_private *p_device, unsigned char by_pkt_type,
-		  unsigned char *pbyTxBufferAddr,
-		  unsigned int uDMAIdx, struct vnt_tx_desc *pHeadTD,
-		  unsigned int uNodeIndex);
+static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
+				     unsigned char by_pkt_type,
+				     struct vnt_tx_fifo_head *,
+				     void *pvRrvTime,
+				     void *pv_rts,
+				     void *pvCTS,
+				     unsigned int	cbFrameSize,
+				     bool bNeedACK,
+				     unsigned int	uDMAIdx,
+				     void *psEthHeader,
+				     unsigned short wCurrentRate);
+
+static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
+				      unsigned char by_pkt_type,
+				      unsigned char *pbyTxBufferAddr,
+				      unsigned int uDMAIdx,
+				      struct vnt_tx_desc *pHeadTD,
+				      unsigned int uNodeIndex);
 
 static __le16 s_uFillDataHead(struct vnt_private *p_device,
 			      unsigned char by_pkt_type,
@@ -936,17 +937,17 @@ static void s_vFillCTSHead(struct vnt_private *p_device,
  -
  * unsigned int cbFrameSize, Hdr+Payload+FCS
  */
-static void s_vGenerateTxParameter(struct vnt_private *p_device,
-				   unsigned char by_pkt_type,
-				   struct vnt_tx_fifo_head *tx_buffer_head,
-				   void *pvRrvTime,
-				   void *pv_rts,
-				   void *pvCTS,
-				   unsigned int cbFrameSize,
-				   bool bNeedACK,
-				   unsigned int uDMAIdx,
-				   void *psEthHeader,
-				   unsigned short wCurrentRate)
+static void s_vgenerate_tx_parameter(struct vnt_private *p_device,
+				     unsigned char by_pkt_type,
+				     struct vnt_tx_fifo_head *tx_buffer_head,
+				     void *pvRrvTime,
+				     void *pv_rts,
+				     void *pvCTS,
+				     unsigned int cbFrameSize,
+				     bool bNeedACK,
+				     unsigned int uDMAIdx,
+				     void *psEthHeader,
+				     unsigned short wCurrentRate)
 {
 	u16 fifo_ctl = le16_to_cpu(tx_buffer_head->fifo_ctl);
 	bool b_dis_crc = false;
@@ -1223,8 +1224,8 @@ static unsigned int s_cbFillTxBufHead(struct vnt_private *p_device,
 	memset((void *)(pbyTxBufferAddr + wTxBufSize), 0, (cbHeaderLength - wTxBufSize));
 
 	/* Fill FIFO,RrvTime,RTS,and CTS */
-	s_vGenerateTxParameter(p_device, by_pkt_type, tx_buffer_head, pvRrvTime, pv_rts, pvCTS,
-			       cbFrameSize, bNeedACK, uDMAIdx, hdr, p_device->wCurrentRate);
+	s_vgenerate_tx_parameter(p_device, by_pkt_type, tx_buffer_head, pvRrvTime, pv_rts, pvCTS,
+				 cbFrameSize, bNeedACK, uDMAIdx, hdr, p_device->wCurrentRate);
 	/* Fill DataHead */
 	uDuration = s_uFillDataHead(p_device, by_pkt_type, pvTxDataHd, cbFrameSize, uDMAIdx,
 				    bNeedACK, 0, 0, uMACfragNum, by_fb_option,
-- 
2.34.1

