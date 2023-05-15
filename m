Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485D270331A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbjEOQdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242050AbjEOQdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:33:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6791FEE;
        Mon, 15 May 2023 09:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E3B162752;
        Mon, 15 May 2023 16:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A588C433EF;
        Mon, 15 May 2023 16:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168378;
        bh=Iup2JzrWPfcbSMD8/xBZi0fnrYNuqGT2nNueqcOrTFE=;
        h=From:To:Cc:Subject:Date:From;
        b=QK3U2eR9rexk+JxH/2RKRJdeghOdAgAzqPto8XSqhsgkukimdc/nVMbdjkUISeGci
         WnpYgpYDyNoL4y7pbInZhtr8l0trwJWmjchGZQ9pmsqaptOOVyj1xPqXWFHP0n2uE6
         1BFCGS+GZchApbFYgIsUeCLcaxQQfCPO0i3zGuGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 4.14 000/116] 4.14.315-rc1 review
Date:   Mon, 15 May 2023 18:24:57 +0200
Message-Id: <20230515161658.228491273@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.315-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.315-rc1
X-KernelTest-Deadline: 2023-05-17T16:17+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.315 release.
There are 116 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.315-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.315-rc1

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    printk: declare printk_deferred_{enter,safe}() in include/linux/printk.h

Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
    drbd: correctly submit flush bio on barrier

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    serial: 8250: Fix serial8250_tx_empty() race with DMA Tx

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf bench: Share some global variables to fix build with gcc 10

Theodore Ts'o <tytso@mit.edu>
    ext4: fix invalid free tracking in ext4_xattr_move_to_block()

Theodore Ts'o <tytso@mit.edu>
    ext4: remove a BUG_ON in ext4_mb_release_group_pa()

Theodore Ts'o <tytso@mit.edu>
    ext4: bail out of ext4_xattr_ibody_get() fails for any reason

Theodore Ts'o <tytso@mit.edu>
    ext4: add bounds checking in get_max_inline_xattr_value_size()

Theodore Ts'o <tytso@mit.edu>
    ext4: improve error recovery code paths in __ext4_remount()

Tudor Ambarus <tudor.ambarus@linaro.org>
    ext4: avoid a potential slab-out-of-bounds in ext4_group_desc_csum

Ping Cheng <pinglinux@gmail.com>
    HID: wacom: Set a default resolution for older tablets

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: s5pv210: correct MIPI CSIS clock name

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: exynos: fix WM8960 clock name in Itop Elite

Randy Dunlap <rdunlap@infradead.org>
    sh: nmi_debug: fix return value of __setup handler

Randy Dunlap <rdunlap@infradead.org>
    sh: math-emu: fix macro redefined warning

Pawel Witek <pawel.ireneusz.witek@gmail.com>
    cifs: fix pcchunk length type in smb2_copychunk_range

Anastasia Belova <abelova@astralinux.ru>
    btrfs: print-tree: parent bytenr must be aligned to sector size

Filipe Manana <fdmanana@suse.com>
    btrfs: fix btrfs_prev_leaf() to not return the same key twice

Yang Jihong <yangjihong1@huawei.com>
    perf symbols: Fix return incorrect build_id size in elf_read_build_id()

Markus Elfring <Markus.Elfring@web.de>
    perf map: Delete two variable initialisations before null pointer checks in sort__sym_from_cmp()

Kajol Jain <kjain@linux.ibm.com>
    perf vendor events power9: Remove UTF-8 characters from JSON files

Ruliang Lin <u202112092@hust.edu.cn>
    ALSA: caiaq: input: Add error handling for unsupported input methods in `snd_usb_caiaq_input_init`

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_packet: Don't send zero-byte data in packet_sendmsg_spkt().

Victor Nogueira <victor@mojatatu.com>
    net/sched: act_mirred: Add carrier check

Maxim Korotkov <korotkov.maxim.s@gmail.com>
    writeback: fix call of incorrect macro

Cong Wang <cong.wang@bytedance.com>
    sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: deactivate anonymous set from preparation phase

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: bogus EBUSY when deleting set after flush

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: use-after-free in failing rule with bound set

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_hash: fix nft_hash_deactivate

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: unbind set in rule from commit path

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: split set destruction in deactivate and destroy phase

Adrian Hunter <adrian.hunter@intel.com>
    perf auxtrace: Fix address filter entire kernel size

Mike Snitzer <snitzer@kernel.org>
    dm ioctl: fix nested locking in table_clear() to remove deadlock concern

Mikulas Patocka <mpatocka@redhat.com>
    dm flakey: fix a crash with invalid table line

Mike Snitzer <snitzer@kernel.org>
    dm integrity: call kmem_cache_destroy() in dm_integrity_init() error path

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix hanging blockdevice after request requeue

Qu Wenruo <wqu@suse.com>
    btrfs: scrub: reject unsupported scrub flags

Quentin Schulz <quentin.schulz@theobroma-systems.com>
    clk: rockchip: rk3399: allow clk_cifout to force clk_cifout_src to reparent

Bitterblue Smith <rtl8821cerfe2@gmail.com>
    wifi: rtl8xxxu: RTL8192EU always needs full init

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix infinite loop in nilfs_mdt_get_block()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: do not write dirty data after degenerating to read-only

Helge Deller <deller@gmx.de>
    parisc: Fix argument pointer in real64_call_asm()

Claudiu Beznea <claudiu.beznea@microchip.com>
    dmaengine: at_xdmac: do not enable all cyclic channels

Gaosheng Cui <cuigaosheng1@huawei.com>
    phy: tegra: xusb: Add missing tegra_xusb_port_unregister for usb2_port and ulpi_port

Dai Ngo <dai.ngo@oracle.com>
    SUNRPC: remove the maximum number of retries in call_bind_status

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4.1: Always send a RECLAIM_COMPLETE after establishing lease

Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
    IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order

Clément Léger <clement.leger@bootlin.com>
    clk: add missing of_node_put() in "assigned-clocks" property parsing

Sebastian Reichel <sre@kernel.org>
    power: supply: generic-adc-battery: fix unit scaling

Natalia Petrova <n.petrova@fintech.ru>
    RDMA/rdmavt: Delete unnecessary NULL check

Yang Jihong <yangjihong1@huawei.com>
    perf/core: Fix hardlockup failure caused by perf throttle

Nathan Lynch <nathanl@linux.ibm.com>
    powerpc/rtas: use memmove for potentially overlapping buffer copy

Randy Dunlap <rdunlap@infradead.org>
    macintosh: via-pmu-led: requires ATA to be set

Randy Dunlap <rdunlap@infradead.org>
    powerpc/sysdev/tsi108: fix resource printk format warnings

Randy Dunlap <rdunlap@infradead.org>
    powerpc/wii: fix resource printk format warnings

Randy Dunlap <rdunlap@infradead.org>
    powerpc/mpc512x: fix resource printk format warning

Liang He <windhl@126.com>
    macintosh/windfarm_smu_sat: Add missing of_node_put()

Jishnu Prakash <quic_jprakash@quicinc.com>
    spmi: Add a check for remove callback when removing a SPMI driver

Philipp Hortmann <philipp.g.hortmann@gmail.com>
    staging: rtl8192e: Fix W_DISABLE# does not work after stop/start

Florian Fainelli <f.fainelli@gmail.com>
    serial: 8250: Add missing wakeup event reporting

Shenwei Wang <shenwei.wang@nxp.com>
    tty: serial: fsl_lpuart: adjust buffer length to the intended size

Yinhao Hu <dddddd@hust.edu.cn>
    usb: chipidea: fix missing goto in `ci_hdrc_probe`

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
    sh: sq: Fix incorrect element size for allocating bitmap buffer

Kevin Brodsky <kevin.brodsky@arm.com>
    uapi/linux/const.h: prefer ISO-friendly __typeof__

Randy Dunlap <rdunlap@infradead.org>
    ia64: mm/contig: fix section mismatch warning/error

Miquel Raynal <miquel.raynal@bootlin.com>
    of: Fix modalias string generation

Christophe Leroy <christophe.leroy@csgroup.eu>
    spi: fsl-spi: Fix CPM/QE mode Litte Endian

Randy Dunlap <rdunlap@infradead.org>
    linux/vt_buffer.h: allow either builtin or modular for macros

John Stultz <jstultz@google.com>
    pstore: Revert pmsg_lock back to a normal mutex

Kuniyuki Iwashima <kuniyu@amazon.com>
    tcp/udp: Fix memleaks of sk and zerocopy skbs with TX timestamp.

Gencen Gan <gangecen@hust.edu.cn>
    net: amd: Fix link leak when verifying config failed

Liu Jian <liujian56@huawei.com>
    Revert "Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work"

Ziyang Xuan <william.xuanziyang@huawei.com>
    ipv4: Fix potential uninit variable access bug in __ip_make_skb()

Joe Damato <jdamato@fastly.com>
    ixgbe: Enable setting RSS table to default values

Joe Damato <jdamato@fastly.com>
    ixgbe: Allow flow hash to be set via ethtool

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: check firmware response size

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: make the loop for card preparation effective

Yu Kuai <yukuai3@huawei.com>
    md/raid10: fix leak of 'r10bio->remaining' for recovery

Danila Chernetsov <listdansp@mail.ru>
    scsi: megaraid: Fix mega_cmd_done() CMDID_INT_CMDS

Mike Christie <michael.christie@oracle.com>
    scsi: target: iscsit: Fix TAS handling during conn cleanup

Eric Dumazet <edumazet@google.com>
    net/packet: convert po->auxdata to an atomic flag

Eric Dumazet <edumazet@google.com>
    net/packet: convert po->origdev to an atomic flag

Vadim Fedorenko <vadim.fedorenko@linux.dev>
    vlan: partially enable SIOCSHWTSTAMP in container

Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
    scm: fix MSG_CTRUNC setting condition for SO_PASSSEC

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath6kl: reduce WARN to dev_dbg() in callback

Dan Carpenter <error27@gmail.com>
    wifi: ath5k: fix an off by one check in ath5k_eeprom_read_freq_list()

Alexey V. Vissarionov <gremlin@altlinux.org>
    wifi: ath6kl: minor fix for allocation size

Sumit Garg <sumit.garg@linaro.org>
    arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

Saurabh Sengar <ssengar@linux.microsoft.com>
    x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()

Zheng Wang <zyytlz.wz@163.com>
    media: dm1105: Fix use after free bug in dm1105_remove due to race condition

Uros Bizjak <ubizjak@gmail.com>
    x86/apic: Fix atomic update of offset in reserve_eilvt_offset()

Dan Carpenter <error27@gmail.com>
    media: av7110: prevent underflow in write_ts_to_decoder()

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    media: bdisp: Add missing check for create_workqueue

Dom Cobley <popcornmix@gmail.com>
    drm/probe-helper: Cancel previous job before starting new one

Maíra Canal <mcanal@igalia.com>
    drm/vgem: add missing mutex_destroy

Rob Clark <robdclark@chromium.org>
    drm/rockchip: Drop unbalanced obj unref

Paul Moore <paul@paul-moore.com>
    selinux: ensure av_permissions.h is built when needed

Ondrej Mosnacek <omosnace@redhat.com>
    selinux: fix Makefile dependencies of flask.h

Mårten Lindahl <marten.lindahl@axis.com>
    ubifs: Free memory for tmpfile name

Wang YanQing <udknight@gmail.com>
    ubi: Fix return value overwrite issue in try_write_vid_and_data()

Zhihao Cheng <chengzhihao1@huawei.com>
    Revert "ubifs: dirty_cow_znode: Fix memleak in error handling path"

Reid Tonking <reidt@ti.com>
    i2c: omap: Fix standard mode false ACK readings

Roberto Sassu <roberto.sassu@huawei.com>
    reiserfs: Add security prefix to xattr name in reiserfs_security_write()

Johannes Berg <johannes.berg@intel.com>
    ring-buffer: Sync IRQ works before buffer destruction

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: fw: Allow firmware to pass a empty env

Nuno Sá <nuno.sa@analog.com>
    staging: iio: resolver: ads1210: fix config mode

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf sched: Cast PTHREAD_STACK_MIN to int as it may turn into sysconf(__SC_THREAD_STACK_MIN_VALUE)

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: fix runtime pm imbalance on unbind

Randy Dunlap <rdunlap@infradead.org>
    IMA: allow/fix UML builds

Patrik Dahlström <risca@dalakolonin.se>
    iio: adc: palmas_gpadc: fix NULL dereference on rmmod

Arınç ÜNAL <arinc.unal@arinc9.com>
    USB: serial: option: add UNISOC vendor and TOZED LT70C product

Ruihan Li <lrh2000@pku.edu.cn>
    bluetooth: Perform careful capability checks in hci_sock_ioctl()

Jisoo Jang <jisoo.jang@yonsei.ac.kr>
    wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/exynos4412-itop-elite.dts        |   2 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |   2 +-
 arch/arm64/include/asm/debug-monitors.h            |   1 +
 arch/arm64/kernel/debug-monitors.c                 |   5 +
 arch/arm64/kernel/kgdb.c                           |   2 +
 arch/ia64/mm/contig.c                              |   2 +-
 arch/mips/fw/lib/cmdline.c                         |   2 +-
 arch/parisc/kernel/real2.S                         |   5 +-
 arch/powerpc/kernel/rtas.c                         |   2 +-
 arch/powerpc/platforms/512x/clock-commonclk.c      |   2 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |   2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |   2 +-
 arch/powerpc/platforms/embedded6xx/wii.c           |   4 +-
 arch/powerpc/sysdev/tsi108_pci.c                   |   5 +-
 arch/sh/kernel/cpu/sh4/sq.c                        |   2 +-
 arch/sh/kernel/nmi_debug.c                         |   4 +-
 arch/sh/math-emu/sfp-util.h                        |   4 -
 arch/x86/kernel/apic/apic.c                        |   5 +-
 arch/x86/kernel/apic/io_apic.c                     |  14 ++-
 drivers/block/drbd/drbd_receiver.c                 |   2 +-
 drivers/bluetooth/btsdio.c                         |   1 -
 drivers/clk/clk-conf.c                             |  12 +-
 drivers/clk/rockchip/clk-rk3399.c                  |   2 +-
 drivers/dma/at_xdmac.c                             |   5 +-
 drivers/gpu/drm/drm_probe_helper.c                 |   5 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |   3 -
 drivers/gpu/drm/vgem/vgem_fence.c                  |   1 +
 drivers/hid/wacom_wac.c                            |  12 +-
 drivers/i2c/busses/i2c-omap.c                      |   2 +-
 drivers/iio/adc/palmas_gpadc.c                     |   2 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c                |  13 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |   2 -
 drivers/macintosh/Kconfig                          |   1 +
 drivers/macintosh/windfarm_smu_sat.c               |   1 +
 drivers/md/dm-flakey.c                             |   4 +-
 drivers/md/dm-integrity.c                          |   8 +-
 drivers/md/dm-ioctl.c                              |   7 +-
 drivers/md/raid10.c                                |  23 ++--
 drivers/media/pci/dm1105/dm1105.c                  |   1 +
 drivers/media/pci/ttpci/av7110_av.c                |   4 +-
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c      |   2 +
 drivers/mtd/ubi/eba.c                              |  19 ++-
 drivers/net/ethernet/amd/nmclan_cs.c               |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  23 ++--
 drivers/net/wireless/ath/ath5k/eeprom.c            |   2 +-
 drivers/net/wireless/ath/ath6kl/bmi.c              |   2 +-
 drivers/net/wireless/ath/ath6kl/htc_pipe.c         |   4 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   5 +
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |  10 ++
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   3 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |   1 +
 drivers/of/device.c                                |   7 +-
 drivers/phy/tegra/xusb.c                           |   2 +
 drivers/power/supply/generic-adc-battery.c         |   3 +
 drivers/s390/block/dasd.c                          |   2 +-
 drivers/scsi/megaraid.c                            |   1 +
 drivers/spi/spi-fsl-spi.c                          |  12 +-
 drivers/spmi/spmi.c                                |   3 +-
 drivers/staging/iio/resolver/ad2s1210.c            |   2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   1 +
 drivers/target/iscsi/iscsi_target.c                |  16 +--
 drivers/tty/serial/8250/8250.h                     |  12 ++
 drivers/tty/serial/8250/8250_port.c                |  16 ++-
 drivers/tty/serial/fsl_lpuart.c                    |   2 +-
 drivers/tty/tty_io.c                               |   4 +-
 drivers/tty/tty_ioctl.c                            |  47 +++++--
 drivers/usb/chipidea/core.c                        |   2 +-
 drivers/usb/dwc3/core.c                            |   1 +
 drivers/usb/serial/option.c                        |   6 +
 fs/btrfs/ctree.c                                   |  32 ++++-
 fs/btrfs/ioctl.c                                   |   5 +
 fs/btrfs/print-tree.c                              |   6 +-
 fs/cifs/smb2ops.c                                  |   2 +-
 fs/ext4/inline.c                                   |  14 ++-
 fs/ext4/mballoc.c                                  |   6 +-
 fs/ext4/super.c                                    |  19 +--
 fs/ext4/xattr.c                                    |   5 +-
 fs/fs-writeback.c                                  |   2 +-
 fs/nfs/nfs4state.c                                 |   4 +
 fs/nilfs2/bmap.c                                   |  16 ++-
 fs/nilfs2/segment.c                                |   5 +-
 fs/pstore/pmsg.c                                   |   7 +-
 fs/reiserfs/xattr_security.c                       |   8 +-
 fs/ubifs/dir.c                                     |   1 +
 fs/ubifs/tnc.c                                     |   9 +-
 include/linux/printk.h                             |  19 +++
 include/linux/sunrpc/sched.h                       |   3 +-
 include/linux/tty.h                                |   2 +
 include/linux/vt_buffer.h                          |   2 +-
 include/net/netfilter/nf_tables.h                  |  30 ++++-
 include/net/scm.h                                  |  13 +-
 include/uapi/linux/btrfs.h                         |   1 +
 include/uapi/linux/const.h                         |   2 +-
 kernel/events/core.c                               |   4 +-
 kernel/trace/ring_buffer.c                         |   4 +
 mm/page_alloc.c                                    |  16 +++
 net/8021q/vlan_dev.c                               |   2 +-
 net/bluetooth/hci_sock.c                           |   9 +-
 net/core/skbuff.c                                  |   3 +
 net/ipv4/ip_output.c                               |  16 ++-
 net/ipv6/sit.c                                     |   8 +-
 net/netfilter/nf_tables_api.c                      | 139 +++++++++++++++------
 net/netfilter/nft_dynset.c                         |  22 +++-
 net/netfilter/nft_immediate.c                      |   6 +-
 net/netfilter/nft_lookup.c                         |  21 +++-
 net/netfilter/nft_objref.c                         |  21 +++-
 net/netfilter/nft_set_hash.c                       |   2 +-
 net/packet/af_packet.c                             |  20 ++-
 net/packet/diag.c                                  |   4 +-
 net/packet/internal.h                              |  26 +++-
 net/sched/act_mirred.c                             |   2 +-
 net/sunrpc/clnt.c                                  |   3 -
 net/sunrpc/sched.c                                 |   1 -
 security/integrity/ima/Kconfig                     |   2 +-
 security/selinux/Makefile                          |   4 +-
 sound/usb/caiaq/input.c                            |   1 +
 tools/perf/bench/bench.h                           |   4 +
 tools/perf/bench/futex-hash.c                      |  12 +-
 tools/perf/bench/futex-lock-pi.c                   |  11 +-
 tools/perf/builtin-sched.c                         |   2 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json |   4 +-
 .../pmu-events/arch/powerpc/power9/pipeline.json   |   2 +-
 tools/perf/util/auxtrace.c                         |   5 +-
 tools/perf/util/sort.c                             |   3 +-
 tools/perf/util/symbol-elf.c                       |   2 +-
 126 files changed, 708 insertions(+), 280 deletions(-)


