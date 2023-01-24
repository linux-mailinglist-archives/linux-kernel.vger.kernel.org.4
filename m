Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FFE67A55D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjAXWFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbjAXWFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:05:06 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A1D4FCE0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:04:48 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so39317wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9S2rTJlEcWEor4NpjYK8tyE3FSBDpDNy8fvb6AVYPwo=;
        b=SIvJKZtSi9jA4IyGpgIv4sKxGDXt1pKkXJImNFVlpqnh6ibkX4NdoisQ/vn3MQdfcD
         1v21r0uxK7VPqKwXwdljp5Wz1LQgbyw/btPRrO3UGIIP8K+cIqe6Eu8p6os7/T3D4lp1
         xfJMrNdC8SYDerb+12duC0uRbIq5juECHQPYv2TxA2n/x1Xvhkiei5iHWZz8RXYB/V0w
         anirJHlKmrp+8m11dmVlxZD7969CRHBXXxj+fq3xZNB57pCL2CAlG9uuYI2Ohu2z2Dew
         7FPJanGxfa6wGcuCeB9MTHY4x+2m8TimnwYHUrgUErLnqDDN/o9sjU7qdPgIIEJdEZ6U
         xNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S2rTJlEcWEor4NpjYK8tyE3FSBDpDNy8fvb6AVYPwo=;
        b=sbdT0H5/pCCUYZEwzzn/klO8I6l6L5P8kywFZ8vdJ/ow/W7ipDx2rc9UTwzPDeWemn
         YfO3CRxboMXLSAvXNCd3VsijAmagByWpnkYIrKt5hHrq3p6uBuza3VgBABraVw0264Y3
         37Y3gIqNq0lDrZedMkq8VDl38sg6rDwAY/MVC23GUXwNUTq2AvcdHHFkvE0b2MK++uiX
         6RWQC0tdBHIwEsiGQIeF9Jy5cLH79C2PNAszpMyt5K6WetAGELFrIFE4xQBZaPmVzi3Z
         e5nerV6FUtoFjnr7ZnaYViUN5QRU01i4Hg+NesZmveQE2q+Q2cQiSerZ/WOtDsqa8pSj
         xQeQ==
X-Gm-Message-State: AFqh2kpOJCvHxY24BkFURWSOMMwZBmit8dZvnQfBlpKXrviiEudKOCs/
        2YGGE5Hzx7wTVGf5Tm7oxB0gU04fFVs=
X-Google-Smtp-Source: AMrXdXu7JUYAxrZW5Lg8rLz1tGb9Ru3lQNdWzxQQYLbCC6Ixt6NMfAEgI7yxBuztNcRLaA5y0BLnaQ==
X-Received: by 2002:a05:600c:5120:b0:3db:21b8:5f53 with SMTP id o32-20020a05600c512000b003db21b85f53mr5582634wms.1.1674597880319;
        Tue, 24 Jan 2023 14:04:40 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id g26-20020a7bc4da000000b003d96efd09b7sm38551wmk.19.2023.01.24.14.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:04:39 -0800 (PST)
Date:   Tue, 24 Jan 2023 23:04:37 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] staging: rtl8192e: Remove unused variables txbytes..,
 txbyt.. and signa..
Message-ID: <bbfa1eb95b90476a5df40651343e3976e7742e5d.1674596722.git.philipp.g.hortmann@gmail.com>
References: <cover.1674596722.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674596722.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

txbytesmulticast, txbytesbroadcast and signal_quality are initialized and
increased or set but never read. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 6 +-----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 3 ---
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 154d15b68b8e..7616486bb1ec 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1619,7 +1619,6 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 
 			tmp_val = priv->stats.slide_evm_total /
 				  slide_evm_statistics;
-			priv->stats.signal_quality = tmp_val;
 			priv->stats.last_signal_strength_inpercent = tmp_val;
 		}
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 2c5edda74e73..f8a8ece40ac1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1616,11 +1616,7 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
 	type = WLAN_FC_GET_TYPE(fc);
 	pda_addr = header->addr1;
 
-	if (is_broadcast_ether_addr(pda_addr))
-		priv->stats.txbytesbroadcast += skb->len - fwinfo_size;
-	else if (is_multicast_ether_addr(pda_addr))
-		priv->stats.txbytesmulticast += skb->len - fwinfo_size;
-	else
+	if (!is_broadcast_ether_addr(pda_addr) && !is_multicast_ether_addr(pda_addr))
 		priv->stats.txbytesunicast += skb->len - fwinfo_size;
 
 	spin_lock_irqsave(&priv->irq_th_lock, flags);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index c6a4ac6ce959..4cf776094ac0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -184,8 +184,6 @@ enum reset_type {
 
 struct rt_stats {
 	unsigned long received_rate_histogram[4][32];
-	unsigned long txbytesmulticast;
-	unsigned long txbytesbroadcast;
 	unsigned long txbytesunicast;
 	unsigned long rxbytesunicast;
 	unsigned long txretrycount;
@@ -195,7 +193,6 @@ struct rt_stats {
 	unsigned long	slide_rssi_total;
 	unsigned long slide_evm_total;
 	long signal_strength;
-	long signal_quality;
 	long last_signal_strength_inpercent;
 	long	recv_signal_power;
 	u8 rx_rssi_percentage[4];
-- 
2.39.1

