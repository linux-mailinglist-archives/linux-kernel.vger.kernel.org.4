Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BF46A3E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjB0JO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjB0JOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:14:11 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18EE65A4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:07:11 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230227090708epoutp04337ef93df8bb99210a9fe61fcb19765f~HozPAMmnW2231422314epoutp04N
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:07:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230227090708epoutp04337ef93df8bb99210a9fe61fcb19765f~HozPAMmnW2231422314epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677488828;
        bh=GcC728ZJBF/qRatNWquihSzkmxihf6LSYIUW6SKVvXw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VQGN5Au9oOY+0/S8axXmFgNZFin9/RarIEXN+Yu7v7Yy98JUsAC8vsXp9aFtNwS2s
         mB0ArWQhBHQpBJWAve9Vfb0PaxNX/F53VBQITNuG1SqvLP3J+xPoKwkPr8aoBI3JIe
         zT/YsTJheNTLvOWtITZp0lE0v+LKU3Rz4H5mRt84=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230227090708epcas5p447230e3115e46354016862898ce30d56~HozOZjz3D3001530015epcas5p4I;
        Mon, 27 Feb 2023 09:07:08 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PQF4V48qCz4x9QC; Mon, 27 Feb
        2023 09:07:06 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.A7.06765.AB27CF36; Mon, 27 Feb 2023 18:07:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230227084748epcas5p2602a39017d3366bdfb5af95088ed89dc~HoiV7i8140056800568epcas5p2D;
        Mon, 27 Feb 2023 08:47:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230227084748epsmtrp160012d04d53fde53f181d53b2b23a429~HoiV39A3b2498824988epsmtrp1g;
        Mon, 27 Feb 2023 08:47:47 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-4e-63fc72ba5c41
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.53.17995.33E6CF36; Mon, 27 Feb 2023 17:47:47 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230227084744epsmtip2ae3d3948fd93a167a7495f705bd17b83~HoiS2jcvb0614606146epsmtip2h;
        Mon, 27 Feb 2023 08:47:44 +0000 (GMT)
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
Subject: [Patch v5] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Date:   Mon, 27 Feb 2023 14:17:36 +0530
Message-Id: <20230227084736.89361-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTa0xTZxjOd87padF0O1YI38hkXTNncCm0WsoHsw6HwzNxE2T+cGbDrhwp
        obS1pwxZdikymHS22wJzigQUEBUvQAFBhgk3ZeAwuCEF1nIn3JJN6FQCmK21sP173ud53u95
        vxsPF3SSAbxkrZExaJUaEbmOuNkWtEXcaFhRSQYtgWiy4SwHjRTdJFHp4hSGhktdBGqtqeOi
        2t5zOLrU0cxBxe33Oai+ZYxA1dNu9cFZJ4Gmim8ANFMwRCLr9CiObON9HPR7YyGJTlXVcdD1
        dicXXbQ/wFC5bQVDJXV/c1H27XYu+jqnHYv0p68VXQN0g7MM0PayBZy+VeDk0qVNMxhtq8gl
        aUdfE0nXlH1FZ99ZImhrbQWgze12knbZAumuxy5uLP/DlB1qRpnIGISMVqVLTNYmKUQx8QlR
        CaFyiVQsDUdhIqFWmcooRLv3xYqjkzXu3YuEnyo1aW4qVsmyopCdOwy6NCMjVOtYo0LE6BM1
        epk+mFWmsmnapGAtY4yQSiTbQt3GIynq7v4JTL+iOH57bp40gR6xGfjwICWDJa29XDNYxxNQ
        PwP4h+kK5i0WADRNjnC8hQvA/Mv38LWW2eou3Cs0AmgxLZDeIhuDzpxHboXHIykx7K7XeBp8
        qUwAx08aPR6cMhPQPN3C9QgbqQNwNLuQ9PgJajN8OC/z0HxKAWvy81bDXoFXq5qfh0FqmgcX
        e5o4XmE3rP/GtmraCGc7arleHABnvstZxSo4XjKz6tHAyqZ8wovfgs29hYQnF6eCYGVjiJfe
        BH/suoF5ME69AC3LE5iX58OGojX8Oix0LK6O8DJsu3oReJaBFA2HBxkPLaA+gjMDTuJ7sKng
        /4DzAFSAlxg9m5rEsKH67Vom/b97UulSbeD5m94a0wDGRh4FtwKMB1oB5OEiX76jc1El4Ccq
        Mz5jDLoEQ5qGYVtBqPvEfsAD/FQ696fQGhOksnCJTC6Xy8K3y6Uif/4WRadKQCUpjUwKw+gZ
        w1ofxvMJMGEnWPv7ew7Pjjw9UX44THX88t4D0bqQ/sw3O1K3JUzWxz7NieK0DC9xu/xNy+Z9
        X2x4O7Dz43LKchpcWJl8L63t6Mh9i++ef5QlLxobD5Lrq/17+u5GnVl4PHrlHcm9iNwMjbX/
        2FC688kzIPx2LCirf74Ta5gOjJubii9d0lhfy8B/irb3bc4MTr/eNK9+91Bk9wdfugjpwLk3
        dvLlaJfD4hoElVNxk5/7aHT7HfER2XN/Lj2xi9HiL4eCFtSWY3cHsoS5+dyJSwK27Mj+h0Vn
        fq2yrs86+UwY+Ulbxfm4GGum5dXlO8WOvi7fo36//WXM97slPpiXJ9kQtqu+sra340L3kIhg
        1UrpVtzAKv8F+c53MVwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSvK5x3p9kg219ZhZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzaLvxUNmi02Pr7FaXN41h82iZ8NWVou1R+6yWyy9fpHJYtmmP0wWi7Z+Ybdo3XuE3aKl
        7QiTg7jHmnlrGD123F3C6HF9ySdmj52z7rJ7LN7zkslj06pONo871/aweWxeUu/RevQXi0ff
        llWMHl1HrrN5fN4k53Hq62f2AN4oLpuU1JzMstQifbsEroyzN54wFfyxrdj7+iNbA+MF3S5G
        Tg4JAROJVxtPMXcxcnEICexglLi89xsjREJG4n/bMXYIW1hi5b/n7BBFzUwSuxeuY+pi5OBg
        E9CVOLs9ByQuItDKKHF9ZScTiMMssIBFYvWiEywg3cICARL3H25mA2lgEVCVuPrRBCTMK2Ar
        sXnKZGaIBfISqzccYJ7AyLOAkWEVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZw1Ghp
        7WDcs+qD3iFGJg7GQ4wSHMxKIrx3Tv5IFuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBA
        emJJanZqakFqEUyWiYNTqoGptOzY546dusef8n6fJTG9ZwaPoNjMTQv2TUne0qUqXy/hJ9h9
        0+omT/X2dvb9Rkkps0L52DeG6+d/W/P03K1nj6S/Jz0rmJl4faYOR7PWkoyvMWKbjmq9uX/y
        bHNRf9sNhY3LNuixfbz5/tGxPRxVUZt9+0Inrn7y+Lr4Sz75Lo3DDyQnx0S8m3CSwXJBq2zB
        lqnz7+adf5n/8N6pDz52eee8rWd8u712Vt7NXpvZh+bl33vksXqdHlvNGS/H5nVPhUT/Vs26
        sK9iQoNkivzKK24BZ9KPHlf8IB5Yuz12+x/RL3dnJv9rrbrts2h59Vwu+RW7/91WS+2ynWhw
        +ZwW0zn296ff/JR/7HiktVo6LFiJpTgj0VCLuag4EQCeSHp4CQMAAA==
X-CMS-MailID: 20230227084748epcas5p2602a39017d3366bdfb5af95088ed89dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230227084748epcas5p2602a39017d3366bdfb5af95088ed89dc
References: <CGME20230227084748epcas5p2602a39017d3366bdfb5af95088ed89dc@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert s5p-mfc bindings to DT schema format using json-schema.

Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
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

 .../devicetree/bindings/media/s5p-mfc.txt     |  78 ---------
 .../bindings/media/samsung,s5p-mfc.yaml       | 148 ++++++++++++++++++
 2 files changed, 148 insertions(+), 78 deletions(-)
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
index 000000000000..b4a289619db0
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
@@ -0,0 +1,148 @@
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
+          - samsung,mfc-v5              # Exynos4
+          - samsung,mfc-v6              # Exynos5
+      - items:
+          - enum:
+              - samsung,exynos3250-mfc  # Exynos3250
+          - const: samsung,mfc-v7       # Fall back for Exynos3250
+      - enum:
+          - samsung,mfc-v7              # Exynos5420
+          - samsung,mfc-v8              # Exynos5800
+          - samsung,exynos5433-mfc      # Exynos5433
+          - samsung,mfc-v10             # Exynos7880
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
+    items:
+      - const: left
+      - const: right
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
+    };
-- 
2.17.1

