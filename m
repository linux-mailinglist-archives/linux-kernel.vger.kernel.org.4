Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B078630FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 18:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiKSRag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 12:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiKSRae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 12:30:34 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDBB3A5;
        Sat, 19 Nov 2022 09:30:33 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AJHUN3C044519;
        Sat, 19 Nov 2022 11:30:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668879023;
        bh=r8sLHDDOzGgbBCIGqYcV91GxOugG6GFPoo0nw7unMfE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dD0JnMrLEqNU/jITbbU7UNta+mN+t7nmx5klAzpvhduqMtl+jLOO+X0BpRE60HCFh
         HtjNVCkjqrs2/1gmsg0acJkQSLu/l+lhMxcHBjJe2xq/ltyciIcZL4Ycmwv2DkVrHg
         iHneJGa4p8Q5RCI5a+lc5VoZDuyOc4Pa1TJf8KO4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AJHUNft093884
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 19 Nov 2022 11:30:23 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sat, 19
 Nov 2022 11:30:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sat, 19 Nov 2022 11:30:22 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AJHUMnK055641;
        Sat, 19 Nov 2022 11:30:22 -0600
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v6 1/5] dt-bindings: display: ti,am65x-dss: Add support for am625 dss
Date:   Sat, 19 Nov 2022 23:00:15 +0530
Message-ID: <20221119173019.15643-2-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221119173019.15643-1-a-bhatia1@ti.com>
References: <20221119173019.15643-1-a-bhatia1@ti.com>
MIME-Version: 1.0
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

The DSS controller on TI's AM625 SoC is an update from that on TI's
AM65X SoC. The former has an additional OLDI TX on its first video port
(VP0) that helps output cloned video or WUXGA (1920x1200@60fps)
resolution video output over a dual-link mode to reduce the required
OLDI clock output.

Add the new controller's compatible and a port property for the 2nd OLDI
TX (OLDI TX 1).

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rahul T R <r-ravikumar@ti.com>
---
 .../bindings/display/ti/ti,am65x-dss.yaml     | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index 5c7d2cbc4aac..55ec91f11577 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -19,7 +19,9 @@ description: |
 
 properties:
   compatible:
-    const: ti,am65x-dss
+    enum:
+      - ti,am625-dss
+      - ti,am65x-dss
 
   reg:
     description:
@@ -80,13 +82,18 @@ properties:
       port@0:
         $ref: /schemas/graph.yaml#/properties/port
         description:
-          The DSS OLDI output port node form video port 1
+          The DSS OLDI output port node form video port 1 (OLDI TX 0).
 
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
         description:
           The DSS DPI output port node from video port 2
 
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          The DSS OLDI output port node form video port 1 (OLDI TX 1).
+
   ti,am65x-oldi-io-ctrl:
     $ref: "/schemas/types.yaml#/definitions/phandle"
     description:
@@ -102,6 +109,18 @@ properties:
       Input memory (from main memory to dispc) bandwidth limit in
       bytes per second
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am65x-dss
+    then:
+      properties:
+        ports:
+          properties:
+            port@2: false
+
 required:
   - compatible
   - reg
-- 
2.38.1

