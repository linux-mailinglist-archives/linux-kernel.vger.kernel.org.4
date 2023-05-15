Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13967038E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbjEORf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244442AbjEORf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:35:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5C11B0A6;
        Mon, 15 May 2023 10:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AFFE62D79;
        Mon, 15 May 2023 17:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21E3C433D2;
        Mon, 15 May 2023 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171993;
        bh=S/HhQ9twXFMVCy7qjYyJsyujKmfhOD9OLjAgXqNuYQo=;
        h=From:To:Cc:Subject:Date:From;
        b=G48ymT1dooQm2vmRuFkbl0OsDFn3H3qtvR2VvaHTz3NDfDaAQm5972qI9PIrtHRiS
         tV1vsaVv8l8cSEhK5KjWws2VEyzIWmgO2hERu/Y9h3CbJfCdA0bEOro+MEAw6LlfyB
         0vr1JUiXP6M4MN0Sy/3IfU8xNMIRB3XpzSekCoik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.10 000/381] 5.10.180-rc1 review
Date:   Mon, 15 May 2023 18:24:11 +0200
Message-Id: <20230515161736.775969473@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.180-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.180-rc1
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

This is the start of the stable review cycle for the 5.10.180 release.
There are 381 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.180-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.180-rc1

Aurabindo Pillai <aurabindo.pillai@amd.com>
    drm/amd/display: Fix hang when skipping modeset

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock

Tian Tao <tiantao6@hisilicon.com>
    drm/exynos: move to use request_irq by IRQF_NO_AUTOEN flag

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    printk: declare printk_deferred_{enter,safe}() in include/linux/printk.h

Rishabh Bhatnagar <risbhat@amazon.com>
    KVM: x86: move guest_pv_has out of user_access section

Rishabh Bhatnagar <risbhat@amazon.com>
    KVM: x86: do not report preemption if the steal time cache is stale

Rishabh Bhatnagar <risbhat@amazon.com>
    KVM: x86: revalidate steal time cache if MSR value changes

Rishabh Bhatnagar <risbhat@amazon.com>
    KVM: x86: do not set st->preempted when going back to user space

Rishabh Bhatnagar <risbhat@amazon.com>
    KVM: x86: Remove obsolete disabling of page faults in kvm_arch_vcpu_put()

Rishabh Bhatnagar <risbhat@amazon.com>
    KVM: Fix steal time asm constraints

Rishabh Bhatnagar <risbhat@amazon.com>
    KVM: x86: Fix recording of guest steal time / preempted status

Rishabh Bhatnagar <risbhat@amazon.com>
    KVM: x86: Ensure PV TLB flush tracepoint reflects KVM behavior

Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
    drbd: correctly submit flush bio on barrier

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    serial: 8250: Fix serial8250_tx_empty() race with DMA Tx

Theodore Ts'o <tytso@mit.edu>
    ext4: fix invalid free tracking in ext4_xattr_move_to_block()

Theodore Ts'o <tytso@mit.edu>
    ext4: remove a BUG_ON in ext4_mb_release_group_pa()

Theodore Ts'o <tytso@mit.edu>
    ext4: bail out of ext4_xattr_ibody_get() fails for any reason

Theodore Ts'o <tytso@mit.edu>
    ext4: add bounds checking in get_max_inline_xattr_value_size()

Theodore Ts'o <tytso@mit.edu>
    ext4: fix deadlock when converting an inline directory in nojournal mode

Theodore Ts'o <tytso@mit.edu>
    ext4: improve error recovery code paths in __ext4_remount()

Baokun Li <libaokun1@huawei.com>
    ext4: check iomap type only if ext4_iomap_begin() does not fail

Jan Kara <jack@suse.cz>
    ext4: fix data races when using cached status extents

Tudor Ambarus <tudor.ambarus@linaro.org>
    ext4: avoid a potential slab-out-of-bounds in ext4_group_desc_csum

Ye Bin <yebin10@huawei.com>
    ext4: fix WARNING in mb_find_extent

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: do not report a vCPU as preempted outside instruction boundaries

Vitaly Kuznetsov <vkuznets@redhat.com>
    KVM: x86: hyper-v: Avoid calling kvm_make_vcpus_request_mask() with vcpu_mask==NULL

Ping Cheng <pinglinux@gmail.com>
    HID: wacom: insert timestamp to packed Bluetooth (BT) events

Ping Cheng <pinglinux@gmail.com>
    HID: wacom: Set a default resolution for older tablets

Guchun Chen <guchun.chen@amd.com>
    drm/amdgpu: disable sdma ecc irq only when sdma RAS is enabled in suspend

Guchun Chen <guchun.chen@amd.com>
    drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when enabling legacy gfx ras

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amdgpu: fix an amdgpu_irq_put() issue in gmc_v9_0_hw_fini()

James Cowgill <james.cowgill@blaize.com>
    drm/panel: otm8009a: Set backlight parent to panel device

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix potential corruption when moving a directory

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: s5pv210: correct MIPI CSIS clock name

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: exynos: fix WM8960 clock name in Itop Elite

Mathieu Poirier <mathieu.poirier@linaro.org>
    remoteproc: st: Call of_node_put() on iteration error

Mathieu Poirier <mathieu.poirier@linaro.org>
    remoteproc: stm32: Call of_node_put() on iteration error

Randy Dunlap <rdunlap@infradead.org>
    sh: nmi_debug: fix return value of __setup handler

Randy Dunlap <rdunlap@infradead.org>
    sh: init: use OF_EARLY_FLATTREE for early init

Randy Dunlap <rdunlap@infradead.org>
    sh: mcount.S: fix build error when PRINTK is not enabled

Randy Dunlap <rdunlap@infradead.org>
    sh: math-emu: fix macro redefined warning

Jan Kara <jack@suse.cz>
    inotify: Avoid reporting event with invalid wd

Andrey Avdeev <jamesstoun@gmail.com>
    platform/x86: touchscreen_dmi: Add info for the Dexp Ursus KX210i

Hans de Goede <hdegoede@redhat.com>
    platform/x86: touchscreen_dmi: Add upside-down quirk for GDIX1002 ts on the Juno Tablet

Pawel Witek <pawel.ireneusz.witek@gmail.com>
    cifs: fix pcchunk length type in smb2_copychunk_range

Anastasia Belova <abelova@astralinux.ru>
    btrfs: print-tree: parent bytenr must be aligned to sector size

Josef Bacik <josef@toxicpanda.com>
    btrfs: don't free qgroup space unless specified

Filipe Manana <fdmanana@suse.com>
    btrfs: fix btrfs_prev_leaf() to not return the same key twice

Yang Jihong <yangjihong1@huawei.com>
    perf symbols: Fix return incorrect build_id size in elf_read_build_id()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    crypto: sun8i-ss - Fix a test in sun8i_ss_setup_ivs()

Markus Elfring <Markus.Elfring@web.de>
    perf map: Delete two variable initialisations before null pointer checks in sort__sym_from_cmp()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf pmu: zfree() expects a pointer to a pointer to zero it after freeing its contents

Kajol Jain <kjain@linux.ibm.com>
    perf vendor events power9: Remove UTF-8 characters from JSON files

Florian Fainelli <f.fainelli@gmail.com>
    net: bcmgenet: Remove phy_stop() from bcmgenet_netif_stop()

Wei Fang <wei.fang@nxp.com>
    net: enetc: check the index of the SFI rather than the handle

Wenliang Wang <wangwenliang.1995@bytedance.com>
    virtio_net: suppress cpu stall when free_unused_bufs

Xuan Zhuo <xuanzhuo@linux.alibaba.com>
    virtio_net: split free_unused_bufs()

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix corrupt frames using trgmii on 40 MHz XTAL MT7621

Ruliang Lin <u202112092@hust.edu.cn>
    ALSA: caiaq: input: Add error handling for unsupported input methods in `snd_usb_caiaq_input_init`

Chia-I Wu <olvaffe@gmail.com>
    drm/amdgpu: add a missing lock for AMDGPU_SCHED

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_packet: Don't send zero-byte data in packet_sendmsg_spkt().

Shannon Nelson <shannon.nelson@amd.com>
    ionic: remove noise from ethtool rxnfc error msg

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-vf: Detach LF resources on probe cleanup

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-pf: Disable packet I/O for graceful exit

David Howells <dhowells@redhat.com>
    rxrpc: Fix hard call timeout units

Andy Moreton <andy.moreton@amd.com>
    sfc: Fix module EEPROM reporting for QSFP modules

Victor Nogueira <victor@mojatatu.com>
    net/sched: act_mirred: Add carrier check

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    watchdog: dw_wdt: Fix the error handling path of dw_wdt_drv_probe()

Maxim Korotkov <korotkov.maxim.s@gmail.com>
    writeback: fix call of incorrect macro

Angelo Dureghello <angelo.dureghello@timesys.com>
    net: dsa: mv88e6xxx: add mv88e6321 rsvd2cpu

Cong Wang <cong.wang@bytedance.com>
    sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()

Vlad Buslov <vladbu@nvidia.com>
    net/sched: cls_api: remove block_cb from driver_list before freeing

Cosmo Chou <chou.cosmo@gmail.com>
    net/ncsi: clear Tx enable mode when handling a Config required AEN

Zheng Wang <zyytlz.wz@163.com>
    scsi: qedi: Fix use after free bug in qedi_remove()

Yeongjin Gil <youngjin.gil@samsung.com>
    dm verity: fix error handling for check_at_most_once on FEC

Akilesh Kailash <akailash@google.com>
    dm verity: skip redundant verity_handle_err() on I/O errors

Tanmay Shah <tanmay.shah@amd.com>
    mailbox: zynqmp: Fix counts of child nodes

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mailbox: zynq: Switch to flexible array to simplify code

Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
    crypto: ccp - Clear PSP interrupt status register before calling handler

Tze-nan Wu <Tze-nan.Wu@mediatek.com>
    ring-buffer: Ensure proper resetting of atomic variables in ring_buffer_reset_online_cpus

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: clean include/linux/tty.h up

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: move some tty-only functions to drivers/tty/tty.h

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: move some internal tty lock enums and functions out of tty.h

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: audit: move some local functions out of tty.h

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: create internal tty.h file

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: deactivate anonymous set from preparation phase

Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
    scsi: target: core: Avoid smp_processor_id() in preemptible code

Vincent Guittot <vincent.guittot@linaro.org>
    arm64: dts: qcom: sdm845: correct dynamic power coefficients - again

Miles Chen <miles.chen@mediatek.com>
    sound/oss/dmasound: fix 'dmasound_setup' defined but not used

Thomas Gleixner <tglx@linutronix.de>
    debugobject: Ensure pool refill (again)

Ard Biesheuvel <ardb@kernel.org>
    arm64: Stash shadow stack pointer in the task struct on interrupt

Ard Biesheuvel <ardb@kernel.org>
    arm64: Always load shadow stack pointer directly from the task struct

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix CYC timestamps after standalone CBR

Adrian Hunter <adrian.hunter@intel.com>
    perf auxtrace: Fix address filter entire kernel size

Mike Snitzer <snitzer@kernel.org>
    dm ioctl: fix nested locking in table_clear() to remove deadlock concern

Mikulas Patocka <mpatocka@redhat.com>
    dm flakey: fix a crash with invalid table line

Mike Snitzer <snitzer@kernel.org>
    dm integrity: call kmem_cache_destroy() in dm_integrity_init() error path

Mike Snitzer <snitzer@kernel.org>
    dm clone: call kmem_cache_destroy() in dm_clone_init() error path

Hugh Dickins <hughd@google.com>
    ia64: fix an addr to taddr in huge_pte_offset()

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix hanging blockdevice after request requeue

Qu Wenruo <wqu@suse.com>
    btrfs: scrub: reject unsupported scrub flags

Peng Liu <liupeng17@lenovo.com>
    scripts/gdb: fix lx-timerlist for Python3

Marc Dionne <marc.dionne@auristor.com>
    afs: Fix updating of i_size with dv jump from server

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    mfd: tqmx86: Correct board names for TQMxE39x

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    mfd: tqmx86: Specify IO port register range more precisely

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    mfd: tqmx86: Add support for TQMx110EB and TQMxE40x

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    mfd: tqmx86: Remove incorrect TQMx90UC board ID

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    mfd: tqmx86: Do not access I2C_DETECT register through io_base

Kang Chen <void0red@hust.edu.cn>
    thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe

Claudiu Beznea <claudiu.beznea@microchip.com>
    dmaengine: at_xdmac: do not enable all cyclic channels

Shunsuke Mie <mie@igel.co.jp>
    dmaengine: dw-edma: Fix to enable to issue dma request on DMA processing

Shunsuke Mie <mie@igel.co.jp>
    dmaengine: dw-edma: Fix to change for continuous transfer

Gaosheng Cui <cuigaosheng1@huawei.com>
    phy: tegra: xusb: Add missing tegra_xusb_port_unregister for usb2_port and ulpi_port

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    pwm: mtk-disp: Disable shadow registers before setting backlight values

Jitao Shi <jitao.shi@mediatek.com>
    pwm: mtk-disp: Adjust the clocks to avoid them mismatch

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pwm: mtk-disp: Don't check the return code of pwmchip_remove()

H. Nikolaus Schaller <hns@goldelico.com>
    leds: tca6507: Fix error handling of using fwnode_property_read_string

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: mv_xor_v2: Fix an error code.

Randy Dunlap <rdunlap@infradead.org>
    leds: TI_LMU_COMMON: select REGMAP instead of depending on it

Ye Bin <yebin10@huawei.com>
    ext4: fix use-after-free read in ext4_find_extent for bigalloc + inline

Stafford Horne <shorne@gmail.com>
    openrisc: Properly store r31 to pt_regs on unhandled exceptions

Qinrun Dai <flno@hust.edu.cn>
    clocksource/drivers/davinci: Fix memory leak in davinci_timer_register when init fails

Mark Zhang <markzhang@nvidia.com>
    RDMA/mlx5: Use correct device num_ports when modify DC

Dai Ngo <dai.ngo@oracle.com>
    SUNRPC: remove the maximum number of retries in call_bind_status

Mark Bloch <mbloch@nvidia.com>
    RDMA/mlx5: Fix flow counter query via DEVX

Miaoqian Lin <linmq006@gmail.com>
    Input: raspberrypi-ts - fix refcount leak in rpi_ts_probe

Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
    input: raspberrypi-ts: Release firmware handle when not needed

Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
    firmware: raspberrypi: Introduce devm_rpi_firmware_get()

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4.1: Always send a RECLAIM_COMPLETE after establishing lease

Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
    IB/hfi1: Fix bugs with non-PAGE_SIZE-end multi-iovec user SDMA requests

Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
    IB/hfi1: Add additional usdma traces

Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
    IB/hfi1: Add AIP tx traces

Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
    IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order

Saravanan Vajravel <saravanan.vajravel@broadcom.com>
    RDMA/srpt: Add a check for valid 'mad_agent' pointer

Mark Zhang <markzhang@nvidia.com>
    RDMA/cm: Trace icm_send_rej event before the cm state is reset

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    RDMA/siw: Remove namespace check from siw_netdev_event()

Clément Léger <clement.leger@bootlin.com>
    clk: add missing of_node_put() in "assigned-clocks" property parsing

Sebastian Reichel <sre@kernel.org>
    power: supply: generic-adc-battery: fix unit scaling

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    rtc: meson-vrtc: Use ktime_get_real_ts64() to get the current time

Dan Carpenter <error27@gmail.com>
    RDMA/mlx4: Prevent shift wrapping in set_user_sq_size()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    rtc: omap: include header for omap_rtc_power_off_program prototype

Petr Mladek <pmladek@suse.com>
    workqueue: Fix hung time report of worker pools

Lai Jiangshan <laijs@linux.alibaba.com>
    workqueue: Rename "delayed" (delayed by active management) to "inactive"

Natalia Petrova <n.petrova@fintech.ru>
    RDMA/rdmavt: Delete unnecessary NULL check

Daniil Dulov <d.dulov@aladdin.ru>
    RDMA/siw: Fix potential page_array out of range access

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: at91: clk-sam9x60-pll: fix return value check

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

Dan Carpenter <dan.carpenter@linaro.org>
    firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe

Chunfeng Yun <chunfeng.yun@mediatek.com>
    usb: mtu3: fix kernel panic at qmu transfer done irq handler

Yinhao Hu <dddddd@hust.edu.cn>
    usb: chipidea: fix missing goto in `ci_hdrc_probe`

Jon Hunter <jonathanh@nvidia.com>
    usb: gadget: tegra-xudc: Fix crash in vbus_draw

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
    sh: sq: Fix incorrect element size for allocating bitmap buffer

Kevin Brodsky <kevin.brodsky@arm.com>
    uapi/linux/const.h: prefer ISO-friendly __typeof__

Lars-Peter Clausen <lars@metafoo.de>
    i2c: cadence: cdns_i2c_master_xfer(): Fix runtime PM leak on error path

Dhruva Gole <d-gole@ti.com>
    spi: cadence-quadspi: fix suspend-resume implementations

Liliang Ye <yll@hust.edu.cn>
    ASoC: fsl_mqs: move of_node_put() to the correct location

Suzuki K Poulose <suzuki.poulose@arm.com>
    coresight: etm_pmu: Set the module field

Florian Fainelli <f.fainelli@gmail.com>
    scripts/gdb: bail early if there are no generic PD

Florian Fainelli <f.fainelli@gmail.com>
    scripts/gdb: bail early if there are no clocks

Randy Dunlap <rdunlap@infradead.org>
    ia64: salinfo: placate defined-but-not-used warning

Randy Dunlap <rdunlap@infradead.org>
    ia64: mm/contig: fix section mismatch warning/error

Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
    PCI/EDR: Clear Device Status after EDR error recovery

Miquel Raynal <miquel.raynal@bootlin.com>
    of: Fix modalias string generation

Dae R. Jeong <threeearcat@gmail.com>
    vmci_host: fix a race condition in vmci_host_poll() causing GPF

Christophe Leroy <christophe.leroy@csgroup.eu>
    spi: fsl-spi: Fix CPM/QE mode Litte Endian

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: qup: Don't skip cleanup in remove's error path

Randy Dunlap <rdunlap@infradead.org>
    linux/vt_buffer.h: allow either builtin or modular for macros

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: es8316: Handle optional IRQ assignment

Hans de Goede <hdegoede@redhat.com>
    ASoC: es8316: Use IRQF_NO_AUTOEN when requesting the IRQ

H. Nikolaus Schaller <hns@goldelico.com>
    PCI: imx6: Install the fault handler only on compatible match

Zheng Wang <zyytlz.wz@163.com>
    usb: gadget: udc: renesas_usb3: Fix use after free bug in renesas_usb3_remove due to race condition

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: imx: Don't skip cleanup in remove's error path

Minghao Chi <chi.minghao@zte.com.cn>
    spi: spi-imx: using pm_runtime_resume_and_get instead of pm_runtime_get_sync

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    iio: light: max44009: add missing OF device matching

Marco Pagani <marpagan@redhat.com>
    fpga: bridge: fix kernel-doc parameter description

Prashanth K <quic_prashk@quicinc.com>
    usb: dwc3: gadget: Change condition for processing suspend event

Wolfram Sang <wsa+renesas@sang-engineering.com>
    usb: host: xhci-rcar: remove leftover quirk handling

John Stultz <jstultz@google.com>
    pstore: Revert pmsg_lock back to a normal mutex

Randy Dunlap <rdunlap@infradead.org>
    ipmi: ASPEED_BT_IPMI_BMC: select REGMAP_MMIO instead of depending on it

Kuniyuki Iwashima <kuniyu@amazon.com>
    tcp/udp: Fix memleaks of sk and zerocopy skbs with TX timestamp.

Gencen Gan <gangecen@hust.edu.cn>
    net: amd: Fix link leak when verifying config failed

Kuniyuki Iwashima <kuniyu@amazon.com>
    netlink: Use copy_to_user() for optval in netlink_getsockopt().

Liu Jian <liujian56@huawei.com>
    Revert "Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work"

Ziyang Xuan <william.xuanziyang@huawei.com>
    ipv4: Fix potential uninit variable access bug in __ip_make_skb()

Davide Caratti <dcaratti@redhat.com>
    net/sched: sch_fq: fix integer overflow of "credit"

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: don't write table validation state without mutex

Stanislav Fomichev <sdf@google.com>
    bpf: Don't EFAULT for getsockopt with optval=NULL

Joe Damato <jdamato@fastly.com>
    ixgbe: Enable setting RSS table to default values

Joe Damato <jdamato@fastly.com>
    ixgbe: Allow flow hash to be set via ethtool

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: fw: fix memory leak in debugfs

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: check firmware response size

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: make the loop for card preparation effective

Jan Kara <jack@suse.cz>
    jdb2: Don't refuse invalidation of already invalidated buffers

Tom Rix <trix@redhat.com>
    wifi: iwlwifi: fw: move memset before early return

Daniel Gabay <daniel.gabay@intel.com>
    wifi: iwlwifi: yoyo: Fix possible division by zero

Yu Kuai <yukuai3@huawei.com>
    md/raid10: fix memleak of md thread

Yu Kuai <yukuai3@huawei.com>
    md/raid10: fix memleak for 'conf->bio_split'

Yu Kuai <yukuai3@huawei.com>
    md/raid10: fix leak of 'r10bio->remaining' for recovery

Daniel Borkmann <daniel@iogearbox.net>
    bpf, sockmap: Revert buggy deadlock fix in the sockhash and sockmap

Ming Lei <ming.lei@redhat.com>
    nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage"

Keith Busch <kbusch@kernel.org>
    nvme: fix async event trace event

Michael Kelley <mikelley@microsoft.com>
    nvme: handle the persistent internal error AER

Xin Liu <liuxin350@huawei.com>
    bpf, sockmap: fix deadlocks in the sockhash and sockmap

Sebastian Reichel <sebastian.reichel@collabora.com>
    net: ethernet: stmmac: dwmac-rk: fix optional phy regulator handling

Shuchang Li <lishuchang@hust.edu.cn>
    scsi: lpfc: Fix ioremap issues in lpfc_sli4_pci_mem_setup()

Chao Yu <chao@kernel.org>
    f2fs: fix to avoid use-after-free for cached IPU bio

Kal Conley <kal.conley@dectris.com>
    xsk: Fix unaligned descriptor validation

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: drbg - Only fail when jent is unavailable in FIPS mode

Nicolai Stange <nstange@suse.de>
    crypto: drbg - make drbg_prepare_hrng() handle jent instantiation errors

Quentin Monnet <quentin@isovalent.com>
    bpftool: Fix bug for long instructions in program CFG dumps

YiFei Zhu <zhuyifei@google.com>
    selftests/bpf: Wait for receive in cg_storage_multi test

Simon Horman <horms@kernel.org>
    net: qrtr: correct types of trace event parameters

Wei Chen <harperchen1110@gmail.com>
    wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_reg()

Wei Chen <harperchen1110@gmail.com>
    wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_rfreg()

Suman Anna <s-anna@ti.com>
    crypto: sa2ul - Select CRYPTO_DES

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    crypto: caam - Clear some memory in instantiate_rng

Yangtao Li <frank.li@vivo.com>
    f2fs: compress: fix to call f2fs_wait_on_page_writeback() in f2fs_write_raw_pages()

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: apply zone capacity to all zone type

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: enforce single zone capacity

Yangtao Li <frank.li@vivo.com>
    f2fs: handle dqget error in f2fs_transfer_project_quota()

Danila Chernetsov <listdansp@mail.ru>
    scsi: megaraid: Fix mega_cmd_done() CMDID_INT_CMDS

Mike Christie <michael.christie@oracle.com>
    scsi: target: iscsit: Fix TAS handling during conn cleanup

Mike Christie <michael.christie@oracle.com>
    scsi: target: Fix multiple LUN_RESET handling

Mike Christie <michael.christie@oracle.com>
    scsi: target: Make state_list per CPU

David Disseldorp <ddiss@suse.de>
    scsi: target: Rename cmd.bad_sector to cmd.sense_info

David Disseldorp <ddiss@suse.de>
    scsi: target: Rename struct sense_info to sense_detail

Eric Dumazet <edumazet@google.com>
    net/packet: convert po->auxdata to an atomic flag

Eric Dumazet <edumazet@google.com>
    net/packet: convert po->origdev to an atomic flag

Eric Dumazet <edumazet@google.com>
    net/packet: annotate accesses to po->xmit

Vadim Fedorenko <vadim.fedorenko@linux.dev>
    vlan: partially enable SIOCSHWTSTAMP in container

Luis Gerhorst <gerhorst@cs.fau.de>
    bpf: Remove misleading spec_v1 check on var-offset stack read

Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
    scm: fix MSG_CTRUNC setting condition for SO_PASSSEC

Andrii Nakryiko <andrii@kernel.org>
    bpf: fix precision propagation verbose logging

Andrii Nakryiko <andrii@kernel.org>
    bpf: take into account liveness when propagating precision

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    wifi: rtw88: mac: Return the original error from rtw_mac_power_switch()

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    wifi: rtw88: mac: Return the original error from rtw_pwr_seq_parser()

Luis Gerhorst <gerhorst@cs.fau.de>
    tools: bpftool: Remove invalid \' json escape

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath6kl: reduce WARN to dev_dbg() in callback

Dan Carpenter <error27@gmail.com>
    wifi: ath5k: fix an off by one check in ath5k_eeprom_read_freq_list()

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: hif_usb: fix memory leak of remain_skbs

Alexey V. Vissarionov <gremlin@altlinux.org>
    wifi: ath6kl: minor fix for allocation size

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    tick/common: Align tick period with the HZ tick.

Thomas Gleixner <tglx@linutronix.de>
    tick: Get rid of tick_period

Thomas Gleixner <tglx@linutronix.de>
    tick/sched: Optimize tick_do_update_jiffies64() further

Yunfeng Ye <yeyunfeng@huawei.com>
    tick/sched: Reduce seqcount held scope in tick_do_update_jiffies64()

Thomas Gleixner <tglx@linutronix.de>
    tick/sched: Use tick_next_period for lockless quick check

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Make intel_get_crtc_new_encoder() less oopsy

Thomas Gleixner <tglx@linutronix.de>
    debugobject: Prevent init race with static objects

Sumit Garg <sumit.garg@linaro.org>
    arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

Saurabh Sengar <ssengar@linux.microsoft.com>
    x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()

YAN SHI <m202071378@hust.edu.cn>
    regulator: stm32-pwr: fix of_iomap leak

Michał Krawczyk <mk@semihalf.com>
    media: venus: dec: Fix handling of the start cmd

Fritz Koenig <frkoenig@chromium.org>
    media: venus: vdec: Handle DRC after drain

Alexandre Courbot <acourbot@chromium.org>
    media: venus: preserve DRC state across seeks

Stanimir Varbanov <stanimir.varbanov@linaro.org>
    media: venus: vdec: Make decoder return LAST flag for sufficient event

Stanimir Varbanov <stanimir.varbanov@linaro.org>
    media: venus: vdec: Fix non reliable setting of LAST flag

Florian Fainelli <f.fainelli@gmail.com>
    media: rc: gpio-ir-recv: Fix support for wake-up

Miaoqian Lin <linmq006@gmail.com>
    media: rcar_fdp1: Fix refcount leak in probe and remove function

Tang Bin <tangbin@cmss.chinamobile.com>
    media: rcar_fdp1: Fix the correct variable assignments

Cai Huoqing <caihuoqing@baidu.com>
    media: rcar_fdp1: Make use of the helper function devm_platform_ioremap_resource()

Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    media: rcar_fdp1: fix pm_runtime_get_sync() usage count

Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    media: rcar_fdp1: simplify error check logic at fdp_open()

Zheng Wang <zyytlz.wz@163.com>
    media: saa7134: fix use after free bug in saa7134_finidev due to race condition

Zheng Wang <zyytlz.wz@163.com>
    media: dm1105: Fix use after free bug in dm1105_remove due to race condition

Zheng Wang <zyytlz.wz@163.com>
    media: rkvdec: fix use after free bug in rkvdec_remove

Uros Bizjak <ubizjak@gmail.com>
    x86/apic: Fix atomic update of offset in reserve_eilvt_offset()

Douglas Anderson <dianders@chromium.org>
    regulator: core: Avoid lockdep reports when resolving supplies

Douglas Anderson <dianders@chromium.org>
    regulator: core: Consistently set mutex_owner when using ww_mutex_lock_slow()

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    drm/lima/lima_drv: Add missing unwind goto in lima_pdev_probe()

H. Nikolaus Schaller <hns@goldelico.com>
    ARM: dts: gta04: fix excess dma channel usage

Georgii Kruglov <georgy.kruglov@yandex.ru>
    mmc: sdhci-of-esdhc: fix quirk to ignore command inhibit for data

Roger Pau Monne <roger.pau@citrix.com>
    ACPI: processor: Fix evaluating _PDC method when running as Xen dom0

Adam Skladowski <a39.skl@gmail.com>
    drm: msm: adreno: Disable preemption on Adreno 510

Johan Hovold <johan+linaro@kernel.org>
    drm/msm/adreno: drop bogus pm_runtime_set_active()

Rob Clark <robdclark@chromium.org>
    drm/msm/adreno: Defer enabling runpm until hw_init()

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: max9286: Free control handler

Adam Ford <aford173@gmail.com>
    drm/bridge: adv7533: Fix adv7533_mode_valid for adv7533 and adv7535

Mukesh Ojha <quic_mojha@quicinc.com>
    firmware: qcom_scm: Clear download bit during reboot

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    media: bdisp: Add missing check for create_workqueue

Muralidhara M K <muralimk@amd.com>
    x86/MCE/AMD: Use an u64 for bank_map

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    ARM: dts: qcom: ipq8064: Fix the PCI I/O port range

Christian Marangi <ansuelsmth@gmail.com>
    ARM: dts: qcom: ipq8064: reduce pci IO size to 64K

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    ARM: dts: qcom: ipq4019: Fix the PCI I/O port range

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    arm64: dts: qcom: msm8996: Fix the PCI I/O port range

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    arm64: dts: qcom: ipq8074: Fix the PCI I/O port range

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    arm64: dts: qcom: msm8998: Fix the PCI I/O port range

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    arm64: dts: qcom: sdm845: Fix the PCI I/O port range

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: sdm845: correct dynamic power coefficients

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: msm8998: Fix stm-stimulus-base reg name

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    EDAC/skx: Fix overflows on the DRAM row address mapping arrays

Vinod Polimera <quic_vpolimer@quicinc.com>
    drm/msm/disp/dpu: check for crtc enable rather than crtc active to release shared resources

Geert Uytterhoeven <geert+renesas@glider.be>
    arm64: dts: renesas: r8a774c0: Remove bogus voltages from OPP table

Geert Uytterhoeven <geert+renesas@glider.be>
    arm64: dts: renesas: r8a77990: Remove bogus voltages from OPP table

Miaoqian Lin <linmq006@gmail.com>
    soc: ti: pm33xx: Fix refcount leak in am33xx_pm_probe

Tony Lindgren <tony@atomide.com>
    soc: ti: pm33xx: Enable basic PM runtime support for genpd

Dom Cobley <popcornmix@gmail.com>
    drm/probe-helper: Cancel previous job before starting new one

Maíra Canal <mcanal@igalia.com>
    drm/vgem: add missing mutex_destroy

Rob Clark <robdclark@chromium.org>
    drm/rockchip: Drop unbalanced obj unref

Jingbo Xu <jefflexu@linux.alibaba.com>
    erofs: fix potential overflow calculating xattr_isize

Gao Xiang <hsiangkao@linux.alibaba.com>
    erofs: stop parsing non-compact HEAD index if clusterofs is invalid

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm_tis: Claim locality when interrupts are reenabled on resume

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm: Implement usage counter for locality

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm_tis: Claim locality before writing interrupt registers

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm_tis: Claim locality before writing TPM_INT_ENABLE register

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm_tis: Do not skip reset of original interrupt vector

Paul Moore <paul@paul-moore.com>
    selinux: ensure av_permissions.h is built when needed

Ondrej Mosnacek <omosnace@redhat.com>
    selinux: fix Makefile dependencies of flask.h

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Check for return value after write_schemata()

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Return NULL if malloc_and_init_memory() did not alloc mem

Zqiang <qiang1.zhang@intel.com>
    rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check

Quentin Schulz <quentin.schulz@theobroma-systems.com>
    clk: rockchip: rk3399: allow clk_cifout to force clk_cifout_src to reparent

Bitterblue Smith <rtl8821cerfe2@gmail.com>
    wifi: rtl8xxxu: RTL8192EU always needs full init

Tanmay Shah <tanmay.shah@amd.com>
    mailbox: zynqmp: Fix typo in IPI documentation

Tanmay Shah <tanmay.shah@amd.com>
    mailbox: zynqmp: Fix IPI isr handling

Li Nan <linan122@huawei.com>
    md/raid10: fix null-ptr-deref in raid10_sync_request

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix infinite loop in nilfs_mdt_get_block()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: do not write dirty data after degenerating to read-only

Helge Deller <deller@gmx.de>
    parisc: Fix argument pointer in real64_call_asm()

Randy Dunlap <rdunlap@infradead.org>
    sound/oss/dmasound: fix build when drivers are mixed =y/=m

Mårten Lindahl <marten.lindahl@axis.com>
    ubifs: Free memory for tmpfile name

Wang YanQing <udknight@gmail.com>
    ubi: Fix return value overwrite issue in try_write_vid_and_data()

Zhihao Cheng <chengzhihao1@huawei.com>
    ubifs: Fix memleak when insert_old_idx() failed

Zhihao Cheng <chengzhihao1@huawei.com>
    Revert "ubifs: dirty_cow_znode: Fix memleak in error handling path"

Kishon Vijay Abraham I <kvijayab@amd.com>
    iommu/amd: Fix "Guest Virtual APIC Table Root Pointer" configuration in IRTE

Reid Tonking <reidt@ti.com>
    i2c: omap: Fix standard mode false ACK readings

Baokun Li <libaokun1@huawei.com>
    writeback, cgroup: fix null-ptr-deref write in bdi_split_work_to_wbs

Zhang Zhengming <zhang.zhengming@h3c.com>
    relayfs: fix out-of-bounds access in relay_file_read

Sean Christopherson <seanjc@google.com>
    KVM: nVMX: Emulate NOPs in L2, and PAUSE if it's not intercepted

Roberto Sassu <roberto.sassu@huawei.com>
    reiserfs: Add security prefix to xattr name in reiserfs_security_write()

Zheng Yejian <zhengyejian1@huawei.com>
    rcu: Avoid stack overflow due to __rcu_irq_enter_check_tick() being kprobe-ed

Jonathan McDowell <noodles@earth.li>
    crypto: safexcel - Cleanup ring IRQ workqueues on load failure

Toke Høiland-Jørgensen <toke@redhat.com>
    crypto: api - Demote BUG_ON() in crypto_unregister_alg() to a WARN_ON()

Johannes Berg <johannes.berg@intel.com>
    ring-buffer: Sync IRQ works before buffer destruction

Heiner Kallweit <hkallweit1@gmail.com>
    pwm: meson: Fix g12a ao clk81 name

Heiner Kallweit <hkallweit1@gmail.com>
    pwm: meson: Fix axg ao mux parents

Kees Cook <keescook@chromium.org>
    kheaders: Use array declaration instead of char

Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
    ipmi: fix SSIF not responding under certain cond.

Corey Minyard <minyard@acm.org>
    ipmi:ssif: Add send_retries increment

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: fw: Allow firmware to pass a empty env

Joel Fernandes (Google) <joel@joelfernandes.org>
    tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem

Johan Hovold <johan+linaro@kernel.org>
    xhci: fix debugfs register accesses while suspended

Nuno Sá <nuno.sa@analog.com>
    staging: iio: resolver: ads1210: fix config mode

Harshad Shirwadkar <harshadshirwadkar@gmail.com>
    ext4: use ext4_journal_start/stop for fast commit transactions

Eric Biggers <ebiggers@google.com>
    blk-crypto: make blk_crypto_evict_key() more robust

Eric Biggers <ebiggers@google.com>
    blk-crypto: make blk_crypto_evict_key() return void

Eric Biggers <ebiggers@google.com>
    blk-mq: release crypto keyslot before reporting I/O complete

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf sched: Cast PTHREAD_STACK_MIN to int as it may turn into sysconf(__SC_THREAD_STACK_MIN_VALUE)

Thomas Gleixner <tglx@linutronix.de>
    posix-cpu-timers: Implement the missing timer_wait_running callback

Chris Packham <chris.packham@alliedtelesis.co.nz>
    hwmon: (adt7475) Use device_property APIs when configuring polarity

Babu Moger <Babu.Moger@amd.com>
    hwmon: (k10temp) Check range scale when CUR_TEMP register is read-write

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: fix runtime pm imbalance on unbind

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: fix runtime pm imbalance on probe errors

Randy Dunlap <rdunlap@infradead.org>
    IMA: allow/fix UML builds

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    PCI: qcom: Fix the incorrect register usage in v2.7.0 config

Lukas Wunner <lukas@wunner.de>
    PCI: pciehp: Fix AB-BA deadlock between reset_lock and device_lock

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    wireguard: timers: cast enum limits members to int in prints

Vladimir Oltean <vladimir.oltean@nxp.com>
    asm-generic/io.h: suppress endianness warnings for readq() and writeq()

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: bytcr_rt5640: Add quirk for the Acer Iconia One 7 B1-750

Patrik Dahlström <risca@dalakolonin.se>
    iio: adc: palmas_gpadc: fix NULL dereference on rmmod

Eugene Huang <eugene.huang99@gmail.com>
    ASOC: Intel: sof_sdw: add quirk for Intel 'Rooks County' NUC M15

Stephen Boyd <swboyd@chromium.org>
    driver core: Don't require dynamic_debug for initcall_debug probe timing

Arınç ÜNAL <arinc.unal@arinc9.com>
    USB: serial: option: add UNISOC vendor and TOZED LT70C product

Thomas Gleixner <tglx@linutronix.de>
    x86/fpu: Prevent FPU state corruption

Ruihan Li <lrh2000@pku.edu.cn>
    bluetooth: Perform careful capability checks in hci_sock_ioctl()

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/fb-helper: set x/yres_virtual in drm_fb_helper_check_var

Jisoo Jang <jisoo.jang@yonsei.ac.kr>
    wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()

Dan Carpenter <dan.carpenter@linaro.org>
    KVM: arm64: Fix buffer overflow in kvm_arm_set_fw_reg()

William Breathitt Gray <william.gray@linaro.org>
    counter: 104-quad-8: Fix race condition between FLAG and CNTR reads

Kuniyuki Iwashima <kuniyu@amazon.com>
    seccomp: Move copy_seccomp() to no failure path.


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/exynos4412-itop-elite.dts        |   2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  16 +
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |   4 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |  12 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |   2 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |  12 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  12 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |   4 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  30 +-
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          |   3 -
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |   3 -
 arch/arm64/include/asm/debug-monitors.h            |   1 +
 arch/arm64/include/asm/scs.h                       |   7 +-
 arch/arm64/kernel/debug-monitors.c                 |   5 +
 arch/arm64/kernel/entry.S                          |  12 +-
 arch/arm64/kernel/head.S                           |   2 +-
 arch/arm64/kernel/kgdb.c                           |   2 +
 arch/arm64/kvm/psci.c                              |   2 +
 arch/ia64/kernel/salinfo.c                         |   2 +-
 arch/ia64/mm/contig.c                              |   2 +-
 arch/ia64/mm/hugetlbpage.c                         |   2 +-
 arch/mips/fw/lib/cmdline.c                         |   2 +-
 arch/openrisc/kernel/entry.S                       |   6 +-
 arch/parisc/kernel/real2.S                         |   5 +-
 arch/powerpc/kernel/rtas.c                         |   2 +-
 arch/powerpc/platforms/512x/clock-commonclk.c      |   2 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |   2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |   2 +-
 arch/powerpc/platforms/embedded6xx/wii.c           |   4 +-
 arch/powerpc/sysdev/tsi108_pci.c                   |   5 +-
 arch/sh/Kconfig.debug                              |   2 +-
 arch/sh/kernel/cpu/sh4/sq.c                        |   2 +-
 arch/sh/kernel/head_32.S                           |   6 +-
 arch/sh/kernel/nmi_debug.c                         |   4 +-
 arch/sh/kernel/setup.c                             |   4 +-
 arch/sh/math-emu/sfp-util.h                        |   4 -
 arch/x86/include/asm/kvm_host.h                    |   5 +-
 arch/x86/kernel/apic/apic.c                        |   5 +-
 arch/x86/kernel/apic/io_apic.c                     |  14 +-
 arch/x86/kernel/cpu/mce/amd.c                      |  14 +-
 arch/x86/kernel/fpu/core.c                         |  67 +--
 arch/x86/kvm/hyperv.c                              |  15 +-
 arch/x86/kvm/svm/svm.c                             |   2 +
 arch/x86/kvm/vmx/vmx.c                             |  16 +
 arch/x86/kvm/x86.c                                 | 164 ++++--
 block/blk-core.c                                   |   7 +
 block/blk-crypto-internal.h                        |  25 +-
 block/blk-crypto.c                                 |  69 ++-
 block/blk-merge.c                                  |   2 +
 block/blk-mq.c                                     |   2 +-
 block/keyslot-manager.c                            |  43 +-
 crypto/algapi.c                                    |   4 +-
 crypto/drbg.c                                      |  16 +-
 drivers/acpi/processor_pdc.c                       |  11 +
 drivers/base/cpu.c                                 |   3 +-
 drivers/base/dd.c                                  |   7 +-
 drivers/block/drbd/drbd_receiver.c                 |   2 +-
 drivers/bluetooth/btsdio.c                         |   1 -
 drivers/char/ipmi/Kconfig                          |   3 +-
 drivers/char/ipmi/ipmi_ssif.c                      |   8 +-
 drivers/char/tpm/tpm_tis_core.c                    | 135 +++--
 drivers/char/tpm/tpm_tis_core.h                    |   2 +
 drivers/clk/at91/clk-sam9x60-pll.c                 |   2 +-
 drivers/clk/clk-conf.c                             |  12 +-
 drivers/clk/rockchip/clk-rk3399.c                  |   2 +-
 drivers/clocksource/timer-davinci.c                |  30 +-
 drivers/counter/104-quad-8.c                       |  28 +-
 drivers/crypto/Kconfig                             |   1 +
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |   2 +-
 drivers/crypto/caam/ctrl.c                         |   6 +-
 drivers/crypto/ccp/psp-dev.c                       |   6 +-
 drivers/crypto/inside-secure/safexcel.c            |  37 +-
 drivers/dma/at_xdmac.c                             |   5 +-
 drivers/dma/dw-edma/dw-edma-core.c                 |  27 +-
 drivers/dma/mv_xor_v2.c                            |   2 +-
 drivers/edac/skx_base.c                            |   4 +-
 drivers/firmware/qcom_scm.c                        |   3 +-
 drivers/firmware/raspberrypi.c                     |  29 +
 drivers/firmware/stratix10-svc.c                   |   4 +-
 drivers/fpga/fpga-bridge.c                         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   8 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   5 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   3 +
 drivers/gpu/drm/bridge/adv7511/adv7533.c           |  23 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   3 +
 drivers/gpu/drm/drm_probe_helper.c                 |   5 +-
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |   7 +-
 drivers/gpu/drm/i915/display/intel_display.c       |   2 +-
 drivers/gpu/drm/lima/lima_drv.c                    |   6 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   8 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   7 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   2 +-
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   |   2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |   3 -
 drivers/gpu/drm/vgem/vgem_fence.c                  |   1 +
 drivers/hid/wacom_wac.c                            |  38 +-
 drivers/hid/wacom_wac.h                            |   1 +
 drivers/hwmon/adt7475.c                            |   6 +-
 drivers/hwmon/k10temp.c                            |   4 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   1 +
 drivers/i2c/busses/i2c-cadence.c                   |   6 +-
 drivers/i2c/busses/i2c-omap.c                      |   2 +-
 drivers/iio/adc/palmas_gpadc.c                     |   2 +-
 drivers/iio/light/max44009.c                       |  13 +-
 drivers/infiniband/core/cm.c                       |   3 +-
 drivers/infiniband/hw/hfi1/ipoib_tx.c              |  19 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c                |  73 +--
 drivers/infiniband/hw/hfi1/mmu_rb.h                |   8 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |  21 +-
 drivers/infiniband/hw/hfi1/sdma.h                  |  16 +-
 drivers/infiniband/hw/hfi1/sdma_txreq.h            |   1 +
 drivers/infiniband/hw/hfi1/trace_mmu.h             |   4 -
 drivers/infiniband/hw/hfi1/trace_tx.h              | 179 ++++++
 drivers/infiniband/hw/hfi1/user_sdma.c             | 612 +++++++++++++--------
 drivers/infiniband/hw/hfi1/user_sdma.h             |   6 +-
 drivers/infiniband/hw/hfi1/verbs.c                 |   4 +-
 drivers/infiniband/hw/hfi1/vnic_sdma.c             |   1 +
 drivers/infiniband/hw/mlx4/qp.c                    |   8 +-
 drivers/infiniband/hw/mlx5/devx.c                  |  31 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   2 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |   2 -
 drivers/infiniband/sw/siw/siw_main.c               |   3 -
 drivers/infiniband/sw/siw/siw_qp_tx.c              |   2 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |   4 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |  23 +-
 drivers/input/touchscreen/raspberrypi-ts.c         |   3 +-
 drivers/iommu/amd/amd_iommu_types.h                |   4 +-
 drivers/leds/Kconfig                               |   2 +-
 drivers/leds/leds-tca6507.c                        |   5 +-
 drivers/macintosh/Kconfig                          |   1 +
 drivers/macintosh/windfarm_smu_sat.c               |   1 +
 drivers/mailbox/zynqmp-ipi-mailbox.c               |  19 +-
 drivers/md/dm-clone-target.c                       |   1 +
 drivers/md/dm-flakey.c                             |   4 +-
 drivers/md/dm-integrity.c                          |   8 +-
 drivers/md/dm-ioctl.c                              |   7 +-
 drivers/md/dm-verity-target.c                      |  17 +-
 drivers/md/raid10.c                                |  74 +--
 drivers/media/i2c/max9286.c                        |   1 +
 drivers/media/pci/dm1105/dm1105.c                  |   1 +
 drivers/media/pci/saa7134/saa7134-ts.c             |   1 +
 drivers/media/pci/saa7134/saa7134-vbi.c            |   1 +
 drivers/media/pci/saa7134/saa7134-video.c          |   1 +
 drivers/media/platform/qcom/venus/core.h           |   6 +-
 drivers/media/platform/qcom/venus/helpers.c        |   6 +
 drivers/media/platform/qcom/venus/vdec.c           | 120 ++--
 drivers/media/platform/rcar_fdp1.c                 |  50 +-
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c      |   2 +
 drivers/media/rc/gpio-ir-recv.c                    |   2 +
 drivers/mfd/tqmx86.c                               |  76 ++-
 drivers/misc/vmw_vmci/vmci_host.c                  |   8 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  24 +-
 drivers/mtd/ubi/eba.c                              |  19 +-
 drivers/net/dsa/mt7530.c                           |   4 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   1 +
 drivers/net/ethernet/amd/nmclan_cs.c               |   2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   1 -
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  23 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  11 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |   2 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |   2 +-
 drivers/net/ethernet/sfc/mcdi_port_common.c        |  11 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |  14 +-
 drivers/net/virtio_net.c                           |  43 +-
 drivers/net/wireguard/timers.c                     |   8 +-
 drivers/net/wireless/ath/ath5k/eeprom.c            |   2 +-
 drivers/net/wireless/ath/ath6kl/bmi.c              |   2 +-
 drivers/net/wireless/ath/ath6kl/htc_pipe.c         |   4 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |  19 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   5 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |   6 +
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |  10 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   3 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |   1 +
 drivers/net/wireless/realtek/rtlwifi/debug.c       |  12 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |   8 +-
 drivers/nvme/host/core.c                           |  34 +-
 drivers/nvme/host/trace.h                          |  15 +-
 drivers/nvme/target/fcloop.c                       |  48 +-
 drivers/of/device.c                                |   7 +-
 drivers/pci/controller/dwc/pci-imx6.c              |   7 +
 drivers/pci/controller/dwc/pcie-qcom.c             |   8 +-
 drivers/pci/hotplug/pciehp_pci.c                   |  15 +
 drivers/pci/pcie/edr.c                             |   1 +
 drivers/phy/tegra/xusb.c                           |   2 +
 drivers/platform/x86/touchscreen_dmi.c             |  41 ++
 drivers/power/supply/generic-adc-battery.c         |   3 +
 drivers/pwm/pwm-meson.c                            |   6 +-
 drivers/pwm/pwm-mtk-disp.c                         |  98 ++--
 drivers/regulator/core.c                           |  93 +++-
 drivers/regulator/stm32-pwr.c                      |   7 +-
 drivers/remoteproc/st_remoteproc.c                 |   5 +-
 drivers/remoteproc/stm32_rproc.c                   |   6 +-
 drivers/rtc/rtc-meson-vrtc.c                       |   4 +-
 drivers/rtc/rtc-omap.c                             |   1 +
 drivers/s390/block/dasd.c                          |   2 +-
 drivers/scsi/lpfc/lpfc_init.c                      |  10 +-
 drivers/scsi/megaraid.c                            |   1 +
 drivers/scsi/qedi/qedi_main.c                      |   3 +
 drivers/soc/ti/pm33xx.c                            |  22 +-
 drivers/spi/spi-cadence-quadspi.c                  |  19 +-
 drivers/spi/spi-fsl-spi.c                          |  12 +-
 drivers/spi/spi-imx.c                              |  14 +-
 drivers/spi/spi-qup.c                              |  22 +-
 drivers/spmi/spmi.c                                |   3 +-
 drivers/staging/iio/resolver/ad2s1210.c            |   2 +-
 drivers/staging/media/rkvdec/rkvdec.c              |   2 +
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   1 +
 drivers/target/iscsi/iscsi_target.c                |  16 +-
 drivers/target/target_core_device.c                |  17 +-
 drivers/target/target_core_sbc.c                   |   2 +-
 drivers/target/target_core_tmr.c                   | 164 +++---
 drivers/target/target_core_transport.c             |  59 +-
 drivers/target/tcm_fc/tfc_cmd.c                    |   2 +-
 drivers/thermal/mtk_thermal.c                      |  14 +-
 drivers/tty/n_gsm.c                                |   1 +
 drivers/tty/n_hdlc.c                               |   1 +
 drivers/tty/n_tty.c                                |   1 +
 drivers/tty/pty.c                                  |   1 +
 drivers/tty/serial/8250/8250.h                     |  12 +
 drivers/tty/serial/8250/8250_port.c                |  16 +-
 drivers/tty/serial/fsl_lpuart.c                    |   2 +-
 drivers/tty/tty.h                                  | 117 ++++
 drivers/tty/tty_audit.c                            |   1 +
 drivers/tty/tty_baudrate.c                         |   1 +
 drivers/tty/tty_buffer.c                           |   2 +-
 drivers/tty/tty_io.c                               |   5 +-
 drivers/tty/tty_ioctl.c                            |  48 +-
 drivers/tty/tty_jobctrl.c                          |   1 +
 drivers/tty/tty_ldisc.c                            |   1 +
 drivers/tty/tty_mutex.c                            |   1 +
 drivers/tty/tty_port.c                             |   1 +
 drivers/usb/chipidea/core.c                        |   2 +-
 drivers/usb/dwc3/core.c                            |  15 +-
 drivers/usb/dwc3/gadget.c                          |  11 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   1 +
 drivers/usb/gadget/udc/tegra-xudc.c                |   2 +-
 drivers/usb/host/xhci-debugfs.c                    |   1 +
 drivers/usb/host/xhci-rcar.c                       |   3 -
 drivers/usb/mtu3/mtu3_qmu.c                        |   5 +-
 drivers/usb/serial/option.c                        |   6 +
 drivers/watchdog/dw_wdt.c                          |   7 +-
 drivers/xen/pcpu.c                                 |  20 +
 fs/afs/inode.c                                     |   1 +
 fs/btrfs/block-rsv.c                               |   3 +-
 fs/btrfs/ctree.c                                   |  32 +-
 fs/btrfs/ioctl.c                                   |   5 +
 fs/btrfs/print-tree.c                              |   6 +-
 fs/cifs/smb2ops.c                                  |   2 +-
 fs/erofs/internal.h                                |   2 +-
 fs/erofs/zmap.c                                    |   4 +
 fs/ext4/acl.c                                      |   2 -
 fs/ext4/balloc.c                                   |  25 +
 fs/ext4/extents.c                                  |   5 +-
 fs/ext4/extents_status.c                           |  30 +-
 fs/ext4/file.c                                     |   4 -
 fs/ext4/inline.c                                   |  17 +-
 fs/ext4/inode.c                                    |   9 +-
 fs/ext4/ioctl.c                                    |   8 +-
 fs/ext4/mballoc.c                                  |   6 +-
 fs/ext4/super.c                                    |  19 +-
 fs/ext4/xattr.c                                    |   5 +-
 fs/f2fs/compress.c                                 |   6 +
 fs/f2fs/data.c                                     |   5 +-
 fs/f2fs/f2fs.h                                     |   2 +-
 fs/f2fs/file.c                                     |  15 +-
 fs/f2fs/namei.c                                    |  16 +-
 fs/f2fs/segment.c                                  |  76 +--
 fs/f2fs/segment.h                                  |   6 +
 fs/f2fs/super.c                                    |  33 +-
 fs/fs-writeback.c                                  |  19 +-
 fs/jbd2/journal.c                                  |   2 +
 fs/jbd2/transaction.c                              |   3 +
 fs/nfs/nfs4state.c                                 |   4 +
 fs/nilfs2/bmap.c                                   |  16 +-
 fs/nilfs2/segment.c                                |   5 +-
 fs/notify/inotify/inotify_fsnotify.c               |  11 +-
 fs/pstore/pmsg.c                                   |   7 +-
 fs/reiserfs/xattr_security.c                       |   8 +-
 fs/ubifs/dir.c                                     |   1 +
 fs/ubifs/tnc.c                                     | 144 +++--
 include/asm-generic/io.h                           |   4 +-
 include/linux/blk-crypto.h                         |   4 +-
 include/linux/mailbox/zynqmp-ipi-message.h         |   2 +-
 include/linux/mlx5/mlx5_ifc.h                      |   3 +-
 include/linux/netfilter/nfnetlink.h                |   1 -
 include/linux/nvme.h                               |   4 +
 include/linux/posix-timers.h                       |  17 +-
 include/linux/printk.h                             |  19 +
 include/linux/sunrpc/sched.h                       |   3 +-
 include/linux/tick.h                               |   2 +
 include/linux/tty.h                                |  97 ----
 include/linux/vt_buffer.h                          |   2 +-
 include/linux/workqueue.h                          |   4 +-
 include/net/netfilter/nf_tables.h                  |   1 +
 include/net/scm.h                                  |  13 +-
 include/net/xsk_buff_pool.h                        |   9 +-
 include/soc/bcm2835/raspberrypi-firmware.h         |   8 +
 include/target/target_core_base.h                  |  16 +-
 include/trace/events/qrtr.h                        |  33 +-
 include/trace/events/timer.h                       |   3 +-
 include/uapi/linux/btrfs.h                         |   1 +
 include/uapi/linux/const.h                         |   2 +-
 include/xen/xen.h                                  |  11 +
 kernel/bpf/cgroup.c                                |   9 +-
 kernel/bpf/verifier.c                              |  26 +-
 kernel/events/core.c                               |   4 +-
 kernel/fork.c                                      |  17 +-
 kernel/kheaders.c                                  |  10 +-
 kernel/rcu/tree.c                                  |   1 +
 kernel/relay.c                                     |   3 +-
 kernel/time/posix-cpu-timers.c                     |  81 ++-
 kernel/time/posix-timers.c                         |   4 +
 kernel/time/tick-broadcast.c                       |   2 +-
 kernel/time/tick-common.c                          |  20 +-
 kernel/time/tick-internal.h                        |   1 -
 kernel/time/tick-sched.c                           | 110 ++--
 kernel/trace/ring_buffer.c                         |  20 +-
 kernel/workqueue.c                                 |  67 +--
 lib/debugobjects.c                                 | 141 +++--
 mm/backing-dev.c                                   |  11 +-
 mm/page_alloc.c                                    |  16 +
 net/8021q/vlan_dev.c                               |   2 +-
 net/bluetooth/hci_sock.c                           |   9 +-
 net/core/skbuff.c                                  |   3 +
 net/ipv4/ip_output.c                               |  16 +-
 net/ipv6/sit.c                                     |   8 +-
 net/ncsi/ncsi-aen.c                                |   1 +
 net/netfilter/nf_tables_api.c                      |  20 +-
 net/netfilter/nfnetlink.c                          |   2 -
 net/netfilter/nft_dynset.c                         |   2 +-
 net/netfilter/nft_lookup.c                         |   2 +-
 net/netfilter/nft_objref.c                         |   2 +-
 net/netlink/af_netlink.c                           |  75 +--
 net/packet/af_packet.c                             |  32 +-
 net/packet/diag.c                                  |   4 +-
 net/packet/internal.h                              |  26 +-
 net/rxrpc/sendmsg.c                                |   2 +-
 net/sched/act_mirred.c                             |   2 +-
 net/sched/cls_api.c                                |   1 +
 net/sched/sch_fq.c                                 |   6 +-
 net/sunrpc/clnt.c                                  |   3 -
 net/sunrpc/sched.c                                 |   1 -
 net/xdp/xsk_queue.h                                |   1 +
 scripts/gdb/linux/clk.py                           |   2 +
 scripts/gdb/linux/genpd.py                         |   4 +-
 scripts/gdb/linux/timerlist.py                     |   4 +-
 scripts/gdb/linux/utils.py                         |   5 +-
 security/integrity/ima/Kconfig                     |   2 +-
 security/selinux/Makefile                          |   4 +-
 sound/oss/dmasound/dmasound.h                      |   6 -
 sound/oss/dmasound/dmasound_core.c                 |  26 +-
 sound/soc/codecs/es8316.c                          |  17 +-
 sound/soc/fsl/fsl_mqs.c                            |  15 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |  12 +
 sound/soc/intel/boards/sof_sdw.c                   |  11 +
 sound/usb/caiaq/input.c                            |   1 +
 tools/bpf/bpftool/json_writer.c                    |   3 -
 tools/bpf/bpftool/xlated_dumper.c                  |   7 +
 tools/perf/builtin-sched.c                         |   2 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json |   4 +-
 .../pmu-events/arch/powerpc/power9/pipeline.json   |   2 +-
 tools/perf/util/auxtrace.c                         |   5 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   2 +
 tools/perf/util/pmu.c                              |   2 +-
 tools/perf/util/sort.c                             |   3 +-
 tools/perf/util/symbol-elf.c                       |   2 +-
 .../selftests/bpf/prog_tests/cg_storage_multi.c    |   8 +-
 tools/testing/selftests/resctrl/fill_buf.c         |   2 +
 tools/testing/selftests/resctrl/mba_test.c         |   7 +-
 379 files changed, 3626 insertions(+), 2091 deletions(-)


