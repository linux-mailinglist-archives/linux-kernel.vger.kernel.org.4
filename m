Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B1713A33
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjE1Owm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE1Owl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:52:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DBE9B
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:52:40 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2566e60cc5aso425157a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685285560; x=1687877560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRB64WwQ13PETFGobSFGuFSAiAnCJdGoGNc6vJQKRDY=;
        b=DtCTlEpkzw0Agtsg7AhmIGhdzot0PT0VAAEEjzLp746i7Qj3vC67EK9EX+ErOfJz4c
         lf66Awib3+34g/ogoZ3OmgBXomAmxIJja8ktWr7wniHTjret40PWuPZY2rI/+Yr2njFU
         TrXoDvT/m4+HOCNuMC2HXKoY/r0LaK2I2MPplFtGwmCM5fsODarTLGdBlHhxrYeJCYCf
         FPrLWapm3XOOJPQ9DlNVY76oW0ypJRMkENq8cMjcBL73a3MYdqklq022htWQVTQ6Sr2w
         OGaVCEoM7gcJ3crZ84OsW7xsG0qQD6MD7jTEKJLftPt8tt69jbhEojRvMDYvT9xKR8Ni
         QxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685285560; x=1687877560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRB64WwQ13PETFGobSFGuFSAiAnCJdGoGNc6vJQKRDY=;
        b=EojCx8V6Z32DoT6f4BSzhRxLVyzRNqoJ6BAEqVW7DJyWZByoNSbfVoAm2uqb15mN8r
         csXnpPi1rdVzNhTztFLHHUhMY7HXSK4At3OH6Nf2sRKkx2V9+oRdg2QQExfyNm6+ZbXp
         F0JVqOR/bS6oZXRZowx32BXRs1whdzmdBA0vYLYi68iyFDy4i/RH6DdChrFCzK878Xds
         V/mBE/wyr5fu0IQcMK164UAwQelqzKaQpAU5ppW+QXMx4zwdDWSchyXtlXTFTwvWu/gx
         U5QENLTr0Ez7ylWsn/XQ88Kh4r9N0NVvLJkL7e6HHPwlYOx0atnMUno2KJPTP9UbN1Xk
         F7ZA==
X-Gm-Message-State: AC+VfDxo64MGgXqaog7nTs2yUBTLS5+MNrsWTN18lsJ8CZmD7EHOfnOK
        Sp11Th+obYylHMaBqdOQ9SoxtqKcAeo=
X-Google-Smtp-Source: ACHHUZ6jM2pi2FbT4a3ULxgqpYpT+ItXWP9QYW9icVCsawynfp3SKquIksGdzpd91JYEkb7Loij2EA==
X-Received: by 2002:a17:90b:1e49:b0:255:f114:fa9f with SMTP id pi9-20020a17090b1e4900b00255f114fa9fmr7962201pjb.3.1685285559671;
        Sun, 28 May 2023 07:52:39 -0700 (PDT)
Received: from yogi-Zephyrus ([103.251.210.199])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a01d100b0025671de4606sm991511pjd.4.2023.05.28.07.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:52:39 -0700 (PDT)
Date:   Sun, 28 May 2023 20:22:35 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: rtl8192e: Rename variable LeisurePSLeave
Message-ID: <05f947b414f50d6f9e1be3de1216da777173d6ba.1685284727.git.yogi.kernel@gmail.com>
References: <cover.1685284727.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1685284727.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable LeisurePSLeave to leisure_ps_leave to avoid
CamelCase which is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 68e921a3a0a8..b82d2b7aa26c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -717,7 +717,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->handle_assoc_response	= _rtl92e_handle_assoc_response;
 	priv->rtllib->handle_beacon		= _rtl92e_handle_beacon;
 	priv->rtllib->set_wireless_mode		= rtl92e_set_wireless_mode;
-	priv->rtllib->LeisurePSLeave		= rtl92e_leisure_ps_leave;
+	priv->rtllib->leisure_ps_leave		= rtl92e_leisure_ps_leave;
 	priv->rtllib->set_bw_mode_handler	= rtl92e_set_bw_mode;
 	priv->rf_set_chan			= rtl92e_set_channel;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index c30821a746c0..03898efea12d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1723,7 +1723,7 @@ struct rtllib_device {
 
 	void (*rtllib_ips_leave_wq)(struct net_device *dev);
 	void (*rtllib_ips_leave)(struct net_device *dev);
-	void (*LeisurePSLeave)(struct net_device *dev);
+	void (*leisure_ps_leave)(struct net_device *dev);
 
 	/* This must be the last item so that it points to the data
 	 * allocated beyond this structure by alloc_rtllib
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index d44bf261de54..36bb2d24521f 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1212,7 +1212,7 @@ static void rtllib_rx_check_leave_lps(struct rtllib_device *ieee, u8 unicast,
 			if (((ieee->link_detect_info.NumRxUnicastOkInPeriod +
 			    ieee->link_detect_info.NumTxOkInPeriod) > 8) ||
 			    (ieee->link_detect_info.NumRxUnicastOkInPeriod > 2)) {
-				ieee->LeisurePSLeave(ieee->dev);
+				ieee->leisure_ps_leave(ieee->dev);
 			}
 		}
 	}
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 07a3d0c0f0e0..4630976132ba 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -340,7 +340,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 
 	chan = ieee->current_network.channel;
 
-	ieee->LeisurePSLeave(ieee->dev);
+	ieee->leisure_ps_leave(ieee->dev);
 	/* notify AP to be in PS mode */
 	rtllib_sta_ps_send_null_frame(ieee, 1);
 	rtllib_sta_ps_send_null_frame(ieee, 1);
-- 
2.25.1

