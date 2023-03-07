Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E918A6AF71F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjCGVBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjCGVBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:01:45 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5B4AD015
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:01:31 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a25so57926043edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 13:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678222888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gIXSorTFAYKTNJM7z/IL0aUuWF162xbbFTav7RI/Z10=;
        b=MnyFJBJSxZ8i3I01ug1cTYZ7Q4PhmKGhRxGU9s3UK+ReZD7m2YF025j+KpvuUsjf1/
         fibjuaTB41CjNezj/Xy3Ax2I3P187iOGXvmjZZaf8SWhyM8fQhIgv3Fm5VD+wU6o6rPn
         wEHb7ZxIciyVG9dBEU86jqTRLBKVcoOgAoRQoHIOyGmy2ckGHVhfGgKAeMzzHIjZqlpk
         Tmp/dGMdYr2NnapNtzdXv0xMxLcuBR5kD7QO/nUSMBFvtEdNFQScKusOxgjJG5BtANhW
         58XuGwZDW4mW2WVHCy4v7RpQi5nO57cKoQfkuXiWeu7alz4Y5MuaqIPTyXkWDhMjhiZD
         7g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIXSorTFAYKTNJM7z/IL0aUuWF162xbbFTav7RI/Z10=;
        b=AmuXRyzL8ixzuu/JESPSYlbJst3LkcPlNC8anUsOIV6iFfPyZnwrhYX2zPF+4Gy6tP
         dl1i57ld3s9ufojm0mD7uHFcooJOPG6uC2H4bZb6O9RpPZko4g/G97jdhKOQM5YuR87u
         shPqPz+6Jht1EqmxK/KjnJs4cL8nGZSQolLPRMZOl6vGAsJsyOexuVEjvc1RqDgAX+Ug
         OH+G0h99VSMrEHMpg3A6b7+HB1dNWsa8sBwfpYDMrkeDI+Lf16mNR8xiJQr9sYmKgd2q
         Uf2ldrRr6DKxVsGkfawf7SBfVz9wH5iaRGsgUYorATP42is+mQkIgwSsfcx56kS3kfKE
         +AZg==
X-Gm-Message-State: AO0yUKUgKt0hL/ldYsXGkkhdSUmt6u9abP9D9yhISvhCIbCzidz1sSIE
        941/Q7Sj3dAkTENvvwWQdoA=
X-Google-Smtp-Source: AK7set9bArSFzIR/CoqbFlchV95RX/tZbI3+aIiIzmVZT1ty/0Xb9IYjdzG0haC/tQ+0hxzVZsjwPA==
X-Received: by 2002:a17:906:5199:b0:8ae:ea08:3842 with SMTP id y25-20020a170906519900b008aeea083842mr14275038ejk.7.1678222887993;
        Tue, 07 Mar 2023 13:01:27 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id r17-20020a50aad1000000b004bfa4f747d2sm7269585edc.54.2023.03.07.13.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 13:01:27 -0800 (PST)
Date:   Tue, 7 Mar 2023 22:01:25 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] staging: rtl8192e: Remove unused Array
 Rtl8192PciERadioD_Array
Message-ID: <608ced17b85ca321fdc0026c686e3c62a9d6d8cd.1678222487.git.philipp.g.hortmann@gmail.com>
References: <cover.1678222487.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678222487.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The array Rtl8192PciERadioD_Array is only used in function
rtl92e_config_rf_path which is only called in function rtl92e_config_rf.
In function rtl92e_config_rf a termination condition for the loop is set
to priv->num_total_rf_path = RTL819X_TOTAL_RF_PATH = 2. The loop is only
executed with numbers 0 and 1 for eRFPath. So the function
rtl92e_config_rf_path is only called with eRFPath for 0 and 1 and never
with 3 that would make the "case RF90_PATH_D:" be called. Remove
resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: Changed argumentation in the description and subject
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 12 ------------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h |  2 --
 drivers/staging/rtl8192e/rtl8192e/table.c      |  3 ---
 drivers/staging/rtl8192e/rtl8192e/table.h      |  2 --
 4 files changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index fe0ef52c163a..a9e83ba811b0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -649,18 +649,6 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
 					  bMask12Bits,
 					  Rtl819XRadioB_Array[i+1]);
 
-		}
-		break;
-	case RF90_PATH_D:
-		for (i = 0; i < RadioD_ArrayLength; i += 2) {
-			if (Rtl819XRadioD_Array[i] == 0xfe) {
-				msleep(100);
-				continue;
-			}
-			rtl92e_set_rf_reg(dev, eRFPath, Rtl819XRadioD_Array[i],
-					  bMask12Bits,
-					  Rtl819XRadioD_Array[i+1]);
-
 		}
 		break;
 	default:
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index 6772ed300591..ac640033e843 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -14,14 +14,12 @@
 #define RadioA_ArrayLength			RadioA_ArrayLengthPciE
 #define RadioB_ArrayLength			RadioB_ArrayLengthPciE
 #define MACPHY_Array_PGLength			MACPHY_Array_PGLengthPciE
-#define RadioD_ArrayLength			RadioD_ArrayLengthPciE
 #define PHY_REG_1T2RArrayLength			PHY_REG_1T2RArrayLengthPciE
 
 #define Rtl819XMACPHY_Array_PG			Rtl8192PciEMACPHY_Array_PG
 #define Rtl819XMACPHY_Array			Rtl8192PciEMACPHY_Array
 #define Rtl819XRadioA_Array			Rtl8192PciERadioA_Array
 #define Rtl819XRadioB_Array			Rtl8192PciERadioB_Array
-#define Rtl819XRadioD_Array			Rtl8192PciERadioD_Array
 #define Rtl819XAGCTAB_Array			Rtl8192PciEAGCTAB_Array
 #define Rtl819XPHY_REG_1T2RArray		Rtl8192PciEPHY_REG_1T2RArray
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.c b/drivers/staging/rtl8192e/rtl8192e/table.c
index 4e97ad4b8fd7..7101061e3519 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.c
+++ b/drivers/staging/rtl8192e/rtl8192e/table.c
@@ -325,9 +325,6 @@ u32 Rtl8192PciERadioB_Array[RadioB_ArrayLengthPciE] = {
 	0x007, 0x00000700,
 };
 
-u32 Rtl8192PciERadioD_Array[RadioD_ArrayLengthPciE] = {
-	0x0, };
-
 u32 Rtl8192PciEMACPHY_Array[] = {
 	0x03c, 0xffff0000, 0x00000f0f,
 	0x340, 0xffffffff, 0x161a1a1a,
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index 981e8b57d3de..b6d4e9696452 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -17,8 +17,6 @@ extern u32 Rtl8192PciEPHY_REG_1T2RArray[PHY_REG_1T2RArrayLengthPciE];
 extern u32 Rtl8192PciERadioA_Array[RadioA_ArrayLengthPciE];
 #define RadioB_ArrayLengthPciE 78
 extern u32 Rtl8192PciERadioB_Array[RadioB_ArrayLengthPciE];
-#define RadioD_ArrayLengthPciE 2
-extern u32 Rtl8192PciERadioD_Array[RadioD_ArrayLengthPciE];
 #define MACPHY_ArrayLengthPciE 18
 extern u32 Rtl8192PciEMACPHY_Array[MACPHY_ArrayLengthPciE];
 #define MACPHY_Array_PGLengthPciE 30
-- 
2.39.2

