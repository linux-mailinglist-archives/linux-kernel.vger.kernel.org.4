Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75F36D89C8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjDEVsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDEVsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:48:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0357DAA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:48:23 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-947a47eb908so61186466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680731302; x=1683323302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCqBVJ5FUAqz6et7gCXC65lddEZjuyWxiqbGgbtDS3g=;
        b=OddqGCVQ9nguKkoLetqbQq9AWu6vI93zintV3cneVBEclDnwlebshfdw2KJ1RnFS4Y
         2sXG/aRTSQ+Hq92MJ4CXM10zB7bau3pkNmAyMclQ4nfhjk4/C1z4XXzhEilgRYy/Pnf0
         D/8ocAm7myGvsbgbrQLrRYcyHeVXQOVbKyHBv5TrAOmdXxzN3XvHI1VGmPjO2zo/Mstm
         X4+6x2ogjas8UYmc/Czy7rOzfp3AXz0BqwWcK+cr8IKLPWPOWQT6qWJe18M/+aEQaIVM
         aVwH18TW2wFqarg7LplLeFXE0ptgWP1EN1XD5MHnlx/7MKcjiTt4MWsfxXlCzb7TIVxR
         k4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680731302; x=1683323302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCqBVJ5FUAqz6et7gCXC65lddEZjuyWxiqbGgbtDS3g=;
        b=hTmiGT4iaY4uENI1VVMbvMO7QZuRbPhj/+YmFBfcRYhidXM8bzs7mHPro4yuaWfIvj
         ef2sAEGrUYHnKIgXHiPthSa/a3dIONFStLDiq9LCUFa+SljVxRlvUAvGIKUKKJshARxv
         Bzo6ccoJuQTST2cZNoYO+9DsfNd58c1R2YkTepyxl2pwkWjQ/3RKDL0AJc6Wy2bnbThV
         sUJrWJrSoTSsjhF99bFolO7Nteh5U7k+dgIF1eyY6utGTmErjuJf/8HDURehfptt5iN2
         bPPugdbBgAKeya7H1e6JIWhPNE+58KChsPUGbWV7WYQXrlDOaGxrTPlYVb5ILWzjW6cO
         GL1A==
X-Gm-Message-State: AAQBX9cxcWQf8HpjTFqJa6ZvBwV8bwgCby5eNv95JfnL6CwZZ6E8GAnC
        IMo0bDwCDWqLcf0JISCQyo9CS7KgVn4=
X-Google-Smtp-Source: AKy350ZiqXN0VUogUx+7XtQuAAa4tmYb5kYNfV+HwIMGR9f8ezTep7UPNCtho/PsZ1Fr7C/0+5je3g==
X-Received: by 2002:a05:6402:27cc:b0:4bb:afe3:e0a with SMTP id c12-20020a05640227cc00b004bbafe30e0amr4846026ede.3.1680731302114;
        Wed, 05 Apr 2023 14:48:22 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id n19-20020a509353000000b004c09527d62dsm7867721eda.30.2023.04.05.14.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:48:21 -0700 (PDT)
Date:   Wed, 5 Apr 2023 23:48:20 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: rtl8192e: Remove unused local variable irq_line
Message-ID: <6ec702e12cb30501fc81693a71a96b238bf09ea0.1680729716.git.philipp.g.hortmann@gmail.com>
References: <cover.1680729715.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680729715.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused local variable irq_line.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
index 0bc3e013001e..1c3ccd2aabc3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
@@ -33,11 +33,9 @@ bool rtl92e_check_adapter(struct pci_dev *pdev, struct net_device *dev)
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 	u16 device_id;
 	u8  revision_id;
-	u16 irq_line;
 
 	device_id = pdev->device;
 	revision_id = pdev->revision;
-	pci_read_config_word(pdev, 0x3C, &irq_line);
 
 	priv->card_8192 = NIC_8192E;
 
-- 
2.40.0

