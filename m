Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF04F6E359F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjDPHUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjDPHU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:20:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C565435BC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:20:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f0c5a426aaso3847345e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681629608; x=1684221608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3sQy4s8gKGVczlWnljrStDth9N5l0gCvMunNzrUK7V4=;
        b=dquZOYPM9/nNsKWfMEHGolT2T5M7XCO/lBux8GNZUVpURx63aXgcknmp0dYLkkRXlV
         BqOObD6pWZ16ZK89eDqEjCipG5TIhBzdU1Vk9/SnwJusVksnrwJ/DNoDW8WAyTQJpu92
         45UPoFAXANVPRScQigVBTdBdiyd4/TfcW/IAqHfFtQLADHFWDWHTmK05qKvv6Dd6kJZv
         5liMO3fd5o4FzQ4EGVQIJrOx273lOwVfEIyNJuC++NaE1WKRM+x+fcTsEeQTrjUPGaCs
         AEF4GuX0uUCrTe8vOHzqcvfwQFyfCXsQg4fA1pikYjzF98VWpB6r9BwBm8YyklZBt258
         mWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629608; x=1684221608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sQy4s8gKGVczlWnljrStDth9N5l0gCvMunNzrUK7V4=;
        b=SMkJNSUImnc2ftfToEnDbHqsOxCLxrfl9klEkA1J0r/MyFc/I6P85UfMja46Dbh61b
         WzRE2fPnGQ18Zwn/loBcIC8UF8cV7NHUHnEtYP+/7MPZUmB6H6GQKimx4sLo+fFqsplL
         CKI6gjW1kBDvhp4K5sa3+LctL7IcgU+EF/OPoHVNXZ8vmyo63tKjA91REdX/S4QrdcwK
         w65OyC285KmXDdcImcHTZRLShjKAH8v/VX/fpes+6DM+ka5z1LTXse43f8lyJb0UFPcb
         Vk2X060HpEV28mObkUFtlgS+dLGC6bEJYReAkINnS1tDMJP3UDN/RCAahm+AV5tC2riE
         VHFA==
X-Gm-Message-State: AAQBX9evBz8o/iSKwJA8BcKdfGi5GTHIEic8aA2NhdZR3Meq31h+sBKz
        l44wGz2DhFj/24GwMxDg8lV1hwnJ5fo=
X-Google-Smtp-Source: AKy350YZQstyORQTHMwBxbX2MVAYnNGd4gNX/Rg5+KRPqNYjBK3ui7IUxuh9uhUDhy6ZoohJCYpnsw==
X-Received: by 2002:a05:600c:450f:b0:3f1:714d:c40b with SMTP id t15-20020a05600c450f00b003f1714dc40bmr855206wmo.3.1681629608269;
        Sun, 16 Apr 2023 00:20:08 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id iz19-20020a05600c555300b003f1733feb3dsm167648wmb.0.2023.04.16.00.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 00:20:07 -0700 (PDT)
Date:   Sun, 16 Apr 2023 09:20:06 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: rtl8192e: Remove set to true while true of
 bfirst_after_down
Message-ID: <053ab341e80909e81867e42ec4c077e76b762051.1681627603.git.philipp.g.hortmann@gmail.com>
References: <cover.1681627603.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681627603.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set to true while true of bfirst_after_down to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 7342ef591169..ed8b39d3c856 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1542,10 +1542,8 @@ static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
 	if ((priv->up_first_time == 1) || (priv->being_init_adapter))
 		return;
 
-	if (priv->bfirst_after_down) {
-		priv->bfirst_after_down = true;
+	if (priv->bfirst_after_down)
 		return;
-	}
 
 	tmp1byte = rtl92e_readb(dev, GPI);
 
-- 
2.40.0

