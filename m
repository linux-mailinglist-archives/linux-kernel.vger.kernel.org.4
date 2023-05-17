Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6FB706761
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjEQMAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjEQMAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:00:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1080A59D6;
        Wed, 17 May 2023 05:00:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8400564606;
        Wed, 17 May 2023 12:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA80C433D2;
        Wed, 17 May 2023 12:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324804;
        bh=eKX36hSxugHKQpsK4lbDExwSVb/zRFnk7WiFOL4UTpI=;
        h=From:To:Cc:Subject:Date:From;
        b=VhZGRkM1+CLfLUYbh7dBSrTEaswmtZy3NKE4gGQRoGnLNSiINlx5ZcO3zxszvMG15
         8AZLG5y0ZJgliKN2aJmHIc0Sf1U3YC+8axIO3k1BbVCgeG0e7e/jMhaBAMNeeAe3zg
         UcIUe/d9CjQ+mR2fTE8DoTOoCi6OptMVRrgulauQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.283
Date:   Wed, 17 May 2023 13:59:49 +0200
Message-Id: <2023051748-bridged-shortcut-c52b@gregkh>
X-Mailer: git-send-email 2.40.1
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

I'm announcing the release of the 4.19.283 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/media/uapi/v4l/subdev-formats.rst             |   27 +
 Makefile                                                    |    2 
 arch/arm/boot/dts/exynos4412-itop-elite.dts                 |    2 
 arch/arm/boot/dts/qcom-ipq4019.dtsi                         |    4 
 arch/arm/boot/dts/s5pv210.dtsi                              |    2 
 arch/arm64/include/asm/debug-monitors.h                     |    1 
 arch/arm64/kernel/debug-monitors.c                          |    5 
 arch/arm64/kernel/kgdb.c                                    |    2 
 arch/ia64/kernel/salinfo.c                                  |    2 
 arch/ia64/mm/contig.c                                       |    2 
 arch/mips/fw/lib/cmdline.c                                  |    2 
 arch/openrisc/kernel/entry.S                                |    6 
 arch/parisc/kernel/real2.S                                  |    5 
 arch/powerpc/kernel/rtas.c                                  |    2 
 arch/powerpc/platforms/512x/clock-commonclk.c               |    2 
 arch/powerpc/platforms/embedded6xx/flipper-pic.c            |    2 
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c               |    2 
 arch/powerpc/platforms/embedded6xx/wii.c                    |    4 
 arch/powerpc/sysdev/tsi108_pci.c                            |    5 
 arch/sh/kernel/cpu/sh4/sq.c                                 |    2 
 arch/sh/kernel/head_32.S                                    |    6 
 arch/sh/kernel/nmi_debug.c                                  |    4 
 arch/sh/kernel/setup.c                                      |    4 
 arch/sh/math-emu/sfp-util.h                                 |    4 
 arch/x86/kernel/apic/apic.c                                 |    5 
 arch/x86/kernel/apic/io_apic.c                              |   14 
 arch/x86/kvm/vmx/vmx.c                                      |   15 
 crypto/drbg.c                                               |   16 
 drivers/base/cpu.c                                          |    3 
 drivers/block/drbd/drbd_receiver.c                          |    2 
 drivers/bluetooth/btsdio.c                                  |    1 
 drivers/char/ipmi/ipmi_msghandler.c                         |  119 +++-
 drivers/char/ipmi/ipmi_si_intf.c                            |    5 
 drivers/char/ipmi/ipmi_ssif.c                               |  118 +++-
 drivers/clk/clk-conf.c                                      |   12 
 drivers/clk/rockchip/clk-rk3399.c                           |    2 
 drivers/dma/at_xdmac.c                                      |    5 
 drivers/edac/skx_edac.c                                     |   29 -
 drivers/firmware/qcom_scm.c                                 |    3 
 drivers/fpga/fpga-bridge.c                                  |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                         |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                  |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                     |   40 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c                   |   47 +
 drivers/gpu/drm/drm_probe_helper.c                          |    5 
 drivers/gpu/drm/msm/adreno/adreno_device.c                  |    7 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                     |    1 
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c            |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                 |    3 
 drivers/gpu/drm/vgem/vgem_fence.c                           |    1 
 drivers/hid/wacom_wac.c                                     |   12 
 drivers/i2c/busses/i2c-omap.c                               |    2 
 drivers/iio/adc/palmas_gpadc.c                              |    2 
 drivers/infiniband/hw/hfi1/mmu_rb.c                         |   13 
 drivers/infiniband/hw/mlx4/qp.c                             |    8 
 drivers/infiniband/hw/mlx5/qp.c                             |    2 
 drivers/infiniband/sw/rdmavt/qp.c                           |    2 
 drivers/macintosh/Kconfig                                   |    1 
 drivers/macintosh/windfarm_smu_sat.c                        |    1 
 drivers/md/dm-flakey.c                                      |    4 
 drivers/md/dm-integrity.c                                   |    8 
 drivers/md/dm-ioctl.c                                       |    7 
 drivers/md/dm-verity-target.c                               |   17 
 drivers/md/raid10.c                                         |   96 ++-
 drivers/md/raid5.c                                          |   10 
 drivers/media/pci/dm1105/dm1105.c                           |    1 
 drivers/media/pci/saa7134/saa7134-ts.c                      |    1 
 drivers/media/pci/saa7134/saa7134-vbi.c                     |    1 
 drivers/media/pci/saa7134/saa7134-video.c                   |    1 
 drivers/media/pci/ttpci/av7110_av.c                         |    4 
 drivers/media/platform/rcar_fdp1.c                          |   18 
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c               |    2 
 drivers/media/rc/gpio-ir-recv.c                             |    2 
 drivers/misc/vmw_vmci/vmci_host.c                           |    8 
 drivers/mtd/spi-nor/cadence-quadspi.c                       |   72 +-
 drivers/mtd/ubi/eba.c                                       |   19 
 drivers/net/dsa/mv88e6xxx/chip.c                            |    3 
 drivers/net/ethernet/amd/nmclan_cs.c                        |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c            |   23 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c           |   32 +
 drivers/net/virtio_net.c                                    |   43 +
 drivers/net/wireless/ath/ath5k/eeprom.c                     |    2 
 drivers/net/wireless/ath/ath6kl/bmi.c                       |    2 
 drivers/net/wireless/ath/ath6kl/htc_pipe.c                  |    4 
 drivers/net/wireless/ath/ath9k/hif_usb.c                    |   19 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c            |   10 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c             |    3 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c      |    1 
 drivers/net/wireless/realtek/rtlwifi/base.c                 |  144 ++---
 drivers/net/wireless/realtek/rtlwifi/cam.c                  |   82 +--
 drivers/net/wireless/realtek/rtlwifi/core.c                 |  259 +++++-----
 drivers/net/wireless/realtek/rtlwifi/debug.c                |   16 
 drivers/net/wireless/realtek/rtlwifi/debug.h                |   11 
 drivers/net/wireless/realtek/rtlwifi/efuse.c                |   72 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c                  |  284 +++++------
 drivers/net/wireless/realtek/rtlwifi/ps.c                   |   98 +--
 drivers/net/wireless/realtek/rtlwifi/regd.c                 |   18 
 drivers/net/wireless/realtek/rtlwifi/usb.c                  |   18 
 drivers/of/device.c                                         |    7 
 drivers/pci/hotplug/pciehp.h                                |    3 
 drivers/pci/hotplug/pciehp_core.c                           |    2 
 drivers/pci/hotplug/pciehp_hpc.c                            |   19 
 drivers/pci/hotplug/pciehp_pci.c                            |   15 
 drivers/phy/tegra/xusb.c                                    |    2 
 drivers/platform/x86/touchscreen_dmi.c                      |   24 
 drivers/power/supply/generic-adc-battery.c                  |    3 
 drivers/pwm/pwm-meson.c                                     |    2 
 drivers/pwm/pwm-mtk-disp.c                                  |   94 +--
 drivers/s390/block/dasd.c                                   |    2 
 drivers/scsi/megaraid.c                                     |    1 
 drivers/spi/spi-fsl-spi.c                                   |   12 
 drivers/spi/spi-qup.c                                       |   20 
 drivers/spmi/spmi.c                                         |    3 
 drivers/staging/iio/resolver/ad2s1210.c                     |    2 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c                |    1 
 drivers/target/iscsi/iscsi_target.c                         |   16 
 drivers/tty/serial/8250/8250.h                              |   12 
 drivers/tty/serial/8250/8250_port.c                         |   16 
 drivers/tty/serial/fsl_lpuart.c                             |    2 
 drivers/tty/tty_io.c                                        |    4 
 drivers/tty/tty_ioctl.c                                     |   45 +
 drivers/usb/chipidea/core.c                                 |    2 
 drivers/usb/dwc3/core.c                                     |    1 
 drivers/usb/gadget/udc/renesas_usb3.c                       |    1 
 drivers/usb/host/xhci-debugfs.c                             |    1 
 drivers/usb/host/xhci-rcar.c                                |    3 
 drivers/usb/serial/option.c                                 |    6 
 fs/btrfs/ctree.c                                            |   32 +
 fs/btrfs/ioctl.c                                            |    5 
 fs/btrfs/print-tree.c                                       |    6 
 fs/cifs/smb2ops.c                                           |    2 
 fs/debugfs/file.c                                           |    8 
 fs/ext4/balloc.c                                            |   25 +
 fs/ext4/inline.c                                            |   14 
 fs/ext4/mballoc.c                                           |    6 
 fs/ext4/super.c                                             |   19 
 fs/ext4/xattr.c                                             |    5 
 fs/fs-writeback.c                                           |    2 
 fs/nfs/nfs4state.c                                          |    4 
 fs/nilfs2/bmap.c                                            |   16 
 fs/nilfs2/segment.c                                         |    5 
 fs/pstore/pmsg.c                                            |    7 
 fs/reiserfs/xattr_security.c                                |    8 
 fs/ubifs/dir.c                                              |    1 
 fs/ubifs/tnc.c                                              |  142 +++--
 include/linux/debugfs.h                                     |    1 
 include/linux/ipmi_smi.h                                    |   36 +
 include/linux/netfilter/nfnetlink.h                         |    1 
 include/linux/printk.h                                      |   19 
 include/linux/sunrpc/sched.h                                |    3 
 include/linux/tick.h                                        |    9 
 include/linux/tty.h                                         |    2 
 include/linux/vt_buffer.h                                   |    2 
 include/net/netfilter/nf_tables.h                           |    1 
 include/net/scm.h                                           |   13 
 include/trace/events/timer.h                                |    3 
 include/uapi/drm/amdgpu_drm.h                               |    3 
 include/uapi/linux/btrfs.h                                  |    1 
 include/uapi/linux/const.h                                  |    2 
 include/uapi/linux/media-bus-format.h                       |    8 
 kernel/events/core.c                                        |    4 
 kernel/relay.c                                              |   18 
 kernel/time/tick-sched.c                                    |   18 
 kernel/trace/ring_buffer.c                                  |    4 
 lib/debugobjects.c                                          |  300 ++++++++----
 mm/page_alloc.c                                             |   16 
 net/8021q/vlan_dev.c                                        |    2 
 net/bluetooth/hci_sock.c                                    |    9 
 net/core/skbuff.c                                           |    3 
 net/ipv4/ip_output.c                                        |   16 
 net/ipv6/sit.c                                              |    8 
 net/netfilter/nf_tables_api.c                               |   20 
 net/netfilter/nfnetlink.c                                   |    2 
 net/netfilter/nft_dynset.c                                  |    2 
 net/netfilter/nft_lookup.c                                  |    2 
 net/netfilter/nft_objref.c                                  |    2 
 net/netlink/af_netlink.c                                    |   67 --
 net/packet/af_packet.c                                      |   20 
 net/packet/diag.c                                           |    4 
 net/packet/internal.h                                       |   26 -
 net/rxrpc/sendmsg.c                                         |    2 
 net/sched/act_mirred.c                                      |    2 
 net/sunrpc/clnt.c                                           |    3 
 net/sunrpc/sched.c                                          |    1 
 security/selinux/Makefile                                   |    4 
 sound/soc/intel/boards/bytcr_rt5640.c                       |   12 
 sound/usb/caiaq/input.c                                     |    1 
 tools/bpf/bpftool/json_writer.c                             |    3 
 tools/bpf/bpftool/xlated_dumper.c                           |    7 
 tools/perf/builtin-sched.c                                  |    2 
 tools/perf/pmu-events/arch/powerpc/power9/other.json        |    4 
 tools/perf/pmu-events/arch/powerpc/power9/pipeline.json     |    2 
 tools/perf/util/auxtrace.c                                  |    5 
 tools/perf/util/sort.c                                      |    3 
 tools/perf/util/symbol-elf.c                                |    2 
 196 files changed, 2140 insertions(+), 1233 deletions(-)

Adrian Hunter (1):
      perf auxtrace: Fix address filter entire kernel size

Akilesh Kailash (1):
      dm verity: skip redundant verity_handle_err() on I/O errors

Alexander Mikhalitsyn (1):
      scm: fix MSG_CTRUNC setting condition for SO_PASSSEC

Alexey V. Vissarionov (1):
      wifi: ath6kl: minor fix for allocation size

Anastasia Belova (1):
      btrfs: print-tree: parent bytenr must be aligned to sector size

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Add missing watchdog ops for 6320 family

Andrey Avdeev (1):
      platform/x86: touchscreen_dmi: Add info for the Dexp Ursus KX210i

Angelo Dureghello (1):
      net: dsa: mv88e6xxx: add mv88e6321 rsvd2cpu

AngeloGioacchino Del Regno (1):
      pwm: mtk-disp: Disable shadow registers before setting backlight values

Arnaldo Carvalho de Melo (1):
      perf sched: Cast PTHREAD_STACK_MIN to int as it may turn into sysconf(__SC_THREAD_STACK_MIN_VALUE)

Arınç ÜNAL (1):
      USB: serial: option: add UNISOC vendor and TOZED LT70C product

Bas Nieuwenhuizen (1):
      drm/amdgpu: Add command to override the context priority.

Bitterblue Smith (1):
      wifi: rtl8xxxu: RTL8192EU always needs full init

Chia-I Wu (1):
      drm/amdgpu: add a missing lock for AMDGPU_SCHED

Christoph Böhmwalder (1):
      drbd: correctly submit flush bio on barrier

Christoph Hellwig (1):
      md: update the optimal I/O size on reshape

Christophe Leroy (1):
      spi: fsl-spi: Fix CPM/QE mode Litte Endian

Claudiu Beznea (1):
      dmaengine: at_xdmac: do not enable all cyclic channels

Clément Léger (1):
      clk: add missing of_node_put() in "assigned-clocks" property parsing

Cong Wang (1):
      sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()

Corey Minyard (3):
      ipmi: Fix SSIF flag requests
      ipmi: Fix how the lower layers are told to watch for messages
      ipmi_ssif: Rename idle state and check

Dae R. Jeong (1):
      vmci_host: fix a race condition in vmci_host_poll() causing GPF

Dafna Hirschfeld (1):
      media: uapi: add MEDIA_BUS_FMT_METADATA_FIXED media bus format.

Dai Ngo (1):
      SUNRPC: remove the maximum number of retries in call_bind_status

Dan Carpenter (3):
      media: av7110: prevent underflow in write_ts_to_decoder()
      wifi: ath5k: fix an off by one check in ath5k_eeprom_read_freq_list()
      RDMA/mlx4: Prevent shift wrapping in set_user_sq_size()

Danila Chernetsov (1):
      scsi: megaraid: Fix mega_cmd_done() CMDID_INT_CMDS

David Howells (1):
      rxrpc: Fix hard call timeout units

Dhruva Gole (1):
      spi: cadence-quadspi: fix suspend-resume implementations

Dom Cobley (1):
      drm/probe-helper: Cancel previous job before starting new one

Emmanuel Grumbach (1):
      wifi: iwlwifi: make the loop for card preparation effective

Eric Dumazet (2):
      net/packet: convert po->origdev to an atomic flag
      net/packet: convert po->auxdata to an atomic flag

Fedor Pchelkin (2):
      wifi: ath9k: hif_usb: fix memory leak of remain_skbs
      wifi: ath6kl: reduce WARN to dev_dbg() in callback

Filipe Manana (1):
      btrfs: fix btrfs_prev_leaf() to not return the same key twice

Florian Fainelli (2):
      media: rc: gpio-ir-recv: Fix support for wake-up
      serial: 8250: Add missing wakeup event reporting

Florian Westphal (1):
      netfilter: nf_tables: don't write table validation state without mutex

Frederic Weisbecker (1):
      nohz: Add TICK_DEP_BIT_RCU

Gaosheng Cui (1):
      phy: tegra: xusb: Add missing tegra_xusb_port_unregister for usb2_port and ulpi_port

Geert Uytterhoeven (1):
      debugfs: regset32: Add Runtime PM support

Gencen Gan (1):
      net: amd: Fix link leak when verifying config failed

Greg Kroah-Hartman (1):
      Linux 4.19.283

Hans de Goede (2):
      ASoC: Intel: bytcr_rt5640: Add quirk for the Acer Iconia One 7 B1-750
      PCI: pciehp: Use down_read/write_nested(reset_lock) to fix lockdep errors

Heiner Kallweit (1):
      pwm: meson: Fix axg ao mux parents

Helge Deller (1):
      parisc: Fix argument pointer in real64_call_asm()

Herbert Xu (1):
      crypto: drbg - Only fail when jent is unavailable in FIPS mode

Ilpo Järvinen (2):
      tty: Prevent writing chars during tcsetattr TCSADRAIN/FLUSH
      serial: 8250: Fix serial8250_tx_empty() race with DMA Tx

James Cowgill (1):
      drm/panel: otm8009a: Set backlight parent to panel device

Jiasheng Jiang (1):
      media: bdisp: Add missing check for create_workqueue

Jiaxun Yang (1):
      MIPS: fw: Allow firmware to pass a empty env

Jiping Ma (1):
      stmmac: debugfs entry name is not be changed when udev rename device name.

Jishnu Prakash (1):
      spmi: Add a check for remove callback when removing a SPMI driver

Jisoo Jang (1):
      wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()

Jitao Shi (1):
      pwm: mtk-disp: Adjust the clocks to avoid them mismatch

Joe Damato (2):
      ixgbe: Allow flow hash to be set via ethtool
      ixgbe: Enable setting RSS table to default values

Joel Fernandes (Google) (1):
      tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem

Johan Hovold (3):
      USB: dwc3: fix runtime pm imbalance on unbind
      xhci: fix debugfs register accesses while suspended
      drm/msm/adreno: drop bogus pm_runtime_set_active()

Johannes Berg (2):
      ring-buffer: Sync IRQ works before buffer destruction
      wifi: iwlwifi: mvm: check firmware response size

John Paul Adrian Glaubitz (1):
      sh: sq: Fix incorrect element size for allocating bitmap buffer

John Stultz (1):
      pstore: Revert pmsg_lock back to a normal mutex

Kajol Jain (1):
      perf vendor events power9: Remove UTF-8 characters from JSON files

Kevin Brodsky (1):
      uapi/linux/const.h: prefer ISO-friendly __typeof__

Krzysztof Kozlowski (2):
      ARM: dts: exynos: fix WM8960 clock name in Itop Elite
      ARM: dts: s5pv210: correct MIPI CSIS clock name

Kuniyuki Iwashima (3):
      netlink: Use copy_to_user() for optval in netlink_getsockopt().
      tcp/udp: Fix memleaks of sk and zerocopy skbs with TX timestamp.
      af_packet: Don't send zero-byte data in packet_sendmsg_spkt().

Larry Finger (3):
      rtlwifi: rtl_pci: Fix memory leak when hardware init fails
      rtlwifi: Start changing RT_TRACE into rtl_dbg
      rtlwifi: Replace RT_TRACE with rtl_dbg

Li Nan (1):
      md/raid10: fix null-ptr-deref in raid10_sync_request

Liang He (1):
      macintosh/windfarm_smu_sat: Add missing of_node_put()

Liu Jian (1):
      Revert "Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work"

Luis Gerhorst (1):
      tools: bpftool: Remove invalid \' json escape

Lukas Wunner (1):
      PCI: pciehp: Fix AB-BA deadlock between reset_lock and device_lock

Manivannan Sadhasivam (1):
      ARM: dts: qcom: ipq4019: Fix the PCI I/O port range

Marco Pagani (1):
      fpga: bridge: fix kernel-doc parameter description

Mark Zhang (1):
      RDMA/mlx5: Use correct device num_ports when modify DC

Markus Elfring (1):
      perf map: Delete two variable initialisations before null pointer checks in sort__sym_from_cmp()

Maxim Korotkov (1):
      writeback: fix call of incorrect macro

Maíra Canal (1):
      drm/vgem: add missing mutex_destroy

Miaoqian Lin (1):
      media: rcar_fdp1: Fix refcount leak in probe and remove function

Mike Christie (1):
      scsi: target: iscsit: Fix TAS handling during conn cleanup

Mike Snitzer (2):
      dm integrity: call kmem_cache_destroy() in dm_integrity_init() error path
      dm ioctl: fix nested locking in table_clear() to remove deadlock concern

Mikulas Patocka (1):
      dm flakey: fix a crash with invalid table line

Miquel Raynal (1):
      of: Fix modalias string generation

Mukesh Ojha (1):
      firmware: qcom_scm: Clear download bit during reboot

Mårten Lindahl (1):
      ubifs: Free memory for tmpfile name

Natalia Petrova (1):
      RDMA/rdmavt: Delete unnecessary NULL check

Nathan Lynch (1):
      powerpc/rtas: use memmove for potentially overlapping buffer copy

Nicolai Stange (1):
      crypto: drbg - make drbg_prepare_hrng() handle jent instantiation errors

Nuno Sá (1):
      staging: iio: resolver: ads1210: fix config mode

Ondrej Mosnacek (1):
      selinux: fix Makefile dependencies of flask.h

Pablo Neira Ayuso (1):
      netfilter: nf_tables: deactivate anonymous set from preparation phase

Patrick Kelsey (1):
      IB/hfi1: Fix SDMA mmu_rb_node not being evicted in LRU order

Patrik Dahlström (1):
      iio: adc: palmas_gpadc: fix NULL dereference on rmmod

Paul Moore (1):
      selinux: ensure av_permissions.h is built when needed

Pawel Witek (1):
      cifs: fix pcchunk length type in smb2_copychunk_range

Pengcheng Yang (1):
      kernel/relay.c: fix read_pos error when multiple readers

Philipp Hortmann (1):
      staging: rtl8192e: Fix W_DISABLE# does not work after stop/start

Ping Cheng (1):
      HID: wacom: Set a default resolution for older tablets

Qiuxu Zhuo (2):
      EDAC, skx: Move debugfs node under EDAC's hierarchy
      EDAC/skx: Fix overflows on the DRAM row address mapping arrays

Qu Wenruo (1):
      btrfs: scrub: reject unsupported scrub flags

Quentin Monnet (1):
      bpftool: Fix bug for long instructions in program CFG dumps

Quentin Schulz (1):
      clk: rockchip: rk3399: allow clk_cifout to force clk_cifout_src to reparent

Randy Dunlap (10):
      linux/vt_buffer.h: allow either builtin or modular for macros
      ia64: mm/contig: fix section mismatch warning/error
      ia64: salinfo: placate defined-but-not-used warning
      powerpc/mpc512x: fix resource printk format warning
      powerpc/wii: fix resource printk format warnings
      powerpc/sysdev/tsi108: fix resource printk format warnings
      macintosh: via-pmu-led: requires ATA to be set
      sh: math-emu: fix macro redefined warning
      sh: init: use OF_EARLY_FLATTREE for early init
      sh: nmi_debug: fix return value of __setup handler

Reid Tonking (1):
      i2c: omap: Fix standard mode false ACK readings

Rex Zhu (2):
      drm/amdgpu: Add amdgpu_gfx_off_ctrl function
      drm/amdgpu: Put enable gfx off feature to a delay thread

Rob Clark (2):
      drm/rockchip: Drop unbalanced obj unref
      drm/msm/adreno: Defer enabling runpm until hw_init()

Roberto Sassu (1):
      reiserfs: Add security prefix to xattr name in reiserfs_security_write()

Ruihan Li (1):
      bluetooth: Perform careful capability checks in hci_sock_ioctl()

Ruliang Lin (1):
      ALSA: caiaq: input: Add error handling for unsupported input methods in `snd_usb_caiaq_input_init`

Ryusuke Konishi (2):
      nilfs2: do not write dirty data after degenerating to read-only
      nilfs2: fix infinite loop in nilfs_mdt_get_block()

Saurabh Sengar (1):
      x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()

Sean Christopherson (1):
      KVM: nVMX: Emulate NOPs in L2, and PAUSE if it's not intercepted

Sebastian Reichel (1):
      power: supply: generic-adc-battery: fix unit scaling

Shenwei Wang (1):
      tty: serial: fsl_lpuart: adjust buffer length to the intended size

Stafford Horne (1):
      openrisc: Properly store r31 to pt_regs on unhandled exceptions

Stefan Haberland (1):
      s390/dasd: fix hanging blockdevice after request requeue

Sumit Garg (1):
      arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

Tang Bin (1):
      media: rcar_fdp1: Fix the correct variable assignments

Tetsuo Handa (2):
      printk: declare printk_deferred_{enter,safe}() in include/linux/printk.h
      mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock

Theodore Ts'o (5):
      ext4: improve error recovery code paths in __ext4_remount()
      ext4: add bounds checking in get_max_inline_xattr_value_size()
      ext4: bail out of ext4_xattr_ibody_get() fails for any reason
      ext4: remove a BUG_ON in ext4_mb_release_group_pa()
      ext4: fix invalid free tracking in ext4_xattr_move_to_block()

Thomas Gleixner (2):
      debugobject: Prevent init race with static objects
      debugobject: Ensure pool refill (again)

Trond Myklebust (1):
      NFSv4.1: Always send a RECLAIM_COMPLETE after establishing lease

Tudor Ambarus (1):
      ext4: avoid a potential slab-out-of-bounds in ext4_group_desc_csum

Uros Bizjak (1):
      x86/apic: Fix atomic update of offset in reserve_eilvt_offset()

Uwe Kleine-König (2):
      spi: qup: Don't skip cleanup in remove's error path
      pwm: mtk-disp: Don't check the return code of pwmchip_remove()

Vadim Fedorenko (1):
      vlan: partially enable SIOCSHWTSTAMP in container

Victor Nogueira (1):
      net/sched: act_mirred: Add carrier check

Vignesh Raghavendra (3):
      mtd: spi-nor: cadence-quadspi: Make driver independent of flash geometry
      mtd: spi-nor: cadence-quadspi: Don't initialize rx_dma_complete on failure
      mtd: spi-nor: cadence-quadspi: Handle probe deferral while requesting DMA channel

Waiman Long (2):
      debugobjects: Add percpu free pools
      debugobjects: Move printk out of db->lock critical sections

Wang Li (1):
      spi: qup: fix PM reference leak in spi_qup_remove()

Wang YanQing (1):
      ubi: Fix return value overwrite issue in try_write_vid_and_data()

Wei Chen (2):
      wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_rfreg()
      wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_reg()

Wenliang Wang (1):
      virtio_net: suppress cpu stall when free_unused_bufs

Wolfram Sang (1):
      usb: host: xhci-rcar: remove leftover quirk handling

Xuan Zhuo (1):
      virtio_net: split free_unused_bufs()

Yang Jihong (2):
      perf/core: Fix hardlockup failure caused by perf throttle
      perf symbols: Fix return incorrect build_id size in elf_read_build_id()

Ye Bin (1):
      ext4: fix WARNING in mb_find_extent

Yeongjin Gil (1):
      dm verity: fix error handling for check_at_most_once on FEC

Yinhao Hu (1):
      usb: chipidea: fix missing goto in `ci_hdrc_probe`

Yu Kuai (3):
      md/raid10: fix leak of 'r10bio->remaining' for recovery
      md/raid10: fix memleak for 'conf->bio_split'
      md/raid10: fix memleak of md thread

Zhang Yuchen (1):
      ipmi: fix SSIF not responding under certain cond.

Zhang Zhengming (1):
      relayfs: fix out-of-bounds access in relay_file_read

Zheng Wang (3):
      media: dm1105: Fix use after free bug in dm1105_remove due to race condition
      media: saa7134: fix use after free bug in saa7134_finidev due to race condition
      usb: gadget: udc: renesas_usb3: Fix use after free bug in renesas_usb3_remove due to race condition

Zhihao Cheng (2):
      Revert "ubifs: dirty_cow_znode: Fix memleak in error handling path"
      ubifs: Fix memleak when insert_old_idx() failed

Ziyang Xuan (1):
      ipv4: Fix potential uninit variable access bug in __ip_make_skb()

