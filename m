Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762C16B9ED8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjCNSnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCNSnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:43:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FFEAFBA2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:43:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so36521280edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678819393; x=1681411393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8LjbSZR0Kfj/oBrMiuwr7Jdgg7szPbhvPzSbkmPBCg=;
        b=UyM49eccXFnyBClUPyJYe3LGlGKmaxEGqwTrTg4KCv9YBDdEY6+K1zqB5J5ndkLM1O
         c+DypDpYQF+6v4bILw7mdHYgNTks84qpDz4OzOzeReTZ1/fzPtljJuMRMimcx+AvjUck
         R6Ce+b7w5Ow8giGiwTHyBAj3Vo95xRS+9zPO6cFhPLJnEM6vzHRSixz12kN8otwuBoGM
         oNOLfY3eyl/6bCuzAf5JzKZ7iV3JLYpODMQ2YlD38A/KV9tqmIfSR3Duz+m2j50fs/oF
         NAL2D75QMAM0gXh7zPdeyKh2zqA23KGm1fGFHfx03zjcIWoTwnzWC+4QFj5vG0R2Sj6q
         ajxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819393; x=1681411393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8LjbSZR0Kfj/oBrMiuwr7Jdgg7szPbhvPzSbkmPBCg=;
        b=GnXVnkxOY0hoG6kzcs8muhkKEf3YixE/b0z+G7xEZHzbzXHas2TWeLuGXvyjNYdVoJ
         zYubv0bmigv4LFuol4KMoBcsTGPayW5za97hq4Hp1AfKahZaaFdpcVQAKQK9q7Jtlt8F
         fGhkEmU0IPkdbNT15exMDK3J9MenNk0VGjjn9Es5ETtcXi0WpQRV++UhaFRsEfWLcx9v
         q/A5sTSml+PfAXtE1nt5+gtInpoQG4dxpXFLSdQQdms+IY7psGpMblFSn+blkB4lCKe+
         LhxXZv6U549kIIYC241kYsdMMry5blKzigXOOYvwAukM+8y+KF4pVOoWNQQfw+bZc6Du
         b5QA==
X-Gm-Message-State: AO0yUKV0zAJxXqTrDG8XE/XQXBdOzyyIf9I/LXK5D2WpNe3PfKX9dbhR
        OrTQ65OwW+4iQV5zGwQu7F44OQrPMBE=
X-Google-Smtp-Source: AK7set/ON/jpn8wtxOhWEVadk2vyaDcFBz4jPlhB1SAt4+VYDDD8bC5u24X8NA5GRjf7vxgMYQSeBA==
X-Received: by 2002:a17:906:208a:b0:889:d24e:6017 with SMTP id 10-20020a170906208a00b00889d24e6017mr15455601ejq.3.1678819393708;
        Tue, 14 Mar 2023 11:43:13 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090629cb00b008e17dc10decsm1491695eje.52.2023.03.14.11.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:43:13 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:43:11 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] staging: rtl8192e: Join constants RadioA_ArrayLength
 with ..LengthPciE
Message-ID: <a03372c15cf1489b964d48d667f39c6e231fa190.1678814935.git.philipp.g.hortmann@gmail.com>
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

Join constants RadioA_ArrayLength with RadioA_ArrayLengthPciE to
RTL8192E_RADIO_A_ARR_LEN to improve readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/table.c      | 2 +-
 drivers/staging/rtl8192e/rtl8192e/table.h      | 4 ++--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 29918a529f77..e4d1b7ad64ac 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -542,7 +542,7 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
 
 	switch (eRFPath) {
 	case RF90_PATH_A:
-		for (i = 0; i < RadioA_ArrayLength; i += 2) {
+		for (i = 0; i < RTL8192E_RADIO_A_ARR_LEN; i += 2) {
 			if (Rtl819XRadioA_Array[i] == 0xfe) {
 				msleep(100);
 				continue;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index 611756517ce6..8f9200bed456 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,7 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-#define RadioA_ArrayLength			RadioA_ArrayLengthPciE
 #define RadioB_ArrayLength			RadioB_ArrayLengthPciE
 #define MACPHY_Array_PGLength			MACPHY_Array_PGLengthPciE
 #define PHY_REG_1T2RArrayLength			PHY_REG_1T2RArrayLengthPciE
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.c b/drivers/staging/rtl8192e/rtl8192e/table.c
index be6c4b7c0e0e..5820c47f4e14 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.c
+++ b/drivers/staging/rtl8192e/rtl8192e/table.c
@@ -157,7 +157,7 @@ u32 Rtl8192PciEPHY_REG_1T2RArray[PHY_REG_1T2RArrayLengthPciE] = {
 	0xe1c, 0x12121416,
 };
 
-u32 Rtl8192PciERadioA_Array[RadioA_ArrayLengthPciE] = {
+u32 Rtl8192PciERadioA_Array[RTL8192E_RADIO_A_ARR_LEN] = {
 	0x019, 0x00000003,
 	0x000, 0x000000bf,
 	0x001, 0x00000ee0,
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index cb424c8fbee0..d177b7b17b19 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -13,8 +13,8 @@
 
 #define PHY_REG_1T2RArrayLengthPciE 296
 extern u32 Rtl8192PciEPHY_REG_1T2RArray[PHY_REG_1T2RArrayLengthPciE];
-#define RadioA_ArrayLengthPciE 246
-extern u32 Rtl8192PciERadioA_Array[RadioA_ArrayLengthPciE];
+#define RTL8192E_RADIO_A_ARR_LEN 246
+extern u32 Rtl8192PciERadioA_Array[RTL8192E_RADIO_A_ARR_LEN];
 #define RadioB_ArrayLengthPciE 78
 extern u32 Rtl8192PciERadioB_Array[RadioB_ArrayLengthPciE];
 #define RTL8192E_MACPHY_ARR_LEN 18
-- 
2.39.2

