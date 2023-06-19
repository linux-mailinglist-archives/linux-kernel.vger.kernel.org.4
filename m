Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99C5735958
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjFSOTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjFSOTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:19:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A3AE64
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:19:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b51780c1b3so28157205ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687184342; x=1689776342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3rO86JQ5SHM0eemJ/VqPbGFU0io6tHVoiFzDxr8Og0=;
        b=elw+cl1rlqwKShs5z+o3pnWcbAKateNwHR4iLX+c7aQT3ymfwK7pTPJmAqbKBxIozO
         Lx4k7TRunfRXhNXl8RIKNItivmqVNgaTu3/iHzhaEun4j7XVlXTGM9WlHNsSlLpJ7J8P
         LtTNTtA6k20Z5mdVQw5I2d78vKjQYtNjj5nfpDZcnu4UYWvq+F5ptFxuunsK+si2sezK
         HjiKyVQPFRSSMfXFFkaocvXyLgN2LS+ReyHAeQ2q1B5MD59+AyYHdaQTEdOp0RFiLMmD
         JFlVjKoupWnaF1c/Q2Vatgs4MmsmOZWTolXHU3SHmCjLsgm36LUoztHhpt4k8rn6OMO/
         tnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687184342; x=1689776342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3rO86JQ5SHM0eemJ/VqPbGFU0io6tHVoiFzDxr8Og0=;
        b=d7UADQcAWHD60mWp0fHBewLgwVWAciH7ueuZAwZHP77cDG68ljL4f0hnAtcShR88nf
         XDPGMFrV1i2zkPxxkBylKCmY7z1FljL3mAcK+gcUg3zQpm6t5uSQHaKtq2Kar0QxVApC
         YtJEkwmDq9ghPM50VbodNGn0ztqSln2Fq+c9WpH2D0pF6lpMX32XfUmqQzVcvu3mGWCX
         vzq5El1AxM6cAZqqStN8/VfsX4UBE6Rgb0FLjMp8RXSfdA1wWk0oxRDVBnIWVcJOW+4Q
         kXLidaylS9wyQEXruMVh2KNs/IaZx/s7hPY8wVYHnzHQrXHL1iEzzhMV+SfdbpWbPMYc
         984g==
X-Gm-Message-State: AC+VfDxVQYRofRDsCcAZT307IYbNSCzceLHIib5pjoSKxfYvCE6QtFrE
        ov2geRKRf9iOnX5d9UfFk3c=
X-Google-Smtp-Source: ACHHUZ6F0GU9diLxr0UYwIygVNvfY9+r/Rh6ObsRANw0cuXNcZrDAV55mbM2wjB20fh/S8C3+qZ+5w==
X-Received: by 2002:a17:902:d485:b0:1b6:79fe:3832 with SMTP id c5-20020a170902d48500b001b679fe3832mr281315plg.69.1687184342004;
        Mon, 19 Jun 2023 07:19:02 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090341c300b001aaecc15d66sm20560820ple.289.2023.06.19.07.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:19:01 -0700 (PDT)
Date:   Mon, 19 Jun 2023 19:48:57 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, philipp.g.hortmann@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH v4 4/4] staging: rtl8192e: Rename variable InitialGainHandler
Message-ID: <a2f37a6cb962e9775978ae5f4fde958b74806a4e.1687183827.git.yogi.kernel@gmail.com>
References: <cover.1687183827.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687183827.git.yogi.kernel@gmail.com>
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

v4: Rebase to latest staging-testing branch as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.

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
index 631cbe016ea9..4447489a16ea 100644
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
index 37e6fcd4b1ec..dbf78b60dd78 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1693,7 +1693,7 @@ struct rtllib_device {
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

