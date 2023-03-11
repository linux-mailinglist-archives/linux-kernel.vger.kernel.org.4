Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8937E6B613A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCKVwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCKVwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:52:18 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF5969057
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:51:45 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g10so5580494eda.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678571499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OkZ4Olpuxh5E3cDSkJctHgzhe5euz/pqRRghSABvVlc=;
        b=SEht0PddCHabZafa5KLInfvaUrCDhb/wI+0h7XhFmCtjLMwojaI8lGBbdmwoVCWRqD
         jmbEJ8pFyMl7u6tFvBGLwun0ozPTG8/JLtjgJSpQTBzTBBtlJWYvOhI4b5NNt/YdXsyE
         bsfJ2f62XRrBtIZaWDiAtojkaiC6yUiM5a4800H/bAR7QvtR59W3InOdlmZhnf+zObC4
         AkEwSD54I2HY/BqBjhfASqM3C6/ZdElhLfOTzVjCNv2d6VCfeasJzWqQw+zvqngO5/4B
         4hxPiDssEYxsIfaHQNkLct3YiTUDcX8jZDrzxDcaYWqAGpl8x8Pg1wVws6NOUWITBwsO
         BV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkZ4Olpuxh5E3cDSkJctHgzhe5euz/pqRRghSABvVlc=;
        b=ZS1Cj8JUG4WmYMw92z6mLINwPdrrou7vk/ttGTkz08LOlw83huO5Cj5ou+Yq0ysA05
         BvvKNLsPMJgflbwgmf66Y0KonruWbSoyXRUCytljeGeGSVf2epTg2T3aYYsGrkLOQTCb
         UojFYWOfCfzrOskqD5Jk5bUZcK2yxk5etsSfwPSjEdzkiqPRP//qoFE4DIhER0SFKcdK
         kHuW0zuiMW9oZ37XcacO6nEn3F3RMla2r29NEhmPP41pqy9HYyVmSEy2jGfUOP/iUylW
         LiytGwihwYxK7bDpL+0i5FEkDmSoqM2nZZLsbu71FOgJfB3WDhe4IDkqQ+Hd9YiP1yi3
         3YZQ==
X-Gm-Message-State: AO0yUKUVbkCQlbAA/4OgtmhexHNksNP0iPMXZPELZquANJ+4rXzSZOWB
        GTaPRb45THRZ7ZnkgBXXDg9vNTzwux0=
X-Google-Smtp-Source: AK7set9YGzcuNatrSwhGf54AWthgBOslDCEbODCL7EQXYiF40b4xcRx0iaJoZ5cBCUHhHLsjK3HdAA==
X-Received: by 2002:a17:906:5352:b0:8b1:814e:c83d with SMTP id j18-20020a170906535200b008b1814ec83dmr6341330ejo.6.1678571498898;
        Sat, 11 Mar 2023 13:51:38 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709062da200b008cf377e8795sm1497633eji.199.2023.03.11.13.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 13:51:38 -0800 (PST)
Date:   Sat, 11 Mar 2023 22:51:36 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] staging: rtl8192e: Remove unused variable
 rfLSSI_Select and rfTxGainStage
Message-ID: <48f05998f4d2fe2df88ff14860cc8615dd72734d.1678569965.git.philipp.g.hortmann@gmail.com>
References: <cover.1678569965.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678569965.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable rfLSSI_Select and rfTxGainStage because they are
just once set and not used. Remove unused constants as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h    |  2 --
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c    | 10 ----------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h |  2 --
 3 files changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index adedcea5824e..2236c1aaf335 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -106,8 +106,6 @@ struct bb_reg_definition {
 	u32 rfintfo;
 	u32 rfintfe;
 	u32 rf3wireOffset;
-	u32 rfLSSI_Select;
-	u32 rfTxGainStage;
 	u32 rfHSSIPara1;
 	u32 rfHSSIPara2;
 	u32 rfSwitchControl;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 1013ab95bc7b..87f28718e732 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -368,16 +368,6 @@ static void _rtl92e_init_bb_rf_reg_def(struct net_device *dev)
 	priv->phy_reg_def[RF90_PATH_A].rf3wireOffset = rFPGA0_XA_LSSIParameter;
 	priv->phy_reg_def[RF90_PATH_B].rf3wireOffset = rFPGA0_XB_LSSIParameter;
 
-	priv->phy_reg_def[RF90_PATH_A].rfLSSI_Select = rFPGA0_XAB_RFParameter;
-	priv->phy_reg_def[RF90_PATH_B].rfLSSI_Select = rFPGA0_XAB_RFParameter;
-	priv->phy_reg_def[RF90_PATH_C].rfLSSI_Select = rFPGA0_XCD_RFParameter;
-	priv->phy_reg_def[RF90_PATH_D].rfLSSI_Select = rFPGA0_XCD_RFParameter;
-
-	priv->phy_reg_def[RF90_PATH_A].rfTxGainStage = rFPGA0_TxGainStage;
-	priv->phy_reg_def[RF90_PATH_B].rfTxGainStage = rFPGA0_TxGainStage;
-	priv->phy_reg_def[RF90_PATH_C].rfTxGainStage = rFPGA0_TxGainStage;
-	priv->phy_reg_def[RF90_PATH_D].rfTxGainStage = rFPGA0_TxGainStage;
-
 	priv->phy_reg_def[RF90_PATH_A].rfHSSIPara1 = rFPGA0_XA_HSSIParameter1;
 	priv->phy_reg_def[RF90_PATH_B].rfHSSIPara1 = rFPGA0_XB_HSSIParameter1;
 	priv->phy_reg_def[RF90_PATH_C].rfHSSIPara1 = rFPGA0_XC_HSSIParameter1;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
index 19acc44648e1..b68e84dd003f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
@@ -65,8 +65,6 @@
 #define rFPGA0_XA_RFInterfaceOE		0x860
 #define rFPGA0_XB_RFInterfaceOE		0x864
 #define rFPGA0_XAB_RFInterfaceSW	0x870
-#define rFPGA0_XAB_RFParameter		0x878
-#define rFPGA0_XCD_RFParameter		0x87c
 #define rFPGA0_AnalogParameter1		0x880
 #define rFPGA0_AnalogParameter2		0x884
 #define rFPGA0_AnalogParameter3		0x888
-- 
2.39.2

