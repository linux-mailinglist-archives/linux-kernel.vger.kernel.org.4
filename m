Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F0F73C70D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjFXGFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjFXGFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:05:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BC82D41
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:04:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51669dd574aso316593a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687586680; x=1690178680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3T8C4UeShnoX/kA2p4evbH04NRgTdKwA7ilNwmOPeH0=;
        b=pNUfGZIMcZt4266HC7Nas0DONedBslUQYOy3Czp9p8MV4CWAnYLwGRRKhcKab5krAX
         1yPxP+HdqWZETrukA8IcpXyy6wMu+CwDuzoVftHhFg+3wrOXCIQKVthogfobjSyZbR3E
         QuSiGPuoRf4Sn62DDG9PyaG4H718xXgFYcTIOSFwoT+CYoEjwGjq5slkG7HdojNSo553
         SGvNNnqwNzfIVtaHT41O9FOnFZkVmdTM/wHAmv82Nu6iaPLu9pIa/tPmTiZek5g8rqOE
         UPYuf7AzQ3cf1U1UoVFh3CzGqrUr+AEBBEr0aHnSj2MyjhV13mVIEIFzFHbVDtFqgsLl
         BxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586680; x=1690178680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T8C4UeShnoX/kA2p4evbH04NRgTdKwA7ilNwmOPeH0=;
        b=dd3gP8WvEMR4K3yTCNX/6ReVDvwMet233bhhcrQr0mvdnJt9fYh1biKoLyx89B+yR2
         QvjvZZQGHz3dXwQTs+2nlUfGU2EhJufNaF9oYjM9Tp/T1jqrdy1xRE4p95uVXVK8Y0VC
         32NmNFc4UVUNWeoV1tU67dTMCgAkTqlL8RV70fbCT9sxPQxwCQoJK6FAuA70wOEczVgy
         ekw1mkxa/UI0+gi2FPJH92tBUEb/AH7zGnINxH0ZOVHyWnXG9YzGQX1fkW7EsXM3nIy9
         tkIGFR5McjvIczJaU5xXngoM3DBzJZiw5gliANtXzkT9HTltB7XmQ6i+qoX+jiwLTetC
         2/Ew==
X-Gm-Message-State: AC+VfDz3Ome92pG9IsH7TOswTWbi8sA6fxGr8ZeAWgaj65ekHFueITSb
        nJ9Y6fJPq8MdkSsi0vSm5A4=
X-Google-Smtp-Source: ACHHUZ6rsTFYz7kROdutExy2vh/9WiuzbEnae/KU3XYefeFprKV5Shivkn2H8Wnar8MfFuUhr85ZrA==
X-Received: by 2002:a05:6402:270f:b0:514:971b:7f36 with SMTP id y15-20020a056402270f00b00514971b7f36mr17612423edd.3.1687586680385;
        Fri, 23 Jun 2023 23:04:40 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7d69a000000b0051bfd21d21asm319307edr.46.2023.06.23.23.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 23:04:39 -0700 (PDT)
Date:   Sat, 24 Jun 2023 08:04:36 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] staging: rtl8192e: Remove variable bdisable_nic
Message-ID: <6b083ce8c4aaf42f366c365cbc47178afa2636d4.1687583718.git.philipp.g.hortmann@gmail.com>
References: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable bdisable_nic as always set to false. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 12 ------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index e9eb55c6e6d8..23f9b729940b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -618,8 +618,6 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 					(&priv->rtllib->pwr_save_ctrl);
 	bool init_status;
 
-	priv->bdisable_nic = false;
-
 	priv->up = 1;
 	priv->rtllib->ieee_up = 1;
 
@@ -760,7 +758,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->up_first_time = 1;
 	priv->blinked_ingpio = false;
 	priv->being_init_adapter = false;
-	priv->bdisable_nic = false;
 	priv->txringcount = 64;
 	priv->rxbuffersize = 9100;
 	priv->rxringcount = MAX_RX_COUNT;
@@ -1498,12 +1495,6 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
 	int   idx;
 	u32 fwinfo_size = 0;
 
-	if (priv->bdisable_nic) {
-		netdev_warn(dev, "%s: Nic is disabled! Can't tx packet.\n",
-			    __func__);
-		return skb->len;
-	}
-
 	priv->rtllib->bAwakePktSent = true;
 
 	fwinfo_size = sizeof(struct tx_fwinfo_8190pci);
@@ -2245,20 +2236,17 @@ bool rtl92e_enable_nic(struct net_device *dev)
 
 	if (!priv->up) {
 		netdev_warn(dev, "%s(): Driver is already down!\n", __func__);
-		priv->bdisable_nic = false;
 		return false;
 	}
 
 	init_status = rtl92e_start_adapter(dev);
 	if (!init_status) {
 		netdev_warn(dev, "%s(): Initialization failed!\n", __func__);
-		priv->bdisable_nic = false;
 		return false;
 	}
 	RT_CLEAR_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC);
 
 	rtl92e_irq_enable(dev);
-	priv->bdisable_nic = false;
 	return init_status;
 }
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 1cb68d53a17e..38b215d86eeb 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -322,7 +322,6 @@ struct r8192_priv {
 
 	bool rf_change_in_progress;
 	bool set_rf_pwr_state_in_progress;
-	bool bdisable_nic;
 
 	u8 cck_pwr_enl;
 	u16 tssi_13dBm;
-- 
2.41.0

