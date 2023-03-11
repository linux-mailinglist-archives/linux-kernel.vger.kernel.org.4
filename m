Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0406B6136
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCKVvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCKVvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:51:13 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8504580CD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:50:59 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r15so7262451edq.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678571458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZRztXr+yi1+VTQciICFP+x1t1LeLTBQI5V0a9mBDUU=;
        b=jrsv3JVCjkddk3WtVccMKFPD0rBNEkDOReh9EgvbeGHtlx4u4dBVST9TGLsYnSrik1
         fCGRem74PcYWnMSFww/ZBYYkad9whVFjreKmBsKE3WvetcmhfYkkJOMHC3eBVkd3O2/e
         C/QWu25lRH9Llr0/i8kkw9F1f74a5VveDwjZItIUksclQQNdeUhV4b/wfOZUb6Y6tIgT
         Ii+SL6IDbR2NS2TuxJmjZsfVhQpFn+UMrBk50894jQRsuplBSocTwjAVWcGTFTBTveVI
         eHmMGOI9H4LGUV2PxLU2yMFpWhCKCmAJfN8rrOvZ4rKMFZtoZdM8r8i4shwg9Z9k4E86
         YTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZRztXr+yi1+VTQciICFP+x1t1LeLTBQI5V0a9mBDUU=;
        b=o7z6BmKkyzvjGDbIdGjWC0mq006g25eV3/CRy52sRgt7GYhSbH1jPsUxO5GyD7SiDo
         yMu+094jBZJ05F6pfdR7D0nHoxjT9mv71bcwBJ5UlJOLE1a2UDmU5NSZGZTFkllG1MID
         pyNZzNJRDGBFnK5QMTzYR4KmI2c6c40Jn4SXMlraPuwSjR8tKZrhrNSQ0ig4n1O0vvby
         hMs7jV8e83nR8lV7AcizpARg0d9v/A44vrLNaaUI9Sy/FW6CYigmf+IS5FwP6b+x93GU
         deXDfi2wcU2OFEp3ujBwm5mR3epleIPuo25LnKojRdRBGxNlqf6sXdsiAlRXFzdjBKAY
         /8oQ==
X-Gm-Message-State: AO0yUKV3XjgSXk4buigm14FlV9UAjMmUtRh6gra43RqC7nc+MvLxwRgq
        HlPh+8TH4azPGC2Q1ZSucg0=
X-Google-Smtp-Source: AK7set+ZhZVUGQysFESJVoq6vJY3frd1ZVHwPO/IGJVBnFykg9eG0tx3wxoLTR87kSNaAYx3KLH9Pw==
X-Received: by 2002:a17:906:d4:b0:878:5fa4:7443 with SMTP id 20-20020a17090600d400b008785fa47443mr5803546eji.3.1678571458319;
        Sat, 11 Mar 2023 13:50:58 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id nb17-20020a1709071c9100b00925867d821fsm125242ejc.120.2023.03.11.13.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 13:50:57 -0800 (PST)
Date:   Sat, 11 Mar 2023 22:50:56 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] staging: rtl8192e: Remove unused variable rfintfi
Message-ID: <f251186fe59855eee3dd465954700a1d0ec50f53.1678569965.git.philipp.g.hortmann@gmail.com>
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

Remove unused variable rfintfi because it is just once set and not used.
Remove unused constants as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h    | 1 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c    | 5 -----
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h | 2 --
 3 files changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index ac192254a4bb..adedcea5824e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -103,7 +103,6 @@ enum rf_optype {
 
 struct bb_reg_definition {
 	u32 rfintfs;
-	u32 rfintfi;
 	u32 rfintfo;
 	u32 rfintfe;
 	u32 rf3wireOffset;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 94b23cb53c36..19fdf56e5e91 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -359,11 +359,6 @@ static void _rtl92e_init_bb_rf_reg_def(struct net_device *dev)
 	priv->phy_reg_def[RF90_PATH_A].rfintfs = rFPGA0_XAB_RFInterfaceSW;
 	priv->phy_reg_def[RF90_PATH_B].rfintfs = rFPGA0_XAB_RFInterfaceSW;
 
-	priv->phy_reg_def[RF90_PATH_A].rfintfi = rFPGA0_XAB_RFInterfaceRB;
-	priv->phy_reg_def[RF90_PATH_B].rfintfi = rFPGA0_XAB_RFInterfaceRB;
-	priv->phy_reg_def[RF90_PATH_C].rfintfi = rFPGA0_XCD_RFInterfaceRB;
-	priv->phy_reg_def[RF90_PATH_D].rfintfi = rFPGA0_XCD_RFInterfaceRB;
-
 	priv->phy_reg_def[RF90_PATH_A].rfintfo = rFPGA0_XA_RFInterfaceOE;
 	priv->phy_reg_def[RF90_PATH_B].rfintfo = rFPGA0_XB_RFInterfaceOE;
 	priv->phy_reg_def[RF90_PATH_C].rfintfo = rFPGA0_XC_RFInterfaceOE;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
index 616a4b62d4b9..5a47b232945f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
@@ -80,8 +80,6 @@
 #define rFPGA0_XC_LSSIReadBack		0x8a8
 #define rFPGA0_XD_LSSIReadBack		0x8ac
 #define rFPGA0_PSDReport		0x8b4
-#define rFPGA0_XAB_RFInterfaceRB	0x8e0
-#define rFPGA0_XCD_RFInterfaceRB	0x8e4
 
 /* Page 9 - RF mode & OFDM TxSC */
 #define rFPGA1_RFMOD			0x900
-- 
2.39.2

