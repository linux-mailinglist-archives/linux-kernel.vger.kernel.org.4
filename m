Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93936B9EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCNSoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCNSoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:44:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681C2126C5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:43:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o12so65958151edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678819414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0AW1dgnhE5Xlf5n9QYJOtZN1NTrjTisP+WLFv3uPMk=;
        b=C2j9764WpXjc8CwbYV5XLIBEsdRgH4vazbHwIq2xko9wc0vf/8yX50is53SRJRQdtQ
         6sPlwfFtaM8L029J8yxGJRFDSSCcBosVjLzAll3E0lKmUzE4RDOsWd7V9TpK1WYjw13T
         y5iekO71QP7vTl6n9zKWUNjDALVnMnMs/AmZKbpnF5Tf0uLL0UGBhIllBBPkPdMegVRy
         0uDM0uwjH10GPPWng1WuY/9h0dJw2+riP8gsdJBwP19t9mA8YrIGCoStWwIbeJLlYY9B
         vabc05uPIXNf7qFR8Rr6QxRqvMmd4z9uLTOlLTgSvdYsBWdk4EpsP2te7AmOdIRt27zy
         hjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0AW1dgnhE5Xlf5n9QYJOtZN1NTrjTisP+WLFv3uPMk=;
        b=y7h24izxILCVhm8QABBY+boRexVk9tsa9uihtj8jw/H1eG3rTVrEYhaagZ4yCqbv8C
         SOJGHoWKKRcaLGYcq14ZlhU7fV98nHl/4d1XGeeGHMXHyeDWuZUpyWgnWh7MHbxbPky7
         NQpl56DEu7g3Rs7h7mDclfadtRF8WFht9hleLtOhm+n4Nymnwhq3hWkb3BYXoEW2cFqh
         JI+RHIdcGyoZ5cZzdTu4aOBrAJ2ytRZr0HQW+r8uIvkG4J6gPkRdtmtss0TsCEKL4G39
         JHKS7j5suEDPPX46EMXIZvo2zd+18WOWevzNk8UiOUSa3BMtjea7S6dDz/4UhooJlxtX
         PHAA==
X-Gm-Message-State: AO0yUKU0QM9OQR4HKMI+dL+Fi+aeT6VIuHEUPaYo6S3ndPvPi8LkzXUJ
        Mnh61JiTaJMyy7DJ8Owri48=
X-Google-Smtp-Source: AK7set+1qlK8tRCzTt4IZ8AZFpcBKyXC8eo0cEI0CEFjvJ3m84Du/17pMV1Rkr/wQd3L5LGKiFuUaQ==
X-Received: by 2002:a17:906:1097:b0:8b1:4141:8a30 with SMTP id u23-20020a170906109700b008b141418a30mr17008911eju.6.1678819414379;
        Tue, 14 Mar 2023 11:43:34 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709064e4c00b008df7d2e122dsm1479082ejw.45.2023.03.14.11.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:43:34 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:43:32 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] staging: rtl8192e: Join constants PHY_REG_1T2RArray..
 with ..LengthPciE
Message-ID: <0e24d00350bd2c6d17558ea6b6667209e15073d2.1678814935.git.philipp.g.hortmann@gmail.com>
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

Join constants PHY_REG_1T2RArrayLength with PHY_REG_1T2RArrayLengthPciE to
RTL8192E_PHY_REG_1T2R_ARR_LEN to improve readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 2 --
 drivers/staging/rtl8192e/rtl8192e/table.c      | 2 +-
 drivers/staging/rtl8192e/rtl8192e/table.h      | 4 ++--
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 86d51eb7af17..231bd49b8892 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -315,7 +315,7 @@ static void _rtl92e_phy_config_bb(struct net_device *dev, u8 ConfigType)
 	AGCTAB_ArrayLen = RTL8192E_AGCTAB_ARR_LEN;
 	Rtl819XAGCTAB_Array_Table = Rtl819XAGCTAB_Array;
 	if (priv->rf_type == RF_1T2R) {
-		PHY_REGArrayLen = PHY_REG_1T2RArrayLength;
+		PHY_REGArrayLen = RTL8192E_PHY_REG_1T2R_ARR_LEN;
 		Rtl819XPHY_REGArray_Table = Rtl819XPHY_REG_1T2RArray;
 	}
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index 73a532b96777..96c581475ffe 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,8 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-#define PHY_REG_1T2RArrayLength			PHY_REG_1T2RArrayLengthPciE
-
 #define Rtl819XMACPHY_Array_PG			Rtl8192PciEMACPHY_Array_PG
 #define Rtl819XMACPHY_Array			Rtl8192PciEMACPHY_Array
 #define Rtl819XRadioA_Array			Rtl8192PciERadioA_Array
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.c b/drivers/staging/rtl8192e/rtl8192e/table.c
index 5c9844f4d117..b2cf4d147c63 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.c
+++ b/drivers/staging/rtl8192e/rtl8192e/table.c
@@ -6,7 +6,7 @@
  */
 #include "table.h"
 
-u32 Rtl8192PciEPHY_REG_1T2RArray[PHY_REG_1T2RArrayLengthPciE] = {
+u32 Rtl8192PciEPHY_REG_1T2RArray[RTL8192E_PHY_REG_1T2R_ARR_LEN] = {
 	0x800, 0x00000000,
 	0x804, 0x00000001,
 	0x808, 0x0000fc00,
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index 70c31d56ea14..d00aa394c36a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -11,8 +11,8 @@
 
 #include <linux/types.h>
 
-#define PHY_REG_1T2RArrayLengthPciE 296
-extern u32 Rtl8192PciEPHY_REG_1T2RArray[PHY_REG_1T2RArrayLengthPciE];
+#define RTL8192E_PHY_REG_1T2R_ARR_LEN 296
+extern u32 Rtl8192PciEPHY_REG_1T2RArray[RTL8192E_PHY_REG_1T2R_ARR_LEN];
 #define RTL8192E_RADIO_A_ARR_LEN 246
 extern u32 Rtl8192PciERadioA_Array[RTL8192E_RADIO_A_ARR_LEN];
 #define RTL8192E_RADIO_B_ARR_LEN 78
-- 
2.39.2

