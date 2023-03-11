Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AF56B613D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCKVwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCKVwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:52:40 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F048D6C6BD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:52:18 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r15so7269287edq.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678571537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TdvdZcJwqOxSED82BHJ454QJEkvE45rumYb+PdMANhk=;
        b=KbQE9gQ4W/aLSm2gJ9USlzEK9E5MDzHVSJHAzEOumHqjyaHmrM59p+IYOJgO7jdKSm
         qwQ0OUWtQCq3/rXRCkuAeu6ui3MnC5M9DjyoEU+Kp30A6XtKcoZvKMeWmkE1wXdCs6Os
         t7GPCYMc9kG+/WxxB2zZ8Ruvc3gIKQTCQaSWHAcT3pmiy0OQJhCzlQtAYjrXgVIQukDq
         SeO2uy1SnpMT0BfpQr8xFWfHl265T10CNW5NF7eOF/bKBKV/JwF/Z3roY5XKGSleAf0o
         Eus6x+poIQCGeCNzd1AVlJuBcWIVappwUB3CoWYw+nUl//NtlkmGXTQzmebaTuPkGIAD
         NKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdvdZcJwqOxSED82BHJ454QJEkvE45rumYb+PdMANhk=;
        b=0orTdd5jwXYaR6KUdbNd3BcxNuRP2aBBtAGX8So2UUnMl0lOvlma6G5pEAAcjsvU0l
         1vScfQtkK4882RvfK38EG5GKVSfczpLpoTRVBnkjTHytk+oLx8sbdPh/Sk8H3DIAyrox
         Nc0q15eZQvq+6eYrPEWuYY9FbEdFH6r8UifIGYmfDFDiZW4Pwvn0rI0a7nbyYuB1n1xa
         4p9JG3aasx35pFQb1EW9C9h5zjsiKbYM4GQHvl05QJFFEgqQsws/R8X2kxGDt4zsHAFe
         JUC0mnRe3yySMlpRrIVBviX/xjhYVJ8VnEd6xSf2xJD2QIULC/nekXCp8yK5K0AjzSE3
         UCfQ==
X-Gm-Message-State: AO0yUKW0nrjqQ3kRJLwKzNWAD5kA4MRFYil0nrdMl6y5AXoa+fL2SrBx
        +qNTgo/O10pmFIVVPlh3F/Q=
X-Google-Smtp-Source: AK7set/9/649wHsySz4J19RJ3v5gomkREh8afFzkaSUa9/qY3LFUVpM1jnwTCAC10MlTMWFU1ohPSA==
X-Received: by 2002:a17:906:7493:b0:878:4bda:2011 with SMTP id e19-20020a170906749300b008784bda2011mr6174866ejl.4.1678571537333;
        Sat, 11 Mar 2023 13:52:17 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id bg4-20020a170906a04400b008b1797b77b2sm1503688ejb.221.2023.03.11.13.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 13:52:16 -0800 (PST)
Date:   Sat, 11 Mar 2023 22:52:15 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] staging: rtl8192e: Remove unused variable
 rfRxIQImbalance and rfRxAFE
Message-ID: <1d578fc962c938e76bc0df529a3c24bba7abe049.1678569965.git.philipp.g.hortmann@gmail.com>
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

Remove unused variable rfRxIQImbalance and rfRxAFE because they are just
once set and not used. Remove unused constants with commenting line.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h    |  2 --
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c    | 10 ----------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h |  9 ---------
 3 files changed, 21 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index a5d99891688d..a5c2ff5b4260 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -107,8 +107,6 @@ struct bb_reg_definition {
 	u32 rfintfe;
 	u32 rf3wireOffset;
 	u32 rfHSSIPara2;
-	u32 rfRxIQImbalance;
-	u32 rfRxAFE;
 	u32 rfTxIQImbalance;
 	u32 rfTxAFE;
 	u32 rfLSSIReadBack;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 32806bcc953a..5b63b9eac090 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -373,16 +373,6 @@ static void _rtl92e_init_bb_rf_reg_def(struct net_device *dev)
 	priv->phy_reg_def[RF90_PATH_C].rfHSSIPara2 = rFPGA0_XC_HSSIParameter2;
 	priv->phy_reg_def[RF90_PATH_D].rfHSSIPara2 = rFPGA0_XD_HSSIParameter2;
 
-	priv->phy_reg_def[RF90_PATH_A].rfRxIQImbalance = rOFDM0_XARxIQImbalance;
-	priv->phy_reg_def[RF90_PATH_B].rfRxIQImbalance = rOFDM0_XBRxIQImbalance;
-	priv->phy_reg_def[RF90_PATH_C].rfRxIQImbalance = rOFDM0_XCRxIQImbalance;
-	priv->phy_reg_def[RF90_PATH_D].rfRxIQImbalance = rOFDM0_XDRxIQImbalance;
-
-	priv->phy_reg_def[RF90_PATH_A].rfRxAFE = rOFDM0_XARxAFE;
-	priv->phy_reg_def[RF90_PATH_B].rfRxAFE = rOFDM0_XBRxAFE;
-	priv->phy_reg_def[RF90_PATH_C].rfRxAFE = rOFDM0_XCRxAFE;
-	priv->phy_reg_def[RF90_PATH_D].rfRxAFE = rOFDM0_XDRxAFE;
-
 	priv->phy_reg_def[RF90_PATH_A].rfTxIQImbalance = rOFDM0_XATxIQImbalance;
 	priv->phy_reg_def[RF90_PATH_B].rfTxIQImbalance = rOFDM0_XBTxIQImbalance;
 	priv->phy_reg_def[RF90_PATH_C].rfTxIQImbalance = rOFDM0_XCTxIQImbalance;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
index d0ea7e06f0f7..78e90bf5d79f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
@@ -98,15 +98,6 @@
 #define rOFDM0_TRxPathEnable		0xc04
 #define rOFDM0_TRMuxPar			0xc08
 #define rOFDM0_TRSWIsolation		0xc0c
-/* RxIQ DC offset, Rx digital filter, DC notch filter */
-#define rOFDM0_XARxAFE			0xc10
-#define rOFDM0_XARxIQImbalance		0xc14 /* RxIQ imbalance matrix */
-#define rOFDM0_XBRxAFE			0xc18
-#define rOFDM0_XBRxIQImbalance		0xc1c
-#define rOFDM0_XCRxAFE			0xc20
-#define rOFDM0_XCRxIQImbalance		0xc24
-#define rOFDM0_XDRxAFE			0xc28
-#define rOFDM0_XDRxIQImbalance		0xc2c
 #define rOFDM0_RxDetector1		0xc30 /* PD, BW & SBD */
 #define rOFDM0_RxDetector2		0xc34 /* SBD */
 #define rOFDM0_RxDetector3		0xc38 /* Frame Sync */
-- 
2.39.2

