Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20D2726F54
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbjFGU5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbjFGU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB071FE2;
        Wed,  7 Jun 2023 13:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DA976486F;
        Wed,  7 Jun 2023 20:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03B4C433D2;
        Wed,  7 Jun 2023 20:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171445;
        bh=k+mJaJvP4BjFqlZUXRX0sP/xGtwGHXPpRTH7i4WhaFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=2BgAoA2iqWnpEg1hHsrGs2bZjYG4MUEiSx1VygOelSUe3UAKIc3XNK3751ZUd+7J6
         bhCxJpj0ccMZ8HQdZkxdCtsPnsk7Gwvc4hbos3PnTUGzfRCFTBrOnLnBCLIMOcyNpG
         yT9tXkpV36/JLRQJxMDv505i0gs5fqOKBn10TwCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.15 000/159] 5.15.116-rc1 review
Date:   Wed,  7 Jun 2023 22:15:03 +0200
Message-ID: <20230607200903.652580797@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.116-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.116-rc1
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

This is the start of the stable review cycle for the 5.15.116 release.
There are 159 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.116-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.116-rc1

Mustafa Ismail <mustafa.ismail@intel.com>
    RDMA/irdma: Do not generate SW completions for NOPs

Shiraz Saleem <shiraz.saleem@intel.com>
    RDMA/irdma: Fix drain SQ hang with no completion

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

Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
    drm/amdgpu/gfx10: Disable gfxoff before disabling powergating.

Ben Hutchings <benh@debian.org>
    scsi: dpt_i2o: Do not process completions with invalid addresses

Ben Hutchings <benh@debian.org>
    scsi: dpt_i2o: Remove broken pass-through ioctl (I2OUSERCMD)

Arnd Bergmann <arnd@arndb.de>
    drm/rcar: stop using 'imply' for dependencies

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm_tis: Request threaded interrupt handler

Jim Wylder <jwylder@google.com>
    regmap: Account for register length when chunking

Roberto Sassu <roberto.sassu@huawei.com>
    KEYS: asymmetric: Copy sig and digest in public_key_verify_signature()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix incorrect AllocationSize set in smb2_get_info

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix credit count leakage

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
    selftests: mptcp: sockopt: skip if MPTCP is not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: pm nl: skip if MPTCP is not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: connect: skip if MPTCP is not supported

Pietro Borrello <borrello@diag.uniroma1.it>
    tracing/probe: trace_probe_primary_from_call(): checked list_first_entry

Paul Moore <paul@paul-moore.com>
    selinux: don't use make's grouped targets feature yet

Damien Le Moal <dlemoal@kernel.org>
    block: fix revalidate performance regression

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fix NCM gadget RX speed 20x slow than expection at iMX8QM

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: allocate TX FIFO size according to composite EP number

Jon Pan-Doh <pandoh@google.com>
    iommu/amd: Fix domain flush size when syncing iotlb

Gaurav Batra <gbatra@linux.vnet.ibm.com>
    powerpc/iommu: Limit number of TCEs to 512 for H_STUFF_TCE hcall

pengfuyuan <pengfuyuan@kylinos.cn>
    btrfs: fix csum_tree_block page iteration to avoid tripping on -Werror=array-bounds

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: use UARTCTRL_TXINV to send break instead of UARTCTRL_SBK

Marek Vasut <marex@denx.de>
    mmc: pwrseq: sd8787: Fix WILC CHIP_EN and RESETN toggling order

Deren Wu <deren.wu@mediatek.com>
    mmc: vub300: fix invalid response handling

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    block/blk-iocost (gcc13): keep large values in a new enum

Kees Cook <keescook@chromium.org>
    ath6kl: Use struct_group() to avoid size-mismatched casting

Kees Cook <keescook@chromium.org>
    x86/boot: Wrap literal addresses in absolute_pointer()

Tim Huang <Tim.Huang@amd.com>
    drm/amd/pm: reverse mclk and fclk clocks levels for renoir

Tim Huang <Tim.Huang@amd.com>
    drm/amd/pm: reverse mclk and fclk clocks levels for yellow carp

Tim Huang <Tim.Huang@amd.com>
    drm/amd/pm: reverse mclk and fclk clocks levels for vangogh

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-scsi: Use correct device no in ata_find_dev()

Bart Van Assche <bvanassche@acm.org>
    scsi: stex: Fix gcc 13 warnings

Richard Acayan <mailingradian@gmail.com>
    misc: fastrpc: reject new invocations during device removal

Richard Acayan <mailingradian@gmail.com>
    misc: fastrpc: return -EPIPE to invocations on device removal

Yu Kuai <yukuai3@huawei.com>
    md/raid5: fix miscalculation of 'end_sector' in raid5_read_one_chunk()

Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
    usb: gadget: f_fs: Add unbind event before functionfs_unbind

Marek Vasut <marex@denx.de>
    dt-bindings: usb: snps,dwc3: Fix "snps,hsphy_interface" type

Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
    net: usb: qmi_wwan: Set DTR quirk for BroadMobi BM818

Lukas Bulwahn <lukas.bulwahn@gmail.com>
    iio: dac: build ad5758 driver when AD5758 is selected

Paul Cercueil <paul@crapouillou.net>
    iio: adc: ad7192: Change "shorted" channels to differential

Marek Vasut <marex@denx.de>
    iio: dac: mcp4725: Fix i2c_master_send() return value handling

Masahiro Honda <honda@mechatrax.com>
    iio: adc: ad_sigma_delta: Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag

Frank Li <Frank.Li@nxp.com>
    iio: light: vcnl4035: fixed chip ID check

Geert Uytterhoeven <geert+renesas@glider.be>
    dt-bindings: iio: adc: renesas,rcar-gyroadc: Fix adi,ad7476 compatible value

Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
    iio: imu: inv_icm42600: fix timestamp reset

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    HID: wacom: avoid integer overflow in wacom_intuos_inout()

Sung-Chi Li <lschyi@chromium.org>
    HID: google: add jewel USB id

Jiakai Luo <jkluo@hust.edu.cn>
    iio: adc: mxs-lradc: fix the order of two cleanup operations

Hans de Goede <hdegoede@redhat.com>
    iio: accel: st_accel: Fix invalid mount_matrix on devices without ACPI _ONT method

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: uvcvideo: Don't expose unsupported formats to userspace

Dan Carpenter <dan.carpenter@linaro.org>
    mailbox: mailbox-test: fix a locking issue in mbox_test_message_write()

Daniel Smith <dansmith@ds.gy>
    nvme-pci: Add quirk for Teamgroup MP33 SSD

Guchun Chen <guchun.chen@amd.com>
    drm/amdgpu: skip disabling fence driver src_irqs when device is unplugged

Arnd Bergmann <arnd@arndb.de>
    atm: hide unused procfs functions

Rob Clark <robdclark@chromium.org>
    drm/msm: Be more shouty if per-process pgtables aren't working

Arnd Bergmann <arnd@arndb.de>
    ALSA: oss: avoid missing-prototype warnings

Christoph Hellwig <hch@lst.de>
    nvme-multipath: don't call blk_mark_disk_dead in nvme_mpath_remove_disk

Tom Rix <trix@redhat.com>
    netfilter: conntrack: define variables exp_nat_nla_policy and any_addr with CONFIG_NF_NAT

Arnd Bergmann <arnd@arndb.de>
    wifi: b43: fix incorrect __packed annotation

Wenchao Hao <haowenchao2@huawei.com>
    scsi: core: Decrease scsi_device's iorequest_cnt if dispatch failed

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: simplify chanctx allocation

Linus Walleij <linus.walleij@linaro.org>
    arm64: vdso: Pass (void *) to virt_to_page()

Min-Hua Chen <minhuadotchen@gmail.com>
    arm64/mm: mark private VM_FAULT_X defines as vm_fault_t

Dario Binacchi <dario.binacchi@amarulasolutions.com>
    ARM: dts: stm32: add pin map for CAN controller on stm32f7

Yun Lu <luyun@kylinos.cn>
    wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value

Rubén Gómez <mrgommer@proton.me>
    ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P

Alexander Gordeev <agordeev@linux.ibm.com>
    s390/topology: honour nr_cpu_ids when adding CPUs

Holger Dengler <dengler@linux.ibm.com>
    s390/pkey: zeroize key blobs

Hyunwoo Kim <v4bel@theori.io>
    media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221

Takashi Iwai <tiwai@suse.de>
    media: dvb-core: Fix kernel WARNING for blocking operation in wait_event*()

Hyunwoo Kim <imv4bel@gmail.com>
    media: dvb-core: Fix use-after-free due to race at dvb_register_device()

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

Johannes Berg <johannes.berg@intel.com>
    um: harddog: fix modular build

Maxim Kochetkov <fido_max@inbox.ru>
    ASoC: dwc: limit the number of overrun messages

Hristo Venev <hristo@venev.name>
    nvme-pci: add quirk for missing secondary temperature thresholds

Sagi Grimberg <sagi@grimberg.me>
    nvme-pci: add NVME_QUIRK_BOGUS_NID for HS-SSD-FUTURE 2048G

Guoqing Jiang <guoqing.jiang@linux.dev>
    block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE

Ivan Orlov <ivan.orlov0322@gmail.com>
    nbd: Fix debugfs_create_dir error checking

Helge Deller <deller@gmx.de>
    fbdev: stifb: Fix info entry in sti_struct on error path

Helge Deller <deller@gmx.de>
    fbdev: modedb: Add 1920x1080 at 60 Hz video mode

Zheng Wang <zyytlz.wz@163.com>
    fbdev: imsttfb: Fix use after free bug in imsttfb_probe

Bob Peterson <rpeterso@redhat.com>
    gfs2: Don't deref jdesc in evict

Julian Winkler <julian.winkler1@web.de>
    platform/x86: intel_scu_pcidrv: Add back PCI ID for Medfield

Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
    media: rcar-vin: Select correct interrupt mode for V4L2_FIELD_ALTERNATE

Haibo Li <haibo.li@mediatek.com>
    ARM: 9295/1: unwind:fix unwind abort for uleb128 case

Filipe Manana <fdmanana@suse.com>
    btrfs: abort transaction when sibling keys check fails for leaves

Jammy Huang <jammy_huang@aspeedtech.com>
    drm/ast: Fix ARM compatibility

Lee Jones <lee@kernel.org>
    mailbox: mailbox-test: Fix potential double-free in mbox_test_message_write()

lyndonli <Lyndon.Li@amd.com>
    drm/amdgpu: Use the default reset when loading or reloading the driver

jasontao <jasontao@glenfly.com>
    ALSA: hda: Glenfly: add HD Audio PCI IDs and HDMI Codec Vendor IDs.

Johannes Thumshirn <jth@kernel.org>
    watchdog: menz069_wdt: fix watchdog initialisation

Chong Li <chongli2@amd.com>
    drm/amdgpu: release gpu full access after "amdgpu_device_ip_late_init"

Xin Long <lucien.xin@gmail.com>
    rtnetlink: call validate_linkmsg in rtnl_create_link

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

Saeed Mahameed <saeedm@nvidia.com>
    net/mlx5e: Fix error handling in mlx5e_refresh_tirs

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

Mustafa Ismail <mustafa.ismail@intel.com>
    RDMA/irdma: Fix Local Invalidate fencing

Mustafa Ismail <mustafa.ismail@intel.com>
    RDMA/irdma: Prevent QP use after free

Mustafa Ismail <mustafa.ismail@intel.com>
    RDMA/irdma: Add SW mechanism to generate completions on error

Arnd Bergmann <arnd@arndb.de>
    mtd: rawnand: ingenic: fix empty stub helper definitions

Raju Rangoju <Raju.Rangoju@amd.com>
    amd-xgbe: fix the false linkup in xgbe_phy_status

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_packet: Fix data-races of pkt_sk(sk)->num.

Eric Dumazet <edumazet@google.com>
    netrom: fix info-leak in nr_write_internal()

Thomas Bogendoerfer <tbogendoerfer@suse.de>
    net: mellanox: mlxbf_gige: Fix skb_panic splat under memory pressure

Dmytro Linkin <dlinkin@nvidia.com>
    net/mlx5e: Don't attach netdev profile while handling internal error

Shay Drory <shayd@nvidia.com>
    net/mlx5: fw_tracer, Fix event handling

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Fix unused variable warning when BUILTIN_DTB is set

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

Yangyang Li <liyangyang20@huawei.com>
    RDMA/hns: Modify the value of long message loopback slice

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix base address table allocation

Yonatan Nachum <ynachum@amazon.com>
    RDMA/efa: Fix unsupported page sizes in device

Selvin Xavier <selvin.xavier@broadcom.com>
    RDMA/bnxt_re: Fix the page_size used during the MR creation


-------------

Diffstat:

 .../bindings/iio/adc/renesas,rcar-gyroadc.yaml     |   2 +-
 .../devicetree/bindings/sound/tas2562.yaml         |   6 +-
 .../devicetree/bindings/sound/tas2764.yaml         |   6 +-
 .../devicetree/bindings/sound/tas2770.yaml         |   6 +-
 .../devicetree/bindings/usb/snps,dwc3.yaml         |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi             |  82 ++++++
 arch/arm/configs/multi_v7_defconfig                |   1 -
 arch/arm/kernel/unwind.c                           |  25 +-
 arch/arm64/kernel/vdso.c                           |   2 +-
 arch/arm64/mm/fault.c                              |   4 +-
 arch/powerpc/platforms/pseries/iommu.c             |  13 +-
 arch/riscv/mm/init.c                               |   2 +-
 arch/s390/kernel/topology.c                        |  32 +--
 arch/um/drivers/Makefile                           |   4 +-
 arch/um/drivers/harddog.h                          |   9 +
 arch/um/drivers/harddog_kern.c                     |   7 +-
 arch/um/drivers/harddog_user.c                     |   1 +
 arch/um/drivers/harddog_user_exp.c                 |   9 +
 arch/x86/boot/boot.h                               |  36 ++-
 arch/x86/boot/main.c                               |   2 +-
 arch/x86/kvm/x86.c                                 |   3 +
 block/blk-iocost.c                                 |   2 +
 block/blk-settings.c                               |   3 +-
 crypto/asymmetric_keys/public_key.c                |  38 +--
 drivers/acpi/resource.c                            |  12 +
 drivers/ata/libata-scsi.c                          |  34 ++-
 drivers/base/regmap/regmap.c                       |   6 +-
 drivers/block/nbd.c                                |   4 +-
 drivers/block/rnbd/rnbd-proto.h                    |   2 +-
 drivers/char/tpm/tpm_tis_core.c                    |   7 +-
 drivers/dma/at_xdmac.c                             |  26 +-
 drivers/dma/pl330.c                                |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  39 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   8 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  10 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |   5 +-
 drivers/gpu/drm/ast/ast_main.c                     |   9 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |   7 +-
 drivers/gpu/drm/rcar-du/Kconfig                    |  25 +-
 drivers/hid/hid-google-hammer.c                    |   2 +
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/wacom_wac.c                            |   2 +-
 drivers/iio/accel/st_accel_core.c                  |   4 +-
 drivers/iio/adc/ad7192.c                           |   8 +-
 drivers/iio/adc/ad_sigma_delta.c                   |   4 +
 drivers/iio/adc/mxs-lradc-adc.c                    |  10 +-
 drivers/iio/dac/Makefile                           |   2 +-
 drivers/iio/dac/mcp4725.c                          |  16 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  10 +-
 drivers/iio/light/vcnl4035.c                       |   3 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |   4 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  11 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |  12 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   7 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |   8 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |  43 ++++
 drivers/infiniband/hw/irdma/hw.c                   |  31 ++-
 drivers/infiniband/hw/irdma/utils.c                | 150 +++++++++++
 drivers/infiniband/hw/irdma/verbs.c                |  66 +++--
 drivers/infiniband/hw/irdma/verbs.h                |  13 +-
 drivers/iommu/amd/iommu.c                          |   5 +-
 drivers/iommu/rockchip-iommu.c                     |  14 +-
 drivers/mailbox/mailbox-test.c                     |  13 +-
 drivers/md/raid5.c                                 |   2 +-
 drivers/media/dvb-core/dvb_ca_en50221.c            |  49 +++-
 drivers/media/dvb-core/dvb_demux.c                 |   4 +-
 drivers/media/dvb-core/dvb_frontend.c              |  16 +-
 drivers/media/dvb-core/dvb_net.c                   |  38 ++-
 drivers/media/dvb-core/dvbdev.c                    |  84 +++++--
 drivers/media/dvb-frontends/mn88443x.c             |   2 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c |  17 +-
 drivers/media/platform/rcar-vin/rcar-dma.c         |   4 +-
 drivers/media/usb/dvb-usb-v2/ce6230.c              |   8 +
 drivers/media/usb/dvb-usb-v2/ec168.c               |  12 +
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c            |  20 ++
 drivers/media/usb/dvb-usb/az6027.c                 |  12 +
 drivers/media/usb/dvb-usb/digitv.c                 |   4 +
 drivers/media/usb/dvb-usb/dw2102.c                 |   2 +-
 drivers/media/usb/ttusb-dec/ttusb_dec.c            |   3 +-
 drivers/media/usb/uvc/uvc_driver.c                 |  16 +-
 drivers/misc/fastrpc.c                             |   7 +-
 drivers/mmc/core/pwrseq_sd8787.c                   |  34 ++-
 drivers/mmc/host/vub300.c                          |   3 +
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h         |   8 +-
 drivers/mtd/nand/raw/marvell_nand.c                |  10 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  12 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_common.c    |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  35 ++-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   2 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |  13 +-
 drivers/net/usb/qmi_wwan.c                         |   2 +-
 drivers/net/wireless/ath/ath6kl/htc.h              |  15 +-
 drivers/net/wireless/ath/ath6kl/htc_mbox.c         |  15 +-
 drivers/net/wireless/broadcom/b43/b43.h            |   2 +-
 .../net/wireless/broadcom/b43legacy/b43legacy.h    |   2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   4 +-
 drivers/nvme/host/hwmon.c                          |   4 +-
 drivers/nvme/host/multipath.c                      |   1 -
 drivers/nvme/host/nvme.h                           |   5 +
 drivers/nvme/host/pci.c                            |   6 +
 drivers/platform/x86/intel_scu_pcidrv.c            |   1 +
 drivers/s390/crypto/pkey_api.c                     |   3 +
 drivers/scsi/Kconfig                               |   2 +-
 drivers/scsi/dpt_i2o.c                             | 278 +--------------------
 drivers/scsi/dpti.h                                |   1 -
 drivers/scsi/scsi_lib.c                            |   2 +
 drivers/scsi/stex.c                                |   4 +
 drivers/tty/serial/8250/8250_tegra.c               |   4 +-
 drivers/tty/serial/fsl_lpuart.c                    |  44 ++--
 drivers/usb/cdns3/cdns3-gadget.c                   |  60 ++++-
 drivers/usb/cdns3/cdns3-gadget.h                   |   9 +-
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 drivers/video/fbdev/core/bitblit.c                 |   3 +
 drivers/video/fbdev/core/modedb.c                  |   5 +
 drivers/video/fbdev/imsttfb.c                      |  15 +-
 drivers/video/fbdev/stifb.c                        |   1 +
 drivers/watchdog/menz69_wdt.c                      |  16 +-
 fs/btrfs/ctree.c                                   |   2 +
 fs/btrfs/disk-io.c                                 |   2 +-
 fs/ext4/ext4.h                                     |   5 +-
 fs/ext4/inode.c                                    |  34 ++-
 fs/ext4/super.c                                    |  24 +-
 fs/ext4/xattr.c                                    |  41 +--
 fs/gfs2/super.c                                    |   8 +
 fs/ksmbd/smb2pdu.c                                 |  27 +-
 include/media/dvb_net.h                            |   4 +
 include/media/dvbdev.h                             |  15 ++
 include/net/sock.h                                 |   4 +
 kernel/trace/trace_probe.h                         |   2 +-
 lib/test_firmware.c                                |  19 +-
 net/atm/resources.c                                |   2 +
 net/core/rtnetlink.c                               |   8 +-
 net/core/sock.c                                    |   2 +-
 net/ipv4/af_inet.c                                 |   2 +
 net/ipv4/inet_connection_sock.c                    |   1 +
 net/ipv4/tcp.c                                     |   9 +-
 net/mac80211/chan.c                                |   2 +-
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
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   4 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |   4 +
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   4 +
 167 files changed, 1544 insertions(+), 779 deletions(-)


