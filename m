Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97085E903F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 00:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiIXWEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 18:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiIXWDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 18:03:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13A6459A1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:03:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v2so3582833edc.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=dSJnz+umwC1fO28aulEVuk9aMWTo08d86Tw2gPXDo/0=;
        b=HLHhHSnMyHhtzYq39NNbRzQpg/WFo6A+npAtuDI4SFXpSXV0WsoZEwOiqiQ9f5LH3U
         mYcJFFc0Qf2/xHCG8sk5zs/pL2FcY3Z7o3zm45Z3R2YFEG67xGwjdrLapDqhHaLPk6rK
         3eWpEu0qjqJrtgdVIYfJ+wOj1MxI6TSftHhnYlpaCvwT4uNuOnVu0Tcv2R6YlbocnWSk
         qK7TKzA0ddGtGE9bLrybL+egPmv915St9xMMoHmF2msXrH1nUEuDY4BsauxLCPQmCvr8
         1Oh+UT2qfCaGc1b+M+easHUPAf4r/xKaip6zgXMr62n5ndcSxTiFW9oocGRL6p6ulHTc
         bVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=dSJnz+umwC1fO28aulEVuk9aMWTo08d86Tw2gPXDo/0=;
        b=vx/5UeL++LtTG/qkjn2YBTVZtIPpjK428Dv5xnJlL4OaECBObyIofMuPN9gR+h/r2V
         KiEqhD/MM7BUdqeiVx8wcOFFYCrJVFgcQEPoMCWKfXB2Hr26PIm3P85JUNFYIIfgpARA
         uxrjfXFf5Fep3C+LcRGspS5kOzQc79mJwUr6os5fQXOd1YEo8JJ1bxIDvZZ6v+GgDzqt
         uUODbzz4w/9WuH8SEDL9eiYP6+uWM2vlRmlQ7dm2Z1dOJwZkQ6mMqrIGWfqf0aTiuvmd
         Av80RQY/Xwye2/1lU9IfY66R/aAurtKK95Da58FROFGqEIqxYxWPZnk6JRZdPaP+rETu
         eBsg==
X-Gm-Message-State: ACrzQf1pJk2/l8rPBUoBuBrvov2lr+4Oh3VEJ51LDjfuP7dIQKBesq58
        vPKh6yOeW5w3uwCgk7RHrQg=
X-Google-Smtp-Source: AMsMyM47OdgdZnT91Qet95p4gB/C79m1RvSWY2YqGAm+MXpQQeRDSydwfz7iQMZkK57x/rRh/bQhXg==
X-Received: by 2002:a50:9510:0:b0:453:dded:60e with SMTP id u16-20020a509510000000b00453dded060emr15306559eda.204.1664057025203;
        Sat, 24 Sep 2022 15:03:45 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id z24-20020a50cd18000000b00456e130b457sm2936547edi.59.2022.09.24.15.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 15:03:44 -0700 (PDT)
Date:   Sun, 25 Sep 2022 00:03:42 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] staging: rtl8192e: Rename szRT2RTAggBuffer,
 bRegRxRe... and bCurRxReo...
Message-ID: <af445e0a80dc8e153a1ba81df99309f19a69d6cb.1664055213.git.philipp.g.hortmann@gmail.com>
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

Rename variable szRT2RTAggBuffer to sz_rt2rt_agg_buf, bRegRxReorderEnable
to reg_rx_reorder_enable and bCurRxReorderEnable to cur_rx_reorder_enable
to avoid CamelCase which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 6 +++---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 drivers/staging/rtl8192e/rtllib_rx.c      | 4 ++--
 drivers/staging/rtl8192e/rtllib_softmac.c | 8 ++++----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 5399931786b8..2dd08f06fa9f 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -158,10 +158,10 @@ struct rt_hi_throughput {
 	u8				RT2RT_HT_Mode;
 	u8 current_rt2rt_aggregation;
 	u8 current_rt2rt_long_slot_time;
-	u8				szRT2RTAggBuffer[10];
+	u8 sz_rt2rt_agg_buf[10];
 
-	u8				bRegRxReorderEnable;
-	u8				bCurRxReorderEnable;
+	u8 reg_rx_reorder_enable;
+	u8 cur_rx_reorder_enable;
 	u8				RxReorderWinSize;
 	u8				RxReorderPendingTime;
 	u16				RxReorderDropCounter;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index cde64b123ced..e8fcfa01204b 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -100,7 +100,7 @@ void HTUpdateDefaultSetting(struct rtllib_device *ieee)
 
 	pHTInfo->reg_rt2rt_aggregation = 1;
 
-	pHTInfo->bRegRxReorderEnable = 1;
+	pHTInfo->reg_rx_reorder_enable = 1;
 	pHTInfo->RxReorderWinSize = 64;
 	pHTInfo->RxReorderPendingTime = 30;
 }
@@ -605,7 +605,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 		pHTInfo->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
 		pHTInfo->ForcedAMSDUMaxSize = 7935;
 	}
-	pHTInfo->bCurRxReorderEnable = pHTInfo->bRegRxReorderEnable;
+	pHTInfo->cur_rx_reorder_enable = pHTInfo->reg_rx_reorder_enable;
 
 	if (pPeerHTCap->MCS[0] == 0)
 		pPeerHTCap->MCS[0] = 0xff;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index abe5c153f74e..8ec8aa7d97d4 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -924,7 +924,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 	sc = le16_to_cpu(hdr->seq_ctl);
 	frag = WLAN_GET_SEQ_FRAG(sc);
 
-	if (!ieee->pHTInfo->bCurRxReorderEnable ||
+	if (!ieee->pHTInfo->cur_rx_reorder_enable ||
 		!ieee->current_network.qos_data.active ||
 		!IsDataFrame(skb->data) ||
 		IsLegacyDataFrame(skb->data)) {
@@ -1442,7 +1442,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	}
 
 	/* Indicate packets to upper layer or Rx Reorder */
-	if (!ieee->pHTInfo->bCurRxReorderEnable || pTS == NULL || bToOtherSTA)
+	if (!ieee->pHTInfo->cur_rx_reorder_enable || pTS == NULL || bToOtherSTA)
 		rtllib_rx_indicate_pkt_legacy(ieee, rx_stats, rxb, dst, src);
 	else
 		RxReorderIndicatePacket(ieee, rxb, pTS, SeqNum);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9d38c35ecf9d..4708aa9752ed 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -866,9 +866,9 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 				       encrypt);
 
 		if (pHTInfo->reg_rt2rt_aggregation) {
-			tmp_generic_ie_buf = ieee->pHTInfo->szRT2RTAggBuffer;
+			tmp_generic_ie_buf = ieee->pHTInfo->sz_rt2rt_agg_buf;
 			tmp_generic_ie_len =
-				 sizeof(ieee->pHTInfo->szRT2RTAggBuffer);
+				 sizeof(ieee->pHTInfo->sz_rt2rt_agg_buf);
 			HTConstructRT2RTAggElement(ieee, tmp_generic_ie_buf,
 						   &tmp_generic_ie_len);
 		}
@@ -1190,9 +1190,9 @@ rtllib_association_req(struct rtllib_network *beacon,
 		HTConstructCapabilityElement(ieee, ht_cap_buf, &ht_cap_len,
 					     encrypt, true);
 		if (ieee->pHTInfo->current_rt2rt_aggregation) {
-			realtek_ie_buf = ieee->pHTInfo->szRT2RTAggBuffer;
+			realtek_ie_buf = ieee->pHTInfo->sz_rt2rt_agg_buf;
 			realtek_ie_len =
-				 sizeof(ieee->pHTInfo->szRT2RTAggBuffer);
+				 sizeof(ieee->pHTInfo->sz_rt2rt_agg_buf);
 			HTConstructRT2RTAggElement(ieee, realtek_ie_buf,
 						   &realtek_ie_len);
 		}
-- 
2.37.3

