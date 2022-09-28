Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EA75EE64F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiI1UAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiI1UAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:00:15 -0400
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Sep 2022 12:59:30 PDT
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28078218;
        Wed, 28 Sep 2022 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664395171; x=1695931171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NLGN8Q6mrtAe+VsUYecER/Bp3qKDihlyPHUb7UXcy2E=;
  b=sMVKqJA3yN5gqeaHDzBhPxrjQRfUNs9M2ZqhsVfwupCEPerifZDEJBgx
   +nPSVPTyDFVHlQiVa3aLGUwLfVMAJv14em6y3Cjqm7sddhx7MMx58q8R2
   68/BPpEaNVI/V2+6dmhym+vOAyJB6xsp6KAx6E0OJWCDzD+W+r/VzAG0m
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Sep 2022 12:57:27 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 12:57:25 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 12:57:24 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 02/14] dt-bindings: Add binding for gunyah hypervisor
Date:   Wed, 28 Sep 2022 12:56:21 -0700
Message-ID: <20220928195633.2348848-3-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928195633.2348848-1-quic_eberman@quicinc.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Linux is booted as a guest under the Gunyah hypervisor, the Gunyah
Resource Manager applies a devicetree overlay describing the virtual
platform configuration of the guest VM, such as the message queue
capability IDs for communicating with the Resource Manager. This
information is not otherwise discoverable by a VM: the Gunyah hypervisor
core does not provide a direct interface to discover capability IDs nor
a way to communicate with RM without having already known the
corresponding message queue capability ID. Add the DT bindings that
Gunyah adheres for the hypervisor node and message queues.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 .../bindings/firmware/gunyah-hypervisor.yaml  | 87 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml

diff --git a/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
new file mode 100644
index 000000000000..f0a14101e2fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/gunyah-hypervisor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Gunyah Hypervisor
+
+maintainers:
+  - Murali Nalajala <quic_mnalajal@quicinc.com>
+  - Elliot Berman <quic_eberman@quicinc.com>
+
+description: |+
+  On systems which support devicetree, Gunyah generates and overlays a deviceetree overlay which
+  describes the basic configuration of the hypervisor. Virtual machines use this information to determine
+  the capability IDs of the message queues used to communicate with the Gunyah Resource Manager.
+  See also: https://github.com/quic/gunyah-resource-manager/blob/develop/src/vm_creation/dto_construct.c
+
+properties:
+  compatible:
+    items:
+      - const: gunyah-hypervisor-1.0
+      - const: gunyah-hypervisor
+
+  "#address-cells":
+    description: Number of cells needed to represent 64-bit capability IDs.
+    const: 2
+
+  "#size-cells":
+    description: must be 0, because capability IDs are not memory address
+                  ranges and do not have a size.
+    const: 0
+
+patternProperties:
+  "^gunyah-resource-mgr(@.*)?":
+    type: object
+    description:
+      Resource Manager node which is required to communicate to Resource
+      Manager VM using Gunyah Message Queues.
+
+    properties:
+      compatible:
+        items:
+          - const: gunyah-resource-manager-1-0
+          - const: gunyah-resource-manager
+
+      reg:
+        items:
+          - description: Gunyah capability ID of the TX message queue
+          - description: Gunyah capability ID of the RX message queue
+
+      interrupts:
+        items:
+          - description: Interrupt for the TX message queue
+          - description: Interrupt for the RX message queue
+
+    additionalProperties: false
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+
+additionalProperties: false
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    hypervisor {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        compatible = "gunyah-hypervisor-1.0", "gunyah-hypervisor";
+
+        gunyah-resource-mgr@0 {
+            compatible = "gunyah-resource-manager-1-0", "gunyah-resource-manager";
+            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX full IRQ */
+                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX empty IRQ */
+            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
+                  /* TX, RX cap ids */
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e88ebb7cbcb8..5b6b6f25c604 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8885,6 +8885,7 @@ M:	Elliot Berman <quic_eberman@quicinc.com>
 M:	Murali Nalajala <quic_mnalajal@quicinc.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
 F:	Documentation/virt/gunyah/
 
 HABANALABS PCI DRIVER
-- 
2.25.1

