Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D761F658F08
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiL2Q0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiL2QZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:25:44 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29DBB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:25:42 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u28so22456929edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8N//8jqLWrIkBGyfF8wv4Tl2KGsW1laCrcUj0eqwXw=;
        b=SOjIqDPJjAG3X8J2l0O1eskK3G1j4SzA1AkgO3M8IcMOGAfztcEIN0KSRvfW5nTL1c
         QBqK6wQBjo+GxJGcwUPfSufBmYCEG3TLjOMiDGPiiuVXw0rvqyLeALougT+LBzP5wIxj
         FKIF5Zf3HX4K9c4oDeZV6RpaA8xspwXNhozk6x1PgN16C+nxgRIHqjGNUSzAHBcn9eaz
         9w/cO6YzILmXE6rmSLYAZSe3PEvroAtnMweberW0+j9NEJ1iiJ8e5tvf58Pl9/Xco093
         b2cywR8IKDTatE3ZgHYEZcH6wBbtedaqn0qeZr/RqvE9g7wzJ178dmD3oLadYRT6tBfC
         AVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8N//8jqLWrIkBGyfF8wv4Tl2KGsW1laCrcUj0eqwXw=;
        b=WEYuxA7I2PkLcWt6MO8iGV3KGISGCgKt6u3tILzgRJFojN3WmJuPa+bgRACGntppdp
         gNONBW1nQRi2ZN+WFDldAcN28c+k5ECIUFcVTUkJI8bzrl9wp9Z0wpX0JSyFgs9Qs2YX
         KOlayZXh6rm2p1gWofuLEx4aa8abMbi9bR/M54ewzLMA9N4ar5i9BDwE68H+uSPu1TF6
         HQjUSLspn7dICt8afXVX1aVkogtc43+X4U9c7QGubVFAEIePYkjHd4xXPrLjKXwxWUyK
         6vbdrUtTZQsfrB5qwpfxx6T5rLh1pGqwSAvYXKyT3DYRgOIU9rjdwJSQoB7+qm1CHnKH
         O2Ow==
X-Gm-Message-State: AFqh2kqqY89IANcKg97Udbs6fpQfii2wsFsM/YhS3hv/peHusj5HWTMY
        26S1OJxVogm7fQPDtiKxJp6jUWZvJ7Q=
X-Google-Smtp-Source: AMrXdXtAgAaBcAczHzVDiavvwBqKWtBJ7XKXpu6mOv6PHDKBjjo6OQGw73CzqRIFzxE01OfbMiFeVg==
X-Received: by 2002:aa7:dd13:0:b0:479:8313:2fe6 with SMTP id i19-20020aa7dd13000000b0047983132fe6mr4986436edv.1.1672331140891;
        Thu, 29 Dec 2022 08:25:40 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id bm25-20020a0564020b1900b0045cf4f72b04sm8420941edb.94.2022.12.29.08.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:25:40 -0800 (PST)
Date:   Thu, 29 Dec 2022 17:25:38 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] staging: rtl8192e: Rename ChannelPlan,
 eeprom_ChannelPlan and CckPwEnl
Message-ID: <1b705718afdcf56475c10db4b284d2c91a58b250.1672330343.git.philipp.g.hortmann@gmail.com>
References: <cover.1672330343.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1672330343.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable ChannelPlan to chnl_plan, eeprom_ChannelPlan to
eeprom_chnl_plan and CckPwEnl to cck_pwr_enl to avoid CamelCase which is
not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |  2 +-
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 20 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  6 +++---
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index ab2e9b729883..93928f3585c1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -154,7 +154,7 @@ void rtl92e_set_cck_tx_power(struct net_device *dev, u8 powerlevel)
 		if (priv->CustomerID == RT_CID_819x_Netcore)
 			TxAGC = 0x22;
 		else
-			TxAGC += priv->CckPwEnl;
+			TxAGC += priv->cck_pwr_enl;
 	}
 	if (TxAGC > 0x24)
 		TxAGC = 0x24;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index f02e67f68e23..25fa7714df4e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -306,7 +306,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		priv->eeprom_CustomerID = usValue & 0xff;
 		usValue = rtl92e_eeprom_read(dev,
 					     EEPROM_ICVersion_ChannelPlan>>1);
-		priv->eeprom_ChannelPlan = usValue&0xff;
+		priv->eeprom_chnl_plan = usValue&0xff;
 		IC_Version = (usValue & 0xff00)>>8;
 
 		ICVer8192 = IC_Version & 0xf;
@@ -328,7 +328,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		priv->eeprom_vid = 0;
 		priv->eeprom_did = 0;
 		priv->eeprom_CustomerID = 0;
-		priv->eeprom_ChannelPlan = 0;
+		priv->eeprom_chnl_plan = 0;
 	}
 
 	if (!priv->AutoloadFailFlag) {
@@ -473,9 +473,9 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 	priv->rf_chip = RF_8256;
 
 	if (priv->reg_chnl_plan == 0xf)
-		priv->ChannelPlan = priv->eeprom_ChannelPlan;
+		priv->chnl_plan = priv->eeprom_chnl_plan;
 	else
-		priv->ChannelPlan = priv->reg_chnl_plan;
+		priv->chnl_plan = priv->reg_chnl_plan;
 
 	if (priv->eeprom_vid == 0x1186 &&  priv->eeprom_did == 0x3304)
 		priv->CustomerID =  RT_CID_DLINK;
@@ -495,10 +495,10 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		break;
 	case EEPROM_CID_TOSHIBA:
 		priv->CustomerID = RT_CID_TOSHIBA;
-		if (priv->eeprom_ChannelPlan&0x80)
-			priv->ChannelPlan = priv->eeprom_ChannelPlan&0x7f;
+		if (priv->eeprom_chnl_plan & 0x80)
+			priv->chnl_plan = priv->eeprom_chnl_plan & 0x7f;
 		else
-			priv->ChannelPlan = 0x0;
+			priv->chnl_plan = 0x0;
 		break;
 	case EEPROM_CID_Nettronix:
 		priv->CustomerID = RT_CID_Nettronix;
@@ -516,9 +516,9 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		break;
 	}
 
-	if (priv->ChannelPlan > CHANNEL_PLAN_LEN - 1)
-		priv->ChannelPlan = 0;
-	priv->ChannelPlan = COUNTRY_CODE_WORLD_WIDE_13;
+	if (priv->chnl_plan > CHANNEL_PLAN_LEN - 1)
+		priv->chnl_plan = 0;
+	priv->chnl_plan = COUNTRY_CODE_WORLD_WIDE_13;
 
 	if (priv->eeprom_vid == 0x1186 &&  priv->eeprom_did == 0x3304)
 		priv->rtllib->bSupportRemoteWakeUp = true;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f8fbe78ccad9..92260d098eaa 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -862,7 +862,7 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->cck_present_attn = 0;
 	priv->rfa_txpowertrackingindex = 0;
 	priv->rfc_txpowertrackingindex = 0;
-	priv->CckPwEnl = 6;
+	priv->cck_pwr_enl = 6;
 	priv->rst_progress = RESET_TYPE_NORESET;
 	priv->force_reset = false;
 	memset(priv->rtllib->swcamtable, 0, sizeof(struct sw_cam_table) * 32);
@@ -952,13 +952,13 @@ static short _rtl92e_get_channel_map(struct net_device *dev)
 		return -1;
 	}
 
-	if (priv->ChannelPlan >= COUNTRY_CODE_MAX) {
+	if (priv->chnl_plan >= COUNTRY_CODE_MAX) {
 		netdev_info(dev,
 			    "rtl819x_init:Error channel plan! Set to default.\n");
-		priv->ChannelPlan = COUNTRY_CODE_FCC;
+		priv->chnl_plan = COUNTRY_CODE_FCC;
 	}
 	dot11d_init(priv->rtllib);
-	dot11d_channel_map(priv->ChannelPlan, priv->rtllib);
+	dot11d_channel_map(priv->chnl_plan, priv->rtllib);
 	for (i = 1; i <= 11; i++)
 		(priv->rtllib->active_channel_map)[i] = 1;
 	(priv->rtllib->active_channel_map)[12] = 2;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index cceb77492363..93b3b75a063f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -420,7 +420,7 @@ struct r8192_priv {
 	u16 eeprom_vid;
 	u16 eeprom_did;
 	u8 eeprom_CustomerID;
-	u16 eeprom_ChannelPlan;
+	u16 eeprom_chnl_plan;
 
 	u8 EEPROMTxPowerLevelCCK[14];
 	u8 EEPROMTxPowerLevelOFDM24G[14];
@@ -451,7 +451,7 @@ struct r8192_priv {
 	bool bTXPowerDataReadFromEEPORM;
 
 	u16 reg_chnl_plan;
-	u16 ChannelPlan;
+	u16 chnl_plan;
 	u8 hw_rf_off_action;
 
 	bool rf_change_in_progress;
@@ -460,7 +460,7 @@ struct r8192_priv {
 
 	u8 DM_Type;
 
-	u8 CckPwEnl;
+	u8 cck_pwr_enl;
 	u16 TSSI_13dBm;
 	u32 Pwr_Track;
 	u8 CCKPresentAttentuation_20Mdefault;
-- 
2.39.0

