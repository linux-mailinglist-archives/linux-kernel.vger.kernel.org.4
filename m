Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406C37385E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjFUN6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjFUN6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:58:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C219AA;
        Wed, 21 Jun 2023 06:58:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFED461478;
        Wed, 21 Jun 2023 13:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A27FC433CB;
        Wed, 21 Jun 2023 13:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687355890;
        bh=M36pDP1ahHac2mP5nUVOeUypletFnH0SxO5yoSgDFR4=;
        h=From:To:Cc:Subject:Date:From;
        b=kZw6FMQ/CBtZOr7U7o+vr1vXzx0fP8B3Zk9ZpK5AyK9+rNqdu/WS464pCfnyaM5c0
         ItjFBQLsMCqGfgGDbkjDivKr44T9jv+uQlLewC+quApigQ1pvMUGXXzt+DXgn6LY0o
         WMcXScg97J890tlIzBhDKlx0KOAVg2ISaH3eiK78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.287
Date:   Wed, 21 Jun 2023 15:58:02 +0200
Message-ID: <2023062103-undertook-goofiness-2902@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

I'm announcing the release of the 4.19.287 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt |    4 
 Documentation/ioctl/ioctl-number.txt            |    1 
 Documentation/networking/decnet.txt             |  232 --
 Documentation/sysctl/net.txt                    |    1 
 MAINTAINERS                                     |    7 
 Makefile                                        |    2 
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts         |    1 
 arch/mips/alchemy/common/dbdma.c                |   27 
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
 arch/powerpc/Makefile                           |    9 
 arch/powerpc/configs/ppc6xx_defconfig           |    2 
 arch/powerpc/purgatory/Makefile                 |    5 
 drivers/block/xen-blkfront.c                    |    3 
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
 drivers/net/ethernet/intel/igb/igb_ethtool.c    |    3 
 drivers/net/usb/qmi_wwan.c                      |    2 
 drivers/net/wan/lapbether.c                     |    3 
 drivers/power/supply/ab8500_btemp.c             |    6 
 drivers/power/supply/ab8500_fg.c                |    6 
 drivers/power/supply/bq27xxx_battery.c          |    6 
 drivers/power/supply/power_supply_core.c        |    8 
 drivers/power/supply/power_supply_sysfs.c       |    3 
 drivers/regulator/core.c                        |    4 
 drivers/usb/dwc3/gadget.c                       |    1 
 drivers/usb/gadget/function/f_ncm.c             |   57 
 drivers/usb/gadget/function/u_ncm.h             |    3 
 drivers/usb/serial/option.c                     |   16 
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
 include/net/dn_nsp.h                            |  203 --
 include/net/dn_route.h                          |  123 -
 include/net/dst.h                               |    6 
 include/net/neighbour.h                         |    7 
 include/net/netns/netfilter.h                   |    3 
 include/uapi/linux/dn.h                         |  149 -
 include/uapi/linux/netfilter_decnet.h           |   82 
 include/uapi/linux/netlink.h                    |    2 
 kernel/kexec_file.c                             |   14 
 net/Kconfig                                     |    2 
 net/Makefile                                    |    1 
 net/core/dev.c                                  |    4 
 net/core/neighbour.c                            |   34 
 net/decnet/Kconfig                              |   42 
 net/decnet/Makefile                             |   10 
 net/decnet/README                               |    8 
 net/decnet/af_decnet.c                          | 2408 ------------------------
 net/decnet/dn_dev.c                             | 1438 --------------
 net/decnet/dn_fib.c                             |  799 -------
 net/decnet/dn_neigh.c                           |  605 ------
 net/decnet/dn_nsp_in.c                          |  914 ---------
 net/decnet/dn_nsp_out.c                         |  703 -------
 net/decnet/dn_route.c                           | 1929 -------------------
 net/decnet/dn_rules.c                           |  258 --
 net/decnet/dn_table.c                           |  928 ---------
 net/decnet/dn_timer.c                           |  104 -
 net/decnet/netfilter/Kconfig                    |   16 
 net/decnet/netfilter/Makefile                   |    5 
 net/decnet/netfilter/dn_rtmsg.c                 |  160 -
 net/decnet/sysctl_net_decnet.c                  |  373 ---
 net/ipv6/ping.c                                 |    3 
 net/netfilter/core.c                            |   10 
 net/netfilter/nfnetlink.c                       |    3 
 net/sctp/sm_statefuns.c                         |    2 
 net/tipc/bearer.c                               |    4 
 tools/testing/selftests/ptp/testptp.c           |    6 
 92 files changed, 281 insertions(+), 12360 deletions(-)

Aleksandr Loktionov (1):
      igb: fix nvm.ops.read() error handling

Alex Maftei (1):
      selftests/ptp: Fix timestamp printf format for PTP_SYS_OFFSET

Alexander Kapshuk (1):
      drm/nouveau/kms: Fix NULL pointer dereference in nouveau_connector_detect_depth

Bob Pearson (1):
      RDMA/rxe: Removed unused name from rxe_task struct

Christian Loehle (1):
      mmc: block: ensure error propagation for non-blk

Dan Carpenter (1):
      sctp: fix an error code in sctp_sf_eat_auth()

Dave Airlie (1):
      nouveau: fix client work fence deletion race

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
      Linux 4.19.287

Guillaume Nault (1):
      ping6: Fix send to link-local addresses with VRF.

Hans de Goede (2):
      power: supply: ab8500: Fix external_power_changed race
      power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() + schedule()

Helge Deller (1):
      parisc: Improve cache flushing for PCXL in arch_sync_dma_for_cpu()

Janne Grunau (1):
      nios2: dts: Fix tse_mac "max-frame-size" property

Jerry Meng (1):
      USB: serial: option: add Quectel EM061KGL series

Krzysztof Kozlowski (2):
      ARM: dts: vexpress: add missing cache properties
      irqchip/meson-gpio: Mark OF related data as maybe unused

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

Michael Ellerman (1):
      powerpc: Fix defconfig choice logic when cross compiling

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

Romain Izard (2):
      usb: gadget: f_ncm: Add OS descriptor support
      usb: gadget: f_ncm: Fix NTP-32 support

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

Wes Huang (1):
      net: usb: qmi_wwan: add support for Compal RXM-G1

Yishai Hadas (1):
      IB/uverbs: Fix to consider event queue closing also upon non-blocking mode

Zhu Yanjun (2):
      RDMA/rxe: Remove the unused variable obj
      RDMA/rxe: Fix the use-before-initialization error of resp_pkts

