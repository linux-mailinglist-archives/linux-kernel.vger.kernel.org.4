Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BE967BC35
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbjAYUJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjAYUJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:09:21 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49985D11E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:08:52 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h12so14225567wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Qr60u7lvfUmg3t7GN82ZYC7UEclCo+vLTjIrczP5SI=;
        b=JKMs68+PzgNteTWB0wk6QWiT9tsW/7RxLt0mei0Xbz09mymudC499yGyfEu3qCHeEp
         iQTiix33JWJs1x5v/wdPpPtrzeKlyc7fkdCh0yWqQOX3ZZIQk6G/hcHnLnqKBFVyPnJ/
         fuVybe8vDc5AvF+U5uSQBKIcY9RwIY3IPaG/0ZbnAt8iKZ46H+koh8i8R+UONurkD5l5
         qXnDIRH8MWTm6MthflmRQ50CSKW1CpYWWvb8dlQVa4kEz8B2q043bKyi8s4/EcFyz2Ph
         15/8FjA6Yi3AGnzRV+0CVSsfqxF7da+qZU6t7RM+rSQhJYXqvEvlkKILQCPX9GaPxLv+
         SpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Qr60u7lvfUmg3t7GN82ZYC7UEclCo+vLTjIrczP5SI=;
        b=6uF5Rgpyq6VDYCyQbk0ed4uEn/OWUV71Ipwv9CNQRbd6r77z53r/Real9Bs2ITIXnQ
         poOhWnWKLzwlHrUiy2I4uQ49GAjCVJD3Iedok8vzIWtzYJ6sEdMfACRuMMlvl7Hyja2z
         yg9ICj8LfVTTuiw33LLFdbFrBELyTHZPnSMEfjQipllsCD6m6fk+7dYLohpF13sFaVjF
         5QTsqP8sp4CbFOVQrH+3NKB8ml7d4tj9wF6p4MSW2LfBeZGOIr9mulXi6PwFMPFtPAhg
         +3DCkGypFeryJB7A1lTOW6vYXFecSjlG9csKjg3ce8No9LriItDupY2aDpVvrjHif7Pn
         bR2Q==
X-Gm-Message-State: AO0yUKWx51kmkoyFRcqhu071cV/+YBYrO2+hkoTeWYf9rKg6A5jBddoK
        YB96oiOi67r28NnW24Q0j/g=
X-Google-Smtp-Source: AK7set88Dkl1JxQP5xyKoZ7XDTMAgeMm+t957mfmuyKK+Un4B3iD1g4nfOWOkaQodU/zJa7DNG2hVA==
X-Received: by 2002:a5d:6791:0:b0:2bf:b0cb:1f9f with SMTP id v17-20020a5d6791000000b002bfb0cb1f9fmr1170482wru.7.1674677329651;
        Wed, 25 Jan 2023 12:08:49 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id r13-20020adfdc8d000000b002bfb5bda59asm3287384wrj.25.2023.01.25.12.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:08:49 -0800 (PST)
Date:   Wed, 25 Jan 2023 21:08:47 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/11] staging: rtl8192e: Remove unused variables
 numpacket.. and received_pre..
Message-ID: <0ed5f4134176393110fdb0b7424df7a8a6fc6262.1674675808.git.philipp.g.hortmann@gmail.com>
References: <cover.1674675808.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674675808.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

numpacket_toself, numpacket_matchbssid and received_preamble_GI are
initialized and increased but never read. Remove dead code. As a result
the local variable preamble_guardinterval is unused. Remove it also.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: removed unused variable preamble_guardinterval
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 11 -----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  3 ---
 2 files changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index e9273dfb638e..b4651cea07a1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1685,10 +1685,6 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 			 ether_addr_equal(praddr, priv->rtllib->dev->dev_addr);
 	if (WLAN_FC_GET_FRAMETYPE(fc) == RTLLIB_STYPE_BEACON)
 		bPacketBeacon = true;
-	if (bpacket_match_bssid)
-		priv->stats.numpacket_matchbssid++;
-	if (bpacket_toself)
-		priv->stats.numpacket_toself++;
 	_rtl92e_process_phyinfo(priv, tmp_buf, &previous_stats, pstats);
 	_rtl92e_query_rxphystatus(priv, pstats, pdesc, pdrvinfo,
 				  &previous_stats, bpacket_match_bssid,
@@ -1703,18 +1699,12 @@ static void _rtl92e_update_received_rate_histogram_stats(
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 	u32 rcvType = 1;
 	u32 rateIndex;
-	u32 preamble_guardinterval;
 
 	if (pstats->bCRC)
 		rcvType = 2;
 	else if (pstats->bICV)
 		rcvType = 3;
 
-	if (pstats->bShortPreamble)
-		preamble_guardinterval = 1;
-	else
-		preamble_guardinterval = 0;
-
 	switch (pstats->rate) {
 	case MGN_1M:
 		rateIndex = 0;
@@ -1804,7 +1794,6 @@ static void _rtl92e_update_received_rate_histogram_stats(
 		rateIndex = 28;
 		break;
 	}
-	priv->stats.received_preamble_GI[preamble_guardinterval][rateIndex]++;
 	priv->stats.received_rate_histogram[0][rateIndex]++;
 	priv->stats.received_rate_histogram[rcvType][rateIndex]++;
 }
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 167c4aeea44e..70767238e721 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -184,9 +184,6 @@ enum reset_type {
 
 struct rt_stats {
 	unsigned long received_rate_histogram[4][32];
-	unsigned long received_preamble_GI[2][32];
-	unsigned long numpacket_matchbssid;
-	unsigned long numpacket_toself;
 	unsigned long num_process_phyinfo;
 	unsigned long numqry_phystatus;
 	unsigned long numqry_phystatusCCK;
-- 
2.39.1

