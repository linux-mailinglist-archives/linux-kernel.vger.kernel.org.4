Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3979C61D94E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 11:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiKEKBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 06:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKEKBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 06:01:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C826A1A81A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 03:00:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j12so6999227plj.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 03:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JToYLUSSy/i5m9Py7IH/T54uqRiJj7SvKEgsJsBwYtc=;
        b=YgwCtTuZYJ//lmjh+GHpYXIMqFSoQBNpDazWKHjIbdxv+yjFzv4LYnSYD5XzEMuE5Z
         7StXWVhGbbNgbASn+odYhDRCP8sh+YBMDSEtecU9794/EGNp+PMatucq2fqpVY2l1tYQ
         97u10QeplCBvqrHSUngVSwUSrUgW2PoNZwSwT+9ETfki+ZS4CV1RPYvUP+R5qkb86pB2
         ZhAEh3Kl3o3ekdml9cHjP5ZYkbyd1D7jE9V09NWL5fpae7n/LUl4lq9mujCMf++9wQOD
         MQnitSMwn486VycY2O+XVUcAqPoaSvheFfw7HnDAYQA2hqFcjPYECafdIK09O0fMgkqh
         6Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JToYLUSSy/i5m9Py7IH/T54uqRiJj7SvKEgsJsBwYtc=;
        b=aWKWj4iYvy2KI1+NMdPE/K+h/8RpmfYYQ/qXJBvR0RpLblIaTNz18wnNmK+vYldXS2
         BCO3g6XzOxz83p6CLFYM/98bRpdWuVkTD2lYod46XyKy7Bpphh8/bKe52ZFGhfqt8/dC
         U3x2mkmKLUjDrUERPjrT/RK+x8QGdKDPLX2GtLWwoHDyHr+olxv1yt1BumfXKcf3yH39
         nLYcPy3u6RBTLanKE9g8eth2OdPpXXuPNYqKGNmBxcgT97CYpc6MVR58IJWDH5AILqAG
         iDMvAne9R1aVVaIOcVFzSMueE+IIvX/2vEjYFiOZDPedd0UC4gSy/ZrCxoNAMo07IzHX
         kzqA==
X-Gm-Message-State: ACrzQf1XiNxzrUnIKSp/bwow/rLevgoTDGS/Rn0gvgmckomnjmoUG/PC
        0OkC280LJhkh17WuLdU2TXU=
X-Google-Smtp-Source: AMsMyM4e+mUO4sg6qtsu0zY4bqfOq2cBTeUC3O4Z1WHF+1Z5QBZUgeEwREL/vbd/JeeqREXuicnfWA==
X-Received: by 2002:a17:902:d54a:b0:186:e852:6775 with SMTP id z10-20020a170902d54a00b00186e8526775mr39989783plf.44.1667642445183;
        Sat, 05 Nov 2022 03:00:45 -0700 (PDT)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id h37-20020a635765000000b00412a708f38asm979171pgm.35.2022.11.05.03.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 03:00:44 -0700 (PDT)
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Jacob Bai <jacob.bai.au@gmail.com>
Subject: [PATCH 3/3] staging: rtl8192e: remove unnecesscary macro define
Date:   Sat,  5 Nov 2022 21:00:30 +1100
Message-Id: <f71f1bd4e20f41fbe99944240437d8fca35e8d0c.1667641211.git.jacob.bai.au@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667641211.git.jacob.bai.au@gmail.com>
References: <cover.1667641211.git.jacob.bai.au@gmail.com>
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

remove useless macro defines

Signed-off-by: Jacob Bai <jacob.bai.au@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 52 +++++++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    | 20 -------
 2 files changed, 26 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index eabb4187d907..aad1842857c0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -307,12 +307,12 @@ void rtl92e_config_mac(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	if (priv->bTXPowerDataReadFromEEPORM) {
-		dwArrayLen = MACPHY_Array_PGLength;
-		pdwArray = Rtl819XMACPHY_Array_PG;
+		dwArrayLen = RTL8192E_MAC_ARRAY_PG_LEN;
+		pdwArray = RTL8192E_MAC_ARRAY_PG;
 
 	} else {
-		dwArrayLen = MACPHY_ArrayLength;
-		pdwArray = Rtl819XMACPHY_Array;
+		dwArrayLen = RTL8192E_MAC_ARRAY_LEN;
+		pdwArray = RTL8192E_MAC_ARRAY;
 	}
 	for (i = 0; i < dwArrayLen; i += 3) {
 		if (pdwArray[i] == 0x318)
@@ -332,14 +332,14 @@ static void _rtl92e_phy_config_bb(struct net_device *dev, u8 ConfigType)
 	u16 AGCTAB_ArrayLen, PHY_REGArrayLen = 0;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	AGCTAB_ArrayLen = AGCTAB_ArrayLength;
-	Rtl819XAGCTAB_Array_Table = Rtl819XAGCTAB_Array;
+	AGCTAB_ArrayLen = RTL8192E_AGC_TAB_ARRAY_LEN;
+	Rtl819XAGCTAB_Array_Table = RTL8192E_AGC_TAB_ARRAY;
 	if (priv->rf_type == RF_2T4R) {
-		PHY_REGArrayLen = PHY_REGArrayLength;
-		Rtl819XPHY_REGArray_Table = Rtl819XPHY_REGArray;
+		PHY_REGArrayLen = RTL8192E_PHY_REG_ARRAY_LEN;
+		Rtl819XPHY_REGArray_Table = RTL8192E_PHY_REG_ARRAY;
 	} else if (priv->rf_type == RF_1T2R) {
-		PHY_REGArrayLen = PHY_REG_1T2RArrayLength;
-		Rtl819XPHY_REGArray_Table = Rtl819XPHY_REG_1T2RArray;
+		PHY_REGArrayLen = RTL8192E_PHY_REG_1T2R_ARRAY_LEN;
+		Rtl819XPHY_REGArray_Table = RTL8192E_PHY_REG_1T2R_ARRAY;
 	}
 
 	if (ConfigType == BaseBand_Config_PHY_REG) {
@@ -668,50 +668,50 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
 
 	switch (eRFPath) {
 	case RF90_PATH_A:
-		for (i = 0; i < RadioA_ArrayLength; i += 2) {
-			if (Rtl819XRadioA_Array[i] == 0xfe) {
+		for (i = 0; i < RTL8192E_RADIOA_ARRAY_LEN; i += 2) {
+			if (RTL8192E_RADIOA_ARRAY[i] == 0xfe) {
 				msleep(100);
 				continue;
 			}
-			rtl92e_set_rf_reg(dev, eRFPath, Rtl819XRadioA_Array[i],
+			rtl92e_set_rf_reg(dev, eRFPath, RTL8192E_RADIOA_ARRAY[i],
 					  bMask12Bits,
-					  Rtl819XRadioA_Array[i+1]);
+					  RTL8192E_RADIOA_ARRAY[i+1]);
 
 		}
 		break;
 	case RF90_PATH_B:
-		for (i = 0; i < RadioB_ArrayLength; i += 2) {
-			if (Rtl819XRadioB_Array[i] == 0xfe) {
+		for (i = 0; i < RTL8192E_RADIOB_ARRAY_LEN; i += 2) {
+			if (RTL8192E_RADIOB_ARRAY[i] == 0xfe) {
 				msleep(100);
 				continue;
 			}
-			rtl92e_set_rf_reg(dev, eRFPath, Rtl819XRadioB_Array[i],
+			rtl92e_set_rf_reg(dev, eRFPath, RTL8192E_RADIOB_ARRAY[i],
 					  bMask12Bits,
-					  Rtl819XRadioB_Array[i+1]);
+					  RTL8192E_RADIOB_ARRAY[i+1]);
 
 		}
 		break;
 	case RF90_PATH_C:
-		for (i = 0; i < RadioC_ArrayLength; i += 2) {
-			if (Rtl819XRadioC_Array[i] == 0xfe) {
+		for (i = 0; i < RTL8192E_RADIOC_ARRAY_LEN; i += 2) {
+			if (RTL8192E_RADIOC_ARRAY[i] == 0xfe) {
 				msleep(100);
 				continue;
 			}
-			rtl92e_set_rf_reg(dev, eRFPath, Rtl819XRadioC_Array[i],
+			rtl92e_set_rf_reg(dev, eRFPath, RTL8192E_RADIOC_ARRAY[i],
 					  bMask12Bits,
-					  Rtl819XRadioC_Array[i+1]);
+					  RTL8192E_RADIOC_ARRAY[i+1]);
 
 		}
 		break;
 	case RF90_PATH_D:
-		for (i = 0; i < RadioD_ArrayLength; i += 2) {
-			if (Rtl819XRadioD_Array[i] == 0xfe) {
+		for (i = 0; i < RTL8192E_RADIOD_ARRAY_LEN; i += 2) {
+			if (RTL8192E_RADIOD_ARRAY[i] == 0xfe) {
 				msleep(100);
 				continue;
 			}
-			rtl92e_set_rf_reg(dev, eRFPath, Rtl819XRadioD_Array[i],
+			rtl92e_set_rf_reg(dev, eRFPath, RTL8192E_RADIOD_ARRAY[i],
 					  bMask12Bits,
-					  Rtl819XRadioD_Array[i+1]);
+					  RTL8192E_RADIOD_ARRAY[i+1]);
 
 		}
 		break;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index e1c1f19b71a3..5e6527e835db 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,26 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-#define AGCTAB_ArrayLength			RTL8192E_AGC_TAB_ARRAY_LEN
-#define MACPHY_ArrayLength			RTL8192E_MAC_ARRAY_LEN
-#define RadioA_ArrayLength			RTL8192E_RADIOA_ARRAY_LEN
-#define RadioB_ArrayLength			RTL8192E_RADIOB_ARRAY_LEN
-#define MACPHY_Array_PGLength			RTL8192E_MAC_ARRAY_PG_LEN
-#define RadioC_ArrayLength			RTL8192E_RADIOC_ARRAY_LEN
-#define RadioD_ArrayLength			RTL8192E_RADIOD_ARRAY_LEN
-#define PHY_REGArrayLength			RTL8192E_PHY_REG_ARRAY_LEN
-#define PHY_REG_1T2RArrayLength			RTL8192E_PHY_REG_1T2R_ARRAY_LEN
-
-#define Rtl819XMACPHY_Array_PG			RTL8192E_MAC_ARRAY_PG
-#define Rtl819XMACPHY_Array			RTL8192E_MAC_ARRAY
-#define Rtl819XRadioA_Array			RTL8192E_RADIOA_ARRAY
-#define Rtl819XRadioB_Array			RTL8192E_RADIOB_ARRAY
-#define Rtl819XRadioC_Array			RTL8192E_RADIOC_ARRAY
-#define Rtl819XRadioD_Array			RTL8192E_RADIOD_ARRAY
-#define Rtl819XAGCTAB_Array			RTL8192E_AGC_TAB_ARRAY
-#define Rtl819XPHY_REGArray			RTL8192E_PHY_REG_ARRAY
-#define Rtl819XPHY_REG_1T2RArray		RTL8192E_PHY_REG_1T2R_ARRAY
-
 extern u32 rtl819XAGCTAB_Array[];
 
 enum hw90_block {
-- 
2.34.1

