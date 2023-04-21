Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95126EB3FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 23:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjDUV5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 17:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjDUV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:57:03 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359591728;
        Fri, 21 Apr 2023 14:57:01 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 62D75CCBF6;
        Fri, 21 Apr 2023 21:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682114189; bh=UtNO0UCuGv/cFMdf46RJCKgPaFL2w8SqDFnXJ4NrvoY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=fW2f6aKQXPfvNDCZmEeYyaTY8Vbn/TK6g6SGlulW0J1ssp6gUMW/jFBzhVw9A5JFL
         khOq+Zz805kptjzBISgoKGRpz8v+1gEGH726CMdoYQR2EoMfVQpTt0Qx/JBH3kwyLp
         JlGXBSPpl0T6CUJmaJSEvF2qROW9YerW37Ky0pdc=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 21 Apr 2023 23:56:20 +0200
Subject: [PATCH 1/3] dt-bindings: pinctrl: qcom,pmic-gpio: add PM8953
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230421-pm8953-gpio-v1-1-3d33e2de47e3@z3ntu.xyz>
References: <20230421-pm8953-gpio-v1-0-3d33e2de47e3@z3ntu.xyz>
In-Reply-To: <20230421-pm8953-gpio-v1-0-3d33e2de47e3@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=UtNO0UCuGv/cFMdf46RJCKgPaFL2w8SqDFnXJ4NrvoY=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkQwaKKb3/UXN3aLhZti8Q65N/+zRFhnl7C0hqt
 OwyQpMCFSmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZEMGigAKCRBy2EO4nU3X
 VlDxD/4tVOUKafpkAlAfNK3n/pT+rewFet0tVxYzbzwj5Qba2jhTsLQ5w2ObaRwiktxob8XQPjj
 GQQ0g0OqhE5yGUkxQ/DxRWyv0gsYsGW5zPsPrJZcZks05VEzDnlffPWsmq1ieDsLakYI2KOUDl1
 DfxUfcK1tF2ZlagppKER9eAl7PTQpagXf2e/Jn+nVKmxpCwmddlek6RPDcELAJMyUejrKuxR/nb
 bWffIhesMdywdkolfXPyAYrllmD9/g12Ss/snLvOBDQooGenNBTJxaQe8OWqgbZIr6nu4upMKps
 PuffQhT03eTldM+eqpUpq8w51LV2EhIsWT+L4I0WcwK6teF1fHCZciM6JSjrBw+RJeDVou6imz0
 NXtWwbPG0nXOPtFn5srI+fVE4SNEOZLL1iV5P68Jx3hLGgf/FIf+QvZZqZVLsbziFtM2ll63k4w
 oc/mTTMi6fguDaiRHGKX8FV6mXfJ5DSkDhZjaMU76/6A/+YEj/ZWvE2s+xsSbIwSCCrUbEaR24s
 nHddxJ2S8n6PHyR20CnO48EZRMfacHmubYbvUJOHdbZidZa73Mi+1bPiDlsXJpeI1L0dazcFXii
 RZdTdeFEqMbzIZi12Fmni2MKQ6PEuMCIDJejk4VO3wCB9Qw9tQegRv9MSxt28h6MQGA1R5nhI4N
 /qZA9fFWYijcuQg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the 8 GPIOs found on PM8953.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index eaadd5a9a445..8aaf50181cef 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -49,6 +49,7 @@ properties:
           - qcom,pm8921-gpio
           - qcom,pm8941-gpio
           - qcom,pm8950-gpio
+          - qcom,pm8953-gpio
           - qcom,pm8994-gpio
           - qcom,pm8998-gpio
           - qcom,pma8084-gpio
@@ -175,6 +176,7 @@ allOf:
               - qcom,pm8350b-gpio
               - qcom,pm8550ve-gpio
               - qcom,pm8950-gpio
+              - qcom,pm8953-gpio
               - qcom,pmi632-gpio
     then:
       properties:
@@ -434,6 +436,7 @@ $defs:
                  - gpio1-gpio44 for pm8921
                  - gpio1-gpio36 for pm8941
                  - gpio1-gpio8 for pm8950 (hole on gpio3)
+                 - gpio1-gpio8 for pm8953 (hole on gpio3 and gpio6)
                  - gpio1-gpio22 for pm8994
                  - gpio1-gpio26 for pm8998
                  - gpio1-gpio22 for pma8084

-- 
2.40.0

