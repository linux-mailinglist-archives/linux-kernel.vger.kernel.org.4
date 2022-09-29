Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A645F16CC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiI3Xo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiI3XoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:44:17 -0400
X-Greylist: delayed 88199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Sep 2022 16:44:12 PDT
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EEF8157FD1;
        Fri, 30 Sep 2022 16:44:11 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 028D6E0EBD;
        Fri, 30 Sep 2022 01:54:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=ZdjgTOaIl8+CYayXTtVo5NrVjc8YBMSotFVNB5jURGc=; b=O8A+TU7/pfry
        ftzsrb0mtAIWLqLzj51mFGV1YTUc7sHG4T4N1fiQVCIFYCsXZDdA+G/0vQ2/mnP1
        gYQi4YAcjQmm3z8ie1iVP94pe+JXYDklD/T65nK0IcXjVSGHlBw3hHHOZ3KnIGb9
        A6bvg5HQMXgBjN2ESqAWjANIuglZ2tU=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id E8873E0EBB;
        Fri, 30 Sep 2022 01:54:13 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 01:54:14 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-clk@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH RESEND v12 6/8] dt-bindings: clk: baikal-t1: Add DDR/PCIe reset IDs
Date:   Fri, 30 Sep 2022 01:54:00 +0300
Message-ID: <20220929225402.9696-7-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929225402.9696-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929225402.9696-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aside with a set of the trigger-like resets Baikal-T1 CCU provides
additional directly controlled reset signals for the DDR and PCIe
controllers. As a preparation before adding these resets support to the
kernel let's extent the Baikal-T1 CCU IDs list with the new IDs, which
will be used to access the corresponding reset controls.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>

---

Changelog v11:
- This is a new patch created by detaching the DT-part from:
[PATCH v10 6/7] clk: baikal-t1: Add DDR/PCIe directly controlled resets support
  (@Krzysztof)
---
 include/dt-bindings/reset/bt1-ccu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/dt-bindings/reset/bt1-ccu.h b/include/dt-bindings/reset/bt1-ccu.h
index 3578e83026bc..c691efaa678f 100644
--- a/include/dt-bindings/reset/bt1-ccu.h
+++ b/include/dt-bindings/reset/bt1-ccu.h
@@ -21,5 +21,14 @@
 
 #define CCU_SYS_SATA_REF_RST		0
 #define CCU_SYS_APB_RST			1
+#define CCU_SYS_DDR_FULL_RST		2
+#define CCU_SYS_DDR_INIT_RST		3
+#define CCU_SYS_PCIE_PCS_PHY_RST	4
+#define CCU_SYS_PCIE_PIPE0_RST		5
+#define CCU_SYS_PCIE_CORE_RST		6
+#define CCU_SYS_PCIE_PWR_RST		7
+#define CCU_SYS_PCIE_STICKY_RST		8
+#define CCU_SYS_PCIE_NSTICKY_RST	9
+#define CCU_SYS_PCIE_HOT_RST		10
 
 #endif /* __DT_BINDINGS_RESET_BT1_CCU_H */
-- 
2.37.3


