Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE17C73542D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjFSKxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjFSKwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:52:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787DA1732;
        Mon, 19 Jun 2023 03:51:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90A826068B;
        Mon, 19 Jun 2023 10:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA94C433C0;
        Mon, 19 Jun 2023 10:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171895;
        bh=2YnzpfQnf8Zt7l0b7KPG/XQIKetC8REE16fdY1DxS8Q=;
        h=From:To:Cc:Subject:Date:From;
        b=Po6T2dMjScWGoZLzf9rRjl18k7TZsk1cbL2pw2HVfuRCOQJkyphb5NwjFsies96gd
         cPi4H3hrULvMt0rknaFJFTFZavDraoO7g9jhxemOXDC3sf2MWUijqT+aMDap+ZveBf
         HXd24eYHD+sr6Hm0mJHFxe0VJ9dZknauCg+werlg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.4 00/64] 5.4.248-rc1 review
Date:   Mon, 19 Jun 2023 12:29:56 +0200
Message-ID: <20230619102132.808972458@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.248-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.248-rc1
X-KernelTest-Deadline: 2023-06-21T10:21+00:00
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

This is the start of the stable review cycle for the 5.4.248 release.
There are 64 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.248-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.248-rc1

Christian Loehle <CLoehle@hyperstone.com>
    mmc: block: ensure error propagation for non-blk

Alexander Kapshuk <alexander.kapshuk@gmail.com>
    drm/nouveau/kms: Fix NULL pointer dereference in nouveau_connector_detect_depth

Leon Romanovsky <leonro@nvidia.com>
    neighbour: delete neigh_lookup_nodev as not used

Gaosheng Cui <cuigaosheng1@huawei.com>
    net: Remove unused inline function dst_hold_and_use()

Gaosheng Cui <cuigaosheng1@huawei.com>
    neighbour: Remove unused inline function neigh_key_eq16()

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

Natalia Petrova <n.petrova@fintech.ru>
    drm/nouveau: add nv_encoder pointer check for NULL

Lyude Paul <lyude@redhat.com>
    drm/nouveau/kms: Don't change EDID when it hasn't actually changed

Natalia Petrova <n.petrova@fintech.ru>
    drm/nouveau/dp: check for NULL nv_connector->native_mode

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

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nfnetlink: skip error delivery on batch in case of ENOMEM

Vladimir Oltean <vladimir.oltean@nxp.com>
    spi: fsl-dspi: avoid SCK glitches with continuous transfers

Vladimir Oltean <vladimir.oltean@nxp.com>
    spi: spi-fsl-dspi: Remove unused chip->void_write_data

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

Sukrut Bellary <sukrut.bellary@linux.com>
    drm:amd:amdgpu: Fix missing buffer object unlock in failure path

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen/blkfront: Only check REQ_FUA for writes

Liviu Dudau <liviu@dudau.co.uk>
    mips: Move initrd_start check after initrd address sanitisation.

Manuel Lauss <manuel.lauss@gmail.com>
    MIPS: Alchemy: fix dbdma2

Helge Deller <deller@gmx.de>
    parisc: Flush gatt writes and adjust gatt mask in parisc_agp_mask_memory()

Helge Deller <deller@gmx.de>
    parisc: Improve cache flushing for PCXL in arch_sync_dma_for_cpu()

Johannes Thumshirn <johannes.thumshirn@wdc.com>
    btrfs: handle memory allocation failure in btrfs_csum_one_bio

Mario Limonciello <mario.limonciello@amd.com>
    power: supply: Fix logic checking if system is running from battery

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    irqchip/meson-gpio: Mark OF related data as maybe unused

Osama Muhammad <osmtendev@gmail.com>
    regulator: Fix error checking for debugfs_create_dir

Alexandru Sorodoc <ealex95@gmail.com>
    platform/x86: asus-wmi: Ignore WMI events with codes 0x7B, 0xC0

Marek Vasut <marex@denx.de>
    power: supply: Ratelimit no data debug output

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: vexpress: add missing cache properties

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() + schedule()

Hans de Goede <hdegoede@redhat.com>
    power: supply: sc27xx: Fix external_power_changed race

Hans de Goede <hdegoede@redhat.com>
    power: supply: ab8500: Fix external_power_changed race

Jan Höppner <hoeppner@linux.ibm.com>
    s390/dasd: Use correct lock while counting channel queue length

Christoph Hellwig <hch@lst.de>
    dasd: refactor dasd_ioctl_information

Roberto Sassu <roberto.sassu@huawei.com>
    KEYS: asymmetric: Copy sig and digest in public_key_verify_signature()

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: fix a memory leak with reqs buffer


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt |    4 -
 Documentation/admin-guide/sysctl/net.rst        |   15 +-
 Documentation/ioctl/ioctl-number.rst            |    1 -
 Documentation/networking/decnet.txt             |  230 ---
 MAINTAINERS                                     |    7 -
 Makefile                                        |    4 +-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts         |    1 +
 arch/mips/alchemy/common/dbdma.c                |   27 +-
 arch/mips/configs/decstation_64_defconfig       |    2 -
 arch/mips/configs/decstation_defconfig          |    2 -
 arch/mips/configs/decstation_r4k_defconfig      |    2 -
 arch/mips/configs/gpr_defconfig                 |    2 -
 arch/mips/configs/jazz_defconfig                |    2 -
 arch/mips/configs/mtx1_defconfig                |    2 -
 arch/mips/configs/nlm_xlp_defconfig             |    2 -
 arch/mips/configs/nlm_xlr_defconfig             |    2 -
 arch/mips/configs/rm200_defconfig               |    2 -
 arch/mips/kernel/setup.c                        |    9 +-
 arch/nios2/boot/dts/10m50_devboard.dts          |    2 +-
 arch/nios2/boot/dts/3c120_devboard.dts          |    2 +-
 arch/parisc/kernel/pci-dma.c                    |   18 +-
 arch/powerpc/configs/ppc6xx_defconfig           |    2 -
 arch/powerpc/purgatory/Makefile                 |    5 +
 crypto/asymmetric_keys/public_key.c             |   36 +-
 drivers/block/xen-blkfront.c                    |    3 +-
 drivers/char/agp/parisc-agp.c                   |   15 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c          |    4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c           |    4 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c     |   67 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c           |   14 +-
 drivers/infiniband/core/uverbs_cmd.c            |    7 +-
 drivers/infiniband/core/uverbs_main.c           |   12 +-
 drivers/infiniband/sw/rxe/rxe_qp.c              |   16 +-
 drivers/infiniband/sw/rxe/rxe_task.c            |    5 +-
 drivers/infiniband/sw/rxe/rxe_task.h            |    5 +-
 drivers/infiniband/ulp/isert/ib_isert.c         |   16 +-
 drivers/irqchip/irq-meson-gpio.c                |    2 +-
 drivers/mmc/core/block.c                        |    5 +
 drivers/net/ethernet/intel/iavf/iavf.h          |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c     |   15 +-
 drivers/net/ethernet/intel/iavf/iavf_register.h |    2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c    |    3 +
 drivers/net/ipvlan/ipvlan_l3s.c                 |    4 +
 drivers/net/usb/qmi_wwan.c                      |    2 +
 drivers/net/wan/lapbether.c                     |    3 +
 drivers/platform/x86/asus-nb-wmi.c              |    2 +
 drivers/power/supply/ab8500_btemp.c             |    6 +-
 drivers/power/supply/ab8500_fg.c                |    6 +-
 drivers/power/supply/bq27xxx_battery.c          |    6 +-
 drivers/power/supply/power_supply_core.c        |    8 +-
 drivers/power/supply/power_supply_sysfs.c       |    3 +-
 drivers/power/supply/sc27xx_fuel_gauge.c        |    9 +-
 drivers/regulator/core.c                        |    4 +-
 drivers/s390/block/dasd_ioctl.c                 |   46 +-
 drivers/spi/spi-fsl-dspi.c                      |   19 +-
 drivers/tty/serial/lantiq.c                     |    1 +
 drivers/usb/dwc3/gadget.c                       |    1 +
 drivers/usb/serial/option.c                     |   16 +
 fs/afs/vl_probe.c                               |    4 +-
 fs/btrfs/file-item.c                            |    4 +-
 fs/nilfs2/btnode.c                              |   12 +-
 fs/nilfs2/sufile.c                              |    9 +
 fs/ocfs2/file.c                                 |    8 +-
 fs/ocfs2/super.c                                |    6 +-
 include/linux/netdevice.h                       |    4 -
 include/linux/netfilter.h                       |    5 -
 include/linux/netfilter_defs.h                  |    8 -
 include/net/dn.h                                |  231 ---
 include/net/dn_dev.h                            |  199 --
 include/net/dn_fib.h                            |  167 --
 include/net/dn_neigh.h                          |   30 -
 include/net/dn_nsp.h                            |  195 --
 include/net/dn_route.h                          |  115 --
 include/net/dst.h                               |    6 -
 include/net/neighbour.h                         |    7 -
 include/net/netns/netfilter.h                   |    3 -
 include/uapi/linux/dn.h                         |  149 --
 include/uapi/linux/netfilter_decnet.h           |   72 -
 include/uapi/linux/netlink.h                    |    2 +-
 kernel/kexec_file.c                             |   14 +-
 lib/test_firmware.c                             |   10 +
 net/Kconfig                                     |    2 -
 net/Makefile                                    |    1 -
 net/core/dev.c                                  |    4 +-
 net/core/neighbour.c                            |   34 -
 net/decnet/Kconfig                              |   43 -
 net/decnet/Makefile                             |   10 -
 net/decnet/README                               |    8 -
 net/decnet/af_decnet.c                          | 2400 -----------------------
 net/decnet/dn_dev.c                             | 1438 --------------
 net/decnet/dn_fib.c                             |  799 --------
 net/decnet/dn_neigh.c                           |  605 ------
 net/decnet/dn_nsp_in.c                          |  906 ---------
 net/decnet/dn_nsp_out.c                         |  695 -------
 net/decnet/dn_route.c                           | 1921 ------------------
 net/decnet/dn_rules.c                           |  258 ---
 net/decnet/dn_table.c                           |  929 ---------
 net/decnet/dn_timer.c                           |  104 -
 net/decnet/netfilter/Kconfig                    |   17 -
 net/decnet/netfilter/Makefile                   |    6 -
 net/decnet/netfilter/dn_rtmsg.c                 |  158 --
 net/decnet/sysctl_net_decnet.c                  |  373 ----
 net/ipv6/ping.c                                 |    3 +-
 net/netfilter/core.c                            |   10 -
 net/netfilter/nfnetlink.c                       |    3 +-
 net/sched/cls_api.c                             |   12 +-
 net/sched/cls_u32.c                             |   18 +-
 net/sctp/sm_statefuns.c                         |    2 +-
 net/tipc/bearer.c                               |    4 +-
 sound/pci/hda/patch_realtek.c                   |    1 +
 tools/testing/selftests/ptp/testptp.c           |    6 +-
 111 files changed, 364 insertions(+), 12380 deletions(-)


