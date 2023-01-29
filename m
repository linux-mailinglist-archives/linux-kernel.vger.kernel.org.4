Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C5C67FFA5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjA2O6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjA2O6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:58:16 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FEC144B3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:58:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a3so2224651wrt.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eapJfMMbUhQoPbQcq0LW4vCgN/iDDA+h2+m4Hvg5O/Y=;
        b=fx+TJN5XiMVDaM3DMm20nAVT5wQtftfj59wz16DPm623dJIwBFth2yo0LN+3qGDA8B
         7Lgg6yiYSumyjaD/C8CjzKciUEm7GoEbkGYt1c2TjPLJCFha9+77PjsrXUz1D/tF17ul
         QBLD6f8eRRfQkerRYy93RViV9k1h7m7jXU6QGALXpVufPMbV2Y/tizdzaEFzIoMqDfEJ
         rYl3xMJYNM03j05q5O79yI6C8+ucrduFF7K9tPAQj/2pgKmrIPKe/3s3UiYkXVb1HVmy
         /IAGXfaNkb8tqGaG/breTC5zAkeFOb1hSzxkdfQFBMkk86Q6Hz6jSZETeL2slHO74FvG
         Paag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eapJfMMbUhQoPbQcq0LW4vCgN/iDDA+h2+m4Hvg5O/Y=;
        b=x1jJSo/AZtYj1+RC0aHST3SAzR4+n3eKw9Kn+J2vFvslSSEZQ6Wfu/8JaPk6Vwz0eI
         /5mDK2poV0jSdPX6vAbNCXJy7d6mMVgJxuhRCsDGJV8V/43lufkj3cvbb6a9whJNXBMK
         wnadI1HhJApGfgqXQkZie4Q9Z1s4q2hv74co5I82wexhfA0m9Wp1GQbE5awxbam0lL8Y
         k8il8P0Ex6hUh/yVCeeCicdf9uEyCxMImCVUNhoF8PMWE9KDodTw6Yx1D3QmnGJkGvx+
         a1RNFQ2xItAVQEkpR9qqSVYWZ5Y6cmmnPgsb1JlMY5KhR9ZFWGeTzIWTeLYTkaBDc42u
         7+7w==
X-Gm-Message-State: AO0yUKWuRrkED7Wvgyg+hS+eKFJ+Uul37GayNf3cnKUesyQA5+cicmHN
        I1ArrI1EnxcDBiUpBMOniC0=
X-Google-Smtp-Source: AK7set82CtTr+my606Xd3Oyf4zHyaDz8vqZ+WkX2aMZSEib/F6Z0d9MxJvBwW1IjFWxviT7t3aPcEA==
X-Received: by 2002:adf:e6c1:0:b0:2bf:d333:2194 with SMTP id y1-20020adfe6c1000000b002bfd3332194mr1444001wrm.3.1675004289697;
        Sun, 29 Jan 2023 06:58:09 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b002bdec340a1csm9240032wri.110.2023.01.29.06.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:58:09 -0800 (PST)
Date:   Sun, 29 Jan 2023 15:58:07 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] staging: rtl8192e: Rename sCrcLng
Message-ID: <b0139a958123881fd04b60110a6889f726d943cc.1675003608.git.philipp.g.hortmann@gmail.com>
References: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename constant sCrcLng to S_CRC_LEN to avoid CamelCase which is not
accepted by checkpatch. Use S_CRC_LEN instead of fix value with comment
to improve readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 7ed3d47964af..912b50d3fb31 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1827,7 +1827,7 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	stats->RxIs40MHzPacket = pDrvInfo->BW;
 
 	_rtl92e_translate_rx_signal_stats(dev, skb, stats, pdesc, pDrvInfo);
-	skb_trim(skb, skb->len - 4/*sCrcLng*/);
+	skb_trim(skb, skb->len - S_CRC_LEN);
 
 
 	stats->packetlength = stats->Length-4;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f8a8ece40ac1..26cf4b5165f5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1906,7 +1906,7 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 		skb_put(skb, pdesc->Length);
 		skb_reserve(skb, stats.RxDrvInfoSize +
 			stats.RxBufShift);
-		skb_trim(skb, skb->len - 4/*sCrcLng*/);
+		skb_trim(skb, skb->len - S_CRC_LEN);
 		rtllib_hdr = (struct rtllib_hdr_1addr *)skb->data;
 		if (!is_multicast_ether_addr(rtllib_hdr->addr1)) {
 			/* unicast packet */
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 1287580ce352..a5812dfcd614 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -94,7 +94,7 @@
 #define CCK_TX_BB_GAIN_TABLE_LEN		23
 
 #define CHANNEL_PLAN_LEN			10
-#define sCrcLng					4
+#define S_CRC_LEN				4
 
 #define NIC_SEND_HANG_THRESHOLD_NORMAL		4
 #define NIC_SEND_HANG_THRESHOLD_POWERSAVE	8
-- 
2.39.1

