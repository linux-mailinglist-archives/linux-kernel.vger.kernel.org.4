Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B969B6460D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLGSAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLGSAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:00:48 -0500
X-Greylist: delayed 1389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Dec 2022 10:00:47 PST
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.47.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5B92EF38
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:00:47 -0800 (PST)
Received: from atl1wswcm02.websitewelcome.com (unknown [50.6.129.163])
        by atl1wswob02.websitewelcome.com (Postfix) with ESMTP id 795E0300BE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 17:37:37 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id 2yMQpMpVQpVRN2yMSpmBno; Wed, 07 Dec 2022 17:37:37 +0000
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+5Bpf6w0b7QD/SF/Lp8AD5I90AMS2QjMrFwXHi0/feQ=; b=BMC/0ASwRm4c34g3YXLxQJf8ym
        nv8V74ujCjzfXEwZAY2JzdDKRyWY5ZozEMwwZpDcmdql2jTSq//V3tlov1u0Wzf6ozsYc0a5jsP3y
        NlHXqTQD9M5kPFbMHxRRMi1eD1PqtCXBvPLvCyMwc4K3eENYrI9f3EBopyE0NghCsY7aMPR+eBdK5
        RygqEg0YSBpaihueTKbypLWiuKNX9q3QjOTfcRqEw1G8LMox+b2EASur4KyobGCeZTyC3hAA2rTcU
        +/kzYepATjWLE0p+jt8r48nnf3TZo/kuS33X+plwqh9gE0fe5dxvGEXBsJTBxDn9yC60ak0jwFz3+
        WFbJqavg==;
Received: from [106.222.117.249] (port=8172 helo=discovery..)
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <saravanan@linumiz.com>)
        id 1p2yMP-0025qb-ON;
        Wed, 07 Dec 2022 17:37:33 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marten.lindahl@axis.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saravanan Sekar <saravanan@linumiz.com>
Subject: [PATCH v3 2/4] dt-bindings: regulator: Add mps,mpq7932 power-management IC
Date:   Wed,  7 Dec 2022 18:37:14 +0100
Message-Id: <20221207173716.123223-3-saravanan@linumiz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207173716.123223-1-saravanan@linumiz.com>
References: <20221207173716.123223-1-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 106.222.117.249
X-Source-L: No
X-Exim-ID: 1p2yMP-0025qb-ON
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (discovery..) [106.222.117.249]:8172
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 17
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN/NqocAAo1Kh7i4hRaIZFlnlyovPzquD6F1fbXyEqUFkyMLKd0BlM9lvlIpFbv7O2jTT4j9kmJrWRyHqMNub9J6wDgwoelo/mwMI7rhIZ/phdgoE2FA
 GUlz63h7uSwilm4luFL7z3184L8vdGVhTJ1RJV58pcKGrFtWMwHV+KqaHD+UbNNDYR2Al2JOts5MNNNzIO7j0T6ZapIH+ewlHMc=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document mpq7932 power-management IC

Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
---
 .../bindings/regulator/mps,mpq7932.yaml       | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7932.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7932.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7932.yaml
new file mode 100644
index 000000000000..2185cd011c46
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mps,mpq7932.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mps,mpq7932.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Monolithic Power System MPQ7932 PMIC
+
+maintainers:
+  - Saravanan Sekar <saravanan@linumiz.com>
+
+properties:
+  compatible:
+    enum:
+      - mps,mpq7932
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: |
+      list of regulators provided by this controller, must be named
+      after their hardware counterparts BUCK[1-6]
+
+    patternProperties:
+      "^buck[1-6]$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@3 {
+            compatible = "mps,mpq7932";
+            reg = <0x3>;
+
+            regulators {
+                buck1 {
+                    regulator-name = "buck1";
+                    regulator-min-microvolt = <1600000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-boot-on;
+                };
+
+                buck2 {
+                    regulator-name = "buck2";
+                    regulator-min-microvolt = <1700000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-boot-on;
+                };
+            };
+        };
+    };
+...
-- 
2.34.1

