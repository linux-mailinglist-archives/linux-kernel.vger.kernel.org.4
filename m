Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8761370C33D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjEVQ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEVQ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:26:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DED2FA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:26:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6042d605dso10661725e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684772766; x=1687364766;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nepH5iGXOLHccajnwZc6MTpZ6uEQTRzg8VCSEJy8tmc=;
        b=gWJwYpP7gTRBrwW4cmlkuK1Z/0BJz5LSdzCYfFaJIJaM+nSUk3rE65+ey+IKvXfIKO
         6t6c+y2kd6TQJRjmM6A18PcEO7F+iAd4PhFpqynjBhAdGou5Wn2T/aHKfptHgJA2IPbN
         5tROKTDzz6c/CZL+0o0pESpp4nPmz+BB8j/gckqyrrgQ+qmRpuWQBLBlS4oD28wvCbnh
         WBgQ8xCDFJtSHK5oSDmID3pT0wq3e15kg2wZWwVqdM6zzjgrQZ5L1EeshEe84FVO7+iB
         bZ8piFfEujllavjt82XlR7wGRGfU+vdW9J7FpqYGSRJIbeE0Bgx4TgfuxvPXdk4/zo1Y
         d+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684772766; x=1687364766;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nepH5iGXOLHccajnwZc6MTpZ6uEQTRzg8VCSEJy8tmc=;
        b=KIWBC3ib/Wz8NQ+IvAHRZBgVFe4mFFB3CRlLu2MryOXcySkM9IitwktJE13z7Eu9IT
         GlwhbDlU7ze5wO8OAozrOjFE8bGiNZ2LBKT0jmAnqP14uN4SM0nO/NlIqdd5ub6BFsPE
         L6Onqkcu1XaFHyP6dgLnMtaNNQ6lqXa8PzdzMnEVSZH6QnX226bxEa43GOo2aM+ezJ46
         91OhkMQg2iuED4QNdUi9wW57SpR5xcMnKEcQne6x2GB+Sc7oHcOoQDTya/lQtu7CUfpc
         +kL5woH6YfYYytF9X9GZPb5Zzg9OUhz6KmuzUc+qNSAIHy/UPPCC7tPib++4mOut2uOn
         u/qQ==
X-Gm-Message-State: AC+VfDxbMcC4MRPOui6efuiuUeKDuLnCbvcCXjZVAY2oLBf3EyWsropH
        nfvn9ZMHyRfblRtmUH/hlHH2Lw==
X-Google-Smtp-Source: ACHHUZ7d2aVRFO488Vr0xe0B74fe0JEXcSzeGPGqM+ptNYfwIpjNDbuN2+OAgxnq1/vdXYvu28525g==
X-Received: by 2002:a7b:ce89:0:b0:3f6:7ff:b3bd with SMTP id q9-20020a7bce89000000b003f607ffb3bdmr1382197wmj.21.1684772766650;
        Mon, 22 May 2023 09:26:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p24-20020a05600c205800b003f6041f5a6csm4317746wmg.12.2023.05.22.09.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:26:06 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 22 May 2023 18:26:01 +0200
Subject: [PATCH] dt-bindings: leds: qcom-lpg: document PM8550 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230522-topic-sm8550-upstream-pm8550-lpg-v1-1-f016578d9e63@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJiXa2QC/yXNQQqDMBCF4avIrDuQRgO2VyldJHHUgRjDjEpBv
 HtDu/ze4n8nKAmTwrM5Qehg5TVX3G8NxNnniZCHarDGtsZZi9taOKIuvXMG96KbkF+w/J3KhC6
 MnXn0nY3tADUTvBIG8TnONZT3lOpYhEb+/H5f7+v6Ar7SzHyHAAAA
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1727;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1iBfYlBa2kOii/Fa1CWOA2mUunOJhoOPHiCd2fuv9dU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBka5edtsQEAgiDR8UamS6yCyhQYv4K0McfLEHN9Oji
 VuDnCMGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZGuXnQAKCRB33NvayMhJ0XB/D/
 4822iruHdb5epzVHXaQ4evPsPnMkXPhmS5l33u+HdybZ+1ui00u1ShwOKB7BUVC3sXZDx+//5BoS9F
 gF4xBb5OzUX5ORZGaLBJJEmop4whg8CXzAJIbvud2lcyB8zsJ1+Ld0VSAHjVV5Yas8i9FcFpkyuBYT
 I7cQHgYS3m6n/1clO35GeR4N2MAFrDal1j2DnrxZs+JXXeDHWdYVJ/3dQHOhLclQxtaNo/QiIXXlvR
 mX+nR0N8GP3qsyAQP62xJ1vOSoCUtpUjwOp1GuPYMdEMQXhWW4HzXxchZLPHFvQKC1TB9DKvoHhPDz
 q462mYIqsciDQnj9St+utotYcr9NDiTM2toAvsMtD6QwvkljHNwldSByKGXm4Ch/qqrxALrZKDADy6
 b4HwH3Yhdfr+GzLV5YEA6Lm8W0qIi/S011LO3NdDvnH9hod5b+g2kmZUnpJhvUuhwDLBIUKDhjIvKT
 5GSr20nXEDdyRxYcZVsqkd/WmEwykVYWUFPpUnjAL7dyGBq46KgL5xdIUzeZIpcZLi59/RFPjiPjOy
 bDf0LTfOvct/koB+tSx77dhyTDD75OQhNBS9dis3ufbOH621j+EKVsqBN3EKpFD6a/SKGsThLKir9V
 764I9K5kqdu8dUW+v3j8+IHlRxyTGqMdDAwJRixUDPmBJUV8PNRudyHNv0Hw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8550 PWM modules are compatible with the PM8350c PWM modules,
document the PM8350c PWM compatible as fallback for the PM8550 PWM.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/leds/leds-qcom-lpg.yaml    | 30 +++++++++++++---------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 6295c91f43e8..fa378ee05c16 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -16,18 +16,24 @@ description: >
 
 properties:
   compatible:
-    enum:
-      - qcom,pm660l-lpg
-      - qcom,pm8150b-lpg
-      - qcom,pm8150l-lpg
-      - qcom,pm8350c-pwm
-      - qcom,pm8916-pwm
-      - qcom,pm8941-lpg
-      - qcom,pm8994-lpg
-      - qcom,pmc8180c-lpg
-      - qcom,pmi8994-lpg
-      - qcom,pmi8998-lpg
-      - qcom,pmk8550-pwm
+    oneOf:
+      - enum:
+          - qcom,pm660l-lpg
+          - qcom,pm8150b-lpg
+          - qcom,pm8150l-lpg
+          - qcom,pm8350c-pwm
+          - qcom,pm8916-pwm
+          - qcom,pm8941-lpg
+          - qcom,pm8994-lpg
+          - qcom,pmc8180c-lpg
+          - qcom,pmi8994-lpg
+          - qcom,pmi8998-lpg
+          - qcom,pmk8550-pwm
+      - items:
+          - enum:
+              - qcom,pm8550-pwm
+          - const: qcom,pm8350c-pwm
+
 
   "#pwm-cells":
     const: 2

---
base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
change-id: 20230522-topic-sm8550-upstream-pm8550-lpg-5bf409842c3d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

