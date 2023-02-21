Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA0769E92D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjBUUyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjBUUyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:54:06 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12F9311FC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:53:47 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x10so21563469edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677012826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CmIDpU8pXZhC5aYh2hMJFzJrfUi2LzepJbDTKpZAl1o=;
        b=XjuV/lDfgltw3xurK4bBzbpOfF1oUP0uTjshEwMJ+4UE33ReKtVH0jGMKQHocn+vGT
         4A/VraDNjjbOk85kkyH5pau1Dpc2vIfajzemO1Q+zGl3JuYn26HlUdLDEGbu0Bj4OTNd
         0QapTGdHfhGtl+9Y+33UtZWnfC1ji09isd+ShbWFUQomICj36xcpkXkc8ZAFHeMcTUDE
         Il+Orwqcx446ACIGcaXck/XoJrpC5sUu/n/jXq4ldTyhKxOG3XTkEN2q7DR8qAfGwKUV
         gRz920QzCH5DqzBfg97Aj09qr4C3lRU2NiPq322RA2GC9YTqYdiATBPnIrOlHO5AmhCU
         b7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677012826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmIDpU8pXZhC5aYh2hMJFzJrfUi2LzepJbDTKpZAl1o=;
        b=pd7wLy+akpEXoL2G2LMimLDWcCQ5KwwkVVS5xjmHYYzkWtYTTpkIy2eF0B1jNiRORR
         MxrK8RTyYw7begKV473BlywKq4iTFV/KHXc/yN3iiBq+zLTy507J8fcuiMCkKFAnFuvX
         lGP6JFCl/tQHxBQ15tX1xuXAO/4bNfqGIchNYeZhqdTouaP2Wx8ymThr1yZG/8AzpSUw
         N0LzLetIQEzwL/ScBfYkBPGgtRGJ+dcUX4Qv4bkcB1t02PfOgg1IAFvfID9RRoynfU+7
         mPMYbv6F09P0CF73GvjqHW3KbWr0fgXP775dazwb7aD05mqEPZKwgZyh7dBZNJ26TJ9F
         o6jA==
X-Gm-Message-State: AO0yUKU3RZy3+i3eZo9a1QGpcU/XZUGbdKhVGZk46fagZjhb/cmeNCyv
        dBAiv1WgSNPQU7jwePpYbfI=
X-Google-Smtp-Source: AK7set+knyD7lerXdj8a4NvreqfY6fcZTZgSR/Hds2LOTR2lobqL6+4VKAXBcfc60flR+xGjUBRnTg==
X-Received: by 2002:a17:906:150:b0:894:4341:77d6 with SMTP id 16-20020a170906015000b00894434177d6mr13256655ejh.1.1677012825929;
        Tue, 21 Feb 2023 12:53:45 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id v18-20020a1709060b5200b008a9e585786dsm7576480ejg.64.2023.02.21.12.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:53:45 -0800 (PST)
Date:   Tue, 21 Feb 2023 21:53:43 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] staging: rtl8192e: Remove entry .nic_type from struct
 rtl819x_ops
Message-ID: <f1fd37a2d2b90bef8caac31a98f3eeff404b3095.1677010997.git.philipp.g.hortmann@gmail.com>
References: <cover.1677010997.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677010997.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unchanged entry .nic_type and replace it with constant NIC_8192E.
This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c  | 6 +++---
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 2d2f9d4a0ff5..044cab649ff1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -26,7 +26,6 @@ int hwwep = 1;
 static char *ifname = "wlan%d";
 
 static const struct rtl819x_ops rtl819xp_ops = {
-	.nic_type			= NIC_8192E,
 };
 
 static struct pci_device_id rtl8192_pci_id_tbl[] = {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index fa72f8891409..f75cc96052d9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -204,7 +204,6 @@ struct rtl8192_tx_ring {
 };
 
 struct rtl819x_ops {
-	enum nic_t nic_type;
 };
 
 struct r8192_priv {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
index 81e1bb856c60..0bc3e013001e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
@@ -39,7 +39,7 @@ bool rtl92e_check_adapter(struct pci_dev *pdev, struct net_device *dev)
 	revision_id = pdev->revision;
 	pci_read_config_word(pdev, 0x3C, &irq_line);
 
-	priv->card_8192 = priv->ops->nic_type;
+	priv->card_8192 = NIC_8192E;
 
 	if (device_id == 0x8192) {
 		switch (revision_id) {
@@ -64,10 +64,10 @@ bool rtl92e_check_adapter(struct pci_dev *pdev, struct net_device *dev)
 		}
 	}
 
-	if (priv->ops->nic_type != priv->card_8192) {
+	if (priv->card_8192 != NIC_8192E) {
 		dev_info(&pdev->dev,
 			 "Detect info(%x) and hardware info(%x) not match!\n",
-			 priv->ops->nic_type, priv->card_8192);
+			 NIC_8192E, priv->card_8192);
 		dev_info(&pdev->dev,
 			 "Please select proper driver before install!!!!\n");
 		return false;
-- 
2.39.2

