Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54481706779
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjEQMDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjEQMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:01:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EC28690;
        Wed, 17 May 2023 05:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23BC164618;
        Wed, 17 May 2023 12:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32340C433EF;
        Wed, 17 May 2023 12:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324853;
        bh=HocF9GCQHMm3XihViwvvwrwkXZ6EczthzuRdGWheG5Y=;
        h=From:To:Cc:Subject:Date:From;
        b=PuW0AolYWxJnWM2izeYpbkCX00wPXTlsiKX4qbH1IGUQ1h4q+LsXCoB8W6fYjkE56
         TavCvci9kEeXDJs3pHp6pYJ1tp4N3cE7ymto9zfKf41U/sSKrMcjOt94DMSeaK7tOD
         DIO8TOeBJtGaS9GrdNng1mqxeV0sfDZZQj/bkGug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.112
Date:   Wed, 17 May 2023 14:00:39 +0200
Message-Id: <2023051739-leggings-reassure-a517@gregkh>
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

I'm announcing the release of the 5.15.112 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                  |    2 
 arch/arm/boot/dts/exynos4412-itop-elite.dts               |    2 
 arch/arm/boot/dts/s5pv210.dtsi                            |    2 
 arch/riscv/mm/init.c                                      |    3 
 arch/riscv/mm/pageattr.c                                  |    8 
 arch/sh/Kconfig.debug                                     |    2 
 arch/sh/kernel/head_32.S                                  |    6 
 arch/sh/kernel/nmi_debug.c                                |    4 
 arch/sh/kernel/setup.c                                    |    4 
 arch/sh/math-emu/sfp-util.h                               |    4 
 crypto/algapi.c                                           |    3 
 crypto/crypto_engine.c                                    |   11 
 drivers/block/drbd/drbd_receiver.c                        |    2 
 drivers/bus/Makefile                                      |    2 
 drivers/bus/mhi/Kconfig                                   |   27 
 drivers/bus/mhi/Makefile                                  |    8 
 drivers/bus/mhi/core/Makefile                             |    4 
 drivers/bus/mhi/core/boot.c                               |  533 ----
 drivers/bus/mhi/core/debugfs.c                            |  413 ---
 drivers/bus/mhi/core/init.c                               | 1431 -----------
 drivers/bus/mhi/core/internal.h                           |  718 ------
 drivers/bus/mhi/core/main.c                               | 1673 --------------
 drivers/bus/mhi/core/pm.c                                 | 1261 ----------
 drivers/bus/mhi/host/Kconfig                              |   31 
 drivers/bus/mhi/host/Makefile                             |    6 
 drivers/bus/mhi/host/boot.c                               |  541 ++++
 drivers/bus/mhi/host/debugfs.c                            |  413 +++
 drivers/bus/mhi/host/init.c                               | 1443 ++++++++++++
 drivers/bus/mhi/host/internal.h                           |  718 ++++++
 drivers/bus/mhi/host/main.c                               | 1673 ++++++++++++++
 drivers/bus/mhi/host/pci_generic.c                        | 1146 +++++++++
 drivers/bus/mhi/host/pm.c                                 | 1261 ++++++++++
 drivers/bus/mhi/pci_generic.c                             | 1146 ---------
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c       |    2 
 drivers/crypto/ccp/psp-dev.c                              |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c                 |    6 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                     |    3 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                     |    1 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                    |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         |   18 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c         |    3 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c |   45 
 drivers/gpu/drm/bridge/lontium-lt8912b.c                  |    1 
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c                   |    2 
 drivers/gpu/drm/i915/display/intel_snps_phy.c             | 1210 ++++++++++
 drivers/gpu/drm/msm/adreno/a5xx_debugfs.c                 |    4 
 drivers/gpu/drm/msm/adreno/adreno_device.c                |   20 
 drivers/gpu/drm/msm/msm_debugfs.c                         |   12 
 drivers/gpu/drm/msm/msm_drv.c                             |   11 
 drivers/gpu/drm/msm/msm_gpu.c                             |   14 
 drivers/gpu/drm/msm/msm_gpu.h                             |   20 
 drivers/gpu/drm/msm/msm_perf.c                            |    9 
 drivers/gpu/drm/msm/msm_rd.c                              |   16 
 drivers/gpu/drm/msm/msm_ringbuffer.c                      |    4 
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c          |    2 
 drivers/hid/wacom_wac.c                                   |   38 
 drivers/hid/wacom_wac.h                                   |    1 
 drivers/mailbox/zynqmp-ipi-mailbox.c                      |   13 
 drivers/net/dsa/mt7530.c                                  |    4 
 drivers/net/dsa/mv88e6xxx/chip.c                          |    1 
 drivers/net/ethernet/freescale/enetc/enetc_qos.c          |    2 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c          |    5 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h          |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c           |   49 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c     |   13 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c      |   11 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c      |    2 
 drivers/net/ethernet/pensando/ionic/ionic_devlink.c       |    2 
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c       |    2 
 drivers/net/ethernet/sfc/mcdi_port_common.c               |   11 
 drivers/net/usb/r8152.c                                   |   84 
 drivers/net/virtio_net.c                                  |   43 
 drivers/net/wireless/realtek/rtw88/rtw8821c.c             |    2 
 drivers/platform/x86/touchscreen_dmi.c                    |   41 
 drivers/remoteproc/imx_rproc.c                            |    7 
 drivers/remoteproc/st_remoteproc.c                        |    5 
 drivers/remoteproc/stm32_rproc.c                          |    6 
 drivers/scsi/qedi/qedi_main.c                             |    3 
 drivers/tty/serial/8250/8250.h                            |   12 
 drivers/tty/serial/8250/8250_port.c                       |   12 
 drivers/watchdog/dw_wdt.c                                 |    7 
 fs/btrfs/block-rsv.c                                      |    3 
 fs/btrfs/ctree.c                                          |   32 
 fs/btrfs/file-item.c                                      |    5 
 fs/btrfs/free-space-cache.c                               |    7 
 fs/btrfs/print-tree.c                                     |    6 
 fs/btrfs/zoned.c                                          |   10 
 fs/cifs/cifsfs.c                                          |   16 
 fs/cifs/connect.c                                         |    7 
 fs/cifs/smb2ops.c                                         |    2 
 fs/ext4/balloc.c                                          |   25 
 fs/ext4/extents_status.c                                  |   30 
 fs/ext4/hash.c                                            |    6 
 fs/ext4/inline.c                                          |   17 
 fs/ext4/inode.c                                           |    2 
 fs/ext4/mballoc.c                                         |    6 
 fs/ext4/namei.c                                           |   53 
 fs/ext4/super.c                                           |   19 
 fs/ext4/xattr.c                                           |    5 
 fs/f2fs/namei.c                                           |   16 
 fs/fs-writeback.c                                         |    2 
 fs/ksmbd/auth.c                                           |   98 
 fs/ksmbd/auth.h                                           |   19 
 fs/ksmbd/connection.c                                     |    3 
 fs/ksmbd/connection.h                                     |   16 
 fs/ksmbd/mgmt/tree_connect.c                              |    5 
 fs/ksmbd/mgmt/tree_connect.h                              |    4 
 fs/ksmbd/mgmt/user_config.c                               |   10 
 fs/ksmbd/mgmt/user_config.h                               |    1 
 fs/ksmbd/mgmt/user_session.c                              |   95 
 fs/ksmbd/mgmt/user_session.h                              |   14 
 fs/ksmbd/oplock.c                                         |   11 
 fs/ksmbd/smb2pdu.c                                        |   94 
 fs/ksmbd/smb_common.h                                     |    2 
 fs/ksmbd/vfs.c                                            |    3 
 fs/ksmbd/vfs_cache.c                                      |    2 
 fs/notify/inotify/inotify_fsnotify.c                      |   11 
 fs/ntfs3/bitmap.c                                         |    3 
 fs/ntfs3/namei.c                                          |   10 
 fs/ntfs3/ntfs.h                                           |    3 
 fs/ubifs/dir.c                                            |   31 
 fs/ubifs/ubifs.h                                          |    2 
 fs/ubifs/xattr.c                                          |    2 
 include/crypto/algapi.h                                   |    7 
 include/linux/crypto.h                                    |    6 
 include/sound/pcm.h                                       |   15 
 include/sound/soc-dpcm.h                                  |    2 
 include/sound/soc.h                                       |    2 
 kernel/locking/rwsem.c                                    |    8 
 kernel/trace/ring_buffer.c                                |   16 
 net/ethtool/ioctl.c                                       |    2 
 net/ipv6/sit.c                                            |    8 
 net/ncsi/ncsi-aen.c                                       |    1 
 net/packet/af_packet.c                                    |    2 
 net/rxrpc/sendmsg.c                                       |    2 
 net/sched/act_mirred.c                                    |    2 
 net/sched/cls_api.c                                       |    1 
 sound/core/pcm_native.c                                   |   13 
 sound/soc/soc-compress.c                                  |    3 
 sound/soc/soc-core.c                                      |    1 
 sound/soc/soc-pcm.c                                       |  364 ++-
 sound/usb/caiaq/input.c                                   |    1 
 tools/perf/builtin-stat.c                                 |  181 -
 tools/perf/pmu-events/arch/powerpc/power9/other.json      |    4 
 tools/perf/pmu-events/arch/powerpc/power9/pipeline.json   |    2 
 tools/perf/scripts/python/intel-pt-events.py              |    2 
 tools/perf/util/evlist.c                                  |  146 -
 tools/perf/util/evlist.h                                  |   50 
 tools/perf/util/evsel.h                                   |    6 
 tools/perf/util/pmu.c                                     |    2 
 tools/perf/util/sort.c                                    |    3 
 tools/perf/util/symbol-elf.c                              |    2 
 tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh   |   10 
 154 files changed, 9922 insertions(+), 7953 deletions(-)

Alexandre Ghiti (1):
      RISC-V: Fix up a cherry-pick warning in setup_vm_final()

Anastasia Belova (1):
      btrfs: print-tree: parent bytenr must be aligned to sector size

Andrea Mayer (1):
      selftests: srv6: make srv6_end_dt46_l3vpn_test more robust

Andrey Avdeev (1):
      platform/x86: touchscreen_dmi: Add info for the Dexp Ursus KX210i

Andy Moreton (1):
      sfc: Fix module EEPROM reporting for QSFP modules

Angelo Dureghello (1):
      net: dsa: mv88e6xxx: add mv88e6321 rsvd2cpu

Ankit Nautiyal (1):
      drm/i915/dg2: Add HDMI pixel clock frequencies 267.30 and 319.89 MHz

Arnaldo Carvalho de Melo (1):
      perf pmu: zfree() expects a pointer to a pointer to zero it after freeing its contents

Arınç ÜNAL (1):
      net: dsa: mt7530: fix corrupt frames using trgmii on 40 MHz XTAL MT7621

Aurabindo Pillai (1):
      drm/amd/display: Fix hang when skipping modeset

Baokun Li (1):
      ext4: check iomap type only if ext4_iomap_begin() does not fail

Boris Burkov (1):
      btrfs: fix encoded write i_size corruption with no-holes

Chia-I Wu (1):
      drm/amdgpu: add a missing lock for AMDGPU_SCHED

Christoph Böhmwalder (1):
      drbd: correctly submit flush bio on barrier

Christoph Hellwig (1):
      btrfs: zero the buffer before marking it dirty in btrfs_redirty_list_add

Christophe JAILLET (3):
      mailbox: zynq: Switch to flexible array to simplify code
      watchdog: dw_wdt: Fix the error handling path of dw_wdt_drv_probe()
      crypto: sun8i-ss - Fix a test in sun8i_ss_setup_ivs()

Cong Wang (1):
      sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()

Corentin Labbe (1):
      crypto: engine - check if BH is disabled during completion

Cosmo Chou (1):
      net/ncsi: clear Tx enable mode when handling a Config required AEN

Dale Zhao (1):
      drm/amd/display: Refine condition of cursor visibility for pipe-split

Daniel Baluta (1):
      ASoC: soc-compress: Inherit atomicity from DAI link for Compress FE

David Howells (1):
      rxrpc: Fix hard call timeout units

Dmitrii Dolgov (1):
      perf stat: Separate bperf from bpf_profiler

Filipe Manana (2):
      btrfs: fix btrfs_prev_leaf() to not return the same key twice
      btrfs: fix space cache inconsistency after error loading it from disk

Francesco Dolcini (1):
      drm/bridge: lt8912b: Fix DSI Video Mode

Geetha sowjanya (1):
      octeontx2-af: Secure APR table update with the lock

Greg Kroah-Hartman (1):
      Linux 5.15.112

Guchun Chen (2):
      drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when enabling legacy gfx ras
      drm/amdgpu: disable sdma ecc irq only when sdma RAS is enabled in suspend

Hamza Mahfooz (2):
      drm/amd/display: fix flickering caused by S/G mode
      drm/amdgpu: fix an amdgpu_irq_put() issue in gmc_v9_0_hw_fini()

Hans de Goede (1):
      platform/x86: touchscreen_dmi: Add upside-down quirk for GDIX1002 ts on the Juno Tablet

Hayes Wang (3):
      r8152: fix flow control issue of RTL8156A
      r8152: fix the poor throughput for 2.5G devices
      r8152: move setting r8153b_rx_agg_chg_indicate()

Herbert Xu (2):
      crypto: api - Add scaffolding to change completion function signature
      crypto: engine - Use crypto_request_complete

Ian Rogers (1):
      perf evlist: Refactor evlist__for_each_cpu()

Ido Schimmel (1):
      ethtool: Fix uninitialized number of lanes

Ilpo Järvinen (1):
      serial: 8250: Fix serial8250_tx_empty() race with DMA Tx

Jaegeuk Kim (1):
      f2fs: fix potential corruption when moving a directory

James Cowgill (1):
      drm/panel: otm8009a: Set backlight parent to panel device

Jan Kara (2):
      inotify: Avoid reporting event with invalid wd
      ext4: fix data races when using cached status extents

Jeffrey Hugo (3):
      bus: mhi: host: Remove duplicate ee check for syserr
      bus: mhi: host: Use mhi_tryset_pm_state() for setting fw error state
      bus: mhi: host: Range check CHDBOFF and ERDBOFF

Jeremi Piotrowski (1):
      crypto: ccp - Clear PSP interrupt status register before calling handler

Johan Hovold (3):
      drm/msm: fix NULL-deref on snapshot tear down
      drm/msm: fix NULL-deref on irq uninstall
      drm/msm/adreno: fix runtime PM imbalance at gpu load

John Stultz (1):
      locking/rwsem: Add __always_inline annotation to __down_read_common() and inlined callers

Josef Bacik (1):
      btrfs: don't free qgroup space unless specified

Kajol Jain (1):
      perf vendor events power9: Remove UTF-8 characters from JSON files

Konrad Dybcio (1):
      drm/msm/adreno: adreno_gpu: Use suspend() instead of idle() on load error

Konstantin Komarov (1):
      fs/ntfs3: Refactoring of various minor issues

Krzysztof Kozlowski (2):
      ARM: dts: exynos: fix WM8960 clock name in Itop Elite
      ARM: dts: s5pv210: correct MIPI CSIS clock name

Kuninori Morimoto (1):
      ASoC: soc-pcm.c: call __soc_pcm_close() in soc_pcm_close()

Kuniyuki Iwashima (1):
      af_packet: Don't send zero-byte data in packet_sendmsg_spkt().

Lin.Cao (1):
      drm/amdgpu: Fix vram recover doesn't work after whole GPU reset (v2)

Manivannan Sadhasivam (1):
      bus: mhi: Move host MHI code to "host" directory

Markus Elfring (1):
      perf map: Delete two variable initialisations before null pointer checks in sort__sym_from_cmp()

Mathieu Poirier (3):
      remoteproc: stm32: Call of_node_put() on iteration error
      remoteproc: st: Call of_node_put() on iteration error
      remoteproc: imx_rproc: Call of_node_put() on iteration error

Maxim Korotkov (1):
      writeback: fix call of incorrect macro

Mårten Lindahl (1):
      ubifs: Fix memory leak in do_rename

Namjae Jeon (8):
      ksmbd: set RSS capable in FSCTL_QUERY_NETWORK_INTERFACE_INFO
      ksmbd: fix multi session connection failure
      ksmbd: replace sessions list in connection with xarray
      ksmbd: add channel rwlock
      ksmbd: fix kernel oops from idr_remove()
      ksmbd: fix racy issue while destroying session on multichannel
      ksmbd: fix deadlock in ksmbd_find_crypto_ctx()
      ksmbd: not allow guest user on multichannel

Naohiro Aota (1):
      btrfs: zoned: fix wrong use of bitops API in btrfs_ensure_empty_zones

Nicholas Kazlauskas (1):
      drm/amd/display: Add NULL plane_state check for cursor disable logic

Olivier Bacon (1):
      crypto: engine - fix crypto_queue backlog handling

Pawel Witek (1):
      cifs: fix pcchunk length type in smb2_copychunk_range

Pierre-Louis Bossart (4):
      ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure
      ASoC: soc-pcm: align BE 'atomicity' with that of the FE
      ASoC: soc-pcm: test refcount before triggering
      ASoC: soc-pcm: fix BE handling of PAUSE_RELEASE

Ping Cheng (2):
      HID: wacom: Set a default resolution for older tablets
      HID: wacom: insert timestamp to packed Bluetooth (BT) events

Randy Dunlap (4):
      sh: math-emu: fix macro redefined warning
      sh: mcount.S: fix build error when PRINTK is not enabled
      sh: init: use OF_EARLY_FLATTREE for early init
      sh: nmi_debug: fix return value of __setup handler

Ratheesh Kannoth (1):
      octeontx2-af: Skip PFs if not enabled

Rob Clark (1):
      drm/msm: Remove struct_mutex usage

Roman Lozko (1):
      perf scripts intel-pt-events.py: Fix IPC output for Python 2

Ruliang Lin (1):
      ALSA: caiaq: input: Add error handling for unsupported input methods in `snd_usb_caiaq_input_init`

Sascha Hauer (1):
      wifi: rtw88: rtw8821c: Fix rfe_option field width

Saurabh Sengar (1):
      drm/hyperv: Don't overwrite dirt_needed value set by host

Shannon Nelson (2):
      ionic: remove noise from ethtool rxnfc error msg
      ionic: catch failure from devlink_alloc

Sia Jee Heng (1):
      RISC-V: mm: Enable huge page support to kernel_page_present() function

Steve French (3):
      cifs: release leases for deferred close handles when freezing
      smb3: fix problem remounting a share after shutdown
      SMB3: force unmount was failing to close deferred close files

Subbaraya Sundeep (2):
      octeontx2-pf: Disable packet I/O for graceful exit
      octeontx2-vf: Detach LF resources on probe cleanup

Takashi Iwai (5):
      ASoC: soc-pcm: Fix and cleanup DPCM locking
      ASoC: soc-pcm: serialize BE triggers
      ASoC: soc-pcm: Fix DPCM lockdep warning due to nested stream locks
      ASoC: soc-pcm: Move debugfs removal out of spinlock
      ASoC: DPCM: Don't pick up BE without substream

Tanmay Shah (1):
      mailbox: zynqmp: Fix counts of child nodes

Taylor, Clinton A (1):
      drm/i915/dg2: Add additional HDMI pixel clock frequencies

Theodore Ts'o (7):
      ext4: improve error recovery code paths in __ext4_remount()
      ext4: improve error handling from ext4_dirhash()
      ext4: fix deadlock when converting an inline directory in nojournal mode
      ext4: add bounds checking in get_max_inline_xattr_value_size()
      ext4: bail out of ext4_xattr_ibody_get() fails for any reason
      ext4: remove a BUG_ON in ext4_mb_release_group_pa()
      ext4: fix invalid free tracking in ext4_xattr_move_to_block()

Tudor Ambarus (1):
      ext4: avoid a potential slab-out-of-bounds in ext4_group_desc_csum

Tze-nan Wu (1):
      ring-buffer: Ensure proper resetting of atomic variables in ring_buffer_reset_online_cpus

Vandita Kulkarni (1):
      drm/i915/dg2: Support 4k@30 on HDMI

Victor Nogueira (1):
      net/sched: act_mirred: Add carrier check

Vlad Buslov (1):
      net/sched: cls_api: remove block_cb from driver_list before freeing

Wei Fang (1):
      net: enetc: check the index of the SFI rather than the handle

Wenliang Wang (1):
      virtio_net: suppress cpu stall when free_unused_bufs

Xuan Zhuo (1):
      virtio_net: split free_unused_bufs()

Yang Jihong (1):
      perf symbols: Fix return incorrect build_id size in elf_read_build_id()

Ye Bin (1):
      ext4: fix WARNING in mb_find_extent

ZhangPeng (1):
      fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()

Zheng Wang (1):
      scsi: qedi: Fix use after free bug in qedi_remove()

Zhihao Cheng (1):
      ubifs: Fix AA deadlock when setting xattr for encrypted file

