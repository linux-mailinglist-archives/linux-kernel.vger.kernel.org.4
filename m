Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA237385D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjFUN6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUN6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:58:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECC31A1;
        Wed, 21 Jun 2023 06:58:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 276B1612DD;
        Wed, 21 Jun 2023 13:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13706C433C0;
        Wed, 21 Jun 2023 13:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687355881;
        bh=ZwIRLtcDHO+NH+nEjwEIjiOFhsApTs4MKeKR7KBW5EA=;
        h=From:To:Cc:Subject:Date:From;
        b=fOfvafdFjbL0JeZ1HTfD2Hdmr1pvmyo0fMFAxNJmgjin65d0ClC7S66X20N1q9tzh
         EqNxYRKPFFbf9AzGUy40mrPCK3Hp35t/Kxo5M+JS/oIxcWK8YelQpNRgCiWjdkW42L
         BhkawWzLM2l01uX0FtEjsZj+z6wXlzJJpmFEKmjM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.319
Date:   Wed, 21 Jun 2023 15:57:56 +0200
Message-ID: <2023062157-froth-nanometer-9ada@gregkh>
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

I'm announcing the release of the 4.14.319 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
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
 arch/powerpc/Makefile                           |    9 
 arch/powerpc/configs/ppc6xx_defconfig           |    2 
 drivers/block/xen-blkfront.c                    |    3 
 drivers/gpu/drm/nouveau/nouveau_connector.c     |    4 
 drivers/infiniband/ulp/isert/ib_isert.c         |   16 
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
 drivers/usb/serial/option.c                     |   16 
 fs/nilfs2/btnode.c                              |   12 
 fs/nilfs2/sufile.c                              |    9 
 fs/ocfs2/file.c                                 |    8 
 fs/ocfs2/super.c                                |    6 
 include/linux/netdevice.h                       |    2 
 include/linux/netfilter_defs.h                  |    3 
 include/net/dn.h                                |  238 --
 include/net/dn_dev.h                            |  199 -
 include/net/dn_fib.h                            |  167 -
 include/net/dn_neigh.h                          |   30 
 include/net/dn_nsp.h                            |  204 --
 include/net/dn_route.h                          |  122 -
 include/net/neighbour.h                         |    7 
 include/uapi/linux/dn.h                         |  149 -
 include/uapi/linux/netfilter_decnet.h           |   80 
 include/uapi/linux/netlink.h                    |    2 
 net/Kconfig                                     |    2 
 net/Makefile                                    |    1 
 net/core/dev.c                                  |    1 
 net/core/neighbour.c                            |   34 
 net/decnet/Kconfig                              |   43 
 net/decnet/Makefile                             |   11 
 net/decnet/README                               |    8 
 net/decnet/af_decnet.c                          | 2423 ------------------------
 net/decnet/dn_dev.c                             | 1451 --------------
 net/decnet/dn_fib.c                             |  799 -------
 net/decnet/dn_neigh.c                           |  620 ------
 net/decnet/dn_nsp_in.c                          |  918 ---------
 net/decnet/dn_nsp_out.c                         |  718 -------
 net/decnet/dn_route.c                           | 1942 -------------------
 net/decnet/dn_rules.c                           |  257 --
 net/decnet/dn_table.c                           |  927 ---------
 net/decnet/dn_timer.c                           |  104 -
 net/decnet/netfilter/Kconfig                    |   16 
 net/decnet/netfilter/Makefile                   |    6 
 net/decnet/netfilter/dn_rtmsg.c                 |  161 -
 net/decnet/sysctl_net_decnet.c                  |  373 ---
 net/ipv6/ping.c                                 |    3 
 net/netfilter/nfnetlink.c                       |    3 
 net/sctp/sm_statefuns.c                         |    2 
 net/tipc/bearer.c                               |    4 
 tools/testing/selftests/ptp/testptp.c           |    6 
 75 files changed, 131 insertions(+), 12336 deletions(-)

Aleksandr Loktionov (1):
      igb: fix nvm.ops.read() error handling

Alex Maftei (1):
      selftests/ptp: Fix timestamp printf format for PTP_SYS_OFFSET

Christian Loehle (1):
      mmc: block: ensure error propagation for non-blk

Dan Carpenter (1):
      sctp: fix an error code in sctp_sf_eat_auth()

Eric Dumazet (1):
      net: lapbether: only support ethernet devices

Gaosheng Cui (1):
      neighbour: Remove unused inline function neigh_key_eq16()

Greg Kroah-Hartman (1):
      Linux 4.14.319

Guillaume Nault (1):
      ping6: Fix send to link-local addresses with VRF.

Hans de Goede (2):
      power: supply: ab8500: Fix external_power_changed race
      power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() + schedule()

Janne Grunau (1):
      nios2: dts: Fix tse_mac "max-frame-size" property

Jerry Meng (1):
      USB: serial: option: add Quectel EM061KGL series

Krzysztof Kozlowski (1):
      ARM: dts: vexpress: add missing cache properties

Leon Romanovsky (1):
      neighbour: delete neigh_lookup_nodev as not used

Lin Ma (1):
      net: tipc: resize nlattr array to correct size

Liviu Dudau (1):
      mips: Move initrd_start check after initrd address sanitisation.

Luís Henriques (2):
      ocfs2: fix use-after-free when unmounting read-only filesystem
      ocfs2: check new file size on fallocate call

Manuel Lauss (1):
      MIPS: Alchemy: fix dbdma2

Marek Vasut (1):
      power: supply: Ratelimit no data debug output

Mario Limonciello (1):
      power: supply: Fix logic checking if system is running from battery

Michael Ellerman (1):
      powerpc: Fix defconfig choice logic when cross compiling

Natalia Petrova (1):
      drm/nouveau/dp: check for NULL nv_connector->native_mode

Osama Muhammad (1):
      regulator: Fix error checking for debugfs_create_dir

Pablo Neira Ayuso (1):
      netfilter: nfnetlink: skip error delivery on batch in case of ENOMEM

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

