Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B00E619E88
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiKDRWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiKDRWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:22:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7E64199E;
        Fri,  4 Nov 2022 10:22:03 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 476846602995;
        Fri,  4 Nov 2022 17:21:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667582520;
        bh=xk85JL4r9GN8347TeRxdMBc6hGdnmcfNXzfRU+FDXVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ddq/w482hg/tM55H/d0BFH7R1PAvyrQ0w2EwwewOT5DRLLqg0sugFU2+LlzfgiuXQ
         Kq+tM1GNN3xFARPOGrWS4U7v1sDuaS0Ty39D+6lx0iTplwb4tFTpj+/C3z4ZpbdxPt
         1xftY2hdw8OOMfVLoI61SBSE25CjqpdbxBbVpyfCrRl2wS00lF+d8/kkyTGEZ9kVsx
         Kzg7BH6qo4LlZ5STDwntBiSc8XceM/6sJBG5YW+mGavDt7RP2EzqYgAoHUI5mn5ZsF
         8dCpbqGS8734ALrTi1HHoYihjNK7qijTiFDhRWe3rfvLcGobpbqQ15vIYPLOXbk2Xv
         nZkDfego7zhIQ==
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
Subject: [PATCH 3/9] dt-bindings: arm: qcom: Document msm8956 and msm8976 SoC and devices
Date:   Fri,  4 Nov 2022 18:21:16 +0100
Message-Id: <20221104172122.252761-4-angelogioacchino.delregno@collabora.com>
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

Note that msm8976 is omitted as a compatible, since there are currently
no boards/devices using it.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 207e28260206..bd1d5164938a 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -34,7 +34,9 @@ description: |
         mdm9615
         msm8226
         msm8916
+        msm8956
         msm8974
+        msm8976
         msm8992
         msm8994
         msm8996
@@ -149,6 +151,12 @@ properties:
               - samsung,s3ve3g
           - const: qcom,msm8226
 
+      - items:
+          - enum:
+              - sony,kugo-row
+              - sony,suzu-row
+          - const: qcom,msm8956
+
       - items:
           - enum:
               - qcom,msm8960-cdp
@@ -834,6 +842,8 @@ allOf:
               - qcom,apq8026
               - qcom,apq8094
               - qcom,apq8096
+              - qcom,msm8956
+              - qcom,msm8976
               - qcom,msm8992
               - qcom,msm8994
               - qcom,msm8996
-- 
2.37.2

