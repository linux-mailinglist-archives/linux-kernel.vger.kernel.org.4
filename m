Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFEE726B1C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjFGUWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjFGUWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:22:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43492689;
        Wed,  7 Jun 2023 13:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95090618C2;
        Wed,  7 Jun 2023 20:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFD6C433EF;
        Wed,  7 Jun 2023 20:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169327;
        bh=VEAIB4vS4//HH1ZY4hwflFYJn72ALk47enxwxHnRBJk=;
        h=From:To:Cc:Subject:Date:From;
        b=SnksGHqCUy0gYfXfkRwA10tFJORGpPdxloN7/T4Uy7Q1LCFmaWv0YRqC0HztOXTCK
         PJ/DEiLcAnsXUzBA8wBvZqxu3q1dNtKYjlkVkV9jysS0VBgyD6ElnXYRycdRUWlKoA
         DAcs5bD5yP/ns8AR0/nB/uInBVB7iMELh30f1SuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 6.3 000/286] 6.3.7-rc1 review
Date:   Wed,  7 Jun 2023 22:11:39 +0200
Message-ID: <20230607200922.978677727@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.3.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.3.7-rc1
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

This is the start of the stable review cycle for the 6.3.7 release.
There are 286 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.7-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.3.7-rc1

Theodore Ts'o <tytso@mit.edu>
    ext4: enable the lazy init thread when remounting read/write

Nathan Chancellor <nathan@kernel.org>
    riscv: vmlinux.lds.S: Explicitly handle '.got' section

Darrick J. Wong <djwong@kernel.org>
    xfs: verify buffer contents when we skip log replay

Vasant Hegde <vasant.hegde@amd.com>
    iommu/amd/pgtbl_v2: Fix domain max address

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm_tis: Request threaded interrupt handler

Jim Wylder <jwylder@google.com>
    regmap: Account for register length when chunking

Roberto Sassu <roberto.sassu@huawei.com>
    KEYS: asymmetric: Copy sig and digest in public_key_verify_signature()

Kuan-Ting Chen <h3xrabbit@gmail.com>
    ksmbd: fix multiple out-of-bounds read during context decoding

Kuan-Ting Chen <h3xrabbit@gmail.com>
    ksmbd: fix slab-out-of-bounds read in smb2_handle_negotiate

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix incorrect AllocationSize set in smb2_get_info

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix UAF issue from opinfo->conn

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix credit count leakage

Sean Christopherson <seanjc@google.com>
    KVM: x86: Bail from kvm_recalculate_phys_map() if x2APIC ID is out-of-bounds

Sean Christopherson <seanjc@google.com>
    KVM: x86: Account fastpath-only VM-Exits in vCPU stats

Sean Christopherson <seanjc@google.com>
    KVM: x86/mmu: Grab memslot for correct address space in NX recovery worker

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: Drop last page ref in kvm_pgtable_stage2_free_removed()

Akihiko Odaki <akihiko.odaki@daynix.com>
    KVM: arm64: Populate fault info for watchpoint

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: fix the memory leak of the allocated firmware buffer

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: fix a memory leak with reqs buffer

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: prevent race conditions by a correct implementation of locking

Maninder Singh <maninder1.s@samsung.com>
    powerpc/xmon: Use KSYM_NAME_LEN in array size

Herve Codina <herve.codina@bootlin.com>
    serial: cpm_uart: Fix a COMPILE_TEST dependency

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

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix active subflow finalization

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix connect timeout handling

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: userspace pm: skip if MPTCP is not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: sockopt: skip if MPTCP is not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: simult flows: skip if MPTCP is not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: diag: skip if MPTCP is not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: avoid using 'cmp --bytes'

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: skip if MPTCP is not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: pm nl: skip if MPTCP is not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: connect: skip if MPTCP is not supported

Pietro Borrello <borrello@diag.uniroma1.it>
    tracing/probe: trace_probe_primary_from_call(): checked list_first_entry

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing/histograms: Allow variables to have some modifiers

Daniel Bristot de Oliveira <bristot@kernel.org>
    tracing/timerlat: Always wakeup the timerlat thread

Arnd Bergmann <arnd@arndb.de>
    mtdchar: mark bits of ioctl handler noinline

Paul Moore <paul@paul-moore.com>
    selinux: don't use make's grouped targets feature yet

Ben Noordhuis <info@bnoordhuis.nl>
    io_uring: undeprecate epoll_ctl support

Ism Hong <ism.hong@gmail.com>
    riscv: perf: Fix callchain parse error with kernel tracepoint events

Peter Rosin <peda@axentia.se>
    dmaengine: at_hdmac: Extend the Flow Controller bitfield to three bits

Peter Rosin <peda@axentia.se>
    dmaengine: at_hdmac: Repair bitfield macros for peripheral ID handling

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    HID: hidpp: terminate retry loop on success

Sasha Levin <sashal@kernel.org>
    btrfs: call btrfs_orig_bbio_end_io in btrfs_end_bio_work

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Pass proper scm arguments for secure map request

Elliot Berman <quic_eberman@quicinc.com>
    firmware: qcom_scm: Use fixed width src vm bitmap

Lucas De Marchi <lucas.demarchi@intel.com>
    module/decompress: Fix error checking on zstd decompression

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm_tis: correct tpm_tis_flags enumeration values

Jon Pan-Doh <pandoh@google.com>
    iommu/amd: Fix domain flush size when syncing iotlb

Gaurav Batra <gbatra@linux.vnet.ibm.com>
    powerpc/iommu: Limit number of TCEs to 512 for H_STUFF_TCE hcall

Damien Le Moal <dlemoal@kernel.org>
    block: fix revalidate performance regression

Johan Hovold <johan+linaro@kernel.org>
    phy: qcom-qmp-pcie-msm8996: fix init-count imbalance

Johan Hovold <johan+linaro@kernel.org>
    phy: qcom-qmp-combo: fix init-count imbalance

pengfuyuan <pengfuyuan@kylinos.cn>
    btrfs: fix csum_tree_block page iteration to avoid tripping on -Werror=array-bounds

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: use UARTCTRL_TXINV to send break instead of UARTCTRL_SBK

Marek Vasut <marex@denx.de>
    mmc: pwrseq: sd8787: Fix WILC CHIP_EN and RESETN toggling order

Deren Wu <deren.wu@mediatek.com>
    mmc: vub300: fix invalid response handling

Tim Huang <Tim.Huang@amd.com>
    drm/amd/pm: reverse mclk and fclk clocks levels for renoir

Tim Huang <Tim.Huang@amd.com>
    drm/amd/pm: reverse mclk and fclk clocks levels for yellow carp

Tim Huang <Tim.Huang@amd.com>
    drm/amd/pm: reverse mclk clocks levels for SMU v13.0.5

Guchun Chen <guchun.chen@amd.com>
    drm/amd/pm: resolve reboot exception for si oland

Tim Huang <Tim.Huang@amd.com>
    drm/amd/pm: reverse mclk and fclk clocks levels for vangogh

Tim Huang <Tim.Huang@amd.com>
    drm/amd/pm: reverse mclk and fclk clocks levels for SMU v13.0.4

Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>
    drm/amdgpu: enable tmz by default for GC 11.0.1

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-scsi: Use correct device no in ata_find_dev()

Bart Van Assche <bvanassche@acm.org>
    scsi: stex: Fix gcc 13 warnings

Richard Acayan <mailingradian@gmail.com>
    misc: fastrpc: reject new invocations during device removal

Richard Acayan <mailingradian@gmail.com>
    misc: fastrpc: return -EPIPE to invocations on device removal

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Reassign memory ownership only for remote heap

Yu Kuai <yukuai3@huawei.com>
    md/raid5: fix miscalculation of 'end_sector' in raid5_read_one_chunk()

Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
    usb: gadget: f_fs: Add unbind event before functionfs_unbind

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fix NCM gadget RX speed 20x slow than expection at iMX8QM

Marek Vasut <marex@denx.de>
    dt-bindings: usb: snps,dwc3: Fix "snps,hsphy_interface" type

Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
    net: usb: qmi_wwan: Set DTR quirk for BroadMobi BM818

Lukas Bulwahn <lukas.bulwahn@gmail.com>
    iio: dac: build ad5758 driver when AD5758 is selected

Sean Nyekjaer <sean@geanix.com>
    iio: adc: stm32-adc: skip adc-diff-channels setup if none is present

Paul Cercueil <paul@crapouillou.net>
    iio: adc: ad7192: Change "shorted" channels to differential

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    iio: addac: ad74413: fix resistance input processing

Marek Vasut <marex@denx.de>
    iio: dac: mcp4725: Fix i2c_master_send() return value handling

Masahiro Honda <honda@mechatrax.com>
    iio: adc: ad_sigma_delta: Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag

Sean Nyekjaer <sean@geanix.com>
    iio: adc: stm32-adc: skip adc-channels setup if none is present

Matti Vaittinen <mazziesaccount@gmail.com>
    iio: accel: kx022a fix irq getting

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

ChiaEn Wu <chiaen_wu@richtek.com>
    iio: adc: mt6370: Fix ibus and ibat scaling value of some specific vendor ID chips

Lars-Peter Clausen <lars@metafoo.de>
    iio: ad4130: Make sure clock provider gets removed

Lars-Peter Clausen <lars@metafoo.de>
    iio: tmag5273: Fix runtime PM leak on measurement error

Jiakai Luo <jkluo@hust.edu.cn>
    iio: adc: mxs-lradc: fix the order of two cleanup operations

Hans de Goede <hdegoede@redhat.com>
    iio: accel: st_accel: Fix invalid mount_matrix on devices without ACPI _ONT method

Aric Cyr <aric.cyr@amd.com>
    drm/amd/display: Only wait for blank completion if OTG active

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    selftests/ftrace: Choose target function for filter test from samples

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: uvcvideo: Don't expose unsupported formats to userspace

Francesco Dolcini <francesco.dolcini@toradex.com>
    dt-bindings: serial: 8250_omap: add rs485-rts-active-high

K Prateek Nayak <kprateek.nayak@amd.com>
    drivers: base: cacheinfo: Update cpu_map_populated during CPU Hotplug

K Prateek Nayak <kprateek.nayak@amd.com>
    drivers: base: cacheinfo: Fix shared_cpu_map changes in event of CPU hotplug

Dan Carpenter <dan.carpenter@linaro.org>
    mailbox: mailbox-test: fix a locking issue in mbox_test_message_write()

Pin-yen Lin <treapking@chromium.org>
    media: mediatek: vcodec: Only apply 4K frame sizes on decoder formats

Fuad Tabba <tabba@google.com>
    KVM: arm64: Reload PTE after invoking walker callback on preorder traversal

Like Xu <likexu@tencent.com>
    perf/x86/intel: Save/restore cpuc->active_pebs_data_cfg when using guest PEBS

Gleb Chesnokov <gleb.chesnokov@scst.dev>
    scsi: qla2xxx: Fix NULL pointer dereference in target mode

Will Deacon <will@kernel.org>
    KVM: arm64: Prevent unconditional donation of unmapped regions from the host

Jean-Philippe Brucker <jean-philippe@linaro.org>
    KVM: arm64: vgic: Fix locking comment

Jean-Philippe Brucker <jean-philippe@linaro.org>
    KVM: arm64: vgic: Wrap vgic_its_create() with config_lock

Jean-Philippe Brucker <jean-philippe@linaro.org>
    KVM: arm64: vgic: Fix a circular locking issue

Dan Carpenter <error27@gmail.com>
    iio: adc: imx93: fix a signedness bug in imx93_adc_read_raw()

Loic Poulain <loic.poulain@linaro.org>
    block: Deny writable memory mapping if block is read-only

Daniel Smith <dansmith@ds.gy>
    nvme-pci: Add quirk for Teamgroup MP33 SSD

Ming Lei <ming.lei@redhat.com>
    ublk: fix AB-BA lockdep warning

Guchun Chen <guchun.chen@amd.com>
    drm/amdgpu: skip disabling fence driver src_irqs when device is unplugged

Xiubo Li <xiubli@redhat.com>
    ceph: silence smatch warning in reconnect_caps_cb()

Arnd Bergmann <arnd@arndb.de>
    atm: hide unused procfs functions

Rob Clark <robdclark@chromium.org>
    drm/msm: Be more shouty if per-process pgtables aren't working

Arnd Bergmann <arnd@arndb.de>
    ALSA: oss: avoid missing-prototype warnings

Maurizio Lombardi <mlombard@redhat.com>
    nvme: do not let the user delete a ctrl before a complete initialization

Christoph Hellwig <hch@lst.de>
    nvme-multipath: don't call blk_mark_disk_dead in nvme_mpath_remove_disk

Tom Rix <trix@redhat.com>
    netfilter: conntrack: define variables exp_nat_nla_policy and any_addr with CONFIG_NF_NAT

Kai-Heng Feng <kai.heng.feng@canonical.com>
    net: wwan: t7xx: Ensure init is completed before system sleep

Arnd Bergmann <arnd@arndb.de>
    wifi: b43: fix incorrect __packed annotation

Wenchao Hao <haowenchao2@huawei.com>
    scsi: core: Decrease scsi_device's iorequest_cnt if dispatch failed

Po-Wen Kao <powen.kao@mediatek.com>
    scsi: ufs: core: Fix MCQ nr_hw_queues

Po-Wen Kao <powen.kao@mediatek.com>
    scsi: ufs: core: Rename symbol sizeof_utp_transfer_cmd_desc()

Po-Wen Kao <powen.kao@mediatek.com>
    scsi: ufs: core: Fix MCQ tag calculation

Ariel Malamud <ariel.malamud@intel.com>
    wifi: iwlwifi: mvm: Add locking to the rate read flow

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: recalc chanctx mindef before assigning

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: consider reserved chanctx for mindef

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
    s390/ipl: fix IPIB virtual vs physical address confusion

Alexander Gordeev <agordeev@linux.ibm.com>
    s390/topology: honour nr_cpu_ids when adding CPUs

Holger Dengler <dengler@linux.ibm.com>
    s390/pkey: zeroize key blobs

Kai Vehmanen <kai.vehmanen@linux.intel.com>
    ASoC: SOF: pm: save io region state in case of errors in resume

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: SOF: sof-client-probes: fix pm_runtime imbalance in error handling

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: SOF: pcm: fix pm_runtime imbalance in error handling

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: SOF: debug: conditionally bump runtime_pm counter on exceptions

Hyunwoo Kim <v4bel@theori.io>
    media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221

Takashi Iwai <tiwai@suse.de>
    media: dvb-core: Fix kernel WARNING for blocking operation in wait_event*()

Hyunwoo Kim <imv4bel@gmail.com>
    media: dvb-core: Fix use-after-free due to race at dvb_register_device()

Hyunwoo Kim <imv4bel@gmail.com>
    media: dvb-core: Fix use-after-free due on race condition at dvb_net

Hyunwoo Kim <imv4bel@gmail.com>
    media: dvb-core: Fix use-after-free on race condition at dvb_frontend

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

Alexandru Sorodoc <ealex95@gmail.com>
    ALSA: hda/realtek: Add quirks for ASUS GU604V and GU603V

Martin Povišer <povik+lin@cutebit.org>
    ASoC: dt-bindings: Adjust #sound-dai-cells on TI's single-DAI codecs

Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
    ASoC: jz4740-i2s: Make I2S divider calculations more robust

Benedict Wong <benedictwong@google.com>
    xfrm: Check if_id in inbound policy/secpath match

Johannes Berg <johannes.berg@intel.com>
    um: harddog: fix modular build

V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
    ASoC: SOF: amd: Fix NULL pointer crash in acp_sof_ipc_msg_data function

Hao Zeng <zenghao@kylinos.cn>
    cpupower:Fix resource leaks in sysfs_get_enabled()

Maxim Kochetkov <fido_max@inbox.ru>
    ASoC: dwc: limit the number of overrun messages

Jeremy Soller <jeremy@system76.com>
    ASoC: amd: yc: Add DMI entry to support System76 Pangolin 12

Adrian Huang <ahuang12@lenovo.com>
    nvme-pci: clamp max_hw_sectors based on DMA optimized limitation

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

Yifan Zhang <yifan1.zhang@amd.com>
    drm/amdgpu: set gfx9 onwards APU atomics support to be true

Thong Thai <thong.thai@amd.com>
    drm/amdgpu/nv: update VCN 3 max HEVC encoding resolution

Bob Peterson <rpeterso@redhat.com>
    gfs2: Don't deref jdesc in evict

Liming Sun <limings@nvidia.com>
    platform/mellanox: fix potential race in mlxbf-tmfifo driver

Julian Winkler <julian.winkler1@web.de>
    platform/x86: intel_scu_pcidrv: Add back PCI ID for Medfield

Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
    media: rcar-vin: Select correct interrupt mode for V4L2_FIELD_ALTERNATE

Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
    media: rcar-vin: Fix NV12 size alignment

Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
    media: rcar-vin: Gen3 can not scale NV12

Mario Limonciello <mario.limonciello@amd.com>
    hwmon: (k10temp) Add PCI ID for family 19, model 78h

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/ds: Flush PEBS DS when changing PEBS_DATA_CFG

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

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: soc-acpi-cht: Add quirk for Nextbook Ares 8A tablet

Qing Zhang <zhangqing@loongson.cn>
    LoongArch: Add ARCH_HAS_FORTIFY_SOURCE selection

WANG Xuerui <git@xen0n.name>
    LoongArch: Relay BCE exceptions to userland as SIGSEGV with si_code=SEGV_BNDERR

Hersen Wu <hersenxs.wu@amd.com>
    drm/amd/display: fix memleak in aconnector->timing_requested

jasontao <jasontao@glenfly.com>
    ALSA: hda: Glenfly: add HD Audio PCI IDs and HDMI Codec Vendor IDs.

Johannes Thumshirn <jth@kernel.org>
    watchdog: menz069_wdt: fix watchdog initialisation

Chong Li <chongli2@amd.com>
    drm/amdgpu: release gpu full access after "amdgpu_device_ip_late_init"

Paolo Abeni <pabeni@redhat.com>
    mptcp: add annotations around sk->sk_shutdown accesses

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix data race around msk->first access

Paolo Abeni <pabeni@redhat.com>
    mptcp: consolidate passive msk socket initialization

Paolo Abeni <pabeni@redhat.com>
    mptcp: simplify subflow_syn_recv_sock()

Paolo Abeni <pabeni@redhat.com>
    mptcp: avoid unneeded address copy

Paolo Abeni <pabeni@redhat.com>
    mptcp: add annotations around msk->subflow accesses

Paolo Abeni <pabeni@redhat.com>
    mptcp: avoid unneeded __mptcp_nmpc_socket() usage

Xin Long <lucien.xin@gmail.com>
    rtnetlink: add the missing IFLA_GRO_ tb check in validate_linkmsg

Xin Long <lucien.xin@gmail.com>
    rtnetlink: move IFLA_GSO_ tb check to validate_linkmsg

Xin Long <lucien.xin@gmail.com>
    rtnetlink: call validate_linkmsg in rtnl_create_link

Maciej Fijalkowski <maciej.fijalkowski@intel.com>
    ice: recycle/free all of the fragments from multi-buffer frame

Xu Liang <lxu@maxlinear.com>
    net: phy: mxl-gpy: extend interrupt fix to all impacted variants

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    net: renesas: rswitch: Fix return value in error path of xmit

Chris Packham <chris.packham@alliedtelesis.co.nz>
    mtd: rawnand: marvell: don't set the NAND frequency select

Chris Packham <chris.packham@alliedtelesis.co.nz>
    mtd: rawnand: marvell: ensure timing values are written

Andreas Svensson <andreas.svensson@axis.com>
    net: dsa: mv88e6xxx: Increase wait after reset deactivation

Bert Karwatzki <spasswolf@web.de>
    net: ipa: Use correct value for IPA_STATUS_SIZE

fuyuanli <fuyuanli@didiglobal.com>
    tcp: fix mishandling when the sack compression is deferred.

Hangyu Hua <hbh25y@gmail.com>
    net/sched: flower: fix possible OOB write in fl_set_geneve_opt()

Chen-Yu Tsai <wenst@chromium.org>
    iommu/mediatek: Flush IOTLB completely only if domain has been attached

Edward Cree <ecree.xilinx@gmail.com>
    sfc: fix error unwinds in TC offload

Moshe Shemesh <moshe@nvidia.com>
    net/mlx5: Read embedded cpu after init bit cleared

Saeed Mahameed <saeedm@nvidia.com>
    net/mlx5e: Fix error handling in mlx5e_refresh_tirs

Christoph Hellwig <hch@lst.de>
    nvme: fix the name of Zone Append for verbose logging

Bastien Nocera <hadess@hadess.net>
    HID: logitech-hidpp: Handle timeout differently from busy

Dan Carpenter <dan.carpenter@linaro.org>
    nfsd: fix double fget() bug in __write_ports_addfd()

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

Wen Gu <guwen@linux.alibaba.com>
    net/smc: Don't use RMBs not mapped to new link in SMCRv2 ADD LINK

Wen Gu <guwen@linux.alibaba.com>
    net/smc: Scan from current RMB list when no position specified

David Howells <dhowells@redhat.com>
    rxrpc: Truncate UTS_RELEASE for rxrpc version

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

Akihiro Suda <suda.kyoto@gmail.com>
    efi: Bump stub image version for macOS HVF compatibility

Arnd Bergmann <arnd@arndb.de>
    mtd: rawnand: ingenic: fix empty stub helper definitions

Namhyung Kim <namhyung@kernel.org>
    perf ftrace latency: Remove unnecessary "--" from --use-nsec option

Raju Rangoju <Raju.Rangoju@amd.com>
    amd-xgbe: fix the false linkup in xgbe_phy_status

Jakub Kicinski <kuba@kernel.org>
    tls: improve lockless access safety of tls_err_abort()

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_packet: Fix data-races of pkt_sk(sk)->num.

Eric Dumazet <edumazet@google.com>
    netrom: fix info-leak in nr_write_internal()

Wei Fang <wei.fang@nxp.com>
    net: stmmac: fix call trace when stmmac_xdp_xmit() is invoked

Thomas Bogendoerfer <tbogendoerfer@suse.de>
    net: mellanox: mlxbf_gige: Fix skb_panic splat under memory pressure

Jianbo Liu <jianbol@nvidia.com>
    net/mlx5e: Move Ethernet driver debugfs to profile init callback

Dmytro Linkin <dlinkin@nvidia.com>
    net/mlx5e: Don't attach netdev profile while handling internal error

Vlad Buslov <vladbu@nvidia.com>
    net/mlx5: Fix post parse infra to only parse every action once

Paul Blakey <paulb@nvidia.com>
    net/mlx5e: TC, Remove CT action reordering

Paul Blakey <paulb@nvidia.com>
    net/mlx5e: CT: Use per action stats

Dragos Tatulea <dtatulea@nvidia.com>
    net/mlx5e: Use query_special_contexts cmd only once per mdev

Shay Drory <shayd@nvidia.com>
    net/mlx5: fw_tracer, Fix event handling

Shay Drory <shayd@nvidia.com>
    net/mlx5: SF, Drain health before removing device

Shay Drory <shayd@nvidia.com>
    net/mlx5: Drain health before unregistering devlink

Maher Sanalla <msanalla@nvidia.com>
    net/mlx5e: Do not update SBCM when prio2buffer command is invalid

Maher Sanalla <msanalla@nvidia.com>
    net/mlx5e: Consider internal buffers size in port buffer calculations

Chris Mi <cmi@nvidia.com>
    net/mlx5e: Prevent encap offload when neigh update is running

Chris Mi <cmi@nvidia.com>
    net/mlx5e: Extract remaining tunnel encap code to dedicated file

Paul Blakey <paulb@nvidia.com>
    net/mlx5e: TC, Move main flow attribute cleanup to helper func

Paul Blakey <paulb@nvidia.com>
    net/mlx5e: TC, Remove unused vf_tun variable

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Fix unused variable warning when BUILTIN_DTB is set

Ard Biesheuvel <ardb@kernel.org>
    crypto: x86/aria - Use 16 byte alignment for GFNI constant vectors

Randy Dunlap <rdunlap@infradead.org>
    dmaengine: pl330: rename _start to prevent build error

Jeff Layton <jlayton@kernel.org>
    nfsd: make a copy of struct iattr before calling notify_change

Jason Gunthorpe <jgg@ziepe.ca>
    iommu/amd: Add missing domain type checks

Jerry Snitselaar <jsnitsel@redhat.com>
    iommu/amd: Fix up merge conflict resolution

Joao Martins <joao.m.martins@oracle.com>
    iommu/amd: Handle GALog overflows

Joao Martins <joao.m.martins@oracle.com>
    iommu/amd: Don't block updates to GATag if guest mode is on

Chao Wang <D202280639@hust.edu.cn>
    iommu/rockchip: Fix unwind goto issue

Randy Dunlap <rdunlap@infradead.org>
    iommu: Make IPMMU_VMSA dependencies more strict

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Fix return value of bnxt_re_process_raw_qp_pkt_rx

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Fix a possible memory leak

Dan Carpenter <dan.carpenter@linaro.org>
    dmaengine: at_xdmac: fix potential Oops in at_xdmac_prep_interleaved()

Yangyang Li <liyangyang20@huawei.com>
    RDMA/hns: Modify the value of long message loopback slice

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix base address table allocation

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix timeout attr in query qp for HIP08

Yonatan Nachum <ynachum@amazon.com>
    RDMA/efa: Fix unsupported page sizes in device

Neil Armstrong <neil.armstrong@linaro.org>
    phy: amlogic: phy-meson-g12a-mipi-dphy-analog: fix CNTL2_DIF_TX_CTL0 value

Selvin Xavier <selvin.xavier@broadcom.com>
    RDMA/bnxt_re: Fix the page_size used during the MR creation


-------------

Diffstat:

 .../bindings/iio/adc/renesas,rcar-gyroadc.yaml     |   2 +-
 .../devicetree/bindings/serial/8250_omap.yaml      |   1 +
 .../devicetree/bindings/sound/tas2562.yaml         |   6 +-
 .../devicetree/bindings/sound/tas2770.yaml         |   6 +-
 .../devicetree/bindings/sound/tas27xx.yaml         |   6 +-
 .../devicetree/bindings/usb/snps,dwc3.yaml         |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi             |  82 +++++++++
 arch/arm/kernel/unwind.c                           |  25 ++-
 arch/arm64/include/asm/kvm_pgtable.h               |   6 +-
 arch/arm64/kernel/vdso.c                           |   2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   8 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              |  14 +-
 arch/arm64/kvm/hyp/nvhe/switch.c                   |   2 +
 arch/arm64/kvm/hyp/pgtable.c                       |  17 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |   1 +
 arch/arm64/kvm/vgic/vgic-init.c                    |  25 ++-
 arch/arm64/kvm/vgic/vgic-its.c                     |  14 +-
 arch/arm64/kvm/vgic/vgic-kvm-device.c              |  10 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |  31 ++--
 arch/arm64/kvm/vgic/vgic-mmio.c                    |   9 +-
 arch/arm64/kvm/vgic/vgic-v2.c                      |   6 -
 arch/arm64/kvm/vgic/vgic-v3.c                      |   7 -
 arch/arm64/kvm/vgic/vgic-v4.c                      |   3 +-
 arch/arm64/mm/fault.c                              |   4 +-
 arch/loongarch/Kconfig                             |   1 +
 arch/loongarch/include/asm/inst.h                  |  26 +++
 arch/loongarch/kernel/genex.S                      |   1 +
 arch/loongarch/kernel/traps.c                      |  92 +++++++++++
 arch/powerpc/platforms/pseries/iommu.c             |  13 +-
 arch/powerpc/xmon/xmon.c                           |   2 +-
 arch/riscv/include/asm/perf_event.h                |   7 +
 arch/riscv/kernel/vmlinux.lds.S                    |   2 +
 arch/riscv/mm/init.c                               |   2 +-
 arch/s390/kernel/ipl.c                             |   3 +-
 arch/s390/kernel/topology.c                        |  32 ++--
 arch/um/drivers/Makefile                           |   4 +-
 arch/um/drivers/harddog.h                          |   9 +
 arch/um/drivers/harddog_kern.c                     |   7 +-
 arch/um/drivers/harddog_user.c                     |   1 +
 arch/um/drivers/harddog_user_exp.c                 |   9 +
 arch/x86/crypto/aria-aesni-avx-asm_64.S            |   2 -
 arch/x86/events/intel/core.c                       |   2 +-
 arch/x86/events/intel/ds.c                         |  56 ++++---
 arch/x86/include/asm/perf_event.h                  |   3 +
 arch/x86/kvm/lapic.c                               |  20 ++-
 arch/x86/kvm/mmu/mmu.c                             |   5 +-
 arch/x86/kvm/x86.c                                 |   3 +
 block/blk-settings.c                               |   3 +-
 block/fops.c                                       |  12 +-
 crypto/asymmetric_keys/public_key.c                |  38 +++--
 drivers/acpi/resource.c                            |  12 ++
 drivers/ata/libata-scsi.c                          |  34 +++-
 drivers/base/cacheinfo.c                           |  26 +++
 drivers/base/regmap/regmap.c                       |   6 +-
 drivers/block/nbd.c                                |   4 +-
 drivers/block/rnbd/rnbd-proto.h                    |   2 +-
 drivers/block/ublk_drv.c                           |   9 +-
 drivers/char/tpm/tpm_tis_core.c                    |   7 +-
 drivers/char/tpm/tpm_tis_core.h                    |   8 +-
 drivers/dma/at_hdmac.c                             |  17 +-
 drivers/dma/at_xdmac.c                             |   7 +-
 drivers/dma/pl330.c                                |   8 +-
 drivers/firmware/qcom_scm.c                        |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  45 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |  22 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   4 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  29 ----
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  10 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c   |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |   5 +-
 drivers/gpu/drm/ast/ast_main.c                     |   9 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |   7 +-
 drivers/hid/hid-google-hammer.c                    |   2 +
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-logitech-hidpp.c                   |  12 +-
 drivers/hid/wacom_wac.c                            |   2 +-
 drivers/hwmon/k10temp.c                            |   1 +
 drivers/iio/accel/kionix-kx022a.c                  |   2 +-
 drivers/iio/accel/st_accel_core.c                  |   4 +-
 drivers/iio/adc/ad4130.c                           |  12 +-
 drivers/iio/adc/ad7192.c                           |   8 +-
 drivers/iio/adc/ad_sigma_delta.c                   |   4 +
 drivers/iio/adc/imx93_adc.c                        |   7 +-
 drivers/iio/adc/mt6370-adc.c                       |  53 +++++-
 drivers/iio/adc/mxs-lradc-adc.c                    |  10 +-
 drivers/iio/adc/stm32-adc.c                        |  61 +++----
 drivers/iio/addac/ad74413r.c                       |   2 +-
 drivers/iio/dac/Makefile                           |   2 +-
 drivers/iio/dac/mcp4725.c                          |  16 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  10 +-
 drivers/iio/light/vcnl4035.c                       |   3 +
 drivers/iio/magnetometer/tmag5273.c                |   5 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |   4 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  11 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |  12 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   7 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  25 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   2 +
 drivers/infiniband/hw/hns/hns_roce_mr.c            |  43 +++++
 drivers/infiniband/hw/irdma/verbs.c                |  12 +-
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/amd/amd_iommu.h                      |   4 +-
 drivers/iommu/amd/init.c                           |  24 +++
 drivers/iommu/amd/iommu.c                          |  31 +++-
 drivers/iommu/mtk_iommu.c                          |   3 +-
 drivers/iommu/rockchip-iommu.c                     |  14 +-
 drivers/mailbox/mailbox-test.c                     |  13 +-
 drivers/md/raid5.c                                 |   2 +-
 drivers/media/dvb-core/dvb_ca_en50221.c            |  49 +++++-
 drivers/media/dvb-core/dvb_demux.c                 |   4 +-
 drivers/media/dvb-core/dvb_frontend.c              |  69 ++++++--
 drivers/media/dvb-core/dvb_net.c                   |  38 ++++-
 drivers/media/dvb-core/dvbdev.c                    |  84 +++++++---
 drivers/media/dvb-frontends/mn88443x.c             |   2 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c |  17 +-
 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c      |   3 +
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c |  21 ++-
 drivers/media/usb/dvb-usb-v2/ce6230.c              |   8 +
 drivers/media/usb/dvb-usb-v2/ec168.c               |  12 ++
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c            |  20 +++
 drivers/media/usb/dvb-usb/az6027.c                 |  12 ++
 drivers/media/usb/dvb-usb/digitv.c                 |   4 +
 drivers/media/usb/dvb-usb/dw2102.c                 |   2 +-
 drivers/media/usb/ttusb-dec/ttusb_dec.c            |   3 +-
 drivers/media/usb/uvc/uvc_driver.c                 |  16 +-
 drivers/misc/fastrpc.c                             |  33 +++-
 drivers/mmc/core/pwrseq_sd8787.c                   |  34 +++-
 drivers/mmc/host/vub300.c                          |   3 +
 drivers/mtd/mtdchar.c                              |   8 +-
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h         |   8 +-
 drivers/mtd/nand/raw/marvell_nand.c                |  10 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  12 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   2 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   1 +
 .../ethernet/mellanox/mlx5/core/en/port_buffer.c   |  44 +++--
 .../ethernet/mellanox/mlx5/core/en/port_buffer.h   |   8 +-
 .../ethernet/mellanox/mlx5/core/en/tc/act/act.c    |  27 +--
 .../ethernet/mellanox/mlx5/core/en/tc/act/act.h    |   8 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c |   9 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  | 120 ++++++++++++--
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.h  |   9 +
 .../net/ethernet/mellanox/mlx5/core/en_common.c    |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  69 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   6 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    | 184 +++++----------------
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/mr.c       |  21 +++
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |   1 +
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |  13 +-
 drivers/net/ethernet/renesas/rswitch.c             |   2 +-
 drivers/net/ethernet/sfc/tc.c                      |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c   |   6 +
 drivers/net/ipa/ipa_endpoint.c                     |   2 +-
 drivers/net/phy/mxl-gpy.c                          |  16 +-
 drivers/net/usb/qmi_wwan.c                         |   2 +-
 drivers/net/wireless/ath/ath10k/qmi.c              |   4 +-
 drivers/net/wireless/broadcom/b43/b43.h            |   2 +-
 .../net/wireless/broadcom/b43legacy/b43legacy.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |   3 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   4 +-
 drivers/net/wwan/t7xx/t7xx_pci.c                   |  18 ++
 drivers/net/wwan/t7xx/t7xx_pci.h                   |   1 +
 drivers/nvme/host/constants.c                      |   2 +-
 drivers/nvme/host/core.c                           |   6 +-
 drivers/nvme/host/hwmon.c                          |   4 +-
 drivers/nvme/host/multipath.c                      |   1 -
 drivers/nvme/host/nvme.h                           |   5 +
 drivers/nvme/host/pci.c                            |   8 +-
 .../phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c  |   2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |   5 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c   |   5 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c           |  11 +-
 drivers/platform/x86/intel_scu_pcidrv.c            |   1 +
 drivers/remoteproc/qcom_q6v5_mss.c                 |   8 +-
 drivers/remoteproc/qcom_q6v5_pas.c                 |   2 +-
 drivers/s390/crypto/pkey_api.c                     |   3 +
 drivers/scsi/qla2xxx/qla_def.h                     |   1 +
 drivers/scsi/qla2xxx/qla_init.c                    |   3 +
 drivers/scsi/qla2xxx/qla_inline.h                  |   3 +
 drivers/scsi/qla2xxx/qla_isr.c                     |   3 +
 drivers/scsi/scsi_lib.c                            |   2 +
 drivers/scsi/stex.c                                |   4 +
 drivers/soc/qcom/rmtfs_mem.c                       |   2 +-
 drivers/tty/serial/8250/8250_tegra.c               |   4 +-
 drivers/tty/serial/Kconfig                         |   2 +-
 drivers/tty/serial/cpm_uart/cpm_uart.h             |   2 -
 drivers/tty/serial/fsl_lpuart.c                    |  44 ++---
 drivers/ufs/core/ufs-mcq.c                         |   5 +-
 drivers/ufs/core/ufshcd.c                          |  10 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |  13 ++
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 drivers/video/fbdev/core/bitblit.c                 |   3 +
 drivers/video/fbdev/core/modedb.c                  |   5 +
 drivers/video/fbdev/imsttfb.c                      |  15 +-
 drivers/video/fbdev/stifb.c                        |   1 +
 drivers/watchdog/menz69_wdt.c                      |  16 +-
 fs/btrfs/bio.c                                     |   2 +-
 fs/btrfs/ctree.c                                   |   2 +
 fs/btrfs/disk-io.c                                 |   2 +-
 fs/ceph/mds_client.c                               |   3 +-
 fs/ext4/ext4.h                                     |   5 +-
 fs/ext4/inode.c                                    |  34 +++-
 fs/ext4/super.c                                    |  24 +--
 fs/ext4/xattr.c                                    |  41 ++---
 fs/gfs2/super.c                                    |   8 +
 fs/ksmbd/oplock.c                                  |  72 +++++---
 fs/ksmbd/smb2pdu.c                                 |  90 +++++-----
 fs/nfsd/nfsctl.c                                   |   7 +-
 fs/nfsd/vfs.c                                      |  10 +-
 fs/xfs/xfs_buf_item_recover.c                      |  10 ++
 include/linux/firmware/qcom/qcom_scm.h             |   2 +-
 include/linux/mlx5/driver.h                        |   1 +
 include/linux/pe.h                                 |  25 +--
 include/linux/sunrpc/svcsock.h                     |   7 +-
 include/media/dvb_frontend.h                       |   6 +-
 include/media/dvb_net.h                            |   4 +
 include/media/dvbdev.h                             |  15 ++
 include/net/sock.h                                 |   4 +
 include/net/tcp.h                                  |   1 +
 include/ufs/ufshcd.h                               |   2 +-
 io_uring/epoll.c                                   |   4 -
 kernel/module/decompress.c                         |   2 +-
 kernel/trace/trace_events_hist.c                   |  23 ++-
 kernel/trace/trace_osnoise.c                       |   2 +
 kernel/trace/trace_probe.h                         |   2 +-
 lib/test_firmware.c                                |  85 +++++++---
 net/atm/resources.c                                |   2 +
 net/core/rtnetlink.c                               |  54 ++++--
 net/core/sock.c                                    |   2 +-
 net/ipv4/af_inet.c                                 |   2 +
 net/ipv4/inet_connection_sock.c                    |   1 +
 net/ipv4/tcp.c                                     |   9 +-
 net/ipv4/tcp_input.c                               |   2 +-
 net/ipv4/tcp_timer.c                               |  16 +-
 net/mac80211/chan.c                                |  75 +++++----
 net/mac80211/ieee80211_i.h                         |   3 +-
 net/mac80211/util.c                                |   2 +-
 net/mptcp/protocol.c                               | 143 +++++++++-------
 net/mptcp/protocol.h                               |  15 +-
 net/mptcp/subflow.c                                |  63 ++-----
 net/netfilter/nf_conntrack_netlink.c               |   4 +
 net/netlink/af_netlink.c                           |   2 +-
 net/netrom/nr_subr.c                               |   7 +-
 net/packet/af_packet.c                             |   8 +-
 net/packet/diag.c                                  |   2 +-
 net/rxrpc/af_rxrpc.c                               |   1 +
 net/rxrpc/ar-internal.h                            |   1 +
 net/rxrpc/local_event.c                            |  11 +-
 net/sched/cls_flower.c                             |   3 +
 net/sched/sch_api.c                                |  16 +-
 net/sched/sch_ingress.c                            |  16 +-
 net/smc/smc_llc.c                                  |   9 +-
 net/sunrpc/svcsock.c                               |  24 +--
 net/tls/tls_strp.c                                 |   4 +-
 net/tls/tls_sw.c                                   |   4 +-
 net/xfrm/xfrm_policy.c                             |  11 +-
 security/selinux/Makefile                          |   6 +-
 sound/core/oss/pcm_plugin.h                        |  16 +-
 sound/pci/hda/hda_intel.c                          |  21 +++
 sound/pci/hda/patch_hdmi.c                         |  22 +++
 sound/pci/hda/patch_realtek.c                      |  20 +++
 sound/soc/amd/yc/acp6x-mach.c                      |   7 +
 sound/soc/codecs/ssm2602.c                         |  15 ++
 sound/soc/dwc/dwc-i2s.c                            |   4 +-
 sound/soc/intel/common/soc-acpi-intel-cht-match.c  |  26 +++
 sound/soc/jz4740/jz4740-i2s.c                      |  54 +++++-
 sound/soc/sof/amd/acp-ipc.c                        |   7 +-
 sound/soc/sof/debug.c                              |   4 +-
 sound/soc/sof/pcm.c                                |  17 +-
 sound/soc/sof/pm.c                                 |  14 +-
 sound/soc/sof/sof-client-probes.c                  |  14 +-
 tools/perf/builtin-ftrace.c                        |   2 +-
 tools/power/cpupower/lib/powercap.c                |  23 ++-
 .../ftrace/test.d/filter/event-filter-function.tc  |  47 +++---
 tools/testing/selftests/net/mptcp/Makefile         |   2 +-
 tools/testing/selftests/net/mptcp/diag.sh          |   4 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   4 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  17 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  40 +++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   4 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |   4 +
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   4 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |   4 +
 295 files changed, 2806 insertions(+), 1289 deletions(-)


