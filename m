Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB20E625A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiKKMCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiKKMCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:02:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F75CD0F;
        Fri, 11 Nov 2022 04:02:06 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE54B6602A59;
        Fri, 11 Nov 2022 12:02:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668168125;
        bh=3dwx4sOkXLslHVkjR3ykk6d4Uvy7UTkbpE06rEle/dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJ96edCAiTd0fOiAPzJq+KV6R/VU0T/LQw968kLpBHISad8/slSQJd85gC0u3McGS
         Oavmkr6X+KjqDvGhtg2ckU/TDdQ7x3vx3uc1tDj4jE3Ya7Q07KkqGQ61TeYtFjCl4Y
         ewgO0gTBluU5S3LhZdTuocKb4rK30Df5NwgzjcXI0pXm5LKF9HinPAyYPmJ/+UVFDd
         MyrK1HR9s0S93EOLavgXsvHWXISjwvxQe1gHn4eLoQyst6ISXsvAyRf4rtucWZxsFT
         qVfpxQjy3GCqXskd//pbinRVJFs/Asyer8+ABM9ZskCIP4neiWZDGIl4pK617HKDSZ
         xj576czisqjfQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 02/11] dt-bindings: nvmem: Fix qcom,qfprom compatibles enum ordering
Date:   Fri, 11 Nov 2022 13:01:47 +0100
Message-Id: <20221111120156.48040-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
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

Move qcom,msm8974-qfprom after qcom,msm8916-qfprom to respect
alphabetical ordering.

Fixes: c8b336bb1aeb ("dt-bindings: nvmem: Add soc qfprom compatible strings")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 2eab2f46cb65..474abdbb1ee7 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -19,8 +19,8 @@ properties:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
           - qcom,ipq8064-qfprom
-          - qcom,msm8974-qfprom
           - qcom,msm8916-qfprom
+          - qcom,msm8974-qfprom
           - qcom,msm8996-qfprom
           - qcom,msm8998-qfprom
           - qcom,qcs404-qfprom
-- 
2.38.1

