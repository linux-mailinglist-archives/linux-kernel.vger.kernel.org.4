Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386576B9EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCNSns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjCNSnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:43:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B589B5B6A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:43:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eh3so10066135edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678819401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bBloYsUXJ4nsR8iknh3IyaxMJy5tm/ZnRPS+e2A2ehg=;
        b=Cc+eiJJbpaK++5Rpay8c+vgf1LlAgiCX3DI4PS/aI4YE9gO9ZLvjBJdjjJF+6BJBay
         y7DHAPVpDsbfVF7IBWbaPIfLIiqPLnZij93vd7in/ZCRDqTBV2cP+uCVx3ozwKiWmGGz
         nQGigmOZrgg/Qprns29T/XF2w2nY4UabatJ36iE9S6qy/T/+SMaTL7sgkGt94w8NqAjh
         uGoTdde8s4SNhw5PdK9mg1syzSZ/vUTdTGb1xMsZA2ETSbc86JfvRmqyYX4+KgkAUl5d
         lWm9GewyPRP+4KHEPdMMTvScR02t3BmGqd9QRYhIsY0OfkHhbnxcxz8b0mPnck9zL3Jo
         R2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBloYsUXJ4nsR8iknh3IyaxMJy5tm/ZnRPS+e2A2ehg=;
        b=YQlB5E6Ym8QMf3IOBo2V3LOBvNMDUaDld3vf39VbGKPL1RV2sakltpHpsPbn8ooVr6
         766QVcmH5+6+Dh/EGKGdmwNNjnLgd1h8B0sutwg+HUWF5wgdiY3oXix1fBhB7va6MBsS
         hkMywSpkjZKbIJ1fXAtIJdUlP1OXtovj6nfYhmcIvA9tobWbUkvb+5/WHBSs3IxVLXGI
         DoyGmuM32WpgGAVqCKj87BRX4TYTxFxZzpPY5ri+NQRgWnSuoNMwziFh1XE+OEX7Y8g9
         D7t+PYPnfO9UAA0uYJrHTbJ3q5MyVpwT/KmbpuxOWY6HeIhA1XK1Ep3E76Xg0pu6zoGs
         Uysg==
X-Gm-Message-State: AO0yUKXDPKiwHjYnQS8kbiED2ARUhKHLSTMKHxBH2ULQu/Ve0ThrqL+W
        kPfRJe80esp1oURMwU9cUe4jT1uapXE=
X-Google-Smtp-Source: AK7set82crYoVByFkf/r3suirXAZgQUEAOMpVghg/agMHrlHAptZNl24Mv+kHQaXhJNVPNF8oAJr1g==
X-Received: by 2002:a05:6402:3490:b0:4fb:886:c9d9 with SMTP id v16-20020a056402349000b004fb0886c9d9mr13419798edc.1.1678819400803;
        Tue, 14 Mar 2023 11:43:20 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id r23-20020a50aad7000000b004f9e6495f94sm1435311edc.50.2023.03.14.11.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:43:20 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:43:18 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] staging: rtl8192e: Join constants RadioB_ArrayLength
 with ..LengthPciE
Message-ID: <1f48c0691eb4627be81fc39d08762617a6c58a08.1678814935.git.philipp.g.hortmann@gmail.com>
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

Join constants RadioB_ArrayLength with RadioB_ArrayLengthPciE to
RTL8192E_RADIO_B_ARR_LEN to improve readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/table.c      | 2 +-
 drivers/staging/rtl8192e/rtl8192e/table.h      | 4 ++--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index e4d1b7ad64ac..e42b77f91528 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -554,7 +554,7 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
 		}
 		break;
 	case RF90_PATH_B:
-		for (i = 0; i < RadioB_ArrayLength; i += 2) {
+		for (i = 0; i < RTL8192E_RADIO_B_ARR_LEN; i += 2) {
 			if (Rtl819XRadioB_Array[i] == 0xfe) {
 				msleep(100);
 				continue;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index 8f9200bed456..e9ff224953f9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,7 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-#define RadioB_ArrayLength			RadioB_ArrayLengthPciE
 #define MACPHY_Array_PGLength			MACPHY_Array_PGLengthPciE
 #define PHY_REG_1T2RArrayLength			PHY_REG_1T2RArrayLengthPciE
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.c b/drivers/staging/rtl8192e/rtl8192e/table.c
index 5820c47f4e14..5c9844f4d117 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.c
+++ b/drivers/staging/rtl8192e/rtl8192e/table.c
@@ -283,7 +283,7 @@ u32 Rtl8192PciERadioA_Array[RTL8192E_RADIO_A_ARR_LEN] = {
 	0x007, 0x00000700,
 };
 
-u32 Rtl8192PciERadioB_Array[RadioB_ArrayLengthPciE] = {
+u32 Rtl8192PciERadioB_Array[RTL8192E_RADIO_B_ARR_LEN] = {
 	0x019, 0x00000003,
 	0x000, 0x000000bf,
 	0x001, 0x000006e0,
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index d177b7b17b19..174a4dfb1855 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -15,8 +15,8 @@
 extern u32 Rtl8192PciEPHY_REG_1T2RArray[PHY_REG_1T2RArrayLengthPciE];
 #define RTL8192E_RADIO_A_ARR_LEN 246
 extern u32 Rtl8192PciERadioA_Array[RTL8192E_RADIO_A_ARR_LEN];
-#define RadioB_ArrayLengthPciE 78
-extern u32 Rtl8192PciERadioB_Array[RadioB_ArrayLengthPciE];
+#define RTL8192E_RADIO_B_ARR_LEN 78
+extern u32 Rtl8192PciERadioB_Array[RTL8192E_RADIO_B_ARR_LEN];
 #define RTL8192E_MACPHY_ARR_LEN 18
 extern u32 Rtl8192PciEMACPHY_Array[RTL8192E_MACPHY_ARR_LEN];
 #define MACPHY_Array_PGLengthPciE 30
-- 
2.39.2

