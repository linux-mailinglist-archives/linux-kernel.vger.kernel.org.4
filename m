Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF02D65092A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiLSJLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiLSJLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:11:09 -0500
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316492D8;
        Mon, 19 Dec 2022 01:10:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B34ADAD38;
        Mon, 19 Dec 2022 10:10:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1671441040; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding; bh=aiXh/ExI0q2i/YVLjLnQty5ENSjZdOHDcI1EUjubmQI=;
        b=LQotbZ7/iuIAcCJw8X5S3gTb6RtvKvPW8pu+6HyxfNGxeSOkwwboo/ZFJURPO4j2KCromD
        5dO4NHkHvledvaWj+Tf9WVnDLG/RtGOB2NVM125mAMYVt4jlKqpmlQTaL/+iZhWxchjU1O
        vvCxqgaGPakAYR3IHRxaZc18nP3iE1XxUZgI4BKm/IrtGmicK9Hxm3D97dwqzzKVdUESer
        yI2zUOoAaGESr+sVA+158IAtfdANbrvDwfaS022aP8B8nbLrft9r+DWmRb1Gz1lIGjvLJ1
        kV7lzQXCWmnRdptiKfFANWwi6zYTV1VnZe/fCa7ioxe52WOE/Yf99j96aE9P9g==
Date:   Mon, 19 Dec 2022 10:10:36 +0100
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
Subject: [ANNOUNCE] 4.19.269-rt119
Message-ID: <167144069993.3503.13484547425689613996@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

I'm pleased to announce the 4.19.269-rt119 stable release.

No RT specific changes, just an update to the latest stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 5e2c14da030d9d13030ed7f3349b43537a21f371

Or to build 4.19.269-rt119 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.269.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.269-rt119.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.265-rt117:
---

Adrian Hunter (1):
      mmc: sdhci: Fix voltage switch delay

Akihiko Odaki (2):
      e1000e: Fix TX dispatch condition
      igb: Allocate MSI-X vector when testing

Alejandro Concepción Rodríguez (1):
      iio: light: apds9960: fix wrong register for gesture gain

Alex Barba (1):
      bnxt_en: fix potentially incorrect return value for ndo_rx_flow_steer

Alexander Potapenko (3):
      ipv6: addrlabel: fix infoleak when sending struct ifaddrlblmsg to network
      misc/vmw_vmci: fix an infoleak in vmci_host_do_receive_datagram()
      mm: fs: initialize fsdata passed to write_begin/write_end interface

Alexandre Chartre (2):
      x86/bugs: Report AMD retbleed vulnerability
      x86/bugs: Add AMD retbleed= boot parameter

Aman Dhoot (1):
      Input: synaptics - switch touchpad on HP Laptop 15-da3001TU to RMI mode

Anand Jain (3):
      btrfs: free btrfs_path before copying fspath to userspace
      btrfs: free btrfs_path before copying subvol info to userspace
      btrfs: free btrfs_path before copying inodes to userspace

Anastasia Belova (1):
      HID: hid-lg4ff: Add check for empty lbuf

Andreas Gruenbacher (1):
      gfs2: Switch from strlcpy to strscpy

Andreas Kemnade (1):
      regulator: twl6030: fix get status of twl6032 regulators

Andrew Cooper (1):
      x86/cpu/amd: Enumerate BTC_NO

Andrew Price (1):
      gfs2: Check sb_bsize_shift after reading superblock

Andy Shevchenko (1):
      pinctrl: intel: Save and restore pins in "direct IRQ" mode

Ard Biesheuvel (1):
      arm64: efi: Fix handling of misaligned runtime regions and drop warning

Arend van Spriel (1):
      wifi: cfg80211: fix memory leak in query_regdb_file()

Baisong Zhong (1):
      bpf, test_run: Fix alignment problem in bpf_prog_test_run_skb()

Ben Hutchings (2):
      Revert "x86/speculation: Change FILL_RETURN_BUFFER to work with objtool"
      Revert "percpu: include irqflags.h for raw_local_irq_save()"

Benjamin Coddington (1):
      NFSv4: Retry LOCK on OLD_STATEID during delegation return

Benoît Monin (1):
      USB: serial: option: add Sierra Wireless EM9191

Borislav Petkov (1):
      x86/cpu: Restore AMD's DE_CFG MSR after resume

Chen Jun (1):
      Input: i8042 - fix leaking of platform device on module removal

Chen Zhongjin (6):
      ASoC: core: Fix use-after-free in snd_soc_exit()
      ASoC: soc-utils: Remove __exit for snd_soc_util_exit()
      xfrm: Fix ignored return value in xfrm6_init()
      iio: core: Fix entry not deleted when iio_register_sw_trigger_type() fails
      nilfs2: fix nilfs_sufile_mark_dirty() not set segment usage as dirty
      Bluetooth: Fix not cleanup led when bt_init fails

ChenXiaoSong (1):
      btrfs: qgroup: fix sleep from invalid context bug in btrfs_qgroup_inherit()

Christian König (1):
      drm/amdgpu: always register an MMU notifier for userptr

Christophe JAILLET (1):
      dmaengine: mv_xor_v2: Fix a resource leak in mv_xor_v2_remove()

Chuang Wang (1):
      net: macvlan: fix memory leaks of macvlan_common_newlink

Cong Wang (1):
      kcm: close race conditions on sk_receive_queue

Connor Shu (1):
      rcutorture: Automatically create initrd directory

Dan Carpenter (4):
      phy: stm32: fix an error code in probe
      drbd: use after free in drbd_create_device()
      net: mvneta: Prevent out of bounds read in mvneta_config_rss()
      net: mvneta: Fix an out of bounds check

Daniel Sneddon (1):
      x86/speculation: Add RSB VM Exit protections

Daniel Wagner (3):
      Linux 4.19.265-rt118
      Merge tag 'v4.19.269' into v4.19-rt
      Linux 4.19.269-rt119

Daniil Tatianin (1):
      ring_buffer: Do not deactivate non-existant pages

Davide Tronchin (4):
      USB: serial: option: remove old LARA-R6 PID
      USB: serial: option: add u-blox LARA-R6 00B modem
      USB: serial: option: add u-blox LARA-L6 modem
      net: usb: qmi_wwan: add u-blox 0x1342 composition

Detlev Casanova (1):
      ASoC: sgtl5000: Reset the CHIP_CLK_CTRL reg on remove

Dominik Haller (1):
      ARM: dts: am335x-pcm-953: Define fixed regulators in root node

Dominique Martinet (2):
      9p: trans_fd/p9_conn_cancel: drop client lock earlier
      9p/xen: check logical size for buffer size

Duoming Zhou (3):
      tty: n_gsm: fix sleep-in-atomic-context bug in gsm_control_send
      usb: chipidea: fix deadlock in ci_otg_del_timer
      qlcnic: fix sleep-in-atomic-context bugs caused by msleep

Enrico Sau (1):
      net: usb: qmi_wwan: add Telit 0x103a composition

Eric Dumazet (5):
      net: tun: call napi_schedule_prep() to ensure we own a napi
      macvlan: enforce a consistent minimal mtu
      tcp: cdg: allow tcp_cdg_release() to be called multiple times
      kcm: avoid potential race in kcm_tx_work
      ipv6: avoid use-after-free in ip6_fragment()

Filipe Manana (1):
      btrfs: remove pointless and double ulist frees in error paths of qgroup tests

Frank Jungclaus (1):
      can: esd_usb: Allow REC and TEC to return to zero

Frieder Schrempf (1):
      spi: spi-imx: Fix spi_bus_clk if requested clock is higher than input clock

GUO Zihua (1):
      9p/fd: Use P9_HDRSZ for header size

Gaosheng Cui (4):
      capabilities: fix undefined behavior in bit shift for CAP_TO_MASK
      bnxt_en: Remove debugfs when pci_register_driver failed
      audit: fix undefined behavior in bit shift for AUDIT_BIT
      hwmon: (ibmpex) Fix possible UAF when ibmpex_register_bmc() fails

Giulio Benetti (1):
      ARM: 9266/1: mm: fix no-MMU ZERO_PAGE() implementation

Gleb Mazovetskiy (1):
      tcp: configurable source port perturb table size

Greg Kroah-Hartman (4):
      Linux 4.19.266
      Linux 4.19.267
      Linux 4.19.268
      Linux 4.19.269

Guenter Roeck (1):
      xtensa: increase size of gcc stack frame check

Hans Verkuil (1):
      media: v4l2-dv-timings.c: fix too strict blanking sanity checks

Hans de Goede (2):
      drm: panel-orientation-quirks: Add quirk for Acer Switch V 10 (SW5-017)
      platform/x86: acer-wmi: Enable SW_TABLET_MODE on Switch V 10 (SW5-017)

Hauke Mehrtens (1):
      ca8210: Fix crash by zero initializing data

Hawkins Jiawei (3):
      ntfs: fix use-after-free in ntfs_attr_find()
      ntfs: fix out-of-bounds read in ntfs_attr_find()
      ntfs: check overflow when iterating ATTR_RECORDs

Heiko Carstens (1):
      s390/crashdump: fix TOD programmable field size

Helge Deller (2):
      parisc: Increase size of gcc stack frame check
      parisc: Increase FRAME_WARN to 2048 bytes on parisc

Herbert Xu (1):
      af_key: Fix send_acquire race with pfkey_register

Ilpo Järvinen (3):
      serial: 8250: Fall back to non-DMA Rx if IIR_RDI occurs
      serial: 8250_lpss: Configure DMA also w/o DMA filter
      serial: 8250: Flush DMA Rx on RLSI

Ingo Molnar (1):
      x86/cpufeature: Fix various quality problems in the <asm/cpu_device_hd.h> header

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: lower rk3399-puma-haikou SD controller clock frequency

James Morse (2):
      arm64: Fix panic() when Spectre-v2 causes Spectre-BHB to re-allocate KVM vectors
      arm64: errata: Fix KVM Spectre-v2 mitigation selection for Cortex-A57/A72

Jann Horn (1):
      ipc/sem: Fix dangling sem_array access in semtimedop race

Jason A. Donenfeld (1):
      MIPS: pic32: treat port as signed integer

Jerry Ray (1):
      dsa: lan9303: Correct stat name

Jiri Benc (1):
      net: gso: fix panic on frag_list with mixed head alloc types

Jisheng Zhang (2):
      riscv: process: fix kernel info leakage
      net: stmmac: fix "snps,axi-config" node property parsing

Johan Jonker (2):
      ARM: dts: rockchip: fix ir-receiver node names
      ARM: dts: rockchip: disable arm_global_timer on rk3066 and rk3188

Jonas Jelonek (1):
      wifi: mac80211_hwsim: fix debugfs attribute ps with rc table support

Jorge Lopez (1):
      platform/x86: hp_wmi: Fix rfkill causing soft blocked wifi

Josef Bacik (1):
      btrfs: free btrfs_path before copying root refs to userspace

Josh Poimboeuf (8):
      x86/speculation: Fix RSB filling with CONFIG_RETPOLINE=n
      x86/speculation: Fix firmware entry SPEC_CTRL handling
      x86/speculation: Fix SPEC_CTRL write on SMT state change
      x86/speculation: Use cached host SPEC_CTRL value for guest entry/exit
      x86/speculation: Remove x86_spec_ctrl_mask
      KVM: VMX: Prevent guest RSB poisoning attacks with eIBRS
      KVM: VMX: Fix IBRS handling after vmexit
      x86/speculation: Fill RSB on vmexit for IBRS

Juergen Gross (3):
      xen/netback: do some code cleanup
      xen/netback: don't call kfree_skb() with interrupts disabled
      xen/netback: fix build warning

Jussi Laako (1):
      ALSA: usb-audio: Add DSD support for Accuphase DAC-60

Kai-Heng Feng (1):
      platform/x86: hp-wmi: Ignore Smart Experience App event

Kan Liang (1):
      x86/cpufeature: Add facility to check for min microcode revisions

Kees Cook (2):
      ALSA: seq: Fix function prototype mismatch in snd_seq_expand_var_event
      NFC: nci: Bounds check struct nfc_target arrays

Keith Busch (1):
      nvme: restrict management ioctls to admin

Krzysztof Kozlowski (1):
      slimbus: stream: correct presence rate frequencies

Kuniyuki Iwashima (2):
      dccp/tcp: Reset saddr on failure after inet6?_hash_connect().
      tcp/udp: Fix memory leak in ipv6_renew_options().

Lars-Peter Clausen (1):
      iio: ms5611: Simplify IO callback parameters

Lee Jones (1):
      Kconfig.debug: provide a little extra FRAME_WARN leeway when KASAN is enabled

Lin Liu (1):
      xen-netfront: Fix NULL sring after live migration

Lin Ma (1):
      nfc/nci: fix race with opening and closing

Linus Torvalds (4):
      cert host tools: Stop complaining about deprecated OpenSSL functions
      proc: avoid integer type confusion in get_proc_long
      proc: proc_skip_spaces() shouldn't think it is working on C strings
      v4l2: don't fall back to follow_pfn() if pin_user_pages_fast() fails

Liu Jian (2):
      net: hisilicon: Fix potential use-after-free in hisi_femac_rx()
      net: hisilicon: Fix potential use-after-free in hix5hd2_rx()

Liu Shixin (1):
      NFC: nci: fix memory leak in nci_rx_data_packet()

Luiz Augusto von Dentz (2):
      Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm
      Bluetooth: L2CAP: Fix accepting connection request for invalid SPSM

Lukas Wunner (1):
      serial: 8250: 8250_omap: Avoid RS485 RTS glitch on ->set_termios()

Lyude Paul (1):
      drm/amd/dc/dce120: Fix audio register mapping, stop triggering KASAN

Maciej W. Rozycki (1):
      parport_pc: Avoid FIFO port location truncation

Mark Brown (1):
      ASoC: ops: Fix bounds check for _sx controls

Mark Gross (1):
      x86/cpu: Add a steppings field to struct x86_cpu_id

Martin Faltesek (2):
      nfc: st-nci: fix incorrect validating logic in EVT_TRANSACTION
      nfc: st-nci: fix memory leaks in EVT_TRANSACTION

Masahiro Yamada (1):
      mmc: sdhci: use FIELD_GET for preset value bit masks

Matthew Auld (1):
      drm/i915/dmabuf: fix sg_table handling in map_dma_buf

Matthias Schiffer (1):
      serial: 8250_omap: remove wait loop from Errata i202 workaround

Mauro Lima (1):
      spi: intel: Fix the offset to get the 64K erase opcode

Maxim Korotkov (1):
      pinctrl: single: Fix potential division by zero

Michael Grzeschik (1):
      ARM: dts: at91: sam9g20ek: enable udc vbus gpio pinctrl

Michael Kelley (1):
      x86/ioremap: Fix page aligned size calculation in __ioremap_caller()

Michal Jaron (1):
      i40e: Fix not setting default xps_cpus after reset

Mikulas Patocka (2):
      dm ioctl: fix misbehavior if list_versions races with module loading
      dm integrity: flush the journal on suspend

Mitja Spes (2):
      iio: pressure: ms5611: changed hardcoded SPI speed to value limited
      iio: pressure: ms5611: fixed value compensation bug

Moshe Shemesh (1):
      net/mlx5: Fix FW tracer timestamp calculation

Mushahid Hussain (1):
      speakup: fix a segfault caused by switching consoles

Nathan Chancellor (4):
      x86/speculation: Use DECLARE_PER_CPU for x86_spec_ctrl_current
      vmlinux.lds.h: Fix placement of '.data..decrypted' section
      RISC-V: vdso: Do not add missing symbols to version section in linker script
      mm: Fix '.data.once' orphan section warning

Nathan Huckleberry (1):
      drm/imx: imx-tve: Fix return type of imx_tve_connector_mode_valid

Nicolas Cavallari (1):
      wifi: mac80211: Fix ack frame idr leak when mesh has no route

Nicolas Dumazet (1):
      usb: add NO_LPM quirk for Realforce 87U Keyboard

Pankaj Raghav (1):
      nvme initialize core quirks before calling nvme_init_subsystem

Paul Gazzillo (1):
      iio: light: rpr0521: add missing Kconfig dependencies

Pawan Gupta (7):
      x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS
      x86/bugs: Add Cannon lake to RETBleed affected CPU list
      x86/speculation: Disable RRSBA behavior
      x86/bugs: Warn when "ibrs" mitigation is selected on Enhanced IBRS parts
      x86/bugs: Make sure MSR_SPEC_CTRL is updated properly upon resume from S3
      x86/tsx: Add a feature bit for TSX control MSR support
      x86/pm: Add enumeration check before spec MSRs save/restore setup

Peter Kosyh (1):
      net/mlx4: Check retval of mlx4_bitmap_init

Peter Zijlstra (10):
      x86/cpufeatures: Move RETPOLINE flags to word 11
      x86/bugs: Keep a per-CPU IA32_SPEC_CTRL value
      x86/entry: Remove skip_r11rcx
      x86/entry: Add kernel IBRS implementation
      x86/bugs: Optimize SPEC_CTRL MSR writes
      x86/bugs: Split spectre_v2_select_mitigation() and spectre_v2_user_select_mitigation()
      x86/bugs: Report Intel retbleed vulnerability
      intel_idle: Disable IBRS during long idle
      x86/speculation: Change FILL_RETURN_BUFFER to work with objtool
      x86/common: Stamp out the stepping madness

Phil Auld (1):
      hwmon: (coretemp) Check for null before removing sysfs attrs

Przemyslaw Patynowski (1):
      i40e: Disallow ip4 and ip6 l4_4_bytes

Randy Dunlap (1):
      nios2: add FORCE for vmlinuz.gz

Reinhard Speyerer (1):
      USB: serial: option: add Fibocom FM160 0x0111 composition

Ricardo Cañuelo (2):
      selftests/futex: fix build for clang
      selftests/intel_pstate: fix build for ARCH=x86_64

Ross Lagerwall (1):
      xen/netback: Ensure protocol headers don't fall in the non-linear area

Ryusuke Konishi (2):
      nilfs2: fix deadlock in nilfs_count_free_blocks()
      nilfs2: fix use-after-free bug of ns_writer on remount

Samuel Holland (1):
      bus: sunxi-rsb: Support atomic transfers

Sean Anderson (1):
      net: fman: Unregister ethernet device on removal

Sean Nyekjaer (1):
      spi: stm32: fix stm32_spi_prepare_mbr() that halves spi clk for every run

Sebastian Reichel (1):
      arm: dts: rockchip: fix node name for hym8563 rtc

Serge Semin (1):
      block: sed-opal: kmalloc the cmd/resp buffers

Shawn Guo (1):
      serial: imx: Add missing .thaw_noirq hook

Shigeru Yoshida (1):
      net: tun: Fix use-after-free in tun_detach()

Shuah Khan (1):
      docs: update mediator contact information in CoC doc

Srikar Dronamraju (1):
      scripts/faddr2line: Fix regression in name resolution on ppc64le

Srinivasa Rao Mandadapu (1):
      ASoC: soc-pcm: Add NULL check in BE reparenting

Stefan Haberland (1):
      s390/dasd: fix no record found for raw_track_access

Steven Rostedt (Google) (1):
      error-injection: Add prompt for function error injection

Suleiman Souhlal (2):
      Revert "x86/speculation: Add RSB VM Exit protections"
      Revert "x86/cpu: Add a steppings field to struct x86_cpu_id"

Sylwester Dziedziuch (1):
      i40e: Fix for VF MAC address 0

Takashi Iwai (2):
      ALSA: usb-audio: Add quirk entry for M-Audio Micro
      ALSA: usb-audio: Drop snd_BUG_ON() from snd_usbmidi_output_open()

Tejun Heo (1):
      memcg: fix possible use-after-free in memcg_write_event_control()

Tetsuo Handa (2):
      9p/trans_fd: always use O_NONBLOCK read/write
      fbcon: Use kzalloc() in fbcon_prepare_logo()

Thomas Gleixner (2):
      x86/devicetable: Move x86 specific macro out of generic code
      x86/cpu: Add consistent CPU match macros

Thomas Huth (1):
      KVM: s390: vsie: Fix the initialization of the epoch extension (epdx) field

Tiezhu Yang (1):
      tools/vm/slabinfo-gnuplot: use "grep -E" instead of "egrep"

Tomislav Novak (1):
      ARM: 9251/1: perf: Fix stacktraces for tracepoint events in THUMB2 kernels

Tony Lindgren (1):
      serial: 8250: omap: Flush PM QOS work on remove

Tudor Ambarus (6):
      dmaengine: at_hdmac: Fix at_lli struct definition
      dmaengine: at_hdmac: Don't start transactions at tx_submit level
      dmaengine: at_hdmac: Fix completion of unissued descriptor in case of errors
      dmaengine: at_hdmac: Don't allow CPU to reorder channel enable
      dmaengine: at_hdmac: Fix impossible condition
      dmaengine: at_hdmac: Check return code of dma_async_device_register

Valentina Goncharenko (2):
      net: encx24j600: Add parentheses to fix precedence
      net: encx24j600: Fix invalid logic in reading of MISTAT register

Wang Hai (2):
      net: pch_gbe: fix potential memleak in pch_gbe_tx_queue()
      net/9p: Fix a potential socket leak in p9_socket_open

Wang ShaoBo (2):
      mISDN: fix misuse of put_device() in mISDN_register_device()
      Bluetooth: 6LoWPAN: add missing hci_dev_put() in get_l2cap_conn()

Wang Wensheng (2):
      ftrace: Fix the possible incorrect kernel message
      ftrace: Optimize the allocation for mcount entries

Wang Yufen (1):
      net: tun: Fix memory leaks of napi_get_frags

Wei Yongjun (5):
      net: bgmac: Drop free_netdev() from bgmac_enet_remove()
      net/x25: Fix skb leak in x25_lapb_receive_frame()
      iio: health: afe4403: Fix oob read in afe4403_read_raw
      iio: health: afe4404: Fix oob read in afe4404_[read|write]_raw
      mac802154: fix missing INIT_LIST_HEAD in ieee802154_if_add()

Willem de Bruijn (1):
      packet: do not set TP_STATUS_CSUM_VALID on CHECKSUM_COMPLETE

Xian Wang (1):
      ALSA: hda/ca0132: add quirk for EVGA Z390 DARK

Xin Long (3):
      tipc: fix the msg->req tlv len check in tipc_nl_compat_name_table_dump_header
      tipc: set con sock in tipc_conn_alloc
      tipc: add an extra conn_get in tipc_conn_alloc

Xiongfeng Wang (4):
      mmc: sdhci-pci: Fix possible memory leak caused by missing pci_dev_put()
      platform/x86: asus-wmi: add missing pci_dev_put() in asus_wmi_set_xusb2pr()
      iommu/vt-d: Fix PCI device refcount leak in dmar_dev_scope_init()
      gpio: amd8111: Fix PCI device reference count leak

Xiu Jianfeng (1):
      ftrace: Fix null pointer dereference in ftrace_add_mod()

Xiubo Li (2):
      ceph: do not update snapshot context when there is no new snapshot
      ceph: avoid putting the realm twice when decoding snaps fails

Yang Yingliang (17):
      HID: hyperv: fix possible memory leak in mousevsc_probe()
      siox: fix possible memory leak in siox_device_add()
      ata: libata-transport: fix double ata_host_put() in ata_tport_add()
      mISDN: fix possible memory leak in mISDN_dsp_element_register()
      xen/pcpu: fix possible memory leak in register_pcpu()
      iio: adc: at91_adc: fix possible memory leak in at91_adc_allocate_trigger()
      iio: trigger: sysfs: fix possible memory leak in iio_sysfs_trig_init()
      scsi: target: tcm_loop: Fix possible name leak in tcm_loop_setup_hba_bus()
      net: pch_gbe: fix pci device refcount leak while module exiting
      Drivers: hv: vmbus: fix double free in the error path of vmbus_add_channel_work()
      Drivers: hv: vmbus: fix possible memory leak in vmbus_device_register()
      bnx2x: fix pci device refcount leak in bnx2x_vf_is_pcie_pending()
      hwmon: (i5500_temp) fix missing pci_disable_device()
      of: property: decrement node refcount in of_fwnode_get_reference_args()
      net: phy: fix null-ptr-deref while probe() failed
      hwmon: (coretemp) fix pci device refcount leak in nv1a_ram_new()
      net: plip: don't call kfree_skb/dev_kfree_skb() under spin_lock_irq()

Yann Gautier (1):
      mmc: core: properly select voltage range without power cycle

Ye Bin (1):
      ALSA: hda: fix potential memleak in 'add_widget_node'

Yoshihiro Shimoda (1):
      net: ethernet: renesas: ravb: Fix promiscuous mode after system resumed

Yu Liao (1):
      net: thunderx: Fix the ACPI memory leak

Yuan Can (3):
      drm/vc4: Fix missing platform_unregister_drivers() call in vc4_drm_register()
      net: thunderbolt: Fix error handling in tbnet_init()
      net: net_netdev: Fix error handling in ntb_netdev_init_module()

YueHaibing (4):
      tipc: check skb_linearize() return value in tipc_disc_rcv()
      net/mlx5: Fix uninitialized variable bug in outlen_write()
      net: hsr: Fix potential use-after-free
      tipc: Fix potential OOB in tipc_link_proto_rcv()

Zeng Heng (1):
      pinctrl: devicetree: fix null pointer dereferencing in pinctrl_dt_to_map

Zhang Changzhong (4):
      net/qla3xxx: fix potential memleak in ql3xxx_send()
      can: sja1000_isa: sja1000_isa_probe(): add missing free_sja1000dev()
      can: cc770: cc770_isa_probe(): add missing free_cc770dev()
      ethernet: aeroflex: fix potential skb leak in greth_init_rings()

Zhang Qilong (3):
      ASoC: wm5102: Revert "ASoC: wm5102: Fix PM disable depth imbalance in wm5102_probe"
      ASoC: wm5110: Revert "ASoC: wm5110: Fix PM disable depth imbalance in wm5110_probe"
      ASoC: wm8997: Revert "ASoC: wm8997: Fix PM disable depth imbalance in wm8997_probe"

Zhang Xiaoxu (2):
      btrfs: selftests: fix wrong error check in btrfs_free_dummy_root()
      cifs: Fix wrong return value checking when GETFLAGS

ZhangPeng (3):
      udf: Fix a slab-out-of-bounds write bug in udf_find_entry()
      nilfs2: fix NULL pointer dereference in nilfs_palloc_commit_free_entry()
      HID: core: fix shift-out-of-bounds in hid_report_raw_event

Zheng Yongjun (1):
      ARM: mxs: fix memory leak in mxs_machine_init()

Zhengchao Shao (10):
      net: lapbether: fix issue of dev reference count leakage in lapbeth_device_event()
      hamradio: fix issue of dev reference count leakage in bpq_device_event()
      drivers: net: xgene: disable napi when register irq failed in xgene_enet_open()
      net: nixge: disable napi when enable interrupts failed in nixge_open()
      net: cxgb3_main: disable napi when bind qsets failed in cxgb_up()
      ethernet: s2io: disable napi when start nic failed in s2io_card_up()
      net: mv643xx_eth: disable napi when init rxq or txq failed in mv643xx_eth_open()
      net: caif: fix double disconnect client in chnl_net_open()
      9p/fd: fix issue of list_del corruption in p9_fd_cancel()
      selftests: rtnetlink: correct xfrm policy rule in kci_test_ipsec_offload

Ziyang Xuan (1):
      ieee802154: cc2520: Fix error return code in cc2520_hw_init()

ruanjinjie (1):
      xen/platform-pci: add missing free_irq() in error path
