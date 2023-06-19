Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359F2735217
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjFSKaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjFSKaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0F0D7;
        Mon, 19 Jun 2023 03:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44A1460B5E;
        Mon, 19 Jun 2023 10:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A4AC433C0;
        Mon, 19 Jun 2023 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170616;
        bh=27dmlyxVexKROyJoWEwMG1BM+Rzzp3y5u1G7bVW+bNk=;
        h=From:To:Cc:Subject:Date:From;
        b=OEhsfVTfyyAV9TwpsJJ4aNKtP7TJE6gH4z0M9RAoJvlKXi17pxuodqUh7VxtIFuw3
         0CqXMRDMUekcy1vx0W4/ZS6/TWcDYw9GD9IFeEaH9RKuVF79R2fJxFkabRWJwsCuaG
         goQ9VMpx6CUvv0jascc2XZ83iQ1USAUeRQoNG0xo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 4.14 00/32] 4.14.319-rc1 review
Date:   Mon, 19 Jun 2023 12:28:48 +0200
Message-ID: <20230619102127.461443957@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.319-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.319-rc1
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

This is the start of the stable review cycle for the 4.14.319 release.
There are 32 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.319-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.319-rc1

Christian Loehle <CLoehle@hyperstone.com>
    mmc: block: ensure error propagation for non-blk

Michael Ellerman <mpe@ellerman.id.au>
    powerpc: Fix defconfig choice logic when cross compiling

Leon Romanovsky <leonro@nvidia.com>
    neighbour: delete neigh_lookup_nodev as not used

Gaosheng Cui <cuigaosheng1@huawei.com>
    neighbour: Remove unused inline function neigh_key_eq16()

Alex Maftei <alex.maftei@amd.com>
    selftests/ptp: Fix timestamp printf format for PTP_SYS_OFFSET

Lin Ma <linma@zju.edu.cn>
    net: tipc: resize nlattr array to correct size

Eric Dumazet <edumazet@google.com>
    net: lapbether: only support ethernet devices

Natalia Petrova <n.petrova@fintech.ru>
    drm/nouveau/dp: check for NULL nv_connector->native_mode

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    igb: fix nvm.ops.read() error handling

Dan Carpenter <dan.carpenter@linaro.org>
    sctp: fix an error code in sctp_sf_eat_auth()

Saravanan Vajravel <saravanan.vajravel@broadcom.com>
    IB/isert: Fix incorrect release of isert connection

Saravanan Vajravel <saravanan.vajravel@broadcom.com>
    IB/isert: Fix possible list corruption in CMA handler

Saravanan Vajravel <saravanan.vajravel@broadcom.com>
    IB/isert: Fix dead lock in ib_isert

Guillaume Nault <gnault@redhat.com>
    ping6: Fix send to link-local addresses with VRF.

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nfnetlink: skip error delivery on batch in case of ENOMEM

Jerry Meng <jerry-meng@foxmail.com>
    USB: serial: option: add Quectel EM061KGL series

Stephen Hemminger <stephen@networkplumber.org>
    Remove DECnet support from kernel

Wes Huang <wes.huang@moxa.com>
    net: usb: qmi_wwan: add support for Compal RXM-G1

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

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen/blkfront: Only check REQ_FUA for writes

Liviu Dudau <liviu@dudau.co.uk>
    mips: Move initrd_start check after initrd address sanitisation.

Manuel Lauss <manuel.lauss@gmail.com>
    MIPS: Alchemy: fix dbdma2

Mario Limonciello <mario.limonciello@amd.com>
    power: supply: Fix logic checking if system is running from battery

Osama Muhammad <osmtendev@gmail.com>
    regulator: Fix error checking for debugfs_create_dir

Marek Vasut <marex@denx.de>
    power: supply: Ratelimit no data debug output

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: vexpress: add missing cache properties

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() + schedule()

Hans de Goede <hdegoede@redhat.com>
    power: supply: ab8500: Fix external_power_changed race


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt |    4 -
 Documentation/ioctl/ioctl-number.txt            |    1 -
 Documentation/networking/decnet.txt             |  232 ---
 Documentation/sysctl/net.txt                    |    1 -
 MAINTAINERS                                     |    7 -
 Makefile                                        |    4 +-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts         |    1 +
 arch/mips/alchemy/common/dbdma.c                |   27 +-
 arch/mips/configs/gpr_defconfig                 |    2 -
 arch/mips/configs/jazz_defconfig                |    2 -
 arch/mips/configs/mtx1_defconfig                |    2 -
 arch/mips/configs/nlm_xlp_defconfig             |    2 -
 arch/mips/configs/nlm_xlr_defconfig             |    2 -
 arch/mips/configs/rm200_defconfig               |    2 -
 arch/mips/kernel/setup.c                        |    9 +-
 arch/nios2/boot/dts/10m50_devboard.dts          |    2 +-
 arch/nios2/boot/dts/3c120_devboard.dts          |    2 +-
 arch/powerpc/Makefile                           |    9 +-
 arch/powerpc/configs/ppc6xx_defconfig           |    2 -
 drivers/block/xen-blkfront.c                    |    3 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c     |    4 +-
 drivers/infiniband/ulp/isert/ib_isert.c         |   16 +-
 drivers/mmc/core/block.c                        |    5 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c    |    3 +
 drivers/net/usb/qmi_wwan.c                      |    2 +
 drivers/net/wan/lapbether.c                     |    3 +
 drivers/power/supply/ab8500_btemp.c             |    6 +-
 drivers/power/supply/ab8500_fg.c                |    6 +-
 drivers/power/supply/bq27xxx_battery.c          |    6 +-
 drivers/power/supply/power_supply_core.c        |    8 +-
 drivers/power/supply/power_supply_sysfs.c       |    3 +-
 drivers/regulator/core.c                        |    4 +-
 drivers/usb/serial/option.c                     |   16 +
 fs/nilfs2/btnode.c                              |   12 +-
 fs/nilfs2/sufile.c                              |    9 +
 fs/ocfs2/file.c                                 |    8 +-
 fs/ocfs2/super.c                                |    6 +-
 include/linux/netdevice.h                       |    2 -
 include/linux/netfilter_defs.h                  |    3 +-
 include/net/dn.h                                |  238 ---
 include/net/dn_dev.h                            |  199 --
 include/net/dn_fib.h                            |  167 --
 include/net/dn_neigh.h                          |   30 -
 include/net/dn_nsp.h                            |  204 --
 include/net/dn_route.h                          |  122 --
 include/net/neighbour.h                         |    7 -
 include/uapi/linux/dn.h                         |  149 --
 include/uapi/linux/netfilter_decnet.h           |   80 -
 include/uapi/linux/netlink.h                    |    2 +-
 net/Kconfig                                     |    2 -
 net/Makefile                                    |    1 -
 net/core/dev.c                                  |    1 -
 net/core/neighbour.c                            |   34 -
 net/decnet/Kconfig                              |   43 -
 net/decnet/Makefile                             |   11 -
 net/decnet/README                               |    8 -
 net/decnet/af_decnet.c                          | 2423 -----------------------
 net/decnet/dn_dev.c                             | 1451 --------------
 net/decnet/dn_fib.c                             |  799 --------
 net/decnet/dn_neigh.c                           |  620 ------
 net/decnet/dn_nsp_in.c                          |  918 ---------
 net/decnet/dn_nsp_out.c                         |  718 -------
 net/decnet/dn_route.c                           | 1942 ------------------
 net/decnet/dn_rules.c                           |  257 ---
 net/decnet/dn_table.c                           |  927 ---------
 net/decnet/dn_timer.c                           |  104 -
 net/decnet/netfilter/Kconfig                    |   16 -
 net/decnet/netfilter/Makefile                   |    6 -
 net/decnet/netfilter/dn_rtmsg.c                 |  161 --
 net/decnet/sysctl_net_decnet.c                  |  373 ----
 net/ipv6/ping.c                                 |    3 +-
 net/netfilter/nfnetlink.c                       |    3 +-
 net/sctp/sm_statefuns.c                         |    2 +-
 net/tipc/bearer.c                               |    4 +-
 tools/testing/selftests/ptp/testptp.c           |    6 +-
 75 files changed, 132 insertions(+), 12337 deletions(-)


