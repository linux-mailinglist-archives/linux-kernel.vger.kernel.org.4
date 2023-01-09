Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9593662FEF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbjAITJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbjAITIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:08:55 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941CD3C391
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:08:54 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id cf18so16301891ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZMU1x+tLk0OFGwO9qk4HxCl3v2Y+JR1fHam1odju/4=;
        b=OB/LTABusMIttSRpolHRGe2RIiuDWHWG13bN3ppO4WyfcRn+a/WDmaR1YjSQAcrmcA
         k2ez60PSPSRmPBqqGOuElxT+rBcglhwwfky4BmwEnG+Z/+Jh/p1rzD7sXxnXbjUJxpZB
         uACAgleEtJ4v+FWb4b0S96F5XaZl8DeG+L60CF7ZM02KUrT2zjbIiq8TSivFsqgIml+E
         Bajz2jXwHY22zTkgxXINxTnD3FEeDuGGhg7SR0PG05efzSLfQStfTCCrvb9a+lfq0xqn
         cLZcpyquyPf40ugaOiDBXxiBAYEShj+oRapZQ9Eyc4B9say5O4ozSEpqNplDsCCYTozc
         zXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZMU1x+tLk0OFGwO9qk4HxCl3v2Y+JR1fHam1odju/4=;
        b=xI5qQVrrk9SBEFxwXGPRf1/rX9v+BwMxeVskyDQ/6IHGT+eBjaSzVaTOhMWQXT4++I
         NGaE2eR5vRmsj6Db49tAt6UgPw0JZUYsKkbKmiNfTTcg8x+t+Zq3Iq38vBlw7d+3XqpH
         wrrSqU42Mc+BNKskB0OiWnqjMDZSBzwbxVV6gNKIs9PUvZgNYNNd/9NFVdkg8uTWHUiA
         og+YXHhj5MNRCjyubHbp9CBfwxcXgt5iuL7CSEK7r0NewkDuZiDcCXc/VLNsoXMgEtil
         45J1gZoOAQyb/d9pF2lrDn3r8b5NGWyGu9siBamXakFk170yvJOk11In12+N/nWQVKru
         623w==
X-Gm-Message-State: AFqh2krZmIz5i5zxicFmdj4WACtTqfEqISfAdOg9V98v6dkLkLEhNGj4
        cWptNuk33NE8gAYKuJCdHonHElI2SxQ=
X-Google-Smtp-Source: AMrXdXu7ZDtWWQPtPguBBWqpEMGojFE8xUIljZYuY0yg54sMXqwaB0eOISFjJKxDpzY58FR4Lv4TuA==
X-Received: by 2002:a17:906:9c85:b0:7c0:d7af:fce3 with SMTP id fj5-20020a1709069c8500b007c0d7affce3mr12499739ejc.1.1673291333241;
        Mon, 09 Jan 2023 11:08:53 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id gn19-20020a1709070d1300b00815835b4b5fsm4038886ejc.134.2023.01.09.11.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:08:52 -0800 (PST)
Date:   Mon, 9 Jan 2023 20:08:51 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] staging: rtl8192e: Rename TxPowerLevelCCK...
Message-ID: <c18af327debcf85f3498be9c7a1492d501748669.1673290428.git.philipp.g.hortmann@gmail.com>
References: <cover.1673290428.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673290428.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable TxPowerLevelCCK to tx_pwr_level_cck, TxPowerLevelCCK_A to
tx_pwr_level_cck_a and TxPowerLevelCCK_C to tx_pwr_level_cck_c to avoid
CamelCase which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 14 +++++++-------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c |  8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  6 +++---
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 5c5326491e90..ec817de1ca59 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -408,7 +408,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		}
 		if (priv->epromtype == EEPROM_93C46) {
 			for (i = 0; i < 14; i++) {
-				priv->TxPowerLevelCCK[i] =
+				priv->tx_pwr_level_cck[i] =
 					 priv->EEPROMTxPowerLevelCCK[i];
 				priv->TxPowerLevelOFDM24G[i] =
 					 priv->EEPROMTxPowerLevelOFDM24G[i];
@@ -427,31 +427,31 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		} else if (priv->epromtype == EEPROM_93C56) {
 
 			for (i = 0; i < 3; i++) {
-				priv->TxPowerLevelCCK_A[i] =
+				priv->tx_pwr_level_cck_a[i] =
 					 priv->EEPROMRfACCKChnl1TxPwLevel[0];
 				priv->TxPowerLevelOFDM24G_A[i] =
 					 priv->EEPROMRfAOfdmChnlTxPwLevel[0];
-				priv->TxPowerLevelCCK_C[i] =
+				priv->tx_pwr_level_cck_c[i] =
 					 priv->EEPROMRfCCCKChnl1TxPwLevel[0];
 				priv->TxPowerLevelOFDM24G_C[i] =
 					 priv->EEPROMRfCOfdmChnlTxPwLevel[0];
 			}
 			for (i = 3; i < 9; i++) {
-				priv->TxPowerLevelCCK_A[i]  =
+				priv->tx_pwr_level_cck_a[i]  =
 					 priv->EEPROMRfACCKChnl1TxPwLevel[1];
 				priv->TxPowerLevelOFDM24G_A[i] =
 					 priv->EEPROMRfAOfdmChnlTxPwLevel[1];
-				priv->TxPowerLevelCCK_C[i] =
+				priv->tx_pwr_level_cck_c[i] =
 					 priv->EEPROMRfCCCKChnl1TxPwLevel[1];
 				priv->TxPowerLevelOFDM24G_C[i] =
 					 priv->EEPROMRfCOfdmChnlTxPwLevel[1];
 			}
 			for (i = 9; i < 14; i++) {
-				priv->TxPowerLevelCCK_A[i]  =
+				priv->tx_pwr_level_cck_a[i]  =
 					 priv->EEPROMRfACCKChnl1TxPwLevel[2];
 				priv->TxPowerLevelOFDM24G_A[i] =
 					 priv->EEPROMRfAOfdmChnlTxPwLevel[2];
-				priv->TxPowerLevelCCK_C[i] =
+				priv->tx_pwr_level_cck_c[i] =
 					 priv->EEPROMRfCCCKChnl1TxPwLevel[2];
 				priv->TxPowerLevelOFDM24G_C[i] =
 					 priv->EEPROMRfCOfdmChnlTxPwLevel[2];
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 33b39b1dc655..ee6138699e10 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -592,14 +592,14 @@ void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
 	u32	u4RegValue;
 
 	if (priv->epromtype == EEPROM_93C46) {
-		powerlevel = priv->TxPowerLevelCCK[channel-1];
+		powerlevel = priv->tx_pwr_level_cck[channel - 1];
 		powerlevelOFDM24G = priv->TxPowerLevelOFDM24G[channel-1];
 	} else if (priv->epromtype == EEPROM_93C56) {
 		if (priv->rf_type == RF_1T2R) {
-			powerlevel = priv->TxPowerLevelCCK_C[channel-1];
+			powerlevel = priv->tx_pwr_level_cck_c[channel - 1];
 			powerlevelOFDM24G = priv->TxPowerLevelOFDM24G_C[channel-1];
 		} else if (priv->rf_type == RF_2T4R) {
-			powerlevel = priv->TxPowerLevelCCK_A[channel-1];
+			powerlevel = priv->tx_pwr_level_cck_a[channel - 1];
 			powerlevelOFDM24G = priv->TxPowerLevelOFDM24G_A[channel-1];
 
 			ant_pwr_diff = priv->TxPowerLevelOFDM24G_C[channel-1]
@@ -726,7 +726,7 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
 static void _rtl92e_set_tx_power_level(struct net_device *dev, u8 channel)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	u8	powerlevel = priv->TxPowerLevelCCK[channel-1];
+	u8	powerlevel = priv->tx_pwr_level_cck[channel - 1];
 	u8	powerlevelOFDM24G = priv->TxPowerLevelOFDM24G[channel-1];
 
 	switch (priv->rf_chip) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 344b2c92843a..1efaea925b3a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -470,9 +470,9 @@ struct r8192_priv {
 	long undecorated_smoothed_pwdb;
 
 	u32 MCSTxPowerLevelOriginalOffset[6];
-	u8 TxPowerLevelCCK[14];
-	u8 TxPowerLevelCCK_A[14];
-	u8 TxPowerLevelCCK_C[14];
+	u8 tx_pwr_level_cck[14];
+	u8 tx_pwr_level_cck_a[14];
+	u8 tx_pwr_level_cck_c[14];
 	u8		TxPowerLevelOFDM24G[14];
 	u8		TxPowerLevelOFDM24G_A[14];
 	u8		TxPowerLevelOFDM24G_C[14];
-- 
2.39.0

