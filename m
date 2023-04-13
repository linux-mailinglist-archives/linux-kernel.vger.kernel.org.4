Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7231C6E1832
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjDMXTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjDMXT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:19:27 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E1155A6;
        Thu, 13 Apr 2023 16:18:59 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B60B6D0C52;
        Thu, 13 Apr 2023 23:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681427894; bh=mdBEwzgyTkn6OiQX8yDfJw3X7WbLKTich7Ekd7KwYOQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=ZGXKb5o2sU/8p9Z8YCDFMolWXSq8U9QaY4cOG3qFRfYEv/kZQ9nYG3eYbqPEpgpuQ
         CvYLyE3xNIaL5dRs4Zdj9ZZpOuMMVJ7D7fkJD66wFhBfukpGqZI/8hMAh8vvanKlwT
         ArPE5iLgeWQCx/uZ+trpn2TuOJQn9yqBC63CM70c=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 14 Apr 2023 01:17:50 +0200
Subject: [PATCH 6/8] dt-bindings: mfd: qcom-spmi-pmic: Add PMI632
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v1-6-fe94dc414832@z3ntu.xyz>
References: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=755; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=mdBEwzgyTkn6OiQX8yDfJw3X7WbLKTich7Ekd7KwYOQ=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkOI2yhdXz4/nLXnly1oi2QAFdZkaZqnwTAd9iT
 E0Jdt42JP6JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZDiNsgAKCRBy2EO4nU3X
 VmBCD/9Mxlr5zAlia3YXc8pS+dgsVr+lV0fcGqktZARJ8Ry26mAHBFpuW7gHwCKBRZlR6r3gT3v
 MolU2FyfQjQj9gOkd2FH3zTg9mFh7gGjhbsJH9h4ZlVsHhTQPiUe4xX0mXZZpjyGXf7kaRITeSc
 3oeUuKQAxsfLNLD4F2fr9yy3zYB3qQZSPtViPm986bUf+/6xA+8eyJNZC1yGsYkGTR/9j7PSWER
 DU5wjA2catOtgSuT6iuFuseAXFpEkzfXYB9Xt5LtUBu8bXiTrQvnJ/cgxR1ooTk1B31vKoctSiZ
 H7oigK70Xrn0KUVPxdbg/BlfsUgeMErFy0N5zDnTh4WXgJ6qJ1tim/jq238kHajW7IgMXvhrPAk
 hALCjYCtsTpUyyDakb110WdMqrnX7LIb7qShjrBBISaVXcNGP/6/vOR5gRqRWzDxkTlkK+gDrKW
 c1QVX2/bLTQZaWqEt35n5lA/cwX5/5TS0S+8VjV3cVFBMIPXlOqjxFZ/XhNUg51lzdGVJBggkOL
 wxY9Q4qSWW2/Aa5bHFSq8lve0EodZKBLyUBGqa7e1UvpMh8Rwyao/xX44O8NqrYpCSfhSeg4q+e
 ZgkLENAT1cB2o2VSvSKXzraBFsasmPI2yUGxoC337s5JdXutX1PbWVzDXDEV6oarfkCo6RDQXCV
 fED8X7FH0LoO9Rg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for the pmi632, often found with the sdm632 SoC.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 84620ebc1efe..09e7195c622b 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -71,6 +71,7 @@ properties:
           - qcom,pm8998
           - qcom,pma8084
           - qcom,pmd9635
+          - qcom,pmi632
           - qcom,pmi8950
           - qcom,pmi8962
           - qcom,pmi8994

-- 
2.40.0

