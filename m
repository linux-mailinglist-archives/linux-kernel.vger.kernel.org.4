Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC96A06EB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjBWLB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjBWLBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:01:48 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EA754567
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 03:01:40 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230223110138epoutp02dafdcf0d811d5e8244f7dcd80ec8a9f6~GbyD3VQAP3104431044epoutp02S
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:01:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230223110138epoutp02dafdcf0d811d5e8244f7dcd80ec8a9f6~GbyD3VQAP3104431044epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677150098;
        bh=6Am/pU+0DRzbajMRwCB6It4syIPlNp3VoLOYpRU4yCQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=sEoVfkkyyx75sM1XGUU83Z1luTWtMSTVBEdiI0s9Yj7d5O4DollVnDI/sv2I+pgZy
         5Fy5jWQawCM4M5QEJYFT3uQXsXM8szTfpL+JXEMMUWJ5pXZi2OSJAA/Ase7r9n9ova
         sel3sTFcec9F0ubAI1Wifrp4UxYqxWQH9JHJNZcc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230223110137epcas5p38c18c38934281e8f8d9d9ef9a21e33db~GbyCzirgn1474914749epcas5p3u;
        Thu, 23 Feb 2023 11:01:37 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PMqpR3Kd2z4x9Q9; Thu, 23 Feb
        2023 11:01:35 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.1A.10528.F8747F36; Thu, 23 Feb 2023 20:01:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230223104649epcas5p260da7a49016c9ef7826ac1fab7567776~GblIIBS6x0042400424epcas5p2l;
        Thu, 23 Feb 2023 10:46:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230223104649epsmtrp1e92b922e75ba00bacd4219ef0374638c~GblIG-Srv1201512015epsmtrp10;
        Thu, 23 Feb 2023 10:46:49 +0000 (GMT)
X-AuditID: b6c32a49-c17ff70000012920-2a-63f7478f5309
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.39.05839.91447F36; Thu, 23 Feb 2023 19:46:49 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230223104646epsmtip2496f2c8dcee31e0110a003036556156a~GblFJEi2O0991609916epsmtip2T;
        Thu, 23 Feb 2023 10:46:46 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, Aakarsh Jain <aakarsh.jain@samsung.com>
Subject: [PATCH] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Date:   Thu, 23 Feb 2023 16:16:14 +0530
Message-Id: <20230223104614.10954-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfUxTVxjGc+69vbeoJVeEcWBT2Y3bAgnQbm05Xawj0YyrYxO2GTM3B7W9
        46u0TW8ZuGSZLsNp5UMdJoAICKgJImL5luqwFO3YWMYAcWgdX44Ps8FgDLcprOXC9t/vnOd9
        njfnPeeIcT8XGSxOMVg4s0GjZ8g1RFNHaFh4fsyCVvpw8Bn0sKVIhIZKm0hU+XgcQz9XzhHI
        Ud9IoYa+Mzi6eLtdhMqc34tQ880RAl2d8Kg9RW4CjZfVAjRZ/IBEeRPDOLKN3hGh3mslJMqp
        axShy043hc4P9GDogu0Jhioa/6BQ9nUnhb444sSiA9ma0hrAtrirADtQNYuzrcVuiq20T2Ks
        rfoYyd6/YyfZ+qrP2OzOvwk2r6EasFbnAMnO2TaxXfNzVJxkX9rWZE6j48whnEFr1KUYktTM
        G+8kbE9QKKWycJkKRTEhBk06p2Z2xMaFv56i95yeCflYo8/wbMVpeJ6J3LbVbMywcCHJRt6i
        ZjiTTm+SmyJ4TTqfYUiKMHCWV2VS6csKT2FiWnJ9zzRlWlJlNbe1kodAUagV+IghLYdjU8Ok
        l/3oNgCrxyIFngUwzyWygjUe/hNA68QZsGpwuUqBIFwHsMDeiwuLbAw2Dv6GWYFYTNLhsLtZ
        7zX404cBHD1q8dbgtJXwJN2kvMIGejecyb0r8jJBvwA7noxQXq+EVkPbvVih2WZ4qa59OR/S
        Y2L4bfFxUhB2QJfjFibwBjh1u4ESOBhO5h9ZYS0crZjEBdbDK/YCQuDXYHtfCeHthdOh8Mq1
        SGF7IzzdVbscidO+MPefsZV4CWwpXeUXYcn9xyKBn4Mdl86vDIWFp47NE8Lk9sOR7gbRCbCx
        +P8O5QBUgyDOxKcncbzCJDNwmf9dk9aYbgPLTzpsZwtwD81EOAAmBg4AxTjjLzmNLWj9JDrN
        wU84szHBnKHneAdQeEZ2Eg8O0Bo9f8JgSZDJVVK5UqmUq15RyphAyUvqb7R+dJLGwqVxnIkz
        r/owsU/wIWwP1LeG//BdeV1B2adUoOFRfdDUV9bdE6lBm87Wbs537iqy18zKb5SNXFS/l0/E
        cI8mE591xLf/qlxKaA8btR1QvBk/Nrq9PyW2L7vK3BlAdvYRF7iQL99yJzZdbkP+Ww7G3819
        oAuKVXx+9q+l6c6sbr9E8sPCwFS+/YP3pc0nA47q1rv3TlfkcOk+B/qfFkoXyrVZi3XPL86Y
        VLhofQ6Tt3M8c8hU9XTf19E/+u7aI4132ReTiJjf1wY7WroS55p+Sb3ls1ZVDw3ryqP2xmTe
        +Gm+v3K+Yp3yo74p7FzU1eiK/YPDcefetVl4Zgvf27VNKfNNbfOve5vi7x2OO3XcWsgQfLJG
        Foabec2/OzZ7L1sEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSvK6ky/dkgwN9ehZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzaLvxUNmi02Pr7FaXN41h82iZ8NWVou1R+6yWyy9fpHJYtmmP0wWi7Z+Ybdo3XuE3aKl
        7QiTg7jHmnlrGD123F3C6HF9ySdmj52z7rJ7LN7zkslj06pONo871/aweWxeUu/RevQXi0ff
        llWMHl1HrrN5fN4k53Hq62f2AN4oLpuU1JzMstQifbsErozNF9+zF/y3rNi+eydbA+NMzS5G
        Tg4JAROJEyfmMXYxcnEICexmlFjy/Q8TREJG4n/bMXYIW1hi5b/n7BBFzUwSq2evBerg4GAT
        0JU4uz0HJC4i0MoocX1lJxOIwyywgEVi9aITLCDdwgK+Em/nH2cDsVkEVCUO/3nEDtLMK2Ar
        sem2D8QCeYnVGw4wT2DkWcDIsIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhqtDR3
        MG5f9UHvECMTB+MhRgkOZiUR3qlM35OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCe
        WJKanZpakFoEk2Xi4JRqYDr+g/lE896En3yCjLpPNho58J2vYtY09feNcxFL/MoZxb/ccmbM
        lLer959ujdszw/Pc8/T/2eUMt/48Pqe7dTPfRO+rAoVxQbP2VLorsruoCM0tOWQsvPxGlO0V
        y9dTrsufqOKv1OZ0s1af/GLfCb6WzS+VeQ+tu98Uu7uWYcakOQ/ihPJFZZlb+zI3sT9yKnn1
        4xnjTz7zxfULOg57uJ198y1R9Jx45kv3oszyN/dXzd4h+2dCNIPSCdkz899eeMG99wHT6cvF
        bUebzjV03t3/edHRQuePq11eb2GpCNphaaSumFmxfO/Pt05d/TavlPY9/H32z83VUa+TzU6U
        xby73n9k/tOYoqvzT8695XdOiaU4I9FQi7moOBEAmd2ZMwkDAAA=
X-CMS-MailID: 20230223104649epcas5p260da7a49016c9ef7826ac1fab7567776
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230223104649epcas5p260da7a49016c9ef7826ac1fab7567776
References: <CGME20230223104649epcas5p260da7a49016c9ef7826ac1fab7567776@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert s5p-mfc bindings to DT schema format using json-schema.

Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
Since, obsolete properties are not part of dt-node so we are not including these properties in dt-schema. 
 
.../devicetree/bindings/media/s5p-mfc.txt     |  78 ---------
 .../bindings/media/samsung,s5p-mfc.yaml       | 160 ++++++++++++++++++
 2 files changed, 160 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml

diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
index 8eb90c043d5d..e69de29bb2d1 100644
--- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
+++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
@@ -1,78 +0,0 @@
-* Samsung Multi Format Codec (MFC)
-
-Multi Format Codec (MFC) is the IP present in Samsung SoCs which
-supports high resolution decoding and encoding functionalities.
-The MFC device driver is a v4l2 driver which can encode/decode
-video raw/elementary streams and has support for all popular
-video codecs.
-
-Required properties:
-  - compatible : value should be either one among the following
-	(a) "samsung,mfc-v5" for MFC v5 present in Exynos4 SoCs
-	(b) "samsung,mfc-v6" for MFC v6 present in Exynos5 SoCs
-	(c) "samsung,exynos3250-mfc", "samsung,mfc-v7" for MFC v7
-	     present in Exynos3250 SoC
-	(d) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
-	(e) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
-	(f) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
-	(g) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
-
-  - reg : Physical base address of the IP registers and length of memory
-	  mapped region.
-
-  - interrupts : MFC interrupt number to the CPU.
-  - clocks : from common clock binding: handle to mfc clock.
-  - clock-names : from common clock binding: must contain "mfc",
-		  corresponding to entry in the clocks property.
-
-Optional properties:
-  - power-domains : power-domain property defined with a phandle
-			   to respective power domain.
-  - memory-region : from reserved memory binding: phandles to two reserved
-	memory regions, first is for "left" mfc memory bus interfaces,
-	second if for the "right" mfc memory bus, used when no SYSMMU
-	support is available; used only by MFC v5 present in Exynos4 SoCs
-
-Obsolete properties:
-  - samsung,mfc-r, samsung,mfc-l : support removed, please use memory-region
-	property instead
-
-
-Example:
-SoC specific DT entry:
-
-mfc: codec@13400000 {
-	compatible = "samsung,mfc-v5";
-	reg = <0x13400000 0x10000>;
-	interrupts = <0 94 0>;
-	power-domains = <&pd_mfc>;
-	clocks = <&clock 273>;
-	clock-names = "mfc";
-};
-
-Reserved memory specific DT entry for given board (see reserved memory binding
-for more information):
-
-reserved-memory {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-
-	mfc_left: region@51000000 {
-		compatible = "shared-dma-pool";
-		no-map;
-		reg = <0x51000000 0x800000>;
-	};
-
-	mfc_right: region@43000000 {
-		compatible = "shared-dma-pool";
-		no-map;
-		reg = <0x43000000 0x800000>;
-	};
-};
-
-Board specific DT entry:
-
-codec@13400000 {
-	memory-region = <&mfc_left>, <&mfc_right>;
-};
diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
index 000000000000..e82b143086ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/samsung,s5p-mfc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos Multi Format Codec (MFC)
+
+maintainers:
+  - Marek Szyprowski <m.szyprowski@samsung.com>
+  - Aakarsh Jain <aakarsh.jain@samsung.com>
+
+description:
+  Multi Format Codec (MFC) is the IP present in Samsung SoCs which
+  supports high resolution decoding and encoding functionalities.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - samsung,mfc-v5                  # Exynos4
+              - samsung,mfc-v6                  # Exynos5
+      - items:
+          - enum:
+              - samsung,exynos3250-mfc          # Exynos3250
+          - const: samsung,mfc-v7               # Fall back Exynos3250
+      - items:
+          - enum:
+              - samsung,mfc-v7                  # Exynos5420
+              - samsung,mfc-v8                  # Exynos5800
+              - samsung,exynos5433-mfc          # Exynos5433
+              - samsung,mfc-v10                 # Exynos7880
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+  interrupts:
+    maxItems: 1
+
+  iommus:
+    minItems: 1
+    maxItems: 2
+
+  iommu-names:
+    minItems: 1
+    maxItems: 2
+
+  power-domains:
+    maxItems: 1
+
+  memory-region:
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,mfc-v5
+              - samsung,exynos3250-mfc
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          items:
+            - const: mfc
+            - const: sclk_mfc
+        iommus:
+          minItems: 1
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,mfc-v6
+              - samsung,mfc-v8
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: mfc
+        iommus:
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos5433-mfc
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: pclk
+            - const: aclk
+            - const: aclk_xiu
+        iommus:
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,mfc-v7
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 2
+        iommus:
+          minItems: 1
+          maxItems: 2
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos4.h>
+    #include <dt-bindings/clock/exynos-audss-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    codec@13400000 {
+          compatible = "samsung,mfc-v5";
+          reg = <0x13400000 0x10000>;
+          interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+          power-domains = <&pd_mfc>;
+          clocks = <&clock CLK_MFC>, <&clock CLK_SCLK_MFC>;
+          clock-names = "mfc", "sclk_mfc";
+          iommus = <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
+          iommu-names = "left", "right";
+
+    };
-- 
2.17.1

