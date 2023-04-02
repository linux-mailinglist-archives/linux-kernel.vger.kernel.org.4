Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D306D36C0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjDBJwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjDBJwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:52:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C921E1BF79
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 02:52:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h8so106308324ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 02:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680429122; x=1683021122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mPalzn3j45ikPjT3aRccNp7p7+9165ZTfapmFphFUHY=;
        b=M2LZmF84K5PaWvGfhAd9RAgX8+pIOyPa5ZkoljoOxi+fNNAY+EN8e0kUQURdXqHeac
         rq37xn/t+Or7SwfBy+V/pHdnd5dhf0FzpSFM/lF+cogNljTsD+ySns69JJtnBuZFvmY/
         l1Z8CSrtYLteFt9YZZvVaxku6dECKL/iGnxGLdcAxAOWM+22gjoRFz3vw2x2vc0L3AhS
         UqAuUNzsxK1xMCsVuhdsF13WakMo1932/wXO4XIz7WBGbwt5sVAYZuT2RrIbSw+Mutt8
         9aUdO+eddzs4osK/9rjtiZI3w46sngqi1Qkp6bIlTPd+a9Iiu9mVYMcuoVu6NBRaXeFk
         O80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680429122; x=1683021122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPalzn3j45ikPjT3aRccNp7p7+9165ZTfapmFphFUHY=;
        b=tOgjrAuPBpKkMNLYksv+7IL1ooNjGaU4pScsxvVHUYRssDO/EOBU6nZ6L6fhiY8jEy
         yhzegD0fp0h2Kq5cX87QmTvACw73wkdZvvYtyfBnysdrA4xqusXlaDXPWtKs5delvVhB
         4T1l9yMOajIXASyWnukhSVmKFgTSjGK8Jy1/6CuLhcVnCAABGBzt/u2qZzbHApadX2oL
         D8W5JHxtemE72DYjSCDfmyJX2d0GUVVioa3tYDpjRxhLCME83kpp1nxvNXy0n3r7/U2W
         HQNYI3HBMFvDdhDRaLmywk35KiE6U7Udv8Z7YbGCD5tpCSsx6nnTDgS7fxiEerHlEqzu
         rMGQ==
X-Gm-Message-State: AAQBX9fgNiu7hPsUJlTtLcLttCQwc022Rb4vW60EPzyazQ2RHYhZGSfT
        mWQ164mbnXDLiThtQfcyZsE=
X-Google-Smtp-Source: AKy350b0bqkTXDgHMGI6LPEzUsHagvaF3aUWLRswGrfCv2wMtr3uR+ZhlpiN3wlhq7HoA1BI4z4W5w==
X-Received: by 2002:a17:906:1ce:b0:92e:f520:7762 with SMTP id 14-20020a17090601ce00b0092ef5207762mr10352217ejj.6.1680429121988;
        Sun, 02 Apr 2023 02:52:01 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id u13-20020a1709063b8d00b0093e261cc8bcsm3063039ejf.58.2023.04.02.02.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 02:52:01 -0700 (PDT)
Date:   Sun, 2 Apr 2023 11:51:59 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] staging: rtl8192e: Remove case customer_id =
 RT_CID_DLINK
Message-ID: <e4ecef11015c32c9909cd07e0939c4de53fd501a.1680427945.git.philipp.g.hortmann@gmail.com>
References: <cover.1680427945.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680427945.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

customer_id is initialize to zero. Changing customer_id to RT_CID_DLINK
would not change the program execution as there is no equation for
RT_CID_DLINK. Remove useless code lines to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: No changes
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 6 ------
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h  | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 1 -
 3 files changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 1da14e737aa4..cbe66b4a6ad9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -431,9 +431,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 	else
 		priv->chnl_plan = priv->reg_chnl_plan;
 
-	if (priv->eeprom_vid == 0x1186 &&  priv->eeprom_did == 0x3304)
-		priv->customer_id =  RT_CID_DLINK;
-
 	switch (priv->eeprom_customer_id) {
 	case EEPROM_CID_DEFAULT:
 		priv->customer_id = RT_CID_DEFAULT;
@@ -460,9 +457,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 	case EEPROM_CID_Pronet:
 		priv->customer_id = RT_CID_PRONET;
 		break;
-	case EEPROM_CID_DLINK:
-		priv->customer_id = RT_CID_DLINK;
-		break;
 
 	case EEPROM_CID_WHQL:
 		break;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 99640c4779f7..706d024bcfd1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -37,7 +37,6 @@ enum baseband_config {
 #define EEPROM_CID_NetCore				0x5
 #define EEPROM_CID_Nettronix			0x6
 #define EEPROM_CID_Pronet				0x7
-#define EEPROM_CID_DLINK				0x8
 #define EEPROM_CID_WHQL					0xFE
 enum _RTL8192PCI_HW {
 	MAC0			= 0x000,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 1e99eb833405..91d634f5d3e7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -134,7 +134,6 @@ enum rt_customer_id {
 	RT_CID_TOSHIBA	  = 9,
 	RT_CID_819X_NETCORE     = 10,
 	RT_CID_Nettronix	= 11,
-	RT_CID_DLINK	    = 12,
 	RT_CID_PRONET	   = 13,
 };
 
-- 
2.40.0

