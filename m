Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA0A6CC200
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjC1OYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjC1OYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:24:41 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2910CA260
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:24:36 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230328142432epoutp025c2a2c3176ea1eb5c93eab77b3e6ff33~Qm1o1w-wc2281922819epoutp02R
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 14:24:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230328142432epoutp025c2a2c3176ea1eb5c93eab77b3e6ff33~Qm1o1w-wc2281922819epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680013472;
        bh=V980h8LEVAH7v5xTJP3iTtznj/zOhEDcr2XJMd0tXB0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BGziA7qsEUziLmGG3OfL8tQXj+4BbP0jjMoy7HdPAhachqTJwimtBOQl+FZNnl83U
         GRZgdSgE9Q8iPlBHdX1v8056rBUuLtNK4ZjXdozkTueZ56qK/UoOhPAzwCxR2cWlqG
         zN2j8B4BooSs1NtaHkyZGV+N27tGJDJsK08wW/bM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230328142431epcas5p11a3fbae7e78223f1df386dc2dda5b6d9~Qm1oAOSOG1172711727epcas5p1H;
        Tue, 28 Mar 2023 14:24:31 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PmBlL1Cxjz4x9Pr; Tue, 28 Mar
        2023 14:24:30 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.D4.55678.D98F2246; Tue, 28 Mar 2023 23:24:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230328114738epcas5p475b8fa1d1e86bbb86d004afe365e0259~Qksou_lIK2683626836epcas5p4J;
        Tue, 28 Mar 2023 11:47:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230328114738epsmtrp2fd6c145e4d26ebdb7dd20fd032ea2f62~Qksosbhbm1607416074epsmtrp2o;
        Tue, 28 Mar 2023 11:47:38 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-30-6422f89d84cf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.90.31821.9D3D2246; Tue, 28 Mar 2023 20:47:37 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230328114733epsmtip2d83f080a32905f74d0b62e2b635f4cdf~QkskpBhXi2498624986epsmtip2E;
        Tue, 28 Mar 2023 11:47:33 +0000 (GMT)
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
Date:   Tue, 28 Mar 2023 17:17:29 +0530
Message-Id: <20230328114729.61436-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTa0xbZRjO19OedmSVIwP5bIThie7SBUaxwIeusux6IpviZnAal+6kPRSk
        nHZtEdxixkC2gYOJ29iA2hEuM2HcLNcVUFa6QEk2LiLoXCeMyaU/CK4QqgixUNB/z/s8z5v3
        eb+LAPPrw0WCZNbA6FhaTeI+3JbuneJQk5tUhl87i/5oK+ahMVMLjircUxz0e4WLi6yNzXzU
        NFyKoe96unjolu0hD7Xee8pF30971MFiBxdN3aoDaKbkCY4KpscxZJ4Y4aGfLEYcXW5o5qFa
        m4OPqkYHOei2+R8OKm+e56OcThsffXnBxtkbSNWYagDV5qgE1Gjlc4y6W+LgUxUdMxzKXJ2L
        U49HOnCqsfIclXP/by5V0FQNqDzbKE65zMFU34KLHy/8OGVPEkMrGV0Iwyo0ymRWJSPjjsv3
        yyOjwiWhkhgUTYawdCojIw8ciQ89lKz2LE+GfEar0zxUPK3Xk7vf3qPTpBmYkCSN3iAjGa1S
        rZVqw/R0qj6NVYWxjOFNSXh4RKTHeCol6XLRIqZ9cjDD0ViKZYJpSR7YJICEFBbVXsXzgI/A
        j2gH8FKdDXiL5wBmW9w8b+ECsKz5Jnej5ZuFgXWXBUDjygPMW+Rw4LfGQo9LIMCJUPigVb3a
        4E+cB3DikmHVgxF5XJg3fY+/KmwhjsEBWxm+irnE63C8rJWzioWEDA6suHjeaVvhnYautQGQ
        eCaAtwt+BF7hAKyqtfG9eAt09jStYxF0zXbiXqyAE+UzmBerYX3HtfUVYmHXsHEtKEbshPWW
        3V46CF7vq1vLgBEvwPylZxwvL4Rtpg28DRofu9ezvQK771Stx6Fg+VDjGu9HnIQ/L/6KfQ2C
        Sv6fUAZANXiZ0epTVYw+UhvBMun/3ZRCk2oGa49a/E4bGB+bC7MCjgBYARRgpL9waYRU+gmV
        9OdnGJ1GrktTM3oriPScWSEmClBoPL+CNcgl0phwaVRUlDTmjSgJGSjcLrMr/AgVbWBSGEbL
        6Db6OIJNokwOmRiM9/aa5ccPD8dL5k6QzndHjp19y3K93jf2q4UMzZmEw0/vJkzGy7o77+er
        fjm1rTg44OCfTn/f+fnN+T68ivL02b+y8AtDAUmmL7DS0lnxwPvN2QWZYbukBVNy69z5jCw1
        L7bnxIhdaPowe9iRY1Pt637RWb3cuMtpLRclttsIe6TzpU9qPl10X6VffU3T1xP9yB0dFicd
        UFCbFyZvKCLcO670PEpoilAxV5aHxnUZp7OCPrixr0ws9pldGdsReJKt+KHbvj33YkO/73uH
        7KKj/ktdRb3pufb+rsL9K8am37BiqfSceGvi8umLLWz74N7EkiMPqy0qS1zLR5P9NXaSq0+i
        JWJMp6f/BSzTKb1dBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSvO7Ny0opBte2mVs83TGT1eLBvG1s
        Fot/PGeyuL/4M4vFoc1b2S22XJnNbLH8+AFWi/lHzrFabD/4iMVi4wug7MWZd1ksns9fx2jx
        ctY9Nou+Fw+ZLTY9vsZqcXnXHDaLng1bWS3WHrnLbrH0+kUmi2Wb/jBZLNr6hd2ide8RdouW
        tiNMDuIea+atYfTYcXcJo8f1JZ+YPXbOusvusXjPSyaPTas62TzuXNvD5rF5Sb1H69FfLB59
        W1YxenQduc7m8XmTnMepr5/ZA3ijuGxSUnMyy1KL9O0SuDJ6pn1nLrjnWnF382zmBsYXhl2M
        nBwSAiYSk75eYOxi5OIQEtjBKLFs53k2iISMxP+2Y+wQtrDEyn/P2SGKmpkkfvydANTBwcEm
        oCtxdnsOSFxEoJVR4vrKTiYQh1lgAYvE6kUnWEC6hQUCJGas2MsKYrMIqEo8XLCdCcTmFbCV
        uPDvMyvEBnmJ1RsOME9g5FnAyLCKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4brS0
        djDuWfVB7xAjEwfjIUYJDmYlEd4SYGwJ8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9
        sSQ1OzW1ILUIJsvEwSnVwMT8ofB/8eo1u/LvO8xOSbparmNQ2CNqsvLtBPFFiTtXy3yN7kn0
        CJeZnfl5V9fbuVf3txgeDpx7vTqb7U6t1UtWtZXiUze7HD82YcvOwoYFq7q+6fq79H7XbxOW
        yVm0aYGgTGGIyMmQMwH6bVNdEzeei3VWPnOy5HDjlUWfrNZaPDjzPWiPeqbg/x7df1Py2W98
        9xA0SVr0ReCSMud1P3MH8+rEXXdVRR+X/nMrjvuiZyeVtq/r0cGlNQcWX5TUl6qKjWU5M/9+
        yVXF/aJ3BNWvzXlX9HPxHLO+M2/N84UDDx/3Orb7nXa8RtTsddXqyhJXWeae8jBySudW6qnb
        5RCZPMvIsfzBnMvlrmLvjiuxFGckGmoxFxUnAgBmp70WCgMAAA==
X-CMS-MailID: 20230328114738epcas5p475b8fa1d1e86bbb86d004afe365e0259
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230328114738epcas5p475b8fa1d1e86bbb86d004afe365e0259
References: <CGME20230328114738epcas5p475b8fa1d1e86bbb86d004afe365e0259@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
new file mode 100644
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

