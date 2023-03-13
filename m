Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CD16B851F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCMWr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjCMWrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:47:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334DF25961
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:47:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r11so3298564edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678747596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7TLZPnNjrnRgbjwrvS44w5hw2N4GLY0cSoAaZVi2pEE=;
        b=m2RSEuBg0uEtg2iVzUp5mmt9ug6IBwTaXbhdRNeZes19EZssRfA1BB4LCbEdmW6pAz
         jm44m5UyhfAUX3+7i+m/3yhxih4YgEUpHfGiKXZchdyequTJ8eoP5wmW2ZosP5DJ48aE
         LpPSiJQXvT7dz7gTBxe40aEAvUGoa5h9SAy+hETJNEE8BgTuuzn2N2I3scH90WAttozv
         7WDzIhJJ4eiBcbkaEL/87QznljGgGadRH54DuXHXXgEzweeABef0CY6pnvdQZbtBGOl1
         YB5k8yBveAYl0U8O2oLkxaKhWRoml6+uBOhUnxrYBH18Dfhld8aGrNayTA/IxKvv3Y6y
         YSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678747596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TLZPnNjrnRgbjwrvS44w5hw2N4GLY0cSoAaZVi2pEE=;
        b=aGa9yjwAdvp8S5AexAmxYxzGZdsgdoR8lrTSHnZPaqkJuVU8h38psDDkM2ZZaXePR6
         K4PpP0Rn0G70CSxFk4vxJEjVaXEZYGggn7T2zqVeT5pJ7ZWVf4q4dodywBCUdgpEYXXv
         l0EtA9ZeT11OUjgo3Dj9OS1donf7Y4VYKuEbvqmbt5Qxzpip3xqPB2pxq4W2SozDZRrr
         s7QEqUQu7fhIXh9DjsJtcQ0HhK6FCDvt6ta7CcBPfk1gb1DJFhMRLMCVClDdb1KhSF2e
         Ibk838+4wzpfhixXpmytX3BaF/ItdUvoAXR8KR7/+MfIpCQ3usUf0POpi5dpnFd0qlb/
         0PBw==
X-Gm-Message-State: AO0yUKVNm1JsI3EIrBNOjfA0SN9Vt0wdH7SLg+G4unfIJCzesA9dW1Ek
        BWMIIfHdS6WDa/v6Tbz130w=
X-Google-Smtp-Source: AK7set84rSY1OsAj8JuHwi2bhHdSLhfvney4ee37GxjdCGjMcvFLEcvNLfIrlF0fkpKd4/m1wWYVJQ==
X-Received: by 2002:a17:906:73c9:b0:8f0:ba09:4abe with SMTP id n9-20020a17090673c900b008f0ba094abemr12465653ejl.2.1678747595930;
        Mon, 13 Mar 2023 15:46:35 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id de11-20020a1709069bcb00b008d1dc5f5692sm309765ejc.76.2023.03.13.15.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:46:35 -0700 (PDT)
Date:   Mon, 13 Mar 2023 23:46:33 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8192e: Remove function
 rtl92e_is_legal_rf_path
Message-ID: <b801f1f9ff3c58aedab4e3e07b2ec0a816fdf5d9.1678740713.git.philipp.g.hortmann@gmail.com>
References: <cover.1678740713.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678740713.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function rtl92e_is_legal_rf_path that will always return 1. Reason
is that the eRFPath is always 0 for RF90_PATH_A or 1 for RF90_PATH_B but
never 2 or 3. In most usage cases this is easy to see but for the
following functions that use rtl92e_is_legal_rf_path it is more
difficult:
rtl92e_set_rf_reg and rtl92e_get_rf_reg are used in:
rtl92e_set_bandwidth (eRFPath only for 0 and 1)
rtl92e_config_rf (eRFPath only for 0 and 1)
_rtl92e_phy_switch_channel_step (eRFPath only for 0 and 1)
_rtl92e_dm_check_tx_power_tracking_thermal (eRFPath only for 0)
rtl92e_check_bb_and_rf is used in:
rtl92e_config_rf (eRFPath only for 0 and 1)
_rtl92e_bb_config_para_file (eRFPath only for 0)
rtl92e_config_rf_path is used in:
rtl92e_config_rf (eRFPath only for 0 and 1)
Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8190P_rtl8256.c |  6 ------
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  2 --
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 18 ------------------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h |  1 -
 4 files changed, 27 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index ecbcf0d5bb68..bb4539e337c8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -22,9 +22,6 @@ void rtl92e_set_bandwidth(struct net_device *dev,
 	}
 
 	for (eRFPath = 0; eRFPath < priv->num_total_rf_path; eRFPath++) {
-		if (!rtl92e_is_legal_rf_path(dev, eRFPath))
-			continue;
-
 		switch (bandwidth) {
 		case HT_CHANNEL_WIDTH_20:
 			rtl92e_set_rf_reg(dev, (enum rf90_radio_path)eRFPath,
@@ -67,9 +64,6 @@ bool rtl92e_config_rf(struct net_device *dev)
 
 	for (eRFPath = (enum rf90_radio_path)RF90_PATH_A;
 	     eRFPath < priv->num_total_rf_path; eRFPath++) {
-		if (!rtl92e_is_legal_rf_path(dev, eRFPath))
-			continue;
-
 		pPhyReg = &priv->phy_reg_def[eRFPath];
 
 		switch (eRFPath) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index fb4eede0470a..1e7be321721b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1515,8 +1515,6 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 
 	if (!prev_st->bIsCCK && prev_st->bPacketToSelf) {
 		for (rfpath = RF90_PATH_A; rfpath < priv->num_total_rf_path; rfpath++) {
-			if (!rtl92e_is_legal_rf_path(priv->rtllib->dev, rfpath))
-				continue;
 			if (priv->stats.rx_rssi_percentage[rfpath] == 0) {
 				priv->stats.rx_rssi_percentage[rfpath] =
 					 prev_st->RxMIMOSignalStrength[rfpath];
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index e3886db3bfbb..51a20379dca0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -47,20 +47,6 @@ static u32 _rtl92e_calculate_bit_shift(u32 dwBitMask)
 	return ffs(dwBitMask) - 1;
 }
 
-u8 rtl92e_is_legal_rf_path(struct net_device *dev, u32 eRFPath)
-{
-	u8 ret = 1;
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	if (priv->rf_type == RF_1T2R) {
-		if (eRFPath == RF90_PATH_A || eRFPath == RF90_PATH_B)
-			ret = 1;
-		else if (eRFPath == RF90_PATH_C || eRFPath == RF90_PATH_D)
-			ret = 0;
-	}
-	return ret;
-}
-
 void rtl92e_set_bb_reg(struct net_device *dev, u32 dwRegAddr, u32 dwBitMask,
 		       u32 dwData)
 {
@@ -196,8 +182,6 @@ void rtl92e_set_rf_reg(struct net_device *dev, enum rf90_radio_path eRFPath,
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u32 Original_Value, BitShift, New_Value;
 
-	if (!rtl92e_is_legal_rf_path(dev, eRFPath))
-		return;
 	if (priv->rtllib->rf_power_state != rf_on && !priv->being_init_adapter)
 		return;
 
@@ -233,8 +217,6 @@ u32 rtl92e_get_rf_reg(struct net_device *dev, enum rf90_radio_path eRFPath,
 	u32 Original_Value, Readback_Value, BitShift;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (!rtl92e_is_legal_rf_path(dev, eRFPath))
-		return 0;
 	if (priv->rtllib->rf_power_state != rf_on && !priv->being_init_adapter)
 		return	0;
 	mutex_lock(&priv->rf_mutex);
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index ac640033e843..f1d183ed7ca4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -49,7 +49,6 @@ enum rf90_radio_path {
 #define bMaskLWord                0x0000ffff
 #define bMaskDWord                0xffffffff
 
-u8 rtl92e_is_legal_rf_path(struct net_device *dev, u32 eRFPath);
 void rtl92e_set_bb_reg(struct net_device *dev, u32 dwRegAddr,
 		       u32 dwBitMask, u32 dwData);
 u32 rtl92e_get_bb_reg(struct net_device *dev, u32 dwRegAddr, u32 dwBitMask);
-- 
2.39.2

