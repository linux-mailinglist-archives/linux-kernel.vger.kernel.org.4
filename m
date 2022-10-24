Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72296609786
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 02:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJXAh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 20:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJXAhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 20:37:54 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B110961710
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 17:37:52 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g16so4909223qtu.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 17:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IS79whyGBrNQD9WJyETCZZgadnHZ9WBjb8uBUK6K82Y=;
        b=i3/8OGGQYeyvm0vJr6/J7FEYV4NdXuqyM5OTlKOtXV3c6oc6U7sQtic/2nz7V6JbEU
         M7clXkt0gSfl6cZsETs20qt4k2D2GW+tjR3OtfvdTLSHPAO4hSEurpZJFiH3PK3HywnT
         KAblBPasW0Q6QxwcynglO+4q6LuHIugMOxof38Ja7ZLp4rCP30oZYVfj+T7hRcTMama6
         psC5dbgEb8Bbl0awVDGr8RWUyGbk6LxoEL8T1i40dvgcJ4Xc3183FCloA2I/3axoQeJi
         tA9j8Ha3nu7M6btAM2GoPmWoh7Sxg8rVYVnIh/IEhBWXpfWBp5E3hExu2MVVkcpd256n
         gDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IS79whyGBrNQD9WJyETCZZgadnHZ9WBjb8uBUK6K82Y=;
        b=qsmoxNQu9FaM+Q5Iet7klpOT46zhd3/dueIzSOA1HoRy11rgm+62DL0PRO1+SIstOL
         3rSegCZIodFlxarSAL8nyEYzO+gtAUA/ofksYSyPYJQLa4Z+nYG9d8Cn/ShIr3hrnsho
         jYqZjMUd9SFpFRmousmN1cAAoAnU4wRWjG1pYv4i4ddUdJ5SSxBGFlBJOgo8ByG8AwwF
         lWJozRCN1xiynGbxyTwuqW+TpW0i3P4zKNML6aWMXMWrbm65BnCTRUbWLlapmz0wjNhq
         K9cw8orbB8wI+qwUEyhjqT4frbsclGkC0ts6MJpqR3/r2P7l6PLYa69COOK4b4L1TGlK
         JkKQ==
X-Gm-Message-State: ACrzQf3wtKvsTGdcsT1zsRrRLz9etsX/k3L9cnYvWP67uV+meor4OaFD
        +GpGH0v6QfNt8clyrjT93j2Hcw==
X-Google-Smtp-Source: AMsMyM7wEaqRBWzHD7BMc6Ad8iVpXg6sybVR+H8qEwO/WqEge9ZX7A0okW9fwi6ApYK7kYdSxoM6eQ==
X-Received: by 2002:a05:622a:302:b0:39c:dc1f:db98 with SMTP id q2-20020a05622a030200b0039cdc1fdb98mr26307311qtw.467.1666571871846;
        Sun, 23 Oct 2022 17:37:51 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a25cd00b006bbf85cad0fsm14198145qko.20.2022.10.23.17.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 17:37:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] pinctrl: dt-bindings: qcom: Improvements for v6.2
Date:   Sun, 23 Oct 2022 20:37:47 -0400
Message-Id: <20221024003747.36021-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

All my existing Qualcomm pinctrl bindings combined, plus one Neil's.

Best regards,
Krzysztof


The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/qcom-pinctrl-6.2

for you to fetch changes up to 1b6b54ef7c4a1f482a2a6d33a769e89877beba4e:

  dt-bindings: pinctrl: qcom,sc7180: convert to dtschema (2022-10-19 11:55:58 -0400)

----------------------------------------------------------------
Qualcomm pinctrl Devicetree bindings changes for v6.2

Big set of refactoring and improving Qualcomm pin controller bindings:
1. Convert several bindings from TXT to DT schema format: MDM9615,
   MSM8974, MSM8994, MSM8996, MSM8998, SC7180, SDM630, SDM845, SM8150.

2. Refactor existing DT schema bindings to be consistent and similar to
   each other, remove unneeded pieces (provided by common bindings) and
   unify the style.

2. Fix matching of the existing DT schema bindings, so they properly
   validate the DTS.  When looking for pin configuration (children
   nodes), be specific and expect "state" or "pins" suffixes (depending
   on the nesting.  This allows the schema later to properly parse also
   GPIO hogs, although it is not yet implemented.  The changes require
   aligning the DTS to new layout, but it does not break any
   compatibility.

----------------------------------------------------------------
Krzysztof Kozlowski (86):
      dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: fix gpio pattern
      dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: fix gpio pattern
      dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: fix matching pin config
      dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: fix matching pin config
      dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: fix matching pin config
      dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: fix matching pin config
      dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: add bias-bus-hold
      dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: add bias-bus-hold and input-enable
      dt-bindings: pinctrl: qcom,tlmm-common: add common check for function
      dt-bindings: pinctrl: qcom,ipq6018: add qpic_pad function
      dt-bindings: pinctrl: qcom,ipq6018: correct BLSP6->BLSP0 functions
      dt-bindings: pinctrl: qcom,ipq6018: increase number of pins in pinmux
      dt-bindings: pinctrl: qcom,ipq6018: fix matching pin config
      dt-bindings: pinctrl: qcom,ipq6018: use common TLMM schema
      dt-bindings: pinctrl: qcom,ipq6018: fix indentation in example
      dt-bindings: pinctrl: qcom,msm8226: fix matching pin config
      dt-bindings: pinctrl: qcom,msm8226: use common TLMM schema
      dt-bindings: pinctrl: qcom,msm8226: add functions and input-enable
      dt-bindings: pinctrl: qcom,msm8226: fix indentation in example
      dt-bindings: pinctrl: qcom,msm8909-tlmm: fix matching pin config
      dt-bindings: pinctrl: qcom,msm8909-tlmm: do not require function on non-GPIOs
      dt-bindings: pinctrl: qcom,msm8909-tlmm: fix indentation in example
      dt-bindings: pinctrl: qcom,msm8953: fix matching pin config
      dt-bindings: pinctrl: qcom,msm8953: use common TLMM schema
      dt-bindings: pinctrl: qcom,msm8953: fix indentation in example
      dt-bindings: pinctrl: qcom,mdm9607: do not require function on non-GPIOs
      dt-bindings: pinctrl: qcom,mdm9607: fix indentation in example
      dt-bindings: pinctrl: qcom,qcm2290: fix matching pin config
      dt-bindings: pinctrl: qcom,qcm2290: use common TLMM schema
      dt-bindings: pinctrl: qcom,sdx55: fix matching pin config
      dt-bindings: pinctrl: qcom,sdx55: use common TLMM schema
      dt-bindings: pinctrl: qcom,sdx55: fix indentation in example
      dt-bindings: pinctrl: qcom,sdx65: fix matching pin config
      dt-bindings: pinctrl: qcom,sdx65: use common TLMM schema
      dt-bindings: pinctrl: qcom,sc7280: fix matching pin config
      dt-bindings: pinctrl: qcom,sc8280xp: fix indentation in example (remaining piece)
      dt-bindings: pinctrl: qcom,sdm845: convert to dtschema
      dt-bindings: pinctrl: qcom,sdm630: convert to dtschema
      dt-bindings: pinctrl: qcom,sm8250: add gpio-reserved-ranges and gpio-line-names
      dt-bindings: pinctrl: qcom,sm8250: use common TLMM pin schema
      dt-bindings: pinctrl: qcom,sm8250: fix matching pin config
      dt-bindings: pinctrl: qcom,sm8250: add input-enable
      dt-bindings: pinctrl: qcom,sc7280: correct number of GPIOs
      dt-bindings: pinctrl: qcom,sc7280: add bias-bus-hold and input-enable
      dt-bindings: pinctrl: qcom,sc7280: use common TLMM pin schema
      dt-bindings: pinctrl: qcom,ipq6018: replace maintainer
      dt-bindings: pinctrl: qcom,mdm9607: drop ref to pinctrl.yaml
      dt-bindings: pinctrl: qcom,sc8180x: drop ref to pinctrl.yaml
      dt-bindings: pinctrl: qcom,sc8180x: drop checks used in common TLMM
      dt-bindings: pinctrl: qcom,sc8280xp: drop checks used in common TLMM
      dt-bindings: pinctrl: qcom,sm6115: use common TLMM schema
      dt-bindings: pinctrl: qcom,sm6125: drop checks used in common TLMM
      dt-bindings: pinctrl: qcom,sm6125: drop ref to pinctrl.yaml
      dt-bindings: pinctrl: qcom,sm6350: drop ref to pinctrl.yaml
      dt-bindings: pinctrl: qcom,sm6350: drop checks used in common TLMM
      dt-bindings: pinctrl: qcom,sm6375-tlmm: drop ref to pinctrl.yaml
      dt-bindings: pinctrl: qcom,sm6375-tlmm: drop checks used in common TLMM
      dt-bindings: pinctrl: qcom,sm8250: use common TLMM schema
      dt-bindings: pinctrl: qcom,sm8350: drop ref to pinctrl.yaml
      dt-bindings: pinctrl: qcom,sm8350: drop checks used in common TLMM
      dt-bindings: pinctrl: qcom,sm8450: drop checks used in common TLMM
      dt-bindings: pinctrl: qcom,mdm9607-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,msm8909-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,qcm2290-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sdx65-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sc8180x-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sc8280xp-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sm6115-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sm6125-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sm6350-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sm6375-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sm8250: minor style cleanups
      dt-bindings: pinctrl: qcom,sm8350-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sm8450-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: minor style cleanups
      dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: minor style cleanups
      dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: minor style cleanups
      dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: minor style cleanups
      dt-bindings: pinctrl: qcom: adjust description
      dt-bindings: pinctrl: qcom,sm8150: convert to dtschema
      dt-bindings: pinctrl: qcom,msm8998: convert to dtschema
      dt-bindings: pinctrl: qcom,msm8996: convert to dtschema
      dt-bindings: pinctrl: qcom,msm8994: convert to dtschema
      dt-bindings: pinctrl: qcom: drop minItems equal to maxItems
      dt-bindings: pinctrl: qcom,msm8974: convert to dtschema
      dt-bindings: pinctrl: qcom,sc7180: convert to dtschema

Neil Armstrong (1):
      dt-bindings: pinctrl: convert qcom,mdm9615-pinctrl.txt to dt-schema

 .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml     | 113 +++++------
 ...mdm9607-pinctrl.yaml => qcom,mdm9607-tlmm.yaml} |  41 ++--
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt      | 161 ----------------
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     | 119 ++++++++++++
 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml     | 103 ++++------
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml        |  75 ++++----
 .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml     |  97 ++++------
 .../bindings/pinctrl/qcom,msm8974-pinctrl.txt      | 121 ------------
 .../bindings/pinctrl/qcom,msm8974-pinctrl.yaml     | 179 ++++++++++++++++++
 .../bindings/pinctrl/qcom,msm8994-pinctrl.txt      | 186 ------------------
 .../bindings/pinctrl/qcom,msm8994-pinctrl.yaml     | 162 ++++++++++++++++
 .../bindings/pinctrl/qcom,msm8996-pinctrl.txt      | 208 ---------------------
 .../bindings/pinctrl/qcom,msm8996-pinctrl.yaml     | 182 ++++++++++++++++++
 .../bindings/pinctrl/qcom,msm8998-pinctrl.txt      | 202 --------------------
 .../bindings/pinctrl/qcom,msm8998-pinctrl.yaml     | 171 +++++++++++++++++
 ...qcm2290-pinctrl.yaml => qcom,qcm2290-tlmm.yaml} |  64 ++-----
 .../bindings/pinctrl/qcom,sc7180-pinctrl.txt       | 187 ------------------
 .../bindings/pinctrl/qcom,sc7180-pinctrl.yaml      | 158 ++++++++++++++++
 .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     |  48 +++--
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml      |  47 ++---
 ...sc8180x-pinctrl.yaml => qcom,sc8180x-tlmm.yaml} |  29 +--
 .../pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml   |  44 ++++-
 ...8280xp-pinctrl.yaml => qcom,sc8280xp-tlmm.yaml} |  28 +--
 .../bindings/pinctrl/qcom,sdm630-pinctrl.yaml      | 188 +++++++++++++++++++
 .../bindings/pinctrl/qcom,sdm660-pinctrl.txt       | 191 -------------------
 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt       | 176 -----------------
 .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml      | 158 ++++++++++++++++
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml       |  95 ++++------
 ...com,sdx65-pinctrl.yaml => qcom,sdx65-tlmm.yaml} |  62 ++----
 ...m,sm6115-pinctrl.yaml => qcom,sm6115-tlmm.yaml} |  67 ++-----
 ...m,sm6125-pinctrl.yaml => qcom,sm6125-tlmm.yaml} |  32 +---
 ...m,sm6350-pinctrl.yaml => qcom,sm6350-tlmm.yaml} |  25 +--
 .../bindings/pinctrl/qcom,sm6375-tlmm.yaml         |  23 +--
 .../bindings/pinctrl/qcom,sm8150-pinctrl.txt       | 190 -------------------
 .../bindings/pinctrl/qcom,sm8150-pinctrl.yaml      | 173 +++++++++++++++++
 .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     |  58 ++++--
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml      | 206 +++++++++-----------
 ...m,sm8350-pinctrl.yaml => qcom,sm8350-tlmm.yaml} |  25 +--
 .../pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml     |  51 ++++-
 ...m,sm8450-pinctrl.yaml => qcom,sm8450-tlmm.yaml} |  24 +--
 .../bindings/pinctrl/qcom,tlmm-common.yaml         |  20 +-
 41 files changed, 2082 insertions(+), 2407 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,mdm9607-pinctrl.yaml => qcom,mdm9607-tlmm.yaml} (84%)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{qcom,qcm2290-pinctrl.yaml => qcom,qcm2290-tlmm.yaml} (76%)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sc8180x-pinctrl.yaml => qcom,sc8180x-tlmm.yaml} (88%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sc8280xp-pinctrl.yaml => qcom,sc8280xp-tlmm.yaml} (89%)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sdx65-pinctrl.yaml => qcom,sdx65-tlmm.yaml} (85%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6115-pinctrl.yaml => qcom,sm6115-tlmm.yaml} (75%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6125-pinctrl.yaml => qcom,sm6125-tlmm.yaml} (87%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6350-pinctrl.yaml => qcom,sm6350-tlmm.yaml} (90%)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm8350-pinctrl.yaml => qcom,sm8350-tlmm.yaml} (89%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm8450-pinctrl.yaml => qcom,sm8450-tlmm.yaml} (89%)
