Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15056AB2FB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCEWdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCEWdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:33:22 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A0F8A6C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 14:33:21 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x3so31228903edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 14:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678055600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+faGcyrcjggVSJi7hxIupggyB5hed7usIcPhK71OdM=;
        b=I33mrdbRoDE/yTqiYTUaY2x6eBs/13PiCZUxAndrAZB+YE4HL54bVw/a30JnKaDW5I
         NGtstuPKrROarY5efhla6aDmBTp6wYF4IaqTzds/7qxdlVyZC3autjctZdmetbGZtCqo
         31cS8KDu8L4NG+Uw4+kuHOAtB9pkyH21cwv1nGs53bU7ytqt+3uOZ/Wvf5uQB1cxhvd5
         svFXVlcehn155CwKL7cnMnCDrng60KDtTGJH+uaayvh7F0iwP1YOSFvv3T+MEbBVUwHz
         qzMAMLMdCe88ie1Ep7gG0sWl5g5rFLNUbfUv/7PBHgUrwVhLgJT4EMe2iTAamitytS74
         NQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678055600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+faGcyrcjggVSJi7hxIupggyB5hed7usIcPhK71OdM=;
        b=ZCXFRdPOUDv/SvukNJCSTZAejSS6MeWyYkqHm6tBAHPWLiddET9u5scN5ZdNw/+C02
         tBkJxeIvqC3ELWaz6MqXjwkCJZqn4yZ5R/LZUZOWtrtga8B+oaAMLW55i5CrZe+TdSJO
         Zk0uSSfibHUO9BvjiWecNq9YDT6hwTt5n4lavGuR01CcpYuolZqQH8kNTUq61eRSM74X
         yOU6Sx3wzq2HrIMvSxXPwzxAFxWqAhEPg4jTv5uVjTfRj/KxaxUKCakTBT2AqhM7STC8
         yDlzHcGXEijkDfll/8b4eNVuW4U1anCqWNLtY1Rw94bJZiCgZpKlB59cR3qL105rgnpk
         rHdg==
X-Gm-Message-State: AO0yUKWwIhOrnO/hWPaUtrwTRR8zrIq+YAnlvcfRvBuesrF0DWdWUkox
        2uonO+T9Inx2SZmmG8y50+c=
X-Google-Smtp-Source: AK7set8O1hWoozyZKnBPsG4nR4jDb1QQApe+/6ptnoJKYW0YDJlaT2Hh0XhOZisU40zu4GaqNNaW5w==
X-Received: by 2002:a17:906:154:b0:8ae:cd8e:3957 with SMTP id 20-20020a170906015400b008aecd8e3957mr7785048ejh.4.1678055600291;
        Sun, 05 Mar 2023 14:33:20 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id p23-20020a170906615700b008d5d721f8a4sm3676089ejl.197.2023.03.05.14.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 14:33:19 -0800 (PST)
Date:   Sun, 5 Mar 2023 23:33:18 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8192e: Remove empty Array
 Rtl8192PciERadioD_Array
Message-ID: <e8842422d34fd19592047ad821c0dbe2eb4bcdc9.1678051461.git.philipp.g.hortmann@gmail.com>
References: <cover.1678051460.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678051460.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty array Rtl8192PciERadioD_Array and the code where it is used
because it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
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

