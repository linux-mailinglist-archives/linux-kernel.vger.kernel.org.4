Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D767C6CB960
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjC1I2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjC1I2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:28:00 -0400
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A2BA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:27:55 -0700 (PDT)
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 3E5F92F785BA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:27:51 +0200 (CEST)
Received: from s934.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id 2ED462E28203;
        Tue, 28 Mar 2023 10:27:51 +0200 (CEST)
Received: from s475.loopia.se (unknown [172.22.191.5])
        by s934.loopia.se (Postfix) with ESMTP id 2A9267CEA49;
        Tue, 28 Mar 2023 10:27:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
Received: from s980.loopia.se ([172.22.191.6])
        by s475.loopia.se (s475.loopia.se [172.22.190.15]) (amavisd-new, port 10024)
        with LMTP id Ud5Qu7CToYgz; Tue, 28 Mar 2023 10:27:50 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: richard@bit42.se
X-Loopia-Originating-IP: 178.174.130.84
Received: from hypercube.. (h-178-174-130-84.A444.priv.bahnhof.se [178.174.130.84])
        (Authenticated sender: richard@bit42.se)
        by s980.loopia.se (Postfix) with ESMTPSA id 83030220160B;
        Tue, 28 Mar 2023 10:27:50 +0200 (CEST)
From:   Richard Alpe <richard@bit42.se>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        niklas.soderlund+renesas@ragnatech.se,
        Richard Alpe <richard@bit42.se>
Subject: [PATCH v3 1/2] dt-bindings: nvmem: Add nxp,qoriq-efuse
Date:   Tue, 28 Mar 2023 10:27:00 +0200
Message-Id: <20230328082701.2569114-1-richard@bit42.se>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; h=from:subject; bh=4/OqOS1KaTkvhLfKWyJykZRZBAxFTPbtj56M/6PFhPA=; b=owEBbQKS/ZANAwAKAaR4ncy5pstaAcsmYgBkIqTUkq2VqvtooDwr6B+Dbt9eJeHxDw6k9weHRdZ1 bY1XLgSJAjMEAAEKAB0WIQQsEvAKF4GLpV03omKkeJ3MuabLWgUCZCKk1AAKCRCkeJ3MuabLWjsgD/ wLp9tsE3HrMzxaJpY3TJFQMjrbQesIz+wgaSLPs313c5tq2FiQv9kGUyKDqdKJCvdffNoJu6U9U9IX HyRzQnmd2piC+xHuXDtCOFQReoVsAcLaS4FdNEPEJknVv+PXfJaX0vON1qtsXgHrHXxzzNXjy4NH41 du2Mh3FmEETNJTDLjoO+R/GTORVG0flWkeTsf4xNvqx9YWFNPkEFE4sQC6+yDAFE9PKftJ6FVtf04D OYZVx/w471iVxlf/4F4t8CsJv46AY0oXajXE3KW2nSJ6oe3VXM5ATYLmnVEHQtdxhR4ahwY307JPXv rZmnasi1wFuPk15fw6Cu/OzPtUwl42YBqnCyVVFHxwFmqbDI5m2mzKqIztu8WdQ/qQnPIRuQ6tQhfV OODj3MZX3y4obIgPTa/WruupxKr0WPwT6MmxKlVxzMr8m46FUU5a5lwS/blItdD1mn6712qO+I08GO iZBfg+2j4TKSWT6yfTHeHVQJiSz4TuRflmG6NTV+ZOuuz/CEAZS6bDW95eh7sY4mEoWHpKN3OeAbnv Me9bzxAP6R7N0gX9oWNnb35aCcNnujOECgyUQ9HkoQzPZe9BLc7fu5sddAiI6vOa6nMRa6qM0Ji7jr 531jvAO78PEIYkTYd+njoxJ7aPA8vl90M3+12PrzJwBH+AJ9eh/ZCOR4aoIw==
X-Developer-Key: i=richard@bit42.se; a=openpgp; fpr=B1C705C6B1BF719CA5CD67398BEE8379084BC511
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a schema for the NVMEM eFuse (SFP) layout on the NXP QorIQ SOC.

Signed-off-by: Richard Alpe <richard@bit42.se>
---
 .../bindings/nvmem/nxp,qoriq-efuse.yaml       | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,qoriq-efuse.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/nxp,qoriq-efuse.yaml b/Documentation/devicetree/bindings/nvmem/nxp,qoriq-efuse.yaml
new file mode 100644
index 000000000000..e1d4d3849519
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nxp,qoriq-efuse.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/nxp,qoriq-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP QorIQ eFuse support
+
+maintainers:
+  - Richard Alpe <richard@bit42.se>
+
+description: |
+  Read support for the eFuses (SFP) on NXP QorIQ series SoC's.
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - description: Trust architecture 2.0
+        items:
+          - const: fsl,t1023-sfp
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse@e8000 {
+        compatible = "fsl,t1023-sfp";
+        reg = <0xe8000 0x1000>;
+    };
+...
-- 
2.34.1

