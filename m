Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0D06C5288
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCVRfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCVRfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:35:15 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028025C104;
        Wed, 22 Mar 2023 10:35:10 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-177b78067ffso20156949fac.7;
        Wed, 22 Mar 2023 10:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oO1r+1wOZPdRmVHFSgMXfniQwXiQpryzfNXnQDmnsok=;
        b=qk5vxbnSKM3NmOe7EBhOxK3LEUN6utfcr3pUJD0I1ZetiqNTikDUHFLHsWv/AlNj/t
         lzUKYlDB1wLPXKKGTdLT2z+Y8sUMRkApREMh4w806S1ANmofBSJKo0SIM+6tLm12syen
         G0ciCsT6KjKHCs80lgS0ezqAmKJDP/1Beu0M9lqe1UVuzItcSZL1QyNvU9QVPBYH2XGK
         H1vDKyDDspruVDRmsLZ9rhDp4+csmQXBRmS1GMx302i8k5Lm35AAaGkZX7jE911nU0WQ
         HRsBGQgs8pS9qFnVan5Alt/HOspDJ4A57uLY0m2DY4tWUd/jMBDg+TX+7ianbNw16QRt
         ipHQ==
X-Gm-Message-State: AAQBX9e0o78vqymOoz7O2PM2emQ7H7YggVcoQ+byFUkoPbWNnXRUOr9A
        cG3MmxygyOdtIDK0SD+1kg==
X-Google-Smtp-Source: AKy350aJQ/zu7y+zv9sL8buQx6HyBBrINb9iplEr6ICsp6AZ6NaLtLRQHTohfmvE7kyL2L6Fqk+mRw==
X-Received: by 2002:a05:6871:706:b0:177:c72a:a9cd with SMTP id f6-20020a056871070600b00177c72aa9cdmr453896oap.13.1679506509996;
        Wed, 22 Mar 2023 10:35:09 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ug21-20020a0568714d1500b0017af6149e61sm5437878oab.21.2023.03.22.10.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:35:06 -0700 (PDT)
Received: (nullmailer pid 3971125 invoked by uid 1000);
        Wed, 22 Mar 2023 17:35:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: arm/soc: mediatek: Drop unneeded quotes
Date:   Wed, 22 Mar 2023 12:34:59 -0500
Message-Id: <20230322173501.3970991-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml   | 4 ++--
 .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml      | 4 ++--
 .../bindings/arm/mediatek/mediatek,mt7622-pcie-mirror.yaml    | 4 ++--
 .../devicetree/bindings/arm/mediatek/mediatek,mt7622-wed.yaml | 4 ++--
 .../bindings/arm/mediatek/mediatek,mt7986-wed-pcie.yaml       | 4 ++--
 .../bindings/arm/mediatek/mediatek,mt8186-clock.yaml          | 4 ++--
 .../bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml      | 4 ++--
 .../bindings/arm/mediatek/mediatek,mt8192-clock.yaml          | 4 ++--
 .../bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml      | 4 ++--
 .../bindings/arm/mediatek/mediatek,mt8195-clock.yaml          | 4 ++--
 .../bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml      | 4 ++--
 .../devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml    | 4 ++--
 Documentation/devicetree/bindings/soc/mediatek/devapc.yaml    | 4 ++--
 13 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
index e997635e4fe4..ea98043c6ba3 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,infracfg.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,infracfg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek Infrastructure System Configuration Controller
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
index d1410345ef18..536f5a5ebd24 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mmsys.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mmsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek mmsys controller
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pcie-mirror.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pcie-mirror.yaml
index 9fbeb626ab23..d89848a8f478 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pcie-mirror.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pcie-mirror.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt7622-pcie-mirror.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7622-pcie-mirror.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek PCIE Mirror Controller for MT7622
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-wed.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-wed.yaml
index 5c223cb063d4..efcdc4449416 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-wed.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-wed.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt7622-wed.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7622-wed.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek Wireless Ethernet Dispatch Controller for MT7622
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7986-wed-pcie.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7986-wed-pcie.yaml
index 96221f51c1c3..82f64469a601 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7986-wed-pcie.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7986-wed-pcie.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt7986-wed-pcie.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7986-wed-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek PCIE WED Controller for MT7986
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
index cf1002c3efa6..7cd14b163abe 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-clock.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek Functional Clock Controller for MT8186
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
index 661047d26e11..64c769416690 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-sys-clock.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-sys-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek System Clock Controller for MT8186
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
index b57cc2e69efb..dff4c8e8fd4b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8192-clock.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8192-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek Functional Clock Controller for MT8192
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml
index 27f79175c678..8d608fddf3f9 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8192-sys-clock.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8192-sys-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek System Clock Controller for MT8192
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
index d62d60181147..d17164b0b13e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-clock.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek Functional Clock Controller for MT8195
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
index 95b6bdf99936..066c9b3d6ac9 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-sys-clock.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-sys-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek System Clock Controller for MT8195
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
index ef62cbb13590..26158d0d72f3 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,pericfg.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,pericfg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek Peripheral Configuration Controller
 
diff --git a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
index d0a4bc3b03e9..99e2caafeadf 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
@@ -2,8 +2,8 @@
 # # Copyright 2020 MediaTek Inc.
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/soc/mediatek/devapc.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/soc/mediatek/devapc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek Device Access Permission Control driver
 
-- 
2.39.2

