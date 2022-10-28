Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B161E611E19
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJ1XZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJ1XZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:25:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6342413F8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:25:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r12so10655891lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NydDvRv0i8mMT7jRZyJYJbYlAa1+nO5vO7eF1y80kZw=;
        b=E9MqjzSzPc9LhNOmhwtwSVnBeemxoUB7Thg6pwAaJZeP2e+HYMhSC5lLzAAeNG4RMq
         w/7Oz65qQFP5gqVGRHIiDuqPVpBkTjiX0appsBNmWUVQjJLdJl372Q2rAr724GWuCmkz
         LGnJiM3UNXSwtRzyaMS8Ab8CS4naCh3wubvd1r9cPMgWvvmts7qOJGiCt2cSBP0gbMsM
         osmx1kY56Vj5/6VW4UIHBLuFhxOA6KRi4LQpDj7LK7tFZYfdbFydq+8iFhNHDjVomNFn
         Kft3+64eBYN/H9bQStgfzTTmAyFaY328+xE606h4sqIBOBY1vcbTBH+1r5/T/z3VB6gs
         62+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NydDvRv0i8mMT7jRZyJYJbYlAa1+nO5vO7eF1y80kZw=;
        b=VnViwW9NmF4AnqI5VWzUyvm49h6iGNayPaOQuWvtNpevBk9MjFu/w83i2yYWauRVcj
         B82fo6+SXQUPWL2mSqpVK/Jy+a4xO7kJP3xJScixlo+Tvdou+Ak6AVXic5oSj+QbBjyD
         7gCal1FrVanvSy7y9sCsOTyFITiv59yqbNDUOv+wX1DostxQu1SC5Ae1KCyMzY0L6Jx5
         rqXZZov5cxAQ2OKC/puLB+cRKZU1ZYb+tv9qeUXTo0Uz4SC8LKjFoGrAGR4t+pNP2LUG
         XNiI2A3vgvU50Y+W3CpWta1C5983bIxqIYZKIR75OzYJn5WUm+qNxqswiRsU7iwVMkZo
         4WqQ==
X-Gm-Message-State: ACrzQf0Mijq7QTeomGeF/VYTFsgTKGlHMP334ErPrfISqrtgxj3LbV8s
        Sbiv/obs/lIIdQXkEeixsXw2j/iDJ+9VLg==
X-Google-Smtp-Source: AMsMyM4X8FmA5VtSoDrLyrhm1C/ZcmO8HSJPXAv823KLyiFzC3fWpLfTF8xhBgy4yDKUSvMfJGwFhQ==
X-Received: by 2002:a19:c50d:0:b0:4a9:2a57:e236 with SMTP id w13-20020a19c50d000000b004a92a57e236mr574014lfe.263.1666999546845;
        Fri, 28 Oct 2022 16:25:46 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id s2-20020a056512202200b0049aa20af00fsm7064lfs.21.2022.10.28.16.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 16:25:46 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v9 1/6] staging: vt6655: fix lines ending in a '('
Date:   Fri, 28 Oct 2022 23:23:22 +0000
Message-Id: <6742e42999e05ddf09318a0a3bda9ce23b6ae562.1666995639.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666995639.git.tanjubrunostar0@gmail.com>
References: <cover.1666995639.git.tanjubrunostar0@gmail.com>
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

fix several checkpatch errors related to lines ending with a '(' 
by joining some lines of code and indenting properly to improve
visibility

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 165 ++++++++++++++--------------------
 1 file changed, 69 insertions(+), 96 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 1e5036121665..7eb7c6eb5cf0 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -139,15 +139,11 @@ static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
  * PK_TYPE_11GB    2
  * PK_TYPE_11GA    3
  */
-static
-unsigned int
-s_uGetTxRsvTime(
-	struct vnt_private *pDevice,
-	unsigned char byPktType,
-	unsigned int cbFrameLength,
-	unsigned short wRate,
-	bool bNeedAck
-)
+static unsigned int s_uGetTxRsvTime(struct vnt_private *pDevice,
+				    unsigned char byPktType,
+				    unsigned int cbFrameLength,
+				    unsigned short wRate,
+				    bool bNeedAck)
 {
 	unsigned int uDataTime, uAckTime;
 
@@ -214,20 +210,16 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
 }
 
 /* byFreqType 0: 5GHz, 1:2.4Ghz */
-static
-unsigned int
-s_uGetDataDuration(
-	struct vnt_private *pDevice,
-	unsigned char byDurType,
-	unsigned int cbFrameLength,
-	unsigned char byPktType,
-	unsigned short wRate,
-	bool bNeedAck,
-	unsigned int uFragIdx,
-	unsigned int cbLastFragmentSize,
-	unsigned int uMACfragNum,
-	unsigned char byFBOption
-)
+static unsigned int s_uGetDataDuration(struct vnt_private *pDevice,
+				       unsigned char byDurType,
+				       unsigned int cbFrameLength,
+				       unsigned char byPktType,
+				       unsigned short wRate,
+				       bool bNeedAck,
+				       unsigned int uFragIdx,
+				       unsigned int cbLastFragmentSize,
+				       unsigned int uMACfragNum,
+				       unsigned char byFBOption)
 {
 	bool bLastFrag = false;
 	unsigned int uAckTime = 0, uNextPktTime = 0, len;
@@ -316,17 +308,13 @@ s_uGetDataDuration(
 }
 
 /* byFreqType: 0=>5GHZ 1=>2.4GHZ */
-static
-__le16
-s_uGetRTSCTSDuration(
-	struct vnt_private *pDevice,
-	unsigned char byDurType,
-	unsigned int cbFrameLength,
-	unsigned char byPktType,
-	unsigned short wRate,
-	bool bNeedAck,
-	unsigned char byFBOption
-)
+static __le16 s_uGetRTSCTSDuration(struct vnt_private *pDevice,
+				   unsigned char byDurType,
+				   unsigned int cbFrameLength,
+				   unsigned char byPktType,
+				   unsigned short wRate,
+				   bool bNeedAck,
+				   unsigned char byFBOption)
 {
 	unsigned int uCTSTime = 0, uDurTime = 0;
 
@@ -409,22 +397,18 @@ s_uGetRTSCTSDuration(
 	return cpu_to_le16((u16)uDurTime);
 }
 
-static
-__le16
-s_uFillDataHead(
-	struct vnt_private *pDevice,
-	unsigned char byPktType,
-	void *pTxDataHead,
-	unsigned int cbFrameLength,
-	unsigned int uDMAIdx,
-	bool bNeedAck,
-	unsigned int uFragIdx,
-	unsigned int cbLastFragmentSize,
-	unsigned int uMACfragNum,
-	unsigned char byFBOption,
-	unsigned short wCurrentRate,
-	bool is_pspoll
-)
+static __le16 s_uFillDataHead(struct vnt_private *pDevice,
+			      unsigned char byPktType,
+			      void *pTxDataHead,
+			      unsigned int cbFrameLength,
+			      unsigned int uDMAIdx,
+			      bool bNeedAck,
+			      unsigned int uFragIdx,
+			      unsigned int cbLastFragmentSize,
+			      unsigned int uMACfragNum,
+			      unsigned char byFBOption,
+			      unsigned short wCurrentRate,
+			      bool is_pspoll)
 {
 	struct vnt_tx_datahead_ab *buf = pTxDataHead;
 
@@ -555,19 +539,15 @@ s_uFillDataHead(
 	return buf->duration;
 }
 
-static
-void
-s_vFillRTSHead(
-	struct vnt_private *pDevice,
-	unsigned char byPktType,
-	void *pvRTS,
-	unsigned int cbFrameLength,
-	bool bNeedAck,
-	bool bDisCRC,
-	struct ieee80211_hdr *hdr,
-	unsigned short wCurrentRate,
-	unsigned char byFBOption
-)
+static void s_vFillRTSHead(struct vnt_private *pDevice,
+			   unsigned char byPktType,
+			   void *pvRTS,
+			   unsigned int cbFrameLength,
+			   bool bNeedAck,
+			   bool bDisCRC,
+			   struct ieee80211_hdr *hdr,
+			   unsigned short wCurrentRate,
+			   unsigned char byFBOption)
 {
 	unsigned int uRTSFrameLen = 20;
 
@@ -750,19 +730,15 @@ s_vFillRTSHead(
 	}
 }
 
-static
-void
-s_vFillCTSHead(
-	struct vnt_private *pDevice,
-	unsigned int uDMAIdx,
-	unsigned char byPktType,
-	void *pvCTS,
-	unsigned int cbFrameLength,
-	bool bNeedAck,
-	bool bDisCRC,
-	unsigned short wCurrentRate,
-	unsigned char byFBOption
-)
+static void s_vFillCTSHead(struct vnt_private *pDevice,
+			   unsigned int uDMAIdx,
+			   unsigned char byPktType,
+			   void *pvCTS,
+			   unsigned int cbFrameLength,
+			   bool bNeedAck,
+			   bool bDisCRC,
+			   unsigned short wCurrentRate,
+			   unsigned char byFBOption)
 {
 	unsigned int uCTSFrameLen = 14;
 
@@ -868,21 +844,17 @@ s_vFillCTSHead(
  -
  * unsigned int cbFrameSize, Hdr+Payload+FCS
  */
-static
-void
-s_vGenerateTxParameter(
-	struct vnt_private *pDevice,
-	unsigned char byPktType,
-	struct vnt_tx_fifo_head *tx_buffer_head,
-	void *pvRrvTime,
-	void *pvRTS,
-	void *pvCTS,
-	unsigned int cbFrameSize,
-	bool bNeedACK,
-	unsigned int uDMAIdx,
-	void *psEthHeader,
-	unsigned short wCurrentRate
-)
+static void s_vGenerateTxParameter(struct vnt_private *pDevice,
+				   unsigned char byPktType,
+				   struct vnt_tx_fifo_head *tx_buffer_head,
+				   void *pvRrvTime,
+				   void *pvRTS,
+				   void *pvCTS,
+				   unsigned int cbFrameSize,
+				   bool bNeedACK,
+				   unsigned int uDMAIdx,
+				   void *psEthHeader,
+				   unsigned short wCurrentRate)
 {
 	u16 fifo_ctl = le16_to_cpu(tx_buffer_head->fifo_ctl);
 	bool bDisCRC = false;
@@ -954,11 +926,12 @@ s_vGenerateTxParameter(
 	}
 }
 
-static unsigned int
-s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
-		  unsigned char *pbyTxBufferAddr,
-		  unsigned int uDMAIdx, struct vnt_tx_desc *pHeadTD,
-		  unsigned int is_pspoll)
+static unsigned int s_cbFillTxBufHead(struct vnt_private *pDevice,
+				      unsigned char byPktType,
+				      unsigned char *pbyTxBufferAddr,
+				      unsigned int uDMAIdx,
+				      struct vnt_tx_desc *pHeadTD,
+				      unsigned int is_pspoll)
 {
 	struct vnt_td_info *td_info = pHeadTD->td_info;
 	struct sk_buff *skb = td_info->skb;
-- 
2.34.1

