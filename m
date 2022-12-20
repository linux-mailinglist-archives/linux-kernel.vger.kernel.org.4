Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01122651743
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 01:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiLTAvI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Dec 2022 19:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbiLTAvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:51:04 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF71F59F;
        Mon, 19 Dec 2022 16:51:02 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2FA3324DF03;
        Tue, 20 Dec 2022 08:50:56 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 20 Dec
 2022 08:50:56 +0800
Received: from ubuntu.localdomain (183.27.97.120) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 20 Dec
 2022 08:50:55 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/11] Basic clock and reset support for StarFive JH7110 RISC-V SoC
Date:   Tue, 20 Dec 2022 08:50:43 +0800
Message-ID: <20221220005054.34518-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.120]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds basic clock&reset support for StarFive JH7110 SoC.
You can simply get or review the patches at the link [1].

[1]: https://github.com/hal-feng/linux/commits/visionfive2-minimal

Changes since v2:
- Rebased on tag v6.1.
- Added "JH71X0" to the StarFive driver headers in MAINTAINERS.
- Removed Co-developed-by tag of Hal in patch 1 and patch 4.
- Changed the commit author from Hal to Emil in patch 2 and patch 5.
  Removed Co-developed-by tag of Emil in patch 2 and patch 5. (by Emil)
- Improved the coding style of patch 11, 12 and 13.
- Dropped patch 14. (by Emil)
Patch 4:
- Passed the "owner" member of reset_controller_dev structure
  directly in reset_starfive_jh7100_register(). (by Emil)
- Added MAINTAINERS changes.
Patch 7:
- Split patch 7 into sys part and aon part. Merged them into patch 9 and
  patch 10 respectively. (by Krzysztof)
- Renamed include/dt-bindings/clock/starfive-jh7110.h to
  include/dt-bindings/clock/starfive,jh7110-crg.h. (by Krzysztof)
- Synchronized the definitions with the latest changes from Emil.
Patch 8:
- Split patch 8 into sys part and aon part. Merged them into patch 9 and
  patch 10 respectively. (by Krzysztof)
- Renamed include/dt-bindings/reset/starfive-jh7110.h to
  include/dt-bindings/reset/starfive,jh7110-crg.h. (by Krzysztof)
- Fixed the date of Copyright. (by Emil)
- Dropped weird indentations. (by Krzysztof)
- Synchronized the definitions with the latest changes from Emil.
Patch 9:
- Improved the description of clocks. (by Emil and Krzysztof)
- Added MAINTAINERS changes.
Patch 10:
- Improved the description of clocks. (by Emil and Krzysztof)
- Changed the clock-name "clk_rtc" to "rtc_osc" and  "apb_bus_func" to
  "apb_bus".
Patch 11:
- Removed the flags of trace/debug clocks and set the flags of core clocks
  as CLK_IS_CRITICAL. (by Emil)
- Deleted the extra 1-1 clocks and synchronized the clock tree with the
  latest changes from Emil. (by Emil)
- Selected RESET_STARFIVE_JH7110 in Kconfig option CLK_STARFIVE_JH7110_SYS.
Patch 12:
- Changed the macro JH7110_AONCLK_RTC to JH7110_AONCLK_RTC_OSC and
  JH7110_AONCLK_APB_BUS_FUNC to JH7110_AONCLK_APB_BUS.
- Synchronized the clock tree with the latest changes from Emil.
- Set the MODULE_LICENSE as "GPL" according to commit bf7fbeeae6db.
Patch 13:
- Removed the "asserted" member in reset_info structure and always pass
  NULL when calling reset_starfive_jh71x0_register(). (by Emil)

  v2: https://lore.kernel.org/all/20221118010627.70576-1-hal.feng@starfivetech.com/

Changes since v1:
- Rebased on tag v6.1-rc5.
- Rewrote the clock and reset drivers using auxiliary bus framework, so
  patch 8, 9, 15 were dropped and all patches changed a lot. (by Stephen)
- Split Patch 14 into two patches. One is for factoring out the common
  JH71X0 code, the another one is for renaming. (by Stephen)
- Created a subdirectory for StarFive reset drivers.
- Factored out common JH71X0 reset code.
- Renamed the common clock and reset code from "*starfive*" or
  "*STARFIVE*" to "*jh71x0*" or "*JH71X0*".
- Combined JH7110 system and always-on clock DT binding headers in one
  file named "include/dt-bindings/clock/starfive-jh7110.h".
- Renamed clock definitions "JH7110_SYSCLK_PCLK2_MUX_FUNC_PCLK" and
  "JH7110_SYSCLK_U2_PCLK_MUX_PCLK" to "JH7110_SYSCLK_PCLK2_MUX_FUNC" and
  "JH7110_SYSCLK_PCLK2_MUX".
- Rewrote the DT bindings of clock and reset for using auxiliary bus.
- Registered an auxiliary device for reset controller in clock drivers.
- Changed clock names "CODAJ*" and "WAVE*" to "codaj*" and "wave*".
  Changed clock names "u2_pclk_mux_func_pclk" and "u2_pclk_mux_pclk" to
  "pclk2_mux_func" and "pclk2_mux".
- Changed the flags of clock apb0 and noc_bus_isp_axi to CLK_IS_CRITICAL
  as suggested by StarFive SDK group.
- Registered clock gmac0_gtxc as a gate clock instead of a div clock
  as suggested by StarFive SDK group.
- Changed the frequency of clock pll2_out to 1188MHz as suggested by
  StarFive SDK group.
- Fixed the bug that the clock JH7110_AONCLK_GMAC0_GTXCLK was not handled
  in JH7110 always-on clock driver.
- Registered the reset driver as an auxiliary driver.
- Reworded the commit messages.

  v1: https://lore.kernel.org/all/20220929143225.17907-1-hal.feng@linux.starfivetech.com/

Emil Renner Berthing (10):
  clk: starfive: Factor out common JH7100 and JH7110 code
  clk: starfive: Rename "jh7100" to "jh71x0" for the common code
  reset: Create subdirectory for StarFive drivers
  reset: starfive: Factor out common JH71X0 reset code
  reset: starfive: Rename "jh7100" to "jh71x0" for the common code
  reset: starfive: jh71x0: Use 32bit I/O on 32bit registers
  dt-bindings: clock: Add StarFive JH7110 system clock and reset
    generator
  dt-bindings: clock: Add StarFive JH7110 always-on clock and reset
    generator
  clk: starfive: Add StarFive JH7110 system clock driver
  clk: starfive: Add StarFive JH7110 always-on clock driver

Hal Feng (1):
  reset: starfive: Add StarFive JH7110 reset driver

 .../clock/starfive,jh7110-aoncrg.yaml         |  76 ++
 .../clock/starfive,jh7110-syscrg.yaml         |  80 ++
 MAINTAINERS                                   |  16 +-
 drivers/clk/starfive/Kconfig                  |  27 +
 drivers/clk/starfive/Makefile                 |   6 +-
 .../clk/starfive/clk-starfive-jh7100-audio.c  |  74 +-
 drivers/clk/starfive/clk-starfive-jh7100.c    | 713 +++++-------------
 drivers/clk/starfive/clk-starfive-jh7100.h    | 112 ---
 .../clk/starfive/clk-starfive-jh7110-aon.c    | 156 ++++
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 448 +++++++++++
 drivers/clk/starfive/clk-starfive-jh71x0.c    | 387 ++++++++++
 drivers/clk/starfive/clk-starfive-jh71x0.h    | 122 +++
 drivers/reset/Kconfig                         |   8 +-
 drivers/reset/Makefile                        |   2 +-
 drivers/reset/reset-starfive-jh7100.c         | 173 -----
 drivers/reset/starfive/Kconfig                |  20 +
 drivers/reset/starfive/Makefile               |   5 +
 .../reset/starfive/reset-starfive-jh7100.c    |  74 ++
 .../reset/starfive/reset-starfive-jh7110.c    |  64 ++
 .../reset/starfive/reset-starfive-jh71x0.c    | 129 ++++
 .../reset/starfive/reset-starfive-jh71x0.h    |  20 +
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 225 ++++++
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 154 ++++
 23 files changed, 2234 insertions(+), 857 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
 delete mode 100644 drivers/clk/starfive/clk-starfive-jh7100.h
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-aon.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-sys.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.h
 delete mode 100644 drivers/reset/reset-starfive-jh7100.c
 create mode 100644 drivers/reset/starfive/Kconfig
 create mode 100644 drivers/reset/starfive/Makefile
 create mode 100644 drivers/reset/starfive/reset-starfive-jh7100.c
 create mode 100644 drivers/reset/starfive/reset-starfive-jh7110.c
 create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.c
 create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.h
 create mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h


base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
-- 
2.38.1

