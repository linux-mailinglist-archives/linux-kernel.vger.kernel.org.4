Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBE66ECFDF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjDXOCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjDXOCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:02:08 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1083C30E3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:02:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4edcc885d8fso4887025e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682344925; x=1684936925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v/z8QV1WqouxURsTgQErRlqwgp6f16hAh+dPTsL9aXs=;
        b=aMUSimLF4Ep3btKCt+SwFIhBl5300M6//x4OUQxec+p8HzUnHMAkVLUIPLEtKohhXM
         daUj7dpc/sDP74l9IXnSz3G4fjGbEL4A84rHRFCk3krlnvn1q5TkH1DztXpmzUWlpOSj
         lOzqCj5xWTF4d8aQGU9o2S/ihbjaXI4wJ8ya5P9fvfASnG+Y6CtqjjP8U3I7x62uJ2nO
         tvUZ6G99Y9iNFnV4dcJBRasDFoB5AFByqQxGfw5diTInLCdoCgBynSC7PgNkQzMmLb6b
         KTWnSTOlBJrkiWPsl+BQoOY52uaYPjaBPt5YVHFVYzjJs0OcNkj/WsaS9zkNCtyUNO87
         hKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682344925; x=1684936925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/z8QV1WqouxURsTgQErRlqwgp6f16hAh+dPTsL9aXs=;
        b=VvUWM4TW3KaGhUldDmNuqe+8X7EmH6zoLA4jHH6WPalPGqRMP62NJdOq5Al1L/Kcvv
         ZJ5B4M0+iW0tc2NhzJrwsXL2SMaReN2nRWuIX1/X4BmSe0fNOF9wFtxbrCblbNqbGCFL
         IJmeUpLLn13a/7MzPY3HTSzAaF5dzpu6+MqK3iB1naDRF22wCjcxZR3YcScf2kgqcpUN
         ptoBizNgMsipqIdDAYheKWurj+wG5HOgLi55eMx5x/12cd07YH+a+y9FoRy1IUIvFTqN
         XCAqz57OO3lrPs5b7zV2RfBPzqSK+JfDr95zxsE93feTz8e/HTgCA7CDg5fMzhx3qTTg
         sz0A==
X-Gm-Message-State: AAQBX9fifuGDSVQMRdWUjVGoo+t79Ol2E6O71giYrnkyYI+yIRg5FW8O
        y0VHhUybxz6FswZrBK26okYTbeIY5o3Ob8mjNmI=
X-Google-Smtp-Source: AKy350YghS5sSgp1kVNE/o9b00ZCroqjR2Lw8FTzO4cK3uFz3gfxCV3WDlxfEvquAc2hFm96oCY3Xw==
X-Received: by 2002:a19:ad48:0:b0:4ef:ef8e:56f1 with SMTP id s8-20020a19ad48000000b004efef8e56f1mr885202lfd.49.1682344925206;
        Mon, 24 Apr 2023 07:02:05 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id q14-20020ac25a0e000000b004eff530efe7sm187385lfn.93.2023.04.24.07.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 07:02:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v6.4
Date:   Mon, 24 Apr 2023 16:02:03 +0200
Message-Id: <20230424140203.4565-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the PR with the MMC and MEMSTICK updates for v6.4-rc1. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 4b6d621c9d859ff89e68cebf6178652592676013:

  memstick: fix memory leak if card device is never registered (2023-04-05 11:43:51 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.4

for you to fetch changes up to 22a4455e75be443fb80784175bb70f40ba6d0c52:

  dt-bindings: mmc: sdhci-msm: Document the IPQ5018 compatible (2023-04-17 11:54:26 +0200)

----------------------------------------------------------------
MMC core:
 - Allow an invalid regulator in mmc_regulator_set_ocr()
 - Log about empty non-removable slots
 - Add helpers to enable/disable the vqmmc regulator

MMC host:
 - mtk-sd: Add support for the mt8365 variant
 - renesas_sdhi: Remove support for R-Car H3 ES1.* variants
 - sdhci_am654: Add power management support
 - sdhci-cadence: Add support for eMMC hardware reset
 - sdhci-cadence: Add support for AMD Pensando Elba variant
 - sdhci-msm: Add support for the IPQ5018 variant
 - sdhci-msm: Add support for the QCM2290 variant
 - sdhci-of-arasan: Skip setting clock delay for 400KHz
 - sdhci-of-arasan: Add support for the Xilinx Versal Net variant
 - sdhci-of-arasan: Remove Intel Thunder Bay SOC support
 - sdhci-of-arasan: Add support to request the "gate" clock
 - sdhci-of-dwcmshc: Properly determine max clock on Rockchip
 - sdhci-of-esdhc: Fix quirk to ignore command inhibit for data
 - sdhci-pci-o2micro: Fix SDR50 mode timing issue

MEMSTICK:
 - r592: Fix use-after-free bug in r592_remove due to race condition

----------------------------------------------------------------
A, Rashmi (2):
      mmc: sdhci-of-arasan: Remove Intel Thunder Bay SOC support
      dt-bindings: mmc: Remove bindings for Intel Thunder Bay SoC"

Alexandre Mergnat (1):
      dt-bindings: mmc: mediatek,mtk-sd: add mt8365

Aswath Govindraju (1):
      mmc: sdhci_am654: Add support for PM suspend/resume

Bean Huo (1):
      mmc: core: Remove unused macro mmc_req_rel_wr

Bo Liu (1):
      mmc: vub300: remove unreachable code

Brad Larson (5):
      dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
      mmc: sdhci-cadence: Enable device specific override of writel()
      mmc: sdhci-cadence: Support device specific init during probe
      mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
      mmc: sdhci-cadence: Support mmc hardware reset

Fred (1):
      mmc: sdhci-pci-o2micro: Fix SDR50 mode timing issue

Georgii Kruglov (1):
      mmc: sdhci-of-esdhc: fix quirk to ignore command inhibit for data

Heiner Kallweit (4):
      mmc: core: Allow invalid regulator in mmc_regulator_set_ocr()
      mmc: meson-gx: simplify usage of mmc_regulator_set_ocr
      mmc: core: add helpers mmc_regulator_enable/disable_vqmmc
      mmc: meson-gx: use new helpers mmc_regulator_enable/disable_vqmmc

Konrad Dybcio (1):
      dt-bindings: mmc: sdhci-msm: Document QCM2290 SDHCI

Krzysztof Kozlowski (1):
      mmc: sdhci: drop useless sdhci_get_compatibility() !OF stub

Marc Gonzalez (1):
      mmc: core: Log about empty non-removable slots

Peng Fan (1):
      dt-bindings: mmc: fsl-imx-esdhc: ref sdhci-common.yaml

Rob Herring (3):
      mmc: arasan: Use of_property_present() for testing DT property presence
      mmc: Use of_property_read_bool() for boolean properties
      dt-bindings: mmc: fujitsu: Add Socionext Synquacer

Sai Krishna Potthuri (2):
      dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net compatible
      mmc: sdhci-of-arasan: Skip setting clock delay for 400KHz

Sricharan Ramabadhran (1):
      dt-bindings: mmc: sdhci-msm: Document the IPQ5018 compatible

Swati Agarwal (2):
      mmc: sdhci-of-arasan: Add support to request the "gate" clock
      mmc: sdhci-of-arasan: Add support for eMMC5.1 on Xilinx Versal Net platform

Tom Rix (1):
      mmc: sdricoh_cs: remove unused sdricoh_readw function

Ulf Hansson (2):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next

Vasily Khoruzhick (1):
      mmc: sdhci-of-dwcmshc: properly determine max clock on Rockchip

Wolfram Sang (1):
      mmc: renesas_sdhi: remove R-Car H3 ES1.* handling

Yang Li (6):
      mmc: dw_mmc-pltfm: Use devm_platform_get_and_ioremap_resource()
      mmc: jz4740: Use devm_platform_get_and_ioremap_resource()
      mmc: omap: Use devm_platform_get_and_ioremap_resource()
      mmc: owl-mmc: Use devm_platform_get_and_ioremap_resource()
      mmc: sdhci-of-aspeed: Use devm_platform_get_and_ioremap_resource()
      mmc: usdhi6rol0: Use devm_platform_get_and_ioremap_resource()

Yu Zhe (1):
      mmc: core: remove unnecessary (void*) conversions

Zheng Wang (1):
      memstick: r592: Fix UAF bug in r592_remove due to race condition

 .../devicetree/bindings/mmc/arasan,sdhci.yaml      |  30 +--
 .../devicetree/bindings/mmc/cdns,sdhci.yaml        |  27 +-
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |   2 +-
 .../bindings/mmc/fujitsu,sdhci-fujitsu.yaml        |  15 +-
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |   1 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   2 +
 drivers/memstick/host/r592.c                       |   2 +-
 drivers/mmc/core/block.c                           |   2 -
 drivers/mmc/core/core.c                            |   5 +
 drivers/mmc/core/debugfs.c                         |   2 +-
 drivers/mmc/core/mmc_test.c                        |   6 +-
 drivers/mmc/core/regulator.c                       |  44 ++++
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/dw_mmc-pltfm.c                    |   3 +-
 drivers/mmc/host/jz4740_mmc.c                      |   3 +-
 drivers/mmc/host/meson-gx-mmc.c                    |  24 +-
 drivers/mmc/host/mmci.c                            |  22 +-
 drivers/mmc/host/omap.c                            |   3 +-
 drivers/mmc/host/omap_hsmmc.c                      |   8 +-
 drivers/mmc/host/owl-mmc.c                         |   3 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  10 +-
 drivers/mmc/host/sdhci-cadence.c                   | 175 +++++++++++--
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   4 +-
 drivers/mmc/host/sdhci-of-arasan.c                 | 275 ++++++++++++++++++---
 drivers/mmc/host/sdhci-of-aspeed.c                 |   3 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |   9 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  24 +-
 drivers/mmc/host/sdhci-pci-o2micro.c               |  30 +--
 drivers/mmc/host/sdhci-pltfm.c                     |   4 -
 drivers/mmc/host/sdhci-pxav2.c                     |   2 +-
 drivers/mmc/host/sdhci-s3c.c                       |   4 +-
 drivers/mmc/host/sdhci_am654.c                     | 147 +++++++++--
 drivers/mmc/host/sdricoh_cs.c                      |   8 -
 drivers/mmc/host/tmio_mmc_core.c                   |   2 +-
 drivers/mmc/host/usdhi6rol0.c                      |   3 +-
 drivers/mmc/host/vub300.c                          |   2 -
 drivers/mmc/host/wmt-sdmmc.c                       |   6 +-
 include/linux/mmc/host.h                           |   3 +
 38 files changed, 711 insertions(+), 205 deletions(-)
