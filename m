Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA48A6944FF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBMMAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBMMAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:00:07 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DE518AAF;
        Mon, 13 Feb 2023 04:00:04 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31DBxvaI124227;
        Mon, 13 Feb 2023 05:59:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1676289597;
        bh=Ck7HKCzkxTJ+xWcXSAQH2Jrn57umtVcCN89jVyNIzq8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YTelJ6ZKU/cXiS/K+T7de6q/YzYda5uoPSoJ1FVAejwCZ2n2r7cDDAuk0b+GwWhOp
         RCCfSPRYj6NDOnERpAI7woUbivBJ1HcOUnvtYAVAth3sSPG5nhA2AUavVb6whrYuhB
         PJ0As/3we64iAdHFJEO4yuMr2sq6TgVMX3gCkc6Y=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31DBxv4T126096
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Feb 2023 05:59:57 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Feb 2023 05:59:56 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Feb 2023 05:59:56 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31DBxtJp056756;
        Mon, 13 Feb 2023 05:59:56 -0600
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tomi Valkeinen <tomba@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Linux Clock List <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: clock: Add binding documentation for TI AM62 DSS Clock
Date:   Mon, 13 Feb 2023 17:29:53 +0530
Message-ID: <20230213115954.553-2-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213115954.553-1-a-bhatia1@ti.com>
References: <20230213115954.553-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for DSS clock divider of TI's AM62 family of SoCs.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 .../clock/ti,am62-dss-vp0-div-clk.yaml        | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,am62-dss-vp0-div-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/ti,am62-dss-vp0-div-clk.yaml b/Documentation/devicetree/bindings/clock/ti,am62-dss-vp0-div-clk.yaml
new file mode 100644
index 000000000000..310d2a989d5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti,am62-dss-vp0-div-clk.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/ti,am62-dss-vp0-div-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI AM62 DSS - OLDI Divider Clock
+
+maintainers:
+  - Aradhya Bhatia <a-bhatia1@ti.com>
+
+properties:
+  compatible:
+    items:
+      - const: ti,am62-dss-vp0-div-clk
+
+  "#clock-cells":
+    const: 0
+
+  clocks:
+    maxItems: 1
+
+  clock-div:
+    description: Fixed divider
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+
+required:
+  - compatible
+  - clocks
+  - "#clock-cells"
+  - clock-div
+
+additionalProperties: false
+
+examples:
+  - |
+    clock {
+      compatible = "ti,am62-dss-vp0-div-clk";
+      clocks = <&parent_clock>;
+      #clock-cells = <0>;
+      clock-div = <7>;
+    };
+...
-- 
2.39.1

