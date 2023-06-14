Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3755072F972
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244276AbjFNJkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244184AbjFNJjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:39:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B701E52;
        Wed, 14 Jun 2023 02:38:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F20616363A;
        Wed, 14 Jun 2023 09:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0419BC433C8;
        Wed, 14 Jun 2023 09:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686735515;
        bh=FxY6N4hbT9BS25QnEkPhe+VTNtp/EmdkNTzloqZWLpE=;
        h=From:To:Cc:Subject:Date:From;
        b=0MCHd2qerzENb+XJi8feS/UadQjc6B+PgaLin1prfpiP4FN2XLMKYrq0GcPZzePAL
         6BbmBsKnMUCzUW6P8/7B4slE0mokLNGsVew05TyKAJmkALixwN6oz0goU5ViZthFdu
         X5rbIbqTEQtMaGXAevq0erD4i/WJ/1ZXTwI6W9mk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.117
Date:   Wed, 14 Jun 2023 11:38:22 +0200
Message-ID: <2023061423-chubby-shredder-eb1a@gregkh>
X-Mailer: git-send-email 2.41.0
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

I'm announcing the release of the 5.15.117 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arm/boot/dts/at91-sama7g5ek.dts                       |    2 
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi             |    8 
 arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi |    4 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts               |    4 
 arch/arm64/boot/dts/qcom/sc7180-lite.dtsi                  |    8 
 arch/riscv/Kconfig                                         |    1 
 block/blk-iocost.c                                         |    8 
 drivers/ata/ahci.h                                         |  245 +-
 drivers/block/Kconfig                                      |    9 
 drivers/block/Makefile                                     |    2 
 drivers/block/rbd.c                                        |   62 
 drivers/block/sx8.c                                        | 1575 -------------
 drivers/bluetooth/hci_qca.c                                |    6 
 drivers/firmware/arm_ffa/driver.c                          |    1 
 drivers/gpu/drm/amd/amdgpu/vi.c                            |   11 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   92 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c             |    4 
 drivers/gpu/drm/i915/display/intel_dp_aux.c                |   32 
 drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c      |  132 -
 drivers/gpu/drm/i915/gt/selftest_execlists.c               |   60 
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c               |   51 
 drivers/gpu/drm/i915/selftests/i915_request.c              |  252 +-
 drivers/i2c/busses/i2c-mv64xxx.c                           |   11 
 drivers/i2c/busses/i2c-sprd.c                              |    8 
 drivers/input/input.c                                      |    2 
 drivers/input/joystick/xpad.c                              |    1 
 drivers/input/mouse/elantech.c                             |    9 
 drivers/misc/eeprom/Kconfig                                |    1 
 drivers/net/dsa/lan9303-core.c                             |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                  |   28 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c          |    2 
 drivers/net/ethernet/freescale/enetc/enetc.c               |    8 
 drivers/net/ethernet/intel/i40e/i40e.h                     |    6 
 drivers/net/ethernet/intel/i40e/i40e_adminq.c              |   64 
 drivers/net/ethernet/intel/i40e/i40e_alloc.h               |   22 
 drivers/net/ethernet/intel/i40e/i40e_client.c              |   12 
 drivers/net/ethernet/intel/i40e/i40e_common.c              | 1032 +++-----
 drivers/net/ethernet/intel/i40e/i40e_dcb.c                 |   60 
 drivers/net/ethernet/intel/i40e/i40e_dcb.h                 |   28 
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c              |   16 
 drivers/net/ethernet/intel/i40e/i40e_ddp.c                 |   14 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c             |    8 
 drivers/net/ethernet/intel/i40e/i40e_diag.c                |   12 
 drivers/net/ethernet/intel/i40e/i40e_diag.h                |    4 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c             |   65 
 drivers/net/ethernet/intel/i40e/i40e_hmc.c                 |   56 
 drivers/net/ethernet/intel/i40e/i40e_hmc.h                 |   46 
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c             |   94 
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h             |   34 
 drivers/net/ethernet/intel/i40e/i40e_main.c                |  404 +--
 drivers/net/ethernet/intel/i40e/i40e_nvm.c                 |  252 +-
 drivers/net/ethernet/intel/i40e/i40e_osdep.h               |    1 
 drivers/net/ethernet/intel/i40e/i40e_prototype.h           |  629 ++---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c         |   94 
 drivers/net/ethernet/intel/ice/ice_fltr.c                  |    2 
 drivers/net/ethernet/qlogic/qed/qed_l2.c                   |    2 
 drivers/net/ethernet/qlogic/qede/qede.h                    |    4 
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c            |   24 
 drivers/net/ethernet/qlogic/qede/qede_main.c               |   34 
 drivers/net/ethernet/sfc/ef100_tx.c                        |    3 
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c            |    3 
 drivers/pinctrl/meson/pinctrl-meson-axg.c                  |    1 
 drivers/platform/surface/aggregator/controller.c           |    2 
 drivers/s390/block/dasd_ioctl.c                            |    4 
 drivers/spi/spi-qup.c                                      |   37 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c               |    6 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h               |    5 
 drivers/tee/amdtee/amdtee_if.h                             |   10 
 drivers/tee/amdtee/call.c                                  |   30 
 drivers/usb/core/buffer.c                                  |   41 
 drivers/usb/core/devio.c                                   |   20 
 drivers/vdpa/vdpa_user/vduse_dev.c                         |    3 
 drivers/vhost/vdpa.c                                       |   21 
 drivers/vhost/vhost.c                                      |   18 
 drivers/vhost/vhost.h                                      |    8 
 fs/afs/dir.c                                               |    3 
 fs/ceph/caps.c                                             |    6 
 fs/ceph/snap.c                                             |    4 
 fs/ext4/super.c                                            |    6 
 fs/ext4/xattr.c                                            |    6 
 fs/f2fs/sysfs.c                                            |    4 
 fs/xfs/xfs_buf_item_recover.c                              |   10 
 include/linux/netdevice.h                                  |    7 
 include/linux/usb/hcd.h                                    |    5 
 include/net/bond_alb.h                                     |    4 
 include/net/neighbour.h                                    |    2 
 include/net/netns/ipv6.h                                   |    2 
 include/net/pkt_sched.h                                    |    2 
 include/net/rpl.h                                          |    3 
 include/net/sock.h                                         |   18 
 kernel/fork.c                                              |    2 
 kernel/trace/bpf_trace.c                                   |   12 
 lib/cpu_rmap.c                                             |    2 
 lib/debugobjects.c                                         |   21 
 net/batman-adv/distributed-arp-table.c                     |    2 
 net/bluetooth/hci_core.c                                   |    8 
 net/bluetooth/l2cap_core.c                                 |   13 
 net/can/j1939/main.c                                       |   24 
 net/can/j1939/socket.c                                     |    5 
 net/core/dev.c                                             |    6 
 net/ipv6/exthdrs.c                                         |   29 
 net/netfilter/ipset/ip_set_core.c                          |    8 
 net/netfilter/nf_conntrack_core.c                          |    3 
 net/sched/act_police.c                                     |   10 
 net/sched/cls_api.c                                        |    3 
 net/sched/sch_fq_pie.c                                     |    8 
 net/smc/smc_llc.c                                          |    4 
 net/wireless/core.c                                        |    4 
 scripts/gcc-plugins/gcc-common.h                           |    4 
 sound/pci/hda/patch_realtek.c                              |    3 
 sound/soc/codecs/wsa881x.c                                 |    1 
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c                 |    5 
 sound/soc/mediatek/mt8195/mt8195-afe-clk.h                 |    1 
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c                 |    9 
 sound/soc/mediatek/mt8195/mt8195-audsys-clk.c              |   47 
 sound/soc/mediatek/mt8195/mt8195-audsys-clk.h              |    1 
 tools/testing/selftests/bpf/prog_tests/sockopt_sk.c        |   28 
 tools/testing/selftests/bpf/progs/sockopt_sk.c             |   12 
 119 files changed, 2491 insertions(+), 3742 deletions(-)

Adam Ford (1):
      arm64: dts: imx8mn-beacon: Fix SPI CS pinmux

Ai Chao (1):
      ALSA: hda/realtek: Add a quirk for HP Slim Desktop S01

Akeem G Abodunrin (1):
      drm/i915/selftests: Increase timeout for live_parallel_switch

Alexander Sverdlin (1):
      net: dsa: lan9303: allow vid != 0 in port_fdb_{add|del} methods

Andi Shyti (1):
      drm/i915/gt: Use the correct error value when kernel_context() fails

Arnd Bergmann (2):
      ata: ahci: fix enum constants for gcc-13
      blk-iocost: avoid 64-bit division in ioc_timer_fn

Balint Dobszay (1):
      firmware: arm_ffa: Set handle field to zero in memory descriptor

Ben Hutchings (1):
      lib: cpu_rmap: Fix potential use-after-free in irq_cpu_rmap_release()

Chia-I Wu (1):
      drm/amdgpu: fix xclk freq on CHIP_STONEY

Christoph Hellwig (1):
      remove the sx8 block driver

Claudiu Beznea (1):
      ARM: dts: at91: sama7g5ek: fix debounce delay property for shdwc

Darrick J. Wong (1):
      xfs: verify buffer contents when we skip log replay

David Howells (1):
      afs: Fix setting of mtime when creating a file/dir/symlink

Dmitry Torokhov (2):
      Input: psmouse - fix OOB access in Elantech protocol
      Input: fix open count when closing inhibited device

Douglas Anderson (1):
      arm64: dts: qcom: sc7180-lite: Fix SDRAM freq for misidentified sc7180-lite boards

Eric Dumazet (6):
      net/ipv6: fix bool/int mismatch for skip_notify_on_dev_down
      net/sched: fq_pie: ensure reasonable TCA_FQ_PIE_QUANTUM values
      rfs: annotate lockless accesses to sk->sk_rxhash
      rfs: annotate lockless accesses to RFS sock flow table
      net: sched: move rtm_tca_policy declaration to include file
      net: sched: act_police: fix sparse errors in tcf_police_dump()

Evan Quan (1):
      drm/amd/pm: conditionally disable pcie lane switching for some sienna_cichlid SKUs

Fedor Pchelkin (2):
      can: j1939: change j1939_netdev_lock type to mutex
      can: j1939: avoid possible use-after-free when j1939_can_rx_register fails

Greg Kroah-Hartman (4):
      i40e: fix build warning in ice_fltr_add_mac_to_list()
      Revert "debugobject: Ensure pool refill (again)"
      Revert "staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE"
      Linux 5.15.117

Hangyu Hua (1):
      net: sched: fix possible refcount leak in tc_chain_tmplt_add()

Ilya Dryomov (2):
      rbd: move RBD_OBJ_FLAG_COPYUP_ENABLED flag setting
      rbd: get snapshot context after exclusive lock is ensured to be held

Ismael Ferreras Morezuelas (1):
      Input: xpad - delete a Razer DeathAdder mouse VID/PID entry

Jan Höppner (1):
      s390/dasd: Use correct lock while counting channel queue length

Jan Sokolowski (2):
      i40e: Remove string printing for i40e_status
      i40e: use int for i40e_status

Jiri Olsa (1):
      bpf: Add extra path pointer check to d_path helper

Jiri Slaby (SUSE) (2):
      sfc (gcc13): synchronize ef100_enqueue_skb()'s return type
      bonding (gcc13): synchronize bond_{a,t}lb_xmit() types

Johan Hovold (1):
      Bluetooth: hci_qca: fix debugfs registration

Johannes Berg (1):
      wifi: cfg80211: fix locking in sched scan stop work

Jouni Högander (1):
      drm/i915: Use 18 fast wake AUX sync len

KP Singh (1):
      bpf: Fix UAF in task local storage

Kees Cook (1):
      gcc-plugins: Reorganize gimple includes for GCC 13

Kuniyuki Iwashima (2):
      netfilter: ipset: Add schedule point in call_ad().
      ipv6: rpl: Fix Route of Death.

Lijo Lazar (1):
      drm/amd/pm: Fix power context allocation in SMU13

Lorenzo Bianconi (1):
      wifi: mt76: mt7615: fix possible race in mt7615_mac_sta_poll

Luiz Augusto von Dentz (1):
      Bluetooth: Fix use-after-free in hci_remove_ltk/hci_remove_irk

Manish Chopra (1):
      qed/qede: Fix scheduling while atomic

Marek Behún (1):
      i2c: mv64xxx: Fix reading invalid status value in atomic mode

Martin Hundebøll (1):
      pinctrl: meson-axg: add missing GPIOA_18 gpio group

Maximilian Luz (1):
      platform/surface: aggregator: Allow completion work-items to be executed in parallel

Oleksij Rempel (1):
      can: j1939: j1939_sk_send_loop_abort(): improved error queue handling in J1939 Socket

Qilin Tan (1):
      f2fs: fix iostat lock protection

Qingfang DENG (1):
      neighbour: fix unaligned access to pneigh_entry

Randy Dunlap (1):
      eeprom: at24: also select REGMAP

RenHai (1):
      ALSA: hda/realtek: Add Lenovo P3 Tower platform

Rijo Thomas (1):
      tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'

Ruan Jinjie (1):
      riscv: fix kprobe __user string arg print fault issue

Ruihan Li (2):
      usb: usbfs: Enforce page requirements for mmap
      usb: usbfs: Use consistent mmap functions

Shannon Nelson (2):
      vhost: support PACKED when setting-getting vring_base
      vhost_vdpa: support PACKED when setting-getting vring_base

Sheng Zhao (1):
      vduse: avoid empty string for dev name

Shenwei Wang (2):
      arm64: dts: imx8qm-mek: correct GPIOs for USDHC2 CD and WP signals
      arm64: dts: imx8-ss-dma: assign default clock rate for lpuarts

Somnath Kotur (2):
      bnxt_en: Query default VLAN before VNIC setup on a VF
      bnxt_en: Implement .set_port / .unset_port UDP tunnel callbacks

Sreekanth Reddy (1):
      bnxt_en: Don't issue AP reset during ethtool's reset operation

Srinivas Kandagatla (1):
      ASoC: codecs: wsa881x: do not set can_multi_write flag

Stanislav Fomichev (1):
      selftests/bpf: Verify optval=NULL case

Stephan Gerhold (1):
      spi: qup: Request DMA before enabling clocks

Sungwoo Kim (1):
      Bluetooth: L2CAP: Add missing checks for invalid DCID

Theodore Ts'o (2):
      Revert "ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled"
      ext4: only check dquot_initialize_needed() when debugging

Tijs Van Buggenhout (1):
      netfilter: conntrack: fix NULL pointer dereference in nf_confirm_cthelper

Tim Crawford (1):
      ALSA: hda/realtek: Add quirk for Clevo NS50AU

Trevor Wu (1):
      ASoC: mediatek: mt8195: fix use-after-free in driver remove path

Tvrtko Ursulin (2):
      drm/i915/selftests: Stop using kthread_stop()
      drm/i915/selftests: Add some missing error propagation

Uwe Kleine-König (2):
      ASoC: mediatek: mt8195-afe-pcm: Convert to platform remove callback returning void
      i2c: sprd: Delete i2c adapter in .remove's error path

Ville Syrjälä (1):
      drm/i915: Explain the magic numbers for AUX SYNC/precharge length

Vladislav Efanov (1):
      batman-adv: Broken sync while rescheduling delayed work

Wei Fang (1):
      net: enetc: correct the statistics of rx bytes

Wen Gu (1):
      net/smc: Avoid to access invalid RMBs' MRs in SMCRv1 ADD LINK CONT

Xiubo Li (1):
      ceph: fix use-after-free bug for inodes when flushing capsnaps

Ying Hsu (1):
      Bluetooth: Fix l2cap_disconnect_req deadlock

Yonghong Song (1):
      selftests/bpf: Fix sockopt_sk selftest

