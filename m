Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5862967BC48
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbjAYUKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbjAYUJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:09:59 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B068F5CFF5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:09:38 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k16so14625437wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUNK4telbL5iEm9hMJeiQP6SRHQdjAr35nMvZWBiILs=;
        b=REd4vr+NBUQzVGTn98U8rYpH2ztbkzE46mstrYzWVGqc6JaLtIGyXUEXeQaMNry8kG
         8Np9kCEW0zrxUpZ0uq/bQCP247NQl8Ygff6Rb9Mw3xJXO4fufvQrpVUGHZJMM3+PjA/D
         bAWsJhV67XoXXs2EOA3HdfZY/4ohZvP8e8p4E9wInWYxMjseqMg7XlW+Tv94sDV3gUmg
         MdADRNptB9qFbCXuJzg8rPdfmcZa7Ax0OIT4RHo8R8inA0v+6DJ4A3S7keWLmHJPfb/q
         i39yTLdw2v91ILvGUGOOm8JeHw6bWSmVhJD0XSL6xTtFgHdQU6gZcgstxE0dzLk46uyd
         9MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUNK4telbL5iEm9hMJeiQP6SRHQdjAr35nMvZWBiILs=;
        b=HGGpgvEoTEZGdG0N0p5x/Bj9Fhmu4P8pFrRTOIhHoql4Te33pQhQoM5IhYhlDJWigj
         DY2iM3frOuRln+9rrx68G2GnxiwkSuUd3wt0+/Whqxvzq82NN+PRgvGXEhFzPhC6QUwx
         Eea4a92yBgrrh7Zh63hzhtxPa59qHMX7qo88/PWmBFlrDE3+FBHvu9L4tQuE3EJUpi0n
         wD6JMQ04EZg5sXu0r0mWGR86lHHZWrniokA3No1upp706v5GB50RS2C5hy4+J1vNqA72
         L2L6DM7cx8beTy6bYdlS/VzyvYM+QP6AKSrxXdAEgWKArseJ/iG9K9fKr3oFdKjHHQGW
         etug==
X-Gm-Message-State: AFqh2kp+Lu17EzFC9tp0B+z0QysfcWBFKakHxT3EBMtbvu1EjWSKGdP8
        FJ3fyhIIK57p+ObfQmJ6Qu4=
X-Google-Smtp-Source: AMrXdXuepv1cKXrMXx18nZpaMQWWKMg9TVj9FBgPL1rBbx9bj+2ZLOkP+Euv57+gjC7jBl1bo1b82Q==
X-Received: by 2002:a05:600c:1c83:b0:3da:ff24:4b93 with SMTP id k3-20020a05600c1c8300b003daff244b93mr8571356wms.3.1674677374737;
        Wed, 25 Jan 2023 12:09:34 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id h24-20020a05600c499800b003dc1a525f22sm2642847wmp.25.2023.01.25.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:09:34 -0800 (PST)
Date:   Wed, 25 Jan 2023 21:09:32 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] staging: rtl8192e: Remove unused variables
 txbytes.., txbyt.. and signa..
Message-ID: <c469f82619625fecbed95532967cc7ec2b12e5f9.1674675808.git.philipp.g.hortmann@gmail.com>
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

txbytesmulticast, txbytesbroadcast and signal_quality are initialized and
increased or set but never read. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 6 +-----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 3 ---
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 9d13fda33fbf..3989d484cc33 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1613,7 +1613,6 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 
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

