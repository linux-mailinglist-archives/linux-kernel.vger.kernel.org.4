Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0B6253DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiKKGe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiKKGeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:34:21 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1108814D17;
        Thu, 10 Nov 2022 22:33:48 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4N7pnQ5vNFz1Dwb;
        Fri, 11 Nov 2022 14:33:46 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4N7pn71HTcz5TCGC;
        Fri, 11 Nov 2022 14:33:31 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4N7pn32kkBzdmYkq;
        Fri, 11 Nov 2022 14:33:27 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N7pmz2Xf7z5PkGm;
        Fri, 11 Nov 2022 14:33:23 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4N7pmw6h5Pz501Qd;
        Fri, 11 Nov 2022 14:33:20 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AB6XCw2066862;
        Fri, 11 Nov 2022 14:33:12 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 11 Nov 2022 14:33:14 +0800 (CST)
Date:   Fri, 11 Nov 2022 14:33:14 +0800 (CST)
X-Zmail-TransId: 2afa636decaaffffffffeb37579f
X-Mailer: Zmail v1.0
Message-ID: <202211111433143392243@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <stern@rowland.harvard.edu>
Cc:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chi.minghao@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSB1c2I6IGVoY2ktb3Jpb246IHVzZSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AB6XCw2066862
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 636DECC9.000 by FangMail milter!
X-FangMail-Envelope: 1668148427/4N7pnQ5vNFz1Dwb/636DECC9.000/10.35.20.165/[10.35.20.165]/mxde.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636DECC9.000/4N7pnQ5vNFz1Dwb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/usb/host/ehci-orion.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index a3454a3ea4e0..d0970caf3c3a 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -234,8 +234,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	if (err)
 		goto err;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&pdev->dev, res);
+	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(regs)) {
 		err = PTR_ERR(regs);
 		goto err;
-- 
2.25.1
