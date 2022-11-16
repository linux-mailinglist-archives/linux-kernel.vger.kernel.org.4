Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5100D62B75D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiKPKMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiKPKLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:11:48 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AD42018C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:11:47 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j15so29109890wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExCAMXl4X7rdqIm34AVHVhl9Z8BlvBZkZwKq1aSTCFQ=;
        b=S4iYucZ+MqnX/0CvFzAz1FzJkdOEyIr5n6/k6CFu3hna2QUZUrpqVD5dVuOpEMiP6B
         Y6dB7Sm0zw+6TLKUL3cNSXk+ORYPHOdC0wrupiPbCWl4zgh76mfF7HYi4WhfomYItL5p
         sjrjIogREx0dE//6DN6DZZDPkF6lhIMLB2pOoBrb0iVYJcAY8LAHTEXvIn/C2kQ+/jFN
         Vw+WRW4r+f9n4Sa/hJmpK1i3dyOZLgyRPoNMGOAI7nbBHcc+CEQAayPL1bhqsgoCNL64
         p+YbEcUyGSVq8uhzsVrA5zeH+0SJMUu0ghIYy42I6CK3nnY8bBxvv4UzeIOhUaz9rzn3
         5ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExCAMXl4X7rdqIm34AVHVhl9Z8BlvBZkZwKq1aSTCFQ=;
        b=W9xJzvuTGZxFEFcZtx+xRISougIb0Ri7iar183vt3ba6tVzr3ghTakbDjyV2dIgPnz
         gLUQXPYbwhiWjvR86nPhPM0tl/uZ3jqjqpYxClLeKZQAtdI1Ij5FkilhvtrU2gPUGchF
         BjVFFZunnAw9h6GErTTSzFiyBPVGQqi+yTnUGX1off4049EBTmHR/lMY9QHC0bqAiJp2
         wCX+ZBNKs7DUZdvf/7smP2wd5JU11kZQETwM9FRxzdxIzmsLxK2ZEZHzjAiJgCdFXAgt
         eQVvJCXoV8TyejOI/j/wDP8KLuX2Z0UoRDWAPpEUFIvXoPE31y43cp/ugH2brqeRxmSF
         W30Q==
X-Gm-Message-State: ANoB5pk/ryeuf0VdjnIEIvE61r6T31ctksX9+1RpeDBUDc/5kR/0+tSC
        k85w25XnSdlY4vp6u3bwcjKPE9GSRr1AyA==
X-Google-Smtp-Source: AA0mqf5vpWUc8K7B7XBKSiAD7ykkjuU2GkQ8ATzB5QV68u7ShOVrW8NmfiuHSAPa6qjtQ/XhwNxA8g==
X-Received: by 2002:a05:6000:1283:b0:236:5fa6:1873 with SMTP id f3-20020a056000128300b002365fa61873mr12577296wrx.49.1668593506164;
        Wed, 16 Nov 2022 02:11:46 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c350c00b003c6bd91caa5sm1741752wmq.17.2022.11.16.02.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:11:45 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:11:33 +0100
Subject: [PATCH 4/7] dt-bindings: pinctrl: qcom,pmic-gpio: document pm8550,
 pm8550b, pm8550ve, pm8550vs & pmk8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-spmi-v1-4-6338a2b4b241@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-spmi-v1-0-6338a2b4b241@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-spmi-v1-0-6338a2b4b241@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-gpio@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document compatible, pin count & pin names for pm8550, pm8550b, pm8550ve,
pm8550vs & pmk8550 SPMI GPIO controllers.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml       | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 29dd503f9522..a32e4b4566bb 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -40,6 +40,10 @@ properties:
           - qcom,pm8350b-gpio
           - qcom,pm8350c-gpio
           - qcom,pm8450-gpio
+          - qcom,pm8550-gpio
+          - qcom,pm8550b-gpio
+          - qcom,pm8550ve-gpio
+          - qcom,pm8550vs-gpio
           - qcom,pm8916-gpio
           - qcom,pm8917-gpio
           - qcom,pm8921-gpio
@@ -52,6 +56,7 @@ properties:
           - qcom,pmi8994-gpio
           - qcom,pmi8998-gpio
           - qcom,pmk8350-gpio
+          - qcom,pmk8550-gpio
           - qcom,pmm8155au-gpio
           - qcom,pmp8074-gpio
           - qcom,pmr735a-gpio
@@ -146,6 +151,8 @@ allOf:
             enum:
               - qcom,pm8018-gpio
               - qcom,pm8019-gpio
+              - qcom,pm8550vs-gpio
+              - qcom,pmk8550-gpio
     then:
       properties:
         gpio-line-names:
@@ -162,6 +169,7 @@ allOf:
             enum:
               - qcom,pm8226-gpio
               - qcom,pm8350b-gpio
+              - qcom,pm8550ve-gpio
               - qcom,pm8950-gpio
     then:
       properties:
@@ -236,6 +244,8 @@ allOf:
               - qcom,pm8038-gpio
               - qcom,pm8150b-gpio
               - qcom,pm8150l-gpio
+              - qcom,pm8550-gpio
+              - qcom,pm8550b-gpio
               - qcom,pmc8180c-gpio
               - qcom,pmp8074-gpio
               - qcom,pms405-gpio
@@ -411,6 +421,10 @@ $defs:
                  - gpio1-gpio8 for pm8350b
                  - gpio1-gpio9 for pm8350c
                  - gpio1-gpio4 for pm8450
+                 - gpio1-gpio12 for pm8550
+                 - gpio1-gpio12 for pm8550b
+                 - gpio1-gpio8 for pm8550ve
+                 - gpio1-gpio6 for pm8550vs
                  - gpio1-gpio38 for pm8917
                  - gpio1-gpio44 for pm8921
                  - gpio1-gpio36 for pm8941
@@ -421,6 +435,7 @@ $defs:
                  - gpio1-gpio2 for pmi8950
                  - gpio1-gpio10 for pmi8994
                  - gpio1-gpio4 for pmk8350
+                 - gpio1-gpio6 for pmk8550
                  - gpio1-gpio10 for pmm8155au
                  - gpio1-gpio12 for pmp8074 (holes on gpio1 and gpio12)
                  - gpio1-gpio4 for pmr735a

-- 
b4 0.10.1
