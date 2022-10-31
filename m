Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8006141C5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJaX1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJaX1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:27:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDF912AB5;
        Mon, 31 Oct 2022 16:27:28 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRGsb058538;
        Mon, 31 Oct 2022 18:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667258836;
        bh=LgTBdkwNzRTJ5B07mN+M8e2UjKFtWtJrOweJr0P5xmQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cb4o8bYoK4NxStvBp3hk/Ibqmb8r0NMMmYClJk1qzzBgrlj+dTFmtBBumX3SKVDcq
         LBFbIY/qCaArbnLeEtgxR6kaBqmEktg1khnMsdDpiQo5ze63chZgwdHNxx1UbG71LG
         L5EnEjCF/s2zzQ3CTSjsmRfplajkUogjD1czqDw8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VNRGFV022968
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 18:27:16 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 18:27:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 18:27:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRFJK037173;
        Mon, 31 Oct 2022 18:27:15 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Keerthy <j-keerthy@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        Device Trees <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LKML ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 05/11] dt-bindings: thermal: k3-j72xx: elaborate on binding description
Date:   Mon, 31 Oct 2022 18:26:56 -0500
Message-ID: <20221031232702.10339-6-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031232702.10339-1-bb@ti.com>
References: <20221031232702.10339-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1908; h=from:subject; bh=2owYngSVCIIHuMuf97DPY5J6wC+TRH6miDqFBbdv1FU=; b=owNCWmg5MUFZJlNZZSwGGwAAZH///r5tYyl/v/rPy3X3/6fet//2f35uO86z7r376nf/9dewARsZ SHpNBiAaMgA0GTIDQA00DJoDEeo0MgAAAABoaNGQA0ABoD1NNDJsmjSMg5AGg0BoNAAyNAGgADINNA GmmQNDR6QGnpBoNAYho0GammQaaGgYmnpNA0YaiGjamgxNGjTI0DQNNGRo0MQA0aaNMEGTEBkGgaAD JkAGQZDRoDIYQMI0AAAA3YToNBFAENlBuOmEkI+Cl5+FCCQ79ze3SCoMcMUGuTXYC1XJDa9JaImPrk mvlmHSAL6gFssU5EPur/VQV1gfRVq4s2pdD1KIvOx6C5slSxjJsmLAYoPbwafvuyZ8scw8ZuUG7e0r dylbcDnGEAEYXUzbjNNEooJnG67sXRphSHkQb6ciRGJA2qJJ2jdLM3LRKQMo2g/nZtHq1QsAShA5xU q04bJTh4cJILlrEJw1BJ8scyDJPvSOfdXrbt+2/4p0Pg8jLT1a/QhqZwzvox38gsEyu0wAKAzofaQI ZmuzhUDvlVJ42N8Nl2CbQ8ouyNzsYMcr8GZzAKHO+WJivjU6wvGSbeYCAgebQP9DAB1hBjtE1P8AQu XWiGADJ1vRiG02dgfvzV/yyDs/awvbdW5Kz7o05EgpSVAmC2wL4S7g0JtE/5WF/i7kinChIMpYDDY=
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elaborate on the function of this device node as well as some of the
properties this node uses.

Signed-off-by: Bryan Brattlof <bb@ti.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/thermal/ti,j72xx-thermal.yaml    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
index c74f124ebfc00..3bb870a26872f 100644
--- a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
@@ -9,6 +9,19 @@ title: Texas Instruments J72XX VTM (DTS) binding
 maintainers:
   - Keerthy <j-keerthy@ti.com>
 
+description: |
+  The TI K3 family of SoCs typically have a Voltage & Thermal
+  Management (VTM) device to control up to 8 temperature diode
+  sensors to measure silicon junction temperatures from different
+  hotspots of the chip as well as provide temperature, interrupt
+  and alerting information.
+
+  The following polynomial equation can then be used to convert
+  value returned by this device into a temperature in Celsius
+
+  Temp(C) = (-9.2627e-12) * x^4 + (6.0373e-08) * x^3 + \
+            (-1.7058e-04) * x^2 + (3.2512e-01) * x   + (-4.9003e+01)
+
 properties:
   compatible:
     enum:
@@ -19,7 +32,11 @@ properties:
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
     maxItems: 1
-- 
2.38.1

