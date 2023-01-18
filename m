Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEF06728E6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjARUAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjARUAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:00:24 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888475DC06
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:00:21 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o17-20020a05600c511100b003db021ef437so2416625wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKHxjmN02i/BHbdj2UWJHSksRbf2ziy6vT0R/buc9Kw=;
        b=I5FI9EU/z5BZ4/wpjNCc/vMEvZPZI6KnWjr9ycx26XKe1v+Wat2zoohBGrbayqUYRY
         xAKlpfayi6Fdy//xjIpTh5EgECV1JH1/XcZ5B9AWNI6K7tq68o1NNnuS5QxkmBa78GRO
         LDkIBMMPMNO0VugcwJUAEHMFvWad5CU03fKGxD83Ink33tfnPVrVAZzTfgHMWNJrwOp1
         B5hUZqIJSRh9fbN5fpK6YohtKHepiTXU1QJ28K7sKp8U6qZXLTXyAXpILbteVl5gw+yT
         G7joulItwvXIsbwlMQuci08Jrl+q+XMXS5ECAG9up8gwfVj+cxQwjma+0DZ3RT02BVPT
         dH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKHxjmN02i/BHbdj2UWJHSksRbf2ziy6vT0R/buc9Kw=;
        b=1M6Xjj8dN8wL6fEK4JPYI1FqV95WKP2cHrEMsD6grHub11Pss51kUPPGqYvYezdH9V
         D9VWXD1o+rMP58cfsNq7tixz0BFrjQTMA/5AofugCUioDVVc9XNr+AtvzaTfI5ZjRuvY
         NDUBwRKSCdR4/erCOnSg0iKF7wAHPcky9Jhq8PWMNdPq/BKejcqjBzw//xKcPrTwN9rg
         D0yEoIavO6eS3eENnTTNFlkAs2Fj2PxDUrLSGKvvUdp8ZKAPaciCDvlVOgg/ZNB4B5aE
         YIAcpWWYH/tAR+lBuGPI16eDMKg1TkpEXkfeGRoEFyt5ajVV1zpbx3QMiPdpT2w60+ZI
         EFVA==
X-Gm-Message-State: AFqh2kqfxDh6eUH+2biZRME8gY/gU0vcxMi41zUdNBo0sD3kLMvLg086
        qp/o0aTI2S7yOueYVFy3s7A=
X-Google-Smtp-Source: AMrXdXtM6vpOEkGvWWDvDbC+610yIbibv+L0IS1JciOtIsHsPzq60bZVFNIVj8rFbJneozPo3mCOag==
X-Received: by 2002:a05:600c:3b29:b0:3da:f7a9:50ca with SMTP id m41-20020a05600c3b2900b003daf7a950camr2017626wms.0.1674072020111;
        Wed, 18 Jan 2023 12:00:20 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d65c1000000b002be15ee1377sm6184451wrw.22.2023.01.18.12.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:00:19 -0800 (PST)
Date:   Wed, 18 Jan 2023 21:00:17 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] staging: rtl8192e: Remove unused variable DM_Type
Message-ID: <380fa2767d1f1cc32a5ad271057683d67ceb1b6f.1674071236.git.philipp.g.hortmann@gmail.com>
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

DM_Type is initialized and then never evaluated. Remove resulting dead
code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h   | 2 --
 3 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 6662558e56fa..11f3f88491b2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -457,8 +457,6 @@ struct r8192_priv {
 	bool set_rf_pwr_state_in_progress;
 	bool bdisable_nic;
 
-	u8 DM_Type;
-
 	u8 cck_pwr_enl;
 	u16 tssi_13dBm;
 	u32 pwr_track;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index cb55b6645674..ba92dab682ec 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -203,8 +203,6 @@ void rtl92e_dm_init(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	priv->DM_Type = DM_Type_ByDriver;
-
 	priv->undecorated_smoothed_pwdb = -1;
 
 	_rtl92e_dm_init_dynamic_tx_power(dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 1d4d7d98a859..65d077dfee37 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -47,8 +47,6 @@
 #define		TX_RETRY_COUNT_REG		0x1ac
 #define		RegC38_TH				 20
 
-#define		DM_Type_ByDriver		1
-
 /*--------------------------Define Parameters-------------------------------*/
 
 
-- 
2.39.0

