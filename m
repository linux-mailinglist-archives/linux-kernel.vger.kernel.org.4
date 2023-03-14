Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68DC6B9EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjCNSoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCNSob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:44:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4955617E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:44:04 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h8so22196399ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678819441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JhOP8mQ5Z2Gmq+/y1PXXgLvgLODRnQ4GFaonYd0lOUw=;
        b=P50FfZweqLtcGAFr2+JlKgYeryjXgIlvdsMCvh5JHJoPL0gmt/q99CFhc7rbMf5qGz
         4OKMzRnfJRGF23e0mWtSuKYq9H2nW1VpqAFkiz6z73oBKGliCngPb23O7Na46Xo1jzA3
         7O4RiCzA53HUDeWeEkd5EhIG8twELC+dJHFgi18fQYuF82IJw9GBgIdZkgOMLY18ZoAk
         BzJSzkyyaZGoCJb/92S/C8iHrOhrMeevtIYEvBbmkO5T3rQZ/Vmh/TunCaUcmMxrzf8W
         /LxJvR+abewzFVk7Nc7Al0l2qGyPN7aPxMTkm875GNqemo35z4gExnAVB803Q/vEXT8P
         msvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhOP8mQ5Z2Gmq+/y1PXXgLvgLODRnQ4GFaonYd0lOUw=;
        b=5TOGwaZBalngw6H/l094XWjlFlLHblGfr7GOv+u/5srWJA7Mua4XSGUhm1GwLX4htX
         O90aWO9Vw1wYU1UQF1+b/OkpeNeKGruegYU0+EJh9MMaFJ3O/nnnFetvfgoilHSlmPwU
         qjzAlu0Je+O/G1fXn1fWEGwnuXguhYdT0yP5GQurRIebPigzRLlxVWHEA9yyqpta84qn
         6pdnqr36jz43PL2YBFR/FdcZSVIlD1h5+LQB9grnK0jrSZX03wfnimwVn+znzed25YQi
         lHA2pxYN0d1LsRzqT1/1Ecku9SliD2mCd8mxuoZmprQdXymTv1aYjwvOk+FOnOC5RWtV
         fNLA==
X-Gm-Message-State: AO0yUKVcjVx0YawwvSN1+hBR/95m1MMkyaS2o+ee2uZtWsVJYlqHrLcx
        sjAQaiWGRYPbSsjGMN18xKA=
X-Google-Smtp-Source: AK7set+PIEkUWxnQhJUd8f+NTLDRwkt0ZG5GMGUpPCOPKVWm4UA0JFomM0lf53w2mVprSlZBPioedw==
X-Received: by 2002:a05:6402:1d54:b0:4fb:ac81:49bf with SMTP id dz20-20020a0564021d5400b004fbac8149bfmr11012979edb.4.1678819441658;
        Tue, 14 Mar 2023 11:44:01 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id e20-20020a50d4d4000000b004fbf6b35a56sm1404258edj.76.2023.03.14.11.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:44:01 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:43:59 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] staging: rtl8192e: Join constants Rtl819XRadioA_..
 with ..RadioA_..
Message-ID: <0ce85e55fd9ddd5459590d756a951809b6a1b9ee.1678814935.git.philipp.g.hortmann@gmail.com>
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

Join constants Rtl819XRadioA_Array with Rtl8192PciERadioA_Array to
RTL8192E_RADIO_A_ARR to improve readability. Fix spaces around '+' to
improve coding style.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/table.c      | 2 +-
 drivers/staging/rtl8192e/rtl8192e/table.h      | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index bf4fec83d316..49fdaacb788a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -543,13 +543,13 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
 	switch (eRFPath) {
 	case RF90_PATH_A:
 		for (i = 0; i < RTL8192E_RADIO_A_ARR_LEN; i += 2) {
-			if (Rtl819XRadioA_Array[i] == 0xfe) {
+			if (RTL8192E_RADIO_A_ARR[i] == 0xfe) {
 				msleep(100);
 				continue;
 			}
-			rtl92e_set_rf_reg(dev, eRFPath, Rtl819XRadioA_Array[i],
+			rtl92e_set_rf_reg(dev, eRFPath, RTL8192E_RADIO_A_ARR[i],
 					  bMask12Bits,
-					  Rtl819XRadioA_Array[i+1]);
+					  RTL8192E_RADIO_A_ARR[i + 1]);
 
 		}
 		break;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index 2d2b80bc1f21..74c7850e514c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,7 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-#define Rtl819XRadioA_Array			Rtl8192PciERadioA_Array
 #define Rtl819XRadioB_Array			Rtl8192PciERadioB_Array
 #define Rtl819XAGCTAB_Array			Rtl8192PciEAGCTAB_Array
 #define Rtl819XPHY_REG_1T2RArray		Rtl8192PciEPHY_REG_1T2RArray
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.c b/drivers/staging/rtl8192e/rtl8192e/table.c
index 0ab786d35682..4f36a480f6f2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.c
+++ b/drivers/staging/rtl8192e/rtl8192e/table.c
@@ -157,7 +157,7 @@ u32 Rtl8192PciEPHY_REG_1T2RArray[RTL8192E_PHY_REG_1T2R_ARR_LEN] = {
 	0xe1c, 0x12121416,
 };
 
-u32 Rtl8192PciERadioA_Array[RTL8192E_RADIO_A_ARR_LEN] = {
+u32 RTL8192E_RADIO_A_ARR[RTL8192E_RADIO_A_ARR_LEN] = {
 	0x019, 0x00000003,
 	0x000, 0x000000bf,
 	0x001, 0x00000ee0,
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index c6c7d4cd313e..60917c95842b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -14,7 +14,7 @@
 #define RTL8192E_PHY_REG_1T2R_ARR_LEN 296
 extern u32 Rtl8192PciEPHY_REG_1T2RArray[RTL8192E_PHY_REG_1T2R_ARR_LEN];
 #define RTL8192E_RADIO_A_ARR_LEN 246
-extern u32 Rtl8192PciERadioA_Array[RTL8192E_RADIO_A_ARR_LEN];
+extern u32 RTL8192E_RADIO_A_ARR[RTL8192E_RADIO_A_ARR_LEN];
 #define RTL8192E_RADIO_B_ARR_LEN 78
 extern u32 Rtl8192PciERadioB_Array[RTL8192E_RADIO_B_ARR_LEN];
 #define RTL8192E_MACPHY_ARR_LEN 18
-- 
2.39.2

