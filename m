Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E2D5E9040
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 00:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiIXWEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 18:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiIXWD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 18:03:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EED34BA6A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:03:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id f20so4464400edf.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=eP06qnbCwxGVtciyiHBHP8FAxePB4HjgZ+xJDoorIoU=;
        b=K8w1XgAMjxjat1n8IG/jP6N000U9JPzKgvv3GitU6ECmkSsbyVMl2lfwA4+p+hGrfi
         e9d9M1KV5zPRVnS/k6Z7GVkkLZynn57tg40ILsdURjO+sBsgyk130Sff6p60agBYn8Oa
         7EPhtqBgRgA17D6RRjqcvmRMhY74jAjb3u/Jkh2ja6ixXmYxQfH2AB8L0c8XqNW1p2OF
         jw5BRakkawk+yOBLm1tf9sFTqfxw3xOhnsHWBrvOLDLjrHm1s15PsGRDcK6rfnZH3j+y
         KopqdvEKiNHgyp7PH3xD5PllgXtgT6/629Hykwj/WuZxvr88elXhNeTzTxqX6zwobw43
         jeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=eP06qnbCwxGVtciyiHBHP8FAxePB4HjgZ+xJDoorIoU=;
        b=dnsvGZ78DxLIWZNxV6rUQ7S2cXxpjdiv2dOiEtO4wozIXIKYKJlcLORfJd97UVdokl
         YDEcH1t9oIZWPjX9LYsiqjoiTWmKjnA0gP0ufsz9nFpBxfBV+w5RnRHOhjXxfESRgNGR
         dQlOE2dnnbDn556dFUnQv0hv94gIwL+AvINYLKiPgQYjH9TKqexo6oDXske6Q4mwjNin
         WRKJ+OhFNnIINicM3I/hT8FUWV4zdcwEgfIijkeM5HFfYAvy3VVK9n9meyHHsv4+PNoD
         HzPUCGaZiTME+QhzuRRhZI5C3yR7UMJl0ImvfimmUlwu3Q/xqOOt1w3v0yuRoQYPNSz/
         BEJQ==
X-Gm-Message-State: ACrzQf0t5FTcYaENjZ00NIqDw3D2P8lg3P6CAKsOuRGTBxffuk/GKIKk
        CuThMQddEL2uoYLY/3T/2FTkFYPF9n0=
X-Google-Smtp-Source: AMsMyM53mrQZtXzxgQuIoVb1KZPCMdFFLkBIqiP4IVJUTIo9wr2lyHC2bED28BhxfgagYrZq1acldg==
X-Received: by 2002:a05:6402:f07:b0:450:bf95:59e9 with SMTP id i7-20020a0564020f0700b00450bf9559e9mr15265805eda.46.1664057031655;
        Sat, 24 Sep 2022 15:03:51 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id f10-20020a170906084a00b0073c80d008d5sm5882486ejd.122.2022.09.24.15.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 15:03:51 -0700 (PDT)
Date:   Sun, 25 Sep 2022 00:03:49 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] staging: rtl8192e: Rename RxRe...WinSize, RxReorder...
 and RxReorderDr...
Message-ID: <e09ef6e2edc88e32782202589a9230204b547a9c.1664055213.git.philipp.g.hortmann@gmail.com>
References: <cover.1664055213.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664055213.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable RxReorderWinSize to rx_reorder_win_size,
RxReorderPendingTime to rx_reorder_pending_time and RxReorderDropCounter
to rx_reorder_drop_counter to avoid CamelCase which is not accepted by
checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 6 +++---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 2dd08f06fa9f..7380df65959b 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -162,9 +162,9 @@ struct rt_hi_throughput {
 
 	u8 reg_rx_reorder_enable;
 	u8 cur_rx_reorder_enable;
-	u8				RxReorderWinSize;
-	u8				RxReorderPendingTime;
-	u16				RxReorderDropCounter;
+	u8 rx_reorder_win_size;
+	u8 rx_reorder_pending_time;
+	u16 rx_reorder_drop_counter;
 
 	u8				bIsPeerBcm;
 
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index e8fcfa01204b..a7ccdee57a1b 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -101,8 +101,8 @@ void HTUpdateDefaultSetting(struct rtllib_device *ieee)
 	pHTInfo->reg_rt2rt_aggregation = 1;
 
 	pHTInfo->reg_rx_reorder_enable = 1;
-	pHTInfo->RxReorderWinSize = 64;
-	pHTInfo->RxReorderPendingTime = 30;
+	pHTInfo->rx_reorder_win_size = 64;
+	pHTInfo->rx_reorder_pending_time = 30;
 }
 
 static u16 HTMcsToDataRate(struct rtllib_device *ieee, u8 nMcsRate)
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 34b00a76b6bd..05c7e822f372 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -83,7 +83,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	if (bPktInBuf && (pRxTs->rx_timeout_indicate_seq == 0xffff)) {
 		pRxTs->rx_timeout_indicate_seq = pRxTs->rx_indicate_seq;
 		mod_timer(&pRxTs->rx_pkt_pending_timer,  jiffies +
-			  msecs_to_jiffies(ieee->pHTInfo->RxReorderPendingTime)
+			  msecs_to_jiffies(ieee->pHTInfo->rx_reorder_pending_time)
 			  );
 	}
 	spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 8ec8aa7d97d4..46d75e925ee9 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -569,7 +569,7 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 {
 	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
 	struct rx_reorder_entry *pReorderEntry = NULL;
-	u8 WinSize = pHTInfo->RxReorderWinSize;
+	u8 WinSize = pHTInfo->rx_reorder_win_size;
 	u16 WinEnd = 0;
 	u8 index = 0;
 	bool bMatchWinStart = false, bPktInBuf = false;
@@ -591,7 +591,7 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 		netdev_dbg(ieee->dev,
 			   "Packet Drop! IndicateSeq: %d, NewSeq: %d\n",
 			   pTS->rx_indicate_seq, SeqNum);
-		pHTInfo->RxReorderDropCounter++;
+		pHTInfo->rx_reorder_drop_counter++;
 		{
 			int i;
 
@@ -755,7 +755,7 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 		netdev_dbg(ieee->dev, "%s(): SET rx timeout timer\n", __func__);
 		pTS->rx_timeout_indicate_seq = pTS->rx_indicate_seq;
 		mod_timer(&pTS->rx_pkt_pending_timer, jiffies +
-			  msecs_to_jiffies(pHTInfo->RxReorderPendingTime));
+			  msecs_to_jiffies(pHTInfo->rx_reorder_pending_time));
 	}
 	spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
 }
-- 
2.37.3

