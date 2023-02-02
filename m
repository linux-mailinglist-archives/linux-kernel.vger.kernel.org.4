Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2351368834C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjBBPz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjBBPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:55:00 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306916600E;
        Thu,  2 Feb 2023 07:54:48 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.17]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LbtXm-1oyCOM3UY8-00jG5j;
 Thu, 02 Feb 2023 16:32:35 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-imx@nxp.com, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>, Chester Lin <clin@suse.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Ming Qian <ming.qian@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>
Subject: [PATCH v6 00/10] arm64: dts: freescale: prepare and add apalis imx8 support
Date:   Thu,  2 Feb 2023 16:32:10 +0100
Message-Id: <20230202153221.197308-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QCr3eIY/f7iKBMR6HQhCFrqkauKhZ2OoRkInQg+lILkTRx9xKun
 Z2Qs8A4NXh7AtncS8EXI3tZfJ3TXHvalktxIimGzh/YSAxxu1g7+RjOTqAphccnJtSyQCBm
 7FsXHVhVNutYHt0M91mz538e/RdGL2nwppqcZNv49/kAAZPUKCRYIFQyUuaVbNY/xYzAfNA
 QFVbFIOUd0t2hjIBF32Gw==
UI-OutboundReport: notjunk:1;M01:P0:fKPRPfOjn/o=;ZIYrqo6LlGWaJpwcDpYfCU/wC6j
 AlaYPLkY0lYPU+qfcOW+DBd7x44hdg+NCxJePLiljcjjagwR+dPwQClFdyNu9bVNB+2ggcy3h
 7gRkkXWBVrWUnXmxjd0cS+qusO4MZOQFK2OPEwRyrGSqUEU8Y53L1SJf+KmZoqIxwPdQUAfgv
 CIK0xX/J1sA+aB3dg697jA3Ur4sHyyW2KX0YS0HxT73NvAuPXcguS/v7OXLgQDDC91RHc6nnq
 x8GT+uV7B3OVGQh+4u/TV8/Ab3EqC+MOnUvWzl+BwYYnwzVXxPzDsT2L+86y9sxXqDdTuM5ch
 eKWg4O1XuMKHZQhZkM7L3NPPAsWE4xS5WNaMIAjJOZ0gJUYUdrWaIl/mtJN3yQJLdZSUp+hO8
 bXGsModVQ6ajRykOV5TvayGHXp5pwgTX+5kAh3ADxDnEp95Np0n7LJW63vGzx8eOIJV5bUC32
 gN7GXc92FS0xiXDuwbKJwXCdgL+vGCPV2dJfSBRuwRFPQ5kAkS401mdaKnMmJZhW75gCceBTm
 QwQ2DQGcHFu25CrtMUNMRtOKUxEMPGusl/Hqnd+/rvllxbbW3lu6j5yzK6eyaDs8iuUrVKiFy
 lD3pdgMFjhxXztfpWs8PLrJK0DTak0Em7CkXeikpzB1utVM+jNag8PhTC8qadVYKaEVnDZodr
 x+a0jVGU2azRCwkSFsiFyj40UvoXnr4YHaDjS14CDw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


Add support for lsio_pwm0-3, add io-channel-cells property for ADC
nodes, set lpspi0 max frequency to 60MHz, add missed LVDS lpi2c and PWM
power domains, add flexcan in adma, add can node in devicetree, add vpu
decoder and encoder, add toradex,apalis-imx8 et al. to dt-bindings and
finally, add initial support for Apalis iMX8 split into module and
carrier board parts.

Changes in v6:
- Add Alexander's acked-by. Thanks!
- Add Alexander's tested-by. Thanks!
- Incorporate Shawn's review feedback. Thanks!

Changes in v5:
- Update subject prefix as pointed out by Krzysztof. Thanks!
- Remove LVDS PWM support waiting for Liu's patches to land first.
- Remove bkl1_pwm functionality depending on the above.
- Squashing all Apalis iMX8 specific device tree patches. As outlined by
  Krzysztof reviewers may simply use b4 diff.

Changes in v4:
- New patch inspired by the following downstream patch:
  commit 0c36c5b63c1e ("LF-3569-1 firmware: imx: scu-pd: add missed lvds lpi2c and pwm power domains")
  Avoiding the following being reported upon boot:
  [    1.309776] lvds0_pwm0_clk: failed to attached the power domain -2
  [    1.334097] lvds1_pwm0_clk: failed to attached the power domain -2
  ...
  [   15.281767] platform 57244000.pwm: deferred probe pending
  ...
  [   15.292630] platform backlight: deferred probe pending
- New patch combining the following downstream patches:
  commit e8fe3f57223a ("arm64: dts: imx8qxp: add FlexCAN in adma")
  commit 4e90361f1ed3 ("arm64: dts: imx8qxp: add multi-pd support for CAN1/2")
  commit 899f516e61f8 ("arm64: dts: imx8: dma: fully switched to new clk binding")
  commit 8a28ca15a058 ("arm64: dts: imx8qxp: drop multi-pd for CAN device")
  commit c493402197dd ("arm64: dts: imx8: update CAN fsl,clk-source and fsl,scu-index property")
- New patch inspired by the following downstream patch:
  commit 117607e6a7b5 ("arm64: dts: imx8qm: add CAN node in devicetree")
- New patch combining the following downstream patches:
  commit 4f2147ce6f0e ("arm64: dts: imx8qm: add vpu decoder and encoder")
  commit 0c9f9b64d27d ("LF-6575: imx8q: vpu: switch to amphion upstream driver")
- Shorten subject.

Changes in v3:
- Fix subject as pointed out by Shawn. Thanks!
- Properly accommodate for -v1.1 modules curtsey Francesco.
- Only use V1.1 compatible for V1.1 module dtsi.
- Split patch into separate module and carrier boards parts as suggested
  by Shawn.
- Put reg after compatible as requested by Shawn.
- Move atmel_mxt_ts and rtc_i2c into module dtsi to save such
  duplications as suggested by Shawn.
- Change iomuxc pinctrl indent style as suggested by Shawn.
- Change led node names to the preferred first form as suggested by
  Shawn. While at it also add color (yikes), default-state and function
  properties and remove the deprecated label property.
- Put enable-active-high properties after the gpio ones as suggested by
  Shawn. Thanks!
- Remove adc node's vref-supply and accompanying reg_vref_1v8 regulator
  node.
- Rename gpio-hogs adherring to dt schema naming convention.

Changes in v2:
- Fixed missing space in the comment V1.1Module curtsey Max.
- Added Rob's ack.

Clark Wang (1):
  firmware: imx: scu-pd: add missed lvds lpi2c and pwm power domains

Joakim Zhang (2):
  arm64: dts: imx8qxp: add flexcan in adma
  arm64: dts: imx8qm: add can node in devicetree

Marcel Ziswiler (3):
  dt-bindings: arm: fsl: add toradex,apalis-imx8 et al.
  arm64: dts: freescale: add initial apalis imx8 aka quadmax module
    support
  arm64: dts: freescale: add apalis imx8 aka quadmax carrier board
    support

Max Krummenacher (1):
  arm64: dts: imx8-ss-dma: add io-channel-cells to adc nodes

Philippe Schenker (2):
  arm64: dts: freescale: imx8-ss-lsio: add support for lsio_pwm0-3
  arm64: dts: freescale: imx8-ss-dma: set lpspi0 max frequency to 60mhz

Zhou Peng (1):
  arm64: dts: imx8qm: add vpu decoder and encoder

 .../devicetree/bindings/arm/fsl.yaml          |   19 +
 arch/arm64/boot/dts/freescale/Makefile        |    5 +
 .../boot/dts/freescale/imx8-apalis-eval.dtsi  |  144 ++
 .../dts/freescale/imx8-apalis-ixora-v1.1.dtsi |  220 +++
 .../dts/freescale/imx8-apalis-ixora-v1.2.dtsi |  270 +++
 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  | 1484 +++++++++++++++++
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi |   76 +-
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      |   48 +
 .../boot/dts/freescale/imx8qm-apalis-eval.dts |   16 +
 .../freescale/imx8qm-apalis-ixora-v1.1.dts    |   16 +
 .../dts/freescale/imx8qm-apalis-v1.1-eval.dts |   16 +
 .../imx8qm-apalis-v1.1-ixora-v1.1.dts         |   16 +
 .../imx8qm-apalis-v1.1-ixora-v1.2.dts         |   16 +
 .../dts/freescale/imx8qm-apalis-v1.1.dtsi     |   16 +
 .../boot/dts/freescale/imx8qm-apalis.dtsi     |  340 ++++
 .../boot/dts/freescale/imx8qm-ss-dma.dtsi     |   44 +
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     |    4 +
 drivers/firmware/imx/scu-pd.c                 |    4 +
 18 files changed, 2753 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-eval.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-ixora-v1.1.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.1.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi

-- 
2.36.1

