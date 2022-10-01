Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AEC5F1B7B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJAJkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJAJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:40:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367C043E69
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:40:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bj12so13446506ejb.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=odNlku/fCB1Yowy4jooGlZap4i4f7PBMesjt3jUU6no=;
        b=MgTFyiDKe6Bw+E1PreJyd5fK6VXZd8cTFxznwErue8pKqT4JCauVnWLVlumklLtOkm
         OBDytSP4TUPUCzYOWlwIVthvw5x/Q5+rHidxBqeG4ZQfgET4d5Zc0/Ro+TPURNyrD9Ls
         hgWJZFMw5vQ2JqujnN5C5KwJuL4Yd1vsQTTpXji549qVM/kXZ1HAjnA58WYaAnTZV2Bo
         EGauzP4IN4SwhAUVRl2pkh2NmIqwUSBMe4Ao7k7zUiOLM4VozpUmbiv+IcPPirnAdpRv
         iUlD/VhJGk1Rj7NzjVLCBb2Z8MqTQYiMre8gEwL50Cu+MFJraGDVNcCRmanpnRLw6Q+2
         MYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=odNlku/fCB1Yowy4jooGlZap4i4f7PBMesjt3jUU6no=;
        b=aDaPg3ETrTDOc4zzdOhoG86FBRel9HnroNPxtgwzuQpZ4gbKfg4UtUn0BXeX/Hrloi
         ii6s+juVZ6DRX7mA7qkBTbOoVVhtPwye1J/YsB/tB7E4HnlHUYb7g2eP8ryxpDmagGnj
         sBmdDpbOh+UlGzFAZkXK71tUr68uNOj66Gup7+7Kdn/jjIyj25dqbrnnMlFuYtGCf5UE
         ebHL0i8VM0LM4ZDZr1/kF1F/moMXC7Yz2ik945qdm+056p4NreubQONZFrrqa711Kfbp
         9whRM0K538bKJdGj0cJQs8qOzbqcv3CU7qjF5JPA0icVWnY14amGnB7nBcLom7hIL3O/
         Y+PA==
X-Gm-Message-State: ACrzQf1GlW7pWWZHhraoBD6sDJBoCOPehq7CyDzsbZq5UEYC2+yGUoAe
        jFYsfHuhd61W66jKhn0rGBnbCnUUQOY=
X-Google-Smtp-Source: AMsMyM7hkgs+NJuyji0aersw2hfU/2jVhWYKR2dOBHuRrB10wwtrzkJH8ZPOFfuC5yBObvR5J2TQbA==
X-Received: by 2002:a17:907:1c9b:b0:783:43c:10b with SMTP id nb27-20020a1709071c9b00b00783043c010bmr9233340ejc.320.1664617231889;
        Sat, 01 Oct 2022 02:40:31 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id dn12-20020a05640222ec00b004585a21df62sm3319990edb.0.2022.10.01.02.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 02:40:31 -0700 (PDT)
Date:   Sat, 1 Oct 2022 11:40:29 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] staging: rtl8192e: Remove unchanged variable bFwCtrlLPS
Message-ID: <d5b5cfd26648180d082f38085a807c932e87703c.1664616227.git.philipp.g.hortmann@gmail.com>
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

bFwCtrlLPS is just once initialized and never changed. The evaluation will
always have the same result. Remove resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c   | 15 ++++-----------
 drivers/staging/rtl8192e/rtllib.h            |  3 ---
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 89bc989cffba..10b79003c633 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -889,7 +889,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rtllib->PowerSaveControl.bInactivePs = true;
 	priv->rtllib->PowerSaveControl.bIPSModeBackup = false;
 	priv->rtllib->PowerSaveControl.bLeisurePs = true;
-	priv->rtllib->PowerSaveControl.bFwCtrlLPS = false;
 	priv->rtllib->LPSDelayCnt = 0;
 	priv->rtllib->sta_sleep = LPS_IS_WAKE;
 	priv->rtllib->rf_power_state = rf_on;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 8c00b111ddb2..49c50ec21d04 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -229,11 +229,8 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 		if (pPSC->LpsIdleCount >= RT_CHECK_FOR_HANG_PERIOD) {
 
 			if (priv->rtllib->ps == RTLLIB_PS_DISABLED) {
-				if (!pPSC->bFwCtrlLPS) {
-					if (priv->rtllib->SetFwCmdHandler)
-						priv->rtllib->SetFwCmdHandler(
-							dev, FW_CMD_LPS_ENTER);
-				}
+				if (priv->rtllib->SetFwCmdHandler)
+					priv->rtllib->SetFwCmdHandler(dev, FW_CMD_LPS_ENTER);
 				_rtl92e_ps_set_mode(dev, RTLLIB_PS_MBCAST |
 							 RTLLIB_PS_UNICAST);
 			}
@@ -251,12 +248,8 @@ void rtl92e_leisure_ps_leave(struct net_device *dev)
 	if (pPSC->bLeisurePs) {
 		if (priv->rtllib->ps != RTLLIB_PS_DISABLED) {
 			_rtl92e_ps_set_mode(dev, RTLLIB_PS_DISABLED);
-
-			if (!pPSC->bFwCtrlLPS) {
-				if (priv->rtllib->SetFwCmdHandler)
-					priv->rtllib->SetFwCmdHandler(dev,
-							 FW_CMD_LPS_LEAVE);
-			}
+			if (priv->rtllib->SetFwCmdHandler)
+				priv->rtllib->SetFwCmdHandler(dev, FW_CMD_LPS_LEAVE);
 		}
 	}
 }
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 3c72ed2a30a4..40bea71bcb22 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1264,9 +1264,6 @@ struct rt_pwr_save_ctrl {
 
 	u32				CurPsLevel;
 	u32				RegRfPsLevel;
-
-	bool				bFwCtrlLPS;
-
 };
 
 #define RT_RF_CHANGE_SOURCE u32
-- 
2.37.3

