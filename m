Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC96634A34
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiKVWqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbiKVWqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:46:02 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAB1BEB71
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:46:01 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p16so11908283wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LaM4uBFPK4LMbdxsIb7pxDSXVMQTFFMHLlfL2JcjVUM=;
        b=bWZjjnUkUXYQxbQ42tbjZksddrd+wvEx1I46C6UKITkM/8kfuyE3hogrMMlwh2IjKw
         rHsxbr7rxGwJQdOuptveRWF5qtSx/KQRNEA4O9k1EWu5UztaoRoDhMsIdVGRbFUqsBWp
         GbTEhkvaPbOpvRQ5cVsx2NLYzyCXZfpl4neqUN1mvwS1egOkWxIGCnENmDAYonbRjiTH
         B5h5konFG5/TSCSjrDJKp/W4Xx9jtmX4HqwRBVUxw4XEb/IrHhJQSYhjKfxbtlL4j3uZ
         HfbwzAK0p0ES8y3FY7EFo3FFtimky4pJB1SWinkCpHw2hkKh9/EDP4vL9VzsX6xFjMKF
         JS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaM4uBFPK4LMbdxsIb7pxDSXVMQTFFMHLlfL2JcjVUM=;
        b=PVu3j7oBKxRe1aapP6WXptr92E2KlU/5fzPQEVCiJue+EgqHumNor8/PQLBlt+ruRP
         nrufHow4gYmTQQ6OaNsYLoHFN9WzsfFMxTzpqsZy8iS1qLqecVeeZgGZE0uwrgYFnqgS
         Vg6ecpJKmfrgYNK8ZQzZq7s6ykplE9aphtQl837kJt70d3//YfrOMZSoH3qirJ8LFj0O
         t9sXcNpHgRW/+fC7JgNZAsF9FyAQNVRAlmUJ7JqbcqEmLz+ACbob7uWynZ3lfIPPsIjq
         ImnbAh8Xrm/Zrg+18Y0Uz3ZiTC4PP4hB8WzPzkTn4wAhnzf2UGIHL5mLqXSAvku3VWoW
         1CPQ==
X-Gm-Message-State: ANoB5pmMKDG6OwqrvY3KSyptgvTmVFFurPOKBg3AL2Rl1RaOB/ouYiyn
        LXeqfRB+tDvQfqdq3S/WYju0xLEYk0w=
X-Google-Smtp-Source: AA0mqf7O/pfxst0Zs/QaWzPCTIu3maDJVE6OQHbQrUhRJmYB+NpG+EhA/mdGAk3WWagvkQf9osM1LA==
X-Received: by 2002:a05:600c:1ca4:b0:3cf:7125:fc1d with SMTP id k36-20020a05600c1ca400b003cf7125fc1dmr4421820wms.70.1669157159967;
        Tue, 22 Nov 2022 14:45:59 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id s2-20020adff802000000b00241c712916fsm13824559wrp.0.2022.11.22.14.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:45:59 -0800 (PST)
Date:   Tue, 22 Nov 2022 23:45:57 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] staging: rtl8192e: Remove unchanged variable AcmMethod
Message-ID: <7d73a66184e13d5f8d4af7d21564032247a7e923.1669156825.git.philipp.g.hortmann@gmail.com>
References: <cover.1669156825.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1669156825.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AcmMethod is initialized and never changed. The evaluation will always
have the same result. Remove resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 2 --
 drivers/staging/rtl8192e/rtl819x_Qos.h         | 7 -------
 4 files changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b9c846015d28..80eba5d5ab37 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -224,8 +224,6 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 		u8 acm = pAciAifsn->f.acm;
 		u8 AcmCtrl = rtl92e_readb(dev, AcmHwCtrl);
 
-		AcmCtrl = AcmCtrl | ((priv->AcmMethod == 2) ? 0x0 : 0x1);
-
 		if (acm) {
 			switch (eACI) {
 			case AC0_BE:
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 399ee9783f99..a8cbeb9545da 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -830,7 +830,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u8 i;
 
-	priv->AcmMethod = eAcmWay2_SW;
 	priv->dot11_current_preamble_mode = PREAMBLE_AUTO;
 	priv->rtllib->status = 0;
 	priv->polling_timer_on = 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index b1656d4ecbad..54c7a2128053 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -340,8 +340,6 @@ struct r8192_priv {
 	struct bb_reg_definition PHYRegDef[4];
 	struct rate_adaptive rate_adaptive;
 
-	enum acm_method AcmMethod;
-
 	struct rt_firmware			*pFirmware;
 	enum rtl819x_loopback LoopbackMode;
 
diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index 5073f9f40fdc..c010eb0d6036 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -97,13 +97,6 @@ enum direction_value {
 	DIR_BI_DIR		= 3,
 };
 
-enum acm_method {
-	eAcmWay0_SwAndHw		= 0,
-	eAcmWay1_HW			= 1,
-	eAcmWay2_SW			= 2,
-};
-
-
 struct acm {
 	u64		UsedTime;
 	u64		MediumTime;
-- 
2.37.3

