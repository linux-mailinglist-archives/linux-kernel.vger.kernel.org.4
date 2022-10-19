Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A001B605049
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJSTUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJSTUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:20:15 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0119514139B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:20:14 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h8so23458615lja.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9hBHwT//7YVRU6p7n6Dpa0soZobMlVM8+tmM4b0TcpA=;
        b=XrHgrTxgcw2OnbR2Rn2l85bm8PqJaW2asw3Rj8nSKkpWabYmNRocvMCA6WpeRWnATc
         sjSU8uuNefou14117FYgY2AzHTWFYi8E8uAoA50p4Y265wqBYZKKhCBlJxT7t4lgon1j
         d7oajZYLNqsLwHuYzX8rxu4D5a+SJZxvkVNg7aDlzavvmgQwqEq1/0v2XDV4hK5aObGS
         vXCSN9ow7djwmgbT0UZ23j6VUcQJCQKsbOVHDaDNQf6eNN1liJQZ5ihiBUcQ4mY3jzMS
         MOG33Mm8BvSeuZXkq4KarClm9YmJA8/beT+e0QZ8rT/oNqYdC4mM4yrpqDvITKsIeyV+
         HYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hBHwT//7YVRU6p7n6Dpa0soZobMlVM8+tmM4b0TcpA=;
        b=rzPGr/sBAqLL0WbeDwb+OlrdmEicd2WOHsoW3JvXWRlOVG+OPpXuldHJYfMTby7fiM
         VMC0LH16OCK1nHmbr6tX50RLD8GDqoDAPEIFYwTdFeI2kR2CJ6B4C60vH70tro+bQcOd
         LlM6MplNcBHgFIQWaeJp7ptV4UvORKLoYQPpfLwqcLKJ4qJ4wDKaHlCKV2iApYh0vLt5
         ToGYhIkz0R46WQHUOPfOT8wFgE+TibUtAWxRiuruc4hbWUW8X/Fp5B27HmFVHym7uS2j
         zhBu9w9PR91lmQcO9owzl6c+RZ7YgTeRMZqNf9y7h/h0/Nz7OLNYDd0GhaCu+sJcVHxw
         4yrA==
X-Gm-Message-State: ACrzQf0Y9MUkrPqB+0+SLXSG5W8+uGtxmoEAkmN0cHXNUg9yc1ocQNrg
        D2sdiPeqUNMLJkKTfe15ZuI=
X-Google-Smtp-Source: AMsMyM6VKRTEwsTBz1IDque1DOW2qle9uQwrVW2yMe/+Q1Jp5HupvS9q3Z6RkkqsA1PMtpz6DvwY7Q==
X-Received: by 2002:a2e:a887:0:b0:26a:871b:a16d with SMTP id m7-20020a2ea887000000b0026a871ba16dmr3658942ljq.482.1666207212039;
        Wed, 19 Oct 2022 12:20:12 -0700 (PDT)
Received: from elroy-temp-vm ([20.240.130.248])
        by smtp.gmail.com with ESMTPSA id bg31-20020a05651c0b9f00b0026dce212f24sm2551026ljb.98.2022.10.19.12.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 12:20:11 -0700 (PDT)
Date:   Wed, 19 Oct 2022 19:20:11 +0000
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     greg@kroah.com, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH v2] staging: vt6655: Fix Lines should not end with a '('
Message-ID: <Y1BN6wPMrpxPB3qP@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
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

 drivers/staging/vt6655/rxtx.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 5bdb5176772c..d987f7dff02a 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -85,10 +85,8 @@ static const unsigned short wFB_Opt1[2][5] = {
 #define DATADUR_A_F1    13
 
 /*---------------------  Static Functions  --------------------------*/
-static
-void
-s_vFillRTSHead(
-	struct vnt_private *pDevice,
+static void
+s_vFillRTSHead(struct vnt_private *pDevice,
 	unsigned char byPktType,
 	void *pvRTS,
 	unsigned int	cbFrameLength,
@@ -96,13 +94,10 @@ s_vFillRTSHead(
 	bool bDisCRC,
 	struct ieee80211_hdr *hdr,
 	unsigned short wCurrentRate,
-	unsigned char byFBOption
-);
+	unsigned char byFBOption);
 
-static
-void
-s_vGenerateTxParameter(
-	struct vnt_private *pDevice,
+static void
+s_vGenerateTxParameter(struct vnt_private *pDevice,
 	unsigned char byPktType,
 	struct vnt_tx_fifo_head *,
 	void *pvRrvTime,
@@ -112,8 +107,7 @@ s_vGenerateTxParameter(
 	bool bNeedACK,
 	unsigned int	uDMAIdx,
 	void *psEthHeader,
-	unsigned short wCurrentRate
-);
+	unsigned short wCurrentRate);
 
 static unsigned int
 s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
-- 
2.34.1

