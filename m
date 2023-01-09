Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B376C662FEE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbjAITIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbjAITI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:08:29 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F4739FB9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:08:28 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gh17so22657819ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8N//8jqLWrIkBGyfF8wv4Tl2KGsW1laCrcUj0eqwXw=;
        b=TFoZZD8LmwoKwxtRMrcQl1iMqMdHwceJp7ycxW0TaVBkKDXE3wjNkomljwHAlG8l/2
         A5IIo+K8J5R1vLNVNCqrNd9Ka5qxa+SSuxctHMJgm+e/rJApM2uwMEDhXBl+nzINhj9h
         D1LXvNht8HNxQ9h/LIJi49ycActMTGSOWKWOQnGVdUkeVS1JvAT5L2AQT5yNGhU+R4op
         QIgVwU045+VwFvtsA8TZygumzCmL8QAir2feCDUvtLfIvZkf6KQM1qGuFF92KfwcC9tg
         UH7lB/vr9R+2gK/ZVsjHOPehjsyZ6p0hUxorRirNdIsD9j83DL6Ude/JVxDkcKfGSL1G
         UX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8N//8jqLWrIkBGyfF8wv4Tl2KGsW1laCrcUj0eqwXw=;
        b=vLbPBDeHaHqn/qJAzg8lwR3+U7gCs5b/logaXCdf+4aICV/MGrt7yIovvVnWn6tn55
         lVDJJxJICYSBHzHGQqS6kXbTVB/K79JQgzQNU+4q3mto+0N7RbOk8eQrLXxWlbHUTRZ+
         5LOn/ricaNuNKoCZR+IRiUEO+XwGcScmH/UlyXzGN7l7kihAFgz4DKY/n8moMMtiu5fs
         oLk1SZvwcvfvwa6P5sO4KXAC+5quas/SwiPFnnDKFEBh/NrDOCvCjxsqopz46R/n2Tcc
         /6AQPOSBiBz9kPRjagb1TLM2L8sTQKry/oOIdcKkTUBXaCkMI1pfKU49tjV/kOHl4QNc
         1Xlw==
X-Gm-Message-State: AFqh2krJWQsAQUOKfHdyOlhCvA2dgz45HhPiu/QkR0GbVVeFCmszOSIj
        oS51BJK7bOMIbd60f/HrMl4=
X-Google-Smtp-Source: AMrXdXvHlEG9akMoa+0OXhI8w4vMSx5xTtepk+h8iZmdK4QSSVwM7MaaFnFi/ajNPe6nvHLno/8QDQ==
X-Received: by 2002:a17:907:8b95:b0:84c:95c7:302d with SMTP id tb21-20020a1709078b9500b0084c95c7302dmr6110575ejc.5.1673291307022;
        Mon, 09 Jan 2023 11:08:27 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id ss17-20020a170907039100b0084debc3fdadsm788983ejb.188.2023.01.09.11.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:08:26 -0800 (PST)
Date:   Mon, 9 Jan 2023 20:08:24 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] staging: rtl8192e: Rename ChannelPlan,
 eeprom_ChannelPlan and CckPwEnl
Message-ID: <aee78a6adf41a2096898e0c0c5ef45e9f7e1659b.1673290428.git.philipp.g.hortmann@gmail.com>
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

