Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242465B3F67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiIITVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiIITVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:21:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239FF13E4E8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:21:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s11so3943480edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=MkAY/Jcu/hkscnGDVcOYDI45azzXGp9MrTrjBXlU/cA=;
        b=au1S7C3TORZbne2ymkdz4Gjz1ynnIJR9sm2Hkb2weOmzXTcshEODiY4BRU5Q4WCKDV
         Ai+n1LpoIEh7CeGyW7ykmhVbgMo3ekrF8jh7c+SOdPreNgV72nsalQzhr7BVfgdrdFG6
         Iz9qVGXWbuO3tYUAVFoJzMUA6rNzCaNH1OPTbYYU02lWdkEnynPp6ZmzAfkyKqKy9h6y
         ZokA6B+OWvFWDlx+0vxrrtczP4K9GU8iQpPeewvmHxTu61ZRaFyCkBOs9LidWALvC0ni
         Nr/cMKBfvF/BiaIOYmcAL79c9ZPL+xm7bDgOCOf9FRmlk3PlT71OfxdoXyngXMlI1rXZ
         OhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MkAY/Jcu/hkscnGDVcOYDI45azzXGp9MrTrjBXlU/cA=;
        b=G1stxQ232WX8mhniXsuRgyyWTpynzUz9zXcGpwrMSxUCB+H1HM3SyH9dtnu9tfYrvf
         5A76mqMIwpnuSBz/PDwrMIpHE9kj1sDwN5qbq5DfF1LMcRCNV5XATAFLO1wivSp501OQ
         0ypSkdYUtidbV75wyCknUOt8jZIMGz/ELFE057keOQIz2bmjLHD66IhlKWm+0g2CGa2Z
         yQSdOeazbcvji5nBk9NMzK/B1nr3DUKvx70H9TaDEr3ZJuo8RjRlL+ZRGtjrPOCyJ2WM
         jW/T45a09s+AdgUEtivzCwDQCfs67gb5f4rPEGaWMP4E52lbijnDfz3HHG+QevOigyNC
         A/rg==
X-Gm-Message-State: ACgBeo16fEeT3Tx7oPRSpBLV2BBxsCAarjEgHRP7uxDCq7QYRV8OVvUw
        c7tjb2OFgY/EVRaEWcCtlidUUKY3d9M=
X-Google-Smtp-Source: AA6agR4iO7uEvZ6T8gHyCCuuNYv6WhbBg9DMz2grQwKWvsXDsZ+HOE1A8lPM03V8IT4f+YWZGoHoeg==
X-Received: by 2002:a05:6402:34c2:b0:44f:322f:f0de with SMTP id w2-20020a05640234c200b0044f322ff0demr9775354edc.297.1662751274410;
        Fri, 09 Sep 2022 12:21:14 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b00764a76d5888sm672812ejh.27.2022.09.09.12.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 12:21:13 -0700 (PDT)
Date:   Fri, 9 Sep 2022 21:21:11 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] staging: rtl8192e: Rename bActionAllowed
Message-ID: <e8b617ab58c360bb485cb51d080a8ef81cd47869.1662402870.git.philipp.g.hortmann@gmail.com>
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

Rename variable bActionAllowed to action_allowed to avoid CamelCase which
is not accepted by checkpatch.pl.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 005c4fd966eb..e904a8704e5d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -137,7 +137,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_device *ieee = priv->rtllib;
-	bool			bActionAllowed = false;
+	bool action_allowed = false;
 	bool			bConnectBySSID = false;
 	enum rt_rf_power_state rtState;
 	u16			RFWaitCounter = 0;
@@ -177,7 +177,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 
 		if (!priv->rtllib->RfOffReason) {
 			priv->rtllib->RfOffReason = 0;
-			bActionAllowed = true;
+			action_allowed = true;
 
 			if (rtState == eRfOff &&
 			    change_source >= RF_CHANGE_BY_HW)
@@ -202,19 +202,19 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 		if ((change_source == RF_CHANGE_BY_HW) && !priv->bHwRadioOff)
 			priv->bHwRadioOff = true;
 		priv->rtllib->RfOffReason |= change_source;
-		bActionAllowed = true;
+		action_allowed = true;
 		break;
 
 	case eRfSleep:
 		priv->rtllib->RfOffReason |= change_source;
-		bActionAllowed = true;
+		action_allowed = true;
 		break;
 
 	default:
 		break;
 	}
 
-	if (bActionAllowed) {
+	if (action_allowed) {
 		rtl92e_set_rf_power_state(dev, state_to_set);
 		if (state_to_set == eRfOn) {
 			if (bConnectBySSID && priv->blinked_ingpio) {
@@ -228,7 +228,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 	spin_lock_irqsave(&priv->rf_ps_lock, flag);
 	priv->RFChangeInProgress = false;
 	spin_unlock_irqrestore(&priv->rf_ps_lock, flag);
-	return bActionAllowed;
+	return action_allowed;
 }
 
 static short _rtl92e_check_nic_enough_desc(struct net_device *dev, int prio)
-- 
2.37.2

