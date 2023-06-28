Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D8F740DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjF1Jwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:52:37 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:48480 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjF1J01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:26:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78CCC60E9D;
        Wed, 28 Jun 2023 09:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22757C433C8;
        Wed, 28 Jun 2023 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687944385;
        bh=1VgkIU4Q3t42RzVtRsjh1xy6RPrO2tlBdAINn0EkxTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=E1lz2fJ0FElw86hBPXMB6dEfoVy2oZ3A7ccPPz76sOKOW5FPHBxFTIwAO4qUzmsgG
         2vaoQJi9XlcIy5ziMDrRtHJjMLppNLwSN5yvhkO7f5JmyaiwoZlaU6iUwqexjz57yE
         OYBFYsLeYL9Alo/rOH0agl99WEZQhp879W/ildlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.3.10
Date:   Wed, 28 Jun 2023 11:26:00 +0200
Message-ID: <2023062800-broiling-robbing-f482@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.3.10 kernel.

All users of the 6.3 kernel series must upgrade.

The updated 6.3.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.3.y
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
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                       |    2 
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                     |    2 
 arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts           |   18 
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi              |   29 
 arch/arm64/boot/dts/rockchip/rk3568.dtsi                       |   14 
 arch/arm64/boot/dts/rockchip/rk356x.dtsi                       |    7 
 arch/arm64/include/asm/sysreg.h                                |    6 
 arch/arm64/kvm/hyp/include/hyp/switch.h                        |   13 
 arch/arm64/kvm/vgic/vgic-init.c                                |   11 
 arch/riscv/Makefile                                            |    2 
 arch/s390/purgatory/Makefile                                   |    1 
 arch/x86/Makefile                                              |   12 
 arch/x86/include/asm/Kbuild                                    |    1 
 arch/x86/include/asm/orc_header.h                              |   19 
 arch/x86/kernel/apic/x2apic_phys.c                             |    5 
 arch/x86/kernel/unwind_orc.c                                   |    3 
 arch/x86/mm/kaslr.c                                            |    8 
 arch/x86/net/bpf_jit_comp.c                                    |    2 
 block/blk-cgroup.c                                             |    5 
 drivers/acpi/acpica/achware.h                                  |    2 
 drivers/acpi/sleep.c                                           |   16 
 drivers/ata/libata-core.c                                      |    3 
 drivers/ata/libata-eh.c                                        |    2 
 drivers/ata/libata-scsi.c                                      |   22 
 drivers/base/regmap/regmap-spi-avmm.c                          |    2 
 drivers/block/null_blk/main.c                                  |    1 
 drivers/block/virtio_blk.c                                     |   82 -
 drivers/char/tpm/tpm_tis_core.c                                |    2 
 drivers/dma-buf/udmabuf.c                                      |   47 
 drivers/firmware/efi/efi.c                                     |   21 
 drivers/gpio/gpio-sifive.c                                     |    8 
 drivers/gpio/gpiolib.c                                         |   11 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |   73 -
 drivers/gpu/drm/exynos/exynos_drm_g2d.c                        |    2 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                       |    2 
 drivers/gpu/drm/radeon/radeon_gem.c                            |    4 
 drivers/hid/wacom_sys.c                                        |    7 
 drivers/hv/channel_mgmt.c                                      |   18 
 drivers/hv/vmbus_drv.c                                         |    5 
 drivers/i2c/busses/i2c-designware-core.h                       |    1 
 drivers/i2c/busses/i2c-designware-slave.c                      |    4 
 drivers/i2c/busses/i2c-imx-lpi2c.c                             |    4 
 drivers/i2c/busses/i2c-mchp-pci1xxxx.c                         |    6 
 drivers/input/misc/soc_button_array.c                          |   30 
 drivers/iommu/amd/iommu.c                                      |    8 
 drivers/media/cec/core/cec-adap.c                              |    8 
 drivers/media/cec/core/cec-core.c                              |    2 
 drivers/media/cec/core/cec-priv.h                              |    1 
 drivers/mmc/host/bcm2835.c                                     |    4 
 drivers/mmc/host/litex_mmc.c                                   |    1 
 drivers/mmc/host/meson-gx-mmc.c                                |   14 
 drivers/mmc/host/mmci.c                                        |    3 
 drivers/mmc/host/mtk-sd.c                                      |    2 
 drivers/mmc/host/mvsdio.c                                      |    2 
 drivers/mmc/host/omap.c                                        |    2 
 drivers/mmc/host/omap_hsmmc.c                                  |    6 
 drivers/mmc/host/owl-mmc.c                                     |    2 
 drivers/mmc/host/sdhci-acpi.c                                  |    2 
 drivers/mmc/host/sdhci-msm.c                                   |    3 
 drivers/mmc/host/sdhci-spear.c                                 |    4 
 drivers/mmc/host/sh_mmcif.c                                    |    2 
 drivers/mmc/host/sunxi-mmc.c                                   |    4 
 drivers/mmc/host/usdhi6rol0.c                                  |    6 
 drivers/net/dsa/mt7530.c                                       |   35 
 drivers/net/dsa/mt7530.h                                       |    5 
 drivers/net/ethernet/emulex/benet/be_main.c                    |    4 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c   |    9 
 drivers/net/ethernet/qualcomm/qca_spi.c                        |    3 
 drivers/net/ethernet/sfc/ef10.c                                |   25 
 drivers/net/ethernet/sfc/ef100_nic.c                           |    7 
 drivers/net/ethernet/sfc/ef100_tx.c                            |    4 
 drivers/net/ethernet/sfc/ef100_tx.h                            |    2 
 drivers/net/ethernet/sfc/tx_common.c                           |    4 
 drivers/net/ethernet/sfc/tx_common.h                           |    2 
 drivers/net/ieee802154/mac802154_hwsim.c                       |    6 
 drivers/net/phy/dp83867.c                                      |    2 
 drivers/net/phy/mdio_bus.c                                     |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                  |    2 
 drivers/nfc/nfcsim.c                                           |    4 
 drivers/nvme/host/core.c                                       |   52 
 drivers/nvme/host/ioctl.c                                      |    2 
 drivers/nvme/host/nvme.h                                       |    3 
 drivers/nvme/target/passthru.c                                 |    2 
 drivers/pci/controller/pci-hyperv.c                            |  139 +-
 drivers/platform/x86/amd/pmf/core.c                            |   10 
 drivers/platform/x86/intel/int3472/clk_and_regulator.c         |   13 
 drivers/s390/cio/device.c                                      |    5 
 drivers/soundwire/dmi-quirks.c                                 |    7 
 drivers/soundwire/qcom.c                                       |   17 
 drivers/spi/spi-fsl-lpspi.c                                    |    7 
 drivers/spi/spi-geni-qcom.c                                    |    2 
 drivers/target/iscsi/iscsi_target.c                            |    2 
 drivers/target/iscsi/iscsi_target_login.c                      |   63 -
 drivers/target/iscsi/iscsi_target_nego.c                       |   74 -
 drivers/target/iscsi/iscsi_target_util.c                       |   51 
 drivers/target/iscsi/iscsi_target_util.h                       |    4 
 drivers/thermal/intel/intel_soc_dts_iosf.c                     |    2 
 drivers/usb/gadget/udc/amd5536udc_pci.c                        |    3 
 drivers/vhost/net.c                                            |   11 
 drivers/vhost/vdpa.c                                           |   13 
 fs/afs/write.c                                                 |    7 
 fs/btrfs/tree-log.c                                            |    2 
 fs/cifs/connect.c                                              |    9 
 fs/cifs/dfs.c                                                  |    9 
 fs/cifs/smb2pdu.c                                              |    2 
 fs/gfs2/file.c                                                 |   17 
 fs/internal.h                                                  |    2 
 fs/ksmbd/server.c                                              |   33 
 fs/ksmbd/smb2misc.c                                            |   33 
 fs/ksmbd/smb2pdu.c                                             |  223 +---
 fs/ksmbd/smbacl.c                                              |   10 
 fs/ksmbd/vfs.c                                                 |  557 +++++-----
 fs/ksmbd/vfs.h                                                 |   36 
 fs/ksmbd/vfs_cache.c                                           |    7 
 fs/namei.c                                                     |  125 +-
 fs/nilfs2/page.c                                               |   10 
 fs/nilfs2/segbuf.c                                             |    6 
 fs/nilfs2/segment.c                                            |    7 
 fs/nilfs2/super.c                                              |   23 
 include/acpi/acpixf.h                                          |    1 
 include/asm-generic/vmlinux.lds.h                              |    3 
 include/linux/gpio/driver.h                                    |    8 
 include/linux/libata.h                                         |    2 
 include/linux/namei.h                                          |    9 
 include/linux/regulator/pca9450.h                              |    4 
 include/net/dsa.h                                              |    8 
 include/net/netfilter/nf_tables.h                              |   31 
 include/net/xfrm.h                                             |    1 
 include/target/iscsi/iscsi_target_core.h                       |    7 
 include/trace/events/writeback.h                               |    2 
 io_uring/net.c                                                 |   17 
 io_uring/poll.c                                                |    9 
 kernel/bpf/btf.c                                               |   20 
 kernel/bpf/syscall.c                                           |    5 
 kernel/bpf/verifier.c                                          |   10 
 kernel/cgroup/cgroup.c                                         |   20 
 kernel/cgroup/legacy_freezer.c                                 |    8 
 kernel/time/tick-common.c                                      |   13 
 kernel/time/tick-sched.c                                       |   13 
 mm/maccess.c                                                   |   16 
 mm/memfd.c                                                     |    9 
 mm/mprotect.c                                                  |    2 
 mm/usercopy.c                                                  |    2 
 mm/vmalloc.c                                                   |   17 
 net/core/sock.c                                                |    6 
 net/dsa/dsa.c                                                  |   24 
 net/ipv4/esp4_offload.c                                        |    3 
 net/ipv4/xfrm4_input.c                                         |    1 
 net/ipv6/esp6_offload.c                                        |    3 
 net/ipv6/xfrm6_input.c                                         |    3 
 net/mptcp/pm_netlink.c                                         |    1 
 net/mptcp/protocol.c                                           |  111 +
 net/mptcp/subflow.c                                            |   17 
 net/netfilter/ipvs/ip_vs_xmit.c                                |    2 
 net/netfilter/nf_tables_api.c                                  |  330 ++++-
 net/netfilter/nfnetlink_osf.c                                  |    1 
 net/netfilter/nft_immediate.c                                  |   90 +
 net/netfilter/nft_set_bitmap.c                                 |    5 
 net/netfilter/nft_set_hash.c                                   |   23 
 net/netfilter/nft_set_pipapo.c                                 |   20 
 net/netfilter/nft_set_rbtree.c                                 |    5 
 net/netfilter/xt_osf.c                                         |    1 
 net/sched/sch_api.c                                            |    2 
 net/sched/sch_netem.c                                          |    8 
 net/xfrm/xfrm_input.c                                          |    1 
 net/xfrm/xfrm_interface_core.c                                 |   54 
 net/xfrm/xfrm_policy.c                                         |   14 
 scripts/gfp-translate                                          |    6 
 scripts/mod/modpost.c                                          |    5 
 scripts/orc_hash.sh                                            |   16 
 sound/pci/hda/patch_realtek.c                                  |    2 
 sound/soc/amd/yc/acp6x-mach.c                                  |    7 
 sound/soc/codecs/nau8824.c                                     |   24 
 sound/soc/codecs/wcd938x-sdw.c                                 |    1 
 sound/soc/fsl/fsl_sai.c                                        |   11 
 sound/soc/fsl/fsl_sai.h                                        |    1 
 sound/soc/generic/simple-card.c                                |    1 
 tools/testing/selftests/net/fcnal-test.sh                      |   27 
 tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh |    4 
 tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh |    4 
 tools/testing/selftests/net/mptcp/config                       |    1 
 tools/testing/selftests/net/mptcp/diag.sh                      |   42 
 tools/testing/selftests/net/mptcp/mptcp_connect.c              |    8 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh             |   20 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                |  523 ++++++---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh                 |   64 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c              |   18 
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh             |   20 
 tools/testing/selftests/net/mptcp/pm_netlink.sh                |   27 
 tools/testing/selftests/net/mptcp/userspace_pm.sh              |   13 
 tools/testing/selftests/net/tls.c                              |   24 
 tools/testing/selftests/net/vrf-xfrm-tests.sh                  |   32 
 tools/virtio/ringtest/main.h                                   |   11 
 virt/kvm/kvm_main.c                                            |   20 
 206 files changed, 2801 insertions(+), 1444 deletions(-)

Al Viro (1):
      fs: introduce lock_rename_child() helper

Alexander Gordeev (1):
      s390/purgatory: disable branch profiling

Alexei Starovoitov (1):
      mm: Fix copy_from_user_nofault().

Andreas Gruenbacher (1):
      gfs2: Don't get stuck writing page onto itself under direct I/O

Andrew Powers-Holmes (1):
      arm64: dts: rockchip: Fix rk356x PCIe register and range mappings

Andrey Smetanin (1):
      vhost_net: revert upend_idx only on retriable error

Arınç ÜNAL (3):
      net: dsa: mt7530: fix trapping frames on non-MT7621 SoC MT7530 switch
      net: dsa: mt7530: fix handling of BPDUs on MT7530 switch
      net: dsa: mt7530: fix handling of LLDP frames

Benedict Wong (2):
      xfrm: Treat already-verified secpath entries as optional
      xfrm: Ensure policies always checked on XFRM-I input path

Chancel Liu (1):
      ASoC: fsl_sai: Enable BCI bit if SAI works on synchronous mode with BYP asserted

Chen Aotian (1):
      ieee802154: hwsim: Fix possible memory leaks

Christophe Kerello (1):
      mmc: mmci: stm32: fix max busy timeout calculation

Clark Wang (2):
      spi: lpspi: disable lpspi module irq in DMA mode
      i2c: imx-lpi2c: fix type char overflow issue when calculating the clock cycle

Damien Le Moal (1):
      ata: libata-scsi: Avoid deadlock on rescan after device resume

Dan Carpenter (1):
      usb: gadget: udc: fix NULL dereference in remove()

Danielle Ratson (1):
      selftests: forwarding: Fix race condition in mirror installation

David Zheng (1):
      i2c: designware: fix idx_write_cnt in read loop

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

Eric Dumazet (1):
      sch_netem: acquire qdisc lock in netem_change()

Florent Revest (1):
      bpf/btf: Accept function names that contain dots

Francesco Dolcini (1):
      Revert "net: phy: dp83867: perform soft reset and retain established link"

Gavin Shan (1):
      KVM: Avoid illegal stage2 mapping on invalid memory slot

Greg Kroah-Hartman (1):
      Linux 6.3.10

Hans Verkuil (2):
      media: cec: core: disable adapter in cec_devnode_unregister
      media: cec: core: don't set last_initiator if tx in progress

Hans de Goede (2):
      thermal/intel/intel_soc_dts_iosf: Fix reporting wrong temperatures
      Input: soc_button_array - add invalid acpi_index DMI quirk handling

Hao Yao (1):
      platform/x86: int3472: Avoid crash in unregistering regulator gpio

Herve Codina (1):
      ASoC: simple-card: Add missing of_node_put() in case of error

Inki Dae (1):
      drm/exynos: vidi: fix a wrong error return

Jens Axboe (4):
      io_uring/net: clear msg_controllen on partial sendmsg retry
      io_uring/net: disable partial retries for recvmsg with cmsg
      io_uring/poll: serialize poll linked timer start with poll removal
      io_uring/net: use the correct msghdr union member in io_sendmsg_copy_hdr

Jiasheng Jiang (1):
      gpio: sifive: add missing check for platform_get_irq

Jiawen Wu (2):
      net: mdio: fix the wrong parameters
      gpiolib: Fix GPIO chip IRQ initialization restriction

Jiri Olsa (1):
      bpf: Force kprobe multi expected_attach_type for kprobe_multi link

Jisheng Zhang (1):
      mmc: litex_mmc: set PROBE_PREFER_ASYNCHRONOUS

Krister Johansen (1):
      bpf: ensure main program has an extable

Krzysztof Kozlowski (3):
      arm64: dts: qcom: sc7280-idp: drop incorrect dai-cells from WCD938x SDW
      arm64: dts: qcom: sc7280-qcard: drop incorrect dai-cells from WCD938x SDW
      soundwire: qcom: add proper error paths in qcom_swrm_startup()

Lee Jones (1):
      x86/mm: Avoid using set_pgd() outside of real PGD pages

Leon Romanovsky (1):
      xfrm: add missed call to delete offloaded policies

Liam R. Howlett (1):
      mm/mprotect: fix do_mprotect_pkey() limit check

Lino Sanfilippo (1):
      tpm, tpm_tis: Claim locality in interrupt handler

Linus Torvalds (1):
      Revert "efi: random: refresh non-volatile random seed when RNG is initialized"

Linus Walleij (1):
      ARM: dts: Fix erroneous ADS touchscreen polarities

Lorenzo Stoakes (1):
      mm/vmalloc: do not output a spurious warning when huge vmalloc() fails

Maciej Żenczykowski (2):
      xfrm: fix inbound ipv4/udp/esp packets to UDPv6 dualstack sockets
      revert "net: align SO_RCVMARK required privileges with SO_MARK"

Magali Lemes (3):
      selftests: net: tls: check if FIPS mode is enabled
      selftests: net: vrf-xfrm-tests: change authentication and encryption algos
      selftests: net: fcnal-test: check if FIPS mode is enabled

Marc Zyngier (2):
      arm64: Add missing Set/Way CMO encodings
      KVM: arm64: Restore GICv2-on-GICv3 functionality

Martin Hundebøll (1):
      mmc: meson-gx: remove redundant mmc_request_done() call from irq context

Matthieu Baerts (33):
      selftests: mptcp: remove duplicated entries in usage
      selftests: mptcp: join: fix ShellCheck warnings
      selftests: mptcp: lib: skip if missing symbol
      selftests: mptcp: connect: skip transp tests if not supported
      selftests: mptcp: connect: skip disconnect tests if not supported
      selftests: mptcp: connect: skip TFO tests if not supported
      selftests: mptcp: diag: skip listen tests if not supported
      selftests: mptcp: diag: skip inuse tests if not supported
      selftests: mptcp: pm nl: remove hardcoded default limits
      selftests: mptcp: pm nl: skip fullmesh flag checks if not supported
      selftests: mptcp: sockopt: relax expected returned size
      selftests: mptcp: sockopt: skip getsockopt checks if not supported
      selftests: mptcp: sockopt: skip TCP_INQ checks if not supported
      selftests: mptcp: userspace pm: skip if 'ip' tool is unavailable
      selftests: mptcp: userspace pm: skip if not supported
      selftests: mptcp: userspace pm: skip PM listener events tests if unavailable
      selftests: mptcp: lib: skip if not below kernel version
      selftests: mptcp: join: use 'iptables-legacy' if available
      selftests: mptcp: join: helpers to skip tests
      selftests: mptcp: join: skip check if MIB counter not supported
      selftests: mptcp: join: skip test if iptables/tc cmds fail
      selftests: mptcp: join: support local endpoint being tracked or not
      selftests: mptcp: join: skip Fastclose tests if not supported
      selftests: mptcp: join: support RM_ADDR for used endpoints or not
      selftests: mptcp: join: skip implicit tests if not supported
      selftests: mptcp: join: skip backup if set flag on ID not supported
      selftests: mptcp: join: skip fullmesh flag tests if not supported
      selftests: mptcp: join: skip userspace PM tests if not supported
      selftests: mptcp: join: skip fail tests if not supported
      selftests: mptcp: join: skip MPC backups tests if not supported
      selftests: mptcp: join: skip PM listener tests if not supported
      selftests: mptcp: join: uniform listener tests
      selftests: mptcp: join: skip mixed tests if not supported

Maurizio Lombardi (3):
      scsi: target: iscsi: Fix hang in the iSCSI login code
      scsi: target: iscsi: Remove unused transport_timer
      scsi: target: iscsi: Prevent login threads from racing between each other

Maxim Mikityanskiy (1):
      bpf: Fix verifier id tracking of scalars on spill

Michael Kelley (1):
      Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to scan present CPUs

Michael S. Tsirkin (1):
      Revert "virtio-blk: support completion batching for the IRQ path"

Michael Walle (1):
      gpiolib: Fix irq_domain resource tracking for gpiochip_irqchip_add_domain()

Mike Kravetz (1):
      udmabuf: revert 'Add support for mapping hugepages (v4)'

Min Li (2):
      drm/exynos: fix race condition UAF in exynos_g2d_exec_ioctl
      drm/radeon: fix race condition UAF in radeon_gem_set_domain_ioctl

Min-Hua Chen (1):
      net: sched: wrap tc_skip_wrapper with CONFIG_RETPOLINE

Ming Lei (1):
      block: make sure local irq is disabled when calling __blkcg_rstat_flush

Mukesh Sisodiya (1):
      wifi: iwlwifi: pcie: Handle SO-F device for PCI id 0x7AF0

Namjae Jeon (9):
      ksmbd: validate command payload size
      ksmbd: fix out-of-bound read in smb2_write
      ksmbd: validate session id and tree id in the compound request
      ksmbd: remove internal.h include
      ksmbd: fix racy issue from using ->d_parent and ->d_name
      ksmbd: add mnt_want_write to ksmbd vfs functions
      ksmbd: fix uninitialized pointer read in ksmbd_vfs_rename()
      ksmbd: fix uninitialized pointer read in smb2_create_link()
      ksmbd: call putname after using the last component

Nathan Chancellor (1):
      riscv: Link with '-z norelro'

Neil Armstrong (1):
      spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_chan()

Nicolas Frattaroli (1):
      arm64: dts: rockchip: fix nEXTRST on SOQuartz

Nitesh Shetty (1):
      null_blk: Fix: memory release when memory_backed=1

Omar Sandoval (1):
      x86/unwind/orc: Add ELF section with ORC version identifier

Osama Muhammad (1):
      nfcsim.c: Fix error checking for debugfs_create_dir

Pablo Neira Ayuso (10):
      netfilter: nf_tables: fix chain binding transaction logic
      netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain
      netfilter: nf_tables: drop map element references from preparation phase
      netfilter: nft_set_pipapo: .walk does not deal with generations
      netfilter: nf_tables: disallow element updates of bound anonymous sets
      netfilter: nf_tables: reject unbound anonymous set before commit phase
      netfilter: nf_tables: reject unbound chain set before commit phase
      netfilter: nf_tables: disallow updates of anonymous sets
      netfilter: nfnetlink_osf: fix module autoload
      netfilter: nf_tables: drop module reference after updating chain

Paolo Abeni (5):
      mptcp: handle correctly disconnect() failures
      mptcp: fix possible divide by zero in recvmsg()
      mptcp: fix possible list corruption on passive MPJ
      mptcp: consolidate fallback and non fallback state machine
      mptcp: ensure listener is unhashed before updating the sk status

Pierre-Louis Bossart (1):
      soundwire: dmi-quirks: add new mapping for HP Spectre x360

Prathu Baronia (1):
      scripts: fix the gfp flags header path in gfp-translate

Rafael Aquini (1):
      writeback: fix dereferencing NULL mapping->host on writeback_page_template

Rafael J. Wysocki (1):
      ACPI: sleep: Avoid breaking S3 wakeup due to might_sleep()

Reiji Watanabe (1):
      KVM: arm64: PMU: Restore the host's PMUSERENR_EL0

Roberto Sassu (1):
      memfd: check for non-NULL file_seals in memfd_create() syscall

Rodrigo Siqueira (2):
      drm/amd/display: Use dc_update_planes_and_stream
      drm/amd/display: Add wrapper to call planes and stream update

Rong Tao (1):
      tools/virtio: Fix arm64 ringtest compilation error

Ross Lagerwall (1):
      be2net: Extend xmit workaround to BE3 chip

Russ Weight (1):
      regmap: spi-avmm: Fix regmap_bus max_raw_write

Ryusuke Konishi (2):
      nilfs2: fix buffer corruption due to concurrent device reads
      nilfs2: prevent general protection fault in nilfs_clear_dirty_page()

Sayed, Karimuddin (1):
      ALSA: hda/realtek: Add "Intel Reference board" and "NUC 13" SSID in the ALC256

Sebastian Andrzej Siewior (1):
      xfrm: Linearize the skb after offloading if needed.

Sergey Shtylyov (12):
      mmc: sdhci-spear: fix deferred probing
      mmc: bcm2835: fix deferred probing
      mmc: sunxi: fix deferred probing
      mmc: meson-gx: fix deferred probing
      mmc: mtk-sd: fix deferred probing
      mmc: mvsdio: fix deferred probing
      mmc: omap: fix deferred probing
      mmc: omap_hsmmc: fix deferred probing
      mmc: owl: fix deferred probing
      mmc: sdhci-acpi: fix deferred probing
      mmc: sh_mmcif: fix deferred probing
      mmc: usdhi60rol0: fix deferred probing

Shannon Nelson (1):
      vhost_vdpa: tell vqs about the negotiated

Shida Zhang (1):
      btrfs: fix an uninitialized variable warning in btrfs_log_inode

Shyam Prasad N (1):
      cifs: fix status checks in cifs_tree_connect

Shyam Sundar S K (1):
      platform/x86/amd/pmf: Register notify handler only if SPS is enabled

Sicong Jiang (1):
      ASoC: amd: yc: Add Thinkpad Neo14 to quirks list for acp6x

Simon Horman (1):
      i2c: mchp-pci1xxxx: Avoid cast to incompatible function type

Srinivas Kandagatla (1):
      ASoC: codecs: wcd938x-sdw: do not set can_multi_write flag

Stefan Wahren (1):
      net: qca_spi: Avoid high load if QCA7000 is not available

Stephan Gerhold (1):
      mmc: sdhci-msm: Disable broken 64-bit DMA on MSM8916

Steve French (1):
      smb3: missing null check in SMB2_change_notify

Su Hui (1):
      iommu/amd: Fix possible memory leak of 'domain'

Teresa Remmet (1):
      regulator: pca9450: Fix LDO3OUT and LDO4OUT MASK

Terin Stock (1):
      ipvs: align inner_mac_header for encapsulation

Tetsuo Handa (1):
      cgroup,freezer: hold cpu_hotplug_lock before freezer_mutex in freezer_css_{online,offline}()

Thomas Gleixner (1):
      tick/common: Align tick period during sched_timer setup

Tom Chung (1):
      drm/amd/display: fix the system hang while disable PSR

Uday Shankar (3):
      nvme: double KA polling frequency to avoid KATO with TBKAS on
      nvme: check IO start time when deciding to defer KA
      nvme: improve handling of long keep alives

Vineeth Vijayan (1):
      s390/cio: unregister device when the only path is gone

Vishal Moola (Oracle) (2):
      afs: Fix dangling folio ref counts in writeback
      afs: Fix waiting for writeback then skipping folio

Vladimir Oltean (1):
      net: dsa: introduce preferred_default_local_cpu_port and use on MT7530

Xiu Jianfeng (1):
      cgroup: Do not corrupt task iteration when rebinding subsystem

Yevgeny Kliteynik (1):
      net/mlx5: DR, Fix wrong action data allocation in decap action

Yonghong Song (1):
      bpf: Fix a bpf_jit_dump issue for x86_64 with sysctl bpf_jit_enable.

min15.li (1):
      nvme: fix miss command type check

Íñigo Huguet (1):
      sfc: use budget for TX completions

