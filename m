Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DC06546AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiLVTdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiLVTd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:33:28 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D8118397;
        Thu, 22 Dec 2022 11:33:26 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 45D8620176;
        Thu, 22 Dec 2022 20:33:24 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 1/4] dt-bindings: arm-smmu: Document smmu-500 binding for SM6125
Date:   Thu, 22 Dec 2022 20:32:51 +0100
Message-Id: <20221222193254.126925-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221222193254.126925-1-marijn.suijten@somainline.org>
References: <20221222193254.126925-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Botka <martin.botka@somainline.org>

Document smmu-500 compatibility with the SM6125 SoC.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
[Marijn: Move compatible to the new, generic, qcom,smmu-500 list]
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 124253e84c02..9b4520aff92a 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -43,6 +43,7 @@ properties:
               - qcom,sdm670-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sm6115-smmu-500
+              - qcom,sm6125-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
               - qcom,sm8150-smmu-500
@@ -334,6 +335,7 @@ allOf:
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
               - qcom,sm6115-smmu-500
+              - qcom,sm6125-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
               - qcom,sm8350-smmu-500
-- 
2.39.0

