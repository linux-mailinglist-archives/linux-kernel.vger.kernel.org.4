Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E81973E9A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjFZSiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjFZSiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6B9AC;
        Mon, 26 Jun 2023 11:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B00760F52;
        Mon, 26 Jun 2023 18:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213AFC433C9;
        Mon, 26 Jun 2023 18:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804698;
        bh=RoiSxw4M+Jn56/z2Zzphtp4P3MGbzD+sW9cCuz87V1E=;
        h=From:To:Cc:Subject:Date:From;
        b=ubkOZk0VLexMESjgxq2AIzChRG47lgt3J4OlMvqq8CdJzmervylfjkNwab8lz5D+S
         LGvYKD6qJIyB+bY/XLAzo8nu4g70T0yku5Tz+T1jA4x+DkV+FyhC6r/2+SLIGJs3lS
         wsiQ1PE/UsfjUOV1IInGW3NJMDwckZ3Yivw+5OAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.15 00/96] 5.15.119-rc1 review
Date:   Mon, 26 Jun 2023 20:11:15 +0200
Message-ID: <20230626180746.943455203@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.119-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.119-rc1
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

This is the start of the stable review cycle for the 5.15.119 release.
There are 96 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.119-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.119-rc1

Clark Wang <xiaoning.wang@nxp.com>
    i2c: imx-lpi2c: fix type char overflow issue when calculating the clock cycle

Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
    x86/apic: Fix kernel panic when booting with intremap=off and x2apic_phys

Andrey Smetanin <asmetanin@yandex-team.ru>
    vhost_net: revert upend_idx only on retriable error

Min Li <lm0963hack@gmail.com>
    drm/radeon: fix race condition UAF in radeon_gem_set_domain_ioctl

Min Li <lm0963hack@gmail.com>
    drm/exynos: fix race condition UAF in exynos_g2d_exec_ioctl

Inki Dae <inki.dae@samsung.com>
    drm/exynos: vidi: fix a wrong error return

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: Fix erroneous ADS touchscreen polarities

Alexander Gordeev <agordeev@linux.ibm.com>
    s390/purgatory: disable branch profiling

Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
    ASoC: nau8824: Add quirk to active-high jack-detect

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    soundwire: dmi-quirks: add new mapping for HP Spectre x360

Herve Codina <herve.codina@bootlin.com>
    ASoC: simple-card: Add missing of_node_put() in case of error

Clark Wang <xiaoning.wang@nxp.com>
    spi: lpspi: disable lpspi module irq in DMA mode

Vineeth Vijayan <vneethv@linux.ibm.com>
    s390/cio: unregister device when the only path is gone

Hans de Goede <hdegoede@redhat.com>
    Input: soc_button_array - add invalid acpi_index DMI quirk handling

Uday Shankar <ushankar@purestorage.com>
    nvme: double KA polling frequency to avoid KATO with TBKAS on

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

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    gpio: sifive: add missing check for platform_get_irq

Jiawen Wu <jiawenwu@trustnetic.com>
    gpiolib: Fix GPIO chip IRQ initialization restriction

Marc Zyngier <maz@kernel.org>
    gpio: Allow per-parent interrupt data

Eric Dumazet <edumazet@google.com>
    sch_netem: acquire qdisc lock in netem_change()

Danielle Ratson <danieller@nvidia.com>
    selftests: forwarding: Fix race condition in mirror installation

Florent Revest <revest@chromium.org>
    bpf/btf: Accept function names that contain dots

Francesco Dolcini <francesco.dolcini@toradex.com>
    Revert "net: phy: dp83867: perform soft reset and retain established link"

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nfnetlink_osf: fix module autoload

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow updates of anonymous sets

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject unbound chain set before commit phase

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject unbound anonymous set before commit phase

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow element updates of bound anonymous sets

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_pipapo: .walk does not deal with generations

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: fix chain binding transaction logic

Ross Lagerwall <ross.lagerwall@citrix.com>
    be2net: Extend xmit workaround to BE3 chip

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix handling of BPDUs on MT7530 switch

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
    mmc: owl: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: omap_hsmmc: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: omap: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: mvsdio: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: mtk-sd: fix deferred probing

Stefan Wahren <stefan.wahren@i2se.com>
    net: qca_spi: Avoid high load if QCA7000 is not available

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    xfrm: Linearize the skb after offloading if needed.

Magali Lemes <magali.lemes@canonical.com>
    selftests: net: fcnal-test: check if FIPS mode is enabled

Maciej Żenczykowski <maze@google.com>
    xfrm: fix inbound ipv4/udp/esp packets to UDPv6 dualstack sockets

Maxim Mikityanskiy <maxim@isovalent.com>
    bpf: Fix verifier id tracking of scalars on spill

Eduard Zingerman <eddyz87@gmail.com>
    bpf: track immediate values written to stack by BPF_ST instruction

Benedict Wong <benedictwong@google.com>
    xfrm: Ensure policies always checked on XFRM-I input path

Eyal Birger <eyal.birger@gmail.com>
    xfrm: interface: rename xfrm_interface.c to xfrm_interface_core.c

Benedict Wong <benedictwong@google.com>
    xfrm: Treat already-verified secpath entries as optional

Chen Aotian <chenaotian2@163.com>
    ieee802154: hwsim: Fix possible memory leaks

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: meson-gx: fix deferred probing

Roberto Sassu <roberto.sassu@huawei.com>
    memfd: check for non-NULL file_seals in memfd_create() syscall

Lee Jones <lee@kernel.org>
    x86/mm: Avoid using set_pgd() outside of real PGD pages

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent general protection fault in nilfs_clear_dirty_page()

Jens Axboe <axboe@kernel.dk>
    io_uring/net: disable partial retries for recvmsg with cmsg

Jens Axboe <axboe@kernel.dk>
    io_uring/net: clear msg_controllen on partial sendmsg retry

Jens Axboe <axboe@kernel.dk>
    io_uring/net: save msghdr->msg_control for retries

Rafael Aquini <aquini@redhat.com>
    writeback: fix dereferencing NULL mapping->host on writeback_page_template

Russ Weight <russell.h.weight@intel.com>
    regmap: spi-avmm: Fix regmap_bus max_raw_write

Teresa Remmet <t.remmet@phytec.de>
    regulator: pca9450: Fix LDO3OUT and LDO4OUT MASK

Matthias May <matthias.may@westermo.com>
    ip_tunnels: allow VXLAN/GENEVE to inherit TOS/TTL from VLAN

Christophe Kerello <christophe.kerello@foss.st.com>
    mmc: mmci: stm32: fix max busy timeout calculation

Martin Hundebøll <martin@geanix.com>
    mmc: meson-gx: remove redundant mmc_request_done() call from irq context

Stephan Gerhold <stephan@gerhold.net>
    mmc: sdhci-msm: Disable broken 64-bit DMA on MSM8916

Xiu Jianfeng <xiujianfeng@huawei.com>
    cgroup: Do not corrupt task iteration when rebinding subsystem

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Add a per-bus mutex state_lock

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Fix a race condition in hv_irq_unmask() that can cause panic

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Remove the useless hv_pcichild_state from struct hv_pci_dev

Dexuan Cui <decui@microsoft.com>
    Revert "PCI: hv: Fix a timing issue which causes kdump to fail occasionally"

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Fix a race condition bug in hv_pci_query_relations()

Michael Kelley <mikelley@microsoft.com>
    Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to scan present CPUs

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: Call hv_synic_free() if hv_synic_alloc() fails

Gavin Shan <gshan@redhat.com>
    KVM: Avoid illegal stage2 mapping on invalid memory slot

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: sleep: Avoid breaking S3 wakeup due to might_sleep()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix buffer corruption due to concurrent device reads

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: skip check if MIB counter not supported

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: use 'iptables-legacy' if available

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: pm nl: remove hardcoded default limits

Shuah Khan <skhan@linuxfoundation.org>
    selftests/mount_setattr: fix redefine struct mount_attr build error

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: lib: skip if not below kernel version

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: lib: skip if missing symbol

Thomas Gleixner <tglx@linutronix.de>
    tick/common: Align tick period during sched_timer setup

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Add wrapper to call planes and stream update

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Use dc_update_planes_and_stream

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Add minimal pipe split transition state

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    tpm, tpm_tis: Claim locality in interrupt handler

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Add tracing_reset_all_online_cpus_unlocked() function

Tom Chung <chiahsuan.chung@amd.com>
    drm/amd/display: fix the system hang while disable PSR


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
 arch/s390/purgatory/Makefile                       |   1 +
 arch/x86/kernel/apic/x2apic_phys.c                 |   5 +-
 arch/x86/mm/kaslr.c                                |   8 +-
 drivers/acpi/acpica/achware.h                      |   2 -
 drivers/acpi/sleep.c                               |  16 +-
 drivers/base/regmap/regmap-spi-avmm.c              |   2 +-
 drivers/char/tpm/tpm_tis_core.c                    |   2 +
 drivers/gpio/gpio-sifive.c                         |   8 +-
 drivers/gpio/gpiolib.c                             |  17 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  72 ++++--
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 277 +++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |  20 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |   2 -
 drivers/gpu/drm/radeon/radeon_gem.c                |   4 +-
 drivers/hid/wacom_sys.c                            |   7 +-
 drivers/hv/channel_mgmt.c                          |  18 +-
 drivers/hv/vmbus_drv.c                             |   5 +-
 drivers/i2c/busses/i2c-imx-lpi2c.c                 |   4 +-
 drivers/input/misc/soc_button_array.c              |  30 +++
 drivers/media/cec/core/cec-adap.c                  |   3 +-
 drivers/mmc/host/meson-gx-mmc.c                    |  14 +-
 drivers/mmc/host/mmci.c                            |   3 +-
 drivers/mmc/host/mtk-sd.c                          |   2 +-
 drivers/mmc/host/mvsdio.c                          |   2 +-
 drivers/mmc/host/omap.c                            |   2 +-
 drivers/mmc/host/omap_hsmmc.c                      |   6 +-
 drivers/mmc/host/owl-mmc.c                         |   2 +-
 drivers/mmc/host/sdhci-acpi.c                      |   2 +-
 drivers/mmc/host/sdhci-msm.c                       |   3 +
 drivers/mmc/host/sh_mmcif.c                        |   2 +-
 drivers/mmc/host/usdhi6rol0.c                      |   6 +-
 drivers/net/dsa/mt7530.c                           |  16 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   4 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            |   3 +-
 drivers/net/ieee802154/mac802154_hwsim.c           |   6 +-
 drivers/net/phy/dp83867.c                          |   2 +-
 drivers/nfc/nfcsim.c                               |   4 -
 drivers/nvme/host/core.c                           |  18 +-
 drivers/pci/controller/pci-hyperv.c                | 139 ++++++-----
 drivers/s390/cio/device.c                          |   5 +-
 drivers/soundwire/dmi-quirks.c                     |   7 +
 drivers/spi/spi-fsl-lpspi.c                        |   7 +-
 drivers/target/iscsi/iscsi_target_nego.c           |   4 +-
 drivers/usb/gadget/udc/amd5536udc_pci.c            |   3 +
 drivers/vhost/net.c                                |  11 +-
 fs/nilfs2/page.c                                   |  10 +-
 fs/nilfs2/segbuf.c                                 |   6 +
 fs/nilfs2/segment.c                                |   7 +
 fs/nilfs2/super.c                                  |  25 +-
 include/acpi/acpixf.h                              |   1 +
 include/linux/gpio/driver.h                        |  19 +-
 include/linux/regulator/pca9450.h                  |   4 +-
 include/net/ip_tunnels.h                           |  12 +-
 include/net/netfilter/nf_tables.h                  |  26 +-
 include/net/xfrm.h                                 |   1 +
 include/trace/events/writeback.h                   |   2 +-
 io_uring/io_uring.c                                |  15 +-
 kernel/bpf/btf.c                                   |  20 +-
 kernel/bpf/verifier.c                              |  21 +-
 kernel/cgroup/cgroup.c                             |  20 +-
 kernel/time/tick-common.c                          |  13 +-
 kernel/time/tick-sched.c                           |  13 +-
 kernel/trace/trace.c                               |  11 +-
 kernel/trace/trace.h                               |   1 +
 kernel/trace/trace_events.c                        |   2 +-
 kernel/trace/trace_events_synth.c                  |   2 -
 mm/memfd.c                                         |   3 +-
 net/ipv4/esp4_offload.c                            |   3 +
 net/ipv4/xfrm4_input.c                             |   1 +
 net/ipv6/esp6_offload.c                            |   3 +
 net/ipv6/xfrm6_input.c                             |   3 +
 net/netfilter/ipvs/ip_vs_xmit.c                    |   2 +
 net/netfilter/nf_tables_api.c                      | 183 +++++++++++---
 net/netfilter/nfnetlink_osf.c                      |   1 +
 net/netfilter/nft_immediate.c                      |  90 ++++++-
 net/netfilter/nft_set_pipapo.c                     |   6 +-
 net/netfilter/xt_osf.c                             |   1 -
 net/sched/sch_netem.c                              |   8 +-
 net/xfrm/Makefile                                  |   2 +
 net/xfrm/xfrm_input.c                              |   1 +
 .../{xfrm_interface.c => xfrm_interface_core.c}    |  54 +++-
 net/xfrm/xfrm_policy.c                             |  12 +
 sound/soc/codecs/nau8824.c                         |  24 ++
 sound/soc/generic/simple-card.c                    |   1 +
 .../bpf/verifier/bounds_mix_sign_unsign.c          | 110 ++++----
 .../selftests/mount_setattr/mount_setattr_test.c   |   7 -
 tools/testing/selftests/net/fcnal-test.sh          |  27 +-
 .../net/forwarding/mirror_gre_bridge_1d.sh         |   4 +
 .../net/forwarding/mirror_gre_bridge_1q.sh         |   4 +
 tools/testing/selftests/net/mptcp/config           |   1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 181 ++++++++------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  64 +++++
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  12 +-
 virt/kvm/kvm_main.c                                |  20 +-
 108 files changed, 1458 insertions(+), 411 deletions(-)


