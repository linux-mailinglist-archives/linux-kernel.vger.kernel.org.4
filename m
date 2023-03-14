Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72516B9EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCNSod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjCNSoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:44:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5846222E6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:43:57 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ek18so34820323edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678819435; x=1681411435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0y9mPuC4HKBUj5I294EC9CBSZXqeTk6Vm6POjoEahtQ=;
        b=Q8dEcaCUfpEN+VAxpheSP82vMpI+AiH74bQ+iGkrb0Ti5xK3kP5WC6INk8zgkWQ/Pd
         80JylRbs7bpUhv+zYQKgIUS2FzMf8QB7zQE3X1s6S+Uyp1hlDtLY+V3BwAJIEZbswxuX
         QFTqOB9cfuldBl2ixS8Ktrtj7ApDFogMyRisfqtFQJwplD815mC3pLbV46LBujZBV85e
         J6RGoYoLsdA0nJ5zcTnGPY9+7QHRj/RDfNgHp780fBkRgTsOG0G7oH7bfr08QXyAgPrb
         L6Y6NWvdKTkhrePSURvCEInmVzuxNn1FyEzmtEJW3D0GovoDkqFWJmiSBXoIIm0m8EGh
         74gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819435; x=1681411435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0y9mPuC4HKBUj5I294EC9CBSZXqeTk6Vm6POjoEahtQ=;
        b=ukBuoLu/TceO7EqAUSdZN9K14myqCW4dMcUvUOA0tY9/4PaDpw98xxwRtzsI4QXq9V
         8+LNiDhkd3xQ5Ncq7wZ7C4Pi0hE5vwXjBJMg4K+wmA40XerdOc3OTZwOWKGo2B0x4nbt
         0A0aa7EC6oEMuAdezE7wHh1xDu0WR0L5lGlcn039HagsNiDtFRrrGAtfviBuWJrYCphs
         r1NbOY673ETjStV7/KkWMR9nu4FT3RgEVgib9ZA8qC0j4NVQeAHwMaRonjaqnmwT2WbB
         ysoybsFLZua+x3He09AYT8EevQMy0HcDslMNd/TROSPbSL8voc/lyLTKdE4rXVSO9gHf
         Kkqw==
X-Gm-Message-State: AO0yUKX6UmCZUm8i3Fh7LFVNJOi/7QB44Y6Vmzzll6ZQsWIEx2WiCRts
        KSQd6BuvBRGlSynIcNlMY4M=
X-Google-Smtp-Source: AK7set/O4bLq9OSTWrY/lvH2idxmzOwX8jrmOGxinb+SgyOjYjcLhvrekFpetbnM/dUYwanclV0KHg==
X-Received: by 2002:a05:6402:42d5:b0:4fd:c0a4:224c with SMTP id i21-20020a05640242d500b004fdc0a4224cmr3881221edc.4.1678819434983;
        Tue, 14 Mar 2023 11:43:54 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id b72-20020a509f4e000000b0049e1f167956sm1440486edf.9.2023.03.14.11.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:43:54 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:43:52 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] staging: rtl8192e: Join constants Rtl819XMACPHY_..
 with Rtl8192PciE..
Message-ID: <6e5609e6b31892671d203c9da1a947bd42b70c37.1678814935.git.philipp.g.hortmann@gmail.com>
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

Join constants Rtl819XMACPHY_Array with Rtl8192PciEMACPHY_Array to
RTL8192E_MACPHY_ARR to improve readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/table.c      | 2 +-
 drivers/staging/rtl8192e/rtl8192e/table.h      | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index ef33f651f018..bf4fec83d316 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -292,7 +292,7 @@ void rtl92e_config_mac(struct net_device *dev)
 
 	} else {
 		dwArrayLen = RTL8192E_MACPHY_ARR_LEN;
-		pdwArray = Rtl819XMACPHY_Array;
+		pdwArray = RTL8192E_MACPHY_ARR;
 	}
 	for (i = 0; i < dwArrayLen; i += 3) {
 		if (pdwArray[i] == 0x318)
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index 694528ca7910..2d2b80bc1f21 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,7 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-#define Rtl819XMACPHY_Array			Rtl8192PciEMACPHY_Array
 #define Rtl819XRadioA_Array			Rtl8192PciERadioA_Array
 #define Rtl819XRadioB_Array			Rtl8192PciERadioB_Array
 #define Rtl819XAGCTAB_Array			Rtl8192PciEAGCTAB_Array
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.c b/drivers/staging/rtl8192e/rtl8192e/table.c
index aed1c46dedf6..0ab786d35682 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.c
+++ b/drivers/staging/rtl8192e/rtl8192e/table.c
@@ -325,7 +325,7 @@ u32 Rtl8192PciERadioB_Array[RTL8192E_RADIO_B_ARR_LEN] = {
 	0x007, 0x00000700,
 };
 
-u32 Rtl8192PciEMACPHY_Array[] = {
+u32 RTL8192E_MACPHY_ARR[] = {
 	0x03c, 0xffff0000, 0x00000f0f,
 	0x340, 0xffffffff, 0x161a1a1a,
 	0x344, 0xffffffff, 0x12121416,
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index f94975b112aa..c6c7d4cd313e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -18,7 +18,7 @@ extern u32 Rtl8192PciERadioA_Array[RTL8192E_RADIO_A_ARR_LEN];
 #define RTL8192E_RADIO_B_ARR_LEN 78
 extern u32 Rtl8192PciERadioB_Array[RTL8192E_RADIO_B_ARR_LEN];
 #define RTL8192E_MACPHY_ARR_LEN 18
-extern u32 Rtl8192PciEMACPHY_Array[RTL8192E_MACPHY_ARR_LEN];
+extern u32 RTL8192E_MACPHY_ARR[RTL8192E_MACPHY_ARR_LEN];
 #define RTL8192E_MACPHY_ARR_PG_LEN 30
 extern u32 RTL8192E_MACPHY_ARR_PG[RTL8192E_MACPHY_ARR_PG_LEN];
 #define RTL8192E_AGCTAB_ARR_LEN 384
-- 
2.39.2

