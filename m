Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A84623E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiKJJA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKJJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:00:24 -0500
X-Greylist: delayed 374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 01:00:22 PST
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DD169DE6;
        Thu, 10 Nov 2022 01:00:22 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4N7Fxp1jXkz1DyZ;
        Thu, 10 Nov 2022 16:54:06 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4N7FxX1vcHz9vXNx;
        Thu, 10 Nov 2022 16:53:52 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4N7FxT2m03z9tyD6;
        Thu, 10 Nov 2022 16:53:49 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N7FxN2Qx9z5BNS0;
        Thu, 10 Nov 2022 16:53:44 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AA8rQFa043755;
        Thu, 10 Nov 2022 16:53:27 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 10 Nov 2022 16:53:29 +0800 (CST)
Date:   Thu, 10 Nov 2022 16:53:29 +0800 (CST)
X-Zmail-TransId: 2afa636cbc09ffffffffb2faccdb
X-Mailer: Zmail v1.0
Message-ID: <202211101653295187226@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <mturquette@baylibre.com>
Cc:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chi.minghao@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBkbWFlbmdpbmU6IHVzZSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AA8rQFa043755
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 636CBC2D.001 by FangMail milter!
X-FangMail-Envelope: 1668070446/4N7Fxp1jXkz1DyZ/636CBC2D.001/10.35.20.121/[10.35.20.121]/mxde.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636CBC2D.001/4N7Fxp1jXkz1DyZ
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
 drivers/dma/bcm2835-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 630dfbb01a40..1547f528a58e 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -902,8 +902,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)

 	dma_set_max_seg_size(&pdev->dev, 0x3FFFFFFF);

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);

-- 
2.25.1
