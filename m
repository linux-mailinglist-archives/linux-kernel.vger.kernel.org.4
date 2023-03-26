Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B4C6C9449
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjCZMgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCZMgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:36:33 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Mar 2023 05:36:31 PDT
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69A976BD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:36:31 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 25648 invoked from network); 26 Mar 2023 14:29:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1679833786; bh=D8zDe47wM+oZAKrDRTfNyDqW3Tn+VphA2yyNh9Q+aSI=;
          h=From:To:Subject;
          b=OpViCiiBXRb1FXhObLrvmRfDui6uBaiq5Qm2u1zWAGLASuJZYMaB0mTJDOH9Bc43f
           Jai5yjWDD6LtVaxTyIbzW5I7zaNI+IuItOiq739Y+nk3GDwC3jFFS9SjHoov1erEtm
           om/XPX1ht3DSZ8Iu0BkiR5RfNf2d2PREwQiYh8us=
Received: from 79.184.247.17.ipv4.supernova.orange.pl (HELO LAPTOP-OLEK.home) (olek2@wp.pl@[79.184.247.17])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <tsbogend@alpha.franken.de>; 26 Mar 2023 14:29:46 +0200
From:   Aleksander Jan Bajkowski <olek2@wp.pl>
To:     tsbogend@alpha.franken.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, olek2@wp.pl,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mips: lantiq: Document Lantiq SoC dt bindings
Date:   Sun, 26 Mar 2023 14:29:42 +0200
Message-Id: <20230326122942.870990-1-olek2@wp.pl>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 63da01927b132ccbf3a9b870b64d5ead
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [EUN0]                               
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the legacy Lantiq device tree bindings.
Compatible strings for xRX100 (ar9) and newer SoCs
should be renamed and will be added later.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 .../devicetree/bindings/mips/lantiq/soc.yaml  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/soc.yaml

diff --git a/Documentation/devicetree/bindings/mips/lantiq/soc.yaml b/Documentation/devicetree/bindings/mips/lantiq/soc.yaml
new file mode 100644
index 000000000000..90e8148b111b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/lantiq/soc.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mips/lantiq/soc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lantiq SoC based Platform
+
+maintainers:
+  - Aleksander Jan Bajkowski <olek2@wp.pl>
+
+description:
+  Devices with a Lantiq CPU shall have the following properties.
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+      - description: Boards with Lantiq Amazon-SE SoC
+        items:
+          - const: lantiq,ase
+
+      - description: Boards with Lantiq Danube SoC
+        items:
+          - const: lantiq,danube
+
+      - description: Boards with Lantiq Falcon SoC
+        items:
+          - const: lantiq,falcon
+
+      - description: Boards with Lantiq Twinpass SoC
+        items:
+          - const: lantiq,twinpass
+
+additionalProperties: true
+
+...
-- 
2.30.2

