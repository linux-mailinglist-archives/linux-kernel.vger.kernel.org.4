Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CE76B9EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjCNSpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjCNSot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:44:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6D424493
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:44:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ek18so34825189edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678819462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLOK37kaCCRFSQ6Qfe95p7DC41DH+xkXW4p/2GEywPo=;
        b=o5rcG3ReV5MD3ATMvPIYIfyLf0tGNylYLK6uBZxngMMr3PGyyQrrvif8+lWI8KVBHg
         DqGsDsfiCtzL7vAnFb2N7jGCcBiaGmZ4cAoRqm2fkBq7lexgOmgzUa7cojefENXzd1hT
         ksSLBEiJTlzGP6wWgBOWuD08DviRn+JgAdF9OTXNalT4EGOpDIovQ5YKPWh5jwGgzZS5
         EMLL5VlOC+stUBVUX4akXIDRcjZsIR5JY2Lhww9EQeeUe1zchSLr1stcFdqrBcH0ZWE/
         qXgcFm+m9+OAkoSxnIdjSobknk/7ZruvnUwkTNNQ1qs+4X9uyO512DB0jRuihET3Q/OJ
         JNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLOK37kaCCRFSQ6Qfe95p7DC41DH+xkXW4p/2GEywPo=;
        b=p6ttFCwmhdnuuC4bpSrmkfQBSXdZE6WX1uWtVhjsXAiEdDsB9VVubUWUj5WRvzPy1r
         VR8DPawJCOFOdXPqmrFn5aC/6cpnabJGlKJM2xWRi2l4dNxueO48cBL4dAd3/eKvOS+X
         fLkTU2Xcp19UIUL1rfvU95v5XyrWzEbGXeSQB01EHe3hrcE3QY5eVXMNVNMj5CzAd7EW
         +26gJgS099VZhVlQWPQli2xqngtYVuiCC8OaVdPVXmdtBqRw8JRbyEKw6cm3baNqFEUH
         XQuHCl+tnae4rVzNvHHCypwgzepN4FrO/KjoFdd9rI9o7NtMdiSbefDPSTIg23YH5MXJ
         hwWA==
X-Gm-Message-State: AO0yUKUo2qQMe3TA9EwvRR0IbilPM40HZmTwgpURwSqBAkPn9zKlIpr1
        /C2w6de1pJeaXt8CxCQfIi7PBREA6Os=
X-Google-Smtp-Source: AK7set8sc29DTAjORv8IgrLZDEPnHQwqE8NefI67oQBQEvJxfDt7dYpNCX3Q82APCNeRdWkS3/e7aA==
X-Received: by 2002:a05:6402:268e:b0:4bc:edde:14dd with SMTP id w14-20020a056402268e00b004bcedde14ddmr20474290edd.0.1678819462676;
        Tue, 14 Mar 2023 11:44:22 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id g8-20020aa7d1c8000000b004be11e97ca2sm1400647edp.90.2023.03.14.11.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:44:22 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:44:20 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] staging: rtl8192e: Join constants Rtl819XPHY_REG_..
 with ..PciEPHY_REG_..
Message-ID: <2816a10a8a534014c58e0092b78443e01a67930a.1678814935.git.philipp.g.hortmann@gmail.com>
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

Join constants Rtl819XPHY_REG_1T2RArray with Rtl8192PciEPHY_REG_1T2RArray
to RTL8192E_PHY_REG_1T2R_ARR to improve readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 2 --
 drivers/staging/rtl8192e/rtl8192e/table.c      | 2 +-
 drivers/staging/rtl8192e/rtl8192e/table.h      | 2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 72ecdb9ea375..2dbddf4ae3d6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -316,7 +316,7 @@ static void _rtl92e_phy_config_bb(struct net_device *dev, u8 ConfigType)
 	Rtl819XAGCTAB_Array_Table = RTL8192E_AGCTAB_ARR;
 	if (priv->rf_type == RF_1T2R) {
 		PHY_REGArrayLen = RTL8192E_PHY_REG_1T2R_ARR_LEN;
-		Rtl819XPHY_REGArray_Table = Rtl819XPHY_REG_1T2RArray;
+		Rtl819XPHY_REGArray_Table = RTL8192E_PHY_REG_1T2R_ARR;
 	}
 
 	if (ConfigType == BB_CONFIG_PHY_REG) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index 1f9bafd6d3cc..6723fcce8954 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,8 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-#define Rtl819XPHY_REG_1T2RArray		Rtl8192PciEPHY_REG_1T2RArray
-
 extern u32 rtl819XAGCTAB_Array[];
 
 enum hw90_block {
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.c b/drivers/staging/rtl8192e/rtl8192e/table.c
index 3a7656facefc..0b5cc6049232 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.c
+++ b/drivers/staging/rtl8192e/rtl8192e/table.c
@@ -6,7 +6,7 @@
  */
 #include "table.h"
 
-u32 Rtl8192PciEPHY_REG_1T2RArray[RTL8192E_PHY_REG_1T2R_ARR_LEN] = {
+u32 RTL8192E_PHY_REG_1T2R_ARR[RTL8192E_PHY_REG_1T2R_ARR_LEN] = {
 	0x800, 0x00000000,
 	0x804, 0x00000001,
 	0x808, 0x0000fc00,
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index 576228882c21..82be44a9d4e8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -12,7 +12,7 @@
 #include <linux/types.h>
 
 #define RTL8192E_PHY_REG_1T2R_ARR_LEN 296
-extern u32 Rtl8192PciEPHY_REG_1T2RArray[RTL8192E_PHY_REG_1T2R_ARR_LEN];
+extern u32 RTL8192E_PHY_REG_1T2R_ARR[RTL8192E_PHY_REG_1T2R_ARR_LEN];
 #define RTL8192E_RADIO_A_ARR_LEN 246
 extern u32 RTL8192E_RADIO_A_ARR[RTL8192E_RADIO_A_ARR_LEN];
 #define RTL8192E_RADIO_B_ARR_LEN 78
-- 
2.39.2

