Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF525E9044
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 00:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiIXWFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 18:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbiIXWE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 18:04:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E644B4C600
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:04:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c30so3314755edn.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=5MWN7wULTG9J6qm7GHbwlY2627vVnidsrjKrrOkFmCY=;
        b=d6UuLG4UrhH8Ffcq1TAXSn4SJY9b89SbhMqve7sPhe6zDnRCtTNgmNpkP1MRZCqFJ1
         cfAnjHggl5DaOBXKJgfFUxkiPM/0nn+OczYFy6hHy4cLD6AxXqbZmNPiKb4t/GM+g5J+
         wUCgKlPol/cOZybTN+DHRXbi/+F/I7RUls98yJ7BeLRyeu4BxSuBU+QAA0yYV6LDz088
         G+q7GQta75pi948Cm0ZSMKryduuIDbudGGwjICwy9TuLh28My/EyaDnZQHfya3oRJwbn
         yira2XZuZYbXN2T5Im1gPPvZyXp6dpXPUjD+M4dVzNj72jVk/qVeIVMBl1S2ZQmhXHaH
         2Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5MWN7wULTG9J6qm7GHbwlY2627vVnidsrjKrrOkFmCY=;
        b=EGGe9ubsviyrrVpsuKB/eO/0C5m/07klJlw7GO/OUTgEmqvJBMe6rzbTgTkyPUyT52
         ythdCXWPq8WbAxDoQMcysX9YSxQaiVH3As5ZtvO7DX4HIIh8jzEbksLHAKow79qFAOL7
         jJJY0vg1ZGJBdnu30mGkAnWxgh4YJMagrVIXpncGysXgXcHi0HZhhxPJhmQVMNbZU50O
         gMsFXCVKYycKY1l+N3liARQVS+4qE0QD4HY3Pjz3hwV7XM7LYsfFAdjE9xNdkY7iD2Uh
         Jkpur4lIkbtDfJFomCawNvsA1jSUztTNEzXKwbGU1DM9ROX4na51UnvrAACIuxlYLLkj
         AvpQ==
X-Gm-Message-State: ACrzQf2kil95nLr+BOx8X9iU6yoCdalO5QlII28aLwJAYDWRi2Q4zU3i
        0Mcz8naNJ8bodVlZelw285I=
X-Google-Smtp-Source: AMsMyM5zYss1HirJsMob9TrryvOtli9I/6XCuwxRaPFR5YF5m5DtGfWzcktKSKaIOd3TxZd8KDhxrw==
X-Received: by 2002:a50:ed05:0:b0:456:d6fe:d800 with SMTP id j5-20020a50ed05000000b00456d6fed800mr8215871eds.101.1664057062418;
        Sat, 24 Sep 2022 15:04:22 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906858900b00773dbdd8205sm5846657ejx.168.2022.09.24.15.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 15:04:21 -0700 (PDT)
Date:   Sun, 25 Sep 2022 00:04:19 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] staging: rtl8192e: Remove unused variables
 ForcedAMSDUMaxSize, ...
Message-ID: <0f3e63030511f72dbadc0368fd5e2dbd3ff84e07.1664055213.git.philipp.g.hortmann@gmail.com>
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

Remove unused variables that are may just once written but never read
ForcedAMSDUMaxSize, PeerBandwidth, SwBwStep, bIsPeerBcm and
bAcceptAddbaReq to avoid CamelCase which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 11 -----------
 drivers/staging/rtl8192e/rtl819x_HTProc.c |  4 ----
 2 files changed, 15 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 3d5dc60d2912..76bc9c5a6d83 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -138,8 +138,6 @@ struct rt_hi_throughput {
 	u8 forced_mpdu_density;
 
 	enum ht_aggre_mode ForcedAMSDUMode;
-	u16				ForcedAMSDUMaxSize;
-
 	u8 forced_short_gi;
 
 	u8 current_op_mode;
@@ -149,11 +147,7 @@ struct rt_hi_throughput {
 
 	enum ht_extchnl_offset CurSTAExtChnlOffset;
 	u8 cur_tx_bw40mhz;
-	u8				PeerBandwidth;
-
 	u8 sw_bw_in_progress;
-	u8				SwBwStep;
-
 	u8 reg_rt2rt_aggregation;
 	u8				RT2RT_HT_Mode;
 	u8 current_rt2rt_aggregation;
@@ -165,17 +159,12 @@ struct rt_hi_throughput {
 	u8 rx_reorder_win_size;
 	u8 rx_reorder_pending_time;
 	u16 rx_reorder_drop_counter;
-
-	u8				bIsPeerBcm;
-
 	u8				IOTPeer;
 	u32 iot_action;
 	u8 iot_ra_func;
 
 	u8	bWAIotBroadcom;
 	u8	WAIotTH;
-
-	u8				bAcceptAddbaReq;
 } __packed;
 
 struct bss_ht {
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index a038a8c1504f..4a3bd49ce81a 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -70,9 +70,6 @@ static u8 LINKSYS_MARVELL_4400N[3] = {0x00, 0x14, 0xa4};
 void HTUpdateDefaultSetting(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
-
-	pHTInfo->bAcceptAddbaReq = 1;
-
 	pHTInfo->bRegShortGI20MHz = 1;
 	pHTInfo->bRegShortGI40MHz = 1;
 
@@ -603,7 +600,6 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	if (pHTInfo->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
 		pHTInfo->bCurrentAMPDUEnable = false;
 		pHTInfo->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
-		pHTInfo->ForcedAMSDUMaxSize = 7935;
 	}
 	pHTInfo->cur_rx_reorder_enable = pHTInfo->reg_rx_reorder_enable;
 
-- 
2.37.3

