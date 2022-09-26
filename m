Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBD75EAEC6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiIZR4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiIZRzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:55:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE39061D44
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:32:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id z13so15654514ejp.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xi2G+BsPgSScnEoa84XoZM1sbuZ3s1TxWbx1fy5OnFQ=;
        b=dB9ShWeAoemK8HvsNrZeb0wa+SP+dM2SqTIjA1wcBvy2YebMogV0sfju5Fdw1/NqwR
         ov4mqnS5uJcJugeRKiCITxHiBzVmmWNcfTp2elc3aR/J/iuzTcefzBDTdsGlhaCX/Nk5
         9COMZLPtGjHXlfTdFgOI/c8O43In1fTC+1l8wOnSuWcZwDl7pg1jcL3bkl32vEjyICKq
         GIhC1RzUcdGiUk/USdXP6RF5kyh+fCyGJTf1iE/Uv58KFVD92HA0w8/SN6+9y0e7Og1C
         jcZTSZe5G1c/5cBPemgoMoRFEIk5GM5DqtbPfgIW/zlygkH+LiAY+YzmdC3Fb8olYBzO
         gUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xi2G+BsPgSScnEoa84XoZM1sbuZ3s1TxWbx1fy5OnFQ=;
        b=zdaU6wO1A9FzTQsAcl9Td16xCf8K2lJRAfzSxOcC6SGMQEAsKJjDoQwodbJ58+z8zx
         UM/wuD0PPKatcxLjjVBWsVad0kqyKYNy54S9ATa9dqIj7mxl1jOT2UlL9E6j2v/4NgnP
         VBpRIW9eVbLnqDGptjPrvbfQl+zGuEM59fzfpQc5ELTNQjsJ9VMtuoMh0jI0cuTizfTb
         vfrS4tUQfcxoeK8xVpLohnm64PRtmcUvnmDJH9NvmeIubhTLImT+Xjezd6UStcjptmxJ
         SkN1voNnhpmHUhjd9/9S7KTLL1m7DoH/Y9d2M2ZpfZAnalSyRO/SlaYKlMbNJskAp52W
         q9fQ==
X-Gm-Message-State: ACrzQf1mU/NqUGoKfDMH/xEvNsRwpTT4AUqlNuqXC3SrG2gU2SEBAl4a
        X8FqwNhfvNCPAp8XaeSgdUA=
X-Google-Smtp-Source: AMsMyM5xgm78mRRMZIhRXfbbuWI2UfC8uHaO4bxogWFeRF8kouBkDSMfIrMwz4EFp0GZkub8DSS5tQ==
X-Received: by 2002:a17:907:a049:b0:77c:1f27:1b28 with SMTP id gz9-20020a170907a04900b0077c1f271b28mr20641845ejc.20.1664213571368;
        Mon, 26 Sep 2022 10:32:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id y4-20020a1709060a8400b00782667df018sm6554617ejf.54.2022.09.26.10.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 10:32:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: remove hal/odm_RegConfig8188E.c
Date:   Mon, 26 Sep 2022 19:32:43 +0200
Message-Id: <20220926173243.8767-4-straube.linux@gmail.com>
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

All remaining functions in hal/odm_RegConfig8188E.c are only used
in hal/HalHWImg8188E_BB.c. Make them static and remove the now empty
file hal/odm_RegConfig8188E.c and the header odm_RegConfig8188E.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/Makefile              |  1 -
 .../staging/r8188eu/hal/HalHWImg8188E_BB.c    | 50 +++++++++++++++++
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  | 54 -------------------
 .../r8188eu/include/odm_RegConfig8188E.h      | 16 ------
 .../staging/r8188eu/include/rtl8188e_hal.h    |  1 -
 5 files changed, 50 insertions(+), 72 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
 delete mode 100644 drivers/staging/r8188eu/include/odm_RegConfig8188E.h

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index f5091a3ed4d2..fd494c2299e6 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -10,7 +10,6 @@ r8188eu-y = \
 		hal/hal_com.o \
 		hal/odm.o \
 		hal/odm_HWConfig.o \
-		hal/odm_RegConfig8188E.o \
 		hal/odm_RTL8188E.o \
 		hal/rtl8188e_cmd.o \
 		hal/rtl8188e_dm.o \
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index 7901d0afa2e7..a4eb2879b77e 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -166,6 +166,13 @@ static u32 array_agc_tab_1t_8188e[] = {
 		0xC78, 0x407F0001,
 };
 
+static void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask, u32 Data)
+{
+	rtl8188e_PHY_SetBBReg(pDM_Odm->Adapter, Addr, Bitmask, Data);
+	/*  Add 1us delay between BB/RF register setting. */
+	udelay(1);
+}
+
 enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32     hex         = 0;
@@ -442,6 +449,30 @@ static u32 array_phy_reg_1t_8188e[] = {
 		0xF00, 0x00000300,
 };
 
+static void odm_ConfigBB_PHY_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask, u32 Data)
+{
+	if (Addr == 0xfe) {
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
+		if (Addr == 0xa24)
+			pDM_Odm->RFCalibrateInfo.RegA24 = Data;
+		rtl8188e_PHY_SetBBReg(pDM_Odm->Adapter, Addr, Bitmask, Data);
+
+		/*  Add 1us delay between BB/RF register setting. */
+		udelay(1);
+	}
+}
+
 enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32     hex         = 0;
@@ -647,6 +678,25 @@ static u32 array_phy_reg_pg_8188e[] = {
 
 };
 
+static void odm_ConfigBB_PHY_REG_PG_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask,
+					  u32 Data)
+{
+	if (Addr == 0xfe)
+		msleep(50);
+	else if (Addr == 0xfd)
+		mdelay(5);
+	else if (Addr == 0xfc)
+		mdelay(1);
+	else if (Addr == 0xfb)
+		udelay(50);
+	else if (Addr == 0xfa)
+		udelay(5);
+	else if (Addr == 0xf9)
+		udelay(1);
+	else
+		storePwrIndexDiffRateOffset(pDM_Odm->Adapter, Addr, Bitmask, Data);
+}
+
 void ODM_ReadAndConfig_PHY_REG_PG_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32  hex;
diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
deleted file mode 100644
index 963697574e9e..000000000000
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ /dev/null
@@ -1,54 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#include "../include/drv_types.h"
-
-void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask, u32 Data)
-{
-	rtl8188e_PHY_SetBBReg(pDM_Odm->Adapter, Addr, Bitmask, Data);
-	/*  Add 1us delay between BB/RF register setting. */
-	udelay(1);
-}
-
-void odm_ConfigBB_PHY_REG_PG_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
-				   u32 Bitmask, u32 Data)
-{
-	if (Addr == 0xfe)
-		msleep(50);
-	else if (Addr == 0xfd)
-		mdelay(5);
-	else if (Addr == 0xfc)
-		mdelay(1);
-	else if (Addr == 0xfb)
-		udelay(50);
-	else if (Addr == 0xfa)
-		udelay(5);
-	else if (Addr == 0xf9)
-		udelay(1);
-	else
-		storePwrIndexDiffRateOffset(pDM_Odm->Adapter, Addr, Bitmask, Data);
-}
-
-void odm_ConfigBB_PHY_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask, u32 Data)
-{
-	if (Addr == 0xfe) {
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
-		if (Addr == 0xa24)
-			pDM_Odm->RFCalibrateInfo.RegA24 = Data;
-		rtl8188e_PHY_SetBBReg(pDM_Odm->Adapter, Addr, Bitmask, Data);
-
-		/*  Add 1us delay between BB/RF register setting. */
-		udelay(1);
-	}
-}
diff --git a/drivers/staging/r8188eu/include/odm_RegConfig8188E.h b/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
deleted file mode 100644
index ce8af50d13bb..000000000000
--- a/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef __INC_ODM_REGCONFIG_H_8188E
-#define __INC_ODM_REGCONFIG_H_8188E
-
-void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
-			    u32 Bitmask, u32 Data);
-
-void odm_ConfigBB_PHY_REG_PG_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
-				   u32 Bitmask, u32 Data);
-
-void odm_ConfigBB_PHY_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
-			    u32 Bitmask, u32 Data);
-
-#endif
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 64cdc2fad20e..ed4091e7cc7e 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -23,7 +23,6 @@
 #include "HalHWImg8188E_MAC.h"
 #include "HalHWImg8188E_RF.h"
 #include "HalHWImg8188E_BB.h"
-#include "odm_RegConfig8188E.h"
 #include "odm_RTL8188E.h"
 
 #define DRVINFO_SZ	4 /*  unit is 8bytes */
-- 
2.37.3

