Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF795FBE58
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJKXTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJKXTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:19:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C975EA59BC;
        Tue, 11 Oct 2022 16:18:37 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29BNIQXS005747;
        Tue, 11 Oct 2022 18:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665530306;
        bh=P1m/db96NUv+Yg/RID1mWoELUsUOMqR0M54jnmoWElo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SSllpkkg9qtDYsVDOiXA6GfVVSytL2EUL7et14uyz3yhecLShYhnOjaGoGm8HyFyD
         Hc9Pz9SQHteerFajeRgzLQkwxqRn1xAS0OYUVjWelmxnWLCSicbWeRuRyJhrx3cf10
         dG3CsuMhLJpKyMb76tEf/M4COfuIjtrQVM3YhTB4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29BNIQEa096544
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Oct 2022 18:18:26 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 11
 Oct 2022 18:18:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 11 Oct 2022 18:18:01 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29BNI1aA088414;
        Tue, 11 Oct 2022 18:18:01 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Linux Thermal <linux-pm@vger.kernel.org>,
        Linux Device Tree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 05/11] dt-bindings: thermal: k3-j72xx: elaborate on binding descriptions
Date:   Tue, 11 Oct 2022 18:17:21 -0500
Message-ID: <20221011231727.8090-6-bb@ti.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221011231727.8090-1-bb@ti.com>
References: <20221011231727.8090-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2264; h=from:subject; bh=xzPQXHc0OCTrwaaHBhCklOdKZFKQQ617QSSHOw26KN4=; b=owNCWmg5MUFZJlNZosh7uAAAY//////N9nvz/L2TNv09fJP+bx5/bue7O/u/8m//5/5v/PSwARs2 g7UAaAAAAGgDQABoAAAaZGgGjIAADQ0DTQaBk0aABo9IGRtT1GxT2VEDJk0aGgGIaGho0BkMgGQZGh poNGgADJpowBBhMQaBkBoYgaMg0yaNABg7U0yBpoGhhNAAANGgYmgAyAAA0AGT1B6EeowTI0ZGg0AB kDI0NNDQ09IMGDDw472vWL+jYN/aEBFU7IPcNoBHiI3ogAyRAVlsgEVJQ+pW/Z6IUi1AEnsL+4aL5y 86SWZFReGhzf47Hc9QMrE6IM4Ch0a+vvfYDubVZGDCLUQ3enGCs0GkX6R43SQSBMKXImP41BL76wHs efRJEwKf+Tta7yDzGDTktDchj2IkOHbTpLbfcrXYfFbd4p0dNop1LguDyOhlzcaw8bNFLITelbPMZ9 vIV/ftUnDy6/J5fgh7P0vgLxodev4WXB0ggrfL261MvYThRxniUDHlJ7JTHhDlTh/4DCPDstU4Titx pJsJStc+jUHF89wyJl0b7CZehfVKkpB8FNlsfxIgqzPTilGyTH6+p7tSyXxiKIEij8SW3sBFfixBbk DFDKPJ3HWgAIQSzV7bBmmx/XhCqef7GOaSPYLOqCwjLUJCpGJDkrDCCWAH/F3JFOFCQosh7uA=
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elaborate on the function of this device node as well as some of the
properties that this node uses.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 .../bindings/thermal/ti,j72xx-thermal.yaml    | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
index c74f124ebfc00..0b6a6fa07a532 100644
--- a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
@@ -9,6 +9,24 @@ title: Texas Instruments J72XX VTM (DTS) binding
 maintainers:
   - Keerthy <j-keerthy@ti.com>
 
+description: |
+  The TI K3 family of SoCs typically have a Voltage & Thermal
+  Management (VTM) device to control up to 8 temperature diode
+  sensors to measure silicon junction temperatures from different
+  hotspots of the chip as well as provide temperature, interrupt
+  and alerting information.
+
+  The VTM device will periodically enable these temperature sensors
+  to make a temperature measurement and store the reported data
+  allowing the sensors to stay in a reset state when not in use
+  to maximize the sensor's life.
+
+  This VTM driver will then use the following polynomial equation to
+  calculate the temperature from the value stored in the VTM device.
+
+  Temp = (-9.2627e-12) * x^4 + (6.0373e-08) * x^3 + \
+         (-1.7058e-04) * x^2 + (3.2512e-01) * x   + (-4.9003e+01)
+
 properties:
   compatible:
     enum:
@@ -19,9 +37,16 @@ properties:
     items:
       - description: VTM cfg1 register space
       - description: VTM cfg2 register space
-      - description: VTM efuse register space
+      - description: |
+          A software trimming method must be applied to some Jacinto
+          devices to function properly. This eFuse region provides
+          the information needed for these SoCs to report
+          temperatures accurately.
 
   power-domains:
+    description: |
+      Should contain the phandle to a power management (PM) domain
+      node and the device-id of this device.
     maxItems: 1
 
   "#thermal-sensor-cells":
-- 
2.38.0

