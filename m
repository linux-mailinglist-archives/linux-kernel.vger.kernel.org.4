Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3283A629564
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbiKOKLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiKOKLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:11:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DFF5F82;
        Tue, 15 Nov 2022 02:11:35 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6901D6602980;
        Tue, 15 Nov 2022 10:11:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668507094;
        bh=NHdspCLp4Pq3hK88QRXd3z7hZRds4FeUTB1LzXblsv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbWCja0PZqnIvmCSwCgIigaRxo2WvBLvsVsUSfRGzVy9DwF8HbAmznUKxZfZZOOQQ
         mygWfD7EyzHZnchZwVcskuwwgz+2tlHQKiMHEGHrkUul478JFlL3s+3wJp4IVFMTFu
         RaxPXSKcMMASOqwm25YQ4+Q8EAahav06y5n7LyArSi7woPwymtQbppJfUHpf5UusKN
         l6KPbGW9FC45541w8cXP6QLpRNwrxUC79gVPDBoDetTKY5acf41Djz8OGgs38noCPK
         afgzqpjc5nu4QgzB4opsNxd3vdW59tPH1X29HBWaiUHDn+VNexmv2dd1DI1bWzVATq
         5YyrgphgxBFaQ==
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
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/6] dt-bindings: iommu: qcom,iommu: Document qcom,ctx-num property
Date:   Tue, 15 Nov 2022 11:11:17 +0100
Message-Id: <20221115101122.155440-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
References: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
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

Add a new "qcom,ctx-num" property to force an ASID number on IOMMU
contexts where required.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
[Marijn: Rebased over next-20221111]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
index 059139abce35..7d4e0a18b08e 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -46,6 +46,7 @@ to non-secure vs secure interrupt line.
                      for routing of context bank irq's to secure vs non-
                      secure lines.  (Ie. if the iommu contains secure
                      context banks)
+- qcom,ctx-num     : The ASID number associated to the context bank
 
 
 ** Examples:
-- 
2.38.1

