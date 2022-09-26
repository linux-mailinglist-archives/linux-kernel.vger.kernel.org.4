Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1055EAEC4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIZR4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiIZRzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:55:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B51DBF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:32:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u24so10015984edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=chQdQ1OJInZBPZSx9Da9erBbPScxyL3Yh0RTnHzjDog=;
        b=mMrt+yWZg8MJ0vlVlYf0aeWrXVRCmn5VOZUqe2P7roWiwSemQVuLkGga1ckz5ph/k5
         fIOk4idieZuCZpUBOkQe4e9Z6IrVsPclropIR/d7lQieSQDf9bumfkLqzvNuB8srbC+x
         /1vylDmA170vwMv7A1j7eUxmXAGZdkSccjdB7TbHaRaDrsTL9D32pNKkvH2BTHjPeHwc
         kir1ZKNL9SF1RThJu+Ye2fCi3HWgvmox27cgSGj1WtXHByA0EI6I2skBq7YSor1AZEo4
         6Vpcq8EVbw0oK1mA7yH/gJevDjNySby/UHosVROTDbHKJJziW6GgCTA+B770CEidYuWF
         SnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=chQdQ1OJInZBPZSx9Da9erBbPScxyL3Yh0RTnHzjDog=;
        b=zpx8rPR4CGaSTpbc//3PZHBif/o0EL6rjY2V15jcOuYiTG1ECqklCcSM3X3WMJU+D8
         B/FLuGXl6VnYlAf1JKDCEoyogapnwtSLiihnMj3DAqWj+GhxjsgTeIueqC4Wlip4oaCx
         PB/tz+dEfMGOuybfV8ckeW3sg0c/cMKj+CeiswwzPqWoSmo3WL2pGF6LOcmecjezb4I4
         /BJElke6zkLmCUMRPRQyvmFIipvQA/XUoKclu2MvWNke1lszuHWYpLndhAFGJq32a64t
         3xHtt9PsCSr6hYSeOEGizM3aFgtd/IyJbzlLoBWqKiDjmtErKAsnHLIlVIIuTXt4udT1
         3plg==
X-Gm-Message-State: ACrzQf01FeOeaGe4crwlJJpgMuOpbJ+i4ft5xfEUMazljk2hnKFwDF1/
        93tcdTcd3QqC21W3FwoTwT0=
X-Google-Smtp-Source: AMsMyM7LRZevVNJGFSlpW39DHMVH4Gvjb+2uC0freI1aEdDjrQW2ti09AlZb14Mp6upd/1aPNkSAeQ==
X-Received: by 2002:aa7:cd8e:0:b0:452:2682:a955 with SMTP id x14-20020aa7cd8e000000b004522682a955mr23796156edv.379.1664213570721;
        Mon, 26 Sep 2022 10:32:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id y4-20020a1709060a8400b00782667df018sm6554617ejf.54.2022.09.26.10.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 10:32:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: make odm_ConfigRF_RadioA_8188E() static
Date:   Mon, 26 Sep 2022 19:32:42 +0200
Message-Id: <20220926173243.8767-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926173243.8767-1-straube.linux@gmail.com>
References: <20220926173243.8767-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function odm_ConfigRF_RadioA_8188E() is only used in
HalHWImg8188E_RF.c. Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    | 30 +++++++++++++++++++
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  | 30 -------------------
 .../r8188eu/include/odm_RegConfig8188E.h      |  3 --
 3 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index 08cbfce3808d..ea123817e3d5 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -130,6 +130,36 @@ static u32 Array_RadioA_1T_8188E[] = {
 		0x000, 0x00033E60,
 };
 
+static void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
+				  u32 Data, u32 RegAddr)
+{
+	if (Addr == 0xffe) {
+		msleep(50);
+	} else if (Addr == 0xfd) {
+		mdelay(5);
+	} else if (Addr == 0xfc) {
+		mdelay(1);
+	} else if (Addr == 0xfb) {
+		udelay(50);
+	} else if (Addr == 0xfa) {
+		udelay(5);
+	} else if (Addr == 0xf9) {
+		udelay(1);
+	} else {
+		rtl8188e_PHY_SetRFReg(pDM_Odm->Adapter, RegAddr, bRFRegOffsetMask, Data);
+		/*  Add 1us delay between BB/RF register setting. */
+		udelay(1);
+	}
+}
+
+static void odm_ConfigRF_RadioA_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data)
+{
+	u32  content = 0x1000; /*  RF_Content: radioa_txt */
+	u32 maskforPhySet = (u32)(content & 0xE000);
+
+	odm_ConfigRFReg_8188E(pDM_Odm, Addr, Data, Addr | maskforPhySet);
+}
+
 enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 {
 	#define READ_NEXT_PAIR(v1, v2, i) do	\
diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index e6e10a3c8d54..963697574e9e 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -3,36 +3,6 @@
 
 #include "../include/drv_types.h"
 
-static void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
-				  u32 Data, u32 RegAddr)
-{
-	if (Addr == 0xffe) {
-		msleep(50);
-	} else if (Addr == 0xfd) {
-		mdelay(5);
-	} else if (Addr == 0xfc) {
-		mdelay(1);
-	} else if (Addr == 0xfb) {
-		udelay(50);
-	} else if (Addr == 0xfa) {
-		udelay(5);
-	} else if (Addr == 0xf9) {
-		udelay(1);
-	} else {
-		rtl8188e_PHY_SetRFReg(pDM_Odm->Adapter, RegAddr, bRFRegOffsetMask, Data);
-		/*  Add 1us delay between BB/RF register setting. */
-		udelay(1);
-	}
-}
-
-void odm_ConfigRF_RadioA_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data)
-{
-	u32  content = 0x1000; /*  RF_Content: radioa_txt */
-	u32 maskforPhySet = (u32)(content & 0xE000);
-
-	odm_ConfigRFReg_8188E(pDM_Odm, Addr, Data, Addr | maskforPhySet);
-}
-
 void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask, u32 Data)
 {
 	rtl8188e_PHY_SetBBReg(pDM_Odm->Adapter, Addr, Bitmask, Data);
diff --git a/drivers/staging/r8188eu/include/odm_RegConfig8188E.h b/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
index 9cecbf9532f5..ce8af50d13bb 100644
--- a/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
+++ b/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
@@ -4,9 +4,6 @@
 #ifndef __INC_ODM_REGCONFIG_H_8188E
 #define __INC_ODM_REGCONFIG_H_8188E
 
-void odm_ConfigRF_RadioA_8188E(struct odm_dm_struct *pDM_Odm,
-			       u32 Addr, u32 Data);
-
 void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 			    u32 Bitmask, u32 Data);
 
-- 
2.37.3

