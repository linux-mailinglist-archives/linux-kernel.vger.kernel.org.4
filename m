Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD8664B352
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiLMKiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbiLMKh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:37:59 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0E8263B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:37:53 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g7so4201445lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OmJ1unnLQL11jWk2NBVDCKvznUBrMSHaTbcQQLc+9QY=;
        b=byftv/uHfMvu4IIdxSl8xoPQY7QzcpdPtCGcFh5V0dWdkn3nx2f07+4CDdgmjbhPd+
         80isrC34eTwxJj7oHyvKWwoU6y3SLC+bmSjkPzs4zXxVDnfgHFU3+0lD6DnQH9OkD0yW
         1sEwrhPtva1Y5x+XwL8FJEHcCl+r4cWt/Ddf2sXTbIW6s36WGmoSuzR6TT++nd+gw5LL
         WJeKaY9zr6bCF+Moud90t4KfBEmWeq8ItQEgJsLApMs5MY6TB+b0sD0Q4rZtCfHPRNUN
         1Qf2BshXFccZ59DDUCr4uw/iXB3eYA24kdQlJfJXy6C97JQ6dD9jpqpw4zxVQ5rt4Tww
         viJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmJ1unnLQL11jWk2NBVDCKvznUBrMSHaTbcQQLc+9QY=;
        b=L072J+q+IOBTR58j0pEGHFv9EdgkI81ljPGBQj9GzHY3NhRYvcjBQ7EA7GNUn7bEb2
         Rn4S4+rMt/TvFotG0SvVWGYuMgdq3OmnatvEzum+MB4AyZAzOn4aknTlrzlpOZstbTND
         2IdcdwnXg1xIYg6frG0qR6EI5HnEE43rU75eVGUmd+DpfI6KoCb54rGmnydbeu4FPAgY
         6yBylef9VaHDoOQNBUd1dVWy1JDPyz4eKVoRhZ9zL2NnVALrfJHpvGhDRpIDwkO86bPD
         b03a/nLjDyZqzHyudheA8W6/Pf7BohHBQIyzCzGcpjhjCKOxzj8JLtV9L2+nKVnnovY7
         1gCw==
X-Gm-Message-State: ANoB5pkoxz27N3/wgLuIm14mHAiMEhJjoliJ7eTYKp3aGR6KRE27k+zG
        rMjIVz2zapbFZgdJC5dA1hu6iQ==
X-Google-Smtp-Source: AA0mqf7MdstQD/trMcQoVXmLkyG8hscVT8vWOnc3Dvrl3/qocNTMDZ36UMPjwBGp94SxIdsV6vLY2w==
X-Received: by 2002:a05:6512:b10:b0:4a6:c596:6ff7 with SMTP id w16-20020a0565120b1000b004a6c5966ff7mr6336195lfu.2.1670927871822;
        Tue, 13 Dec 2022 02:37:51 -0800 (PST)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id f19-20020a2eb5b3000000b00279d206a43bsm214208ljn.34.2022.12.13.02.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 02:37:51 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v6.2
Date:   Tue, 13 Dec 2022 11:37:50 +0100
Message-Id: <20221213103750.107606-1-ulf.hansson@linaro.org>
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

Here's the pull-request with the updates for MMC and MEMSTICK for v6.2. Details
about the highlights are as usual found in the signed tag.

Note 1)
The pull-request also includes a few patches for iommu, which are conflicting
with some changes from the iommu tree. I think the conflict should be rather
trivial to resolve, also managed by Stephen Rothwell [1] in linux-next. If you
encounter any issues, just reach out to me.

Note 2)
The pull-request also includes a clock patch for socfpga.

Please pull this in!

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/all/20221208104503.0ee41406@canb.auug.org.au/


The following changes since commit 76dcd734eca23168cb008912c0f69ff408905235:

  Linux 6.1-rc8 (2022-12-04 14:48:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.2

for you to fetch changes up to ff874dbc4f868af128b412a9bd92637103cf11d7:

  mmc: sdhci-sprd: Disable CLK_AUTO when the clock is less than 400K (2022-12-09 10:32:58 +0100)

----------------------------------------------------------------
MMC core:
 - A few minor improvements and cleanups

MMC host:
 - Remove some redundant calls to local_irq_{save,restore}()
 - Replace kmap_atomic() with kmap_local_page()
 - Take return values from mmc_add_host() into account
 - dw_mmc-pltfm: Add support to configure clk-phase for socfpga
 - hsq: Minimize latency by using a fifo to dispatch requests
 - litex_mmc: Fixup corner case for polling mode
 - mtk-sd: Add inline crypto engine clock control
 - mtk-sd: Add support for the mediatek MT7986 variant
 - renesas_sdhi: Improve reset from HS400 mode
 - renesas_sdhi: Take DMA end interrupts into account
 - sdhci: Avoid unnecessary update of clock
 - sdhci: Fix an SD tuning issue
 - sdhci-brcmst: Add Kamal Dasu as maintainer for the Broadcom driver
 - sdhci-esdhc-imx: Improve tuning logic
 - sdhci-esdhc-imx: Improve support for the imxrt1050 variant
 - sdhci_f_sdh30: Add support for non-removable media
 - sdhci_f_sdh30: Add support for the Socionext F_SDH30_E51 variant
 - sdhci_f_sdh30: Add reset control support
 - sdhci-msm: Add support for the Qcom SM8550/SM8350/SM6375 variants
 - sdhci-msm: Add support for the Qcom MSM8976 variant
 - sdhci-of-arasan: Add support for dynamic configuration
 - sdhci-of-esdhc: Limit the clock frequency to confirm to spec
 - sdhci-pci: Enable asynchronous probe
 - sdhci-sprd: Improve card detection
 - sdhci-tegra: Improve reset support
 - sdhci-tegra: Add support to program MC stream ID
 - sunplus-mmc: Add new mmc driver for the Sunplus SP7021 controller
 - vub300: Fix warning splat for SDIO irq

MEMSTICK core:
 - memstick: A few minor improvements and cleanups

CLK/IOMMU:
 - clk: socfpga: Drop redundant support for clk-phase for the SD/MMC clk
 - iommu: Add tegra specific helper to get stream_id

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: mmc: sdhci-msm: Document the SM8550 compatible

Adrian Hunter (16):
      mmc: sdhci: Remove local_irq_{save,restore}() around k[un]map_atomic()
      mmc: sdhci: Remove local_irq_{save,restore}() around sg_miter_{next,stop}()
      mmc: sdhci: Replace kmap_atomic() with kmap_local_page()
      mmc: bcm2835: Remove local_irq_{save,restore}() around k[un]map_atomic()
      mmc: bcm2835: Remove local_irq_{save,restore}() around sg_miter_{next,stop}()
      mmc: bcm2835: Replace kmap_atomic() with kmap_local_page()
      mmc: mmc_test: Remove local_irq_{save,restore}() around sg_copy_{from,to}_buffer()
      mmc: tifm_sd: Remove local_irq_{save,restore}() around tifm_sd_transfer_data()
      mmc: tifm_sd: Remove local_irq_{save,restore}() around tifm_sd_bounce_block()
      mmc: tifm_sd: Replace kmap_atomic() with kmap_local_page()
      mmc: tmio_mmc_core: Remove local_irq_{save,restore}() around k[un]map_atomic()
      mmc: tmio_mmc_core: Replace kmap_atomic() with kmap_local_page()
      mmc: au1xmmc: Replace kmap_atomic() with kmap_local_page()
      mmc: wbsd: Replace kmap_atomic() with kmap_local_page()
      mmc: Remove duplicate words in comments
      mmc: sdhci: Avoid unnecessary ->set_clock()

Andy Tang (1):
      mmc: sdhci-of-esdhc: limit the SDHC clock frequency

AngeloGioacchino Del Regno (1):
      dt-bindings: mmc: sdhci-msm: Document compatible for MSM8976

Brian Norris (4):
      mmc: sdhci-brcmstb: Allow building with COMPILE_TEST
      mmc: sdhci-*: Convert drivers to new sdhci_and_cqhci_reset()
      mmc: sdhci-pci: Set PROBE_PREFER_ASYNCHRONOUS
      mmc: sdhci-brcmstb: Resolve "unused" warnings with CONFIG_OF=n

ChanWoo Lee (1):
      mmc: Avoid open coding by using mmc_op_tuning()

Charl Liu (1):
      mmc: sdhci: Fix the SD tuning issue that the SDHCI_TRANSFER_MODE is cleared incorrectly

Christian Löhle (1):
      mmc: core: Remove non-data R1B ioctl workaround

Christoph Niedermaier (1):
      dt-bindings: mmc: Remove comment on wakeup-source property

Deren Wu (1):
      mmc: vub300: fix warning - do not call blocking ops when !TASK_RUNNING

Dinh Nguyen (3):
      dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
      mmc: dw_mmc-pltfm: socfpga: add method to configure clk-phase
      clk: socfpga: remove the setting of clk-phase for sdmmc_clk

Gabriel Somlo (1):
      mmc: litex_mmc: ensure `host->irq == 0` if polling

Geert Uytterhoeven (1):
      dt-bindings: mmc: renesas,sdhi: Document R-Car V4H support

Giulio Benetti (1):
      mmc: sdhci-esdhc-imx: improve imxrt1050 data

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: reset the tuning logic before execute tuning

Jagan Teki (1):
      dt-bindings: mmc: rockchip-dw-mshc: Add power-domains property

Jiapeng Chong (1):
      mmc: sdhci-of-esdhc: Modify mismatched function name

Jiasheng Jiang (1):
      memstick/ms_block: Add check for alloc_ordered_workqueue

Kamal Dasu (1):
      MAINTAINERS: Update maintainer for SDHCI Broadcom BRCMSTB driver

Konrad Dybcio (2):
      dt-bindings: mmc: sdhci-msm: Document the SM6375 compatible
      dt-bindings: mmc: sdhci-msm: Document SM8350 SDHCI

Krzysztof Kozlowski (5):
      dt-bindings: mmc: sdhci: document sdhci-caps and sdhci-caps-mask
      dt-bindings: mmc: sdhci-am654: cleanup style
      dt-bindings: mmc: sdhci-msm: cleanup style
      dt-bindings: mmc: sdhci-msm: drop properties mentioned in common MMC
      dt-bindings: mmc: sdhci-msm: allow dma-coherent

Kunihiko Hayashi (6):
      dt-bindings: mmc: Convert sdhci-fujitsu to JSON schema
      mmc: f-sdh30: Add reset control support
      dt-bindings: sdhci-fujitsu: Add compatible string for F_SDH30_E51
      mmc: f-sdh30: Add compatible string for Socionext F_SDH30_E51
      mmc: f-sdh30: Add support for non-removable media
      mmc: f-sdh30: Add quirks for broken timeout clock capability

Marek Vasut (1):
      dt-bindings: mmc: arm,pl18x: Document interrupt-names is ignored

Matt Ranostay (1):
      dt-bindings: mmc: sdhci-am654: add ti,itap-del-sel-ddr50 to schema

Matthias Schiffer (1):
      mmc: sdhci_am654: Use dev_err_probe() for mmc_of_parse() return code

Mengqi Zhang (2):
      dt-bindings: mmc: mtk-sd: add Inline Crypto Engine clock
      mmc: mtk-sd: add Inline Crypto Engine clock control

Michael Wu (1):
      mmc: mmc-hsq: Use fifo to dispatch mmc_request

Nícolas F. R. A. Prado (1):
      dt-bindings: mmc: mtk-sd: Set clocks based on compatible

Peng Fan (1):
      dt-bindings: mmc: fsl-imx-esdhc: update i.MX8DXL compatible

Prathamesh Shete (3):
      mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
      mmc: sdhci-tegra: Add support to program MC stream ID
      mmc: sdhci-tegra: Issue CMD and DAT resets together

Sai Krishna Potthuri (1):
      mmc: sdhci-of-arasan: Add support for dynamic configuration

Sam Shih (2):
      dt-bindings: mmc: Add support for Mediatek MT7986
      mmc: mediatek: add support for MT7986 SoC

Sebastian Reichel (1):
      dt-bindings: mmc: sdhci-of-dwcmhsc: Add reset support

Thierry Reding (3):
      iommu: Add note about struct iommu_fwspec usage
      iommu/tegra: Add tegra_dev_iommu_get_stream_id() helper
      mmc: sdhci-tegra: Sort includes alphabetically

Tony Huang (2):
      dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
      mmc: Add mmc driver for Sunplus SP7021

Wenchao Chen (1):
      mmc: sdhci-sprd: Disable CLK_AUTO when the clock is less than 400K

Wolfram Sang (12):
      mmc: renesas_sdhi: remove accessor function for internal_dmac
      mmc: renesas_sdhi: improve naming of DMA struct
      mmc: tmio: add callback for dma irq
      mmc: renesas_sdhi: add quirk for broken register layout
      mmc: renesas_sdhi: take DMA end interrupts into account
      mmc: tmio: remove tmio_mmc_k(un)map_atomic helpers
      mmc: tmio: remove 'alignment_shift' from platform data
      mmc: renesas_sdhi: alway populate SCC pointer
      mmc: renesas_sdhi: better reset from HS400 mode
      mmc: renesas_sdhi: add helper to access quirks
      mmc: renesas_sdhi: use new convenience macro from MMC core
      mmc: renesas_sdhi: use plain numbers for end_flags

Yang Li (1):
      mmc: Remove unneeded semicolon

Yang Yingliang (15):
      mmc: alcor: fix return value check of mmc_add_host()
      mmc: moxart: fix return value check of mmc_add_host()
      mmc: mxcmmc: fix return value check of mmc_add_host()
      mmc: pxamci: fix return value check of mmc_add_host()
      mmc: rtsx_pci: fix return value check of mmc_add_host()
      mmc: rtsx_usb_sdmmc: fix return value check of mmc_add_host()
      mmc: toshsd: fix return value check of mmc_add_host()
      mmc: vub300: fix return value check of mmc_add_host()
      mmc: wmt-sdmmc: fix return value check of mmc_add_host()
      mmc: atmel-mci: fix return value check of mmc_add_host()
      mmc: omap_hsmmc: fix return value check of mmc_add_host()
      mmc: meson-gx: fix return value check of mmc_add_host()
      mmc: via-sdmmc: fix return value check of mmc_add_host()
      mmc: wbsd: fix return value check of mmc_add_host()
      mmc: mmci: fix return value check of mmc_add_host()

Ye Bin (1):
      mmc: core: refactor debugfs code

Yu Zhe (1):
      mmc: mtk-sd: fix two spelling mistakes in comment

Zhen Lei (1):
      mmc: core: Normalize the error handling branch in sd_read_ext_regs()

wangjianli (1):
      mmc: host: Fix repeated words in comments

ye xingchen (2):
      mmc: pwrseq: Use device_match_of_node()
      memstick/mspro_block: Convert to use sysfs_emit()/sysfs_emit_at() APIs

zhang songyi (1):
      mmc: sdhci: Remove unneeded semicolon

 .../devicetree/bindings/mmc/arm,pl18x.yaml         |    4 +-
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |    3 +-
 .../bindings/mmc/fujitsu,sdhci-fujitsu.yaml        |   57 ++
 .../devicetree/bindings/mmc/mmc-controller.yaml    |    1 -
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |  171 +++-
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |    1 +
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |    3 +
 .../devicetree/bindings/mmc/sdhci-am654.yaml       |   69 +-
 .../devicetree/bindings/mmc/sdhci-common.yaml      |   32 +
 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |   32 -
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   23 +-
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |   11 +
 .../devicetree/bindings/mmc/sunplus,mmc.yaml       |   61 ++
 .../devicetree/bindings/mmc/synopsys-dw-mshc.yaml  |   32 +-
 .../devicetree/bindings/power/wakeup-source.txt    |   13 +-
 MAINTAINERS                                        |    9 +
 drivers/clk/socfpga/clk-gate-a10.c                 |   68 --
 drivers/clk/socfpga/clk-gate.c                     |   61 --
 drivers/clk/socfpga/clk.h                          |    1 -
 drivers/memstick/core/ms_block.c                   |    9 +-
 drivers/memstick/core/mspro_block.c                |  177 ++--
 drivers/mmc/core/block.c                           |   13 -
 drivers/mmc/core/bus.c                             |    4 -
 drivers/mmc/core/core.c                            |    7 +-
 drivers/mmc/core/core.h                            |   15 +
 drivers/mmc/core/host.c                            |    6 +-
 drivers/mmc/core/mmc_test.c                        |    5 -
 drivers/mmc/core/pwrseq.c                          |    2 +-
 drivers/mmc/core/sd.c                              |   11 +-
 drivers/mmc/host/Kconfig                           |   13 +-
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/alcor.c                           |    5 +-
 drivers/mmc/host/atmel-mci.c                       |    9 +-
 drivers/mmc/host/au1xmmc.c                         |    8 +-
 drivers/mmc/host/bcm2835.c                         |   12 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |   41 +-
 drivers/mmc/host/dw_mmc.c                          |    5 +-
 drivers/mmc/host/litex_mmc.c                       |    1 +
 drivers/mmc/host/meson-gx-mmc.c                    |    4 +-
 drivers/mmc/host/mmc_hsq.c                         |   40 +-
 drivers/mmc/host/mmc_hsq.h                         |    5 +
 drivers/mmc/host/mmci.c                            |    4 +-
 drivers/mmc/host/moxart-mmc.c                      |    4 +-
 drivers/mmc/host/mtk-sd.c                          |   38 +-
 drivers/mmc/host/mxcmmc.c                          |    4 +-
 drivers/mmc/host/omap_hsmmc.c                      |    4 +-
 drivers/mmc/host/pxamci.c                          |    7 +-
 drivers/mmc/host/renesas_sdhi.h                    |   16 +-
 drivers/mmc/host/renesas_sdhi_core.c               |   32 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   86 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   11 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |    9 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |   11 +-
 drivers/mmc/host/sdhci-acpi.c                      |    4 +-
 drivers/mmc/host/sdhci-bcm-kona.c                  |    2 +-
 drivers/mmc/host/sdhci-brcmstb.c                   |    2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   87 +-
 drivers/mmc/host/sdhci-msm.c                       |   13 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |   69 ++
 drivers/mmc/host/sdhci-of-esdhc.c                  |   11 +-
 drivers/mmc/host/sdhci-omap.c                      |    2 +-
 drivers/mmc/host/sdhci-pci-core.c                  |   14 +-
 drivers/mmc/host/sdhci-pci-gli.c                   |   11 +-
 drivers/mmc/host/sdhci-pci-o2micro.c               |    3 +-
 drivers/mmc/host/sdhci-sprd.c                      |   16 +-
 drivers/mmc/host/sdhci-tegra.c                     |   77 +-
 drivers/mmc/host/sdhci.c                           |   85 +-
 drivers/mmc/host/sdhci.h                           |    4 +-
 drivers/mmc/host/sdhci_am654.c                     |    2 +-
 drivers/mmc/host/sdhci_f_sdh30.c                   |   31 +-
 drivers/mmc/host/sdhci_f_sdh30.h                   |    3 +
 drivers/mmc/host/sunplus-mmc.c                     | 1000 ++++++++++++++++++++
 drivers/mmc/host/tifm_sd.c                         |   28 +-
 drivers/mmc/host/tmio_mmc.h                        |   15 +-
 drivers/mmc/host/tmio_mmc_core.c                   |   18 +-
 drivers/mmc/host/toshsd.c                          |    6 +-
 drivers/mmc/host/via-sdmmc.c                       |    4 +-
 drivers/mmc/host/vub300.c                          |   13 +-
 drivers/mmc/host/wbsd.c                            |   22 +-
 drivers/mmc/host/wmt-sdmmc.c                       |    6 +-
 include/linux/iommu.h                              |   25 +
 include/linux/mfd/tmio.h                           |    1 -
 82 files changed, 2117 insertions(+), 728 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-common.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
 create mode 100644 drivers/mmc/host/sunplus-mmc.c
