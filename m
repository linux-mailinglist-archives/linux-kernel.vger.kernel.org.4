Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772B8662FF9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbjAITJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbjAITJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:09:04 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DFA3FC85
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:09:01 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r26so14024568edc.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CcTDCJVTG9eANRkVa7iv7hN1YnFrfeblrrLWZBP7MBA=;
        b=XxdrcDNU+mPGWv4xYhF9ZKoaX8Wen2hDHRNorvUoqyY0dRverQMCyhqHmVGAX8Q7mJ
         e0NSRKgKAndlG7QhIKcG9lZFWdaw1i4LmoIDl+sMTxhv3MH1hbWQePfFAoJO4anP7kim
         9vHnexrQRxFsT/LVdmrMUG0AuFN0J5Q62HOgolRhApMYcFIvuQfOd53m3tOIeugD8wpJ
         R3Uvq8+9YKAJSsI/extdmMCSdIrbsEtLbAbvhYT0EuFXqy0m9eYi4uQG1Ny9TVX7p0Bq
         3QAwAs7iTzjkFB7vMh6W20LKyDOQ4MkrjRJ+5XzM19IUwjLSVwD58Rk9vUM4m6ueyox9
         dVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcTDCJVTG9eANRkVa7iv7hN1YnFrfeblrrLWZBP7MBA=;
        b=jqgHZo17EQ87KCtRd+IcDNiJk/rB1WJh9Hyvq/EpQF5y4d4jTS2/eIc6s7tQof0KKl
         qk35rOCLgyOYddiTApK2T89gVYADW44Lwi5xut7p3vFGrBo3SGankycBjxGvMSASPezK
         SyEWDFxWCH9WJgVbG4uI5h9RZq7xYxVrD76flG6Kw5kU4bN22sst5rF42y+YwEvSoA6x
         K0ENZVQnUCNgvoLmerV9CaEKBSTKNHk3Au6Lds7MW0WKsLTUuF8PoG1QjrOceSUFRfIN
         jh6sK0OfSijRyFFTJklVYBPbyPk9Bm1M5aPwaSxLrIUG9YLYEwXRJIREjzUDw14oB5Sq
         +aOQ==
X-Gm-Message-State: AFqh2kpMn0S2nLCg+HAXbed3EcnU1GkC5HhWthELsuuazjdJq16Xhg4a
        K7X7AsORm8UMrk6BxtAyZfU=
X-Google-Smtp-Source: AMrXdXtdW+VT/dvka9eu9/AVlIGH3zj7xjzBP+UJpSEXcx5DHfhiwwCjvZnqkxwrj/+zYqtjypaFVw==
X-Received: by 2002:aa7:d1c9:0:b0:48c:a058:8897 with SMTP id g9-20020aa7d1c9000000b0048ca0588897mr7546484edp.3.1673291340281;
        Mon, 09 Jan 2023 11:09:00 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906318b00b0078d3f96d293sm4082658ejy.30.2023.01.09.11.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:08:59 -0800 (PST)
Date:   Mon, 9 Jan 2023 20:08:58 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] staging: rtl8192e: Rename TxPowerLevelOFDM24G...
Message-ID: <6bb354bd6f6387a26378de3b154d975b826a1a88.1673290428.git.philipp.g.hortmann@gmail.com>
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

Rename variable TxPowerLevelOFDM24G to tx_pwr_level_ofdm_24g,
TxPowerLevelOFDM24G_A to tx_pwr_level_ofdm_24g_a and TxPowerLevelOFDM24G_C
to tx_pwr_level_ofdm_24g_c to avoid CamelCase which is not accepted by
checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 14 +++++++-------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 12 ++++++------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  6 +++---
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index ec817de1ca59..ab9e2265df6f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -410,7 +410,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 			for (i = 0; i < 14; i++) {
 				priv->tx_pwr_level_cck[i] =
 					 priv->EEPROMTxPowerLevelCCK[i];
-				priv->TxPowerLevelOFDM24G[i] =
+				priv->tx_pwr_level_ofdm_24g[i] =
 					 priv->EEPROMTxPowerLevelOFDM24G[i];
 			}
 			priv->LegacyHTTxPowerDiff =
@@ -429,31 +429,31 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 			for (i = 0; i < 3; i++) {
 				priv->tx_pwr_level_cck_a[i] =
 					 priv->EEPROMRfACCKChnl1TxPwLevel[0];
-				priv->TxPowerLevelOFDM24G_A[i] =
+				priv->tx_pwr_level_ofdm_24g_a[i] =
 					 priv->EEPROMRfAOfdmChnlTxPwLevel[0];
 				priv->tx_pwr_level_cck_c[i] =
 					 priv->EEPROMRfCCCKChnl1TxPwLevel[0];
-				priv->TxPowerLevelOFDM24G_C[i] =
+				priv->tx_pwr_level_ofdm_24g_c[i] =
 					 priv->EEPROMRfCOfdmChnlTxPwLevel[0];
 			}
 			for (i = 3; i < 9; i++) {
 				priv->tx_pwr_level_cck_a[i]  =
 					 priv->EEPROMRfACCKChnl1TxPwLevel[1];
-				priv->TxPowerLevelOFDM24G_A[i] =
+				priv->tx_pwr_level_ofdm_24g_a[i] =
 					 priv->EEPROMRfAOfdmChnlTxPwLevel[1];
 				priv->tx_pwr_level_cck_c[i] =
 					 priv->EEPROMRfCCCKChnl1TxPwLevel[1];
-				priv->TxPowerLevelOFDM24G_C[i] =
+				priv->tx_pwr_level_ofdm_24g_c[i] =
 					 priv->EEPROMRfCOfdmChnlTxPwLevel[1];
 			}
 			for (i = 9; i < 14; i++) {
 				priv->tx_pwr_level_cck_a[i]  =
 					 priv->EEPROMRfACCKChnl1TxPwLevel[2];
-				priv->TxPowerLevelOFDM24G_A[i] =
+				priv->tx_pwr_level_ofdm_24g_a[i] =
 					 priv->EEPROMRfAOfdmChnlTxPwLevel[2];
 				priv->tx_pwr_level_cck_c[i] =
 					 priv->EEPROMRfCCCKChnl1TxPwLevel[2];
-				priv->TxPowerLevelOFDM24G_C[i] =
+				priv->tx_pwr_level_ofdm_24g_c[i] =
 					 priv->EEPROMRfCOfdmChnlTxPwLevel[2];
 			}
 			priv->LegacyHTTxPowerDiff =
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index ee6138699e10..19c65aaef3f6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -593,17 +593,17 @@ void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
 
 	if (priv->epromtype == EEPROM_93C46) {
 		powerlevel = priv->tx_pwr_level_cck[channel - 1];
-		powerlevelOFDM24G = priv->TxPowerLevelOFDM24G[channel-1];
+		powerlevelOFDM24G = priv->tx_pwr_level_ofdm_24g[channel - 1];
 	} else if (priv->epromtype == EEPROM_93C56) {
 		if (priv->rf_type == RF_1T2R) {
 			powerlevel = priv->tx_pwr_level_cck_c[channel - 1];
-			powerlevelOFDM24G = priv->TxPowerLevelOFDM24G_C[channel-1];
+			powerlevelOFDM24G = priv->tx_pwr_level_ofdm_24g_c[channel - 1];
 		} else if (priv->rf_type == RF_2T4R) {
 			powerlevel = priv->tx_pwr_level_cck_a[channel - 1];
-			powerlevelOFDM24G = priv->TxPowerLevelOFDM24G_A[channel-1];
+			powerlevelOFDM24G = priv->tx_pwr_level_ofdm_24g_a[channel - 1];
 
-			ant_pwr_diff = priv->TxPowerLevelOFDM24G_C[channel-1]
-				       - priv->TxPowerLevelOFDM24G_A[channel-1];
+			ant_pwr_diff = priv->tx_pwr_level_ofdm_24g_c[channel - 1]
+				       - priv->tx_pwr_level_ofdm_24g_a[channel - 1];
 
 			priv->RF_C_TxPwDiff = ant_pwr_diff;
 
@@ -727,7 +727,7 @@ static void _rtl92e_set_tx_power_level(struct net_device *dev, u8 channel)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u8	powerlevel = priv->tx_pwr_level_cck[channel - 1];
-	u8	powerlevelOFDM24G = priv->TxPowerLevelOFDM24G[channel-1];
+	u8	powerlevelOFDM24G = priv->tx_pwr_level_ofdm_24g[channel - 1];
 
 	switch (priv->rf_chip) {
 	case RF_8225:
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 1efaea925b3a..ca61fc60db6e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -473,9 +473,9 @@ struct r8192_priv {
 	u8 tx_pwr_level_cck[14];
 	u8 tx_pwr_level_cck_a[14];
 	u8 tx_pwr_level_cck_c[14];
-	u8		TxPowerLevelOFDM24G[14];
-	u8		TxPowerLevelOFDM24G_A[14];
-	u8		TxPowerLevelOFDM24G_C[14];
+	u8 tx_pwr_level_ofdm_24g[14];
+	u8 tx_pwr_level_ofdm_24g_a[14];
+	u8 tx_pwr_level_ofdm_24g_c[14];
 	u8		LegacyHTTxPowerDiff;
 	s8		RF_C_TxPwDiff;
 	u8		AntennaTxPwDiff[3];
-- 
2.39.0

