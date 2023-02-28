Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F486A52FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 07:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjB1GcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 01:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB1GcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:32:13 -0500
Received: from spamfilter04.delta.nl (spamfilter04.delta.nl [217.102.255.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A898D2057D;
        Mon, 27 Feb 2023 22:32:11 -0800 (PST)
Received: from host-ubmmyvj.static.zeelandnet.nl ([217.102.255.198] helo=mail.zeelandnet.nl)
        by spamfilter04.delta.nl with esmtp (Exim 4.92)
        (envelope-from <mike.looijmans@topic.nl>)
        id 1pWtX0-0006dr-W8; Tue, 28 Feb 2023 07:32:07 +0100
X-Sender-IP: 204.168.188.16
Received: from phenom.domain_not_set.invalid (016-188-168-204.dynamic.caiway.nl [204.168.188.16])
        (Authenticated sender: glasveze@delta.nl)
        by mail.zeelandnet.nl (Postfix) with ESMTPA;
        Tue, 28 Feb 2023 07:31:52 +0100 (CET)
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: Add TI ADS1100 and ADS1000
Date:   Tue, 28 Feb 2023 07:31:50 +0100
Message-Id: <20230228063151.17598-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: 217.102.255.198
X-DELTA-Domain: zeelandnet.nl
X-DELTA-Username: 217.102.255.198
Authentication-Results: delta.nl; auth=pass smtp.auth=217.102.255.198@zeelandnet.nl
X-DELTA-Outgoing-Class: ham
X-DELTA-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+DcX9mBS87Sjkl3zt5DZ/JPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5xzeemUa7CfwmLuWRw6Ruql9Wrt/oF2ofKYeezPZTW+uL/H
 seNZtCKdSRRS0Op9pfwEIJgF/Accv4lLtE4TWYNIjgZ0d6t6F7vRFkkblm+Z5L7uq2AYbiB7eX7C
 A0Ee9FXnLqvnkE9k+JY3j0cID29DoODujL6FEsNqPMBZcb5VIYa36rQUNKpqI1Q4bofNkWUu8fTD
 ZLzKN6k+QrhjNGJv3vMX8kxfmgvnPiAPWmoBuxmBwTME+9GFGInGiou45HNmtfv+FqJdBAzMzmkl
 3RebQxyzcaJWgnTP1X4liYqSLtlnibl3vcBqVmvQB4A18ae2ZUrTg6FOOV02sP442WuqAVXirbLu
 Jjy3NtnGWLbnBD5wBOYayDY3tUZW3y7uaAiYA/VUAhdIJZFus1IsgsCDp7g8tNbgTOJVkvPWcKve
 fL+CgfasVEKELzhStrT89iLQPrbYmyedRWSaH5Jq+f9dFu3a+YmrU6Iy71ckAFY+TtvrQQT37tVB
 F8TuA2zDxdadd1WxHO/mLVgwAb47uaav6rkstLAf90f4v3S1FulD9czOuJQrulh5Fko3Tg7NaUQc
 YIYdvv9xV5Ex49z0ZSNkjgZ0d6t6F7vRFkkblm+Z5MW9qS2/3RCT5H9A6khsXlWGs9HjdrlYbXkZ
 KU5GQmOJZsmqX57B1EDhkm+xMEreF4WyYiqdZEM01eRU4ONdoVEFBfQHNmmYaIBwRgEu+hlkUryY
 cSJLFEwVd01VIyXuC84PLa7Kvs1vJgz+jb+KUZ4ZI4crFqIiLO9pmeAxg3M8BMj+y2IddO0/FlXY
 D8b+M8bPMsyA7EJ+U7NdS2YrNZ05xOYqJ9Tq2b0GjLr7lMbCDjnM3rdD8NgG/HfNinI857jdWiOx
 jT+Uoc44sbCX7JxqjLaXu1AD0YHYM/EUhlEfE6TG2ORqQuRwhOvtgDJH0WotQdu7BL5WjlV6WURt
 Nxb4RqrqGwDerCVKfZxBaa6lpe1/5cEtgGt7CHfC+dbEjaN+/GAFlUDQdIxEvZe3STQis/XYTU9g
 OFOXr5UdN6W4PtxMTp1vEgkwihjWmfmNVfPvzy/hTW1WrcVDSDSSDu0wxuDU9J+Dmr/6e4fImcm4
 9R/2gMGq0KWAzmMf+ibVDqLZPzE7W9Cqnhlc7GZSDtYOqFKIG2trlPUTQYEjbgmVnZqbKIaNWdFw
 SHKOTj4XQZ8i4WqksVTtjhZSepuHki+xkgmaS1TA/Dv/4AHP2EFtNptbHtgZAQM3rG32ibSwsxBN
 fS19KOA46lF/j0xwFgg=
X-Report-Abuse-To: spam@spamfilter03.delta.nl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADS1100 is a 16-bit ADC (at 8 samples per second).
The ADS1000 is similar, but has a fixed data rate.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

(no changes since v2)

Changes in v2:
"reg" property is mandatory.
Add vdd-supply and #io-channel-cells

 .../bindings/iio/adc/ti,ads1100.yaml          | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
new file mode 100644
index 000000000000..970ccab15e1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI ADS1100/ADS1000 single channel I2C analog to digital converter
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+description: |
+  Datasheet at: https://www.ti.com/lit/gpn/ads1100
+
+properties:
+  compatible:
+    enum:
+      - ti,ads1100
+      - ti,ads1000
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  "#io-channel-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@49 {
+            compatible = "ti,ads1100";
+            reg = <0x49>;
+        };
+    };
+...
-- 
2.17.1

