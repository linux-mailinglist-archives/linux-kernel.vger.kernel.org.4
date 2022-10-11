Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031755FBF91
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJLDrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJLDrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:47:33 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A5F796A9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:47:31 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221012034730epoutp032632eeb17748299af4f9beffbd721ad7~dNawcAv0D2700027000epoutp03H
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:47:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221012034730epoutp032632eeb17748299af4f9beffbd721ad7~dNawcAv0D2700027000epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546450;
        bh=KQA2k/ooP0X6HqqDcCu+dMgG5d+FuA71B4Z/y2XwyDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHIrkPI64do7jHzAZ8zImRabISNbgrWQlJnusYdxOG6yh4RMGU2a65Ruq647XmODc
         PFsXdDX15SqG0DoTQ+hoEK7u6/3zdWSNZoNw0+hhdbgrUH8mBW83njBf/7PnePccWa
         gJRcIFoPTAQWAOZkIjG7OV8mBiU0zhqEyeY/teFM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221012034729epcas5p207f37b5c9bd8158c601dbe57033f8976~dNavmEVGk1526715267epcas5p2B;
        Wed, 12 Oct 2022 03:47:29 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MnJWM13lbz4x9Q0; Wed, 12 Oct
        2022 03:47:27 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.1E.26992.EC836436; Wed, 12 Oct 2022 12:47:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca~dBMnQmnWt3163231632epcas5p1X;
        Tue, 11 Oct 2022 12:51:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221011125142epsmtrp1d972403c617995345b6bc46e2b9bca85~dBMnPheY32654526545epsmtrp1D;
        Tue, 11 Oct 2022 12:51:42 +0000 (GMT)
X-AuditID: b6c32a49-0c7ff70000016970-12-634638ce625f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.0D.14392.DD665436; Tue, 11 Oct 2022 21:51:41 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125138epsmtip1e7c289d1b3c2c222ad1ce0cdc6f672f0~dBMkIdScf2177321773epsmtip11;
        Tue, 11 Oct 2022 12:51:38 +0000 (GMT)
From:   aakarsh jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, smitha.t@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v3 01/15] dt-bindings: media: s5p-mfc: Add new DT schema for
 MFC
Date:   Tue, 11 Oct 2022 17:55:02 +0530
Message-Id: <20221011122516.32135-2-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0zTVxTHd39tfy0a9Ac4vUNAUsMEDNDO0l1YwQ2Z+y1uSyfZXMQIpfxs
        GaXt2iLMZJuCgKIIuC1CB5RRGAHksdIyYDB5l6lgyJxNJuVVFh5bmLwcDqNrKWz/fe73fM89
        5557L4vmPoF7spLkGkolF8nY+DZ6S2+Af9AwOirmFN0ToN9bixlooqwFR/q1GQyN65fpqKfZ
        xETG+9/QULW5i4F0fcMM9EP3FB19P2uPjhRb6WhG1wDQnHYMRwbbAwaanD+BfmkvwdHVJhMD
        1fdZmajKMoKh7wxPMVRhWmGirM4+JrJ2tAB0MbsPex2SN8tuArLVWglIS+USjWzTWpmkvmMO
        Iw21l3Fy9EEHTjZXfkFm9f9DJ68ZawH5LKOUSeb2WXBy2eBD3l5dZgp3nEwWSClRIqXypeRi
        RWKSXBLBPhYTdyQulM/hBnHD0KtsX7kohYpgR78jDDqaJLOPge17ViRLtUtCkVrNDokUqBSp
        GspXqlBrItiUMlGm5CmD1aIUdapcEiynNOFcDueVULsxPll6rXsBKE1h6eX3apnnQUZALnBh
        QYIH+y/dALlgG8ud+BFAQ2MO07lYAnDIXI85XO7EYwBvLQm2MoZ1DZjT1AngotaGO01ZGCxY
        3eNgnAiCt6q6NvRdxAUAbZc0jgQakUmH1rvrTEfAgzgOK0Yu0BxMJ/zgU9so3cGuRARczc+j
        O6vtg3VNXRseFyISLlYN4I6NIJHjAgdnf6M5TdFQn5mHO9kDzpuNTCd7wrn87E0WQ1vF3KZf
        Bhs7vtoscBh23S+xM8veXQBsbA9xyt7w69sNG6enETtg3vo05tRdYWvZFr8MS0bXGE72gr11
        VcDJJLySP09zTqgQwD/L6+gFwEf7f4lyAGrBS5RSnSKh1KFKrpxK++/WxIoUA9h46oFvtwLr
        xKPgHoCxQA+ALBp7lyvQRYndXRNFn56jVIo4VaqMUveAUPsAC2meL4oV9r8i18RxeWEcHp/P
        54Ud4nPZe1z1RYFid0Ii0lDJFKWkVFt5GMvF8zxWOjvgzzozPe42Iy2zdxl58tTe8Z7a1nTO
        w7feeLjgfcTvfV1LS97BDyzPx2pEU+9+pFvZzgILjJlOiVeRdqLgRMHO08nZ1UZO5rmI4qZT
        MXMvXN2POofe27/yc4NftKBx7Vv/u+Gmj5t3B/Iah3wSCn8Svjb5yLf0oOzKHAx6fGZo+zN9
        PYH9Ybw8nSCMPxBvWx+ejJWaDz15U+vmzTO63TGVDfZWZ+yeOmA+ljHe5jF90dS703L2r3Wv
        9sjR+vG9nKiE6/7PeWncsTrBr8LZYLcPeZbu0zeaP8MXY/XeaUWebbzrkk/6I/fFPok5bv4y
        /HB7VkhN+kDA34TLYE0UP+fO52y6WiriBtJUatG/DxerbnMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRfUyMcQDH+z333PM8nZVnl9avEnbDlIkm+pk6r62HMZm3eVm51XNXc9fl
        uZJaXnOsQ6xlqah0xRw1ruuFXlznIkYydJa7lCJFxVWyauFq/vtsn32/3z++FE+YjXtRsXEJ
        LBcnkYsIAV75WDRniU0aGrUsuykQfa7O4aOO/EoCaX/3YOijdghHpvIKEhne5vHQradGPiow
        N/NRVcMnHN3/+s++zrHhqKegDKDe3HYC6bta+aizbw968/AagS7cq+CjUrONRCWW1xi6qZ/A
        UFHFMInUdWYS2WorATpz1oythczd/LuAqbYVA8ZSbOcxD3JtJKOt7cUYvS6dYKyttQRTXnyC
        UTeO4UyGQQeYydPXSUZjthDMkH4O83xkiAx33ScIjmblsUdYbqn4oCAmo2EAxFesOlr4Skee
        BKd9NcCZgnQgbC4owzRAQAnpGgDbhsaIaTEb/jn7hJxmN3h7smeKhXQaBtVvQxxM0EvgoxIj
        4QjPotUAWm6nTzXx6Dwc/s408jWAotzocFje5+YI4PQCONFlxR3sQofAkUsX8emBufDOPSPP
        wc60GP4seUJMj4XAU4NXsMvAtRA46YAnG69SyBSqgPiAODbJXyVRqBLjZP5RSoUeTH3n51sN
        qnQ//E0Ao4AJQIonmuUCCtZHCV2iJckpLKeM5BLlrMoEvClc5OHSonkWKaRlkgT2EMvGs9x/
        i1HOXicxo/i9qW6RQhsaqVwM2vrrJ9Qr8sQan63nYGORcvMW1bVBY5jo0v4P0WPdwx6lYYFc
        Zu671EHteFDj47zjW86sWuvUtiH71pX2lvym0f7opHE23XvHnazelCO7L1+t8SqVWKuz/FZe
        d/+SuMs0kLbY7u8TUWY+WjI8LBBrug0D9U7bQqg9ReGu9esiTKKgjp0GakRtt6ctl0rHM3V7
        rd6BGaNhskl3/rrtycHwpdsbbyn9nfv6q3Rivnymcl5nqNSz8oDFnn1e841jV1yYIW1LsrKu
        CxuOpaSeWxPKdRnUnEfhi4aNq9Xt3TmSbfmbzst+7VSkmW90Bfs2bz7MJstFuCpGEuDH41SS
        v4BPiMEqAwAA
X-CMS-MailID: 20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Smitha T Murthy <smitha.t@samsung.com>

Convert DT schema for s5p-mfc in yaml format

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../devicetree/bindings/media/s5p-mfc.txt     |  75 --------
 .../bindings/media/samsung,s5p-mfc.yaml       | 163 ++++++++++++++++++
 2 files changed, 163 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml

diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
index aa54c8159d9f..8b137891791f 100644
--- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
+++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
@@ -1,76 +1 @@
-* Samsung Multi Format Codec (MFC)
 
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
-	(c) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
-	(d) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
-	(e) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
-	(f) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
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
index 000000000000..ad61b509846f
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
@@ -0,0 +1,163 @@
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
+  - Smitha T Murthy <smitha.t@samsung.com>
+  - Aakarsh Jain <aakarsh.jain@samsung.com>
+
+description:
+  Multi Format Codec (MFC) is the IP present in Samsung SoCs which
+  supports high resolution decoding and encoding functionalities.
+
+properties:
+  compatible:
+    enum:
+      - samsung,mfc-v5                  # Exynos4
+      - samsung,mfc-v6                  # Exynos5
+      - samsung,mfc-v7                  # Exynos5420
+      - samsung,mfc-v8                  # Exynos5800
+      - samsung,exynos5433-mfc          # Exynos5433
+      - samsung,mfc-v10                 # Exynos7880
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
+    maxItems: 2
+
+  iommu-names:
+    maxItems: 2
+
+  power-domains:
+    maxItems: 1
+
+  memory-region:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,mfc-v6
+              - samsung,mfc-v7
+              - samsung,mfc-v8
+              - tesla,fsd-mfc
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
+              - samsung,mfc-v5
+    then:
+      properties:
+        clocks:
+          minItems: 2
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
+              - samsung,exynos5433-mfc
+    then:
+      properties:
+        clocks:
+          minItems: 3
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
+              - samsung,mfc-v5
+              - samsung,mfc-v6
+              - samsung,mfc-v7
+              - samsung,mfc-v8
+              - samsung,exynos5433-mfc
+
+    then:
+      properties:
+        iommus:
+          minItems: 2
+          maxItems: 2
+        iommu-names:
+          items:
+            - const: left
+            - const: right
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - tesla,fsd-mfc
+    then:
+      properties:
+        memory-region:
+          maxItems: 1
+
+additionalProperties: false
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

