Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039DE60552B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiJTBsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiJTBsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:48:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500F41D2B58;
        Wed, 19 Oct 2022 18:48:05 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mt9NX6S1yzVhkK;
        Thu, 20 Oct 2022 09:43:24 +0800 (CST)
Received: from ubuntu1604.huawei.com (10.67.174.160) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 09:48:02 +0800
From:   Xiang Yang <xiangyang3@huawei.com>
To:     <mika.westerberg@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] gpiolib: acpi: Use METHOD_NAME__AEI macro for acpi_walk_resources
Date:   Thu, 20 Oct 2022 09:44:26 +0800
Message-ID: <20221020014426.188667-1-xiangyang3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.160]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the METHOD_NAME__AEI macro instead of using "_AEI" directly.

Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
---
 drivers/gpio/gpiolib-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index a7d2358736fe..064ba5150fd4 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -512,7 +512,7 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip *chip)
 	if (ACPI_FAILURE(status))
 		return;
 
-	acpi_walk_resources(handle, "_AEI",
+	acpi_walk_resources(handle, METHOD_NAME__AEI,
 			    acpi_gpiochip_alloc_event, acpi_gpio);
 
 	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
-- 
2.22.0

