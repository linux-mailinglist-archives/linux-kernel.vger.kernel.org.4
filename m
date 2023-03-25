Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651DA6C8E1E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjCYMZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjCYMZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670E3158B2;
        Sat, 25 Mar 2023 05:25:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48BC660C4E;
        Sat, 25 Mar 2023 12:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5852C433D2;
        Sat, 25 Mar 2023 12:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679747122;
        bh=A9ymok+/CGMkt/H6RYi5QK5yyXAyJGJdWyfhM1XUAiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfEIAHke1Ikv5j5kihtoM3VuyFnZYaO8dTG5uniNGHfkj+0HrqV3eHd2TDaH2iq7l
         J4LEVx5fUOoyNYuknR8EgfnDWTZnUg/VMLAhAzdil9qC0aPJDDbO9ABfww8WA9IjZA
         xQRNR0MeS4Sbh70slR4jZlBbm/lqB3XFA3NhdaZKbn9uZ0Bz0IFG7vIoso6coHs9Q+
         C40VoNreOOdWiK73cc1Gc/RYl20Nil20Mczs8kmtr7ehNSnmD4iV80SAminKGo53Cx
         deU5q/C/WQSMY2hdpsPyix0tAQemNwtUwAWyLb3B4lj1vSe3NtnPQ7pXtfv6TjjoV0
         oCocmylHV4jkA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/12] dt-bindings: phy: qcom,qmp-ufs: fix the sc8180x regs
Date:   Sat, 25 Mar 2023 17:54:39 +0530
Message-Id: <20230325122444.249507-8-vkoul@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230325122444.249507-1-vkoul@kernel.org>
References: <20230325122444.249507-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sc8180x ufs phy requires to describe five reg areas for the phy to work,
so move the description to the correct place documenting tx, rx lane
1, 2 and pcs.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
index 80a5348dbfde..881ba543fd46 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
@@ -160,6 +160,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-qmp-ufs-phy
+              - qcom,sc8180x-qmp-ufs-phy
               - qcom,sdm845-qmp-ufs-phy
               - qcom,sm6350-qmp-ufs-phy
               - qcom,sm8150-qmp-ufs-phy
@@ -178,23 +179,6 @@ allOf:
                 - description: TX lane 2
                 - description: RX lane 2
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sc8180x-qmp-ufs-phy
-    then:
-      patternProperties:
-        "^phy@[0-9a-f]+$":
-          properties:
-            reg:
-              items:
-                - description: TX
-                - description: RX
-                - description: PCS
-                - description: PCS_MISC
-
   - if:
       properties:
         compatible:
-- 
2.39.2

