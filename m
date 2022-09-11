Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E4C5B4FF4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 18:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIKQUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 12:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiIKQUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 12:20:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90F213F02
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:20:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id wc11so427120ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5/IIZbWRTXX4L4GClXT0KhOjJ/7HccMx71oM1JZ+Wao=;
        b=qt8DPBK9nsHDVjwGrqgLpBzVPfG65OzLmfeda/YIKHJx0dLGFN5IpJ0SPQgo4zXgrL
         q3ZUsNblrO/WcjTt2zoHCg3LI+jX3+XHGc/flOWysgFAkk9kHDfQX07Uz8aJYOQ9t6aS
         mjY+0vEE7wNFrAR+6S6aryGt73ywxVgDIYmvTdRH0MUK4d7udGVzH6Nfq8rhA84bfAz8
         fRZ6gbOHO1gBJCm9Hs5VBNa/WOcH/WL4pHe4pMdP0UqOkf1B0bx357EkzGSmAkrNWYFm
         e9dpXBps38bCfqH18A41Li2ANSNKWeV8sD+46tciiPQ9aLkEy7JS100oV+qq7MXtL//f
         Gi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5/IIZbWRTXX4L4GClXT0KhOjJ/7HccMx71oM1JZ+Wao=;
        b=I9Ip9PmXJopFHfogF9/6x8PruNsFvLtHo9HUb4kJYBAs8gQr1uQpuJs2WGoJh+R4tu
         u2nkGAiNM6BMpq2lLhtCE4bIn1MusxxEhOX0moK6bH+VCZ6k/yJzjoFHuhnio9TcoxAi
         XiGT9eIvA8/AMGKQl22+kix/hrhHm/5JfmzjhzPtqsajDm5ealaXYK3gTPq8ckpyUway
         thOEP5edYtnOl6HS0qcDWeNQMxFQDOI61MhzB/9mqiUr9+K9qMSpjPD1XMTCIijTlx8Y
         men2WAv5FnsI6lT2Qtooj85/Az6zUAYkTcosDL5C0lFWna5B14EVpBcrSrV0VF2TuUV7
         jvwQ==
X-Gm-Message-State: ACgBeo1bm0V+c7JWKr3qOBtr/LPBq4gKrghOknr+m4I77saF+l4IESAz
        n/HH4IdeWXLCRWCSICXOiO0=
X-Google-Smtp-Source: AA6agR4+ga2QghFLqkPTwzMTva+vEGzt6fMB58RBbVxHQE77kDfdgtbFZmbQmtBlI4nyOY1iQC85Gw==
X-Received: by 2002:a17:906:fc6:b0:72f:d080:416 with SMTP id c6-20020a1709060fc600b0072fd0800416mr16218426ejk.1.1662913203217;
        Sun, 11 Sep 2022 09:20:03 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id bt6-20020a170906b14600b00779dc23be62sm3055346ejb.120.2022.09.11.09.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 09:20:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: r8188eu: rename odm_QueryRxPwrPercentage()
Date:   Sun, 11 Sep 2022 18:19:47 +0200
Message-Id: <20220911161949.11293-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911161949.11293-1-straube.linux@gmail.com>
References: <20220911161949.11293-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename odm_QueryRxPwrPercentage() to avoid camel case.

odm_QueryRxPwrPercentage -> odm_query_rxpwrpercentage

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index a557c5d1542e..8b292644b38c 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -3,7 +3,7 @@
 
 #include "../include/drv_types.h"
 
-static u8 odm_QueryRxPwrPercentage(s8 AntPower)
+static u8 odm_query_rxpwrpercentage(s8 AntPower)
 {
 	if ((AntPower <= -100) || (AntPower >= 20))
 		return	0;
@@ -117,7 +117,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			break;
 		}
 		rx_pwr_all += 6;
-		PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
+		PWDB_ALL = odm_query_rxpwrpercentage(rx_pwr_all);
 		if (!cck_highpwr) {
 			if (PWDB_ALL >= 80)
 				PWDB_ALL = ((PWDB_ALL - 80) << 1) + ((PWDB_ALL - 80) >> 1) + 80;
@@ -162,7 +162,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			pPhyInfo->RxPwr[i] = rx_pwr[i];
 
 			/* Translate DBM to percentage. */
-			RSSI = odm_QueryRxPwrPercentage(rx_pwr[i]);
+			RSSI = odm_query_rxpwrpercentage(rx_pwr[i]);
 			total_rssi += RSSI;
 
 			pPhyInfo->RxMIMOSignalStrength[i] = (u8)RSSI;
@@ -173,7 +173,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 		/*  (2)PWDB, Average PWDB calculated by hardware (for rate adaptive) */
 		rx_pwr_all = (((pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all) >> 1) & 0x7f) - 110;
 
-		PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
+		PWDB_ALL = odm_query_rxpwrpercentage(rx_pwr_all);
 
 		pPhyInfo->RxPWDBAll = PWDB_ALL;
 		pPhyInfo->RxPower = rx_pwr_all;
-- 
2.37.3

