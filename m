Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB7B6A8869
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCBSRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBSRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:17:00 -0500
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51CB741B4B;
        Thu,  2 Mar 2023 10:16:57 -0800 (PST)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 3752740A03; Thu,  2 Mar 2023 17:25:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 3752740A03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1677774337;
        bh=HPEYhkQ7rJm1C5Sj//VfLmecOW3zTfkuHUrB7rR0Rak=;
        h=Date:From:To:Cc:Subject:From;
        b=mV1nSQOIg2ynjJ2qbNLouBElxf3pNW5LT+jv3Tm3f7WGq/fbDTsVKJ+lL9z2qkEsB
         +NxGpnvLC8hIHIjQLJ2McGoRtY1ebaM4Isl5HpilqZ/BgMBE8uySwfAH3Y4vLGxKlC
         Kag4A0Xd/9yAX7/7rCAjYCWatQ6kKGTyLfMYH17w=
Date:   Thu, 2 Mar 2023 17:25:37 +0100
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Andrej Picej <andrej.picej@norik.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Chen Jun <chenjun102@huawei.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        George Cherian <george.cherian@marvell.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Li Hua <hucool.lihua@huawei.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Primoz Fiser <primoz.fiser@norik.com>,
        Robert Marko <robert.marko@sartura.hr>,
        ruanjinjie <ruanjinjie@huawei.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [GIT PULL REQUEST] watchdog - v6.3 release cycle.
Message-ID: <20230302162537.GA3071@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull following watchdog changes for the v5.19 release cycle.

This series contains:
* qcom-wdt dt-bindings improvements and additions (like MSM8994 and MDM9615)
* mtk_wdt: Add reset_by_toprgu support
* devm_clk_get_enabled() helper changes
* Fix kmemleak in watchdog_cdev_register
* watchdog sysfs improvements
* Other fixes and small improvements

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit d2d11f342b179f1894a901f143ec7c008caba43e:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2023-02-05 17:17:10 -0800)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.3-rc1

for you to fetch changes up to cf3be7e82b129ed34f811f116f2b113f6299d449:

  watchdog: at91rm9200: Only warn once about problems in .remove() (2023-03-02 06:51:35 +0100)

----------------------------------------------------------------
linux-watchdog 6.3-rc1 tag

----------------------------------------------------------------
Allen-KH Cheng (2):
      dt-bindings: watchdog: mtk-wdt: Add reset-by-toprgu support
      watchdog: mtk_wdt: Add reset_by_toprgu support

Andrej Picej (2):
      watchdog: imx2_wdg: suspend watchdog in WAIT mode
      dt-bindings: watchdog: fsl-imx: document suspend in wait mode

Bartosz Golaszewski (1):
      dt-bindings: watchdog: qcom-wdt: add qcom,apss-wdt-sa8775p compatible

Chen Jun (1):
      watchdog: Fix kmemleak in watchdog_cdev_register

Christophe JAILLET (19):
      watchdog: realtek_otto: Use devm_clk_get_enabled() helper
      watchdog: pnx4008: Use devm_clk_get_enabled() helper
      watchdog: pic32-wdt: Use devm_clk_get_enabled() helper
      watchdog: pic32-dmt: Use devm_clk_get_enabled() helper
      watchdog: lpc18xx: Use devm_clk_get_enabled() helper
      watchdog: of_xilinx_wdt: Use devm_clk_get_enabled() helper
      watchdog: imgpdc: Use devm_clk_get_enabled() helper
      watchdog: cadence: Use devm_clk_get_enabled() helper
      watchdog: meson_gxbb: Use devm_clk_get_enabled() helper
      watchdog: davinci: Use devm_clk_get_enabled() helper
      watchdog: imx7ulp: Use devm_clk_get_enabled() helper
      watchdog: rtd119x: Use devm_clk_get_enabled() helper
      watchdog: bcm7038: Use devm_clk_get_enabled() helper
      watchdog: armada_37xx: Use devm_clk_get_enabled() helper
      watchdog: qcom: Use devm_clk_get_enabled() helper
      watchdog: rzn1: Use devm_clk_get_enabled() helper
      watchdog: visconti: Use devm_clk_get_enabled() helper
      watchdog: apple: Use devm_clk_get_enabled() helper
      watchdog: Include <linux/kstrtox.h> when appropriate

Cosmin Tanislav (1):
      watchdog: dw_wdt: stop on reboot

Fabrizio Castro (1):
      watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M

George Cherian (1):
      watchdog: sbsa_wdog: Make sure the timeout programming is within the limits

Konrad Dybcio (1):
      dt-bindings: watchdog: Add MSM8994 watchdog timer

Krzysztof Kozlowski (7):
      dt-bindings: watchdog: allow "timer" as node name
      dt-bindings: watchdog: qcom-wdt: require fallback for IPQ4019
      dt-bindings: watchdog: qcom-wdt: do not allow fallback alone
      dt-bindings: watchdog: qcom-wdt: fix list of MSM timer compatibles
      dt-bindings: watchdog: qcom-wdt: add qcom,kpss-wdt-mdm9615
      dt-bindings: watchdog: qcom-wdt: allow interrupts
      dt-bindings: watchdog: qcom-wdt: merge MSM timer

Lad Prabhakar (2):
      dt-bindings: watchdog: renesas,wdt: Document RZ/Five SoC
      watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks

Li Hua (1):
      watchdog: pcwd_usb: Fix attempting to access uninitialized memory

Neil Armstrong (1):
      dt-bindings: watchdog: convert meson-wdt.txt to dt-schema

Primoz Fiser (1):
      watchdog: da9062: da9063: use unlocked xfer function in restart

Robert Marko (1):
      dt-bindings: watchdog: Convert GPIO binding to json-schema

Sergio Paracuellos (3):
      dt-bindings: watchdog: mt7621-wdt: add phandle to access system controller registers
      watchdog: mt7621-wdt: avoid static global declarations
      watchdog: mt7621-wdt: avoid ralink architecture dependent code

Thomas Weißschuh (4):
      watchdog: wdat_wdt: Avoid unimplemented get_timeleft
      watchdog: iTCO_wdt: Report firmware_version
      watchdog: report fw_version in sysfs
      watchdog: report options in sysfs

Uwe Kleine-König (2):
      watchdog: ziirave_wdt: Convert to i2c's .probe_new()
      watchdog: at91rm9200: Only warn once about problems in .remove()

ruanjinjie (1):
      watchdog: at91sam9_wdt: use devm_request_irq to avoid missing free_irq() in error path

 Documentation/ABI/testing/sysfs-class-watchdog     |  13 +++
 .../devicetree/bindings/timer/qcom,msm-timer.txt   |  47 --------
 .../bindings/watchdog/amlogic,meson6-wdt.yaml      |  50 +++++++++
 .../devicetree/bindings/watchdog/fsl-imx-wdt.yaml  |  37 ++++++-
 .../devicetree/bindings/watchdog/gpio-wdt.yaml     |  55 ++++++++++
 .../bindings/watchdog/mediatek,mt7621-wdt.yaml     |   7 ++
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |   6 +
 .../devicetree/bindings/watchdog/meson-wdt.txt     |  21 ----
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |  96 ++++++++++++++--
 .../devicetree/bindings/watchdog/renesas,wdt.yaml  |   2 +-
 .../devicetree/bindings/watchdog/watchdog.yaml     |   7 +-
 drivers/watchdog/Kconfig                           |   4 +-
 drivers/watchdog/apple_wdt.c                       |  18 +--
 drivers/watchdog/armada_37xx_wdt.c                 |  15 +--
 drivers/watchdog/aspeed_wdt.c                      |   1 +
 drivers/watchdog/at91rm9200_wdt.c                  |   2 +-
 drivers/watchdog/at91sam9_wdt.c                    |   7 +-
 drivers/watchdog/bcm7038_wdt.c                     |  15 +--
 drivers/watchdog/cadence_wdt.c                     |  17 +--
 drivers/watchdog/da9062_wdt.c                      |  15 ++-
 drivers/watchdog/da9063_wdt.c                      |  15 ++-
 drivers/watchdog/davinci_wdt.c                     |  18 +--
 drivers/watchdog/dw_wdt.c                          |   1 +
 drivers/watchdog/iTCO_wdt.c                        |   4 +-
 drivers/watchdog/imgpdc_wdt.c                      |  31 +-----
 drivers/watchdog/imx2_wdt.c                        |  55 +++++++++-
 drivers/watchdog/imx7ulp_wdt.c                     |  15 +--
 drivers/watchdog/lpc18xx_wdt.c                     |  30 +----
 drivers/watchdog/meson_gxbb_wdt.c                  |  16 +--
 drivers/watchdog/mt7621_wdt.c                      | 122 ++++++++++++++-------
 drivers/watchdog/mtk_wdt.c                         |   7 ++
 drivers/watchdog/of_xilinx_wdt.c                   |  16 +--
 drivers/watchdog/pcwd_usb.c                        |   6 +-
 drivers/watchdog/pic32-dmt.c                       |  15 +--
 drivers/watchdog/pic32-wdt.c                       |  17 +--
 drivers/watchdog/pnx4008_wdt.c                     |  15 +--
 drivers/watchdog/qcom-wdt.c                        |  16 +--
 drivers/watchdog/realtek_otto_wdt.c                |  17 +--
 drivers/watchdog/rtd119x_wdt.c                     |  16 +--
 drivers/watchdog/rzg2l_wdt.c                       |  45 +++++++-
 drivers/watchdog/rzn1_wdt.c                        |  18 +--
 drivers/watchdog/sbsa_gwdt.c                       |   1 +
 drivers/watchdog/visconti_wdt.c                    |  17 +--
 drivers/watchdog/watchdog_dev.c                    |  23 +++-
 drivers/watchdog/wdat_wdt.c                        |   6 +-
 drivers/watchdog/ziirave_wdt.c                     |   5 +-
 46 files changed, 527 insertions(+), 455 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/amlogic,meson6-wdt.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/gpio-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt
----------------------------------------------------------------

Kind regards,
Wim.

