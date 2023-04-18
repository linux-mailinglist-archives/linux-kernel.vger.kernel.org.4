Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0755C6E69F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjDRQoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjDRQoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:44:15 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D2710F2;
        Tue, 18 Apr 2023 09:44:14 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4ADABCA65D;
        Tue, 18 Apr 2023 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681836222; bh=cf8LvtTKNrXgOVqnfPBTTBrobXcm7GixsxPTc9CbZI8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=YDpqgryyebKOo21fnxTWC+nCRdpBuErzrEBraHI1qLBIYwfGauslOiJs4u8WoaSZC
         FvqEDtkNCOfC4+AiWDID9IIK/8XjnkDoZTIqUbd6krN/FY97nkr5lKVPA09pyIqQea
         2SKm++LAM+o6YXk7GnM94YOxc9k7CmEE9i7PcmE0=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 18 Apr 2023 18:43:17 +0200
Subject: [PATCH v2 1/8] dt-bindings: pinctrl: qcom,pmic-gpio: add PMI632
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v2-1-98bafa909c36@z3ntu.xyz>
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
        linux-doc@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=cf8LvtTKNrXgOVqnfPBTTBrobXcm7GixsxPTc9CbZI8=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkPsi3SNkpS8d/Eulaj4wZnh0Vn8qnQgZ954mj5
 +KwnBfY12KJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZD7ItwAKCRBy2EO4nU3X
 VoovD/wLzln3jpbza/IVaQxcgbOH2+0Y3AFysC0yUZYVdkEePlQ1Qt236/z8G4cgwqB/qNBovtD
 /t6JNhmW+b8Oe7z1xG7ylpBwtXv7orb6l6D44xfmckJx1ifbQf57ybSaDUM7QLTBT752ceGPg+O
 GW1AP3skMPHSBpum9O5fhHtOS/u9B5g9N7dObLV6boE35XvExofQdFNvz5LX5MplZVGGWLQX9z9
 fpsMJLaWg9XqBEUZAq+uJydwKfHb+ds1M9jGVK26S9w59BUizCNi4gA1+hCopJJhSELJeiwgbnM
 nwth7Z0/4GTdq90HvQIcipsh7nA2yEZgUjl5DQnbbplbxNMLIJzQCSWARcHPYO231YFOOCflc+A
 kig4tjUPSACivzVLBLVGICxe6rOkJHLZsaNcln6nwusl+N+0e4nMVtfTmerwOB1VW7uJxb03b4g
 2iB21ANIG/xCjY+JdTQvrRbJXO3fqzmAlGYEwJMDg42Ag2M8NJc+C51KwcA6YZjoc3HMzAiLEaY
 K4BMQOFg4USWURIWyDjNnYrC7jNtFFEZsHJBTggwPHRqKIUQSe4EWKAt08BS3/B3yFDFmoF1uOZ
 nuBCfu+H5fX7eKwpQBZLt35HMHJSK+3VLzn5UqRH6jM8B0HHdaLhe4PNcue83shNiLTa7ACZPip
 bm97szTkULXMUqg==
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

Document the 8 GPIOs found on PMI632.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 36c6435cfd0a..eaadd5a9a445 100644
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
@@ -174,6 +175,7 @@ allOf:
               - qcom,pm8350b-gpio
               - qcom,pm8550ve-gpio
               - qcom,pm8950-gpio
+              - qcom,pmi632-gpio
     then:
       properties:
         gpio-line-names:
@@ -435,6 +437,7 @@ $defs:
                  - gpio1-gpio22 for pm8994
                  - gpio1-gpio26 for pm8998
                  - gpio1-gpio22 for pma8084
+                 - gpio1-gpio8 for pmi632
                  - gpio1-gpio2 for pmi8950
                  - gpio1-gpio10 for pmi8994
                  - gpio1-gpio4 for pmk8350

-- 
2.40.0

