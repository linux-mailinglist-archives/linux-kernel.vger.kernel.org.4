Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEDB66609A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbjAKQez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbjAKQec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:34:32 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF56DE2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1673454852; x=1676046852;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=C4kvWi4nYSn0kSIK0WvaQkfls0F7UuJxhBfke5JCvQE=;
        b=GSjL3laUR3wL5q5WR1mBIqYvHmXfwkHxALnFu4n2tILDVvtsIyCTlERpiQrFIJyM
        dpVj3K+99Tdk3iWnSC4FdzZZjGK5gHXT4nSyePL1W9vWz9Ub3lMFs0azHx5Deat/
        b2dQvhWeRUn4aKS9Uv/+8Xqw0wqElU5LsgLFlxEZOH8=;
X-AuditID: ac14000a-923ff70000007ecb-a5-63bee504219b
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B2.F6.32459.405EEB36; Wed, 11 Jan 2023 17:34:12 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 11 Jan
 2023 17:34:11 +0100
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <upstream@lists.phytec.de>
CC:     <riku.voipio@iki.fi>, <alexandre.belloni@bootlin.com>,
        <a.zummo@towertech.it>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <lee@kernel.org>, <pavel@ucw.cz>
Subject: [PATCH v2 2/2] dt-bindings: rtc: Move rv3028 from trivial-rtc.yaml into own schema file
Date:   Wed, 11 Jan 2023 17:34:04 +0100
Message-ID: <20230111163404.3526248-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230111163404.3526248-1-w.egorov@phytec.de>
References: <20230111163404.3526248-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42JZI8nAo8vydF+yweYGZoslF6+yW7S/W8Zu
        Mf/IOVaLvhcPmS12tC1ksbi8aw6bxdY36xgtjq2+wmZx99RRNouTGy6xWbTuPcJu0f1O3YHH
        Y96aao/DXxeyeGxa1cnmcefaHjaP/u4WVo/p834yeaxY/Z3d4/MmuQCOKC6blNSczLLUIn27
        BK6MK6sa2Av+C1fMWHKTsYHxDn8XIyeHhICJxL/uz6xdjFwcQgKLmSQebN/DBOE8YZTobtrM
        BlLFJqAucWfDN7AqEYHZjBIdbzcwgzjMApsYJabcPM4CUiUskCCx6eoHMJtFQFWiY+EbJhCb
        V8BSYtaf0ywQ++QlZl76zg5icwpYSTw5+4kZxBYCqnl1+yYrRL2gxMmZT8DqmYHqm7fOZoaw
        JSQOvngBVS8v8eLScriZ0869ZoawQyW2ftnONIFRaBaSUbOQjJqFZNQCRuZVjEK5mcnZqUWZ
        2XoFGZUlqcl6KambGEERJsLAtYOxb47HIUYmDsZDjBIczEoivCs59yQL8aYkVlalFuXHF5Xm
        pBYfYpTmYFES573fw5QoJJCeWJKanZpakFoEk2Xi4JRqYFTgaY1W/lihLDWtejGn2haOlcnn
        nv457CuT/E58Q8yM3YkP+dhPb5ppJqPkpnW98Xf43pp3SezRdQsMZ0imRz/59uL4xdBZtomZ
        XEIB+zPkdPnPtR8MLTj0/uxlA52y3JxE9Yhin/3qnc+6TdkZmf9Na/E8K+vEoP094XylkKrU
        EgWH029WKrEUZyQaajEXFScCAEX6bHeeAgAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move RV3028 RTC bindings from trivial-rtc.yaml into microcrystal,rv3032.yaml.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v2:
  - Update subject 
  - Remove not needed quotes
  - Remove start-year
  - Use unevaluatedProperties instead of additionalProperties
---
 .../bindings/rtc/microcrystal,rv3028.yaml     | 54 +++++++++++++++++++
 .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
 2 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml

diff --git a/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml b/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
new file mode 100644
index 000000000000..5ade5dfad048
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/microcrystal,rv3028.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip RV-3028 RTC
+
+allOf:
+  - $ref: rtc.yaml#
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+properties:
+  compatible:
+    const: microcrystal,rv3028
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  trickle-resistor-ohms:
+    enum:
+      - 3000
+      - 5000
+      - 9000
+      - 15000
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@51 {
+            compatible = "microcrystal,rv3028";
+            reg = <0x51>;
+            pinctrl-0 = <&rtc_nint_pins>;
+            interrupts-extended = <&gpio1 16 IRQ_TYPE_LEVEL_HIGH>;
+            trickle-resistor-ohms = <3000>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index d9fc120c61cc..84cce1f0ca0c 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -48,8 +48,6 @@ properties:
       # Intersil ISL12022 Real-time Clock
       - isil,isl12022
       # Real Time Clock Module with I2C-Bus
-      - microcrystal,rv3028
-      # Real Time Clock Module with I2C-Bus
       - microcrystal,rv3029
       # Real Time Clock
       - microcrystal,rv8523
-- 
2.34.1

