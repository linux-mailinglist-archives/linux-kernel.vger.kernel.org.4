Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0DF6B613B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjCKVw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCKVw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:52:27 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606AD5F6FA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:51:57 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r15so7266980edq.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678571511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3lz0rCujQhVibf0Ri4YpJvVDSlapNGCLqwJwhuUj9iY=;
        b=g1XROsxLntlHnDJmSTz0qt7nem4Tid9+eF8wErcrgZHZhL1eIYgs9nYN/R8tlQbXPj
         v8Kx2VhvaP7UK2z3UI8ahK/Lgj62VHFBDaSpIZrwidgWgGxn2fPOCmhjna9aK82KBrHZ
         YJoFx7d/mvdbbIfpcd1B6dN8oO6mQvLzqzFzR/TA3rnWP3+6A2yTonlUNfGrDBcIeA34
         5XFKybm6Ys16llD/wpa/Le9dpfNgbUbIET9gdOZ6M2ppL/8VHXA4W/mwLNxr0UKkdCFQ
         hEIML6UWRMCblTRLFXYP2UwlCV2QzDEWq0bCzmFTQoBUkBecP8TlkoLTeIqYNPS5MgG3
         VDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lz0rCujQhVibf0Ri4YpJvVDSlapNGCLqwJwhuUj9iY=;
        b=QAuEh4yH4BbIbV60YzSK/xwwYln+KfA6anP1Ha9up7T/Q1P2uwolcFIeqbkPmfEjhF
         emUoU6Hmk9eJo8gXWAcG/qq/hTktCfnqDv+JMa2G558EuAfmTnqA9HYPf+7k9JZdyed4
         4yEC0sZAGOqXCkvoomECXpUMfZh3a6td6qavOo/CrZvYuSZWaDOVUMQ0P9WVFyvozi2c
         dCzpBxq6LUpZmEsqcWzRzJM+4KDa4zQ5obdpXpiH4NgHZqKjgvo9+pHRENqSodL9DvYM
         s93YpyNgQ2lBFn+zUnunLslPg3/IqpBvwNANbSywwCiyc2VPr0i7Fv+YJksETR36kO3k
         AM0g==
X-Gm-Message-State: AO0yUKWGnSvUaGatsN4f1MSWHfzTRKoOJ183osMaFInH3Ll441nkbpDo
        r9VCFFJoLdJWuwpgFN2Vt7S+DZN4EWE=
X-Google-Smtp-Source: AK7set9AZWxbuta0wo1kYU6KhCXTkFmoJ1saYc/52/4fbe7kyUJgiPxYbrNgI/MDuhWs4ZbIZFuY0A==
X-Received: by 2002:a17:906:d4:b0:878:5fa4:7443 with SMTP id 20-20020a17090600d400b008785fa47443mr5804894eji.3.1678571511297;
        Sat, 11 Mar 2023 13:51:51 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id q21-20020a170906389500b008b907006d5dsm1522934ejd.173.2023.03.11.13.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 13:51:50 -0800 (PST)
Date:   Sat, 11 Mar 2023 22:51:49 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] staging: rtl8192e: Remove unused variable rfHSSIPara1
 and rfSwitchControl
Message-ID: <5f13420ce5598d447aaad0fe43b807467e0a15bb.1678569965.git.philipp.g.hortmann@gmail.com>
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

Remove unused variable rfHSSIPara1 and rfSwitchControl because they are
just once set and not used. Remove unused constants as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h    |  2 --
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c    | 10 ----------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h |  6 ------
 3 files changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index 2236c1aaf335..d42eac4b6012 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -106,9 +106,7 @@ struct bb_reg_definition {
 	u32 rfintfo;
 	u32 rfintfe;
 	u32 rf3wireOffset;
-	u32 rfHSSIPara1;
 	u32 rfHSSIPara2;
-	u32 rfSwitchControl;
 	u32 rfAGCControl1;
 	u32 rfAGCControl2;
 	u32 rfRxIQImbalance;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 87f28718e732..add3de156e09 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -368,21 +368,11 @@ static void _rtl92e_init_bb_rf_reg_def(struct net_device *dev)
 	priv->phy_reg_def[RF90_PATH_A].rf3wireOffset = rFPGA0_XA_LSSIParameter;
 	priv->phy_reg_def[RF90_PATH_B].rf3wireOffset = rFPGA0_XB_LSSIParameter;
 
-	priv->phy_reg_def[RF90_PATH_A].rfHSSIPara1 = rFPGA0_XA_HSSIParameter1;
-	priv->phy_reg_def[RF90_PATH_B].rfHSSIPara1 = rFPGA0_XB_HSSIParameter1;
-	priv->phy_reg_def[RF90_PATH_C].rfHSSIPara1 = rFPGA0_XC_HSSIParameter1;
-	priv->phy_reg_def[RF90_PATH_D].rfHSSIPara1 = rFPGA0_XD_HSSIParameter1;
-
 	priv->phy_reg_def[RF90_PATH_A].rfHSSIPara2 = rFPGA0_XA_HSSIParameter2;
 	priv->phy_reg_def[RF90_PATH_B].rfHSSIPara2 = rFPGA0_XB_HSSIParameter2;
 	priv->phy_reg_def[RF90_PATH_C].rfHSSIPara2 = rFPGA0_XC_HSSIParameter2;
 	priv->phy_reg_def[RF90_PATH_D].rfHSSIPara2 = rFPGA0_XD_HSSIParameter2;
 
-	priv->phy_reg_def[RF90_PATH_A].rfSwitchControl = rFPGA0_XAB_SwitchControl;
-	priv->phy_reg_def[RF90_PATH_B].rfSwitchControl = rFPGA0_XAB_SwitchControl;
-	priv->phy_reg_def[RF90_PATH_C].rfSwitchControl = rFPGA0_XCD_SwitchControl;
-	priv->phy_reg_def[RF90_PATH_D].rfSwitchControl = rFPGA0_XCD_SwitchControl;
-
 	priv->phy_reg_def[RF90_PATH_A].rfAGCControl1 = rOFDM0_XAAGCCore1;
 	priv->phy_reg_def[RF90_PATH_B].rfAGCControl1 = rOFDM0_XBAGCCore1;
 	priv->phy_reg_def[RF90_PATH_C].rfAGCControl1 = rOFDM0_XCAGCCore1;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
index b68e84dd003f..5062be507a30 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
@@ -48,20 +48,14 @@
 #define rFPGA0_TxGainStage		0x80c
 #define rFPGA0_RFTiming1		0x810
 #define rFPGA0_RFTiming2		0x814
-#define rFPGA0_XA_HSSIParameter1	0x820
 #define rFPGA0_XA_HSSIParameter2	0x824
-#define rFPGA0_XB_HSSIParameter1	0x828
 #define rFPGA0_XB_HSSIParameter2	0x82c
-#define rFPGA0_XC_HSSIParameter1	0x830
 #define rFPGA0_XC_HSSIParameter2	0x834
-#define rFPGA0_XD_HSSIParameter1	0x838
 #define rFPGA0_XD_HSSIParameter2	0x83c
 #define rFPGA0_XA_LSSIParameter		0x840
 #define rFPGA0_XB_LSSIParameter		0x844
 #define rFPGA0_RFWakeUpParameter	0x850
 #define rFPGA0_RFSleepUpParameter	0x854
-#define rFPGA0_XAB_SwitchControl	0x858
-#define rFPGA0_XCD_SwitchControl	0x85c
 #define rFPGA0_XA_RFInterfaceOE		0x860
 #define rFPGA0_XB_RFInterfaceOE		0x864
 #define rFPGA0_XAB_RFInterfaceSW	0x870
-- 
2.39.2

