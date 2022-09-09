Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45F05B3F66
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiIITVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiIITVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:21:09 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035EB9F8D1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:21:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lz22so6278847ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=uuGKoZi7jbz/BgarBzXWxM5q9C5tlwbcJXG17PWDyHQ=;
        b=PXc5ylOLx/G8fY59PiuB1r5k5miy0zFhLxkQIqzpmKzXnb26oJmW0Ue9aORblq4Zyv
         xCHLqLlJNV4JbXGBAad/Gdk+Hhjor1ogqLeXTG1/CxFsgGWrDnZo+iv29e1rSZ6yli8Y
         tdPNrv0aeBghVcP0zPPU9GtdkCfrEvXt++Zgna8yKJXGG7ebCKfET1xfg+sq1PLrvJ8U
         WGwVVYl/Y63CLpYkXCCGiaguMqNdp1HUi1lDmoXQ1DIe9ZSFPLffVVcjTTEU9G2VGMSQ
         9BHsECPCvx7FLkIisCNe0MdhEj1BP9u1dIZC+ygnMVMJXNjUg2d8wxgAt3EzxmRZUNkp
         LOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uuGKoZi7jbz/BgarBzXWxM5q9C5tlwbcJXG17PWDyHQ=;
        b=bizMXsFgEnJJuB7yoH9DZnN+U4gqrihCKgktVyduJe/1wTE6VaPjCYse1iMt2KWwNB
         VZDzaFXLbsX8CAh+k1JwPMRJYuEGducm9vD94RZyMElVmfEbQYUVOf+VL7A6wg89NavN
         Oum+8R6LOP1KWkRHnsXHlEbTDURQaEkkDliuV5P4yrdUgcaERp3GglTHJJGfPzHBLSkx
         wFxbgH/5Z8dBaimR8AT6SuBlgVS4nPWdsSaoTa2+BCIkuIg026aji/K0V1dH1cwxM9Vf
         ZY7bBlVHikjumeRk8BVDpbhA8u4TjFuPhWgh0AeEHWL03JgpjQVfa/lZSMAddfUmp0or
         DRHQ==
X-Gm-Message-State: ACgBeo16rczMp25SfxKPkp2joiR/x9Gt0J7257Wcp4W29c1o+7XprpWE
        jpoJUIUBnzNAcx4nu9rTt10=
X-Google-Smtp-Source: AA6agR6+Zy5/5XvgD2dW5rBap2quh1dZ5h+VtNaCz3bX/kYA1wJ9tqB03RNdJkXDeNVzd8YF2CzmZA==
X-Received: by 2002:a17:906:ee8e:b0:730:4a24:f311 with SMTP id wt14-20020a170906ee8e00b007304a24f311mr10936370ejb.420.1662751265325;
        Fri, 09 Sep 2022 12:21:05 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id kb8-20020a170907924800b00777d41ba812sm629099ejb.113.2022.09.09.12.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 12:21:04 -0700 (PDT)
Date:   Fri, 9 Sep 2022 21:21:03 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] staging: rtl8192e: Rename ChangeSource
Message-ID: <0d934bb707510692ccd161ea6034b69133aac14c.1662402870.git.philipp.g.hortmann@gmail.com>
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

Rename variable ChangeSource to change_source to avoid CamelCase which
is not accepted by checkpatch.pl.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 16 ++++++++--------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 5ac4817909df..005c4fd966eb 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -133,7 +133,7 @@ void rtl92e_writew(struct net_device *dev, int x, u16 y)
  ****************************************************************************/
 bool rtl92e_set_rf_state(struct net_device *dev,
 			 enum rt_rf_power_state state_to_set,
-			 RT_RF_CHANGE_SOURCE ChangeSource)
+			 RT_RF_CHANGE_SOURCE change_source)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_device *ieee = priv->rtllib;
@@ -170,9 +170,9 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 
 	switch (state_to_set) {
 	case eRfOn:
-		priv->rtllib->RfOffReason &= (~ChangeSource);
+		priv->rtllib->RfOffReason &= (~change_source);
 
-		if ((ChangeSource == RF_CHANGE_BY_HW) && priv->bHwRadioOff)
+		if ((change_source == RF_CHANGE_BY_HW) && priv->bHwRadioOff)
 			priv->bHwRadioOff = false;
 
 		if (!priv->rtllib->RfOffReason) {
@@ -180,7 +180,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 			bActionAllowed = true;
 
 			if (rtState == eRfOff &&
-			    ChangeSource >= RF_CHANGE_BY_HW)
+			    change_source >= RF_CHANGE_BY_HW)
 				bConnectBySSID = true;
 		}
 		break;
@@ -190,7 +190,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 		if ((priv->rtllib->iw_mode == IW_MODE_INFRA) ||
 		    (priv->rtllib->iw_mode == IW_MODE_ADHOC)) {
 			if ((priv->rtllib->RfOffReason > RF_CHANGE_BY_IPS) ||
-			    (ChangeSource > RF_CHANGE_BY_IPS)) {
+			    (change_source > RF_CHANGE_BY_IPS)) {
 				if (ieee->state == RTLLIB_LINKED)
 					priv->blinked_ingpio = true;
 				else
@@ -199,14 +199,14 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 						      WLAN_REASON_DISASSOC_STA_HAS_LEFT);
 			}
 		}
-		if ((ChangeSource == RF_CHANGE_BY_HW) && !priv->bHwRadioOff)
+		if ((change_source == RF_CHANGE_BY_HW) && !priv->bHwRadioOff)
 			priv->bHwRadioOff = true;
-		priv->rtllib->RfOffReason |= ChangeSource;
+		priv->rtllib->RfOffReason |= change_source;
 		bActionAllowed = true;
 		break;
 
 	case eRfSleep:
-		priv->rtllib->RfOffReason |= ChangeSource;
+		priv->rtllib->RfOffReason |= change_source;
 		bActionAllowed = true;
 		break;
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 1796c881a5fa..7dee40481087 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -599,5 +599,5 @@ bool rtl92e_disable_nic(struct net_device *dev);
 
 bool rtl92e_set_rf_state(struct net_device *dev,
 			 enum rt_rf_power_state state_to_set,
-			 RT_RF_CHANGE_SOURCE ChangeSource);
+			 RT_RF_CHANGE_SOURCE change_source);
 #endif
-- 
2.37.2

