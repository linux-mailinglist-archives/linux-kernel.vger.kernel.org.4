Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E74608558
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJVHGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 03:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJVHGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 03:06:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C242A79E2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 00:06:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j4so8854965lfk.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 00:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4maC1ewmpW31x1+/ZutwiTXSSsedpc4aQ1ME2Ogiqcg=;
        b=jjxDV72HaiWcEUJCW06k9mJBVN5H6X/Aths+c3EBdFIBlrt3Bf+FfS4Z1/12AfQUZy
         Ap30xeYUHVL8jHCGmoUNnEDePlLL+FojmVbXpCM3sFtA6pH6j5yIZ0sV9TXI5UkkvvEB
         64eVqysV9GN9eTJUEN4HAxEXlga+5dAmITIV3XBbLUP9/QYpXMgvIin0MHjtCOaLoZ3z
         VUHPFt9MiEy4JufBg9JmqN04ao5/u0K1edtoE7mrBNpqOVPCG0Fdhb6Mbh3TXEAn1vMm
         +e9dEFlGoU/HYyFiLFQesma90kTI9qf8vOc0UArXfQcJnHWuXxcDYV2wyiCq4jJcyXqy
         TAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4maC1ewmpW31x1+/ZutwiTXSSsedpc4aQ1ME2Ogiqcg=;
        b=E0Mv+XMUmIm8arP0ZuAGhzHgC9rnUkAGYU5Wue09Jy3uUkYZmn7ifNPOaOjXYRVB1e
         ca6PlS+4yEqGr7vtPMeiDXYNt1cq0Frbp+Li8mbQsDTHfBsnFo8cBTVvvyseUI26uzKA
         MVWXV/kJCdJS3nPe+Pn/cW4sas4GNDZY3/u9yMT4WnAetgDYFy29KgrdaveMTQauVHVU
         mi3LtUJxsLwwOFwsjePUzMV0uxzgX2M0ukMg5h3pafs3A0ZbdGuT5MKkPUs1YU/Ds8Ub
         ntiSYZ2uPYWy5dPsK1fYJHYSqefoC9CHhVqVPzqiWU+xFvtjno9V2UA/5/TeKWiRgGwF
         Em2Q==
X-Gm-Message-State: ACrzQf2bekUOkH4JrKY+rItSCWfRTfPFJk5/NG2jLOXZVmTZUDikggoM
        l0CQkUb1KuJPej8QiGsGjP0=
X-Google-Smtp-Source: AMsMyM6dBV4osBfec7LziKg54FEX6hrZcnfpZDYeW13Gbs0USaCoakMtOybJOnJI2MZ/mXb8d0ER5A==
X-Received: by 2002:ac2:47e1:0:b0:4a2:40e5:781a with SMTP id b1-20020ac247e1000000b004a240e5781amr7805580lfp.335.1666422393414;
        Sat, 22 Oct 2022 00:06:33 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id s5-20020a2e1505000000b00276d2537921sm390404ljd.59.2022.10.22.00.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 00:06:33 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v3 1/6] staging: vt6655: fix lines ending in a '('
Date:   Sat, 22 Oct 2022 07:06:07 +0000
Message-Id: <20221022070612.13009-2-tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221022070612.13009-1-tanjubrunostar0@gmail.com>
References: <20221022070612.13009-1-tanjubrunostar0@gmail.com>
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

fix serveral checkpatch errors related to lines ending with a '(' by
refactoring the code lines

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 149 ++++++++++++++--------------------
 1 file changed, 63 insertions(+), 86 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 1e5036121665..f9d0b00d7cff 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -141,13 +141,11 @@ static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
  */
 static
 unsigned int
-s_uGetTxRsvTime(
-	struct vnt_private *pDevice,
-	unsigned char byPktType,
-	unsigned int cbFrameLength,
-	unsigned short wRate,
-	bool bNeedAck
-)
+s_uGetTxRsvTime(struct vnt_private *pDevice,
+		unsigned char byPktType,
+		unsigned int cbFrameLength,
+		unsigned short wRate,
+		bool bNeedAck)
 {
 	unsigned int uDataTime, uAckTime;
 
@@ -215,19 +213,16 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
 
 /* byFreqType 0: 5GHz, 1:2.4Ghz */
 static
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
+unsigned int s_uGetDataDuration(struct vnt_private *pDevice,
+				unsigned char byDurType,
+				unsigned int cbFrameLength,
+				unsigned char byPktType,
+				unsigned short wRate,
+				bool bNeedAck,
+				unsigned int uFragIdx,
+				unsigned int cbLastFragmentSize,
+				unsigned int uMACfragNum,
+				unsigned char byFBOption)
 {
 	bool bLastFrag = false;
 	unsigned int uAckTime = 0, uNextPktTime = 0, len;
@@ -316,17 +311,13 @@ s_uGetDataDuration(
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
 
@@ -409,22 +400,18 @@ s_uGetRTSCTSDuration(
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
 
@@ -555,19 +542,15 @@ s_uFillDataHead(
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
 
@@ -752,17 +735,15 @@ s_vFillRTSHead(
 
 static
 void
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
+s_vFillCTSHead(struct vnt_private *pDevice,
+	       unsigned int uDMAIdx,
+	       unsigned char byPktType,
+	       void *pvCTS,
+	       unsigned int cbFrameLength,
+	       bool bNeedAck,
+	       bool bDisCRC,
+	       unsigned short wCurrentRate,
+	       unsigned char byFBOption)
 {
 	unsigned int uCTSFrameLen = 14;
 
@@ -868,21 +849,17 @@ s_vFillCTSHead(
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
-- 
2.34.1

