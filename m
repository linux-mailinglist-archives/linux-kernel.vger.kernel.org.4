Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6927263A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbjFGPFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241249AbjFGPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:02:59 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47821FC1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:02:54 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso6713282a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686150174; x=1688742174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ciCWuo7mkukE2uWGAYr6I0+J8XwMl63aYshkUdvmROQ=;
        b=VCxEtwdUm8HLNHQcljdU0bHwGkU554jQ9c9dorWKjf7VEN+f0JQeiDrT0d8aIgdBoN
         ssCPxv4w0oIcMiuOB25ZSy4jxoJc6BdNi0gjR8oJ9T2tSRYX8CxiR4GZck0qC3LvU1mc
         2wtdVzce0PnIs7CErGRS3EP8l4VAFSeIao8Y+HNAJKGZc6oK/nvcPgrOb9f1rVpyih7I
         hqU0Mv2k0lVHOjN/vKKaGgJ/S4nxQaPDZR+fCrLJKS/pcSZRASNWCdjLhuLjl/DU+y+I
         VEeqg185Kio6zQl52dkxPSPNtJ/AoKjAwZo7Zj03NO044l57kDn0+PMAVtvsEt6Sztls
         3n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150174; x=1688742174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciCWuo7mkukE2uWGAYr6I0+J8XwMl63aYshkUdvmROQ=;
        b=eyfvK0X61P5Gz/cOl5e+aoNB+XtAhOfxVXMwWZsBJVznBa09RqKA5Y9fdo69S9ZB+R
         Eyqmpmnt8VoSI2WQvBMmEXta5Evrxdj5O57c7U7nIq2yvVBxGtCcYfmJyuSg4NquJ2QK
         M34+clsN3/Vt3WbebGh7wjjn8tNsM/oJh+nobcfxXNBUks4q1sRkbj7iQv/GVGHtlCzC
         CXmYfgZwwmap4r9Z05POoqIT0iXSuWBNigQR2o2Fu7zkrBmtg6l3oClNxEzG8ZojftaG
         dKZnusMg3GctGl2LnJeuR2kgnNf1FKlLtpquxCugQel/tyMgOB3wG3M/0L5yMyBvz7j4
         glNA==
X-Gm-Message-State: AC+VfDwAo8gL6iZBjN4GYaz7iV+hL8H4BAkg0MTtv0uPZcP83ZHB0dKo
        KCE9G1MLXn2xna0gh8o6M80=
X-Google-Smtp-Source: ACHHUZ4l5u97Jt7CCXzYWcOorreKz2dWoum4LQB1l3ensFhK3vI4lOOlDXpEYPrzw0rgb1vJ0Qj8uQ==
X-Received: by 2002:a17:90a:598b:b0:253:26e5:765a with SMTP id l11-20020a17090a598b00b0025326e5765amr4456240pji.48.1686150174229;
        Wed, 07 Jun 2023 08:02:54 -0700 (PDT)
Received: from yogi-Zephyrus ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id nn4-20020a17090b38c400b002562cfb81dfsm1486061pjb.28.2023.06.07.08.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:02:53 -0700 (PDT)
Date:   Wed, 7 Jun 2023 20:32:50 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] staging: rtl8192e: Remove variable InitialGainHandler
Message-ID: <15852c9ce64695e60b8dfa3d459ad5b1d26ba07e.1686149467.git.yogi.kernel@gmail.com>
References: <cover.1686149467.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686149467.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable InitialGainHandler is set in only one place throughout the
driver. This patch removes the variable and calls the real function
directly instead, eliminating the unnecessary indirection.
Additionally, the removal of the variable aligns with the checkpatch
guidelines by removing the use of CamelCase.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---

v2: Removed the variable and called the function direction instead of
    just renaming the variable as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 1 -
 drivers/staging/rtl8192e/rtllib.h              | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 641e993aaa86..5385bb099c56 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1129,11 +1129,11 @@ void rtl92e_scan_op_backup(struct net_device *dev, u8 Operation)
 	if (priv->up) {
 		switch (Operation) {
 		case SCAN_OPT_BACKUP:
-			priv->rtllib->InitialGainHandler(dev, IG_Backup);
+			rtl92e_init_gain(dev, IG_Backup);
 			break;
 
 		case SCAN_OPT_RESTORE:
-			priv->rtllib->InitialGainHandler(dev, IG_Restore);
+			rtl92e_init_gain(dev, IG_Restore);
 			break;
 		}
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 231903002233..8218319ad834 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -731,7 +731,6 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 
 	priv->rtllib->SetHwRegHandler = rtl92e_set_reg;
 	priv->rtllib->AllowAllDestAddrHandler = rtl92e_set_monitor_mode;
-	priv->rtllib->InitialGainHandler = rtl92e_init_gain;
 	priv->rtllib->rtllib_ips_leave_wq = rtl92e_rtllib_ips_leave_wq;
 	priv->rtllib->rtllib_ips_leave = rtl92e_rtllib_ips_leave;
 	priv->rtllib->ScanOperationBackupHandler = rtl92e_scan_op_backup;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index f7fd8b77db99..92ed1b493f6b 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1709,7 +1709,6 @@ struct rtllib_device {
 	bool (*GetNmodeSupportBySecCfg)(struct net_device *dev);
 	bool (*GetHalfNmodeSupportByAPsHandler)(struct net_device *dev);
 	u8   (*rtllib_ap_sec_type)(struct rtllib_device *ieee);
-	void (*InitialGainHandler)(struct net_device *dev, u8 Operation);
 	void (*ScanOperationBackupHandler)(struct net_device *dev,
 					   u8 Operation);
 	void (*SetHwRegHandler)(struct net_device *dev, u8 variable, u8 *val);
-- 
2.25.1

