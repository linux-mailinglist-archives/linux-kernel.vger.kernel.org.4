Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFB562B74C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiKPKLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiKPKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:11:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0349B20BEE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:11:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1114901wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrFpP9QwUo7UqKYXxLix0MUsi0KOqYbvwdMGQZr77xU=;
        b=eMTVGG49sC4X6HIhmiWz0T/pIw4BVcQA8T/8TD08hCKMLsVkfU5p6azY4KGAH3Dwg5
         X4zszBAoOc2To0cXd6IlAZvLOQLwOzVlQ7lB8cbxwyLkPJkC8Oejd8LAK5B9PbQRKwUk
         88lzJYTazF+xSsIGfvUPHu7JmLX2LUHNidlTPNAlmimVvh7hDQ5xZhhb09R9MqUulmqI
         VE2nOhTgwC98QGkO2eEiT+ahYjZE782fOfUYYfM0/XClx2silBSkrQOwT2OrVsOseYio
         5ZG6gfCJew4YIejFYFUXpBIsWIbWdCpHDOomdUaDuqPQJu4B8geMzAtvfaoPAufsU8tE
         89Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrFpP9QwUo7UqKYXxLix0MUsi0KOqYbvwdMGQZr77xU=;
        b=clD4x8dxXhojVmnAyM/R88/UcF3Zyul+3s6GXO+5zZzbWNhUGsl8tTae/bijW1d+mw
         9DpfVGzOPdObbflnwsoceZr0us2wEdcNmjrn10YlOM6ddMT07ANOPbROzf8FMid9Bdjr
         Et6FQnrXiqF+UyjwaoMHMEEY8fBboB85MYEp1EQfWlf8GqFelTIGo47tmb99F7f4zuVO
         Y9tk4xRzCvs4OO7NO2+yBI1z5YChlcCzu1hrFWKEZ5fFrB+VOtsCuh4I2mhlTWNf1bxO
         pul3ZKv3MYIVr/nSfRjI5D+yqT4hWRv/2FuoBaAM+namzA+HgJa/rOaa/Og2heeizz0o
         TyMg==
X-Gm-Message-State: ANoB5pnNg8eiaLR/YIAlGUMHfIRratQkjAH6QXRt8OIoH9qoP9R0K6Uz
        Scnr9eqQLH99rLO/LtmNA+9u5Q==
X-Google-Smtp-Source: AA0mqf5B3TT3UbZWZIPIYVSwDm7bpf27/Yg3J5xtbt2zfp6zKAu4+azwrHIc/fLSAVuD+4pcpfY26Q==
X-Received: by 2002:a05:600c:21d2:b0:3cf:b2b1:3c7 with SMTP id x18-20020a05600c21d200b003cfb2b103c7mr1570335wmj.176.1668593503465;
        Wed, 16 Nov 2022 02:11:43 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c350c00b003c6bd91caa5sm1741752wmq.17.2022.11.16.02.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:11:43 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:11:30 +0100
Subject: [PATCH 1/7] dt-bindings: mfd: qcom,spmi-pmic: document pm8550, pm8550b,
 pm8550ve, pm8550vs & pmk8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-spmi-v1-1-6338a2b4b241@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document compatible for the pm8550, pm8550b, pm8550ve, pm8550vs & pmk8550 SPMI PMICs

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index c01a00128eda..93e76d7f7814 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -55,6 +55,10 @@ properties:
           - qcom,pm8350
           - qcom,pm8350b
           - qcom,pm8350c
+          - qcom,pm8550
+          - qcom,pm8550b
+          - qcom,pm8550ve
+          - qcom,pm8550vs
           - qcom,pm8841
           - qcom,pm8909
           - qcom,pm8916
@@ -71,6 +75,7 @@ properties:
           - qcom,pmi8998
           - qcom,pmk8002
           - qcom,pmk8350
+          - qcom,pmk8550
           - qcom,pmm8155au
           - qcom,pmp8074
           - qcom,pmr735a

-- 
b4 0.10.1
