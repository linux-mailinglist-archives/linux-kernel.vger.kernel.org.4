Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F334E6D8F10
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjDFGI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDFGIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:08:53 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7458C7ED6;
        Wed,  5 Apr 2023 23:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q1rNeif5SglXwNm5q9Xo+iYAlYdCJQhUEhbhkizzO3M=; b=RWFEyK5gSMfWrjS/dEpaxjljgr
        +ieanTeHqt8w7otVnaTWT7gn2n7mbvORdC9ojpR3POd9rONjYO0U/Dvv2FzcpEYUlvWRR09qJ3L5f
        vChwtZlIjLWLQLBuVxuHoYp30pChWgEZgtUTMBKF9sFsBm36rumBvEmiaAn7JUAHx5UIG61VczevX
        TF0DGYtWZA45+HUXJMkyD000hv5g91xqv5KhWt/fndb08Ydw5bRxRux00eSIkEU3RMsgSrRxQukCW
        rCTDpG+fC7yjSNottwVnd09RzmjY7fi33+aWTt0xnnSnElb/otM+rUFfQSL/y07XtkCRKZ8DPmufC
        6Nl5CWrg==;
Received: from p200300ccff190e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff19:e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pkInc-0001dk-U8; Thu, 06 Apr 2023 08:08:45 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1pkInc-000Qqe-22;
        Thu, 06 Apr 2023 08:08:44 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andreas@kemnade.info,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mazziesaccount@gmail.com,
        hns@goldelico.com
Subject: [PATCH 1/2] dt-bindings: leds: ROHM BD2606MVV LED driver
Date:   Thu,  6 Apr 2023 08:08:24 +0200
Message-Id: <20230406060825.103187-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406060825.103187-1-andreas@kemnade.info>
References: <20230406060825.103187-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document ROHM BD2606MVV LED driver devicetree bindings.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../bindings/leds/rohm,bd2606mvv.yaml         | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml

diff --git a/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml b/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
new file mode 100644
index 0000000000000..6d4ddd8d31162
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/rohm,bd2606mvv.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BD2606MVV LED controller
+
+maintainers:
+  - Andreas Kemnade <andreas@kemnade.info>
+
+description:
+  The BD2606 MVV is a programmable LED controller connected via I2C that can
+  drive 6 separate lines. Each of them can be individually switched on and off
+  but the brightness setting is shared between two of them.
+
+properties:
+  compatible:
+    const: rohm,bd2606mvv
+
+  reg:
+    description: I2C slave address of the controller.
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-6]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 6
+
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/leds/common.h>
+
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@66 {
+            compatible = "rohm,bd2606mvv";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0x66>;
+
+            led@0 {
+                color = <LED_COLOR_ID_RED>;
+                function = LED_FUNCTION_POWER;
+                reg = <0x0>;
+            };
+
+            led@2 {
+                color = <LED_COLOR_ID_WHITE>;
+                function = LED_FUNCTION_STATUS;
+                reg = <0x2>;
+            };
+        };
+    };
+
+...
-- 
2.39.2

