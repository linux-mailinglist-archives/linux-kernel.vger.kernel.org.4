Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF5C713FAF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 21:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjE1Tr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 15:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjE1Try (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 15:47:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6D79C;
        Sun, 28 May 2023 12:47:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26F7461FCE;
        Sun, 28 May 2023 19:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03394C433D2;
        Sun, 28 May 2023 19:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303271;
        bh=ZzGHnPTlV/Bxs06dUofKyBmK6Ttg9X4cAGBZOFhYuUI=;
        h=From:To:Cc:Subject:Date:From;
        b=mINEIG0Vp4c1jUVtsFNaYyOnatYzbKKIVc2J8DrQlrwuMc1Rytzhf4V1j9F5afysq
         +J0BDMBy+T0MO8MH+Q1fvJdIuMcAc1fLpqVbm7+LlWiVyx0OZZEoAchxKh1QNkqmVr
         P5aGcpPuln5lQrqLkyLqKhOl6lIf9YVyXubfkl5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.15 00/69] 5.15.114-rc1 review
Date:   Sun, 28 May 2023 20:11:20 +0100
Message-Id: <20230528190828.358612414@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.114-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.114-rc1
X-KernelTest-Deadline: 2023-05-30T19:08+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.15.114 release.
There are 69 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.114-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.114-rc1

David Epping <david.epping@missinglinkelectronics.com>
    net: phy: mscc: add VSC8502 to MODULE_DEVICE_TABLE

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    3c589_cs: Fix an error handling path in tc589_probe()

Sen Chu <sen.chu@mediatek.com>
    regulator: mt6359: add read check for PMIC MT6359

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_ffa: Set reserved/MBZ fields to zero in the memory descriptors

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    arm64: dts: imx8mn-var-som: fix PHY detection bug by adding deassert delay

Shay Drory <shayd@nvidia.com>
    net/mlx5: Devcom, fix error flow in mlx5_devcom_register_device

Roi Dayan <roid@nvidia.com>
    net/mlx5: Fix error message when failing to allocate device memory

Yevgeny Kliteynik <kliteyn@nvidia.com>
    net/mlx5: DR, Check force-loopback RC QP capability independently from RoCE

Erez Shitrit <erezsh@nvidia.com>
    net/mlx5: DR, Fix crc32 calculation to work on big-endian (BE) CPUs

Jakub Kicinski <kuba@kernel.org>
    net/mlx5e: do as little as possible in napi poll when budget is 0

Dan Carpenter <dan.carpenter@linaro.org>
    platform/mellanox: mlxbf-pmc: fix sscanf() error checking

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    forcedeth: Fix an error handling path in nv_probe()

Xin Long <lucien.xin@gmail.com>
    sctp: fix an issue that plpmtu can never go to complete state

Cezary Rojewski <cezary.rojewski@intel.com>
    ASoC: Intel: Skylake: Fix declaration of enum skl_ch_cfg

Vernon Lovejoy <vlovejoy@redhat.com>
    x86/show_trace_log_lvl: Ensure stack pointer is aligned, again

Dan Carpenter <dan.carpenter@linaro.org>
    xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()

Dan Carpenter <dan.carpenter@linaro.org>
    coresight: Fix signedness bug in tmc_etr_buf_insert_barrier_packet()

Alexander Stein <alexander.stein@ew.tq-group.com>
    regulator: pca9450: Fix BUCK2 enable_mask

Hao Ge <gehao@kylinos.cn>
    fs: fix undefined behavior in bit shift for SB_NOUSER

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_ffa: Fix FFA device names for logical partitions

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_ffa: Check if ffa_driver remove is present before executing

Daisuke Nojiri <dnojiri@chromium.org>
    power: supply: sbs-charger: Fix INHIBITED bit for Status reg

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Add cache parameter to bq27xxx_battery_current_and_status()

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Fix poll_interval handling and races on remove

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Fix I2C IRQ race on remove

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition

Kang Chen <void0red@gmail.com>
    power: supply: mt6360: add a check of devm_work_autocancel in mt6360_charger_probe

Hans de Goede <hdegoede@redhat.com>
    power: supply: leds: Fix blink to LED on transition

Steve French <stfrench@microsoft.com>
    cifs: mapchars mount option ignored

Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
    ipv6: Fix out-of-bounds access in ipv6_find_tlv()

Will Deacon <will@kernel.org>
    bpf: Fix mask generation for 32-bit narrow loads of 64-bit fields

Sunil Goutham <sgoutham@marvell.com>
    octeontx2-pf: Fix TSOv6 offload

Po-Hsu Lin <po-hsu.lin@canonical.com>
    selftests: fib_tests: mute cleanup error message

Pratyush Yadav <ptyadav@amazon.de>
    net: fix skb leak in __skb_tstamp_tx()

Ravulapati Vishnu Vardhan Rao <quic_visr@quicinc.com>
    ASoC: lpass: Fix for KASAN use_after_free out of bounds

Alan Stern <stern@rowland.harvard.edu>
    media: radio-shark: Add endpoint checks

Alan Stern <stern@rowland.harvard.edu>
    USB: sisusbvga: Add endpoint checks

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Add routines for endpoint checks in old drivers

Kuniyuki Iwashima <kuniyu@amazon.com>
    udplite: Fix NULL pointer dereference in __sk_mem_raise_allocated().

Taehee Yoo <ap420073@gmail.com>
    net: fix stack overflow when LRO is disabled for virtual interfaces

Alan Stern <stern@rowland.harvard.edu>
    fbdev: udlfb: Fix endpoint check

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    debugobjects: Don't wake up kswapd from fill_pool()

Zhang Rui <rui.zhang@intel.com>
    x86/topology: Fix erroneous smp_num_siblings on Intel Hybrid platforms

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/uncore: Correct the number of CHAs on SPR

Helge Deller <deller@gmx.de>
    parisc: Fix flush_dcache_page() for usage from irq context

Hardik Garg <hargar@linux.microsoft.com>
    selftests/memfd: Fix unknown type name build failure

Dave Hansen <dave.hansen@linux.intel.com>
    x86/mm: Avoid incomplete Global INVLPG flushes

Frank Li <Frank.Li@nxp.com>
    dt-binding: cdns,usb3: Fix cdns,on-chip-buff-size type

Josef Bacik <josef@toxicpanda.com>
    btrfs: use nofs when cleaning up aborted transactions

Zev Weiss <zev@bewilderbeest.net>
    gpio: mockup: Fix mode of debugfs files

Helge Deller <deller@gmx.de>
    parisc: Allow to reboot machine after system halt

Helge Deller <deller@gmx.de>
    parisc: Handle kgdb breakpoints only in kernel context

Finn Thain <fthain@linux-m68k.org>
    m68k: Move signal frame following exception on 68020/030

Tudor Ambarus <tudor.ambarus@linaro.org>
    net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize

Matthias Kaehlcke <mka@chromium.org>
    ASoC: rt5682: Disable jack detection interrupt during suspend

Haibo Chen <haibo.chen@nxp.com>
    mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works

Bin Li <bin.li@canonical.com>
    ALSA: hda/realtek: Enable headset onLenovo M70/M90

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Fix unhandled register update during auto-suspend period

Adam Stylinski <kungfujesus06@gmail.com>
    ALSA: hda/ca0132: add quirk for EVGA X299 DARK

Peter Collingbourne <pcc@google.com>
    arm64: Also reset KASAN tag if page is not PG_mte_tagged

Roberto Sassu <roberto.sassu@huawei.com>
    ocfs2: Switch to security_inode_init_security()

Christophe Leroy <christophe.leroy@csgroup.eu>
    spi: fsl-cpm: Use 16 bit mode for large transfers with even size

Christophe Leroy <christophe.leroy@csgroup.eu>
    spi: fsl-spi: Re-organise transfer bits_per_word adaptation

Olivier Moysan <olivier.moysan@foss.st.com>
    ARM: dts: stm32: fix AV96 board SAI2 pin muxing on stm32mp15

Gregory Oakes <gregory.oakes@amd.com>
    watchdog: sp5100_tco: Immediately trigger upon starting.

Michal Simek <michal.simek@amd.com>
    dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries

Piyush Mehta <piyush.mehta@xilinx.com>
    dt-bindings: ata: ahci-ceva: convert to yaml

Linyu Yuan <quic_linyyuan@quicinc.com>
    usb: dwc3: fix gadget mode suspend interrupt handler issue

Elson Roy Serrao <quic_eserrao@quicinc.com>
    usb: gadget: Properly configure the device for remote wakeup


-------------

Diffstat:

 .../devicetree/bindings/ata/ahci-ceva.txt          |  63 -------
 .../devicetree/bindings/ata/ceva,ahci-1v84.yaml    | 189 +++++++++++++++++++++
 .../devicetree/bindings/usb/cdns,usb3.yaml         |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi           |   2 +-
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi  |   8 +-
 arch/arm64/mm/copypage.c                           |   3 +-
 arch/m68k/kernel/signal.c                          |  14 +-
 arch/parisc/include/asm/cacheflush.h               |   5 +
 arch/parisc/kernel/cache.c                         |   5 +-
 arch/parisc/kernel/process.c                       |  11 +-
 arch/parisc/kernel/traps.c                         |   4 +-
 arch/x86/events/intel/uncore_snbep.c               |  11 ++
 arch/x86/include/asm/intel-family.h                |   5 +
 arch/x86/kernel/cpu/topology.c                     |   5 +-
 arch/x86/kernel/dumpstack.c                        |   7 +-
 arch/x86/mm/init.c                                 |  25 +++
 drivers/firmware/arm_ffa/bus.c                     |  19 ++-
 drivers/firmware/arm_ffa/driver.c                  |   6 +
 drivers/gpio/gpio-mockup.c                         |   2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   2 +-
 drivers/media/radio/radio-shark.c                  |  10 ++
 drivers/media/radio/radio-shark2.c                 |  10 ++
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  18 +-
 drivers/net/bonding/bond_main.c                    |   8 +-
 drivers/net/ethernet/3com/3c589_cs.c               |  11 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c  |  16 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   2 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |   4 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_ste.c  |   3 +-
 drivers/net/ethernet/nvidia/forcedeth.c            |   1 +
 drivers/net/phy/mscc/mscc_main.c                   |   1 +
 drivers/net/team/team.c                            |   7 +-
 drivers/net/usb/cdc_ncm.c                          |  24 ++-
 drivers/platform/mellanox/mlxbf-pmc.c              |   5 +-
 drivers/power/supply/bq27xxx_battery.c             |  60 ++++---
 drivers/power/supply/bq27xxx_battery_i2c.c         |   3 +-
 drivers/power/supply/mt6360_charger.c              |   4 +-
 drivers/power/supply/power_supply_leds.c           |   5 +-
 drivers/power/supply/sbs-charger.c                 |   2 +-
 drivers/regulator/mt6359-regulator.c               |   7 +-
 drivers/regulator/pca9450-regulator.c              |   4 +-
 drivers/spi/spi-fsl-cpm.c                          |  23 +++
 drivers/spi/spi-fsl-spi.c                          |  53 +++---
 drivers/usb/core/usb.c                             |  76 +++++++++
 drivers/usb/dwc3/core.h                            |   2 +
 drivers/usb/dwc3/gadget.c                          |  10 +-
 drivers/usb/gadget/composite.c                     |  18 ++
 drivers/usb/gadget/configfs.c                      |   3 +
 drivers/usb/gadget/udc/core.c                      |  27 +++
 drivers/usb/gadget/udc/trace.h                     |   5 +
 drivers/usb/misc/sisusbvga/sisusb.c                |  14 ++
 drivers/video/fbdev/udlfb.c                        |  13 +-
 drivers/watchdog/sp5100_tco.c                      |   4 +
 drivers/xen/pvcalls-back.c                         |   9 +-
 fs/btrfs/disk-io.c                                 |   9 +
 fs/cifs/fs_context.c                               |   8 +
 fs/ocfs2/namei.c                                   |   2 +
 fs/ocfs2/xattr.c                                   |  30 +++-
 include/linux/arm_ffa.h                            |   1 +
 include/linux/fs.h                                 |  42 ++---
 include/linux/if_team.h                            |   1 +
 include/linux/mlx5/mlx5_ifc.h                      |   4 +-
 include/linux/power/bq27xxx_battery.h              |   1 +
 include/linux/usb.h                                |   5 +
 include/linux/usb/composite.h                      |   2 +
 include/linux/usb/gadget.h                         |   8 +
 include/net/bonding.h                              |   1 +
 include/uapi/sound/skl-tplg-interface.h            |   3 +-
 kernel/bpf/verifier.c                              |   2 +-
 lib/debugobjects.c                                 |   2 +-
 net/core/skbuff.c                                  |   4 +-
 net/ipv4/udplite.c                                 |   2 +
 net/ipv6/exthdrs_core.c                            |   2 +
 net/ipv6/udplite.c                                 |   2 +
 net/sctp/transport.c                               |  11 +-
 sound/hda/hdac_device.c                            |   2 +-
 sound/pci/hda/patch_ca0132.c                       |   1 +
 sound/pci/hda/patch_realtek.c                      |   2 +
 sound/soc/codecs/lpass-tx-macro.c                  |   5 +
 sound/soc/codecs/rt5682-i2c.c                      |   4 +-
 sound/soc/codecs/rt5682.c                          |   6 +
 sound/soc/codecs/rt5682.h                          |   1 +
 tools/testing/selftests/memfd/fuse_test.c          |   1 +
 tools/testing/selftests/net/fib_tests.sh           |   2 +-
 87 files changed, 789 insertions(+), 238 deletions(-)


