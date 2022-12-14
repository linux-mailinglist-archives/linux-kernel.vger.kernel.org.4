Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FAA64C895
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbiLNMAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237680AbiLNMAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:00:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1564125C61
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:59:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p5QQ6-0005u5-Oh; Wed, 14 Dec 2022 12:59:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p5QQ5-004SUT-96; Wed, 14 Dec 2022 12:59:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p5QQ5-005122-86; Wed, 14 Dec 2022 12:59:29 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: display: imx: Describe drm binding for fsl,imx-lcdc
Date:   Wed, 14 Dec 2022 12:59:20 +0100
Message-Id: <20221214115921.1845994-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214115921.1845994-1-u.kleine-koenig@pengutronix.de>
References: <20221214115921.1845994-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2164; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=1NIdH+33Goz5fyXKjLETK/Z17qROmoceRqEUPWsk8nw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjmbqOp53HkCUZ8uIMQ5d7zzjETuf54RrPmcDvAeBA kYYh77GJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY5m6jgAKCRDB/BR4rcrsCRTxB/ sGm7y25pSIRQRMeYgeRppp6NUSDQAqlKHR0A5mzul9lUuV17Ou1GGhlnCMkbfVynWYTt12wvYbeDTJ VEOMqfFZK5BMcwrancax3vnGtZaY1E8r88BWlHfcaV1PQ8ygYc8GK5yrziOh0s99BYKM/vo4xXQzol A5NZGzmuXozp/c7FhGmy3CnHn2TKJZH/wvJ0JT1lKbmf/+0clra+qnW2ErDuHQC+NxTKXmgA/u45pj kBoWr5O9kY4VmwS02bpH/oSAjO1xdFJ+vgSiuNPWV4//ze3LXCvh8BY/56hv6iOZltZa4O9/StZX2e GPtwi3z5qdhJBYo1XjeRO/NKTIW04W
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the existing (fb-like) binding to support the drm-like binding in
parallel.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 .../bindings/display/imx/fsl,imx-lcdc.yaml    | 45 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
index 35a8fff036ca..2a8225b10890 100644
--- a/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
@@ -21,6 +21,9 @@ properties:
               - fsl,imx25-fb
               - fsl,imx27-fb
           - const: fsl,imx21-fb
+      - items:
+          - const: fsl,imx25-lcdc
+          - const: fsl,imx21-lcdc
 
   clocks:
     maxItems: 3
@@ -31,6 +34,9 @@ properties:
       - const: ahb
       - const: per
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+
   display:
     $ref: /schemas/types.yaml#/definitions/phandle
 
@@ -59,17 +65,54 @@ properties:
     description:
       LCDC Sharp Configuration Register value.
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - fsl,imx1-lcdc
+          - fsl,imx21-lcdc
+then:
+  properties:
+    display: false
+    fsl,dmacr: false
+    fsl,lpccr: false
+    fsl,lscr1: false
+
+  required:
+    - port
+
+else:
+  properties:
+    port: false
+
+  required:
+    - display
+
 required:
   - compatible
   - clocks
   - clock-names
-  - display
   - interrupts
   - reg
 
 additionalProperties: false
 
 examples:
+  - |
+    lcdc@53fbc000 {
+        compatible = "fsl,imx25-lcdc", "fsl,imx21-lcdc";
+        reg = <0x53fbc000 0x4000>;
+        interrupts = <39>;
+        clocks = <&clks 103>, <&clks 66>, <&clks 49>;
+        clock-names = "ipg", "ahb", "per";
+
+        port {
+            parallel_out: endpoint {
+              remote-endpoint = <&panel_in>;
+            };
+        };
+    };
   - |
     imxfb: fb@10021000 {
         compatible = "fsl,imx21-fb";
-- 
2.38.1

