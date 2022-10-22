Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6653D608F4C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 21:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJVTm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 15:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJVTmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 15:42:51 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173341217C4;
        Sat, 22 Oct 2022 12:42:46 -0700 (PDT)
Received: from localhost.localdomain (95.49.32.126.neoplus.adsl.tpnet.pl [95.49.32.126])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id F1D391F5E9;
        Sat, 22 Oct 2022 21:42:43 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: arm: qcom: Document SM6375 & Xperia 10 IV
Date:   Sat, 22 Oct 2022 21:42:15 +0200
Message-Id: <20221022194218.210941-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221022194218.210941-1-konrad.dybcio@somainline.org>
References: <20221022194218.210941-1-konrad.dybcio@somainline.org>
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

Add compatibles for Sony Xperia 10 IV (PDX225) and the SM6375 SoC
it's based on.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
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

