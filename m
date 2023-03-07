Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF89A6AF71D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjCGVBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjCGVBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:01:17 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD39E521
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:01:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ec29so26856449edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 13:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678222869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+laKuP5cAVSNtPYHlxeAmSs0nLf7ZBBLqCdQZgZeOuw=;
        b=pP8JZTf/ySfxULNY/h6PvVv+THp2rayv+OJYRT4KQh4uQhrRgyCfIuSlGzJWfC5WAw
         iL1sUouNGDPhFTUtxIR5InIUZ6jBKsTGAG+C8KrXDV5mb/LDAS3RUqkDhlfZNiWk+etX
         883/y1oRQz0BpS5IBX8xbImf7iKLQFuy0zKE/0UOm3RBXaSlu6DPmib5/2aN5FLyK+zj
         wyc07QcbQXzOxZm1VsxcCwIPZk/ELGXByKhoSqosjVDYe4nQ4IDnzb9Fy5ERXB10pJo1
         KkmOzXXnqFvZXjKRfBxox6Kcl7Hkh+PSybG0kmJWpB2BlTIi+UPvOSYHbTdERNNnXfu8
         ticQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+laKuP5cAVSNtPYHlxeAmSs0nLf7ZBBLqCdQZgZeOuw=;
        b=SsQ3/z2JZA6zGJd8opqkMBw64f76OjnhJUJVJ2FDB8LYjRvdNSb1ZVznxG2w6zdSnR
         jLioAt5Yly7zliqrACIqZPsEEALJzMZvPwjkScMwd7iH9xjpcHksBKSaODr5I06yeqCh
         NObmByEID4pRDMIl1uFoqvqX0teGb16GwAwzRta6hZ33rrubyywcocuEgDvmnsNrZWQK
         +Qtg7CqNuLPBulwk8GQnLED+2q8swogHupMSOoyYhJGmdLJgFkUjFnUciYViVETyydmM
         GUDdben4la7X5YALAKdqYkn1lcB+hARBEftDMe5etefrorRTNFvsn01YfLfq5/GyWCLc
         UyQw==
X-Gm-Message-State: AO0yUKXMhHrwcyIt2gtsKkzulV2y6r4UNjxOD4oUiXwYIOiwd6bihRPo
        KdrJ69pj5o7r+UytYlAlMv0=
X-Google-Smtp-Source: AK7set/FUB119mWbKzYcHi8ScWt6wwPseoHRsgkIPsjCex7BdjgyMe6HiZ3+12nBTjyhKl8UDuOIiA==
X-Received: by 2002:a05:6402:274d:b0:4af:7bdc:18a5 with SMTP id z13-20020a056402274d00b004af7bdc18a5mr20098565edd.0.1678222868751;
        Tue, 07 Mar 2023 13:01:08 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id d5-20020a170906640500b008be0b7242d5sm6640808ejm.90.2023.03.07.13.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 13:01:08 -0800 (PST)
Date:   Tue, 7 Mar 2023 22:01:06 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] staging: rtl8192e: Remove unused Array
 Rtl8192PciERadioC_Array
Message-ID: <ed1e0df7ed677c335340f42c1108e7b5c0f18462.1678222487.git.philipp.g.hortmann@gmail.com>
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

The array Rtl8192PciERadioC_Array is only used in function
rtl92e_config_rf_path which is only called in function rtl92e_config_rf.
In function rtl92e_config_rf a termination condition for the loop is set
to priv->num_total_rf_path = RTL819X_TOTAL_RF_PATH = 2. The loop is only
executed with numbers 0 and 1 for eRFPath. So the function
rtl92e_config_rf_path is only called with eRFPath for 0 and 1 and never
with 2 that would make the "case RF90_PATH_C:" be called. Remove
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
index 35ca01ab65ff..fe0ef52c163a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -649,18 +649,6 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
 					  bMask12Bits,
 					  Rtl819XRadioB_Array[i+1]);
 
-		}
-		break;
-	case RF90_PATH_C:
-		for (i = 0; i < RadioC_ArrayLength; i += 2) {
-			if (Rtl819XRadioC_Array[i] == 0xfe) {
-				msleep(100);
-				continue;
-			}
-			rtl92e_set_rf_reg(dev, eRFPath, Rtl819XRadioC_Array[i],
-					  bMask12Bits,
-					  Rtl819XRadioC_Array[i+1]);
-
 		}
 		break;
 	case RF90_PATH_D:
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index 561a4c874fe3..6772ed300591 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -14,7 +14,6 @@
 #define RadioA_ArrayLength			RadioA_ArrayLengthPciE
 #define RadioB_ArrayLength			RadioB_ArrayLengthPciE
 #define MACPHY_Array_PGLength			MACPHY_Array_PGLengthPciE
-#define RadioC_ArrayLength			RadioC_ArrayLengthPciE
 #define RadioD_ArrayLength			RadioD_ArrayLengthPciE
 #define PHY_REG_1T2RArrayLength			PHY_REG_1T2RArrayLengthPciE
 
@@ -22,7 +21,6 @@
 #define Rtl819XMACPHY_Array			Rtl8192PciEMACPHY_Array
 #define Rtl819XRadioA_Array			Rtl8192PciERadioA_Array
 #define Rtl819XRadioB_Array			Rtl8192PciERadioB_Array
-#define Rtl819XRadioC_Array			Rtl8192PciERadioC_Array
 #define Rtl819XRadioD_Array			Rtl8192PciERadioD_Array
 #define Rtl819XAGCTAB_Array			Rtl8192PciEAGCTAB_Array
 #define Rtl819XPHY_REG_1T2RArray		Rtl8192PciEPHY_REG_1T2RArray
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.c b/drivers/staging/rtl8192e/rtl8192e/table.c
index d04608d99cbf..4e97ad4b8fd7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.c
+++ b/drivers/staging/rtl8192e/rtl8192e/table.c
@@ -325,9 +325,6 @@ u32 Rtl8192PciERadioB_Array[RadioB_ArrayLengthPciE] = {
 	0x007, 0x00000700,
 };
 
-u32 Rtl8192PciERadioC_Array[RadioC_ArrayLengthPciE] = {
-	0x0,  };
-
 u32 Rtl8192PciERadioD_Array[RadioD_ArrayLengthPciE] = {
 	0x0, };
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index 177fe2173430..981e8b57d3de 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -17,8 +17,6 @@ extern u32 Rtl8192PciEPHY_REG_1T2RArray[PHY_REG_1T2RArrayLengthPciE];
 extern u32 Rtl8192PciERadioA_Array[RadioA_ArrayLengthPciE];
 #define RadioB_ArrayLengthPciE 78
 extern u32 Rtl8192PciERadioB_Array[RadioB_ArrayLengthPciE];
-#define RadioC_ArrayLengthPciE 2
-extern u32 Rtl8192PciERadioC_Array[RadioC_ArrayLengthPciE];
 #define RadioD_ArrayLengthPciE 2
 extern u32 Rtl8192PciERadioD_Array[RadioD_ArrayLengthPciE];
 #define MACPHY_ArrayLengthPciE 18
-- 
2.39.2

