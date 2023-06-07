Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71CB726ED2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbjFGUw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjFGUw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:52:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE0FE4;
        Wed,  7 Jun 2023 13:52:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0B176477F;
        Wed,  7 Jun 2023 20:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A54C433D2;
        Wed,  7 Jun 2023 20:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171172;
        bh=E963SUZ4RcwXp/FvCpjGCGchNNFHRwG84HL2yOH8F1E=;
        h=From:To:Cc:Subject:Date:From;
        b=HPLXJyF/0fg0F71X0lrRkLu5JAzX3BoBdQ6cdZ3GhQ+C6KfRAOSao7/spgfH+p9IS
         D9iumpBjCC3w1wqVgdx5RG+NTzFb++hX+2PeVZElX05YnjRhGisVKjFaDIPh8xnS3X
         l+I2RQD48Z2CioIw0YQCbHiKkDjEYVqm+Goe8ia4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.4 00/99] 5.4.246-rc1 review
Date:   Wed,  7 Jun 2023 22:15:52 +0200
Message-ID: <20230607200900.195572674@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.246-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.246-rc1
X-KernelTest-Deadline: 2023-06-09T20:09+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.4.246 release.
There are 99 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.246-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.246-rc1

Linus Torvalds <torvalds@linux-foundation.org>
    drm/edid: fix objtool warning in drm_cvt_modes()

Ping-Ke Shih <pkshih@realtek.com>
    wifi: rtlwifi: 8192de: correct checking of IQK reload

Lyude Paul <lyude@redhat.com>
    drm/edid: Fix uninitialized variable in drm_cvt_modes()

Selvin Xavier <selvin.xavier@broadcom.com>
    RDMA/bnxt_re: Remove the qp from list only if the qp destroy succeeds

YueHaibing <yuehaibing@huawei.com>
    RDMA/bnxt_re: Remove set but not used variable 'dev_attr'

Ben Hutchings <benh@debian.org>
    scsi: dpt_i2o: Do not process completions with invalid addresses

Ben Hutchings <benh@debian.org>
    scsi: dpt_i2o: Remove broken pass-through ioctl (I2OUSERCMD)

Jim Wylder <jwylder@google.com>
    regmap: Account for register length when chunking

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: fix the memory leak of the allocated firmware buffer

Helge Deller <deller@gmx.de>
    fbcon: Fix null-ptr-deref in soft_cursor

Theodore Ts'o <tytso@mit.edu>
    ext4: add lockdep annotations for i_data_sem for ea_inode's

Theodore Ts'o <tytso@mit.edu>
    ext4: disallow ea_inodes with extended attributes

Theodore Ts'o <tytso@mit.edu>
    ext4: set lockdep subclass for the ea_inode in ext4_xattr_inode_cache_find()

Theodore Ts'o <tytso@mit.edu>
    ext4: add EA_INODE checking to ext4_iget()

Pietro Borrello <borrello@diag.uniroma1.it>
    tracing/probe: trace_probe_primary_from_call(): checked list_first_entry

Paul Moore <paul@paul-moore.com>
    selinux: don't use make's grouped targets feature yet

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: use UARTCTRL_TXINV to send break instead of UARTCTRL_SBK

Deren Wu <deren.wu@mediatek.com>
    mmc: vub300: fix invalid response handling

Jakub Kicinski <kuba@kernel.org>
    wifi: rtlwifi: remove always-true condition pointed out by GCC 12

Nathan Chancellor <natechancellor@gmail.com>
    lib/dynamic_debug.c: use address-of operator on section symbols

Kees Cook <keescook@chromium.org>
    treewide: Remove uninitialized_var() usage

Nathan Chancellor <natechancellor@gmail.com>
    kernel/extable.c: use address-of operator on section symbols

Martin Liška <mliska@suse.cz>
    eth: sun: cassini: remove dead code

Linus Torvalds <torvalds@linux-foundation.org>
    gcc-12: disable '-Wdangling-pointer' warning for now

Adam Borowski <kilobyte@angband.pl>
    ACPI: thermal: drop an always true check

Kees Cook <keescook@chromium.org>
    x86/boot: Wrap literal addresses in absolute_pointer()

Arnd Bergmann <arnd@arndb.de>
    flow_dissector: work around stack frame size warning

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-scsi: Use correct device no in ata_find_dev()

Bart Van Assche <bvanassche@acm.org>
    scsi: stex: Fix gcc 13 warnings

Richard Acayan <mailingradian@gmail.com>
    misc: fastrpc: reject new invocations during device removal

Richard Acayan <mailingradian@gmail.com>
    misc: fastrpc: return -EPIPE to invocations on device removal

Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
    usb: gadget: f_fs: Add unbind event before functionfs_unbind

Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
    net: usb: qmi_wwan: Set DTR quirk for BroadMobi BM818

Lukas Bulwahn <lukas.bulwahn@gmail.com>
    iio: dac: build ad5758 driver when AD5758 is selected

Marek Vasut <marex@denx.de>
    iio: dac: mcp4725: Fix i2c_master_send() return value handling

Frank Li <Frank.Li@nxp.com>
    iio: light: vcnl4035: fixed chip ID check

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    HID: wacom: avoid integer overflow in wacom_intuos_inout()

Sung-Chi Li <lschyi@chromium.org>
    HID: google: add jewel USB id

Jiakai Luo <jkluo@hust.edu.cn>
    iio: adc: mxs-lradc: fix the order of two cleanup operations

Dan Carpenter <dan.carpenter@linaro.org>
    mailbox: mailbox-test: fix a locking issue in mbox_test_message_write()

Arnd Bergmann <arnd@arndb.de>
    atm: hide unused procfs functions

Arnd Bergmann <arnd@arndb.de>
    ALSA: oss: avoid missing-prototype warnings

Tom Rix <trix@redhat.com>
    netfilter: conntrack: define variables exp_nat_nla_policy and any_addr with CONFIG_NF_NAT

Arnd Bergmann <arnd@arndb.de>
    wifi: b43: fix incorrect __packed annotation

Wenchao Hao <haowenchao2@huawei.com>
    scsi: core: Decrease scsi_device's iorequest_cnt if dispatch failed

Min-Hua Chen <minhuadotchen@gmail.com>
    arm64/mm: mark private VM_FAULT_X defines as vm_fault_t

Dario Binacchi <dario.binacchi@amarulasolutions.com>
    ARM: dts: stm32: add pin map for CAN controller on stm32f7

Yun Lu <luyun@kylinos.cn>
    wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value

Hyunwoo Kim <v4bel@theori.io>
    media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221

Takashi Iwai <tiwai@suse.de>
    media: dvb-core: Fix kernel WARNING for blocking operation in wait_event*()

Hyunwoo Kim <imv4bel@gmail.com>
    media: dvb-core: Fix use-after-free due on race condition at dvb_net

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    media: mn88443x: fix !CONFIG_OF error by drop of_match_ptr from ID table

Hyunwoo Kim <imv4bel@gmail.com>
    media: ttusb-dec: fix memory leak in ttusb_dec_exit_dvb()

YongSu Yoo <yongsuyoo0215@gmail.com>
    media: dvb_ca_en50221: fix a size write bug

Wei Chen <harperchen1110@gmail.com>
    media: netup_unidvb: fix irq init by register it at the end of probe

Wei Chen <harperchen1110@gmail.com>
    media: dvb-usb: dw2102: fix uninit-value in su3000_read_mac_address

Wei Chen <harperchen1110@gmail.com>
    media: dvb-usb: digitv: fix null-ptr-deref in digitv_i2c_xfer()

Zhang Shurong <zhang_shurong@foxmail.com>
    media: dvb-usb-v2: rtl28xxu: fix null-ptr-deref in rtl28xxu_i2c_xfer

Wei Chen <harperchen1110@gmail.com>
    media: dvb-usb-v2: ce6230: fix null-ptr-deref in ce6230_i2c_master_xfer()

Wei Chen <harperchen1110@gmail.com>
    media: dvb-usb-v2: ec168: fix null-ptr-deref in ec168_i2c_xfer()

Wei Chen <harperchen1110@gmail.com>
    media: dvb-usb: az6027: fix three null-ptr-deref in az6027_i2c_xfer()

YongSu Yoo <yongsuyoo0215@gmail.com>
    media: dvb_demux: fix a bug for the continuity counter

Paweł Anikiel <pan@semihalf.com>
    ASoC: ssm2602: Add workaround for playback distortions

Benedict Wong <benedictwong@google.com>
    xfrm: Check if_id in inbound policy/secpath match

Maxim Kochetkov <fido_max@inbox.ru>
    ASoC: dwc: limit the number of overrun messages

Ivan Orlov <ivan.orlov0322@gmail.com>
    nbd: Fix debugfs_create_dir error checking

Helge Deller <deller@gmx.de>
    fbdev: stifb: Fix info entry in sti_struct on error path

Helge Deller <deller@gmx.de>
    fbdev: modedb: Add 1920x1080 at 60 Hz video mode

Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
    media: rcar-vin: Select correct interrupt mode for V4L2_FIELD_ALTERNATE

Haibo Li <haibo.li@mediatek.com>
    ARM: 9295/1: unwind:fix unwind abort for uleb128 case

Lee Jones <lee@kernel.org>
    mailbox: mailbox-test: Fix potential double-free in mbox_test_message_write()

Johannes Thumshirn <jth@kernel.org>
    watchdog: menz069_wdt: fix watchdog initialisation

Chris Packham <chris.packham@alliedtelesis.co.nz>
    mtd: rawnand: marvell: don't set the NAND frequency select

Chris Packham <chris.packham@alliedtelesis.co.nz>
    mtd: rawnand: marvell: ensure timing values are written

Andreas Svensson <andreas.svensson@axis.com>
    net: dsa: mv88e6xxx: Increase wait after reset deactivation

Hangyu Hua <hbh25y@gmail.com>
    net/sched: flower: fix possible OOB write in fl_set_geneve_opt()

Vladislav Efanov <VEfanov@ispras.ru>
    udp6: Fix race condition in udp6_sendmsg & connect

Pedro Tammela <pctammela@mojatatu.com>
    net/netlink: fix NETLINK_LIST_MEMBERSHIPS length report

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    ocfs2/dlm: move BITS_TO_BYTES() to bitops.h for wider use

Zhengchao Shao <shaozhengchao@huawei.com>
    net: sched: fix NULL pointer dereference in mq_attach

Peilin Ye <peilin.ye@bytedance.com>
    net/sched: Prohibit regrafting ingress or clsact Qdiscs

Peilin Ye <peilin.ye@bytedance.com>
    net/sched: Reserve TC_H_INGRESS (TC_H_CLSACT) for ingress (clsact) Qdiscs

Peilin Ye <peilin.ye@bytedance.com>
    net/sched: sch_clsact: Only create under TC_H_CLSACT

Peilin Ye <peilin.ye@bytedance.com>
    net/sched: sch_ingress: Only create under TC_H_INGRESS

Cambda Zhu <cambda@linux.alibaba.com>
    tcp: Return user_mss for TCP_MAXSEG in CLOSE/LISTEN state if user_mss set

Eric Dumazet <edumazet@google.com>
    tcp: deny tcp_disconnect() when threads are waiting

Eric Dumazet <edumazet@google.com>
    af_packet: do not use READ_ONCE() in packet_bind()

Arnd Bergmann <arnd@arndb.de>
    mtd: rawnand: ingenic: fix empty stub helper definitions

Raju Rangoju <Raju.Rangoju@amd.com>
    amd-xgbe: fix the false linkup in xgbe_phy_status

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_packet: Fix data-races of pkt_sk(sk)->num.

Eric Dumazet <edumazet@google.com>
    netrom: fix info-leak in nr_write_internal()

Shay Drory <shayd@nvidia.com>
    net/mlx5: fw_tracer, Fix event handling

Randy Dunlap <rdunlap@infradead.org>
    dmaengine: pl330: rename _start to prevent build error

Joao Martins <joao.m.martins@oracle.com>
    iommu/amd: Don't block updates to GATag if guest mode is on

Chao Wang <D202280639@hust.edu.cn>
    iommu/rockchip: Fix unwind goto issue

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Fix return value of bnxt_re_process_raw_qp_pkt_rx

Devesh Sharma <devesh.sharma@broadcom.com>
    RDMA/bnxt_re: Refactor queue pair creation code

Devesh Sharma <devesh.sharma@broadcom.com>
    RDMA/bnxt_re: Enable SRIOV VF support on Broadcom's 57500 adapter series

Yonatan Nachum <ynachum@amazon.com>
    RDMA/efa: Fix unsupported page sizes in device


-------------

Diffstat:

 Makefile                                           |   8 +-
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi             |  82 +++
 arch/arm/kernel/unwind.c                           |  25 +-
 arch/arm/mach-sa1100/assabet.c                     |   2 +-
 arch/arm/mm/alignment.c                            |   2 +-
 arch/arm64/mm/fault.c                              |   4 +-
 arch/ia64/kernel/process.c                         |   2 +-
 arch/ia64/mm/discontig.c                           |   2 +-
 arch/ia64/mm/tlb.c                                 |   2 +-
 arch/mips/lib/dump_tlb.c                           |   2 +-
 arch/mips/mm/init.c                                |   2 +-
 arch/mips/mm/tlb-r4k.c                             |   6 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |   2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c          |   2 +-
 arch/s390/kernel/smp.c                             |   2 +-
 arch/x86/boot/boot.h                               |  36 +-
 arch/x86/boot/main.c                               |   2 +-
 arch/x86/kernel/quirks.c                           |  10 +-
 block/blk-merge.c                                  |   2 +-
 drivers/acpi/acpi_pad.c                            |   2 +-
 drivers/acpi/thermal.c                             |   2 -
 drivers/ata/libata-scsi.c                          |  36 +-
 drivers/atm/zatm.c                                 |   2 +-
 drivers/base/regmap/regmap.c                       |   6 +-
 drivers/block/drbd/drbd_nl.c                       |   6 +-
 drivers/block/nbd.c                                |   4 +-
 drivers/block/rbd.c                                |   2 +-
 drivers/clk/clk-gate.c                             |   2 +-
 drivers/dma/pl330.c                                |   8 +-
 drivers/firewire/ohci.c                            |  14 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |   2 +-
 drivers/gpu/drm/drm_edid.c                         |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |   6 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                |   2 +-
 drivers/gpu/drm/i915/intel_uncore.c                |   2 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |   4 +-
 drivers/hid/hid-google-hammer.c                    |   2 +
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/wacom_wac.c                            |   2 +-
 drivers/i2c/busses/i2c-rk3x.c                      |   2 +-
 drivers/ide/ide-acpi.c                             |   2 +-
 drivers/ide/ide-atapi.c                            |   2 +-
 drivers/ide/ide-io-std.c                           |   4 +-
 drivers/ide/ide-io.c                               |   8 +-
 drivers/ide/ide-sysfs.c                            |   2 +-
 drivers/ide/umc8672.c                              |   2 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |  10 +-
 drivers/iio/dac/Makefile                           |   2 +-
 drivers/iio/dac/mcp4725.c                          |  16 +-
 drivers/iio/light/vcnl4035.c                       |   3 +
 drivers/infiniband/core/uverbs_cmd.c               |   4 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |  14 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           | 663 ++++++++++++++-------
 drivers/infiniband/hw/bnxt_re/main.c               | 136 +++--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |   5 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |   2 +-
 drivers/infiniband/hw/cxgb4/cq.c                   |   2 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   2 +-
 drivers/infiniband/hw/mlx4/qp.c                    |   6 +-
 drivers/infiniband/hw/mlx5/cq.c                    |   6 +-
 drivers/infiniband/hw/mlx5/devx.c                  |   2 +-
 drivers/infiniband/hw/mthca/mthca_qp.c             |  10 +-
 drivers/input/serio/serio_raw.c                    |   2 +-
 drivers/iommu/amd_iommu.c                          |   3 +-
 drivers/iommu/rockchip-iommu.c                     |  14 +-
 drivers/mailbox/mailbox-test.c                     |  13 +-
 drivers/md/dm-io.c                                 |   2 +-
 drivers/md/dm-ioctl.c                              |   2 +-
 drivers/md/dm-snap-persistent.c                    |   2 +-
 drivers/md/dm-table.c                              |   2 +-
 drivers/md/raid5.c                                 |   2 +-
 drivers/media/dvb-core/dvb_ca_en50221.c            |  49 +-
 drivers/media/dvb-core/dvb_demux.c                 |   4 +-
 drivers/media/dvb-core/dvb_frontend.c              |  16 +-
 drivers/media/dvb-core/dvb_net.c                   |  38 +-
 drivers/media/dvb-frontends/mn88443x.c             |   2 +-
 drivers/media/dvb-frontends/rtl2832.c              |   2 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c |  17 +-
 drivers/media/platform/rcar-vin/rcar-dma.c         |   1 +
 drivers/media/tuners/qt1010.c                      |   4 +-
 drivers/media/usb/dvb-usb-v2/ce6230.c              |   8 +
 drivers/media/usb/dvb-usb-v2/ec168.c               |  12 +
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c            |  20 +
 drivers/media/usb/dvb-usb/az6027.c                 |  12 +
 drivers/media/usb/dvb-usb/digitv.c                 |   4 +
 drivers/media/usb/dvb-usb/dw2102.c                 |   2 +-
 drivers/media/usb/gspca/vicam.c                    |   2 +-
 drivers/media/usb/ttusb-dec/ttusb_dec.c            |   3 +-
 drivers/media/usb/uvc/uvc_video.c                  |   8 +-
 drivers/memstick/host/jmb38x_ms.c                  |   2 +-
 drivers/memstick/host/tifm_ms.c                    |   2 +-
 drivers/misc/fastrpc.c                             |   7 +-
 drivers/mmc/host/sdhci.c                           |   2 +-
 drivers/mmc/host/vub300.c                          |   3 +
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h         |   8 +-
 drivers/mtd/nand/raw/marvell_nand.c                |  10 +-
 drivers/mtd/nand/raw/nand_ecc.c                    |   2 +-
 drivers/mtd/nand/raw/s3c2410.c                     |   2 +-
 drivers/mtd/parsers/afs.c                          |   4 +-
 drivers/mtd/ubi/eba.c                              |   2 +-
 drivers/net/can/janz-ican3.c                       |   2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  12 +-
 drivers/net/ethernet/broadcom/bnx2.c               |   4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h   |   1 -
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   2 +-
 .../net/ethernet/mellanox/mlx5/core/pagealloc.c    |   4 +-
 drivers/net/ethernet/neterion/s2io.c               |   2 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |   2 +-
 drivers/net/ethernet/sun/cassini.c                 |   6 +-
 drivers/net/ethernet/sun/niu.c                     |   6 +-
 drivers/net/usb/qmi_wwan.c                         |   2 +-
 drivers/net/wan/z85230.c                           |   2 +-
 drivers/net/wireless/ath/ath10k/core.c             |   2 +-
 drivers/net/wireless/ath/ath6kl/init.c             |   2 +-
 drivers/net/wireless/ath/ath9k/init.c              |   2 +-
 drivers/net/wireless/broadcom/b43/b43.h            |   2 +-
 drivers/net/wireless/broadcom/b43/debugfs.c        |   2 +-
 drivers/net/wireless/broadcom/b43/dma.c            |   2 +-
 drivers/net/wireless/broadcom/b43/lo.c             |   2 +-
 drivers/net/wireless/broadcom/b43/phy_n.c          |   2 +-
 drivers/net/wireless/broadcom/b43/xmit.c           |  12 +-
 .../net/wireless/broadcom/b43legacy/b43legacy.h    |   2 +-
 drivers/net/wireless/broadcom/b43legacy/debugfs.c  |   2 +-
 drivers/net/wireless/broadcom/b43legacy/main.c     |   2 +-
 drivers/net/wireless/intel/iwlegacy/3945.c         |   2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |   2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   4 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    |   4 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |  10 +-
 drivers/pci/pcie/aer.c                             |   2 +-
 drivers/platform/x86/hdaps.c                       |   4 +-
 drivers/scsi/Kconfig                               |   2 +-
 drivers/scsi/dc395x.c                              |   2 +-
 drivers/scsi/dpt_i2o.c                             | 278 +--------
 drivers/scsi/dpti.h                                |   1 -
 drivers/scsi/pm8001/pm8001_hwi.c                   |   2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c                   |   2 +-
 drivers/scsi/scsi_lib.c                            |   2 +
 drivers/scsi/stex.c                                |   4 +
 drivers/ssb/driver_chipcommon.c                    |   4 +-
 drivers/tty/cyclades.c                             |   2 +-
 drivers/tty/isicom.c                               |   2 +-
 drivers/tty/serial/fsl_lpuart.c                    |  44 +-
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 drivers/usb/musb/cppi_dma.c                        |   2 +-
 drivers/usb/storage/sddr55.c                       |   4 +-
 drivers/vhost/net.c                                |   4 +-
 drivers/video/fbdev/core/bitblit.c                 |   3 +
 drivers/video/fbdev/core/modedb.c                  |   5 +
 drivers/video/fbdev/matrox/matroxfb_maven.c        |   6 +-
 drivers/video/fbdev/pm3fb.c                        |   6 +-
 drivers/video/fbdev/riva/riva_hw.c                 |   3 +-
 drivers/video/fbdev/stifb.c                        |   1 +
 drivers/virtio/virtio_ring.c                       |   6 +-
 drivers/watchdog/menz69_wdt.c                      |  16 +-
 fs/afs/dir.c                                       |   2 +-
 fs/afs/security.c                                  |   2 +-
 fs/dlm/netlink.c                                   |   2 +-
 fs/ext4/ext4.h                                     |   5 +-
 fs/ext4/inode.c                                    |  34 +-
 fs/ext4/xattr.c                                    |  41 +-
 fs/fat/dir.c                                       |   2 +-
 fs/fuse/control.c                                  |   4 +-
 fs/fuse/cuse.c                                     |   2 +-
 fs/fuse/file.c                                     |   2 +-
 fs/gfs2/aops.c                                     |   2 +-
 fs/gfs2/bmap.c                                     |   2 +-
 fs/gfs2/lops.c                                     |   2 +-
 fs/hfsplus/unicode.c                               |   2 +-
 fs/isofs/namei.c                                   |   4 +-
 fs/jffs2/erase.c                                   |   2 +-
 fs/nfsd/nfsctl.c                                   |   2 +-
 fs/ocfs2/alloc.c                                   |   4 +-
 fs/ocfs2/dir.c                                     |  14 +-
 fs/ocfs2/dlm/dlmcommon.h                           |   4 -
 fs/ocfs2/extent_map.c                              |   4 +-
 fs/ocfs2/namei.c                                   |   2 +-
 fs/ocfs2/refcounttree.c                            |   2 +-
 fs/ocfs2/xattr.c                                   |   2 +-
 fs/omfs/file.c                                     |   2 +-
 fs/overlayfs/copy_up.c                             |   2 +-
 fs/ubifs/commit.c                                  |   6 +-
 fs/ubifs/dir.c                                     |   2 +-
 fs/ubifs/file.c                                    |   4 +-
 fs/ubifs/journal.c                                 |   4 +-
 fs/ubifs/lpt.c                                     |   2 +-
 fs/ubifs/tnc.c                                     |   6 +-
 fs/ubifs/tnc_misc.c                                |   4 +-
 fs/udf/balloc.c                                    |   2 +-
 fs/xfs/xfs_bmap_util.c                             |   2 +-
 include/linux/bitops.h                             |   1 +
 include/media/dvb_net.h                            |   4 +
 include/net/sock.h                                 |   4 +
 kernel/async.c                                     |   4 +-
 kernel/audit.c                                     |   2 +-
 kernel/dma/debug.c                                 |   2 +-
 kernel/events/core.c                               |   2 +-
 kernel/events/uprobes.c                            |   2 +-
 kernel/exit.c                                      |   2 +-
 kernel/extable.c                                   |   3 +-
 kernel/futex.c                                     |  12 +-
 kernel/locking/lockdep.c                           |  14 +-
 kernel/trace/ring_buffer.c                         |   2 +-
 kernel/trace/trace_probe.h                         |   2 +-
 lib/dynamic_debug.c                                |   2 +-
 lib/radix-tree.c                                   |   2 +-
 lib/test_firmware.c                                |  19 +-
 mm/frontswap.c                                     |   2 +-
 mm/ksm.c                                           |   2 +-
 mm/memcontrol.c                                    |   2 +-
 mm/mempolicy.c                                     |   4 +-
 mm/percpu.c                                        |   2 +-
 mm/slub.c                                          |   4 +-
 mm/swap.c                                          |   4 +-
 net/atm/resources.c                                |   2 +
 net/core/sock.c                                    |   2 +-
 net/dccp/options.c                                 |   2 +-
 net/ipv4/af_inet.c                                 |   2 +
 net/ipv4/inet_connection_sock.c                    |   1 +
 net/ipv4/netfilter/nf_socket_ipv4.c                |   6 +-
 net/ipv4/tcp.c                                     |   9 +-
 net/ipv6/ip6_flowlabel.c                           |   2 +-
 net/ipv6/netfilter/nf_socket_ipv6.c                |   2 +-
 net/netfilter/nf_conntrack_ftp.c                   |   2 +-
 net/netfilter/nf_conntrack_netlink.c               |   4 +
 net/netfilter/nfnetlink_log.c                      |   2 +-
 net/netfilter/nfnetlink_queue.c                    |   4 +-
 net/netlink/af_netlink.c                           |   2 +-
 net/netrom/nr_subr.c                               |   7 +-
 net/packet/af_packet.c                             |   8 +-
 net/packet/diag.c                                  |   2 +-
 net/sched/cls_flow.c                               |   2 +-
 net/sched/cls_flower.c                             |  22 +-
 net/sched/sch_api.c                                |  16 +-
 net/sched/sch_cake.c                               |   2 +-
 net/sched/sch_cbq.c                                |   2 +-
 net/sched/sch_fq_codel.c                           |   2 +-
 net/sched/sch_hfsc.c                               |   2 +-
 net/sched/sch_htb.c                                |   2 +-
 net/sched/sch_ingress.c                            |  16 +-
 net/sched/sch_sfq.c                                |   2 +-
 net/sunrpc/xprtsock.c                              |   4 +-
 net/tls/tls_sw.c                                   |   2 +-
 net/xfrm/xfrm_policy.c                             |  11 +-
 security/selinux/Makefile                          |   6 +-
 sound/core/control_compat.c                        |   2 +-
 sound/core/oss/pcm_plugin.h                        |  16 +-
 sound/isa/sb/sb16_csp.c                            |   2 +-
 sound/soc/codecs/ssm2602.c                         |  15 +
 sound/soc/dwc/dwc-i2s.c                            |   4 +-
 sound/usb/endpoint.c                               |   2 +-
 253 files changed, 1441 insertions(+), 1041 deletions(-)


