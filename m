Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D59726E41
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjFGUtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjFGUsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:48:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FAA213F;
        Wed,  7 Jun 2023 13:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7E85646D6;
        Wed,  7 Jun 2023 20:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97478C4339E;
        Wed,  7 Jun 2023 20:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170906;
        bh=j+nHit9mMCLWEjPqkduJB8UfsAZNGoDnQoDc6IP29zs=;
        h=From:To:Cc:Subject:Date:From;
        b=aVVYgy1xqmSte0egyhkvmcZ+z5vT6RHxIGhtUYFGt6Ge0FeZ2ImEt/fZqjv20Y03P
         e64x7gW12ex9MD5MJ8PRoQnkLvjvfxDyB0QpTjZIe1c3GrvJUVD1n7k7gOLCxetSVM
         17XLOcr9cLqXKsG2EZmvMDN53vcgYSiquVHBs3dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.10 000/120] 5.10.183-rc1 review
Date:   Wed,  7 Jun 2023 22:15:16 +0200
Message-ID: <20230607200900.915613242@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.183-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.183-rc1
X-KernelTest-Deadline: 2023-06-09T20:09+00:00
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

This is the start of the stable review cycle for the 5.10.183 release.
There are 120 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.183-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.183-rc1

Arnd Bergmann <arnd@arndb.de>
    ARM: defconfig: drop CONFIG_DRM_RCAR_LVDS

Theodore Ts'o <tytso@mit.edu>
    ext4: enable the lazy init thread when remounting read/write

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: skip if MPTCP is not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: simult flows: skip if MPTCP is not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: diag: skip if MPTCP is not supported

Sean Christopherson <seanjc@google.com>
    crypto: ccp: Play nice with vmalloc'd memory for SEV command structs

Sean Christopherson <seanjc@google.com>
    crypto: ccp: Reject SEV commands with mismatching command buffer

Ben Hutchings <benh@debian.org>
    scsi: dpt_i2o: Do not process completions with invalid addresses

Ben Hutchings <benh@debian.org>
    scsi: dpt_i2o: Remove broken pass-through ioctl (I2OUSERCMD)

Arnd Bergmann <arnd@arndb.de>
    drm/rcar: stop using 'imply' for dependencies

Arnd Bergmann <arnd@arndb.de>
    media: ti-vpe: cal: avoid FIELD_GET assertion

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm_tis: Request threaded interrupt handler

Jim Wylder <jwylder@google.com>
    regmap: Account for register length when chunking

Roberto Sassu <roberto.sassu@huawei.com>
    KEYS: asymmetric: Copy sig and digest in public_key_verify_signature()

Sean Christopherson <seanjc@google.com>
    KVM: x86: Account fastpath-only VM-Exits in vCPU stats

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: fix the memory leak of the allocated firmware buffer

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    serial: 8250_tegra: Fix an error handling path in tegra_uart_probe()

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

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: pm nl: skip if MPTCP is not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: connect: skip if MPTCP is not supported

Pietro Borrello <borrello@diag.uniroma1.it>
    tracing/probe: trace_probe_primary_from_call(): checked list_first_entry

Paul Moore <paul@paul-moore.com>
    selinux: don't use make's grouped targets feature yet

pengfuyuan <pengfuyuan@kylinos.cn>
    btrfs: fix csum_tree_block page iteration to avoid tripping on -Werror=array-bounds

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: use UARTCTRL_TXINV to send break instead of UARTCTRL_SBK

Deren Wu <deren.wu@mediatek.com>
    mmc: vub300: fix invalid response handling

Martin Liška <mliska@suse.cz>
    eth: sun: cassini: remove dead code

Linus Torvalds <torvalds@linux-foundation.org>
    gcc-12: disable '-Wdangling-pointer' warning for now

Kees Cook <keescook@chromium.org>
    ath6kl: Use struct_group() to avoid size-mismatched casting

Adam Borowski <kilobyte@angband.pl>
    ACPI: thermal: drop an always true check

Kees Cook <keescook@chromium.org>
    x86/boot: Wrap literal addresses in absolute_pointer()

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

Paul Cercueil <paul@crapouillou.net>
    iio: adc: ad7192: Change "shorted" channels to differential

Marek Vasut <marex@denx.de>
    iio: dac: mcp4725: Fix i2c_master_send() return value handling

Frank Li <Frank.Li@nxp.com>
    iio: light: vcnl4035: fixed chip ID check

Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
    iio: imu: inv_icm42600: fix timestamp reset

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

Rob Clark <robdclark@chromium.org>
    drm/msm: Be more shouty if per-process pgtables aren't working

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

Holger Dengler <dengler@linux.ibm.com>
    s390/pkey: zeroize key blobs

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

Martin Povišer <povik+lin@cutebit.org>
    ASoC: dt-bindings: Adjust #sound-dai-cells on TI's single-DAI codecs

Benedict Wong <benedictwong@google.com>
    xfrm: Check if_id in inbound policy/secpath match

Maxim Kochetkov <fido_max@inbox.ru>
    ASoC: dwc: limit the number of overrun messages

Guoqing Jiang <guoqing.jiang@linux.dev>
    block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE

Ivan Orlov <ivan.orlov0322@gmail.com>
    nbd: Fix debugfs_create_dir error checking

Helge Deller <deller@gmx.de>
    fbdev: stifb: Fix info entry in sti_struct on error path

Helge Deller <deller@gmx.de>
    fbdev: modedb: Add 1920x1080 at 60 Hz video mode

Bob Peterson <rpeterso@redhat.com>
    gfs2: Don't deref jdesc in evict

Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
    media: rcar-vin: Select correct interrupt mode for V4L2_FIELD_ALTERNATE

Haibo Li <haibo.li@mediatek.com>
    ARM: 9295/1: unwind:fix unwind abort for uleb128 case

Filipe Manana <fdmanana@suse.com>
    btrfs: abort transaction when sibling keys check fails for leaves

Lee Jones <lee@kernel.org>
    mailbox: mailbox-test: Fix potential double-free in mbox_test_message_write()

jasontao <jasontao@glenfly.com>
    ALSA: hda: Glenfly: add HD Audio PCI IDs and HDMI Codec Vendor IDs.

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

Moshe Shemesh <moshe@nvidia.com>
    net/mlx5: Read embedded cpu after init bit cleared

Vladislav Efanov <VEfanov@ispras.ru>
    udp6: Fix race condition in udp6_sendmsg & connect

Pedro Tammela <pctammela@mojatatu.com>
    net/netlink: fix NETLINK_LIST_MEMBERSHIPS length report

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

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Fix a possible memory leak

Dan Carpenter <dan.carpenter@linaro.org>
    dmaengine: at_xdmac: fix potential Oops in at_xdmac_prep_interleaved()

Tudor Ambarus <tudor.ambarus@microchip.com>
    dmaengine: at_xdmac: Move the free desc to the tail of the desc list

Tudor Ambarus <tudor.ambarus@microchip.com>
    dmaengine: at_xdmac: Fix race for the tx desc callback

Tudor Ambarus <tudor.ambarus@microchip.com>
    dmaengine: at_xdmac: Fix concurrency over chan's completed_cookie

Yonatan Nachum <ynachum@amazon.com>
    RDMA/efa: Fix unsupported page sizes in device

Selvin Xavier <selvin.xavier@broadcom.com>
    RDMA/bnxt_re: Fix the page_size used during the MR creation

Selvin Xavier <selvin.xavier@broadcom.com>
    RDMA/bnxt_re: Code refactor while populating user MRs


-------------

Diffstat:

 .../devicetree/bindings/sound/tas2562.yaml         |   6 +-
 .../devicetree/bindings/sound/tas2764.yaml         |   6 +-
 .../devicetree/bindings/sound/tas2770.yaml         |   6 +-
 Makefile                                           |   8 +-
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi             |  82 ++++++
 arch/arm/configs/multi_v7_defconfig                |   1 -
 arch/arm/kernel/unwind.c                           |  25 +-
 arch/arm64/mm/fault.c                              |   4 +-
 arch/x86/boot/boot.h                               |  36 ++-
 arch/x86/boot/main.c                               |   2 +-
 arch/x86/kvm/x86.c                                 |   3 +
 crypto/asymmetric_keys/public_key.c                |  38 +--
 drivers/acpi/thermal.c                             |   2 -
 drivers/ata/libata-scsi.c                          |  34 ++-
 drivers/base/regmap/regmap.c                       |   6 +-
 drivers/block/nbd.c                                |   4 +-
 drivers/block/rnbd/rnbd-proto.h                    |   2 +-
 drivers/char/tpm/tpm_tis_core.c                    |   7 +-
 drivers/crypto/ccp/sev-dev.c                       |  35 ++-
 drivers/crypto/ccp/sev-dev.h                       |   2 +
 drivers/dma/at_xdmac.c                             |  50 ++--
 drivers/dma/pl330.c                                |   8 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |   7 +-
 drivers/gpu/drm/rcar-du/Kconfig                    |  25 +-
 drivers/hid/hid-google-hammer.c                    |   2 +
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/wacom_wac.c                            |   2 +-
 drivers/iio/adc/ad7192.c                           |   8 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |  10 +-
 drivers/iio/dac/Makefile                           |   2 +-
 drivers/iio/dac/mcp4725.c                          |  16 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  10 +-
 drivers/iio/light/vcnl4035.c                       |   3 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  45 +---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  11 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |  12 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |  22 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |   2 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   2 +-
 drivers/iommu/amd/iommu.c                          |   3 +-
 drivers/iommu/rockchip-iommu.c                     |  14 +-
 drivers/mailbox/mailbox-test.c                     |  13 +-
 drivers/media/dvb-core/dvb_ca_en50221.c            |  49 +++-
 drivers/media/dvb-core/dvb_demux.c                 |   4 +-
 drivers/media/dvb-core/dvb_frontend.c              |  16 +-
 drivers/media/dvb-core/dvb_net.c                   |  38 ++-
 drivers/media/dvb-frontends/mn88443x.c             |   2 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c |  17 +-
 drivers/media/platform/rcar-vin/rcar-dma.c         |   4 +-
 drivers/media/platform/ti-vpe/cal.h                |   2 +-
 drivers/media/usb/dvb-usb-v2/ce6230.c              |   8 +
 drivers/media/usb/dvb-usb-v2/ec168.c               |  12 +
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c            |  20 ++
 drivers/media/usb/dvb-usb/az6027.c                 |  12 +
 drivers/media/usb/dvb-usb/digitv.c                 |   4 +
 drivers/media/usb/dvb-usb/dw2102.c                 |   2 +-
 drivers/media/usb/ttusb-dec/ttusb_dec.c            |   3 +-
 drivers/misc/fastrpc.c                             |   7 +-
 drivers/mmc/host/vub300.c                          |   3 +
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h         |   8 +-
 drivers/mtd/nand/raw/marvell_nand.c                |  10 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  12 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   2 +-
 drivers/net/ethernet/sun/cassini.c                 |   4 +-
 drivers/net/usb/qmi_wwan.c                         |   2 +-
 drivers/net/wireless/ath/ath6kl/htc.h              |  15 +-
 drivers/net/wireless/ath/ath6kl/htc_mbox.c         |  15 +-
 drivers/net/wireless/broadcom/b43/b43.h            |   2 +-
 .../net/wireless/broadcom/b43legacy/b43legacy.h    |   2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   4 +-
 drivers/s390/crypto/pkey_api.c                     |   3 +
 drivers/scsi/Kconfig                               |   2 +-
 drivers/scsi/dpt_i2o.c                             | 278 +--------------------
 drivers/scsi/dpti.h                                |   1 -
 drivers/scsi/scsi_lib.c                            |   2 +
 drivers/scsi/stex.c                                |   4 +
 drivers/tty/serial/8250/8250_tegra.c               |   4 +-
 drivers/tty/serial/fsl_lpuart.c                    |  44 ++--
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 drivers/video/fbdev/core/bitblit.c                 |   3 +
 drivers/video/fbdev/core/modedb.c                  |   5 +
 drivers/video/fbdev/stifb.c                        |   1 +
 drivers/watchdog/menz69_wdt.c                      |  16 +-
 fs/btrfs/ctree.c                                   |   2 +
 fs/btrfs/disk-io.c                                 |   2 +-
 fs/ext4/ext4.h                                     |   5 +-
 fs/ext4/inode.c                                    |  34 ++-
 fs/ext4/super.c                                    |  24 +-
 fs/ext4/xattr.c                                    |  41 +--
 fs/gfs2/super.c                                    |   8 +
 include/media/dvb_net.h                            |   4 +
 include/net/sock.h                                 |   4 +
 kernel/trace/trace_probe.h                         |   2 +-
 lib/test_firmware.c                                |  19 +-
 net/atm/resources.c                                |   2 +
 net/core/sock.c                                    |   2 +-
 net/ipv4/af_inet.c                                 |   2 +
 net/ipv4/inet_connection_sock.c                    |   1 +
 net/ipv4/tcp.c                                     |   9 +-
 net/netfilter/nf_conntrack_netlink.c               |   4 +
 net/netlink/af_netlink.c                           |   2 +-
 net/netrom/nr_subr.c                               |   7 +-
 net/packet/af_packet.c                             |   8 +-
 net/packet/diag.c                                  |   2 +-
 net/sched/cls_flower.c                             |   3 +
 net/sched/sch_api.c                                |  16 +-
 net/sched/sch_ingress.c                            |  16 +-
 net/xfrm/xfrm_policy.c                             |  11 +-
 security/selinux/Makefile                          |   6 +-
 sound/core/oss/pcm_plugin.h                        |  16 +-
 sound/pci/hda/hda_intel.c                          |  21 ++
 sound/pci/hda/patch_hdmi.c                         |  22 ++
 sound/soc/codecs/ssm2602.c                         |  15 ++
 sound/soc/dwc/dwc-i2s.c                            |   4 +-
 tools/testing/selftests/net/mptcp/Makefile         |   2 +-
 tools/testing/selftests/net/mptcp/diag.sh          |   4 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   4 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   4 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  40 +++
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |   4 +
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   4 +
 124 files changed, 949 insertions(+), 653 deletions(-)


