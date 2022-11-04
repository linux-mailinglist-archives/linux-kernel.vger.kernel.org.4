Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B12C619E71
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiKDRWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiKDRWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:22:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DF141996;
        Fri,  4 Nov 2022 10:22:00 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D83E36602997;
        Fri,  4 Nov 2022 17:21:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667582519;
        bh=yJVjQ3f9FOfr69ZHuU0UhqtUyjhf5Eq1urXR3HU4CjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1bTd1lU9vjJE0IarBtqRsIxTwqkqlAwOMPE5uFrbe1SS1UbVFOdWlEd85HjUE9sf
         +UDT1jZQJ7L65SGUKX0WzFmTs3jxi4N25cz9/6fL0FprZWrHjR3GDRJTDSSUU/GTbX
         q7a/RUKKu5Pdr0WjIq72GPKL+jKIxZ4eA6DIZqxGPhmidpJST8uLy+Xbql9nMUiF5S
         i82OSiZuGheARFBukjdPkg4oo6BjRV9nWXNn/IulmKWY2q7SslO/UCp+sEjdFBeUzK
         Sk3nq1hO1Erapkb0P8Cd0H7sLmDKaJ3GhWUCQpzayPwWmankYvwhDiWIBisIvgUChg
         GFp1MDBkRjTSA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/9] dt-bindings: nvmem: Add compatible for MSM8976
Date:   Fri,  4 Nov 2022 18:21:15 +0100
Message-Id: <20221104172122.252761-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
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

From: Marijn Suijten <marijn.suijten@somainline.org>

Document generic QFPROM compatibility on MSM8976.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 2eab2f46cb65..cac7be59c3cd 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -22,6 +22,7 @@ properties:
           - qcom,msm8974-qfprom
           - qcom,msm8916-qfprom
           - qcom,msm8996-qfprom
+          - qcom,msm8976-qfprom
           - qcom,msm8998-qfprom
           - qcom,qcs404-qfprom
           - qcom,sc7180-qfprom
-- 
2.37.2

