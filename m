Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7576BCBA5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCPJ4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjCPJ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:56:36 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042592798C;
        Thu, 16 Mar 2023 02:56:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 73CF3DACE9;
        Thu, 16 Mar 2023 10:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1678960551; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding; bh=C4T2y2QSLrggLx5BPJ/BCzk2jshhGDV9/zP6g4Iatso=;
        b=RgUjm8WgoLvfUmvUrPigQUwHHVhsmxX9MnYp9CqA8ip5GIP54AZx3sh+Kp4pDX4gLCAxMi
        4bJNWNgXqAJBD64/kgymTpUbNKrumFmyaUwh6WCPgin5UiJqUYXc1eb27K3HhNhvhpA3Mf
        X2zAkdJa5ejfnf+XROXm0I5Ykq/AqYyaj+5SbXvQZA2WP9zB33kE5FbBYoPDYSia4xGrqn
        Ptl9hwEKEXjkTIhO+ME4VY6hexZ+wVErJmNtfuT4d/2P9UVMo4GPvW0Vu70wgKvDFmEtPk
        0ZZuKM2F0RvWCX+bJOF3sbnQyDT0eFxpePtMOZzMs44xmIvxR//e4Txante6Mg==
Date:   Thu, 16 Mar 2023 10:55:45 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: [ANNOUNCE] 4.19.277-rt122
Message-ID: <167895995721.11976.4190110536742300848@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.277-rt122 stable release.

The 4.19.277-rt121 release updates to the latest stable kernel (no rt specifc
changes) and 4.19.277-rt122 adds a fix from Brennan Lamoreaux which addresses a
regression in the workqueue code.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 98073c457fd2e3f52c94163b8a4478ed265406a9

Or to build 4.19.277-rt122 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.277.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.277-rt122.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.271-rt120:
---

Al Viro (1):
      alpha: fix FEN fault handling

Alan Stern (2):
      net: USB: Fix wrong-direction WARNING in plusb.c
      USB: core: Don't hold device lock while reading the "descriptors" sysfs file

Alexander Egorenkov (2):
      watchdog: diag288_wdt: do not use stack buffers for hardware data
      watchdog: diag288_wdt: fix __diag288() inline assembly

Alexander Potapenko (1):
      affs: initialize fsdata in affs_truncate()

Alexander Usyskin (1):
      mei: bus-fixup:upon error print return values of send and receive

Alexander Wetzel (1):
      wifi: cfg80211: Fix use after free for wext

Alexey Kodanev (1):
      wifi: orinoco: check return value of hermes_write_wordrec()

Alexey V. Vissarionov (2):
      scsi: hpsa: Fix allocation size for scsi_host_alloc()
      ALSA: hda/ca0132: minor fix for allocation size

Alper Nebi Yasak (1):
      firmware: coreboot: framebuffer: Ignore reserved pixel color bits

Amit Engel (1):
      nvme-fc: fix a missing queue put in nvmet_fc_ls_create_association

Ammar Faizi (1):
      x86: um: vdso: Add '%rcx' and '%r11' to the syscall clobber list

Andrea Merello (1):
      dmaengine: xilinx_dma: commonize DMA copy size calculation

Andreas Gruenbacher (1):
      gfs2: jdata writepage fix

Andreas Kemnade (2):
      iio:adc:twl6030: Enable measurements of VUSB, VBAT and others
      iio:adc:twl6030: Enable measurement of VAC

Andreas Schwab (1):
      riscv: disable generation of unwind tables

Andrew Morton (1):
      revert "squashfs: harden sanity check in squashfs_read_xattr_id_table"

Andy Shevchenko (2):
      pinctrl: intel: Convert unsigned to unsigned int
      pinctrl: intel: Restore the pins that used to be in Direct IRQ mode

AngeloGioacchino Del Regno (1):
      arm64: dts: mediatek: mt7622: Add missing pwm-cells to pwm node

Angus Chen (1):
      ARM: imx: Call ida_simple_remove() for ida_simple_get

Archie Pusaka (1):
      Bluetooth: hci_sync: cancel cmd_timer if hci_open failed

Ard Biesheuvel (1):
      efi: Accept version 2 of memory attributes table

Armin Wolf (1):
      ACPI: battery: Fix missing NUL-termination with large strings

Arnaldo Carvalho de Melo (1):
      perf env: Do not return pointers to local variables

Arnd Bergmann (4):
      ASoC: cs42l56: fix DT probe
      rtlwifi: fix -Wpointer-sign warning
      wifi: ath9k: use proper statements in conditionals
      scsi: ipr: Work around fortify-string warning

Artemii Karasev (2):
      ALSA: hda/via: Avoid potential array out-of-bound in add_secret_dac_path()
      ALSA: emux: Avoid potential array out-of-bound in snd_emux_xg_control()

Benjamin Coddington (1):
      nfsd: fix race to check ls_layouts

Bitterblue Smith (2):
      wifi: rtl8xxxu: gen2: Turn on the rate control
      wifi: rtl8xxxu: Use a longer retry limit of 48

Bjorn Andersson (1):
      rpmsg: glink: Avoid infinite loop on intent for missing channel

Bo Liu (1):
      ALSA: hda/conexant: add a new hda codec SN6180

Borislav Petkov (AMD) (3):
      x86/microcode/amd: Remove load_microcode_amd()'s bsp parameter
      x86/microcode/AMD: Add a @cpu parameter to the reloading functions
      x86/microcode/AMD: Fix mixed steppings support

Brennan Lamoreaux (VMware) (1):
      workqueue: Fix deadlock due to recursive locking of pool->lock

Breno Leitao (1):
      x86/bugs: Reset speculation control settings on init

Chen Hui (1):
      ARM: OMAP2+: Fix memory leak in realtime_counter_init()

Chen Jun (1):
      watchdog: Fix kmemleak in watchdog_cdev_register

Chen-Yu Tsai (1):
      clk: Honor CLK_OPS_PARENT_ENABLE in clk_core_is_enabled()

Chris Healy (1):
      net: phy: meson-gxl: Add generic dummy stubs for MMD register access

Christoph Hellwig (1):
      block: fix and cleanup bio_check_ro

Christophe JAILLET (1):
      ipw2x00: switch from 'pci_' to 'dma_' API

Claudiu Beznea (1):
      pinctrl: at91: use devm_kasprintf() to avoid potential leaks

Conor Dooley (1):
      RISC-V: time: initialize hrtimer based broadcast clock event device

Cristian Ciocaltea (1):
      net: stmmac: Restrict warning on disabling DMA store and fwd mode

Damien Le Moal (2):
      ata: libata: Fix sata_down_spd_limit() when no link speed is reported
      PCI: Avoid FLR for AMD FCH AHCI adapters

Dan Carpenter (3):
      ALSA: pci: lx6464es: fix a debug loop
      wifi: mwifiex: fix loop iterator in mwifiex_update_ampdu_txwinsize()
      thermal: intel: quark_dts: fix error pointer dereference

Daniel Mentz (1):
      drm/mipi-dsi: Fix byte order of 16-bit DCS set/get brightness

Daniel Scally (1):
      usb: uvc: Enumerate valid values for color matching

Daniel Wagner (3):
      Merge tag 'v4.19.277' into v4.19-rt
      Linux 4.19.277-rt121
      Linux 4.19.277-rt122

Daniil Tatianin (1):
      ACPICA: nsrepair: handle cases without a return value correctly

Darrell Kavanagh (1):
      firmware/efi sysfb_efi: Add quirk for Lenovo IdeaPad Duet 3

Dave Hansen (1):
      uaccess: Add speculation barrier to copy_from_user()

Dave Stevenson (2):
      drm/vc4: dpi: Add option for inverting pixel clock and output enable
      drm/vc4: dpi: Fix format mapping for RGB565

David Christensen (1):
      net/tg3: resolve deadlock in tg3_reset_task() during EEH

David Howells (1):
      cifs: Fix oops due to uncleared server->smbd_conn in reconnect

David Sterba (1):
      btrfs: send: limit number of clones and allocated memory size

Dean Luick (5):
      IB/hfi1: Reject a zero-length user expected buffer
      IB/hfi1: Reserve user expected TIDs
      IB/hfi1: Fix expected receive setup error exit issues
      IB/hfi1: Restore allocated resources on failed copyout
      IB/hfi1: Assign npages earlier

Dmitry Baryshkov (1):
      drm/msm: use strscpy instead of strncpy

Dmitry Fomin (1):
      ALSA: ice1712: Do not left ice->gpio_mutex locked in aureon_add_controls()

Dmitry Goncharov (1):
      kbuild: Port silent mode detection to future gnu make.

Dmitry Perchanov (1):
      iio: hid: fix the retval in accel_3d_capture_sample

Dmitry Torokhov (1):
      Revert "Input: synaptics - switch touchpad on HP Laptop 15-da3001TU to RMI mode"

Dongliang Mu (2):
      fs: reiserfs: remove useless new_opts in reiserfs_remount
      fs: hfsplus: fix UAF issue in hfsplus_put_super

Duoming Zhou (2):
      media: rc: Fix use-after-free bugs caused by ene_tx_irqsim()
      media: usb: siano: Fix use after free bugs caused by do_submit_urb

Elvira Khabirova (1):
      mips: fix syscall_get_nr

Eric Biggers (2):
      f2fs: fix information leak in f2fs_move_inline_dirents()
      f2fs: fix cgroup writeback accounting with fs-layer encryption

Eric Dumazet (7):
      netlink: annotate data races around nlk->portid
      netlink: annotate data races around dst_portid and dst_group
      netlink: annotate data races around sk_state
      ipv4: prevent potential spectre v1 gadget in ip_metrics_convert()
      ipv6: ensure sane device mtu in tunnels
      net: fix __dev_kfree_skb_any() vs drop monitor
      tcp: tcp_check_req() can be called from process context

Eric W. Biederman (2):
      exit: Add and use make_task_dead.
      objtool: Add a missing comma to avoid string concatenation

Fabio Estevam (1):
      ARM: dts: imx6qdl-gw560x: Remove incorrect 'uart-has-rtscts'

Fabrice Gasnier (1):
      pwm: stm32-lp: fix the check on arr and cmp registers update

Fedor Pchelkin (5):
      squashfs: harden sanity check in squashfs_read_xattr_id_table
      net: openvswitch: fix flow memory leak in ovs_flow_cmd_new
      wifi: ath9k: htc_hst: free skb in ath9k_htc_rx_msg() if there is no callback function
      wifi: ath9k: hif_usb: clean up skbs if ath9k_hif_usb_rx_stream() fails
      nfc: fix memory leak of se_io context in nfc_genl_se_io

Florian Fainelli (3):
      irqchip/irq-brcmstb-l2: Set IRQ_LEVEL for level triggered interrupts
      irqchip/irq-bcm7120-l2: Set IRQ_LEVEL for level triggered interrupts
      net: bcmgenet: Add a check for oversized packets

Florian Westphal (2):
      netfilter: conntrack: do not renew entry stuck in tcp SYN_SENT state
      netfilter: nft_tproxy: restrict to prerouting hook

Florian Zumbiehl (1):
      USB: serial: option: add support for VW/Skoda "Carstick LTE"

Frank Jungclaus (1):
      can: esd_usb: Move mislocated storage of SJA1000_ECC_SEG bits in case of a bus error

Frederic Barrat (1):
      powerpc/powernv/ioda: Skip unallocated resources when mapping to PE

Geert Uytterhoeven (2):
      ARM: dts: imx: Fix pca9547 i2c-mux node name
      drm: mxsfb: DRM_MXSFB should depend on ARCH_MXS || ARCH_MXC

George Kennedy (3):
      vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF
      ubi: ensure that VID header offset + VID header size <= alloc, size
      vc_screen: modify vcs_size() handling in vcs_read()

Giulio Benetti (1):
      ARM: 9280/1: mm: fix warning on phys_addr_t to void pointer assignment

Greg Kroah-Hartman (8):
      Linux 4.19.272
      Revert "x86/fpu: Use _Alignof to avoid undefined behavior in TYPE_ALIGN"
      kvm: initialize all of the kvm_debugregs structure before sending it to userspace
      Linux 4.19.273
      Linux 4.19.274
      Linux 4.19.275
      Linux 4.19.276
      Linux 4.19.277

Guenter Roeck (1):
      media: uvcvideo: Handle errors from calls to usb_string

Guillaume Nault (2):
      ipv6: Fix datagram socket connection with DSCP.
      ipv6: Fix tcp socket connection with DSCP.

Guo Ren (1):
      riscv: Fixup race condition on PG_dcache_clean in flush_icache_pte

Haibo Chen (1):
      gpio: vf610: connect GPIO label to dev name

Hangbin Liu (1):
      selftests: forwarding: lib: quote the sysctl values

Hangyu Hua (1):
      netfilter: ctnetlink: fix possible refcount leak in ctnetlink_create_conntrack()

Hans Verkuil (1):
      media: i2c: ov7670: 0 instead of -EINVAL was returned

Hans de Goede (1):
      ACPI: video: Fix Lenovo Ideapad Z570 DMI match

Harshit Mogalapalli (2):
      iio: accel: mma9551_core: Prevent uninitialized variable in mma9551_read_status_word()
      iio: accel: mma9551_core: Prevent uninitialized variable in mma9551_read_config_word()

Hector Martin (1):
      wifi: cfg80211: Partial revert "wifi: cfg80211: Fix use after free for wext"

Heiner Kallweit (5):
      net: mdio: validate parameter addr in mdiobus_get_phy()
      net: phy: add macros for PHYID matching
      net: phy: meson-gxl: use MMD access dummy stubs for GXL, internal PHY
      arm64: dts: meson-gx: Make mmc host controller interrupts level-sensitive
      arm64: dts: meson-axg: Make mmc host controller interrupts level-sensitive

Helge Deller (2):
      parisc: Fix return code of pdc_iodc_print()
      parisc: Wire up PTRACE_GETREGS/PTRACE_SETREGS for compat case

Heming Zhao via Ocfs2-devel (2):
      ocfs2: fix defrag path triggering jbd2 ASSERT
      ocfs2: fix non-auto defrag path not working issue

Hendrik Borghorst (1):
      KVM: x86/vmx: Do not skip segment attributes if unusable bit is set

Herbert Xu (4):
      lib/mpi: Fix buffer overrun when SG is too long
      crypto: seqiv - Handle EBUSY correctly
      crypto: rsa-pkcs1pad - Use akcipher_request_complete
      crypto: crypto4xx - Call dma_unmap_page when done

Hui Wang (1):
      dmaengine: imx-sdma: Fix a possible memory leak in sdma_transfer_init

Hyunwoo Kim (3):
      netrom: Fix use-after-free caused by accept on already connected socket
      net/x25: Fix to not accept on connected socket
      net/rose: Fix to not accept on connected socket

Ian Rogers (1):
      perf llvm: Fix inadvertent file creation

Ilpo Järvinen (2):
      serial: 8250_dma: Fix DMA Rx completion race
      serial: 8250_dma: Fix DMA Rx rearm race

Ilya Dryomov (1):
      rbd: avoid use-after-free in do_rbd_add() when rbd_dev_create() fails

Ilya Leoshkevich (2):
      libbpf: Fix alen calculation in libbpf_nla_dump_errormsg()
      s390: discard .interp section

Jack Morgenstein (1):
      net/mlx5: Enhance debug print in page allocation failure

Jakob Koschel (1):
      docs/scripts/gdb: add necessary make scripts_gdb step

Jakub Kicinski (1):
      net: mpls: fix stale pointer if allocation fails during device rename

Jamal Hadi Salim (1):
      net/sched: Retire tcindex classifier

James Bottomley (1):
      scsi: ses: Don't attach if enclosure has no components

Jan Beulich (1):
      x86/entry/64: Add instruction suffix to SYSRET

Jan Kara (5):
      udf: Define EFSCORRUPTED error code
      udf: Truncate added extents on failed expansion
      udf: Do not bother merging very long extents
      udf: Do not update file length for failed writes to inline files
      udf: Fix file corruption when appending just after end of preallocated extent

Jann Horn (2):
      exit: Put an upper limit on how often we can oops
      timers: Prevent union confusion from unexpected restart_syscall()

Jason A. Donenfeld (1):
      random: always mix cycle counter in add_latent_entropy()

Jason Xing (2):
      tcp: avoid the lookup process failing to get sk in ehash table
      i40e: add double of VLAN header when computing the max MTU

Jerome Brunet (2):
      net: phy: meson-gxl: add g12a support
      arm64: dts: meson-axg: enable SCPI

Jia-Ju Bai (1):
      tracing: Add NULL checks for buffer in ring_buffer_free_read_page()

Jiapeng Chong (1):
      phy: rockchip-typec: Fix unsigned comparison with less than zero

Jiasheng Jiang (9):
      HID: intel_ish-hid: Add check for ishtp_dma_tx_map
      dmaengine: sh: rcar-dmac: Check for error num after dma_set_max_seg_size
      wifi: iwl3945: Add missing check for create_singlethread_workqueue
      wifi: iwl4965: Add missing check for create_singlethread_workqueue()
      drm/msm/hdmi: Add missing check for alloc_ordered_workqueue
      drm/msm/dpu: Add check for pstates
      scsi: aic94xx: Add missing check for dma_map_single()
      media: platform: ti: Add missing check for devm_regulator_get
      drm/msm/dsi: Add missing check for alloc_ordered_workqueue

Jisoo Jang (3):
      net: nfc: Fix use-after-free in local_cleanup()
      wifi: brcmfmac: Fix potential stack-out-of-bounds in brcmf_c_preinit_dcmds()
      wifi: brcmfmac: ensure CLM version is null-terminated to prevent stack-out-of-bounds

Joel Stanley (1):
      pinctrl: aspeed: Fix confusing types in return value

Johan Hovold (4):
      rtc: pm8xxx: fix set-alarm race
      irqdomain: Fix association race
      irqdomain: Fix disassociation race
      irqdomain: Drop bogus fwspec-mapping error handling

Johan Jonker (1):
      ARM: dts: rockchip: add power-domains property to dp node on rk3288

Johannes Zink (1):
      net: stmmac: fix order of dwmac5 FlexPPS parametrization sequence

Jonathan Cormier (1):
      hwmon: (ltc2945) Handle error case in ltc2945_value_store

Josef Bacik (1):
      btrfs: limit device extents to the device size

Juergen Gross (2):
      9p/xen: fix version parsing
      9p/xen: fix connection sequence

Jun ASAKA (1):
      wifi: rtl8xxxu: fixing transmisison failure for rtl8192eu

Jun Nie (2):
      ext4: optimize ea_inode block expansion
      ext4: refuse to create ea block when umounted

KP Singh (2):
      x86/speculation: Allow enabling STIBP with legacy IBRS
      Documentation/hw-vuln: Document the interaction between IBRS and STIBP

Kailang Yang (1):
      ALSA: hda/realtek - fixed wrong gpio assigned

Kees Cook (14):
      exit: Expose "oops_count" to sysfs
      exit: Allow oops_limit to be disabled
      panic: Consolidate open-coded panic_on_warn checks
      panic: Introduce warn_limit
      panic: Expose "warn_count" to sysfs
      docs: Fix path paste-o for /sys/kernel/warn_count
      exit: Use READ_ONCE() for all oops/warn limit reads
      ext4: Fix function prototype mismatch for ext4_feat_ktype
      ASoC: kirkwood: Iterate over array indexes instead of using pointer math
      regulator: max77802: Bounds check regulator id against opmode
      regulator: s5m8767: Bounds check id indexing into arrays
      media: uvcvideo: Silence memcpy() run-time false positive warnings
      usb: host: xhci: mvebu: Iterate over array indexes instead of using pointer math
      USB: ene_usb6250: Allocate enough memory for full object

Kemeng Shi (1):
      blk-mq: remove stale comment for blk_mq_sched_mark_restart_hctx

Koba Ko (1):
      dmaengine: Fix double increment of client_count in dma_chan_get()

Krish Sadhukhan (1):
      nVMX x86: Check VMX-preemption timer controls on vmentry of L2 guests

Krzysztof Kozlowski (5):
      ARM: dts: exynos: correct wr-active property in Exynos3250 Rinato
      ARM: dts: exynos: correct HDMI phy compatible in Exynos4
      ARM: dts: exynos: correct TMU phandle in Exynos4
      ARM: dts: exynos: correct TMU phandle in Odroid XU
      ARM: dts: spear320-hmi: correct STMPE GPIO compatible

Kuninori Morimoto (1):
      ASoC: soc-compress.c: fixup private_data on snd_soc_new_compress()

Kuniyuki Iwashima (4):
      netrom: Fix use-after-free of a listening socket.
      dccp/tcp: Avoid negative sk_forward_alloc by ipv6_pinfo.pktoptions.
      net: Remove WARN_ON_ONCE(sk->sk_forward_alloc) from sk_stream_kill_queues().
      tcp: Fix listen() regression in 4.19.270

Laurent Pinchart (1):
      drm: Clarify definition of the DRM_BUS_FLAG_(PIXDATA|SYNC)_* macros

Lee Jones (1):
      pinctrl: pinctrl-rockchip: Fix a bunch of kerneldoc misdemeanours

Li Hua (1):
      watchdog: pcwd_usb: Fix attempting to access uninitialized memory

Li RongQing (1):
      netlink: remove hash::nelems check in netlink_insert

Li Zetao (3):
      wifi: rtlwifi: Fix global-out-of-bounds bug in _rtl8812ae_phy_set_txpower_limit()
      ubi: Fix use-after-free when volume resizing failed
      ubi: Fix unreferenced object reported by kmemleak in ubi_resize_volume()

Liang He (1):
      gpu: ipu-v3: common: Add of_node_put() for reference returned by of_graph_get_port_by_id()

Linus Torvalds (2):
      drm/i915/display: fix compiler warning about array overrun
      bpf: add missing header file include

Liu Shixin (2):
      dmaengine: xilinx_dma: call of_node_put() when breaking out of for_each_child_of_node()
      hfs: fix missing hfs_bnode_get() in __hfs_bnode_create

Liu Shixin via Jfs-discussion (1):
      fs/jfs: fix shift exponent db_agl2size negative

Liwei Song (1):
      drm/radeon: free iio for atombios when driver shutdown

Long Li (1):
      smbd: Make upper layer decide when to destroy the transport

Longlong Xia (1):
      mm/swapfile: add cond_resched() in get_swap_pages()

Luca Ellero (2):
      Input: ads7846 - don't report pressure for ads7845
      Input: ads7846 - don't check penirq immediately for 7845

Luis Gerhorst (1):
      bpf: Fix pointer-leak due to insufficient speculative store bypass mitigation

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix potential user-after-free

Lukas Wunner (1):
      wifi: mwifiex: Add missing compatible string for SD8787

Luke D. Jones (1):
      HID: asus: Remove check for same LED brightness on set

Manivannan Sadhasivam (1):
      EDAC/device: Respect any driver-supplied workqueue polling value

Marc Kleine-Budde (1):
      can: kvaser_usb: hydra: help gcc-13 to figure out cmd_len

Marcelo Ricardo Leitner (1):
      sctp: fail if no bound addresses can be used for a given scope

Mario Limonciello (1):
      ACPICA: Drop port I/O validation for some regions

Mark Hawrylak (1):
      drm/radeon: Fix eDP for single-display iMac11,2

Mark Pearson (1):
      usb: core: add quirk for Alcor Link AK9563 smartcard reader

Mark Rutland (1):
      ACPI: Don't build ACPICA with '-Os'

Markuss Broks (1):
      ARM: dts: exynos: Use Exynos5420 compatible for the MIPI video phy

Martin Blumenstingl (2):
      arm64: dts: meson-gx: Fix Ethernet MAC address unit name
      arm64: dts: meson-gx: Fix the SCPI DVFS node name and unit address

Martin K. Petersen (1):
      block: bio-integrity: Copy flags when bio_integrity_payload is cloned

Masahiro Yamada (1):
      tomoyo: fix broken dependency on *.conf.default

Masami Hiramatsu (Google) (1):
      selftests/ftrace: Fix bash specific "==" operator

Maurizio Lombardi (1):
      scsi: target: core: Fix warning on RT kernels

Maxim Korotkov (1):
      pinctrl: single: fix potential NULL dereference

Miaoqian Lin (4):
      EDAC/highbank: Fix memory leak in highbank_mc_probe()
      irqchip/alpine-msi: Fix refcount leak in alpine_msix_init_domains
      irqchip/irq-mvebu-gicp: Fix refcount leak in mvebu_gicp_probe
      pinctrl: rockchip: Fix refcount leak in rockchip_pinctrl_parse_groups

Michael Chan (1):
      bnxt_en: Fix mqprio and XDP ring checking logic

Michael Schmitz (1):
      m68k: Check syscall_trace_enter() return code

Mike Christie (1):
      scsi: iscsi_tcp: Fix UAF during login when accessing the shost ipaddress

Mike Kravetz (3):
      mm: hugetlb: proc: check for hugetlb shared PMD in /proc/PID/smaps
      migrate: hugetlb: check for hugetlb shared PMD in node migration
      hugetlb: check for undefined shift on 32 bit architectures

Mike Snitzer (3):
      dm: remove flush_scheduled_work() during local_exit()
      dm thin: add cond_resched() to various workqueue loops
      dm cache: add cond_resched() to various workqueue loops

Mikko Perttunen (1):
      gpu: host1x: Don't skip assigning syncpoints to channels

Miko Larsson (1):
      net/usb: kalmia: Don't pass act_len in usb_bulk_msg error path

Mikulas Patocka (3):
      x86/asm: Fix an assembler warning with current binutils
      dm flakey: fix logic when corrupting a bio
      dm flakey: don't corrupt the zero page

Minsuk Kang (1):
      wifi: ath9k: Fix potential stack-out-of-bounds write in ath9k_wmi_rsp_callback()

Natalia Petrova (2):
      trace_events_hist: add check for return value of 'create_hist_field'
      i40e: Add checking for null for nlmsg_find_attr()

Nathan Chancellor (3):
      hexagon: Fix function name in die()
      h8300: Fix build errors from do_exit() to make_task_dead() transition
      powerpc: Remove linker flag from KBUILD_AFLAGS

Nathan Lynch (3):
      powerpc/pseries/lparcfg: add missing RTAS retry status handling
      powerpc/rtas: make all exports GPL
      powerpc/rtas: ensure 4KB alignment for rtas_data_buf

Neil Armstrong (6):
      usb: dwc3: qcom: enable vbus override when in OTG dr-mode
      arm64: dts: amlogic: meson-gx: fix SCPI clock dvfs node name
      arm64: dts: amlogic: meson-axg: fix SCPI clock dvfs node name
      arm64: dts: amlogic: meson-gx: add missing SCPI sensors compatible
      arm64: dts: amlogic: meson-gx: add missing unit address to rng node name
      arm64: dts: amlogic: meson-gxl: add missing unit address to eth-phy-mux node name

Nguyen Dinh Phi (1):
      Bluetooth: hci_sock: purge socket queues in the destruct() callback

Nícolas F. R. A. Prado (1):
      drm/mediatek: Clean dangling pointer on bind error path

Olivier Moysan (1):
      iio: adc: stm32-dfsdm: fill module aliases

Pablo Neira Ayuso (1):
      netfilter: nft_set_rbtree: skip elements in transaction from garbage collection

Paolo Abeni (1):
      net: fix UaF in netns ops registration error path

Paul E. McKenney (1):
      rcu: Suppress smp_processor_id() complaint in synchronize_rcu_expedited_wait()

Pavel Skripkin (2):
      mac80211: mesh: embedd mesh_paths and mpp_paths into ieee80211_if_mesh
      ath9k: htc: clean up statistics macros

Peter Chen (1):
      usb: host: xhci-plat: add wakeup entry at sysfs

Petr Pavlu (1):
      module: Don't wait for GOING modules

Philipp Hortmann (2):
      staging: rtl8192e: Remove function ..dm_check_ac_dc_power calling a script
      staging: rtl8192e: Remove call_usermodehelper starting RadioPower.sh

Phillip Lougher (1):
      Squashfs: fix handling and sanity checking of xattr_ids count

Pietro Borrello (7):
      HID: check empty report_list in hid_validate_values()
      HID: betop: check shape of output reports
      rds: rds_rm_zerocopy_callback() use list_first_entry()
      HID: asus: use spinlock to protect concurrent accesses
      HID: asus: use spinlock to safely schedule workers
      rds: rds_rm_zerocopy_callback() correct order for list_add_tail()
      inet: fix fast path in __inet_hash_connect()

Prashant Malani (1):
      usb: typec: altmodes/displayport: Fix probe pin assign check

Qiheng Lin (2):
      ARM: zynq: Fix refcount leak in zynq_early_slcr_init
      mfd: pcf50633-adc: Fix potential memleak in pcf50633_adc_async_read()

Quinn Tran (2):
      scsi: qla2xxx: Fix link failure in NPIV environment
      scsi: qla2xxx: Fix erroneous link down

Radhey Shyam Pandey (1):
      dmaengine: xilinx_dma: program hardware supported buffer length

Rafael J. Wysocki (1):
      thermal: intel: int340x: Add locking to int340x_thermal_get_trip_type()

Rafał Miłecki (1):
      net: bgmac: fix BCM5358 support by setting correct flags

Raju Rangoju (2):
      amd-xgbe: TX Flow Ctrl Registers are h/w ver dependent
      amd-xgbe: Delay AN timeout during KR training

Randy Dunlap (6):
      net: mlx5: eliminate anonymous module_init & module_exit
      ia64: make IA64_MCA_RECOVERY bool instead of tristate
      i2c: rk3x: fix a bunch of kernel-doc warnings
      m68k: /proc/hardware should depend on PROC_FS
      sparc: allow PM configs for sparc32 COMPILE_TEST
      MIPS: vpe-mt: drop physical_memsize

Ricardo Ribalda (3):
      media: uvcvideo: Handle cameras with invalid descriptors
      media: uvcvideo: Provide sync and async uvc_ctrl_status_event
      media: uvcvideo: Fix race condition with usb_kill_urb

Rob Clark (1):
      drm/mediatek: Drop unbalanced obj unref

Robert Hancock (1):
      net: macb: fix PTP TX timestamp failure due to packet padding

Roberto Sassu (1):
      ima: Align ima_file_mmap() parameters with mmap_file LSM hook

Roman Li (1):
      drm/amd/display: Fix potential null-deref in dm_resume

Roxana Nicolescu (1):
      selftest: fib_tests: Always cleanup before exit

Ryusuke Konishi (1):
      nilfs2: fix underflow in second superblock position calculations

Sakari Ailus (1):
      media: ipu3-cio2: Fix PM runtime usage_count in driver unbind

Samuel Holland (1):
      mtd: rawnand: sunxi: Fix the size of the last OOB region

Samuel Thibault (1):
      fbcon: Check font dimension limits

Sean Anderson (2):
      powerpc: dts: t208x: Mark MAC1 and MAC2 as 10G
      powerpc: dts: t208x: Disable 10G on MAC1 and MAC2

Sean Christopherson (6):
      KVM: VMX: Move VMX specific files to a "vmx" subdirectory
      KVM: VMX: Move caching of MSR_IA32_XSS to hardware_setup()
      x86/virt: Force GIF=1 prior to disabling SVM (for reboot flows)
      x86/crash: Disable virt in core NMI crash handler to avoid double shootdown
      x86/reboot: Disable virtualization in an emergency if SVM is supported
      x86/reboot: Disable SVM, not just VMX, when stopping CPUs

Seth Jenkins (1):
      aio: fix mremap after fork null-deref

Shang XiaoJing (1):
      phy: rockchip-inno-usb2: Fix missing clk_disable_unprepare() in rockchip_usb2phy_power_on()

Shay Drory (1):
      net/mlx5: fw_tracer: Fix debug print

Shayne Chen (1):
      wifi: mac80211: make rate u32 in sta_set_rate_info_rx()

Sherry Sun (1):
      tty: serial: fsl_lpuart: disable the CTS when send break signal

Shunsuke Mie (1):
      tools/virtio: fix the vringh test for virtio ring changes

Srinivas Pandruvada (2):
      thermal: intel: int340x: Protect trip temperature from concurrent updates
      thermal: intel: powerclamp: Fix cur_state for multi package system

Sriram Yagnaraman (1):
      netfilter: conntrack: fix vtag checks for ABORT/SHUTDOWN_COMPLETE

Steven Rostedt (3):
      ktest.pl: Give back console on Ctrt^C on monitor
      ktest.pl: Fix missing "end_monitor" when machine check fails
      ktest.pl: Add RUN_TIMEOUT option with default unlimited

Steven Rostedt (Google) (1):
      tracing: Make sure trace_printk() can output as soon as it can be used

Sven Schnelle (1):
      tty: fix out-of-bounds access in tty_driver_lookup_tty()

Swati Agarwal (1):
      dmaengine: xilinx_dma: Fix devm_platform_ioremap_resource error handling

Szymon Heidrich (2):
      wifi: rndis_wlan: Prevent buffer overflow in rndis_query_oid
      net: usb: sr9700: Handle negative len

Takashi Sakamoto (1):
      firewire: fix memory leak for payload of request subaction to IEC 61883-1 FCP region

Thomas Gleixner (2):
      x86/i8259: Mark legacy PIC interrupts with IRQ_LEVEL
      alarmtimer: Prevent starvation by small intervals and SIG_IGN

Thomas Weißschuh (1):
      vc_screen: don't clobber return value in vcs_read

Tiezhu Yang (1):
      panic: unset panic_on_warn inside panic()

Toke Høiland-Jørgensen (1):
      bpf: Always return target ifindex in bpf_fib_lookup

Tomas Henzl (4):
      scsi: ses: Fix slab-out-of-bounds in ses_enclosure_data_process()
      scsi: ses: Fix possible addl_desc_ptr out-of-bounds accesses
      scsi: ses: Fix possible desc_ptr out-of-bounds accesses
      scsi: ses: Fix slab-out-of-bounds in ses_intf_remove()

Udipto Goswami (3):
      usb: gadget: f_fs: Prevent race during ffs_ep0_queue_wait
      usb: gadget: f_fs: Ensure ep0req is dequeued before free_request
      usb: gadget: f_fs: Fix unbalanced spinlock in __ffs_ep0_queue_wait

Vadim Pasternak (1):
      hwmon: (mlxreg-fan) Return zero speed for broken fan

Vasily Gorbik (4):
      s390/kprobes: fix irq mask clobbering on kprobe reenter from post_handler
      s390/kprobes: fix current_kprobe never cleared after kprobes reenter
      s390/maccess: add no DAT mode to kernel_write
      s390/setup: init jump labels before command line parsing

Vishal Verma (1):
      ACPI: NFIT: fix a potential deadlock during NFIT teardown

Wan Jiabing (1):
      ath9k: hif_usb: simplify if-if to if-else

Werner Sembach (4):
      Input: i8042 - move __initconst to fix code styling warning
      Input: i8042 - merge quirk tables
      Input: i8042 - add TUXEDO devices to i8042 quirk tables
      Input: i8042 - add Clevo PCX0DX to i8042 quirk table

Wesley Cheng (1):
      usb: dwc3: dwc3-qcom: Fix typo in the dwc3 vbus override API

William Zhang (1):
      spi: bcm63xx-hsspi: Fix multi-bit mode setting

Xiang Yang (1):
      um: vector: Fix memory leak in vector_config

Xiaoming Ni (1):
      sysctl: add a new register_sysctl_init() interface

Xiongfeng Wang (1):
      iio: adc: berlin2-adc: Add missing of_node_put() in error path

Yang Jihong (2):
      x86/kprobes: Fix __recover_optprobed_insn check optimizing logic
      x86/kprobes: Fix arch_check_optimized_kprobe check within optimized_kprobe range

Yang Li (1):
      thermal: intel: Fix unsigned comparison with less than zero

Yang Yingliang (13):
      w1: fix deadloop in __w1_remove_master_device()
      w1: fix WARNING after calling w1_process()
      mmc: sdio: fix possible resource leaks in some error paths
      ARM: OMAP1: call platform_device_put() in error case in omap1_dm_timer_init()
      wifi: rtl8xxxu: don't call dev_kfree_skb() under spin_lock_irqsave()
      wifi: ipw2x00: don't call dev_kfree_skb() under spin_lock_irqsave()
      wifi: libertas_tf: don't call kfree_skb() under spin_lock_irqsave()
      wifi: libertas: if_usb: don't call kfree_skb() under spin_lock_irqsave()
      wifi: libertas: main: don't call kfree_skb() under spin_lock_irqsave()
      wifi: libertas: cmdresp: don't call kfree_skb() under spin_lock_irqsave()
      wifi: wl3501_cs: don't call kfree_skb() under spin_lock_irqsave()
      powercap: fix possible name leak in powercap_register_zone()
      ubi: Fix possible null-ptr-deref in ubi_free_volume()

Yicong Yang (1):
      perf tools: Fix auto-complete on aarch64

Yoshihiro Shimoda (1):
      net: ravb: Fix possible hang if RIS2_QFF1 happen

Yuan Can (4):
      bus: sunxi-rsb: Fix error handling in sunxi_rsb_init()
      wifi: rsi: Fix memory leak in rsi_coex_attach()
      drm/bridge: megachips: Fix error handling in i2c_register_driver()
      media: i2c: ov772x: Fix memleak in ov772x_probe()

Yulong Zhang (1):
      tools/iio/iio_utils:fix memory leak

Zhang Changzhong (1):
      wifi: brcmfmac: fix potential memory leak in brcmf_netdev_start_xmit()

Zhang Xiaoxu (2):
      cifs: Fix lost destroy smbd connection when MR allocate failed
      cifs: Fix warning and UAF when destroy the MR list

Zhen Lei (1):
      genirq: Fix the return type of kstat_cpu_irqs_sum()

Zheng Wang (1):
      drm/i915/gvt: fix double free bug in split_2MB_gtt_entry

Zhengchao Shao (4):
      wifi: libertas: fix memory leak in lbs_init_adapter()
      wifi: ipw2200: fix memory leak in ipw_wdev_init()
      wifi: brcmfmac: unmap dma buffer in brcmf_msgbuf_alloc_pktid()
      9p/rdma: unmap receive dma buffer in rdma_request()/post_recv()

Zhihao Cheng (10):
      ubifs: Rectify space budget for ubifs_symlink() if symlink is encrypted
      ubifs: Rectify space budget for ubifs_xrename()
      ubifs: Fix wrong dirty space budget for dirty inode
      ubifs: do_rename: Fix wrong space budget when target inode's nlink > 1
      ubifs: Reserve one leb for each journal head while doing budget
      ubifs: Re-statistic cleaned znode count if commit failed
      ubifs: dirty_cow_znode: Fix memleak in error handling path
      ubifs: ubifs_writepage: Mark page dirty after writing inode failed
      ubi: Fix UAF wear-leveling entry in eraseblk_count_seq_show()
      ubi: ubi_wl_put_peb: Fix infinite loop when wear-leveling work failed

ruanjinjie (1):
      watchdog: at91sam9_wdt: use devm_request_irq to avoid missing free_irq() in error path

Álvaro Fernández Rojas (1):
      spi: bcm63xx-hsspi: fix pm_runtime
