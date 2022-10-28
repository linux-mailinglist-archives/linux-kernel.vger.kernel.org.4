Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEB26107D5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbiJ1CRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiJ1CRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:17:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C73B8C3D;
        Thu, 27 Oct 2022 19:17:19 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mz5gy25QqzpW3p;
        Fri, 28 Oct 2022 10:13:50 +0800 (CST)
Received: from localhost (10.175.101.6) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 10:17:17 +0800
From:   Weilong Chen <chenweilong@huawei.com>
To:     <chenweilong@huawei.com>, <f.fangjian@huawei.com>,
        <linus.walleij@linaro.org>, <yangyicong@hisilicon.com>,
        <xuwei5@huawei.com>, <robh+dt@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH next v2 2/2] dt-bindings: gpio: add entry for hisilicon,ascend910-gpio
Date:   Fri, 28 Oct 2022 10:24:53 +0800
Message-ID: <20221028022453.163186-2-chenweilong@huawei.com>
X-Mailer: git-send-email 2.31.GIT
In-Reply-To: <20221028022453.163186-1-chenweilong@huawei.com>
References: <20221028022453.163186-1-chenweilong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new compatible for HiSilicon gpio controller driver.

Signed-off-by: Weilong Chen <chenweilong@huawei.com>
---
Change since v1:
- Drop "Device Tree Bindings" and reg's description
- Move description in top-level description.
- Add gpio-cells to required
- Use additionalProperties and decimal numbers
- Use IRQ flags
- Use vendor,soc-ipblock format
Link: https://lore.kernel.org/lkml/30b95e7b-b902-babc-ea78-a2112c80ec7e@linaro.org/t/#m298c22f175ee09b101d6baca2a959bdd0f90b2c0

 .../gpio/hisilicon,ascend910-gpio.yaml        | 56 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml b/Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml
new file mode 100644
index 000000000000..8868838bde3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/hisilicon,ascend910-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon common GPIO controller
+
+maintainers:
+  - Jay Fang <f.fangjian@huawei.com>
+
+description: |
+  The HiSilicon common GPIO controller can be used for many different
+  types of SoC such as Huawei Ascend AI series chips.
+
+properties:
+  compatible:
+    const: hisilicon,ascend910-gpio
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  ngpios:
+    minimum: 1
+    maximum: 32
+
+required:
+  - compatible
+  - gpio-controller
+  - '#gpio-cells'
+  - interrupts
+  - ngpios
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpio@840d0000 {
+      compatible = "hisilicon,ascend910-gpio";
+      reg = <0x840d0000 0x1000>;
+      ngpios = <32>;
+      gpio-controller;
+      #gpio-cells = <2>;
+      interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 746becb5fe92..e29aad776ec1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9212,6 +9212,7 @@ HISILICON GPIO DRIVER
 M:	Jay Fang <f.fangjian@huawei.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml
 F:	drivers/gpio/gpio-hisi.c
 
 HISILICON HIGH PERFORMANCE RSA ENGINE DRIVER (HPRE)
-- 
2.31.GIT

