Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B2B73E764
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjFZSOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjFZSOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B39310D7;
        Mon, 26 Jun 2023 11:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A277E60F21;
        Mon, 26 Jun 2023 18:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE8FC433C9;
        Mon, 26 Jun 2023 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803281;
        bh=E60ysgSxu9+zVZtnqGYeknoO5HJg4LBgPFo1cPe5Jd8=;
        h=From:To:Cc:Subject:Date:From;
        b=ISXC2BW9k4cwIJxSMB5iTtloRkSTDuiMGZUTE8w233C/o3Un40dzXhBERfhs1Ra6T
         S6GOTxhxczJkuAKQLUDopu9y/fkBi/KxYZyAnz4+beGfCssin0KoKsah8TnakqjUzd
         Lo/w55vBII0Mgw83Kbaj3ibBbU1Zlurm44wW8Nx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 4.14 00/26] 4.14.320-rc1 review
Date:   Mon, 26 Jun 2023 20:11:02 +0200
Message-ID: <20230626180733.699092073@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.320-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.320-rc1
X-KernelTest-Deadline: 2023-06-28T18:07+00:00
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

This is the start of the stable review cycle for the 4.14.320 release.
There are 26 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.320-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.320-rc1

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

Vineeth Vijayan <vneethv@linux.ibm.com>
    s390/cio: unregister device when the only path is gone

Dan Carpenter <dan.carpenter@linaro.org>
    usb: gadget: udc: fix NULL dereference in remove()

Helge Deller <deller@gmx.de>
    fbdev: imsttfb: Release framebuffer and dealloc cmap on error path

Osama Muhammad <osmtendev@gmail.com>
    nfcsim.c: Fix error checking for debugfs_create_dir

Marc Zyngier <maz@kernel.org>
    arm64: Add missing Set/Way CMO encodings

Denis Arefev <arefev@swemel.ru>
    HID: wacom: Add error check to wacom_parse_and_register()

Maurizio Lombardi <mlombard@redhat.com>
    scsi: target: iscsi: Prevent login threads from racing between each other

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow element updates of bound anonymous sets

Ross Lagerwall <ross.lagerwall@citrix.com>
    be2net: Extend xmit workaround to BE3 chip

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: usdhi60rol0: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: omap_hsmmc: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: omap: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: mtk-sd: fix deferred probing

Stefan Wahren <stefan.wahren@i2se.com>
    net: qca_spi: Avoid high load if QCA7000 is not available

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    xfrm: Linearize the skb after offloading if needed.

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent general protection fault in nilfs_clear_dirty_page()

Xiu Jianfeng <xiujianfeng@huawei.com>
    cgroup: Do not corrupt task iteration when rebinding subsystem

Michael Kelley <mikelley@microsoft.com>
    Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to scan present CPUs

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix buffer corruption due to concurrent device reads

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: reject devices with insufficient block count

Bernhard Seibold <mail@bernhard-seibold.de>
    serial: lantiq: add missing interrupt ack


-------------

Diffstat:

 Makefile                                    |  4 +--
 arch/arm64/include/asm/sysreg.h             |  6 ++++
 arch/x86/kernel/apic/x2apic_phys.c          |  5 +++-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c     |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c    |  2 --
 drivers/gpu/drm/radeon/radeon_gem.c         |  4 +--
 drivers/hid/wacom_sys.c                     |  7 ++++-
 drivers/hv/channel_mgmt.c                   | 18 ++++++++++--
 drivers/i2c/busses/i2c-imx-lpi2c.c          |  4 +--
 drivers/mmc/host/mtk-sd.c                   |  2 +-
 drivers/mmc/host/omap.c                     |  2 +-
 drivers/mmc/host/omap_hsmmc.c               |  6 ++--
 drivers/mmc/host/usdhi6rol0.c               |  6 ++--
 drivers/net/ethernet/emulex/benet/be_main.c |  4 +--
 drivers/net/ethernet/qualcomm/qca_spi.c     |  3 +-
 drivers/nfc/nfcsim.c                        |  4 ---
 drivers/s390/cio/device.c                   |  5 +++-
 drivers/target/iscsi/iscsi_target_nego.c    |  4 ++-
 drivers/tty/serial/lantiq.c                 |  1 +
 drivers/usb/gadget/udc/amd5536udc_pci.c     |  3 ++
 drivers/video/fbdev/imsttfb.c               |  6 +++-
 fs/nilfs2/page.c                            | 10 ++++++-
 fs/nilfs2/segbuf.c                          |  6 ++++
 fs/nilfs2/segment.c                         |  7 +++++
 fs/nilfs2/super.c                           | 25 ++++++++++++++--
 fs/nilfs2/the_nilfs.c                       | 44 ++++++++++++++++++++++++++++-
 kernel/cgroup/cgroup.c                      | 20 +++++++++++--
 net/ipv4/esp4_offload.c                     |  3 ++
 net/ipv6/esp6_offload.c                     |  3 ++
 net/netfilter/nf_tables_api.c               |  7 +++--
 30 files changed, 183 insertions(+), 40 deletions(-)


