Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8606E1815
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDMXSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjDMXST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:18:19 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BE1BE;
        Thu, 13 Apr 2023 16:18:17 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 6862BD0C51;
        Thu, 13 Apr 2023 23:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681427894; bh=FCBw8XDNRhE4YdMQX9/OeTPh8F87PXGZsKt/roj2lZA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=ElRyy3/eGjLjnPL9epuoPuvJamXadHbyXW9hsax22PdmfysDyA4OxOi48PZfQZhXE
         oTseleVrDue0VWBqM3etXSHC9KoUhgMl6lrUwynII7N4fbIHDfZoCYsFq9bI4CjPSG
         o/tN0hkw7IeHbPRjUxMZsQ0nA1J8Twuv1v8rqOok=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 14 Apr 2023 01:17:49 +0200
Subject: [PATCH 5/8] dt-bindings: iio: adc: qcom,spmi-vadc: Allow 1/16 for
 pre-scaling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v1-5-fe94dc414832@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=FCBw8XDNRhE4YdMQX9/OeTPh8F87PXGZsKt/roj2lZA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkOI2xbIPcdKZh9IQXKUO+TxGTsdPhQSARWauW8
 Ej3E04fojKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZDiNsQAKCRBy2EO4nU3X
 Vi8ZD/9dRAJu9zCMylW34QTtL3TnwNl+kPTu/AcQwhYsqwJ/R6JlAVQ1yYk/jFOjpm7Li26+4AH
 BuVTQk/Rnc9lLE82C3GhZuW3juTiTOcGAzrANhaYVB/qoVmxmnAmYwypxV7nvSF6i+eeNpM07rk
 GCNHvQ8q2TPLSse+oFNk2vU5IEnXiCHIDbvvXRe/Ua/jWF21DCRiqDHw1n82BbIJhZu/BBwNtsU
 kd690cgY/5sYpdvvNrTl6Av31+XZbnjSm5WXKG9Wy27USIQHRhHMNipm/fLVTcBmYgx4Ktz+QQq
 7nRDKLG4vNSQi/sqTK6DfG0r6NBvPK+XGJwyOGRonC76oSPf9SOwBUSOfzSke9Vbdzjn+KRoFoM
 hVyf1dAUgjMHYX7SrbJDAzAMpX4lFeGo/24z+hFf5YcDNlmgStiV8Y8t0+fWed97BRanni93HfT
 KJy2ywoxzng7sUW8SonyAXGSL/R4Bd/70stichwVYGXVsySlT0c6ui2t8XdAKJkdGfLkFvAmat7
 TIbFIA2EOoyNUkYqj+yw6/VLdQZ6b2vFsnf8m8EUEJwz28wGYWTA/KEv/Z48nkrQiRdIC6wV0Iv
 WaqRNBUZbEt0aCTZLgt1Je0BlnO6I4yDeDgNDCc0xuPTw+KzKUl1e/cgauUzu5EeIYA5DeVw9eK
 wB+viIhCkaZoyqQ==
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

The channel ADC5_USB_IN_V_16 is using 1/16 pre-scaling on at least
pm7250b and pmi632. Allow that in the schema.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index bd6e0d6f6e0c..365aa3528a87 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -101,7 +101,7 @@ patternProperties:
         oneOf:
           - items:
               - const: 1
-              - enum: [ 1, 3, 4, 6, 20, 8, 10 ]
+              - enum: [ 1, 3, 4, 6, 20, 8, 10, 16 ]
           - items:
               - const: 10
               - const: 81

-- 
2.40.0

