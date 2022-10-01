Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9DF5F1B81
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJAJlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJAJlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:41:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EE08051D
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:41:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m15so8773367edb.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=aCkr8qk5ZO2rVhVTWEWIP6+TWOWpwdW6xSFiVrbuIos=;
        b=PL/XzRHpegfVqBK8FO6quJouUt7zG3NxP5g4qA/AUNVfwGkAbOJawvlWPKmHnCVRuT
         qm9GEYpCljIhIP1hFmWXV/8S8UofuEgIYUtf2EEuJDSjzYjsSp3UGm7okE8rBvuBoWqS
         ZNfkDnGsoKaY3rFVqRdVLhVGFBQEoLNh5lB/4nBLzSNNmeaG2ZTFwbiJiImy1gtxH17d
         dHFnQE3IWMKDSHtMsgwjd4z7ro00FhFWIqx7nAcj0K4MgLaMwpDW748yPOrMCrXZ8DUD
         M1dXRz7dV5VsV6MfgSeDVQGvOdFacW+iV9Ww3Opi93qneuirUJ5rj+kYjZKbzSuUKSkw
         1vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aCkr8qk5ZO2rVhVTWEWIP6+TWOWpwdW6xSFiVrbuIos=;
        b=XJaIFB3BWj1HSRJ9GUYGLU/Y3OgyN/glD74exfe8mIuLsIVp4lXhTpfgM5/htIDlpI
         N92a2N/tayPOtViMomCVIkSz6nK1moxS1GTTHUMWw0iOCo4yw+pC6SZ53HN+mSlZHxZH
         kQ4LqbRCpfkK8428ghukxcvJFg6RCLxY1Vfb7Pket0YPxZFaIdPCk9iXcjjdLiXFAGOC
         glu+OW6lDsqsYXSrHDbu2F1LYt3QX6W3LfgDP2yVJqrQgvtuFpyL7cpJyLK08+vmq+Pd
         IazWL/mIRmPwbxYA3u6ybi5mQ6SxctWV2W25GK4Mi4g9mPFRkETE1kW4LMY+/bZmU1lI
         +hKg==
X-Gm-Message-State: ACrzQf0j7zP4v4oawMz2ljEPaHxh5pvORSes8l/QIBOnRtl2j/wE2kRU
        SuXG/4lbZo95gLi6clMkzWGIdfmd9G0=
X-Google-Smtp-Source: AMsMyM5/KC85qeACNLVaRwtsvESTas+p8tyMuovWELs50vRMetEmUrf1/9jJ7DaEyNf9dxnyMVGNTQ==
X-Received: by 2002:a05:6402:1e8d:b0:454:79a9:201f with SMTP id f13-20020a0564021e8d00b0045479a9201fmr11221668edf.176.1664617272811;
        Sat, 01 Oct 2022 02:41:12 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id rp9-20020a170906d96900b0077fb63da010sm2449730ejb.114.2022.10.01.02.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 02:41:12 -0700 (PDT)
Date:   Sat, 1 Oct 2022 11:41:10 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] staging: rtl8192e: Remove unchanged variable RegRfOff
Message-ID: <fa306d364b43fee7b81f5289309e93bb6fccdba5.1664616227.git.philipp.g.hortmann@gmail.com>
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

RegRfOff is just once initialized with false and then set to false again.
All evaluations will result in false. Remove resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 7 +------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 2 --
 4 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 18e4e5d84878..f2cbec6eb08f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -624,9 +624,6 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	}
 	priv->pFirmware->status = FW_STATUS_0_INIT;
 
-	if (priv->RegRfOff)
-		priv->rtllib->rf_power_state = rf_off;
-
 	ulRegRead = rtl92e_readl(dev, CPU_GEN);
 	if (priv->pFirmware->status == FW_STATUS_0_INIT)
 		ulRegRead |= CPU_GEN_SYSTEM_RESET;
@@ -756,9 +753,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 
 	rtl92e_writeb(dev, 0x87, 0x0);
 
-	if (priv->RegRfOff) {
-		rtl92e_set_rf_state(dev, rf_off, RF_CHANGE_BY_SW);
-	} else if (priv->rtllib->rf_off_reason > RF_CHANGE_BY_PS) {
+	if (priv->rtllib->rf_off_reason > RF_CHANGE_BY_PS) {
 		rtl92e_set_rf_state(dev, rf_off, priv->rtllib->rf_off_reason);
 	} else if (priv->rtllib->rf_off_reason >= RF_CHANGE_BY_IPS) {
 		rtl92e_set_rf_state(dev, rf_off, priv->rtllib->rf_off_reason);
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 1b592258e640..a44dffa76a39 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1325,7 +1325,6 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 
 				do {
 					InitilizeCount--;
-					priv->RegRfOff = false;
 					rtstatus = rtl92e_enable_nic(dev);
 				} while (!rtstatus && (InitilizeCount > 0));
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 3cddc9a86f28..e77a73df9bc5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -879,7 +879,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->RxCounter = 0;
 	priv->rtllib->wx_set_enc = 0;
 	priv->hw_radio_off = false;
-	priv->RegRfOff = false;
 	priv->rtllib->rf_off_reason = 0;
 	priv->rf_change_in_progress = false;
 	priv->bHwRfOffAction = 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 23dccd6079ea..7d716fa12995 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -472,8 +472,6 @@ struct r8192_priv {
 
 	u16 RegChannelPlan;
 	u16 ChannelPlan;
-
-	bool RegRfOff;
 	u8 bHwRfOffAction;
 
 	bool rf_change_in_progress;
-- 
2.37.3

