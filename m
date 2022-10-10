Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7915FA6D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 23:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJJVD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 17:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJJVDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 17:03:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601D1E2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:03:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bj12so27289164ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Pd1MxV7SmICwBH6H0rIXFG+0R3FZKQQJRi8bHcNJ44=;
        b=YgxkIazDHtmbgfncn9oenEALUy7XRXsvmCAa77YpB+eB5kiVxVMnesuski33vLf/8S
         Dqw+XOR+MKjpoanRAveCeU6ToZoM27bNqvxmlp4HmY3CwJCZ2KKB4YvQ3ofT5oJk6AT4
         XPmSIUsn3Jmd7rgTshi9XtrTFROWQ84Xh51OIbgsolXEjiT5/EynBJ3ZlNEQ37LGKE6l
         0PMzN69vxi6Wq8YkM/muyPJ+/rTvs3f28JFYpln0K273FfzXi8DLxjszUgF5uzhTifSa
         WFXRfqLCKYWenQTkL0dZCphwAcX89IQ+kWVxj/ku4EoUMZoasFNTzvmh0bIpDv0bV88C
         XDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Pd1MxV7SmICwBH6H0rIXFG+0R3FZKQQJRi8bHcNJ44=;
        b=2lnevapIsu2Wqmk8gHhAV0KaLvQczThicemuOfsY1crpHyTVWMfjpSuI+zJKorAEwf
         BIQ7CnLD/pgPgyUop6m9SB4G7Dh4dRzYKHnW6XTog/YvK9HXtdcChaeUdUBKdEiV0Flo
         Z+Rjc+PNZ3MOrUxV4QTfRU64pJt8QKQqNFfeXWNfBDXzmQu2Ti9BQASA93tc1f3KlRtB
         K19Z4Xm0mxQU8jvZMSN8gxnYVrfarvIUF2e3b/KFl4Gc0FP9SXl5BrHY3W1bhZ+DruBo
         Azgz7fVPPy80oueVT7vMyELLM8SNljqR17GTnHEqn87JpgDjRMvlG1uDDnPjlv0ROeGQ
         iakg==
X-Gm-Message-State: ACrzQf0j+SsVJ3VaDWQ/AVVX4FtWECLeAHmo3DiQUjz8/8hsJMstYd/t
        vYm9+HWYfi67+ALE7WfSokR7d7lkhvHnhHd9ODFCLjGhbxdkVQ==
X-Google-Smtp-Source: AMsMyM5cyndgD14T8WL660gcDZmH0X1Aysryi2x1wl//16dzXTJN8aCLr9C2MskR+KF8him9HyhUvTNMdCzPACPnnT0=
X-Received: by 2002:a17:907:1624:b0:78d:d61c:2b4a with SMTP id
 hb36-20020a170907162400b0078dd61c2b4amr217544ejc.208.1665435825149; Mon, 10
 Oct 2022 14:03:45 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Oct 2022 23:03:34 +0200
Message-ID: <CACRpkdY1Z1xZQ2PDDn7gvbY4C04wbX9GwkDqGM-gzQsN+QkxdA@mail.gmail.com>
Subject: [GIT PULL] bulk pin control changes for v6.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
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

here is the big pin control pull request for v6.1.

There is nothing exciting going on, no core changes, just a few
drivers and cleanups.

I have had to pull in an immutable branch from the i2c tree that
makes the remove callback return void, so that is appearing
here and as it is cluttering the diffstat and I vaguely remember
there is a way around that but, no big deal so I just include the
whole thing. Anything not pinctrl-related is off that branch.
I see you already pulled the i2c tree so it should look nice
when pulling.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868=
:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.1-1

for you to fetch changes up to 9d157c89c5569f0ef560b7a5b2d7bf59ae98499c:

  MAINTAINERS: adjust STARFIVE JH7100 PINCTRL DRIVER after file
movement (2022-10-06 11:23:02 +0200)

----------------------------------------------------------------
These are the pin control changes for the v6.1 kernel cycle:

New drivers:

- Cypress CY8C95x0 chip pin control support, along with an immediate
  cleanup.

- Mediatek MT8188 SoC pin control support.

- Qualcomm SM8450 and SC8280XP LPASS (low power audio subsystem)
  pin control support.

- Qualcomm PM7250, PM8450

- Rockchip RV1126 SoC pin control support.

Improvements:

- Fix some missing pins in the Armada 37xx driver.

- Convert Broadcom and Nomadik drivers to use PINCTRL_PINGROUP() macro.

- Fix some GPIO irq_chips to be immutable.

- Massive Qualcomm device tree binding cleanup, with more to come.

----------------------------------------------------------------
Allen-KH Cheng (1):
      dt-bindings: pinctrl: mt8186: Fix 'reg-names' for pinctrl nodes

Andy Shevchenko (29):
      pinctrl: bcm: Convert drivers to use struct pingroup and
PINCTRL_PINGROUP()
      pinctrl: nomadik: Convert drivers to use struct pingroup and
PINCTRL_PINGROUP()
      pinctrl: mcp23s08: Drop assignment of default number of OF cells
      pinctrl: pistachio: Switch to use fwnode instead of
      pinctrl: cy8c95x0: make irq_chip immutable
      pinctrl: cy8c95x0: Allow IRQ chip core to handle numbering
      pinctrl: cy8c95x0: Fix return value in cy8c95x0_detect()
      pinctrl: cy8c95x0: Fix pin control name to enable more than one
      pinctrl: cy8c95x0: Drop unneeded npins assignment
      pinctrl: cy8c95x0: Enable GPIO range
      pinctrl: cy8c95x0: Remove device initialization
      pinctrl: cy8c95x0: Remove useless conditionals
      pinctrl: cy8c95x0: Remove custom ->set_config()
      pinctrl: cy8c95x0: Use 'default' in all switch-cases
      pinctrl: cy8c95x0: Implement ->pin_dbg_show()
      pinctrl: cy8c95x0: Make use of device properties
      pinctrl: cy8c95x0: support ACPI device found on Galileo Gen1
      pinctrl: cy8c95x0: Override IRQ for one of the expanders on Galileo G=
en 1
      pinctrl: cy8c95x0: use bits.h macros for all masks
      pinctrl: cy8c95x0: Correct comment style
      pinctrl: ingenic: Switch to use fwnode instead of of_node
      pinctrl: microchip-sgpio: Correct the fwnode_irq_get() return value c=
heck
      pinctrl: meson: Switch to use fwnode instead of of_node
      pinctrl: pistachio: Correct the fwnode_irq_get() return value check
      pinctrl: cy8c95x0: Use 'default' in all switch-cases (part 2)
      pinctrl: cy8c95x0: Lock register accesses in cy8c95x0_set_mux()
      pinctrl: cy8c95x0: Drop atomicity on operations on push_pull
      pinctrl: cy8c95x0: Align function names in cy8c95x0_pmxops
      pinctrl: wpcm450: Correct the fwnode_irq_get() return value check

Anjelique Melendez (2):
      pinctrl: qcom: spmi-gpio: Fix the GPIO strength mapping
      dt-bindings: qcom-pmic-gpio: Add PM7250B and PM8450 bindings

Basavaraj Natikar (1):
      pinctrl: amd: change dev_warn to dev_dbg for additional feature suppo=
rt

Billy Tsai (1):
      pinctrl: aspeed: Force to disable the function's signal

Claudiu Beznea (3):
      pinctrl: at91: use kernel-doc style for documentation of at91_gpio_ch=
ip
      pinctrl: at91: move gpio suspend/resume calls to driver's context
      pinctrl: at91: use dev_dbg() instead of printk()

Colin Foster (1):
      pinctrl: ocelot: add help and description information to ocelot
pinctrl kconfig

David Collins (1):
      pinctrl: qcom: spmi-gpio: add support for LV_VIN2 and MV_VIN3 subtype=
s

Dmitry Torokhov (1):
      pinctrl: st: stop abusing of_get_named_gpio()

Francesco Dolcini (2):
      pinctrl: imx8m: kconfig: Depends on SOC_IMX8M
      pinctrl: imx8m: kconfig: Fix build error on test compile

Hui.Liu (2):
      dt-bindings: pinctrl: mediatek: add support for mt8188
      pinctrl: mediatek: add mt8188 driver

Iskren Chernev (1):
      dt-bindings: pinctrl: qcom: sm6115: Add reserved ranges

Jagan Teki (2):
      dt-bindings: pinctrl: rockchip: Document RV1126 pinctrl
      pinctrl: rockchip: Add RV1126 pinctrl support

Jiangshan Yi (1):
      pinctrl: berlin: fix spelling typo in comment

Jianlong Huang (2):
      pinctrl: Create subdirectory for StarFive drivers
      pinctrl: starfive: Rename "pinctrl-starfive" to "pinctrl-starfive-jh7=
100"

Jilin Yuan (1):
      pinctrl: nuvoton: Use 'unsigned int' instead of just 'unsigned'.

Jishnu Prakash (1):
      pinctrl: qcom: spmi-gpio: Add compatible for PM7250B

Krzysztof Kozlowski (36):
      dt-bindings: pinctrl: samsung: stop using bindings header with consta=
nts
      dt-bindings: pinctrl: samsung: deprecate header with register constan=
ts
      dt-bindings: pinctrl: qcom,sm6115-pinctrl: fix matching pin config
      dt-bindings: pinctrl: qcom,sm6115-pinctrl: require function on GPIOs
      dt-bindings: pinctrl: qcom,sm6115-pinctrl: fix indentation in example
      dt-bindings: pinctrl: qcom,sm6125-pinctrl: fix matching pin config
      dt-bindings: pinctrl: qcom,sm6125-pinctrl: do not require
function on non-GPIOs
      dt-bindings: pinctrl: qcom,sm6125-pinctrl: extend example
      dt-bindings: pinctrl: qcom,sm6350-pinctrl: fix matching pin config
      dt-bindings: pinctrl: qcom,sm6350-pinctrl: do not require
function on non-GPIOs
      dt-bindings: pinctrl: qcom,sm6350-pinctrl: fix indentation in example
      dt-bindings: pinctrl: qcom,sm6375-pinctrl: fix matching pin config
      dt-bindings: pinctrl: qcom,sm6375-pinctrl: do not require
function on non-GPIOs
      dt-bindings: pinctrl: qcom,sm6375-pinctrl: fix indentation in example
      dt-bindings: pinctrl: qcom,sm8250-pinctrl: do not require
function on non-GPIOs
      dt-bindings: pinctrl: qcom,sm8250-pinctrl: reference tlmm common pins
      dt-bindings: pinctrl: qcom,sm8250-pinctrl: fix indentation in example
      dt-bindings: pinctrl: qcom,sm8350-pinctrl: fix matching pin config
      dt-bindings: pinctrl: qcom,sm8350-pinctrl: fix indentation in example
      dt-bindings: pinctrl: qcom,sm8350-pinctrl: do not require
function on non-GPIOs
      dt-bindings: pinctrl: qcom,sm8450-pinctrl: fix matching pin config
      dt-bindings: pinctrl: qcom,sm8450-pinctrl: fix indentation in example
      dt-bindings: pinctrl: qcom,sm8450-pinctrl: do not require
function on non-GPIOs
      dt-bindings: pinctrl: qcom,sm8450-pinctrl: add gpio-line-names
      dt-bindings: pinctrl: qcom,sc7280-pinctrl: correct number of GPIOs
      dt-bindings: pinctrl: qcom,sc7280-pinctrl: do not require
function on non-GPIOs
      dt-bindings: pinctrl: qcom,sc7280-pinctrl: add gpio-line-names
      dt-bindings: pinctrl: qcom,sc7280-pinctrl: reference tlmm schema
      dt-bindings: pinctrl: qcom,sc7280-pinctrl: fix indentation in example
      dt-bindings: pinctrl: qcom,sc8180x-pinctrl: fix matching pin config
      dt-bindings: pinctrl: qcom,sc8180x-pinctrl: do not require
function on non-GPIOs
      dt-bindings: pinctrl: qcom,sc8180x-pinctrl: fix indentation in exampl=
e
      dt-bindings: pinctrl: qcom,sc8280xp-pinctrl: fix matching pin config
      dt-bindings: pinctrl: qcom,sc8280xp-pinctrl: do not require
function on non-GPIOs
      dt-bindings: pinctrl: qcom,sc8280xp-pinctrl: fix indentation in examp=
le
      pinctrl: qcom: restrict drivers per ARM/ARM64

Lad Prabhakar (1):
      dt-bindings: pinctrl: renesas: Document RZ/Five SoC

Linus Walleij (5):
      Merge branch 'i2c/make_remove_callback_void-immutable' of
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux into devel
      Merge tag 'renesas-pinctrl-for-v6.1-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      Merge tag 'samsung-pinctrl-6.1' of
https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung into
devel
      pinctrl: nomadik: Dereference gpio_chip properly
      pinctrl: nomadik: Make gpio irqchip immutable

Lukas Bulwahn (2):
      pinctrl: nomadik: remove dead code after DB8540 pinctrl removal
      MAINTAINERS: adjust STARFIVE JH7100 PINCTRL DRIVER after file movemen=
t

Manivannan Sadhasivam (1):
      pinctrl: qcom: spmi-gpio: Make irqchip immutable

Marek Vasut (3):
      dt-bindings: pinctrl: st,stm32: Document gpio-line-names
      dt-bindings: pinctrl: st,stm32: Document gpio-hog pattern property
      dt-bindings: pinctrl: st,stm32: Document interrupt-controller propert=
y

Mario Limonciello (1):
      pinctrl: amd: Pick some different unicode symbols

Pali Roh=C3=A1r (4):
      pinctrl: armada-37xx: Add missing GPIO-only pins
      pinctrl: armada-37xx: Fix definitions for MPP pins 20-22
      pinctrl: armada-37xx: Checks for errors in gpio_request_enable callba=
ck
      pinctrl: armada-37xx: Remove unused macro PIN_GRP()

Patrick Rudolph (2):
      dt-binding: pinctrl: Add cypress,cy8c95x0
      pinctrl: Add Cypress cy8c95x0 support

Peter Chiu (1):
      dt-bindings: pinctrl: update bindings for MT7986 SoC

Quentin Schulz (2):
      pinctrl: rockchip: add pinmux_ops.gpio_set_direction callback
      gpio: rockchip: request GPIO mux to pinctrl when setting direction

Rob Herring (2):
      dt-bindings: pinctrl: aspeed: Add missing properties to examples
      dt-bindings: pinctrl: Add missing
(unevaluated|additional)Properties on child nodes

Saravana Kannan (1):
      pinctrl: samsung: Finish initializing the gpios before registering th=
em

Shang XiaoJing (1):
      pinctrl: bcm: ns: Remove redundant dev_err call

Srinivas Kandagatla (4):
      dt-bindings: pinctrl: qcom: Add sm8450 lpass lpi pinctrl bindings
      pinctrl: qcom: Add sm8450 lpass lpi pinctrl driver
      dt-bindings: pinctrl: qcom: Add sc8280xp lpass lpi pinctrl bindings
      pinctrl: qcom: Add sc8280xp lpass lpi pinctrl driver

Stephen Rothwell (1):
      pinctrl: fixup for "i2c: Make remove callback return void"

Uwe Kleine-K=C3=B6nig (6):
      drm/i2c/sil164: Drop no-op remove function
      leds: lm3697: Remove duplicated error reporting in .remove()
      leds: lm3601x: Don't use mutex after it was destroyed
      leds: lm3601x: Improve error reporting for problems during .remove()
      gpio: pca953x: Make platform teardown callback return void
      i2c: Make remove callback return void

Yang Yingliang (2):
      pinctrl: stm32: Switch to use dev_err_probe() helper
      pinctrl: sunxi: sun50i-h5: Switch to use dev_err_probe() helper

Yuan Can (1):
      pinctrl: bcm: Remove unused struct bcm6328_pingroup

 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   |    6 +
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   |    4 +
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   |    6 +
 .../bindings/pinctrl/brcm,bcm4908-pinctrl.yaml     |    1 +
 .../bindings/pinctrl/cypress,cy8c95x0.yaml         |  134 ++
 .../bindings/pinctrl/intel,pinctrl-keembay.yaml    |    1 +
 .../bindings/pinctrl/intel,pinctrl-thunderbay.yaml |    1 +
 .../bindings/pinctrl/marvell,ac5-pinctrl.yaml      |    1 +
 .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml  |    2 +
 .../bindings/pinctrl/mediatek,mt7986-pinctrl.yaml  |   48 +-
 .../bindings/pinctrl/mediatek,mt8188-pinctrl.yaml  |  226 ++
 .../bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml  |    1 +
 .../bindings/pinctrl/pinctrl-mt8186.yaml           |   14 +-
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |    4 +
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml      |   55 +-
 .../bindings/pinctrl/qcom,sc8180x-pinctrl.yaml     |   79 +-
 .../pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml   |  133 ++
 .../bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml    |   73 +-
 .../bindings/pinctrl/qcom,sm6115-pinctrl.yaml      |   96 +-
 .../bindings/pinctrl/qcom,sm6125-pinctrl.yaml      |   61 +-
 .../bindings/pinctrl/qcom,sm6350-pinctrl.yaml      |   73 +-
 .../bindings/pinctrl/qcom,sm6375-tlmm.yaml         |   73 +-
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml      |   41 +-
 .../bindings/pinctrl/qcom,sm8350-pinctrl.yaml      |   73 +-
 .../pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml     |  135 ++
 .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml      |   82 +-
 .../bindings/pinctrl/renesas,rza1-ports.yaml       |    1 +
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    |    2 +-
 .../bindings/pinctrl/rockchip,pinctrl.yaml         |    1 +
 .../bindings/pinctrl/samsung,pinctrl-pins-cfg.yaml |    1 -
 .../bindings/pinctrl/samsung,pinctrl.yaml          |   66 +-
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |   13 +
 .../bindings/pinctrl/starfive,jh7100-pinctrl.yaml  |    2 +-
 .../bindings/pinctrl/toshiba,visconti-pinctrl.yaml |    1 +
 Documentation/i2c/writing-clients.rst              |    2 +-
 MAINTAINERS                                        |   10 +-
 arch/arm/mach-at91/pm.c                            |   15 -
 arch/arm/mach-davinci/board-da850-evm.c            |   12 +-
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c     |    3 +-
 .../boot/dts/starfive/jh7100-beaglev-starlight.dts |    2 +-
 drivers/auxdisplay/ht16k33.c                       |    4 +-
 drivers/auxdisplay/lcd2s.c                         |    3 +-
 drivers/char/ipmi/ipmb_dev_int.c                   |    4 +-
 drivers/char/ipmi/ipmi_ipmb.c                      |    4 +-
 drivers/char/ipmi/ipmi_ssif.c                      |    6 +-
 drivers/char/tpm/st33zp24/i2c.c                    |    4 +-
 drivers/char/tpm/tpm_i2c_atmel.c                   |    3 +-
 drivers/char/tpm/tpm_i2c_infineon.c                |    4 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c                 |    3 +-
 drivers/char/tpm/tpm_tis_i2c.c                     |    3 +-
 drivers/char/tpm/tpm_tis_i2c_cr50.c                |    6 +-
 drivers/clk/clk-cdce706.c                          |    3 +-
 drivers/clk/clk-cs2000-cp.c                        |    4 +-
 drivers/clk/clk-si514.c                            |    3 +-
 drivers/clk/clk-si5341.c                           |    4 +-
 drivers/clk/clk-si5351.c                           |    4 +-
 drivers/clk/clk-si570.c                            |    3 +-
 drivers/clk/clk-versaclock5.c                      |    4 +-
 drivers/crypto/atmel-ecc.c                         |    6 +-
 drivers/crypto/atmel-sha204a.c                     |    6 +-
 drivers/extcon/extcon-rt8973a.c                    |    4 +-
 drivers/gpio/gpio-adp5588.c                        |    4 +-
 drivers/gpio/gpio-max7300.c                        |    4 +-
 drivers/gpio/gpio-pca953x.c                        |   13 +-
 drivers/gpio/gpio-pcf857x.c                        |    4 +-
 drivers/gpio/gpio-rockchip.c                       |    7 +
 drivers/gpio/gpio-tpic2810.c                       |    4 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |    4 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |    4 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c |    4 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c          |    4 +-
 drivers/gpu/drm/bridge/chrontel-ch7033.c           |    4 +-
 drivers/gpu/drm/bridge/cros-ec-anx7688.c           |    4 +-
 drivers/gpu/drm/bridge/ite-it6505.c                |    4 +-
 drivers/gpu/drm/bridge/ite-it66121.c               |    4 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |    3 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c            |    4 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c            |    4 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |    4 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |    8 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |    4 +-
 drivers/gpu/drm/bridge/parade-ps8622.c             |    4 +-
 drivers/gpu/drm/bridge/sii902x.c                   |    4 +-
 drivers/gpu/drm/bridge/sii9234.c                   |    4 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |    4 +-
 drivers/gpu/drm/bridge/tc358767.c                  |    4 +-
 drivers/gpu/drm/bridge/tc358768.c                  |    4 +-
 drivers/gpu/drm/bridge/tc358775.c                  |    4 +-
 drivers/gpu/drm/bridge/ti-dlpc3433.c               |    4 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |    4 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |    4 +-
 drivers/gpu/drm/i2c/ch7006_drv.c                   |    4 +-
 drivers/gpu/drm/i2c/sil164_drv.c                   |    7 -
 drivers/gpu/drm/i2c/tda9950.c                      |    4 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                  |    3 +-
 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c |    4 +-
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  |    4 +-
 drivers/gpu/drm/solomon/ssd130x-i2c.c              |    4 +-
 drivers/hid/i2c-hid/i2c-hid-core.c                 |    4 +-
 drivers/hid/i2c-hid/i2c-hid.h                      |    2 +-
 drivers/hwmon/adc128d818.c                         |    4 +-
 drivers/hwmon/adt7470.c                            |    3 +-
 drivers/hwmon/asb100.c                             |    6 +-
 drivers/hwmon/asc7621.c                            |    4 +-
 drivers/hwmon/dme1737.c                            |    4 +-
 drivers/hwmon/f75375s.c                            |    5 +-
 drivers/hwmon/fschmd.c                             |    6 +-
 drivers/hwmon/ftsteutates.c                        |    3 +-
 drivers/hwmon/ina209.c                             |    4 +-
 drivers/hwmon/ina3221.c                            |    4 +-
 drivers/hwmon/jc42.c                               |    3 +-
 drivers/hwmon/occ/p8_i2c.c                         |    4 +-
 drivers/hwmon/pcf8591.c                            |    3 +-
 drivers/hwmon/smm665.c                             |    3 +-
 drivers/hwmon/tps23861.c                           |    4 +-
 drivers/hwmon/w83781d.c                            |    4 +-
 drivers/hwmon/w83791d.c                            |    6 +-
 drivers/hwmon/w83792d.c                            |    6 +-
 drivers/hwmon/w83793.c                             |    6 +-
 drivers/hwmon/w83795.c                             |    4 +-
 drivers/hwmon/w83l785ts.c                          |    6 +-
 drivers/i2c/i2c-core-base.c                        |    6 +-
 drivers/i2c/i2c-slave-eeprom.c                     |    4 +-
 drivers/i2c/i2c-slave-testunit.c                   |    3 +-
 drivers/i2c/i2c-smbus.c                            |    3 +-
 drivers/i2c/muxes/i2c-mux-ltc4306.c                |    4 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                |    3 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |    3 +-
 drivers/iio/accel/bma180.c                         |    4 +-
 drivers/iio/accel/bmc150-accel-i2c.c               |    4 +-
 drivers/iio/accel/kxcjk-1013.c                     |    4 +-
 drivers/iio/accel/kxsd9-i2c.c                      |    4 +-
 drivers/iio/accel/mc3230.c                         |    4 +-
 drivers/iio/accel/mma7455_i2c.c                    |    4 +-
 drivers/iio/accel/mma7660.c                        |    4 +-
 drivers/iio/accel/mma8452.c                        |    4 +-
 drivers/iio/accel/mma9551.c                        |    4 +-
 drivers/iio/accel/mma9553.c                        |    4 +-
 drivers/iio/accel/stk8312.c                        |    4 +-
 drivers/iio/accel/stk8ba50.c                       |    4 +-
 drivers/iio/adc/ad799x.c                           |    4 +-
 drivers/iio/adc/ina2xx-adc.c                       |    4 +-
 drivers/iio/adc/ltc2497.c                          |    4 +-
 drivers/iio/adc/ti-ads1015.c                       |    4 +-
 drivers/iio/chemical/atlas-sensor.c                |    4 +-
 drivers/iio/chemical/ccs811.c                      |    4 +-
 drivers/iio/chemical/sgp30.c                       |    4 +-
 drivers/iio/dac/ad5380.c                           |    4 +-
 drivers/iio/dac/ad5446.c                           |    4 +-
 drivers/iio/dac/ad5593r.c                          |    4 +-
 drivers/iio/dac/ad5696-i2c.c                       |    4 +-
 drivers/iio/dac/ds4424.c                           |    4 +-
 drivers/iio/dac/m62332.c                           |    4 +-
 drivers/iio/dac/mcp4725.c                          |    4 +-
 drivers/iio/dac/ti-dac5571.c                       |    4 +-
 drivers/iio/gyro/bmg160_i2c.c                      |    4 +-
 drivers/iio/gyro/fxas21002c_i2c.c                  |    4 +-
 drivers/iio/gyro/itg3200_core.c                    |    4 +-
 drivers/iio/gyro/mpu3050-i2c.c                     |    4 +-
 drivers/iio/health/afe4404.c                       |    4 +-
 drivers/iio/health/max30100.c                      |    4 +-
 drivers/iio/health/max30102.c                      |    4 +-
 drivers/iio/humidity/hdc2010.c                     |    4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    4 +-
 drivers/iio/imu/kmx61.c                            |    4 +-
 drivers/iio/light/apds9300.c                       |    4 +-
 drivers/iio/light/apds9960.c                       |    4 +-
 drivers/iio/light/bh1750.c                         |    4 +-
 drivers/iio/light/bh1780.c                         |    4 +-
 drivers/iio/light/cm3232.c                         |    4 +-
 drivers/iio/light/cm36651.c                        |    4 +-
 drivers/iio/light/gp2ap002.c                       |    4 +-
 drivers/iio/light/gp2ap020a00f.c                   |    4 +-
 drivers/iio/light/isl29028.c                       |    4 +-
 drivers/iio/light/isl29125.c                       |    4 +-
 drivers/iio/light/jsa1212.c                        |    4 +-
 drivers/iio/light/ltr501.c                         |    4 +-
 drivers/iio/light/opt3001.c                        |    6 +-
 drivers/iio/light/pa12203001.c                     |    4 +-
 drivers/iio/light/rpr0521.c                        |    4 +-
 drivers/iio/light/stk3310.c                        |    4 +-
 drivers/iio/light/tcs3472.c                        |    4 +-
 drivers/iio/light/tsl2563.c                        |    4 +-
 drivers/iio/light/tsl2583.c                        |    4 +-
 drivers/iio/light/tsl4531.c                        |    4 +-
 drivers/iio/light/us5182d.c                        |    4 +-
 drivers/iio/light/vcnl4000.c                       |    4 +-
 drivers/iio/light/vcnl4035.c                       |    4 +-
 drivers/iio/light/veml6070.c                       |    4 +-
 drivers/iio/magnetometer/ak8974.c                  |    4 +-
 drivers/iio/magnetometer/ak8975.c                  |    4 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |    4 +-
 drivers/iio/magnetometer/hmc5843_i2c.c             |    4 +-
 drivers/iio/magnetometer/mag3110.c                 |    4 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |    4 +-
 drivers/iio/potentiostat/lmp91000.c                |    4 +-
 drivers/iio/pressure/mpl3115.c                     |    4 +-
 drivers/iio/pressure/ms5611_i2c.c                  |    4 +-
 drivers/iio/pressure/zpa2326_i2c.c                 |    4 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |    4 +-
 drivers/iio/proximity/sx9500.c                     |    4 +-
 drivers/iio/temperature/mlx90614.c                 |    4 +-
 drivers/iio/temperature/mlx90632.c                 |    4 +-
 drivers/input/joystick/as5011.c                    |    4 +-
 drivers/input/keyboard/adp5588-keys.c              |    3 +-
 drivers/input/keyboard/lm8323.c                    |    4 +-
 drivers/input/keyboard/lm8333.c                    |    4 +-
 drivers/input/keyboard/mcs_touchkey.c              |    4 +-
 drivers/input/keyboard/qt1070.c                    |    4 +-
 drivers/input/keyboard/qt2160.c                    |    4 +-
 drivers/input/keyboard/tca6416-keypad.c            |    4 +-
 drivers/input/misc/adxl34x-i2c.c                   |    4 +-
 drivers/input/misc/bma150.c                        |    4 +-
 drivers/input/misc/cma3000_d0x_i2c.c               |    4 +-
 drivers/input/misc/pcf8574_keypad.c                |    4 +-
 drivers/input/mouse/synaptics_i2c.c                |    4 +-
 drivers/input/rmi4/rmi_smbus.c                     |    4 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |    4 +-
 drivers/input/touchscreen/bu21013_ts.c             |    4 +-
 drivers/input/touchscreen/cyttsp4_i2c.c            |    4 +-
 drivers/input/touchscreen/edt-ft5x06.c             |    4 +-
 drivers/input/touchscreen/goodix.c                 |    4 +-
 drivers/input/touchscreen/migor_ts.c               |    4 +-
 drivers/input/touchscreen/s6sy761.c                |    4 +-
 drivers/input/touchscreen/stmfts.c                 |    4 +-
 drivers/input/touchscreen/tsc2004.c                |    4 +-
 drivers/leds/flash/leds-as3645a.c                  |    4 +-
 drivers/leds/flash/leds-lm3601x.c                  |   13 +-
 drivers/leds/flash/leds-rt4505.c                   |    3 +-
 drivers/leds/leds-an30259a.c                       |    4 +-
 drivers/leds/leds-aw2013.c                         |    4 +-
 drivers/leds/leds-bd2802.c                         |    4 +-
 drivers/leds/leds-blinkm.c                         |    3 +-
 drivers/leds/leds-is31fl32xx.c                     |    4 +-
 drivers/leds/leds-lm3530.c                         |    3 +-
 drivers/leds/leds-lm3532.c                         |    4 +-
 drivers/leds/leds-lm355x.c                         |    4 +-
 drivers/leds/leds-lm3642.c                         |    3 +-
 drivers/leds/leds-lm3692x.c                        |    4 +-
 drivers/leds/leds-lm3697.c                         |    8 +-
 drivers/leds/leds-lp3944.c                         |    4 +-
 drivers/leds/leds-lp3952.c                         |    4 +-
 drivers/leds/leds-lp50xx.c                         |    4 +-
 drivers/leds/leds-lp5521.c                         |    4 +-
 drivers/leds/leds-lp5523.c                         |    4 +-
 drivers/leds/leds-lp5562.c                         |    4 +-
 drivers/leds/leds-lp8501.c                         |    4 +-
 drivers/leds/leds-lp8860.c                         |    4 +-
 drivers/leds/leds-pca9532.c                        |    6 +-
 drivers/leds/leds-tca6507.c                        |    4 +-
 drivers/leds/leds-turris-omnia.c                   |    4 +-
 drivers/macintosh/ams/ams-i2c.c                    |    4 +-
 drivers/macintosh/therm_adt746x.c                  |    4 +-
 drivers/macintosh/therm_windtunnel.c               |    4 +-
 drivers/macintosh/windfarm_ad7417_sensor.c         |    4 +-
 drivers/macintosh/windfarm_fcu_controls.c          |    3 +-
 drivers/macintosh/windfarm_lm75_sensor.c           |    4 +-
 drivers/macintosh/windfarm_lm87_sensor.c           |    4 +-
 drivers/macintosh/windfarm_max6690_sensor.c        |    4 +-
 drivers/macintosh/windfarm_smu_sat.c               |    4 +-
 drivers/media/cec/i2c/ch7322.c                     |    4 +-
 drivers/media/dvb-frontends/a8293.c                |    3 +-
 drivers/media/dvb-frontends/af9013.c               |    4 +-
 drivers/media/dvb-frontends/af9033.c               |    4 +-
 drivers/media/dvb-frontends/au8522_decoder.c       |    3 +-
 drivers/media/dvb-frontends/cxd2099.c              |    4 +-
 drivers/media/dvb-frontends/cxd2820r_core.c        |    4 +-
 drivers/media/dvb-frontends/dvb-pll.c              |    3 +-
 drivers/media/dvb-frontends/lgdt3306a.c            |    4 +-
 drivers/media/dvb-frontends/lgdt330x.c             |    4 +-
 drivers/media/dvb-frontends/m88ds3103.c            |    3 +-
 drivers/media/dvb-frontends/mn88443x.c             |    4 +-
 drivers/media/dvb-frontends/mn88472.c              |    4 +-
 drivers/media/dvb-frontends/mn88473.c              |    4 +-
 drivers/media/dvb-frontends/mxl692.c               |    4 +-
 drivers/media/dvb-frontends/rtl2830.c              |    4 +-
 drivers/media/dvb-frontends/rtl2832.c              |    4 +-
 drivers/media/dvb-frontends/si2165.c               |    3 +-
 drivers/media/dvb-frontends/si2168.c               |    4 +-
 drivers/media/dvb-frontends/sp2.c                  |    3 +-
 drivers/media/dvb-frontends/stv090x.c              |    3 +-
 drivers/media/dvb-frontends/stv6110x.c             |    3 +-
 drivers/media/dvb-frontends/tc90522.c              |    3 +-
 drivers/media/dvb-frontends/tda10071.c             |    3 +-
 drivers/media/dvb-frontends/ts2020.c               |    3 +-
 drivers/media/i2c/ad5820.c                         |    3 +-
 drivers/media/i2c/ad9389b.c                        |    3 +-
 drivers/media/i2c/adp1653.c                        |    4 +-
 drivers/media/i2c/adv7170.c                        |    3 +-
 drivers/media/i2c/adv7175.c                        |    3 +-
 drivers/media/i2c/adv7180.c                        |    4 +-
 drivers/media/i2c/adv7183.c                        |    3 +-
 drivers/media/i2c/adv7343.c                        |    4 +-
 drivers/media/i2c/adv7393.c                        |    4 +-
 drivers/media/i2c/adv748x/adv748x-core.c           |    4 +-
 drivers/media/i2c/adv7511-v4l2.c                   |    3 +-
 drivers/media/i2c/adv7604.c                        |    3 +-
 drivers/media/i2c/adv7842.c                        |    3 +-
 drivers/media/i2c/ak7375.c                         |    4 +-
 drivers/media/i2c/ak881x.c                         |    4 +-
 drivers/media/i2c/ar0521.c                         |    3 +-
 drivers/media/i2c/bt819.c                          |    3 +-
 drivers/media/i2c/bt856.c                          |    3 +-
 drivers/media/i2c/bt866.c                          |    3 +-
 drivers/media/i2c/ccs/ccs-core.c                   |    4 +-
 drivers/media/i2c/cs3308.c                         |    3 +-
 drivers/media/i2c/cs5345.c                         |    3 +-
 drivers/media/i2c/cs53l32a.c                       |    3 +-
 drivers/media/i2c/cx25840/cx25840-core.c           |    3 +-
 drivers/media/i2c/dw9714.c                         |    4 +-
 drivers/media/i2c/dw9768.c                         |    4 +-
 drivers/media/i2c/dw9807-vcm.c                     |    4 +-
 drivers/media/i2c/et8ek8/et8ek8_driver.c           |    4 +-
 drivers/media/i2c/hi556.c                          |    4 +-
 drivers/media/i2c/hi846.c                          |    4 +-
 drivers/media/i2c/hi847.c                          |    4 +-
 drivers/media/i2c/imx208.c                         |    4 +-
 drivers/media/i2c/imx214.c                         |    4 +-
 drivers/media/i2c/imx219.c                         |    4 +-
 drivers/media/i2c/imx258.c                         |    4 +-
 drivers/media/i2c/imx274.c                         |    3 +-
 drivers/media/i2c/imx290.c                         |    4 +-
 drivers/media/i2c/imx319.c                         |    4 +-
 drivers/media/i2c/imx334.c                         |    4 +-
 drivers/media/i2c/imx335.c                         |    4 +-
 drivers/media/i2c/imx355.c                         |    4 +-
 drivers/media/i2c/imx412.c                         |    4 +-
 drivers/media/i2c/ir-kbd-i2c.c                     |    4 +-
 drivers/media/i2c/isl7998x.c                       |    4 +-
 drivers/media/i2c/ks0127.c                         |    3 +-
 drivers/media/i2c/lm3560.c                         |    4 +-
 drivers/media/i2c/lm3646.c                         |    4 +-
 drivers/media/i2c/m52790.c                         |    3 +-
 drivers/media/i2c/m5mols/m5mols_core.c             |    4 +-
 drivers/media/i2c/max2175.c                        |    4 +-
 drivers/media/i2c/max9286.c                        |    4 +-
 drivers/media/i2c/ml86v7667.c                      |    4 +-
 drivers/media/i2c/msp3400-driver.c                 |    3 +-
 drivers/media/i2c/mt9m001.c                        |    4 +-
 drivers/media/i2c/mt9m032.c                        |    3 +-
 drivers/media/i2c/mt9m111.c                        |    4 +-
 drivers/media/i2c/mt9p031.c                        |    4 +-
 drivers/media/i2c/mt9t001.c                        |    3 +-
 drivers/media/i2c/mt9t112.c                        |    4 +-
 drivers/media/i2c/mt9v011.c                        |    4 +-
 drivers/media/i2c/mt9v032.c                        |    4 +-
 drivers/media/i2c/mt9v111.c                        |    4 +-
 drivers/media/i2c/noon010pc30.c                    |    4 +-
 drivers/media/i2c/og01a1b.c                        |    4 +-
 drivers/media/i2c/ov02a10.c                        |    4 +-
 drivers/media/i2c/ov08d10.c                        |    4 +-
 drivers/media/i2c/ov13858.c                        |    4 +-
 drivers/media/i2c/ov13b10.c                        |    4 +-
 drivers/media/i2c/ov2640.c                         |    3 +-
 drivers/media/i2c/ov2659.c                         |    4 +-
 drivers/media/i2c/ov2680.c                         |    4 +-
 drivers/media/i2c/ov2685.c                         |    4 +-
 drivers/media/i2c/ov2740.c                         |    4 +-
 drivers/media/i2c/ov5640.c                         |    4 +-
 drivers/media/i2c/ov5645.c                         |    4 +-
 drivers/media/i2c/ov5647.c                         |    4 +-
 drivers/media/i2c/ov5648.c                         |    4 +-
 drivers/media/i2c/ov5670.c                         |    4 +-
 drivers/media/i2c/ov5675.c                         |    4 +-
 drivers/media/i2c/ov5693.c                         |    4 +-
 drivers/media/i2c/ov5695.c                         |    4 +-
 drivers/media/i2c/ov6650.c                         |    3 +-
 drivers/media/i2c/ov7251.c                         |    4 +-
 drivers/media/i2c/ov7640.c                         |    4 +-
 drivers/media/i2c/ov7670.c                         |    3 +-
 drivers/media/i2c/ov772x.c                         |    4 +-
 drivers/media/i2c/ov7740.c                         |    3 +-
 drivers/media/i2c/ov8856.c                         |    4 +-
 drivers/media/i2c/ov8865.c                         |    4 +-
 drivers/media/i2c/ov9282.c                         |    4 +-
 drivers/media/i2c/ov9640.c                         |    4 +-
 drivers/media/i2c/ov9650.c                         |    4 +-
 drivers/media/i2c/ov9734.c                         |    4 +-
 drivers/media/i2c/rdacm20.c                        |    4 +-
 drivers/media/i2c/rdacm21.c                        |    4 +-
 drivers/media/i2c/rj54n1cb0c.c                     |    4 +-
 drivers/media/i2c/s5c73m3/s5c73m3-core.c           |    4 +-
 drivers/media/i2c/s5k4ecgx.c                       |    4 +-
 drivers/media/i2c/s5k5baf.c                        |    4 +-
 drivers/media/i2c/s5k6a3.c                         |    3 +-
 drivers/media/i2c/s5k6aa.c                         |    4 +-
 drivers/media/i2c/saa6588.c                        |    4 +-
 drivers/media/i2c/saa6752hs.c                      |    3 +-
 drivers/media/i2c/saa7110.c                        |    3 +-
 drivers/media/i2c/saa7115.c                        |    3 +-
 drivers/media/i2c/saa7127.c                        |    3 +-
 drivers/media/i2c/saa717x.c                        |    3 +-
 drivers/media/i2c/saa7185.c                        |    3 +-
 drivers/media/i2c/sony-btf-mpx.c                   |    4 +-
 drivers/media/i2c/sr030pc30.c                      |    3 +-
 drivers/media/i2c/st-mipid02.c                     |    4 +-
 drivers/media/i2c/tc358743.c                       |    4 +-
 drivers/media/i2c/tda1997x.c                       |    4 +-
 drivers/media/i2c/tda7432.c                        |    3 +-
 drivers/media/i2c/tda9840.c                        |    3 +-
 drivers/media/i2c/tea6415c.c                       |    3 +-
 drivers/media/i2c/tea6420.c                        |    3 +-
 drivers/media/i2c/ths7303.c                        |    4 +-
 drivers/media/i2c/ths8200.c                        |    4 +-
 drivers/media/i2c/tlv320aic23b.c                   |    3 +-
 drivers/media/i2c/tvaudio.c                        |    3 +-
 drivers/media/i2c/tvp514x.c                        |    3 +-
 drivers/media/i2c/tvp5150.c                        |    4 +-
 drivers/media/i2c/tvp7002.c                        |    3 +-
 drivers/media/i2c/tw2804.c                         |    3 +-
 drivers/media/i2c/tw9903.c                         |    3 +-
 drivers/media/i2c/tw9906.c                         |    3 +-
 drivers/media/i2c/tw9910.c                         |    4 +-
 drivers/media/i2c/uda1342.c                        |    3 +-
 drivers/media/i2c/upd64031a.c                      |    3 +-
 drivers/media/i2c/upd64083.c                       |    3 +-
 drivers/media/i2c/video-i2c.c                      |    4 +-
 drivers/media/i2c/vp27smpx.c                       |    3 +-
 drivers/media/i2c/vpx3220.c                        |    4 +-
 drivers/media/i2c/vs6624.c                         |    3 +-
 drivers/media/i2c/wm8739.c                         |    3 +-
 drivers/media/i2c/wm8775.c                         |    3 +-
 drivers/media/radio/radio-tea5764.c                |    3 +-
 drivers/media/radio/saa7706h.c                     |    3 +-
 drivers/media/radio/si470x/radio-si470x-i2c.c      |    3 +-
 drivers/media/radio/si4713/si4713.c                |    4 +-
 drivers/media/radio/tef6862.c                      |    3 +-
 drivers/media/test-drivers/vidtv/vidtv_demod.c     |    4 +-
 drivers/media/test-drivers/vidtv/vidtv_tuner.c     |    4 +-
 drivers/media/tuners/e4000.c                       |    4 +-
 drivers/media/tuners/fc2580.c                      |    3 +-
 drivers/media/tuners/m88rs6000t.c                  |    4 +-
 drivers/media/tuners/mt2060.c                      |    4 +-
 drivers/media/tuners/mxl301rf.c                    |    3 +-
 drivers/media/tuners/qm1d1b0004.c                  |    3 +-
 drivers/media/tuners/qm1d1c0042.c                  |    3 +-
 drivers/media/tuners/si2157.c                      |    4 +-
 drivers/media/tuners/tda18212.c                    |    4 +-
 drivers/media/tuners/tda18250.c                    |    4 +-
 drivers/media/tuners/tua9001.c                     |    3 +-
 drivers/media/usb/go7007/s2250-board.c             |    3 +-
 drivers/media/v4l2-core/tuner-core.c               |    3 +-
 drivers/mfd/88pm800.c                              |    4 +-
 drivers/mfd/88pm805.c                              |    4 +-
 drivers/mfd/88pm860x-core.c                        |    3 +-
 drivers/mfd/acer-ec-a500.c                         |    4 +-
 drivers/mfd/arizona-i2c.c                          |    4 +-
 drivers/mfd/axp20x-i2c.c                           |    4 +-
 drivers/mfd/da903x.c                               |    3 +-
 drivers/mfd/da9052-i2c.c                           |    3 +-
 drivers/mfd/da9055-i2c.c                           |    4 +-
 drivers/mfd/da9062-core.c                          |    4 +-
 drivers/mfd/da9150-core.c                          |    4 +-
 drivers/mfd/dm355evm_msp.c                         |    3 +-
 drivers/mfd/ene-kb3930.c                           |    4 +-
 drivers/mfd/gateworks-gsc.c                        |    4 +-
 drivers/mfd/intel_soc_pmic_core.c                  |    4 +-
 drivers/mfd/iqs62x.c                               |    4 +-
 drivers/mfd/lm3533-core.c                          |    4 +-
 drivers/mfd/lp8788.c                               |    3 +-
 drivers/mfd/madera-i2c.c                           |    4 +-
 drivers/mfd/max14577.c                             |    4 +-
 drivers/mfd/max77693.c                             |    4 +-
 drivers/mfd/max8907.c                              |    4 +-
 drivers/mfd/max8925-i2c.c                          |    3 +-
 drivers/mfd/mc13xxx-i2c.c                          |    3 +-
 drivers/mfd/menelaus.c                             |    3 +-
 drivers/mfd/ntxec.c                                |    4 +-
 drivers/mfd/palmas.c                               |    4 +-
 drivers/mfd/pcf50633-core.c                        |    4 +-
 drivers/mfd/retu-mfd.c                             |    4 +-
 drivers/mfd/rk808.c                                |    4 +-
 drivers/mfd/rn5t618.c                              |    4 +-
 drivers/mfd/rsmu_i2c.c                             |    4 +-
 drivers/mfd/rt4831.c                               |    4 +-
 drivers/mfd/si476x-i2c.c                           |    4 +-
 drivers/mfd/stmfx.c                                |    4 +-
 drivers/mfd/stmpe-i2c.c                            |    4 +-
 drivers/mfd/tc3589x.c                              |    4 +-
 drivers/mfd/tps6105x.c                             |    4 +-
 drivers/mfd/tps65010.c                             |    3 +-
 drivers/mfd/tps65086.c                             |    4 +-
 drivers/mfd/tps65217.c                             |    4 +-
 drivers/mfd/tps6586x.c                             |    3 +-
 drivers/mfd/tps65912-i2c.c                         |    4 +-
 drivers/mfd/twl-core.c                             |    3 +-
 drivers/mfd/twl6040.c                              |    4 +-
 drivers/mfd/wm8994-core.c                          |    4 +-
 drivers/misc/ad525x_dpot-i2c.c                     |    3 +-
 drivers/misc/apds9802als.c                         |    3 +-
 drivers/misc/apds990x.c                            |    3 +-
 drivers/misc/bh1770glc.c                           |    4 +-
 drivers/misc/ds1682.c                              |    3 +-
 drivers/misc/eeprom/at24.c                         |    4 +-
 drivers/misc/eeprom/ee1004.c                       |    4 +-
 drivers/misc/eeprom/eeprom.c                       |    4 +-
 drivers/misc/eeprom/idt_89hpesx.c                  |    4 +-
 drivers/misc/eeprom/max6875.c                      |    4 +-
 drivers/misc/hmc6352.c                             |    3 +-
 drivers/misc/ics932s401.c                          |    5 +-
 drivers/misc/isl29003.c                            |    3 +-
 drivers/misc/isl29020.c                            |    3 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c             |    3 +-
 drivers/misc/tsl2550.c                             |    4 +-
 drivers/mtd/maps/pismo.c                           |    4 +-
 drivers/net/dsa/lan9303_i2c.c                      |    6 +-
 drivers/net/dsa/microchip/ksz9477_i2c.c            |    4 +-
 drivers/net/dsa/xrs700x/xrs700x_i2c.c              |    6 +-
 drivers/net/ethernet/mellanox/mlxsw/i2c.c          |    4 +-
 drivers/net/mctp/mctp-i2c.c                        |    4 +-
 drivers/nfc/fdp/i2c.c                              |    4 +-
 drivers/nfc/microread/i2c.c                        |    4 +-
 drivers/nfc/nfcmrvl/i2c.c                          |    4 +-
 drivers/nfc/nxp-nci/i2c.c                          |    4 +-
 drivers/nfc/pn533/i2c.c                            |    4 +-
 drivers/nfc/pn544/i2c.c                            |    4 +-
 drivers/nfc/s3fwrn5/i2c.c                          |    4 +-
 drivers/nfc/st-nci/i2c.c                           |    4 +-
 drivers/nfc/st21nfca/i2c.c                         |    4 +-
 drivers/of/unittest.c                              |    6 +-
 drivers/pinctrl/Kconfig                            |   37 +-
 drivers/pinctrl/Makefile                           |    3 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed.c            |   11 +-
 drivers/pinctrl/bcm/pinctrl-bcm6318.c              |  121 +-
 drivers/pinctrl/bcm/pinctrl-bcm63268.c             |  139 +-
 drivers/pinctrl/bcm/pinctrl-bcm6328.c              |   91 +-
 drivers/pinctrl/bcm/pinctrl-bcm6358.c              |   20 +-
 drivers/pinctrl/bcm/pinctrl-bcm6362.c              |  121 +-
 drivers/pinctrl/bcm/pinctrl-bcm6368.c              |   91 +-
 drivers/pinctrl/bcm/pinctrl-bcm63xx.h              |    2 +
 drivers/pinctrl/bcm/pinctrl-ns.c                   |    4 +-
 drivers/pinctrl/berlin/berlin.c                    |    2 +-
 drivers/pinctrl/freescale/Kconfig                  |   12 +-
 drivers/pinctrl/mediatek/Kconfig                   |   12 +
 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8188.c          | 1673 +++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8188.h      | 2259 ++++++++++++++++=
++++
 drivers/pinctrl/meson/pinctrl-meson.c              |    7 +-
 drivers/pinctrl/meson/pinctrl-meson.h              |    4 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        |   26 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c   |  295 ++-
 drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c  |   29 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |  117 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.h          |   30 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |    8 +-
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c          |    5 +-
 drivers/pinctrl/pinctrl-amd.c                      |   32 +-
 drivers/pinctrl/pinctrl-at91.c                     |  105 +-
 drivers/pinctrl/pinctrl-cy8c95x0.c                 | 1419 ++++++++++++
 drivers/pinctrl/pinctrl-ingenic.c                  |   31 +-
 drivers/pinctrl/pinctrl-mcp23s08.c                 |    3 -
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |    5 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |    2 +
 drivers/pinctrl/pinctrl-pistachio.c                |   27 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |  346 ++-
 drivers/pinctrl/pinctrl-rockchip.h                 |    1 +
 drivers/pinctrl/pinctrl-st.c                       |   34 +-
 drivers/pinctrl/qcom/Kconfig                       |   57 +
 drivers/pinctrl/qcom/Makefile                      |    2 +
 drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c  |  207 ++
 drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c    |  240 +++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |   79 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          |    8 +-
 drivers/pinctrl/starfive/Kconfig                   |   18 +
 drivers/pinctrl/starfive/Makefile                  |    3 +
 .../pinctrl-starfive-jh7100.c}                     |   10 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |    5 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c          |    9 +-
 drivers/platform/chrome/cros_ec_i2c.c              |    4 +-
 drivers/platform/surface/surface3_power.c          |    4 +-
 drivers/platform/x86/asus-tf103c-dock.c            |    4 +-
 drivers/platform/x86/intel/int3472/tps68470.c      |    4 +-
 drivers/power/supply/bq2415x_charger.c             |    4 +-
 drivers/power/supply/bq24190_charger.c             |    4 +-
 drivers/power/supply/bq24257_charger.c             |    4 +-
 drivers/power/supply/bq25890_charger.c             |    4 +-
 drivers/power/supply/bq27xxx_battery_i2c.c         |    4 +-
 drivers/power/supply/cw2015_battery.c              |    3 +-
 drivers/power/supply/ds2782_battery.c              |    4 +-
 drivers/power/supply/lp8727_charger.c              |    3 +-
 drivers/power/supply/rt5033_battery.c              |    4 +-
 drivers/power/supply/rt9455_charger.c              |    4 +-
 drivers/power/supply/smb347-charger.c              |    4 +-
 drivers/power/supply/z2_battery.c                  |    4 +-
 drivers/pwm/pwm-pca9685.c                          |    4 +-
 drivers/regulator/da9121-regulator.c               |    3 +-
 drivers/regulator/lp8755.c                         |    4 +-
 drivers/regulator/rpi-panel-attiny-regulator.c     |    4 +-
 drivers/rtc/rtc-bq32k.c                            |    4 +-
 drivers/rtc/rtc-ds1374.c                           |    4 +-
 drivers/rtc/rtc-isl12026.c                         |    3 +-
 drivers/rtc/rtc-m41t80.c                           |    4 +-
 drivers/rtc/rtc-rs5c372.c                          |    3 +-
 drivers/rtc/rtc-x1205.c                            |    3 +-
 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c |    4 +-
 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c |    4 +-
 drivers/staging/media/atomisp/i2c/atomisp-lm3554.c |    4 +-
 .../staging/media/atomisp/i2c/atomisp-mt9m114.c    |    3 +-
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c |    4 +-
 drivers/staging/media/atomisp/i2c/atomisp-ov2722.c |    4 +-
 .../media/atomisp/i2c/ov5693/atomisp-ov5693.c      |    4 +-
 drivers/staging/media/max96712/max96712.c          |    4 +-
 drivers/staging/most/i2c/i2c.c                     |    4 +-
 drivers/staging/olpc_dcon/olpc_dcon.c              |    4 +-
 drivers/tty/serial/max310x.c                       |    4 +-
 drivers/tty/serial/sc16is7xx.c                     |    4 +-
 drivers/usb/misc/usb3503.c                         |    4 +-
 drivers/usb/phy/phy-isp1301-omap.c                 |    4 +-
 drivers/usb/phy/phy-isp1301.c                      |    4 +-
 drivers/usb/typec/anx7411.c                        |    4 +-
 drivers/usb/typec/hd3ss3220.c                      |    4 +-
 drivers/usb/typec/mux/fsa4480.c                    |    4 +-
 drivers/usb/typec/mux/pi3usb30532.c                |    3 +-
 drivers/usb/typec/rt1719.c                         |    4 +-
 drivers/usb/typec/stusb160x.c                      |    4 +-
 drivers/usb/typec/tcpm/fusb302.c                   |    4 +-
 drivers/usb/typec/tcpm/tcpci.c                     |    4 +-
 drivers/usb/typec/tcpm/tcpci_maxim.c               |    4 +-
 drivers/usb/typec/tcpm/tcpci_rt1711h.c             |    3 +-
 drivers/usb/typec/tipd/core.c                      |    4 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |    4 +-
 drivers/usb/typec/ucsi/ucsi_stm32g0.c              |    4 +-
 drivers/usb/typec/wusb3801.c                       |    4 +-
 drivers/video/backlight/adp8860_bl.c               |    4 +-
 drivers/video/backlight/adp8870_bl.c               |    4 +-
 drivers/video/backlight/arcxcnn_bl.c               |    4 +-
 drivers/video/backlight/bd6107.c                   |    4 +-
 drivers/video/backlight/lm3630a_bl.c               |    3 +-
 drivers/video/backlight/lm3639_bl.c                |    3 +-
 drivers/video/backlight/lp855x_bl.c                |    4 +-
 drivers/video/backlight/lv5207lp.c                 |    4 +-
 drivers/video/backlight/tosa_bl.c                  |    3 +-
 drivers/video/fbdev/matrox/matroxfb_maven.c        |    3 +-
 drivers/video/fbdev/ssd1307fb.c                    |    4 +-
 drivers/w1/masters/ds2482.c                        |    3 +-
 drivers/watchdog/ziirave_wdt.c                     |    4 +-
 .../dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h  | 1280 +++++++++++
 ...inctrl-starfive.h =3D> pinctrl-starfive-jh7100.h} |    6 +-
 include/dt-bindings/pinctrl/samsung.h              |    7 +
 include/linux/i2c.h                                |    2 +-
 include/linux/platform_data/pca953x.h              |    2 +-
 include/soc/at91/pm.h                              |   16 -
 sound/aoa/codecs/onyx.c                            |    3 +-
 sound/aoa/codecs/tas.c                             |    3 +-
 sound/pci/hda/cs35l41_hda_i2c.c                    |    4 +-
 sound/ppc/keywest.c                                |    6 +-
 sound/soc/codecs/adau1761-i2c.c                    |    3 +-
 sound/soc/codecs/adau1781-i2c.c                    |    3 +-
 sound/soc/codecs/ak4375.c                          |    4 +-
 sound/soc/codecs/ak4458.c                          |    4 +-
 sound/soc/codecs/ak4641.c                          |    4 +-
 sound/soc/codecs/ak5558.c                          |    4 +-
 sound/soc/codecs/cs35l32.c                         |    4 +-
 sound/soc/codecs/cs35l33.c                         |    4 +-
 sound/soc/codecs/cs35l34.c                         |    4 +-
 sound/soc/codecs/cs35l35.c                         |    4 +-
 sound/soc/codecs/cs35l36.c                         |    4 +-
 sound/soc/codecs/cs35l41-i2c.c                     |    4 +-
 sound/soc/codecs/cs35l45-i2c.c                     |    4 +-
 sound/soc/codecs/cs4234.c                          |    4 +-
 sound/soc/codecs/cs4265.c                          |    4 +-
 sound/soc/codecs/cs4270.c                          |    4 +-
 sound/soc/codecs/cs42l42.c                         |    4 +-
 sound/soc/codecs/cs42l51-i2c.c                     |    4 +-
 sound/soc/codecs/cs42l56.c                         |    3 +-
 sound/soc/codecs/cs42xx8-i2c.c                     |    4 +-
 sound/soc/codecs/cs43130.c                         |    4 +-
 sound/soc/codecs/cs4349.c                          |    4 +-
 sound/soc/codecs/cs53l30.c                         |    4 +-
 sound/soc/codecs/cx2072x.c                         |    3 +-
 sound/soc/codecs/max98090.c                        |    4 +-
 sound/soc/codecs/max9860.c                         |    3 +-
 sound/soc/codecs/max98927.c                        |    4 +-
 sound/soc/codecs/mt6660.c                          |    3 +-
 sound/soc/codecs/nau8825.c                         |    6 +-
 sound/soc/codecs/pcm1789-i2c.c                     |    4 +-
 sound/soc/codecs/pcm3168a-i2c.c                    |    4 +-
 sound/soc/codecs/pcm512x-i2c.c                     |    3 +-
 sound/soc/codecs/rt274.c                           |    4 +-
 sound/soc/codecs/rt286.c                           |    4 +-
 sound/soc/codecs/rt298.c                           |    4 +-
 sound/soc/codecs/rt5616.c                          |    6 +-
 sound/soc/codecs/rt5631.c                          |    6 +-
 sound/soc/codecs/rt5645.c                          |    4 +-
 sound/soc/codecs/rt5663.c                          |    4 +-
 sound/soc/codecs/rt5670.c                          |    4 +-
 sound/soc/codecs/rt5677.c                          |    4 +-
 sound/soc/codecs/rt5682-i2c.c                      |    4 +-
 sound/soc/codecs/rt5682s.c                         |    4 +-
 sound/soc/codecs/rt9120.c                          |    3 +-
 sound/soc/codecs/sgtl5000.c                        |    4 +-
 sound/soc/codecs/sta350.c                          |    6 +-
 sound/soc/codecs/tas2552.c                         |    3 +-
 sound/soc/codecs/tas5086.c                         |    6 +-
 sound/soc/codecs/tas571x.c                         |    4 +-
 sound/soc/codecs/tas5805m.c                        |    3 +-
 sound/soc/codecs/tas6424.c                         |    4 +-
 sound/soc/codecs/tlv320adc3xxx.c                   |    3 +-
 sound/soc/codecs/tlv320aic32x4-i2c.c               |    4 +-
 sound/soc/codecs/tlv320aic3x-i2c.c                 |    4 +-
 sound/soc/codecs/tlv320dac33.c                     |    4 +-
 sound/soc/codecs/wm1250-ev1.c                      |    4 +-
 sound/soc/codecs/wm2200.c                          |    4 +-
 sound/soc/codecs/wm5100.c                          |    4 +-
 sound/soc/codecs/wm8804-i2c.c                      |    3 +-
 sound/soc/codecs/wm8900.c                          |    6 +-
 sound/soc/codecs/wm8903.c                          |    4 +-
 sound/soc/codecs/wm8960.c                          |    6 +-
 sound/soc/codecs/wm8962.c                          |    3 +-
 sound/soc/codecs/wm8993.c                          |    4 +-
 sound/soc/codecs/wm8996.c                          |    4 +-
 sound/soc/codecs/wm9081.c                          |    6 +-
 712 files changed, 10117 insertions(+), 2921 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.y=
aml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yam=
l
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8188.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8188.h
 create mode 100644 drivers/pinctrl/pinctrl-cy8c95x0.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c
 create mode 100644 drivers/pinctrl/starfive/Kconfig
 create mode 100644 drivers/pinctrl/starfive/Makefile
 rename drivers/pinctrl/{pinctrl-starfive.c =3D>
starfive/pinctrl-starfive-jh7100.c} (99%)
 create mode 100644 include/dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h
 rename include/dt-bindings/pinctrl/{pinctrl-starfive.h =3D>
pinctrl-starfive-jh7100.h} (98%)
 delete mode 100644 include/soc/at91/pm.h
