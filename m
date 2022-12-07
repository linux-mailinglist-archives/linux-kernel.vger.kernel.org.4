Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CC96461A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiLGTXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLGTXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:23:34 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4430663DF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:23:32 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id f18so29505172wrj.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 11:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=C/ucFAOI2Iw49PsMpiLJ1W8f9WPorHFdTdwmC6zDH1Q=;
        b=xZcGUw7j/udNJzp6q3v9DnUQWnrnBHrOYufYXtsJ11DOBsBVl/aA7pLZMQwWVGUDcO
         GH99Jd7+2wXr9IlQRN/nL5tdSYmJ1Q3KAPLKvhO5bFoUdnvvpPGK6arrHluEu1yjUSEd
         ikqYxDgj+iJkfRhPQYjrL368LyVoGdnSwJnXA9SAABpiyA4ifSi17L9F7KoB/bi3iLHF
         np6OYplDTy7zLgw+6U/HpRLl/YS7uidTY5hhdWW7f853HhWLJuv4sSYpeYK3OKABHV7p
         +hv69RTRQpHkImI6bRmhcZllEpOvRs68tFWtRiile+Xvpv5mDD6VL/Ke52Z/LCbBOwZY
         Tkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/ucFAOI2Iw49PsMpiLJ1W8f9WPorHFdTdwmC6zDH1Q=;
        b=YSZKh3kATljz+6XDLjMefz+6Uzh/uf9qeU+RWclfhI9lorjjS9Qorav1F8ayg5zidz
         0jgDADtuMFdtLvYcj5B0wle43OER90206lkxvuXfQAI3O0XG/ZWglEx8nxzc65gknBlj
         MXgpct8AOTXfGtwKEha2k+2d5gQxYL0OOjfEfYrGpLq/stEdLRJo+Rl+AHdLbI+8VE5M
         zINmP+vWeh6KxwpBRfrl2C7SO+7tki/6PXF1KRo7cADtPlPJ+PI10NSrn9afyyXJTzrJ
         vicR7EnTycWpB8JDd673R5J9Bzjtk4RR6Xh71H82uTeQ/Et1fR5VHKAoEsBzzkob1oDe
         YEyw==
X-Gm-Message-State: ANoB5pmQioY94Ikurw/ADZEAu49PM2OZd6j7jZ7GBfSLjYvXGZ6VXuHE
        Af1CucvlFcbJu83AB90grJw2VQ==
X-Google-Smtp-Source: AA0mqf7lUzeg/Mb/Jc7Mj6zbY1CYia5Xmj0KlBbI1SWWuFUnP5qsvIXERkQSaTKgQltRJR1knP0y0w==
X-Received: by 2002:a5d:610d:0:b0:242:4fd1:1f5c with SMTP id v13-20020a5d610d000000b002424fd11f5cmr12540012wrt.376.1670441011388;
        Wed, 07 Dec 2022 11:23:31 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d5441000000b002422b462975sm19400355wrv.34.2022.12.07.11.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 11:23:31 -0800 (PST)
Subject: [PATCH v3 0/5] remoteproc: qcom_q6v5_pas: add support for SM8550 adsp, cdsp & mpss
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIACrokGMC/52NQQ6CMBBFr0K6dkw7LRFdeQ/joq0FmkBLpkBiCHd3dOdSV5M3yX9vEyVQDEVcqk
 1QWGOJOTHoQyV8b1MXID6YBUpEpZSBZGksM+XUQRmbupawTMzBjkBhzHOYKHtopGl165w2rhXscrYE
 cGST79mWlmHgZx/LnOn5aa+Kz+3XzKpAgpLGa+Oddmd1HSIv8zFTJ+6cWPEvLb616Dwi1rU5mS/tvu 8vabEcQjcBAAA=
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Dec 2022 20:23:22 +0100
Message-Id: <20221114-narmstrong-sm8550-upstream-remoteproc-v3-0-62162a1df718@linaro.org>
To:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-remoteproc@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchsets adds support for the aDSP, cDSP and MPSS found in the
SM8550 SoC.

The aDSP, cDSP and MPSS boot process on SM8550 now requires a secondary
"Devicetree" firmware to be passed along the main Firmware, and the cDSP
a new power domain named "NSP".

In order to satisfy the load & authentication order required by the SM8550
SoC, the following is implemented:
- "Devicetree" firmware request & load in dedicated memory
- Q6V5 prepare
- Power Domain & Clocks enable
- "Devicetree" firmware authentication
- Main firmware load in dedicated memory
- Main firmware authentication
- Q6V5 startup
- "Devicetree" firmware metadata release
- Main metadata release

When booting older platforms, the "Devicetree" steps would be
bypassed and the load & authentication order would still be valid.

Bindings changes depends on:
- https://lore.kernel.org/all/20221124184333.133911-1-krzysztof.kozlowski@linaro.org/

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Changes in v3:
- fix mpss matching in bindings, tested against DT
- Link to v2: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-remoteproc-v2-0-12bc22255474@linaro.org

Changes in v2:
- Moved the SM8550 pas bindings on top of "split and reorganize PAS/PIL" v3 patchset 
- Incorporated DSM memory support into pas bindings & driver
- Moved second DTB firmware into second entry of firmware-name
- Dropped applied "qcom,fastrpc: increase allowed iommus entries" patch
- Link to v1: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-remoteproc-v1-0-104c34cb3b91@linaro.org

---
Neil Armstrong (5):
      dt-bindings: remoteproc: qcom: adsp: move memory-region and firmware-name out of pas-common
      dt-bindings: remoteproc: qcom: adsp: document sm8550 adsp, cdsp & mpss compatible
      remoteproc: qcom_q6v5_pas: add support for dtb co-firmware loading
      remoteproc: qcom_q6v5_pas: add support for assigning memory to firmware
      remoteproc: qcom_q6v5_pas: add sm8550 adsp, cdsp & mpss compatible & data

 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |   4 +
 .../bindings/remoteproc/qcom,pas-common.yaml       |   8 -
 .../bindings/remoteproc/qcom,qcs404-pas.yaml       |   8 +
 .../bindings/remoteproc/qcom,sc7180-pas.yaml       |   8 +
 .../bindings/remoteproc/qcom,sc8180x-pas.yaml      |   8 +
 .../bindings/remoteproc/qcom,sc8280xp-pas.yaml     |   8 +
 .../bindings/remoteproc/qcom,sdx55-pas.yaml        |   8 +
 .../bindings/remoteproc/qcom,sm6350-pas.yaml       |   8 +
 .../bindings/remoteproc/qcom,sm8150-pas.yaml       |   8 +
 .../bindings/remoteproc/qcom,sm8350-pas.yaml       |   8 +
 .../bindings/remoteproc/qcom,sm8550-pas.yaml       | 178 ++++++++++++++
 drivers/remoteproc/qcom_q6v5_pas.c                 | 271 ++++++++++++++++++++-
 12 files changed, 504 insertions(+), 21 deletions(-)
---
base-commit: 268975e1af25cd83994d24c46ad0d95753291f64
change-id: 20221114-narmstrong-sm8550-upstream-remoteproc-804f3fbb34bf

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
