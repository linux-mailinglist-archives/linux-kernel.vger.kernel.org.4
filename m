Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E10E62BD17
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiKPMH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiKPMHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:07:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C749C1261C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d9so24832215wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpRgnbMi8qckAARNiFgw/+KtlyEj1vTV5D3PXlU2xTg=;
        b=vj3zT89Y9w4Wmm6PjLwvVOBkxfmwSg71xksovxuPW14LdTfbw12qfIabfdtDu/+qt7
         C2IfBL6jUaK0shIZ3cf0uxGE+cqEBdowBAsxePJ+8ThqoPH8NFcfPV3ULp4EWnZmM8gp
         B9zCTYy7S3Z7mlFNGzu6LiTvfhs608kKx0bLOK/nFdC2ct9N/qnpIGVNidhHyuopolWW
         Whq3XkSZb8P57pXpoERARY90aPcOBPXZLiiN1VaZtLB+CTro6HdiPDJbFhXUgTKDi4xm
         vp/wrHyTJmWfp1pOXCeri51IyaCGZJNP8gsnTEKpZFS3fPSROCHDDcbSGEkTrt8aqIgD
         jgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpRgnbMi8qckAARNiFgw/+KtlyEj1vTV5D3PXlU2xTg=;
        b=NXQvVJLrq1qI4f4k6gLM9ntmCJ/sAHKaJojBzeMVuHnkxhRlNyHtUDiDHywt9ZrE5C
         oXtYwnSIk6Fe5B3Fqhn8Fu9FQbqFdvEGwz/Ae1k6ixO4+F9/DMYmAwzcibqlUZZE0mkp
         L1GnrRL1qwTOHAd0vjAPcOVolStVVznhTjbYlAzTP8L9K8vTuUQIQtfxKBE6gUFNCxVa
         Khf8XIEoca8baVy6Zu3BpeCbUlp4FWx86+OSjNsIef1XPRi7YUqjT7yjVVCjzwoItUux
         M55yQawXV8XAogYO03JtTEJpVya7ATy35tG0cc/n+4Wa5fernv6bSZKtqbPn8iNkaLbf
         k9HA==
X-Gm-Message-State: ANoB5pkFV4ROy66VMVrJFzvNass01q29WlvIKYnssIAuXBmR3mXGEmau
        MPheLLQReDE25kv6gmwmA3yMWQ==
X-Google-Smtp-Source: AA0mqf6ixmpppWedB5Oh+piLn1Omme6b6zbkSxNf6UmceeGl0ZaoCF8e8wNiQu1SaTCKMsF8koLSlw==
X-Received: by 2002:a05:6000:181c:b0:236:60ce:7c10 with SMTP id m28-20020a056000181c00b0023660ce7c10mr13546096wrh.440.1668600120343;
        Wed, 16 Nov 2022 04:02:00 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b002206203ed3dsm15120109wrx.29.2022.11.16.04.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:01:59 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH 00/10] phy: qualcomm: Add support for SM8550
Date:   Wed, 16 Nov 2022 14:01:47 +0200
Message-Id: <20221116120157.2706810-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This patchset adds PHY support for the PCIe, UFS and USB found in
the new Qualcomm SM8550 SoC. Since the SM8550 bumps the HW version
to 6.0 (respectively, 6.20 for PCIe G4), add support for it beforehand.
The SM8550 also uses Synopsis eUSB2 PHY, so add a dedicated driver
for it.

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Abel Vesa (9):
  phy: qcom-qmp: qserdes-com: Add v6 register offsets
  dt-bindings: phy: Add QMP UFS PHY comptible for SM8550
  phy: qcom-qmp-ufs: Add SM8550 support
  dt-bindings: phy: qcom,qmp-usb: Document SM8550 compatible
  phy: qualcomm: qmp-usb: Add support for SM8550
  dt-bindings: phy: qcom,qmp-pcie: Document SM8550 compatible
  phy: qualcomm: qmp-pcie: Add support for SM8550 g3x2 and g4x2 PCIEs
  dt-bindings: phy: Add qcom,snps-eusb2-phy schema file
  phy: qualcomm: Add QCOM SNPS eUSB2 driver

Neil Armstrong (1):
  phy: qualcomm: phy-qcom-snps-eusb2: Add support for eUSB2 repeater

 .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        |  38 +-
 .../phy/qcom,msm8996-qmp-ufs-phy.yaml         |  24 +
 .../phy/qcom,msm8996-qmp-usb3-phy.yaml        |   1 +
 .../bindings/phy/qcom,snps-eusb2-phy.yaml     |  84 ++++
 drivers/phy/qualcomm/Kconfig                  |   9 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 354 +++++++++++++
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h   |  15 +
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h    |  23 +
 .../phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h    |  31 ++
 .../phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h    |  31 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h    |  16 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h |  18 +
 .../qualcomm/phy-qcom-qmp-qserdes-com-v6.h    |  75 +++
 .../phy-qcom-qmp-qserdes-ln-shrd-v6.h         |  32 ++
 .../phy-qcom-qmp-qserdes-txrx-ufs-v6.h        |  30 ++
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h   |  68 +++
 .../phy-qcom-qmp-qserdes-txrx-v6_20.h         |  45 ++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       |  91 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 171 +++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  13 +
 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c    | 467 ++++++++++++++++++
 22 files changed, 1634 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-ln-shrd-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c

-- 
2.34.1

