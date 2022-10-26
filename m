Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B260D9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbiJZDez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiJZDeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:34:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADAA2A439;
        Tue, 25 Oct 2022 20:34:40 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MxvYt19xKzHvDf;
        Wed, 26 Oct 2022 11:34:26 +0800 (CST)
Received: from localhost (10.175.101.6) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 11:34:38 +0800
From:   Weilong Chen <chenweilong@huawei.com>
To:     <chenweilong@huawei.com>, <f.fangjian@huawei.com>,
        <linus.walleij@linaro.org>, <yangyicong@hisilicon.com>,
        <xuwei5@huawei.com>, <robh+dt@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH next 2/2] dt-bindings: gpio: add entry for hisilicon,gpio-ascend910
Date:   Wed, 26 Oct 2022 11:42:19 +0800
Message-ID: <20221026034219.172880-2-chenweilong@huawei.com>
X-Mailer: git-send-email 2.31.GIT
In-Reply-To: <20221026034219.172880-1-chenweilong@huawei.com>
References: <20221026034219.172880-1-chenweilong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new compatible for HiSilicon gpio controller driver.

Signed-off-by: Weilong Chen <chenweilong@huawei.com>
---
 .../gpio/hisilicon,gpio-ascend910.yaml        | 54 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/hisilicon,gpio-ascend910.yaml

diff --git a/Documentation/devicetree/bindings/gpio/hisilicon,gpio-ascend910.yaml b/Documentation/devicetree/bindings/gpio/hisilicon,gpio-ascend910.yaml
new file mode 100644
index 000000000000..912e4b808cae
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/hisilicon,gpio-ascend910.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/hisilicon,gpio-ascend910.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon common GPIO controller Device Tree Bindings
+
+maintainers:
+  - Jay Fang <f.fangjian@huawei.com>
+
+properties:
+  compatible:
+    const: hisilicon,gpio-ascend910
+    description:
+      The HiSilicon common GPIO controller can be used for many different
+      types of SoC such as Huawei Ascend AI series chips.
+
+  reg:
+    description:
+      Address and length of the register set for the device.
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
+  - reg
+  - interrupts
+  - ngpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    gpio@840d0000 {
+      compatible = "hisilicon,gpio-ascend910";
+      reg = <0x840d0000 0x1000>;
+      ngpios = <0x20>;
+      gpio-controller;
+      #gpio-cells = <2>;
+      interrupts = <0x0 33 0x4>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 746becb5fe92..0ec86558cdce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9212,6 +9212,7 @@ HISILICON GPIO DRIVER
 M:	Jay Fang <f.fangjian@huawei.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/hisilicon,gpio-ascend910.yaml
 F:	drivers/gpio/gpio-hisi.c
 
 HISILICON HIGH PERFORMANCE RSA ENGINE DRIVER (HPRE)
-- 
2.31.GIT

