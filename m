Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBED735234
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjFSKcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFSKcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:32:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289E7CA;
        Mon, 19 Jun 2023 03:32:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A556860B67;
        Mon, 19 Jun 2023 10:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BACC433C9;
        Mon, 19 Jun 2023 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170730;
        bh=/aBEhDDxMb1v+q2Vdk8R+EU7IqH4g5R62xvVNusFRCs=;
        h=From:To:Cc:Subject:Date:From;
        b=ih2Ju/rwUP+5aw3bjCdIUvK8pVG95NAoGrXPkzKdpXsvlSDcAuvbFNPeKH4q1PjUt
         75SuXBhJ53L4oqiPmWkuuIhAIr9bJfYFoDnmtZNHfEZkYhebB12rXecDwD+aXFIeV4
         6pXZOA5HE0QrSzM0p2hjz2AfOw8ycPJ2H+r8gzc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 6.3 000/187] 6.3.9-rc1 review
Date:   Mon, 19 Jun 2023 12:26:58 +0200
Message-ID: <20230619102157.579823843@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.9-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.3.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.3.9-rc1
X-KernelTest-Deadline: 2023-06-21T10:22+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.3.9 release.
There are 187 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.9-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.3.9-rc1

Ming Lei <ming.lei@redhat.com>
    blk-cgroup: Flush stats before releasing blkcg_gq

Bob Pearson <rpearsonhpe@gmail.com>
    scsi: target: core: Fix error path in target_setup_session()

Leon Romanovsky <leon@kernel.org>
    neighbour: delete neigh_lookup_nodev as not used

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm8550: Use the correct LLCC register scheme

Ben Hutchings <benh@debian.org>
    parisc: Delete redundant register definitions in <asm/assembly.h>

David Howells <dhowells@redhat.com>
    afs: Fix vlserver probe RTT handling

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    octeon_ep: Add missing check for ioremap

Alex Maftei <alex.maftei@amd.com>
    selftests/ptp: Fix timestamp printf format for PTP_SYS_OFFSET

Lin Ma <linma@zju.edu.cn>
    net: tipc: resize nlattr array to correct size

Li Lingfeng <lilingfeng3@huawei.com>
    dm: don't lock fs when the map is NULL during suspend or resume

Íñigo Huguet <ihuguet@redhat.com>
    sfc: fix XDP queues mode with legacy IRQ

Fedor Pchelkin <pchelkin@ispras.ru>
    net: macsec: fix double free of percpu stats

Eric Dumazet <edumazet@google.com>
    net: lapbether: only support ethernet devices

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: felix: fix taprio guard band overflow at 10Mbps with jumbo frames

Vlad Buslov <vladbu@nvidia.com>
    net/sched: cls_api: Fix lockup on flushing explicitly created chain

Jakub Buchocki <jakubx.buchocki@intel.com>
    ice: Fix ice module unload

Fabio M. De Francesco <fmdefrancesco@gmail.com>
    ext4: drop the call to ext4_error() from ext4_get_group_info()

Mauro Carvalho Chehab <mchehab@kernel.org>
    Revert "media: dvb-core: Fix use-after-free on race condition at dvb_frontend"

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Fix rxe_cq_post

Steve French <stfrench@microsoft.com>
    cifs: fix lease break oops in xfstest generic/098

Danielle Ratson <danieller@nvidia.com>
    selftests: forwarding: hw_stats_l3: Set addrgenmode in a separate step

Peilin Ye <peilin.ye@bytedance.com>
    net/sched: qdisc_destroy() old ingress and clsact Qdiscs before grafting

Peilin Ye <peilin.ye@bytedance.com>
    net/sched: Refactor qdisc_graft() for ingress and clsact Qdiscs

Paul Blakey <paulb@nvidia.com>
    net/sched: act_ct: Fix promotion of offloaded unreplied tuple

Vlad Buslov <vladbu@nvidia.com>
    selftests/tc-testing: Fix SFB db test

Vlad Buslov <vladbu@nvidia.com>
    selftests/tc-testing: Fix Error: failed to find target LOG

Vlad Buslov <vladbu@nvidia.com>
    selftests/tc-testing: Fix Error: Specified qdisc kind is unknown.

Dan Carpenter <dan.carpenter@linaro.org>
    net: ethernet: ti: am65-cpsw: Call of_node_put() on error path

Natalia Petrova <n.petrova@fintech.ru>
    drm/nouveau: add nv_encoder pointer check for NULL

Natalia Petrova <n.petrova@fintech.ru>
    drm/nouveau/dp: check for NULL nv_connector->native_mode

Su Hui <suhui@nfschina.com>
    drm/bridge: ti-sn65dsi86: Avoid possible buffer overflow

Ratchanan Srirattanamet <peathot@hotmail.com>
    drm/nouveau: don't detect DSM for non-NVIDIA device

Maxime Chevallier <maxime.chevallier@bootlin.com>
    net: phylink: use a dedicated helper to parse usgmii control word

Maxime Chevallier <maxime.chevallier@bootlin.com>
    net: phylink: report correct max speed for QUSGMII

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    igb: fix nvm.ops.read() error handling

Vinicius Costa Gomes <vinicius.gomes@intel.com>
    igc: Fix possible system crash when loading module

Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
    igc: Clean the TX buffer and TX descriptor ring

Dan Carpenter <dan.carpenter@linaro.org>
    sctp: fix an error code in sctp_sf_eat_auth()

Hangbin Liu <liuhangbin@gmail.com>
    ipvlan: fix bound dev checking for IPv6 l3s mode

Benjamin Berg <benjamin.berg@intel.com>
    wifi: mac80211: fragment per STA profile correctly

Jakub Kicinski <kuba@kernel.org>
    net: ethtool: correct MAX attribute value for stats

Saravanan Vajravel <saravanan.vajravel@broadcom.com>
    IB/isert: Fix incorrect release of isert connection

Saravanan Vajravel <saravanan.vajravel@broadcom.com>
    IB/isert: Fix possible list corruption in CMA handler

Saravanan Vajravel <saravanan.vajravel@broadcom.com>
    IB/isert: Fix dead lock in ib_isert

Mark Bloch <mbloch@nvidia.com>
    RDMA/mlx5: Fix affinity assignment

Yishai Hadas <yishaih@nvidia.com>
    IB/uverbs: Fix to consider event queue closing also upon non-blocking mode

Mark Zhang <markzhang@nvidia.com>
    RDMA/cma: Always set static rate to 0 for RoCE

Mark Bloch <mbloch@nvidia.com>
    RDMA/mlx5: Create an indirect flow table for steering anchor

Maher Sanalla <msanalla@nvidia.com>
    RDMA/mlx5: Initiate dropless RQ for RAW Ethernet functions

Nithin Dabilpuram <ndabilpuram@marvell.com>
    octeontx2-af: fix lbk link credits on cn10k

Satha Rao <skoteshwar@marvell.com>
    octeontx2-af: fixed resource availability check

Ahmed Zaki <ahmed.zaki@intel.com>
    iavf: remove mask from iavf_irq_enable_queues()

Zhu Yanjun <yanjun.zhu@linux.dev>
    RDMA/rxe: Fix the use-before-initialization error of resp_pkts

Benjamin Berg <benjamin.berg@intel.com>
    wifi: mac80211: take lock before setting vif links

Benjamin Berg <benjamin.berg@intel.com>
    wifi: cfg80211: fix link del callback to call correct handler

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix link activation settings order

Lee Jones <lee@kernel.org>
    net/sched: cls_u32: Fix reference counter leak leading to overflow

Zhengchao Shao <shaozhengchao@huawei.com>
    net/sched: taprio: fix slab-out-of-bounds Read in taprio_dequeue_from_txq

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-af: Fix promiscuous mode

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    net: renesas: rswitch: Fix timestamp feature after all descriptors are used

Max Tottenham <mtottenh@akamai.com>
    net/sched: act_pedit: Parse L3 Header for L4 offset

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: act_pedit: remove extra check for key type

Yuezhen Luan <eggcar.luan@gmail.com>
    igb: Fix extts capture value format for 82580/i354/i350

Guillaume Nault <gnault@redhat.com>
    ping6: Fix send to link-local addresses with VRF.

Wei Fang <wei.fang@nxp.com>
    net: enetc: correct the indexes of highest and 2nd highest TCs

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE

Kamil Maziarz <kamil.maziarz@intel.com>
    ice: Fix XDP memory leak when NIC is brought up and down

Simon Horman <horms@kernel.org>
    ice: Don't dereference NULL in ice_gnss_read error path

Michal Schmidt <mschmidt@redhat.com>
    ice: do not busy-wait to read GNSS data

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nfnetlink: skip error delivery on batch in case of ENOMEM

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: integrate pipapo into commit protocol

Abel Vesa <abel.vesa@linaro.org>
    regulator: qcom-rpmh: Fix regulators for PM8550

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    regulator: qcom-rpmh: add support for pmm8654au regulators

Vladimir Oltean <vladimir.oltean@nxp.com>
    spi: fsl-dspi: avoid SCK glitches with continuous transfers

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    spi: cadence-quadspi: Add missing check for dma_set_mask

Kamal Heib <kheib@redhat.com>
    RDMA/bnxt_re: Fix reporting active_{speed,width} attributes

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Fix ref count error in check_rkey()

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Fix packet length checks

Li Zhijian <lizhijian@fujitsu.com>
    RDMA/rtrs: Fix rxe_dealloc_pd warning

Li Zhijian <lizhijian@fujitsu.com>
    RDMA/rtrs: Fix the last iu->buf leak in err path

Elson Roy Serrao <quic_eserrao@quicinc.com>
    usb: dwc3: gadget: Reset num TRBs before giving back the request

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: fix use-after-free on core driver unbind

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: qcom: fix NULL-deref on suspend

Biju Das <biju.das.jz@bp.renesas.com>
    usb: gadget: udc: renesas_usb3: Fix RZ/V2M {modprobe,bind} error

Badhri Jagan Sridharan <badhri@google.com>
    usb: gadget: udc: core: Prevent soft_connect_store() race

Badhri Jagan Sridharan <badhri@google.com>
    usb: gadget: udc: core: Offload usb_udc_vbus_handler processing

Pavan Holla <pholla@chromium.org>
    usb: typec: Fix fast_role_swap_current show function

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    usb: typec: ucsi: Fix command cancellation

Robert Hodaszi <robert.hodaszi@digi.com>
    tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A

Bernhard Seibold <mail@bernhard-seibold.de>
    serial: lantiq: add missing interrupt ack

Jerry Meng <jerry-meng@foxmail.com>
    USB: serial: option: add Quectel EM061KGL series

Arnd Bergmann <arnd@arndb.de>
    clk: pxa: fix NULL pointer dereference in pxa3xx_clk_update_accr

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Mask ring interrupt on Intel hardware as well

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: dma_test: Use correct value for absent rings when creating paths

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Do not touch CL state configuration during discovery

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Increase DisplayPort Connection Manager handshake timeout

Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
    ALSA: hda/realtek: Add a quirk for Compaq N14JP6

Jiadong Zhu <Jiadong.Zhu@amd.com>
    drm/amdgpu: Modify indirect buffer packages for resubmission

Jiadong Zhu <Jiadong.Zhu@amd.com>
    drm/amdgpu: Implement gfx9 patch functions for resubmission

Jiadong Zhu <Jiadong.Zhu@amd.com>
    drm/amdgpu: Program gds backup address as zero if no gds allocated

Jiadong Zhu <Jiadong.Zhu@amd.com>
    drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence signaled

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: add missing radeon secondary PCI ID

Kenneth Feng <kenneth.feng@amd.com>
    drm/amd/pm: workaround for compute workload type on some skus

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Tighten permissions on VBIOS flashing attributes

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Make sure image is written to trigger VBIOS image update flow

Hersen Wu <hersenxs.wu@amd.com>
    drm/amd/display: edp do not add non-edid timings

Peichen Huang <peichen.huang@amd.com>
    drm/amd/display: limit DPIA link rate to HBR3

Wes Huang <wes.huang@moxa.com>
    net: usb: qmi_wwan: add support for Compal RXM-G1

Sonny Jiang <sonjiang@amd.com>
    drm/amdgpu: vcn_4_0 set instance 0 init sched score to 1

Edward Srouji <edwards@nvidia.com>
    RDMA/uverbs: Restrict usage of privileged QKEYs

Haibo Li <haibo.li@mediatek.com>
    mm/gup_test: fix ioctl fail for compat task

Dave Airlie <airlied@redhat.com>
    nouveau: fix client work fence deletion race

Christian Marangi <ansuelsmth@gmail.com>
    net: ethernet: stmicro: stmmac: fix possible memory leak in __stmmac_open

Mike Snitzer <snitzer@kernel.org>
    dm thin: fix issue_discard to pass GFP_NOIO to __blkdev_issue_discard

Li Lingfeng <lilingfeng3@huawei.com>
    dm thin metadata: check fail_io before using data_sm

Julian Ruess <julianr@linux.ibm.com>
    s390/ism: Fix trying to free already-freed IRQ by repeated ism_dev_exit()

Lukasz Tyl <ltyl@hem-e.com>
    ALSA: usb-audio: Add quirk flag for HEM devices to enable native DSD playback

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Fix broken resume due to UAC3 power state

Chris Mason <clm@fb.com>
    btrfs: can_nocow_file_extent should pass down args->strict from callers

Christoph Hellwig <hch@lst.de>
    btrfs: fix iomap_begin length for nocow writes

Qu Wenruo <wqu@suse.com>
    btrfs: do not ASSERT() on duplicated global roots

Chris Mason <clm@fb.com>
    btrfs: properly enable async discard when switching from RO->RW

Qu Wenruo <wqu@suse.com>
    btrfs: subpage: fix a crash in metadata repair path

Ricardo Ribalda <ribalda@chromium.org>
    powerpc/purgatory: remove PGO flags

Ricardo Ribalda <ribalda@chromium.org>
    riscv/purgatory: remove PGO flags

Ricardo Ribalda <ribalda@chromium.org>
    x86/purgatory: remove PGO flags

Ricardo Ribalda <ribalda@chromium.org>
    kexec: support purgatories with .text.hot sections

Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
    Revert "drm/amdgpu: remove TOPDOWN flags when allocating VRAM in large bar system"

Jens Axboe <axboe@kernel.dk>
    io_uring/net: save msghdr->msg_control for retries

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Fix perf event id calculation

Immad Mir <mirimmad17@gmail.com>
    LoongArch: Fix debugfs_create_dir() error checking

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: reject devices with insufficient block count

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix possible out-of-bounds segment allocation in resize ioctl

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix incomplete buffer cleanup in nilfs_btnode_abort_change_key()

Peter Xu <peterx@redhat.com>
    mm/uffd: fix vma operation where start addr cuts part of vma

Janne Grunau <j@jannau.net>
    nios2: dts: Fix tse_mac "max-frame-size" property

Kefeng Wang <wangkefeng.wang@huawei.com>
    mm/damon/core: fix divide error in damon_nr_accesses_to_accesses_bp()

Nhat Pham <nphamcs@gmail.com>
    zswap: do not shrink if cgroup may not zswap

Luís Henriques <ocfs2-devel@oss.oracle.com>
    ocfs2: check new file size on fallocate call

Luís Henriques <ocfs2-devel@oss.oracle.com>
    ocfs2: fix use-after-free when unmounting read-only filesystem

Benjamin Segall <bsegall@google.com>
    epoll: ep_autoremove_wake_function should use list_del_init_careful

Dan Carpenter <dan.carpenter@linaro.org>
    wifi: cfg80211: fix double lock bug in reg_wdev_chan_valid()

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix locking in regulatory disconnect

Marc Zyngier <maz@kernel.org>
    irqchip/gic: Correctly validate OF quirk descriptors

Tatsuki Sugiura <sugi@nemui.org>
    NVMe: Add MAXIO 1602 to bogus nid list.

Wenwen Chen <wenwen.chen@samsung.com>
    io_uring: unlock sqd->lock before sq thread release CPU

Sukrut Bellary <sukrut.bellary@linux.com>
    drm:amd:amdgpu: Fix missing buffer object unlock in failure path

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen/blkfront: Only check REQ_FUA for writes

Maxim Kochetkov <fido_max@inbox.ru>
    ASoC: dwc: move DMA init to snd_soc_dai_driver probe()

Stefan Binding <sbinding@opensource.cirrus.com>
    ASoC: cs35l41: Fix default regmap values for some registers

Liviu Dudau <liviu@dudau.co.uk>
    mips: Move initrd_start check after initrd address sanitisation.

Manuel Lauss <manuel.lauss@gmail.com>
    MIPS: Alchemy: fix dbdma2

Manuel Lauss <manuel.lauss@gmail.com>
    MIPS: Restore Au1300 support

Manuel Lauss <manuel.lauss@gmail.com>
    MIPS: unhide PATA_PLATFORM

Gao Xiang <xiang@kernel.org>
    erofs: use HIPRI by default if per-cpu kthreads are enabled

Helge Deller <deller@gmx.de>
    parisc: Flush gatt writes and adjust gatt mask in parisc_agp_mask_memory()

Helge Deller <deller@gmx.de>
    parisc: Improve cache flushing for PCXL in arch_sync_dma_for_cpu()

Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
    ASoC: Intel: avs: Add missing checks on FE startup

Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
    ASoC: Intel: avs: Fix avs_path_module::instance_id size

Cezary Rojewski <cezary.rojewski@intel.com>
    ASoC: Intel: avs: Account for UID of ACPI device

Alejandro Lucero <alejandro.lucero-palau@amd.com>
    sfc: fix devlink info error handling

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ASoC: soc-pcm: test if a BE can be prepared

Johannes Thumshirn <johannes.thumshirn@wdc.com>
    btrfs: handle memory allocation failure in btrfs_csum_one_bio

Qu Wenruo <wqu@suse.com>
    btrfs: scrub: try harder to mark RAID56 block groups read-only

Maya Matuszczyk <maccraft123mc@gmail.com>
    drm: panel-orientation-quirks: Change Air's quirk to support Air Plus

Mario Limonciello <mario.limonciello@amd.com>
    power: supply: Fix logic checking if system is running from battery

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    irqchip/meson-gpio: Mark OF related data as maybe unused

Douglas Anderson <dianders@chromium.org>
    irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware issues

Osama Muhammad <osmtendev@gmail.com>
    regulator: Fix error checking for debugfs_create_dir

Alexandru Sorodoc <ealex95@gmail.com>
    platform/x86: asus-wmi: Ignore WMI events with codes 0x7B, 0xC0

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports

Marek Vasut <marex@denx.de>
    power: supply: Ratelimit no data debug output

Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
    selftests: gpio: gpio-sim: Fix BUG: test FAILED due to recent change

Milo Spadacini <milo.spadacini@gmail.com>
    tools: gpio: fix debounce_period_us output of lsgpio

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: arm: add missing cache properties

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: vexpress: add missing cache properties

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() + schedule()

Hans de Goede <hdegoede@redhat.com>
    power: supply: sc27xx: Fix external_power_changed race

Hans de Goede <hdegoede@redhat.com>
    power: supply: ab8500: Fix external_power_changed race

Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
    of: overlay: Fix missing of_node_put() in error case of init_overlay_changeset()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: validate smb request protocol id

Manivannan Sadhasivam <mani@kernel.org>
    EDAC/qcom: Get rid of hardcoded register offsets

Manivannan Sadhasivam <mani@kernel.org>
    qcom: llcc/edac: Fix the base address used for accessing LLCC banks

Qi Zheng <zhengqi.arch@bytedance.com>
    cgroup: fix missing cpus_read_{lock,unlock}() in cgroup_transfer_tasks()

John Sperbeck <jsperbeck@google.com>
    cgroup: always put cset in cgroup_css_set_put_fork

Kamalesh Babulal <kamalesh.babulal@oracle.com>
    cgroup: bpf: use cgroup_lock()/cgroup_unlock() wrappers

Tom Lendacky <thomas.lendacky@amd.com>
    x86/head/64: Switch to KERNEL_CS as soon as new GDT is installed


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |   1 +
 arch/arm64/boot/dts/arm/foundation-v8.dtsi         |   1 +
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         |   1 +
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      |   1 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  11 +-
 arch/loongarch/kernel/perf_event.c                 |   6 +-
 arch/loongarch/kernel/unaligned.c                  |   2 +-
 arch/mips/Kconfig                                  |   1 +
 arch/mips/alchemy/common/dbdma.c                   |  27 +-
 arch/mips/kernel/cpu-probe.c                       |   5 +
 arch/mips/kernel/setup.c                           |   9 +-
 arch/nios2/boot/dts/10m50_devboard.dts             |   2 +-
 arch/nios2/boot/dts/3c120_devboard.dts             |   2 +-
 arch/parisc/include/asm/assembly.h                 |   4 -
 arch/parisc/kernel/pci-dma.c                       |  18 +-
 arch/powerpc/purgatory/Makefile                    |   5 +
 arch/riscv/purgatory/Makefile                      |   5 +
 arch/x86/kernel/head_64.S                          |  18 +-
 arch/x86/purgatory/Makefile                        |   5 +
 block/blk-cgroup.c                                 |  40 ++-
 drivers/block/xen-blkfront.c                       |   3 +-
 drivers/char/agp/parisc-agp.c                      |  15 +-
 drivers/clk/pxa/clk-pxa3xx.c                       |   2 +-
 drivers/edac/qcom_edac.c                           | 122 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  18 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c       |  60 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h       |  15 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 105 +++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |   6 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   8 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |   5 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  33 ++-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |   4 +
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |   2 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |   3 +
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   7 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  14 +-
 drivers/infiniband/core/cma.c                      |   4 +-
 drivers/infiniband/core/uverbs_cmd.c               |   7 +-
 drivers/infiniband/core/uverbs_main.c              |  12 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |   2 -
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |   7 +-
 drivers/infiniband/hw/bnxt_re/main.c               |   2 -
 drivers/infiniband/hw/mlx5/fs.c                    | 276 ++++++++++++++++++++-
 drivers/infiniband/hw/mlx5/fs.h                    |  16 ++
 drivers/infiniband/hw/mlx5/main.c                  |   3 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |  14 ++
 drivers/infiniband/hw/mlx5/qp.c                    |   3 +
 drivers/infiniband/sw/rxe/rxe_cq.c                 |   4 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |   6 +
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   7 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |   3 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |  16 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |  55 ++--
 drivers/infiniband/ulp/rtrs/rtrs.c                 |   4 +-
 drivers/irqchip/irq-gic-common.c                   |  10 +-
 drivers/irqchip/irq-gic-common.h                   |   1 +
 drivers/irqchip/irq-gic-v3.c                       |  20 ++
 drivers/irqchip/irq-meson-gpio.c                   |   2 +-
 drivers/md/dm-ioctl.c                              |   5 +-
 drivers/md/dm-thin-metadata.c                      |  20 +-
 drivers/md/dm-thin.c                               |   3 +-
 drivers/md/dm.c                                    |   4 +
 drivers/media/dvb-core/dvb_frontend.c              |  53 +---
 drivers/net/dsa/ocelot/felix_vsc9959.c             |   2 +-
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   |   4 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  15 +-
 drivers/net/ethernet/intel/iavf/iavf_register.h    |   2 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c          |  50 ++--
 drivers/net/ethernet/intel/ice/ice_gnss.h          |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  20 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   3 +
 drivers/net/ethernet/intel/igb/igb_main.c          |   8 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |  12 +-
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |   7 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   7 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.c   |  29 +--
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |  12 -
 drivers/net/ethernet/renesas/rswitch.c             |  36 +--
 drivers/net/ethernet/sfc/efx_channels.c            |   2 +
 drivers/net/ethernet/sfc/efx_devlink.c             |  95 ++++---
 drivers/net/ethernet/sfc/siena/efx_channels.c      |   2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   9 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   2 +-
 drivers/net/ipvlan/ipvlan_l3s.c                    |   4 +
 drivers/net/macsec.c                               |  12 +-
 drivers/net/phy/phylink.c                          |  41 ++-
 drivers/net/usb/qmi_wwan.c                         |   2 +
 drivers/net/wan/lapbether.c                        |   3 +
 drivers/nvme/host/pci.c                            |   2 +
 drivers/of/overlay.c                               |   1 +
 drivers/pci/quirks.c                               |   9 +-
 drivers/platform/x86/asus-nb-wmi.c                 |   2 +
 drivers/power/supply/ab8500_btemp.c                |   6 +-
 drivers/power/supply/ab8500_fg.c                   |   6 +-
 drivers/power/supply/bq27xxx_battery.c             |   6 +-
 drivers/power/supply/power_supply_core.c           |   8 +-
 drivers/power/supply/power_supply_sysfs.c          |   3 +-
 drivers/power/supply/sc27xx_fuel_gauge.c           |   9 +-
 drivers/regulator/core.c                           |   4 +-
 drivers/regulator/qcom-rpmh-regulator.c            |  85 +++++--
 drivers/s390/net/ism_drv.c                         |   8 -
 drivers/soc/qcom/llcc-qcom.c                       |  72 +++---
 drivers/spi/spi-cadence-quadspi.c                  |   7 +-
 drivers/spi/spi-fsl-dspi.c                         |  15 ++
 drivers/target/target_core_transport.c             |   2 +
 drivers/thunderbolt/dma_test.c                     |   8 +-
 drivers/thunderbolt/nhi.c                          |  11 +-
 drivers/thunderbolt/tb.c                           |  17 +-
 drivers/thunderbolt/tunnel.c                       |   2 +-
 drivers/tty/serial/fsl_lpuart.c                    |   2 +-
 drivers/tty/serial/lantiq.c                        |   1 +
 drivers/usb/dwc3/core.c                            |   5 +
 drivers/usb/dwc3/dwc3-qcom.c                       |  11 +-
 drivers/usb/dwc3/gadget.c                          |   1 +
 drivers/usb/gadget/udc/core.c                      | 180 ++++++++++----
 drivers/usb/gadget/udc/renesas_usb3.c              |   4 +-
 drivers/usb/serial/option.c                        |  16 ++
 drivers/usb/typec/pd.c                             |   2 +-
 drivers/usb/typec/ucsi/ucsi.c                      |  11 +-
 fs/afs/vl_probe.c                                  |   4 +-
 fs/btrfs/block-group.c                             |  14 +-
 fs/btrfs/disk-io.c                                 |  19 +-
 fs/btrfs/file-item.c                               |   4 +-
 fs/btrfs/inode.c                                   |  20 +-
 fs/btrfs/scrub.c                                   |   9 +-
 fs/btrfs/super.c                                   |   6 +
 fs/cifs/file.c                                     |   8 +-
 fs/erofs/Kconfig                                   |   1 +
 fs/erofs/zdata.c                                   |   2 -
 fs/eventpoll.c                                     |   6 +-
 fs/ext4/balloc.c                                   |  20 +-
 fs/ksmbd/connection.c                              |   5 +-
 fs/ksmbd/smb_common.c                              |  14 +-
 fs/nilfs2/btnode.c                                 |  12 +-
 fs/nilfs2/sufile.c                                 |   9 +
 fs/nilfs2/the_nilfs.c                              |  43 +++-
 fs/ocfs2/file.c                                    |   8 +-
 fs/ocfs2/super.c                                   |   6 +-
 fs/userfaultfd.c                                   |   5 +
 include/linux/mlx5/driver.h                        |  12 +
 include/linux/soc/qcom/llcc-qcom.h                 |  12 +-
 include/media/dvb_frontend.h                       |   6 +-
 include/net/neighbour.h                            |   2 -
 include/net/netfilter/nf_flow_table.h              |   2 +-
 include/net/netfilter/nf_tables.h                  |   4 +-
 include/net/sch_generic.h                          |   8 +
 include/rdma/ib_addr.h                             |  23 --
 include/sound/soc-acpi.h                           |   1 +
 include/sound/soc-dpcm.h                           |   4 +
 include/uapi/linux/ethtool_netlink.h               |   2 +-
 io_uring/net.c                                     |   8 +-
 io_uring/sqpoll.c                                  |   6 +-
 kernel/bpf/cgroup.c                                |  38 +--
 kernel/bpf/cgroup_iter.c                           |   4 +-
 kernel/bpf/local_storage.c                         |   4 +-
 kernel/cgroup/cgroup-v1.c                          |  20 +-
 kernel/cgroup/cgroup.c                             |  77 +++---
 kernel/kexec_file.c                                |  14 +-
 mm/damon/core.c                                    |   2 +
 mm/gup_test.c                                      |   1 +
 mm/zswap.c                                         |  11 +-
 net/core/neighbour.c                               |  31 ---
 net/ipv6/ping.c                                    |   3 +-
 net/mac80211/cfg.c                                 |   9 +-
 net/mac80211/ieee80211_i.h                         |   2 +-
 net/mac80211/link.c                                |   4 +-
 net/mac80211/mlme.c                                |   5 +-
 net/mac80211/util.c                                |   4 +-
 net/netfilter/nf_flow_table_core.c                 |  13 +-
 net/netfilter/nf_flow_table_ip.c                   |   4 +-
 net/netfilter/nf_tables_api.c                      |  59 ++++-
 net/netfilter/nfnetlink.c                          |   3 +-
 net/netfilter/nft_set_pipapo.c                     |  55 ++--
 net/sched/act_ct.c                                 |   9 +-
 net/sched/act_pedit.c                              |  45 +++-
 net/sched/cls_api.c                                |  12 +-
 net/sched/cls_u32.c                                |  18 +-
 net/sched/sch_api.c                                |  44 +++-
 net/sched/sch_generic.c                            |  14 +-
 net/sched/sch_taprio.c                             |   3 +
 net/sctp/sm_statefuns.c                            |   2 +-
 net/tipc/bearer.c                                  |   4 +-
 net/wireless/rdev-ops.h                            |   6 +-
 net/wireless/reg.c                                 |   7 +-
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/soc/codecs/cs35l41-lib.c                     |   6 +-
 sound/soc/dwc/dwc-i2s.c                            |  41 +--
 sound/soc/intel/avs/avs.h                          |   4 +-
 sound/soc/intel/avs/board_selection.c              |   2 +-
 sound/soc/intel/avs/dsp.c                          |   4 +-
 sound/soc/intel/avs/path.h                         |   2 +-
 sound/soc/intel/avs/pcm.c                          |  23 +-
 sound/soc/intel/avs/probes.c                       |   2 +-
 sound/soc/soc-pcm.c                                |  20 ++
 sound/usb/pcm.c                                    |   4 +
 sound/usb/quirks.c                                 |   2 +
 tools/gpio/lsgpio.c                                |   2 +-
 tools/testing/selftests/gpio/gpio-sim.sh           |   3 +
 .../selftests/net/forwarding/hw_stats_l3.sh        |  11 +-
 tools/testing/selftests/ptp/testptp.c              |   6 +-
 tools/testing/selftests/tc-testing/config          |   1 +
 .../selftests/tc-testing/tc-tests/qdiscs/sfb.json  |   4 +-
 tools/testing/selftests/tc-testing/tdc.sh          |   1 +
 211 files changed, 2103 insertions(+), 940 deletions(-)


