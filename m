Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE076B6135
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCKVvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCKVvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:51:10 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0908C35269
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:50:48 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id k10so34350013edk.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678571446; x=1681163446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4UP85sr6iGf1vN76NAlj4OusJ0swvD759QkXT0aobgs=;
        b=V8Z5burVcUIEaPrUPaRikqCuZx+x7xilXlHj7OidoaJvXR2Xjz3j1QuhP8Ldmqw39W
         H2e4kDOQV6PN9w13Y6yuqFky8OjwaATjudE7ruXroJGAtm9i1zoa3m0fHxp1/uw3V7LB
         M69H8tkdSEE23kXEZXV6l3kjtWmLrDrX/jpiVuRzhHucAaqlZfrD29xFSC/9Q49e/gUi
         NAf8+p5ReVHhNDT431Z1zQa0uRFGuKXgd/0Kx1lcExDNcTZ1IHwzABiZxBKXm40tiX6Z
         wSHNL1zQH0DUBZ0/L/Fpjzmwdv1URQUsg99SJd4Xru+MugIqF8C1FJVNo/VEv4uX/QId
         zRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571446; x=1681163446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UP85sr6iGf1vN76NAlj4OusJ0swvD759QkXT0aobgs=;
        b=eY4VxjvF3WL83S/3IdtgWIpQCa2+S2dOr/fbCM3r/gAbEpHeMTZldjmLWNizy/UHmL
         0rZxHPq6SuDuNX4nzL88YpbSARHUbvrazLoT2ozwIFiXppk92KyGDi1GE31T+pdeV8Df
         zTMij84GUqUReavpMFMsyV+Zrq3l7qd9poaDlMQmSk9v2GyWFWau3RoxZaXGRluwnMC8
         hfXZ1L3AE4VUtCuwJ46RYmSsxLJJVzd1ilcqdwsfyxdiFeC/9oTv2ZVWbRCH25fCmhdT
         jb/eOX1eMHN9miInD8KWum4ykGBhYDY93JG1uqM51SfjzRLwX9sYR4b8eaBbvoaK6Q01
         URWA==
X-Gm-Message-State: AO0yUKVabvGT0WkgLc6mI9UULKFr1gEv81QQZWM3t1CK/5ksVSsRGg8h
        AWibPqRPZDyQabwhkLcTxgc=
X-Google-Smtp-Source: AK7set/8S93Qxfz/hN4PvWI9qs6pVgh6/hZYFS+VchJfNFAwsvSJkPceNaueYpxxOjDIlPb8A66ocw==
X-Received: by 2002:a17:906:19c:b0:8d3:be84:1cc6 with SMTP id 28-20020a170906019c00b008d3be841cc6mr9839752ejb.3.1678571446404;
        Sat, 11 Mar 2023 13:50:46 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709063e5000b0092435626c0asm413523eji.29.2023.03.11.13.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 13:50:46 -0800 (PST)
Date:   Sat, 11 Mar 2023 22:50:44 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] staging: rtl8192e: Remove unused RF90_PATH_C and ..D
 for rfintfs
Message-ID: <801d10f460acbf0601c78dee05c7b32f1628f3a8.1678569965.git.philipp.g.hortmann@gmail.com>
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

Remove unused priv->phy_reg_def[RF90_PATH_C].rfintfs and
priv->phy_reg_def[RF90_PATH_D].rfintfs.
The termination condition for the loop is set to
priv->num_total_rf_path = RTL819X_TOTAL_RF_PATH = 2.
Because of this pPhyReg = &priv->phy_reg_def[eRFPath]; pPhyReg cannot
point to array element 2 for RF90_PATH_C and 3 for RF90_PATH_D.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c    | 2 --
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index a9e83ba811b0..94b23cb53c36 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -358,8 +358,6 @@ static void _rtl92e_init_bb_rf_reg_def(struct net_device *dev)
 
 	priv->phy_reg_def[RF90_PATH_A].rfintfs = rFPGA0_XAB_RFInterfaceSW;
 	priv->phy_reg_def[RF90_PATH_B].rfintfs = rFPGA0_XAB_RFInterfaceSW;
-	priv->phy_reg_def[RF90_PATH_C].rfintfs = rFPGA0_XCD_RFInterfaceSW;
-	priv->phy_reg_def[RF90_PATH_D].rfintfs = rFPGA0_XCD_RFInterfaceSW;
 
 	priv->phy_reg_def[RF90_PATH_A].rfintfi = rFPGA0_XAB_RFInterfaceRB;
 	priv->phy_reg_def[RF90_PATH_B].rfintfi = rFPGA0_XAB_RFInterfaceRB;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
index f846f109ed98..616a4b62d4b9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
@@ -69,7 +69,6 @@
 #define rFPGA0_XC_RFInterfaceOE		0x868
 #define rFPGA0_XD_RFInterfaceOE		0x86c
 #define rFPGA0_XAB_RFInterfaceSW	0x870
-#define rFPGA0_XCD_RFInterfaceSW	0x874
 #define rFPGA0_XAB_RFParameter		0x878
 #define rFPGA0_XCD_RFParameter		0x87c
 #define rFPGA0_AnalogParameter1		0x880
-- 
2.39.2

