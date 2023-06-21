Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A754D7385F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjFUN6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjFUN6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:58:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A91BC8;
        Wed, 21 Jun 2023 06:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCDA56150F;
        Wed, 21 Jun 2023 13:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA146C433CA;
        Wed, 21 Jun 2023 13:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687355902;
        bh=SDD2WniZsdH1ytGS8CoEI88JNPxwgiR/ovanZ9v4IK0=;
        h=From:To:Cc:Subject:Date:From;
        b=C1KE2X9TSiDxSnHrexxT+zYJAx7n0EKqXabcgvuLdiq1obWrUPNpib26uGzDcAwuS
         lziN+B9468CFAZBH/YQD9WyaN8OhHz7yBYa5NrQiGGroFL77Zj5y7uo/vvHVvu1sKC
         eBrqZZQ6+NVtq9KD8jkkjDP9h+hB53oniG9ahXds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.248
Date:   Wed, 21 Jun 2023 15:58:08 +0200
Message-ID: <2023062109-musky-undermine-f14a@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

I'm announcing the release of the 5.4.248 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt |    4 
 Documentation/admin-guide/sysctl/net.rst        |   15 
 Documentation/ioctl/ioctl-number.rst            |    1 
 Documentation/networking/decnet.txt             |  230 --
 MAINTAINERS                                     |    7 
 Makefile                                        |    2 
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts         |    1 
 arch/mips/alchemy/common/dbdma.c                |   27 
 arch/mips/configs/decstation_64_defconfig       |    2 
 arch/mips/configs/decstation_defconfig          |    2 
 arch/mips/configs/decstation_r4k_defconfig      |    2 
 arch/mips/configs/gpr_defconfig                 |    2 
 arch/mips/configs/jazz_defconfig                |    2 
 arch/mips/configs/mtx1_defconfig                |    2 
 arch/mips/configs/nlm_xlp_defconfig             |    2 
 arch/mips/configs/nlm_xlr_defconfig             |    2 
 arch/mips/configs/rm200_defconfig               |    2 
 arch/mips/kernel/setup.c                        |    9 
 arch/nios2/boot/dts/10m50_devboard.dts          |    2 
 arch/nios2/boot/dts/3c120_devboard.dts          |    2 
 arch/parisc/kernel/pci-dma.c                    |   18 
 arch/powerpc/configs/ppc6xx_defconfig           |    2 
 arch/powerpc/purgatory/Makefile                 |    5 
 crypto/asymmetric_keys/public_key.c             |   36 
 drivers/block/xen-blkfront.c                    |    3 
 drivers/char/agp/parisc-agp.c                   |   15 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c          |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c           |    4 
 drivers/gpu/drm/nouveau/nouveau_connector.c     |   67 
 drivers/gpu/drm/nouveau/nouveau_drm.c           |   14 
 drivers/infiniband/core/uverbs_cmd.c            |    7 
 drivers/infiniband/core/uverbs_main.c           |   12 
 drivers/infiniband/sw/rxe/rxe_qp.c              |   16 
 drivers/infiniband/sw/rxe/rxe_task.c            |    5 
 drivers/infiniband/sw/rxe/rxe_task.h            |    5 
 drivers/infiniband/ulp/isert/ib_isert.c         |   16 
 drivers/irqchip/irq-meson-gpio.c                |    2 
 drivers/mmc/core/block.c                        |    5 
 drivers/net/ethernet/intel/iavf/iavf.h          |    2 
 drivers/net/ethernet/intel/iavf/iavf_main.c     |   15 
 drivers/net/ethernet/intel/iavf/iavf_register.h |    2 
 drivers/net/ethernet/intel/igb/igb_ethtool.c    |    3 
 drivers/net/ipvlan/ipvlan_l3s.c                 |    4 
 drivers/net/usb/qmi_wwan.c                      |    2 
 drivers/net/wan/lapbether.c                     |    3 
 drivers/platform/x86/asus-nb-wmi.c              |    2 
 drivers/power/supply/ab8500_btemp.c             |    6 
 drivers/power/supply/ab8500_fg.c                |    6 
 drivers/power/supply/bq27xxx_battery.c          |    6 
 drivers/power/supply/power_supply_core.c        |    8 
 drivers/power/supply/power_supply_sysfs.c       |    3 
 drivers/power/supply/sc27xx_fuel_gauge.c        |    9 
 drivers/regulator/core.c                        |    4 
 drivers/s390/block/dasd_ioctl.c                 |   46 
 drivers/spi/spi-fsl-dspi.c                      |   19 
 drivers/tty/serial/lantiq.c                     |    1 
 drivers/usb/dwc3/gadget.c                       |    1 
 drivers/usb/serial/option.c                     |   16 
 fs/afs/vl_probe.c                               |    4 
 fs/btrfs/file-item.c                            |    4 
 fs/nilfs2/btnode.c                              |   12 
 fs/nilfs2/sufile.c                              |    9 
 fs/ocfs2/file.c                                 |    8 
 fs/ocfs2/super.c                                |    6 
 include/linux/netdevice.h                       |    4 
 include/linux/netfilter.h                       |    5 
 include/linux/netfilter_defs.h                  |    8 
 include/net/dn.h                                |  231 --
 include/net/dn_dev.h                            |  199 -
 include/net/dn_fib.h                            |  167 -
 include/net/dn_neigh.h                          |   30 
 include/net/dn_nsp.h                            |  195 -
 include/net/dn_route.h                          |  115 -
 include/net/dst.h                               |    6 
 include/net/neighbour.h                         |    7 
 include/net/netns/netfilter.h                   |    3 
 include/uapi/linux/dn.h                         |  149 -
 include/uapi/linux/netfilter_decnet.h           |   72 
 include/uapi/linux/netlink.h                    |    2 
 kernel/kexec_file.c                             |   14 
 lib/test_firmware.c                             |   10 
 net/Kconfig                                     |    2 
 net/Makefile                                    |    1 
 net/core/dev.c                                  |    4 
 net/core/neighbour.c                            |   34 
 net/decnet/Kconfig                              |   43 
 net/decnet/Makefile                             |   10 
 net/decnet/README                               |    8 
 net/decnet/af_decnet.c                          | 2400 ------------------------
 net/decnet/dn_dev.c                             | 1438 --------------
 net/decnet/dn_fib.c                             |  799 -------
 net/decnet/dn_neigh.c                           |  605 ------
 net/decnet/dn_nsp_in.c                          |  906 ---------
 net/decnet/dn_nsp_out.c                         |  695 ------
 net/decnet/dn_route.c                           | 1921 -------------------
 net/decnet/dn_rules.c                           |  258 --
 net/decnet/dn_table.c                           |  929 ---------
 net/decnet/dn_timer.c                           |  104 -
 net/decnet/netfilter/Kconfig                    |   17 
 net/decnet/netfilter/Makefile                   |    6 
 net/decnet/netfilter/dn_rtmsg.c                 |  158 -
 net/decnet/sysctl_net_decnet.c                  |  373 ---
 net/ipv6/ping.c                                 |    3 
 net/netfilter/core.c                            |   10 
 net/netfilter/nfnetlink.c                       |    3 
 net/sched/cls_api.c                             |   12 
 net/sched/cls_u32.c                             |   18 
 net/sctp/sm_statefuns.c                         |    2 
 net/tipc/bearer.c                               |    4 
 sound/pci/hda/patch_realtek.c                   |    1 
 tools/testing/selftests/ptp/testptp.c           |    6 
 111 files changed, 363 insertions(+), 12379 deletions(-)

Ahmed Zaki (1):
      iavf: remove mask from iavf_irq_enable_queues()

Aleksandr Loktionov (1):
      igb: fix nvm.ops.read() error handling

Alex Maftei (1):
      selftests/ptp: Fix timestamp printf format for PTP_SYS_OFFSET

Alexander Kapshuk (1):
      drm/nouveau/kms: Fix NULL pointer dereference in nouveau_connector_detect_depth

Alexandru Sorodoc (1):
      platform/x86: asus-wmi: Ignore WMI events with codes 0x7B, 0xC0

Bernhard Seibold (1):
      serial: lantiq: add missing interrupt ack

Bob Pearson (1):
      RDMA/rxe: Removed unused name from rxe_task struct

Christian Loehle (1):
      mmc: block: ensure error propagation for non-blk

Christoph Hellwig (1):
      dasd: refactor dasd_ioctl_information

Dan Carpenter (1):
      sctp: fix an error code in sctp_sf_eat_auth()

Dave Airlie (1):
      nouveau: fix client work fence deletion race

David Howells (1):
      afs: Fix vlserver probe RTT handling

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Add a quirk for Compaq N14JP6

Edward Srouji (1):
      RDMA/uverbs: Restrict usage of privileged QKEYs

Elson Roy Serrao (1):
      usb: dwc3: gadget: Reset num TRBs before giving back the request

Eric Dumazet (1):
      net: lapbether: only support ethernet devices

Gaosheng Cui (2):
      neighbour: Remove unused inline function neigh_key_eq16()
      net: Remove unused inline function dst_hold_and_use()

Greg Kroah-Hartman (1):
      Linux 5.4.248

Guillaume Nault (1):
      ping6: Fix send to link-local addresses with VRF.

Hangbin Liu (1):
      ipvlan: fix bound dev checking for IPv6 l3s mode

Hans de Goede (3):
      power: supply: ab8500: Fix external_power_changed race
      power: supply: sc27xx: Fix external_power_changed race
      power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() + schedule()

Helge Deller (2):
      parisc: Improve cache flushing for PCXL in arch_sync_dma_for_cpu()
      parisc: Flush gatt writes and adjust gatt mask in parisc_agp_mask_memory()

Jan Höppner (1):
      s390/dasd: Use correct lock while counting channel queue length

Janne Grunau (1):
      nios2: dts: Fix tse_mac "max-frame-size" property

Jerry Meng (1):
      USB: serial: option: add Quectel EM061KGL series

Johannes Thumshirn (1):
      btrfs: handle memory allocation failure in btrfs_csum_one_bio

Krzysztof Kozlowski (2):
      ARM: dts: vexpress: add missing cache properties
      irqchip/meson-gpio: Mark OF related data as maybe unused

Lee Jones (1):
      net/sched: cls_u32: Fix reference counter leak leading to overflow

Leon Romanovsky (1):
      neighbour: delete neigh_lookup_nodev as not used

Lin Ma (1):
      net: tipc: resize nlattr array to correct size

Liviu Dudau (1):
      mips: Move initrd_start check after initrd address sanitisation.

Luís Henriques (2):
      ocfs2: fix use-after-free when unmounting read-only filesystem
      ocfs2: check new file size on fallocate call

Lyude Paul (1):
      drm/nouveau/kms: Don't change EDID when it hasn't actually changed

Manuel Lauss (1):
      MIPS: Alchemy: fix dbdma2

Marek Vasut (1):
      power: supply: Ratelimit no data debug output

Mario Limonciello (1):
      power: supply: Fix logic checking if system is running from battery

Mirsad Goran Todorovac (1):
      test_firmware: fix a memory leak with reqs buffer

Natalia Petrova (2):
      drm/nouveau/dp: check for NULL nv_connector->native_mode
      drm/nouveau: add nv_encoder pointer check for NULL

Osama Muhammad (1):
      regulator: Fix error checking for debugfs_create_dir

Pablo Neira Ayuso (1):
      netfilter: nfnetlink: skip error delivery on batch in case of ENOMEM

Ricardo Ribalda (2):
      kexec: support purgatories with .text.hot sections
      powerpc/purgatory: remove PGO flags

Roberto Sassu (1):
      KEYS: asymmetric: Copy sig and digest in public_key_verify_signature()

Ross Lagerwall (1):
      xen/blkfront: Only check REQ_FUA for writes

Ryusuke Konishi (2):
      nilfs2: fix incomplete buffer cleanup in nilfs_btnode_abort_change_key()
      nilfs2: fix possible out-of-bounds segment allocation in resize ioctl

Saravanan Vajravel (3):
      IB/isert: Fix dead lock in ib_isert
      IB/isert: Fix possible list corruption in CMA handler
      IB/isert: Fix incorrect release of isert connection

Stephen Hemminger (1):
      Remove DECnet support from kernel

Sukrut Bellary (1):
      drm:amd:amdgpu: Fix missing buffer object unlock in failure path

Vlad Buslov (1):
      net/sched: cls_api: Fix lockup on flushing explicitly created chain

Vladimir Oltean (2):
      spi: spi-fsl-dspi: Remove unused chip->void_write_data
      spi: fsl-dspi: avoid SCK glitches with continuous transfers

Wes Huang (1):
      net: usb: qmi_wwan: add support for Compal RXM-G1

Yishai Hadas (1):
      IB/uverbs: Fix to consider event queue closing also upon non-blocking mode

Zhu Yanjun (2):
      RDMA/rxe: Remove the unused variable obj
      RDMA/rxe: Fix the use-before-initialization error of resp_pkts

