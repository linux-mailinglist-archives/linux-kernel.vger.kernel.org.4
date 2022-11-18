Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B518462EF2F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbiKRIY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241388AbiKRIYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:24:49 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED6668687
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:24:44 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k8so8173602wrh.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMGR4In1ez92l+6LPD0CMqRP2g3QAqepco0/vRQIOao=;
        b=sdMJayyrnbsiU4fsXxIN7vd1owzQRMv9kP0Mx1vtR8UGFPpNAWzCi9u7FZmteegJg/
         upE1BrV9BgLaBo06fZy416X4/BV4Wo2+TKND96Z/qnA67N9XbpsY6Vep7r/zxZ2X1rb/
         yBSkMdDb5h4aFhYOhLlK6MA3pgVxIx+xZuhfqdcZFqkHcelyM/L8Q1JADjfvPj5Rw8+u
         8AMVm6gAwXb5MUdJ5TCKRHMXGCBp+MgmESRLLmuL2MTOUzkwKmW89lSDu8MUTeINRk8c
         XajthPDgJrL4FKXIJAS44HjJhspFZP3FSXne27Xtcn1+u66drhQclsCiD81BXq13K1ET
         g9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMGR4In1ez92l+6LPD0CMqRP2g3QAqepco0/vRQIOao=;
        b=feMIl9/1GkrGV5WMeoetwXYtGIe/Dh7M9Zt0GT/cNfT7am5skO0Es3lhkuHdP5sMZA
         VNmxujF6D0DPA3JjYTMt2vCd7hz8Ux7/eHTAl3Ss4baKKg7cRuAkSTWx0tj3YoRzpnC5
         tfizhqoXycWob+xNtchnciIyiDvupOCZjC5Aq/WpuPz8XTyvvnV+fVqHllKZEsLXWG/n
         uQY9u9KGKzXkDjxqdIXS5Nol/25y7WsgabPfywMPMsEh5Suex9hNrI0qG+WaajcUopna
         5GQRjZrNSy8cll8tj8M4sMelG+RFhlge76P5g6PDhST4CowSM9fOf+nZrYfZMZ9Rai8F
         NMlA==
X-Gm-Message-State: ANoB5pmzbd8yyBDm6/Kgjcrm1idZTO9xghp69DWfMb3VX/nlzMFMHTPN
        3HMLoz0zzEGSHG34rImvrHI1nQ==
X-Google-Smtp-Source: AA0mqf64riMiSJ94l+aHKxz4F/81dvxvtSGueqChRIzCV7iqPXrpie0sm4DVlj4zSVUFv6dJN/HJJw==
X-Received: by 2002:adf:e78e:0:b0:22e:32ab:c37 with SMTP id n14-20020adfe78e000000b0022e32ab0c37mr3718829wrm.317.1668759883035;
        Fri, 18 Nov 2022 00:24:43 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b003cffd3c3d6csm4070084wmq.12.2022.11.18.00.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:24:42 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 18 Nov 2022 09:24:39 +0100
Subject: [PATCH v2 2/3] dt-bindings: pinctrl: qcom,pmic-gpio: document pm8550,
 pm8550b, pm8550ve, pm8550vs, pmk8550 & pmr735d
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-spmi-v2-2-b839bf2d558a@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-spmi-v2-0-b839bf2d558a@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-spmi-v2-0-b839bf2d558a@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
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
pm8550vs, pmk8550 & pmr735d SPMI GPIO controllers.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 29dd503f9522..db505fdeac86 100644
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
@@ -52,10 +56,12 @@ properties:
           - qcom,pmi8994-gpio
           - qcom,pmi8998-gpio
           - qcom,pmk8350-gpio
+          - qcom,pmk8550-gpio
           - qcom,pmm8155au-gpio
           - qcom,pmp8074-gpio
           - qcom,pmr735a-gpio
           - qcom,pmr735b-gpio
+          - qcom,pmr735d-gpio
           - qcom,pms405-gpio
           - qcom,pmx55-gpio
           - qcom,pmx65-gpio
@@ -111,6 +117,7 @@ allOf:
             enum:
               - qcom,pm8008-gpio
               - qcom,pmi8950-gpio
+              - qcom,pmr735d-gpio
     then:
       properties:
         gpio-line-names:
@@ -146,6 +153,8 @@ allOf:
             enum:
               - qcom,pm8018-gpio
               - qcom,pm8019-gpio
+              - qcom,pm8550vs-gpio
+              - qcom,pmk8550-gpio
     then:
       properties:
         gpio-line-names:
@@ -162,6 +171,7 @@ allOf:
             enum:
               - qcom,pm8226-gpio
               - qcom,pm8350b-gpio
+              - qcom,pm8550ve-gpio
               - qcom,pm8950-gpio
     then:
       properties:
@@ -236,6 +246,8 @@ allOf:
               - qcom,pm8038-gpio
               - qcom,pm8150b-gpio
               - qcom,pm8150l-gpio
+              - qcom,pm8550-gpio
+              - qcom,pm8550b-gpio
               - qcom,pmc8180c-gpio
               - qcom,pmp8074-gpio
               - qcom,pms405-gpio
@@ -411,6 +423,10 @@ $defs:
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
@@ -421,10 +437,12 @@ $defs:
                  - gpio1-gpio2 for pmi8950
                  - gpio1-gpio10 for pmi8994
                  - gpio1-gpio4 for pmk8350
+                 - gpio1-gpio6 for pmk8550
                  - gpio1-gpio10 for pmm8155au
                  - gpio1-gpio12 for pmp8074 (holes on gpio1 and gpio12)
                  - gpio1-gpio4 for pmr735a
                  - gpio1-gpio4 for pmr735b
+                 - gpio1-gpio2 for pmr735d
                  - gpio1-gpio12 for pms405 (holes on gpio1, gpio9
                                             and gpio10)
                  - gpio1-gpio11 for pmx55 (holes on gpio3, gpio7, gpio10

-- 
b4 0.10.1
