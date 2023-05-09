Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774EB6FBD9D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjEID02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjEID0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:26:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F566581;
        Mon,  8 May 2023 20:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 919C5613F1;
        Tue,  9 May 2023 03:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D95C433D2;
        Tue,  9 May 2023 03:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683602779;
        bh=yw0ixEjoafkJJGkbEouuTw+T8NvhQWV3pCIePQFg2EQ=;
        h=From:To:Cc:Subject:Date:From;
        b=e1YyYnwQZDJGRu+5cj1OqwMnwKDmGjDbyVd/n9FxFRkWCzIwRZEZJlSG6bo0rgqyA
         hYhxCrsadkX2Ks/fBfZNwxqer66ImR57sLGIfCKfYrAjbEIXAJV0lJ4m+dyVyu3yN4
         bM0SpnVuxmuZNj+3BKSXwIuI/OvHzt8fsVMBlgMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.15 000/370] 5.15.111-rc2 review
Date:   Tue,  9 May 2023 05:26:15 +0200
Message-Id: <20230509030611.521807993@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.111-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.111-rc2
X-KernelTest-Deadline: 2023-05-11T03:06+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.15.111 release.
There are 370 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.111-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.111-rc2

Vincent Guittot <vincent.guittot@linaro.org>
    arm64: dts: qcom: sdm845: correct dynamic power coefficients - again

Miles Chen <miles.chen@mediatek.com>
    sound/oss/dmasound: fix 'dmasound_setup' defined but not used

Thomas Gleixner <tglx@linutronix.de>
    debugobject: Ensure pool refill (again)

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix CYC timestamps after standalone CBR

Adrian Hunter <adrian.hunter@intel.com>
    perf auxtrace: Fix address filter entire kernel size

Li Lingfeng <lilingfeng3@huawei.com>
    dm: don't lock fs when the map is NULL in process of resume

Mike Snitzer <snitzer@kernel.org>
    dm ioctl: fix nested locking in table_clear() to remove deadlock concern

Mikulas Patocka <mpatocka@redhat.com>
    dm flakey: fix a crash with invalid table line

Mike Snitzer <snitzer@kernel.org>
    dm integrity: call kmem_cache_destroy() in dm_integrity_init() error path

Mike Snitzer <snitzer@kernel.org>
    dm clone: call kmem_cache_destroy() in dm_clone_init() error path

Yeongjin Gil <youngjin.gil@samsung.com>
    dm verity: fix error handling for check_at_most_once on FEC

Hugh Dickins <hughd@google.com>
    ia64: fix an addr to taddr in huge_pte_offset()

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

Michael Walle <michael@walle.cc>
    mtd: core: fix error path for nvmem provider

Michael Walle <michael@walle.cc>
    mtd: core: fix nvmem error reporting

Michael Walle <michael@walle.cc>
    mtd: core: provide unique name for nvmem device, take two

Li Nan <linan122@huawei.com>
    md/raid10: fix null-ptr-deref in raid10_sync_request

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix infinite loop in nilfs_mdt_get_block()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: do not write dirty data after degenerating to read-only

Geraldo Nascimento <geraldogabriel@gmail.com>
    ALSA: usb-audio: Add quirk for Pioneer DDJ-800

Helge Deller <deller@gmx.de>
    parisc: Fix argument pointer in real64_call_asm()

Marc Dionne <marc.dionne@auristor.com>
    afs: Fix updating of i_size with dv jump from server

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    mfd: tqmx86: Correct board names for TQMxE39x

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    mfd: tqmx86: Specify IO port register range more precisely

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    mfd: tqmx86: Do not access I2C_DETECT register through io_base

Kang Chen <void0red@hust.edu.cn>
    thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe

Claudiu Beznea <claudiu.beznea@microchip.com>
    dmaengine: at_xdmac: do not enable all cyclic channels

Tudor Ambarus <tudor.ambarus@microchip.com>
    dmaengine: at_xdmac: Fix race for the tx desc callback

Tudor Ambarus <tudor.ambarus@microchip.com>
    dmaengine: at_xdmac: Fix concurrency over chan's completed_cookie

Shunsuke Mie <mie@igel.co.jp>
    dmaengine: dw-edma: Fix to enable to issue dma request on DMA processing

Shunsuke Mie <mie@igel.co.jp>
    dmaengine: dw-edma: Fix to change for continuous transfer

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    dma: gpi: remove spurious unlock in gpi_ch_init

Gaosheng Cui <cuigaosheng1@huawei.com>
    phy: tegra: xusb: Add missing tegra_xusb_port_unregister for usb2_port and ulpi_port

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    pwm: mtk-disp: Configure double buffering before reading in .get_state()

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    pwm: mtk-disp: Disable shadow registers before setting backlight values

H. Nikolaus Schaller <hns@goldelico.com>
    leds: tca6507: Fix error handling of using fwnode_property_read_string

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: mv_xor_v2: Fix an error code.

Randy Dunlap <rdunlap@infradead.org>
    leds: TI_LMU_COMMON: select REGMAP instead of depending on it

Hai Pham <hai.pham.ud@renesas.com>
    pinctrl: renesas: r8a779a0: Remove incorrect AVB[01] pinmux configuration

Ye Bin <yebin10@huawei.com>
    ext4: fix use-after-free read in ext4_find_extent for bigalloc + inline

Zhihao Cheng <chengzhihao1@huawei.com>
    ext4: fix i_disksize exceeding i_size problem in paritally written case

Bharath SM <bharathsm@microsoft.com>
    SMB3: Close deferred file handles in case of handle lease break

Bharath SM <bharathsm@microsoft.com>
    SMB3: Add missing locks to protect deferred close file list

Geert Uytterhoeven <geert+renesas@glider.be>
    timekeeping: Fix references to nonexistent ktime_get_fast_ns()

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

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: gcc-sm8350: fix PCIe PIPE clocks handling

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: regmap: add PHY clock source implementation

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4.1: Always send a RECLAIM_COMPLETE after establishing lease

Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
    IB/hfi1: Fix bugs with non-PAGE_SIZE-end multi-iovec user SDMA requests

Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
    IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order

Saravanan Vajravel <saravanan.vajravel@broadcom.com>
    RDMA/srpt: Add a check for valid 'mad_agent' pointer

Mark Zhang <markzhang@nvidia.com>
    RDMA/cm: Trace icm_send_rej event before the cm state is reset

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: gcc-sm6115: Mark RCGs shared where applicable

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    RDMA/siw: Remove namespace check from siw_netdev_event()

Clément Léger <clement.leger@bootlin.com>
    clk: add missing of_node_put() in "assigned-clocks" property parsing

Sebastian Reichel <sre@kernel.org>
    power: supply: generic-adc-battery: fix unit scaling

Zeng Heng <zengheng4@huawei.com>
    fs/ntfs3: Fix slab-out-of-bounds read in hdr_delete_de()

ZhangPeng <zhangpeng362@huawei.com>
    fs/ntfs3: Fix OOB read in indx_insert_into_buffer

ZhangPeng <zhangpeng362@huawei.com>
    fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    fs/ntfs3: Add check for kmemdup

Chen Zhongjin <chenzhongjin@huawei.com>
    fs/ntfs3: Fix memory leak if ntfs_read_mft failed

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    rtc: meson-vrtc: Use ktime_get_real_ts64() to get the current time

Dan Carpenter <error27@gmail.com>
    RDMA/mlx4: Prevent shift wrapping in set_user_sq_size()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    rtc: omap: include header for omap_rtc_power_off_program prototype

Petr Mladek <pmladek@suse.com>
    workqueue: Fix hung time report of worker pools

Imran Khan <imran.f.khan@oracle.com>
    workqueue: Introduce show_one_worker_pool and show_one_workqueue.

Natalia Petrova <n.petrova@fintech.ru>
    RDMA/rdmavt: Delete unnecessary NULL check

Daniil Dulov <d.dulov@aladdin.ru>
    RDMA/siw: Fix potential page_array out of range access

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: at91: clk-sam9x60-pll: fix return value check

Schspa Shi <schspa@gmail.com>
    sched/rt: Fix bad task migration for rt tasks

Josh Poimboeuf <jpoimboe@kernel.org>
    Revert "objtool: Support addition to set CFA base"

Yang Jihong <yangjihong1@huawei.com>
    perf/core: Fix hardlockup failure caused by perf throttle

Libo Chen <libo.chen@oracle.com>
    sched/fair: Fix inaccurate tally of ttwu_move_affine

Yafang Shao <laoar.shao@gmail.com>
    sched: Make struct sched_statistics independent of fair sched class

Yafang Shao <laoar.shao@gmail.com>
    sched/fair: Use __schedstat_set() in set_next_entity()

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

Albert Huang <huangjie.albert@bytedance.com>
    virtio_ring: don't update event idx on get_buf

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

Florian Fainelli <f.fainelli@gmail.com>
    scripts/gdb: raise error with reduced debugging information

Lars-Peter Clausen <lars@metafoo.de>
    i2c: cadence: cdns_i2c_master_xfer(): Fix runtime PM leak on error path

Dhruva Gole <d-gole@ti.com>
    spi: cadence-quadspi: fix suspend-resume implementations

Liliang Ye <yll@hust.edu.cn>
    ASoC: fsl_mqs: move of_node_put() to the correct location

Suzuki K Poulose <suzuki.poulose@arm.com>
    coresight: etm_pmu: Set the module field

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    HID: amd_sfh: Add support for shutdown operation

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

H. Nikolaus Schaller <hns@goldelico.com>
    PCI: imx6: Install the fault handler only on compatible match

Zheng Wang <zyytlz.wz@163.com>
    usb: gadget: udc: renesas_usb3: Fix use after free bug in renesas_usb3_remove due to race condition

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: imx: Don't skip cleanup in remove's error path

Minghao Chi <chi.minghao@zte.com.cn>
    spi: spi-imx: using pm_runtime_resume_and_get instead of pm_runtime_get_sync

Doug Berger <opendmb@gmail.com>
    serial: 8250_bcm7271: Fix arbitration handling

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    iio: light: max44009: add missing OF device matching

Marco Pagani <marpagan@redhat.com>
    fpga: bridge: fix kernel-doc parameter description

Marek Vasut <marex@denx.de>
    serial: stm32: Re-assert RTS/DE GPIO in RS485 mode only if more data are transmitted

Erwan Le Ray <erwan.leray@foss.st.com>
    serial: stm32: re-introduce an irq flag condition in usart_receive_chars

Prashanth K <quic_prashk@quicinc.com>
    usb: dwc3: gadget: Change condition for processing suspend event

Wolfram Sang <wsa+renesas@sang-engineering.com>
    usb: host: xhci-rcar: remove leftover quirk handling

John Stultz <jstultz@google.com>
    pstore: Revert pmsg_lock back to a normal mutex

Hans de Goede <hdegoede@redhat.com>
    drivers: staging: rtl8723bs: Fix locking in rtw_scan_timeout_handler()

Hans de Goede <hdegoede@redhat.com>
    drivers: staging: rtl8723bs: Fix locking in _rtw_join_timeout_handler()

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

Yan Wang <rk.code@outlook.com>
    net: stmmac:fix system hang when setting up tag_8021q VLAN for DSA ports

Chris Mi <cmi@nvidia.com>
    net/mlx5: E-switch, Don't destroy indirect table in split rule

Joe Damato <jdamato@fastly.com>
    ixgbe: Enable setting RSS table to default values

Joe Damato <jdamato@fastly.com>
    ixgbe: Allow flow hash to be set via ethtool

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: fw: fix memory leak in debugfs

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: check firmware response size

Quan Zhou <quan.zhou@mediatek.com>
    wifi: mt76: mt7921e: improve reliability of dma reset

Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
    wifi: mt76: fix 6GHz high channel not be scanned

Quan Zhou <quan.zhou@mediatek.com>
    wifi: mt76: mt7921e: fix probe timeout after reboot

Deren Wu <deren.wu@mediatek.com>
    wifi: mt76: add flexible polling wait-interval support

Kang Chen <void0red@gmail.com>
    wifi: mt76: handle failure of vzalloc in mt7615_coredump_work

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: make the loop for card preparation effective

Jan Kara <jack@suse.cz>
    jdb2: Don't refuse invalidation of already invalidated buffers

Tom Rix <trix@redhat.com>
    wifi: iwlwifi: fw: move memset before early return

Tom Rix <trix@redhat.com>
    wifi: iwlwifi: mvm: initialize seq variable

Daniel Gabay <daniel.gabay@intel.com>
    wifi: iwlwifi: yoyo: Fix possible division by zero

Daniel Gabay <daniel.gabay@intel.com>
    wifi: iwlwifi: yoyo: skip dump correctly on hw error

Yu Kuai <yukuai3@huawei.com>
    md/raid10: don't call bio_start_io_acct twice for bio which experienced read error

Yu Kuai <yukuai3@huawei.com>
    md/raid10: fix memleak of md thread

Yu Kuai <yukuai3@huawei.com>
    md/raid10: fix memleak for 'conf->bio_split'

Yu Kuai <yukuai3@huawei.com>
    md/raid10: fix leak of 'r10bio->remaining' for recovery

Li Nan <linan122@huawei.com>
    md/raid10: fix task hung in raid10d

Yu Kuai <yukuai3@huawei.com>
    md/raid10: factor out code from wait_barrier() to stop_waiting_barrier()

Vishal Verma <vverma@digitalocean.com>
    md: raid10 add nowait support

Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
    md: drop queue limitation for RAID1 and RAID10

Daniel Borkmann <daniel@iogearbox.net>
    bpf, sockmap: Revert buggy deadlock fix in the sockhash and sockmap

Song Liu <song@kernel.org>
    selftests/bpf: Fix leaked bpf_link in get_stackid_cannot_attach

Ming Lei <ming.lei@redhat.com>
    nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage"

Keith Busch <kbusch@kernel.org>
    nvme: fix async event trace event

Michael Kelley <mikelley@microsoft.com>
    nvme: handle the persistent internal error AER

Damien Le Moal <damien.lemoal@opensource.wdc.com>
    nvmet: fix I/O Command Set specific Identify Controller

Damien Le Moal <damien.lemoal@opensource.wdc.com>
    nvmet: fix Identify Active Namespace ID list handling

Damien Le Moal <damien.lemoal@opensource.wdc.com>
    nvmet: fix Identify Controller handling

Damien Le Moal <damien.lemoal@opensource.wdc.com>
    nvmet: fix Identify Namespace handling

Damien Le Moal <damien.lemoal@opensource.wdc.com>
    nvmet: fix error handling in nvmet_execute_identify_cns_cs_ns()

Christoph Hellwig <hch@lst.de>
    nvmet: move the call to nvmet_ns_changed out of nvmet_ns_revalidate

Chaitanya Kulkarni <kch@nvidia.com>
    nvmet: use i_size_read() to set size for file-ns

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

Kal Conley <kal.conley@dectris.com>
    selftests: xsk: Disable IPv6 on VETH1

Simon Horman <horms@kernel.org>
    net: qrtr: correct types of trace event parameters

Armin Wolf <W_Armin@gmx.de>
    wifi: rt2x00: Fix memory leak when handling surveys

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

Eric Dumazet <edumazet@google.com>
    net/packet: convert po->auxdata to an atomic flag

Eric Dumazet <edumazet@google.com>
    net/packet: convert po->origdev to an atomic flag

Eric Dumazet <edumazet@google.com>
    net/packet: annotate accesses to po->xmit

Vadim Fedorenko <vadim.fedorenko@linux.dev>
    vlan: partially enable SIOCSHWTSTAMP in container

Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
    net: pcs: xpcs: remove double-read of link state when using AN

Luis Gerhorst <gerhorst@cs.fau.de>
    bpf: Remove misleading spec_v1 check on var-offset stack read

Martin KaFai Lau <martin.lau@kernel.org>
    selftests/bpf: Fix a fd leak in an error path in network_helpers.c

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

John Keeping <john@metanate.com>
    wifi: brcmfmac: support CQM RSSI notification with older firmware

Dan Carpenter <error27@gmail.com>
    wifi: ath5k: fix an off by one check in ath5k_eeprom_read_freq_list()

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: hif_usb: fix memory leak of remain_skbs

Alexey V. Vissarionov <gremlin@altlinux.org>
    wifi: ath6kl: minor fix for allocation size

Tomáš Pecka <tomas.pecka@cesnet.cz>
    hwmon: (pmbus/fsp-3y) Fix functionality bitmask in FSP-3Y YM-2151E

Sanjay Chandrashekara <sanjayc@nvidia.com>
    cpufreq: use correct unit when verify cur freq

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    tick/common: Align tick period with the HZ tick.

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

Florian Fainelli <f.fainelli@gmail.com>
    media: rc: gpio-ir-recv: Fix support for wake-up

Igor Artemiev <Igor.A.Artemiev@mcst.ru>
    drm/amd/display: Fix potential null dereference

Miaoqian Lin <linmq006@gmail.com>
    media: rcar_fdp1: Fix refcount leak in probe and remove function

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    media: rcar_fdp1: Convert to platform remove callback returning void

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    platform: Provide a remove callback that returns no value

Tang Bin <tangbin@cmss.chinamobile.com>
    media: rcar_fdp1: Fix the correct variable assignments

Cai Huoqing <caihuoqing@baidu.com>
    media: rcar_fdp1: Make use of the helper function devm_platform_ioremap_resource()

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

Thomas Hellström <thomas.hellstrom@linux.intel.com>
    drm/ttm/pool: Fix ttm_pool_alloc error path

Christian König <christian.koenig@amd.com>
    drm/ttm: optimize pool allocations a bit v2

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8994-msft-lumia-octagon: drop unit address from PMI8994 regulator

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8994-kitakami: drop unit address from PMI8994 regulator

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sc7180-trogdor-lazor: correct trackpad supply

Conor Dooley <conor.dooley@microchip.com>
    mailbox: mpfs: switch to txdone_poll

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    drm/lima/lima_drv: Add missing unwind goto in lima_pdev_probe()

Jean-Philippe Brucker <jean-philippe@linaro.org>
    ACPI: VIOT: Initialize the correct IOMMU fwspec

Cristian Marussi <cristian.marussi@arm.com>
    firmware: arm_scmi: Fix xfers allocation on Rx channel

H. Nikolaus Schaller <hns@goldelico.com>
    ARM: dts: gta04: fix excess dma channel usage

Dan Carpenter <error27@gmail.com>
    drm: rcar-du: Fix a NULL vs IS_ERR() bug

Georgii Kruglov <georgy.kruglov@yandex.ru>
    mmc: sdhci-of-esdhc: fix quirk to ignore command inhibit for data

Roger Pau Monne <roger.pau@citrix.com>
    ACPI: processor: Fix evaluating _PDC method when running as Xen dom0

Lee Jones <lee@kernel.org>
    drm/amd/display/dc/dce60/Makefile: Fix previous attempt to silence known override-init warnings

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

Dan Carpenter <error27@gmail.com>
    media: av7110: prevent underflow in write_ts_to_decoder()

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    media: bdisp: Add missing check for create_workqueue

Muralidhara M K <muralimk@amd.com>
    x86/MCE/AMD: Use an u64 for bank_map

Manivannan Sadhasivam <mani@kernel.org>
    ARM: dts: qcom: ipq8064: Fix the PCI I/O port range

Christian Marangi <ansuelsmth@gmail.com>
    ARM: dts: qcom: ipq8064: reduce pci IO size to 64K

Manivannan Sadhasivam <mani@kernel.org>
    ARM: dts: qcom: ipq4019: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: sm8250: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: msm8996: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: ipq6018: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: ipq8074: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: msm8998: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: sdm845: Fix the PCI I/O port range

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: sdm845: correct dynamic power coefficients

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: msm8998: Fix stm-stimulus-base reg name

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: broadcom: bcmbca: bcm4908: fix procmon nodename

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: broadcom: bcmbca: bcm4908: fix NAND interrupt name

William Zhang <william.zhang@broadcom.com>
    arm64: dts: Move BCM4908 dts to bcmbca folder

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: Add base DTS file for bcmbca device Asus GT-AX6000

Anand Gore <anand.gore@broadcom.com>
    ARM64: dts: Add DTS files for bcmbca SoC BCM6858

William Zhang <william.zhang@broadcom.com>
    arm64: dts: Add DTS files for bcmbca SoC BCM4912

William Zhang <william.zhang@broadcom.com>
    arm64: dts: Add DTS files for bcmbca SoC BCM63158

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: broadcom: bcm4908: add DT for Netgear RAXE500

Bhavya Kapoor <b-kapoor@ti.com>
    arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel property

Douglas Anderson <dianders@chromium.org>
    regulator: core: Shorten off-on-delay-us for always-on/boot-on by time since booted

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

Terry Bowman <terry.bowman@amd.com>
    tools/x86/kcpuid: Fix avx512bw and avx512lvl fields in Fn00000007

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
    selftests/resctrl: Allow ->setup() to return errors

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Move ->setup() call outside of test specific branches

Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
    selftests/resctrl: Extend CPU vendor detection

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Return NULL if malloc_and_init_memory() did not alloc mem

Zqiang <qiang1.zhang@intel.com>
    rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check

Randy Dunlap <rdunlap@infradead.org>
    sound/oss/dmasound: fix build when drivers are mixed =y/=m

Dave Chinner <dchinner@redhat.com>
    xfs: don't consider future format versions valid

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

Ondrej Mosnacek <omosnace@redhat.com>
    tracing: Fix permissions for the buffer_percent file

Song Shuai <suagrfillet@gmail.com>
    riscv: mm: remove redundant parameter of create_fdt_early_page_table

Reid Tonking <reidt@ti.com>
    i2c: omap: Fix standard mode false ACK readings

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix memleak in session setup

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix NULL pointer dereference in smb2_get_info_filesystem()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: call rcu_barrier() in ksmbd_server_exit()

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

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    pinctrl: qcom: lpass-lpi: set output value before enabling output

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: qcom: correct setting ignore bit on v1.5.1

Heiner Kallweit <hkallweit1@gmail.com>
    pwm: meson: Fix g12a ao clk81 name

Heiner Kallweit <hkallweit1@gmail.com>
    pwm: meson: Fix axg ao mux parents

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: add missing locking to protect against concurrent rx/status calls

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

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH

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

Manivannan Sadhasivam <mani@kernel.org>
    PCI: qcom: Fix the incorrect register usage in v2.7.0 config

Lukas Wunner <lukas@wunner.de>
    PCI: pciehp: Fix AB-BA deadlock between reset_lock and device_lock

Ard Biesheuvel <ardb@kernel.org>
    arm64: Stash shadow stack pointer in the task struct on interrupt

Ard Biesheuvel <ardb@kernel.org>
    arm64: Always load shadow stack pointer directly from the task struct

Mario Limonciello <mario.limonciello@amd.com>
    wifi: mt76: mt7921e: Set memory space enable in PCI_COMMAND if unset

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    wireguard: timers: cast enum limits members to int in prints

Tony Luck <tony.luck@intel.com>
    x86/cpu: Add model number for Intel Arrow Lake processor

Vladimir Oltean <vladimir.oltean@nxp.com>
    asm-generic/io.h: suppress endianness warnings for readq() and writeq()

Anh Tuan Phan <tuananhlfc@gmail.com>
    selftests mount: Fix mount_setattr_test builds failed

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: bytcr_rt5640: Add quirk for the Acer Iconia One 7 B1-750

Patrik Dahlström <risca@dalakolonin.se>
    iio: adc: palmas_gpadc: fix NULL dereference on rmmod

Michael Kelley <mikelley@microsoft.com>
    x86/hyperv: Block root partition functionality in a Confidential VM

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: soc-pcm: fix hw->formats cleared by soc_pcm_hw_init() for dpcm

Eugene Huang <eugene.huang99@gmail.com>
    ASOC: Intel: sof_sdw: add quirk for Intel 'Rooks County' NUC M15


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  16 +
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |   4 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |  12 +-
 arch/arm64/boot/dts/broadcom/Makefile              |   2 +-
 arch/arm64/boot/dts/broadcom/bcm4908/Makefile      |   4 -
 arch/arm64/boot/dts/broadcom/bcmbca/Makefile       |  10 +
 .../{bcm4908 => bcmbca}/bcm4906-netgear-r8000p.dts |   0
 .../bcm4906-tplink-archer-c2300-v1.dts             |   0
 .../dts/broadcom/{bcm4908 => bcmbca}/bcm4906.dtsi  |   0
 .../{bcm4908 => bcmbca}/bcm4908-asus-gt-ac5300.dts |   0
 .../broadcom/bcmbca/bcm4908-netgear-raxe500.dts    |  50 ++
 .../dts/broadcom/{bcm4908 => bcmbca}/bcm4908.dtsi  |   4 +-
 .../dts/broadcom/bcmbca/bcm4912-asus-gt-ax6000.dts |  19 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi   | 128 +++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi  | 128 +++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi   | 121 +++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts   |  30 ++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts  |  30 ++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts   |  30 ++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |   6 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |  12 +-
 .../boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi  |   3 +-
 .../dts/qcom/msm8994-sony-xperia-kitakami.dtsi     |   3 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  12 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |   4 +-
 .../qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts |   2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  30 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |   8 +-
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          |   3 -
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |   3 -
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |   1 -
 arch/arm64/include/asm/debug-monitors.h            |   1 +
 arch/arm64/include/asm/scs.h                       |   7 +-
 arch/arm64/kernel/debug-monitors.c                 |   5 +
 arch/arm64/kernel/entry.S                          |  16 +-
 arch/arm64/kernel/head.S                           |   2 +-
 arch/arm64/kernel/kgdb.c                           |   2 +
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
 arch/riscv/mm/init.c                               |   6 +-
 arch/sh/kernel/cpu/sh4/sq.c                        |   2 +-
 arch/x86/include/asm/intel-family.h                |   2 +
 arch/x86/kernel/apic/apic.c                        |   5 +-
 arch/x86/kernel/apic/io_apic.c                     |  14 +-
 arch/x86/kernel/cpu/mce/amd.c                      |  14 +-
 arch/x86/kernel/cpu/mshyperv.c                     |  12 +-
 arch/x86/kvm/vmx/vmx.c                             |  15 +
 block/blk-core.c                                   |   7 +
 block/blk-crypto-internal.h                        |  25 +-
 block/blk-crypto.c                                 |  69 ++-
 block/blk-merge.c                                  |   2 +
 block/blk-mq.c                                     |   2 +-
 block/keyslot-manager.c                            |  43 +-
 crypto/algapi.c                                    |   4 +-
 crypto/drbg.c                                      |  16 +-
 drivers/acpi/processor_pdc.c                       |  11 +
 drivers/acpi/viot.c                                |   5 +-
 drivers/base/cpu.c                                 |   3 +-
 drivers/base/platform.c                            |   4 +-
 drivers/bluetooth/btsdio.c                         |   1 -
 drivers/char/ipmi/Kconfig                          |   3 +-
 drivers/char/ipmi/ipmi_ssif.c                      |   8 +-
 drivers/char/tpm/tpm_tis_core.c                    | 135 +++--
 drivers/char/tpm/tpm_tis_core.h                    |   2 +
 drivers/clk/at91/clk-sam9x60-pll.c                 |   2 +-
 drivers/clk/clk-conf.c                             |  12 +-
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-regmap-phy-mux.c              |  62 +++
 drivers/clk/qcom/clk-regmap-phy-mux.h              |  33 ++
 drivers/clk/qcom/gcc-sm6115.c                      |  50 +-
 drivers/clk/qcom/gcc-sm8350.c                      |  47 +-
 drivers/clk/rockchip/clk-rk3399.c                  |   2 +-
 drivers/clocksource/timer-davinci.c                |  30 +-
 drivers/cpufreq/cpufreq.c                          |   2 +-
 drivers/crypto/Kconfig                             |   1 +
 drivers/crypto/caam/ctrl.c                         |   6 +-
 drivers/crypto/inside-secure/safexcel.c            |  37 +-
 drivers/dma/at_xdmac.c                             |  33 +-
 drivers/dma/dw-edma/dw-edma-core.c                 |  27 +-
 drivers/dma/mv_xor_v2.c                            |   2 +-
 drivers/dma/qcom/gpi.c                             |   1 -
 drivers/edac/skx_base.c                            |   4 +-
 drivers/firmware/arm_scmi/driver.c                 |   2 +-
 drivers/firmware/qcom_scm.c                        |   3 +-
 drivers/firmware/stratix10-svc.c                   |   4 +-
 drivers/fpga/fpga-bridge.c                         |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/dce60/Makefile      |   2 +-
 drivers/gpu/drm/bridge/adv7511/adv7533.c           |  23 +-
 drivers/gpu/drm/drm_probe_helper.c                 |   5 +-
 drivers/gpu/drm/i915/display/intel_display.c       |   2 +-
 drivers/gpu/drm/lima/lima_drv.c                    |   6 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   8 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   7 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |   4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |   3 -
 drivers/gpu/drm/ttm/ttm_pool.c                     | 161 ++++--
 drivers/gpu/drm/vgem/vgem_fence.c                  |   1 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             |   9 +
 drivers/hwmon/adt7475.c                            |   6 +-
 drivers/hwmon/k10temp.c                            |   4 +-
 drivers/hwmon/pmbus/fsp-3y.c                       |   1 -
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   1 +
 drivers/i2c/busses/i2c-cadence.c                   |   6 +-
 drivers/i2c/busses/i2c-omap.c                      |   2 +-
 drivers/iio/adc/palmas_gpadc.c                     |   2 +-
 drivers/iio/light/max44009.c                       |  13 +-
 drivers/infiniband/core/cm.c                       |   3 +-
 drivers/infiniband/hw/hfi1/ipoib_tx.c              |   1 +
 drivers/infiniband/hw/hfi1/mmu_rb.c                |  73 +--
 drivers/infiniband/hw/hfi1/mmu_rb.h                |   8 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |  21 +-
 drivers/infiniband/hw/hfi1/sdma.h                  |  16 +-
 drivers/infiniband/hw/hfi1/sdma_txreq.h            |   1 +
 drivers/infiniband/hw/hfi1/trace_mmu.h             |   4 -
 drivers/infiniband/hw/hfi1/user_sdma.c             | 600 +++++++++++++--------
 drivers/infiniband/hw/hfi1/user_sdma.h             |   5 -
 drivers/infiniband/hw/hfi1/verbs.c                 |   4 +-
 drivers/infiniband/hw/hfi1/vnic_sdma.c             |   1 +
 drivers/infiniband/hw/mlx4/qp.c                    |   8 +-
 drivers/infiniband/hw/mlx5/devx.c                  |  31 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   2 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |   2 -
 drivers/infiniband/sw/siw/siw_main.c               |   3 -
 drivers/infiniband/sw/siw/siw_qp_tx.c              |   2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |  23 +-
 drivers/input/touchscreen/raspberrypi-ts.c         |   3 +-
 drivers/iommu/amd/amd_iommu_types.h                |   4 +-
 drivers/leds/Kconfig                               |   2 +-
 drivers/leds/leds-tca6507.c                        |   5 +-
 drivers/macintosh/Kconfig                          |   1 +
 drivers/macintosh/windfarm_smu_sat.c               |   1 +
 drivers/mailbox/mailbox-mpfs.c                     |  12 +-
 drivers/mailbox/zynqmp-ipi-mailbox.c               |   6 +-
 drivers/md/dm-clone-target.c                       |   1 +
 drivers/md/dm-flakey.c                             |   4 +-
 drivers/md/dm-integrity.c                          |   8 +-
 drivers/md/dm-ioctl.c                              |  12 +-
 drivers/md/dm-table.c                              |  19 +-
 drivers/md/dm-verity-target.c                      |   2 +-
 drivers/md/raid1-10.c                              |   6 -
 drivers/md/raid1.c                                 |   7 -
 drivers/md/raid10.c                                | 221 +++++---
 drivers/media/i2c/max9286.c                        |   1 +
 drivers/media/pci/dm1105/dm1105.c                  |   1 +
 drivers/media/pci/saa7134/saa7134-ts.c             |   1 +
 drivers/media/pci/saa7134/saa7134-vbi.c            |   1 +
 drivers/media/pci/saa7134/saa7134-video.c          |   1 +
 drivers/media/platform/qcom/venus/vdec.c           |   8 +
 drivers/media/platform/rcar_fdp1.c                 |  28 +-
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c      |   2 +
 drivers/media/rc/gpio-ir-recv.c                    |   2 +
 drivers/mfd/tqmx86.c                               |  52 +-
 drivers/misc/vmw_vmci/vmci_host.c                  |   8 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  24 +-
 drivers/mtd/mtdcore.c                              |  23 +-
 drivers/mtd/ubi/eba.c                              |  19 +-
 drivers/net/ethernet/amd/nmclan_cs.c               |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  23 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   2 -
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |  14 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  12 +-
 drivers/net/pcs/pcs-xpcs.c                         |  13 +-
 drivers/net/wireguard/timers.c                     |   8 +-
 drivers/net/wireless/ath/ath5k/eeprom.c            |   2 +-
 drivers/net/wireless/ath/ath6kl/bmi.c              |   2 +-
 drivers/net/wireless/ath/ath6kl/htc_pipe.c         |   4 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |  19 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  14 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   8 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |   6 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |  10 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |   2 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |  13 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c   |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c    |  40 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   6 +
 drivers/net/wireless/mediatek/mt76/tx.c            |   4 +
 drivers/net/wireless/mediatek/mt76/util.c          |  10 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |   1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |   1 +
 drivers/net/wireless/realtek/rtlwifi/debug.c       |  12 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |   8 +-
 drivers/nvme/host/core.c                           |  34 +-
 drivers/nvme/host/trace.h                          |  15 +-
 drivers/nvme/target/admin-cmd.c                    |  51 +-
 drivers/nvme/target/configfs.c                     |   3 +-
 drivers/nvme/target/core.c                         |   5 +-
 drivers/nvme/target/fcloop.c                       |  48 +-
 drivers/nvme/target/io-cmd-file.c                  |  17 +-
 drivers/nvme/target/nvmet.h                        |   6 +-
 drivers/nvme/target/zns.c                          |  20 +-
 drivers/of/device.c                                |   7 +-
 drivers/pci/controller/dwc/pci-imx6.c              |   7 +
 drivers/pci/controller/dwc/pcie-qcom.c             |   8 +-
 drivers/pci/hotplug/pciehp_pci.c                   |  15 +
 drivers/pci/pcie/edr.c                             |   1 +
 drivers/phy/tegra/xusb.c                           |   2 +
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           |  14 +-
 drivers/pinctrl/renesas/pfc-r8a779a0.c             |   8 -
 drivers/power/supply/generic-adc-battery.c         |   3 +
 drivers/pwm/pwm-meson.c                            |   6 +-
 drivers/pwm/pwm-mtk-disp.c                         |  34 +-
 drivers/regulator/core.c                           | 100 +++-
 drivers/regulator/stm32-pwr.c                      |   7 +-
 drivers/rtc/rtc-meson-vrtc.c                       |   4 +-
 drivers/rtc/rtc-omap.c                             |   1 +
 drivers/s390/block/dasd.c                          |   2 +-
 drivers/scsi/lpfc/lpfc_init.c                      |  10 +-
 drivers/scsi/megaraid.c                            |   1 +
 drivers/soc/ti/pm33xx.c                            |   5 +-
 drivers/soundwire/qcom.c                           |   2 +-
 drivers/spi/spi-cadence-quadspi.c                  |  19 +-
 drivers/spi/spi-fsl-spi.c                          |  12 +-
 drivers/spi/spi-imx.c                              |  14 +-
 drivers/spi/spi-qup.c                              |  22 +-
 drivers/spmi/spmi.c                                |   3 +-
 drivers/staging/iio/resolver/ad2s1210.c            |   2 +-
 drivers/staging/media/av7110/av7110_av.c           |   4 +-
 drivers/staging/media/rkvdec/rkvdec.c              |   2 +
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   1 +
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |   8 +-
 drivers/target/iscsi/iscsi_target.c                |  16 +-
 drivers/target/target_core_device.c                |   1 +
 drivers/target/target_core_tmr.c                   |  26 +-
 drivers/thermal/mtk_thermal.c                      |  14 +-
 drivers/tty/serial/8250/8250_bcm7271.c             |  18 +-
 drivers/tty/serial/8250/8250_port.c                |   4 +
 drivers/tty/serial/fsl_lpuart.c                    |   2 +-
 drivers/tty/serial/stm32-usart.c                   |  26 +-
 drivers/tty/sysrq.c                                |   2 +-
 drivers/tty/tty.h                                  |   2 +
 drivers/tty/tty_io.c                               |   4 +-
 drivers/tty/tty_ioctl.c                            |  47 +-
 drivers/usb/chipidea/core.c                        |   2 +-
 drivers/usb/dwc3/core.c                            |  15 +-
 drivers/usb/dwc3/gadget.c                          |  11 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   1 +
 drivers/usb/gadget/udc/tegra-xudc.c                |   2 +-
 drivers/usb/host/xhci-debugfs.c                    |   1 +
 drivers/usb/host/xhci-rcar.c                       |   3 -
 drivers/usb/mtu3/mtu3_qmu.c                        |   5 +-
 drivers/virtio/virtio_ring.c                       |  22 +-
 drivers/xen/pcpu.c                                 |  20 +
 fs/afs/inode.c                                     |   1 +
 fs/btrfs/ioctl.c                                   |   5 +
 fs/cifs/file.c                                     |  16 +
 fs/cifs/misc.c                                     |   8 +-
 fs/erofs/internal.h                                |   2 +-
 fs/erofs/zmap.c                                    |   4 +
 fs/ext4/acl.c                                      |   2 -
 fs/ext4/extents.c                                  |   6 +-
 fs/ext4/file.c                                     |   4 -
 fs/ext4/inode.c                                    |  10 +-
 fs/ext4/ioctl.c                                    |  10 +-
 fs/f2fs/compress.c                                 |   6 +
 fs/f2fs/data.c                                     |   5 +-
 fs/f2fs/f2fs.h                                     |   2 +-
 fs/f2fs/file.c                                     |  15 +-
 fs/f2fs/segment.c                                  |  76 +--
 fs/f2fs/segment.h                                  |   6 +
 fs/f2fs/super.c                                    |  33 +-
 fs/fs-writeback.c                                  |  17 +-
 fs/jbd2/journal.c                                  |   2 +
 fs/jbd2/transaction.c                              |   3 +
 fs/ksmbd/server.c                                  |   1 +
 fs/ksmbd/smb2pdu.c                                 |   7 +
 fs/nfs/nfs4state.c                                 |   4 +
 fs/nilfs2/bmap.c                                   |  16 +-
 fs/nilfs2/segment.c                                |   5 +-
 fs/ntfs3/fslog.c                                   |   6 +-
 fs/ntfs3/index.c                                   |   8 +
 fs/ntfs3/inode.c                                   |   2 +-
 fs/ntfs3/namei.c                                   |  10 +
 fs/ntfs3/ntfs_fs.h                                 |   1 +
 fs/pstore/pmsg.c                                   |   7 +-
 fs/reiserfs/xattr_security.c                       |   8 +-
 fs/ubifs/dir.c                                     |   1 +
 fs/ubifs/tnc.c                                     | 144 +++--
 fs/xfs/libxfs/xfs_sb.c                             |  11 +-
 include/asm-generic/io.h                           |   4 +-
 include/linux/blk-crypto.h                         |   4 +-
 include/linux/mailbox/zynqmp-ipi-message.h         |   2 +-
 include/linux/mlx5/mlx5_ifc.h                      |   3 +-
 include/linux/netfilter/nfnetlink.h                |   1 -
 include/linux/nvme.h                               |   4 +
 include/linux/platform_device.h                    |  11 +
 include/linux/posix-timers.h                       |  17 +-
 include/linux/sched.h                              |   6 +-
 include/linux/sunrpc/sched.h                       |   3 +-
 include/linux/tick.h                               |   2 +
 include/linux/vt_buffer.h                          |   2 +-
 include/linux/workqueue.h                          |   3 +-
 include/net/scm.h                                  |  13 +-
 include/net/xsk_buff_pool.h                        |   9 +-
 include/target/target_core_base.h                  |   1 +
 include/trace/events/qrtr.h                        |  33 +-
 include/trace/events/timer.h                       |   3 +-
 include/uapi/linux/btrfs.h                         |   1 +
 include/uapi/linux/const.h                         |   2 +-
 include/xen/xen.h                                  |  11 +
 kernel/bpf/cgroup.c                                |   9 +-
 kernel/bpf/verifier.c                              |  26 +-
 kernel/events/core.c                               |   4 +-
 kernel/kheaders.c                                  |  10 +-
 kernel/power/process.c                             |   2 +-
 kernel/rcu/tree.c                                  |   1 +
 kernel/relay.c                                     |   3 +-
 kernel/sched/core.c                                |  25 +-
 kernel/sched/deadline.c                            |   5 +-
 kernel/sched/debug.c                               |  92 ++--
 kernel/sched/fair.c                                |  93 ++--
 kernel/sched/rt.c                                  |   8 +-
 kernel/sched/stats.h                               |  19 +
 kernel/sched/stop_task.c                           |   4 +-
 kernel/time/posix-cpu-timers.c                     |  81 ++-
 kernel/time/posix-timers.c                         |   4 +
 kernel/time/tick-common.c                          |  12 +-
 kernel/time/tick-sched.c                           |  16 +-
 kernel/time/timekeeping.c                          |   4 +-
 kernel/trace/ring_buffer.c                         |   4 +
 kernel/trace/trace.c                               |   2 +-
 kernel/workqueue.c                                 | 180 ++++---
 lib/debugobjects.c                                 | 146 ++---
 mm/backing-dev.c                                   |  12 +-
 net/8021q/vlan_dev.c                               |   2 +-
 net/core/skbuff.c                                  |   3 +
 net/ipv4/ip_output.c                               |  16 +-
 net/netfilter/nf_tables_api.c                      |   8 +-
 net/netfilter/nfnetlink.c                          |   2 -
 net/netlink/af_netlink.c                           |  75 +--
 net/packet/af_packet.c                             |  30 +-
 net/packet/diag.c                                  |   4 +-
 net/packet/internal.h                              |  26 +-
 net/sched/sch_fq.c                                 |   6 +-
 net/sunrpc/clnt.c                                  |   3 -
 net/sunrpc/sched.c                                 |   1 -
 net/xdp/xsk_queue.h                                |   1 +
 scripts/gdb/linux/clk.py                           |   2 +
 scripts/gdb/linux/constants.py.in                  |   2 +
 scripts/gdb/linux/genpd.py                         |   4 +-
 scripts/gdb/linux/timerlist.py                     |   4 +-
 scripts/gdb/linux/utils.py                         |   5 +-
 scripts/gdb/vmlinux-gdb.py                         |   5 +-
 security/integrity/ima/Kconfig                     |   2 +-
 security/selinux/Makefile                          |   4 +-
 sound/oss/dmasound/dmasound.h                      |   6 -
 sound/oss/dmasound/dmasound_core.c                 |  26 +-
 sound/soc/codecs/es8316.c                          |  14 +-
 sound/soc/fsl/fsl_mqs.c                            |  15 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |  12 +
 sound/soc/intel/boards/sof_sdw.c                   |  11 +
 sound/soc/soc-pcm.c                                |   4 +
 sound/usb/quirks-table.h                           |  58 ++
 tools/arch/x86/kcpuid/cpuid.csv                    |   4 +-
 tools/bpf/bpftool/json_writer.c                    |   3 -
 tools/bpf/bpftool/xlated_dumper.c                  |   7 +
 tools/objtool/check.c                              |  11 -
 tools/perf/util/auxtrace.c                         |   5 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   2 +
 tools/testing/selftests/bpf/network_helpers.c      |   2 +-
 .../selftests/bpf/prog_tests/cg_storage_multi.c    |   8 +-
 .../bpf/prog_tests/get_stackid_cannot_attach.c     |   1 +
 tools/testing/selftests/bpf/test_xsk.sh            |   1 +
 .../selftests/mount_setattr/mount_setattr_test.c   |   1 +
 tools/testing/selftests/resctrl/cache.c            |   4 +-
 tools/testing/selftests/resctrl/cat_test.c         |   4 +-
 tools/testing/selftests/resctrl/cmt_test.c         |   2 +-
 tools/testing/selftests/resctrl/fill_buf.c         |   2 +
 tools/testing/selftests/resctrl/mba_test.c         |   9 +-
 tools/testing/selftests/resctrl/mbm_test.c         |   2 +-
 tools/testing/selftests/resctrl/resctrl.h          |   7 +-
 tools/testing/selftests/resctrl/resctrl_tests.c    |  41 +-
 tools/testing/selftests/resctrl/resctrl_val.c      |  21 +-
 tools/testing/selftests/resctrl/resctrlfs.c        |   2 +-
 394 files changed, 3867 insertions(+), 2113 deletions(-)


