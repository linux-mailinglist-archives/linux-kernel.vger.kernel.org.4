Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07263649FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiLLNRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiLLNRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:17:08 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF813D5B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:16:47 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c140so13538380ybf.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FkyR78N3iX4V6QhYQNZQMk6zU3hhQIWKAm0khwBeVk8=;
        b=Fc5ToA3N/6mBhzWYggCbi9Vvd2Yypv7tySFcVlWHAOEqmIThdNI9QiM6F2uZhCctqw
         IFrQ/yKeESHaUhqahWjfOZGYyPwkT0pOPwQ/roki6Em8nqDpKhMUmn5y8v/zv0VlLwqB
         SeBHD56DTfX3eIDdT88A2zjmsFr0kGF0Hb1s/xMh+t9FfeFgzBd9jbxhjJ1pwTpiw8+O
         4IiDI7VhM6qmHDVstvIU1sWNpS0FzC3UbyiovWCZzuLlOJZz683ftb6SWxDPPqbZwOWC
         o5kytVsK9aFlw4+B3woyM1Z2M4uco56klAjOQAfpxqGoK8y3rvWIZ+qiQYck1+PK/0QI
         7jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkyR78N3iX4V6QhYQNZQMk6zU3hhQIWKAm0khwBeVk8=;
        b=loxsZeImEm0GmsKWn5aRpnEW4kpy5TkIad/lUnpmGnP0WyQ8rmdPNCvAFBfjMWr9A4
         R1/XCkg1ES8S4ZY5OMp5vnW0NUVPmUHI/xlDeTjoU1gkMcJgt11VhlNrkigEOBZ7NBlA
         3VPKkFOncTdY/tpCIKt9+wCFaba5c5MQBqdojvCG2CEu6k7K+0C22IvXXI7KD4ZfwfPg
         Hs7x5CXmcpC9DT9tkVR8FEGQso+5VsfmYrPfs43Yzgg5MAqzBhDEPO5sF4jgD4jHXr3n
         K3J7CcV/6bV6+a3CMY6Nwc23U6ZLROnqPA/RVrPMXLtQXx8h6on85Ka3tGcKWjJBnKyY
         5ZZA==
X-Gm-Message-State: ANoB5pms8Gn7Cnc9Ya/sb/zWZmntPU7nPIZKf3cqzep/i0h2HM8gf5sz
        oYuTCN+VpCMYHPwE7S/D4zlt0yssPQL1JuN88/3RyQ==
X-Google-Smtp-Source: AA0mqf68h8GP6RKdf3MhIa8AVdyImwwInz7Yl/Abob+h4wj9HRNpw2i8lhyyABAxnjbHa0AJmtcq+eIgSft8xbhFBoQ=
X-Received: by 2002:a25:8e82:0:b0:6d2:70d5:3ed0 with SMTP id
 q2-20020a258e82000000b006d270d53ed0mr95764740ybl.457.1670851006060; Mon, 12
 Dec 2022 05:16:46 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 12 Dec 2022 14:16:35 +0100
Message-ID: <CACRpkdYZDXH=_Mgv0u+B8btLjFcCSTboWFXH4u1h9V=WqLEJQA@mail.gmail.com>
Subject: [GIT PULL] pin control bulk changes for v6.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is the bulk of pin control changes for the v6.2 kernel cycle.

The two large chunks is the header clean-up from Andy and the Qualcomm
DT bindings clean-up from Krzysztof. Each which could give rise to conflict=
s,
but I haven't seen any.

The YAML conversions happening around the device tree is the biggest
item in the series and is the result of Rob Herrings ambition to autovalida=
te
these trees against strict schemas and it is paying off in lots of bugs fou=
nd
and ever prettier device trees. Sooner or later the transition will be comp=
lete,
Krzysztof is fixing up all of the Qualcomm stuff, which is pretty voluminou=
s.

What has however conflicted in linux-next is pinctrl and the SoC tree, see:
https://lore.kernel.org/linux-next/20221206121336.474457bb@canb.auug.org.au=
/
this was caused by a merge path misunderstanding, so now it becomes
your problem, congratulations. However as you can see the resolution is
fairly trivial and available in linux-next.

Further details in the signed tag.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780=
:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.2-1

for you to fetch changes up to 83e1bcaf8cef26edaaf2a6098ef760f563683483:

  pinctrl: thunderbay: fix possible memory leak in
thunderbay_build_functions() (2022-12-06 15:28:14 +0100)

----------------------------------------------------------------
Pin control changes for the v6.2 kernel cycle:

Core changes:

- Minor but nice and important documentation clean-ups.

New drivers:

- New subdriver for the Qualcomm SDM670 SoC.

- New subdriver for the Intel Moorefield SoC.

- New trivial support for the NXP Freescale i.MXRT1170 SoC.

Other changes and improvements

- A major clean-up of the Qualcomm pin control device tree bindings
  by Krzysztof.

- A major header clean-up by Andy.

- Some immutable irqchip clean-up for the Actions Semiconductor
  and Nuvoton drivers.

- GPIO helpers for The Cypress cy8c95x0 driver.

- Bias handling in the Mediatek MT7986 driver.

- Remove the unused pins-are-numbered concept that never flew.

----------------------------------------------------------------
Andy Shevchenko (78):
      pinctrl: actions: make irq_chip immutable
      pinctrl: cy8c95x0: Extract cy8c95x0_set_mode() helper
      pinctrl: cy8c95x0: Implement ->gpio_request_enable() and
->gpio_set_direction()
      pinctrl: st: Switch to use fwnode instead of of_node
      gpio: aspeed: Add missing header(s)
      gpio: arizona: Remove unused header(s)
      gpio: da9052: Remove unused header(s)
      pinctrl: cy8c95x0: Don't use cy8c95x0_set_mode() twice
      gpio: mockup: Add missing header(s)
      gpio: pca953x: Add missing header(s)
      gpio: pl061: Add missing header(s)
      gpio: reg: Add missing header(s)
      gpio: wm8350: Remove unused header(s)
      gpio: tegra186: Add missing header(s)
      gpiolib: cdev: Add missing header(s)
      gpiolib: Clean up headers
      media: c8sectpfe: Add missing header(s)
      pinctrl: actions: Add missing header(s)
      pinctrl: apple-gpio: Add missing header(s)
      pinctrl: aspeed: Add missing header(s)
      pinctrl: at91: Add missing header(s)
      pinctrl: axp209: Add missing header(s)
      pinctrl: bcm: Add missing header(s)
      pinctrl: bm1880: Add missing header(s)
      pinctrl: cirrus: Add missing header(s)
      pinctrl: cy8c95x0: Add missing header(s)
      pinctrl: gemini: Add missing header(s)
      pinctrl: imx: Add missing header(s)
      pinctrl: ingenic: Add missing header(s)
      pinctrl: k210: Add missing header(s)
      pinctrl: lantiq: Add missing header(s)
      pinctrl: lochnagar: Add missing header(s)
      pinctrl: lpc18xx: Add missing header(s)
      pinctrl: mediatek: Add missing header(s)
      pinctrl: microchip-sgpio: Add missing header(s)
      pinctrl: mvebu: Add missing header(s)
      pinctrl: npcm7xx: Add missing header(s)
      pinctrl: ocelot: Add missing header(s)
      pinctrl: qcom: Add missing header(s)
      pinctrl: renesas: Add missing header(s)
      pinctrl: samsung: Add missing header(s)
      pinctrl: single: Add missing header(s)
      pinctrl: spear: Add missing header(s)
      pinctrl: sprd: Add missing header(s)
      pinctrl: st: Add missing header(s)
      pinctrl: starfive: Add missing header(s)
      pinctrl: stm32: Add missing header(s)
      pinctrl: stmfx: Add missing header(s)
      pinctrl: sunxi: Add missing header(s)
      pinctrl: tegra: Add missing header(s)
      pinctrl: ti-iodelay: Add missing header(s)
      pinctrl: uniphier: Add missing header(s)
      pinctrl: zynqmp: Add missing header(s)
      pinctrl: cherryview: Add missing header(s)
      pinctrl: lynxpoint: Add missing header(s)
      pinctrl: merrifield: Add missing header(s)
      pinctrl: intel: Add missing header(s)
      pinctrl: Clean up headers
      pinctrl: alderlake: Deduplicate COMMUNITY macro code
      pinctrl: cannonlake: Deduplicate COMMUNITY macro code
      pinctrl: icelake: Deduplicate COMMUNITY macro code
      pinctrl: sunrisepoint: Deduplicate COMMUNITY macro code
      pinctrl: tigerlake: Deduplicate COMMUNITY macro code
      pinctrl: intel: Use str_enable_disable() helper
      pinctrl: qcom: lpass-lpi: Add missed bitfield.h
      device property: Introduce fwnode_device_is_compatible() helper
      soc: fsl: qe: Switch to use fwnode instead of of_node
      pinctrl: intel: Use temporary variable for struct device
      pinctrl: merrifield: Use temporary variable for struct device
      pinctrl: intel: Add Intel Moorefield pin controller support
      pinctrl: Put space between type and data in compound literal
      pinctrl: Move for_each_maps() to namespace and hide iterator inside
      pwm: Add a stub for devm_pwmchip_add()
      pwm: lpss: Rename MAX_PWMS --> LPSS_MAX_PWMS
      pwm: lpss: Include headers we are the direct user of
      pwm: lpss: Allow other drivers to enable PWM LPSS
      pwm: lpss: Rename pwm_lpss_probe() --> devm_pwm_lpss_probe()
      pinctrl: intel: Enumerate PWM device when community has a capability

Balsam CHIHI (2):
      pinctrl: mediatek: common: add mt8365_set_clr_mode() callback
for broken SET/CLR modes
      pinctrl: mediatek: mt8365: use mt8365_set_clr_mode() callback

Bernhard Rosenkr=C3=A4nzer (4):
      pinctrl: mediatek: common: Remove check for pins-are-numbered
      pinctrl: stm32: Remove check for pins-are-numbered
      dt-bindings: pinctrl: mediatek,mt65xx: Deprecate pins-are-numbered
      dt-bindings: pinctrl: st,stm32: Deprecate pins-are-numbered

Biju Das (2):
      pinctrl: renesas: rzv2m: remove unnecessary check from
rzv2m_dt_node_to_map()
      pinctrl: renesas: rzg2l: remove unnecessary check from
rzg2l_dt_node_to_map()

Fabien Poussin (1):
      pinctrl: sunxi: d1: Add CAN bus pinmuxes

Frank Wunderlich (2):
      dt-bindings: pinctrl: update pcie/pwm/spi bindings for MT7986 SoC
      dt-bindings: pinctrl: update uart/mmc bindings for MT7986 SoC

Gaosheng Cui (1):
      pinctrl: thunderbay: fix possible memory leak in
thunderbay_build_functions()

Geert Uytterhoeven (2):
      pinctrl: renesas: gpio: Use dynamic GPIO base if no function GPIOs
      pinctrl: starfive: Use existing variable gpio

Jesse Taube (6):
      dt-bindings: arm: imx: Add i.MXRT compatible Documentation
      dt-bindings: pinctrl: Fix file path for pinfunc include
      dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
      dt-bindings: serial: fsl-lpuart: add i.MXRT1170 compatible
      dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170 compatible
      pinctrl: freescale: Fix i.MXRT1050 pad names

Jonathan Neusch=C3=A4fer (3):
      pinctrl: nuvoton: wpcm450: Convert irqchip to IRQCHIP_IMMUTABLE
      pinctrl: nuvoton: wpcm450: Refactor MFSEL setting code
      pinctrl: nuvoton: wpcm450: Fix handling of inverted MFSEL bits

Krzysztof Kozlowski (93):
      dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: fix gpio pattern
      dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: fix gpio pattern
      dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: fix matching pin config
      dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: fix matching pin confi=
g
      dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: fix matching pin config
      dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: fix matching pin config
      dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: add bias-bus-hold
      dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: add bias-bus-hold
and input-enable
      dt-bindings: pinctrl: qcom,tlmm-common: add common check for function
      dt-bindings: pinctrl: qcom,ipq6018: add qpic_pad function
      dt-bindings: pinctrl: qcom,ipq6018: correct BLSP6->BLSP0 functions
      dt-bindings: pinctrl: qcom,ipq6018: increase number of pins in pinmux
      dt-bindings: pinctrl: qcom,ipq6018: fix matching pin config
      dt-bindings: pinctrl: qcom,ipq6018: use common TLMM schema
      dt-bindings: pinctrl: qcom,ipq6018: fix indentation in example
      dt-bindings: pinctrl: qcom,msm8226: fix matching pin config
      dt-bindings: pinctrl: qcom,msm8226: use common TLMM schema
      dt-bindings: pinctrl: qcom,msm8226: add functions and input-enable
      dt-bindings: pinctrl: qcom,msm8226: fix indentation in example
      dt-bindings: pinctrl: qcom,msm8909-tlmm: fix matching pin config
      dt-bindings: pinctrl: qcom,msm8909-tlmm: do not require function
on non-GPIOs
      dt-bindings: pinctrl: qcom,msm8909-tlmm: fix indentation in example
      dt-bindings: pinctrl: qcom,msm8953: fix matching pin config
      dt-bindings: pinctrl: qcom,msm8953: use common TLMM schema
      dt-bindings: pinctrl: qcom,msm8953: fix indentation in example
      dt-bindings: pinctrl: qcom,mdm9607: do not require function on non-GP=
IOs
      dt-bindings: pinctrl: qcom,mdm9607: fix indentation in example
      dt-bindings: pinctrl: qcom,qcm2290: fix matching pin config
      dt-bindings: pinctrl: qcom,qcm2290: use common TLMM schema
      dt-bindings: pinctrl: qcom,sdx55: fix matching pin config
      dt-bindings: pinctrl: qcom,sdx55: use common TLMM schema
      dt-bindings: pinctrl: qcom,sdx55: fix indentation in example
      dt-bindings: pinctrl: qcom,sdx65: fix matching pin config
      dt-bindings: pinctrl: qcom,sdx65: use common TLMM schema
      dt-bindings: pinctrl: qcom,sc7280: fix matching pin config
      dt-bindings: pinctrl: qcom,sc8280xp: fix indentation in example
(remaining piece)
      dt-bindings: pinctrl: qcom,sdm845: convert to dtschema
      dt-bindings: pinctrl: qcom,sdm630: convert to dtschema
      dt-bindings: pinctrl: qcom,sm8250: add gpio-reserved-ranges and
gpio-line-names
      dt-bindings: pinctrl: qcom,sm8250: use common TLMM pin schema
      dt-bindings: pinctrl: qcom,sm8250: fix matching pin config
      dt-bindings: pinctrl: qcom,sm8250: add input-enable
      dt-bindings: pinctrl: qcom,sc7280: correct number of GPIOs
      dt-bindings: pinctrl: qcom,sc7280: add bias-bus-hold and input-enable
      dt-bindings: pinctrl: qcom,sc7280: use common TLMM pin schema
      dt-bindings: pinctrl: qcom,ipq6018: replace maintainer
      dt-bindings: pinctrl: qcom,mdm9607: drop ref to pinctrl.yaml
      dt-bindings: pinctrl: qcom,sc8180x: drop ref to pinctrl.yaml
      dt-bindings: pinctrl: qcom,sc8180x: drop checks used in common TLMM
      dt-bindings: pinctrl: qcom,sc8280xp: drop checks used in common TLMM
      dt-bindings: pinctrl: qcom,sm6115: use common TLMM schema
      dt-bindings: pinctrl: qcom,sm6125: drop checks used in common TLMM
      dt-bindings: pinctrl: qcom,sm6125: drop ref to pinctrl.yaml
      dt-bindings: pinctrl: qcom,sm6350: drop ref to pinctrl.yaml
      dt-bindings: pinctrl: qcom,sm6350: drop checks used in common TLMM
      dt-bindings: pinctrl: qcom,sm6375-tlmm: drop ref to pinctrl.yaml
      dt-bindings: pinctrl: qcom,sm6375-tlmm: drop checks used in common TL=
MM
      dt-bindings: pinctrl: qcom,sm8250: use common TLMM schema
      dt-bindings: pinctrl: qcom,sm8350: drop ref to pinctrl.yaml
      dt-bindings: pinctrl: qcom,sm8350: drop checks used in common TLMM
      dt-bindings: pinctrl: qcom,sm8450: drop checks used in common TLMM
      dt-bindings: pinctrl: qcom,mdm9607-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,msm8909-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,qcm2290-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sdx65-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sc8180x-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sc8280xp-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sm6115-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sm6125-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sm6350-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sm6375-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sm8250: minor style cleanups
      dt-bindings: pinctrl: qcom,sm8350-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sm8450-tlmm: minor style cleanups
      dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: minor style cleanups
      dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: minor style cleanups
      dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: minor style cleanups
      dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: minor style cleanups
      dt-bindings: pinctrl: qcom: adjust description
      dt-bindings: pinctrl: qcom,sm8150: convert to dtschema
      dt-bindings: pinctrl: qcom,msm8998: convert to dtschema
      dt-bindings: pinctrl: qcom,msm8996: convert to dtschema
      dt-bindings: pinctrl: qcom,msm8994: convert to dtschema
      dt-bindings: pinctrl: qcom: drop minItems equal to maxItems
      dt-bindings: pinctrl: qcom,msm8974: convert to dtschema
      dt-bindings: pinctrl: qcom,sc7180: convert to dtschema
      dt-bindings: pinctrl: qcom,pmic-mpp: make compatible fallbacks specif=
ic
      dt-bindings: pinctrl: qcom,msm8916: convert to dtschema
      dt-bindings: pinctrl: qcom,qcs404: convert to dtschema
      dt-bindings: pinctrl: qcom,msm8660: convert to dtschema
      dt-bindings: pinctrl: qcom,ipq8074: convert to dtschema
      dt-bindings: pinctrl: qcom,msm8960: convert to dtschema
      dt-bindings: pinctrl: qcom,msm8976: convert to dtschema

Linus Walleij (7):
      Merge tag 'qcom-pinctrl-6.2' of
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt into
devel
      Merge tag 'intel-pinctrl-v6.1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into devel
      Merge tag 'qcom-pinctrl-6.2-2' of
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt into
devel
      Merge tag 'intel-pinctrl-v6.2-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into devel
      Merge tag 'renesas-pinctrl-for-v6.2-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      pinctrl: loongson2: Fix some const correctness
      Merge tag 'intel-pinctrl-v6.2-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into devel

Mario Limonciello (1):
      pinctrl: amd: Add dynamic debugging for active GPIOs

Neil Armstrong (3):
      dt-bindings: pinctrl: convert qcom,mdm9615-pinctrl.txt to dt-schema
      dt-bindings: pinctrl: convert semtech,sx150xq bindings to dt-schema
      dt-bindings: pinctrl: semtech,sx150xq: fix match patterns for 16
GPIOs matching

Niyas Sait (2):
      pinconf-generic: clarify pull up and pull down config values
      pinconf-generic: fix style issues in pin_config_param doc

Ren Zhijie (1):
      pinctrl: pinctrl-loongson2: fix Kconfig dependency

Richard Acayan (3):
      dt-bindings: pinctrl: qcom: add sdm670 pinctrl
      pinctrl: qcom: do not reinitialize gpio valid mask
      pinctrl: qcom: add sdm670 pinctrl

Ryan Wanner (2):
      pinctrl: at91-pio4: Add configuration to userspace
      pinctrl: at91-pio4: Add persist state case in config

Sam Shih (5):
      pinctrl: mt7986: allow configuring uart rx/tx and rts/cts separately
      dt-bindings: pinctrl: mt7986: add generic bias-pull* support
      pinctrl: mediatek: fix the pinconf register offset of some pins
      pinctrl: mediatek: extend pinctrl-moore to support new bias functions
      pinctrl: mediatek: add pull_type attribute for mediatek MT7986 SoC

Sebastian Reichel (1):
      dt-bindings: pinctrl: rockchip: further increase max amount of
device functions

Shenwei Wang (2):
      pinctrl: freescale: add pad wakeup config
      gpio: mxc: enable pad wakeup on i.MX8x platforms

Siarhei Volkau (2):
      docs/pinctrl: fix pinctrl_select_state examples
      docs/pinctrl: fix runtime pinmuxing example

Thierry Reding (1):
      pinctrl: tegra: Separate Tegra194 instances

Wei Li (1):
      dt-bindings: pinctrl: Correct the header guard of mt6795-pinfunc.h

Yang Yingliang (2):
      pinctrl: ocelot: add missing destroy_workqueue() in error path
in ocelot_pinctrl_probe()
      pinctrl: qcom: sdm670: change sdm670_reserved_gpios to static

Yassine Oudjana (5):
      dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Improve description
      dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Make gpio-ranges optio=
nal
      dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Add MT6797
      dt-bindings: pinctrl: mediatek,pinctrl-mt6795: Fix interrupt count
      dt-bindings: pinctrl: mediatek,pinctrl-mt6795: Improve
interrupts description

Yinbo Zhu (1):
      dt-bindings: pinctrl: add loongson-2 pinctrl

ZhangPeng (2):
      pinctrl: k210: call of_node_put()
      pinctrl: pinconf-generic: add missing of_node_put()

ye xingchen (1):
      pinctrl: qcom: remove duplicate included header files

zhanghongchen (1):
      pinctrl: pinctrl-loongson2: add pinctrl driver support

 Documentation/devicetree/bindings/arm/fsl.yaml     |   12 +
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |    4 +
 .../devicetree/bindings/pinctrl/fsl,imxrt1050.yaml |    2 +-
 .../bindings/pinctrl/loongson,ls2k-pinctrl.yaml    |  123 ++
 .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml  |    5 +-
 .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml  |   95 +-
 .../bindings/pinctrl/mediatek,mt6797-pinctrl.yaml  |  176 ---
 .../bindings/pinctrl/mediatek,mt7986-pinctrl.yaml  |  108 +-
 .../bindings/pinctrl/mediatek,pinctrl-mt6795.yaml  |    7 +-
 .../devicetree/bindings/pinctrl/pinctrl-sx150x.txt |   72 --
 .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml     |  113 +-
 .../bindings/pinctrl/qcom,ipq8074-pinctrl.txt      |  181 ---
 .../bindings/pinctrl/qcom,ipq8074-pinctrl.yaml     |  135 ++
 ...mdm9607-pinctrl.yaml =3D> qcom,mdm9607-tlmm.yaml} |   41 +-
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt      |  161 ---
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     |  119 ++
 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml     |  103 +-
 .../bindings/pinctrl/qcom,msm8660-pinctrl.txt      |   96 --
 .../bindings/pinctrl/qcom,msm8660-pinctrl.yaml     |  125 ++
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml        |   75 +-
 .../bindings/pinctrl/qcom,msm8916-pinctrl.txt      |  195 ---
 .../bindings/pinctrl/qcom,msm8916-pinctrl.yaml     |  166 +++
 .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml     |   97 +-
 .../bindings/pinctrl/qcom,msm8960-pinctrl.txt      |  190 ---
 .../bindings/pinctrl/qcom,msm8960-pinctrl.yaml     |  164 +++
 .../bindings/pinctrl/qcom,msm8974-pinctrl.txt      |  121 --
 .../bindings/pinctrl/qcom,msm8974-pinctrl.yaml     |  179 +++
 .../bindings/pinctrl/qcom,msm8976-pinctrl.txt      |  183 ---
 .../bindings/pinctrl/qcom,msm8976-pinctrl.yaml     |  136 ++
 .../bindings/pinctrl/qcom,msm8994-pinctrl.txt      |  186 ---
 .../bindings/pinctrl/qcom,msm8994-pinctrl.yaml     |  162 +++
 .../bindings/pinctrl/qcom,msm8996-pinctrl.txt      |  208 ---
 .../bindings/pinctrl/qcom,msm8996-pinctrl.yaml     |  182 +++
 .../bindings/pinctrl/qcom,msm8998-pinctrl.txt      |  202 ---
 .../bindings/pinctrl/qcom,msm8998-pinctrl.yaml     |  171 +++
 .../devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml |   45 +-
 ...qcm2290-pinctrl.yaml =3D> qcom,qcm2290-tlmm.yaml} |   64 +-
 .../bindings/pinctrl/qcom,qcs404-pinctrl.txt       |  199 ---
 .../bindings/pinctrl/qcom,qcs404-pinctrl.yaml      |  176 +++
 .../bindings/pinctrl/qcom,sc7180-pinctrl.txt       |  187 ---
 .../bindings/pinctrl/qcom,sc7180-pinctrl.yaml      |  158 +++
 .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     |   48 +-
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml      |   47 +-
 ...sc8180x-pinctrl.yaml =3D> qcom,sc8180x-tlmm.yaml} |   29 +-
 .../pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml   |   44 +-
 ...8280xp-pinctrl.yaml =3D> qcom,sc8280xp-tlmm.yaml} |   28 +-
 .../bindings/pinctrl/qcom,sdm630-pinctrl.yaml      |  188 +++
 .../bindings/pinctrl/qcom,sdm660-pinctrl.txt       |  191 ---
 .../bindings/pinctrl/qcom,sdm670-tlmm.yaml         |  127 ++
 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt       |  176 ---
 .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml      |  158 +++
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml       |   95 +-
 ...com,sdx65-pinctrl.yaml =3D> qcom,sdx65-tlmm.yaml} |   62 +-
 ...m,sm6115-pinctrl.yaml =3D> qcom,sm6115-tlmm.yaml} |   67 +-
 ...m,sm6125-pinctrl.yaml =3D> qcom,sm6125-tlmm.yaml} |   32 +-
 ...m,sm6350-pinctrl.yaml =3D> qcom,sm6350-tlmm.yaml} |   25 +-
 .../bindings/pinctrl/qcom,sm6375-tlmm.yaml         |   23 +-
 .../bindings/pinctrl/qcom,sm8150-pinctrl.txt       |  190 ---
 .../bindings/pinctrl/qcom,sm8150-pinctrl.yaml      |  173 +++
 .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     |   58 +-
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml      |  206 ++-
 ...m,sm8350-pinctrl.yaml =3D> qcom,sm8350-tlmm.yaml} |   25 +-
 .../pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml     |   51 +-
 ...m,sm8450-pinctrl.yaml =3D> qcom,sm8450-tlmm.yaml} |   24 +-
 .../bindings/pinctrl/qcom,tlmm-common.yaml         |   20 +-
 .../bindings/pinctrl/rockchip,pinctrl.yaml         |    2 +-
 .../bindings/pinctrl/semtech,sx1501q.yaml          |  208 +++
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |    7 +-
 .../devicetree/bindings/serial/fsl-lpuart.yaml     |    3 +
 .../devicetree/bindings/timer/fsl,imxgpt.yaml      |    2 +
 Documentation/driver-api/pin-control.rst           |   10 +-
 MAINTAINERS                                        |   10 +-
 drivers/gpio/gpio-arizona.c                        |    5 +-
 drivers/gpio/gpio-aspeed.c                         |    5 +-
 drivers/gpio/gpio-da9052.c                         |    9 +-
 drivers/gpio/gpio-mockup.c                         |    1 +
 drivers/gpio/gpio-mxc.c                            |   92 +-
 drivers/gpio/gpio-pca953x.c                        |    3 +-
 drivers/gpio/gpio-pl061.c                          |   15 +-
 drivers/gpio/gpio-tegra186.c                       |    3 +-
 drivers/gpio/gpio-wm8350.c                         |    7 +-
 drivers/gpio/gpiolib-acpi.h                        |   12 +
 drivers/gpio/gpiolib-cdev.c                        |    4 +-
 drivers/gpio/gpiolib-of.h                          |   11 +-
 drivers/gpio/gpiolib-sysfs.h                       |    2 +
 .../platform/st/sti/c8sectpfe/c8sectpfe-core.c     |    8 +-
 drivers/pinctrl/Kconfig                            |   11 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/actions/pinctrl-owl.c              |   49 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed.c            |    1 +
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c             |   13 +-
 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c           |    9 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c           |   12 +-
 drivers/pinctrl/bcm/pinctrl-ns2-mux.c              |    8 +-
 drivers/pinctrl/bcm/pinctrl-nsp-mux.c              |    8 +-
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c         |    6 +-
 drivers/pinctrl/cirrus/pinctrl-madera-core.c       |    5 +-
 drivers/pinctrl/core.c                             |   25 +-
 drivers/pinctrl/core.h                             |   22 +-
 drivers/pinctrl/devicetree.h                       |    6 +
 drivers/pinctrl/freescale/pinctrl-imx.c            |    8 +-
 drivers/pinctrl/freescale/pinctrl-imx1-core.c      |    4 +-
 drivers/pinctrl/freescale/pinctrl-imxrt1050.c      |  546 ++++----
 drivers/pinctrl/freescale/pinctrl-mxs.c            |    7 +-
 drivers/pinctrl/freescale/pinctrl-scu.c            |   30 +
 drivers/pinctrl/intel/Kconfig                      |   11 +
 drivers/pinctrl/intel/Makefile                     |    1 +
 drivers/pinctrl/intel/pinctrl-alderlake.c          |   40 +-
 drivers/pinctrl/intel/pinctrl-cannonlake.c         |    8 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |    6 +-
 drivers/pinctrl/intel/pinctrl-icelake.c            |    8 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |   61 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c          |    6 +-
 drivers/pinctrl/intel/pinctrl-merrifield.c         |   19 +-
 drivers/pinctrl/intel/pinctrl-moorefield.c         |  916 +++++++++++++
 drivers/pinctrl/intel/pinctrl-sunrisepoint.c       |   32 +-
 drivers/pinctrl/intel/pinctrl-tigerlake.c          |   28 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c           |   52 +-
 drivers/pinctrl/mediatek/pinctrl-mt7986.c          |  112 +-
 drivers/pinctrl/mediatek/pinctrl-mt8365.c          |   18 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |   21 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |    8 +-
 drivers/pinctrl/mediatek/pinctrl-paris.c           |    5 +
 drivers/pinctrl/mvebu/pinctrl-mvebu.c              |   14 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |   11 +-
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c          |   48 +-
 drivers/pinctrl/pinconf-generic.c                  |    4 +-
 drivers/pinctrl/pinconf.h                          |   10 +
 drivers/pinctrl/pinctrl-amd.c                      |   10 +-
 drivers/pinctrl/pinctrl-apple-gpio.c               |    7 +-
 drivers/pinctrl/pinctrl-at91-pio4.c                |   36 +-
 drivers/pinctrl/pinctrl-at91.c                     |   16 +-
 drivers/pinctrl/pinctrl-axp209.c                   |    8 +-
 drivers/pinctrl/pinctrl-bm1880.c                   |    6 +-
 drivers/pinctrl/pinctrl-cy8c95x0.c                 |  134 +-
 drivers/pinctrl/pinctrl-falcon.c                   |    9 +-
 drivers/pinctrl/pinctrl-gemini.c                   |   12 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |   10 +-
 drivers/pinctrl/pinctrl-k210.c                     |   16 +-
 drivers/pinctrl/pinctrl-lantiq.c                   |    5 +-
 drivers/pinctrl/pinctrl-lantiq.h                   |    7 +-
 drivers/pinctrl/pinctrl-loongson2.c                |  311 +++++
 drivers/pinctrl/pinctrl-lpc18xx.c                  |    6 +-
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |    4 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |   30 +-
 drivers/pinctrl/pinctrl-single.c                   |    6 +-
 drivers/pinctrl/pinctrl-st.c                       |   25 +-
 drivers/pinctrl/pinctrl-stmfx.c                    |    2 +
 drivers/pinctrl/pinctrl-thunderbay.c               |    8 +-
 drivers/pinctrl/pinctrl-utils.h                    |    5 +
 drivers/pinctrl/pinctrl-zynqmp.c                   |    5 +-
 drivers/pinctrl/pinmux.c                           |   17 +-
 drivers/pinctrl/pinmux.h                           |   11 +
 drivers/pinctrl/qcom/Kconfig                       |   10 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           |    5 +
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h           |    9 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   29 +-
 drivers/pinctrl/qcom/pinctrl-msm.h                 |    5 +
 drivers/pinctrl/qcom/pinctrl-sdm670.c              | 1345 ++++++++++++++++=
++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |    8 +-
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c            |    8 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c           |   19 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c            |   19 +-
 drivers/pinctrl/renesas/gpio.c                     |   10 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |   10 +-
 drivers/pinctrl/renesas/pinctrl-rzn1.c             |    8 +-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c            |    7 +-
 drivers/pinctrl/renesas/pinctrl.c                  |    8 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   11 +-
 drivers/pinctrl/spear/pinctrl-spear.c              |    6 +-
 drivers/pinctrl/sprd/pinctrl-sprd.c                |    7 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c |    7 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |   21 +-
 drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c          |    4 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   18 +-
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c         |    7 +-
 drivers/pinctrl/tegra/pinctrl-tegra.c              |   39 +-
 drivers/pinctrl/tegra/pinctrl-tegra.h              |    2 +
 drivers/pinctrl/tegra/pinctrl-tegra194.c           |  286 +++--
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c            |    8 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c   |    8 +-
 drivers/pwm/pwm-lpss-pci.c                         |    2 +-
 drivers/pwm/pwm-lpss-platform.c                    |    2 +-
 drivers/pwm/pwm-lpss.c                             |    8 +-
 drivers/pwm/pwm-lpss.h                             |   26 +-
 drivers/soc/fsl/qe/gpio.c                          |    4 +-
 include/dt-bindings/pinctrl/mt6795-pinfunc.h       |    4 +-
 include/linux/gpio.h                               |    2 +-
 include/linux/gpio/aspeed.h                        |    4 +
 include/linux/gpio/driver.h                        |    2 +-
 include/linux/gpio/gpio-reg.h                      |    4 +
 include/linux/gpio/machine.h                       |    1 -
 include/linux/pinctrl/consumer.h                   |   31 +-
 include/linux/pinctrl/devinfo.h                    |    6 +-
 include/linux/pinctrl/machine.h                    |    8 +-
 include/linux/pinctrl/pinconf-generic.h            |   29 +-
 include/linux/pinctrl/pinctrl.h                    |   20 +-
 include/linux/pinctrl/pinmux.h                     |    5 +-
 include/linux/platform_data/x86/pwm-lpss.h         |   33 +
 include/linux/property.h                           |   10 +-
 include/linux/pwm.h                                |    5 +
 202 files changed, 7904 insertions(+), 4773 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-sx150=
x.txt
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{qcom,mdm9607-pinctrl.yam=
l
=3D> qcom,mdm9607-tlmm.yaml} (84%)
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{qcom,qcm2290-pinctrl.yam=
l
=3D> qcom,qcm2290-tlmm.yaml} (76%)
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sc8180x-pinctrl.yam=
l
=3D> qcom,sc8180x-tlmm.yaml} (88%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sc8280xp-pinctrl.ya=
ml
=3D> qcom,sc8280xp-tlmm.yaml} (89%)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sdx65-pinctrl.yaml
=3D> qcom,sdx65-tlmm.yaml} (85%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6115-pinctrl.yaml
=3D> qcom,sm6115-tlmm.yaml} (75%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6125-pinctrl.yaml
=3D> qcom,sm6125-tlmm.yaml} (87%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6350-pinctrl.yaml
=3D> qcom,sm6350-tlmm.yaml} (90%)
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm8350-pinctrl.yaml
=3D> qcom,sm8350-tlmm.yaml} (89%)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm8450-pinctrl.yaml
=3D> qcom,sm8450-tlmm.yaml} (89%)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml
 create mode 100644 drivers/pinctrl/intel/pinctrl-moorefield.c
 create mode 100644 drivers/pinctrl/pinctrl-loongson2.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm670.c
 create mode 100644 include/linux/platform_data/x86/pwm-lpss.h
