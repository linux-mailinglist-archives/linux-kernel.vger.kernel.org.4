Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF96769B0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 22:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjAUVo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 16:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjAUVo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 16:44:58 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B52D2748F
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:44:57 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso8118054wmc.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZoNlyGEzH+kRtX90Fp6TGkEBqbyFKQBWafIzoqpx24=;
        b=gULpFAAhxcluTbRql5M1HyxwCkBQDxBZ+Tag4Rz4pndbVmvE8u/2CMFIWVKRyP6Vn3
         1IcTQL93KsokkQCdS+tueBh2wMTu6D8jIJbrHVpA6JB0ygKQyF6YeeL8E++WCkGqNNv/
         5dA1aYTFhVSDHPjpvGZsknke1UmiEDDugBFrj1IiLKUOvoDEv9ChhuGemMVqp1zS9zF1
         OZXasDcVb5x3+wYEjWdn9Ma+hSkJT1qqzSxit/XkWpk0gRXoOMBVLLBa7ORc52IWsXd2
         sa3Uqp6tsbymBKZ+FVe6724c4vo9eMZVCHxmXlq5neHOjNSoddlS0+cqoE/HBDRJ2wEj
         UwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZoNlyGEzH+kRtX90Fp6TGkEBqbyFKQBWafIzoqpx24=;
        b=KR3fZ20ouv5hxixRBNUDimhp/O8O4Fe8pbUK0+60+4BWL95tXPOEKHu555Cq6KLwqx
         rZnqQQx0TDPtmF8evcKk0iowq9tRHqGtLob7t014l8oYX+PwJZ6dXO1rWsPNk3uEXUhG
         JDayGDPg0y4bA1aWmjx+QB3qgaXyG7huGZ3eLokcQPa2gTz+bsBybgKUggEcQ3tY5bxE
         WWkGGSYnugckr+RFIYSvUpG3Uxdm40vX2WBZf2/XEDwR/TcAxo8rSbnkHL10ODEvNrj2
         6hoT+yWX6DZpWYPyGOvgqogW2e0SZ9KRsKf5YKfKXD98FQjsq5ZDIQXMrqB3HfJ9F/sY
         AGHg==
X-Gm-Message-State: AFqh2ko2Kf/P1i1T60F1C6kH/8EBbUxPnZmQuLA117n06uTChmBMuxZu
        gCOS7kT0mvm7cxno89RhksJckuekCpY=
X-Google-Smtp-Source: AMrXdXuXHtG0IVkGciFWV03e7ox79YQN8u3OPYVVrHgR9UM1otsGKleDBu7N825XRzuAMj2yHt5Eow==
X-Received: by 2002:a05:600c:3b06:b0:3d3:446a:b493 with SMTP id m6-20020a05600c3b0600b003d3446ab493mr5089729wms.4.1674337495560;
        Sat, 21 Jan 2023 13:44:55 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b003dafadd2f77sm6956549wms.1.2023.01.21.13.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:44:54 -0800 (PST)
Date:   Sat, 21 Jan 2023 22:44:53 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: rtl8192e: Remove unused variable bfirst_init
Message-ID: <d4f4552e5dbaa036a762590bf47bd5faff15b598.1674336211.git.philipp.g.hortmann@gmail.com>
References: <cover.1674336211.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674336211.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bfirst_init is six times set but never evaluated. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 6 ------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 7a89381bae50..80450d46191c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -692,16 +692,13 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 	priv->rtllib->ieee_up = 1;
 
 	priv->up_first_time = 0;
-	priv->bfirst_init = true;
 	init_status = priv->ops->initialize_adapter(dev);
 	if (!init_status) {
 		netdev_err(dev, "%s(): Initialization failed!\n", __func__);
-		priv->bfirst_init = false;
 		return -1;
 	}
 
 	RT_CLEAR_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC);
-	priv->bfirst_init = false;
 
 	if (priv->polling_timer_on == 0)
 		rtl92e_check_rfctrl_gpio_timer(&priv->gpio_polling_timer);
@@ -837,7 +834,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->blinked_ingpio = false;
 	priv->being_init_adapter = false;
 	priv->bdisable_nic = false;
-	priv->bfirst_init = false;
 	priv->txringcount = 64;
 	priv->rxbuffersize = 9100;
 	priv->rxringcount = MAX_RX_COUNT;
@@ -2423,7 +2419,6 @@ bool rtl92e_enable_nic(struct net_device *dev)
 		return false;
 	}
 
-	priv->bfirst_init = true;
 	init_status = priv->ops->initialize_adapter(dev);
 	if (!init_status) {
 		netdev_warn(dev, "%s(): Initialization failed!\n", __func__);
@@ -2431,7 +2426,6 @@ bool rtl92e_enable_nic(struct net_device *dev)
 		return false;
 	}
 	RT_CLEAR_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC);
-	priv->bfirst_init = false;
 
 	rtl92e_irq_enable(dev);
 	priv->bdisable_nic = false;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 59049ad349e0..e0f4a3b444ee 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -298,7 +298,6 @@ struct r8192_priv {
 	struct pci_dev *pdev;
 	struct pci_dev *bridge_pdev;
 
-	bool		bfirst_init;
 	bool		bfirst_after_down;
 	bool		being_init_adapter;
 
-- 
2.39.0

