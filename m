Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB5651273
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiLSTLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiLSTLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:11:34 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334786348;
        Mon, 19 Dec 2022 11:11:33 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so12747660fac.2;
        Mon, 19 Dec 2022 11:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMnlxoTqvS1IA4HSYL23J+M9Pwti5hhqK+tvoJpTS0E=;
        b=NA5beNuOGx2PM6zub4dr4bZtYWfHZbkH8BV0enhNZweYIs1A97L635ciVOAXqkdKYQ
         nWzh4ZYDyoJn1/t98XysHqOYx8tqW8WH88kny+/29oqfmstIxBjeoL+pO+B12zDfz26E
         b2eZXS/CwGrg74Q2QJJqxbqlTNmy93eV1OZ2k/wOl1QDSLoKT9lssyjt1bIPftXya09s
         jDP+wcqn0NKw3AiQ2a9+bsD1pJiikOAUnUXyzNQK4Jch5w8mFHbcJ5GpZLtjGvXVsAWY
         oadTo3gyTM9ErIdeblFidNx7Whef7P1kTClcmpA/EPCUZV/SRV+UrB2mnfFW/mF3/lKq
         9b6g==
X-Gm-Message-State: AFqh2kqYCRSq5O2Xs1V6p5cqwGDsMDtiAucBZucX/Ukpm53WMLIgZwSV
        FriMdOzMe7tFJlw92Wuqe3Y8ScCLOg==
X-Google-Smtp-Source: AMrXdXu3wBvfQIorWmAnp1iP/C4nuvb3Qyhergc7ouc5u9CQeLqRntwO76/NrnpHB4TIB3t7E2dz7g==
X-Received: by 2002:a05:6870:c68c:b0:144:2c97:ab06 with SMTP id cv12-20020a056870c68c00b001442c97ab06mr4069398oab.43.1671477092440;
        Mon, 19 Dec 2022 11:11:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k2-20020a056870148200b001447a2a34dfsm5037224oab.40.2022.12.19.11.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:11:32 -0800 (PST)
Received: (nullmailer pid 1975039 invoked by uid 1000);
        Mon, 19 Dec 2022 19:11:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] regulator: dt-bindings: Convert Fairchild FAN53555 to DT schema
Date:   Mon, 19 Dec 2022 13:11:25 -0600
Message-Id: <20221219191125.1974879-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Fairchild FAN53555 and compatible variants binding to DT
schema format.

The example was missing 'reg', so add it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/fan53555.txt           | 24 --------
 .../bindings/regulator/fcs,fan53555.yaml      | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/fan53555.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml

diff --git a/Documentation/devicetree/bindings/regulator/fan53555.txt b/Documentation/devicetree/bindings/regulator/fan53555.txt
deleted file mode 100644
index 013f096ac0aa..000000000000
--- a/Documentation/devicetree/bindings/regulator/fan53555.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Binding for Fairchild FAN53555 regulators
-
-Required properties:
-  - compatible: one of "fcs,fan53555", "fcs,fan53526", "silergy,syr827",
-		"silergy,syr828" or "tcs,tcs4525".
-  - reg: I2C address
-
-Optional properties:
-  - fcs,suspend-voltage-selector: declare which of the two available
-		voltage selector registers should be used for the suspend
-		voltage. The other one is used for the runtime voltage setting
-		Possible values are either <0> or <1>
-  - vin-supply: regulator supplying the vin pin
-
-Example:
-
-	regulator@40 {
-		compatible = "fcs,fan53555";
-		regulator-name = "fan53555";
-		regulator-min-microvolt = <1000000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&parent_reg>;
-		fcs,suspend-voltage-selector = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml b/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
new file mode 100644
index 000000000000..9610e48c5b8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/fcs,fan53555.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fairchild FAN53555 regulators
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - fcs,fan53555
+      - fcs,fan53526
+      - silergy,syr827
+      - silergy,syr828
+      - tcs,tcs4525
+
+  reg:
+    maxItems: 1
+
+  fcs,suspend-voltage-selector:
+    description: Declares which of the two available voltage selector
+      registers should be used for the suspend voltage. The other one is used
+      for the runtime voltage setting.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+
+  vin-supply:
+    description: Supply for the vin pin
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@40 {
+            compatible = "fcs,fan53555";
+            reg = <0x40>;
+            regulator-name = "fan53555";
+            regulator-min-microvolt = <1000000>;
+            regulator-max-microvolt = <1800000>;
+            vin-supply = <&parent_reg>;
+            fcs,suspend-voltage-selector = <1>;
+        };
+    };
+...
-- 
2.35.1

