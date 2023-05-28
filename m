Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4457F713E56
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 21:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjE1Teg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjE1Tee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 15:34:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978A3B1;
        Sun, 28 May 2023 12:34:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2668061DF2;
        Sun, 28 May 2023 19:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF3EC4339B;
        Sun, 28 May 2023 19:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302470;
        bh=FNCtZTRhkzaJ7qRRu+4k2zBCjd9Bn9B590TLCbZRnek=;
        h=From:To:Cc:Subject:Date:From;
        b=io+fJ20VUM2HKOPITszaIjelBeBgCKEzBMFapQ/U+zRBAC6VBdOy+0aBq3SX7uvBH
         VC1XHnuNNq6kZUUPp4Romf9FSFh1cgIZaHt16vd/M3LeVoe4+BARXnr3uokAszn8J5
         PgPW9SDZE2oP1rpeLYYYSEnUXoCuo6MjK72tYeto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 6.1 000/119] 6.1.31-rc1 review
Date:   Sun, 28 May 2023 20:10:00 +0100
Message-Id: <20230528190835.386670951@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.31-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.31-rc1
X-KernelTest-Deadline: 2023-05-30T19:08+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.1.31 release.
There are 119 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.31-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.31-rc1

David Epping <david.epping@missinglinkelectronics.com>
    net: phy: mscc: add VSC8502 to MODULE_DEVICE_TABLE

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    3c589_cs: Fix an error handling path in tc589_probe()

Wen Gu <guwen@linux.alibaba.com>
    net/smc: Reset connection when trying to use SMCRv2 fails.

Sen Chu <sen.chu@mediatek.com>
    regulator: mt6359: add read check for PMIC MT6359

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_ffa: Set reserved/MBZ fields to zero in the memory descriptors

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    arm64: dts: imx8mn-var-som: fix PHY detection bug by adding deassert delay

Shay Drory <shayd@nvidia.com>
    net/mlx5: Devcom, serialize devcom registration

Shay Drory <shayd@nvidia.com>
    net/mlx5: Devcom, fix error flow in mlx5_devcom_register_device

Shay Drory <shayd@nvidia.com>
    net/mlx5: Collect command failures data only for known commands

Roi Dayan <roid@nvidia.com>
    net/mlx5: Fix error message when failing to allocate device memory

Yevgeny Kliteynik <kliteyn@nvidia.com>
    net/mlx5: DR, Check force-loopback RC QP capability independently from RoCE

Shay Drory <shayd@nvidia.com>
    net/mlx5: Handle pairing of E-switch via uplink un/load APIs

Erez Shitrit <erezsh@nvidia.com>
    net/mlx5: DR, Fix crc32 calculation to work on big-endian (BE) CPUs

Jakub Kicinski <kuba@kernel.org>
    net/mlx5e: do as little as possible in napi poll when budget is 0

Vlad Buslov <vladbu@nvidia.com>
    net/mlx5e: Use correct encap attribute during invalidation

Vlad Buslov <vladbu@nvidia.com>
    net/mlx5e: Fix deadlock in tc route query code

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Fix SQ wake logic in ptp napi_poll context

Dan Carpenter <dan.carpenter@linaro.org>
    platform/mellanox: mlxbf-pmc: fix sscanf() error checking

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    forcedeth: Fix an error handling path in nv_probe()

Xin Long <lucien.xin@gmail.com>
    sctp: fix an issue that plpmtu can never go to complete state

Dave Jiang <dave.jiang@intel.com>
    cxl: Wait Memory_Info_Valid before access memory related info

Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
    ASoC: Intel: avs: Access path components under lock

Cezary Rojewski <cezary.rojewski@intel.com>
    ASoC: Intel: avs: Fix declaration of enum avs_channel_config

Cezary Rojewski <cezary.rojewski@intel.com>
    ASoC: Intel: Skylake: Fix declaration of enum skl_ch_cfg

Vernon Lovejoy <vlovejoy@redhat.com>
    x86/show_trace_log_lvl: Ensure stack pointer is aligned, again

Dan Carpenter <dan.carpenter@linaro.org>
    xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()

Maximilian Heyne <mheyne@amazon.de>
    x86/pci/xen: populate MSI sysfs entries

Alexander Stein <alexander.stein@ew.tq-group.com>
    ARM: dts: imx6qdl-mba6: Add missing pvcie-supply regulator

Dan Carpenter <dan.carpenter@linaro.org>
    coresight: Fix signedness bug in tmc_etr_buf_insert_barrier_packet()

Steve Wahl <steve.wahl@hpe.com>
    platform/x86: ISST: Remove 8 socket limit

Alexander Stein <alexander.stein@ew.tq-group.com>
    regulator: pca9450: Fix BUCK2 enable_mask

Hao Ge <gehao@kylinos.cn>
    fs: fix undefined behavior in bit shift for SB_NOUSER

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_ffa: Fix FFA device names for logical partitions

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_ffa: Check if ffa_driver remove is present before executing

Etienne Carriere <etienne.carriere@linaro.org>
    optee: fix uninited async notif value

Daisuke Nojiri <dnojiri@chromium.org>
    power: supply: sbs-charger: Fix INHIBITED bit for Status reg

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq24190: Call power_supply_changed() after updating input current

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq25890: Call power_supply_changed() after updating input current or voltage

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Ensure power_supply_changed() is called on current sign changes

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Move bq27xxx_battery_update() down

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

Horatiu Vultur <horatiu.vultur@microchip.com>
    lan966x: Fix unloading/loading of the driver

Anton Protopopov <aspsk@isovalent.com>
    bpf: fix a memory leak in the LRU and LRU_PERCPU hash maps

Will Deacon <will@kernel.org>
    bpf: Fix mask generation for 32-bit narrow loads of 64-bit fields

Sunil Goutham <sgoutham@marvell.com>
    octeontx2-pf: Fix TSOv6 offload

Po-Hsu Lin <po-hsu.lin@canonical.com>
    selftests: fib_tests: mute cleanup error message

Matthew Auld <matthew.auld@intel.com>
    drm: fix drmm_mutex_init()

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

Jiaxun Yang <jiaxun.yang@flygoat.com>
    irqchip/mips-gic: Use raw spinlock for gic_lock

Jiaxun Yang <jiaxun.yang@flygoat.com>
    irqchip/mips-gic: Don't touch vl_map if a local interrupt is not routable

Zhang Rui <rui.zhang@intel.com>
    x86/topology: Fix erroneous smp_num_siblings on Intel Hybrid platforms

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/uncore: Correct the number of CHAs on SPR

Jack Xiao <Jack.Xiao@amd.com>
    drm/amd/amdgpu: limit one queue per gang

Hardik Garg <hargar@linux.microsoft.com>
    selftests/memfd: Fix unknown type name build failure

Carlos Llamas <cmllamas@google.com>
    binder: fix UAF of alloc->vma in race with munmap()

Carlos Llamas <cmllamas@google.com>
    binder: fix UAF caused by faulty buffer cleanup

Carlos Llamas <cmllamas@google.com>
    binder: add lockless binder_alloc_(set|get)_vma()

Carlos Llamas <cmllamas@google.com>
    Revert "android: binder: stop saving a pointer to the VMA"

Carlos Llamas <cmllamas@google.com>
    Revert "binder_alloc: add missing mmap_lock calls when using the VMA"

Jonatas Esteves <jntesteves@gmail.com>
    drm/amd/pm: Fix output of pp_od_clk_voltage

Evan Quan <evan.quan@amd.com>
    drm/amd/pm: add missing NotifyPowerSource message mapping for SMU13.0.7

Alex Deucher <alexander.deucher@amd.com>
    drm/radeon: reintroduce radeon_dp_work_func content

Jocelyn Falempe <jfalempe@redhat.com>
    drm/mgag200: Fix gamma lut not initialized.

Frank Li <Frank.Li@nxp.com>
    dt-binding: cdns,usb3: Fix cdns,on-chip-buff-size type

Josef Bacik <josef@toxicpanda.com>
    btrfs: use nofs when cleaning up aborted transactions

Zev Weiss <zev@bewilderbeest.net>
    gpio: mockup: Fix mode of debugfs files

Helge Deller <deller@gmx.de>
    parisc: Handle kprobes breakpoints only in kernel context

Helge Deller <deller@gmx.de>
    parisc: Enable LOCKDEP support

Helge Deller <deller@gmx.de>
    parisc: Allow to reboot machine after system halt

Helge Deller <deller@gmx.de>
    parisc: Fix flush_dcache_page() for usage from irq context

Helge Deller <deller@gmx.de>
    parisc: Handle kgdb breakpoints only in kernel context

Helge Deller <deller@gmx.de>
    parisc: Use num_present_cpus() in alternative patching code

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: add __bswap{si,di}2 helpers

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix signal delivery to FDPIC process

Finn Thain <fthain@linux-m68k.org>
    m68k: Move signal frame following exception on 68020/030

Tudor Ambarus <tudor.ambarus@linaro.org>
    net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize

Matthias Kaehlcke <mka@chromium.org>
    ASoC: rt5682: Disable jack detection interrupt during suspend

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq25890: Fix external_power_changed race

Hans de Goede <hdegoede@redhat.com>
    power: supply: axp288_fuel_gauge: Fix external_power_changed race

Christian Loehle <CLoehle@hyperstone.com>
    mmc: block: ensure error propagation for non-blk

Haibo Chen <haibo.chen@nxp.com>
    mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Don't change task->tk_status after the call to rpc_exit_task

Bin Li <bin.li@canonical.com>
    ALSA: hda/realtek: Enable headset onLenovo M70/M90

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Fix unhandled register update during auto-suspend period

Adam Stylinski <kungfujesus06@gmail.com>
    ALSA: hda/ca0132: add quirk for EVGA X299 DARK

David Arcari <darcari@redhat.com>
    platform/x86/intel/ifs: Annotate work queue on stack so object debug does not complain

Dave Hansen <dave.hansen@linux.intel.com>
    x86/mm: Avoid incomplete Global INVLPG flushes

Peter Collingbourne <pcc@google.com>
    arm64: Also reset KASAN tag if page is not PG_mte_tagged

Roberto Sassu <roberto.sassu@huawei.com>
    ocfs2: Switch to security_inode_init_security()

Robin Chen <robin.chen@amd.com>
    drm/amd/display: hpd rx irq not working with eDP interface

Steffen Bätz <steffen@innosonix.de>
    net: dsa: mv88e6xxx: Add RGMII delay to 88E6320

Hans de Goede <hdegoede@redhat.com>
    platform/x86: hp-wmi: Fix cast to smaller integer type warning

Kees Cook <keescook@chromium.org>
    skbuff: Proactively round up to kmalloc bucket size

Jack Xiao <Jack.Xiao@amd.com>
    drm/amdgpu/mes11: enable reg active poll

Jack Xiao <Jack.Xiao@amd.com>
    drm/amd/amdgpu: update mes11 api def

Gregory Oakes <gregory.oakes@amd.com>
    watchdog: sp5100_tco: Immediately trigger upon starting.

Jarkko Sakkinen <jarkko@kernel.org>
    tpm: Prevent hwrng from activating during resume

Jarkko Sakkinen <jarkko@kernel.org>
    tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM drivers

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm_tis: startup chip before testing for interrupts

Jarkko Sakkinen <jarkko@kernel.org>
    tpm_tis: Use tpm_chip_{start,stop} decoration inside tpm_tis_resume

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm_tis: Only handle supported interrupts

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm_tis: Avoid cache incoherency in test for interrupts

Linyu Yuan <quic_linyyuan@quicinc.com>
    usb: dwc3: fix gadget mode suspend interrupt handler issue


-------------

Diffstat:

 .../devicetree/bindings/usb/cdns,usb3.yaml         |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/imx6qdl-mba6.dtsi                |   1 +
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi  |   8 +-
 arch/arm64/mm/copypage.c                           |   5 +-
 arch/m68k/kernel/signal.c                          |  14 +-
 arch/parisc/Kconfig                                |   4 +
 arch/parisc/include/asm/cacheflush.h               |   4 +
 arch/parisc/kernel/alternative.c                   |   2 +-
 arch/parisc/kernel/cache.c                         |   5 +-
 arch/parisc/kernel/process.c                       |  11 +-
 arch/parisc/kernel/traps.c                         |   8 +-
 arch/x86/events/intel/uncore_snbep.c               |  11 ++
 arch/x86/kernel/cpu/topology.c                     |   5 +-
 arch/x86/kernel/dumpstack.c                        |   7 +-
 arch/x86/mm/init.c                                 |  25 +++
 arch/x86/pci/xen.c                                 |   8 +-
 arch/xtensa/kernel/signal.c                        |  35 +++-
 arch/xtensa/kernel/xtensa_ksyms.c                  |   4 +
 arch/xtensa/lib/Makefile                           |   2 +-
 arch/xtensa/lib/bswapdi2.S                         |  21 +++
 arch/xtensa/lib/bswapsi2.S                         |  16 ++
 drivers/android/binder.c                           |  28 ++-
 drivers/android/binder_alloc.c                     |  64 ++++---
 drivers/android/binder_alloc.h                     |   4 +-
 drivers/android/binder_alloc_selftest.c            |   2 +-
 drivers/char/tpm/tpm-chip.c                        |  52 ++++--
 drivers/char/tpm/tpm-interface.c                   |  10 ++
 drivers/char/tpm/tpm.h                             |   1 +
 drivers/char/tpm/tpm_tis.c                         |   2 +-
 drivers/char/tpm/tpm_tis_core.c                    | 187 ++++++++++++---------
 drivers/char/tpm/tpm_tis_core.h                    |   3 +-
 drivers/cxl/core/pci.c                             |  85 +++++++++-
 drivers/cxl/cxlpci.h                               |   2 +
 drivers/firmware/arm_ffa/bus.c                     |  19 ++-
 drivers/firmware/arm_ffa/driver.c                  |   6 +
 drivers/gpio/gpio-mockup.c                         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |   9 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |   6 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h      |   6 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  12 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   1 +
 drivers/gpu/drm/drm_managed.c                      |  22 +--
 drivers/gpu/drm/mgag200/mgag200_mode.c             |   5 +
 drivers/gpu/drm/radeon/radeon_irq_kms.c            |  10 ++
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   2 +-
 drivers/irqchip/irq-mips-gic.c                     |  32 ++--
 drivers/media/radio/radio-shark.c                  |  10 ++
 drivers/media/radio/radio-shark2.c                 |  10 ++
 drivers/mmc/core/block.c                           |   5 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  18 +-
 drivers/net/bonding/bond_main.c                    |   8 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   2 +
 drivers/net/dsa/mv88e6xxx/port.c                   |   9 +
 drivers/net/dsa/mv88e6xxx/port.h                   |   2 +
 drivers/net/ethernet/3com/3c589_cs.c               |  11 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |   2 +
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h  |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  23 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |  19 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c  |  16 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   4 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   7 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |  70 ++++++--
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   2 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |   4 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_ste.c  |   3 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  10 ++
 drivers/net/ethernet/nvidia/forcedeth.c            |   1 +
 drivers/net/phy/mscc/mscc_main.c                   |   1 +
 drivers/net/team/team.c                            |   7 +-
 drivers/net/usb/cdc_ncm.c                          |  24 ++-
 drivers/platform/mellanox/mlxbf-pmc.c              |   5 +-
 drivers/platform/x86/hp/hp-wmi.c                   |   2 +-
 drivers/platform/x86/intel/ifs/load.c              |   2 +-
 .../x86/intel/speed_select_if/isst_if_common.c     |  12 +-
 drivers/power/supply/axp288_fuel_gauge.c           |   2 +-
 drivers/power/supply/bq24190_charger.c             |   1 +
 drivers/power/supply/bq25890_charger.c             |   5 +-
 drivers/power/supply/bq27xxx_battery.c             | 175 ++++++++++---------
 drivers/power/supply/bq27xxx_battery_i2c.c         |   3 +-
 drivers/power/supply/mt6360_charger.c              |   4 +-
 drivers/power/supply/power_supply_leds.c           |   5 +-
 drivers/power/supply/sbs-charger.c                 |   2 +-
 drivers/regulator/mt6359-regulator.c               |   7 +-
 drivers/regulator/pca9450-regulator.c              |   4 +-
 drivers/tee/optee/smc_abi.c                        |   4 +-
 drivers/usb/core/usb.c                             |  76 +++++++++
 drivers/usb/dwc3/core.h                            |   2 +
 drivers/usb/dwc3/gadget.c                          |  10 +-
 drivers/usb/misc/sisusbvga/sisusb.c                |  14 ++
 drivers/video/fbdev/udlfb.c                        |  13 +-
 drivers/watchdog/sp5100_tco.c                      |   4 +
 drivers/xen/pvcalls-back.c                         |   9 +-
 fs/btrfs/disk-io.c                                 |   9 +
 fs/cifs/fs_context.c                               |   8 +
 fs/ocfs2/namei.c                                   |   2 +
 fs/ocfs2/xattr.c                                   |  30 +++-
 include/drm/drm_managed.h                          |  18 +-
 include/linux/arm_ffa.h                            |   1 +
 include/linux/fs.h                                 |  42 ++---
 include/linux/if_team.h                            |   1 +
 include/linux/mlx5/mlx5_ifc.h                      |   4 +-
 include/linux/msi.h                                |   9 +-
 include/linux/power/bq27xxx_battery.h              |   4 +
 include/linux/tpm.h                                |  14 +-
 include/linux/usb.h                                |   5 +
 include/net/bonding.h                              |   1 +
 include/uapi/sound/skl-tplg-interface.h            |   3 +-
 kernel/bpf/hashtab.c                               |   6 +-
 kernel/bpf/verifier.c                              |   2 +-
 kernel/irq/msi.c                                   |   4 +-
 lib/debugobjects.c                                 |   2 +-
 net/core/skbuff.c                                  |  56 +++---
 net/ipv4/udplite.c                                 |   2 +
 net/ipv6/exthdrs_core.c                            |   2 +
 net/ipv6/udplite.c                                 |   2 +
 net/sctp/transport.c                               |  11 +-
 net/smc/af_smc.c                                   |   9 +-
 net/smc/smc_core.c                                 |   1 +
 net/sunrpc/sched.c                                 |   5 +-
 sound/hda/hdac_device.c                            |   2 +-
 sound/pci/hda/patch_ca0132.c                       |   1 +
 sound/pci/hda/patch_realtek.c                      |   2 +
 sound/soc/codecs/lpass-tx-macro.c                  |   5 +
 sound/soc/codecs/rt5682-i2c.c                      |   4 +-
 sound/soc/codecs/rt5682.c                          |   6 +
 sound/soc/codecs/rt5682.h                          |   1 +
 sound/soc/intel/avs/apl.c                          |   6 +-
 sound/soc/intel/avs/messages.h                     |   2 +-
 tools/testing/selftests/memfd/fuse_test.c          |   1 +
 tools/testing/selftests/net/fib_tests.sh           |   2 +-
 138 files changed, 1201 insertions(+), 511 deletions(-)


