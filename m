Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCE6713A34
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjE1OxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjE1OxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:53:03 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08F8B2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:53:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d2b42a8f9so1964712b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685285582; x=1687877582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h281HgpjzK4XEri7LVFQyvfUqK1gjl7k3qozv2JOCAE=;
        b=nR1fI3qjXN5dxhT/H2mc44EsCADS2cSqRN83AR2w6D7+whusEr4zT7A9oYtZ7S570u
         OUENjdpgmBAqIFDzB6S7oRYbVTiOt3/aiF3JdTQD4Hp4sX1PKLIXmj7e3GagxO6SIQk6
         aVcKI1k8fsja0rlelkTzJ+Xmg83K8tKW8efrEM5EhjQsnQm1D3DBinIXaVT4SnpINsMg
         Zjp4CGdAv8AmtQrkah+AvE8hi2gWMNvmj2NHwE60e5VbxFG8MGgEQAUc/soBbNEVKomg
         NzmL15HeHOkpeXs3Sr9Qb5rOYq9HC5ogSQN+D3uPRJTJSbo/nM8k4VkJ3wEwVlI1oyev
         sqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685285582; x=1687877582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h281HgpjzK4XEri7LVFQyvfUqK1gjl7k3qozv2JOCAE=;
        b=QE3YZIkxWXGssroTg8ESnbZsp72F3OTaLSctIoakGrIegMh9qmkNksk700rjgVJUKp
         QkyvquXcszfJuD6UIGSsdr/Zc2IjOfezA9qodTXxHjZIXht6Mluc+ZbRMo1UemsdWu5/
         SHOVzPRZfgQM1H3OlLUacLrpLJ/Uio/3eon3u6wRza6DX22yWITV2Z+oFUwj2MylTwet
         gz9q11KjXjji/TY3Pu3hpLdmDlDpECayMrCk7XsGwdM/tbwgYpGaQgkJF3kZiqU96CIZ
         XKNToPXcdkibveILr+JCjtf15UAX1d2hPQRP0xIDG/SRa5rrfbnGywBwdmitVY+6iAvV
         i4YA==
X-Gm-Message-State: AC+VfDyFsZMquBoPYsccm24BHOrPrJdE8Cbe5YyEWIdvjFtwrDRlo5t6
        l+jeBbo8aEppKxRnIVgWzuA=
X-Google-Smtp-Source: ACHHUZ7/htqm/7HGd8RJuPjs7WprXIgVuzvLzBW4KqV3JK/pdQpTJDazny+scCDYyN4IUaaGThmdag==
X-Received: by 2002:a17:902:ec8c:b0:1ac:6d4c:c26a with SMTP id x12-20020a170902ec8c00b001ac6d4cc26amr11738757plg.14.1685285582106;
        Sun, 28 May 2023 07:53:02 -0700 (PDT)
Received: from yogi-Zephyrus ([103.251.210.199])
        by smtp.gmail.com with ESMTPSA id bg8-20020a1709028e8800b001ac591b0500sm6385884plb.134.2023.05.28.07.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:53:01 -0700 (PDT)
Date:   Sun, 28 May 2023 20:22:58 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: rtl8192e: Rename variable InitialGainHandler
Message-ID: <721239f5b292ba9ffa973f5fea81069aaeac34a7.1685284727.git.yogi.kernel@gmail.com>
References: <cover.1685284727.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1685284727.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable InitialGainHandler to init_gain_handler to avoid
CamelCase which is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 61fd84ca58d2..4fceb5ee51d5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1130,11 +1130,11 @@ void rtl92e_scan_op_backup(struct net_device *dev, u8 Operation)
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
index 03898efea12d..d361d18d54f6 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1713,7 +1713,7 @@ struct rtllib_device {
 	void (*set_wireless_mode)(struct net_device *dev, u8 wireless_mode);
 	bool (*GetHalfNmodeSupportByAPsHandler)(struct net_device *dev);
 	u8   (*rtllib_ap_sec_type)(struct rtllib_device *ieee);
-	void (*InitialGainHandler)(struct net_device *dev, u8 Operation);
+	void (*init_gain_handler)(struct net_device *dev, u8 Operation);
 	void (*ScanOperationBackupHandler)(struct net_device *dev,
 					   u8 Operation);
 	void (*SetHwRegHandler)(struct net_device *dev, u8 variable, u8 *val);
-- 
2.25.1

