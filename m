Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C5B6F6913
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjEDK3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEDK3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:29:15 -0400
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AB8E49E3;
        Thu,  4 May 2023 03:29:12 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 667D7409F8; Thu,  4 May 2023 10:34:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 667D7409F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1683189262;
        bh=7zvKsdkiKpXD/6DxlLJuYjcIVF1essDTgeioRSNH75c=;
        h=Date:From:To:Cc:Subject:From;
        b=DRYuxkDBeaIEB5EKxZ90/Gv9KUxKU5jE5CP6pat3ZvOqizObfV7m56Q58zL1tA9eB
         YAOM2Hz54o0jnmM0mDJ0YpMdke3rg5Ro/SJ/Y8YvvrS3kLRPoEE6caRtGroUOKAXOR
         ChY3QNiZoSi3r1qSvVbBiKGQeuxQQly8UbyW9GrY=
Date:   Thu, 4 May 2023 10:34:22 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Gregory Oakes <gregory.oakes@amd.com>,
        Jakob Koschel <jkl820.git@gmail.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Om Parikh <hack3r-0m@proton.me>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Tom Rix <trix@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wang Wensheng <wangwensheng4@huawei.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [GIT PULL REQUEST] watchdog - v6.4 release cycle.
Message-ID: <20230504083422.GA2308@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull following watchdog changes for the v6.4 release cycle.

This series contains:
* Add watchdog driver for StarFive JH7100 and JH7110 Soc
* Add Rockchip RK3588 devices
* Add Qualcom IPQ5332 APSS, QCM2290 KPSS and SM6115 SoC devices
* Add Mediatke MT8365 and MT6735 devices
* Watchdog-core: Always set WDOG_HW_RUNNING when starting watchdog
* Convert watchdog platform drivers to return void on the remove callback
* Convert to devm_clk_get_enabled() helpers
* And other small fixes and improvements

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.4-rc1

for you to fetch changes up to 10f67d1fd275528e62109de2ece26371833638e5:

  watchdog: dw_wdt: Simplify clk management (2023-04-29 08:08:41 +0200)

----------------------------------------------------------------
linux-watchdog 6.4-rc1 tag

----------------------------------------------------------------
Alexandre Mergnat (1):
      dt-bindings: watchdog: mediatek,mtk-wdt: add mt8365

Bhupesh Sharma (1):
      dt-bindings: watchdog: Document Qualcomm SM6115 watchdog

Christophe JAILLET (4):
      watchdog: ixp4xx: Use devm_clk_get_enabled() helper
      watchdog: loongson1: Use devm_clk_get_enabled() helper
      watchdog: dw_wdt: Fix the error handling path of dw_wdt_drv_probe()
      watchdog: dw_wdt: Simplify clk management

Gregory Oakes (1):
      watchdog: sp5100_tco: Immediately trigger upon starting.

Guenter Roeck (4):
      watchdog: imx2_wdg: Declare local symbols static
      watchdog: core: Always set WDOG_HW_RUNNING when starting watchdog
      watchdog: s3c2410_wdt: Use devm_clk_get[_optional]_enabled() helpers
      watchdog: s3c2410_wdt: Use devm_add_action_or_reset() to disable watchdog

Jakob Koschel (1):
      watchdog: avoid usage of iterator after loop

Johannes Thumshirn (2):
      watchdog: menz069_wdt: fix watchdog initialisation
      watchdog: menz069_wdt: fix timeout setting

Kathiravan T (1):
      dt-bindings: watchdog: qcom-wdt: add qcom,apss-wdt-ipq5332 compatible

Keguang Zhang (1):
      watchdog: loongson1_wdt: Implement restart handler

Konrad Dybcio (1):
      dt-bindings: watchdog: qcom-wdt: add QCM2290

Krzysztof Kozlowski (7):
      watchdog: aspeed: Drop of_match_ptr for ID table
      dt-bindings: watchdog: indentation, quotes and white-space cleanup
      dt-bindings: watchdog: drop duplicated GPIO watchdog bindings
      dt-bindings: watchdog: arm,sp805: drop unneeded minItems
      dt-bindings: watchdog: fsl-imx7ulp-wdt: simplify with unevaluatedProperties
      dt-bindings: watchdog: toshiba,visconti-wdt: simplify with unevaluatedProperties
      dt-bindings: watchdog: realtek,otto-wdt: simplify requiring interrupt-names

Om Parikh (1):
      dt-bindings: watchdog: alphascale-asm9260: convert to DT schema

Sergio Paracuellos (3):
      watchdog: rt2880-wdt: avoid static global declarations
      watchdog: rt2880-wdt: prefer unsigned int over unsigned
      dt-bindings: watchdog: migrate rt2880 text bindings to YAML

Shreeya Patel (1):
      dt-bindings: watchdog: rockchip: Add rockchip,rk3588-wdt string

Srinivas Neeli (1):
      MAINTAINERS: Add fragment for Xilinx watchdog driver

Tom Rix (1):
      watchdog: s3c2410: remove unused freq_to_wdt and s3c2410wdt_is_running functions

Uwe Kleine-König (34):
      watchdog: acquirewdt: Convert to platform remove callback returning void
      watchdog: advantechwdt: Convert to platform remove callback returning void
      watchdog: ar7: Convert to platform remove callback returning void
      watchdog: at91rm9200: Convert to platform remove callback returning void
      watchdog: ath79: Convert to platform remove callback returning void
      watchdog: bcm2835: Convert to platform remove callback returning void
      watchdog: bcm_kona: Convert to platform remove callback returning void
      watchdog: cpwd: Convert to platform remove callback returning void
      watchdog: dw: Convert to platform remove callback returning void
      watchdog: gef: Convert to platform remove callback returning void
      watchdog: geodewdt: Convert to platform remove callback returning void
      watchdog: ib700wdt: Convert to platform remove callback returning void
      watchdog: ie6xx: Convert to platform remove callback returning void
      watchdog: lpc18xx: Convert to platform remove callback returning void
      watchdog: mtx-1: Convert to platform remove callback returning void
      watchdog: nic7018: Convert to platform remove callback returning void
      watchdog: nv_tco: Convert to platform remove callback returning void
      watchdog: omap: Convert to platform remove callback returning void
      watchdog: orion: Convert to platform remove callback returning void
      watchdog: rc32434: Convert to platform remove callback returning void
      watchdog: rdc321x: Convert to platform remove callback returning void
      watchdog: renesas: Convert to platform remove callback returning void
      watchdog: riowd: Convert to platform remove callback returning void
      watchdog: rti: Convert to platform remove callback returning void
      watchdog: sa1100: Convert to platform remove callback returning void
      watchdog: sch311x: Convert to platform remove callback returning void
      watchdog: shwdt: Convert to platform remove callback returning void
      watchdog: st_lpc: Convert to platform remove callback returning void
      watchdog: stmp3xxx_rtc: Convert to platform remove callback returning void
      watchdog: bcm47xx: Simplify using devm_watchdog_register_device()
      watchdog: rn5t618: Simplify using devm_watchdog_register_device()
      watchdog: wm8350: Simplify using devm_watchdog_register_device()
      watchdog: s3c2410: Make s3c2410_get_wdt_drv_data() return an int
      watchdog: s3c2410_wdt: Simplify using dev_err_probe()

Wang Wensheng (1):
      watchdog: sbsa: Test WDOG_HW_RUNNING bit in suspend and resume

William Breathitt Gray (1):
      watchdog: ebc-c384_wdt: Mark status as orphaned

Xingyu Wu (4):
      dt-bindings: watchdog: Add watchdog for StarFive JH7100 and JH7110
      drivers: watchdog: Add StarFive Watchdog driver
      watchdog: starfive: Fix the probe return error if PM and early_enable are both disabled
      watchdog: starfive: Fix the warning of starfive_wdt_match

Yassine Oudjana (1):
      dt-bindings: reset: Add binding for MediaTek MT6735 TOPRGU/WDT

 .../bindings/watchdog/alphascale,asm9260-wdt.yaml  |  70 +++
 .../bindings/watchdog/alphascale-asm9260.txt       |  35 --
 .../bindings/watchdog/amlogic,meson-gxbb-wdt.yaml  |  10 +-
 .../bindings/watchdog/arm,sbsa-gwdt.yaml           |   1 -
 .../devicetree/bindings/watchdog/arm,sp805.yaml    |   1 -
 .../devicetree/bindings/watchdog/arm,twd-wdt.yaml  |   6 +-
 .../devicetree/bindings/watchdog/arm-smc-wdt.yaml  |   7 +-
 .../bindings/watchdog/atmel,sama5d4-wdt.yaml       |  14 +-
 .../bindings/watchdog/brcm,bcm7038-wdt.yaml        |   6 +-
 .../bindings/watchdog/faraday,ftwdt010.yaml        |  16 +-
 .../bindings/watchdog/fsl-imx7ulp-wdt.yaml         |   4 +-
 .../devicetree/bindings/watchdog/gpio-wdt.yaml     |  55 --
 .../bindings/watchdog/linux,wdt-gpio.yaml          |  17 +-
 .../bindings/watchdog/mediatek,mt7621-wdt.yaml     |   6 +-
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |   2 +
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |  36 +-
 .../bindings/watchdog/ralink,rt2880-wdt.yaml       |  46 ++
 .../bindings/watchdog/realtek,otto-wdt.yaml        |   4 +-
 .../devicetree/bindings/watchdog/renesas,wdt.yaml  |  14 +-
 .../devicetree/bindings/watchdog/rt2880-wdt.txt    |  18 -
 .../devicetree/bindings/watchdog/snps,dw-wdt.yaml  |  33 +-
 .../bindings/watchdog/st,stm32-iwdg.yaml           |  10 +-
 .../bindings/watchdog/starfive,jh7100-wdt.yaml     |  71 +++
 .../bindings/watchdog/toshiba,visconti-wdt.yaml    |   4 +-
 .../bindings/watchdog/xlnx,xps-timebase-wdt.yaml   |  12 +-
 MAINTAINERS                                        |  18 +-
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   3 +
 drivers/watchdog/acquirewdt.c                      |   6 +-
 drivers/watchdog/advantechwdt.c                    |   6 +-
 drivers/watchdog/ar7_wdt.c                         |   5 +-
 drivers/watchdog/aspeed_wdt.c                      |   2 +-
 drivers/watchdog/at91rm9200_wdt.c                  |   6 +-
 drivers/watchdog/ath79_wdt.c                       |   5 +-
 drivers/watchdog/bcm2835_wdt.c                     |   6 +-
 drivers/watchdog/bcm47xx_wdt.c                     |  12 +-
 drivers/watchdog/bcm_kona_wdt.c                    |   6 +-
 drivers/watchdog/cpwd.c                            |   6 +-
 drivers/watchdog/dw_wdt.c                          |  55 +-
 drivers/watchdog/gef_wdt.c                         |   6 +-
 drivers/watchdog/geodewdt.c                        |   5 +-
 drivers/watchdog/ib700wdt.c                        |   5 +-
 drivers/watchdog/ie6xx_wdt.c                       |   6 +-
 drivers/watchdog/imx2_wdt.c                        |   4 +-
 drivers/watchdog/ixp4xx_wdt.c                      |  18 +-
 drivers/watchdog/loongson1_wdt.c                   |  36 +-
 drivers/watchdog/lpc18xx_wdt.c                     |   6 +-
 drivers/watchdog/menz69_wdt.c                      |  18 +-
 drivers/watchdog/mtx-1_wdt.c                       |   5 +-
 drivers/watchdog/nic7018_wdt.c                     |   6 +-
 drivers/watchdog/nv_tco.c                          |   6 +-
 drivers/watchdog/omap_wdt.c                        |   6 +-
 drivers/watchdog/orion_wdt.c                       |   5 +-
 drivers/watchdog/rc32434_wdt.c                     |   5 +-
 drivers/watchdog/rdc321x_wdt.c                     |   6 +-
 drivers/watchdog/renesas_wdt.c                     |   6 +-
 drivers/watchdog/riowd.c                           |   6 +-
 drivers/watchdog/rn5t618_wdt.c                     |  12 +-
 drivers/watchdog/rt2880_wdt.c                      |  89 +--
 drivers/watchdog/rti_wdt.c                         |   6 +-
 drivers/watchdog/s3c2410_wdt.c                     | 132 ++---
 drivers/watchdog/sa1100_wdt.c                      |   6 +-
 drivers/watchdog/sbsa_gwdt.c                       |   4 +-
 drivers/watchdog/sch311x_wdt.c                     |   5 +-
 drivers/watchdog/shwdt.c                           |   6 +-
 drivers/watchdog/sp5100_tco.c                      |   4 +
 drivers/watchdog/st_lpc_wdt.c                      |   6 +-
 drivers/watchdog/starfive-wdt.c                    | 606 +++++++++++++++++++++
 drivers/watchdog/stmp3xxx_rtc_wdt.c                |   5 +-
 drivers/watchdog/watchdog_core.c                   |   2 +-
 drivers/watchdog/watchdog_dev.c                    |   3 +-
 drivers/watchdog/watchdog_pretimeout.c             |   3 +-
 drivers/watchdog/wm8350_wdt.c                      |   9 +-
 include/dt-bindings/reset/mediatek,mt6735-wdt.h    |  17 +
 74 files changed, 1155 insertions(+), 560 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/gpio-wdt.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/ralink,rt2880-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/rt2880-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
 create mode 100644 drivers/watchdog/starfive-wdt.c
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-wdt.h
----------------------------------------------------------------

Kind regards,
Wim.

