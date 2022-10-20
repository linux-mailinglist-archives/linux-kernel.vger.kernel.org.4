Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6132605EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJTLaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiJTLal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:30:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62F11958FC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:30:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b2so33034331lfp.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HlZkA9cMQXxGdkJxrvcIgpC4zTHT7PCGOSCarF98fw=;
        b=Qddp436yqykHlrELlixj3k7NnlnNDEqKzvEbjFUTOqsb4kZr/FoIo7TuVLPE1LB/lp
         AVHcLPErhpjht6pRQ6uTZGC6cM4/RJejveNBDaEBt+SlBZfNr/MzgahIbsbidQOUNwPf
         KqP3hZ0imeFVyj3wqtv0mzCV94GTtTPi1Pd45O0vg334rnq81qrg9rI8xMuXFyna4GIX
         WwOLc6yuKOCXGWSORC8SGgNgOaP7FRGIRb/g/B9Z0BzPfUz9piBNHQRN8daYyxMJZDKL
         V5rUJV35otovgOI7gHWaUOeHPTxIOoRdIG3orBL7e12ssR1PiCsoah2z2lfbI9CdHu3/
         giIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HlZkA9cMQXxGdkJxrvcIgpC4zTHT7PCGOSCarF98fw=;
        b=CBtY56NF09pT5pCQYTac5rHLZ55sTpnpnWlH4+fbi1cVAjOxdHFGg9uD8UF8wejD8C
         mGzRqu+u7++nmdtYCAAhVvTeS26Z8xR470lemGNzG8kvV0cW0vkG9m56hV1jjWC0xfcO
         fTo6qGYzW4uELe0OKav1Wa93PZ6FeGwhdNl0b1HSk2vQgnO1Zrlsw+luL0MNa9pT3VVH
         1vWqR3pMsYBURVAjMpSjVEHT2fW2HLu90Hr1gq0w13evfcXugJdYnoqNCUj0mGKjllT0
         cDUketvf9CinKl7EKRfAo+HneVlU7w6hCmH8uuA829pO6PcaTkmu8lBEes1djE49noSD
         oCYQ==
X-Gm-Message-State: ACrzQf2JWiw2CycX+Bcinv+VaeUGR7p5XcncworPbaMNy17FV2UVjf4y
        aKGND7+S67mdV0YNXTMUKvuEU4A0O/AbpSGB
X-Google-Smtp-Source: AMsMyM5xkAS9ayI6cah9ixTnnB2Rip+uKkfjC69qVdQiWrA2av434aXTqVsInhtUCy6EpyERywbnTQ==
X-Received: by 2002:ac2:5b9b:0:b0:4a2:3d0d:cb47 with SMTP id o27-20020ac25b9b000000b004a23d0dcb47mr5002714lfn.610.1666265437643;
        Thu, 20 Oct 2022 04:30:37 -0700 (PDT)
Received: from elroy-temp-vm ([20.240.130.248])
        by smtp.gmail.com with ESMTPSA id s5-20020a05651c200500b0026ddaf38b0fsm2885429ljo.96.2022.10.20.04.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 04:30:37 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:30:36 +0000
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [PATCH v3] staging: vt6655: Fix Lines should not end with a '('
Message-ID: <Y1ExXEuhV3cJnTiD@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code style warnings reported by checkpatch.
Improve the layout of a function header:
Put the first parameter immediately after the '(' and align the other
parameters underneath it.

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>

---
v2: put static and void on the same line and adjusted the indentation as
suggested by Greg KH
---
v3: Reformat the code by inserting tabs and white space as recommended
by Nam Cao and Julia Lawall

 drivers/staging/vt6655/rxtx.c | 78 +++++++++++++++--------------------
 1 file changed, 33 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 5bdb5176772c..1e5036121665 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -85,35 +85,27 @@ static const unsigned short wFB_Opt1[2][5] = {
 #define DATADUR_A_F1    13
 
 /*---------------------  Static Functions  --------------------------*/
-static
-void
-s_vFillRTSHead(
-	struct vnt_private *pDevice,
-	unsigned char byPktType,
-	void *pvRTS,
-	unsigned int	cbFrameLength,
-	bool bNeedAck,
-	bool bDisCRC,
-	struct ieee80211_hdr *hdr,
-	unsigned short wCurrentRate,
-	unsigned char byFBOption
-);
-
-static
-void
-s_vGenerateTxParameter(
-	struct vnt_private *pDevice,
-	unsigned char byPktType,
-	struct vnt_tx_fifo_head *,
-	void *pvRrvTime,
-	void *pvRTS,
-	void *pvCTS,
-	unsigned int	cbFrameSize,
-	bool bNeedACK,
-	unsigned int	uDMAIdx,
-	void *psEthHeader,
-	unsigned short wCurrentRate
-);
+static void s_vFillRTSHead(struct vnt_private *pDevice,
+			   unsigned char byPktType,
+			   void *pvRTS,
+			   unsigned int	cbFrameLength,
+			   bool bNeedAck,
+			   bool bDisCRC,
+			   struct ieee80211_hdr *hdr,
+			   unsigned short wCurrentRate,
+			   unsigned char byFBOption);
+
+static void s_vGenerateTxParameter(struct vnt_private *pDevice,
+				   unsigned char byPktType,
+				   struct vnt_tx_fifo_head *,
+				   void *pvRrvTime,
+				   void *pvRTS,
+				   void *pvCTS,
+				   unsigned int	cbFrameSize,
+				   bool bNeedACK,
+				   unsigned int	uDMAIdx,
+				   void *psEthHeader,
+				   unsigned short wCurrentRate);
 
 static unsigned int
 s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
@@ -121,22 +113,18 @@ s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
 		  unsigned int uDMAIdx, struct vnt_tx_desc *pHeadTD,
 		  unsigned int uNodeIndex);
 
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
-);
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
+			      bool is_pspoll);
 
 /*---------------------  Export Variables  --------------------------*/
 
-- 
2.34.1

