Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1C3612ABE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 14:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJ3NcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 09:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3NcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 09:32:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D46A1AC
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 06:32:09 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p21so4794738plr.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 06:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ect7CUW3whk/jekELT8ewhs/AbnHcthL4OWXL1M6vak=;
        b=YxPCTAMe6zNXtmgdkxtzZrNqFcbZ2o5OFLTbvKNpsFWubS76jl9jrtCVbQ5Fa9zzw1
         2zOzjI3M6aafgnGr90feo6vu/balKHzYpRQg0LbcouFqwzrCtb2mk1JLeoZKX9S43tqN
         uORP8YmpZ5xrlXKhZeQfz7FGgDTPRWSnpplDF87sObok+cUn/fkDZMhElhMri6qXAwA8
         S3jBQ/AsoNtheX78saj4xzLSzwUyODD0EA1aBOqjPCaAJIFsf4U3hKWouAZ/n8P1TMdI
         1k7PLDwJd8TBORxIr5pc+Yc21S18CsJTZP0EzVsNpGgBn7ZbLGjDuTyU6qnW5Hn05nyZ
         uboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ect7CUW3whk/jekELT8ewhs/AbnHcthL4OWXL1M6vak=;
        b=sEds33hBBRTlcFTD9fNz5PwHWmbK3LOFBONLJervGnRLsZnYsjIJshb2ONxZAcX/bx
         QeMZ1pwywjQQa7QIANyxsY+54MpzLenE8e3z383T7xMXFiOwtfmBvJmjd8cBHpj9Nfm6
         hCwvjwI5o4Es9ZG+QeBrmnJiUKtTZt1yWjv30Fun6a53OnwrLYRRI2iiRV0E2pDtFdg/
         fHcFtamgCMnW7KWeJBw9k9/dtgmPM+ddNWQ4BF+RpJWQTbsv4Kdcbxj7IBpA10puz7rt
         jDeswtPtFEGB4j8Binhdl/7aUeiUTmigLuaTqDqm9iFyleGH1+G9uCUU1z5vWkBQgMky
         B2Mw==
X-Gm-Message-State: ACrzQf2yBCH8zPBdDTz3jjkLs6H2cc2LiyiEZuYUhQLC+ztfY1ARH6t0
        kDiSGRbvU48uYzNaXNNQc/U=
X-Google-Smtp-Source: AMsMyM65sWppqQzriWx34rWiG10j1Ed9QUGrX196o3lTNfKYqQZ2tUA1CVjS1RNJg0WFY5qhv0HmGw==
X-Received: by 2002:a17:90b:1c06:b0:20a:f070:9f3c with SMTP id oc6-20020a17090b1c0600b0020af0709f3cmr9817614pjb.151.1667136729343;
        Sun, 30 Oct 2022 06:32:09 -0700 (PDT)
Received: from zephyrus ([103.251.210.204])
        by smtp.gmail.com with ESMTPSA id s2-20020a63ff42000000b00439f027789asm2392858pgk.59.2022.10.30.06.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 06:32:08 -0700 (PDT)
Date:   Sun, 30 Oct 2022 19:02:04 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Rename variables rateIndex and rateBitmap
 to avoid CamelCase
Message-ID: <20221030133204.GA416592@zephyrus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variables
* rateIndex to rate_index
* rateBitmap to rate_bitmap
to avoid CamelCase which is not accepted by checkpatch.pl .

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index c9e495538e2c..767c746fc73d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -2121,8 +2121,8 @@ static void _rtl92e_dm_end_sw_fsync(struct net_device *dev)
 static void _rtl92e_dm_start_sw_fsync(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	u32			rateIndex;
-	u32			rateBitmap;
+	u32 rate_index;
+	u32 rate_bitmap;
 
 	priv->rate_record = 0;
 	priv->ContinueDiffCount = 0;
@@ -2136,12 +2136,12 @@ static void _rtl92e_dm_start_sw_fsync(struct net_device *dev)
 		priv->rtllib->fsync_firstdiff_ratethreshold = 200;
 		priv->rtllib->fsync_seconddiff_ratethreshold = 200;
 	}
-	for (rateIndex = 0; rateIndex <= 27; rateIndex++) {
-		rateBitmap  = 1 << rateIndex;
-		if (priv->rtllib->fsync_rate_bitmap & rateBitmap)
+	for (rate_index = 0; rate_index <= 27; rate_index++) {
+		rate_bitmap  = 1 << rate_index;
+		if (priv->rtllib->fsync_rate_bitmap & rate_bitmap)
 			priv->rate_record +=
 				 priv->stats.received_rate_histogram[1]
-				[rateIndex];
+				[rate_index];
 	}
 	if (timer_pending(&priv->fsync_timer))
 		del_timer_sync(&priv->fsync_timer);
-- 
2.25.1

