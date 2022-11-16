Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CFC62BB17
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiKPLLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238678AbiKPLL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:11:26 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA1A3C6C1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:58:01 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so29247695wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEdbDk2wJVkl3rubNY+LO4i7Rgy5Hk/w2qu0GygUSzI=;
        b=ZIVY5j/2cma1itu6fm6wJ2QJFrXzr3QsiYqTHhe9PEmEuPOfA8D4Vr/N9aWI+iHMIR
         bozG3vZTiqQ25I3mSzS9neCkJW0sIddE4dAqZ1laLuK0ObPCJGS/V005Hb92pJGp0hKJ
         UVvm0tgI8Fh8RN4zd4mPiBd/Gu5M68c5utAop6dq/GqAIsz2R35g2zoaGIOtzMZ+MXQF
         U926K3QwYLorrqbyb2W11DWO+81W93sf461GyfZeReV9O1nN+L/rGjMnSiiEVa6+cRRD
         nAxRDvSoxWSDxssqal9SN020ggWEgJcmHIzMMxsiMklo7J9Dua/LI4RI/hfKHh9RoLW8
         LVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEdbDk2wJVkl3rubNY+LO4i7Rgy5Hk/w2qu0GygUSzI=;
        b=X1r5CBRaKrPUI4NYxmGKw78bxM5VoKL3asFheoiFbxcz+CDXIzDK4+NdgMygTXTdzu
         rFwa7XCqByl6ah6t/6TMfceK29pykSTC8tXL8V4kMVbCJfDv5FfwziMhxxzrEmfHElDE
         SBSUt675lPwA9yFaahSu7taQo+0sg9XqxyhZSJ3DAPqe5Xs4UoC36zQHR3N8NaaUwV+g
         1Ytbiehhp+F50w5T3x+B+ZadqDRPK8OiXszJuL0ViwZRyJOkWIPxYqu1s9BrrewTelRe
         /e2BNOqNEpQEoyB0M6EF9O/gbOcbEtN8o83hcugXn7y7zHk8HS8H7qmQ8xNgxLdSsRCw
         MnWw==
X-Gm-Message-State: ANoB5pnYmbUruZsL89NM+vXHcAo905H9d0iOH94G/MPv91BIDF4/Texo
        LSY77l+p88lsWqZuTFFCbtK0AA==
X-Google-Smtp-Source: AA0mqf5vUX/IzsOOWPxAELgcvX6K8puEuHEQSgib0rAROSBiGm0lwbkW6ySoip+YBPxFa9Evn24tgQ==
X-Received: by 2002:a05:6000:152:b0:22e:34c2:c6f0 with SMTP id r18-20020a056000015200b0022e34c2c6f0mr13308116wrx.232.1668596279968;
        Wed, 16 Nov 2022 02:57:59 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p13-20020adfe60d000000b00236e9755c02sm14935053wrm.111.2022.11.16.02.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:57:59 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 2/4] dt-bindings: pinctrl: qcom,tlmm-common: document i2c pull property
Date:   Wed, 16 Nov 2022 12:57:22 +0200
Message-Id: <20221116105724.2600349-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116105724.2600349-1-abel.vesa@linaro.org>
References: <20221116105724.2600349-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

Document the new i2c_pull property introduced for SM8550 setting
an I2C specific pull mode on I2C able pins.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,tlmm-common.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
index e1354f0c64f8..eddd58eafba9 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
@@ -77,6 +77,9 @@ $defs:
       input-enable: true
       output-high: true
       output-low: true
+      qcom,i2c-pull:
+        type: boolean
+        description: enable bias pull feature designed for i2c on pin
 
     allOf:
       - $ref: pincfg-node.yaml#
-- 
2.34.1

