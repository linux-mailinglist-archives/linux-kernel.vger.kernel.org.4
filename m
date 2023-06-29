Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E40674214A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjF2HrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjF2Hqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:46:55 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845882707
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:46:50 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bd77424c886so393698276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688024809; x=1690616809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RJeiGNkXR106duLLLxSKlrFrdAsgc2Z9qLi3NZqjJpI=;
        b=RofVyWCkd2kvX/W5V15dPduNQFT66InT9jtWcnoX/axbKeY+sUS2Tj7B+aY1TygdRG
         oXYpzADWkMW32f8Q0DgVBvao+A9HvfLqb0h7aIYpdeHoN/boOYs0txZqUj/K6fsIMtWT
         0oBfhd4EIxg8L4vvOzNXoNlH/PwdTd03ZKQmY9h9+maZzVYPsSDzo1rzyOmrmkI+QKJT
         evQsYC8Ov7Zjjwjmyo8oJX31aM0FAhzkBVYnmqNBS1SBQDRfYmEGX77KoaOiq203LgGt
         BDjQ/KVFLFkttJs65wcMNWOfE3ANAa+bX51gST45AC421+j3VwF9e0A0tBAWFCb7lmUG
         D5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688024809; x=1690616809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJeiGNkXR106duLLLxSKlrFrdAsgc2Z9qLi3NZqjJpI=;
        b=QdryNsX5lUUfBX0UfK0cakVbvf7LAwRj1t2nTvJDa0nfZ4JFJ+0nY5ESD3mqQM64Xj
         TbGhKIMxYVnXByqIzVPpiaBscKjBAs+hILStSFt8SbjMdxn1BrluWb/5tfY9Vy6l+CoE
         e1cNphDOiIk+zrPtOnoxUmXfYHxgwZAy17nile3uiNtYFNMzWXj3k1XFH8b+0VXba7lE
         haHtXr7Va2I2f/hOng1EmlkL49qDlb7sifQlGURgZW4GncN8+oMkGpKvSqUEgESmLFLo
         txaX/HvQP8eRO0Hf3/w97s4rMqlw477bDhnMt/q8Lak/Wb/Gm25pbNgkmKYLhMGJ/kDX
         gn/Q==
X-Gm-Message-State: AC+VfDzHLRQTTSO9U/O1MfhgSQkMm8FOf/QPPm64ROD/6b/9AU1SEqUa
        84jXo/tAIhLAWj+vaIJ78azuUmpo26PFhe752p/GfA==
X-Google-Smtp-Source: ACHHUZ5PKVXpt4F+XZDGAh0MXXbLQOHiUdqanKSeGsCacuQ2RAW47IcAOULlQ4hGdZshg6LcGR+qXi5dB2oqCTTgYNA=
X-Received: by 2002:a25:4050:0:b0:bfe:9259:8f1a with SMTP id
 n77-20020a254050000000b00bfe92598f1amr25393814yba.50.1688024809647; Thu, 29
 Jun 2023 00:46:49 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Jun 2023 09:46:38 +0200
Message-ID: <CACRpkdYdnrDJ8=76DHT3yLyCKqCRyLEObhUaKFOHSMy9y5jVHw@mail.gmail.com>
Subject: [GIT PULL] Pin control changes for v6.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

here is the bulk of pin control changes for v6.5.

There is not much to say about it: it is smaller than usual
and it is all drivers.

Some lib/* functions are added, they come from Andy Shechenko
who maintains lib/* quite a lot.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b=
:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.5-1

for you to fetch changes up to 9f0648f13e34a01f2e1a7a0d5801988a7bca6988:

  Merge tag 'intel-pinctrl-v6.5-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into devel
(2023-06-21 09:37:43 +0200)

----------------------------------------------------------------
Pin control changes for the v6.5 kernel cycle:

No core changes this time.

New drivers:

- Tegra234 support.

- Qualcomm IPQ5018 support.

- Intel Meteor Lake-S support.

- Qualcomm SDX75 subdriver.

- Qualcomm SPMI-based PM8953 support.

Improvements:

- Fix up support for GPIO3 on the AXP209.

- Push-pull drive configuration support for the AT91 PIO4.

- Fix misc non-urgent bugs in the AMD driver.

- Misc non-urgent improved error handling.

- Misc janitorial and minor improvements.

----------------------------------------------------------------
Andy Shevchenko (18):
      pinctrl: baytrail: Unify style of error and debug messages
      pinctrl: baytrail: Use BIT() in BYT_PULL_ASSIGN_* definitions
      pinctrl: cherryview: Don't use IRQ core constanst for invalid IRQ
      pinctrl: cherryview: Return correct value if pin in push-pull mode
      pinctrl: merrifield: Fix open-drain pin mode configuration
      pinctrl: merrifield: Use BUFCFG_PINMODE_GPIO in ->pin_dbg_show()
      pinctrl: moorefield: Fix open-drain pin mode configuration
      pinctrl: moorefield: Use BUFCFG_PINMODE_GPIO in ->pin_dbg_show()
      pinctrl: intel: Add Intel Meteor Lake-S pin controller support
      pinctrl: Duplicate user memory in one go in pinmux_select()
      pinctrl: Relax user input size in pinmux_select()
      lib/string_helpers: Add missing header files to MAINTAINERS database
      lib/string_helpers: Split out string_choices.h
      lib/string_choices: Add str_high_low() helper
      pinctrl: baytrail: Use str_hi_lo() helper
      pinctrl: lantiq: Remove unused of_gpio.h inclusion
      pinctrl: spear: Remove unused of_gpio.h inclusion
      pinctrl: cherryview: Drop goto label

Arnd Bergmann (2):
      pinctrl: mlxbf3: remove broken Kconfig 'select'
      pinctrl: tegra: avoid duplicate field initializers

Bartosz Golaszewski (1):
      pinctrl: qcom: sa8775p: add the wakeirq map

Chester Lin (1):
      pinctrl: s32: separate const device data from struct s32_pinctrl_soc_=
info

Christophe JAILLET (1):
      pinctrl: bcm2835: Handle gpiochip_add_pin_range() errors

Claudiu Beznea (2):
      pinctrl: microchip-sgpio: check return value of devm_kasprintf()
      pinctrl: at91-pio4: check return value of devm_kasprintf()

Dan Carpenter (1):
      pinctrl: at91: fix a couple NULL vs IS_ERR() checks

Jiasheng Jiang (1):
      pinctrl: npcm7xx: Add missing check for ioremap

Jonathan McDowell (1):
      pinctrl: axp209: Add support for GPIO3 on the AXP209

Kornel Dul=C4=99ba (1):
      pinctrl: amd: Detect and mask spurious interrupts

Krzysztof Kozlowski (14):
      dt-bindings: pinctrl: qcom,ipq9574-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,sc8280xp-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,qcm2290-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm7150-tlmm: simplify with
unevaluatedProperties
      pinctrl: qcom: sc8180x: gracefully handle missing IO memory resource
      pinctrl: qcom: qdf2xxx: drop ACPI_PTR
      pinctrl: qcom: fix indentation in Kconfig
      pinctrl: qcom: correct language typo (Technologies)
      pinctrl: qcom: drop unneeded GPIOLIB dependency
      pinctrl: qcom: mark true OF dependency - common MSM pinctrl code
      pinctrl: qcom: allow true compile testing
      pinctrl: qcom: organize main SoC drivers in new Kconfig.msm
      pinctrl: qcom: organize audio drivers in menuconfig
      dt-bindings: pinctrl: qcom,sdx65-tlmm: add pcie_clkreq function

Linus Walleij (3):
      Merge tag 'renesas-pinctrl-for-v6.5-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      Merge tag 'qcom-pinctrl-6.5' of
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt into
devel
      Merge tag 'intel-pinctrl-v6.5-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into devel

Lizhe (1):
      pinctrl: microchip: Remove redundant clearing of IRQ_TYPE_SENSE_MASK

Lu Hongfei (1):
      pinctrl: nxp: Fix resource leaks in for_each_child_of_node() loops

Luca Weiss (2):
      dt-bindings: pinctrl: qcom,pmic-gpio: add PM8953
      pinctrl: qcom: spmi-gpio: Add PM8953 support

Marek Vasut (1):
      pinctrl: renesas: Fix spaces followed by tabs

Mario Limonciello (3):
      pinctrl: amd: Detect internal GPIO0 debounce handling
      pinctrl: amd: Fix mistake in handling clearing pins at startup
      pinctrl: amd: Revert "pinctrl: amd: disable and mask interrupts on pr=
obe"

Nishanth Menon (1):
      dt-bindings: pinctrl: Drop k3

Prathamesh Shete (3):
      dt-bindings: pinctrl: Document Tegra234 pin controllers
      pinctrl: tegra: Add Tegra234 pinmux driver
      gpio: tegra186: Check PMC driver status before any request

Raag Jadav (5):
      pinctrl: intel: refine ->set_mux() hook
      pinctrl: intel: refine ->irq_set_type() hook
      pinctrl: baytrail: reduce scope of spinlock in ->dbg_show() hook
      pinctrl: baytrail: add warning for BYT_VAL_REG retrieval failure
      pinctrl: baytrail: invert if condition

Rohit Agarwal (5):
      pinctrl: qcom: Remove the msm_function struct
      pinctrl: qcom: Refactor generic qcom pinctrl driver
      dt-bindings: pinctrl: qcom: Add SDX75 pinctrl devicetree compatible
      MAINTAINERS: Update the entry for pinctrl maintainers
      pinctrl: qcom: Add SDX75 pincontrol driver

Ryan Wanner (2):
      dt-bindings: pinctrl: at91-pio4: Add push-pull support
      pinctrl: at91-pio4: Enable Push-Pull configuration

Sricharan Ramabadhran (2):
      dt-bindings: pinctrl: qcom: Add support for ipq5018
      pinctrl: qcom: Add IPQ5018 pinctrl driver

Thierry Reding (2):
      pinctrl: tegra: Duplicate pinmux functions table
      pinctrl: tegra: Consistently refer to SoC data

Uwe Kleine-K=C3=B6nig (1):
      pinctrl: Switch i2c drivers back to use .probe()

Wells Lu (2):
      pinctrl: sunplus: Add check for kmalloc
      pinctrl:sunplus: Add check for kmalloc

Xiaolei Wang (1):
      pinctrl: freescale: Fix a memory out of bounds when num_configs is 1

 .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt   |    3 +-
 .../pinctrl/nvidia,tegra234-pinmux-aon.yaml        |   78 +
 .../pinctrl/nvidia,tegra234-pinmux-common.yaml     |   66 +
 .../bindings/pinctrl/nvidia,tegra234-pinmux.yaml   |  139 ++
 .../bindings/pinctrl/qcom,ipq5018-tlmm.yaml        |  127 ++
 .../bindings/pinctrl/qcom,ipq9574-tlmm.yaml        |   11 +-
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |    3 +
 .../bindings/pinctrl/qcom,qcm2290-tlmm.yaml        |   11 +-
 .../bindings/pinctrl/qcom,sc8280xp-tlmm.yaml       |   12 +-
 .../bindings/pinctrl/qcom,sdx65-tlmm.yaml          |    2 +-
 .../bindings/pinctrl/qcom,sdx75-tlmm.yaml          |  137 ++
 .../bindings/pinctrl/qcom,sm7150-tlmm.yaml         |   11 +-
 MAINTAINERS                                        |    6 +-
 drivers/gpio/gpio-tegra186.c                       |   14 +-
 drivers/pinctrl/Kconfig                            |    1 -
 drivers/pinctrl/Makefile                           |    2 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |    6 +-
 drivers/pinctrl/freescale/pinctrl-scu.c            |    3 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c           |  104 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   26 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |   54 +-
 drivers/pinctrl/intel/pinctrl-merrifield.c         |   16 +-
 drivers/pinctrl/intel/pinctrl-meteorlake.c         |  212 ++-
 drivers/pinctrl/intel/pinctrl-moorefield.c         |   16 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |    2 +
 drivers/pinctrl/nxp/pinctrl-s32.h                  |   14 +-
 drivers/pinctrl/nxp/pinctrl-s32cc.c                |   42 +-
 drivers/pinctrl/nxp/pinctrl-s32g2.c                |   14 +-
 drivers/pinctrl/pinctrl-amd.c                      |   50 +-
 drivers/pinctrl/pinctrl-amd.h                      |    1 +
 drivers/pinctrl/pinctrl-at91-pio4.c                |   17 +-
 drivers/pinctrl/pinctrl-at91.c                     |    8 +-
 drivers/pinctrl/pinctrl-axp209.c                   |   42 +
 drivers/pinctrl/pinctrl-cy8c95x0.c                 |    2 +-
 drivers/pinctrl/pinctrl-falcon.c                   |    1 -
 drivers/pinctrl/pinctrl-mcp23s08_i2c.c             |    2 +-
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |    5 +-
 drivers/pinctrl/pinctrl-sx150x.c                   |    2 +-
 drivers/pinctrl/pinctrl-xway.c                     |    2 +-
 drivers/pinctrl/pinmux.c                           |   15 +-
 drivers/pinctrl/qcom/Kconfig                       |  463 +----
 drivers/pinctrl/qcom/Kconfig.msm                   |  369 ++++
 drivers/pinctrl/qcom/Makefile                      |    4 +-
 drivers/pinctrl/qcom/pinctrl-apq8064.c             |  104 +-
 drivers/pinctrl/qcom/pinctrl-apq8084.c             |  264 ++-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c             |  104 +-
 drivers/pinctrl/qcom/pinctrl-ipq5018.c             |  783 ++++++++
 drivers/pinctrl/qcom/pinctrl-ipq5332.c             |  206 +-
 drivers/pinctrl/qcom/pinctrl-ipq6018.c             |  260 ++-
 drivers/pinctrl/qcom/pinctrl-ipq8064.c             |  114 +-
 drivers/pinctrl/qcom/pinctrl-ipq8074.c             |  240 ++-
 drivers/pinctrl/qcom/pinctrl-ipq9574.c             |  176 +-
 drivers/pinctrl/qcom/pinctrl-mdm9607.c             |  276 ++-
 drivers/pinctrl/qcom/pinctrl-mdm9615.c             |   90 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   13 +-
 drivers/pinctrl/qcom/pinctrl-msm.h                 |   42 +-
 drivers/pinctrl/qcom/pinctrl-msm8226.c             |  156 +-
 drivers/pinctrl/qcom/pinctrl-msm8660.c             |  252 ++-
 drivers/pinctrl/qcom/pinctrl-msm8909.c             |  268 ++-
 drivers/pinctrl/qcom/pinctrl-msm8916.c             |  556 +++---
 drivers/pinctrl/qcom/pinctrl-msm8953.c             |  424 +++--
 drivers/pinctrl/qcom/pinctrl-msm8960.c             |  464 +++--
 drivers/pinctrl/qcom/pinctrl-msm8976.c             |  212 +--
 drivers/pinctrl/qcom/pinctrl-msm8994.c             |  564 +++---
 drivers/pinctrl/qcom/pinctrl-msm8996.c             |  508 +++--
 drivers/pinctrl/qcom/pinctrl-msm8998.c             |  380 ++--
 drivers/pinctrl/qcom/pinctrl-msm8x74.c             |  474 +++--
 drivers/pinctrl/qcom/pinctrl-qcm2290.c             |  230 ++-
 drivers/pinctrl/qcom/pinctrl-qcs404.c              |  388 ++--
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c             |    8 +-
 drivers/pinctrl/qcom/pinctrl-qdu1000.c             |  249 ++-
 drivers/pinctrl/qcom/pinctrl-sa8775p.c             |  327 ++--
 drivers/pinctrl/qcom/pinctrl-sc7180.c              |  254 ++-
 drivers/pinctrl/qcom/pinctrl-sc7280.c              |  322 ++--
 drivers/pinctrl/qcom/pinctrl-sc8180x.c             |  292 ++-
 drivers/pinctrl/qcom/pinctrl-sc8280xp.c            |  358 ++--
 drivers/pinctrl/qcom/pinctrl-sdm660.c              |  387 ++--
 drivers/pinctrl/qcom/pinctrl-sdm670.c              |  284 ++-
 drivers/pinctrl/qcom/pinctrl-sdm845.c              |  286 ++-
 drivers/pinctrl/qcom/pinctrl-sdx55.c               |  190 +-
 drivers/pinctrl/qcom/pinctrl-sdx65.c               |  194 +-
 drivers/pinctrl/qcom/pinctrl-sdx75.c               | 1144 ++++++++++++
 drivers/pinctrl/qcom/pinctrl-sm6115.c              |  162 +-
 drivers/pinctrl/qcom/pinctrl-sm6125.c              |  282 ++-
 drivers/pinctrl/qcom/pinctrl-sm6350.c              |  296 ++-
 drivers/pinctrl/qcom/pinctrl-sm6375.c              |  358 ++--
 drivers/pinctrl/qcom/pinctrl-sm7150.c              |  247 ++-
 drivers/pinctrl/qcom/pinctrl-sm8150.c              |  286 ++-
 drivers/pinctrl/qcom/pinctrl-sm8250.c              |  258 ++-
 drivers/pinctrl/qcom/pinctrl-sm8350.c              |  298 ++-
 drivers/pinctrl/qcom/pinctrl-sm8450.c              |  300 ++-
 drivers/pinctrl/qcom/pinctrl-sm8550.c              |  320 ++--
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |    2 +
 drivers/pinctrl/renesas/pfc-r8a77970.c             |    2 +-
 drivers/pinctrl/renesas/pfc-r8a77980.c             |    6 +-
 drivers/pinctrl/spear/pinctrl-spear.c              |    1 -
 drivers/pinctrl/sunplus/sppctl.c                   |   23 +-
 drivers/pinctrl/tegra/Kconfig                      |    4 +
 drivers/pinctrl/tegra/Makefile                     |    1 +
 drivers/pinctrl/tegra/pinctrl-tegra.c              |   28 +-
 drivers/pinctrl/tegra/pinctrl-tegra.h              |    3 +-
 drivers/pinctrl/tegra/pinctrl-tegra114.c           |    7 +-
 drivers/pinctrl/tegra/pinctrl-tegra124.c           |    7 +-
 drivers/pinctrl/tegra/pinctrl-tegra194.c           |    7 +-
 drivers/pinctrl/tegra/pinctrl-tegra20.c            |    7 +-
 drivers/pinctrl/tegra/pinctrl-tegra210.c           |    7 +-
 drivers/pinctrl/tegra/pinctrl-tegra234.c           | 1960 ++++++++++++++++=
++++
 drivers/pinctrl/tegra/pinctrl-tegra30.c            |    7 +-
 drivers/soc/tegra/Kconfig                          |    1 +
 include/dt-bindings/pinctrl/k3.h                   |   60 -
 include/linux/string_choices.h                     |   44 +
 include/linux/string_helpers.h                     |   26 +-
 112 files changed, 11602 insertions(+), 7366 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux-aon.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux-common.yam=
l
 create mode 100644
Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/Kconfig.msm
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5018.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdx75.c
 create mode 100644 drivers/pinctrl/tegra/pinctrl-tegra234.c
 delete mode 100644 include/dt-bindings/pinctrl/k3.h
 create mode 100644 include/linux/string_choices.h
