Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFE973546B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjFSK4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjFSKzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:55:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792543C2D;
        Mon, 19 Jun 2023 03:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEA7260B89;
        Mon, 19 Jun 2023 10:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FF7C433C0;
        Mon, 19 Jun 2023 10:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172023;
        bh=iLkKsC+996qrSa54wPM9of61h2TgVUMFK0TPQJd5Cks=;
        h=From:To:Cc:Subject:Date:From;
        b=Jg14AvjVTGrYrxfjKg8QAIglJpuog3GR3lErl6h65CHgFduApGr7s3CyYIUy6pnAd
         pRKIPIXXmXwW1CES58b4rh5L2KDz/IVKox5Q5F0NiiGf0sti9A+JRvCnYGvYcyaoe5
         Y917Sz5+FC3htIMJ97OEj06/W0jJy+esDiESV4t4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.10 00/89] 5.10.185-rc1 review
Date:   Mon, 19 Jun 2023 12:29:48 +0200
Message-ID: <20230619102138.279161276@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.185-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.185-rc1
X-KernelTest-Deadline: 2023-06-21T10:21+00:00
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

This is the start of the stable review cycle for the 5.10.185 release.
There are 89 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.185-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.185-rc1

Johannes Berg <johannes.berg@intel.com>
    um: Fix build w/o CONFIG_PM_SLEEP

José Roberto de Souza <jose.souza@intel.com>
    drm/i915/gen11+: Only load DRAM information from pcode

Matt Roper <matthew.d.roper@intel.com>
    drm/i915/dg1: Wait for pcode/uncore handshake at startup

Hyunwoo Kim <imv4bel@gmail.com>
    media: dvb-core: Fix use-after-free due to race at dvb_register_device()

Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    media: dvbdev: fix error logic at dvb_register_device()

Dinghao Liu <dinghao.liu@zju.edu.cn>
    media: dvbdev: Fix memleak in dvb_register_device

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: reject devices with insufficient block count

David Hildenbrand <david@redhat.com>
    mm/memory_hotplug: extend offline_and_remove_memory() to handle more than one memory block

Christian Loehle <CLoehle@hyperstone.com>
    mmc: block: ensure error propagation for non-blk

Sven Eckelmann <sven@narfation.org>
    batman-adv: Switch to kstrtox.h for kstrtou64

Leon Romanovsky <leon@kernel.org>
    neighbour: delete neigh_lookup_nodev as not used

Guillaume Nault <gnault@redhat.com>
    net: Remove DECnet leftovers from flow.h.

Gaosheng Cui <cuigaosheng1@huawei.com>
    net: Remove unused inline function dst_hold_and_use()

Gaosheng Cui <cuigaosheng1@huawei.com>
    neighbour: Remove unused inline function neigh_key_eq16()

Ziwei Dai <ziwei.dai@unisoc.com>
    rcu/kvfree: Avoid freeing new kfree_rcu() memory after old grace period

John Sperbeck <jsperbeck@google.com>
    cgroup: always put cset in cgroup_css_set_put_fork

David Howells <dhowells@redhat.com>
    afs: Fix vlserver probe RTT handling

Alex Maftei <alex.maftei@amd.com>
    selftests/ptp: Fix timestamp printf format for PTP_SYS_OFFSET

Lin Ma <linma@zju.edu.cn>
    net: tipc: resize nlattr array to correct size

Eric Dumazet <edumazet@google.com>
    net: lapbether: only support ethernet devices

Vlad Buslov <vladbu@nvidia.com>
    net/sched: cls_api: Fix lockup on flushing explicitly created chain

Fabio M. De Francesco <fmdefrancesco@gmail.com>
    ext4: drop the call to ext4_error() from ext4_get_group_info()

Natalia Petrova <n.petrova@fintech.ru>
    drm/nouveau: add nv_encoder pointer check for NULL

Natalia Petrova <n.petrova@fintech.ru>
    drm/nouveau/dp: check for NULL nv_connector->native_mode

Ratchanan Srirattanamet <peathot@hotmail.com>
    drm/nouveau: don't detect DSM for non-NVIDIA device

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    igb: fix nvm.ops.read() error handling

Dan Carpenter <dan.carpenter@linaro.org>
    sctp: fix an error code in sctp_sf_eat_auth()

Hangbin Liu <liuhangbin@gmail.com>
    ipvlan: fix bound dev checking for IPv6 l3s mode

Saravanan Vajravel <saravanan.vajravel@broadcom.com>
    IB/isert: Fix incorrect release of isert connection

Saravanan Vajravel <saravanan.vajravel@broadcom.com>
    IB/isert: Fix possible list corruption in CMA handler

Saravanan Vajravel <saravanan.vajravel@broadcom.com>
    IB/isert: Fix dead lock in ib_isert

Yishai Hadas <yishaih@nvidia.com>
    IB/uverbs: Fix to consider event queue closing also upon non-blocking mode

Mark Zhang <markzhang@nvidia.com>
    RDMA/cma: Always set static rate to 0 for RoCE

Maher Sanalla <msanalla@nvidia.com>
    RDMA/mlx5: Initiate dropless RQ for RAW Ethernet functions

Satha Rao <skoteshwar@marvell.com>
    octeontx2-af: fixed resource availability check

Ahmed Zaki <ahmed.zaki@intel.com>
    iavf: remove mask from iavf_irq_enable_queues()

Zhu Yanjun <yanjun.zhu@linux.dev>
    RDMA/rxe: Fix the use-before-initialization error of resp_pkts

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Removed unused name from rxe_task struct

Zhu Yanjun <yanjun.zhu@linux.dev>
    RDMA/rxe: Remove the unused variable obj

Lee Jones <lee@kernel.org>
    net/sched: cls_u32: Fix reference counter leak leading to overflow

Guillaume Nault <gnault@redhat.com>
    ping6: Fix send to link-local addresses with VRF.

Wei Fang <wei.fang@nxp.com>
    net: enetc: correct the indexes of highest and 2nd highest TCs

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nfnetlink: skip error delivery on batch in case of ENOMEM

Vladimir Oltean <vladimir.oltean@nxp.com>
    spi: fsl-dspi: avoid SCK glitches with continuous transfers

Li Zhijian <lizhijian@fujitsu.com>
    RDMA/rtrs: Fix the last iu->buf leak in err path

Elson Roy Serrao <quic_eserrao@quicinc.com>
    usb: dwc3: gadget: Reset num TRBs before giving back the request

Bernhard Seibold <mail@bernhard-seibold.de>
    serial: lantiq: add missing interrupt ack

Jerry Meng <jerry-meng@foxmail.com>
    USB: serial: option: add Quectel EM061KGL series

Stephen Hemminger <stephen@networkplumber.org>
    Remove DECnet support from kernel

Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
    ALSA: hda/realtek: Add a quirk for Compaq N14JP6

Wes Huang <wes.huang@moxa.com>
    net: usb: qmi_wwan: add support for Compal RXM-G1

Edward Srouji <edwards@nvidia.com>
    RDMA/uverbs: Restrict usage of privileged QKEYs

Dave Airlie <airlied@redhat.com>
    nouveau: fix client work fence deletion race

Ricardo Ribalda <ribalda@chromium.org>
    powerpc/purgatory: remove PGO flags

Ricardo Ribalda <ribalda@chromium.org>
    x86/purgatory: remove PGO flags

Ricardo Ribalda <ribalda@chromium.org>
    kexec: support purgatories with .text.hot sections

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix possible out-of-bounds segment allocation in resize ioctl

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix incomplete buffer cleanup in nilfs_btnode_abort_change_key()

Janne Grunau <j@jannau.net>
    nios2: dts: Fix tse_mac "max-frame-size" property

Luís Henriques <ocfs2-devel@oss.oracle.com>
    ocfs2: check new file size on fallocate call

Luís Henriques <ocfs2-devel@oss.oracle.com>
    ocfs2: fix use-after-free when unmounting read-only filesystem

Benjamin Segall <bsegall@google.com>
    epoll: ep_autoremove_wake_function should use list_del_init_careful

Jens Axboe <axboe@kernel.dk>
    io_uring: hold uring mutex around poll removal

Marc Zyngier <maz@kernel.org>
    irqchip/gic: Correctly validate OF quirk descriptors

Sukrut Bellary <sukrut.bellary@linux.com>
    drm:amd:amdgpu: Fix missing buffer object unlock in failure path

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen/blkfront: Only check REQ_FUA for writes

Maxim Kochetkov <fido_max@inbox.ru>
    ASoC: dwc: move DMA init to snd_soc_dai_driver probe()

Liviu Dudau <liviu@dudau.co.uk>
    mips: Move initrd_start check after initrd address sanitisation.

Manuel Lauss <manuel.lauss@gmail.com>
    MIPS: Alchemy: fix dbdma2

Helge Deller <deller@gmx.de>
    parisc: Flush gatt writes and adjust gatt mask in parisc_agp_mask_memory()

Helge Deller <deller@gmx.de>
    parisc: Improve cache flushing for PCXL in arch_sync_dma_for_cpu()

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ASoC: soc-pcm: test if a BE can be prepared

Johannes Thumshirn <johannes.thumshirn@wdc.com>
    btrfs: handle memory allocation failure in btrfs_csum_one_bio

Qu Wenruo <wqu@suse.com>
    btrfs: scrub: try harder to mark RAID56 block groups read-only

Mario Limonciello <mario.limonciello@amd.com>
    power: supply: Fix logic checking if system is running from battery

Douglas Anderson <dianders@chromium.org>
    irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware issues

Osama Muhammad <osmtendev@gmail.com>
    regulator: Fix error checking for debugfs_create_dir

Alexandru Sorodoc <ealex95@gmail.com>
    platform/x86: asus-wmi: Ignore WMI events with codes 0x7B, 0xC0

Marek Vasut <marex@denx.de>
    power: supply: Ratelimit no data debug output

Milo Spadacini <milo.spadacini@gmail.com>
    tools: gpio: fix debounce_period_us output of lsgpio

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: vexpress: add missing cache properties

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() + schedule()

Hans de Goede <hdegoede@redhat.com>
    power: supply: sc27xx: Fix external_power_changed race

Hans de Goede <hdegoede@redhat.com>
    power: supply: ab8500: Fix external_power_changed race

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: fix a memory leak with reqs buffer

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: prevent race conditions by a correct implementation of locking

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    test_firmware: Use kstrtobool() instead of strtobool()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    kernel.h: split out kstrtox() and simple_strtox() to a separate header

Alexey Dobriyan <adobriyan@gmail.com>
    lib: cleanup kstrto*() usage


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt    |    4 -
 Documentation/admin-guide/sysctl/net.rst           |   15 +-
 Documentation/core-api/kernel-api.rst              |    7 +-
 Documentation/networking/decnet.rst                |  243 --
 Documentation/networking/index.rst                 |    1 -
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 -
 MAINTAINERS                                        |    7 -
 Makefile                                           |    4 +-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |    1 +
 arch/mips/alchemy/common/dbdma.c                   |   27 +-
 arch/mips/configs/decstation_64_defconfig          |    2 -
 arch/mips/configs/decstation_defconfig             |    2 -
 arch/mips/configs/decstation_r4k_defconfig         |    2 -
 arch/mips/configs/gpr_defconfig                    |    2 -
 arch/mips/configs/mtx1_defconfig                   |    2 -
 arch/mips/configs/nlm_xlp_defconfig                |    2 -
 arch/mips/configs/nlm_xlr_defconfig                |    2 -
 arch/mips/configs/rm200_defconfig                  |    2 -
 arch/mips/kernel/setup.c                           |    9 +-
 arch/nios2/boot/dts/10m50_devboard.dts             |    2 +-
 arch/nios2/boot/dts/3c120_devboard.dts             |    2 +-
 arch/parisc/kernel/pci-dma.c                       |   18 +-
 arch/powerpc/configs/ppc6xx_defconfig              |    2 -
 arch/powerpc/purgatory/Makefile                    |    5 +
 arch/um/kernel/um_arch.c                           |    2 +-
 arch/x86/purgatory/Makefile                        |    5 +
 drivers/block/xen-blkfront.c                       |    3 +-
 drivers/char/agp/parisc-agp.c                      |   15 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |    4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    4 +-
 drivers/gpu/drm/i915/display/intel_bw.c            |   80 +-
 drivers/gpu/drm/i915/i915_drv.c                    |    4 +
 drivers/gpu/drm/i915/i915_drv.h                    |    1 +
 drivers/gpu/drm/i915/i915_reg.h                    |    3 +
 drivers/gpu/drm/i915/intel_dram.c                  |   82 +-
 drivers/gpu/drm/i915/intel_sideband.c              |   15 +
 drivers/gpu/drm/i915/intel_sideband.h              |    2 +
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |    3 +
 drivers/gpu/drm/nouveau/nouveau_connector.c        |    7 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   14 +-
 drivers/infiniband/core/cma.c                      |    4 +-
 drivers/infiniband/core/uverbs_cmd.c               |    7 +-
 drivers/infiniband/core/uverbs_main.c              |   12 +-
 drivers/infiniband/hw/mlx5/main.c                  |    3 +
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   16 +-
 drivers/infiniband/sw/rxe/rxe_task.c               |    5 +-
 drivers/infiniband/sw/rxe/rxe_task.h               |    5 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |   16 +-
 drivers/infiniband/ulp/rtrs/rtrs.c                 |    4 +-
 drivers/irqchip/irq-gic-common.c                   |   10 +-
 drivers/irqchip/irq-gic-common.h                   |    1 +
 drivers/irqchip/irq-gic-v3.c                       |   20 +
 drivers/media/dvb-core/dvbdev.c                    |   88 +-
 drivers/mmc/core/block.c                           |    5 +
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   |    4 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   15 +-
 drivers/net/ethernet/intel/iavf/iavf_register.h    |    2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |    3 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |    3 +-
 drivers/net/ipvlan/ipvlan_l3s.c                    |    4 +
 drivers/net/usb/qmi_wwan.c                         |    2 +
 drivers/net/wan/lapbether.c                        |    3 +
 drivers/platform/x86/asus-nb-wmi.c                 |    2 +
 drivers/power/supply/ab8500_btemp.c                |    6 +-
 drivers/power/supply/ab8500_fg.c                   |    6 +-
 drivers/power/supply/bq27xxx_battery.c             |    6 +-
 drivers/power/supply/power_supply_core.c           |    8 +-
 drivers/power/supply/power_supply_sysfs.c          |    3 +-
 drivers/power/supply/sc27xx_fuel_gauge.c           |    9 +-
 drivers/regulator/core.c                           |    4 +-
 drivers/spi/spi-fsl-dspi.c                         |   15 +
 drivers/tty/serial/lantiq.c                        |    1 +
 drivers/usb/dwc3/gadget.c                          |    1 +
 drivers/usb/serial/option.c                        |   16 +
 fs/afs/vl_probe.c                                  |    4 +-
 fs/btrfs/block-group.c                             |   14 +-
 fs/btrfs/file-item.c                               |    4 +-
 fs/btrfs/scrub.c                                   |    9 +-
 fs/eventpoll.c                                     |    6 +-
 fs/ext4/balloc.c                                   |   20 +-
 fs/nilfs2/btnode.c                                 |   12 +-
 fs/nilfs2/sufile.c                                 |    9 +
 fs/nilfs2/the_nilfs.c                              |   44 +-
 fs/ocfs2/file.c                                    |    8 +-
 fs/ocfs2/super.c                                   |    6 +-
 include/linux/kernel.h                             |  143 +-
 include/linux/kstrtox.h                            |  155 ++
 include/linux/netdevice.h                          |    4 -
 include/linux/netfilter.h                          |    5 -
 include/linux/netfilter_defs.h                     |    8 -
 include/linux/string.h                             |    7 -
 include/linux/sunrpc/cache.h                       |    1 +
 include/media/dvbdev.h                             |   15 +
 include/net/dn.h                                   |  231 --
 include/net/dn_dev.h                               |  199 --
 include/net/dn_fib.h                               |  167 --
 include/net/dn_neigh.h                             |   30 -
 include/net/dn_nsp.h                               |  195 --
 include/net/dn_route.h                             |  115 -
 include/net/dst.h                                  |    6 -
 include/net/flow.h                                 |   26 -
 include/net/neighbour.h                            |    7 -
 include/net/netns/netfilter.h                      |    3 -
 include/rdma/ib_addr.h                             |   23 -
 include/sound/soc-dpcm.h                           |    4 +
 include/uapi/linux/dn.h                            |  149 --
 include/uapi/linux/netfilter_decnet.h              |   72 -
 include/uapi/linux/netlink.h                       |    2 +-
 io_uring/io_uring.c                                |    3 +
 kernel/cgroup/cgroup.c                             |   17 +-
 kernel/kexec_file.c                                |   14 +-
 kernel/rcu/tree.c                                  |   49 +-
 lib/kstrtox.c                                      |    5 +-
 lib/parser.c                                       |    1 +
 lib/test_firmware.c                                |   72 +-
 lib/test_kmod.c                                    |   26 +-
 mm/memory_hotplug.c                                |  105 +-
 net/Kconfig                                        |    2 -
 net/Makefile                                       |    1 -
 net/batman-adv/gateway_common.c                    |    2 +-
 net/core/dev.c                                     |    4 +-
 net/core/neighbour.c                               |   34 -
 net/decnet/Kconfig                                 |   43 -
 net/decnet/Makefile                                |   10 -
 net/decnet/README                                  |    8 -
 net/decnet/af_decnet.c                             | 2400 --------------------
 net/decnet/dn_dev.c                                | 1435 ------------
 net/decnet/dn_fib.c                                |  799 -------
 net/decnet/dn_neigh.c                              |  605 -----
 net/decnet/dn_nsp_in.c                             |  906 --------
 net/decnet/dn_nsp_out.c                            |  695 ------
 net/decnet/dn_route.c                              | 1923 ----------------
 net/decnet/dn_rules.c                              |  258 ---
 net/decnet/dn_table.c                              |  929 --------
 net/decnet/dn_timer.c                              |  104 -
 net/decnet/netfilter/Kconfig                       |   17 -
 net/decnet/netfilter/Makefile                      |    6 -
 net/decnet/netfilter/dn_rtmsg.c                    |  158 --
 net/decnet/sysctl_net_decnet.c                     |  362 ---
 net/ipv6/ping.c                                    |    3 +-
 net/netfilter/core.c                               |   10 -
 net/netfilter/nfnetlink.c                          |    3 +-
 net/sched/cls_api.c                                |   12 +-
 net/sched/cls_u32.c                                |   18 +-
 net/sctp/sm_statefuns.c                            |    2 +-
 net/tipc/bearer.c                                  |    4 +-
 sound/pci/hda/patch_realtek.c                      |    1 +
 sound/soc/dwc/dwc-i2s.c                            |   41 +-
 sound/soc/soc-pcm.c                                |   20 +
 tools/gpio/lsgpio.c                                |    2 +-
 tools/testing/selftests/ptp/testptp.c              |    6 +-
 152 files changed, 993 insertions(+), 12744 deletions(-)


