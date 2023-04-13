Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C74E6E180D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDMXSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjDMXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:18:17 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53512BE;
        Thu, 13 Apr 2023 16:18:15 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 588C6D0C0E;
        Thu, 13 Apr 2023 23:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681427893; bh=TEj4vSyCxV9XVNVp48E4PxqwZCWlY48NmSsIQJyvDoU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=kbyDhM9rAIcseg64MMtsyEfItSPVJ6H8WlReNSEnrr27OMZOHquwpokplsxckJO5B
         pTVawcV/PoAH4yms1ju8XKg3oUJPcMWE/kll7cI4y/viEAYCd6M+hFLl91lvn5Z6Yj
         aBmY3IEtsJvkvjP50WWd9hvsR1pJwj+pRuBeRjKw=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 14 Apr 2023 01:17:45 +0200
Subject: [PATCH 1/8] dt-bindings: pinctrl: qcom,pmic-gpio: add PMI632
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v1-1-fe94dc414832@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=TEj4vSyCxV9XVNVp48E4PxqwZCWlY48NmSsIQJyvDoU=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkOI2tzYzDKRMKxJfZ0gHjsAYTQS7WpTtVT2q6W
 5pRxZ4Paw2JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZDiNrQAKCRBy2EO4nU3X
 VpDfD/97vIuZFpcGJP4e8ENH8R+GEqJ50DlaQIsPe50rNg2rjlV7SSHEpEwDvLlzA+Ei462AjXD
 kq6CHA/OsZ3tss8hH8hwc1l9o9kzPqAvoSXPqlXUEw5hLHo64Ij/8Q1SQuQFRVlEoZ9QqDDp5dt
 CH+QF9pvhW68GmOWxJQ/iDKI6b6uTXnSqBupb2NPkbifcgTRBGUfyeKGQGHdtlXCa+nqY0qrPm+
 ohLu9N0ae9IwOU3o0z5hh6byFQdDYj57IiKIqmg/v8szKzX5LtjqMtk5ppNklrO+B/9FsUTNVmi
 RU16pFkATjAzaazVopIl82aSqv21mlSuIz8EN+6P5lEzKAcKvADWrV35t4TCYXniU1zu7MM4riX
 qufHBD5hQNGLXihqwcQ822YMWEt+GFv3YtG0SYu51NAYPrr8GgrLCPMgo+CtnoKGCQhMkrxfa9l
 5ogEcGXdppEJsbbpLvLLwGCSb1h1P2zL8hFyZBaWaj3JLoaDLvoa68gwv1PIaG/opwgG97absrC
 viE/kvjSZtVZbdpBeigVWT0q+IsiugKB0D53da3KqacbyT9lkG3cr07qUffzy/vHZcL1AQ9tn74
 9j2DXAMbNL51KsjtiHUegCgVMeH16ZELHXi31eI397sfg0tsNYM2SYXFxelhAZhf03PzIJYCyOJ
 hvo4xDhLYbFbz5w==
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

Document the 8 GPIOs found on PMI632.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 1096655961f7..2179444b7a83 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -52,6 +52,7 @@ properties:
           - qcom,pm8994-gpio
           - qcom,pm8998-gpio
           - qcom,pma8084-gpio
+          - qcom,pmi632-gpio
           - qcom,pmi8950-gpio
           - qcom,pmi8994-gpio
           - qcom,pmi8998-gpio
@@ -434,6 +435,7 @@ $defs:
                  - gpio1-gpio22 for pm8994
                  - gpio1-gpio26 for pm8998
                  - gpio1-gpio22 for pma8084
+                 - gpio1-gpio8 for pmi632
                  - gpio1-gpio2 for pmi8950
                  - gpio1-gpio10 for pmi8994
                  - gpio1-gpio4 for pmk8350

-- 
2.40.0

