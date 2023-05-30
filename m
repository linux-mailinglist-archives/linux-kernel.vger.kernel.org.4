Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC37161C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjE3N1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjE3N1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:27:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49E6A1;
        Tue, 30 May 2023 06:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6122862A81;
        Tue, 30 May 2023 13:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77520C433EF;
        Tue, 30 May 2023 13:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685453254;
        bh=Mo1+AfNhI0vTwMA0zYdczMxO91+TRK8k5wCauaGxYsY=;
        h=From:To:Cc:Subject:Date:From;
        b=TdhxqSaEzvDTsbPPzhvtgNiJa0qZGo8updvS9czvagciAc0PI+DrpT0TeZPF5EqEs
         xcwFockX7WZEtV1Fe+I/xDgHxzyouz5ejWednJYAM8qYexaDHtEP2DXm7bwfilA6Yz
         QH4MzdGk77hjoPS7C88GTDYSrstH29M7E5qNmmCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.114
Date:   Tue, 30 May 2023 14:27:31 +0100
Message-Id: <2023053031-outlook-calm-6547@gregkh>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.15.114 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/ata/ahci-ceva.txt       |   63 ----
 Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml |  189 ++++++++++++++
 Documentation/devicetree/bindings/usb/cdns,usb3.yaml      |    2 
 Makefile                                                  |    2 
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi                  |    2 
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi         |    8 
 arch/arm64/mm/copypage.c                                  |    3 
 arch/m68k/kernel/signal.c                                 |   14 -
 arch/parisc/include/asm/cacheflush.h                      |    5 
 arch/parisc/kernel/cache.c                                |    5 
 arch/parisc/kernel/process.c                              |   11 
 arch/parisc/kernel/traps.c                                |    4 
 arch/x86/events/intel/uncore_snbep.c                      |   11 
 arch/x86/include/asm/intel-family.h                       |    5 
 arch/x86/kernel/cpu/topology.c                            |    5 
 arch/x86/kernel/dumpstack.c                               |    7 
 arch/x86/mm/init.c                                        |   25 +
 drivers/firmware/arm_ffa/bus.c                            |   19 +
 drivers/firmware/arm_ffa/driver.c                         |    6 
 drivers/gpio/gpio-mockup.c                                |    2 
 drivers/hwtracing/coresight/coresight-tmc-etr.c           |    2 
 drivers/media/radio/radio-shark.c                         |   10 
 drivers/media/radio/radio-shark2.c                        |   10 
 drivers/mmc/host/sdhci-esdhc-imx.c                        |   18 -
 drivers/net/bonding/bond_main.c                           |    8 
 drivers/net/ethernet/3com/3c589_cs.c                      |   11 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c    |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c         |   16 -
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c      |    3 
 drivers/net/ethernet/mellanox/mlx5/core/main.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c |    4 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c |    3 
 drivers/net/ethernet/nvidia/forcedeth.c                   |    1 
 drivers/net/phy/mscc/mscc_main.c                          |    1 
 drivers/net/team/team.c                                   |    7 
 drivers/net/usb/cdc_ncm.c                                 |   24 +
 drivers/platform/mellanox/mlxbf-pmc.c                     |    5 
 drivers/power/supply/bq27xxx_battery.c                    |   60 ++--
 drivers/power/supply/bq27xxx_battery_i2c.c                |    3 
 drivers/power/supply/mt6360_charger.c                     |    4 
 drivers/power/supply/power_supply_leds.c                  |    5 
 drivers/power/supply/sbs-charger.c                        |    2 
 drivers/regulator/mt6359-regulator.c                      |    7 
 drivers/regulator/pca9450-regulator.c                     |    4 
 drivers/spi/spi-fsl-cpm.c                                 |   23 +
 drivers/spi/spi-fsl-spi.c                                 |   53 +--
 drivers/usb/core/usb.c                                    |   76 +++++
 drivers/usb/dwc3/core.h                                   |    2 
 drivers/usb/dwc3/gadget.c                                 |   10 
 drivers/usb/gadget/composite.c                            |   18 +
 drivers/usb/gadget/configfs.c                             |    3 
 drivers/usb/gadget/udc/core.c                             |   27 ++
 drivers/usb/gadget/udc/trace.h                            |    5 
 drivers/usb/misc/sisusbvga/sisusb.c                       |   14 +
 drivers/video/fbdev/udlfb.c                               |   13 
 drivers/watchdog/sp5100_tco.c                             |    4 
 drivers/xen/pvcalls-back.c                                |    9 
 fs/btrfs/disk-io.c                                        |    9 
 fs/cifs/fs_context.c                                      |    8 
 fs/ocfs2/namei.c                                          |    2 
 fs/ocfs2/xattr.c                                          |   30 +-
 include/linux/arm_ffa.h                                   |    1 
 include/linux/fs.h                                        |   42 +--
 include/linux/if_team.h                                   |    1 
 include/linux/mlx5/mlx5_ifc.h                             |    4 
 include/linux/power/bq27xxx_battery.h                     |    1 
 include/linux/usb.h                                       |    5 
 include/linux/usb/composite.h                             |    2 
 include/linux/usb/gadget.h                                |    8 
 include/net/bonding.h                                     |    1 
 include/uapi/sound/skl-tplg-interface.h                   |    3 
 kernel/bpf/verifier.c                                     |    2 
 lib/debugobjects.c                                        |    2 
 net/core/skbuff.c                                         |    4 
 net/ipv4/udplite.c                                        |    2 
 net/ipv6/exthdrs_core.c                                   |    2 
 net/ipv6/udplite.c                                        |    2 
 net/sctp/transport.c                                      |   11 
 sound/hda/hdac_device.c                                   |    2 
 sound/pci/hda/patch_ca0132.c                              |    1 
 sound/pci/hda/patch_realtek.c                             |    2 
 sound/soc/codecs/lpass-tx-macro.c                         |    5 
 sound/soc/codecs/rt5682-i2c.c                             |    4 
 sound/soc/codecs/rt5682.c                                 |    6 
 sound/soc/codecs/rt5682.h                                 |    1 
 tools/testing/selftests/memfd/fuse_test.c                 |    1 
 tools/testing/selftests/net/fib_tests.sh                  |    2 
 87 files changed, 788 insertions(+), 237 deletions(-)

Adam Stylinski (1):
      ALSA: hda/ca0132: add quirk for EVGA X299 DARK

Alan Stern (4):
      fbdev: udlfb: Fix endpoint check
      USB: core: Add routines for endpoint checks in old drivers
      USB: sisusbvga: Add endpoint checks
      media: radio-shark: Add endpoint checks

Alexander Stein (1):
      regulator: pca9450: Fix BUCK2 enable_mask

Bin Li (1):
      ALSA: hda/realtek: Enable headset onLenovo M70/M90

Cezary Rojewski (1):
      ASoC: Intel: Skylake: Fix declaration of enum skl_ch_cfg

Christophe JAILLET (2):
      forcedeth: Fix an error handling path in nv_probe()
      3c589_cs: Fix an error handling path in tc589_probe()

Christophe Leroy (2):
      spi: fsl-spi: Re-organise transfer bits_per_word adaptation
      spi: fsl-cpm: Use 16 bit mode for large transfers with even size

Daisuke Nojiri (1):
      power: supply: sbs-charger: Fix INHIBITED bit for Status reg

Dan Carpenter (3):
      coresight: Fix signedness bug in tmc_etr_buf_insert_barrier_packet()
      xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()
      platform/mellanox: mlxbf-pmc: fix sscanf() error checking

Dave Hansen (1):
      x86/mm: Avoid incomplete Global INVLPG flushes

David Epping (1):
      net: phy: mscc: add VSC8502 to MODULE_DEVICE_TABLE

Elson Roy Serrao (1):
      usb: gadget: Properly configure the device for remote wakeup

Erez Shitrit (1):
      net/mlx5: DR, Fix crc32 calculation to work on big-endian (BE) CPUs

Finn Thain (1):
      m68k: Move signal frame following exception on 68020/030

Frank Li (1):
      dt-binding: cdns,usb3: Fix cdns,on-chip-buff-size type

Gavrilov Ilia (1):
      ipv6: Fix out-of-bounds access in ipv6_find_tlv()

Greg Kroah-Hartman (1):
      Linux 5.15.114

Gregory Oakes (1):
      watchdog: sp5100_tco: Immediately trigger upon starting.

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works

Hans de Goede (5):
      power: supply: leds: Fix blink to LED on transition
      power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition
      power: supply: bq27xxx: Fix I2C IRQ race on remove
      power: supply: bq27xxx: Fix poll_interval handling and races on remove
      power: supply: bq27xxx: Add cache parameter to bq27xxx_battery_current_and_status()

Hao Ge (1):
      fs: fix undefined behavior in bit shift for SB_NOUSER

Hardik Garg (1):
      selftests/memfd: Fix unknown type name build failure

Helge Deller (3):
      parisc: Handle kgdb breakpoints only in kernel context
      parisc: Allow to reboot machine after system halt
      parisc: Fix flush_dcache_page() for usage from irq context

Hugo Villeneuve (1):
      arm64: dts: imx8mn-var-som: fix PHY detection bug by adding deassert delay

Jakub Kicinski (1):
      net/mlx5e: do as little as possible in napi poll when budget is 0

Josef Bacik (1):
      btrfs: use nofs when cleaning up aborted transactions

Kan Liang (1):
      perf/x86/uncore: Correct the number of CHAs on SPR

Kang Chen (1):
      power: supply: mt6360: add a check of devm_work_autocancel in mt6360_charger_probe

Kuniyuki Iwashima (1):
      udplite: Fix NULL pointer dereference in __sk_mem_raise_allocated().

Linyu Yuan (1):
      usb: dwc3: fix gadget mode suspend interrupt handler issue

Matthias Kaehlcke (1):
      ASoC: rt5682: Disable jack detection interrupt during suspend

Michal Simek (1):
      dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries

Olivier Moysan (1):
      ARM: dts: stm32: fix AV96 board SAI2 pin muxing on stm32mp15

Peter Collingbourne (1):
      arm64: Also reset KASAN tag if page is not PG_mte_tagged

Piyush Mehta (1):
      dt-bindings: ata: ahci-ceva: convert to yaml

Po-Hsu Lin (1):
      selftests: fib_tests: mute cleanup error message

Pratyush Yadav (1):
      net: fix skb leak in __skb_tstamp_tx()

Ravulapati Vishnu Vardhan Rao (1):
      ASoC: lpass: Fix for KASAN use_after_free out of bounds

Roberto Sassu (1):
      ocfs2: Switch to security_inode_init_security()

Roi Dayan (1):
      net/mlx5: Fix error message when failing to allocate device memory

Sen Chu (1):
      regulator: mt6359: add read check for PMIC MT6359

Shay Drory (1):
      net/mlx5: Devcom, fix error flow in mlx5_devcom_register_device

Steve French (1):
      cifs: mapchars mount option ignored

Sudeep Holla (3):
      firmware: arm_ffa: Check if ffa_driver remove is present before executing
      firmware: arm_ffa: Fix FFA device names for logical partitions
      firmware: arm_ffa: Set reserved/MBZ fields to zero in the memory descriptors

Sunil Goutham (1):
      octeontx2-pf: Fix TSOv6 offload

Taehee Yoo (1):
      net: fix stack overflow when LRO is disabled for virtual interfaces

Takashi Iwai (1):
      ALSA: hda: Fix unhandled register update during auto-suspend period

Tetsuo Handa (1):
      debugobjects: Don't wake up kswapd from fill_pool()

Tudor Ambarus (1):
      net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize

Vernon Lovejoy (1):
      x86/show_trace_log_lvl: Ensure stack pointer is aligned, again

Will Deacon (1):
      bpf: Fix mask generation for 32-bit narrow loads of 64-bit fields

Xin Long (1):
      sctp: fix an issue that plpmtu can never go to complete state

Yevgeny Kliteynik (1):
      net/mlx5: DR, Check force-loopback RC QP capability independently from RoCE

Zev Weiss (1):
      gpio: mockup: Fix mode of debugfs files

Zhang Rui (1):
      x86/topology: Fix erroneous smp_num_siblings on Intel Hybrid platforms

