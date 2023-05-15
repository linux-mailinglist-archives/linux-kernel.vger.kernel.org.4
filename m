Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE1703842
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244322AbjEORat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244402AbjEORaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:30:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AC2DC52;
        Mon, 15 May 2023 10:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8F8062CF7;
        Mon, 15 May 2023 17:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D61AC433EF;
        Mon, 15 May 2023 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171601;
        bh=SGCKDVyxHKrPD0/qzj03IwvP7ELUwh+WdBMgjzha0aM=;
        h=From:To:Cc:Subject:Date:From;
        b=PdolShBITIkPd6K3HpDTkRaJhUmURSR23xn65m5v5Fo0vqd38meVk2CjgokzgJmUU
         Vo5oeyQPUb3CkvK4P7R9geamBIDvuElGietmlFWYWRdmG+ECNM8IT/NGZ13Iv92eC3
         VH01uyoUoClSEtt3VSUQxmqHptLlY0/esYLR6WOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.15 000/134] 5.15.112-rc1 review
Date:   Mon, 15 May 2023 18:27:57 +0200
Message-Id: <20230515161702.887638251@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.112-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.112-rc1
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

This is the start of the stable review cycle for the 5.15.112 release.
There are 134 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.112-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.112-rc1

Aurabindo Pillai <aurabindo.pillai@amd.com>
    drm/amd/display: Fix hang when skipping modeset

Alexandre Ghiti <alexghiti@rivosinc.com>
    RISC-V: Fix up a cherry-pick warning in setup_vm_final()

Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
    drbd: correctly submit flush bio on barrier

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    serial: 8250: Fix serial8250_tx_empty() race with DMA Tx

Konrad Dybcio <konrad.dybcio@linaro.org>
    drm/msm/adreno: adreno_gpu: Use suspend() instead of idle() on load error

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
    ext4: improve error handling from ext4_dirhash()

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

John Stultz <jstultz@google.com>
    locking/rwsem: Add __always_inline annotation to __down_read_common() and inlined callers

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: not allow guest user on multichannel

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix deadlock in ksmbd_find_crypto_ctx()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix racy issue while destroying session on multichannel

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix kernel oops from idr_remove()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: add channel rwlock

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: replace sessions list in connection with xarray

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix multi session connection failure

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: set RSS capable in FSCTL_QUERY_NETWORK_INTERFACE_INFO

Sascha Hauer <s.hauer@pengutronix.de>
    wifi: rtw88: rtw8821c: Fix rfe_option field width

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Add NULL plane_state check for cursor disable logic

Dale Zhao <dale.zhao@amd.com>
    drm/amd/display: Refine condition of cursor visibility for pipe-split

Johan Hovold <johan+linaro@kernel.org>
    drm/msm/adreno: fix runtime PM imbalance at gpu load

Rob Clark <robdclark@chromium.org>
    drm/msm: Remove struct_mutex usage

Ankit Nautiyal <ankit.k.nautiyal@intel.com>
    drm/i915/dg2: Add HDMI pixel clock frequencies 267.30 and 319.89 MHz

Taylor, Clinton A <clinton.a.taylor@intel.com>
    drm/i915/dg2: Add additional HDMI pixel clock frequencies

Vandita Kulkarni <vandita.kulkarni@intel.com>
    drm/i915/dg2: Support 4k@30 on HDMI

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: soc-pcm.c: call __soc_pcm_close() in soc_pcm_close()

Takashi Iwai <tiwai@suse.de>
    ASoC: DPCM: Don't pick up BE without substream

Takashi Iwai <tiwai@suse.de>
    ASoC: soc-pcm: Move debugfs removal out of spinlock

Daniel Baluta <daniel.baluta@nxp.com>
    ASoC: soc-compress: Inherit atomicity from DAI link for Compress FE

Takashi Iwai <tiwai@suse.de>
    ASoC: soc-pcm: Fix DPCM lockdep warning due to nested stream locks

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Refactoring of various minor issues

Ping Cheng <pinglinux@gmail.com>
    HID: wacom: insert timestamp to packed Bluetooth (BT) events

Ping Cheng <pinglinux@gmail.com>
    HID: wacom: Set a default resolution for older tablets

Guchun Chen <guchun.chen@amd.com>
    drm/amdgpu: disable sdma ecc irq only when sdma RAS is enabled in suspend

Lin.Cao <lincao12@amd.com>
    drm/amdgpu: Fix vram recover doesn't work after whole GPU reset (v2)

Guchun Chen <guchun.chen@amd.com>
    drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when enabling legacy gfx ras

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amdgpu: fix an amdgpu_irq_put() issue in gmc_v9_0_hw_fini()

Hamza Mahfooz <hamza.mahfooz@amd.com>
    drm/amd/display: fix flickering caused by S/G mode

James Cowgill <james.cowgill@blaize.com>
    drm/panel: otm8009a: Set backlight parent to panel device

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix potential corruption when moving a directory

Johan Hovold <johan+linaro@kernel.org>
    drm/msm: fix NULL-deref on irq uninstall

Johan Hovold <johan+linaro@kernel.org>
    drm/msm: fix NULL-deref on snapshot tear down

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: lt8912b: Fix DSI Video Mode

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: s5pv210: correct MIPI CSIS clock name

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: exynos: fix WM8960 clock name in Itop Elite

Mathieu Poirier <mathieu.poirier@linaro.org>
    remoteproc: imx_rproc: Call of_node_put() on iteration error

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

Steve French <stfrench@microsoft.com>
    SMB3: force unmount was failing to close deferred close files

Steve French <stfrench@microsoft.com>
    smb3: fix problem remounting a share after shutdown

Jan Kara <jack@suse.cz>
    inotify: Avoid reporting event with invalid wd

Andrey Avdeev <jamesstoun@gmail.com>
    platform/x86: touchscreen_dmi: Add info for the Dexp Ursus KX210i

Hans de Goede <hdegoede@redhat.com>
    platform/x86: touchscreen_dmi: Add upside-down quirk for GDIX1002 ts on the Juno Tablet

Steve French <stfrench@microsoft.com>
    cifs: release leases for deferred close handles when freezing

Pawel Witek <pawel.ireneusz.witek@gmail.com>
    cifs: fix pcchunk length type in smb2_copychunk_range

Filipe Manana <fdmanana@suse.com>
    btrfs: fix space cache inconsistency after error loading it from disk

Anastasia Belova <abelova@astralinux.ru>
    btrfs: print-tree: parent bytenr must be aligned to sector size

Christoph Hellwig <hch@lst.de>
    btrfs: zero the buffer before marking it dirty in btrfs_redirty_list_add

Josef Bacik <josef@toxicpanda.com>
    btrfs: don't free qgroup space unless specified

Boris Burkov <boris@bur.io>
    btrfs: fix encoded write i_size corruption with no-holes

Naohiro Aota <naohiro.aota@wdc.com>
    btrfs: zoned: fix wrong use of bitops API in btrfs_ensure_empty_zones

Filipe Manana <fdmanana@suse.com>
    btrfs: fix btrfs_prev_leaf() to not return the same key twice

Dmitrii Dolgov <9erthalion6@gmail.com>
    perf stat: Separate bperf from bpf_profiler

Ian Rogers <irogers@google.com>
    perf evlist: Refactor evlist__for_each_cpu()

Yang Jihong <yangjihong1@huawei.com>
    perf symbols: Fix return incorrect build_id size in elf_read_build_id()

Olivier Bacon <olivierb89@gmail.com>
    crypto: engine - fix crypto_queue backlog handling

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: engine - Use crypto_request_complete

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: api - Add scaffolding to change completion function signature

Corentin Labbe <clabbe@baylibre.com>
    crypto: engine - check if BH is disabled during completion

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    crypto: sun8i-ss - Fix a test in sun8i_ss_setup_ivs()

Markus Elfring <Markus.Elfring@web.de>
    perf map: Delete two variable initialisations before null pointer checks in sort__sym_from_cmp()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf pmu: zfree() expects a pointer to a pointer to zero it after freeing its contents

Kajol Jain <kjain@linux.ibm.com>
    perf vendor events power9: Remove UTF-8 characters from JSON files

Roman Lozko <lozko.roma@gmail.com>
    perf scripts intel-pt-events.py: Fix IPC output for Python 2

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
    ionic: catch failure from devlink_alloc

Ido Schimmel <idosch@nvidia.com>
    ethtool: Fix uninitialized number of lanes

Shannon Nelson <shannon.nelson@amd.com>
    ionic: remove noise from ethtool rxnfc error msg

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-vf: Detach LF resources on probe cleanup

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-pf: Disable packet I/O for graceful exit

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-af: Skip PFs if not enabled

Geetha sowjanya <gakula@marvell.com>
    octeontx2-af: Secure APR table update with the lock

David Howells <dhowells@redhat.com>
    rxrpc: Fix hard call timeout units

Andy Moreton <andy.moreton@amd.com>
    sfc: Fix module EEPROM reporting for QSFP modules

Hayes Wang <hayeswang@realtek.com>
    r8152: move setting r8153b_rx_agg_chg_indicate()

Hayes Wang <hayeswang@realtek.com>
    r8152: fix the poor throughput for 2.5G devices

Hayes Wang <hayeswang@realtek.com>
    r8152: fix flow control issue of RTL8156A

Victor Nogueira <victor@mojatatu.com>
    net/sched: act_mirred: Add carrier check

Sia Jee Heng <jeeheng.sia@starfivetech.com>
    RISC-V: mm: Enable huge page support to kernel_page_present() function

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    watchdog: dw_wdt: Fix the error handling path of dw_wdt_drv_probe()

Maxim Korotkov <korotkov.maxim.s@gmail.com>
    writeback: fix call of incorrect macro

Angelo Dureghello <angelo.dureghello@timesys.com>
    net: dsa: mv88e6xxx: add mv88e6321 rsvd2cpu

Andrea Mayer <andrea.mayer@uniroma2.it>
    selftests: srv6: make srv6_end_dt46_l3vpn_test more robust

Cong Wang <cong.wang@bytedance.com>
    sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()

Vlad Buslov <vladbu@nvidia.com>
    net/sched: cls_api: remove block_cb from driver_list before freeing

Cosmo Chou <chou.cosmo@gmail.com>
    net/ncsi: clear Tx enable mode when handling a Config required AEN

Zheng Wang <zyytlz.wz@163.com>
    scsi: qedi: Fix use after free bug in qedi_remove()

Saurabh Sengar <ssengar@linux.microsoft.com>
    drm/hyperv: Don't overwrite dirt_needed value set by host

ZhangPeng <zhangpeng362@huawei.com>
    fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: soc-pcm: fix BE handling of PAUSE_RELEASE

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: soc-pcm: test refcount before triggering

Takashi Iwai <tiwai@suse.de>
    ASoC: soc-pcm: serialize BE triggers

Takashi Iwai <tiwai@suse.de>
    ASoC: soc-pcm: Fix and cleanup DPCM locking

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: soc-pcm: align BE 'atomicity' with that of the FE

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure

Tanmay Shah <tanmay.shah@amd.com>
    mailbox: zynqmp: Fix counts of child nodes

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mailbox: zynq: Switch to flexible array to simplify code

Jeffrey Hugo <quic_jhugo@quicinc.com>
    bus: mhi: host: Range check CHDBOFF and ERDBOFF

Jeffrey Hugo <quic_jhugo@quicinc.com>
    bus: mhi: host: Use mhi_tryset_pm_state() for setting fw error state

Jeffrey Hugo <quic_jhugo@quicinc.com>
    bus: mhi: host: Remove duplicate ee check for syserr

Manivannan Sadhasivam <mani@kernel.org>
    bus: mhi: Move host MHI code to "host" directory

Mårten Lindahl <marten.lindahl@axis.com>
    ubifs: Fix memory leak in do_rename

Zhihao Cheng <chengzhihao1@huawei.com>
    ubifs: Fix AA deadlock when setting xattr for encrypted file

Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
    crypto: ccp - Clear PSP interrupt status register before calling handler

Tze-nan Wu <Tze-nan.Wu@mediatek.com>
    ring-buffer: Ensure proper resetting of atomic variables in ring_buffer_reset_online_cpus


-------------

Diffstat:

 Makefile                                           |    4 +-
 arch/arm/boot/dts/exynos4412-itop-elite.dts        |    2 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |    2 +-
 arch/riscv/mm/init.c                               |    3 +-
 arch/riscv/mm/pageattr.c                           |    8 +
 arch/sh/Kconfig.debug                              |    2 +-
 arch/sh/kernel/head_32.S                           |    6 +-
 arch/sh/kernel/nmi_debug.c                         |    4 +-
 arch/sh/kernel/setup.c                             |    4 +-
 arch/sh/math-emu/sfp-util.h                        |    4 -
 crypto/algapi.c                                    |    3 +
 crypto/crypto_engine.c                             |   11 +-
 drivers/block/drbd/drbd_receiver.c                 |    2 +-
 drivers/bus/Makefile                               |    2 +-
 drivers/bus/mhi/Kconfig                            |   27 +-
 drivers/bus/mhi/Makefile                           |    8 +-
 drivers/bus/mhi/host/Kconfig                       |   31 +
 drivers/bus/mhi/{core => host}/Makefile            |    4 +-
 drivers/bus/mhi/{core => host}/boot.c              |   16 +-
 drivers/bus/mhi/{core => host}/debugfs.c           |    0
 drivers/bus/mhi/{core => host}/init.c              |   12 +
 drivers/bus/mhi/{core => host}/internal.h          |    0
 drivers/bus/mhi/{core => host}/main.c              |    2 +-
 drivers/bus/mhi/{ => host}/pci_generic.c           |    0
 drivers/bus/mhi/{core => host}/pm.c                |    0
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |    2 +-
 drivers/crypto/ccp/psp-dev.c                       |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |    6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |    1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |    8 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   18 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |    3 +
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   45 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |    1 -
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c            |    2 -
 drivers/gpu/drm/i915/display/intel_snps_phy.c      | 1210 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a5xx_debugfs.c          |    4 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   20 +-
 drivers/gpu/drm/msm/msm_debugfs.c                  |   12 +-
 drivers/gpu/drm/msm/msm_drv.c                      |   11 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   14 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |   20 +-
 drivers/gpu/drm/msm/msm_perf.c                     |    9 +-
 drivers/gpu/drm/msm/msm_rd.c                       |   16 +-
 drivers/gpu/drm/msm/msm_ringbuffer.c               |    4 +-
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   |    2 +-
 drivers/hid/wacom_wac.c                            |   38 +-
 drivers/hid/wacom_wac.h                            |    1 +
 drivers/mailbox/zynqmp-ipi-mailbox.c               |   13 +-
 drivers/net/dsa/mt7530.c                           |    4 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |    1 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |    1 -
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   |    2 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c   |    5 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |    3 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   49 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cn10k.c  |   13 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   11 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |    2 +-
 .../net/ethernet/pensando/ionic/ionic_devlink.c    |    2 +
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |    2 +-
 drivers/net/ethernet/sfc/mcdi_port_common.c        |   11 +-
 drivers/net/usb/r8152.c                            |   84 +-
 drivers/net/virtio_net.c                           |   43 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    2 +-
 drivers/platform/x86/touchscreen_dmi.c             |   41 +
 drivers/remoteproc/imx_rproc.c                     |    7 +-
 drivers/remoteproc/st_remoteproc.c                 |    5 +-
 drivers/remoteproc/stm32_rproc.c                   |    6 +-
 drivers/scsi/qedi/qedi_main.c                      |    3 +
 drivers/tty/serial/8250/8250.h                     |   12 +
 drivers/tty/serial/8250/8250_port.c                |   12 +-
 drivers/watchdog/dw_wdt.c                          |    7 +-
 fs/btrfs/block-rsv.c                               |    3 +-
 fs/btrfs/ctree.c                                   |   32 +-
 fs/btrfs/file-item.c                               |    5 +-
 fs/btrfs/free-space-cache.c                        |    7 +-
 fs/btrfs/print-tree.c                              |    6 +-
 fs/btrfs/zoned.c                                   |   10 +-
 fs/cifs/cifsfs.c                                   |   16 +
 fs/cifs/connect.c                                  |    7 +
 fs/cifs/smb2ops.c                                  |    2 +-
 fs/ext4/balloc.c                                   |   25 +
 fs/ext4/extents_status.c                           |   30 +-
 fs/ext4/hash.c                                     |    6 +-
 fs/ext4/inline.c                                   |   17 +-
 fs/ext4/inode.c                                    |    2 +-
 fs/ext4/mballoc.c                                  |    6 +-
 fs/ext4/namei.c                                    |   53 +-
 fs/ext4/super.c                                    |   19 +-
 fs/ext4/xattr.c                                    |    5 +-
 fs/f2fs/namei.c                                    |   16 +-
 fs/fs-writeback.c                                  |    2 +-
 fs/ksmbd/auth.c                                    |   98 +-
 fs/ksmbd/auth.h                                    |   19 +-
 fs/ksmbd/connection.c                              |    3 +-
 fs/ksmbd/connection.h                              |   16 +-
 fs/ksmbd/mgmt/tree_connect.c                       |    5 +-
 fs/ksmbd/mgmt/tree_connect.h                       |    4 +-
 fs/ksmbd/mgmt/user_config.c                        |   10 +
 fs/ksmbd/mgmt/user_config.h                        |    1 +
 fs/ksmbd/mgmt/user_session.c                       |   97 +-
 fs/ksmbd/mgmt/user_session.h                       |   14 +-
 fs/ksmbd/oplock.c                                  |   11 +-
 fs/ksmbd/smb2pdu.c                                 |   94 +-
 fs/ksmbd/smb_common.h                              |    2 +-
 fs/ksmbd/vfs.c                                     |    3 +-
 fs/ksmbd/vfs_cache.c                               |    2 +-
 fs/notify/inotify/inotify_fsnotify.c               |   11 +-
 fs/ntfs3/bitmap.c                                  |    3 +-
 fs/ntfs3/namei.c                                   |   10 +
 fs/ntfs3/ntfs.h                                    |    3 -
 fs/ubifs/dir.c                                     |   31 +-
 fs/ubifs/ubifs.h                                   |    2 +-
 fs/ubifs/xattr.c                                   |    2 +-
 include/crypto/algapi.h                            |    7 +
 include/linux/crypto.h                             |    6 +
 include/sound/pcm.h                                |   15 +
 include/sound/soc-dpcm.h                           |    2 +
 include/sound/soc.h                                |    2 -
 kernel/locking/rwsem.c                             |    8 +-
 kernel/trace/ring_buffer.c                         |   16 +-
 net/ethtool/ioctl.c                                |    2 +-
 net/ipv6/sit.c                                     |    8 +-
 net/ncsi/ncsi-aen.c                                |    1 +
 net/packet/af_packet.c                             |    2 +-
 net/rxrpc/sendmsg.c                                |    2 +-
 net/sched/act_mirred.c                             |    2 +-
 net/sched/cls_api.c                                |    1 +
 sound/core/pcm_native.c                            |   13 +
 sound/soc/soc-compress.c                           |    3 +
 sound/soc/soc-core.c                               |    1 -
 sound/soc/soc-pcm.c                                |  364 ++++--
 sound/usb/caiaq/input.c                            |    1 +
 tools/perf/builtin-stat.c                          |  185 ++-
 .../perf/pmu-events/arch/powerpc/power9/other.json |    4 +-
 .../pmu-events/arch/powerpc/power9/pipeline.json   |    2 +-
 tools/perf/scripts/python/intel-pt-events.py       |    2 +-
 tools/perf/util/evlist.c                           |  148 +--
 tools/perf/util/evlist.h                           |   50 +-
 tools/perf/util/evsel.h                            |    6 +-
 tools/perf/util/pmu.c                              |    2 +-
 tools/perf/util/sort.c                             |    3 +-
 tools/perf/util/symbol-elf.c                       |    2 +-
 .../selftests/net/srv6_end_dt46_l3vpn_test.sh      |   10 +-
 147 files changed, 2754 insertions(+), 786 deletions(-)


