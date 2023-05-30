Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5CB7161C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjE3N1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjE3N1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:27:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2FFE;
        Tue, 30 May 2023 06:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ADE762885;
        Tue, 30 May 2023 13:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68966C433A0;
        Tue, 30 May 2023 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685453263;
        bh=2XUQorytkR3aaj43V2pcHtL+tcfVsStmT+TauREsQog=;
        h=From:To:Cc:Subject:Date:From;
        b=oYSQA6mF/l+dIYFZP8bjahJJTYZolV4A55rUMb4LmTFyQjJzHbIg4SDabEHpTNK9d
         e+CqEEBewOeAN7+4A+PMHs8ZZYFhVBMqcvX0GkJF0KI7MpZ9GMOL2ine1cL0YXwykn
         p2Bz2J/tqiDZp+SDnNnRZPZEu4O/M+nzfYTx1SLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.31
Date:   Tue, 30 May 2023 14:27:37 +0100
Message-Id: <2023053037-juice-scrawny-83c3@gregkh>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.31 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/usb/cdns,usb3.yaml        |    2 
 Makefile                                                    |    2 
 arch/arm/boot/dts/imx6qdl-mba6.dtsi                         |    1 
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi           |    8 
 arch/arm64/mm/copypage.c                                    |    5 
 arch/m68k/kernel/signal.c                                   |   14 
 arch/parisc/Kconfig                                         |    4 
 arch/parisc/include/asm/cacheflush.h                        |    4 
 arch/parisc/kernel/alternative.c                            |    2 
 arch/parisc/kernel/cache.c                                  |    5 
 arch/parisc/kernel/process.c                                |   11 
 arch/parisc/kernel/traps.c                                  |    8 
 arch/x86/events/intel/uncore_snbep.c                        |   11 
 arch/x86/kernel/cpu/topology.c                              |    5 
 arch/x86/kernel/dumpstack.c                                 |    7 
 arch/x86/mm/init.c                                          |   25 +
 arch/x86/pci/xen.c                                          |    8 
 arch/xtensa/kernel/signal.c                                 |   35 +-
 arch/xtensa/kernel/xtensa_ksyms.c                           |    4 
 arch/xtensa/lib/Makefile                                    |    2 
 arch/xtensa/lib/bswapdi2.S                                  |   21 +
 arch/xtensa/lib/bswapsi2.S                                  |   16 +
 drivers/android/binder.c                                    |   28 +
 drivers/android/binder_alloc.c                              |   64 +---
 drivers/android/binder_alloc.h                              |    4 
 drivers/android/binder_alloc_selftest.c                     |    2 
 drivers/char/tpm/tpm-chip.c                                 |   52 ++-
 drivers/char/tpm/tpm-interface.c                            |   10 
 drivers/char/tpm/tpm.h                                      |    1 
 drivers/char/tpm/tpm_tis.c                                  |    2 
 drivers/char/tpm/tpm_tis_core.c                             |  187 ++++++------
 drivers/char/tpm/tpm_tis_core.h                             |    3 
 drivers/cxl/core/pci.c                                      |   85 ++++-
 drivers/cxl/cxlpci.h                                        |    2 
 drivers/firmware/arm_ffa/bus.c                              |   19 -
 drivers/firmware/arm_ffa/driver.c                           |    6 
 drivers/gpio/gpio-mockup.c                                  |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                     |    9 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                      |    1 
 drivers/gpu/drm/amd/display/dc/core/dc_link.c               |    9 
 drivers/gpu/drm/amd/display/dc/dc_types.h                   |    6 
 drivers/gpu/drm/amd/include/mes_v11_api_def.h               |    6 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                          |   12 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c        |    1 
 drivers/gpu/drm/drm_managed.c                               |   22 -
 drivers/gpu/drm/mgag200/mgag200_mode.c                      |    5 
 drivers/gpu/drm/radeon/radeon_irq_kms.c                     |   10 
 drivers/hwtracing/coresight/coresight-tmc-etr.c             |    2 
 drivers/irqchip/irq-mips-gic.c                              |   32 +-
 drivers/media/radio/radio-shark.c                           |   10 
 drivers/media/radio/radio-shark2.c                          |   10 
 drivers/mmc/core/block.c                                    |    5 
 drivers/mmc/host/sdhci-esdhc-imx.c                          |   18 -
 drivers/net/bonding/bond_main.c                             |    8 
 drivers/net/dsa/mv88e6xxx/chip.c                            |    2 
 drivers/net/dsa/mv88e6xxx/port.c                            |    9 
 drivers/net/dsa/mv88e6xxx/port.h                            |    2 
 drivers/net/ethernet/3com/3c589_cs.c                        |   11 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c      |    4 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c               |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c   |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c             |   23 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c             |   19 -
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c           |   16 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h           |    4 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c  |    7 
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c        |   70 +++-
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h        |    1 
 drivers/net/ethernet/mellanox/mlx5/core/main.c              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c   |    4 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c   |    3 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c       |   10 
 drivers/net/ethernet/nvidia/forcedeth.c                     |    1 
 drivers/net/phy/mscc/mscc_main.c                            |    1 
 drivers/net/team/team.c                                     |    7 
 drivers/net/usb/cdc_ncm.c                                   |   24 -
 drivers/platform/mellanox/mlxbf-pmc.c                       |    5 
 drivers/platform/x86/hp/hp-wmi.c                            |    2 
 drivers/platform/x86/intel/ifs/load.c                       |    2 
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c |   12 
 drivers/power/supply/axp288_fuel_gauge.c                    |    2 
 drivers/power/supply/bq24190_charger.c                      |    1 
 drivers/power/supply/bq25890_charger.c                      |    5 
 drivers/power/supply/bq27xxx_battery.c                      |  175 ++++++-----
 drivers/power/supply/bq27xxx_battery_i2c.c                  |    3 
 drivers/power/supply/mt6360_charger.c                       |    4 
 drivers/power/supply/power_supply_leds.c                    |    5 
 drivers/power/supply/sbs-charger.c                          |    2 
 drivers/regulator/mt6359-regulator.c                        |    7 
 drivers/regulator/pca9450-regulator.c                       |    4 
 drivers/tee/optee/smc_abi.c                                 |    4 
 drivers/usb/core/usb.c                                      |   76 ++++
 drivers/usb/dwc3/core.h                                     |    2 
 drivers/usb/dwc3/gadget.c                                   |   10 
 drivers/usb/misc/sisusbvga/sisusb.c                         |   14 
 drivers/video/fbdev/udlfb.c                                 |   13 
 drivers/watchdog/sp5100_tco.c                               |    4 
 drivers/xen/pvcalls-back.c                                  |    9 
 fs/btrfs/disk-io.c                                          |    9 
 fs/cifs/fs_context.c                                        |    8 
 fs/ocfs2/namei.c                                            |    2 
 fs/ocfs2/xattr.c                                            |   30 +
 include/drm/drm_managed.h                                   |   18 +
 include/linux/arm_ffa.h                                     |    1 
 include/linux/fs.h                                          |   42 +-
 include/linux/if_team.h                                     |    1 
 include/linux/mlx5/mlx5_ifc.h                               |    4 
 include/linux/msi.h                                         |    9 
 include/linux/power/bq27xxx_battery.h                       |    4 
 include/linux/tpm.h                                         |   14 
 include/linux/usb.h                                         |    5 
 include/net/bonding.h                                       |    1 
 include/uapi/sound/skl-tplg-interface.h                     |    3 
 kernel/bpf/hashtab.c                                        |    6 
 kernel/bpf/verifier.c                                       |    2 
 kernel/irq/msi.c                                            |    4 
 lib/debugobjects.c                                          |    2 
 net/core/skbuff.c                                           |   56 +--
 net/ipv4/udplite.c                                          |    2 
 net/ipv6/exthdrs_core.c                                     |    2 
 net/ipv6/udplite.c                                          |    2 
 net/sctp/transport.c                                        |   11 
 net/smc/af_smc.c                                            |    9 
 net/smc/smc_core.c                                          |    1 
 net/sunrpc/sched.c                                          |    5 
 sound/hda/hdac_device.c                                     |    2 
 sound/pci/hda/patch_ca0132.c                                |    1 
 sound/pci/hda/patch_realtek.c                               |    2 
 sound/soc/codecs/lpass-tx-macro.c                           |    5 
 sound/soc/codecs/rt5682-i2c.c                               |    4 
 sound/soc/codecs/rt5682.c                                   |    6 
 sound/soc/codecs/rt5682.h                                   |    1 
 sound/soc/intel/avs/apl.c                                   |    6 
 sound/soc/intel/avs/messages.h                              |    2 
 tools/testing/selftests/memfd/fuse_test.c                   |    1 
 tools/testing/selftests/net/fib_tests.sh                    |    2 
 138 files changed, 1200 insertions(+), 510 deletions(-)

Adam Stylinski (1):
      ALSA: hda/ca0132: add quirk for EVGA X299 DARK

Alan Stern (4):
      fbdev: udlfb: Fix endpoint check
      USB: core: Add routines for endpoint checks in old drivers
      USB: sisusbvga: Add endpoint checks
      media: radio-shark: Add endpoint checks

Alex Deucher (1):
      drm/radeon: reintroduce radeon_dp_work_func content

Alexander Stein (2):
      regulator: pca9450: Fix BUCK2 enable_mask
      ARM: dts: imx6qdl-mba6: Add missing pvcie-supply regulator

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Access path components under lock

Anton Protopopov (1):
      bpf: fix a memory leak in the LRU and LRU_PERCPU hash maps

Bin Li (1):
      ALSA: hda/realtek: Enable headset onLenovo M70/M90

Carlos Llamas (5):
      Revert "binder_alloc: add missing mmap_lock calls when using the VMA"
      Revert "android: binder: stop saving a pointer to the VMA"
      binder: add lockless binder_alloc_(set|get)_vma()
      binder: fix UAF caused by faulty buffer cleanup
      binder: fix UAF of alloc->vma in race with munmap()

Cezary Rojewski (2):
      ASoC: Intel: Skylake: Fix declaration of enum skl_ch_cfg
      ASoC: Intel: avs: Fix declaration of enum avs_channel_config

Christian Loehle (1):
      mmc: block: ensure error propagation for non-blk

Christophe JAILLET (2):
      forcedeth: Fix an error handling path in nv_probe()
      3c589_cs: Fix an error handling path in tc589_probe()

Daisuke Nojiri (1):
      power: supply: sbs-charger: Fix INHIBITED bit for Status reg

Dan Carpenter (3):
      coresight: Fix signedness bug in tmc_etr_buf_insert_barrier_packet()
      xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()
      platform/mellanox: mlxbf-pmc: fix sscanf() error checking

Dave Hansen (1):
      x86/mm: Avoid incomplete Global INVLPG flushes

Dave Jiang (1):
      cxl: Wait Memory_Info_Valid before access memory related info

David Arcari (1):
      platform/x86/intel/ifs: Annotate work queue on stack so object debug does not complain

David Epping (1):
      net: phy: mscc: add VSC8502 to MODULE_DEVICE_TABLE

Erez Shitrit (1):
      net/mlx5: DR, Fix crc32 calculation to work on big-endian (BE) CPUs

Etienne Carriere (1):
      optee: fix uninited async notif value

Evan Quan (1):
      drm/amd/pm: add missing NotifyPowerSource message mapping for SMU13.0.7

Finn Thain (1):
      m68k: Move signal frame following exception on 68020/030

Frank Li (1):
      dt-binding: cdns,usb3: Fix cdns,on-chip-buff-size type

Gavrilov Ilia (1):
      ipv6: Fix out-of-bounds access in ipv6_find_tlv()

Greg Kroah-Hartman (1):
      Linux 6.1.31

Gregory Oakes (1):
      watchdog: sp5100_tco: Immediately trigger upon starting.

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works

Hans de Goede (13):
      platform/x86: hp-wmi: Fix cast to smaller integer type warning
      power: supply: axp288_fuel_gauge: Fix external_power_changed race
      power: supply: bq25890: Fix external_power_changed race
      power: supply: leds: Fix blink to LED on transition
      power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition
      power: supply: bq27xxx: Fix I2C IRQ race on remove
      power: supply: bq27xxx: Fix poll_interval handling and races on remove
      power: supply: bq27xxx: Add cache parameter to bq27xxx_battery_current_and_status()
      power: supply: bq27xxx: Move bq27xxx_battery_update() down
      power: supply: bq27xxx: Ensure power_supply_changed() is called on current sign changes
      power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize
      power: supply: bq25890: Call power_supply_changed() after updating input current or voltage
      power: supply: bq24190: Call power_supply_changed() after updating input current

Hao Ge (1):
      fs: fix undefined behavior in bit shift for SB_NOUSER

Hardik Garg (1):
      selftests/memfd: Fix unknown type name build failure

Helge Deller (6):
      parisc: Use num_present_cpus() in alternative patching code
      parisc: Handle kgdb breakpoints only in kernel context
      parisc: Fix flush_dcache_page() for usage from irq context
      parisc: Allow to reboot machine after system halt
      parisc: Enable LOCKDEP support
      parisc: Handle kprobes breakpoints only in kernel context

Horatiu Vultur (1):
      lan966x: Fix unloading/loading of the driver

Hugo Villeneuve (1):
      arm64: dts: imx8mn-var-som: fix PHY detection bug by adding deassert delay

Jack Xiao (3):
      drm/amd/amdgpu: update mes11 api def
      drm/amdgpu/mes11: enable reg active poll
      drm/amd/amdgpu: limit one queue per gang

Jakub Kicinski (1):
      net/mlx5e: do as little as possible in napi poll when budget is 0

Jarkko Sakkinen (3):
      tpm_tis: Use tpm_chip_{start,stop} decoration inside tpm_tis_resume
      tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM drivers
      tpm: Prevent hwrng from activating during resume

Jiaxun Yang (2):
      irqchip/mips-gic: Don't touch vl_map if a local interrupt is not routable
      irqchip/mips-gic: Use raw spinlock for gic_lock

Jocelyn Falempe (1):
      drm/mgag200: Fix gamma lut not initialized.

Jonatas Esteves (1):
      drm/amd/pm: Fix output of pp_od_clk_voltage

Josef Bacik (1):
      btrfs: use nofs when cleaning up aborted transactions

Kan Liang (1):
      perf/x86/uncore: Correct the number of CHAs on SPR

Kang Chen (1):
      power: supply: mt6360: add a check of devm_work_autocancel in mt6360_charger_probe

Kees Cook (1):
      skbuff: Proactively round up to kmalloc bucket size

Kuniyuki Iwashima (1):
      udplite: Fix NULL pointer dereference in __sk_mem_raise_allocated().

Lino Sanfilippo (3):
      tpm, tpm_tis: Avoid cache incoherency in test for interrupts
      tpm, tpm_tis: Only handle supported interrupts
      tpm, tpm_tis: startup chip before testing for interrupts

Linyu Yuan (1):
      usb: dwc3: fix gadget mode suspend interrupt handler issue

Matthew Auld (1):
      drm: fix drmm_mutex_init()

Matthias Kaehlcke (1):
      ASoC: rt5682: Disable jack detection interrupt during suspend

Max Filippov (2):
      xtensa: fix signal delivery to FDPIC process
      xtensa: add __bswap{si,di}2 helpers

Maximilian Heyne (1):
      x86/pci/xen: populate MSI sysfs entries

Peter Collingbourne (1):
      arm64: Also reset KASAN tag if page is not PG_mte_tagged

Po-Hsu Lin (1):
      selftests: fib_tests: mute cleanup error message

Pratyush Yadav (1):
      net: fix skb leak in __skb_tstamp_tx()

Rahul Rameshbabu (1):
      net/mlx5e: Fix SQ wake logic in ptp napi_poll context

Ravulapati Vishnu Vardhan Rao (1):
      ASoC: lpass: Fix for KASAN use_after_free out of bounds

Roberto Sassu (1):
      ocfs2: Switch to security_inode_init_security()

Robin Chen (1):
      drm/amd/display: hpd rx irq not working with eDP interface

Roi Dayan (1):
      net/mlx5: Fix error message when failing to allocate device memory

Sen Chu (1):
      regulator: mt6359: add read check for PMIC MT6359

Shay Drory (4):
      net/mlx5: Handle pairing of E-switch via uplink un/load APIs
      net/mlx5: Collect command failures data only for known commands
      net/mlx5: Devcom, fix error flow in mlx5_devcom_register_device
      net/mlx5: Devcom, serialize devcom registration

Steffen Bätz (1):
      net: dsa: mv88e6xxx: Add RGMII delay to 88E6320

Steve French (1):
      cifs: mapchars mount option ignored

Steve Wahl (1):
      platform/x86: ISST: Remove 8 socket limit

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

Trond Myklebust (1):
      SUNRPC: Don't change task->tk_status after the call to rpc_exit_task

Tudor Ambarus (1):
      net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize

Vernon Lovejoy (1):
      x86/show_trace_log_lvl: Ensure stack pointer is aligned, again

Vlad Buslov (2):
      net/mlx5e: Fix deadlock in tc route query code
      net/mlx5e: Use correct encap attribute during invalidation

Wen Gu (1):
      net/smc: Reset connection when trying to use SMCRv2 fails.

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

