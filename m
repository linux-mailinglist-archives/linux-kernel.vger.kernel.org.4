Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D6F6DC43F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjDJIVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDJIVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:21:39 -0400
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C569E268D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:21:37 -0700 (PDT)
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 5D5842F22300
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:21:35 +0200 (CEST)
Received: from s981.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id 4DA9F2E27DE1;
        Mon, 10 Apr 2023 10:21:35 +0200 (CEST)
Received: from s473.loopia.se (unknown [172.22.191.5])
        by s981.loopia.se (Postfix) with ESMTP id 498EF22B1737;
        Mon, 10 Apr 2023 10:21:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
Received: from s899.loopia.se ([172.22.191.6])
        by s473.loopia.se (s473.loopia.se [172.22.190.13]) (amavisd-new, port 10024)
        with LMTP id VSv7fonlg6Ib; Mon, 10 Apr 2023 10:21:34 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: richard@bit42.se
X-Loopia-Originating-IP: 178.174.130.84
Received: from hypercube.. (h-178-174-130-84.A444.priv.bahnhof.se [178.174.130.84])
        (Authenticated sender: richard@bit42.se)
        by s899.loopia.se (Postfix) with ESMTPSA id B420F2C8BA8D;
        Mon, 10 Apr 2023 10:21:34 +0200 (CEST)
From:   Richard Alpe <richard@bit42.se>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        niklas.soderlund+renesas@ragnatech.se,
        Richard Alpe <richard@bit42.se>
Subject: [PATCH v5 1/2] dt-bindings: nvmem: Add t1023-sfp efuse support
Date:   Mon, 10 Apr 2023 10:20:50 +0200
Message-Id: <20230410082051.2948510-1-richard@bit42.se>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; h=from:subject; bh=Da9LvvCXvjVlfaRpHIIGqxKThdBgra/8TpKwUia8OdY=; b=owEBbQKS/ZANAwAKAaR4ncy5pstaAcsmYgBkM8bhhP+70eMiFG9Joa0W0tbe1OPbW1/u5r/5IURm fb2Ehq+JAjMEAAEKAB0WIQQsEvAKF4GLpV03omKkeJ3MuabLWgUCZDPG4QAKCRCkeJ3MuabLWpWBD/ 42N9SA4iPCRxC55Fki8jDeX5WthAo2Gj9qwhIjf7pU88Zc5x6x0e215+bEXF372x1K3501fByFbZQW L7ERQwachK4qwwgpXeyMYlV+muhIHSIzRmOonR9Z5ksKeJ6d0T0+1RxKZYFW7Y/2GdtlWvydcuTjgs Ccp0mmUSBJgljtHBlg3m5+F2UWMeiPblVOrreu7/7MwDdnFa6Y7L0vlYxQpJkHz88MX3dtqlk6XNHM w7sPHHb2vmTDU5uxUVK0lUuj3VnJqWqHdHib+28nkzskp2ObmrafAg6ZZRddT+bWT0rmbN/btJv2Fn cXapZD4PNiaZDAvySpTMCm1yRETDXBfByRVQMOwKB/F2TBp2QsIwSwlT795KnBiz1l3zVVpMKtLLhu rWju4hZZkMd9Czw1wNGLwzFhFgcb9JY+YINI7uV5wgCZ45+y/QQGevWAWMC2jCJvRERnVftFbo9+1Z ymQZ5WcqYAbLtOE87FMAcLwFbWUAnZRq/K38HQvJfC44qa63mtXy57H/COCmigsdXRjc26YGVbARx9 mhFAW748VtJP0zUJVLS+4yOx9aYKR/ufuC8NE1kSCem1fWaohqj1oatfct8qvmalRy/J0Svl7NzL1P v5lv3lzDa2mUJVONBY9kVNF7Y+NFaFOMeFnEb3a/GjooRN9UjH8NDLlycCog==
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
v3: Introduce this patch.
v4: Updates according to feedback from Krzysztof.
v5: Fix yamllint warning (file name $id matching).

 .../bindings/nvmem/fsl,t1023-sfp.yaml         | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
new file mode 100644
index 000000000000..df826b40d8ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/fsl,t1023-sfp.yaml#
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

