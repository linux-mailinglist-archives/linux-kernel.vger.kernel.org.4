Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000F36A66E7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCAEJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCAEJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:09:47 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CA9AD1A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:09:42 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230301040940epoutp020c8c79f9cbf71fc5e1d55bfae475b4b6~IMCEh5n0J2293122931epoutp02u
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:09:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230301040940epoutp020c8c79f9cbf71fc5e1d55bfae475b4b6~IMCEh5n0J2293122931epoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677643780;
        bh=oa1zlwQREIUVUsvZU420fB6kCs0XuPudJ7j/zfwto3Q=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MtLvgKlsknD7PtfIZRn+7lkAixrMC/G/RB79OM/pApkrtPRtylrvmq/p91BhnPGGe
         +lFENqIscMv7OEKl83jubJeWEHEcH/x217pV1Hvzqg7x8rqNccSSncZGDryuBepHg1
         sjdrGrntTD6YbQodjcB6JTee59P0rbDlb2bLjBMo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230301040939epcas5p477e95069d82001f5e3afcb0906ae2b06~IMCD7h23u0620606206epcas5p4T;
        Wed,  1 Mar 2023 04:09:39 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PRLNG3kbJz4x9Pv; Wed,  1 Mar
        2023 04:09:34 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.B5.06765.CFFCEF36; Wed,  1 Mar 2023 13:09:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230301035153epcas5p40f576188a9a69835c1050135219a3720~ILyjUbhrY2208222082epcas5p4s;
        Wed,  1 Mar 2023 03:51:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230301035153epsmtrp18bf3e9e8e36eb649b7e3e56b4ac24c5e~ILyjSO3rA1049610496epsmtrp1z;
        Wed,  1 Mar 2023 03:51:53 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-62-63fecffc75f2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.E8.17995.9DBCEF36; Wed,  1 Mar 2023 12:51:53 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230301035150epsmtip1c10cc6416085c69ecc9c1d5d4f299cc3~ILygSSuHe2131721317epsmtip1z;
        Wed,  1 Mar 2023 03:51:50 +0000 (GMT)
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
Subject: [Patch v6] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Date:   Wed,  1 Mar 2023 09:21:44 +0530
Message-Id: <20230301035144.8645-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xbVRzHc+5t772QFa+wuSODyRoGwtLSQmEHpcwJWe6CJGQj0xB5NOUK
        hNLWPraJyUBcETqeAzQggzFANoYDOt5Dx8uAbIpEhAR5TMrC08cGKCKK7Qr63+f3/f2+53fO
        75xD4Y5DhDOVpNSxGqVMwSfsOW39Xp6C7ZF/5KKt7CPocUcpFz2qaCNQ9eYChmar1zio724r
        iVrGPsVR3WAPF1UOfMtF7b1zHNS8aMmOlk5z0ELlHYCWymYIlLf4E45M5nEu+r6rnEA5Ta1c
        9PnANIlqJ0Yx9JlpG0M3WtdJZPhigESXMwew1w4yDRUNgOmYrgHMRM1TnOksmyaZ6u4ljDHV
        ZxPM1Hg3wdytSWMMX21xmLyWesAYByYIZs10mBneWCMjeFHJQYmsLJ7VuLFKuSo+SZkg5Yed
        jQ2J9Q8QiQXiQHSc76aUpbBSfugbEYJTSQrL6flu52UKvUWKkGm1fJ/gII1Kr2PdElVanZTP
        quMVaolaqJWlaPXKBKGS1b0iFol8/S2FccmJWas1QD114uLkyCZIB78IjcCOgrQEbnySixuB
        PeVI3wOwuLQeswVPAay4ngOsVY70GoCZ1c/vOQqqmnYdXQBW5pgIW2DAYNaHK6QRUBRBC+A3
        7QqrYT/9AYDmLJ21BqeNHGhc7CWtCSf6DHzYnMGxMoc+CufWr2BW5tFBcPXB77it20vwdlPP
        Ls9T0DzDWteHdCis/TjcJjvB5cEW0sbOcCk/c5fl0HxjadeqgI3dxRwbn4A9Y+Uc6zI47QUb
        u3xssissGb7zbAc47QBz/5rHbDoPdlTssQcsn9rk2tgF9t+uBTZm4Pb8CNc2q2jY3VdEFgDX
        sv87XAegHrzIqrUpCazWX+2nZC/8d01yVYoJPHvS3mEdYO7Rb8I+gFGgD0AK5+/nVf24LXfk
        xcveS2U1qliNXsFq+4C/ZWKFuPMBucryJ5S6WLEkUCQJCAiQBPoFiPkHeZ7Sr+WOdIJMxyaz
        rJrV7Pkwys45HXv7sUE692rktPFCFOiMjj1ZNNk/84d3RkTRk4mTC6tPrikl0aUP9hUujt9M
        KElffeHl4R1yyA5SzctDeHjDgWY/of2Yd7DDZf/ZP1Pdo945Wtgbv9x0c+Vc5z6P1B1FneT0
        5KZ0KS3dePXc4VqHSyHrbVjutcn7TNWOT2Tv2VMx6rcU/Yc8f84PzY9rPKY2qu/n3cqIcVl9
        fTs4zsld4/tDr1qop45/Zxb4pm1myz30OcEXR55zNo/F9EQSowUuvvb5K63H6iYPtS/+Ktee
        Od/RVtZUjJYfXhJUuRoQ6U14+b279ZHh3ka4hnGPWRUNzpac5oVdSa0M+fvNLyOLum69f4TP
        0SbKxN64Riv7F2N7SehbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnO7N0/+SDRomS1k83TGT1eLBvG1s
        Fot/PGeyuL/4M4vFoc1b2S22XJnNbLH8+AFWi/lHzrFabD/4iMVi4wug7MWZd1ksns9fx2jx
        ctY9Nou+Fw+ZLTY9vsZqcXnXHDaLng1bWS3WHrnLbrH0+kUmi2Wb/jBZLNr6hd2ide8RdouW
        tiNMDuIea+atYfTYcXcJo8f1JZ+YPXbOusvusXjPSyaPTas62TzuXNvD5rF5Sb1H69FfLB59
        W1YxenQduc7m8XmTnMepr5/ZA3ijuGxSUnMyy1KL9O0SuDI63ixhLLhjX3Hr/A/GBsZ3el2M
        nBwSAiYSExZuYO5i5OIQEtjBKLF2639WiISMxP+2Y+wQtrDEyn/P2SGKmpkkVq+cBdTBwcEm
        oCtxdnsOSFxEoJVR4vrKTiYQh1lgAYvE6kUnWEC6hQUCJJrvTACbyiKgKvHoSzcTiM0rYCPx
        5vQ3ZogN8hKrNxxgnsDIs4CRYRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnDcaGnt
        YNyz6oPeIUYmDsZDjBIczEoivAtv/0kW4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6
        YklqdmpqQWoRTJaJg1OqgcnxWdc5X/mg81eCivPbtU1ydEo4vk1bdrHoWZbMDy2lOP/e4m81
        m6P1lf7dyZts93/a+rj91jlM3RWVmSIuQrd1Tytsm7LInLfSX2CrtOP24yqHzzoxvXwecS3Q
        R2zyFe1UZsELDb+uFVxboGNvbhQvHbr6Wv5vjYtHmNq/fDvDH7bwCavSbJk53OpFe/KeLp36
        0qqhL+9+afErhdtrTatzckxir8x+/Pctv4vOX6FlLf5bRQrPH/djf8u8y3f+5YcLtt9Ws1Ka
        w80k+fzm/HefbMROzphxX3Bp2Y2nvzSMb00S81zB1Sdw5xJTBVdxT+SKeTrt9+UniL7JU2QX
        +/btzWyZ9/Kr96+w37jt6DolluKMREMt5qLiRACwhA6OCgMAAA==
X-CMS-MailID: 20230301035153epcas5p40f576188a9a69835c1050135219a3720
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230301035153epcas5p40f576188a9a69835c1050135219a3720
References: <CGME20230301035153epcas5p40f576188a9a69835c1050135219a3720@epcas5p4.samsung.com>
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

 .../devicetree/bindings/media/s5p-mfc.txt     |  78 ---------
 .../bindings/media/samsung,s5p-mfc.yaml       | 151 ++++++++++++++++++
 2 files changed, 151 insertions(+), 78 deletions(-)
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
index 000000000000..da48d0493cdd
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
@@ -0,0 +1,151 @@
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

