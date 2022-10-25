Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A589360D2FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiJYSHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiJYSGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:06:54 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B60E167E3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:06:50 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a00:f41:181d:45ba:3479:f7c2:4c21:3ad3])
        (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 5613B200BA;
        Tue, 25 Oct 2022 20:06:47 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: arm: qcom: Document SM6375 & Xperia 10 IV
Date:   Tue, 25 Oct 2022 20:06:31 +0200
Message-Id: <20221025180634.28956-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221025180634.28956-1-konrad.dybcio@somainline.org>
References: <20221025180634.28956-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for Sony Xperia 10 IV (PDX225) and the SM6375 SoC
it's based on.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Changes since v1:
- Pick up Krzysztof's R-b

 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 207e28260206..35e22cf15f9f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -56,6 +56,7 @@ description: |
         sdx65
         sm6125
         sm6350
+        sm6375
         sm7225
         sm8150
         sm8250
@@ -718,6 +719,11 @@ properties:
               - sony,pdx213
           - const: qcom,sm6350
 
+      - items:
+          - enum:
+              - sony,pdx225
+          - const: qcom,sm6375
+
       - items:
           - enum:
               - fairphone,fp4
-- 
2.38.1

