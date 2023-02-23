Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8837B6A02EB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjBWGr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjBWGr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:47:27 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581484AFD2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:47:25 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id h16so39095714edz.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677134844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u4jucbORZ+OZR8pDS3QMC3YnlP5eW/j0vhDGVkYwBMg=;
        b=mOyCavMhBDV9ktxq0ihr3nMvVRXYEwbcgd7mHrheqcejTJuhS9d9saed1e5qorfmAX
         CgsfjvT+NjoT6T3xkU97FRzsGbzvYdOhBJsq8b19im+yxc0teuUtMYuUplsq1+zc4deZ
         R6cHN60ZGIRVk3VN4sV09qkwA2MdUkCCAiuaLU26PQuSIe8D8pEbqBDzY9mJdhF14EpY
         in10GwO0VpOUQG+PN/FybJ1npmiQChsW8/82kCUYGSg5rAttc9uF5Yh6PikeMIugHcKX
         afEyKDNgiAHyGOxFNSCvy+fecEptsyAwSuTcXMFjpePFeVAIQQLUeImSlG75/rnnMbUi
         qHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677134844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4jucbORZ+OZR8pDS3QMC3YnlP5eW/j0vhDGVkYwBMg=;
        b=0WxYslc+F2Y0YlM0rXbVPhIRcYxbbl+d+TzMM7ha1gGXzdkn6QlNF1Etu37cNF7ui7
         jkpJXcdbY8A3/qwwpXsCXlNy35ItCyK3NKubKQl6G3K7ZRFa/EDwpHFo4LPr+2wZfyvd
         QPiY2GE5t2w+m94DfB/Y3kEWDPTz0g0hQYW/hduEuCqbjOWbxdbSYMt/pfzod4jjVVuG
         krVowccvOTfMoktT7HWc9WAekvFmc56cQHs5sJL+nzM6m6TnisRP17TbEvKzHmunlr8+
         6byJmm3gy0w9OglD8drYEIz62fFX0RGjxhtDwWqCMRKRfwCMdCoZ+98E43m+YbWNvytH
         Bphw==
X-Gm-Message-State: AO0yUKXgj1l71w5zieWi4VmvjJ263cJKFBTcprwpuAPkoedMVokVyX6B
        GFckqAEI1ZCGy1oHRmcPt0w=
X-Google-Smtp-Source: AK7set+Gf870jQFuMUaGV3IHvHCyeLL7S+D6Rm9PqbiQPJvOXR5/Ba+wsr9YcXQ+itwqXBgDJsGAvQ==
X-Received: by 2002:a17:906:73d2:b0:87c:c1:111 with SMTP id n18-20020a17090673d200b0087c00c10111mr14654512ejl.4.1677134843927;
        Wed, 22 Feb 2023 22:47:23 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id p12-20020a1709060dcc00b008c1f68ba0e2sm6435870eji.85.2023.02.22.22.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 22:47:23 -0800 (PST)
Date:   Thu, 23 Feb 2023 07:47:21 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8192e: Replace macro RTL_PCI_DEVICE with
 PCI_DEVICE
Message-ID: <8b45ee783fa91196b7c9d6fc840a189496afd2f4.1677133271.git.philipp.g.hortmann@gmail.com>
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

Replace macro RTL_PCI_DEVICE with PCI_DEVICE to get rid of rtl819xp_ops
which is empty.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 044cab649ff1..f5a155d1a81a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -29,9 +29,9 @@ static const struct rtl819x_ops rtl819xp_ops = {
 };
 
 static struct pci_device_id rtl8192_pci_id_tbl[] = {
-	{RTL_PCI_DEVICE(0x10ec, 0x8192, rtl819xp_ops)},
-	{RTL_PCI_DEVICE(0x07aa, 0x0044, rtl819xp_ops)},
-	{RTL_PCI_DEVICE(0x07aa, 0x0047, rtl819xp_ops)},
+	{PCI_DEVICE(0x10ec, 0x8192)},
+	{PCI_DEVICE(0x07aa, 0x0044)},
+	{PCI_DEVICE(0x07aa, 0x0047)},
 	{}
 };
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index f75cc96052d9..c2a4b2ae6a81 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -55,11 +55,6 @@
 #define IS_HARDWARE_TYPE_8192SE(_priv)		\
 	(((struct r8192_priv *)rtllib_priv(dev))->card_8192 == NIC_8192SE)
 
-#define RTL_PCI_DEVICE(vend, dev, cfg) \
-	.vendor = (vend), .device = (dev), \
-	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
-	.driver_data = (kernel_ulong_t)&(cfg)
-
 #define TOTAL_CAM_ENTRY		32
 #define CAM_CONTENT_COUNT	8
 
-- 
2.39.2

