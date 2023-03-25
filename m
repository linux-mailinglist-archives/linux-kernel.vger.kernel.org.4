Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D286C8CB5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjCYIho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjCYIhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:37:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC83C19133
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er18so5298990edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TxvwzNHlMhQxqbhDKY/vp8koWCnsLAxNykHAaCh4kRg=;
        b=X/uzSL9Eb0S+87/KxZ9kB9/5y1GkDhCeHTfCE9i/WhoE4SiX0y0Z85UbK3XRpZeF8V
         AH5Nrvm1dJa/yqzWOjEsdVRZaCuuRf4t4/OkNP3VVE+dn0wywLLrBIMhEXMhv8fx3Chl
         Q/H9owBF18aJlv7SuA+dmhP31nyzj+YiaRRSDZc8QXZPWAJYO+yviUVsOQpGOHzA4f7F
         rAlcv1dMw6b3MAD/1ILwUXif59PJ2Pw0UaIaZWwbxTTx0g0B3BjJagOxIA4LZbsXwGzj
         aqluWNZ3HsnrqaeBm2WQ71d32zdD0LZ64R1g6NlHfndddk5VvGh3ObM+G+Z7Fko0jRds
         cV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxvwzNHlMhQxqbhDKY/vp8koWCnsLAxNykHAaCh4kRg=;
        b=kpzoI5Ve5k5Hx5FbghQcGjl3UZoZltvmgPPYoLpaOsDs/s0j3gIqIt5Bp9fcpjOMuV
         VWdzwy/wdxRQsLPk6yBwhHISoEhrzil4/CLsWczFzLi/r4VrDYLmLNZAITTr0GnRA68B
         yG8hngBGnjOO/sXKRN0LNcL5gUdga2w5NMHw7KwBsydQ+22Q2m3xhSkd8nbwxvut8OU4
         H8foKgnvhbloMTs5Ci31k6OtkBDLpGkB94vpax6B1DxPlhI2b4qsYmaaydSpdnSzSvmC
         L2xJlKlZ3qTw7+/YhvPmU8YVZCOYpLkHJnTgLLFEl6hTvS9JR/t1AHU4hufX1bfeBEth
         Ncfw==
X-Gm-Message-State: AAQBX9fiqQ2MVd/U+bGj3gEBSBNBD9pJRbyDZHLSJEuzEw8p/xT/wkTo
        6VptodjBJyXtW0ivWDIExHo=
X-Google-Smtp-Source: AKy350ZXqwFwkJBUMScwJeLFVmcgz2yVWOKHhIkwUr6pBQnsdf+Jbr4TDPm/eqVDFoGEKNehfFH7sw==
X-Received: by 2002:a17:906:74ca:b0:8b1:2614:dea6 with SMTP id z10-20020a17090674ca00b008b12614dea6mr5108823ejl.1.1679733416406;
        Sat, 25 Mar 2023 01:36:56 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906118f00b0092421bf4927sm11642321eja.95.2023.03.25.01.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:36:56 -0700 (PDT)
Date:   Sat, 25 Mar 2023 09:36:54 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] staging: rtl8192e: Remove rf_chip in
 _rtl92e_get_supported_wireless_mode
Message-ID: <e2db309dea3208560337376fec26fa5cfba93848.1679732276.git.philipp.g.hortmann@gmail.com>
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
condition in function _rtl92e_get_supported_wireless_mode as it is dead
code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 3244aef12c05..8e4e939d7617 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -595,23 +595,9 @@ static void _rtl92e_refresh_support_rate(struct r8192_priv *priv)
 
 static u8 _rtl92e_get_supported_wireless_mode(struct net_device *dev)
 {
-	struct r8192_priv *priv = rtllib_priv(dev);
 	u8 ret = 0;
 
-	switch (priv->rf_chip) {
-	case RF_8225:
-	case RF_8256:
-	case RF_6052:
-	case RF_PSEUDO_11N:
-		ret = (WIRELESS_MODE_N_24G | WIRELESS_MODE_G | WIRELESS_MODE_B);
-		break;
-	case RF_8258:
-		ret = (WIRELESS_MODE_A | WIRELESS_MODE_N_5G);
-		break;
-	default:
-		ret = WIRELESS_MODE_B;
-		break;
-	}
+	ret = (WIRELESS_MODE_N_24G | WIRELESS_MODE_G | WIRELESS_MODE_B);
 	return ret;
 }
 
-- 
2.39.2

