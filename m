Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98ED61314B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 08:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJaHi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 03:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJaHiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 03:38:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B67318;
        Mon, 31 Oct 2022 00:38:20 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29V7c80t028735;
        Mon, 31 Oct 2022 02:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667201888;
        bh=6VGBZK1/abbKCoIRqKSg9pZn/4RHvekCMTImExxCej0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wvAyScsfZ/cG0m1varE2EES0vVsLQURyrqVeToMno1NzSuq9a7Q1H/6nYP2u+jXJx
         UdBOMcXQDFWQlAdFOmhdrm8kPiTj40ZtSk+5WQmwa7NTP2TYBeCaEmc9j391D5yNY6
         K4Vbd1ohdW117pygmb4qMj20NiPwUADnXhfOGp38=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29V7c84h000603
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 02:38:08 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 02:38:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 02:38:07 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29V7c7PW016140;
        Mon, 31 Oct 2022 02:38:07 -0500
Received: from localhost (a0501179-pc.dhcp.ti.com [10.24.69.114])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 29V7c6WE012810;
        Mon, 31 Oct 2022 02:38:07 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <srk@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v7 1/5] dt-bindings: remoteproc: Add PRU consumer bindings
Date:   Mon, 31 Oct 2022 13:07:57 +0530
Message-ID: <20221031073801.130541-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031073801.130541-1-danishanwar@ti.com>
References: <20221031073801.130541-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Add DT schema binding for PRU consumers. The binding includes
all the common properties that can be used by different PRU consumer
or application nodes and supported by the PRU remoteproc driver.
These are used to configure the PRU hardware for specific user
applications.

The application nodes themselves should define their own bindings.

Co-developed-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../bindings/remoteproc/ti,pru-consumer.yaml  | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
new file mode 100644
index 000000000000..c6d86964b72a
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/ti,pru-consumer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common TI PRU Consumer Binding
+
+maintainers:
+  - Suman Anna <s-anna@ti.com>
+
+description: |
+  A PRU application/consumer/user node typically uses one or more PRU device
+  nodes to implement a PRU application/functionality. Each application/client
+  node would need a reference to at least a PRU node, and optionally define
+  some properties needed for hardware/firmware configuration. The below
+  properties are a list of common properties supported by the PRU remoteproc
+  infrastructure.
+
+  The application nodes shall define their own bindings like regular platform
+  devices, so below are in addition to each node's bindings.
+
+properties:
+  ti,prus:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: phandles to the PRU, RTU or Tx_PRU nodes used
+    minItems: 1
+    maxItems: 6
+    items:
+      maxItems: 1
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    minItems: 1
+    maxItems: 6
+    description: |
+      firmwares for the PRU cores, the default firmware for the core from
+      the PRU node will be used if not provided. The firmware names should
+      correspond to the PRU cores listed in the 'ti,prus' property
+
+  ti,pruss-gp-mux-sel:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 6
+    items:
+      enum: [0, 1, 2, 3, 4]
+    description: |
+      array of values for the GP_MUX_SEL under PRUSS_GPCFG register for a PRU.
+      This selects the internal muxing scheme for the PRU instance. Values
+      should correspond to the PRU cores listed in the 'ti,prus' property. The
+      GP_MUX_SEL setting is a per-slice setting (one setting for PRU0, RTU0,
+      and Tx_PRU0 on K3 SoCs). Use the same value for all cores within the
+      same slice in the associative array. If the array size is smaller than
+      the size of 'ti,prus' property, the default out-of-reset value (0) for the
+      PRU core is used.
+
+required:
+  - ti,prus
+
+additionalProperties: true
-- 
2.25.1

