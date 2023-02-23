Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B16D6A02EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjBWGri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBWGrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:47:36 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1C54BE86
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:47:32 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f13so38392555edz.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677134850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6CjMSX3fCv/Qr1M0aeSG/e+l/GblnDne7N25TnEl9vI=;
        b=MAwUCEBEIh7x0Lr0V2oLN8HKK9Nn5ZwZbIFA//ovhuOIgajx6fkWg56JTkjQrQbr9t
         L/WXYNqVV2McAS71EAQB3Oo63SZOXkxPMEZTnDRn1kjmtCytieBTNbkYu7RwpXp2A7Vs
         TaDYpPzcRqwaCxu47TH/JDCV+SwjIc7PGhyJPFPNHb2FBTEH8ASwhJyY+mQsOGW6G7lr
         YSkm4xBhXb/W9eGRCH41G14c2QaQ8nmPlypW7Wnwu2GQzk9K2DMVpV6U5P5HK5iDPK0c
         +8lQwbpLbxcBUEmXnmbkb1QHbPp2kyBnUqZpWt5CNRoNdasziBejSfiGYIvHIPhBnn0X
         4rFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677134850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CjMSX3fCv/Qr1M0aeSG/e+l/GblnDne7N25TnEl9vI=;
        b=xAH0lUKYyeoFHe7yS3vEgUzqQwtLqiMW2h49msnT+CEY2oJolFUQkQDOUh+Fgx8ZgC
         kmevn59Bit4pdiTVh2aNesz0LhKDSU8OHLHu6NMCvL9KpkEI5kA+5T+8To/bZUsMx4sd
         cFPPS/HSjpJ82NuGB2Xcb05C5dyAk3qP8rPbbvRbqRSMv9i2o9ngfvq3PEA0cNMlgakI
         d2olE/VzvPPfRVThguenU2TiVAXFX0lv2BKy8LGZogR33lH0sNKGJpt9pjfcqJucyF4Q
         rae8y4Np8dt/SQIm36xlHwNX0gFe9K0XkCr/TU4EWNY0z5Cl7ZTvjZj49W4ulJOeGr+D
         bSmg==
X-Gm-Message-State: AO0yUKV8hsGSOzQDsgVTwFNNCHEijtECVCXaldAvWh0B+Dn2cn9kNvA5
        86sq/NuGeJ/R7pd/bD0hzuM=
X-Google-Smtp-Source: AK7set89d0/XCAaY6TDRJ0GNgheYEinTgayLhXErICIVlYtWFn5N4+TqzuXiuKgyZjytwk16GCoecg==
X-Received: by 2002:a05:6402:1e8e:b0:4ad:de7:253f with SMTP id f14-20020a0564021e8e00b004ad0de7253fmr11531165edf.3.1677134850536;
        Wed, 22 Feb 2023 22:47:30 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id h21-20020a50cdd5000000b004af5968cb3bsm2614654edj.17.2023.02.22.22.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 22:47:29 -0800 (PST)
Date:   Thu, 23 Feb 2023 07:47:28 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8192e: Remove empty struct rtl819x_ops
Message-ID: <31b5b0ba88d7b07b0407956d56446e8f0e62e3e7.1677133271.git.philipp.g.hortmann@gmail.com>
References: <cover.1677133271.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677133271.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty struct rtl819x_ops as it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 6 ------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 4 ----
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f5a155d1a81a..718d69b4ce16 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -25,9 +25,6 @@
 int hwwep = 1;
 static char *ifname = "wlan%d";
 
-static const struct rtl819x_ops rtl819xp_ops = {
-};
-
 static struct pci_device_id rtl8192_pci_id_tbl[] = {
 	{PCI_DEVICE(0x10ec, 0x8192)},
 	{PCI_DEVICE(0x07aa, 0x0044)},
@@ -2190,7 +2187,6 @@ static int _rtl92e_pci_probe(struct pci_dev *pdev,
 	unsigned long ioaddr = 0;
 	struct net_device *dev = NULL;
 	struct r8192_priv *priv = NULL;
-	struct rtl819x_ops *ops = (struct rtl819x_ops *)(id->driver_data);
 	unsigned long pmem_start, pmem_len, pmem_flags;
 	int err = -ENOMEM;
 	u8 revision_id;
@@ -2257,8 +2253,6 @@ static int _rtl92e_pci_probe(struct pci_dev *pdev,
 	if (pdev->device == 0x8192 && revision_id == 0x10)
 		goto err_unmap;
 
-	priv->ops = ops;
-
 	if (!rtl92e_check_adapter(pdev, dev))
 		goto err_unmap;
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index c2a4b2ae6a81..c8816c44ca51 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -198,9 +198,6 @@ struct rtl8192_tx_ring {
 	struct sk_buff_head queue;
 };
 
-struct rtl819x_ops {
-};
-
 struct r8192_priv {
 	struct pci_dev *pdev;
 	struct pci_dev *bridge_pdev;
@@ -218,7 +215,6 @@ struct r8192_priv {
 	struct delayed_work		txpower_tracking_wq;
 	struct delayed_work		rfpath_check_wq;
 	struct delayed_work		gpio_change_rf_wq;
-	struct rtl819x_ops			*ops;
 	struct rtllib_device			*rtllib;
 
 	struct work_struct				reset_wq;
-- 
2.39.2

