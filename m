Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E41C5FC350
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJLJxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJLJxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:53:43 -0400
X-Greylist: delayed 900 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 02:53:41 PDT
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8278A927A;
        Wed, 12 Oct 2022 02:53:41 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id C282C40A1C; Wed, 12 Oct 2022 09:42:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org C282C40A1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1665560570;
        bh=3CL07NqiCoTUdPjP8GITxfi66uIGtJb4mARn+p4us6g=;
        h=Date:From:To:Cc:Subject:From;
        b=iv06WrZ7aWBmMpjkt0Ce4Jpw2IUFjkAmvhYyQIi4TeB00UPZPPQoXW8dsiSLbtlDl
         UDia+47NbDiu4tXdl239wYhWBtw9oJoIg8Rv1euh8m8OCqueWFTZILuUDbOK3W3LYs
         JGqpo7BJLmb9mTy2Ovwf1NOnIyBU8+E0ZieOATX0=
Date:   Wed, 12 Oct 2022 09:42:50 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alice Guo <alice.guo@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, Bo Liu <liubo03@inspur.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David =?iso-8859-1?Q?M=FCller?= <d.mueller@elsoft.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henning Schild <henning.schild@siemens.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Jean Delvare <jdelvare@suse.de>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Philippe Boos <pboos@baylibre.com>,
        Sergei Antonov <saproj@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Sergiu Moga <sergiu.moga@microchip.com>,
        shaomin Deng <dengshaomin@cdjrlc.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        sunliming <sunliming@kylinos.cn>,
        Thanh Quan <thanh.quan.xn@renesas.com>,
        Vladimir Panteleev <git@vladimir.panteleev.md>,
        Ye Li <ye.li@nxp.com>, ye xingchen <ye.xingchen@zte.com.cn>
Subject: [GIT PULL REQUEST] watchdog - v6.1 release cycle.
Message-ID: <20221012074250.GA19731@www.linux-watchdog.org>
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

Please pull following watchdog changes for the v6.1 release cycle.

This series contains:
* Add watchdog driver for Exar/MaxLinear XR28V38x
* Add support for exynosautov9 SoC
* Add support for Renesas R-Car V5H (R8A779G0) and RZ/V2M (r9a09g011) SoC
* Add support for imx93
* And several other fixes and improvements

(Note: the patch for "watchdog: Add tracing events for the most usual watchdog events" is something that I want to add before 6.1-rc2 if possible).

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.1-rc1

for you to fetch changes up to 099d387ebbcd70c6adc906ab5b66ef639c09dede:

  watchdog: twl4030_wdt: add missing mod_devicetable.h include (2022-10-07 11:03:25 +0200)

----------------------------------------------------------------
linux-watchdog 6.1-rc1 tag

----------------------------------------------------------------
Alice Guo (1):
      watchdog: imx93: add watchdog timer on imx93

Anson Huang (1):
      watchdog: imx7ulp: Move suspend/resume to noirq phase

Bo Liu (1):
      watchdog: Check dev_set_name() return value

Chanho Park (2):
      dt-bindings: watchdog: add exynosautov9 compatible
      watchdog: s3c2410_wdt: support exynosautov9 watchdog

Chin-Ting Kuo (1):
      watchdog: aspeed_wdt: Reorder output signal register configuration

Dan Carpenter (1):
      watchdog: ftwdt010_wdt: fix test for platform_get_irq() failure

David Müller (1):
      watchdog: Exar/MaxLinear XR28V38x driver

Dmitry Torokhov (2):
      watchdog: bd9576_wdt: switch to using devm_fwnode_gpiod_get()
      watchdog: twl4030_wdt: add missing mod_devicetable.h include

Henning Schild (1):
      watchdog: w83627hf_wdt: add bootstatus support

Jacky Bai (1):
      watchdog: imx7ulp: Add explict memory barrier for unlock sequence

Jason Liu (1):
      watchdog: imx7ulp_wdt: init wdog when it was active

Jason Wang (1):
      watchdog: w83977f_wdt: Fix comment typo

Jean Delvare (1):
      watchdog: wdat_wdt: Set the min and max timeout values properly

Jerry Hoemann (2):
      watchdog/hpwdt: Include nmi.h only if CONFIG_HPWDT_NMI_DECODING
      watchdog/hpwdt: Enable HP_WATCHDOG for ARM64 systems.

Johan Jonker (1):
      dt-bindings: watchdog: rockchip: add rockchip,rk3128-wdt

Jonathan Neuschäfer (1):
      watchdog: npcm: Enable clock if provided

Nobuhiro Iwamatsu (1):
      dt-bindings: watchdog: toshiba,visconti-wdt: Update the common clock properties

Pali Rohár (1):
      watchdog: armada_37xx_wdt: Fix .set_timeout callback

Phil Edworthy (2):
      dt-bindings: watchdog: renesas,wdt: Add r9a09g011 (RZ/V2M) support
      watchdog: rzg2l_wdt: Add rzv2m support

Philippe Boos (1):
      watchdog: meson: keep running if already active

Sergei Antonov (1):
      watchdog: ftwdt010_wdt: implement _restart() function

Sergio Paracuellos (1):
      dt-bindings: watchdog: migrate mt7621 text bindings to YAML

Sergiu Moga (1):
      watchdog: dt-bindings: atmel,at91sam9-wdt: convert to json-schema

Srinivas Neeli (1):
      dt-bindings: watchdog: Convert Xilinx watchdog bindings to json-schema

Thanh Quan (1):
      dt-bindings: watchdog: renesas-wdt: Add r8a779g0 support

Vladimir Panteleev (1):
      watchdog: sp5100_tco: Add "action" module parameter

Ye Li (3):
      watchdog: imx7ulp_wdt: Check CMD32EN in wdog init
      watchdog: imx7ulp_wdt: Fix RCS timeout issue
      watchdog: imx7ulp_wdt: Handle wdog reconfigure failure

shaomin Deng (1):
      watchdog: eurotechwdt: Remove redundant word in comments

sunliming (1):
      watchdog: sa1100: make variable sa1100dog_driver static

ye xingchen (1):
      watchdog: rti-wdt:using the pm_runtime_resume_and_get to simplify the code

 .../bindings/watchdog/atmel,at91sam9-wdt.yaml      | 127 ++++++
 .../devicetree/bindings/watchdog/atmel-wdt.txt     |  51 ---
 .../bindings/watchdog/mediatek,mt7621-wdt.yaml     |  33 ++
 .../devicetree/bindings/watchdog/mt7621-wdt.txt    |  12 -
 .../devicetree/bindings/watchdog/of-xilinx-wdt.txt |  26 --
 .../devicetree/bindings/watchdog/renesas,wdt.yaml  |  74 +++-
 .../devicetree/bindings/watchdog/samsung-wdt.yaml  |   3 +
 .../devicetree/bindings/watchdog/snps,dw-wdt.yaml  |   1 +
 .../bindings/watchdog/toshiba,visconti-wdt.yaml    |  12 +-
 .../bindings/watchdog/xlnx,xps-timebase-wdt.yaml   |  68 ++++
 drivers/watchdog/Kconfig                           |  15 +-
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/armada_37xx_wdt.c                 |   2 +
 drivers/watchdog/aspeed_wdt.c                      |  12 +-
 drivers/watchdog/bd9576_wdt.c                      |  51 ++-
 drivers/watchdog/eurotechwdt.c                     |   2 +-
 drivers/watchdog/exar_wdt.c                        | 427 +++++++++++++++++++++
 drivers/watchdog/ftwdt010_wdt.c                    |  25 +-
 drivers/watchdog/hpwdt.c                           |   2 +
 drivers/watchdog/imx7ulp_wdt.c                     | 212 +++++++---
 drivers/watchdog/meson_gxbb_wdt.c                  |  24 +-
 drivers/watchdog/npcm_wdt.c                        |  16 +
 drivers/watchdog/rti_wdt.c                         |   3 +-
 drivers/watchdog/rzg2l_wdt.c                       |  39 +-
 drivers/watchdog/s3c2410_wdt.c                     |  41 +-
 drivers/watchdog/sa1100_wdt.c                      |   2 +-
 drivers/watchdog/sp5100_tco.c                      |  13 +-
 drivers/watchdog/twl4030_wdt.c                     |   1 +
 drivers/watchdog/w83627hf_wdt.c                    |  12 +-
 drivers/watchdog/w83977f_wdt.c                     |   2 +-
 drivers/watchdog/watchdog_dev.c                    |   6 +-
 drivers/watchdog/wdat_wdt.c                        |   5 +-
 32 files changed, 1097 insertions(+), 223 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
 create mode 100644 drivers/watchdog/exar_wdt.c
----------------------------------------------------------------

Kind regards,
Wim.

