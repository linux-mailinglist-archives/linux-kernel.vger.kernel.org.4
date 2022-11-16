Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0762B7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiKPKUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiKPKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:20:09 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DBD20355
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:20:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bs21so29124563wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=4GbCp2O6gNlxizJu7Tt319PycX9j6Cvapw5rEbbaWYE=;
        b=RB85ZkAGAFgykfXmTuudVziBYc58FcKva7Q9NIeE4NNXNbDzCI+EBB5ZuflomH6jHu
         JLh7DyBRLwEuRSq+ofCabRSVYbpQesOeg4RopB+BK0QlvglDJme3oRrccBfDF4K91GYL
         Y1IfaspOXiJ8Hq9lWVU9VRYD+9v7jzYGLGB3fGCwsnAlFgqiuAqbL+yMV1I06a7ueH6w
         gPV14v6ySprwnuZllMArBEjAhJTpDaT8eWlgfMGdkUZHewnF/EGHQVx9x0Nyoavtslx4
         R8EsZ0OYWOLr4+o+RfaECQqZko/jO+FaNmSL+WR8DeuTMO88nAgBwhouVAfgz/qJPa24
         3zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GbCp2O6gNlxizJu7Tt319PycX9j6Cvapw5rEbbaWYE=;
        b=QeEwzGyrN3rBWl6gNj+UtYzS5RK1N5/oj+S4DNZqnkEmQa0uL7KhiGgyjwdNF8KgxM
         dVRjuJ9NMx8zPCPi8nQ5FdFkb0QQysLVBldj+mJ2ygi6Ur/7gt6cCWZlVSpLNjYlkEym
         k/7Mmy+eZ7m8yz//dGxzJ5Xpy3t2LVBsI3OCL68rIzfPIuiXRInapmUCIw5yHR2SpGFe
         rIkXzlqte0GRx067+1BuS9+Vt7YWY7sPHdct3MbCQe6N4/tparY4q8G9G7NXg9qXqNUw
         msgudAx6YVve2bxkTHX6xKaMZy9xk7SX3MQSoIUjTrDaps1WS4J2CoUm0LRkazO5YInE
         fXpQ==
X-Gm-Message-State: ANoB5pmtmkaimwms35i/1YK8P2lZqR2ASIl9Bshvm0A8SgHpfgkHttf3
        okNl10AOTv4PS6lyCUZC+4b6mA==
X-Google-Smtp-Source: AA0mqf6bXo/yUx9vllMy2Zq5WppjBrpj28lotzV7nTNpErTa+jQgcdFkjyxBPN6r37AINX/Qmu1lhg==
X-Received: by 2002:adf:fcc7:0:b0:236:8dd7:1917 with SMTP id f7-20020adffcc7000000b002368dd71917mr12916241wrs.587.1668594005978;
        Wed, 16 Nov 2022 02:20:05 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c4f1200b003c6f3f6675bsm1709900wmq.26.2022.11.16.02.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:20:05 -0800 (PST)
Subject: [PATCH 0/4] remoteproc: qcom_q6v5_pas: add support for SM8550 adsp, cdsp & mpss
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAFO5dGMC/w3MQQ6EIAwAwK+YnrcJICbG3wAWJZFiWt2L8e9ynMs8oCSFFJbhAaF/0dK4w/4GSH
 vgjbCs3eCMc9Zajxyk6iWNN9Q6T5PB++ymUFGototOaQln4/OYYxx9zNCvGJQwSuC0943v43jfD9pd TC58AAAA
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:20:03 +0100
Message-Id: <20221114-narmstrong-sm8550-upstream-remoteproc-v1-0-104c34cb3b91@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
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
Abel Vesa (1):
      dt-bindings: misc: qcom,fastrpc: increase allowed iommus entries

Neil Armstrong (3):
      dt-bindings: remoteproc: qcom: adsp: document sm8550 adsp, cdsp & mpss compatible
      remoteproc: qcom_q6v5_pas: add support for dtb co-firmware loading
      remoteproc: qcom_q6v5_pas: add sm8550 adsp, cdsp & mpss compatible & data

 .../devicetree/bindings/misc/qcom,fastrpc.yaml     |   2 +-
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |  60 ++++++-
 drivers/remoteproc/qcom_q6v5_pas.c                 | 199 +++++++++++++++++++--
 3 files changed, 246 insertions(+), 15 deletions(-)
---
base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
change-id: 20221114-narmstrong-sm8550-upstream-remoteproc-804f3fbb34bf

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
