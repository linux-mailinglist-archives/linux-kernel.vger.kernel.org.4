Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3867B18C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbjAYLgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjAYLgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:36:44 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6623A56ED3;
        Wed, 25 Jan 2023 03:36:10 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30PBZZHX120927;
        Wed, 25 Jan 2023 05:35:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674646535;
        bh=spu8mpkf0idGKiowTQ//ULeRb5yOrGVsyubCEwvDS40=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NYIU/mG6JGxw0IMqcyncZC78JuVW6Tnmo5NM4zl+Yq8vcW436JoyHbixQTX5A0acH
         EZYDuRaEnjMbE57f2Mxe49HmHVvhoscRvYv3ENRlOzX6K7wX7+npNKSzvKhAkyLB9T
         zMuUv7f/miO2tVqbQgHMwapTREOxvWExijflmaxw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30PBZZAW113558
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jan 2023 05:35:35 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 25
 Jan 2023 05:35:35 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 25 Jan 2023 05:35:35 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30PBZYHl074765;
        Wed, 25 Jan 2023 05:35:34 -0600
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v7 2/6] dt-bindings: display: ti,am65x-dss: Add support for am625 dss
Date:   Wed, 25 Jan 2023 17:05:25 +0530
Message-ID: <20230125113529.13952-3-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125113529.13952-1-a-bhatia1@ti.com>
References: <20230125113529.13952-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
2.39.0

