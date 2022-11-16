Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D47862B755
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiKPKL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiKPKLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:11:47 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3A024F1A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:11:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bs21so29087539wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LcrvwagafHn5DmL9sB4s1hodceFlCTJMorw4RZaIdA=;
        b=MAiuVZGyMK1NE4M+mf17m/LzbJwOOU5w0fSlrGyZCkfOudDm4lWOJUQJ84EinHFM4v
         +rBZ/0OmS8T4vDiKog8HWIBEjBR0LTdU3M3uzgU1BC8fAGoipfbulsKtxV5gvl7HZBFQ
         MCBk6HTxJVeOoe//rXYwvf4rLyZHxh1jf8ZrOnI80EtptQ1muKJ/xpMMIyj74zHZ/qIx
         depAXZbP0fh5WqWhSVLGXhSZcoaI9s9HkOp2P/cuuVB/zxb5um6+U8i/9LNiDSbr04LN
         6vvgEIAQZkU9+dijcdhVW+3mEjGrKVBPBIQla2imQnPVZGu15QDOhLtMglQtQSv53O9S
         NKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LcrvwagafHn5DmL9sB4s1hodceFlCTJMorw4RZaIdA=;
        b=qBqMykSfarNBI3iaLzPB5swc3su64nboR423zXExLseGMVudC9jMZg9hfNHiZGknOp
         MIPMOUUCYro2MFD+2XtAHWL3ShlVhH47dmhjJ1nbxGdNAIKraVh+Dsf1OHH1tdDBTsIw
         hpuWt2UQdq3vnPmFS2nlxH12zIzXkjp+hPSwae57ziKSpQUzUDmY1oHmSUwpk+dmehIS
         QQQSU/qOAmbsu45WmEP2X6kbhZwIxPp0V801phKfVgiITjCCDINyIzxlrWzJ/hxoMBH4
         Xd6srnnpojPXYF7LmmVBs4psadM42oThPdqNH8Bv/WmUXpI9zmCxeHptpCW9Zw4gYGjk
         NapA==
X-Gm-Message-State: ANoB5pmRaAzbF/gzkDz7JaH9JXfiaZlH01Q3GRfrsw5btUcNVnjYiOjv
        OOudCTeFD7uUjKK9vM/QTfieMw==
X-Google-Smtp-Source: AA0mqf7zlQ4OKQ8itbO3tTLcFtrISRrl42J/LOtBFGFRNBJYarwyFvh4cbBQpjDjNqebgp9vHBmBlg==
X-Received: by 2002:adf:fe0c:0:b0:236:d479:b0b7 with SMTP id n12-20020adffe0c000000b00236d479b0b7mr12915647wrr.559.1668593504453;
        Wed, 16 Nov 2022 02:11:44 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c350c00b003c6bd91caa5sm1741752wmq.17.2022.11.16.02.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:11:44 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:11:31 +0100
Subject: [PATCH 2/7] dt-bindings: mfd: qcom,spmi-pmic: document pm8010
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-spmi-v1-2-6338a2b4b241@linaro.org>
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

Document compatible for the pm8010 SPMI PMIC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 93e76d7f7814..10a71a130987 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -44,6 +44,7 @@ properties:
           - qcom,pm8004
           - qcom,pm8005
           - qcom,pm8009
+          - qcom,pm8010
           - qcom,pm8019
           - qcom,pm8028
           - qcom,pm8110

-- 
b4 0.10.1
