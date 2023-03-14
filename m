Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E884F6B9EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjCNSow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjCNSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:44:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE7C6484E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:44:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x3so65921866edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678819456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1uYehhFxzaCa8Hl58SvBTbiOvy8bevbMRIqLTRcQvkQ=;
        b=N/LmTvq7X+nRe2JHw29SHzuBzeOBVva84SwRCBlM1v1VB+ubXcfM/EobdmY2E+Ftju
         7lYP7NXN+Im4llj/isNQkUuCQulsbm/puPMAhmGP6SyCbRqoPrceJ1HbPkg2gxxxxqkI
         ieY/8dRminCQYwN1wYjOGTr2kXDmPM4FpyHL/V7/dwwNECFYXTQvd7V0DfrK11AyuQmz
         z8WIhkYQtRF0BvHuXQQ2j6QYyKknP08vvv/gDChyQiBzFrJqWchzV73Hj6d6flIbd2J+
         Nyo/gZAM8Z42oJuyeDaZYQZt4R0uWqAJ6e3cTIi5KgkeKoTjB7A+tXSwwxcWhrnnHuGx
         MEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uYehhFxzaCa8Hl58SvBTbiOvy8bevbMRIqLTRcQvkQ=;
        b=mig4H7atUVx8FbBEe+z9ySyzO25Biat3d1bFTL1q4buS53PODVLPfHf3J4juAMPQou
         ESbe68HnAvwbAib7hXEfrgnOUwc4G3TUbwFkaePQwoUwcaDp2mEB0rnmgyqXGJji4PM6
         l+HcgMz0aVOAq4fxoVSctdae89fFBNXpZi3TqXtd30cIt73JPpN2VjFqlA5Xjjp+rTcI
         ABKYATwWiguyPkv46lsFea5/BbRBNnyI8CpOfpuN5hbPcuNwoi0wDzdaPg2gDEwwL13a
         pz5u53O9F5DA/7fN7fXcG0XRhhGhweyNNbhUwv3nwR/vukAAJ2xVlcPoIahMjI/CjS04
         t4Rw==
X-Gm-Message-State: AO0yUKWsGjdRaZcbcIcWVxwhTB/d70qvMrFWu9dwfXfJKfmBslbBKnkm
        bD2isKIIlDVX9iK/30gumlc=
X-Google-Smtp-Source: AK7set9EJI7caBb11E17/HYnwlTHxtENxZhzCtH7X5thnn/UTA5z8fozcdQHGCfGPBWxZZhYc+LKSw==
X-Received: by 2002:a05:6402:280b:b0:4bc:235c:dcb8 with SMTP id h11-20020a056402280b00b004bc235cdcb8mr16454919ede.1.1678819456076;
        Tue, 14 Mar 2023 11:44:16 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id r9-20020a50c009000000b004c13fe8fabfsm1416835edb.84.2023.03.14.11.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:44:15 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:44:13 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] staging: rtl8192e: Join constants Rtl819XAGCTAB_..
 with ..PciEAGCTAB..
Message-ID: <c7ca930adb5f72daa61b15b02001d09c4a1f8f46.1678814935.git.philipp.g.hortmann@gmail.com>
References: <cover.1678814935.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678814935.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Join constants Rtl819XAGCTAB_Array with Rtl8192PciEAGCTAB_Array to
RTL8192E_AGCTAB_ARR to improve readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/table.c      | 2 +-
 drivers/staging/rtl8192e/rtl8192e/table.h      | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 5b9a1b78c35e..72ecdb9ea375 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -313,7 +313,7 @@ static void _rtl92e_phy_config_bb(struct net_device *dev, u8 ConfigType)
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	AGCTAB_ArrayLen = RTL8192E_AGCTAB_ARR_LEN;
-	Rtl819XAGCTAB_Array_Table = Rtl819XAGCTAB_Array;
+	Rtl819XAGCTAB_Array_Table = RTL8192E_AGCTAB_ARR;
 	if (priv->rf_type == RF_1T2R) {
 		PHY_REGArrayLen = RTL8192E_PHY_REG_1T2R_ARR_LEN;
 		Rtl819XPHY_REGArray_Table = Rtl819XPHY_REG_1T2RArray;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index ee91d687de9b..1f9bafd6d3cc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,7 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-#define Rtl819XAGCTAB_Array			Rtl8192PciEAGCTAB_Array
 #define Rtl819XPHY_REG_1T2RArray		Rtl8192PciEPHY_REG_1T2RArray
 
 extern u32 rtl819XAGCTAB_Array[];
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.c b/drivers/staging/rtl8192e/rtl8192e/table.c
index eeea01681e7d..3a7656facefc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.c
+++ b/drivers/staging/rtl8192e/rtl8192e/table.c
@@ -347,7 +347,7 @@ u32 RTL8192E_MACPHY_ARR_PG[] = {
 	0x318, 0x00000fff, 0x00000800,
 };
 
-u32 Rtl8192PciEAGCTAB_Array[RTL8192E_AGCTAB_ARR_LEN] = {
+u32 RTL8192E_AGCTAB_ARR[RTL8192E_AGCTAB_ARR_LEN] = {
 	0xc78, 0x7d000001,
 	0xc78, 0x7d010001,
 	0xc78, 0x7d020001,
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index 3023440db58b..576228882c21 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -22,6 +22,6 @@ extern u32 RTL8192E_MACPHY_ARR[RTL8192E_MACPHY_ARR_LEN];
 #define RTL8192E_MACPHY_ARR_PG_LEN 30
 extern u32 RTL8192E_MACPHY_ARR_PG[RTL8192E_MACPHY_ARR_PG_LEN];
 #define RTL8192E_AGCTAB_ARR_LEN 384
-extern u32 Rtl8192PciEAGCTAB_Array[RTL8192E_AGCTAB_ARR_LEN];
+extern u32 RTL8192E_AGCTAB_ARR[RTL8192E_AGCTAB_ARR_LEN];
 
 #endif
-- 
2.39.2

