Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1CF5F1B85
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJAJmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJAJl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:41:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B2816B9
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:41:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m3so8784098eda.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=Ca9/JtjBAXJ7Q/8G7d35DLgFmFXGEU6y4hZXwsO0isA=;
        b=CgBGAp8RNTb0dLB7cxjyWocMCTUYTjRUlaCLbpBUUXE/v3vW8YOasfJF9JNuq3MKlf
         CBl/ozhfugPlpwjPgJKX0LkrlTS6xjkunpxlEdLpD8Ndg3kK8spa9MmE2+GrabCjwNtX
         LVrHBgnLdtAtHLuq57f08s+c/mdIo6DHL5cMpHkGIO3+EA06818U7YRqxwMLI0rOZnw8
         NLCB6GyNOUOiCMrnDnX8eJA1GTQpNfljbO4Lr2Gij2fVsk31ILcBXHBTXvF5CgzmSJ3+
         WRGJ59FBSY1rOxs92dANuuCOgSxk0Nk5X2esfKZJEAS4ZxxnxTG3V1QBDMZyoQGUCwgl
         /iDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ca9/JtjBAXJ7Q/8G7d35DLgFmFXGEU6y4hZXwsO0isA=;
        b=nt7OdFGcny4B7tU9uoi/RYKj6gf0ZSNKZJbhA3ExPy/9U0Zyds0qo+eGevSaVf8i9W
         BTvRBWeIIWoK+9b0S8fLjfA+1B0sy0/jWq67KAOgsAe8Wpf8Zi0jQaSBpPAk2ulHriyG
         /SneTB8UmX5hHADVS37QgP1WBt/Ku0psiO7vEAxstcsQjqLTv6hRVULu6ycYC22OXgBC
         jRikyDrQzzOwpzGSQ/c2ujyVZ9SPfYN0qN2e+wszM/OvcxWuHEKieDUX/TW/qZEGWzt9
         kQWMrKyAsClKX7gX9ZFtuBrNM3fb7YgNeHvtMIpgxOfJoYAEV6IunaO4y6+InqXVb/1q
         eJuw==
X-Gm-Message-State: ACrzQf094Ff0pfSieRjKEQOZHIBiuTOh+P6DBtn+0KO2tjEGdwfl5t0/
        Baj2Z7zRgogBn1fRBBw5McQ=
X-Google-Smtp-Source: AMsMyM65+/F7PMcMt7l0HNHwPmRBYZP58HiM14eRdaqKqNMSqnxNCyc6U4obN4KkD0gw1O/Mj9vADg==
X-Received: by 2002:a05:6402:518d:b0:451:6655:5fb4 with SMTP id q13-20020a056402518d00b0045166555fb4mr11036255edd.150.1664617300895;
        Sat, 01 Oct 2022 02:41:40 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090653cc00b0074150f51d86sm2442272ejo.162.2022.10.01.02.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 02:41:40 -0700 (PDT)
Date:   Sat, 1 Oct 2022 11:41:38 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] staging: rtl8192e: Remove unused variable
 bDriverIsGoingToUnload
Message-ID: <48a84cbe359f159cc9c296b261256a405ee3884e.1664616227.git.philipp.g.hortmann@gmail.com>
References: <cover.1664616227.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664616227.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bDriverIsGoingToUnload is never evaluated. Remove resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 ---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f07f0fc690a3..213aac943ef7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -686,7 +686,6 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 					(&priv->rtllib->PowerSaveControl);
 	bool init_status;
 
-	priv->bDriverIsGoingToUnload = false;
 	priv->bdisable_nic = false;
 
 	priv->up = 1;
@@ -735,7 +734,6 @@ static int _rtl92e_sta_down(struct net_device *dev, bool shutdownrf)
 	if (priv->rtllib->state == RTLLIB_LINKED)
 		rtl92e_leisure_ps_leave(dev);
 
-	priv->bDriverIsGoingToUnload = true;
 	priv->up = 0;
 	priv->rtllib->ieee_up = 0;
 	priv->bfirst_after_down = true;
@@ -838,7 +836,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->polling_timer_on = 0;
 	priv->up_first_time = 1;
 	priv->blinked_ingpio = false;
-	priv->bDriverIsGoingToUnload = false;
 	priv->being_init_adapter = false;
 	priv->initialized_at_probe = false;
 	priv->bdisable_nic = false;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index c536131ecd5d..1ae3c77e2fef 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -311,7 +311,6 @@ struct r8192_priv {
 	bool		bfirst_after_down;
 	bool		initialized_at_probe;
 	bool		being_init_adapter;
-	bool		bDriverIsGoingToUnload;
 
 	int		irq;
 	short	irq_enabled;
-- 
2.37.3

