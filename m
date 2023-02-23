Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDBC6A044E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjBWI7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjBWI7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:59:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AAE9038
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:59:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E03AF6162D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 08:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9BBC433D2;
        Thu, 23 Feb 2023 08:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677142784;
        bh=J8nnrBdWTIKTWddQki9KBEee0EDm+ZpWZVqy2Kac1JE=;
        h=Date:From:To:Cc:Subject:From;
        b=Rf+9cWbesiWSrPKcxgLLdnbEs2aS8DcYi5nNsBLIA5TN3c+3XskaddaSAC8DbkX7e
         eT8bY2e/4UGDXWT3jQZJ9XpCRfrmMZx9zu2XZ4SBdkldCSmVBc7XcvxUgt6Wyi9Wtf
         vVu/bUG9jvlmIB1b4yfNHb2GyXJ0cZu8qHjTq/95TZ/eTBOVL6rx9wGX/Nuy0fL82G
         UoQxY0UpaitwtJH4WPDxGFGB6bFbQR0apSNHKUsQV75rGs0Jg/VMALHlJy0Y2fVTcy
         JckpAhtoApjUO8g700Oh2EfzhKr+sRimg5tXRcoxngBAKhB9s9S5+QVw9d8C2Tr3lg
         H9R9lSvsItJjQ==
Date:   Thu, 23 Feb 2023 08:59:40 +0000
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v6.3
Message-ID: <Y/cq/Im+leAX6XRn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.3

for you to fetch changes up to 59c54c59974649b2e7bc92faae4a21e2b2408db2:

  dt-bindings: mfd: qcom,tcsr: Add compatible for IPQ5332 (2023-02-22 11:42:29 +0000)

----------------------------------------------------------------
 - Core Frameworks
   - Change MFD support status from Supported to Maintained

 - New Drivers
   - Add support for the Intel Platform Management Component Interface (PMCI)

 - Remove Drivers
   - HTC PASIC3 LED/DS1WM
   - Toshiba T7L66XB, TC6387XB and TC6393XB TMIO

 - New Device Support
   - Add support for N6000 Flash to Intel M10 BMC PMCI
   - Add support for Lenovo Yoga Tab 3 to Intel CHTWC PMIC

 - New Functionality
   - Provide Reset support to Syscon

 - Fix-ups
   - Explicitly provide missing include files
   - Pass platform type data/info via the SPI/I2C/DT registration strategy
   - Lots of DT documentation / adaptions
   - Replace scnprintf() with preferred sysfs_emit()
   - Remove unused / superfluous code
   - Fix some trivial whitesspace / spelling / grammatical issues
   - Replace pm_power_off with new and improved register_sys_off_handler() API

 - Bug Fixes
   - Reintroduce RK808-clkout registration - fixing Wi-Fi and Bluetooth
   - Repair the order of AXPxxx IRQ PEK RISE/FALL definitions
   - Refuse to build CS5535 on unsupported UML architectures
   - Fix memory leaks in error return paths
   - Prevent refcount leaks in error return paths

----------------------------------------------------------------
Andreas Kemnade (2):
      mfd: twl: Fix TWL6032 phy vbus detection
      mfd: ntxec: Add version number for EC in Tolino Vision

Aren Moynihan (1):
      mfd: axp20x: Fix order of pek rise and fall events

Arnd Bergmann (1):
      mfd: Remove toshiba tmio drivers

Bernhard Rosenkränzer (1):
      dt-bindings: mfd: syscon: Add mt8365-syscfg

Bhanu Prakash Maiya (1):
      dt-bindings: mfd: cros-ec: Add compatible string for UART support

Brad Larson (1):
      dt-bindings: mfd: syscon: Add amd,pensando-elba-syscon compatible

Geert Uytterhoeven (1):
      mfd: core: Spelling s/compement/complement/

Hans de Goede (3):
      mfd: intel_soc_pmic_chtwc: Add Lenovo Yoga Tab 3 X90F to intel_cht_wc_models
      i2c: cht-wc: Add charger-chip info for the Lenovo Yoga Tab 3 YT3-X90F
      extcon: intel-cht-wc: Add support for Lenovo Yoga Tab 3 Pro YT3-X90F

Ilpo Järvinen (11):
      mfd: intel-m10-bmc: Add missing includes to header
      mfd: intel-m10-bmc: Create m10bmc_platform_info for type specific info
      mfd: intel-m10-bmc: Rename the local variables
      mfd: intel-m10-bmc: Split into core and spi specific parts
      mfd: intel-m10-bmc: Support multiple CSR register layouts
      fpga: intel-m10-bmc: Rework flash read/write
      mfd: intel-m10-bmc: Prefix register defines with M10BMC_N3000
      fpga: m10bmc-sec: Create helpers for rsu status/progress checks
      fpga: m10bmc-sec: Make rsu status type specific
      mfd: intel-m10-bmc: Add PMCI driver
      fpga: m10bmc-sec: Add support for N6000

Jacky Bai (1):
      dt-bindings: mfd: Add NXP BBNSM

Jeremy Kerr (2):
      dt-bindings: mfd/syscon: Add resets property
      mfd: syscon: Allow reset control for syscon devices

Jiapeng Chong (2):
      mfd: qcom-pm8xxx: Remove set but unused variable 'rev'
      mfd: max8925: Remove the unused function irq_to_max8925()

Kathiravan T (1):
      dt-bindings: mfd: qcom,tcsr: Add compatible for IPQ5332

Lee Jones (3):
      Merge tags 'ib-mfd-extcon-i2c-v6.3' and 'ib-mfd-fpga-hwmon-v6.3-1' into ibs-for-mfd-merged
      MAINTAINERS: Move MFD from a Supported to Maintaied state
      mfd: simple-mfd-i2c: Fix incoherent comment regarding DT registration

Liang He (1):
      mfd: arizona: Use pm_runtime_resume_and_get() to prevent refcnt leak

Matti Lehtimäki (1):
      dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8226

Neil Armstrong (1):
      dt-bindings: mfd: qcom,spmi-pmic: Document PMICs bundled with SM8550

Nick Hawkins (1):
      dt-bindings: mfd: syscon: Document GXP register compatible

Qiheng Lin (1):
      mfd: pcf50633-adc: Fix potential memleak in pcf50633_adc_async_read()

Randy Dunlap (1):
      mfd: cs5535: Don't build on UML

Samuel Holland (1):
      mfd: axp20x: Switch to the sys-off handler API

Tom Fitzhenry (1):
      mfd: rk808: Re-add rk808-clkout to RK818

Uwe Kleine-König (1):
      mfd: twl4030-power: Drop empty platform remove function

ye xingchen (1):
      mfd: Use sysfs_emit() to instead of scnprintf()

 .../ABI/testing/sysfs-driver-intel-m10-bmc         |    8 +-
 .../devicetree/bindings/mfd/google,cros-ec.yaml    |   20 +
 .../devicetree/bindings/mfd/nxp,bbnsm.yaml         |  101 ++
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |    7 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |    2 +
 Documentation/devicetree/bindings/mfd/syscon.yaml  |    6 +
 MAINTAINERS                                        |    4 +-
 drivers/extcon/extcon-intel-cht-wc.c               |    1 +
 drivers/fpga/Kconfig                               |    2 +-
 drivers/fpga/intel-m10-bmc-sec-update.c            |  415 +++++---
 drivers/hwmon/Kconfig                              |    2 +-
 drivers/i2c/busses/i2c-cht-wc.c                    |   46 +
 drivers/mfd/Kconfig                                |   71 +-
 drivers/mfd/Makefile                               |    9 +-
 drivers/mfd/arizona-core.c                         |    2 +-
 drivers/mfd/asic3.c                                | 1071 --------------------
 drivers/mfd/axp20x.c                               |   27 +-
 drivers/mfd/intel-m10-bmc-core.c                   |  122 +++
 drivers/mfd/intel-m10-bmc-pmci.c                   |  455 +++++++++
 drivers/mfd/intel-m10-bmc-spi.c                    |  168 +++
 drivers/mfd/intel-m10-bmc.c                        |  238 -----
 drivers/mfd/intel_soc_pmic_chtwc.c                 |    8 +
 drivers/mfd/kempld-core.c                          |    7 +-
 drivers/mfd/lm3533-core.c                          |    2 +-
 drivers/mfd/max8925-core.c                         |    6 -
 drivers/mfd/ntxec.c                                |    1 +
 drivers/mfd/pcf50633-adc.c                         |    7 +-
 drivers/mfd/qcom-pm8xxx.c                          |    3 -
 drivers/mfd/rk808.c                                |    1 +
 drivers/mfd/simple-mfd-i2c.c                       |    2 +-
 drivers/mfd/syscon.c                               |   27 +-
 drivers/mfd/t7l66xb.c                              |  427 --------
 drivers/mfd/tc6387xb.c                             |  228 -----
 drivers/mfd/tc6393xb.c                             |  907 -----------------
 drivers/mfd/tmio_core.c                            |   70 --
 drivers/mfd/twl-core.c                             |    9 +-
 drivers/mfd/twl4030-power.c                        |    6 -
 include/linux/mfd/asic3.h                          |  313 ------
 include/linux/mfd/axp20x.h                         |   15 +-
 include/linux/mfd/core.h                           |    2 +-
 include/linux/mfd/intel-m10-bmc.h                  |  205 +++-
 include/linux/mfd/intel_soc_pmic.h                 |    1 +
 include/linux/mfd/ntxec.h                          |    2 +-
 include/linux/mfd/t7l66xb.h                        |   29 -
 include/linux/mfd/tc6387xb.h                       |   19 -
 include/linux/mfd/tc6393xb.h                       |   53 -
 include/linux/mfd/tmio.h                           |    5 -
 include/linux/mfd/twl.h                            |    2 +
 48 files changed, 1479 insertions(+), 3655 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml
 delete mode 100644 drivers/mfd/asic3.c
 create mode 100644 drivers/mfd/intel-m10-bmc-core.c
 create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
 create mode 100644 drivers/mfd/intel-m10-bmc-spi.c
 delete mode 100644 drivers/mfd/intel-m10-bmc.c
 delete mode 100644 drivers/mfd/t7l66xb.c
 delete mode 100644 drivers/mfd/tc6387xb.c
 delete mode 100644 drivers/mfd/tc6393xb.c
 delete mode 100644 drivers/mfd/tmio_core.c
 delete mode 100644 include/linux/mfd/asic3.h
 delete mode 100644 include/linux/mfd/t7l66xb.h
 delete mode 100644 include/linux/mfd/tc6387xb.h
 delete mode 100644 include/linux/mfd/tc6393xb.h

-- 
Lee Jones [李琼斯]
