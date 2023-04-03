Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53416D51DA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjDCUFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjDCUFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:05:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBC43581
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:05:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j24so30633878wrd.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680552336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ypjGSD9MoiyC/BSmZV4rpdSicxantTDyraV9ZwR3Wko=;
        b=HUKwUP5VZRNpodrnPPM3ifw1bAJa/1Pwl19tZY0gZTDQdqvslDjrKagBUWgrt8/NY1
         iJ2tN7m+ZqpRE+cPJMdWcNCThCpokwmT7wlwclKRVO8wDwCdc/pV4pkMjvEhq5no8djC
         kPGn53hin1pRv+iB8fzqU95rfylIHRDYJ0C5vDUFdDcMnNXlFDzMODxFRuRHDnhIfDgD
         CXJ6y6TnYjCZVy6iOCDFQph/FZRUWWpdmfYk6xaMyt1+X7y038/HXHZtZNOQxDMfQztv
         7Znx05mTUxZUmAcoNI+qMtJA3exG/ecL3Ah/qeCHRICM69kcalZ0fIqnlwgmhR9/jGmJ
         RS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680552336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypjGSD9MoiyC/BSmZV4rpdSicxantTDyraV9ZwR3Wko=;
        b=AFEPnRLCgLmy+zFBP5i2hyEci1RU4DkX4zaYfnNqcFz5tM6APQVMOy2/Wayu6QbNz5
         PkdGfthsn2i15eQ6pXJ7qyP0wTlqRa+LvFxXchxWGKTYn/OtOki6E3TKv4Yu/MFhkjBq
         fZBeBqhdsfGOsyTktnMRvsfz1c5TzBq0Qlz+Dh7XwjN/hAii1HFC1qjWrlxCLFibVKge
         sUw8TMqT6ql6IWRJsmZmiacCiNPHHybuYPsZf/uCzhWUxlxqikQYA/R0gRLEAlDcfGnC
         a149cDnAdMpuiy1jnN/LBnzg8TXW/+D6YJLYfLaZszhZhcVdkmEL5mFrI3dBAlLCfNxY
         sEIg==
X-Gm-Message-State: AAQBX9eq/g9T5GiCv8gbQ3xS73tA9L6hyrhaqbTjc44bqPyamXrSfof5
        TsUZ3qMaaZ21bNNegcU2yxbbfA==
X-Google-Smtp-Source: AKy350Ykoxehj3xlHAZUYS0YuJeY0lOEIiHNddtOkaPl+8pQTa1wGWFgeMQoaWYcLwn59zlnlqdkXg==
X-Received: by 2002:adf:dbcf:0:b0:2ce:da65:1e1d with SMTP id e15-20020adfdbcf000000b002ceda651e1dmr14024101wrj.24.1680552336280;
        Mon, 03 Apr 2023 13:05:36 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b003ef69873cf1sm20798037wmb.40.2023.04.03.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:05:35 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v5 0/6] Add dedicated Qcom ICE driver
Date:   Mon,  3 Apr 2023 23:05:24 +0300
Message-Id: <20230403200530.2103099-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

As both SDCC and UFS drivers use the ICE with duplicated implementation,
while none of the currently supported platforms make use concomitantly
of the same ICE IP block instance, the new SM8550 allows both UFS and
SDCC to do so. In order to support such scenario, there is a need for
a unified implementation and a devicetree node to be shared between
both types of storage devices. So lets drop the duplicate implementation
of the ICE from both SDCC and UFS and make it a dedicated (soc) driver.
Also, switch all UFS and SDCC devicetree nodes to use the new ICE
approach.

The v4 is here:
https://lore.kernel.org/all/20230327134734.3256974-1-abel.vesa@linaro.org/

Changes since v4:
 * dropped the SDHCI dt-bindings patch as it will be added along
   with the first use of qcom,ice property from an SDHCI DT node

See each individual patch for changelogs.

Abel Vesa (6):
  dt-bindings: crypto: Add Qualcomm Inline Crypto Engine
  dt-bindings: ufs: qcom: Add ICE phandle
  soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver
  scsi: ufs: ufs-qcom: Switch to the new ICE API
  mmc: sdhci-msm: Switch to the new ICE API
  arm64: dts: qcom: sm8550: Add the Inline Crypto Engine node

 .../crypto/qcom,inline-crypto-engine.yaml     |  42 ++
 .../devicetree/bindings/ufs/qcom,ufs.yaml     |  19 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  10 +
 drivers/mmc/host/Kconfig                      |   2 +-
 drivers/mmc/host/sdhci-msm.c                  | 220 +++--------
 drivers/soc/qcom/Kconfig                      |   4 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/ice.c                        | 365 ++++++++++++++++++
 drivers/ufs/host/Kconfig                      |   2 +-
 drivers/ufs/host/Makefile                     |   4 +-
 drivers/ufs/host/ufs-qcom-ice.c               | 244 ------------
 drivers/ufs/host/ufs-qcom.c                   |  97 ++++-
 drivers/ufs/host/ufs-qcom.h                   |  32 +-
 include/soc/qcom/ice.h                        |  37 ++
 14 files changed, 626 insertions(+), 453 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
 create mode 100644 drivers/soc/qcom/ice.c
 delete mode 100644 drivers/ufs/host/ufs-qcom-ice.c
 create mode 100644 include/soc/qcom/ice.h

-- 
2.34.1

