Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFC86CBD07
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjC1LGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC1LGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:06:17 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCE71FC4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:06:14 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230328110610epoutp044e623e67c1518f42a5b23959a198c1a2~QkIb7nlXM2110021100epoutp04j
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:06:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230328110610epoutp044e623e67c1518f42a5b23959a198c1a2~QkIb7nlXM2110021100epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680001570;
        bh=uLRIKpjy1cjR+tzuJXZX2wtKVkgTGTF7B4pcPMhLsMM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kLOV3RKAiZvmRh5ohthgTZnPRxXzMaR7zbTeAk90OvF8NSYuA6j0CVw0DorGpU1XU
         tr2tMNfy5/4DvLy3VbJzoeAztt+dijW4izAFN9r/dl7xL4SzWWaPPbCQEz/oka33xE
         NqNHqhn+kf7Bo2jV/yqfW1rhHwe7IH7P/hzR8Pbw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230328110609epcas5p2116571fb3160c9d9273565db0193019b~QkIbYlNmq2658426584epcas5p2v;
        Tue, 28 Mar 2023 11:06:09 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Pm6LS1jz6z4x9Pr; Tue, 28 Mar
        2023 11:06:08 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.26.55678.02AC2246; Tue, 28 Mar 2023 20:06:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230328110425epcas5p15549774de4c3a831d59cbe7e5a2c7961~QkG6IRaLG1043610436epcas5p1P;
        Tue, 28 Mar 2023 11:04:25 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230328110425epsmtrp2a5267fe96c653a88fbac425e27aa03b2~QkG6FwTlL2301123011epsmtrp2h;
        Tue, 28 Mar 2023 11:04:25 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-42-6422ca208b9c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.0E.31821.9B9C2246; Tue, 28 Mar 2023 20:04:25 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230328110422epsmtip1c41baa6bc333485c848c7463973b5d4d~QkG2_wYms1150311503epsmtip1y;
        Tue, 28 Mar 2023 11:04:21 +0000 (GMT)
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
Subject: [Patch v7] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Date:   Tue, 28 Mar 2023 16:34:19 +0530
Message-Id: <20230328110419.46722-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmuq7CKaUUg5Ur2S2e7pjJavFg3jY2
        i8U/njNZ3F/8mcXi0Oat7BZbrsxmtlh+/ACrxfwj51gtth98xGKx8QVQ9uLMuywWz+evY7R4
        Oesem0Xfi4fMFpseX2O1uLxrDptFz4atrBZrj9xlt1h6/SKTxbJNf5gsFm39wm7RuvcIu0VL
        2xEmB3GPNfPWMHrsuLuE0eP6kk/MHjtn3WX3WLznJZPHplWdbB53ru1h89i8pN6j9egvFo++
        LasYPbqOXGfz+LxJzuPU18/sAbxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
        Sgp5ibmptkouPgG6bpk5QN8rKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSK
        E3OLS/PS9fJSS6wMDQyMTIEKE7IzpvZ0MRbMcau4cWUaewPjbKMuRk4OCQETibPXl7CD2EIC
        uxkl3u0AsrmA7E+MEl+2bWCFcD4zSjxbdYINpuPNoSY2iI5djBLd3wohilqZJLpPfmfuYuTg
        YBPQlTi7PQekRkSgkVHicUcJSA2zQBeLRNeLg2DrhAWCJC4cWQA2iEVAVWJi5x0wm1fAVuLe
        islMEMvkJVZvOMAMYT/hkOjaowZhu0jsXPGJBcIWlnh1fAs7hC0l8fndXqhDkyUeL3oJ1Zsj
        sX7PFKh6e4kDV+awgNzJLKApsX6XPkRYVmLqqXVga5kF+CR6fz+BOoFXYsc8GFtNYs6dH6wQ
        tozE4dVLGSFsD4mFW7ZAwyRWYvqKY8wTGGVnIWxYwMi4ilEytaA4Nz212LTAKC+1HB5Nyfm5
        mxjBSVrLawfjwwcf9A4xMnEwHmKU4GBWEuHd7K2YIsSbklhZlVqUH19UmpNafIjRFBhkE5ml
        RJPzgXkiryTe0MTSwMTMzMzE0tjMUEmcV932ZLKQQHpiSWp2ampBahFMHxMHp1QD0zbbAgkZ
        Z0kBxePCxpxH5z771SX7ZHOL+TKTnE/nxHcYvp5YocV+LZj7tgv7BekEJ42ArwmqbLMStAs7
        w/U04r+9z9U5VNyb/vWWaYMfL+9Hjc3NrU4LFJdes7U/kFhbvmmffj6/kMy7QIeN67JeeOXc
        P5dyxMPy7vbWC/y+ZWcCw4NsvqoxxC0+3sWd7rqPedUrDf151bmebiINZ3T/ZbEeFWtZvszY
        OX3Ol68SJ3o37/SS1c9/pMXXUKhQ+CNRTNFLQ/V60CbTnxEWc00+dtxyi/QXipyzzSP4s4T6
        l1rfw7dsMp53sV3KCL7p9F+P88GkJZ7SNYl2Fg/+p5/9p+nzpFnHdGfbDmnleUosxRmJhlrM
        RcWJAMGtW3lbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnO7Ok0opBntv8Fg83TGT1eLBvG1s
        Fot/PGeyuL/4M4vFoc1b2S22XJnNbLH8+AFWi/lHzrFabD/4iMVi4wug7MWZd1ksns9fx2jx
        ctY9Nou+Fw+ZLTY9vsZqcXnXHDaLng1bWS3WHrnLbrH0+kUmi2Wb/jBZLNr6hd2ide8RdouW
        tiNMDuIea+atYfTYcXcJo8f1JZ+YPXbOusvusXjPSyaPTas62TzuXNvD5rF5Sb1H69FfLB59
        W1YxenQduc7m8XmTnMepr5/ZA3ijuGxSUnMyy1KL9O0SuDKm9nQxFsxxq7hxZRp7A+Nsoy5G
        Tg4JAROJN4ea2LoYuTiEBHYwSjRPOswOkZCR+N92DMoWllj57zk7RFEzk8S28x9Yuhg5ONgE
        dCXObs8BiYsItDJKXF/ZyQTiMAssYJFYvegEC0i3sECAxIwVe1lBbBYBVYmJnXfYQGxeAVuJ
        eysmM0FskJdYveEA8wRGngWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYLjRktr
        B+OeVR/0DjEycTAeYpTgYFYS4d3srZgixJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0
        xJLU7NTUgtQimCwTB6dUA1O/38oogwl79ax43vi9U5qraP1/UrNvm7ftefaLxtW+C1m9/yj2
        aCzZke3XeVkpIO3PzFkFXzbZuHA5fFOOW8wa1OcWXWSaoT77S8LyRsP3bqFiOoeXPTqpJ3Ze
        /fukOZNfT8n4canr+Zy+/49Dqh7mLw37I6m+leHxgyVCXgy1K1Z93F35/ODWO/4/Y0rK8mxv
        5ykyvxevdQ51rAjeeMM//fE0nlcuzyYv/xj8UmXXTmaf23si1L4/f3zmpaNf37x93e2Gls7f
        2Ta9ON0tv33CuzeRcSJCjaujK18l9FSt5H26c9d08ZfXBdul654YrrerZxF+cCBri9aZO6/F
        lBVmSCT+i2O8pLitQX32pq9KLMUZiYZazEXFiQACWvjRCgMAAA==
X-CMS-MailID: 20230328110425epcas5p15549774de4c3a831d59cbe7e5a2c7961
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230328110425epcas5p15549774de4c3a831d59cbe7e5a2c7961
References: <CGME20230328110425epcas5p15549774de4c3a831d59cbe7e5a2c7961@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert s5p-mfc bindings to DT schema format using json-schema.

Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
changes since v6:
kept hw properties for Exynos3250 and Exynos4 
under different if:then condition.

changes since v5:
kept compatible strings under enum
sorted compatible strings
added iommu maxItems:2
Added indentation with 4 spaces in dts example

changes since v4:
Removed items from oneOf section
dropped black line
defined the iommus names items as
items:
-const left
-const right

changes since v3:
fixed dt-schema warnings and errors while running make dtbs_check and make dt_binding_check for ARMv7
Since, obsolete properties are not part of dt-node so we are not including these properties in dt-schema.

changes since v2:
changed Commit message from Adds to Convert
Removed text "This file has moved to samsung,s5p-mfc.yaml" from s5p-mfc.txt
fixed dt-schema warnings and errors while running make dtbs_check and make dt_binding_check

changes since v1:
fixed dt-schema warnings and errors while running make dtbs_check and make dt_binding_check
Removed description.
Listed items.
Added allOf:if:then for restricting two items to specific compatible

This patch is independent from the previous MFC v12 patch series for HW3 support.
 .../devicetree/bindings/media/s5p-mfc.txt     |  78 --------
 .../bindings/media/samsung,s5p-mfc.yaml       | 184 ++++++++++++++++++
 2 files changed, 184 insertions(+), 78 deletions(-)
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
index 000000000000..084b44582a43
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
@@ -0,0 +1,184 @@
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
+      - enum:
+          - samsung,exynos5433-mfc        # Exynos5433
+          - samsung,mfc-v5                # Exynos4
+          - samsung,mfc-v6                # Exynos5
+          - samsung,mfc-v7                # Exynos5420
+          - samsung,mfc-v8                # Exynos5800
+          - samsung,mfc-v10               # Exynos7880
+      - items:
+          - enum:
+              - samsung,exynos3250-mfc    # Exynos3250
+          - const: samsung,mfc-v7         # Fall back for Exynos3250
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
+          maxItems: 1
+        iommus-names: false
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
+        iommus-names:
+          items:
+            - const: left
+            - const: right
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,mfc-v5
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          items:
+            - const: mfc
+            - const: sclk_mfc
+        iommus:
+          maxItems: 2
+        iommus-names:
+          items:
+            - const: left
+            - const: right
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
+        iommus-names:
+          items:
+            - const: left
+            - const: right
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
+        compatible = "samsung,mfc-v5";
+        reg = <0x13400000 0x10000>;
+        interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&pd_mfc>;
+        clocks = <&clock CLK_MFC>, <&clock CLK_SCLK_MFC>;
+        clock-names = "mfc", "sclk_mfc";
+        iommus = <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
+        iommu-names = "left", "right";
+    };
-- 
2.17.1

