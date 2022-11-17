Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E228262E289
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbiKQRFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbiKQRFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:05:03 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0599E7340B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:05:01 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k8so4952144wrh.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5YzaVX692xNQHy7JextiJs22gCvsGFaf17mRFu01f0=;
        b=rdxQsuVRgYXAnE5PzydAusyFiXb6L0FkB8j+unRFH10XWUUCgfs/PKiZwtsznuAg5/
         JqY1LeSgs/E95ExPb59eGyUT3dAkn76dol+Y+zGNxTJPUSRtD64eVhCELo7Dy5fmnhjL
         G9mHO5ye51ulMyVIRw3rWXbB8B8wKOmnlhKz69d8nR8em9djDU+s0evyQ/mQuawBcaw+
         jqW/8Fv1fSfP2qPST7/qYR7L7U9+n9rH/gnv015WuU/KC0sQWho2i02+JgWT8OY6P78v
         lHYFE5/ttfhUNMaCHP7ERdEc/pgme0Rt+KuThIPgQPENmjygcqViEV/klEQwcUXvuQcj
         mihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5YzaVX692xNQHy7JextiJs22gCvsGFaf17mRFu01f0=;
        b=cqlfE+L4GBtJBmrSBylGe3bEEtRt+IC36XBpJY1nJ1nxbYKMNz1GCSdKgTR1VaSeRs
         fI6f3BX8VdvR7RzAyY5951Nb61P3YjBQj1V5KpeAKDhNmFeXw9K/4jwod51am8fzgLD0
         N1dk49QXg97xcyay7eEDdHkZ4RlACOSe+KHH2Z0AH/FsVcnfdmTZ3IPKpe8Eow/Jompo
         HOtbtAABW5UYj2h3q7FijzgRdUf9/HCDI5bMdTPbCTxkB/6VukWqAA9Y3RpSxM3l2KkX
         AD7gH5MHrtKmfjecOffCpHHC5X1V/brYICI7dRbJXFdojqgWA62MV36YZv8lRfEjHTLO
         Ae+w==
X-Gm-Message-State: ANoB5pmb+JNx1l9zrmeh0yqrNbFZ8gO5dzsa9lvr+mZbDKuZbKafYA8z
        3fgr9mCU5dYKMfrXorbMMngiRg==
X-Google-Smtp-Source: AA0mqf6RoByX41Vu5Bsqe5wcES9V/i2R41Nw5XK4RjbOUbPyt+w6Tovi9HbqEClCqzOjRqzcucAkiA==
X-Received: by 2002:a5d:5d0d:0:b0:236:ea0d:e49b with SMTP id ch13-20020a5d5d0d000000b00236ea0de49bmr2093974wrb.472.1668704700304;
        Thu, 17 Nov 2022 09:05:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d668d000000b00236488f62d6sm1396225wru.79.2022.11.17.09.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 09:04:59 -0800 (PST)
Subject: [PATCH v5 0/2] arm: qcom: mdm9615: second round of bindings and DT fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIALlpdmMC/43NTWrDMBAF4KsErasyo79UXfUeJYuxPIkFshyk1BCC756hu5JFvRreg/fNQ3Vumb
 v6PDxU4zX3vFQJ/u2g0kT1wjqPkpUBYxDA63mcY0Cvr7mmWyv6TnPRaM8+4Qe50ZKS6UCd9dCopknG
 9acUKafcb0u7/75aUc73P+qKGjSkIQEENmThq+RKbXlf2kWdRFzNHsWIEmw8czgSuIFfFLtHsaKwZ3
 A+OBeP+KK4PYoTxQXrjY0YE8Y/yrZtT7d5kPCQAQAA
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 17 Nov 2022 18:04:57 +0100
Message-Id: <20221005-mdm9615-pinctrl-yaml-v5-0-910019fb8b9b@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
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

Dependencies: None

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v5:
- Fixed bindings invalid id after rename
- Fixed invalid ref path to qcom,rpm-regulator.yaml from qcom,rpm.yaml bindings
- Link to v4: https://lore.kernel.org/r/20221005-mdm9615-pinctrl-yaml-v4-0-463523919c19@linaro.org

Changes in v4:
- Removed applied patches
- Removed "-ipc" from bindings file name and removed IPC from title & description
- Added the review tags from v3 after file renaming & title/description change, after Lee's acceptation
- Link to v3: https://lore.kernel.org/r/20221005-mdm9615-pinctrl-yaml-v3-0-e5e045644971@linaro.org

Changes in v3:
- Path 1: Removed from serie because applied
- Path 2: None
- Path 3: Added reviewed-by tag
- Path 4: Fixed dt-schema title and added unevaluatedProperties
- Path 5: Various schema fixes, uses same naming as other dt-schema for qcom regulators
- New patch added changing regulators names of msm8660 to conform to bindings
- Link to v2: https://lore.kernel.org/r/20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org

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
Neil Armstrong (2):
      dt-bindings: regulators: convert non-smd RPM Regulators bindings to dt-schema
      dt-bindings: soc: qcom: convert non-smd RPM bindings to dt-schema

 Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 283 ---------------------
 .../bindings/regulator/qcom,rpm-regulator.yaml     | 128 ++++++++++
 .../devicetree/bindings/soc/qcom/qcom,rpm.yaml     | 101 ++++++++
 3 files changed, 229 insertions(+), 283 deletions(-)
---
base-commit: 19d64985796125c5e3820c3db995c5df6d13d6dc
change-id: 20221005-mdm9615-pinctrl-yaml-13f5c18a4d3a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
