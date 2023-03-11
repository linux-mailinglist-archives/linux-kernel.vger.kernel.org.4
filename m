Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30A46B6143
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCKVxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCKVwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:52:55 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AFF74A4C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:52:36 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id fd5so571214edb.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678571554; x=1681163554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CLM1DMdObV7hO1p/r6vG5OZBTBXPbt7jRsRiNLFKp3Q=;
        b=T3xGwj5RM/C7sIBdSZr6qko+CotZEUqpuXLdHlUU30M5k1DtpX2ScKCKB43OVJShpM
         hVUV3zXE9JenvAJeLuudpAPpVUzxHHemqjhwy3yU9ASaL/6YibrYcwVhspxPqNnVxDrd
         URhtMCxfvzchF60wLwYiHgope0zVDZIVMEDS3wt6w1FGEKoOQG42u+KOcsc/gtGKmc6G
         +Eezl5BobgE/+whQPiZTzPcmiN+mQAOn4a3t1jaPgHZhsQJh9jdxG41rrwWHd0LXMV1a
         xXt7wHA1H91Jxj5SDEFBYOpwqNQ3yZyI4ZQYafgaqWPGITgQxzjO7kj5uSYF8ho5Zg1H
         9BQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571554; x=1681163554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLM1DMdObV7hO1p/r6vG5OZBTBXPbt7jRsRiNLFKp3Q=;
        b=Sa0IUlSihUva2kMAlFpOdNz/zPNXQ+MJbqsS78wHLHoxH21m5VGoHG/1OfcWIp68ZF
         DmjEcAgQuCvdZvQdogjUArSuHhRMpd8iw/+QlcrSjRBWwC8rAjlZaQ0TzFJ5F6vS3X/a
         LCAF7ekJv3F37X1uvm4pJKEB+50389nPDOJ1vaAEhbF1KGmIlU8cGLZOK/ppwCPckY+D
         ESlRDtB5XAhBOM1GUu1/cpabhTK8ioBmt4jxnKo3G1oz35erUfjeeTm8vkW+2Rv1k07w
         qpfdpqLVUUva6R+m61L7kXWKpjql3MMZ/e3bgGPGeSk70Ik99HQSl0WmeWl0GXU1M8t7
         4IQg==
X-Gm-Message-State: AO0yUKVqS6iFXhiK2VY4sRdYdCE8qCmxebSolPh2oXO8TS7DJO+j/0Il
        1QAOjlzAq2K5exFXZHS9LxM=
X-Google-Smtp-Source: AK7set/qZf77ad1RUfZHDcBWbLvREMofsCiPAcIhbCVLCTbsOdpZzxchCSPIe7Q1lCsWiE0V/a9Ldw==
X-Received: by 2002:a05:6402:42cf:b0:4af:7bdc:1888 with SMTP id i15-20020a05640242cf00b004af7bdc1888mr12085566edc.4.1678571554119;
        Sat, 11 Mar 2023 13:52:34 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id ks14-20020a170906f84e00b008ec43ae626csm1504972ejb.167.2023.03.11.13.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 13:52:33 -0800 (PST)
Date:   Sat, 11 Mar 2023 22:52:31 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] staging: rtl8192e: Remove unused variable
 rfTxIQImbalance and rfTxAFE
Message-ID: <62453061bcf1858c23ba57bf1f279999b37b4cc3.1678569965.git.philipp.g.hortmann@gmail.com>
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

Remove unused variable rfTxIQImbalance and rfTxAFE because they are just
once set and not used. Remove unused constants.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h    |  2 --
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c    | 10 ----------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h |  5 -----
 3 files changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index a5c2ff5b4260..385cca79f484 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -107,8 +107,6 @@ struct bb_reg_definition {
 	u32 rfintfe;
 	u32 rf3wireOffset;
 	u32 rfHSSIPara2;
-	u32 rfTxIQImbalance;
-	u32 rfTxAFE;
 	u32 rfLSSIReadBack;
 	u32 rfLSSIReadBackPi;
 };
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 5b63b9eac090..fe12df93bc60 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -373,16 +373,6 @@ static void _rtl92e_init_bb_rf_reg_def(struct net_device *dev)
 	priv->phy_reg_def[RF90_PATH_C].rfHSSIPara2 = rFPGA0_XC_HSSIParameter2;
 	priv->phy_reg_def[RF90_PATH_D].rfHSSIPara2 = rFPGA0_XD_HSSIParameter2;
 
-	priv->phy_reg_def[RF90_PATH_A].rfTxIQImbalance = rOFDM0_XATxIQImbalance;
-	priv->phy_reg_def[RF90_PATH_B].rfTxIQImbalance = rOFDM0_XBTxIQImbalance;
-	priv->phy_reg_def[RF90_PATH_C].rfTxIQImbalance = rOFDM0_XCTxIQImbalance;
-	priv->phy_reg_def[RF90_PATH_D].rfTxIQImbalance = rOFDM0_XDTxIQImbalance;
-
-	priv->phy_reg_def[RF90_PATH_A].rfTxAFE = rOFDM0_XATxAFE;
-	priv->phy_reg_def[RF90_PATH_B].rfTxAFE = rOFDM0_XBTxAFE;
-	priv->phy_reg_def[RF90_PATH_C].rfTxAFE = rOFDM0_XCTxAFE;
-	priv->phy_reg_def[RF90_PATH_D].rfTxAFE = rOFDM0_XDTxAFE;
-
 	priv->phy_reg_def[RF90_PATH_A].rfLSSIReadBack = rFPGA0_XA_LSSIReadBack;
 	priv->phy_reg_def[RF90_PATH_B].rfLSSIReadBack = rFPGA0_XB_LSSIReadBack;
 	priv->phy_reg_def[RF90_PATH_C].rfLSSIReadBack = rFPGA0_XC_LSSIReadBack;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
index 78e90bf5d79f..fe05a94561e8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
@@ -117,12 +117,7 @@
 #define rOFDM0_HTSTFAGC			0xc7c
 #define rOFDM0_XATxIQImbalance		0xc80
 #define rOFDM0_XATxAFE			0xc84
-#define rOFDM0_XBTxIQImbalance		0xc88
-#define rOFDM0_XBTxAFE			0xc8c
 #define rOFDM0_XCTxIQImbalance		0xc90
-#define rOFDM0_XCTxAFE			0xc94
-#define rOFDM0_XDTxIQImbalance		0xc98
-#define rOFDM0_XDTxAFE			0xc9c
 #define rOFDM0_RxHPParameter		0xce0
 #define rOFDM0_TxPseudoNoiseWgt		0xce4
 #define rOFDM0_FrameSync		0xcf0
-- 
2.39.2

