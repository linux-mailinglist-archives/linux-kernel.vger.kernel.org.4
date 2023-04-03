Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12206D49E7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjDCOmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjDCOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:42:05 -0400
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E8D3503B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:42:01 -0700 (PDT)
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 196782F83101
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:41:59 +0200 (CEST)
Received: from s980.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id 074F72E28FEB;
        Mon,  3 Apr 2023 16:41:59 +0200 (CEST)
Received: from s898.loopia.se (unknown [172.22.191.6])
        by s980.loopia.se (Postfix) with ESMTP id 015182201610;
        Mon,  3 Apr 2023 16:41:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
Received: from s979.loopia.se ([172.22.191.5])
        by s898.loopia.se (s898.loopia.se [172.22.190.17]) (amavisd-new, port 10024)
        with LMTP id 3GRwtH2je2cH; Mon,  3 Apr 2023 16:41:58 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: richard@bit42.se
X-Loopia-Originating-IP: 178.174.130.84
Received: from hypercube.. (h-178-174-130-84.A444.priv.bahnhof.se [178.174.130.84])
        (Authenticated sender: richard@bit42.se)
        by s979.loopia.se (Postfix) with ESMTPSA id 5A1FA10BC43C;
        Mon,  3 Apr 2023 16:41:58 +0200 (CEST)
From:   Richard Alpe <richard@bit42.se>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        niklas.soderlund+renesas@ragnatech.se,
        Richard Alpe <richard@bit42.se>
Subject: [PATCH v4 1/2] dt-bindings: nvmem: Add t1023-sfp efuse support
Date:   Mon,  3 Apr 2023 16:41:05 +0200
Message-Id: <20230403144106.2776249-1-richard@bit42.se>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; h=from:subject; bh=VzTo89ujuhNY+3NfqTRMrVKqY+EPqSGrK3IAKfyJCKA=; b=owEBbQKS/ZANAwAKAaR4ncy5pstaAcsmYgBkKuWAJECsxgXKF7/I8heASdUYkp7ho+i4ldM73iGu Y6FIbPuJAjMEAAEKAB0WIQQsEvAKF4GLpV03omKkeJ3MuabLWgUCZCrlgAAKCRCkeJ3MuabLWuu3EA DEoJCYcGuD0sBMqML69jDHBrQ7I3v+1kP4zhlvjHaOkkwfPz0tsThJ15ijQt1+MrqbvyciQ/gstOhx D8B9eSu8MrVitYlVOyRvU7RZhTNBq9mldHMXH62pSBIL8HpMF1eUEJLRL/1bOrV/gDTLhHHLH+AvAa wKwKBhOzs7uOE+y5JJs3tx7ZxfiwvtcL8872+DZxV0Bp3UVaSmGT5+5qw3SBZYZrB9PWHrg+go0Ki0 n3ahF2DIuU9rF/ysnbsJmwhsPnue+fQSUBI/gcEdaTMY2aLbAqeh0oqei2q7Q7kQznKLycUxdSBHPo ot0EJ4SvoN+/0JkWvWjxbOLuimvErgq+gsDWWZN4S4IM1lJKpyLiIxvFEPqRHYDhvj+shaaPAxiLm6 VJQLY6T3rhtb78J5EYg+7Qrlrp8MENQb/hj/a5lXzAG+DjJ8u7QCWtc5fKijS32ae51T0QU8H2D9t7 XdgJvPyedcKoArE4mX2KyVIdgUttOAWvoTw77V566bi+b1T9EVamL0tPwF/PWepr4r8amyOJ1D3bpv GOsn0Nhsn/PcjJSTCWM9PzC6Q95o+YR78fwUX22nxSWD0Ocy7ljy8/nYIEYN7BiZV2A/GcHLNL8fDS RApX2srpYUD3xNiFiNTFysouVXxcjylSyG8XDNC432nKOdSKbNrjoT/n7JXw==
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
v3: Updates according to feedback from Krzysztof.

 .../bindings/nvmem/fsl,t1023-sfp.yaml         | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
new file mode 100644
index 000000000000..a9d249d4dbba
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/fsl,t1023.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP QorIQ eFuse support
+
+maintainers:
+  - Richard Alpe <richard@bit42.se>
+
+description:
+  Read support for the eFuses (SFP) on NXP QorIQ series SoC's.
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    const: fsl,t1023-sfp
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

