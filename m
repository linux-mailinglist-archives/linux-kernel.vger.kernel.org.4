Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9787E6B6144
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjCKVx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjCKVxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:53:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCFC664FB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:52:52 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ek18so3331119edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678571568; x=1681163568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RyEajtXCKm6Ql9H6gCOuQjRwjcr6+UWMUOeAMqv/92A=;
        b=SIy/GjaY1a77lyDckpFkDXDtsTsXvwKdxAdSL9w6MIK9ZcJf6Ze/rYWKK5bodNCpP7
         SDZFUNs1ntMFhPV/M6bPLvmtlRXKwIvDM5lUD3MzAcHVtyO/5x6VO2swwSnFFqAVQpWw
         bLp4KIJgGx1Ux5h21LAsAcibn0W4Tu5cr13khx77MBtn6llKqIbbQCddAMb0ia1qpbLg
         vq607BohABsjQqLto09qYTXiZVGyyV3WLBian0jcJdKa3Tyel26naQ90pDhM+C29mPfW
         VZKCK3+l5wC3uqJ2CnU1o5UGzJYrDeSOpM6SONsqrzEl2pXMY73d347so8hDD/k5Y174
         vsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571568; x=1681163568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyEajtXCKm6Ql9H6gCOuQjRwjcr6+UWMUOeAMqv/92A=;
        b=Ca40xBthN4pSHi7FFwLzfAhjNbfkCXQyBnoIquh0nDDYvQcZqRTcu64kPXSpIjlSI7
         cD2QWRHMEDXoj9DeePPc2bWMCvAo8sel7ihbyDnLklxeA/7Opl6VAawQy+anwp8/ORdJ
         Y9SpC1AjOrDnhNij58o+xNZDOQs68td6mZQQI42Y31shu89aNFddJJPr40/Dfigk3KVo
         We3Sxkoq33POc7dfAxFfNG0WTlMfwhr8zK48Y8NpN84zn/pTI4SB/s9K3ve3zZq1AcWe
         W/UWEKR8MA15pJC4ryxWZKYNbDJ3X2Mz2BlTJCCURaRTu8dLVu/5bfjPzQSZaUgYH8HD
         /mkg==
X-Gm-Message-State: AO0yUKU6SdSB3Da6uFrkHjMMzKNNwhM84U0W/ukiPJuUzuRCn10eJyWF
        tVmIbmZZGAgiHfd30XKdjdpeLI6GuuU=
X-Google-Smtp-Source: AK7set+DeLK3epRnJ1IoskS86bjOn3azl461Sqqzs9fpCLoU1bIAAK68n+2VIcBXGiPam7J2rGdEZA==
X-Received: by 2002:a17:906:19c:b0:8d3:be84:1cc6 with SMTP id 28-20020a170906019c00b008d3be841cc6mr9843663ejb.3.1678571568225;
        Sat, 11 Mar 2023 13:52:48 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id lc22-20020a170906dff600b00922b009fc79sm746203ejc.164.2023.03.11.13.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 13:52:47 -0800 (PST)
Date:   Sat, 11 Mar 2023 22:52:46 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] staging: rtl8192e: Remove unused RF90_PATH_C and ..D
 for rfLSSIReadBack
Message-ID: <622777b394a896b6db08eb7faeb455e5cbeae93f.1678569965.git.philipp.g.hortmann@gmail.com>
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

Remove unused priv->phy_reg_def[RF90_PATH_C].rfLSSIReadBack and
priv->phy_reg_def[RF90_PATH_D].rfLSSIReadBack.
rfLSSIReadBack is used in:
_rtl92e_phy_rf_read which is used in:
rtl92e_set_rf_reg and rtl92e_get_rf_reg are used in:
rtl92e_set_bandwidth (eRFPath only for 0 and 1)
rtl92e_config_rf (eRFPath only for 0 and 1)
_rtl92e_phy_switch_channel_step (eRFPath only for 0 and 1)
_rtl92e_dm_check_tx_power_tracking_thermal (eRFPath only for 0)
rtl92e_check_bb_and_rf is used in:
rtl92e_config_rf (eRFPath only for 0 and 1)
_rtl92e_bb_config_para_file (eRFPath only for 0)
rtl92e_config_rf_path is used in:
rtl92e_config_rf (eRFPath only for 0 and 1)
Remove dead code and constants.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c    | 3 ---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index fe12df93bc60..b26ea8dfd871 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -375,9 +375,6 @@ static void _rtl92e_init_bb_rf_reg_def(struct net_device *dev)
 
 	priv->phy_reg_def[RF90_PATH_A].rfLSSIReadBack = rFPGA0_XA_LSSIReadBack;
 	priv->phy_reg_def[RF90_PATH_B].rfLSSIReadBack = rFPGA0_XB_LSSIReadBack;
-	priv->phy_reg_def[RF90_PATH_C].rfLSSIReadBack = rFPGA0_XC_LSSIReadBack;
-	priv->phy_reg_def[RF90_PATH_D].rfLSSIReadBack = rFPGA0_XD_LSSIReadBack;
-
 }
 
 bool rtl92e_check_bb_and_rf(struct net_device *dev, enum hw90_block CheckBlock,
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
index fe05a94561e8..28f9af71f193 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
@@ -65,8 +65,6 @@
 #define rFPGA0_AnalogParameter4		0x88c
 #define rFPGA0_XA_LSSIReadBack		0x8a0
 #define rFPGA0_XB_LSSIReadBack		0x8a4
-#define rFPGA0_XC_LSSIReadBack		0x8a8
-#define rFPGA0_XD_LSSIReadBack		0x8ac
 #define rFPGA0_PSDReport		0x8b4
 
 /* Page 9 - RF mode & OFDM TxSC */
-- 
2.39.2

