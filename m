Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76AF72F981
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244135AbjFNJlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbjFNJj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:39:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DB11FFF;
        Wed, 14 Jun 2023 02:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D00D63FD8;
        Wed, 14 Jun 2023 09:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F38C433B8;
        Wed, 14 Jun 2023 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686735529;
        bh=6Xj/nOWSNaeK8qHbc9ydbOLe6WbFg2d74OqF38p1MKY=;
        h=From:To:Cc:Subject:Date:From;
        b=lzTX812N2CMZHHyoOfY1aT7QX0mbz/SZ8IZz9HIgY4vb7AvTTBIUytN8MLz5zVTlV
         idDrvzUUOkpeCEAOWLEIwBo0VLLZo8N72YKv91AdMdQqoVqbEqJbUaC17/Ez2SiWWx
         5/o+wsQXrDRTF8BZ8BTd46/0qsRoiyQiIXcBatPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.3.8
Date:   Wed, 14 Jun 2023 11:38:37 +0200
Message-ID: <2023061438-anthill-blurt-5fb5@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.3.8 kernel.

All users of the 6.3 kernel series must upgrade.

The updated 6.3.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.3.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/mm/page_table_check.rst                         |   19 
 Documentation/networking/ip-sysctl.rst                        |    4 
 Makefile                                                      |    2 
 arch/arm/boot/dts/at91-sama7g5ek.dts                          |    2 
 arch/arm/mach-at91/pm.c                                       |   20 
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi                |    8 
 arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi    |    4 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                  |    4 
 arch/arm64/boot/dts/qcom/sc7180-lite.dtsi                     |    8 
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                        |    1 
 arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts |    4 
 arch/riscv/Kconfig                                            |    1 
 arch/riscv/include/asm/pgtable.h                              |    3 
 arch/riscv/mm/init.c                                          |    2 
 block/blk-mq.c                                                |    8 
 drivers/accel/ivpu/Kconfig                                    |    1 
 drivers/accel/ivpu/ivpu_hw_mtl.c                              |   22 
 drivers/accel/ivpu/ivpu_hw_mtl_reg.h                          |    1 
 drivers/accel/ivpu/ivpu_ipc.c                                 |    4 
 drivers/accel/ivpu/ivpu_job.c                                 |   21 
 drivers/accel/ivpu/ivpu_mmu.c                                 |   22 
 drivers/block/rbd.c                                           |   62 +
 drivers/bluetooth/hci_qca.c                                   |    6 
 drivers/firmware/arm_ffa/driver.c                             |    1 
 drivers/gpio/gpio-sim.c                                       |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                      |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                    |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c                     |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                  |    7 
 drivers/gpu/drm/amd/amdgpu/vi.c                               |   11 
 drivers/gpu/drm/amd/display/dc/core/dc.c                      |   36 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c             |   20 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c          |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c       |   92 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                |    4 
 drivers/gpu/drm/i915/display/intel_dp_aux.c                   |   32 
 drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c         |   14 
 drivers/gpu/drm/i915/gt/selftest_execlists.c                  |   12 
 drivers/gpu/drm/lima/lima_sched.c                             |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                         |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                         |    2 
 drivers/i2c/busses/i2c-mv64xxx.c                              |   11 
 drivers/i2c/busses/i2c-sprd.c                                 |    8 
 drivers/input/input.c                                         |    2 
 drivers/input/joystick/xpad.c                                 |    1 
 drivers/input/mouse/elantech.c                                |    9 
 drivers/input/touchscreen/cyttsp5.c                           |    2 
 drivers/misc/eeprom/Kconfig                                   |    1 
 drivers/net/dsa/lan9303-core.c                                |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                     |   40 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c             |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c                 |    1 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                |   22 
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                |    3 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                  |    5 
 drivers/net/ethernet/freescale/enetc/enetc.c                  |   16 
 drivers/net/ethernet/intel/ice/ice_common.c                   |    2 
 drivers/net/ethernet/intel/ice/ice_common.h                   |    2 
 drivers/net/ethernet/intel/ice/ice_gnss.c                     |   64 -
 drivers/net/ethernet/intel/ice/ice_gnss.h                     |   10 
 drivers/net/ethernet/qlogic/qed/qed_l2.c                      |    2 
 drivers/net/ethernet/qlogic/qede/qede.h                       |    4 
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c               |   24 
 drivers/net/ethernet/qlogic/qede/qede_main.c                  |   34 
 drivers/net/virtio_net.c                                      |   16 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                   |    8 
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c               |    3 
 drivers/net/wireless/realtek/rtw88/mac80211.c                 |   14 
 drivers/net/wireless/realtek/rtw88/main.c                     |    4 
 drivers/net/wireless/realtek/rtw88/ps.c                       |   43 +
 drivers/net/wireless/realtek/rtw88/ps.h                       |    2 
 drivers/net/wireless/realtek/rtw89/mac80211.c                 |   16 
 drivers/net/wireless/realtek/rtw89/ps.c                       |   26 
 drivers/net/wireless/realtek/rtw89/ps.h                       |    1 
 drivers/pinctrl/meson/pinctrl-meson-axg.c                     |    1 
 drivers/platform/surface/aggregator/controller.c              |    2 
 drivers/platform/surface/surface_aggregator_tabletsw.c        |    5 
 drivers/s390/block/dasd_ioctl.c                               |    4 
 drivers/soc/qcom/icc-bwmon.c                                  |    4 
 drivers/soc/qcom/ramp_controller.c                            |    2 
 drivers/soc/qcom/rmtfs_mem.c                                  |    1 
 drivers/soc/qcom/rpmh-rsc.c                                   |    2 
 drivers/soundwire/stream.c                                    |    4 
 drivers/spi/spi-mt65xx.c                                      |    3 
 drivers/spi/spi-qup.c                                         |   37 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c                  |    6 
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h                  |    5 
 drivers/tee/amdtee/amdtee_if.h                                |   10 
 drivers/tee/amdtee/call.c                                     |   30 
 drivers/usb/core/buffer.c                                     |   41 +
 drivers/usb/core/devio.c                                      |   20 
 drivers/vdpa/mlx5/net/mlx5_vnet.c                             |    2 
 drivers/vdpa/vdpa_user/vduse_dev.c                            |    3 
 drivers/vhost/vdpa.c                                          |   21 
 drivers/vhost/vhost.c                                         |   18 
 drivers/vhost/vhost.h                                         |    8 
 fs/afs/dir.c                                                  |    3 
 fs/ceph/caps.c                                                |    6 
 fs/ceph/snap.c                                                |    4 
 fs/ext4/super.c                                               |    6 
 fs/ext4/xattr.c                                               |    6 
 fs/ksmbd/connection.c                                         |   12 
 fs/ksmbd/oplock.c                                             |   66 -
 fs/ksmbd/smb2pdu.c                                            |   13 
 fs/ksmbd/smbacl.c                                             |    4 
 fs/ksmbd/vfs.c                                                |    4 
 include/linux/netdevice.h                                     |    9 
 include/linux/page-flags.h                                    |    6 
 include/linux/usb/hcd.h                                       |    5 
 include/net/bluetooth/bluetooth.h                             |   43 -
 include/net/bluetooth/hci.h                                   |    1 
 include/net/bluetooth/hci_core.h                              |   41 -
 include/net/neighbour.h                                       |    2 
 include/net/netns/ipv6.h                                      |    2 
 include/net/ping.h                                            |    6 
 include/net/pkt_sched.h                                       |    2 
 include/net/rpl.h                                             |    3 
 include/net/sch_generic.h                                     |    6 
 include/net/sock.h                                            |   18 
 kernel/bpf/map_in_map.c                                       |    8 
 kernel/fork.c                                                 |    2 
 kernel/trace/bpf_trace.c                                      |   12 
 lib/cpu_rmap.c                                                |    2 
 mm/Kconfig.debug                                              |    1 
 mm/page_table_check.c                                         |    6 
 net/batman-adv/distributed-arp-table.c                        |    2 
 net/bluetooth/hci_conn.c                                      |  378 ++++++----
 net/bluetooth/hci_core.c                                      |   10 
 net/bluetooth/hci_event.c                                     |  161 ++--
 net/bluetooth/hci_sync.c                                      |   23 
 net/bluetooth/iso.c                                           |  133 ++-
 net/bluetooth/l2cap_core.c                                    |   13 
 net/can/j1939/main.c                                          |   24 
 net/can/j1939/socket.c                                        |    5 
 net/core/dev.c                                                |    8 
 net/core/skmsg.c                                              |    3 
 net/ipv4/sysctl_net_ipv4.c                                    |    8 
 net/ipv4/tcp_offload.c                                        |   19 
 net/ipv6/exthdrs.c                                            |   29 
 net/mac80211/he.c                                             |   15 
 net/mac80211/mlme.c                                           |    8 
 net/mac80211/rx.c                                             |    4 
 net/mptcp/pm.c                                                |   23 
 net/mptcp/pm_netlink.c                                        |   18 
 net/mptcp/pm_userspace.c                                      |   48 +
 net/mptcp/protocol.h                                          |    1 
 net/netfilter/ipset/ip_set_core.c                             |    8 
 net/netfilter/nf_conntrack_core.c                             |    3 
 net/netfilter/nf_tables_api.c                                 |    4 
 net/netfilter/nft_bitwise.c                                   |    2 
 net/openvswitch/datapath.c                                    |   19 
 net/openvswitch/vport.c                                       |   18 
 net/sched/act_police.c                                        |   10 
 net/sched/cls_api.c                                           |    3 
 net/sched/sch_api.c                                           |   26 
 net/sched/sch_fq_pie.c                                        |   10 
 net/sched/sch_generic.c                                       |   30 
 net/sched/sch_mq.c                                            |    8 
 net/sched/sch_mqprio.c                                        |    8 
 net/sched/sch_pie.c                                           |    5 
 net/sched/sch_red.c                                           |    5 
 net/sched/sch_sfq.c                                           |    5 
 net/sched/sch_taprio.c                                        |    6 
 net/sched/sch_teql.c                                          |    2 
 net/smc/smc_llc.c                                             |    4 
 net/wireless/core.c                                           |    4 
 net/wireless/nl80211.c                                        |    2 
 sound/isa/gus/gus_pcm.c                                       |    2 
 sound/pci/cmipci.c                                            |    6 
 sound/pci/hda/hda_codec.c                                     |    6 
 sound/pci/hda/patch_realtek.c                                 |    9 
 sound/pci/ice1712/aureon.c                                    |    7 
 sound/pci/ice1712/ice1712.c                                   |   14 
 sound/pci/ice1712/ice1724.c                                   |   16 
 sound/pci/ymfpci/ymfpci_main.c                                |    6 
 sound/soc/amd/ps/pci-ps.c                                     |    3 
 sound/soc/amd/ps/ps-pdm-dma.c                                 |   10 
 sound/soc/codecs/wsa881x.c                                    |    1 
 sound/soc/codecs/wsa883x.c                                    |    1 
 sound/soc/generic/simple-card-utils.c                         |    2 
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c                    |    7 
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h                    |    1 
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c                    |    4 
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c                 |   47 -
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.h                 |    1 
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c                    |    5 
 sound/soc/mediatek/mt8195/mt8195-afe-clk.h                    |    1 
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c                    |    9 
 sound/soc/mediatek/mt8195/mt8195-audsys-clk.c                 |   47 -
 sound/soc/mediatek/mt8195/mt8195-audsys-clk.h                 |    1 
 tools/testing/selftests/bpf/prog_tests/sockopt_sk.c           |   28 
 tools/testing/selftests/bpf/progs/sockopt_sk.c                |   12 
 tools/testing/selftests/net/mptcp/mptcp_join.sh               |   11 
 193 files changed, 1842 insertions(+), 951 deletions(-)

Adam Ford (1):
      arm64: dts: imx8mn-beacon: Fix SPI CS pinmux

Ai Chao (1):
      ALSA: hda/realtek: Add a quirk for HP Slim Desktop S01

Akihiro Suda (1):
      net/ipv4: ping_group_range: allow GID from 2147483648 to 4294967294

Alexander Sverdlin (1):
      net: dsa: lan9303: allow vid != 0 in port_fdb_{add|del} methods

Alvin Lee (1):
      drm/amd/display: Reduce sdp bw after urgent to 90%

Andi Shyti (1):
      drm/i915/gt: Use the correct error value when kernel_context() fails

Andrzej Kacprowski (2):
      accel/ivpu: Do not trigger extra VPU reset if the VPU is idle
      accel/ivpu: Fix sporadic VPU boot failure

Balint Dobszay (1):
      firmware: arm_ffa: Set handle field to zero in memory descriptor

Ben Hutchings (1):
      lib: cpu_rmap: Fix potential use-after-free in irq_cpu_rmap_release()

Bjorn Andersson (1):
      arm64: dts: qcom: sc8280xp: Flush RSC sleep & wake votes

Brett Creeley (1):
      virtio_net: use control_buf for coalesce params

Charles Keepax (1):
      soundwire: stream: Add missing clear of alloc_slave_rt

Chia-I Wu (1):
      drm/amdgpu: fix xclk freq on CHIP_STONEY

Christophe JAILLET (1):
      soc: qcom: ramp_controller: Fix an error handling path in qcom_ramp_controller_probe()

Claudiu Beznea (2):
      ARM: at91: pm: fix imbalanced reference counter for ethernet devices
      ARM: dts: at91: sama7g5ek: fix debounce delay property for shdwc

Dan Carpenter (1):
      soc: qcom: rmtfs: Fix error code in probe()

Daniel Golle (1):
      spi: mt65xx: make sure operations completed before unloading

David Howells (1):
      afs: Fix setting of mtime when creating a file/dir/symlink

Dmitry Baryshkov (1):
      drm/msm/a6xx: initialize GMU mutex earlier

Dmitry Torokhov (2):
      Input: psmouse - fix OOB access in Elantech protocol
      Input: fix open count when closing inhibited device

Douglas Anderson (1):
      arm64: dts: qcom: sc7180-lite: Fix SDRAM freq for misidentified sc7180-lite boards

Dragos Tatulea (1):
      vdpa/mlx5: Fix hang when cvq commands are triggered during device unregister

Eelco Chaudron (1):
      net: openvswitch: fix upcall counter access before allocation

Eric Dumazet (9):
      bpf, sockmap: Avoid potential NULL dereference in sk_psock_verdict_data_ready()
      net/ipv6: fix bool/int mismatch for skip_notify_on_dev_down
      net/sched: fq_pie: ensure reasonable TCA_FQ_PIE_QUANTUM values
      tcp: gso: really support BIG TCP
      rfs: annotate lockless accesses to sk->sk_rxhash
      rfs: annotate lockless accesses to RFS sock flow table
      net: sched: add rcu annotations around qdisc->qdisc_sleeping
      net: sched: move rtm_tca_policy declaration to include file
      net: sched: act_police: fix sparse errors in tcf_police_dump()

Erico Nunes (1):
      drm/lima: fix sched context destroy

Evan Quan (1):
      drm/amd/pm: conditionally disable pcie lane switching for some sienna_cichlid SKUs

Fedor Pchelkin (2):
      can: j1939: change j1939_netdev_lock type to mutex
      can: j1939: avoid possible use-after-free when j1939_can_rx_register fails

Florian Fainelli (1):
      net: bcmgenet: Fix EEE implementation

Gavrilov Ilia (1):
      netfilter: nf_tables: Add null check for nla_nest_start_noflag() in nft_dump_basechain_hook()

Geliang Tang (5):
      mptcp: only send RM_ADDR in nl_cmd_remove
      mptcp: add address into userspace pm list
      mptcp: update userspace pm infos
      selftests: mptcp: update userspace pm addr tests
      selftests: mptcp: update userspace pm subflow tests

Greg Kroah-Hartman (2):
      Revert "staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE"
      Linux 6.3.8

Gustavo A. R. Silva (1):
      wifi: iwlwifi: mvm: Fix -Warray-bounds bug in iwl_mvm_wait_d3_notif()

Hangyu Hua (1):
      net: sched: fix possible refcount leak in tc_chain_tmplt_add()

Horatio Zhang (1):
      drm/amdgpu: fix Null pointer dereference error in amdgpu_device_recover_vram

Hsieh-Tseng Shen (1):
      riscv: mm: Ensure prot of VM_WRITE and VM_EXEC must be readable

Ilya Dryomov (2):
      rbd: move RBD_OBJ_FLAG_COPYUP_ENABLED flag setting
      rbd: get snapshot context after exclusive lock is ensured to be held

Ismael Ferreras Morezuelas (1):
      Input: xpad - delete a Razer DeathAdder mouse VID/PID entry

Iulia Tanasescu (1):
      Bluetooth: Split bt_iso_qos into dedicated structures

Jan Höppner (1):
      s390/dasd: Use correct lock while counting channel queue length

Jaroslav Kysela (1):
      ALSA: ice1712,ice1724: fix the kcontrol->id initialization

Jeremy Sowden (1):
      netfilter: nft_bitwise: fix register tracking

Jiri Olsa (1):
      bpf: Add extra path pointer check to d_path helper

Johan Hovold (2):
      Bluetooth: fix debugfs registration
      Bluetooth: hci_qca: fix debugfs registration

Johannes Berg (5):
      wifi: mac80211: use correct iftype HE cap
      wifi: cfg80211: reject bad AP MLD address
      wifi: mac80211: mlme: fix non-inheritence element
      wifi: mac80211: don't translate beacon/presp addrs
      wifi: cfg80211: fix locking in sched scan stop work

Jouni Högander (1):
      drm/i915: Use 18 fast wake AUX sync len

KP Singh (1):
      bpf: Fix UAF in task local storage

Kent Gibson (1):
      gpio: sim: fix memory corruption when adding named lines and unnamed hogs

Konrad Dybcio (1):
      arm64: dts: qcom: sm6375-pdx225: Fix remoteproc firmware paths

Krzysztof Kozlowski (2):
      soc: qcom: icc-bwmon: fix incorrect error code passed to dev_err_probe()
      soc: qcom: rpmh-rsc: drop redundant unsigned >=0 comparision

Kuniyuki Iwashima (2):
      netfilter: ipset: Add schedule point in call_ad().
      ipv6: rpl: Fix Route of Death.

Lijo Lazar (1):
      drm/amd/pm: Fix power context allocation in SMU13

Lorenzo Bianconi (1):
      wifi: mt76: mt7615: fix possible race in mt7615_mac_sta_poll

Luiz Augusto von Dentz (3):
      Bluetooth: hci_conn: Add support for linking multiple hcon
      Bluetooth: hci_conn: Fix not matching by CIS ID
      Bluetooth: Fix use-after-free in hci_remove_ltk/hci_remove_irk

Manish Chopra (1):
      qed/qede: Fix scheduling while atomic

Marek Behún (1):
      i2c: mv64xxx: Fix reading invalid status value in atomic mode

Mario Limonciello (1):
      drm/amd: Disallow s0ix without BIOS support again

Martin Hundebøll (1):
      pinctrl: meson-axg: add missing GPIOA_18 gpio group

Maximilian Luz (2):
      platform/surface: aggregator: Allow completion work-items to be executed in parallel
      platform/surface: aggregator_tabletsw: Add support for book mode in KIP subsystem

Maximilian Weigand (1):
      Input: cyttsp5 - fix array length

Michal Schmidt (1):
      ice: make writes to /dev/gnssX synchronous

Namjae Jeon (4):
      ksmbd: fix out-of-bound read in deassemble_neg_contexts()
      ksmbd: fix out-of-bound read in parse_lease_state()
      ksmbd: fix posix_acls and acls dereferencing possible ERR_PTR()
      ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop

Oleksij Rempel (1):
      can: j1939: j1939_sk_send_loop_abort(): improved error queue handling in J1939 Socket

Pablo Neira Ayuso (1):
      netfilter: nf_tables: out-of-bound check in chain blob

Pauli Virtanen (4):
      Bluetooth: ISO: consider right CIS when removing CIG at cleanup
      Bluetooth: ISO: Fix CIG auto-allocation to select configurable CIG
      Bluetooth: ISO: don't try to remove CIG if there are bound CIS left
      Bluetooth: ISO: use correct CIS order in Set CIG Parameters event

Pavan Chebbi (2):
      bnxt_en: Fix bnxt_hwrm_update_rss_hash_cfg()
      bnxt_en: Prevent kernel panic when receiving unexpected PHC_UPDATE event

Ping-Ke Shih (2):
      wifi: rtw89: correct PS calculation for SUPPORTS_DYNAMIC_PS
      wifi: rtw88: correct PS calculation for SUPPORTS_DYNAMIC_PS

Qingfang DENG (1):
      neighbour: fix unaligned access to pneigh_entry

Randy Dunlap (2):
      accel/ivpu: ivpu_ipc needs GENERIC_ALLOCATOR
      eeprom: at24: also select REGMAP

RenHai (1):
      ALSA: hda/realtek: Add Lenovo P3 Tower platform

Rhys Rustad-Elliott (1):
      bpf: Fix elem_size not being set for inner maps

Rijo Thomas (1):
      tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'

Robert Hancock (1):
      ASoC: simple-card-utils: fix PCM constraint error check

Ruan Jinjie (1):
      riscv: fix kprobe __user string arg print fault issue

Ruihan Li (7):
      usb: usbfs: Enforce page requirements for mmap
      usb: usbfs: Use consistent mmap functions
      mm: page_table_check: Make it dependent on EXCLUSIVE_SYSTEM_RAM
      mm: page_table_check: Ensure user pages are not slab pages
      Bluetooth: Fix potential double free caused by hci_conn_unlink
      Bluetooth: Refcnt drop must be placed last in hci_conn_unlink
      Bluetooth: Fix UAF in hci_conn_hash_flush again

Samson Tam (1):
      drm/amd/display: add ODM case when looking for first split pipe

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

Srinivas Kandagatla (2):
      ASoC: codecs: wsa883x: do not set can_multi_write flag
      ASoC: codecs: wsa881x: do not set can_multi_write flag

Stanislav Fomichev (1):
      selftests/bpf: Verify optval=NULL case

Stanislaw Gruszka (2):
      accel/ivpu: Reserve all non-command bo's using DMA_RESV_USAGE_BOOKKEEP
      accel/ivpu: Do not use mutex_lock_interruptible

Stefan Binding (1):
      ALSA: hda/realtek: Add quirks for Asus ROG 2024 laptops using CS35L41

Stephan Gerhold (1):
      spi: qup: Request DMA before enabling clocks

Sungwoo Kim (1):
      Bluetooth: L2CAP: Add missing checks for invalid DCID

Takashi Iwai (4):
      ALSA: hda: Fix kctl->id initialization
      ALSA: ymfpci: Fix kctl->id initialization
      ALSA: gus: Fix kctl->id initialization
      ALSA: cmipci: Fix kctl->id initialization

Theodore Ts'o (2):
      Revert "ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled"
      ext4: only check dquot_initialize_needed() when debugging

Tian Lan (1):
      blk-mq: fix blk_mq_hw_ctx active request accounting

Tijs Van Buggenhout (1):
      netfilter: conntrack: fix NULL pointer dereference in nf_confirm_cthelper

Tim Crawford (1):
      ALSA: hda/realtek: Add quirk for Clevo NS50AU

Trevor Wu (2):
      ASoC: mediatek: mt8188: fix use-after-free in driver remove path
      ASoC: mediatek: mt8195: fix use-after-free in driver remove path

Tvrtko Ursulin (1):
      drm/i915/selftests: Add some missing error propagation

Uwe Kleine-König (2):
      ASoC: mediatek: mt8195-afe-pcm: Convert to platform remove callback returning void
      i2c: sprd: Delete i2c adapter in .remove's error path

Vijendar Mukunda (1):
      ASoC: amd: ps: fix for acp_lock access in pdm driver

Vikas Gupta (1):
      bnxt_en: Skip firmware fatal error recovery if chip is not accessible

Ville Syrjälä (1):
      drm/i915: Explain the magic numbers for AUX SYNC/precharge length

Vladislav Efanov (1):
      batman-adv: Broken sync while rescheduling delayed work

Wei Fang (2):
      net: enetc: correct the statistics of rx bytes
      net: enetc: correct rx_bytes statistics of XDP

Wen Gu (1):
      net/smc: Avoid to access invalid RMBs' MRs in SMCRv1 ADD LINK CONT

Xiubo Li (1):
      ceph: fix use-after-free bug for inodes when flushing capsnaps

YiPeng Chai (1):
      drm/amdgpu: change reserved vram info print

Ying Hsu (1):
      Bluetooth: Fix l2cap_disconnect_req deadlock

Yonghong Song (1):
      selftests/bpf: Fix sockopt_sk selftest

Zhengping Jiang (1):
      Bluetooth: hci_sync: add lock to protect HCI_UNREGISTER

