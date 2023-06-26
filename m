Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9843D73E975
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjFZSgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjFZSgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:36:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB1BCC;
        Mon, 26 Jun 2023 11:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F9AB60F45;
        Mon, 26 Jun 2023 18:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7A8C433C9;
        Mon, 26 Jun 2023 18:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804569;
        bh=czcbwr7qnUSP9KF2DNna7bilPHO4T5/0g6zFOp+twks=;
        h=From:To:Cc:Subject:Date:From;
        b=icW0gRCL0/2Rkc0mYLjZucjgHApKum3jAdhObmyHhx3moEHgMA4w9bHwHq1H+4hvL
         Ut4s7hzSicnRXCrtrXggNyiDnQfUzPoeZbF+VSL4UGI8LQaeXXyehywIw4xhjWcBNU
         pd1aFybKrhjJZqPhXtiq4x4lA964NbYvxqc0dTww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.4 00/60] 5.4.249-rc1 review
Date:   Mon, 26 Jun 2023 20:11:39 +0200
Message-ID: <20230626180739.558575012@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.249-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.249-rc1
X-KernelTest-Deadline: 2023-06-28T18:07+00:00
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

This is the start of the stable review cycle for the 5.4.249 release.
There are 60 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.249-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.249-rc1

Darrick J. Wong <djwong@kernel.org>
    xfs: verify buffer contents when we skip log replay

Linus Torvalds <torvalds@linux-foundation.org>
    mm: make wait_on_page_writeback() wait for multiple pending writebacks

Hugh Dickins <hughd@google.com>
    mm: fix VM_BUG_ON(PageTail) and BUG_ON(PageWriteback)

Clark Wang <xiaoning.wang@nxp.com>
    i2c: imx-lpi2c: fix type char overflow issue when calculating the clock cycle

Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
    x86/apic: Fix kernel panic when booting with intremap=off and x2apic_phys

Min Li <lm0963hack@gmail.com>
    drm/radeon: fix race condition UAF in radeon_gem_set_domain_ioctl

Min Li <lm0963hack@gmail.com>
    drm/exynos: fix race condition UAF in exynos_g2d_exec_ioctl

Inki Dae <inki.dae@samsung.com>
    drm/exynos: vidi: fix a wrong error return

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: Fix erroneous ADS touchscreen polarities

Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
    ASoC: nau8824: Add quirk to active-high jack-detect

Vineeth Vijayan <vneethv@linux.ibm.com>
    s390/cio: unregister device when the only path is gone

Dan Carpenter <dan.carpenter@linaro.org>
    usb: gadget: udc: fix NULL dereference in remove()

Osama Muhammad <osmtendev@gmail.com>
    nfcsim.c: Fix error checking for debugfs_create_dir

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: cec: core: don't set last_initiator if tx in progress

Marc Zyngier <maz@kernel.org>
    arm64: Add missing Set/Way CMO encodings

Denis Arefev <arefev@swemel.ru>
    HID: wacom: Add error check to wacom_parse_and_register()

Maurizio Lombardi <mlombard@redhat.com>
    scsi: target: iscsi: Prevent login threads from racing between each other

Eric Dumazet <edumazet@google.com>
    sch_netem: acquire qdisc lock in netem_change()

Francesco Dolcini <francesco.dolcini@toradex.com>
    Revert "net: phy: dp83867: perform soft reset and retain established link"

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nfnetlink_osf: fix module autoload

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow element updates of bound anonymous sets

Ross Lagerwall <ross.lagerwall@citrix.com>
    be2net: Extend xmit workaround to BE3 chip

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix trapping frames on non-MT7621 SoC MT7530 switch

Terin Stock <terin@cloudflare.com>
    ipvs: align inner_mac_header for encapsulation

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: usdhi60rol0: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: sh_mmcif: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: sdhci-acpi: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: omap_hsmmc: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: omap: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: mvsdio: fix deferred probing

Yangtao Li <tiny.windzz@gmail.com>
    mmc: mvsdio: convert to devm_platform_ioremap_resource

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: mtk-sd: fix deferred probing

Stefan Wahren <stefan.wahren@i2se.com>
    net: qca_spi: Avoid high load if QCA7000 is not available

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    xfrm: Linearize the skb after offloading if needed.

Chen Aotian <chenaotian2@163.com>
    ieee802154: hwsim: Fix possible memory leaks

Paul E. McKenney <paulmck@kernel.org>
    rcu: Upgrade rcu_swap_protected() to rcu_replace_pointer()

Lee Jones <lee@kernel.org>
    x86/mm: Avoid using set_pgd() outside of real PGD pages

Paulo Alcantara (SUSE) <pc@cjr.nz>
    cifs: Fix potential deadlock when updating vol in cifs_reconnect()

Paulo Alcantara (SUSE) <pc@cjr.nz>
    cifs: Merge is_path_valid() into get_normalized_path()

Paulo Alcantara (SUSE) <pc@cjr.nz>
    cifs: Introduce helpers for finding TCP connection

Paulo Alcantara (SUSE) <pc@cjr.nz>
    cifs: Get rid of kstrdup_const()'d paths

Paulo Alcantara (SUSE) <pc@cjr.nz>
    cifs: Clean up DFS referral cache

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent general protection fault in nilfs_clear_dirty_page()

Rafael Aquini <aquini@redhat.com>
    writeback: fix dereferencing NULL mapping->host on writeback_page_template

Matthias May <matthias.may@westermo.com>
    ip_tunnels: allow VXLAN/GENEVE to inherit TOS/TTL from VLAN

Martin Hundebøll <martin@geanix.com>
    mmc: meson-gx: remove redundant mmc_request_done() call from irq context

Xiu Jianfeng <xiujianfeng@huawei.com>
    cgroup: Do not corrupt task iteration when rebinding subsystem

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Fix a race condition bug in hv_pci_query_relations()

Michael Kelley <mikelley@microsoft.com>
    Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to scan present CPUs

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix buffer corruption due to concurrent device reads

Hyunwoo Kim <imv4bel@gmail.com>
    media: dvb-core: Fix use-after-free due to race at dvb_register_device()

Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    media: dvbdev: fix error logic at dvb_register_device()

Dinghao Liu <dinghao.liu@zju.edu.cn>
    media: dvbdev: Fix memleak in dvb_register_device

Thomas Gleixner <tglx@linutronix.de>
    tick/common: Align tick period during sched_timer setup

Ricardo Ribalda <ribalda@chromium.org>
    x86/purgatory: remove PGO flags

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Add tracing_reset_all_online_cpus_unlocked() function

Benjamin Segall <bsegall@google.com>
    epoll: ep_autoremove_wake_function should use list_del_init_careful

Linus Torvalds <torvalds@linux-foundation.org>
    list: add "list_del_init_careful()" to go with "list_empty_careful()"

Linus Torvalds <torvalds@linux-foundation.org>
    mm: rewrite wait_on_page_bit_common() logic

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: reject devices with insufficient block count


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |   2 +-
 arch/arm/boot/dts/at91sam9261ek.dts                |   2 +-
 arch/arm/boot/dts/imx7d-pico-hobbit.dts            |   2 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |   2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |   2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |   2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   2 +-
 arch/arm64/include/asm/sysreg.h                    |   6 +
 arch/x86/kernel/apic/x2apic_phys.c                 |   5 +-
 arch/x86/mm/kaslr.c                                |   8 +-
 arch/x86/purgatory/Makefile                        |   5 +
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |   2 -
 drivers/gpu/drm/radeon/radeon_gem.c                |   4 +-
 drivers/hid/wacom_sys.c                            |   7 +-
 drivers/hv/channel_mgmt.c                          |  18 +-
 drivers/i2c/busses/i2c-imx-lpi2c.c                 |   4 +-
 drivers/media/cec/cec-adap.c                       |   3 +-
 drivers/media/dvb-core/dvbdev.c                    |  88 ++-
 drivers/mmc/host/meson-gx-mmc.c                    |  10 +-
 drivers/mmc/host/mtk-sd.c                          |   2 +-
 drivers/mmc/host/mvsdio.c                          |   8 +-
 drivers/mmc/host/omap.c                            |   2 +-
 drivers/mmc/host/omap_hsmmc.c                      |   6 +-
 drivers/mmc/host/sdhci-acpi.c                      |   2 +-
 drivers/mmc/host/sh_mmcif.c                        |   2 +-
 drivers/mmc/host/usdhi6rol0.c                      |   6 +-
 drivers/net/dsa/mt7530.c                           |   2 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   4 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            |   3 +-
 drivers/net/ieee802154/mac802154_hwsim.c           |   6 +-
 drivers/net/phy/dp83867.c                          |   2 +-
 drivers/nfc/nfcsim.c                               |   4 -
 drivers/pci/controller/pci-hyperv.c                |  18 +
 drivers/s390/cio/device.c                          |   5 +-
 drivers/target/iscsi/iscsi_target_nego.c           |   4 +-
 drivers/usb/gadget/udc/amd5536udc_pci.c            |   3 +
 fs/cifs/dfs_cache.c                                | 707 +++++++++++----------
 fs/eventpoll.c                                     |   6 +-
 fs/nilfs2/page.c                                   |  10 +-
 fs/nilfs2/segbuf.c                                 |   6 +
 fs/nilfs2/segment.c                                |   7 +
 fs/nilfs2/super.c                                  |  25 +-
 fs/nilfs2/the_nilfs.c                              |  44 +-
 fs/xfs/xfs_log_recover.c                           |  10 +
 include/linux/list.h                               |  20 +-
 include/linux/rcupdate.h                           |  18 +
 include/media/dvbdev.h                             |  15 +
 include/net/ip_tunnels.h                           |  12 +-
 include/trace/events/writeback.h                   |   2 +-
 kernel/cgroup/cgroup.c                             |  20 +-
 kernel/sched/wait.c                                |   2 +-
 kernel/time/tick-common.c                          |  13 +-
 kernel/time/tick-sched.c                           |  13 +-
 kernel/trace/trace.c                               |  11 +-
 kernel/trace/trace.h                               |   1 +
 kernel/trace/trace_events.c                        |   2 +-
 mm/filemap.c                                       | 137 ++--
 mm/page-writeback.c                                |   8 +-
 net/ipv4/esp4_offload.c                            |   3 +
 net/ipv6/esp6_offload.c                            |   3 +
 net/netfilter/ipvs/ip_vs_xmit.c                    |   2 +
 net/netfilter/nf_tables_api.c                      |   7 +-
 net/netfilter/nfnetlink_osf.c                      |   1 +
 net/netfilter/xt_osf.c                             |   1 -
 net/sched/sch_netem.c                              |   8 +-
 sound/soc/codecs/nau8824.c                         |  24 +
 72 files changed, 898 insertions(+), 507 deletions(-)


