Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DB56E1A42
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDNCTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjDNCT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:19:28 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D37DB49E6;
        Thu, 13 Apr 2023 19:19:16 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 1EBEAE0EB5;
        Fri, 14 Apr 2023 05:19:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=5Rh2sx1MJXE8Q4Wee55Q6UNoIg28VkidcUndZ8wnSpo=; b=agVjiw+LQc+/
        4weTrpxKAZ9WxfNE7oO6kT0WQgpF7E5AVkC4ucp+Su2BNHAj9Tp0LH7E1kXqYDFJ
        lbQsy42XCdfg88JCIVkgA3NMn6E0ON+KqOq806cSO5beLnQ/ulJG9qQd3csCi6qM
        /p2bmRKsS4PbMMvZ12BTPJlqknWz5yk=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id F1B19E0E1D;
        Fri, 14 Apr 2023 05:19:04 +0300 (MSK)
Received: from localhost (10.8.30.14) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Apr 2023 05:19:04 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 10/14] MAINTAINERS: Add Manivannan to DW PCIe core maintainers list
Date:   Fri, 14 Apr 2023 05:18:28 +0300
Message-ID: <20230414021832.13167-11-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414021832.13167-1-Sergey.Semin@baikalelectronics.ru>
References: <20230414021832.13167-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.14]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manivannan has been very active in reviewing and testing the bits coming
to the DW PCIe RP/EP core driver. Let's add him to the driver maintainers
list.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c53424fdecc2..55f38818f783 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16060,6 +16060,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
 
 PCI DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 R:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-- 
2.40.0


