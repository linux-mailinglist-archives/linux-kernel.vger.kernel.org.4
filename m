Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B040D625C12
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiKKN7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiKKN7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:59:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3128B2F6;
        Fri, 11 Nov 2022 05:55:50 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 30BF46602A5C;
        Fri, 11 Nov 2022 13:55:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668174943;
        bh=Zf7m6jLp2JACg2AkUZYo4eLC63C+UuS3mbPUkyrlclQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPprOpb8mi3DmWEWvZ12B4yp7ibqJPZBoEBxhEIVSFmWqYAPhsNyS+8YW/Gqa4sP+
         u3pKvDOTYeS6M53Ui+0IilQ46cSjbkzd+qAmyDakpo/zaX6Jid4O+/NfWyHhjEEH0G
         AgChFR0zIvF0JO8LiO8Vmru5hqTLL75ATuJyWPD52NFIXtEj/9l8mxxIZOSuYQUacX
         hpgXR4av8vVXYu8GnQ6nxfdnE8CYNA+U5mtv079QyWCjy6vqCT+XBlTgBOxIu7oXEh
         nzOSIp7+mm6dvD3wCNrskSh53FzdTf1WSR+5O+LU2W6RuH80GtBOTw8KfzGbPEvUPm
         Wpqsi3OISLNFw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz, a39.skl@gmail.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 5/7] dt-bindings: iommu: qcom,iommu: Document QSMMU v2 compatibles
Date:   Fri, 11 Nov 2022 14:55:23 +0100
Message-Id: <20221111135525.204134-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111135525.204134-1-angelogioacchino.delregno@collabora.com>
References: <20221111135525.204134-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings for "qcom,msm-iommu-v2" for the inner node,
"qcom,msm-iommu-v2-ns" and "qcom,msm-iommu-v2-sec" for the context
bank nodes to support Qualcomm's secure fw "SMMU v2" implementation.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
index 7d4e0a18b08e..b762772f80e7 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -11,7 +11,10 @@ to non-secure vs secure interrupt line.
 
                         "qcom,msm8916-iommu"
 
-                     Followed by "qcom,msm-iommu-v1".
+                     Followed by one of:
+
+                        - "qcom,msm-iommu-v1"
+                        - "qcom,msm-iommu-v2"
 
 - clock-names      : Should be a pair of "iface" (required for IOMMUs
                      register group access) and "bus" (required for
@@ -36,6 +39,8 @@ to non-secure vs secure interrupt line.
   - compatible     : Should be one of:
         - "qcom,msm-iommu-v1-ns"  : non-secure context bank
         - "qcom,msm-iommu-v1-sec" : secure context bank
+        - "qcom,msm-iommu-v2-ns"  : non-secure QSMMUv2/QSMMU500 context bank
+        - "qcom,msm-iommu-v2-sec" : secure QSMMUv2/QSMMU500 context bank
   - reg            : Base address and size of context bank within the iommu
   - interrupts     : The context fault irq.
 
-- 
2.38.1

