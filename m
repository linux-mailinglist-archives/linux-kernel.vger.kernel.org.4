Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825D46728D8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjART6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjART6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:58:46 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6E1539BC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:58:44 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e3so25868175wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m9CjOhr96xi9+FpZ47u/Q+cReHr932dPgU5qJKbRN1E=;
        b=CIWxY+44CFjswsxEOsjN08VIfneDVaIqWWfMexnxkviLISJsENZaIKTPfncKhEIqo5
         lUTJ8aI3aS8prjzNRUXXB26CwN6CQ5eF9rghP6JPnne85kLWHc9x8xSDpPiVDJsk+WEG
         FAceTSuMQca79cSm29KikvUeRzPNnYP7chMFW1HXPfmwc/07bIGBKIr7udOjQEIvfdOv
         0PkYB3oyCnu99mWulM6oCmyiiXKFZ5NG3L3rzl/MYkgLhrPk2vSL5jQQyNWi6nWe7Daq
         R+jrL5xJpLIyUXgISpJfjlCbbHkuAO3iY6QjGKMpKNfbjtSC12zntBNP1yNV1nKm8rvl
         +vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9CjOhr96xi9+FpZ47u/Q+cReHr932dPgU5qJKbRN1E=;
        b=gpLfRDnGVCRF0WYSPulaWbV53tB1piChJX4jzdVJTPlTMiWgKsuY1HcKI1Jx77JNaA
         GurUbdXLDIA+X9UDA/9w3ne7kGMF33Bi+U9iX3UKtmQ4HPPoDqNGu13rJcjHQ3Y3i/BC
         kZAx5yeq1N7e8J8x8CqfDpX+YzRyHhQbAykSl6WP3HgAZt6W+K047WZapXXc+csTTMVB
         33Z4ZMQr+F8PnplN2t39FDvzj7NHJKd8gX3UlskXl+hcaymNe2AJu7m6xwMZG4QSCoyc
         JmjlvpVjWudblmvRCwomzkigLtaoePQ5ObRgV/c/oa1Hj6H3eqfknEZud2Fqz5TwhkcW
         HrvQ==
X-Gm-Message-State: AFqh2kp4uIoSbPNLJnRL6SJUyX4ksuDSvDzCKJAbU9mbNueWkKC4J3nb
        DQLKehK+bMsbCXr8Bc1LKuw=
X-Google-Smtp-Source: AMrXdXvTLsedASp5bBS9DgOn6IBut7CdnGpGgaQrZMmPi9V8khe9LwFcgpPHCSPT0S7JMGAS77/EfQ==
X-Received: by 2002:a05:6000:25c:b0:254:e300:df15 with SMTP id m28-20020a056000025c00b00254e300df15mr1608744wrz.1.1674071923277;
        Wed, 18 Jan 2023 11:58:43 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id i6-20020adfe486000000b002423dc3b1a9sm31551031wrm.52.2023.01.18.11.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 11:58:42 -0800 (PST)
Date:   Wed, 18 Jan 2023 20:58:41 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] staging: rtl8192e: Rename LongRetryL.., ShortRetryL..
 and ReceiveConfig
Message-ID: <6e3920f3353ebc6dd1d039f54688fa1966cc431b.1674071236.git.philipp.g.hortmann@gmail.com>
References: <cover.1674071236.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674071236.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable LongRetryLimit to long_retry_limit, ShortRetryLimit to
short_retry_limit and ReceiveConfig to receive_config to avoid CamelCase
which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 26 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  6 ++---
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 9cffe09e429c..b0f33fbffa42 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -127,7 +127,7 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 
 		Type = val[0];
 		RegRCR = rtl92e_readl(dev, RCR);
-		priv->ReceiveConfig = RegRCR;
+		priv->receive_config = RegRCR;
 
 		if (Type)
 			RegRCR |= (RCR_CBSSID);
@@ -135,7 +135,7 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 			RegRCR &= (~RCR_CBSSID);
 
 		rtl92e_writel(dev, RCR, RegRCR);
-		priv->ReceiveConfig = RegRCR;
+		priv->receive_config = RegRCR;
 
 	}
 	break;
@@ -594,8 +594,8 @@ static void _rtl92e_hwconfig(struct net_device *dev)
 	rtl92e_writel(dev, RRSR, regRRSR);
 
 	rtl92e_writew(dev, RETRY_LIMIT,
-		      priv->ShortRetryLimit << RETRY_LIMIT_SHORT_SHIFT |
-		      priv->LongRetryLimit << RETRY_LIMIT_LONG_SHIFT);
+		      priv->short_retry_limit << RETRY_LIMIT_SHORT_SHIFT |
+		      priv->long_retry_limit << RETRY_LIMIT_LONG_SHIFT);
 }
 
 bool rtl92e_start_adapter(struct net_device *dev)
@@ -670,7 +670,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 				  (MXDMA2_NoLimit<<MXDMA2_TX_SHIFT)));
 	rtl92e_writel(dev, MAC0, ((u32 *)dev->dev_addr)[0]);
 	rtl92e_writew(dev, MAC4, ((u16 *)(dev->dev_addr + 4))[0]);
-	rtl92e_writel(dev, RCR, priv->ReceiveConfig);
+	rtl92e_writel(dev, RCR, priv->receive_config);
 
 	rtl92e_writel(dev, RQPN1, NUM_OF_PAGE_IN_FW_QUEUE_BK <<
 		      RSVD_FW_QUEUE_PAGE_BK_SHIFT |
@@ -860,9 +860,9 @@ void rtl92e_link_change(struct net_device *dev)
 			if (ieee->intel_promiscuous_md_info.promiscuous_on)
 				;
 			else
-				priv->ReceiveConfig = reg |= RCR_CBSSID;
+				priv->receive_config = reg |= RCR_CBSSID;
 		} else
-			priv->ReceiveConfig = reg &= ~RCR_CBSSID;
+			priv->receive_config = reg &= ~RCR_CBSSID;
 
 		rtl92e_writel(dev, RCR, reg);
 	}
@@ -874,12 +874,12 @@ void rtl92e_set_monitor_mode(struct net_device *dev, bool bAllowAllDA,
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	if (bAllowAllDA)
-		priv->ReceiveConfig |= RCR_AAP;
+		priv->receive_config |= RCR_AAP;
 	else
-		priv->ReceiveConfig &= ~RCR_AAP;
+		priv->receive_config &= ~RCR_AAP;
 
 	if (WriteIntoReg)
-		rtl92e_writel(dev, RCR, priv->ReceiveConfig);
+		rtl92e_writel(dev, RCR, priv->receive_config);
 }
 
 static u8 _rtl92e_rate_mgn_to_hw(u8 rate)
@@ -2010,10 +2010,10 @@ rtl92e_init_variables(struct net_device  *dev)
 
 	priv->rtllib->tx_headroom = sizeof(struct tx_fwinfo_8190pci);
 
-	priv->ShortRetryLimit = 0x30;
-	priv->LongRetryLimit = 0x30;
+	priv->short_retry_limit = 0x30;
+	priv->long_retry_limit = 0x30;
 
-	priv->ReceiveConfig = RCR_ADD3	|
+	priv->receive_config = RCR_ADD3	|
 		RCR_AMF | RCR_ADF |
 		RCR_AICV |
 		RCR_AB | RCR_AM | RCR_APM |
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index d86577277844..8de726de57f4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -362,7 +362,7 @@ struct r8192_priv {
 
 	u64		LastRxDescTSF;
 
-	u32		ReceiveConfig;
+	u32 receive_config;
 	u8		retry_data;
 	u8		retry_rts;
 	u16		rts;
@@ -371,8 +371,8 @@ struct r8192_priv {
 	int		 txringcount;
 	atomic_t	tx_pending[0x10];
 
-	u16		ShortRetryLimit;
-	u16		LongRetryLimit;
+	u16 short_retry_limit;
+	u16 long_retry_limit;
 
 	bool		hw_radio_off;
 	bool		blinked_ingpio;
-- 
2.39.0

