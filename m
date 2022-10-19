Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D9D604CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiJSQGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiJSQGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:06:31 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084E5150F8C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:05:09 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r22so22767851ljn.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YCDHsYWcIY96mUtSqodHKe31qpMLaWDuKz478pSr00=;
        b=KHhsVmAmNGZintp/YIDAd4pSn0E5e4hSFuGvoY3fG+1VV7PhE59oWENJD8FG30TEEr
         0ilGqC28Ik/psjVonwjvg6NUDSasG8ZN0rYkQepcXQrRdA1IfXqweE6Oc9Z7ZlD2s4WS
         XNZUohjsBfohMb9ulzAdIq+6ukXKwPMby4m5bpGY43zRnf7RSCvK3lrX4U3Gcj+2I2bw
         V+heCQ3Huv6aFh6iRdVogsawozkdU0dKgJh9KhUgVsoLAr5P0oO7CzHtUiMS8aT7NDmR
         5GSfkUadveG1N/RNPalqsJPUwO9rI4cetSRu7q+suD6YvwYLCPSRdlxEjkmEda/Tl2ZG
         IRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YCDHsYWcIY96mUtSqodHKe31qpMLaWDuKz478pSr00=;
        b=yFPMT4AoPw04EW1NX6VY8K3Yn+uzHHBaJivms9TVjJ4CTQL6HfeyK2BULtcJihnrUQ
         k81hQL1ofdUxbD+WSGmEogHSRSPMVXi1yweU2g7pbGsmq6I/CoY7GjWwVx+dfVuSSSmH
         lQyZ8I1jdnDd0shF5VPJ8pGrXSJDBFgw92Kmct7rV8Lf6WnOvlP1l9QOoAZTiUgxQN+W
         48wKgqk5VJXbEBueeQdynXjuT84ETMNQPR/7YfstE8FLPNi9SUFCaisOClfWGIdkYeu/
         0ET3o1dhOCsMHXR2Pl9kWjmlLHPtDQGSYriCUu+xM3TQiuSb2hdVZ+GLZpUWct4doYzU
         D2+w==
X-Gm-Message-State: ACrzQf3R3wsGcW0lYMwN/ODiNP3osSp2yiMUoJBIAWYz/3soIptwwkdC
        UIMPs+t3+hO/0ujLSnoyCqSyq0YRNnJhug==
X-Google-Smtp-Source: AMsMyM6fO5UYQBYujCKvc6CqltqY94UNh41cSyMFXrGhpAbyftVmOEivr9+vv8IHfUrxjlCqIyuwKA==
X-Received: by 2002:a05:651c:88e:b0:26d:dd92:73e7 with SMTP id d14-20020a05651c088e00b0026ddd9273e7mr3094859ljq.503.1666195507195;
        Wed, 19 Oct 2022 09:05:07 -0700 (PDT)
Received: from elroy-temp-vm ([20.240.130.248])
        by smtp.gmail.com with ESMTPSA id g3-20020a056512118300b0049876c1bb24sm2337411lfr.225.2022.10.19.09.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 09:05:06 -0700 (PDT)
Date:   Wed, 19 Oct 2022 16:05:06 +0000
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     greg@kroah.com, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH] staging: vt6655: Fix Lines should not end with a '('
Message-ID: <Y1AgMjTsmy3C5qcK@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
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
 drivers/staging/vt6655/rxtx.c | 44 ++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 5bdb5176772c..ff855def0bd5 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -87,33 +87,29 @@ static const unsigned short wFB_Opt1[2][5] = {
 /*---------------------  Static Functions  --------------------------*/
 static
 void
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
+s_vFillRTSHead(struct vnt_private *pDevice,
+		unsigned char byPktType,
+		void *pvRTS,
+		unsigned int	cbFrameLength,
+		bool bNeedAck,
+		bool bDisCRC,
+		struct ieee80211_hdr *hdr,
+		unsigned short wCurrentRate,
+		unsigned char byFBOption);
 
 static
 void
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
+s_vGenerateTxParameter(struct vnt_private *pDevice,
+		unsigned char byPktType,
+		struct vnt_tx_fifo_head *,
+		void *pvRrvTime,
+		void *pvRTS,
+		void *pvCTS,
+		unsigned int	cbFrameSize,
+		bool bNeedACK,
+		unsigned int	uDMAIdx,
+		void *psEthHeader,
+		unsigned short wCurrentRate);
 
 static unsigned int
 s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
-- 
2.34.1

