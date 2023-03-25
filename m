Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F021B6C8CAD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjCYIgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjCYIfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:35:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE7918B00
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:35:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b20so16614516edd.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733347; x=1682325347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OtIYOlrEQ6ezmFUmDEHNM3uU5E+lWona9mVF/nvcfZ8=;
        b=dlCMbDJFvAx5eJsoyWDnb8bGX9oUMgTZX/0FamcM+s9vtXAFihUgrJah6WDD3LKRyy
         kzGa6PRSs1Tk6fKaH69zeKiodA5uqR2BoCyAgsCr/LuAGys4fnrwRPXcicr1yijNkLIJ
         TgCMHq7sZBNgibwQ+YU0uaWF3HOGmau//FWI2AfPkJNMrNAUGNMObVSFeaw41ysHlvRW
         TRr3iaeKSlSK6+cCbHhXbqqO7VjiEetFD9sK4+GJyQMqzag6DQp/24tBXPQof8t6kReZ
         6EWxsw02e1vWRB3LnQppnbu12Fmh6f16RlSWWD9DIRt6tgkDVTW7irEN5oFlQB++iFTL
         NTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733347; x=1682325347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtIYOlrEQ6ezmFUmDEHNM3uU5E+lWona9mVF/nvcfZ8=;
        b=e+C1JPm64G+wURWO/GfYqoE++J+71UuYkIbRbI42x+jNVTqvZgpd4pPoXM0l8laNuw
         3lsvJt+NxJuW7rcHCWcky/Cgnr5NLp9UvGS8/WJc8T3LCB+NWcfcv332mBML0fzzbDpD
         SxlQqlsOjFf7Ypr1AvoqQUClKni76b8YQ0xJ14FWI1r31NrWUUk8++FQeqGajT6dkAhR
         3YDS1EOXVt0JSmbwC8GbBQdNnYx4XtvaYZmRY0+wNs03aOcmCI8xfGY4ysmlRWRtiISU
         xr8QmAKo6yF6UOnf20YO1SUG5EDRYaj51WfKveWuMR4UU+V37LbSFGMbq8gncQ8GD7UU
         Ql6w==
X-Gm-Message-State: AAQBX9eo73Rkwl05JhQajqB2E601/W3ZCIh69YZ2vbGiICNJ4Gv2kpen
        V7cWesNhl+2TAe0r7CC6SfY/gjFAu88=
X-Google-Smtp-Source: AKy350Zu03goyVTjXDhMxOEDqqc5iF0P/X4FQg4fZyRTd/jl9FvVZ+lUgnmQ6SLI5VT7zQeKmEj6tQ==
X-Received: by 2002:a17:906:209e:b0:8d3:be84:1cc6 with SMTP id 30-20020a170906209e00b008d3be841cc6mr4172218ejq.3.1679733347206;
        Sat, 25 Mar 2023 01:35:47 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id qb16-20020a1709077e9000b0093f3d41b9ebsm683134ejc.220.2023.03.25.01.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:35:46 -0700 (PDT)
Date:   Sat, 25 Mar 2023 09:35:45 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] staging: rtl8192e: Remove priv->rf_chip in
 rtl92e_set_tx_power
Message-ID: <190d0a77602cb89bc24512c99b72f25f4ca5d5e2.1679732276.git.philipp.g.hortmann@gmail.com>
References: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

priv->rf_chip is initialized to RF_8256 and never changed. Remove
condition in function rtl92e_set_tx_power as it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index acd1e1869d78..6579c7b81bfd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -485,19 +485,8 @@ void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
 		powerlevelOFDM24G = priv->tx_pwr_level_ofdm_24g[channel - 1];
 	}
 
-	switch (priv->rf_chip) {
-	case RF_8225:
-		break;
-	case RF_8256:
-		rtl92e_set_cck_tx_power(dev, powerlevel);
-		rtl92e_set_ofdm_tx_power(dev, powerlevelOFDM24G);
-		break;
-	case RF_8258:
-		break;
-	default:
-		netdev_err(dev, "Invalid RF Chip ID.\n");
-		break;
-	}
+	rtl92e_set_cck_tx_power(dev, powerlevel);
+	rtl92e_set_ofdm_tx_power(dev, powerlevelOFDM24G);
 }
 
 bool rtl92e_config_phy(struct net_device *dev)
-- 
2.39.2

