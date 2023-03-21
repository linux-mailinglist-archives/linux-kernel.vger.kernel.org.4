Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CFE6C3E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCUXEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjCUXEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:04:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD77FF2A;
        Tue, 21 Mar 2023 16:04:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14976B81A62;
        Tue, 21 Mar 2023 23:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216E8C433EF;
        Tue, 21 Mar 2023 23:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679439840;
        bh=SpucqB9n75qjtnnvgZr6/rDAIPTz9Gr8WByPwr4TUVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPa6MgzH8BqqVX8cqk3S2+1Lj/Vr77J0ghRVFCAl5uZeHfZLPiAObOwP0eOTe+/qU
         9jZRLvf2RjJ84MGSsy8PGhVkS+qA/cXF52KDi1kA4tTl1csrBClkTcSJry3aOWibeY
         7iFa8R7J4eJMAIyg/G3BkBwcojlRkbpbaeXTrOAEEywn7MF8L02kMFmd9geswa/JYX
         93hBlwqBw0gBdwxtoYm4lJLpZEdp4dd3v9gdcBBL/6m7PhyF1gBFpjUDo4cWcSHbWx
         dJ/KeaOg8lJENGflTYkeEvcE1VFd6UmCglCFgC825zjNJsRmXT/bNiUcqNtC/Rm5jz
         DkEPAwlq1DwVw==
Date:   Tue, 21 Mar 2023 23:03:54 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>, kernel@esmil.dk
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/21] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Message-ID: <95f11f7c-611f-49a9-97e8-0de89846e430@spud>
References: <20230320103750.60295-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XrvLcEVwIxWnDgFn"
Content-Disposition: inline
In-Reply-To: <20230320103750.60295-1-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XrvLcEVwIxWnDgFn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Emil,

I tried messaging you on IRC yesterday, but message probably got lost in
the ether :(

On Mon, Mar 20, 2023 at 06:37:29PM +0800, Hal Feng wrote:
> This patch series adds basic clock, reset & DT support for StarFive
> JH7110 SoC.

Are you happy with how the series looks now and if so, how do you want
to go about getting it applied?

To me, what'd seem ideal, is a branch that starts w/ the two binding
changes for clock and reset so that that bit can be shared between
clock/reset drivers and dts bits.
Since, I, at least, am happy with the dts since of things, I've gone and
created such a branch with the dt-bindings at the start, followed by the
dts bits, and pushed it here:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=3Dri=
scv-jh7110_initial_dts

If you're happy on the driver side of things, do you want to pick those
patches up on top of the bindings and send a PR to Stephen?
No rush if you're not, still got a fair bit of time til the merge window
yada-yada & I won't merge this branch into the riscv-dt for-next one
until the bindings are in the clock tree.

Thanks,
Conor.

(I did end up re-creating the first patch on that branch, b4/git am
didn't like the maintainers change, so hopefully I've not made a hames
of it.)

>=20
> You can simply review or test the patches at the link [1].
>=20
> [1]: https://github.com/hal-feng/linux/commits/visionfive2-minimal
>=20
> Changes since v5:
> - Rebased on v6.3-rc3.
> Patch 1:
> - Set obj-y for starfive/ in drivers/clk/Makefile.
> Patch 2:
> - Sorted the StarFive entries alphabetically in MAINTAINERS.
> Patch 3:
> - Fixed the build error which caused by renaming the header without
>   changing the users of the header.
> Patch 4:
> - Fixed the errors reported by checkpatch.pl.
> Patch 6:
> - Set obj-y for starfive/ in drivers/reset/Makefile.
> Patch 13:
> - Set the timer clock flags as 0.
>=20
>   v5: https://lore.kernel.org/all/20230311090733.56918-1-hal.feng@starfiv=
etech.com/
>=20
> Changes since v4:
> - Rebased on v6.3-rc1.
> - Added two patches to replace SOC_STARFIVE with ARCH_STARFIVE.
> - Added Tested-by tag for Tommaso.
> Patch 9:
> - Set GMAC1 related clocks as optional inputs.
> - Dropped PLL clock definitions.
> Patch 10:
> - Set GMAC0 related clocks and RTC oscillator as optional inputs.
> - Sorted the clocks.
> Patch 11:
> - Replaced SOC_STARFIVE with ARCH_STARFIVE.
> - Added macros for PLL clocks and adjusted the code properly to
>   make it easier to add the PLL clock driver later.
> - Updated the clock flags.
> Patch 12:
> - Built as a module by default.
> - Sorted the clocks.
> - Updated the clock flags.
> Patch 13:
> - Replaced "default CLK_STARFIVE_JH7110_SYS" with "default ARCH_STARFIVE".
> - Renamed "reset_info" struct to "jh7110_reset_info" and moved its
>   definition into the driver.
> - Put jh7110_sys_info and jh7110_sys_info before the probe().
> Patch 17:
> - Dropped "_zicsr" in ISA.
> - Sorted the external clocks alphabetically.
> - Put the ccache node before the plic node according to their addresses.
> - Sorted the clock inputs of the aoncrg node.
> Patch 19:
> - Replaced SOC_STARFIVE with ARCH_STARFIVE.
> - Sorted the nodes alphabetically.
>=20
>   v4: https://lore.kernel.org/all/20230221024645.127922-1-hal.feng@starfi=
vetech.com/
>=20
> Changes since v3:
> - Suggested by Conor, Merged clock & reset series and DT series together
>   so that they could go via the same tree as the dt-binding headers are
>   required by both driver & devicetree.
> - Rebased on tag v6.2.
>=20
> [Clock & reset]
> Patch 2:
> - Split patch 2 into two. One for renaming file and one for renaming
>   variables. (by Conor)
> Patch 4:
> - Split patch 4 into two. One for code movement and one for
>   extraction. (by Conor)
> Patch 5 & 9 & 10 & 11:
> - Fixed the issues reported by kernel test robot.
> Patch 9:
> - Set (&priv->base) as driver data instead of (priv->base).
> - Set the frequency of clock PLL0 as 1000MHz for Synchronizing with the
>   lastest u-boot setting from StarFive. (by Emil)
> - Used devm_kzalloc() instead of kzalloc() when registering aux device.
> Patch 10:
> - Set (&priv->base) as driver data instead of (priv->base).
> Patch 11:
> - Used (*base) to get the register base address instead of (base).
>=20
> [Device tree]
> - Dropped patch 1, 4, 5 because they were accepted.
> - Added a new patch to add SiFive S7 compatible. (by Conor)
> - Added a new patch to add JH7110 pin function definitions.
> Patch 6:
> - Changed the label "S76_0" to "S7_0" and used compatible "sifive,s7"
>   for core 0.
> - Updated ISA of each cores. (by Conor)
> - Made the node names generic. (by Krzysztof)
> - Added clock-output-names for all external clocks.
> - Added i2c0~6 nodes.
> - Changed the node name "gpio" to "pinctrl". Changed the label "gpio"
>   and "gpioa" to "sysgpio" and "aongpio". (by Conor)
> Patch 7:
> - Separated the long lines into more lines in Makefile. (by Conor)
> - Renamed jh7110-starfive-visionfive-2-va.dts and
>   jh7110-starfive-visionfive-2-vb.dts to
>   jh7110-starfive-visionfive-2-v1.2a.dts and
>   jh7110-starfive-visionfive-2-v1.3b.dts.
>   Changed the model and compatible to match v1.2A and v1.3B which
>   are printed on the silkscreen of VisionFive 2 board. (by Emil)
> - Configured pins for i2c0/2/5/6 and enabled them.
>=20
>   clock & reset v3: https://lore.kernel.org/all/20221220005054.34518-1-ha=
l.feng@starfivetech.com/
>   DT v3: https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@star=
fivetech.com/
>=20
> Changes since v2:
> [Clock & reset]
> - Rebased on tag v6.1.
> - Added "JH71X0" to the StarFive driver headers in MAINTAINERS.
> - Removed Co-developed-by tag of Hal in patch 1 and patch 4.
> - Changed the commit author from Hal to Emil in patch 2 and patch 5.
>   Removed Co-developed-by tag of Emil in patch 2 and patch 5. (by Emil)
> - Improved the coding style of patch 11, 12 and 13.
> - Dropped patch 14. (by Emil)
> Patch 4:
> - Passed the "owner" member of reset_controller_dev structure
>   directly in reset_starfive_jh7100_register(). (by Emil)
> - Added MAINTAINERS changes.
> Patch 7:
> - Split patch 7 into sys part and aon part. Merged them into patch 9 and
>   patch 10 respectively. (by Krzysztof)
> - Renamed include/dt-bindings/clock/starfive-jh7110.h to
>   include/dt-bindings/clock/starfive,jh7110-crg.h. (by Krzysztof)
> - Synchronized the definitions with the latest changes from Emil.
> Patch 8:
> - Split patch 8 into sys part and aon part. Merged them into patch 9 and
>   patch 10 respectively. (by Krzysztof)
> - Renamed include/dt-bindings/reset/starfive-jh7110.h to
>   include/dt-bindings/reset/starfive,jh7110-crg.h. (by Krzysztof)
> - Fixed the date of Copyright. (by Emil)
> - Dropped weird indentations. (by Krzysztof)
> - Synchronized the definitions with the latest changes from Emil.
> Patch 9:
> - Improved the description of clocks. (by Emil and Krzysztof)
> - Added MAINTAINERS changes.
> Patch 10:
> - Improved the description of clocks. (by Emil and Krzysztof)
> - Changed the clock-name "clk_rtc" to "rtc_osc" and  "apb_bus_func" to
>   "apb_bus".
> Patch 11:
> - Removed the flags of trace/debug clocks and set the flags of core clocks
>   as CLK_IS_CRITICAL. (by Emil)
> - Deleted the extra 1-1 clocks and synchronized the clock tree with the
>   latest changes from Emil. (by Emil)
> - Selected RESET_STARFIVE_JH7110 in Kconfig option CLK_STARFIVE_JH7110_SY=
S.
> Patch 12:
> - Changed the macro JH7110_AONCLK_RTC to JH7110_AONCLK_RTC_OSC and
>   JH7110_AONCLK_APB_BUS_FUNC to JH7110_AONCLK_APB_BUS.
> - Synchronized the clock tree with the latest changes from Emil.
> - Set the MODULE_LICENSE as "GPL" according to commit bf7fbeeae6db.
> Patch 13:
> - Removed the "asserted" member in reset_info structure and always pass
>   NULL when calling reset_starfive_jh71x0_register(). (by Emil)
>=20
> [Device tree]
> - Rebased on tag v6.1.
> - Dropped patch 8 because it was merged.
> Patch 1:
> - Made the links into "Link:" tags. (by Conor)
> - Corrected the board name to "VisionFive 2" instead of
>   "VisionFive V2" and added compatibles for version A and
>   version B of VisionFive 2. (by Emil)
> Patch 4:
> - Used "sifive,ccache0" compatible string to match. (by Conor)
> Patch 5:
> - Dropped "select SIFIVE_CCACHE" in config SOC_STARFIVE. (by Conor)
> - Dropped "starfive,jh7110-ccache" compatible in
>   drivers/soc/sifive/sifive_ccache.c.
> Patch 6:
> - Removed all "clock-frequency =3D <0>". (by Conor)
> - Sorted the nodes after their addresses. (by Emil)
> - Renamed "clk_rtc" to "rtc_osc".
> - Added "sifive,ccache0" compatible in the cache-controller node.
> - Renamed "JH7110_SYSCLK_APB_BUS_FUNC" to "JH7110_SYSCLK_APB_BUS" and
>   renamed "apb_bus_func" to "apb_bus".
>   Renamed "JH7110_SYSCLK_IOMUX" to "JH7110_SYSCLK_IOMUX_APB".
>   Renamed "JH7110_SYSRST_IOMUX" to "JH7110_SYSRST_IOMUX_APB".
>   Renamed "JH7110_AONRST_AON_IOMUX" to "JH7110_AONRST_IOMUX".
> - Removed "reg-names" in gpio nodes.
> Patch 7:
> - Corrected the board name to "VisionFive 2" instead of "VisionFive V2".
> - Renamed jh7110-starfive-visionfive-v2.dts to
>   jh7110-starfive-visionfive-2.dtsi.
> - Added dts for VisionFive 2 version A and version B boards.
> - In the chosen node, deleted "linux,initrd-start" and "linux,initrd-end"
>   and changed the value of "stdout-path" to "serial0:115200n8".
> - Changed the bias of uart0 "rx-pins" to
>   "bias-disable; /* external pull-up */".
> - Renamed "clk_rtc" to "rtc_osc".
> - Moved the gpio node behind the uart0 node.
>=20
>   clock & reset v2: https://lore.kernel.org/all/20221118010627.70576-1-ha=
l.feng@starfivetech.com/
>   DT v2: https://lore.kernel.org/all/20221118011714.70877-1-hal.feng@star=
fivetech.com/
>=20
> Changes since v1:
> [Clock & reset]
> - Rebased on tag v6.1-rc5.
> - Rewrote the clock and reset drivers using auxiliary bus framework, so
>   patch 8, 9, 15 were dropped and all patches changed a lot. (by Stephen)
> - Split Patch 14 into two patches. One is for factoring out the common
>   JH71X0 code, the another one is for renaming. (by Stephen)
> - Created a subdirectory for StarFive reset drivers.
> - Factored out common JH71X0 reset code.
> - Renamed the common clock and reset code from "*starfive*" or
>   "*STARFIVE*" to "*jh71x0*" or "*JH71X0*".
> - Combined JH7110 system and always-on clock DT binding headers in one
>   file named "include/dt-bindings/clock/starfive-jh7110.h".
> - Renamed clock definitions "JH7110_SYSCLK_PCLK2_MUX_FUNC_PCLK" and
>   "JH7110_SYSCLK_U2_PCLK_MUX_PCLK" to "JH7110_SYSCLK_PCLK2_MUX_FUNC" and
>   "JH7110_SYSCLK_PCLK2_MUX".
> - Rewrote the DT bindings of clock and reset for using auxiliary bus.
> - Registered an auxiliary device for reset controller in clock drivers.
> - Changed clock names "CODAJ*" and "WAVE*" to "codaj*" and "wave*".
>   Changed clock names "u2_pclk_mux_func_pclk" and "u2_pclk_mux_pclk" to
>   "pclk2_mux_func" and "pclk2_mux".
> - Changed the flags of clock apb0 and noc_bus_isp_axi to CLK_IS_CRITICAL
>   as suggested by StarFive SDK group.
> - Registered clock gmac0_gtxc as a gate clock instead of a div clock
>   as suggested by StarFive SDK group.
> - Changed the frequency of clock pll2_out to 1188MHz as suggested by
>   StarFive SDK group.
> - Fixed the bug that the clock JH7110_AONCLK_GMAC0_GTXCLK was not handled
>   in JH7110 always-on clock driver.
> - Registered the reset driver as an auxiliary driver.
> - Reworded the commit messages.
>=20
> [Device tree]
> - Rebased on tag v6.1-rc5.
> - Added blank line in patch 1. (by Krzysztof)
> - Rebased patch 4 and 6 on the newest code. (by Conor)
> - Dropped patch 5. (by Conor)
> - Removed the quirk of JH7100 in patch 6, considering this patch series
>   should only add support for JH7110.
> - For patch 27, added Co-developed-by tag for Jianlong and me. Renamed
>   cpu labels to "S76_0", "U74_*" instead of "cpu*" following the style
>   of jh7100.dtsi. Moved all "clock-frequency" properties to the board dts.
>   Rewrote clock-controller nodes and deleted reset-controller nodes for
>   using auxiliary bus. Rewrote gpio nodes following generic pinctrl
>   bindings. Removed the redundant second reset entry of uart nodes.
> - For patch 28, added Co-developed-by tag for Jianlong and me. Added a
>   chosen node. Removed reserved-memory node. Added fixed frequency clock
>   nodes for overriding the "clock-frequency" properties. Rewrote the gpio
>   nodes following generic pinctrl bindings.
> - Dropped patch 30. (by Conor)
> - Reworded the commit messages.
>=20
>   v1: https://lore.kernel.org/all/20220929143225.17907-1-hal.feng@linux.s=
tarfivetech.com/
>=20
> Emil Renner Berthing (16):
>   clk: starfive: Factor out common JH7100 and JH7110 code
>   clk: starfive: Rename clk-starfive-jh7100.h to clk-starfive-jh71x0.h
>   clk: starfive: Rename "jh7100" to "jh71x0" for the common code
>   reset: Create subdirectory for StarFive drivers
>   reset: starfive: Factor out common JH71X0 reset code
>   reset: starfive: Extract the common JH71X0 reset code
>   reset: starfive: Rename "jh7100" to "jh71x0" for the common code
>   reset: starfive: jh71x0: Use 32bit I/O on 32bit registers
>   dt-bindings: clock: Add StarFive JH7110 system clock and reset
>     generator
>   dt-bindings: clock: Add StarFive JH7110 always-on clock and reset
>     generator
>   clk: starfive: Add StarFive JH7110 system clock driver
>   clk: starfive: Add StarFive JH7110 always-on clock driver
>   dt-bindings: timer: Add StarFive JH7110 clint
>   dt-bindings: interrupt-controller: Add StarFive JH7110 plic
>   riscv: dts: starfive: Add initial StarFive JH7110 device tree
>   riscv: dts: starfive: Add StarFive JH7110 VisionFive 2 board device
>     tree
>=20
> Hal Feng (4):
>   clk: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
>   reset: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
>   reset: starfive: Add StarFive JH7110 reset driver
>   dt-bindings: riscv: Add SiFive S7 compatible
>=20
> Jianlong Huang (1):
>   riscv: dts: starfive: Add StarFive JH7110 pin function definitions
>=20
>  .../clock/starfive,jh7110-aoncrg.yaml         | 107 +++
>  .../clock/starfive,jh7110-syscrg.yaml         | 104 +++
>  .../sifive,plic-1.0.0.yaml                    |   1 +
>  .../devicetree/bindings/riscv/cpus.yaml       |   1 +
>  .../bindings/timer/sifive,clint.yaml          |   1 +
>  MAINTAINERS                                   |  22 +-
>  arch/riscv/boot/dts/starfive/Makefile         |   6 +-
>  arch/riscv/boot/dts/starfive/jh7110-pinfunc.h | 308 ++++++++
>  .../jh7110-starfive-visionfive-2-v1.2a.dts    |  13 +
>  .../jh7110-starfive-visionfive-2-v1.3b.dts    |  13 +
>  .../jh7110-starfive-visionfive-2.dtsi         | 215 ++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 509 +++++++++++++
>  drivers/clk/Makefile                          |   2 +-
>  drivers/clk/starfive/Kconfig                  |  33 +-
>  drivers/clk/starfive/Makefile                 |   6 +-
>  .../clk/starfive/clk-starfive-jh7100-audio.c  |  74 +-
>  drivers/clk/starfive/clk-starfive-jh7100.c    | 716 +++++-------------
>  drivers/clk/starfive/clk-starfive-jh7100.h    | 112 ---
>  .../clk/starfive/clk-starfive-jh7110-aon.c    | 156 ++++
>  .../clk/starfive/clk-starfive-jh7110-sys.c    | 450 +++++++++++
>  drivers/clk/starfive/clk-starfive-jh71x0.c    | 383 ++++++++++
>  drivers/clk/starfive/clk-starfive-jh71x0.h    | 131 ++++
>  drivers/reset/Kconfig                         |   8 +-
>  drivers/reset/Makefile                        |   2 +-
>  drivers/reset/reset-starfive-jh7100.c         | 173 -----
>  drivers/reset/starfive/Kconfig                |  20 +
>  drivers/reset/starfive/Makefile               |   5 +
>  .../reset/starfive/reset-starfive-jh7100.c    |  74 ++
>  .../reset/starfive/reset-starfive-jh7110.c    |  70 ++
>  .../reset/starfive/reset-starfive-jh71x0.c    | 131 ++++
>  .../reset/starfive/reset-starfive-jh71x0.h    |  14 +
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 221 ++++++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 154 ++++
>  33 files changed, 3370 insertions(+), 865 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh71=
10-aoncrg.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh71=
10-syscrg.yaml
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfi=
ve-2-v1.2a.dts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfi=
ve-2-v1.3b.dts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfi=
ve-2.dtsi
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi
>  delete mode 100644 drivers/clk/starfive/clk-starfive-jh7100.h
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-aon.c
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-sys.c
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.c
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.h
>  delete mode 100644 drivers/reset/reset-starfive-jh7100.c
>  create mode 100644 drivers/reset/starfive/Kconfig
>  create mode 100644 drivers/reset/starfive/Makefile
>  create mode 100644 drivers/reset/starfive/reset-starfive-jh7100.c
>  create mode 100644 drivers/reset/starfive/reset-starfive-jh7110.c
>  create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.c
>  create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.h
>  create mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
>  create mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
>=20
>=20
> base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
> --=20
> 2.38.1
>=20

--XrvLcEVwIxWnDgFn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBo32gAKCRB4tDGHoIJi
0oehAQCLUkE37f1Hy5NcTttlUdXD++1x3tsxXB888RW2R0ZEjwD9Hq8/ZoRm0UOP
ZCtx876tQvTAYdbLP+K9M8D0frYAyQg=
=fOK2
-----END PGP SIGNATURE-----

--XrvLcEVwIxWnDgFn--
