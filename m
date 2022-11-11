Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E43625A03
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiKKMCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiKKMCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:02:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB79A82C46;
        Fri, 11 Nov 2022 04:02:04 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 32F506602A53;
        Fri, 11 Nov 2022 12:02:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668168123;
        bh=E58h8dQlq6iyVZeY2ZoYwPMl0h6V46S7j8hkPKDnsBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=awhAMxu4qfrXwOB6t2GUPEgSm798ULLg98fP0oCTQb43skDUf/q7UKnzDth5LL0pF
         3GwsfVN0YHd8PFGNv38P+8Srft23bL1vw5pIkGbgPup9qNxcBaP16CiY89AO2EVpuq
         VMpL9oyflD5HXAINc9/iRR3q5G/d301dNJK5xSEbE/UrS2exTM7RtxCPCGGJ6rubWW
         BBrHhaEyVLgPulDdmon6rMcUWsgoaYqYWEC/6hzvRcMw9VoNvUyy313Ypl2imIc0Ey
         y2ysICl1SQchfmaGhPNinBmOUjzgynIsZbtiEQoUqHezrZdEqEWHBq8wjLhdhi1rRI
         k7Fq49QHMbYcA==
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
        <angelogioacchino.delregno@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 01/11] dt-bindings: iio: qcom-spmi-vadc: Add definitions for USB DP/DM VADCs
Date:   Fri, 11 Nov 2022 13:01:46 +0100
Message-Id: <20221111120156.48040-2-angelogioacchino.delregno@collabora.com>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Some SoCs do have a USB DP/DM ADC at 0x43, 0x44.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/dt-bindings/iio/qcom,spmi-vadc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
index 08adfe25964c..c7bb9ef1f9ed 100644
--- a/include/dt-bindings/iio/qcom,spmi-vadc.h
+++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
@@ -72,6 +72,9 @@
 #define VADC_AMUX_PU2				0x3b
 #define VADC_LR_MUX3_BUF_XO_THERM		0x3c
 
+#define VADC_USB_DP				0x43
+#define VADC_USB_DM				0x44
+
 #define VADC_LR_MUX1_PU1_BAT_THERM		0x70
 #define VADC_LR_MUX2_PU1_BAT_ID			0x71
 #define VADC_LR_MUX3_PU1_XO_THERM		0x72
-- 
2.38.1

