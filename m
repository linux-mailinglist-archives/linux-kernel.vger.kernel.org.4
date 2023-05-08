Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E928B6FA688
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjEHKUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjEHKUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:20:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0134BBD8;
        Mon,  8 May 2023 03:20:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1539624EF;
        Mon,  8 May 2023 10:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1FDC4339E;
        Mon,  8 May 2023 10:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541202;
        bh=uwLKk5DNVN8mfoK6UfksD4jA4v14Vu6x3MBQiDa/sII=;
        h=From:To:Cc:Subject:Date:From;
        b=CKGmeBzfBUWRh6nrYFGi7iFv3evUrmqCemnLDXo+gwoMcylrG57SPJOsEUyv+dKUF
         RsiCsIF6TFRqzbF6cOpdGrdm5xwGPKN3JJrJpXvpv/wq7ygFgDIJp1mEHDiwrsAaqh
         Mp0ViwwUiuotSyIzJrjDckGabOfzwJYUvSOAlgLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 6.2 000/663] 6.2.15-rc1 review
Date:   Mon,  8 May 2023 11:37:06 +0200
Message-Id: <20230508094428.384831245@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.15-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.2.15-rc1
X-KernelTest-Deadline: 2023-05-10T09:44+00:00
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

This is the start of the stable review cycle for the 6.2.15 release.
There are 663 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 10 May 2023 09:42:40 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.15-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.2.15-rc1

Thomas Gleixner <tglx@linutronix.de>
    debugobject: Ensure pool refill (again)

Jan Sokolowski <jan.sokolowski@intel.com>
    i40e: use int for i40e_status

Jan Sokolowski <jan.sokolowski@intel.com>
    i40e: Remove string printing for i40e_status

Jan Sokolowski <jan.sokolowski@intel.com>
    i40e: Remove unused i40e status codes

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix CYC timestamps after standalone CBR

Adrian Hunter <adrian.hunter@intel.com>
    perf auxtrace: Fix address filter entire kernel size

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    thunderbolt: Use correct type in tb_port_is_clx_enabled() prototype

Paulo Alcantara <pc@manguebit.com>
    cifs: protect access of TCP_Server_Info::{origin,leaf}_fullpath

Paulo Alcantara <pc@manguebit.com>
    cifs: fix potential race when tree connecting ipc

Paulo Alcantara <pc@manguebit.com>
    cifs: fix sharing of DFS connections

Paulo Alcantara <pc@manguebit.com>
    cifs: protect session status check in smb2_reconnect()

Paulo Alcantara <pc@manguebit.com>
    cifs: fix potential use-after-free bugs in TCP_Server_Info::hostname

Arnd Bergmann <arnd@arndb.de>
    blk-iocost: avoid 64-bit division in ioc_timer_fn

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

Cindy Lu <lulu@redhat.com>
    vhost_vdpa: fix unmap process in no-batch mode

Lorenzo Stoakes <lstoakes@gmail.com>
    mm/mempolicy: correctly update prev when policy is equal on mbind

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

Conor Dooley <conor.dooley@microchip.com>
    clk: microchip: fix potential UAF in auxdev release callback

Ping-Ke Shih <pkshih@realtek.com>
    wifi: rtw89: fix potential race condition between napi_init and napi_enable

Sascha Hauer <s.hauer@pengutronix.de>
    wifi: rtw88: rtw8821c: Fix rfe_option field width

Bitterblue Smith <rtl8821cerfe2@gmail.com>
    wifi: rtl8xxxu: RTL8192EU always needs full init

Huanhuan Wang <huanhuan.wang@corigine.com>
    nfp: fix incorrect pointer deference when offloading IPsec with bonding

Tanmay Shah <tanmay.shah@amd.com>
    mailbox: zynqmp: Fix typo in IPI documentation

Marco Elver <elver@google.com>
    kcsan: Avoid READ_ONCE() in read_instrumented_memory()

Tanmay Shah <tanmay.shah@amd.com>
    mailbox: zynqmp: Fix IPI isr handling

Tanmay Shah <tanmay.shah@amd.com>
    drivers: remoteproc: xilinx: Fix carveout names

Tudor Ambarus <tudor.ambarus@linaro.org>
    mtd: spi-nor: core: Update flash's current address mode when changing address mode

Michael Walle <michael@walle.cc>
    mtd: core: fix error path for nvmem provider

Michael Walle <michael@walle.cc>
    mtd: core: fix nvmem error reporting

Michael Walle <michael@walle.cc>
    mtd: core: provide unique name for nvmem device, take two

Mark Rutland <mark.rutland@arm.com>
    kasan: hw_tags: avoid invalid virt_to_page()

Jan Kara <jack@suse.cz>
    md/raid5: Improve performance for sequential IO

Li Nan <linan122@huawei.com>
    md/raid10: fix null-ptr-deref in raid10_sync_request

Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
    drbd: correctly submit flush bio on barrier

Jan Kara <jack@suse.cz>
    mm: do not reclaim private data from pinned page

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix infinite loop in nilfs_mdt_get_block()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: do not write dirty data after degenerating to read-only

Kai-Heng Feng <kai.heng.feng@canonical.com>
    ALSA: hda/realtek: Fix mute and micmute LEDs for an HP laptop

Caleb Harper <calebharp2005@gmail.com>
    ALSA: hda/realtek: support HP Pavilion Aero 13-be0xxx Mute LED

Mark Asselstine <asselsm@gmail.com>
    ALSA: hda/realtek: Add quirk for ASUS UM3402YAR using CS35L41

Vitaly Rodionov <vitalyr@opensource.cirrus.com>
    ALSA: hda/realtek: Add quirk for ThinkPad P1 Gen 6

Geraldo Nascimento <geraldogabriel@gmail.com>
    ALSA: usb-audio: Add quirk for Pioneer DDJ-800

Helge Deller <deller@gmx.de>
    parisc: Ensure page alignment in flush functions

Helge Deller <deller@gmx.de>
    parisc: Fix argument pointer in real64_call_asm()

Marc Dionne <marc.dionne@auristor.com>
    afs: Avoid endless loop if file is larger than expected

David Howells <dhowells@redhat.com>
    afs: Fix getattr to report server i_size on dirs, not local size

Marc Dionne <marc.dionne@auristor.com>
    afs: Fix updating of i_size with dv jump from server

Chen Yu <yu.c.chen@intel.com>
    PM: hibernate: Do not get block device exclusively in test_resume mode

Chen Yu <yu.c.chen@intel.com>
    PM: hibernate: Turn snapshot_test into global variable

Hans de Goede <hdegoede@redhat.com>
    ACPI: PM: Do not turn of unused power resources on the Toshiba Click Mini

Dan Carpenter <dan.carpenter@linaro.org>
    hte: tegra-194: Fix off by one in tegra_hte_map_to_line_id()

Arnd Bergmann <arnd@arndb.de>
    hte: tegra: fix 'struct of_device_id' build error

Charles Keepax <ckeepax@opensource.cirrus.com>
    mfd: arizona-spi: Add missing MODULE_DEVICE_TABLE

Colin Foster <colin.foster@in-advantage.com>
    mfd: ocelot-spi: Fix unsupported bulk read

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    mfd: tqmx86: Correct board names for TQMxE39x

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    mfd: tqmx86: Specify IO port register range more precisely

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    mfd: tqmx86: Do not access I2C_DETECT register through io_base

Kang Chen <void0red@hust.edu.cn>
    thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    pinctrl-bcm2835.c: fix race condition when setting gpio dir

Claudiu Beznea <claudiu.beznea@microchip.com>
    dmaengine: at_xdmac: do not enable all cyclic channels

Shunsuke Mie <mie@igel.co.jp>
    dmaengine: dw-edma: Fix to enable to issue dma request on DMA processing

Shunsuke Mie <mie@igel.co.jp>
    dmaengine: dw-edma: Fix to change for continuous transfer

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    dma: gpi: remove spurious unlock in gpi_ch_init

Siddharth Vadapalli <s-vadapalli@ti.com>
    phy: ti: j721e-wiz: Fix unreachable code in wiz_mode_select()

Gaosheng Cui <cuigaosheng1@huawei.com>
    phy: tegra: xusb: Add missing tegra_xusb_port_unregister for usb2_port and ulpi_port

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    soundwire: intel: don't save hw_params for use in prepare

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    pwm: mtk-disp: Configure double buffering before reading in .get_state()

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    pwm: mtk-disp: Disable shadow registers before setting backlight values

H. Nikolaus Schaller <hns@goldelico.com>
    leds: tca6507: Fix error handling of using fwnode_property_read_string

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: mv_xor_v2: Fix an error code.

Arınç ÜNAL <arinc.unal@arinc9.com>
    pinctrl: ralink: reintroduce ralink,rt2880-pinmux compatible string

Randy Dunlap <rdunlap@infradead.org>
    leds: TI_LMU_COMMON: select REGMAP instead of depending on it

Geert Uytterhoeven <geert+renesas@glider.be>
    pinctrl: renesas: r8a779g0: Fix ERROROUTC function names

Geert Uytterhoeven <geert+renesas@glider.be>
    pinctrl: renesas: r8a779g0: Fix Group 6/7 pin functions

Geert Uytterhoeven <geert+renesas@glider.be>
    pinctrl: renesas: r8a779g0: Fix Group 4/5 pin functions

Phong Hoang <phong.hoang.wz@renesas.com>
    pinctrl: renesas: r8a779f0: Fix tsn1_avtp_pps pin group

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

Avihai Horon <avihaih@nvidia.com>
    RDMA/mlx5: Check pcie_relaxed_ordering_enabled() in UMR

Zhu Yanjun <yanjun.zhu@linux.dev>
    RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Remove __rxe_do_task()

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Convert tasklet args to queue pairs

Michael Kelley <mikelley@microsoft.com>
    swiotlb: fix debugfs reporting of reserved memory pools

Doug Berger <opendmb@gmail.com>
    swiotlb: relocate PageHighMem test away from rmem_swiotlb_setup

Miaoqian Lin <linmq006@gmail.com>
    Input: raspberrypi-ts - fix refcount leak in rpi_ts_probe

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: dispcc-qcm2290: Remove inexistent DSI1PHY clk

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: dispcc-qcm2290: get rid of test clock

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: gcc-sm8350: fix PCIe PIPE clocks handling

Mohammad Rafi Shaik <quic_mohs@quicinc.com>
    clk: qcom: lpassaudiocc-sc7280: Add required gdsc power domain clks in lpass_cc_sc7280_desc

Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
    clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration

Heiko Carstens <hca@linux.ibm.com>
    s390/checksum: always use cksm instruction

Jerry Snitselaar <jsnitsel@redhat.com>
    iommu/amd: Set page size bitmap during V2 domain allocation

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4.1: Always send a RECLAIM_COMPLETE after establishing lease

Peng Fan <peng.fan@nxp.com>
    clk: imx: imx8ulp: Fix XBAR_DIVBUS and AD_SLOW clock parents

Peng Fan <peng.fan@nxp.com>
    clk: imx: fracn-gppll: disable hardware select control

Peng Fan <peng.fan@nxp.com>
    clk: imx: fracn-gppll: fix the rate table

Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
    IB/hfi1: Fix bugs with non-PAGE_SIZE-end multi-iovec user SDMA requests

Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
    IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order

Saravanan Vajravel <saravanan.vajravel@broadcom.com>
    RDMA/srpt: Add a check for valid 'mad_agent' pointer

Mark Zhang <markzhang@nvidia.com>
    RDMA/cm: Trace icm_send_rej event before the cm state is reset

Chris Morgan <macromorgan@hotmail.com>
    power: supply: rk817: Fix low SOC bugs

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: gcc-sm6115: Mark RCGs shared where applicable

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    RDMA/siw: Remove namespace check from siw_netdev_event()

Clément Léger <clement.leger@bootlin.com>
    clk: add missing of_node_put() in "assigned-clocks" property parsing

Sebastian Reichel <sre@kernel.org>
    power: supply: generic-adc-battery: fix unit scaling

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Remove tasklet call from rxe_cq.c

Yong Wu <yong.wu@mediatek.com>
    iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN

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

Cheng Xu <chengyou@linux.alibaba.com>
    RDMA/erdma: Use fixed hardware page size

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Replace exists by rxe in rxe.c

Dhruva Gole <d-gole@ti.com>
    rtc: k3: handle errors while enabling wake irq

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    rtc: meson-vrtc: Use ktime_get_real_ts64() to get the current time

Dan Carpenter <error27@gmail.com>
    RDMA/mlx4: Prevent shift wrapping in set_user_sq_size()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    rtc: omap: include header for omap_rtc_power_off_program prototype

Petr Mladek <pmladek@suse.com>
    workqueue: Fix hung time report of worker pools

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: gcc-qcm2290: Fix up gcc_sdcc2_apps_clk_src

Yang Yingliang <yangyingliang@huawei.com>
    clk: mediatek: clk-pllfh: fix missing of_node_put() in fhctl_parse_dt()

Natalia Petrova <n.petrova@fintech.ru>
    RDMA/rdmavt: Delete unnecessary NULL check

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: mt8135: Properly use CLK_IS_CRITICAL flag

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: mt7622: Properly use CLK_IS_CRITICAL flag

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: Consistently use GATE_MTK() macro

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    clk: mediatek: mt2712: Add error handling to clk_mt2712_apmixed_probe()

Daniil Dulov <d.dulov@aladdin.ru>
    RDMA/siw: Fix potential page_array out of range access

Kang Chen <void0red@gmail.com>
    IB/hifi1: add a null check of kzalloc_node in hfi1_ipoib_txreq_init

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: at91: clk-sam9x60-pll: fix return value check

Beau Belgrave <beaub@linux.microsoft.com>
    tracing/user_events: Ensure write index cannot be negative

Colin Ian King <colin.i.king@gmail.com>
    rv: Fix addition on an uninitialized variable 'run'

Schspa Shi <schspa@gmail.com>
    sched/rt: Fix bad task migration for rt tasks

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Fix ptdump when KASAN is enabled

Josh Poimboeuf <jpoimboe@kernel.org>
    Revert "objtool: Support addition to set CFA base"

Yang Jihong <yangjihong1@huawei.com>
    perf/core: Fix hardlockup failure caused by perf throttle

Libo Chen <libo.chen@oracle.com>
    sched/fair: Fix inaccurate tally of ttwu_move_affine

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

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/perf: Properly detect mpc7450 family

Liang He <windhl@126.com>
    macintosh/windfarm_smu_sat: Add missing of_node_put()

Kajol Jain <kjain@linux.ibm.com>
    selftests/powerpc/pmu: Fix sample field check in the mmcra_thresh_marked_sample_test

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    fbdev: mmp: Fix deferred clk handling in mmphw_probe()

Dhruva Gole <d-gole@ti.com>
    spi: bcm63xx: remove PM_SLEEP based conditional compilation

Albert Huang <huangjie.albert@bytedance.com>
    virtio_ring: don't update event idx on get_buf

Jishnu Prakash <quic_jprakash@quicinc.com>
    spmi: Add a check for remove callback when removing a SPMI driver

Philipp Hortmann <philipp.g.hortmann@gmail.com>
    staging: rtl8192e: Fix W_DISABLE# does not work after stop/start

Dhruva Gole <d-gole@ti.com>
    spi: cadence-quadspi: use macro DEFINE_SIMPLE_DEV_PM_OPS

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
    i2c: xiic: xiic_xfer(): Fix runtime PM leak on error path

Lars-Peter Clausen <lars@metafoo.de>
    i2c: cadence: cdns_i2c_master_xfer(): Fix runtime PM leak on error path

Dhruva Gole <d-gole@ti.com>
    spi: cadence-quadspi: fix suspend-resume implementations

Konrad Dybcio <konrad.dybcio@linaro.org>
    drm/panel: novatek-nt35950: Only unregister DSI1 if it exists

Alex Williamson <alex.williamson@redhat.com>
    PCI/PM: Extend D3hot delay for NVIDIA HDA controllers

Liliang Ye <yll@hust.edu.cn>
    ASoC: fsl_mqs: move of_node_put() to the correct location

Konrad Dybcio <konrad.dybcio@linaro.org>
    drm/panel: novatek-nt35950: Improve error handling

Suzuki K Poulose <suzuki.poulose@arm.com>
    coresight: etm_pmu: Set the module field

Pierre Gondois <pierre.gondois@arm.com>
    cacheinfo: Check sib_leaf in cache_leaves_are_shared()

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    HID: amd_sfh: Handle "no sensors" enabled for SFH1.1

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    HID: amd_sfh: Increase sensor command timeout for SFH1.1

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    HID: amd_sfh: Correct the stop all command

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    HID: amd_sfh: Add support for shutdown operation

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    HID: amd_sfh: Fix illuminance value

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    HID: amd_sfh: Correct the sensor enable and disable command

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    HID: amd_sfh: Correct the structure fields

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

Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
    spi: mchp-pci1xxxx: Fix SPI transactions not working after suspend and resume

Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
    spi: mchp-pci1xxxx: Fix length of SPI transactions not set properly in driver

Johan Hovold <johan+linaro@kernel.org>
    interconnect: qcom: rpm: drop bogus pm domain attach

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: qup: Don't skip cleanup in remove's error path

Randy Dunlap <rdunlap@infradead.org>
    linux/vt_buffer.h: allow either builtin or modular for macros

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: es8316: Handle optional IRQ assignment

H. Nikolaus Schaller <hns@goldelico.com>
    PCI: imx6: Install the fault handler only on compatible match

Daniel Baluta <daniel.baluta@nxp.com>
    ASoC: soc-compress: Inherit atomicity from DAI link for Compress FE

Zheng Wang <zyytlz.wz@163.com>
    usb: gadget: udc: renesas_usb3: Fix use after free bug in renesas_usb3_remove due to race condition

Fabio M. De Francesco <fmdefrancesco@gmail.com>
    module/decompress: Never use kunmap() for local un-mappings

Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
    spi: f_ospi: Add missing spi_mem_default_supports_op() helper

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    interconnect: qcom: osm-l3: drop unuserd header inclusion

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    interconnect: qcom: drop obsolete OSM_L3/EPSS defines

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: imx: Don't skip cleanup in remove's error path

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: atmel-quadspi: Free resources even if runtime resume failed in .remove()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: atmel-quadspi: Don't leak clk enable count in pm resume

Doug Berger <opendmb@gmail.com>
    serial: 8250_bcm7271: Fix arbitration handling

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    iio: light: max44009: add missing OF device matching

Jason Gunthorpe <jgg@ziepe.ca>
    iommufd/selftest: Catch overflow of uptr and length

Marco Pagani <marpagan@redhat.com>
    fpga: bridge: fix kernel-doc parameter description

Marek Vasut <marex@denx.de>
    serial: stm32: Re-assert RTS/DE GPIO in RS485 mode only if more data are transmitted

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

Lucas Tanure <lucas.tanure@collabora.com>
    ASoC: cs35l41: Only disable internal boost

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

Marc Dionne <marc.dionne@auristor.com>
    rxrpc: Fix error when reading rxrpc tokens

Ziyang Xuan <william.xuanziyang@huawei.com>
    ipv4: Fix potential uninit variable access bug in __ip_make_skb()

Davide Caratti <dcaratti@redhat.com>
    net/sched: sch_fq: fix integer overflow of "credit"

Dan Carpenter <dan.carpenter@linaro.org>
    net: dpaa: Fix uninitialized variable in dpaa_stop()

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: don't write table validation state without mutex

Stanislav Fomichev <sdf@google.com>
    bpf: Don't EFAULT for getsockopt with optval=NULL

Alexei Starovoitov <ast@kernel.org>
    bpf: Fix race between btf_put and btf_idr walk.

Yan Wang <rk.code@outlook.com>
    net: stmmac:fix system hang when setting up tag_8021q VLAN for DSA ports

Vlad Buslov <vladbu@nvidia.com>
    Revert "net/mlx5e: Don't use termination table when redundant"

Aya Levin <ayal@nvidia.com>
    net/mlx5e: Nullify table pointer when failing to create

Moshe Shemesh <moshe@nvidia.com>
    net/mlx5: Use recovery timeout on sync reset flow

Moshe Shemesh <moshe@nvidia.com>
    Revert "net/mlx5: Remove "recovery" arg from mlx5_load_one() function"

Jiri Pirko <jiri@nvidia.com>
    net/mlx5: Suspend auxiliary devices only in case of PCI device suspend

Jiri Pirko <jiri@nvidia.com>
    net/mlx5: Remove "recovery" arg from mlx5_load_one() function

Roi Dayan <roid@nvidia.com>
    net/mlx5e: Fix error flow in representor failing to add vport rx rule

Chris Mi <cmi@nvidia.com>
    net/mlx5: E-switch, Don't destroy indirect table in split rule

Chris Mi <cmi@nvidia.com>
    net/mlx5: E-switch, Create per vport table based on devlink encap mode

Vlad Buslov <vladbu@nvidia.com>
    net/mlx5e: Don't clone flow post action attributes second time

Joe Damato <jdamato@fastly.com>
    ixgbe: Enable setting RSS table to default values

Joe Damato <jdamato@fastly.com>
    ixgbe: Allow flow hash to be set via ethtool

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: fw: fix memory leak in debugfs

Tzung-Bi Shih <tzungbi@kernel.org>
    netfilter: conntrack: fix wrong ct->timeout value

Ryder Lee <ryder.lee@mediatek.com>
    wifi: mt76: mt7996: fill txd by host driver

Lorenzo Bianconi <lorenzo@kernel.org>
    wifi: mt76: mt7996: rely on mt76_connac_txp_common structure

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: conntrack: restore IPS_CONFIRMED out of nf_conntrack_hash_check_insert()

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: check firmware response size

Ryder Lee <ryder.lee@mediatek.com>
    wifi: mt76: connac: fix txd multicast rate setting

Quan Zhou <quan.zhou@mediatek.com>
    wifi: mt76: mt7921e: stop chip reset worker in unregister hook

Quan Zhou <quan.zhou@mediatek.com>
    wifi: mt76: mt7921e: improve reliability of dma reset

Jiefeng Li <jiefeng_li@hust.edu.cn>
    wifi: mt76: mt7921: fix missing unwind goto in `mt7921u_probe`

Sean Wang <sean.wang@mediatek.com>
    mt76: mt7921: fix kernel panic by accessing unallocated eeprom.data

Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
    wifi: mt76: fix 6GHz high channel not be scanned

Quan Zhou <quan.zhou@mediatek.com>
    wifi: mt76: mt7921e: fix probe timeout after reboot

Deren Wu <deren.wu@mediatek.com>
    wifi: mt76: add flexible polling wait-interval support

StanleyYP Wang <StanleyYP.Wang@mediatek.com>
    wifi: mt76: mt7996: fix eeprom tx path bitfields

Peter Chiu <chui-hao.chiu@mediatek.com>
    wifi: mt76: mt7996: fix pointer calculation in ie countdown event

Shayne Chen <shayne.chen@mediatek.com>
    wifi: mt76: mt7996: let non-bufferable MMPDUs use correct hw queue

Kang Chen <void0red@gmail.com>
    wifi: mt76: handle failure of vzalloc in mt7615_coredump_work

Howard Hsu <howard-yh.hsu@mediatek.com>
    wifi: mt76: mt7915: rework init flow in mt7915_thermal_init()

Howard Hsu <howard-yh.hsu@mediatek.com>
    wifi: mt76: mt7915: add error message in mt7915_thermal_set_cur_throttle_state()

Lorenz Brun <lorenz@brun.one>
    wifi: mt76: mt7915: expose device tree match table

Ryder Lee <ryder.lee@mediatek.com>
    wifi: mt76: mt7996: fix radiotap bitfield

Dan Carpenter <error27@gmail.com>
    wifi: mt76: mt7915: unlock on error in mt7915_thermal_temp_store()

Deren Wu <deren.wu@mediatek.com>
    wifi: mt76: mt7921: fix PCI DMA hang after reboot

Deren Wu <deren.wu@mediatek.com>
    wifi: mt76: mt7921: fix wrong command to set STA channel

Deren Wu <deren.wu@mediatek.com>
    wifi: mt76: remove redundent MCU_UNI_CMD_* definitions

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: make the loop for card preparation effective

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/rsrc: use nospec'ed indexes

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

Ayala Beker <ayala.beker@intel.com>
    wifi: iwlwifi: mvm: don't drop unencrypted MCAST frames

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

Chao Yu <chao@kernel.org>
    f2fs: fix to check return value of inc_valid_block_count()

Chao Yu <chao@kernel.org>
    f2fs: fix to check return value of f2fs_do_truncate_blocks()

Daniel Borkmann <daniel@iogearbox.net>
    bpf, sockmap: Revert buggy deadlock fix in the sockhash and sockmap

Avraham Stern <avraham.stern@intel.com>
    wifi: iwlwifi: mvm: don't set CHECKSUM_COMPLETE for unsupported protocols

Avraham Stern <avraham.stern@intel.com>
    wifi: iwlwifi: trans: don't trigger d3 interrupt twice

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: fix A-MSDU checks

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: debug: fix crash in __iwl_err()

Christoph Hellwig <hch@lst.de>
    blk-mq: don't plug for head insertions in blk_execute_rq_nowait

Song Liu <song@kernel.org>
    selftests/bpf: Fix leaked bpf_link in get_stackid_cannot_attach

Song Liu <song@kernel.org>
    selftests/bpf: Use read_perf_max_sample_freq() in perf_event_stackmap

Ming Lei <ming.lei@redhat.com>
    nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage"

Keith Busch <kbusch@kernel.org>
    nvme: fix async event trace event

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

Xin Liu <liuxin350@huawei.com>
    bpf, sockmap: fix deadlocks in the sockhash and sockmap

P Praneesh <quic_ppranees@quicinc.com>
    wifi: ath11k: fix writing to unintended memory region

Sebastian Reichel <sebastian.reichel@collabora.com>
    net: ethernet: stmmac: dwmac-rk: fix optional phy regulator handling

Sebastian Reichel <sebastian.reichel@collabora.com>
    net: ethernet: stmmac: dwmac-rk: rework optional clock handling

Shuchang Li <lishuchang@hust.edu.cn>
    scsi: lpfc: Fix ioremap issues in lpfc_sli4_pci_mem_setup()

Feng Zhou <zhoufeng.zf@bytedance.com>
    bpf/btf: Fix is_int_ptr()

Gregory Greenman <gregory.greenman@intel.com>
    wifi: iwlwifi: fix duplicate entry in iwl_dev_info_table

Chao Yu <chao@kernel.org>
    f2fs: fix to avoid use-after-free for cached IPU bio

Kal Conley <kal.conley@dectris.com>
    xsk: Fix unaligned descriptor validation

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: drbg - Only fail when jent is unavailable in FIPS mode

Quentin Monnet <quentin@isovalent.com>
    bpftool: Fix bug for long instructions in program CFG dumps

YiFei Zhu <zhuyifei@google.com>
    selftests/bpf: Wait for receive in cg_storage_multi test

Kal Conley <kal.conley@dectris.com>
    selftests: xsk: Deflakify STATS_RX_DROPPED test

Kal Conley <kal.conley@dectris.com>
    selftests: xsk: Disable IPv6 on VETH1

Kal Conley <kal.conley@dectris.com>
    selftests: xsk: Use correct UMEM size in testapp_invalid_desc

Simon Horman <horms@kernel.org>
    net: qrtr: correct types of trace event parameters

Qilin Tan <qilin.tan@mediatek.com>
    f2fs: fix iostat lock protection

Dave Marchevsky <davemarchevsky@fb.com>
    bpf: Fix struct_meta lookup for bpf_obj_free_fields kfunc call

Andrii Nakryiko <andrii@kernel.org>
    bpf: factor out fetching basic kfunc metadata

Dave Marchevsky <davemarchevsky@fb.com>
    bpf: Add callback validation to kfunc verifier logic

Dave Marchevsky <davemarchevsky@fb.com>
    bpf: Add support for bpf_rb_root and bpf_rb_node in kfunc args

Dave Marchevsky <davemarchevsky@fb.com>
    bpf: Add bpf_rbtree_{add,remove,first} kfuncs

Dave Marchevsky <davemarchevsky@fb.com>
    bpf: Add basic bpf_rb_{root,node} support

Dave Marchevsky <davemarchevsky@fb.com>
    bpf: Migrate release_on_unlock logic to non-owning ref semantics

David Vernet <void@manifault.com>
    bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs

Dave Marchevsky <davemarchevsky@fb.com>
    bpf: rename list_head -> graph_root in field info types

Armin Wolf <W_Armin@gmx.de>
    wifi: rt2x00: Fix memory leak when handling surveys

Xingui Yang <yangxingui@huawei.com>
    scsi: hisi_sas: Handle NCQ error when IPTT is valid

Wei Chen <harperchen1110@gmail.com>
    wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_reg()

Wei Chen <harperchen1110@gmail.com>
    wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_rfreg()

Suman Anna <s-anna@ti.com>
    crypto: sa2ul - Select CRYPTO_DES

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    crypto: caam - Clear some memory in instantiate_rng

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix scheduling while atomic in decompression path

Yangtao Li <frank.li@vivo.com>
    f2fs: compress: fix to call f2fs_wait_on_page_writeback() in f2fs_write_raw_pages()

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: apply zone capacity to all zone type

Yonggil Song <yonggil.song@samsung.com>
    f2fs: fix uninitialized skipped_gc_rwsem

Yangtao Li <frank.li@vivo.com>
    f2fs: handle dqget error in f2fs_transfer_project_quota()

Sean Anderson <seanga2@gmail.com>
    net: sunhme: Fix uninitialized return code

Danila Chernetsov <listdansp@mail.ru>
    scsi: megaraid: Fix mega_cmd_done() CMDID_INT_CMDS

Mike Christie <michael.christie@oracle.com>
    scsi: target: iscsit: Fix TAS handling during conn cleanup

Mike Christie <michael.christie@oracle.com>
    scsi: target: Fix multiple LUN_RESET handling

Mike Christie <michael.christie@oracle.com>
    scsi: target: iscsit: Stop/wait on cmds during conn close

Mike Christie <michael.christie@oracle.com>
    scsi: target: iscsit: isert: Alloc per conn cmd counter

Mike Christie <michael.christie@oracle.com>
    scsi: target: Pass in cmd counter to use during cmd setup

Mike Christie <michael.christie@oracle.com>
    scsi: target: Move cmd counter allocation

Mike Christie <michael.christie@oracle.com>
    scsi: target: Move sess cmd counter to new struct

Daniel Borkmann <daniel@iogearbox.net>
    bpf: Fix __reg_bound_offset 64->32 var_off subreg propagation

JP Kobryn <inwardvessel@gmail.com>
    bpf: return long from bpf_map_ops funcs

Madhu Koriginja <madhu.koriginja@nxp.com>
    netfilter: keep conntrack reference until IPsecv6 policy checks are done

Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
    net: dsa: qca8k: remove assignment of an_enabled in pcs_get_state()

Alexei Starovoitov <ast@kernel.org>
    libbpf: Fix ld_imm64 copy logic for ksym in light skeleton.

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

Aditya Kumar Singh <quic_adisi@quicinc.com>
    wifi: ath11k: fix deinitialization of firmware resources

Alexander Mikhalitsyn <alexander@mihalicyn.com>
    scm: fix MSG_CTRUNC setting condition for SO_PASSSEC

Shashank Gupta <shashank.gupta@intel.com>
    crypto: qat - fix concurrency issue when device state changes

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

Bitterblue Smith <rtl8821cerfe2@gmail.com>
    wifi: rtl8xxxu: Remove always true condition in rtl8xxxu_print_chipinfo

Christian Marangi <ansuelsmth@gmail.com>
    wifi: ath11k: fix SAC bug on peer addition with sta band migration

Dan Carpenter <error27@gmail.com>
    wifi: ath5k: fix an off by one check in ath5k_eeprom_read_freq_list()

Douglas Anderson <dianders@chromium.org>
    wifi: ath5k: Use platform_get_irq() to get the interrupt

Douglas Anderson <dianders@chromium.org>
    wifi: ath11k: Use platform_get_irq() to get the interrupt

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: hif_usb: fix memory leak of remain_skbs

Alexey V. Vissarionov <gremlin@altlinux.org>
    wifi: ath6kl: minor fix for allocation size

Liang He <windhl@126.com>
    platform/chrome: cros_typec_switch: Add missing fwnode_handle_put()

Tomáš Pecka <tomas.pecka@cesnet.cz>
    hwmon: (pmbus/fsp-3y) Fix functionality bitmask in FSP-3Y YM-2151E

Bjorn Andersson <quic_bjorande@quicinc.com>
    rpmsg: glink: Propagate TX failures in intentless mode as well

Sanjay Chandrashekara <sanjayc@nvidia.com>
    cpufreq: use correct unit when verify cur freq

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: bus: Ensure that notify handlers are not running after removal

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    tick/common: Align tick period with the HZ tick.

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Make intel_get_crtc_new_encoder() less oopsy

Thomas Gleixner <tglx@linutronix.de>
    debugobject: Prevent init race with static objects

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: add remove function for decoder platform driver

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: fix decoder disable pm crash

Robin Murphy <robin.murphy@arm.com>
    perf/arm-cmn: Fix port detection for CMN-700

Sumit Garg <sumit.garg@linaro.org>
    arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

Saurabh Sengar <ssengar@linux.microsoft.com>
    x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()

YAN SHI <m202071378@hust.edu.cn>
    regulator: stm32-pwr: fix of_iomap leak

Javier Martinez Canillas <javierm@redhat.com>
    media: venus: dec: Fix capture formats enumeration order

Michał Krawczyk <mk@semihalf.com>
    media: venus: dec: Fix handling of the start cmd

Florian Fainelli <f.fainelli@gmail.com>
    media: rc: gpio-ir-recv: Fix support for wake-up

Igor Artemiev <Igor.A.Artemiev@mcst.ru>
    drm/amd/display: Fix potential null dereference

Wei Chen <harperchen1110@gmail.com>
    media: hi846: Fix memleak in hi846_init_controls()

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: v4l: async: Return async sub-devices to subnotifier list

Miaoqian Lin <linmq006@gmail.com>
    media: rcar_fdp1: Fix refcount leak in probe and remove function

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    media: rcar_fdp1: Convert to platform remove callback returning void

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    platform: Provide a remove callback that returns no value

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    media: vsp1: Replace vb2_is_streaming() with vb2_start_streaming_called()

Moudy Ho <moudy.ho@mediatek.com>
    media: platform: mtk-mdp3: fix potential frame size overflow in mdp_try_fmt_mplane()

Zheng Wang <zyytlz.wz@163.com>
    media: saa7134: fix use after free bug in saa7134_finidev due to race condition

Zheng Wang <zyytlz.wz@163.com>
    media: dm1105: Fix use after free bug in dm1105_remove due to race condition

Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
    platform/x86/amd: pmc: Move out of BIOS SMN pair for STB init

Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
    platform/x86/amd: pmc: Utilize SMN index 0 for driver probe

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86/amd: pmc: Move idlemask check into `amd_pmc_idlemask_read`

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86/amd: pmc: Don't dump data after resume from s0i3 on picasso

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86/amd: pmc: Hide SMU version and program attributes for Picasso

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86/amd: pmc: Don't try to read SMU version on Picasso

Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
    platform/x86/amd/pmf: Move out of BIOS SMN pair for driver probe

Zheng Wang <zyytlz.wz@163.com>
    media: rkvdec: fix use after free bug in rkvdec_remove

Zheng Wang <zyytlz.wz@163.com>
    media: cedrus: fix use after free bug in cedrus_remove due to race condition

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: change lat thread decode error condition

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: making sure queue_work successfully

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: remove unused lat_buf

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: add core decode done event

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: move lat_buf to the top of core list

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: using each instance lat_buf count replace core ready list

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: add params to record lat and core lat_buf count

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: Force capture queue format to MM21

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: Make MM21 the default capture format

Pin-yen Lin <treapking@chromium.org>
    media: mediatek: vcodec: Use 4K frame size when supported by stateful decoder

kyrie wu <kyrie.wu@mediatek.com>
    media: mtk-jpeg: Fixes jpeg enc&dec worker sw flow

kyrie wu <kyrie.wu@mediatek.com>
    media: mtk-jpeg: Fixes jpeghw multi-core judgement

Douglas Anderson <dianders@chromium.org>
    arm64: dts: sdm845: Rename qspi data12 as data23

Douglas Anderson <dianders@chromium.org>
    arm64: dts: sc7280: Rename qspi data12 as data23

Douglas Anderson <dianders@chromium.org>
    arm64: dts: sc7180: Rename qspi data12 as data23

Petr Vorel <pvorel@suse.cz>
    arm64: dts: qcom: msm8994-angler: removed clash with smem_region

Petr Vorel <pvorel@suse.cz>
    arm64: dts: qcom: msm8994-angler: Fix cont_splash_mem mapping

Tushar Nimkar <quic_tnimkar@quicinc.com>
    soc: qcom: rpmh-rsc: Support RSC v3 minor versions

Uros Bizjak <ubizjak@gmail.com>
    x86/apic: Fix atomic update of offset in reserve_eilvt_offset()

Douglas Anderson <dianders@chromium.org>
    regulator: core: Avoid lockdep reports when resolving supplies

Douglas Anderson <dianders@chromium.org>
    regulator: core: Consistently set mutex_owner when using ww_mutex_lock_slow()

Thomas Hellström <thomas.hellstrom@linux.intel.com>
    drm/ttm/pool: Fix ttm_pool_alloc error path

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: apq8096-db820c: drop unit address from PMI8994 regulator

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8994-msft-lumia-octagon: drop unit address from PMI8994 regulator

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8994-kitakami: drop unit address from PMI8994 regulator

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8998-oneplus-cheeseburger: revert "fix backlight pin function"

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sc7180-trogdor-pazquel: correct trackpad supply

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sc7180-trogdor-lazor: correct trackpad supply

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sc7280-herobrine-villager: correct trackpad supply

Yang Yingliang <yangyingliang@huawei.com>
    gpu: host1x: Fix memory leak of device names

Yang Yingliang <yangyingliang@huawei.com>
    gpu: host1x: Fix potential double free if IOMMU is disabled

Li Yang <lidaxian@hust.edu.cn>
    soc: renesas: renesas-soc: Release 'chipid' from ioremap()

Zhaoyang Li <lizhaoyang04@hust.edu.cn>
    soc: bcm: brcmstb: biuctrl: fix of_iomap leak

Conor Dooley <conor.dooley@microchip.com>
    mailbox: mpfs: switch to txdone_poll

Xinlei Lee <xinlei.lee@mediatek.com>
    drm/mediatek: dp: Change the aux retries times when receiving AUX_DEFER

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    drm/lima/lima_drv: Add missing unwind goto in lima_pdev_probe()

Jean-Philippe Brucker <jean-philippe@linaro.org>
    ACPI: VIOT: Initialize the correct IOMMU fwspec

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: mt8192-asurada: Fix voltage constraint for Vgpu

Bjorn Andersson <quic_bjorande@quicinc.com>
    cpufreq: qcom-cpufreq-hw: Revert adding cpufreq qos

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    cpufreq: mediatek: Raise proc and sram max voltage for MT7622/7623

Jia-Wei Chang <jia-wei.chang@mediatek.com>
    cpufreq: mediatek: raise proc/sram max voltage for MT8516

Jia-Wei Chang <jia-wei.chang@mediatek.com>
    cpufreq: mediatek: fix KP caused by handler usage after regulator_put/clk_put

Jia-Wei Chang <jia-wei.chang@mediatek.com>
    cpufreq: mediatek: fix passing zero to 'PTR_ERR'

Janne Grunau <j@jannau.net>
    arm64: dts: apple: t8103: Disable unused PCIe ports

Alexandre Torgue <alexandre.torgue@foss.st.com>
    ARM: dts: stm32: fix spi1 pin assignment on stm32mp15

Jiucheng Xu <jiucheng.xu@amlogic.com>
    perf/amlogic: Fix config1/config2 parsing issue

Ilkka Koskinen <ilkka@os.amperecomputing.com>
    perf/arm-cmn: Move overlapping wp_combine field

Cristian Marussi <cristian.marussi@arm.com>
    firmware: arm_scmi: Fix xfers allocation on Rx channel

H. Nikolaus Schaller <hns@goldelico.com>
    ARM: dts: gta04: fix excess dma channel usage

Dan Carpenter <error27@gmail.com>
    drm: rcar-du: Fix a NULL vs IS_ERR() bug

Neil Armstrong <neil.armstrong@linaro.org>
    arm64: dts: qcom: sm8450: fix pcie1 gpios properties name

Georgii Kruglov <georgy.kruglov@yandex.ru>
    mmc: sdhci-of-esdhc: fix quirk to ignore command inhibit for data

Roger Pau Monne <roger.pau@citrix.com>
    ACPI: processor: Fix evaluating _PDC method when running as Xen dom0

Lee Jones <lee@kernel.org>
    drm/amd/display/dc/dce60/Makefile: Fix previous attempt to silence known override-init warnings

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8350-microsoft-surface: fix USB dual-role mode property

Dionna Glaze <dionnaglaze@google.com>
    virt/coco/sev-guest: Double-buffer messages

Adam Skladowski <a39.skl@gmail.com>
    drm: msm: adreno: Disable preemption on Adreno 510

Johan Hovold <johan+linaro@kernel.org>
    drm/msm/adreno: drop bogus pm_runtime_set_active()

Vignesh Raghavendra <vigneshr@ti.com>
    arm64: dts: ti: k3-am62a7: Correct L2 cache size to 512KB

Vignesh Raghavendra <vigneshr@ti.com>
    arm64: dts: ti: k3-am625: Correct L2 cache size to 512KB

Bagas Sanjaya <bagasdotme@gmail.com>
    accel: Link to compute accelerator subsystem intro

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: max9286: Free control handler

Adam Ford <aford173@gmail.com>
    drm/bridge: adv7533: Fix adv7533_mode_valid for adv7533 and adv7535

Mukesh Ojha <quic_mojha@quicinc.com>
    firmware: qcom_scm: Clear download bit during reboot

Dan Carpenter <error27@gmail.com>
    media: av7110: prevent underflow in write_ts_to_decoder()

Ming Qian <ming.qian@nxp.com>
    media: amphion: decoder implement display delay enable

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    media: platform: mtk-mdp3: Add missing check and free for ida_alloc

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    media: bdisp: Add missing check for create_workqueue

Muralidhara M K <muralimk@amd.com>
    x86/MCE/AMD: Use an u64 for bank_map

Manivannan Sadhasivam <mani@kernel.org>
    ARM: dts: qcom: sdx55: Fix the unit address of PCIe EP node

Adam Skladowski <a39.skl@gmail.com>
    arm64: dts: qcom: msm8976: Add and provide xo clk to rpmcc

Manivannan Sadhasivam <mani@kernel.org>
    ARM: dts: qcom: ipq8064: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    ARM: dts: qcom: ipq4019: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: sm8450: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: sm8150: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: sc8280xp: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: sm8250: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: msm8996: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: ipq6018: Fix the PCI I/O port range

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: ipq6018: Add/remove some newlines

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: ipq8074: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: sc7280: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: msm8998: Fix the PCI I/O port range

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: sdm845: Fix the PCI I/O port range

Vincent Guittot <vincent.guittot@linaro.org>
    arm64: dts: qcom: sdm845: correct dynamic power coefficients

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sc7280: fix EUD port properties

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: msm8998: Fix stm-stimulus-base reg name

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: broadcom: bcmbca: bcm4908: fix procmon nodename

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: broadcom: bcmbca: bcm4908: fix LED nodenames

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: broadcom: bcmbca: bcm4908: fix NAND interrupt name

Bhavya Kapoor <b-kapoor@ti.com>
    arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel property

Devarsh Thakkar <devarsht@ti.com>
    arm64: dts: ti: k3-am62a7-sk: Fix DDR size to full 4GB

Nitin Yadav <n-yadav@ti.com>
    arm64: dts: ti: k3-am62-main: Fix GPIO numbers in DT

Douglas Anderson <dianders@chromium.org>
    regulator: core: Shorten off-on-delay-us for always-on/boot-on by time since booted

Konrad Dybcio <konrad.dybcio@linaro.org>
    ARM: dts: qcom-apq8064: Fix opp table child name

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    EDAC/skx: Fix overflows on the DRAM row address mapping arrays

Vinod Polimera <quic_vpolimer@quicinc.com>
    drm/msm/disp/dpu: check for crtc enable rather than crtc active to release shared resources

Chen-Yu Tsai <wenst@chromium.org>
    drm/mediatek: dp: Only trigger DRM HPD events if bridge is attached

Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
    arm64: dts: renesas: r9a07g043: Update IRQ numbers for SSI channels

Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
    arm64: dts: renesas: r9a07g054: Update IRQ numbers for SSI channels

Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
    arm64: dts: renesas: r9a07g044: Update IRQ numbers for SSI channels

Geert Uytterhoeven <geert+renesas@glider.be>
    arm64: dts: renesas: r8a774c0: Remove bogus voltages from OPP table

Geert Uytterhoeven <geert+renesas@glider.be>
    arm64: dts: renesas: r8a77990: Remove bogus voltages from OPP table

Miaoqian Lin <linmq006@gmail.com>
    soc: ti: pm33xx: Fix refcount leak in am33xx_pm_probe

Nicolas Frayer <nfrayer@baylibre.com>
    soc: ti: k3-ringacc: Add try_module_get() to k3_dmaring_request_dual_ring()

Terry Bowman <terry.bowman@amd.com>
    tools/x86/kcpuid: Fix avx512bw and avx512lvl fields in Fn00000007

Orlando Chamberlain <orlandoch.dev@gmail.com>
    drm/amdgpu: register a vga_switcheroo client for MacBooks with apple-gmux

Dom Cobley <popcornmix@gmail.com>
    drm/probe-helper: Cancel previous job before starting new one

Maíra Canal <mcanal@igalia.com>
    drm/vgem: add missing mutex_destroy

Matt Roper <matthew.d.roper@intel.com>
    drm/i915/dg2: Drop one PCI ID

Rob Clark <robdclark@chromium.org>
    drm/rockchip: Drop unbalanced obj unref

Jingbo Xu <jefflexu@linux.alibaba.com>
    erofs: fix potential overflow calculating xattr_isize

Jingbo Xu <jefflexu@linux.alibaba.com>
    erofs: initialize packed inode after root inode is assigned

Gao Xiang <xiang@kernel.org>
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

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Return NULL if malloc_and_init_memory() did not alloc mem

Zqiang <qiang1.zhang@intel.com>
    rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check

Rae Moar <rmoar@google.com>
    kunit: fix bug in the order of lines in debugfs logs

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ASoC: dt-bindings: qcom,lpass-rx-macro: correct minItems for clocks

Jeffrey Hugo <quic_jhugo@quicinc.com>
    bus: mhi: host: Range check CHDBOFF and ERDBOFF

Jeffrey Hugo <quic_jhugo@quicinc.com>
    bus: mhi: host: Use mhi_tryset_pm_state() for setting fw error state

Jeffrey Hugo <quic_jhugo@quicinc.com>
    bus: mhi: host: Remove duplicate ee check for syserr

Dan Williams <dan.j.williams@intel.com>
    cxl/hdm: Fail upon detecting 0-sized decoders

Dave Chinner <dchinner@redhat.com>
    xfs: don't consider future format versions valid

Alexander Aring <aahringo@redhat.com>
    fs: dlm: fix DLM_IFL_CB_PENDING gets overwritten

Xiubo Li <xiubli@redhat.com>
    ceph: fix potential use-after-free bug when trimming caps

Mårten Lindahl <marten.lindahl@axis.com>
    ubifs: Fix memory leak in do_rename

Mårten Lindahl <marten.lindahl@axis.com>
    ubifs: Free memory for tmpfile name

Wang YanQing <udknight@gmail.com>
    ubi: Fix return value overwrite issue in try_write_vid_and_data()

Zhihao Cheng <chengzhihao1@huawei.com>
    ubifs: Fix memleak when insert_old_idx() failed

Zhihao Cheng <chengzhihao1@huawei.com>
    Revert "ubifs: dirty_cow_znode: Fix memleak in error handling path"

Andrew Jones <ajones@ventanamicro.com>
    RISC-V: Align SBI probe implementation with spec

Kishon Vijay Abraham I <kvijayab@amd.com>
    iommu/amd: Fix "Guest Virtual APIC Table Root Pointer" configuration in IRTE

Tim Huang <tim.huang@amd.com>
    drm/amd/pm: re-enable the gfx imu when smu resume

Ondrej Mosnacek <omosnace@redhat.com>
    tracing: Fix permissions for the buffer_percent file

Song Shuai <suagrfillet@gmail.com>
    riscv: mm: remove redundant parameter of create_fdt_early_page_table

Reid Tonking <reidt@ti.com>
    i2c: omap: Fix standard mode false ACK readings

Hans de Goede <hdegoede@redhat.com>
    ACPI: video: Remove acpi_backlight=video quirk for Lenovo ThinkPad W530

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix deadlock in ksmbd_find_crypto_ctx()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: not allow guest user on multichannel

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix memleak in session setup

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix NULL pointer dereference in smb2_get_info_filesystem()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: call rcu_barrier() in ksmbd_server_exit()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix racy issue under cocurrent smb2 tree disconnect

David Matlack <dmatlack@google.com>
    KVM: RISC-V: Retry fault if vma_lookup() results become invalid

Alex Hung <alex.hung@amd.com>
    drm/amd/display: fix a divided-by-zero error

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: fix PSR-SU/DSC interoperability support

Daniel Miess <Daniel.Miess@amd.com>
    drm/amd/display: limit timing for single dimm memory

Nasir Osman <nasir.osman@amd.com>
    drm/amd/display: Remove stutter only configurations

Zhang Zhengming <zhang.zhengming@h3c.com>
    relayfs: fix out-of-bounds access in relay_file_read

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: vgic: Don't acquire its_lock before config_lock

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: Use config_lock to protect vgic state

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: Use config_lock to protect data ordered against KVM_RUN

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: Avoid lock inversion when setting the VM register width

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: Avoid vcpu->mutex v. kvm->lock inversion in CPU_ON

Sean Christopherson <seanjc@google.com>
    KVM: nVMX: Emulate NOPs in L2, and PAUSE if it's not intercepted

Sean Christopherson <seanjc@google.com>
    KVM: x86/pmu: Disallow legacy LBRs if architectural LBRs are available

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    cpufreq: qcom-cpufreq-hw: fix double IO unmap and resource release on exit

Roberto Sassu <roberto.sassu@huawei.com>
    reiserfs: Add security prefix to xattr name in reiserfs_security_write()

Zheng Yejian <zhengyejian1@huawei.com>
    rcu: Avoid stack overflow due to __rcu_irq_enter_check_tick() being kprobe-ed

Mario Limonciello <mario.limonciello@amd.com>
    crypto: ccp - Don't initialize CCP for PSP 0x1649

Eric Biggers <ebiggers@google.com>
    crypto: testmgr - fix RNG performance in fuzz tests

Eric Biggers <ebiggers@google.com>
    crypto: arm64/aes-neonbs - fix crash with CFI enabled

Jonathan McDowell <noodles@earth.li>
    crypto: safexcel - Cleanup ring IRQ workqueues on load failure

Toke Høiland-Jørgensen <toke@redhat.com>
    crypto: api - Demote BUG_ON() in crypto_unregister_alg() to a WARN_ON()

Johannes Berg <johannes.berg@intel.com>
    ring-buffer: Sync IRQ works before buffer destruction

Tze-nan Wu <Tze-nan.Wu@mediatek.com>
    ring-buffer: Ensure proper resetting of atomic variables in ring_buffer_reset_online_cpus

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    pinctrl: qcom: lpass-lpi: set output value before enabling output

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: qcom: correct setting ignore bit on v1.5.1

Heiner Kallweit <hkallweit1@gmail.com>
    pwm: meson: Fix g12a ao clk81 name

Heiner Kallweit <hkallweit1@gmail.com>
    pwm: meson: Fix axg ao mux parents

Eric Huang <echuang@realtek.com>
    wifi: rtw89: correct 5 MHz mask setting

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: add missing locking to protect against concurrent rx/status calls

Kees Cook <keescook@chromium.org>
    kheaders: Use array declaration instead of char

William Breathitt Gray <william.gray@linaro.org>
    iio: addac: stx104: Fix race condition for stx104_write_raw()

William Breathitt Gray <william.gray@linaro.org>
    iio: addac: stx104: Fix race condition when converting analog-to-digital

Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
    ipmi: fix SSIF not responding under certain cond.

Corey Minyard <minyard@acm.org>
    ipmi:ssif: Add send_retries increment

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: fw: Allow firmware to pass a empty env

Kefeng Wang <wangkefeng.wang@huawei.com>
    fs: fix sysctls.c built

Joel Fernandes (Google) <joel@joelfernandes.org>
    tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem

Jan Kundrát <jan.kundrat@cesnet.cz>
    serial: max310x: fix IO data corruption in batched operations

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    serial: 8250: Fix serial8250_tx_empty() race with DMA Tx

Johan Hovold <johan@kernel.org>
    serial: fix TIOCSRS485 locking

Johan Hovold <johan+linaro@kernel.org>
    xhci: fix debugfs register accesses while suspended

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH

Nuno Sá <nuno.sa@analog.com>
    staging: iio: resolver: ads1210: fix config mode

Eric Biggers <ebiggers@google.com>
    blk-crypto: make blk_crypto_evict_key() more robust

Eric Biggers <ebiggers@google.com>
    blk-crypto: make blk_crypto_evict_key() return void

Eric Biggers <ebiggers@google.com>
    blk-mq: release crypto keyslot before reporting I/O complete

Chengming Zhou <zhouchengming@bytedance.com>
    blk-stat: fix QUEUE_FLAG_STATS clear

Martin Krastev <krastevm@vmware.com>
    drm/vmwgfx: Fix Legacy Display Unit atomic drm support

Ricardo Ribalda <ribalda@chromium.org>
    media: ov8856: Do not check for for module version

Thomas Gleixner <tglx@linutronix.de>
    posix-cpu-timers: Implement the missing timer_wait_running callback

Jarkko Sakkinen <jarkko@kernel.org>
    tpm: Add !tpm_amd_is_rng_defective() to the hwrng_unregister() call site

Chris Packham <chris.packham@alliedtelesis.co.nz>
    hwmon: (adt7475) Use device_property APIs when configuring polarity

Babu Moger <Babu.Moger@amd.com>
    hwmon: (k10temp) Check range scale when CUR_TEMP register is read-write

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: fix runtime pm imbalance on unbind

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: fix runtime pm imbalance on probe errors

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: dwc3: gadget: Stall and restart EP0 if host is unresponsive

Badhri Jagan Sridharan <badhri@google.com>
    usb: gadget: udc: core: Prevent redundant calls to pullup

Badhri Jagan Sridharan <badhri@google.com>
    usb: gadget: udc: core: Invoke usb_gadget_connect only when started

Sascha Hauer <s.hauer@pengutronix.de>
    wifi: rtw88: usb: fix priority queue to endpoint mapping

Randy Dunlap <rdunlap@infradead.org>
    IMA: allow/fix UML builds

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    phy: qcom-qmp-pcie: sc8180x PCIe PHY has 2 lanes

Slark Xiao <slark_xiao@163.com>
    bus: mhi: host: pci_generic: Revert "Add a secondary AT port to Telit FN990"

Manivannan Sadhasivam <mani@kernel.org>
    PCI: qcom: Fix the incorrect register usage in v2.7.0 config

Lukas Wunner <lukas@wunner.de>
    PCI: pciehp: Fix AB-BA deadlock between reset_lock and device_lock

Josh Triplett <josh@joshtriplett.org>
    PCI: kirin: Select REGMAP_MMIO

Nicholas Piggin <npiggin@gmail.com>
    powerpc/boot: Fix boot wrapper code generation with CONFIG_POWER10_CPU

Ard Biesheuvel <ardb@kernel.org>
    arm64: Stash shadow stack pointer in the task struct on interrupt

Ard Biesheuvel <ardb@kernel.org>
    arm64: Always load shadow stack pointer directly from the task struct

Syed Saba Kareem <Syed.SabaKareem@amd.com>
    ASoC: amd: ps: update the acp clock source.

Mario Limonciello <mario.limonciello@amd.com>
    wifi: mt76: mt7921e: Set memory space enable in PCI_COMMAND if unset

Tony Luck <tony.luck@intel.com>
    x86/cpu: Add model number for Intel Arrow Lake processor

Vladimir Oltean <vladimir.oltean@nxp.com>
    asm-generic/io.h: suppress endianness warnings for relaxed accessors

Vladimir Oltean <vladimir.oltean@nxp.com>
    asm-generic/io.h: suppress endianness warnings for readq() and writeq()

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Error if a trace event has an array for a __field()

Kalle Valo <quic_kvalo@quicinc.com>
    wifi: ath11k: reduce the MHI timeout to 20s

Benjamin Asbach <asbachb.kernel@impl.it>
    platform/x86: thinkpad_acpi: Add missing T14s Gen1 type to s2idle quirk list

Daniel Golle <daniel@makrotopia.org>
    net: sfp: add quirk enabling 2500Base-x for HG MXPD-483II

Ranjan Kumar <ranjan.kumar@broadcom.com>
    scsi: mpi3mr: Handle soft reset in progress fault code (0xF002)

Anh Tuan Phan <tuananhlfc@gmail.com>
    selftests mount: Fix mount_setattr_test builds failed

Ben Greear <greearb@candelatech.com>
    wifi: mt76: mt7921: Fix use-after-free in fw features query.

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    net: wwan: t7xx: do not compile with -Werror

Duy Nguyen <duy.nguyen.rh@renesas.com>
    ASoC: da7213.c: add missing pm_runtime_disable()

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: bytcr_rt5640: Add quirk for the Acer Iconia One 7 B1-750

Patrik Dahlström <risca@dalakolonin.se>
    iio: adc: palmas_gpadc: fix NULL dereference on rmmod

Ge-org Brohammer <gbrohammer@outlook.com>
    ASoC: amd: yc: Add DMI entries to support Victus by HP Laptop 16-e1xxx (8A22)

Michael Kelley <mikelley@microsoft.com>
    x86/hyperv: Block root partition functionality in a Confidential VM

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: soc-pcm: fix hw->formats cleared by soc_pcm_hw_init() for dpcm

Eugene Huang <eugene.huang99@gmail.com>
    ASoC: Intel: soc-acpi: add table for Intel 'Rooks County' NUC M15

Eugene Huang <eugene.huang99@gmail.com>
    ASOC: Intel: sof_sdw: add quirk for Intel 'Rooks County' NUC M15


-------------

Diffstat:

 .../bindings/sound/qcom,lpass-rx-macro.yaml        |    1 +
 Makefile                                           |    4 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   16 +
 arch/arm/boot/dts/qcom-apq8064.dtsi                |    2 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |    4 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |   12 +-
 arch/arm/boot/dts/qcom-sdx55.dtsi                  |   78 +-
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi           |   30 +-
 arch/arm64/boot/dts/apple/t8103-j274.dts           |   10 +
 arch/arm64/boot/dts/apple/t8103-j293.dts           |   15 -
 arch/arm64/boot/dts/apple/t8103-j313.dts           |   15 -
 arch/arm64/boot/dts/apple/t8103-j456.dts           |   10 +
 arch/arm64/boot/dts/apple/t8103-j457.dts           |   11 +-
 arch/arm64/boot/dts/apple/t8103.dtsi               |    4 +
 .../dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts |   10 +-
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi   |    4 +-
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi   |    2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts        |    3 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |   26 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |   12 +-
 .../boot/dts/qcom/msm8956-sony-xperia-loire.dtsi   |    4 +
 arch/arm64/boot/dts/qcom/msm8976.dtsi              |    9 +
 arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi  |    5 -
 .../dts/qcom/msm8994-huawei-angler-rev-101.dts     |   11 +-
 .../boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi  |    3 +-
 .../dts/qcom/msm8994-sony-xperia-kitakami.dtsi     |    3 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |    5 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   12 +-
 .../boot/dts/qcom/msm8998-oneplus-cheeseburger.dts |    2 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |    4 +-
 arch/arm64/boot/dts/qcom/pmi8994.dtsi              |    2 -
 .../qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts |    2 +-
 .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi      |    2 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |    2 +-
 .../boot/dts/qcom/sc7280-herobrine-villager.dtsi   |    2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   13 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   10 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   16 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |    6 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |    8 +-
 .../dts/qcom/sm8350-microsoft-surface-duo2.dts     |    3 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |   12 +-
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          |    3 -
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |    3 -
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi         |   19 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi         |   19 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi         |   19 +-
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi           |    4 +-
 arch/arm64/boot/dts/ti/k3-am625.dtsi               |    2 +-
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            |    5 +-
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi              |    2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |    1 -
 arch/arm64/crypto/aes-neonbs-core.S                |    9 +-
 arch/arm64/include/asm/debug-monitors.h            |    1 +
 arch/arm64/include/asm/kvm_host.h                  |    4 +
 arch/arm64/include/asm/scs.h                       |    7 +-
 arch/arm64/kernel/debug-monitors.c                 |    5 +
 arch/arm64/kernel/entry.S                          |   16 +-
 arch/arm64/kernel/head.S                           |    2 +-
 arch/arm64/kernel/kgdb.c                           |    2 +
 arch/arm64/kvm/arm.c                               |   53 +-
 arch/arm64/kvm/guest.c                             |    2 +
 arch/arm64/kvm/hypercalls.c                        |    4 +-
 arch/arm64/kvm/pmu-emul.c                          |   23 +-
 arch/arm64/kvm/psci.c                              |   28 +-
 arch/arm64/kvm/reset.c                             |   15 +-
 arch/arm64/kvm/vgic/vgic-debug.c                   |    8 +-
 arch/arm64/kvm/vgic/vgic-init.c                    |   36 +-
 arch/arm64/kvm/vgic/vgic-its.c                     |   33 +-
 arch/arm64/kvm/vgic/vgic-kvm-device.c              |   47 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |    4 +-
 arch/arm64/kvm/vgic/vgic-mmio.c                    |   12 +-
 arch/arm64/kvm/vgic/vgic-v4.c                      |   11 +-
 arch/arm64/kvm/vgic/vgic.c                         |   12 +-
 arch/ia64/kernel/salinfo.c                         |    2 +-
 arch/ia64/mm/contig.c                              |    2 +-
 arch/ia64/mm/hugetlbpage.c                         |    2 +-
 arch/mips/fw/lib/cmdline.c                         |    2 +-
 arch/openrisc/kernel/entry.S                       |    6 +-
 arch/parisc/kernel/pacache.S                       |    2 +
 arch/parisc/kernel/real2.S                         |    5 +-
 arch/powerpc/boot/Makefile                         |    2 +
 arch/powerpc/include/asm/reg.h                     |    5 +
 arch/powerpc/kernel/rtas.c                         |    2 +-
 arch/powerpc/perf/mpc7450-pmu.c                    |    6 +-
 arch/powerpc/platforms/512x/clock-commonclk.c      |    2 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |    2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |    2 +-
 arch/powerpc/platforms/embedded6xx/wii.c           |    4 +-
 arch/powerpc/sysdev/tsi108_pci.c                   |    5 +-
 arch/riscv/include/asm/sbi.h                       |    2 +-
 arch/riscv/kernel/cpu_ops.c                        |    2 +-
 arch/riscv/kernel/sbi.c                            |   17 +-
 arch/riscv/kvm/main.c                              |    2 +-
 arch/riscv/kvm/mmu.c                               |   25 +-
 arch/riscv/mm/init.c                               |    6 +-
 arch/riscv/mm/ptdump.c                             |   24 +-
 arch/s390/Kconfig                                  |    4 -
 arch/s390/include/asm/checksum.h                   |    9 +-
 arch/sh/kernel/cpu/sh4/sq.c                        |    2 +-
 arch/x86/include/asm/intel-family.h                |    2 +
 arch/x86/kernel/apic/apic.c                        |    5 +-
 arch/x86/kernel/apic/io_apic.c                     |   14 +-
 arch/x86/kernel/cpu/mce/amd.c                      |   14 +-
 arch/x86/kernel/cpu/mshyperv.c                     |   12 +-
 arch/x86/kvm/vmx/vmx.c                             |   23 +-
 block/blk-crypto-internal.h                        |   25 +-
 block/blk-crypto-profile.c                         |   46 +-
 block/blk-crypto.c                                 |   66 +-
 block/blk-iocost.c                                 |    8 +-
 block/blk-merge.c                                  |    2 +
 block/blk-mq.c                                     |   17 +-
 block/blk-stat.c                                   |    4 +-
 crypto/algapi.c                                    |    4 +-
 crypto/drbg.c                                      |    2 +-
 crypto/testmgr.c                                   |  266 +++--
 drivers/acpi/bus.c                                 |    1 +
 drivers/acpi/power.c                               |   19 +
 drivers/acpi/processor_pdc.c                       |   11 +
 drivers/acpi/video_detect.c                        |   14 -
 drivers/acpi/viot.c                                |    5 +-
 drivers/base/cacheinfo.c                           |    5 +-
 drivers/base/cpu.c                                 |    3 +-
 drivers/base/platform.c                            |    4 +-
 drivers/block/drbd/drbd_receiver.c                 |    2 +-
 drivers/bluetooth/btsdio.c                         |    1 -
 drivers/bus/mhi/host/boot.c                        |   16 +-
 drivers/bus/mhi/host/init.c                        |   12 +
 drivers/bus/mhi/host/main.c                        |    2 +-
 drivers/bus/mhi/host/pci_generic.c                 |    2 -
 drivers/char/ipmi/Kconfig                          |    3 +-
 drivers/char/ipmi/ipmi_ssif.c                      |    8 +-
 drivers/char/tpm/tpm-chip.c                        |    3 +-
 drivers/char/tpm/tpm_tis_core.c                    |  131 ++-
 drivers/char/tpm/tpm_tis_core.h                    |    2 +
 drivers/clk/at91/clk-sam9x60-pll.c                 |    2 +-
 drivers/clk/clk-conf.c                             |   12 +-
 drivers/clk/imx/clk-fracn-gppll.c                  |   22 +-
 drivers/clk/imx/clk-imx8ulp.c                      |    4 +-
 drivers/clk/mediatek/clk-mt2701-aud.c              |   40 +-
 drivers/clk/mediatek/clk-mt2701-bdp.c              |   20 +-
 drivers/clk/mediatek/clk-mt2701-eth.c              |   10 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c              |   10 +-
 drivers/clk/mediatek/clk-mt2701-hif.c              |   10 +-
 drivers/clk/mediatek/clk-mt2701-img.c              |   10 +-
 drivers/clk/mediatek/clk-mt2701-mm.c               |   20 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c             |   20 +-
 drivers/clk/mediatek/clk-mt2701.c                  |   40 +-
 drivers/clk/mediatek/clk-mt2712-bdp.c              |   10 +-
 drivers/clk/mediatek/clk-mt2712-img.c              |   10 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c           |   10 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c              |   10 +-
 drivers/clk/mediatek/clk-mt2712-mm.c               |   34 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c             |   20 +-
 drivers/clk/mediatek/clk-mt2712-venc.c             |   10 +-
 drivers/clk/mediatek/clk-mt2712.c                  |   78 +-
 drivers/clk/mediatek/clk-mt6765-audio.c            |   20 +-
 drivers/clk/mediatek/clk-mt6765-cam.c              |   10 +-
 drivers/clk/mediatek/clk-mt6765-img.c              |   10 +-
 drivers/clk/mediatek/clk-mt6765-mipi0a.c           |   10 +-
 drivers/clk/mediatek/clk-mt6765-mm.c               |   10 +-
 drivers/clk/mediatek/clk-mt6765-vcodec.c           |   10 +-
 drivers/clk/mediatek/clk-mt6765.c                  |   80 +-
 drivers/clk/mediatek/clk-mt6797-img.c              |   10 +-
 drivers/clk/mediatek/clk-mt6797-mm.c               |   20 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c             |   20 +-
 drivers/clk/mediatek/clk-mt6797-venc.c             |   10 +-
 drivers/clk/mediatek/clk-mt6797.c                  |   42 +-
 drivers/clk/mediatek/clk-mt7622-aud.c              |   40 +-
 drivers/clk/mediatek/clk-mt7622-eth.c              |   20 +-
 drivers/clk/mediatek/clk-mt7622-hif.c              |   20 +-
 drivers/clk/mediatek/clk-mt7622.c                  |   90 +-
 drivers/clk/mediatek/clk-mt7629-eth.c              |   20 +-
 drivers/clk/mediatek/clk-mt7629-hif.c              |   20 +-
 drivers/clk/mediatek/clk-mt7629.c                  |   40 +-
 drivers/clk/mediatek/clk-mt7986-eth.c              |   24 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c         |   24 +-
 drivers/clk/mediatek/clk-mt8135.c                  |   44 +-
 drivers/clk/mediatek/clk-mt8167-aud.c              |   11 +-
 drivers/clk/mediatek/clk-mt8167-img.c              |   10 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c           |   10 +-
 drivers/clk/mediatek/clk-mt8167-mm.c               |   22 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c             |   20 +-
 drivers/clk/mediatek/clk-mt8173-mm.c               |   22 +-
 drivers/clk/mediatek/clk-mt8516-aud.c              |   10 +-
 drivers/clk/mediatek/clk-mt8516.c                  |   60 +-
 drivers/clk/mediatek/clk-pllfh.c                   |   11 +-
 drivers/clk/microchip/clk-mpfs.c                   |    3 +-
 drivers/clk/qcom/dispcc-qcm2290.c                  |    9 -
 drivers/clk/qcom/gcc-qcm2290.c                     |    3 +-
 drivers/clk/qcom/gcc-sm6115.c                      |   50 +-
 drivers/clk/qcom/gcc-sm8350.c                      |   47 +-
 drivers/clk/qcom/lpassaudiocc-sc7280.c             |    2 +
 drivers/clk/qcom/lpasscc-sc7280.c                  |   16 +-
 drivers/clk/rockchip/clk-rk3399.c                  |    2 +-
 drivers/clocksource/timer-davinci.c                |   30 +-
 drivers/cpufreq/cpufreq.c                          |    2 +-
 drivers/cpufreq/mediatek-cpufreq.c                 |   98 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  |   25 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c                |    2 +-
 drivers/crypto/Kconfig                             |    1 +
 drivers/crypto/caam/ctrl.c                         |    6 +-
 drivers/crypto/ccp/sp-pci.c                        |    2 +-
 drivers/crypto/inside-secure/safexcel.c            |   37 +-
 drivers/crypto/qat/qat_common/adf_accel_devices.h  |    1 +
 drivers/crypto/qat/qat_common/adf_common_drv.h     |    3 +
 drivers/crypto/qat/qat_common/adf_dev_mgr.c        |    2 +
 drivers/crypto/qat/qat_common/adf_init.c           |   64 ++
 drivers/crypto/qat/qat_common/adf_sysfs.c          |   23 +-
 drivers/cxl/core/hdm.c                             |   15 +-
 drivers/dma/at_xdmac.c                             |    5 +-
 drivers/dma/dw-edma/dw-edma-core.c                 |   27 +-
 drivers/dma/mv_xor_v2.c                            |    2 +-
 drivers/dma/qcom/gpi.c                             |    1 -
 drivers/edac/skx_base.c                            |    4 +-
 drivers/firmware/arm_scmi/driver.c                 |    2 +-
 drivers/firmware/qcom_scm.c                        |    3 +-
 drivers/firmware/stratix10-svc.c                   |    4 +-
 drivers/fpga/fpga-bridge.c                         |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   21 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |    3 +
 drivers/gpu/drm/amd/display/dc/dce60/Makefile      |    2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  |   16 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.h  |    3 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c  |    2 +-
 .../drm/amd/display/dc/dcn314/dcn314_resource.c    |   77 +-
 .../drm/amd/display/dc/dcn314/dcn314_resource.h    |    4 +
 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   |    2 +-
 .../drm/amd/display/modules/power/power_helpers.c  |   35 +
 .../drm/amd/display/modules/power/power_helpers.h  |    3 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   40 +-
 drivers/gpu/drm/bridge/adv7511/adv7533.c           |   25 +-
 drivers/gpu/drm/drm_probe_helper.c                 |    5 +-
 drivers/gpu/drm/i915/display/intel_display.c       |    2 +-
 drivers/gpu/drm/lima/lima_drv.c                    |    6 +-
 drivers/gpu/drm/mediatek/mtk_dp.c                  |   15 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |    8 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |    3 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |    2 +-
 drivers/gpu/drm/panel/panel-novatek-nt35950.c      |   10 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |    4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |    3 -
 drivers/gpu/drm/ttm/ttm_pool.c                     |   81 +-
 drivers/gpu/drm/vgem/vgem_fence.c                  |    1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   62 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |    5 -
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |   45 +-
 drivers/gpu/host1x/context.c                       |   24 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             |    9 +
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      |    2 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c      |   11 +
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c |   10 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h |    8 +-
 drivers/hte/hte-tegra194-test.c                    |    1 +
 drivers/hte/hte-tegra194.c                         |    2 +-
 drivers/hwmon/adt7475.c                            |    6 +-
 drivers/hwmon/k10temp.c                            |    4 +-
 drivers/hwmon/pmbus/fsp-3y.c                       |    1 -
 drivers/hwtracing/coresight/coresight-etm-perf.c   |    1 +
 drivers/i2c/busses/i2c-cadence.c                   |    6 +-
 drivers/i2c/busses/i2c-omap.c                      |    2 +-
 drivers/i2c/busses/i2c-xiic.c                      |    4 +-
 drivers/iio/adc/palmas_gpadc.c                     |    2 +-
 drivers/iio/addac/stx104.c                         |   12 +
 drivers/iio/light/max44009.c                       |   13 +-
 drivers/infiniband/core/cm.c                       |    3 +-
 drivers/infiniband/hw/erdma/erdma_hw.h             |    4 +
 drivers/infiniband/hw/erdma/erdma_verbs.c          |   17 +-
 drivers/infiniband/hw/hfi1/ipoib_tx.c              |    6 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c                |   73 +-
 drivers/infiniband/hw/hfi1/mmu_rb.h                |    8 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |   21 +-
 drivers/infiniband/hw/hfi1/sdma.h                  |   16 +-
 drivers/infiniband/hw/hfi1/sdma_txreq.h            |    1 +
 drivers/infiniband/hw/hfi1/trace_mmu.h             |    4 -
 drivers/infiniband/hw/hfi1/user_sdma.c             |  600 +++++++----
 drivers/infiniband/hw/hfi1/user_sdma.h             |    5 -
 drivers/infiniband/hw/hfi1/verbs.c                 |    4 +-
 drivers/infiniband/hw/hfi1/vnic_sdma.c             |    1 +
 drivers/infiniband/hw/mlx4/qp.c                    |    8 +-
 drivers/infiniband/hw/mlx5/devx.c                  |   31 +-
 drivers/infiniband/hw/mlx5/qp.c                    |    2 +-
 drivers/infiniband/hw/mlx5/umr.c                   |    6 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |    2 -
 drivers/infiniband/sw/rxe/rxe.c                    |   12 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |    3 +-
 drivers/infiniband/sw/rxe/rxe_cq.c                 |   32 +-
 drivers/infiniband/sw/rxe/rxe_loc.h                |    6 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   63 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |    3 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |    3 +-
 drivers/infiniband/sw/rxe/rxe_task.c               |   22 +-
 drivers/infiniband/sw/rxe/rxe_task.h               |   15 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |    2 -
 drivers/infiniband/sw/rxe/rxe_verbs.h              |    2 -
 drivers/infiniband/sw/siw/siw_main.c               |    3 -
 drivers/infiniband/sw/siw/siw_qp_tx.c              |    2 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |    4 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   23 +-
 drivers/input/touchscreen/raspberrypi-ts.c         |    3 +-
 drivers/interconnect/qcom/icc-rpm.c                |    7 -
 drivers/interconnect/qcom/icc-rpm.h                |    1 -
 drivers/interconnect/qcom/msm8996.c                |    1 -
 drivers/interconnect/qcom/osm-l3.c                 |    7 -
 drivers/interconnect/qcom/sc7180.h                 |    2 -
 drivers/interconnect/qcom/sc7280.h                 |    2 -
 drivers/interconnect/qcom/sc8180x.h                |    2 -
 drivers/interconnect/qcom/sdm845.h                 |    2 -
 drivers/interconnect/qcom/sm8150.h                 |    2 -
 drivers/interconnect/qcom/sm8250.h                 |    2 -
 drivers/iommu/amd/amd_iommu_types.h                |    4 +-
 drivers/iommu/amd/iommu.c                          |    6 +-
 drivers/iommu/iommu.c                              |    9 +-
 drivers/iommu/iommufd/selftest.c                   |    9 +-
 drivers/iommu/mtk_iommu.c                          |    8 +
 drivers/leds/Kconfig                               |    2 +-
 drivers/leds/leds-tca6507.c                        |    5 +-
 drivers/macintosh/Kconfig                          |    1 +
 drivers/macintosh/windfarm_smu_sat.c               |    1 +
 drivers/mailbox/mailbox-mpfs.c                     |   12 +-
 drivers/mailbox/zynqmp-ipi-mailbox.c               |    6 +-
 drivers/md/dm-clone-target.c                       |    1 +
 drivers/md/dm-flakey.c                             |    4 +-
 drivers/md/dm-integrity.c                          |    8 +-
 drivers/md/dm-ioctl.c                              |   12 +-
 drivers/md/dm-table.c                              |   19 +-
 drivers/md/dm-verity-target.c                      |    2 +-
 drivers/md/raid10.c                                |   96 +-
 drivers/md/raid5.c                                 |   45 +-
 drivers/media/i2c/hi846.c                          |   11 +-
 drivers/media/i2c/max9286.c                        |    1 +
 drivers/media/i2c/ov8856.c                         |   40 -
 drivers/media/pci/dm1105/dm1105.c                  |    1 +
 drivers/media/pci/saa7134/saa7134-ts.c             |    1 +
 drivers/media/pci/saa7134/saa7134-vbi.c            |    1 +
 drivers/media/pci/saa7134/saa7134-video.c          |    1 +
 drivers/media/platform/amphion/vdec.c              |   32 +
 drivers/media/platform/amphion/vpu_codec.h         |    3 +-
 drivers/media/platform/amphion/vpu_malone.c        |    4 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |   19 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.h   |    2 +
 .../media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c |    4 -
 .../media/platform/mediatek/mdp3/mtk-mdp3-m2m.c    |    8 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-regs.c   |   10 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c      |   24 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec_drv.c  |    3 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec_hw.c   |    8 +
 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c      |   12 +-
 .../mediatek/vcodec/mtk_vcodec_dec_stateless.c     |   14 +-
 .../mediatek/vcodec/vdec/vdec_h264_req_multi_if.c  |    2 +-
 .../mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c     |    2 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.c      |   95 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.h      |   12 +
 drivers/media/platform/qcom/venus/vdec.c           |   16 +-
 drivers/media/platform/renesas/rcar_fdp1.c         |   17 +-
 drivers/media/platform/renesas/vsp1/vsp1_video.c   |    2 +-
 drivers/media/platform/st/sti/bdisp/bdisp-v4l2.c   |    2 +
 drivers/media/rc/gpio-ir-recv.c                    |    2 +
 drivers/media/v4l2-core/v4l2-async.c               |   13 +-
 drivers/mfd/arizona-spi.c                          |    1 +
 drivers/mfd/ocelot-spi.c                           |    1 +
 drivers/mfd/tqmx86.c                               |   52 +-
 drivers/misc/vmw_vmci/vmci_host.c                  |    8 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |   24 +-
 drivers/mtd/mtdcore.c                              |   23 +-
 drivers/mtd/spi-nor/core.c                         |    4 +-
 drivers/mtd/ubi/eba.c                              |   19 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |    1 -
 drivers/net/ethernet/amd/nmclan_cs.c               |    2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |    3 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |    6 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |   68 +-
 drivers/net/ethernet/intel/i40e/i40e_alloc.h       |   22 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c      |   12 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      | 1038 +++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_dcb.c         |   60 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb.h         |   28 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |   16 +-
 drivers/net/ethernet/intel/i40e/i40e_ddp.c         |   14 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |    8 +-
 drivers/net/ethernet/intel/i40e/i40e_diag.c        |   12 +-
 drivers/net/ethernet/intel/i40e/i40e_diag.h        |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   65 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.c         |   56 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.h         |   46 +-
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c     |   94 +-
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h     |   34 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  404 ++++----
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  252 ++---
 drivers/net/ethernet/intel/i40e/i40e_osdep.h       |    1 -
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  643 ++++++------
 drivers/net/ethernet/intel/i40e/i40e_status.h      |   35 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   94 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |   23 +-
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |    6 +-
 .../ethernet/mellanox/mlx5/core/en/tc/post_act.c   |   11 +-
 .../ethernet/mellanox/mlx5/core/en/tc/post_act.h   |    2 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc/sample.c |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |    5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |    2 +
 .../net/ethernet/mellanox/mlx5/core/esw/vporttbl.c |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |    2 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |    4 +-
 .../mellanox/mlx5/core/eswitch_offloads_termtbl.c  |   32 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   16 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    6 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |    2 +-
 drivers/net/ethernet/netronome/nfp/crypto/ipsec.c  |    4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |  197 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   12 +-
 drivers/net/ethernet/sun/sunhme.c                  |    2 +-
 drivers/net/pcs/pcs-xpcs.c                         |   13 +-
 drivers/net/phy/sfp.c                              |    4 +
 drivers/net/wireless/ath/ath11k/ahb.c              |   14 +-
 drivers/net/wireless/ath/ath11k/dbring.c           |   12 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |    2 +-
 drivers/net/wireless/ath/ath11k/peer.c             |    5 +-
 drivers/net/wireless/ath/ath5k/ahb.c               |   10 +-
 drivers/net/wireless/ath/ath5k/eeprom.c            |    2 +-
 drivers/net/wireless/ath/ath6kl/bmi.c              |    2 +-
 drivers/net/wireless/ath/ath6kl/htc_pipe.c         |    4 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |   19 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   14 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |    8 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |    6 +
 drivers/net/wireless/intel/iwlwifi/iwl-debug.c     |    3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |    1 +
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   10 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |    5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |    1 -
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   12 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |    2 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |   13 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |    3 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   13 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |    3 -
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c   |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   17 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |    2 +
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |    2 +
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c    |   40 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   20 -
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   21 +-
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  108 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.h    |   56 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |    5 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |    4 +
 drivers/net/wireless/mediatek/mt76/util.c          |   10 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |    1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |    1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |    6 +-
 drivers/net/wireless/realtek/rtlwifi/debug.c       |   12 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |    8 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   70 +-
 drivers/net/wireless/realtek/rtw89/core.c          |   10 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |   19 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    9 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    9 +-
 drivers/net/wwan/t7xx/Makefile                     |    2 -
 drivers/nvme/host/core.c                           |    5 +-
 drivers/nvme/host/trace.h                          |   15 +-
 drivers/nvme/target/admin-cmd.c                    |   45 +-
 drivers/nvme/target/fcloop.c                       |   48 +-
 drivers/nvme/target/nvmet.h                        |    2 +-
 drivers/nvme/target/zns.c                          |   18 +-
 drivers/of/device.c                                |    7 +-
 drivers/pci/controller/dwc/Kconfig                 |    1 +
 drivers/pci/controller/dwc/pci-imx6.c              |    7 +
 drivers/pci/controller/dwc/pcie-qcom.c             |    8 +-
 drivers/pci/hotplug/pciehp_pci.c                   |   15 +
 drivers/pci/pcie/edr.c                             |    1 +
 drivers/pci/quirks.c                               |   13 +
 drivers/perf/amlogic/meson_ddr_pmu_core.c          |    8 +-
 drivers/perf/arm-cmn.c                             |   59 +-
 drivers/perf/riscv_pmu_sbi.c                       |    2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           |    2 +-
 drivers/phy/tegra/xusb.c                           |    2 +
 drivers/phy/ti/phy-j721e-wiz.c                     |   11 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   19 +-
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           |   14 +-
 drivers/pinctrl/ralink/pinctrl-mt7620.c            |    1 +
 drivers/pinctrl/ralink/pinctrl-mt7621.c            |    1 +
 drivers/pinctrl/ralink/pinctrl-rt2880.c            |    1 +
 drivers/pinctrl/ralink/pinctrl-rt305x.c            |    1 +
 drivers/pinctrl/ralink/pinctrl-rt3883.c            |    1 +
 drivers/pinctrl/renesas/pfc-r8a779a0.c             |    8 -
 drivers/pinctrl/renesas/pfc-r8a779f0.c             |    2 +-
 drivers/pinctrl/renesas/pfc-r8a779g0.c             |  990 ++++++++++---------
 drivers/platform/chrome/cros_typec_switch.c        |    1 +
 drivers/platform/x86/amd/Kconfig                   |    2 +-
 drivers/platform/x86/amd/pmc.c                     |  157 ++-
 drivers/platform/x86/amd/pmf/Kconfig               |    1 +
 drivers/platform/x86/amd/pmf/core.c                |   22 +-
 drivers/platform/x86/thinkpad_acpi.c               |    8 +
 drivers/power/supply/generic-adc-battery.c         |    3 +
 drivers/power/supply/rk817_charger.c               |   33 +-
 drivers/pwm/pwm-meson.c                            |    6 +-
 drivers/pwm/pwm-mtk-disp.c                         |   34 +-
 drivers/regulator/core.c                           |  100 +-
 drivers/regulator/stm32-pwr.c                      |    7 +-
 drivers/remoteproc/xlnx_r5_remoteproc.c            |   90 +-
 drivers/rpmsg/qcom_glink_native.c                  |   10 +-
 drivers/rtc/rtc-meson-vrtc.c                       |    4 +-
 drivers/rtc/rtc-omap.c                             |    1 +
 drivers/rtc/rtc-ti-k3.c                            |    3 +-
 drivers/s390/block/dasd.c                          |    2 +-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c             |    6 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c             |    6 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |    6 +-
 drivers/scsi/lpfc/lpfc_init.c                      |   10 +-
 drivers/scsi/megaraid.c                            |    1 +
 drivers/scsi/mpi3mr/mpi3mr_fw.c                    |    2 +-
 drivers/soc/bcm/brcmstb/biuctrl.c                  |    4 +
 drivers/soc/qcom/rpmh-rsc.c                        |    2 +-
 drivers/soc/renesas/renesas-soc.c                  |    5 +-
 drivers/soc/ti/k3-ringacc.c                        |    7 +
 drivers/soc/ti/pm33xx.c                            |    5 +-
 drivers/soundwire/cadence_master.h                 |    2 -
 drivers/soundwire/intel.c                          |   11 +-
 drivers/soundwire/qcom.c                           |    2 +-
 drivers/spi/atmel-quadspi.c                        |   30 +-
 drivers/spi/spi-bcm63xx.c                          |    2 -
 drivers/spi/spi-cadence-quadspi.c                  |   32 +-
 drivers/spi/spi-fsl-spi.c                          |   12 +-
 drivers/spi/spi-imx.c                              |   12 +-
 drivers/spi/spi-pci1xxxx.c                         |    5 +-
 drivers/spi/spi-qup.c                              |   22 +-
 drivers/spi/spi-sn-f-ospi.c                        |    2 +-
 drivers/spmi/spmi.c                                |    3 +-
 drivers/staging/iio/resolver/ad2s1210.c            |    2 +-
 .../media/deprecated/saa7146/av7110/av7110_av.c    |    4 +-
 drivers/staging/media/rkvdec/rkvdec.c              |    2 +
 drivers/staging/media/sunxi/cedrus/cedrus.c        |    1 +
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |    1 +
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |    8 +-
 drivers/target/iscsi/iscsi_target.c                |   36 +-
 drivers/target/iscsi/iscsi_target_login.c          |    7 +
 drivers/target/target_core_device.c                |    1 +
 drivers/target/target_core_internal.h              |    1 -
 drivers/target/target_core_tmr.c                   |   26 +-
 drivers/target/target_core_tpg.c                   |    2 +-
 drivers/target/target_core_transport.c             |  199 ++--
 drivers/target/target_core_xcopy.c                 |   23 +-
 drivers/thermal/mtk_thermal.c                      |   14 +-
 drivers/thunderbolt/tb.h                           |    2 +-
 drivers/tty/serial/8250/8250.h                     |   12 +
 drivers/tty/serial/8250/8250_bcm7271.c             |   18 +-
 drivers/tty/serial/8250/8250_port.c                |   11 +-
 drivers/tty/serial/fsl_lpuart.c                    |    2 +-
 drivers/tty/serial/max310x.c                       |   17 +-
 drivers/tty/serial/serial_core.c                   |    4 +-
 drivers/tty/serial/stm32-usart.c                   |    5 +-
 drivers/tty/tty.h                                  |    2 +
 drivers/tty/tty_io.c                               |    4 +-
 drivers/tty/tty_ioctl.c                            |   45 +-
 drivers/usb/chipidea/core.c                        |    2 +-
 drivers/usb/dwc3/core.c                            |   15 +-
 drivers/usb/dwc3/gadget.c                          |   60 +-
 drivers/usb/gadget/function/f_tcm.c                |    4 +-
 drivers/usb/gadget/udc/core.c                      |  151 ++-
 drivers/usb/gadget/udc/renesas_usb3.c              |    1 +
 drivers/usb/gadget/udc/tegra-xudc.c                |    2 +-
 drivers/usb/host/xhci-debugfs.c                    |    1 +
 drivers/usb/host/xhci-rcar.c                       |    3 -
 drivers/usb/mtu3/mtu3_qmu.c                        |    5 +-
 drivers/vhost/vdpa.c                               |    8 +-
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c              |    2 +-
 drivers/virt/coco/sev-guest/sev-guest.c            |   27 +-
 drivers/virtio/virtio_ring.c                       |   22 +-
 drivers/xen/pcpu.c                                 |   20 +
 fs/Makefile                                        |    3 +-
 fs/afs/dir.c                                       |    4 +
 fs/afs/inode.c                                     |   10 +-
 fs/btrfs/ioctl.c                                   |    5 +
 fs/ceph/caps.c                                     |    2 +-
 fs/ceph/debugfs.c                                  |   18 +-
 fs/ceph/mds_client.c                               |   72 +-
 fs/ceph/mds_client.h                               |    3 +-
 fs/ceph/super.h                                    |    2 +
 fs/cifs/cifs_debug.c                               |    7 +-
 fs/cifs/cifs_debug.h                               |   12 +-
 fs/cifs/cifsglob.h                                 |   21 +-
 fs/cifs/cifsproto.h                                |   44 +-
 fs/cifs/connect.c                                  |  134 +--
 fs/cifs/dfs.c                                      |  133 ++-
 fs/cifs/dfs.h                                      |   13 +-
 fs/cifs/dfs_cache.c                                |    6 +-
 fs/cifs/file.c                                     |   16 +
 fs/cifs/ioctl.c                                    |    2 +-
 fs/cifs/misc.c                                     |    8 +-
 fs/cifs/sess.c                                     |    7 +-
 fs/cifs/smb2pdu.c                                  |   19 +-
 fs/dlm/ast.c                                       |    9 +-
 fs/dlm/dlm_internal.h                              |    5 +-
 fs/dlm/user.c                                      |    2 +-
 fs/erofs/internal.h                                |    3 +-
 fs/erofs/super.c                                   |   22 +-
 fs/erofs/zmap.c                                    |    4 +
 fs/ext4/extents.c                                  |    3 +-
 fs/ext4/inode.c                                    |    3 +
 fs/f2fs/compress.c                                 |   13 +-
 fs/f2fs/data.c                                     |    5 +-
 fs/f2fs/f2fs.h                                     |    1 +
 fs/f2fs/file.c                                     |   21 +-
 fs/f2fs/gc.c                                       |    2 +-
 fs/f2fs/segment.c                                  |   73 +-
 fs/f2fs/segment.h                                  |    3 +
 fs/f2fs/super.c                                    |    2 +-
 fs/f2fs/sysfs.c                                    |    4 +-
 fs/jbd2/transaction.c                              |    3 +
 fs/ksmbd/auth.c                                    |   19 +-
 fs/ksmbd/mgmt/tree_connect.c                       |   10 +-
 fs/ksmbd/mgmt/tree_connect.h                       |    3 +
 fs/ksmbd/server.c                                  |    1 +
 fs/ksmbd/smb2pdu.c                                 |   21 +-
 fs/nfs/nfs4state.c                                 |    4 +
 fs/nilfs2/bmap.c                                   |   16 +-
 fs/nilfs2/segment.c                                |    5 +-
 fs/ntfs3/fslog.c                                   |    6 +-
 fs/ntfs3/index.c                                   |    8 +
 fs/ntfs3/inode.c                                   |    2 +-
 fs/ntfs3/namei.c                                   |   10 +
 fs/ntfs3/ntfs_fs.h                                 |    1 +
 fs/pstore/pmsg.c                                   |    7 +-
 fs/reiserfs/xattr_security.c                       |    8 +-
 fs/ubifs/dir.c                                     |    7 +-
 fs/ubifs/tnc.c                                     |  142 +--
 fs/xfs/libxfs/xfs_sb.c                             |   11 +-
 include/asm-generic/io.h                           |   16 +-
 include/drm/drm_file.h                             |    3 +-
 include/drm/i915_pciids.h                          |    1 -
 include/linux/blk-crypto.h                         |    4 +-
 include/linux/bpf.h                                |   42 +-
 include/linux/bpf_verifier.h                       |   38 +-
 include/linux/btf.h                                |    8 +
 include/linux/filter.h                             |    6 +-
 include/linux/mailbox/zynqmp-ipi-message.h         |    2 +-
 include/linux/mlx5/mlx5_ifc.h                      |    3 +-
 include/linux/netfilter/nfnetlink.h                |    1 -
 include/linux/platform_device.h                    |   11 +
 include/linux/posix-timers.h                       |   17 +-
 include/linux/sunrpc/sched.h                       |    3 +-
 include/linux/tick.h                               |    2 +
 include/linux/vt_buffer.h                          |    2 +-
 include/net/netfilter/nf_conntrack_core.h          |    6 +-
 include/net/scm.h                                  |   13 +-
 include/net/xsk_buff_pool.h                        |    9 +-
 include/target/iscsi/iscsi_target_core.h           |    1 +
 include/target/target_core_base.h                  |   14 +-
 include/target/target_core_fabric.h                |   15 +-
 include/trace/events/qrtr.h                        |   33 +-
 include/trace/events/timer.h                       |    3 +-
 include/trace/stages/stage5_get_offsets.h          |   21 +-
 include/uapi/linux/bpf.h                           |   11 +
 include/uapi/linux/btrfs.h                         |    1 +
 include/uapi/linux/const.h                         |    2 +-
 include/xen/xen.h                                  |   11 +
 io_uring/rsrc.c                                    |    2 +-
 kernel/bpf/arraymap.c                              |   12 +-
 kernel/bpf/bloom_filter.c                          |   12 +-
 kernel/bpf/bpf_cgrp_storage.c                      |    6 +-
 kernel/bpf/bpf_inode_storage.c                     |    6 +-
 kernel/bpf/bpf_struct_ops.c                        |    6 +-
 kernel/bpf/bpf_task_storage.c                      |    6 +-
 kernel/bpf/btf.c                                   |  197 ++--
 kernel/bpf/cgroup.c                                |    9 +-
 kernel/bpf/cpumap.c                                |    8 +-
 kernel/bpf/devmap.c                                |   24 +-
 kernel/bpf/hashtab.c                               |   36 +-
 kernel/bpf/helpers.c                               |   98 +-
 kernel/bpf/local_storage.c                         |    6 +-
 kernel/bpf/lpm_trie.c                              |    6 +-
 kernel/bpf/queue_stack_maps.c                      |   22 +-
 kernel/bpf/reuseport_array.c                       |    2 +-
 kernel/bpf/ringbuf.c                               |    6 +-
 kernel/bpf/stackmap.c                              |    6 +-
 kernel/bpf/syscall.c                               |   28 +-
 kernel/bpf/verifier.c                              |  714 +++++++++++---
 kernel/dma/swiotlb.c                               |   16 +-
 kernel/events/core.c                               |    4 +-
 kernel/kcsan/core.c                                |   17 +-
 kernel/kheaders.c                                  |   10 +-
 kernel/module/decompress.c                         |    2 +-
 kernel/power/hibernate.c                           |   15 +-
 kernel/power/power.h                               |    1 +
 kernel/power/swap.c                                |    8 +-
 kernel/rcu/tree.c                                  |    1 +
 kernel/relay.c                                     |    3 +-
 kernel/sched/deadline.c                            |    1 +
 kernel/sched/fair.c                                |    2 +-
 kernel/sched/rt.c                                  |    4 +
 kernel/time/posix-cpu-timers.c                     |   81 +-
 kernel/time/posix-timers.c                         |    4 +
 kernel/time/tick-common.c                          |   12 +-
 kernel/time/tick-sched.c                           |   16 +-
 kernel/time/timekeeping.c                          |    4 +-
 kernel/trace/ring_buffer.c                         |   20 +-
 kernel/trace/trace.c                               |    2 +-
 kernel/trace/trace_events_user.c                   |    3 +
 kernel/workqueue.c                                 |   10 +-
 lib/debugobjects.c                                 |  146 +--
 lib/kunit/debugfs.c                                |   14 +-
 lib/kunit/test.c                                   |   21 +-
 mm/kasan/hw_tags.c                                 |    4 +-
 mm/mempolicy.c                                     |    4 +-
 mm/vmscan.c                                        |   10 +
 net/8021q/vlan_dev.c                               |    2 +-
 net/core/bpf_sk_storage.c                          |    6 +-
 net/core/skbuff.c                                  |    3 +
 net/core/sock_map.c                                |    8 +-
 net/dccp/ipv6.c                                    |    1 +
 net/ipv4/ip_output.c                               |   16 +-
 net/ipv6/ip6_input.c                               |   14 +-
 net/ipv6/raw.c                                     |    5 +-
 net/ipv6/tcp_ipv6.c                                |    2 +
 net/ipv6/udp.c                                     |    2 +
 net/netfilter/nf_conntrack_bpf.c                   |    1 +
 net/netfilter/nf_conntrack_core.c                  |    1 -
 net/netfilter/nf_conntrack_netlink.c               |   16 +-
 net/netfilter/nf_tables_api.c                      |    8 +-
 net/netfilter/nfnetlink.c                          |    2 -
 net/netlink/af_netlink.c                           |   75 +-
 net/packet/af_packet.c                             |   30 +-
 net/packet/diag.c                                  |    4 +-
 net/packet/internal.h                              |   26 +-
 net/rxrpc/key.c                                    |    2 +-
 net/sched/sch_fq.c                                 |    6 +-
 net/sunrpc/clnt.c                                  |    3 -
 net/sunrpc/sched.c                                 |    1 -
 net/xdp/xsk_queue.h                                |    1 +
 net/xdp/xskmap.c                                   |    8 +-
 scripts/gdb/linux/clk.py                           |    2 +
 scripts/gdb/linux/constants.py.in                  |    2 +
 scripts/gdb/linux/genpd.py                         |    4 +-
 scripts/gdb/linux/timerlist.py                     |    4 +-
 scripts/gdb/linux/utils.py                         |    5 +-
 scripts/gdb/vmlinux-gdb.py                         |    5 +-
 security/integrity/ima/Kconfig                     |    2 +-
 security/selinux/Makefile                          |    4 +-
 sound/pci/hda/patch_realtek.c                      |    5 +
 sound/soc/amd/ps/pci-ps.c                          |    2 -
 sound/soc/amd/yc/acp6x-mach.c                      |    7 +
 sound/soc/codecs/cs35l41.c                         |   34 +-
 sound/soc/codecs/da7213.c                          |    6 +
 sound/soc/codecs/es8316.c                          |   14 +-
 sound/soc/fsl/fsl_mqs.c                            |   15 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |   12 +
 sound/soc/intel/boards/sof_sdw.c                   |   11 +
 sound/soc/intel/common/soc-acpi-intel-adl-match.c  |   20 +
 sound/soc/soc-compress.c                           |    3 +
 sound/soc/soc-pcm.c                                |    4 +
 sound/usb/quirks-table.h                           |   58 ++
 tools/arch/x86/kcpuid/cpuid.csv                    |    4 +-
 tools/bpf/bpftool/json_writer.c                    |    3 -
 tools/bpf/bpftool/xlated_dumper.c                  |    7 +
 tools/include/uapi/linux/bpf.h                     |   11 +
 tools/lib/bpf/gen_loader.c                         |   10 +-
 tools/objtool/check.c                              |   11 -
 tools/perf/util/auxtrace.c                         |    5 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |    2 +
 tools/testing/selftests/bpf/network_helpers.c      |    2 +-
 tools/testing/selftests/bpf/prog_tests/align.c     |    4 +-
 .../selftests/bpf/prog_tests/cg_storage_multi.c    |    8 +-
 .../bpf/prog_tests/get_stackid_cannot_attach.c     |    1 +
 .../testing/selftests/bpf/prog_tests/linked_list.c |   14 +-
 .../selftests/bpf/prog_tests/perf_event_stackmap.c |    3 +-
 .../bpf/prog_tests/stacktrace_build_id_nmi.c       |   15 -
 tools/testing/selftests/bpf/progs/linked_list.c    |    2 +-
 .../testing/selftests/bpf/progs/linked_list_fail.c |  100 +-
 tools/testing/selftests/bpf/test_xsk.sh            |    1 +
 tools/testing/selftests/bpf/testing_helpers.c      |   20 +
 tools/testing/selftests/bpf/testing_helpers.h      |    2 +
 tools/testing/selftests/bpf/xskxceiver.c           |   19 +-
 tools/testing/selftests/bpf/xskxceiver.h           |    1 -
 .../selftests/mount_setattr/mount_setattr_test.c   |    1 +
 .../mmcra_thresh_marked_sample_test.c              |    4 +-
 tools/testing/selftests/resctrl/cache.c            |    4 +-
 tools/testing/selftests/resctrl/cat_test.c         |    2 +-
 tools/testing/selftests/resctrl/cmt_test.c         |    2 +-
 tools/testing/selftests/resctrl/fill_buf.c         |    2 +
 tools/testing/selftests/resctrl/mba_test.c         |    9 +-
 tools/testing/selftests/resctrl/mbm_test.c         |    2 +-
 tools/testing/selftests/resctrl/resctrl.h          |    2 +
 tools/testing/selftests/resctrl/resctrl_val.c      |   21 +-
 .../selftests/tc-testing/tc-tests/qdiscs/fq.json   |   22 +
 tools/testing/selftests/user_events/ftrace_test.c  |    5 +
 tools/verification/rv/src/rv.c                     |    2 +-
 804 files changed, 9115 insertions(+), 7189 deletions(-)


