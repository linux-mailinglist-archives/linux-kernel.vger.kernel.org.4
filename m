Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FD35F63F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiJFJ6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiJFJ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:58:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE92868A9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:58:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id e18so686274wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=ohfqXxwdII5oYNW9uS3cdMbKm4KECEvs5UYtpA0fFOM=;
        b=aybONs5ATWDT+Iv6LK+39sOkIqu5w+GfQ+2dL+OJkAj10LMmsNmuNptCtjD7+vubI+
         fpCQkDztC+5eXA8+uznIjhNGwlzOVHsEbzLBu1xDHRhO2G3iXu4025n/woTGB7ji62Eu
         Wszde/Q/YDb4+cKrabgXovWpgaivS5T8J8jVGiKvP/kLZeno/wSRlN064JfS+h5lw5FJ
         D3i18Yw6YsS0qQppq8Mqn4hIKNC298nZUF/3Gc2UE4fA8BvHHtCEuzDe8+RMH7j4hSAB
         pi37GTyssFwevbLySKxlOC1BXR5px/czpC0A6JNEbaZnOij5aXAQ32XVL6Y1CDmaESlM
         F4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=ohfqXxwdII5oYNW9uS3cdMbKm4KECEvs5UYtpA0fFOM=;
        b=ak164ngZNsBYATpJKTpuVtMe7iC5OGF+FCv23vxidR9oox+qFpCoCm3RQQUbZQbymV
         1nKIm1O/VeRfHBUpffkoX81rGA2PqvCSVNx8rJmh5gsSN26iULBD55QtvwgNBXUR4I6h
         1MEiaXzqFjoM9+vwKulUWhnZd0PHuFvTVAJ8Tbo/9LcI21cuJnrGjFSGPWKbMUZlBYOT
         P1y8GSM49POpx7T2Soing4TIJeI8dla1XZST++JMc9x3Uqv3AH7fwj58KJ8fklN9YBe6
         SVQ/hPnG/KB/DD1OukjuUERI0744xJDUk9CBlfRnRF79y6hfL+8qQUmUk1ITh8CoVIcS
         IJIg==
X-Gm-Message-State: ACrzQf3KhOadWv68acaJg8UxcwOSXMhve2FIzy7oB1AVnNroYPACkWZf
        eX+gEA8HnJKGjj51841o4AZEVQ==
X-Google-Smtp-Source: AMsMyM4+0vw2/ppY/9h4E6G+F/tcBtIRG3FbNjUyCk5ivL/nJSCuMCx8aSS5qUAT6J9eUgomkYrcag==
X-Received: by 2002:a05:600c:35c3:b0:3b4:a686:45c6 with SMTP id r3-20020a05600c35c300b003b4a68645c6mr6431706wmq.86.1665050280451;
        Thu, 06 Oct 2022 02:58:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q11-20020adf9dcb000000b0022ac672654dsm17935603wre.58.2022.10.06.02.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 02:57:59 -0700 (PDT)
Subject: [PATCH 0/6] arm: qcom: mdm9615: second round of bindings and DT fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAKWmPmMC/w3LUQqDMAwA0KtIvhdo6iput4ltNgNtNtopiHj39fN9vBOaVJUGz+GEKrs2/VgH3Q
 aIK9tbUFM3eOc9ORewpPKYKOBXLf5qxoNLRhpfIdLM9zQy9LpwE1wqW1x7ti3n6/oDxEh5TGsAAAA=
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 06 Oct 2022 09:57:57 +0000
Message-Id: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, Lee Jones <lee@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-gpio@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
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

This is a second round of bindings & DT fixes for the MDM9615 platform.

This second round focuses on less trivial changes like pinctrl & regulators bindings,
the remaining work will mainly be fixing the qcom,kpss-timer/qcom,msm-timer situation and
add bindings for qcom,lcc-mdm9615, qcom,kpss-gcc & swir,mangoh-iotport-spi.

Dependencies:
- patch 1-2, 4-6: None
- patch 3: bindings dependency on 20221005-mdm9615-sx1509q-yaml-v1-0-0c26649b637c@linaro.org

To: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Linus Walleij <linus.walleij@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Lee Jones <lee@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Neil Armstrong (6):
      dt-bindings: pinctrl: convert qcom,mdm9615-pinctrl.txt to dt-schema
      arm: dts: qcom: mdm9615: fix pinctrl subnodes
      arm: dts: qcom: mdm9615: wp8548-mangoh-green: fix sx150xq node names and probe-reset property
      dt-bindings: soc: qcom: convert non-smd RPM bindings to dt-schema
      dt-bindings: regulators: convert non-smd RPM Regulators bindings to dt-schema
      dt-bindings: soc: qcom: ipc-rpm: refer to qcom,ipc-rpm-regulator.yaml

 Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 283 ---------------------
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt      | 161 ------------
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     | 101 ++++++++
 .../bindings/regulator/qcom,ipc-rpm-regulator.yaml | 127 +++++++++
 .../devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml |  73 ++++++
 .../boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts  |  20 +-
 arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi         |  22 +-
 7 files changed, 322 insertions(+), 465 deletions(-)
---
base-commit: 6b8b72b0cdd146fe66c6009d86a1784eb24ec798
change-id: 20221005-mdm9615-pinctrl-yaml-13f5c18a4d3a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
