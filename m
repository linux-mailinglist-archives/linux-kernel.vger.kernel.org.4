Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B932D703AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244294AbjEORz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbjEORzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:55:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB82F19F18;
        Mon, 15 May 2023 10:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27192622D2;
        Mon, 15 May 2023 17:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7532C433EF;
        Mon, 15 May 2023 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173190;
        bh=HDmwxQB6TNpY2vf2AKwwF+pTD8GbJNGnpKuJtgE7AR4=;
        h=From:To:Cc:Subject:Date:From;
        b=heRneBtrPx3wEqIAUQVLuVW/o86BkwFTiQyA0BtZLcNziwaFP6RVks4TjGjHcgI/O
         CAS2XY+c+6SYNvE64/CKkIGH7pZAspjdwd1gFHklWnGn49Jwa0JlLWWwh2quhtT5gu
         MBs81cMfv6As2922xM/mKSW3Pu/It0rppSf5zbDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.4 000/282] 5.4.243-rc1 review
Date:   Mon, 15 May 2023 18:26:18 +0200
Message-Id: <20230515161722.146344674@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.243-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.243-rc1
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

This is the start of the stable review cycle for the 5.4.243 release.
There are 282 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.243-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.243-rc1

Aurabindo Pillai <aurabindo.pillai@amd.com>
    drm/amd/display: Fix hang when skipping modeset

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock

Tian Tao <tiantao6@hisilicon.com>
    drm/exynos: move to use request_irq by IRQF_NO_AUTOEN flag

Akhil P Oommen <quic_akhilpo@quicinc.com>
    drm/msm/adreno: Fix null ptr access in adreno_gpu_cleanup()

Yang Yingliang <yangyingliang@huawei.com>
    firmware: raspberrypi: fix possible memory leak in rpi_firmware_probe()

Maximilian Luz <luzmaximilian@gmail.com>
    drm/msm: Fix double pm_runtime_disable() call

Zhang Qilong <zhangqilong3@huawei.com>
    spi: imx: fix reference leak in two imx operations

Sascha Hauer <s.hauer@pengutronix.de>
    spi: imx: fix runtime pm support for !CONFIG_PM

Geert Uytterhoeven <geert+renesas@glider.be>
    PM: domains: Restore comment indentation for generic_pm_domain.child_links

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    printk: declare printk_deferred_{enter,safe}() in include/linux/printk.h

Lukas Wunner <lukas@wunner.de>
    PCI: pciehp: Fix AB-BA deadlock between reset_lock and device_lock

Hans de Goede <hdegoede@redhat.com>
    PCI: pciehp: Use down_read/write_nested(reset_lock) to fix lockdep errors

Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
    drbd: correctly submit flush bio on barrier

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    serial: 8250: Fix serial8250_tx_empty() race with DMA Tx

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH

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

Jan Kara <jack@suse.cz>
    ext4: fix data races when using cached status extents

Tudor Ambarus <tudor.ambarus@linaro.org>
    ext4: avoid a potential slab-out-of-bounds in ext4_group_desc_csum

Ye Bin <yebin10@huawei.com>
    ext4: fix WARNING in mb_find_extent

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
    sh: math-emu: fix macro redefined warning

Jan Kara <jack@suse.cz>
    inotify: Avoid reporting event with invalid wd

Andrey Avdeev <jamesstoun@gmail.com>
    platform/x86: touchscreen_dmi: Add info for the Dexp Ursus KX210i

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

Markus Elfring <Markus.Elfring@web.de>
    perf map: Delete two variable initialisations before null pointer checks in sort__sym_from_cmp()

Kajol Jain <kjain@linux.ibm.com>
    perf vendor events power9: Remove UTF-8 characters from JSON files

Florian Fainelli <f.fainelli@gmail.com>
    net: bcmgenet: Remove phy_stop() from bcmgenet_netif_stop()

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

David Howells <dhowells@redhat.com>
    rxrpc: Fix hard call timeout units

Victor Nogueira <victor@mojatatu.com>
    net/sched: act_mirred: Add carrier check

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

Zhang Zhengming <zhang.zhengming@h3c.com>
    relayfs: fix out-of-bounds access in relay_file_read

Pengcheng Yang <yangpc@wangsu.com>
    kernel/relay.c: fix read_pos error when multiple readers

Jonathan McDowell <noodles@earth.li>
    crypto: safexcel - Cleanup ring IRQ workqueues on load failure

Sven Auhagen <Sven.Auhagen@voleatech.de>
    crypto: inside-secure - irq balance

Yeongjin Gil <youngjin.gil@samsung.com>
    dm verity: fix error handling for check_at_most_once on FEC

Akilesh Kailash <akailash@google.com>
    dm verity: skip redundant verity_handle_err() on I/O errors

Tanmay Shah <tanmay.shah@amd.com>
    mailbox: zynqmp: Fix counts of child nodes

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mailbox: zynq: Switch to flexible array to simplify code

Joel Fernandes (Google) <joel@joelfernandes.org>
    tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem

Frederic Weisbecker <frederic@kernel.org>
    nohz: Add TICK_DEP_BIT_RCU

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: deactivate anonymous set from preparation phase

Thomas Gleixner <tglx@linutronix.de>
    debugobject: Ensure pool refill (again)

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

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix hanging blockdevice after request requeue

Qu Wenruo <wqu@suse.com>
    btrfs: scrub: reject unsupported scrub flags

Peng Liu <liupeng17@lenovo.com>
    scripts/gdb: fix lx-timerlist for Python3

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

Marc Dionne <marc.dionne@auristor.com>
    afs: Fix updating of i_size with dv jump from server

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

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    clocksource: davinci: axe a pointless __GFP_NOFAIL

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    clocksource/drivers/davinci: Avoid trailing '\n' hidden in pr_fmt()

Mark Zhang <markzhang@nvidia.com>
    RDMA/mlx5: Use correct device num_ports when modify DC

Dai Ngo <dai.ngo@oracle.com>
    SUNRPC: remove the maximum number of retries in call_bind_status

Miaoqian Lin <linmq006@gmail.com>
    Input: raspberrypi-ts - fix refcount leak in rpi_ts_probe

Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
    input: raspberrypi-ts: Release firmware handle when not needed

Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
    firmware: raspberrypi: Introduce devm_rpi_firmware_get()

Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
    firmware: raspberrypi: Keep count of all consumers

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4.1: Always send a RECLAIM_COMPLETE after establishing lease

Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
    IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order

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

Natalia Petrova <n.petrova@fintech.ru>
    RDMA/rdmavt: Delete unnecessary NULL check

Daniil Dulov <d.dulov@aladdin.ru>
    RDMA/siw: Fix potential page_array out of range access

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

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
    sh: sq: Fix incorrect element size for allocating bitmap buffer

Kevin Brodsky <kevin.brodsky@arm.com>
    uapi/linux/const.h: prefer ISO-friendly __typeof__

Dhruva Gole <d-gole@ti.com>
    spi: cadence-quadspi: fix suspend-resume implementations

Vignesh Raghavendra <vigneshr@ti.com>
    mtd: spi-nor: cadence-quadspi: Handle probe deferral while requesting DMA channel

Vignesh Raghavendra <vigneshr@ti.com>
    mtd: spi-nor: cadence-quadspi: Don't initialize rx_dma_complete on failure

Vignesh Raghavendra <vigneshr@ti.com>
    mtd: spi-nor: cadence-quadspi: Provide a way to disable DAC mode

Vignesh Raghavendra <vigneshr@ti.com>
    mtd: spi-nor: cadence-quadspi: Make driver independent of flash geometry

Florian Fainelli <f.fainelli@gmail.com>
    scripts/gdb: bail early if there are no generic PD

Kees Cook <keescook@chromium.org>
    PM: domains: Fix up terminology with parent/child

Florian Fainelli <f.fainelli@gmail.com>
    scripts/gdb: bail early if there are no clocks

Randy Dunlap <rdunlap@infradead.org>
    ia64: salinfo: placate defined-but-not-used warning

Randy Dunlap <rdunlap@infradead.org>
    ia64: mm/contig: fix section mismatch warning/error

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

Barry Song <song.bao.hua@hisilicon.com>
    genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()

H. Nikolaus Schaller <hns@goldelico.com>
    PCI: imx6: Install the fault handler only on compatible match

Zheng Wang <zyytlz.wz@163.com>
    usb: gadget: udc: renesas_usb3: Fix use after free bug in renesas_usb3_remove due to race condition

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: imx: Don't skip cleanup in remove's error path

Minghao Chi <chi.minghao@zte.com.cn>
    spi: spi-imx: using pm_runtime_resume_and_get instead of pm_runtime_get_sync

Clark Wang <xiaoning.wang@nxp.com>
    spi: imx: enable runtime pm support

Linus Walleij <linus.walleij@linaro.org>
    spi: imx/fsl-lpspi: Convert to GPIO descriptors

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    iio: light: max44009: add missing OF device matching

Marco Pagani <marpagan@redhat.com>
    fpga: bridge: fix kernel-doc parameter description

Wolfram Sang <wsa+renesas@sang-engineering.com>
    usb: host: xhci-rcar: remove leftover quirk handling

John Stultz <jstultz@google.com>
    pstore: Revert pmsg_lock back to a normal mutex

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

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: don't write table validation state without mutex

Stanislav Fomichev <sdf@google.com>
    bpf: Don't EFAULT for getsockopt with optval=NULL

Joe Damato <jdamato@fastly.com>
    ixgbe: Enable setting RSS table to default values

Joe Damato <jdamato@fastly.com>
    ixgbe: Allow flow hash to be set via ethtool

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: check firmware response size

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: make the loop for card preparation effective

Yu Kuai <yukuai3@huawei.com>
    md/raid10: fix memleak of md thread

Christoph Hellwig <hch@lst.de>
    md: update the optimal I/O size on reshape

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

Shuchang Li <lishuchang@hust.edu.cn>
    scsi: lpfc: Fix ioremap issues in lpfc_sli4_pci_mem_setup()

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: drbg - Only fail when jent is unavailable in FIPS mode

Nicolai Stange <nstange@suse.de>
    crypto: drbg - make drbg_prepare_hrng() handle jent instantiation errors

Quentin Monnet <quentin@isovalent.com>
    bpftool: Fix bug for long instructions in program CFG dumps

Wei Chen <harperchen1110@gmail.com>
    wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_reg()

Wei Chen <harperchen1110@gmail.com>
    wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_rfreg()

Larry Finger <Larry.Finger@lwfinger.net>
    rtlwifi: Replace RT_TRACE with rtl_dbg

Larry Finger <Larry.Finger@lwfinger.net>
    rtlwifi: Start changing RT_TRACE into rtl_dbg

Yangtao Li <frank.li@vivo.com>
    f2fs: handle dqget error in f2fs_transfer_project_quota()

Danila Chernetsov <listdansp@mail.ru>
    scsi: megaraid: Fix mega_cmd_done() CMDID_INT_CMDS

Mike Christie <michael.christie@oracle.com>
    scsi: target: iscsit: Fix TAS handling during conn cleanup

Eric Dumazet <edumazet@google.com>
    net/packet: convert po->auxdata to an atomic flag

Eric Dumazet <edumazet@google.com>
    net/packet: convert po->origdev to an atomic flag

Eric Dumazet <edumazet@google.com>
    net/packet: annotate accesses to po->xmit

Vadim Fedorenko <vadim.fedorenko@linux.dev>
    vlan: partially enable SIOCSHWTSTAMP in container

Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
    scm: fix MSG_CTRUNC setting condition for SO_PASSSEC

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

Thomas Gleixner <tglx@linutronix.de>
    timekeeping: Split jiffies seqlock

Thomas Gleixner <tglx@linutronix.de>
    debugobject: Prevent init race with static objects

Sumit Garg <sumit.garg@linaro.org>
    arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

Saurabh Sengar <ssengar@linux.microsoft.com>
    x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()

YAN SHI <m202071378@hust.edu.cn>
    regulator: stm32-pwr: fix of_iomap leak

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

Uros Bizjak <ubizjak@gmail.com>
    x86/apic: Fix atomic update of offset in reserve_eilvt_offset()

Douglas Anderson <dianders@chromium.org>
    regulator: core: Avoid lockdep reports when resolving supplies

Douglas Anderson <dianders@chromium.org>
    regulator: core: Consistently set mutex_owner when using ww_mutex_lock_slow()

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    drm/lima/lima_drv: Add missing unwind goto in lima_pdev_probe()

Georgii Kruglov <georgy.kruglov@yandex.ru>
    mmc: sdhci-of-esdhc: fix quirk to ignore command inhibit for data

Johan Hovold <johan+linaro@kernel.org>
    drm/msm/adreno: drop bogus pm_runtime_set_active()

Rob Clark <robdclark@chromium.org>
    drm/msm/adreno: Defer enabling runpm until hw_init()

Jonathan Marek <jonathan@marek.ca>
    drm/msm: fix unbalanced pm_runtime_enable in adreno_gpu_{init, cleanup}

Mukesh Ojha <quic_mojha@quicinc.com>
    firmware: qcom_scm: Clear download bit during reboot

Dan Carpenter <error27@gmail.com>
    media: av7110: prevent underflow in write_ts_to_decoder()

Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
    media: uapi: add MEDIA_BUS_FMT_METADATA_FIXED media bus format.

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    media: bdisp: Add missing check for create_workqueue

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    ARM: dts: qcom: ipq8064: Fix the PCI I/O port range

Christian Marangi <ansuelsmth@gmail.com>
    ARM: dts: qcom: ipq8064: reduce pci IO size to 64K

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    ARM: dts: qcom: ipq4019: Fix the PCI I/O port range

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    EDAC/skx: Fix overflows on the DRAM row address mapping arrays

Geert Uytterhoeven <geert+renesas@glider.be>
    arm64: dts: renesas: r8a774c0: Remove bogus voltages from OPP table

Geert Uytterhoeven <geert+renesas@glider.be>
    arm64: dts: renesas: r8a77990: Remove bogus voltages from OPP table

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
    tpm, tpm_tis: Do not skip reset of original interrupt vector

Paul Moore <paul@paul-moore.com>
    selinux: ensure av_permissions.h is built when needed

Ondrej Mosnacek <omosnace@redhat.com>
    selinux: fix Makefile dependencies of flask.h

Mårten Lindahl <marten.lindahl@axis.com>
    ubifs: Free memory for tmpfile name

Wang YanQing <udknight@gmail.com>
    ubi: Fix return value overwrite issue in try_write_vid_and_data()

Zhihao Cheng <chengzhihao1@huawei.com>
    ubifs: Fix memleak when insert_old_idx() failed

Zhihao Cheng <chengzhihao1@huawei.com>
    Revert "ubifs: dirty_cow_znode: Fix memleak in error handling path"

Reid Tonking <reidt@ti.com>
    i2c: omap: Fix standard mode false ACK readings

Sean Christopherson <seanjc@google.com>
    KVM: nVMX: Emulate NOPs in L2, and PAUSE if it's not intercepted

Roberto Sassu <roberto.sassu@huawei.com>
    reiserfs: Add security prefix to xattr name in reiserfs_security_write()

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

Johan Hovold <johan+linaro@kernel.org>
    xhci: fix debugfs register accesses while suspended

Geert Uytterhoeven <geert+renesas@glider.be>
    debugfs: regset32: Add Runtime PM support

Nuno Sá <nuno.sa@analog.com>
    staging: iio: resolver: ads1210: fix config mode

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf sched: Cast PTHREAD_STACK_MIN to int as it may turn into sysconf(__SC_THREAD_STACK_MIN_VALUE)

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: fix runtime pm imbalance on unbind

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: fix runtime pm imbalance on probe errors

Randy Dunlap <rdunlap@infradead.org>
    IMA: allow/fix UML builds

Vladimir Oltean <vladimir.oltean@nxp.com>
    asm-generic/io.h: suppress endianness warnings for readq() and writeq()

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: bytcr_rt5640: Add quirk for the Acer Iconia One 7 B1-750

Patrik Dahlström <risca@dalakolonin.se>
    iio: adc: palmas_gpadc: fix NULL dereference on rmmod

Arınç ÜNAL <arinc.unal@arinc9.com>
    USB: serial: option: add UNISOC vendor and TOZED LT70C product

Ruihan Li <lrh2000@pku.edu.cn>
    bluetooth: Perform careful capability checks in hci_sock_ioctl()

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/fb-helper: set x/yres_virtual in drm_fb_helper_check_var

Jisoo Jang <jisoo.jang@yonsei.ac.kr>
    wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()

William Breathitt Gray <william.gray@linaro.org>
    counter: 104-quad-8: Fix race condition between FLAG and CNTR reads


-------------

Diffstat:

 Documentation/media/uapi/v4l/subdev-formats.rst    |  27 ++
 Makefile                                           |   4 +-
 arch/arm/boot/dts/exynos4412-itop-elite.dts        |   2 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |   4 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |  12 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |   2 +-
 arch/arm/mach-imx/devices-imx27.h                  |  10 +-
 arch/arm/mach-imx/devices-imx31.h                  |  10 +-
 arch/arm/mach-imx/devices/devices-common.h         |   5 +-
 arch/arm/mach-imx/devices/platform-spi_imx.c       |   9 +-
 arch/arm/mach-imx/mach-mx27_3ds.c                  |  40 ++-
 arch/arm/mach-imx/mach-mx31_3ds.c                  |  13 +-
 arch/arm/mach-imx/mach-mx31lilly.c                 |  14 +-
 arch/arm/mach-imx/mach-mx31lite.c                  |  19 +-
 arch/arm/mach-imx/mach-mx31moboard.c               |  12 +-
 arch/arm/mach-imx/mach-pca100.c                    |  21 +-
 arch/arm/mach-imx/mach-pcm037_eet.c                |   7 +-
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          |   3 -
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |   3 -
 arch/arm64/include/asm/debug-monitors.h            |   1 +
 arch/arm64/kernel/debug-monitors.c                 |   5 +
 arch/arm64/kernel/kgdb.c                           |   2 +
 arch/ia64/kernel/salinfo.c                         |   2 +-
 arch/ia64/mm/contig.c                              |   2 +-
 arch/mips/fw/lib/cmdline.c                         |   2 +-
 arch/openrisc/kernel/entry.S                       |   6 +-
 arch/parisc/kernel/real2.S                         |   5 +-
 arch/powerpc/kernel/rtas.c                         |   2 +-
 arch/powerpc/platforms/512x/clock-commonclk.c      |   2 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |   2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |   2 +-
 arch/powerpc/platforms/embedded6xx/wii.c           |   4 +-
 arch/powerpc/sysdev/tsi108_pci.c                   |   5 +-
 arch/sh/kernel/cpu/sh4/sq.c                        |   2 +-
 arch/sh/kernel/head_32.S                           |   6 +-
 arch/sh/kernel/nmi_debug.c                         |   4 +-
 arch/sh/kernel/setup.c                             |   4 +-
 arch/sh/math-emu/sfp-util.h                        |   4 -
 arch/x86/kernel/apic/apic.c                        |   5 +-
 arch/x86/kernel/apic/io_apic.c                     |  14 +-
 arch/x86/kvm/vmx/vmx.c                             |  15 ++
 crypto/drbg.c                                      |  16 +-
 drivers/base/cpu.c                                 |   3 +-
 drivers/base/power/domain.c                        | 194 +++++++-------
 drivers/base/power/domain_governor.c               |  12 +-
 drivers/block/drbd/drbd_receiver.c                 |   2 +-
 drivers/bluetooth/btsdio.c                         |   1 -
 drivers/char/ipmi/ipmi_ssif.c                      |   8 +-
 drivers/char/tpm/tpm_tis_core.c                    |  29 +--
 drivers/clk/clk-conf.c                             |  12 +-
 drivers/clk/rockchip/clk-rk3399.c                  |   2 +-
 drivers/clocksource/timer-davinci.c                |  48 ++--
 drivers/counter/104-quad-8.c                       |  30 +--
 drivers/crypto/inside-secure/safexcel.c            |  50 +++-
 drivers/crypto/inside-secure/safexcel.h            |   3 +
 drivers/dma/at_xdmac.c                             |   5 +-
 drivers/dma/dw-edma/dw-edma-core.c                 |  27 +-
 drivers/dma/mv_xor_v2.c                            |   2 +-
 drivers/edac/skx_base.c                            |   4 +-
 drivers/firmware/qcom_scm.c                        |   3 +-
 drivers/firmware/raspberrypi.c                     |  70 ++++-
 drivers/firmware/stratix10-svc.c                   |   4 +-
 drivers/fpga/fpga-bridge.c                         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   8 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   5 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   3 +
 drivers/gpu/drm/drm_fb_helper.c                    |   3 +
 drivers/gpu/drm/drm_probe_helper.c                 |   5 +-
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |   7 +-
 drivers/gpu/drm/lima/lima_drv.c                    |   6 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   7 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   5 +-
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   |   2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |   3 -
 drivers/gpu/drm/vgem/vgem_fence.c                  |   1 +
 drivers/hid/wacom_wac.c                            |  38 ++-
 drivers/hid/wacom_wac.h                            |   1 +
 drivers/i2c/busses/i2c-omap.c                      |   2 +-
 drivers/iio/adc/palmas_gpadc.c                     |   2 +-
 drivers/iio/light/max44009.c                       |  13 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c                |  13 +-
 drivers/infiniband/hw/mlx4/qp.c                    |   8 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   2 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |   2 -
 drivers/infiniband/sw/siw/siw_main.c               |   3 -
 drivers/infiniband/sw/siw/siw_qp_tx.c              |   2 +-
 drivers/input/touchscreen/raspberrypi-ts.c         |   3 +-
 drivers/leds/Kconfig                               |   2 +-
 drivers/macintosh/Kconfig                          |   1 +
 drivers/macintosh/windfarm_smu_sat.c               |   1 +
 drivers/mailbox/zynqmp-ipi-mailbox.c               |  19 +-
 drivers/md/dm-clone-target.c                       |   1 +
 drivers/md/dm-flakey.c                             |   4 +-
 drivers/md/dm-integrity.c                          |   8 +-
 drivers/md/dm-ioctl.c                              |   7 +-
 drivers/md/dm-verity-target.c                      |  17 +-
 drivers/md/raid10.c                                |  96 +++----
 drivers/md/raid5.c                                 |  10 +-
 drivers/media/pci/dm1105/dm1105.c                  |   1 +
 drivers/media/pci/saa7134/saa7134-ts.c             |   1 +
 drivers/media/pci/saa7134/saa7134-vbi.c            |   1 +
 drivers/media/pci/saa7134/saa7134-video.c          |   1 +
 drivers/media/pci/ttpci/av7110_av.c                |   4 +-
 drivers/media/platform/rcar_fdp1.c                 |  50 ++--
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c      |   2 +
 drivers/media/rc/gpio-ir-recv.c                    |   2 +
 drivers/misc/vmw_vmci/vmci_host.c                  |   8 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  24 +-
 drivers/mtd/spi-nor/cadence-quadspi.c              |  77 +++---
 drivers/mtd/ubi/eba.c                              |  19 +-
 drivers/net/dsa/mt7530.c                           |   4 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   1 +
 drivers/net/ethernet/amd/nmclan_cs.c               |   2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  23 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |   2 +-
 drivers/net/virtio_net.c                           |  43 ++--
 drivers/net/wireless/ath/ath5k/eeprom.c            |   2 +-
 drivers/net/wireless/ath/ath6kl/bmi.c              |   2 +-
 drivers/net/wireless/ath/ath6kl/htc_pipe.c         |   4 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |  19 ++
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   5 +
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |  10 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   3 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |   1 +
 drivers/net/wireless/realtek/rtlwifi/base.c        | 144 +++++------
 drivers/net/wireless/realtek/rtlwifi/cam.c         |  82 +++---
 drivers/net/wireless/realtek/rtlwifi/core.c        | 259 +++++++++----------
 drivers/net/wireless/realtek/rtlwifi/debug.c       |  16 +-
 drivers/net/wireless/realtek/rtlwifi/debug.h       |  11 +
 drivers/net/wireless/realtek/rtlwifi/efuse.c       |  72 +++---
 drivers/net/wireless/realtek/rtlwifi/pci.c         | 282 ++++++++++-----------
 drivers/net/wireless/realtek/rtlwifi/ps.c          |  98 +++----
 drivers/net/wireless/realtek/rtlwifi/regd.c        |  18 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |  18 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |   8 +-
 drivers/nvme/host/core.c                           |  34 ++-
 drivers/nvme/host/trace.h                          |  15 +-
 drivers/nvme/target/fcloop.c                       |  48 ++--
 drivers/of/device.c                                |   7 +-
 drivers/pci/controller/dwc/pci-imx6.c              |   7 +
 drivers/pci/hotplug/pciehp.h                       |   3 +
 drivers/pci/hotplug/pciehp_core.c                  |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  19 +-
 drivers/pci/hotplug/pciehp_pci.c                   |  15 ++
 drivers/phy/tegra/xusb.c                           |   2 +
 drivers/platform/x86/touchscreen_dmi.c             |  24 ++
 drivers/power/supply/generic-adc-battery.c         |   3 +
 drivers/pwm/pwm-meson.c                            |   6 +-
 drivers/pwm/pwm-mtk-disp.c                         |  98 ++++---
 drivers/regulator/core.c                           |  93 ++++++-
 drivers/regulator/stm32-pwr.c                      |   7 +-
 drivers/remoteproc/st_remoteproc.c                 |   5 +-
 drivers/remoteproc/stm32_rproc.c                   |   6 +-
 drivers/rtc/rtc-meson-vrtc.c                       |   4 +-
 drivers/rtc/rtc-omap.c                             |   1 +
 drivers/s390/block/dasd.c                          |   2 +-
 drivers/scsi/lpfc/lpfc_init.c                      |  10 +-
 drivers/scsi/megaraid.c                            |   1 +
 drivers/spi/spi-fsl-lpspi.c                        |  47 +---
 drivers/spi/spi-fsl-spi.c                          |  12 +-
 drivers/spi/spi-imx.c                              | 209 +++++++--------
 drivers/spi/spi-qup.c                              |  22 +-
 drivers/spmi/spmi.c                                |   3 +-
 drivers/staging/iio/resolver/ad2s1210.c            |   2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   1 +
 drivers/target/iscsi/iscsi_target.c                |  16 +-
 drivers/tty/serial/8250/8250.h                     |  12 +
 drivers/tty/serial/8250/8250_port.c                |  16 +-
 drivers/tty/serial/fsl_lpuart.c                    |   2 +-
 drivers/tty/tty_io.c                               |   4 +-
 drivers/tty/tty_ioctl.c                            |  47 +++-
 drivers/usb/chipidea/core.c                        |   2 +-
 drivers/usb/dwc3/core.c                            |  15 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   1 +
 drivers/usb/host/xhci-debugfs.c                    |   1 +
 drivers/usb/host/xhci-rcar.c                       |   3 -
 drivers/usb/mtu3/mtu3_qmu.c                        |   5 +-
 drivers/usb/serial/option.c                        |   6 +
 fs/afs/inode.c                                     |   1 +
 fs/btrfs/block-rsv.c                               |   3 +-
 fs/btrfs/ctree.c                                   |  32 ++-
 fs/btrfs/ioctl.c                                   |   5 +
 fs/btrfs/print-tree.c                              |   6 +-
 fs/cifs/smb2ops.c                                  |   2 +-
 fs/debugfs/file.c                                  |   8 +
 fs/erofs/internal.h                                |   2 +-
 fs/erofs/zmap.c                                    |   4 +
 fs/ext4/balloc.c                                   |  25 ++
 fs/ext4/extents.c                                  |   3 +-
 fs/ext4/extents_status.c                           |  30 +--
 fs/ext4/inline.c                                   |  17 +-
 fs/ext4/mballoc.c                                  |   6 +-
 fs/ext4/super.c                                    |  19 +-
 fs/ext4/xattr.c                                    |   5 +-
 fs/f2fs/file.c                                     |  15 +-
 fs/f2fs/namei.c                                    |  16 +-
 fs/fs-writeback.c                                  |   2 +-
 fs/nfs/nfs4state.c                                 |   4 +
 fs/nilfs2/bmap.c                                   |  16 +-
 fs/nilfs2/segment.c                                |   5 +-
 fs/notify/inotify/inotify_fsnotify.c               |  11 +-
 fs/pstore/pmsg.c                                   |   7 +-
 fs/reiserfs/xattr_security.c                       |   8 +-
 fs/ubifs/dir.c                                     |   1 +
 fs/ubifs/tnc.c                                     | 144 ++++++-----
 include/asm-generic/io.h                           |   4 +-
 include/linux/debugfs.h                            |   1 +
 include/linux/interrupt.h                          |   4 +
 include/linux/mailbox/zynqmp-ipi-message.h         |   2 +-
 include/linux/netfilter/nfnetlink.h                |   1 -
 include/linux/nvme.h                               |   4 +
 include/linux/platform_data/spi-imx.h              |  33 ---
 include/linux/pm_domain.h                          |  12 +-
 include/linux/printk.h                             |  19 ++
 include/linux/sunrpc/sched.h                       |   3 +-
 include/linux/tick.h                               |   9 +-
 include/linux/tty.h                                |   2 +
 include/linux/vt_buffer.h                          |   2 +-
 include/net/netfilter/nf_tables.h                  |   1 +
 include/net/scm.h                                  |  13 +-
 include/soc/bcm2835/raspberrypi-firmware.h         |  10 +
 include/trace/events/timer.h                       |   3 +-
 include/uapi/linux/btrfs.h                         |   1 +
 include/uapi/linux/const.h                         |   2 +-
 include/uapi/linux/media-bus-format.h              |   8 +
 kernel/bpf/cgroup.c                                |   9 +-
 kernel/events/core.c                               |   4 +-
 kernel/irq/manage.c                                |  11 +-
 kernel/kheaders.c                                  |  10 +-
 kernel/relay.c                                     |  18 +-
 kernel/time/jiffies.c                              |   7 +-
 kernel/time/tick-broadcast.c                       |   2 +-
 kernel/time/tick-common.c                          |  30 ++-
 kernel/time/tick-internal.h                        |   1 -
 kernel/time/tick-sched.c                           | 127 ++++++----
 kernel/time/timekeeping.c                          |   6 +-
 kernel/time/timekeeping.h                          |   3 +-
 kernel/trace/ring_buffer.c                         |   4 +
 lib/debugobjects.c                                 | 141 ++++++-----
 mm/page_alloc.c                                    |  16 ++
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
 net/netlink/af_netlink.c                           |  75 ++----
 net/packet/af_packet.c                             |  32 +--
 net/packet/diag.c                                  |   4 +-
 net/packet/internal.h                              |  26 +-
 net/rxrpc/sendmsg.c                                |   2 +-
 net/sched/act_mirred.c                             |   2 +-
 net/sched/cls_api.c                                |   1 +
 net/sunrpc/clnt.c                                  |   3 -
 net/sunrpc/sched.c                                 |   1 -
 scripts/gdb/linux/clk.py                           |   2 +
 scripts/gdb/linux/genpd.py                         |  16 +-
 scripts/gdb/linux/timerlist.py                     |   4 +-
 scripts/gdb/linux/utils.py                         |   5 +-
 security/integrity/ima/Kconfig                     |   2 +-
 security/selinux/Makefile                          |   4 +-
 sound/soc/codecs/es8316.c                          |  17 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |  12 +
 sound/usb/caiaq/input.c                            |   1 +
 tools/bpf/bpftool/json_writer.c                    |   3 -
 tools/bpf/bpftool/xlated_dumper.c                  |   7 +
 tools/perf/builtin-sched.c                         |   2 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json |   4 +-
 .../pmu-events/arch/powerpc/power9/pipeline.json   |   2 +-
 tools/perf/util/auxtrace.c                         |   5 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   2 +
 tools/perf/util/sort.c                             |   3 +-
 tools/perf/util/symbol-elf.c                       |   2 +-
 283 files changed, 2682 insertions(+), 1866 deletions(-)


