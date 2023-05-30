Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28C07161CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjE3N2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjE3N2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:28:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E99C7;
        Tue, 30 May 2023 06:27:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 611B16246A;
        Tue, 30 May 2023 13:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF0DC433D2;
        Tue, 30 May 2023 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685453269;
        bh=bdTQG4tpS11dA5QUah8B6fZQv3xBfZD4noxakU3bHhM=;
        h=From:To:Cc:Subject:Date:From;
        b=xiDQM+bLOfWJmORxnJNRxR3dYuQwyjp64q+aQ2EmteRYGTs0Y9ebayn90nqyzOCwi
         3Ks+kBnTN5pBgBfWROeUO1CZqQf9tVNZH+oDpFsSpi4+EQbOj+zZZ95SPu67WbI1vx
         ghXjsGe2we5hBuZH58sxMn4iiWKe7j6DQfpWBUIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.3.5
Date:   Tue, 30 May 2023 14:27:43 +0100
Message-Id: <2023053044-geriatric-pegboard-f00a@gregkh>
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

I'm announcing the release of the 6.3.5 kernel.

All users of the 6.3 kernel series must upgrade.

The updated 6.3.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.3.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/usb/cdns,usb3.yaml        |    2 
 Makefile                                                    |    2 
 arch/arm/boot/dts/imx6qdl-mba6.dtsi                         |    1 
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi           |    8 
 arch/arm64/boot/dts/freescale/imx8mp.dtsi                   |    2 
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
 block/blk-map.c                                             |    2 
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
 drivers/cxl/core/mbox.c                                     |   15 
 drivers/cxl/core/pci.c                                      |  112 ++++++-
 drivers/cxl/cxl.h                                           |    1 
 drivers/cxl/cxlmem.h                                        |    2 
 drivers/cxl/cxlpci.h                                        |    2 
 drivers/cxl/mem.c                                           |    3 
 drivers/cxl/pci.c                                           |    6 
 drivers/cxl/port.c                                          |   20 -
 drivers/firmware/arm_ffa/bus.c                              |   19 -
 drivers/firmware/arm_ffa/driver.c                           |    6 
 drivers/gpio/gpio-mockup.c                                  |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                     |    9 
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c                      |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |    4 
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
 drivers/net/ethernet/3com/3c589_cs.c                        |   11 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c      |    4 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                 |    8 
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
 drivers/net/wireless/realtek/rtw89/mac.c                    |    4 
 drivers/net/wireless/realtek/rtw89/mac.h                    |    2 
 drivers/net/wireless/realtek/rtw89/rtw8852b.c               |   22 -
 drivers/platform/mellanox/mlxbf-pmc.c                       |    5 
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
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c     |    4 
 drivers/usb/core/usb.c                                      |   76 ++++
 drivers/usb/dwc3/core.h                                     |    2 
 drivers/usb/dwc3/gadget.c                                   |   10 
 drivers/usb/misc/sisusbvga/sisusbvga.c                      |   14 
 drivers/video/fbdev/udlfb.c                                 |   13 
 drivers/watchdog/sp5100_tco.c                               |    4 
 drivers/xen/pvcalls-back.c                                  |    9 
 fs/btrfs/disk-io.c                                          |    9 
 fs/cifs/dfs.c                                               |    2 
 fs/cifs/file.c                                              |    3 
 fs/cifs/fs_context.c                                        |    8 
 fs/ocfs2/namei.c                                            |    2 
 fs/ocfs2/xattr.c                                            |   30 +
 fs/xfs/libxfs/xfs_bmap.c                                    |    1 
 include/drm/drm_managed.h                                   |   18 +
 include/linux/arm_ffa.h                                     |    1 
 include/linux/fs.h                                          |   42 +-
 include/linux/if_team.h                                     |    1 
 include/linux/mlx5/mlx5_ifc.h                               |    4 
 include/linux/mm.h                                          |   16 +
 include/linux/msi.h                                         |    9 
 include/linux/power/bq27xxx_battery.h                       |    4 
 include/linux/tpm.h                                         |   14 
 include/linux/usb.h                                         |    5 
 include/net/bonding.h                                       |    1 
 include/net/ip.h                                            |    2 
 include/net/page_pool.h                                     |   18 -
 include/uapi/linux/in.h                                     |    1 
 include/uapi/sound/skl-tplg-interface.h                     |    3 
 kernel/bpf/hashtab.c                                        |    6 
 kernel/bpf/verifier.c                                       |    2 
 kernel/irq/msi.c                                            |    4 
 lib/debugobjects.c                                          |    2 
 mm/page_alloc.c                                             |   10 
 mm/sparse-vmemmap.c                                         |    3 
 mm/zsmalloc.c                                               |   36 --
 net/core/page_pool.c                                        |   28 +
 net/core/skbuff.c                                           |    4 
 net/ipv4/ip_sockglue.c                                      |   12 
 net/ipv4/raw.c                                              |    5 
 net/ipv4/udplite.c                                          |    2 
 net/ipv6/exthdrs_core.c                                     |    2 
 net/ipv6/raw.c                                              |    3 
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
 tools/testing/cxl/Kbuild                                    |    1 
 tools/testing/cxl/test/mem.c                                |    1 
 tools/testing/cxl/test/mock.c                               |   15 
 tools/testing/selftests/net/fib_tests.sh                    |    2 
 160 files changed, 1321 insertions(+), 581 deletions(-)

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

Aneesh Kumar K.V (1):
      mm/vmemmap/devdax: fix kernel crash when probing devdax devices

Anton Protopopov (1):
      bpf: fix a memory leak in the LRU and LRU_PERCPU hash maps

Anuj Gupta (1):
      block: fix bio-cache for passthru IO

Arınç ÜNAL (1):
      net: ethernet: mtk_eth_soc: fix QoS on DSA MAC on non MTK_NETSYS_V2 SoCs

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

Dan Williams (1):
      cxl/port: Enable the HDM decoder capability for switch ports

Dave Chinner (1):
      xfs: fix livelock in delayed allocation at ENOSPC

Dave Hansen (1):
      x86/mm: Avoid incomplete Global INVLPG flushes

Dave Jiang (2):
      cxl: Wait Memory_Info_Valid before access memory related info
      cxl: Move cxl_await_media_ready() to before capacity info retrieval

David Arcari (1):
      platform/x86/intel/ifs: Annotate work queue on stack so object debug does not complain

David Epping (1):
      net: phy: mscc: add VSC8502 to MODULE_DEVICE_TABLE

David Howells (1):
      cifs: Fix cifs_limit_bvec_subset() to correctly check the maxmimum size

Erez Shitrit (1):
      net/mlx5: DR, Fix crc32 calculation to work on big-endian (BE) CPUs

Etienne Carriere (1):
      optee: fix uninited async notif value

Evan Quan (1):
      drm/amd/pm: add missing NotifyPowerSource message mapping for SMU13.0.7

Fangzhi Zuo (1):
      drm/amd/display: Have Payload Properly Created After Resume

Finn Thain (1):
      m68k: Move signal frame following exception on 68020/030

Frank Li (1):
      dt-binding: cdns,usb3: Fix cdns,on-chip-buff-size type

Gavrilov Ilia (1):
      ipv6: Fix out-of-bounds access in ipv6_find_tlv()

Greg Kroah-Hartman (2):
      Revert "arm64: dts: imx8mp: Drop simple-bus from fsl,imx8mp-media-blk-ctrl"
      Linux 6.3.5

Gregory Oakes (1):
      watchdog: sp5100_tco: Immediately trigger upon starting.

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works

Hans de Goede (12):
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

Jack Xiao (1):
      drm/amd/amdgpu: limit one queue per gang

Jakub Kicinski (1):
      net/mlx5e: do as little as possible in napi poll when budget is 0

Jarkko Sakkinen (3):
      tpm_tis: Use tpm_chip_{start,stop} decoration inside tpm_tis_resume
      tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM drivers
      tpm: Prevent hwrng from activating during resume

Jesse Zhang (1):
      drm/amdgpu: don't enable secure display on incompatible platforms

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

Nhat Pham (1):
      zsmalloc: move LRU update from zs_map_object() to zs_malloc()

Nicolas Dichtel (1):
      ipv{4,6}/raw: fix output xfrm lookup wrt protocol

Paulo Alcantara (1):
      cifs: fix smb1 mount regression

Ping-Ke Shih (1):
      wifi: rtw89: 8852b: adjust quota to avoid SER L1 caused by access null page

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

Roi Dayan (1):
      net/mlx5: Fix error message when failing to allocate device memory

Sen Chu (1):
      regulator: mt6359: add read check for PMIC MT6359

Shay Drory (4):
      net/mlx5: Handle pairing of E-switch via uplink un/load APIs
      net/mlx5: Collect command failures data only for known commands
      net/mlx5: Devcom, fix error flow in mlx5_devcom_register_device
      net/mlx5: Devcom, serialize devcom registration

Srinivas Pandruvada (1):
      thermal: intel: int340x: Add new line for UUID display

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

Yunsheng Lin (1):
      page_pool: fix inconsistency for page_pool_ring_[un]lock()

Zev Weiss (1):
      gpio: mockup: Fix mode of debugfs files

Zhang Rui (1):
      x86/topology: Fix erroneous smp_num_siblings on Intel Hybrid platforms

