Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426EE734639
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 15:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjFRNHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 09:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFRNHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 09:07:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEFEB0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 06:07:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-66615629689so2451331b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 06:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687093623; x=1689685623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ooiaPbgSDk2Vavd/yz78VigQmMncQVwP5N8EDeWNlmo=;
        b=j+it1mrQUvR/fZDFPPpYHa5RUyGfo/KR3ts/RFYP6cRh8d32bZFpPVhN409/WDBC9X
         6+7y6VwhwA1/XDSjGOy6p/VPFjpqG3+hhvk7JTfeOpzkBAKASts7Dla9lbrKFn3apDC2
         DtV5jg5oZnTrtG9k/NCZ4+c3tM6z1aWzFh4/6JbZEDX9az+neu7UTbQrmU5boSSSq2Ec
         41nuPaRAe537iaI+HSgVLBNbWp4BDJpbJCyr6EbTP9zjV0aCZfLDrAaj+nsuyNBOnf+P
         WX4w0d/J0lZcmgy+acQq5cq7ICtuMv0E9KxCk4Rez3AjBHZkwqv0tfp42afWRR7khSKm
         K8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687093623; x=1689685623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooiaPbgSDk2Vavd/yz78VigQmMncQVwP5N8EDeWNlmo=;
        b=f5MvmHcTZ1bSqrgrfduAq6X6FTc3kXPPS2253cXx8Zucm/BMX6Cpq6woS9P1NmSZsd
         qvX4E06i+ouCWou6pQbpN2aFDW47b/zQjQC5Kw2D0aZ3r/W0qK6j6yo5oTjqU5n3i7bO
         BfB1N0Q34Oe6NHBdGrBDIOFeChPbp5aVC4yxGB8K0+Pd08AMSCJAeqgSYolUv96p1N1C
         +mKTbNiX1fY/dHV/U493eGM1LiFRu43bhJI9yyb2P0D8GQbrS6ehjvcAK302jNkSbPX2
         1eK3a2Vp9niESw1SUftU6WPKqUAJfIZmD7yA65s92xZNOWtQhA19Z9chySo+yzz8zTzr
         J+pQ==
X-Gm-Message-State: AC+VfDxfJe6achOjHrvEAPEjitJfQD5nVmflqMhZUpty9xRblKnAhrrx
        Jwd7zlpnhWaCuS5ac7sVasY=
X-Google-Smtp-Source: ACHHUZ79lFMtx+Pb0R/irseT7cjmzdFjy784QY0jo3sRAMHQO/wo6KPP3MDUrfzs48j3sNOBNNPMzQ==
X-Received: by 2002:a05:6a00:1691:b0:665:c10f:709c with SMTP id k17-20020a056a00169100b00665c10f709cmr11340188pfc.21.1687093623535;
        Sun, 18 Jun 2023 06:07:03 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id y9-20020aa78049000000b0065e154bac6dsm16159760pfm.133.2023.06.18.06.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 06:07:03 -0700 (PDT)
Date:   Sun, 18 Jun 2023 18:36:58 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, philipp.g.hortmann@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH v3 4/4] staging: rtl8192e: Rename variable InitialGainHandler
Message-ID: <59e1d108e07a159e766d33df1556ffbeab1f7693.1687092111.git.yogi.kernel@gmail.com>
References: <cover.1687092111.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687092111.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable InitialGainHandler to init_gain_handler to avoid
CamelCase which is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---

v3: Revert back to v1 of the patch as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.

v2: Removed the variable and called the function directly instead of
    just renaming the variable as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 7b0da55fa7aa..267fc6f8800e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1109,11 +1109,11 @@ void rtl92e_scan_op_backup(struct net_device *dev, u8 Operation)
 	if (priv->up) {
 		switch (Operation) {
 		case SCAN_OPT_BACKUP:
-			priv->rtllib->InitialGainHandler(dev, IG_Backup);
+			priv->rtllib->init_gain_handler(dev, IG_Backup);
 			break;
 
 		case SCAN_OPT_RESTORE:
-			priv->rtllib->InitialGainHandler(dev, IG_Restore);
+			priv->rtllib->init_gain_handler(dev, IG_Restore);
 			break;
 		}
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index b82d2b7aa26c..eb20b8014997 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -734,7 +734,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 
 	priv->rtllib->SetHwRegHandler = rtl92e_set_reg;
 	priv->rtllib->AllowAllDestAddrHandler = rtl92e_set_monitor_mode;
-	priv->rtllib->InitialGainHandler = rtl92e_init_gain;
+	priv->rtllib->init_gain_handler = rtl92e_init_gain;
 	priv->rtllib->rtllib_ips_leave_wq = rtl92e_rtllib_ips_leave_wq;
 	priv->rtllib->rtllib_ips_leave = rtl92e_rtllib_ips_leave;
 	priv->rtllib->ScanOperationBackupHandler = rtl92e_scan_op_backup;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0ee9b99b4c5e..0551f9b108f6 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1711,7 +1711,7 @@ struct rtllib_device {
 	void (*set_wireless_mode)(struct net_device *dev, u8 wireless_mode);
 	bool (*GetHalfNmodeSupportByAPsHandler)(struct net_device *dev);
 	u8   (*rtllib_ap_sec_type)(struct rtllib_device *ieee);
-	void (*InitialGainHandler)(struct net_device *dev, u8 Operation);
+	void (*init_gain_handler)(struct net_device *dev, u8 Operation);
 	void (*ScanOperationBackupHandler)(struct net_device *dev,
 					   u8 Operation);
 	void (*SetHwRegHandler)(struct net_device *dev, u8 variable, u8 *val);
-- 
2.34.1

