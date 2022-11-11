Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4B6625DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiKKPBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbiKKO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:59:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C44654D5;
        Fri, 11 Nov 2022 06:59:37 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 588EC6602A6A;
        Fri, 11 Nov 2022 14:59:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668178776;
        bh=MdaH8KbjjoGPf2cEN4UiKaUO79dviS/rWyElqvdnnE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avd20eghOS5K6gOklGt3Sm3Gek5pwuQ/Aprzihhp3r8z/4UR6W7kxHJx5sNNeobr7
         9kClPGQaLigcVaBg+USNAimBjhTtD/X6KVpD5IufbPeVEDrpeKJ30eW29jkVzFYuyf
         6Ap7rYhLr9CnWU63kHmHTS/Vo8ez9Iph7bPpmkUV0ZcP1+EBN/NxK7aPTBvddXs6fk
         sU7L9eoyP7DTvVKvwZ2gL8xAv/x1U4w/lGTegKMjgutPNlQWOGdxncqZ+pZAeo3zaD
         J1s0vvFOJi/FvhDNn+LZbTm6XwM9CYcwiNaHtZE1zwy4ENckVOBuKUWuaxWYYesS7f
         hBGGpZCQPyOYQ==
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
Subject: [PATCH v2 8/8] dt-bindings: iommu: qcom,iommu: Document MSM8976 compatible
Date:   Fri, 11 Nov 2022 15:59:19 +0100
Message-Id: <20221111145919.221159-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111145919.221159-1-angelogioacchino.delregno@collabora.com>
References: <20221111145919.221159-1-angelogioacchino.delregno@collabora.com>
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

Add "qcom,msm8976-iommu" to support IOMMUs on this SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
index b762772f80e7..b7a5822ac00d 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -9,7 +9,8 @@ to non-secure vs secure interrupt line.
 
 - compatible       : Should be one of:
 
-                        "qcom,msm8916-iommu"
+                        - "qcom,msm8916-iommu"
+                        - "qcom,msm8976-iommu"
 
                      Followed by one of:
 
-- 
2.38.1

