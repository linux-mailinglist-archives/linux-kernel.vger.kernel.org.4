Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A5D6523ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiLTPsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLTPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:48:13 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7505064E8;
        Tue, 20 Dec 2022 07:48:10 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2882A1A193E;
        Tue, 20 Dec 2022 16:48:09 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BD99A1A067E;
        Tue, 20 Dec 2022 16:48:08 +0100 (CET)
Received: from lsv03121.swis.in-blr01.nxp.com (lsv03121.swis.in-blr01.nxp.com [92.120.146.118])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 459C01820F77;
        Tue, 20 Dec 2022 23:48:07 +0800 (+08)
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk, robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        manjunatha.venkatesh@nxp.com, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com,
        Kwame Adwere <kwame.adwere@nxp.com>
Subject: [PATCH v6 1/2] dt-bindings: uwb: Device tree information for Nxp SR1XX SOCs
Date:   Tue, 20 Dec 2022 21:17:46 +0530
Message-Id: <20221220154747.2372597-2-manjunatha.venkatesh@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221220154747.2372597-1-manjunatha.venkatesh@nxp.com>
References: <20221220154747.2372597-1-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ultra-wideband (UWB) is a short-range wireless communication protocol.

NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
are FiRa Compliant. SR1XX SOCs are flash less devices and they need
Firmware Download on every device boot. More details on the SR1XX Family
can be found at https://www.nxp.com/products/:UWB-TRIMENSION

The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
Interface (UCI).  The corresponding details are available in the FiRa
Consortium Website (https://www.firaconsortium.org/).

Link: https://lore.kernel.org/r/425858dc-59fe-2311-61ae-3b6dc77a2576@nxp.com
Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Signed-off-by: Kwame Adwere <kwame.adwere@nxp.com>
---
Changes since v5:
  - Moved ioctl command definitions into header file.
  - Version 5 patch review comments addressed.
  - Corporate lawyer sign-off updated.

 .../bindings/uwb/nxp,uwb-sr1xx.yaml           | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml

diff --git a/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml b/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
new file mode 100644
index 000000000000..2a1caa661633
--- /dev/null
+++ b/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/uwb/nxp,uwb-sr1xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:  NXP SR1XX SOC family of Ultra Wide Band(UWB) device bindings
+
+description: The nxp-sr1xx driver works for the NXP SR1XX series of Ultra Wide
+    Band devices namely, SR150 and SR100T devices, and uses UWB Controller Interface (UCI).
+    The corresponding details are available in the FiRa Consortium Website.
+    (https://www.firaconsortium.org/). More details on the SR1XX Family can be
+    found at https://www.nxp.com/products/:UWB-TRIMENSION
+
+maintainers:
+  - Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,sr1xx
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 45000000
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    /* for Raspberry Pi with pin control stuff for GPIO irq */
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    fragment@1 {
+        target = <&spi0>;
+        spi {
+            /* needed to avoid dtc warning */
+            #address-cells = <1>;
+            #size-cells = <0>;
+            interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+            status = "enabled";
+
+            sr1xx: sr1xx@0 {
+                compatible = "nxp,sr1xx";
+                reg = <0>;    /* CE0 */
+                /* GPIO_24 (PIN 18) Host Irq*/
+                nxp,sr1xx-irq-gpios = <&gpio 24 0>;
+                /* GPIO_18(PIN 12) Chip Enable*/
+                nxp,sr1xx-ce-gpios = <&gpio 18 0>;
+                /* GPIO_23(PIN 16) Read Indication from Host to SR1xx*/
+                nxp,sr1xx-ri-gpios = <&gpio 23 0>;
+                /*max supported frequency */
+                spi-max-frequency = <20000000>;
+            };
+        };
+    };
-- 
2.38.1

