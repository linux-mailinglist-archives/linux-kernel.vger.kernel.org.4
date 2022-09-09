Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60D5B3F6C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiIITWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiIITWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:22:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DCFAE234
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:22:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id go34so6283472ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 12:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=TMh6t7G9NdPiJyPu/5Xw7Bp/D3+9IHUcuENuk80sd2g=;
        b=q7ufebPgNN8xCMPpedrlgVtyngBCuKkQZF40DvWuEX/KEkJrAVhgAO96yP6kY2T9Da
         hOZ4+5RqV4lonS2pgDAYBVNg6YZ4g0RHVLMD4h2hphFmYJvsD4vjnf9TAjKF9jZ7JhwO
         xBp8FiRcTno4sx2bezCyYv1EeAw+vH9z5+7+HBVrtGOTnMVUatm1JqHPPIqdu1PNFhTd
         x8p1dFs6/EEsfhr/CfzH1aPNinSTBI7yKO4sjM1iMx4soYLhTcZ04cqjnkM4w+UyjDea
         GqOc544LRa9i+9KGssfPUfhX34Z7Z9XcutD7mn0Jf+Lm/9EZepygMsZ0Z7a1/Jm9cLvH
         UpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TMh6t7G9NdPiJyPu/5Xw7Bp/D3+9IHUcuENuk80sd2g=;
        b=hg+Hg3cfS/DPEwVeZEzshl0k7KxAjM+4PpKWsVytWcBdWNB2JziE7PCqrQ2/CeUgfC
         opZXjZP+uEQeU35nPR9R5gFPTlLpPt11bFa9fFD+c4Ru1Or9ui1Cm9Jpb7HBZem5HLcu
         horInFHzKpAy7X97gEvixFg4OFKLMgol2v7wKFM93+PlndyyLHjJySmFMl+7F7QANcbj
         DwIoVGb7CVtwiSiCNiVMU12tHIQh/PqAE0N0PUc8wJUObLXmvPm3W7pTyLVmZqmU8XhN
         9NcPBaAczVrg7zdHlsfXkdPZ/NjMdbBFiwPwToO9sRte3VMecWyyqn4Imx1ihh3sjx1B
         JImw==
X-Gm-Message-State: ACgBeo1Apy7VjSJYMOq1/u9zy/TaOwd9olT/cl6A1cYR5Gp8b5gTZVdg
        mjIS27v6t6Qa3qWH1sVxsq4=
X-Google-Smtp-Source: AA6agR4xLNysPngTkmrESvh5cAL8QI+3n03YoS0N9A9U1mpfkhqM9e3lv0VjyrwRHki/O0hQ89htTg==
X-Received: by 2002:a17:907:2ccc:b0:741:990f:fe48 with SMTP id hg12-20020a1709072ccc00b00741990ffe48mr10634200ejc.390.1662751327985;
        Fri, 09 Sep 2022 12:22:07 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060cd200b0077085fdd613sm673340ejh.44.2022.09.09.12.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 12:22:07 -0700 (PDT)
Date:   Fri, 9 Sep 2022 21:22:05 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] staging: rtl8192e: Rename bHwRadioOff
Message-ID: <bb977791e835310e51e9c38cc5c547e0b8a35e0c.1662402870.git.philipp.g.hortmann@gmail.com>
References: <cover.1662402870.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662402870.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable bHwRadioOff to hw_radio_off to avoid CamelCase which is
not accepted by checkpatch.pl.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 12 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   | 10 ++---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 40 ++++++++++----------
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index e7aacccfa37e..fb9e5fe5fa5d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -172,8 +172,8 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 	case eRfOn:
 		priv->rtllib->RfOffReason &= (~change_source);
 
-		if ((change_source == RF_CHANGE_BY_HW) && priv->bHwRadioOff)
-			priv->bHwRadioOff = false;
+		if ((change_source == RF_CHANGE_BY_HW) && priv->hw_radio_off)
+			priv->hw_radio_off = false;
 
 		if (!priv->rtllib->RfOffReason) {
 			priv->rtllib->RfOffReason = 0;
@@ -199,8 +199,8 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 						      WLAN_REASON_DISASSOC_STA_HAS_LEFT);
 			}
 		}
-		if ((change_source == RF_CHANGE_BY_HW) && !priv->bHwRadioOff)
-			priv->bHwRadioOff = true;
+		if ((change_source == RF_CHANGE_BY_HW) && !priv->hw_radio_off)
+			priv->hw_radio_off = true;
 		priv->rtllib->RfOffReason |= change_source;
 		action_allowed = true;
 		break;
@@ -878,7 +878,7 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	memset(&priv->InterruptLog, 0, sizeof(struct log_int_8190));
 	priv->RxCounter = 0;
 	priv->rtllib->wx_set_enc = 0;
-	priv->bHwRadioOff = false;
+	priv->hw_radio_off = false;
 	priv->RegRfOff = false;
 	priv->isRFOff = false;
 	priv->bInPowerSaveMode = false;
@@ -1292,7 +1292,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	bool	bHigherBusyRxTraffic = false;
 	bool bEnterPS = false;
 
-	if (!priv->up || priv->bHwRadioOff)
+	if (!priv->up || priv->hw_radio_off)
 		return;
 
 	if (priv->rtllib->state >= RTLLIB_LINKED) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index e851f2471288..093887bcd463 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -392,7 +392,7 @@ struct r8192_priv {
 	u16		ShortRetryLimit;
 	u16		LongRetryLimit;
 
-	bool		bHwRadioOff;
+	bool		hw_radio_off;
 	bool		blinked_ingpio;
 	u8		polling_timer_on;
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index d58800d06e8f..3ee52147960e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1819,15 +1819,15 @@ static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
 
 	eRfPowerStateToSet = (tmp1byte&BIT1) ?  eRfOn : eRfOff;
 
-	if (priv->bHwRadioOff && (eRfPowerStateToSet == eRfOn)) {
+	if (priv->hw_radio_off && (eRfPowerStateToSet == eRfOn)) {
 		RT_TRACE(COMP_RF, "gpiochangeRF  - HW Radio ON\n");
 		netdev_info(dev, "gpiochangeRF  - HW Radio ON\n");
-		priv->bHwRadioOff = false;
+		priv->hw_radio_off = false;
 		bActuallySet = true;
-	} else if (!priv->bHwRadioOff && (eRfPowerStateToSet == eRfOff)) {
+	} else if (!priv->hw_radio_off && (eRfPowerStateToSet == eRfOff)) {
 		RT_TRACE(COMP_RF, "gpiochangeRF  - HW Radio OFF\n");
 		netdev_info(dev, "gpiochangeRF  - HW Radio OFF\n");
-		priv->bHwRadioOff = true;
+		priv->hw_radio_off = true;
 		bActuallySet = true;
 	}
 
@@ -1835,7 +1835,7 @@ static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
 		mdelay(1000);
 		priv->bHwRfOffAction = 1;
 		rtl92e_set_rf_state(dev, eRfPowerStateToSet, RF_CHANGE_BY_HW);
-		if (priv->bHwRadioOff)
+		if (priv->hw_radio_off)
 			argv[1] = "RFOFF";
 		else
 			argv[1] = "RFON";
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 70aa47568f3a..ab0bd12ddfda 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -52,7 +52,7 @@ static int _rtl92e_wx_set_rate(struct net_device *dev,
 	int ret;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
@@ -71,7 +71,7 @@ static int _rtl92e_wx_set_rts(struct net_device *dev,
 	int ret;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
@@ -99,7 +99,7 @@ static int _rtl92e_wx_set_power(struct net_device *dev,
 	int ret;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->bHwRadioOff) {
+	if (priv->hw_radio_off) {
 		netdev_warn(dev, "%s(): Can't set Power: Radio is Off.\n",
 			    __func__);
 		return 0;
@@ -129,7 +129,7 @@ static int _rtl92e_wx_set_rawtx(struct net_device *dev,
 	struct r8192_priv *priv = rtllib_priv(dev);
 	int ret;
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
@@ -228,7 +228,7 @@ static int _rtl92e_wx_set_debug(struct net_device *dev,
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u8 c = *extra;
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	netdev_info(dev, "=====>%s(), *extra:%x, debugflag:%x\n", __func__,
@@ -250,7 +250,7 @@ static int _rtl92e_wx_set_mode(struct net_device *dev,
 	enum rt_rf_power_state rt_state;
 	int ret;
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 	rt_state = priv->rtllib->eRFPowerState;
 	mutex_lock(&priv->wx_mutex);
@@ -391,7 +391,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 			return 0;
 	}
 
-	if (priv->bHwRadioOff) {
+	if (priv->hw_radio_off) {
 		netdev_info(dev, "================>%s(): hwradio off\n",
 			    __func__);
 		return 0;
@@ -473,7 +473,7 @@ static int _rtl92e_wx_get_scan(struct net_device *dev,
 	if (!priv->up)
 		return -ENETDOWN;
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
@@ -492,7 +492,7 @@ static int _rtl92e_wx_set_essid(struct net_device *dev,
 	struct r8192_priv *priv = rtllib_priv(dev);
 	int ret;
 
-	if (priv->bHwRadioOff) {
+	if (priv->hw_radio_off) {
 		netdev_info(dev,
 			    "=========>%s():hw radio off,or Rf state is eRfOff, return\n",
 			    __func__);
@@ -560,7 +560,7 @@ static int _rtl92e_wx_set_freq(struct net_device *dev,
 	int ret;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
@@ -586,7 +586,7 @@ static int _rtl92e_wx_set_frag(struct net_device *dev,
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	if (wrqu->frag.disabled)
@@ -622,7 +622,7 @@ static int _rtl92e_wx_set_wap(struct net_device *dev,
 	int ret;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
@@ -669,7 +669,7 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
 			     {0x00, 0x00, 0x00, 0x00, 0x00, 0x03} };
 	int i;
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	if (!priv->up)
@@ -754,7 +754,7 @@ static int _rtl92e_wx_set_scan_type(struct net_device *dev,
 	int *parms = (int *)p;
 	int mode = parms[0];
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	priv->rtllib->active_scan = mode;
@@ -770,7 +770,7 @@ static int _rtl92e_wx_set_retry(struct net_device *dev,
 	struct r8192_priv *priv = rtllib_priv(dev);
 	int err = 0;
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
@@ -843,7 +843,7 @@ static int _rtl92e_wx_set_sens(struct net_device *dev,
 
 	short err = 0;
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
@@ -870,7 +870,7 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_device *ieee = priv->rtllib;
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
@@ -950,7 +950,7 @@ static int _rtl92e_wx_set_auth(struct net_device *dev,
 
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
@@ -967,7 +967,7 @@ static int _rtl92e_wx_set_mlme(struct net_device *dev,
 
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
@@ -984,7 +984,7 @@ static int _rtl92e_wx_set_gen_ie(struct net_device *dev,
 
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->bHwRadioOff)
+	if (priv->hw_radio_off)
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
-- 
2.37.2

