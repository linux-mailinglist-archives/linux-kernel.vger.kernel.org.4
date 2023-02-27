Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51266A4523
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjB0OuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0OuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:50:09 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77437212AB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:50:07 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id n2so8821624lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wrq5PNV0c3Lx5y6Jo1eXpJj+ltajG1l6dGl0L5eBKPA=;
        b=FHT+K6Zm1hrcvfkEddnJvNzEdQRdl8RVk1q46ejxUT5JEpFvdLClUwBqKqOcjVUiG5
         Sow/JpuoDlDtC7ynT8KT8a3xMHEj3T4SlqUDW1Xv7oA/HQOVx+sUJY4ICg0NxXa2fDo4
         q/N/4OHeAAN6wYoUUo5mptYBecM7XxF6Ttl7rC4zdC9gj70Dl8L/3TVFp5F0vC0D50ny
         q/eUQxC3AAoAFDWkLsUyde6MPwOG/RIKUjYmtSsss68mpNB6MHSAY2XMvJzosrzooDNi
         nEYwZ3JyWhOLnPkEb4qvmAyDF0Wgchgqlwg3bo6EI1r3iGrZCRQdgDqRkpWL1tQ9tc9V
         jJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wrq5PNV0c3Lx5y6Jo1eXpJj+ltajG1l6dGl0L5eBKPA=;
        b=UlhHa5NXPUF/yWUbsOFby7ChbDCyp9SWmVP7w15sKUzookokEEyIN4nl17nlQWPqA8
         UliDdTbrHiF+Ie/ajukrwocvAK5wUDLM8jEwSqingeyXa4pzOGck7logDoE5m0q/FhI6
         qN+vbBktvuyP89/LBBSyUOorPHfkAMdYYGykJk0HkK6WFHjdfJbAyk58athromTmzbQb
         M1ZbjG6mNKh+TxsgTeCY6HFjnd18rIGfbAzZDEBE+rRt4yTMiBsdd+CKb+PjtDuOtEtL
         egcbr+1Q/d3HQ1rvIpuR0FGDjDsrOeC+1kC5e724VJIMgNkW+jMK1zB0tbxP2UGzqI7F
         h+mw==
X-Gm-Message-State: AO0yUKVM05qVb7+iVB9HLRM8XnpuiWuF8vVLtVX42NmetOVo7ufv+S06
        Hi3gn5IToEdO3TDPZov6UOE35g==
X-Google-Smtp-Source: AK7set/NWTF1QsRC/lvcxD2n3Yo1qO9mvp56HRbeYTraGJdt6RscaEFeq+5yubnrjUVeWPupKAdL6g==
X-Received: by 2002:a19:550e:0:b0:4db:456a:9a1 with SMTP id n14-20020a19550e000000b004db456a09a1mr8013812lfe.66.1677509405633;
        Mon, 27 Feb 2023 06:50:05 -0800 (PST)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z22-20020ac25df6000000b0049c29389b98sm924823lfq.151.2023.02.27.06.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 06:50:04 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v6.3
Date:   Mon, 27 Feb 2023 15:50:03 +0100
Message-Id: <20230227145003.69787-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the PR with the MMC and MEMSTICK updates for v6.3-rc1. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3f18c5046e633cc4bbad396b74c05d46d353033d:

  mmc: jz4740: Work around bug on JZ4760(B) (2023-02-14 00:14:05 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.3

for you to fetch changes up to 571f235163ac83407e212b78719175236962aede:

  mmc: meson-gx: Use devm_platform_get_and_ioremap_resource() (2023-02-17 11:55:16 +0100)

----------------------------------------------------------------
MMC core:
 - Extend slot-gpio to be used for host specific card detect interrupts
 - Align to common busy polling behaviour for mmc ioctls
 - Suggest the BFQ I/O scheduler to be built along with MMC/SD support
 - Add devm_mmc_alloc_host() to enable further cleanups in host drivers

MMC host:
 - atmel-mci: Fix race condition when stopping/starting a command
 - dw_mmc-starfive: Add new driver to support the StarFive JH7110 variant
 - dw_mmc-rockchip: Add support for the RK3588 variant
 - jz4740: Add support for the vqmmc power supply
 - meson-gx: Convert the DT bindings to the dt-schema
 - meson-gx: Enable the platform interrupt to be used for card detect
 - moxart: Set the supported maximum request/block/segment sizes
 - renesas,sdhi: Add support for the RZ/V2M variants
 - sdhci: Rework code to drop SDHCI_QUIRK_MISSING_CAPS
 - sdhci-esdhc-imx: Improve tuning logic support
 - sdhci-msm: Add support for the IPQ5332 and the IPQ9574 variants
 - sdhci-of-dwcmshc: Add the missing device table IDs for acpi
 - sdhci-of-dwcmshc: Improve clock support for the Rockchip variant
 - sdhci-of-dwcmshc: Enable support of V4 host for the BlueField-3 variant
 - sdhci-pxav2: Add support for the PXA168 V1 variant
 - sdhci-pxav2: Add support for SDIO IRQs for the PXA168 V1 variant
 - uniphier-sd: Add support for SD UHS-I speed modes

----------------------------------------------------------------
Adrian Hunter (6):
      mmc: sdhci-pci: Replace SDHCI_QUIRK_MISSING_CAPS for Ricoh controller
      mmc: sdhci-brcmstb: Replace SDHCI_QUIRK_MISSING_CAPS
      mmc: sdhci-sprd: Replace SDHCI_QUIRK_MISSING_CAPS
      mmc: sdhci-pxav3: Replace SDHCI_QUIRK_MISSING_CAPS
      mmc: sdhci-iproc: Replace SDHCI_QUIRK_MISSING_CAPS
      mmc: sdhci: Remove SDHCI_QUIRK_MISSING_CAPS

Andreas Kemnade (1):
      dt-bindings: mmc: fsl-imx-esdhc: Add some compatible fallbacks

Doug Brown (8):
      mmc: sdhci-pxav2: add initial support for PXA168 V1 controller
      mmc: sdhci-pxav2: enable CONFIG_MMC_SDHCI_IO_ACCESSORS
      mmc: sdhci-pxav2: add register workaround for PXA168 silicon bug
      mmc: sdhci-pxav2: change clock name to match DT bindings
      mmc: sdhci-pxav2: add optional core clock
      mmc: sdhci-pxav2: add SDIO card IRQ workaround for PXA168 V1 controller
      mmc: sdhci-pxav2: add optional pinctrl for SDIO IRQ workaround
      dt-bindings: mmc: sdhci-pxa: add pxav1

Fabrizio Castro (2):
      dt-bindings: mmc: renesas,sdhi: Document RZ/V2M support
      mmc: renesas_sdhi: Add RZ/V2M compatible string

Geert Uytterhoeven (2):
      mmc: sdio: Spelling s/compement/complement/
      dt-bindings: mmc: renesas,sdhi: Fix RZ/V2M clock description

Haibo Chen (2):
      mmc: sdhci-esdhc-imx: simplify the auto tuning logic
      mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD line auto tuning for SDIO device

Heiner Kallweit (9):
      mmc: core: add devm_mmc_alloc_host
      mmc: meson-gx: use devm_mmc_alloc_host
      mmc: meson-gx: remove meson_mmc_get_cd
      mmc: core: support setting card detect interrupt from drivers
      dt-bindings: mmc: meson-gx: support specifying cd interrupt
      mmc: meson-gx: support platform interrupt as card detect interrupt
      dt-bindings: mmc: meson-gx: fix interrupt binding
      mmc: meson-gx: use devm_clk_get_enabled() for core clock
      mmc: meson-gx: constify member data of struct meson_host

Jonathan Neuschäfer (1):
      dt-bindings: mmc: fsl-imx-esdhc: Improve grammar and fix a typo

Kathiravan T (1):
      dt-bindings: mmc: sdhci-msm: add IPQ5332 compatible

Konrad Dybcio (1):
      dt-bindings: mmc: sdhci-msm: Allow 1 icc path

Krzysztof Kozlowski (2):
      dt-bindings: mmc: drop unneeded quotes
      dt-bindings: mmc: correct pwrseq node names

Kunihiko Hayashi (4):
      dt-bindings: mmc: uniphier-sd: Add socionext,syscon-uhs-mode property
      mmc: uniphier-sd: Add control of UHS mode using SD interface logic
      mmc: uniphier-sd: Add control to switch UHS speed
      dt-bindings: mmc: Add resets property to cadence SDHCI binding

Liming Sun (2):
      mmc: sdhci-of-dwcmshc: enable host V4 support for BlueField-3 SoC
      mmc: sdhci-of-dwcmshc: add the missing device table IDs for acpi

Linus Walleij (2):
      mmc: core: Imply IOSCHED_BFQ
      memstick: core: Imply IOSCHED_BFQ

Lucas Tanure (1):
      dt-bindings: mmc: rockchip-dw-mshc: Add RK3588 compatible string

Lukas Wunner (1):
      mmc: pwrseq_sd8787: Allow being built-in irrespective of dependencies

Neil Armstrong (1):
      dt-bindings: mmc: convert amlogic,meson-gx.txt to dt-schema

Paul Cercueil (1):
      mmc: jz4740: Add support for vqmmc power supply

Peng Fan (1):
      dt-bindings: mmc: fsl-imx-esdhc: update binding for i.MX50 and i.MX7D

Sergei Antonov (1):
      mmc: moxart: set maximum request/block/segment sizes

Shawn Lin (1):
      mmc: sdhci-of-dwcmshc: Update DLL and pre-change delay for rockchip platform

Tobias Schramm (1):
      mmc: atmel-mci: fix race between stop command and start of next command

Tom Fitzhenry (1):
      mmc: pwrseq_simple: include deferred probe reasons

Ulf Hansson (2):
      mmc: Merge branch fixes into next
      mmc: core: Align to common busy polling behaviour for mmc ioctls

William Qiu (2):
      dt-bindings: mmc: Add StarFive MMC module
      mmc: starfive: Add sdio/emmc driver support

Yang Li (1):
      mmc: meson-gx: Use devm_platform_get_and_ioremap_resource()

Yang Yingliang (1):
      mmc: core: fix return value check in devm_mmc_alloc_host()

Ye Xingchen (1):
      mmc: sdhci-brcmstb: Use devm_platform_get_and_ioremap_resource()

devi priya (1):
      dt-bindings: mmc: sdhci-msm: Document the IPQ9574 compatible

 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml      |   2 +-
 .../bindings/mmc/amlogic,meson-gx-mmc.yaml         |  76 +++++++++
 .../devicetree/bindings/mmc/amlogic,meson-gx.txt   |  39 -----
 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml        |   2 +-
 .../devicetree/bindings/mmc/arasan,sdhci.yaml      |   6 +-
 .../devicetree/bindings/mmc/cdns,sdhci.yaml        |  25 +--
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |  21 ++-
 .../devicetree/bindings/mmc/fsl-imx-mmc.yaml       |   2 +-
 .../bindings/mmc/microchip,dw-sparx5-sdhci.yaml    |   4 +-
 .../devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml   |   2 +-
 .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml |   2 +-
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.yaml |   2 +-
 .../devicetree/bindings/mmc/mmc-spi-slot.yaml      |   2 +-
 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml |   2 +-
 .../bindings/mmc/nvidia,tegra20-sdhci.yaml         |  36 ++--
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml |   2 +-
 .../devicetree/bindings/mmc/renesas,mmcif.yaml     |   2 +-
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   8 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |   3 +-
 .../bindings/mmc/samsung,exynos-dw-mshc.yaml       |   2 +-
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   4 +
 .../devicetree/bindings/mmc/sdhci-pxa.yaml         |  19 ++-
 .../bindings/mmc/socionext,uniphier-sd.yaml        |  10 ++
 .../bindings/mmc/starfive,jh7110-mmc.yaml          |  77 +++++++++
 .../devicetree/bindings/mmc/sunplus,mmc.yaml       |   2 +-
 .../bindings/mmc/synopsys-dw-mshc-common.yaml      |   2 +-
 MAINTAINERS                                        |   6 +
 drivers/memstick/core/Kconfig                      |   2 +
 drivers/mmc/core/Kconfig                           |   3 +-
 drivers/mmc/core/block.c                           |  25 ++-
 drivers/mmc/core/host.c                            |  26 +++
 drivers/mmc/core/mmc_ops.c                         |   1 +
 drivers/mmc/core/pwrseq_simple.c                   |   4 +-
 drivers/mmc/core/sdio_io.c                         |   2 +-
 drivers/mmc/core/slot-gpio.c                       |  17 +-
 drivers/mmc/host/Kconfig                           |  11 ++
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/atmel-mci.c                       |   3 -
 drivers/mmc/host/dw_mmc-starfive.c                 | 186 +++++++++++++++++++++
 drivers/mmc/host/jz4740_mmc.c                      |  38 ++++-
 drivers/mmc/host/meson-gx-mmc.c                    |  92 +++-------
 drivers/mmc/host/moxart-mmc.c                      |   9 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  11 ++
 drivers/mmc/host/sdhci-brcmstb.c                   |   8 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  66 +++++++-
 drivers/mmc/host/sdhci-iproc.c                     |  14 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |  19 ++-
 drivers/mmc/host/sdhci-pci-core.c                  |   8 +-
 drivers/mmc/host/sdhci-pxav2.c                     | 154 +++++++++++++++--
 drivers/mmc/host/sdhci-pxav3.c                     |   4 +-
 drivers/mmc/host/sdhci-sprd.c                      |   6 +-
 drivers/mmc/host/sdhci.c                           |   3 -
 drivers/mmc/host/sdhci.h                           |   2 -
 drivers/mmc/host/uniphier-sd.c                     |  83 ++++++++-
 include/linux/mmc/host.h                           |   1 +
 include/linux/mmc/slot-gpio.h                      |   1 +
 56 files changed, 923 insertions(+), 237 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
 create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
