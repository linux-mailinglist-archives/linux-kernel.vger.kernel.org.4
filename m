Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1D6F4B5F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjEBU3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjEBU3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:29:36 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8271988
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:29:32 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9a879cd49cso6296653276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683059371; x=1685651371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wYAzeIPVyQkUZ3w5SFdWrZtoUCl71BPCnupibfUW1sQ=;
        b=h8iD/+NFpR65YWu/3vXBte1hohZUdPth4qaQtbWYtAb5BmsT/qzcVR9LR5anyPh116
         z8fNSZ0wP052cEVl0qF+EoamZVUJypmVdL41e+bR4QmH0bv4/WZtyRDHyBAE085hF4uq
         Gh3nmXV+BFCSVfmbzdD8hw13b5xIn2PTnX4RwMZVMLZgKTn2TOIdj5Gc57ltyCGeWZY1
         0TM3SKg1hjC8wLsEcV2hE4BzaYtoxIvFwtDlgqy3+x/wXuyBJ7Xj8uhON6Y1HAXvtCLF
         UVKvaQZy0LNzip3V7jAbw1rponU6jCkWenpHifFK/AcxIarFCLObSeDrvHgWxkRL2l4L
         FdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683059371; x=1685651371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYAzeIPVyQkUZ3w5SFdWrZtoUCl71BPCnupibfUW1sQ=;
        b=Ne6/swyUpr9QOGZmaJHmiDK/eFDU2ePQCqXlVLS6HIo4iAwaa8msJ2REHSq5aB+IBA
         7SzFOHN9T/eR8LIllTWkjZAcya6OgnTbKzDfkaLwBR0i3XP4vArz3LgPqeOZEfsdN/wq
         bVkNg1rHlSFV5mlormDyRDZl+ka7wdTBL1Gs5uowx4dc41dp3Xk4aAAyyGraYg/tTKTO
         34fXWZ+joyW1zoO1qw0CihzI+zHSBwook44R59cCFsEv22xw9lqaxq+VjUVoOL7wFY6Q
         Bc7YyD+tvfXb4l5NzXPnh6xyk1xw1/Qzbf1gwJS6F6NlzBqDa8/mFDdyRMFH/A3GWvkz
         hORA==
X-Gm-Message-State: AC+VfDx65f9e5/s5OFF4nmOBYzLVVOGM0DC80ZZ6G210Lx92QGwaq7dH
        iKtjkucAaKDnSHQ+teaYwEreqZSbXkFpc6NiTv3Mjw==
X-Google-Smtp-Source: ACHHUZ4Y5BWXtgzn0x7hyysZ1Yelzk9BDyPbM7RJ9VrZo2gG8HehVRtCqHoPRXQJnDtPvU9yebGzGdrHe/8vPOgg0yU=
X-Received: by 2002:a05:6902:188e:b0:b69:eb08:8f3b with SMTP id
 cj14-20020a056902188e00b00b69eb088f3bmr21006797ybb.4.1683059371499; Tue, 02
 May 2023 13:29:31 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 May 2023 22:29:20 +0200
Message-ID: <CACRpkdZ=bpsSKKgqGbGThvVAZc8fEx2vStbm9GUaZ5s1p5YGmQ@mail.gmail.com>
Subject: [GIT PULL] pin control bulk changes for v6.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is the big pull request for pin control changes for the v6.4
kernel cycle. Mostly drivers! Nothing special: some new Qualcomm
chips as usual, and the new NXP S32 and nVidia BlueField-3.

There will be one conflict, in the at91 pio4 driver, which is against
a fix I sent in earlier. The version from my tree goes.

Please pull it in!

Yours,
Linus Walleij


The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6=
:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.4-1

for you to fetch changes up to b7badd752de05312fdb1aeb388480f706d0c087f:

  pinctrl-bcm2835.c: fix race condition when setting gpio dir
(2023-04-21 11:00:34 +0200)

----------------------------------------------------------------
Pin control bulk changes for the v6.4 kernel:

Core changes:

- Make a lot of pin controllers with GPIO and irqchips immutable,
  i.e. not living structs, but const structs. This is driving a
  changed initiated by the irqchip maintainers.

New drivers:

- New driver for the NXP S32 SoC pin controller

- As part of a thorough cleanup and restructuring of the
  Ralink/Mediatek drivers, the Ralink MIPS pin control drivers
  were folded into the Mediatek directory and the family is
  renamed "mtmips". The Ralink chips live on as Mediatek MIPS
  family where new variants can be added. As part of this work
  also the device tree bindings were reworked.

- New subdriver for the Qualcomm SM7150 SoC.

- New subdriver for the Qualcomm IPQ9574 SoC.

- New driver for the nVidia BlueField-3 SoC.

- Support for the Qualcomm PMM8654AU mixed signal circuit GPIO.

- Support for the Qualcomm PMI632 mixed signal circuit GPIO.

Improvements:

- Add some missing pins and generic cleanups on the Renesas
  r8a779g0 and r8a779g0 pin controllers. Generic Renesas
  extension for power source selection on several SoCs.

- Misc cleanups for the Atmel AT91 and AT91-PIO4 pin
  controllers

- Make the GPIO mode work on the Qualcomm SM8550-lpass-lpi
  driver.

- Several device tree binding cleanups as the binding
  YAML syntax is solidifying.

----------------------------------------------------------------
Aleksander Jan Bajkowski (2):
      pinctrl: xway: drop the deprecated compatible strings
      dt-bindings: pinctrl: xway: drop the deprecated compatible strings

Alexandre Mergnat (3):
      dt-bindings: pinctrl: mediatek: deprecate custom drive strength prope=
rty
      dt-bindings: pinctrl: mediatek: deprecate custom bias pull
properties for mt8365
      dt-bindings: pinctrl: mediatek,mt8365-pinctrl: add drive strength pro=
perty

Andy Shevchenko (5):
      pinctrl: at91: use devm_kasprintf() to avoid potential leaks (part 2)
      pinctrl: at91: Don't mix non-devm calls with devm ones
      pinctrl: at91: Use of_device_get_match_data()
      pinctrl: at91: Use dev_err_probe() instead of custom messaging
      pinctrl: at91: Utilise temporary variable for struct device

Arnd Bergmann (1):
      pinctrl: s32cc: fix !CONFIG_PM_SLEEP build error

Ar=C4=B1n=C3=A7 =C3=9CNAL (21):
      pinctrl: ralink: reintroduce ralink,rt2880-pinmux compatible string
      pinctrl: ralink: rt305x: add new compatible string for every SoC
      pinctrl: ralink: mt7620: split out to mt76x8
      pinctrl: ralink: move to mediatek as mtmips
      pinctrl: mediatek: remove OF_GPIO as reverse dependency
      dt-bindings: pinctrl: ralink: move additionalProperties to top
      dt-bindings: pinctrl: ralink: drop quotes from referred schemas
      dt-bindings: pinctrl: ralink: add new compatible strings
      dt-bindings: pinctrl: ralink: {mt7620,mt7621}: rename to mediatek
      dt-bindings: pinctrl: mediatek: mt6795: rename to mediatek,mt6795-pin=
ctrl
      dt-bindings: pinctrl: mediatek: mt8186: rename to mediatek,mt8186-pin=
ctrl
      dt-bindings: pinctrl: mediatek: mt8192: rename to mediatek,mt8192-pin=
ctrl
      dt-bindings: pinctrl: mediatek: mt8195: rename to mediatek,mt8195-pin=
ctrl
      dt-bindings: pinctrl: mediatek: fix naming inconsistency
      dt-bindings: pinctrl: {mediatek,ralink}: fix formatting
      dt-bindings: pinctrl: mediatek: fix pinmux header location
      dt-bindings: pinctrl: mediatek: drop quotes from referred schemas
      dt-bindings: pinctrl: mediatek: mt7986: fix patternProperties regex
      dt-bindings: pinctrl: ralink: rt305x: split binding
      dt-bindings: pinctrl: mediatek: mt7620: split binding
      MAINTAINERS: move ralink pinctrl to mediatek mips pinctrl

Asmaa Mnebhi (1):
      pinctrl: mlxbf3: Add pinctrl driver support

Bartosz Golaszewski (2):
      dt-bindings: pinctrl: qcom,pmic-gpio: add compatible for pmm8654au-gp=
io
      pinctrl: qcom: spmi-gpio: add support for pmm8654au-gpio

Chester Lin (7):
      dt-bindings: pinctrl: add schema for NXP S32 SoCs
      pinctrl: add NXP S32 SoC family support
      MAINTAINERS: Add NXP S32 pinctrl maintainer and reviewer
      pinctrl: s32: refine error/return/config checks and simplify driver c=
odes
      pinctrl: s32cc: refactor pin config parsing
      pinctrl: s32cc: embed generic struct pingroup
      pinctrl: s32cc: Use generic struct data to describe pin function

Claudiu Beznea (4):
      pinctrl: at91-pio4: use devm_clk_get_enabled()
      pinctrl: at91-pio4: use device_get_match_data()
      pinctrl: at91-pio4: use dev_err_probe()
      pinctrl: at91-pio4: use proper format specifier for unsigned int

Danila Tikhonov (2):
      dt-bindings: pinctrl: qcom: Add SM7150 pinctrl binding
      pinctrl: qcom: Add SM7150 pinctrl driver

Devi Priya (3):
      dt-bindings: pinctrl: qcom: Add support for IPQ9574
      pinctrl: qcom: Add IPQ9574 pinctrl driver
      dt-bindings: pinctrl: qcom: Add few missing functions

Douglas Anderson (4):
      dt-bindings: pinctrl: qcom: tlmm should use output-disable, not
input-enable
      dt-bindings: pinctrl: qcom: Add output-enable
      pinctrl: qcom: Support OUTPUT_ENABLE; deprecate INPUT_ENABLE
      pinctrl: qcom: Add "and" to PIN_CONFIG_INPUT_ENABLE comment

Geert Uytterhoeven (16):
      pinctrl: renesas: r8a779g0: Fix Group 4/5 pin functions
      pinctrl: renesas: r8a779g0: Fix Group 6/7 pin functions
      pinctrl: renesas: r8a779g0: Fix ERROROUTC function names
      pinctrl: renesas: Drop support for Renesas-specific properties
      pinctrl: renesas: r8a77995: Retain POCCTRL0 register across suspend/r=
esume
      pinctrl: renesas: rcar: Phase out old SH_PFC_PIN_CFG_IO_VOLTAGE flag
      pinctrl: renesas: Add support for 1.8V/2.5V I/O voltage levels
      pinctrl: renesas: r8a77970: Add support for AVB power-source
      pinctrl: renesas: r8a77980: Add support for AVB/GE power-sources
      pinctrl: renesas: r8a77990: Add support for AVB power-source
      pinctrl: renesas: r8a77995: Add support for AVB power-source
      pinctrl: renesas: r8a779g0: Add support for AVB/TSN power-sources
      pinctrl: renesas: Annotate sentinels in tables
      pinctrl: renesas: r8a7779: Add bias pinconf support
      pinctrl: renesas: r8a7779: Add PWM pins, groups, and functions
      pinctrl: renesas: core: Drop unneeded #ifdef CONFIG_OF

Hai Pham (1):
      pinctrl: renesas: r8a779a0: Remove incorrect AVB[01] pinmux configura=
tion

Hans Verkuil (1):
      pinctrl-bcm2835.c: fix race condition when setting gpio dir

Heiner Kallweit (1):
      dt-bindings: pinctrl: Convert Amlogic Meson pinctrl binding

Johan Hovold (1):
      dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow 'bias-bus-hold'

Jonathan Neusch=C3=A4fer (1):
      pinctrl: wpcm450: select MFD_SYSCON

Konrad Dybcio (2):
      pinctrl: qcom: msm8998: Add MPM pin mappings
      dt-bindings: pinctrl: qcom,qcm2290-tlmm: Allow input-enable

Krzysztof Kozlowski (42):
      dt-bindings: pinctrl: qcom: lpass-lpi: correct description of second =
reg
      pinctrl: sx150x: drop of_match_ptr for ID table
      pinctrl: qcom: lpass-lpi: set output value before enabling output
      pinctrl: qcom: lpass-lpi: use consistent name for "group" variable
      pinctrl: qcom: lpass-lpi: allow glitch-free output GPIO
      pinctrl: qcom: sm8550-lpass-lpi: allow GPIO function
      dt-bindings: pinctrl: qcom,ipq5332-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,ipq6018: simplify with unevaluatedProperti=
es
      dt-bindings: pinctrl: qcom,ipq8074: simplify with unevaluatedProperti=
es
      dt-bindings: pinctrl: qcom,mdm9607-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,mdm9615: simplify with unevaluatedProperti=
es
      dt-bindings: pinctrl: qcom,msm8226: simplify with unevaluatedProperti=
es
      dt-bindings: pinctrl: qcom,msm8660: simplify with unevaluatedProperti=
es
      dt-bindings: pinctrl: qcom,msm8909-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,msm8916: simplify with unevaluatedProperti=
es
      dt-bindings: pinctrl: qcom,msm8953: simplify with unevaluatedProperti=
es
      dt-bindings: pinctrl: qcom,msm8960: simplify with unevaluatedProperti=
es
      dt-bindings: pinctrl: qcom,msm8974: simplify with unevaluatedProperti=
es
      dt-bindings: pinctrl: qcom,msm8976: simplify with unevaluatedProperti=
es
      dt-bindings: pinctrl: qcom,msm8994: simplify with unevaluatedProperti=
es
      dt-bindings: pinctrl: qcom,msm8996: simplify with unevaluatedProperti=
es
      dt-bindings: pinctrl: qcom,msm8998: simplify with unevaluatedProperti=
es
      dt-bindings: pinctrl: qcom,qcs404: simplify with unevaluatedPropertie=
s
      dt-bindings: pinctrl: qcom,qdu1000-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,sa8775p-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,sc7180-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,sc7280-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,sc8180x-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,sdm630: simplify with unevaluatedPropertie=
s
      dt-bindings: pinctrl: qcom,sdm670-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,sdm845: simplify with unevaluatedPropertie=
s
      dt-bindings: pinctrl: qcom,sdx55: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sdx65-tlmm: simplify with unevaluatedPrope=
rties
      dt-bindings: pinctrl: qcom,sm6115-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm6125-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm6350-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm6375-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm8150: simplify with unevaluatedPropertie=
s
      dt-bindings: pinctrl: qcom,sm8250: simplify with unevaluatedPropertie=
s
      dt-bindings: pinctrl: qcom,sm8350-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm8450-tlmm: simplify with
unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm8550-tlmm: simplify with
unevaluatedProperties

Lakshmi Sowjanya D (2):
      pinctrl: Remove Intel Thunder Bay pinctrl driver
      dt-bindings: pinctrl: Remove bindings for Intel Thunderbay pinctrl dr=
iver

Linh Phung (2):
      pinctrl: renesas: r8a779g0: Add Audio Clock pins, groups, and functio=
ns
      pinctrl: renesas: r8a779g0: Add Audio SSI pins, groups, and functions

Linus Walleij (19):
      Merge tag 'renesas-pinctrl-for-v6.4-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      Merge branch 'ib-qcom-quad-spi' into devel
      Merge tag 'renesas-pinctrl-for-v6.4-tag2' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      Merge tag 'qcom-pinctrl-6.4' of
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt into
devel
      pinctrl: iproc: Convert to immutable irq_chip
      pinctrl: nsp: Convert to immutable irq_chip
      pinctrl: armada-37xx: Convert to immutable irq_chip
      pinctrl: npcm7xx: Convert to immutable irq_chip
      pinctrl: equilibrium: Convert to immutable irq_chip
      pinctrl: mcp23s08: Convert to immutable irq_chip
      pinctrl: st: Convert to immutable irq_chip
      pinctrl: stmfx: Convert to immutable irq_chip
      pinctrl: sx150x: Convert to immutable irq_chip
      pinctrl: pic32: Convert to immutable irq_chip
      pinctrl: pistachio: Convert to immutable irq_chip
      pinctrl: plgpio: Convert to immutable irq_chip
      pinctrl: qcom spmi-mpp: Convert to immutable irq_chip
      pinctrl: qcom ssbi-mpp: Convert to immutable irq_chip
      pinctrl: qcom ssbi-gpio: Convert to immutable irq_chip

Luca Weiss (2):
      dt-bindings: pinctrl: qcom,pmic-gpio: add PMI632
      pinctrl: qcom: spmi-gpio: Add PMI632 support

Mario Limonciello (2):
      pinctrl: amd: Adjust debugfs output
      pinctrl: amd: Add fields for interrupt status and wake status

Mark Brown (2):
      pinctrl: at91: Make the irqchip immutable
      pinctrl: at91: Remove pioc_index from struct at91_gpio_chip

Md Sadre Alam (1):
      pinctrl: qcom: Use devm_platform_get_and_ioremap_resource()

Phong Hoang (1):
      pinctrl: renesas: r8a779f0: Fix tsn1_avtp_pps pin group

Rasmus Villemoes (1):
      pinctrl: freescale: remove generic pin config core support

Rob Herring (3):
      pinctrl: Use of_property_present() for testing DT property presence
      dt-bindings: pinctrl: Drop unneeded quotes
      dt-bindings: pinctrl: qcom,sm8150: Drop duplicate function value
"atest_usb2"

Tom Rix (1):
      pinctrl: mlxbf3: set varaiable mlxbf3_pmx_funcs
storage-class-specifier to static

Trevor Woerner (1):
      dt-bindings: gpio: nxp,pcf8575: add gpio-line-names

Uwe Kleine-K=C3=B6nig (2):
      pinctrl: mcp23s08: Rename and change function that wraps
regmap_update_bits()
      pinctrl: mcp23s08: Implement gpio bulk functions

Wolfram Sang (1):
      pinctrl: renesas: Remove R-Car H3 ES1.* handling

 .../devicetree/bindings/gpio/nxp,pcf8575.yaml      |    4 +
 .../bindings/pinctrl/actions,s500-pinctrl.yaml     |    2 +-
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml       |    2 +-
 .../bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml |   67 +
 .../pinctrl/amlogic,meson-pinctrl-common.yaml      |   57 +
 .../pinctrl/amlogic,meson-pinctrl-g12a-aobus.yaml  |   68 +
 .../amlogic,meson-pinctrl-g12a-periphs.yaml        |   72 +
 .../pinctrl/amlogic,meson8-pinctrl-aobus.yaml      |   76 +
 .../pinctrl/amlogic,meson8-pinctrl-cbus.yaml       |   78 +
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    2 +-
 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   |    4 +-
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   |    4 +-
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   |    6 +-
 .../bindings/pinctrl/brcm,bcm6318-pinctrl.yaml     |    2 +-
 .../bindings/pinctrl/brcm,bcm63268-pinctrl.yaml    |    2 +-
 .../bindings/pinctrl/brcm,bcm6328-pinctrl.yaml     |    2 +-
 .../bindings/pinctrl/brcm,bcm6358-pinctrl.yaml     |    2 +-
 .../bindings/pinctrl/brcm,bcm6362-pinctrl.yaml     |    2 +-
 .../bindings/pinctrl/brcm,bcm6368-pinctrl.yaml     |    2 +-
 .../bindings/pinctrl/brcm,ns-pinmux.yaml           |    2 +-
 .../bindings/pinctrl/canaan,k210-fpioa.yaml        |    2 +-
 .../bindings/pinctrl/cirrus,lochnagar.yaml         |    2 +-
 .../devicetree/bindings/pinctrl/cirrus,madera.yaml |    4 +-
 .../bindings/pinctrl/cypress,cy8c95x0.yaml         |    2 +-
 .../bindings/pinctrl/fsl,imx7d-pinctrl.yaml        |    2 +-
 .../bindings/pinctrl/fsl,imx8m-pinctrl.yaml        |    2 +-
 .../bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml      |    2 +-
 .../bindings/pinctrl/fsl,imx93-pinctrl.yaml        |    2 +-
 .../bindings/pinctrl/ingenic,pinctrl.yaml          |    2 +-
 .../devicetree/bindings/pinctrl/intel,lgm-io.yaml  |    2 +-
 .../bindings/pinctrl/intel,pinctrl-thunderbay.yaml |  120 -
 .../bindings/pinctrl/lantiq,pinctrl-xway.txt       |   35 +-
 .../bindings/pinctrl/marvell,ac5-pinctrl.yaml      |    4 +-
 .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml  |   32 +-
 .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml  |   39 +-
 ...rl-mt6795.yaml =3D> mediatek,mt6795-pinctrl.yaml} |   51 +-
 .../bindings/pinctrl/mediatek,mt7620-pinctrl.yaml  |  298 +
 ...1-pinctrl.yaml =3D> mediatek,mt7621-pinctrl.yaml} |   17 +-
 .../bindings/pinctrl/mediatek,mt7622-pinctrl.yaml  |   34 +-
 ...0-pinctrl.yaml =3D> mediatek,mt76x8-pinctrl.yaml} |  252 +-
 .../bindings/pinctrl/mediatek,mt7981-pinctrl.yaml  |   35 +-
 .../bindings/pinctrl/mediatek,mt7986-pinctrl.yaml  |   80 +-
 .../bindings/pinctrl/mediatek,mt8183-pinctrl.yaml  |   40 +-
 ...rl-mt8186.yaml =3D> mediatek,mt8186-pinctrl.yaml} |   55 +-
 .../bindings/pinctrl/mediatek,mt8188-pinctrl.yaml  |   80 +-
 ...rl-mt8192.yaml =3D> mediatek,mt8192-pinctrl.yaml} |   57 +-
 ...rl-mt8195.yaml =3D> mediatek,mt8195-pinctrl.yaml} |   51 +-
 .../bindings/pinctrl/mediatek,mt8365-pinctrl.yaml  |   69 +-
 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |   94 -
 .../bindings/pinctrl/mscc,ocelot-pinctrl.yaml      |    6 +-
 .../bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml  |  123 +
 .../bindings/pinctrl/qcom,ipq5332-tlmm.yaml        |   11 +-
 .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml     |   10 +-
 .../bindings/pinctrl/qcom,ipq8074-pinctrl.yaml     |   11 +-
 .../bindings/pinctrl/qcom,ipq9574-tlmm.yaml        |  130 +
 .../bindings/pinctrl/qcom,mdm9607-tlmm.yaml        |   11 +-
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     |   11 +-
 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml     |   11 +-
 .../bindings/pinctrl/qcom,msm8660-pinctrl.yaml     |   12 +-
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml        |   11 +-
 .../bindings/pinctrl/qcom,msm8916-pinctrl.yaml     |   11 +-
 .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml     |   10 +-
 .../bindings/pinctrl/qcom,msm8960-pinctrl.yaml     |   11 +-
 .../bindings/pinctrl/qcom,msm8974-pinctrl.yaml     |   11 +-
 .../bindings/pinctrl/qcom,msm8976-pinctrl.yaml     |   11 +-
 .../bindings/pinctrl/qcom,msm8994-pinctrl.yaml     |   11 +-
 .../bindings/pinctrl/qcom,msm8996-pinctrl.yaml     |   11 +-
 .../bindings/pinctrl/qcom,msm8998-pinctrl.yaml     |   11 +-
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |    9 +-
 .../devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml |    4 +-
 .../bindings/pinctrl/qcom,qcm2290-tlmm.yaml        |    1 +
 .../bindings/pinctrl/qcom,qcs404-pinctrl.yaml      |   11 +-
 .../bindings/pinctrl/qcom,qdu1000-tlmm.yaml        |   11 +-
 .../bindings/pinctrl/qcom,sa8775p-tlmm.yaml        |   11 +-
 .../bindings/pinctrl/qcom,sc7180-pinctrl.yaml      |   11 +-
 .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     |    2 +-
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml      |   12 +-
 .../bindings/pinctrl/qcom,sc8180x-tlmm.yaml        |   11 +-
 .../pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml   |    2 +-
 .../bindings/pinctrl/qcom,sc8280xp-tlmm.yaml       |    1 +
 .../bindings/pinctrl/qcom,sdm630-pinctrl.yaml      |   11 +-
 .../bindings/pinctrl/qcom,sdm670-tlmm.yaml         |   12 +-
 .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml      |   11 +-
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml       |   10 +-
 .../bindings/pinctrl/qcom,sdx65-tlmm.yaml          |   10 +-
 .../bindings/pinctrl/qcom,sm6115-tlmm.yaml         |   10 +-
 .../bindings/pinctrl/qcom,sm6125-tlmm.yaml         |   11 +-
 .../bindings/pinctrl/qcom,sm6350-tlmm.yaml         |   12 +-
 .../bindings/pinctrl/qcom,sm6375-tlmm.yaml         |   12 +-
 .../bindings/pinctrl/qcom,sm7150-tlmm.yaml         |  162 +
 .../bindings/pinctrl/qcom,sm8150-pinctrl.yaml      |   13 +-
 .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     |    2 +-
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml      |   11 +-
 .../bindings/pinctrl/qcom,sm8350-tlmm.yaml         |   13 +-
 .../pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml     |    2 +-
 .../bindings/pinctrl/qcom,sm8450-tlmm.yaml         |   11 +-
 .../pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml     |    2 +-
 .../bindings/pinctrl/qcom,sm8550-tlmm.yaml         |   11 +-
 .../bindings/pinctrl/qcom,tlmm-common.yaml         |    6 +-
 .../bindings/pinctrl/ralink,rt2880-pinctrl.yaml    |   11 +-
 .../bindings/pinctrl/ralink,rt305x-pinctrl.yaml    |   89 +-
 .../bindings/pinctrl/ralink,rt3352-pinctrl.yaml    |  243 +
 .../bindings/pinctrl/ralink,rt3883-pinctrl.yaml    |   11 +-
 .../bindings/pinctrl/ralink,rt5350-pinctrl.yaml    |  206 +
 .../devicetree/bindings/pinctrl/renesas,pfc.yaml   |    2 +-
 .../bindings/pinctrl/renesas,rza1-ports.yaml       |    2 +-
 .../bindings/pinctrl/renesas,rza2-pinctrl.yaml     |    2 +-
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    |    2 +-
 .../bindings/pinctrl/renesas,rzn1-pinctrl.yaml     |    2 +-
 .../bindings/pinctrl/renesas,rzv2m-pinctrl.yaml    |    2 +-
 .../bindings/pinctrl/rockchip,pinctrl.yaml         |   10 +-
 .../bindings/pinctrl/samsung,pinctrl.yaml          |    2 +-
 .../bindings/pinctrl/semtech,sx1501q.yaml          |    6 +-
 .../pinctrl/socionext,uniphier-pinctrl.yaml        |    2 +-
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |   10 +-
 .../bindings/pinctrl/starfive,jh7100-pinctrl.yaml  |    6 +-
 .../bindings/pinctrl/sunplus,sp7021-pinctrl.yaml   |    6 +-
 .../bindings/pinctrl/toshiba,visconti-pinctrl.yaml |    8 +-
 .../bindings/pinctrl/xlnx,zynq-pinctrl.yaml        |    2 +-
 MAINTAINERS                                        |   42 +-
 drivers/pinctrl/Kconfig                            |   34 +-
 drivers/pinctrl/Makefile                           |    4 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   19 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c           |   38 +-
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c             |   23 +-
 drivers/pinctrl/freescale/Kconfig                  |    2 +-
 drivers/pinctrl/freescale/pinctrl-imx.c            |   80 +-
 drivers/pinctrl/freescale/pinctrl-imx.h            |   24 -
 drivers/pinctrl/mediatek/Kconfig                   |   54 +-
 drivers/pinctrl/mediatek/Makefile                  |   63 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c           |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mt7620.c          |  137 +
 .../pinctrl/{ralink =3D> mediatek}/pinctrl-mt7621.c  |   31 +-
 drivers/pinctrl/mediatek/pinctrl-mt76x8.c          |  283 +
 .../pinctrl-ralink.c =3D> mediatek/pinctrl-mtmips.c} |   90 +-
 .../pinctrl-ralink.h =3D> mediatek/pinctrl-mtmips.h} |   16 +-
 .../pinctrl/{ralink =3D> mediatek}/pinctrl-rt2880.c  |   21 +-
 .../pinctrl/{ralink =3D> mediatek}/pinctrl-rt305x.c  |   47 +-
 .../pinctrl/{ralink =3D> mediatek}/pinctrl-rt3883.c  |   29 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        |   34 +-
 drivers/pinctrl/nuvoton/Kconfig                    |    1 +
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |   34 +-
 drivers/pinctrl/nxp/Kconfig                        |   15 +
 drivers/pinctrl/nxp/Makefile                       |    4 +
 drivers/pinctrl/nxp/pinctrl-s32.h                  |   57 +
 drivers/pinctrl/nxp/pinctrl-s32cc.c                |  973 ++++
 drivers/pinctrl/nxp/pinctrl-s32g2.c                |  770 +++
 drivers/pinctrl/pinctrl-amd.c                      |   90 +-
 drivers/pinctrl/pinctrl-at91-pio4.c                |   42 +-
 drivers/pinctrl/pinctrl-at91.c                     |  189 +-
 drivers/pinctrl/pinctrl-equilibrium.c              |   22 +-
 drivers/pinctrl/pinctrl-equilibrium.h              |    2 -
 drivers/pinctrl/pinctrl-mcp23s08.c                 |   81 +-
 drivers/pinctrl/pinctrl-mcp23s08.h                 |    1 -
 drivers/pinctrl/pinctrl-mlxbf3.c                   |  320 ++
 drivers/pinctrl/pinctrl-pic32.c                    |   36 +-
 drivers/pinctrl/pinctrl-pistachio.c                |   35 +-
 drivers/pinctrl/pinctrl-single.c                   |    4 +-
 drivers/pinctrl/pinctrl-st.c                       |   16 +-
 drivers/pinctrl/pinctrl-stmfx.c                    |   38 +-
 drivers/pinctrl/pinctrl-sx150x.c                   |   66 +-
 drivers/pinctrl/pinctrl-thunderbay.c               | 1294 -----
 drivers/pinctrl/pinctrl-xway.c                     |  252 -
 drivers/pinctrl/qcom/Kconfig                       |   21 +
 drivers/pinctrl/qcom/Makefile                      |    2 +
 drivers/pinctrl/qcom/pinctrl-ipq9574.c             |  826 +++
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           |   46 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   39 +-
 drivers/pinctrl/qcom/pinctrl-msm8998.c             |   14 +
 drivers/pinctrl/qcom/pinctrl-sm7150.c              | 1280 +++++
 drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c    |    8 +
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |    2 +
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c            |   38 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c           |   24 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c            |   35 +-
 drivers/pinctrl/ralink/Kconfig                     |   35 -
 drivers/pinctrl/ralink/Makefile                    |    8 -
 drivers/pinctrl/ralink/pinctrl-mt7620.c            |  391 --
 drivers/pinctrl/renesas/Kconfig                    |    5 -
 drivers/pinctrl/renesas/Makefile                   |    1 -
 drivers/pinctrl/renesas/core.c                     |   51 +-
 drivers/pinctrl/renesas/pfc-emev2.c                |    2 +-
 drivers/pinctrl/renesas/pfc-r8a73a4.c              |    4 +-
 drivers/pinctrl/renesas/pfc-r8a7740.c              |    4 +-
 drivers/pinctrl/renesas/pfc-r8a77470.c             |   46 +-
 drivers/pinctrl/renesas/pfc-r8a7778.c              |    4 +-
 drivers/pinctrl/renesas/pfc-r8a7779.c              |  446 +-
 drivers/pinctrl/renesas/pfc-r8a7790.c              |    4 +-
 drivers/pinctrl/renesas/pfc-r8a7791.c              |    6 +-
 drivers/pinctrl/renesas/pfc-r8a7792.c              |    2 +-
 drivers/pinctrl/renesas/pfc-r8a7794.c              |   50 +-
 drivers/pinctrl/renesas/pfc-r8a77950.c             | 5947 ----------------=
----
 drivers/pinctrl/renesas/pfc-r8a77951.c             |   12 +-
 drivers/pinctrl/renesas/pfc-r8a7796.c              |   12 +-
 drivers/pinctrl/renesas/pfc-r8a77965.c             |   12 +-
 drivers/pinctrl/renesas/pfc-r8a77970.c             |   38 +-
 drivers/pinctrl/renesas/pfc-r8a77980.c             |   49 +-
 drivers/pinctrl/renesas/pfc-r8a77990.c             |   41 +-
 drivers/pinctrl/renesas/pfc-r8a77995.c             |   46 +-
 drivers/pinctrl/renesas/pfc-r8a779a0.c             |   16 +-
 drivers/pinctrl/renesas/pfc-r8a779f0.c             |   10 +-
 drivers/pinctrl/renesas/pfc-r8a779g0.c             | 1095 ++--
 drivers/pinctrl/renesas/pfc-sh7203.c               |    4 +-
 drivers/pinctrl/renesas/pfc-sh7264.c               |    4 +-
 drivers/pinctrl/renesas/pfc-sh7269.c               |    6 +-
 drivers/pinctrl/renesas/pfc-sh73a0.c               |    4 +-
 drivers/pinctrl/renesas/pfc-sh7720.c               |    4 +-
 drivers/pinctrl/renesas/pfc-sh7722.c               |    4 +-
 drivers/pinctrl/renesas/pfc-sh7723.c               |    4 +-
 drivers/pinctrl/renesas/pfc-sh7724.c               |    4 +-
 drivers/pinctrl/renesas/pfc-sh7734.c               |    4 +-
 drivers/pinctrl/renesas/pfc-sh7757.c               |    4 +-
 drivers/pinctrl/renesas/pfc-sh7785.c               |    4 +-
 drivers/pinctrl/renesas/pfc-sh7786.c               |    4 +-
 drivers/pinctrl/renesas/pfc-shx3.c                 |    4 +-
 drivers/pinctrl/renesas/pinctrl-rza1.c             |    2 +-
 drivers/pinctrl/renesas/pinctrl-rzn1.c             |    2 +-
 drivers/pinctrl/renesas/pinctrl.c                  |   53 +-
 drivers/pinctrl/renesas/sh_pfc.h                   |   14 +-
 drivers/pinctrl/spear/pinctrl-plgpio.c             |    8 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |    2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   20 +-
 222 files changed, 8966 insertions(+), 10673 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-g12a-aobus.=
yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-g12a-periph=
s.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-aobus.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-cbus.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/intel,pinctrl-thunderbay.yaml
 rename Documentation/devicetree/bindings/pinctrl/{mediatek,pinctrl-mt6795.=
yaml
=3D> mediatek,mt6795-pinctrl.yaml} (85%)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{ralink,mt7621-pinctrl.ya=
ml
=3D> mediatek,mt7621-pinctrl.yaml} (96%)
 rename Documentation/devicetree/bindings/pinctrl/{ralink,mt7620-pinctrl.ya=
ml
=3D> mediatek,mt76x8-pinctrl.yaml} (61%)
 rename Documentation/devicetree/bindings/pinctrl/{pinctrl-mt8186.yaml
=3D> mediatek,mt8186-pinctrl.yaml} (87%)
 rename Documentation/devicetree/bindings/pinctrl/{pinctrl-mt8192.yaml
=3D> mediatek,mt8192-pinctrl.yaml} (81%)
 rename Documentation/devicetree/bindings/pinctrl/{pinctrl-mt8195.yaml
=3D> mediatek,mt8195-pinctrl.yaml} (89%)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/meson,pinctrl=
.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sm7150-tlmm.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7620.c
 rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-mt7621.c (79%)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt76x8.c
 rename drivers/pinctrl/{ralink/pinctrl-ralink.c =3D>
mediatek/pinctrl-mtmips.c} (74%)
 rename drivers/pinctrl/{ralink/pinctrl-ralink.h =3D>
mediatek/pinctrl-mtmips.h} (75%)
 rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt2880.c (69%)
 rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt305x.c (73%)
 rename drivers/pinctrl/{ralink =3D> mediatek}/pinctrl-rt3883.c (79%)
 create mode 100644 drivers/pinctrl/nxp/Kconfig
 create mode 100644 drivers/pinctrl/nxp/Makefile
 create mode 100644 drivers/pinctrl/nxp/pinctrl-s32.h
 create mode 100644 drivers/pinctrl/nxp/pinctrl-s32cc.c
 create mode 100644 drivers/pinctrl/nxp/pinctrl-s32g2.c
 create mode 100644 drivers/pinctrl/pinctrl-mlxbf3.c
 delete mode 100644 drivers/pinctrl/pinctrl-thunderbay.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm7150.c
 delete mode 100644 drivers/pinctrl/ralink/Kconfig
 delete mode 100644 drivers/pinctrl/ralink/Makefile
 delete mode 100644 drivers/pinctrl/ralink/pinctrl-mt7620.c
 delete mode 100644 drivers/pinctrl/renesas/pfc-r8a77950.c
