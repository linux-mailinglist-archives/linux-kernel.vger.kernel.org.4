Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8798D5F1B7F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJAJlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJAJlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:41:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E7B48E92
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:40:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hy2so13479815ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=tiHEeB6TjFnhc8x7qSHIzbwC1sWIPqTA0JDil3Jab/8=;
        b=PRunBM/zgiMysLtVxGQ/cec3nGW1rX8/tgYvx3oqT8xNd4zXZYXqG2pFXRHnSVHM8q
         NgMXWRtDtH6SDuR10iexHPCZjTwtUh0xOsk4C5ayRhkBMEzPFvVPbvcj1y0Xefrs2VEB
         +7BW+s2kqJbG6VaXKigjrdDOj7sRVUqiOMzOMvj7NF4NkfHZrkDcrKMite5CKXb80E4L
         ZlHieikXlMjwtDVQXOSpme/BdmTUWtYTS/y5SRB31YnNe1gST9PCc3N8xEZJlk5lDPz+
         YIFPAETvdzolgljipkN6kfqvexBkEmaE1WCm48ZCGDs+miitiMYn0WvtXhn+T8mJG2mk
         uTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tiHEeB6TjFnhc8x7qSHIzbwC1sWIPqTA0JDil3Jab/8=;
        b=c3RF/z6Hq5NbP7NF1EIx2sCASnnHmTHYWx/mLPiIkSh4RoNoHcJlO8y/AziozToEFm
         fntUGwm9L7l5QT+WQXX2wCXPAgS9Z//sqZdpbjBFHkwAOwElNiOvEGKxIqJMrcBWzFA2
         1GCJ/f1uD321nky9aM2hugHbVphw5Et5/6/Ne7hCVRx6i4PyxfyY79BKhYaigcxZZjD2
         dZjTgFEso7TTwtei2QOPfzX2lYnRBNi4dAcOtgOGgDxuB64Cel1jrKP4Lc2mHy0Yv/Y6
         LY5IoQfbJ1PlpCxa9YmTnWyc8XkYh8pGt69YvEnE6gzPUVh4pJHJuzc/nQSMwlzj6WRX
         FGPw==
X-Gm-Message-State: ACrzQf13tuLO4yaimleMSd/g40Hz4Aexc1TPMRtOk/XJqXdYtXTO/Wea
        YkrncDfzbu3YEjO4mp2ZtqM=
X-Google-Smtp-Source: AMsMyM68p6g31K1WfupGcvPa5F9voDNuO8IsIu6mvUojneC/8jfGxwPVErFJQ4ohP7YYvIwkngBsZQ==
X-Received: by 2002:a17:907:78b:b0:741:3d29:33d2 with SMTP id xd11-20020a170907078b00b007413d2933d2mr9653610ejb.103.1664617258527;
        Sat, 01 Oct 2022 02:40:58 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id pk5-20020a170906d7a500b0077016f4c6d4sm2487384ejb.55.2022.10.01.02.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 02:40:58 -0700 (PDT)
Date:   Sat, 1 Oct 2022 11:40:56 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] staging: rtl8192e: Remove unused variable
 bInPowerSaveMode
Message-ID: <be3ebecd88b85ba1d87b9b3fbe02f2e78e6a669e.1664616227.git.philipp.g.hortmann@gmail.com>
References: <cover.1664616227.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664616227.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bInPowerSaveMode is just once initialized and changed but never evaluated.
Remove resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c   | 2 --
 3 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index cbb65cfea83a..db55b9b65192 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -881,7 +881,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->hw_radio_off = false;
 	priv->RegRfOff = false;
 	priv->isRFOff = false;
-	priv->bInPowerSaveMode = false;
 	priv->rtllib->rf_off_reason = 0;
 	priv->rf_change_in_progress = false;
 	priv->bHwRfOffAction = 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 7021f9c435d9..28733dc2038b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -475,7 +475,6 @@ struct r8192_priv {
 
 	bool RegRfOff;
 	bool isRFOff;
-	bool bInPowerSaveMode;
 	u8 bHwRfOffAction;
 
 	bool rf_change_in_progress;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index fba86ef730b5..1ced5bcebdab 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -122,7 +122,6 @@ void rtl92e_ips_enter(struct net_device *dev)
 		(priv->rtllib->iw_mode != IW_MODE_MASTER)) {
 		pPSC->eInactivePowerState = rf_off;
 		priv->isRFOff = true;
-		priv->bInPowerSaveMode = true;
 		_rtl92e_ps_update_rf_state(dev);
 	}
 }
@@ -138,7 +137,6 @@ void rtl92e_ips_leave(struct net_device *dev)
 	if (rt_state != rf_on  && !pPSC->bSwRfProcessing &&
 	    priv->rtllib->rf_off_reason <= RF_CHANGE_BY_IPS) {
 		pPSC->eInactivePowerState = rf_on;
-		priv->bInPowerSaveMode = false;
 		_rtl92e_ps_update_rf_state(dev);
 	}
 }
-- 
2.37.3

