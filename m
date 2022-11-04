Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E61461982B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiKDNfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKDNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:35:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8812657C;
        Fri,  4 Nov 2022 06:35:05 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CC35C6602985;
        Fri,  4 Nov 2022 13:35:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667568904;
        bh=R19MuEoWcBHbiyziyxfKuw2qr11jmdAxV5NDzphwFwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmDLolAcbdRXZEFgUI0EieI5zAW3V+hkCoCDWd2kfw1myBn4EbGBLgUDbU8mO66Uk
         rS7U7Z2u849m/egYrnvGoAmxFGUo5j9Mt57dfg1eAM7b94TZzZmMwiyj629wU2jYW+
         8yXycbqD+x4I0HAOtN133/meeZpHybCNy7dln8m4oHQRNKmy8Npbw89+COyDvrE7dV
         +MEXUIEpe2IKS5KxO73e+pOCVRAw+mJ7X0XeFh2POqmUFO8++KskFe1xw5bNDgJ3TY
         WK1gGHix9rb55E2cSalVCF15lde9rxoQhvQSjVxMd3vMxqf8R4UvIY9z04xN1s6jPF
         Pl2BMHd0uO4VA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] dt-bindings: soc: qcom: spm: Add compatibles for MSM8976 L2
Date:   Fri,  4 Nov 2022 14:34:51 +0100
Message-Id: <20221104133452.131227-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221104133452.131227-1-angelogioacchino.delregno@collabora.com>
References: <20221104133452.131227-1-angelogioacchino.delregno@collabora.com>
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

Add SPM AVS Wrapper 2 compatibles for MSM8976's L2 cache.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
index f433e6e0a19f..80434d7111d9 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
@@ -24,6 +24,8 @@ properties:
           - qcom,msm8998-silver-saw2-v4.1-l2
           - qcom,msm8909-saw2-v3.0-cpu
           - qcom,msm8916-saw2-v3.0-cpu
+          - qcom,msm8976-gold-saw2-v2.3-l2
+          - qcom,msm8976-silver-saw2-v2.3-l2
           - qcom,msm8226-saw2-v2.1-cpu
           - qcom,msm8974-saw2-v2.1-cpu
           - qcom,apq8084-saw2-v2.1-cpu
-- 
2.37.2

