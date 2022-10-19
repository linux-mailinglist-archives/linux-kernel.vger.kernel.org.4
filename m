Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFB76045E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiJSMvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiJSMvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:51:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0F31757B9;
        Wed, 19 Oct 2022 05:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C137B823B5;
        Wed, 19 Oct 2022 12:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAE8C433C1;
        Wed, 19 Oct 2022 12:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666182199;
        bh=odCctxv4II0nUiGmOrX/qeGMX0OA2/R1yyxbX6z6K5o=;
        h=From:To:Cc:Subject:Date:From;
        b=AezSfgnDDoTzVa3QxWhAJUmGamN/OoXgoZRKDVhfrgpmbu1fK38ATJV14OQfw42vO
         J6dDVqqd5gJjHg/uMDFYRH4hKkX3oxX/24LL8ytIQzBUrqfKpTUUsbo22GBgcng6ty
         +gJyDILg5popEuqD43Hg9UecJXslZ0lqmrvglfRvsypSjZeOIr2e2BUn/6SbUJqKyp
         pDtzBFoXfpmmN7CSmcVXV/WeND8tPTjyHtMc9BsaHl430rjhzMHpzZp+RUqh0Ig484
         cv9pKr/yM0X8nBpUgKDJYYLgrxB+cbuLaN4ekj2miTvjWnCu48dRbkT5NhZNZEa3lg
         l+qen7pvWLVRQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ol86F-00057T-Rb; Wed, 19 Oct 2022 14:23:07 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: mfd: qcom,tcsr: add sc8280xp binding
Date:   Wed, 19 Oct 2022 14:22:53 +0200
Message-Id: <20221019122253.19669-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the SC8280XP TCSR.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Changes in v2
 - rebase on 6.1-rc1 and a328ae8504db ("dt-bindings: mfd: qcom,tcsr:
   Drop simple-mfd from IPQ6018")

---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index b12809b5cc22..cb0ae38a777f 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -21,6 +21,7 @@ properties:
           - qcom,qcs404-tcsr
           - qcom,sc7180-tcsr
           - qcom,sc7280-tcsr
+          - qcom,sc8280xp-tcsr
           - qcom,sdm630-tcsr
           - qcom,sdm845-tcsr
           - qcom,sm8150-tcsr
-- 
2.37.3

