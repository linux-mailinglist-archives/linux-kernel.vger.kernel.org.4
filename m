Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442D86E6A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjDRQoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjDRQoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:44:18 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9210061BA;
        Tue, 18 Apr 2023 09:44:16 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1796FCAB0E;
        Tue, 18 Apr 2023 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681836224; bh=XV03liIFdzm84RLgEGuEQsAaPXKV3OiKBtrrr/U4Fxs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=PJqMvZiw2T15SsZgBT6ZQuOAb0jXCbhM8lZwipXMjHnUT992YnCreGU852wTZK1Zx
         oKMf1hxmV8SCr+D/1V9436PeCP2GtXQg7AQgurMYvs0FBP2bZ7Js23T7Z+SlhnClNG
         /z5jtxjoUP8Ys+iS+4dkcVXcrEMeo/MjS0j0WG8c=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 18 Apr 2023 18:43:21 +0200
Subject: [PATCH v2 5/8] dt-bindings: mfd: qcom-spmi-pmic: Add PMI632
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v2-5-98bafa909c36@z3ntu.xyz>
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
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
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=858; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=XV03liIFdzm84RLgEGuEQsAaPXKV3OiKBtrrr/U4Fxs=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkPsi61IDWXg7B/k3RdNQJUEt9k5IZsJ6QSILTI
 HIUJ9eAAeCJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZD7IugAKCRBy2EO4nU3X
 VkjKEACJ7n6LVGtIzMkS5SM6uS2zZgTVbhzsNcQdiIbgWQh2EJjXeg+ZMbTghPxC4ekW+hLjDkO
 MiUrjqt1AdmxE/YAhllWZVYUm20a40dsfDjbGXPICo7wRC0O7fIhbWvfPaFkFtE3Frv5KoeJ+Ln
 D+4Du88rQSjhBvpVt7BN7hN5Q7+/DN9BZyhmYyVVXs9uqCSL99e4po/WLePo/L9bThK1pgUUnLk
 t5KFUxGGuhkcVF580gdAOdmiMCPPfJP9ghKFueQXq6rVqyk7lkCRmnZ+46TVEWIPGDy30I/GFHG
 jcV00tIb3Jvw73yZL/PpKCXHN0FQHkorMEKKiIkK3xYKuj+/EZ6Em3IziebFzTW6CxgK0uaGClO
 OWRM6tWVNa6l8MNQUWrww9iWZQSNVtgbGGGkQO9cGrD1pQwhg51UrHgqPliq0/nEhQ5PasSH8Bg
 M3NchvBVxdEM+8RatP20pibgw97Jr81pgNJ/fi4yyrQQlQu0gO0qlw8RxFMtzLyDxGVFdKTSBI/
 DiKiPpeBOhAWWKgNJuLBisSXGWJbqt5ht7mMkQSPtbwPIpGpriLRf5VWdEBecz7bmJab6zkOIQ1
 py61suEzWDmJeoywLL2Wxe/yPRZA7+N+DR8VNb8v7JzD3iO/g8XD3jfYdUPD+vemJzkQGMW2ihp
 h9iaMsCugLeyVCw==
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

Document support for the pmi632, often found with the sdm632 SoC.

Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

