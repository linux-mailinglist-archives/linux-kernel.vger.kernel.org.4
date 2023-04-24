Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB72A6DD06F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjDKDkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjDKDjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:39:52 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68DD1213D;
        Mon, 10 Apr 2023 20:39:51 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 781E9E0EB3;
        Tue, 11 Apr 2023 06:39:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=TSFsJp4bX10BSILZK9L2OF55Miu/NunLzJLcFBycd5A=; b=Zc/hI5vepwu/
        p3l+UtSHaLz+L6wCNPKixB+blIBROkAaykS21IltHbaB3j9fgHif493B5/YEYn5X
        YVpAhjtfySCXNtl6PlpdkQAO2zrQ3qiMeHjRxoa7Q+9xRQ2yRfT3UrfwygPUDdyL
        KOSSqUnTjWopb8Ama6iy/lWg761FyII=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 59001E0E6A;
        Tue, 11 Apr 2023 06:39:50 +0300 (MSK)
Received: from localhost (10.8.30.38) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Tue, 11 Apr 2023 06:39:50 +0300
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
Subject: [PATCH RESEND v3 08/10] MAINTAINERS: Add all generic DW PCIe RP/EP DT-schemas
Date:   Tue, 11 Apr 2023 06:39:26 +0300
Message-ID: <20230411033928.30397-9-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.38]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently the DT-schema of the DW PCIe Root Port and End-point controllers
has been refactored by detaching the common bindings into a separate
schema. The provided modification must be reflected in the MAINTAINERS
list so the patch submitters would be aware of the new files maintainers.
Let's do that by adding the maintained files wildcard pattern like
snps,dw-pcie*.yaml, which is applicable for all the old DW PCIe DT-schema
files and the new one.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec57c42ed544..489fd4b4c7ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16063,8 +16063,7 @@ M:	Jingoo Han <jingoohan1@gmail.com>
 M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
-F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+F:	Documentation/devicetree/bindings/pci/snps,dw-pcie*.yaml
 F:	drivers/pci/controller/dwc/*designware*
 
 PCI DRIVER FOR TI DRA7XX/J721E
-- 
2.40.0


