Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E6D600C49
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJQKXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJQKXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:23:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62655FDE4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:23:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bu30so17724036wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=2tBc5BJTUK0yJeikdsN9lehq8jKJ6hu9VScPZU4a2kI=;
        b=bdMMl9zH0j03ibTEKy/zCqWIwlETzDUo9ooO5EvQAFnx3iYPS7HdIgwALI5bam0aqB
         oQigPd/nYpgC6M+zBK7std6ZLqh0IMHxfvfD3xsD8Cy2AwY2f+OeiAenUJkm/q/GT4T4
         9yN6Z/Cx1MEG2N27/Y0mUbcE9WEOk0KOHAyCSIpPeg/4Oukpt4Qs73+o1e0nPKbL8f4w
         r0wIsQog9ltsUwx9mWhTTYcW1cfalMKdBDX57UH1jyb3eE8HlCNB/au0hlw5J8p17nvd
         YcWDoD85oh0zwnWHDofdDICQbN3JmeekfkKGVLMdXfjQalQNGM1e51Yb0yD2RSJAeWGu
         pivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tBc5BJTUK0yJeikdsN9lehq8jKJ6hu9VScPZU4a2kI=;
        b=x81MBb7zFKY0VMVdm3Y5jL/8e2SVEt/EWA6csj0lYgpZ8ov1EoGLzhWHXJ5cU8Dv9V
         veKdHbLCj+aK2IWijlbouSC8m/d8HTPuSNMy6oSWI5vaYqro21kjVeFCDbl6AaFq+xRZ
         Noh5YzGiy8bhaoK1vC57ux5JGIcHOD86kIOAS6tbbT8oW/5rTW5UEULtkhWPwT3RwRbN
         +LuU03ln+nzFT9DDCtrShR+rl8ct4co10ecJYLxXyjKWhdFj+SLqDpyIULt0Lxe8LuQi
         Vq3AnDukM5as2BLNRkOu36Bg8pOc5Ud43RvP3nbMl54UGyYGti8tzdFJaIdU80gBjwyY
         OP2Q==
X-Gm-Message-State: ACrzQf1YH/ibZMKlYNkJeQ0p1H8e2bn+2C5Ph6Cu9i1cFEtxSgY61/Rw
        YPyEPkwdn/tB/aaUJu2Ml0JNKw==
X-Google-Smtp-Source: AMsMyM4Z0GGBbYxrURvlW1Ga67cbnXc5JvAoUjdO9dpW/aCtJK2zoDhG4xwgBxeVvDxyl5t3Z0wVAg==
X-Received: by 2002:adf:9dd0:0:b0:22c:d6cc:b387 with SMTP id q16-20020adf9dd0000000b0022cd6ccb387mr6109316wre.353.1666002190182;
        Mon, 17 Oct 2022 03:23:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003b4fe03c881sm15590707wmq.48.2022.10.17.03.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 03:23:09 -0700 (PDT)
Subject: [PATCH v2 0/5] arm: qcom: mdm9615: second round of bindings and DT fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAAgtTWMC/4WNQQqDMBBFryKz7pRJrNJ21XuULsaY6kBMZGIFEe/e0At09Xkf3v87ZK/iM9yrHd
 SvkiXFAvZUgRs5Dh6lLwyWrDVEDU79dGtNg7NEt2jAjaeApn43zlz50tcMRe04e+yUoxuLHD8hlHKU
 vCTdflerKfH8s7oaJCTXOaLWW67pESSypnPSAV7HcXwBdEbIaL4AAAA=
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 17 Oct 2022 12:23:04 +0200
Message-Id: <20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org>
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
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
- patch 1-2, 4-5: None
- patch 3: bindings dependency on 20221005-mdm9615-sx1509q-yaml-v2-0-a4a5b8eecc7b@linaro.org

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
Changes in v2:
- Rebased on v6.1-rc1
- Patch 1: Fixed bindings and aligned with Krysztof's series
- Patch 2: Rewrote patch title and added reviewed-by tag
- Patch 3: Added reviewed-by tag
- Patch 4: Moved to end, added support for (regulators|-regulators) sudnode
- Patch 5: Fixed schema description and added missing unevaluatedProperties in patternProperties
- Patch 6: Dropped & squashed with patch 4
- Link to v1: https://lore.kernel.org/r/20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org

---
Neil Armstrong (5):
      dt-bindings: pinctrl: convert qcom,mdm9615-pinctrl.txt to dt-schema
      arm: dts: qcom: mdm9615: align pinctrl subnodes with dt-schema bindings
      arm: dts: qcom: mdm9615: wp8548-mangoh-green: fix sx150xq node names and probe-reset property
      dt-bindings: regulators: convert non-smd RPM Regulators bindings to dt-schema
      dt-bindings: soc: qcom: convert non-smd RPM bindings to dt-schema

 Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 283 ---------------------
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt      | 161 ------------
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     | 120 +++++++++
 .../bindings/regulator/qcom,ipc-rpm-regulator.yaml | 127 +++++++++
 .../devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml |  99 +++++++
 .../boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts  |  20 +-
 arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi         |  22 +-
 7 files changed, 367 insertions(+), 465 deletions(-)
---
base-commit: 19d64985796125c5e3820c3db995c5df6d13d6dc
change-id: 20221005-mdm9615-pinctrl-yaml-13f5c18a4d3a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
