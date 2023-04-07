Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257EE6DA8C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjDGGLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjDGGLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:11:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0C55FC8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 23:11:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-62815785926so291751b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 23:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680847894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmR6rgctA5h10qi1E78YOiMPgpuJw+XUWgs2ChaCqpA=;
        b=jODbys5Apjv7G2eYFmFneVRNWweq5T5O59tDNnQOXJxee50FOgwRIdkDzdq0Kdanhr
         Cke51z1sgQEKCgS4MHLHgzSTHSQlHZJjfHLMshUxX2cgq56MiSm5ldiI1GAn9H55rODy
         MdI1gd58eKVBF5qT+R5i1eTcl3HqtWcpNfX+jdC/Zcc55oKtvEWByPI7O5MKfqMPpcf2
         Vxl+AngaHUao19oybBOjcyaW/9hFgfvx9b9itGKU0Aj458+7afFVmLqu71tAfkeY81cc
         20X4G16nvTPMUmvFFVpZUJQnqV7ajI2dX9y8yTIdb9jiTZ0rY6B3CV1jayfFSfa+eXbZ
         8dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680847894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmR6rgctA5h10qi1E78YOiMPgpuJw+XUWgs2ChaCqpA=;
        b=K9CEaaCzywi+IsRLVsZuxTBPiScJGEUcQs7IkUIUhtW2kePXIBkJYEa8HBOZfu8Mj+
         swTodmBeQRAPaEXBRCH050RU6+YQYvqWhaUX2CtrxfaWqSJyLanJ1P2uFv+RbE2RDQrh
         k9RzV5voRtenNYlrh6lXvXvtCzYB38squaiObewzTTvTTkqnGPfDifUWxpwvrNOWHVdf
         3CZt6EtS5chZdSz7mtaP8BHytED4wjv5mB5i4Ju0JLT28C2jU6JPvO1twZKrpTg6f8QW
         5rGu1zesV3b5vQSvS7fmD3vmZBydEITHizpy2PqRWVGloUEjBbN9e4aEewIZ6EG/e60S
         JV0g==
X-Gm-Message-State: AAQBX9cjRsbnzhuSKE5o+TvbbnjXbdy2yWkHnnTnv8S+Fx1T017BXi/g
        QjBSEg73kBxP+z5ryxL12RY9Ww==
X-Google-Smtp-Source: AKy350Y7KRs3leRqQpn30cRKbXpN644SPm6MQrKtQyUq0iAZ3hOGXe20kE/v1O6tA+VYYJhJ9Jhz7w==
X-Received: by 2002:a62:38c9:0:b0:625:4b46:e019 with SMTP id f192-20020a6238c9000000b006254b46e019mr1077459pfa.9.1680847893649;
        Thu, 06 Apr 2023 23:11:33 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6a11:8ba1:beba:def7:a4ae])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78399000000b0062d7e9bb17asm2253879pfm.81.2023.04.06.23.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 23:11:33 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v6 0/2] Enable USB SS qmp phy for Qualcomm SM6115 SoC
Date:   Fri,  7 Apr 2023 11:41:20 +0530
Message-Id: <20230407061122.2036838-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v5:
-----------------
- v5 can be seen here: https://lore.kernel.org/linux-arm-msm/20230405191633.1864671-1-bhupesh.sharma@linaro.org/
- Addressed review comments from Dmitry and made [PATCH 1/2] compatible with his 
  'split away legacy USB+DP code' series:
  <https://patchwork.kernel.org/project/linux-phy/cover/20230324215550.1966809-1-dmitry.baryshkov@linaro.org>

Changes since v4:
-----------------
- v4 can be seen here: https://lore.kernel.org/linux-arm-msm/20230401154725.1059563-1-bhupesh.sharma@linaro.org/ 
- Collected Krzysztof's Ack for [PATCH 1/2].
- Added more descriptive commit logs as per Dmitry's comments on v4.

Changes since v3:
-----------------
- v3 can be seen here: https://lore.kernel.org/linux-arm-msm/20221215094532.589291-4-bhupesh.sharma@linaro.org/
- Fixed v4 as per the downstream driver code: https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/bengal-usb.dtsi#296

This patchset adds the support for USB SS qmp phy for Qualcomm SM6115
SoC. For the previous versions of this patch there were conversations
on irc as to whether this was a 'qcom,usb-ssphy-qmp-usb3-or-dp' or a
'qcom,usb-ssphy-qmp-dp-combo' as per downstream code and hardware
documentation.

But after a careful look at downstream dtsi (see [1]) it appears that
this indeed is a 'qcom,usb-ssphy-qmp-usb3-or-dp' phy and not a
'dp-combo' phy.

[1]. https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/bengal-usb.dtsi#296

Bhupesh Sharma (2):
  dt-bindings: phy: qcom,qmp-usb: Drop legacy bindings and move to newer
    one (SM6115 & QCM2290)
  arm64: dts: qcom: sm6115: Add USB SS qmp phy node

 .../phy/qcom,msm8996-qmp-usb3-phy.yaml        |  27 -----
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   | 109 +++++++++++++++++-
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |   3 +
 arch/arm64/boot/dts/qcom/sm6115.dtsi          |  36 +++++-
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |   3 +
 5 files changed, 144 insertions(+), 34 deletions(-)

-- 
2.38.1

