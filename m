Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696B76789EC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjAWVty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjAWVts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:49:48 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8BB32E51;
        Mon, 23 Jan 2023 13:49:47 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30NLnSo2081736;
        Mon, 23 Jan 2023 15:49:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674510568;
        bh=5OR+v9xgp/vw0nyDYRGvJLlaXtj5nY3tNjjtcvVN6HA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kVjdZ+PRlKca1dkMBCcXKYW07AZpmqVYaOqE8nbdcifxAedtzHQKVv7o9CbqiGP8n
         NnDtDeiX3wrrZMqZBEZDfzDm/i4lmoJq+BNwXljQsMNfUtAtVujv4GwZNgbyXSVRa+
         ppyBIS2nAbKbeamcuUGdvlRLxztEAztd4NOYn1aw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30NLnS0M009180
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jan 2023 15:49:28 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 23
 Jan 2023 15:49:27 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 23 Jan 2023 15:49:27 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30NLnPZl065237;
        Mon, 23 Jan 2023 15:49:26 -0600
From:   Andrew Davis <afd@ti.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v5 1/9] dt-bindings: mfd: Add TI-Nspire misc registers
Date:   Mon, 23 Jan 2023 15:49:16 -0600
Message-ID: <20230123214924.27476-2-afd@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230123214924.27476-1-afd@ti.com>
References: <20230123214924.27476-1-afd@ti.com>
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

The TI Nspire devices contain a set of registers with a seemingly
miscellaneous set of functionality. This area is known simply as the
"misc" region.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../bindings/mfd/ti,nspire-misc.yaml          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml b/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
new file mode 100644
index 000000000000..316c4b3dcd87
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,nspire-misc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI Nspire MISC hardware block
+
+maintainers:
+  - Andrew Davis <afd@ti.com>
+
+description: |
+  System controller node represents a register region containing a set
+  of miscellaneous registers. The registers are not cohesive enough to
+  represent as any specific type of device. Currently there is a reset
+  controller.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ti,nspire-misc
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  reboot:
+    $ref: "../power/reset/syscon-reboot.yaml"
+
+required:
+  - compatible
+  - reg
+  - reboot
+
+additionalProperties: false
+
+examples:
+  - |
+    misc: misc@900a0000 {
+      compatible = "ti,nspire-misc", "syscon", "simple-mfd";
+      reg = <0x900a0000 0x1000>;
+
+      reboot {
+        compatible = "syscon-reboot";
+        offset = <0x08>;
+        value = <0x02>;
+      };
+    };
-- 
2.38.1

