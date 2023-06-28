Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A33B740D27
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjF1JcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:32:06 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:48104 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjF1J0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:26:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2506D61299;
        Wed, 28 Jun 2023 09:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD87C433C0;
        Wed, 28 Jun 2023 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687944366;
        bh=+d0GdeoxlDi3SqYHYCHqNcZavHXSb7qbFKMppeXUyUg=;
        h=From:To:Cc:Subject:Date:From;
        b=r5JP9fgMZWXJC/zOa86cmF34FI1e48kR6PTUwYC7OIC797nSG+60Rv6BXHE1tdOWp
         +D2gjFzMvwoXPb8cNm2/K4WPEkcTS+OmEhssAW44hFVXD0eyZoFOYSULvFouDk6fqJ
         i50GNqfFgoiA5N2NZzwHky4N8AYmddm9zJoeXza0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.119
Date:   Wed, 28 Jun 2023 11:25:44 +0200
Message-ID: <2023062845-magnify-roundup-f735@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.15.119 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts                      |    2 
 arch/arm/boot/dts/at91sam9261ek.dts                            |    2 
 arch/arm/boot/dts/imx7d-pico-hobbit.dts                        |    2 
 arch/arm/boot/dts/imx7d-sdb.dts                                |    2 
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                            |    2 
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi             |    2 
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi                        |    2 
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi                |    2 
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi                |    2 
 arch/arm/boot/dts/omap3-pandora-common.dtsi                    |    2 
 arch/arm/boot/dts/omap5-cm-t54.dts                             |    2 
 arch/arm64/include/asm/sysreg.h                                |    6 
 arch/s390/purgatory/Makefile                                   |    1 
 arch/x86/kernel/apic/x2apic_phys.c                             |    5 
 arch/x86/mm/kaslr.c                                            |    8 
 drivers/acpi/acpica/achware.h                                  |    2 
 drivers/acpi/sleep.c                                           |   16 
 drivers/base/regmap/regmap-spi-avmm.c                          |    2 
 drivers/char/tpm/tpm_tis_core.c                                |    2 
 drivers/gpio/gpio-sifive.c                                     |    8 
 drivers/gpio/gpiolib.c                                         |   17 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |   72 
 drivers/gpu/drm/amd/display/dc/core/dc.c                       |  277 ++
 drivers/gpu/drm/amd/display/dc/dc_stream.h                     |   18 
 drivers/gpu/drm/exynos/exynos_drm_g2d.c                        |    2 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                       |    2 
 drivers/gpu/drm/radeon/radeon_gem.c                            |    4 
 drivers/hid/wacom_sys.c                                        |    7 
 drivers/hv/channel_mgmt.c                                      |   18 
 drivers/hv/vmbus_drv.c                                         |    5 
 drivers/i2c/busses/i2c-imx-lpi2c.c                             |    4 
 drivers/input/misc/soc_button_array.c                          |   30 
 drivers/media/cec/core/cec-adap.c                              |    3 
 drivers/mmc/host/meson-gx-mmc.c                                |   14 
 drivers/mmc/host/mmci.c                                        |    3 
 drivers/mmc/host/mtk-sd.c                                      |    2 
 drivers/mmc/host/mvsdio.c                                      |    2 
 drivers/mmc/host/omap.c                                        |    2 
 drivers/mmc/host/omap_hsmmc.c                                  |    6 
 drivers/mmc/host/owl-mmc.c                                     |    2 
 drivers/mmc/host/sdhci-acpi.c                                  |    2 
 drivers/mmc/host/sdhci-msm.c                                   |    3 
 drivers/mmc/host/sh_mmcif.c                                    |    2 
 drivers/mmc/host/usdhi6rol0.c                                  |    6 
 drivers/net/dsa/mt7530.c                                       |   16 
 drivers/net/ethernet/emulex/benet/be_main.c                    |    4 
 drivers/net/ethernet/qualcomm/qca_spi.c                        |    3 
 drivers/net/ieee802154/mac802154_hwsim.c                       |    6 
 drivers/net/phy/dp83867.c                                      |    2 
 drivers/nfc/nfcsim.c                                           |    4 
 drivers/nvme/host/core.c                                       |   18 
 drivers/pci/controller/pci-hyperv.c                            |  139 -
 drivers/s390/cio/device.c                                      |    5 
 drivers/soundwire/dmi-quirks.c                                 |    7 
 drivers/spi/spi-fsl-lpspi.c                                    |    7 
 drivers/target/iscsi/iscsi_target_nego.c                       |    4 
 drivers/usb/gadget/udc/amd5536udc_pci.c                        |    3 
 drivers/vhost/net.c                                            |   11 
 fs/nilfs2/page.c                                               |   10 
 fs/nilfs2/segbuf.c                                             |    6 
 fs/nilfs2/segment.c                                            |    7 
 fs/nilfs2/super.c                                              |   23 
 include/acpi/acpixf.h                                          |    1 
 include/linux/gpio/driver.h                                    |   19 
 include/linux/regulator/pca9450.h                              |    4 
 include/net/ip_tunnels.h                                       |   12 
 include/net/netfilter/nf_tables.h                              |   26 
 include/net/xfrm.h                                             |    1 
 include/trace/events/writeback.h                               |    2 
 io_uring/io_uring.c                                            |   15 
 kernel/bpf/btf.c                                               |   20 
 kernel/bpf/verifier.c                                          |   21 
 kernel/cgroup/cgroup.c                                         |   20 
 kernel/time/tick-common.c                                      |   13 
 kernel/time/tick-sched.c                                       |   13 
 kernel/trace/trace.c                                           |   11 
 kernel/trace/trace.h                                           |    1 
 kernel/trace/trace_events.c                                    |    2 
 kernel/trace/trace_events_synth.c                              |    2 
 mm/memfd.c                                                     |    3 
 net/ipv4/esp4_offload.c                                        |    3 
 net/ipv4/xfrm4_input.c                                         |    1 
 net/ipv6/esp6_offload.c                                        |    3 
 net/ipv6/xfrm6_input.c                                         |    3 
 net/netfilter/ipvs/ip_vs_xmit.c                                |    2 
 net/netfilter/nf_tables_api.c                                  |  183 +
 net/netfilter/nfnetlink_osf.c                                  |    1 
 net/netfilter/nft_immediate.c                                  |   90 
 net/netfilter/nft_set_pipapo.c                                 |    6 
 net/netfilter/xt_osf.c                                         |    1 
 net/sched/sch_netem.c                                          |    8 
 net/xfrm/Makefile                                              |    2 
 net/xfrm/xfrm_input.c                                          |    1 
 net/xfrm/xfrm_interface.c                                      | 1032 ---------
 net/xfrm/xfrm_interface_core.c                                 | 1078 ++++++++++
 net/xfrm/xfrm_policy.c                                         |   12 
 sound/soc/codecs/nau8824.c                                     |   24 
 sound/soc/generic/simple-card.c                                |    1 
 tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c  |  110 -
 tools/testing/selftests/mount_setattr/mount_setattr_test.c     |    7 
 tools/testing/selftests/net/fcnal-test.sh                      |   27 
 tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh |    4 
 tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh |    4 
 tools/testing/selftests/net/forwarding/tc_actions.sh           |    1 
 tools/testing/selftests/net/mptcp/config                       |    1 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                |  181 -
 tools/testing/selftests/net/mptcp/mptcp_lib.sh                 |   64 
 tools/testing/selftests/net/mptcp/pm_netlink.sh                |   12 
 virt/kvm/kvm_main.c                                            |   20 
 110 files changed, 2483 insertions(+), 1437 deletions(-)

Alexander Gordeev (1):
      s390/purgatory: disable branch profiling

Andrey Smetanin (1):
      vhost_net: revert upend_idx only on retriable error

Arınç ÜNAL (2):
      net: dsa: mt7530: fix trapping frames on non-MT7621 SoC MT7530 switch
      net: dsa: mt7530: fix handling of BPDUs on MT7530 switch

Benedict Wong (2):
      xfrm: Treat already-verified secpath entries as optional
      xfrm: Ensure policies always checked on XFRM-I input path

Chen Aotian (1):
      ieee802154: hwsim: Fix possible memory leaks

Christophe Kerello (1):
      mmc: mmci: stm32: fix max busy timeout calculation

Clark Wang (2):
      spi: lpspi: disable lpspi module irq in DMA mode
      i2c: imx-lpi2c: fix type char overflow issue when calculating the clock cycle

Dan Carpenter (1):
      usb: gadget: udc: fix NULL dereference in remove()

Danielle Ratson (1):
      selftests: forwarding: Fix race condition in mirror installation

Denis Arefev (1):
      HID: wacom: Add error check to wacom_parse_and_register()

Dexuan Cui (6):
      Drivers: hv: vmbus: Call hv_synic_free() if hv_synic_alloc() fails
      PCI: hv: Fix a race condition bug in hv_pci_query_relations()
      Revert "PCI: hv: Fix a timing issue which causes kdump to fail occasionally"
      PCI: hv: Remove the useless hv_pcichild_state from struct hv_pci_dev
      PCI: hv: Fix a race condition in hv_irq_unmask() that can cause panic
      PCI: hv: Add a per-bus mutex state_lock

Dheeraj Kumar Srivastava (1):
      x86/apic: Fix kernel panic when booting with intremap=off and x2apic_phys

Edson Juliano Drosdeck (1):
      ASoC: nau8824: Add quirk to active-high jack-detect

Eduard Zingerman (1):
      bpf: track immediate values written to stack by BPF_ST instruction

Eric Dumazet (1):
      sch_netem: acquire qdisc lock in netem_change()

Eyal Birger (1):
      xfrm: interface: rename xfrm_interface.c to xfrm_interface_core.c

Florent Revest (1):
      bpf/btf: Accept function names that contain dots

Francesco Dolcini (1):
      Revert "net: phy: dp83867: perform soft reset and retain established link"

Gavin Shan (1):
      KVM: Avoid illegal stage2 mapping on invalid memory slot

Greg Kroah-Hartman (2):
      act_mirred: remove unneded merge conflict markers
      Linux 5.15.119

Hans Verkuil (1):
      media: cec: core: don't set last_initiator if tx in progress

Hans de Goede (1):
      Input: soc_button_array - add invalid acpi_index DMI quirk handling

Herve Codina (1):
      ASoC: simple-card: Add missing of_node_put() in case of error

Inki Dae (1):
      drm/exynos: vidi: fix a wrong error return

Jens Axboe (3):
      io_uring/net: save msghdr->msg_control for retries
      io_uring/net: clear msg_controllen on partial sendmsg retry
      io_uring/net: disable partial retries for recvmsg with cmsg

Jiasheng Jiang (1):
      gpio: sifive: add missing check for platform_get_irq

Jiawen Wu (1):
      gpiolib: Fix GPIO chip IRQ initialization restriction

Lee Jones (1):
      x86/mm: Avoid using set_pgd() outside of real PGD pages

Lino Sanfilippo (1):
      tpm, tpm_tis: Claim locality in interrupt handler

Linus Walleij (1):
      ARM: dts: Fix erroneous ADS touchscreen polarities

Maciej Żenczykowski (1):
      xfrm: fix inbound ipv4/udp/esp packets to UDPv6 dualstack sockets

Magali Lemes (1):
      selftests: net: fcnal-test: check if FIPS mode is enabled

Marc Zyngier (2):
      gpio: Allow per-parent interrupt data
      arm64: Add missing Set/Way CMO encodings

Martin Hundebøll (1):
      mmc: meson-gx: remove redundant mmc_request_done() call from irq context

Matthias May (1):
      ip_tunnels: allow VXLAN/GENEVE to inherit TOS/TTL from VLAN

Matthieu Baerts (5):
      selftests: mptcp: lib: skip if missing symbol
      selftests: mptcp: lib: skip if not below kernel version
      selftests: mptcp: pm nl: remove hardcoded default limits
      selftests: mptcp: join: use 'iptables-legacy' if available
      selftests: mptcp: join: skip check if MIB counter not supported

Maurizio Lombardi (1):
      scsi: target: iscsi: Prevent login threads from racing between each other

Maxim Mikityanskiy (1):
      bpf: Fix verifier id tracking of scalars on spill

Michael Kelley (1):
      Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to scan present CPUs

Min Li (2):
      drm/exynos: fix race condition UAF in exynos_g2d_exec_ioctl
      drm/radeon: fix race condition UAF in radeon_gem_set_domain_ioctl

Osama Muhammad (1):
      nfcsim.c: Fix error checking for debugfs_create_dir

Pablo Neira Ayuso (8):
      netfilter: nf_tables: fix chain binding transaction logic
      netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain
      netfilter: nft_set_pipapo: .walk does not deal with generations
      netfilter: nf_tables: disallow element updates of bound anonymous sets
      netfilter: nf_tables: reject unbound anonymous set before commit phase
      netfilter: nf_tables: reject unbound chain set before commit phase
      netfilter: nf_tables: disallow updates of anonymous sets
      netfilter: nfnetlink_osf: fix module autoload

Pierre-Louis Bossart (1):
      soundwire: dmi-quirks: add new mapping for HP Spectre x360

Rafael Aquini (1):
      writeback: fix dereferencing NULL mapping->host on writeback_page_template

Rafael J. Wysocki (1):
      ACPI: sleep: Avoid breaking S3 wakeup due to might_sleep()

Roberto Sassu (1):
      memfd: check for non-NULL file_seals in memfd_create() syscall

Rodrigo Siqueira (3):
      drm/amd/display: Add minimal pipe split transition state
      drm/amd/display: Use dc_update_planes_and_stream
      drm/amd/display: Add wrapper to call planes and stream update

Ross Lagerwall (1):
      be2net: Extend xmit workaround to BE3 chip

Russ Weight (1):
      regmap: spi-avmm: Fix regmap_bus max_raw_write

Ryusuke Konishi (2):
      nilfs2: fix buffer corruption due to concurrent device reads
      nilfs2: prevent general protection fault in nilfs_clear_dirty_page()

Sebastian Andrzej Siewior (1):
      xfrm: Linearize the skb after offloading if needed.

Sergey Shtylyov (9):
      mmc: meson-gx: fix deferred probing
      mmc: mtk-sd: fix deferred probing
      mmc: mvsdio: fix deferred probing
      mmc: omap: fix deferred probing
      mmc: omap_hsmmc: fix deferred probing
      mmc: owl: fix deferred probing
      mmc: sdhci-acpi: fix deferred probing
      mmc: sh_mmcif: fix deferred probing
      mmc: usdhi60rol0: fix deferred probing

Shuah Khan (1):
      selftests/mount_setattr: fix redefine struct mount_attr build error

Stefan Wahren (1):
      net: qca_spi: Avoid high load if QCA7000 is not available

Stephan Gerhold (1):
      mmc: sdhci-msm: Disable broken 64-bit DMA on MSM8916

Steven Rostedt (Google) (1):
      tracing: Add tracing_reset_all_online_cpus_unlocked() function

Teresa Remmet (1):
      regulator: pca9450: Fix LDO3OUT and LDO4OUT MASK

Terin Stock (1):
      ipvs: align inner_mac_header for encapsulation

Thomas Gleixner (1):
      tick/common: Align tick period during sched_timer setup

Tom Chung (1):
      drm/amd/display: fix the system hang while disable PSR

Uday Shankar (1):
      nvme: double KA polling frequency to avoid KATO with TBKAS on

Vineeth Vijayan (1):
      s390/cio: unregister device when the only path is gone

Xiu Jianfeng (1):
      cgroup: Do not corrupt task iteration when rebinding subsystem

