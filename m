Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93BD6B9ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCNSnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjCNSnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:43:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9775BCA3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:42:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so36518566edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678819378; x=1681411378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oag7SRyOaaDLTQg5hnswCsWRIe6BhWUvxQa3wS0l66I=;
        b=kdC3swFyZDWi5RSaPn88tz9mzktNSOz5/86XDNBqyqZkhQemGxcYz45eV+PlCqfp60
         IuaiymNaOrsf/kVvxHZcvS4H2l8V94LP1kVO+G4lo24GFphuab7u0wGOMOaT3gElTtLj
         /crjxQlN6ZPGzb+FOAX7/NDe86Q3VtndPXKrV/IF1BWK49r8DskmvA8in3nMsGy7jwMf
         yNgcy37P2hv/xJG0PpRDzEbvhC8xLAd9IqIW02RWcjObKvq03/3IwUu0FCz7ZpEYdpfw
         5FiCbHly7uXd7UtZWYagxKOPir2gJAY/V2IaXWrOYzGn6wJRTzxC7aKfK3zWiJonzuu7
         IqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819378; x=1681411378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oag7SRyOaaDLTQg5hnswCsWRIe6BhWUvxQa3wS0l66I=;
        b=hfyTGGvANsps/O2pwacChg0wSnbiccFWXI2w77wePIbmscEcwRIVqDbNoELTnPWblf
         0045CqnD7aoJuZekPM1hiAz7Hl+Pd93s7dByp0CYc3/sUg0+4jcr8IhLVcatcyZP2Q30
         MGSTzVSMJXxY8BQtn/wtrA/7d9XCzJJHIM9GG+klp0pHJA+t8avPoA1/ArRqFGwImdgQ
         5EFDsMeQyxQ/cq/xmUJNMUQZ9oLGVluRu0D8tJ8tWup8vvS3HjY43sgg/e4jvfqCtss+
         2w/HeE22ENx/EfRyre+/WurfMTwt0SBOYE04hq7ztw8m3HfraDmElnmRSf9Vr2PJ8jXo
         Qirw==
X-Gm-Message-State: AO0yUKVI1A9oBsYS892WKu2Y0AVjKCrmzA5838CmRilB4x5k3WgJIfKc
        eTwT+kcSMw8Jk4mP5wPFScA=
X-Google-Smtp-Source: AK7set+PtHeCz9gvdn1bo7bVwP0Av7gyhUd1M2UZViQrnkf4XRCK1ajIOKMw+xTEVOnY8gIV/+S7EA==
X-Received: by 2002:a17:906:748c:b0:92d:5cc4:4aca with SMTP id e12-20020a170906748c00b0092d5cc44acamr908645ejl.1.1678819378295;
        Tue, 14 Mar 2023 11:42:58 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906858a00b008d173604d72sm1477988ejx.174.2023.03.14.11.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:42:57 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:42:56 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] staging: rtl8192e: Join constants AGCTAB_ArrayLength
 with ..LengthPciE
Message-ID: <98a7553403ef95609fbcb84e4cc653628b96c56c.1678814935.git.philipp.g.hortmann@gmail.com>
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

Join constants AGCTAB_ArrayLength with AGCTAB_ArrayLengthPciE to
RTL8192E_AGCTAB_ARR_LEN to improve readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/table.c      | 2 +-
 drivers/staging/rtl8192e/rtl8192e/table.h      | 4 ++--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 51a20379dca0..54596982bc76 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -312,7 +312,7 @@ static void _rtl92e_phy_config_bb(struct net_device *dev, u8 ConfigType)
 	u16 AGCTAB_ArrayLen, PHY_REGArrayLen = 0;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	AGCTAB_ArrayLen = AGCTAB_ArrayLength;
+	AGCTAB_ArrayLen = RTL8192E_AGCTAB_ARR_LEN;
 	Rtl819XAGCTAB_Array_Table = Rtl819XAGCTAB_Array;
 	if (priv->rf_type == RF_1T2R) {
 		PHY_REGArrayLen = PHY_REG_1T2RArrayLength;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index f1d183ed7ca4..d984380bcca3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,7 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-#define AGCTAB_ArrayLength			AGCTAB_ArrayLengthPciE
 #define MACPHY_ArrayLength			MACPHY_ArrayLengthPciE
 #define RadioA_ArrayLength			RadioA_ArrayLengthPciE
 #define RadioB_ArrayLength			RadioB_ArrayLengthPciE
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.c b/drivers/staging/rtl8192e/rtl8192e/table.c
index 7101061e3519..be6c4b7c0e0e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.c
+++ b/drivers/staging/rtl8192e/rtl8192e/table.c
@@ -347,7 +347,7 @@ u32 Rtl8192PciEMACPHY_Array_PG[] = {
 	0x318, 0x00000fff, 0x00000800,
 };
 
-u32 Rtl8192PciEAGCTAB_Array[AGCTAB_ArrayLengthPciE] = {
+u32 Rtl8192PciEAGCTAB_Array[RTL8192E_AGCTAB_ARR_LEN] = {
 	0xc78, 0x7d000001,
 	0xc78, 0x7d010001,
 	0xc78, 0x7d020001,
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index b6d4e9696452..439847b1f52b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -21,7 +21,7 @@ extern u32 Rtl8192PciERadioB_Array[RadioB_ArrayLengthPciE];
 extern u32 Rtl8192PciEMACPHY_Array[MACPHY_ArrayLengthPciE];
 #define MACPHY_Array_PGLengthPciE 30
 extern u32 Rtl8192PciEMACPHY_Array_PG[MACPHY_Array_PGLengthPciE];
-#define AGCTAB_ArrayLengthPciE 384
-extern u32 Rtl8192PciEAGCTAB_Array[AGCTAB_ArrayLengthPciE];
+#define RTL8192E_AGCTAB_ARR_LEN 384
+extern u32 Rtl8192PciEAGCTAB_Array[RTL8192E_AGCTAB_ARR_LEN];
 
 #endif
-- 
2.39.2

