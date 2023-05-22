Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7AE70C6E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjEVTXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjEVTXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:23:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FC3102;
        Mon, 22 May 2023 12:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72F4A62858;
        Mon, 22 May 2023 19:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B45C4339B;
        Mon, 22 May 2023 19:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783392;
        bh=EUdxqGVolBszZk78eFDC5c0Be6RZyGlVxgh/4Wbw+WM=;
        h=From:To:Cc:Subject:Date:From;
        b=HnxkrrxJdFVmshZ7e+VneAWUN905qC7I3PmPqvbRzwpc3Im2bBSbYYT6n4rNnn0Tz
         hQ5cpSJJWhIfmohoRSLKU3NwGsRA5dEaBoKHSOeMBtrTvERR/KUku+Rp4zMqS99hF5
         /3cwraD9Gn2LeuzOWmMfynsNxad7V9HTaZW3aE3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 6.1 000/292] 6.1.30-rc1 review
Date:   Mon, 22 May 2023 20:05:57 +0100
Message-Id: <20230522190405.880733338@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.30-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.30-rc1
X-KernelTest-Deadline: 2023-05-24T19:04+00:00
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

This is the start of the stable review cycle for the 6.1.30 release.
There are 292 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.30-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.30-rc1

Li Ma <li.ma@amd.com>
    drm/amdgpu: reserve the old gc_11_0_*_mes.bin

Jack Xiao <Jack.Xiao@amd.com>
    drm/amd/amdgpu: introduce gc_*_mes_2.bin v2

Li Ma <li.ma@amd.com>
    drm/amdgpu: declare firmware for new MES 11.0.4

Eric Biggers <ebiggers@google.com>
    crypto: testmgr - fix RNG performance in fuzz tests

Mathieu Poirier <mathieu.poirier@linaro.org>
    remoteproc: imx_dsp_rproc: Fix kernel test robot sparse warning

Ze Gao <zegao2021@gmail.com>
    rethook, fprobe: do not trace rethook related functions

Ze Gao <zegao2021@gmail.com>
    rethook: use preempt_{disable, enable}_notrace in rethook_trampoline_handler

Peter Collingbourne <pcc@google.com>
    arm64: mte: Do not set PG_mte_tagged if tags were not initialized

Heiko Carstens <hca@linux.ibm.com>
    s390/qdio: fix do_sqbs() inline assembly constraint

Heiko Carstens <hca@linux.ibm.com>
    s390/crypto: use vector instructions only if available for ChaCha20

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix command reject error on ESE devices

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix use-after-free bug of nilfs_root in nilfs_evict_inode()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s/radix: Fix soft dirty tracking

Jerry Snitselaar <jsnitsel@redhat.com>
    tpm/tpm_tis: Disable interrupts for more Lenovo devices

Gaurav Batra <gbatra@linux.vnet.ibm.com>
    powerpc/iommu: Incorrect DDW Table is referenced for SR-IOV device

Gaurav Batra <gbatra@linux.vnet.ibm.com>
    powerpc/iommu: DMA address offset is incorrectly calculated with 2MB TCEs

Michal Simek <michal.simek@amd.com>
    dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/gfx11: update gpu_clock_counter logic

Tong Liu01 <Tong.Liu01@amd.com>
    drm/amdgpu: refine get gpu clock counter method

Guilherme G. Piccoli <gpiccoli@igalia.com>
    drm/amdgpu/gfx11: Adjust gfxoff before powergating on gfx11 as well

Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
    drm/amdgpu/gfx10: Disable gfxoff before disabling powergating.

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/gmc11: implement get_vbios_fb_size()

Evan Quan <evan.quan@amd.com>
    drm/amd/pm: fix possible power mode mismatch between driver and PMFW

Xiubo Li <xiubli@redhat.com>
    ceph: force updating the msg pointer in non-split case

George Kennedy <george.kennedy@oracle.com>
    vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF

Mario Limonciello <mario.limonciello@amd.com>
    thunderbolt: Clear registers properly when auto clear isn't in use

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    serial: qcom-geni: fix enabling deactivated interrupt

Andrew Davis <afd@ti.com>
    serial: 8250_exar: Add support for USR298x PCI Modems

Vitaliy Tomin <tomin@iszf.irk.ru>
    serial: Add support for Advantech PCI-1611U card

Domenico Cerasuolo <cerasuolodomenico@gmail.com>
    mm: fix zswap writeback race condition

Peng Zhang <zhangpeng.00@bytedance.com>
    maple_tree: make maple state reusable after mas_empty_area()

Ilya Leoshkevich <iii@linux.ibm.com>
    statfs: enforce statfs[64] structure initialization

Michal Luczaj <mhal@rbox.co>
    KVM: Fix vcpu_array[0] races

Chih-Yen Chang <cc85nod@gmail.com>
    ksmbd: fix global-out-of-bounds in smb2_find_context_vals

Chih-Yen Chang <cc85nod@gmail.com>
    ksmbd: fix wrong UserName check in session_user

Chih-Yen Chang <cc85nod@gmail.com>
    ksmbd: allocate one more byte for implied bcc[0]

Gustav Johansson <gustajo@axis.com>
    ksmbd: smb2: Allow messages padded to 8byte boundary

Bharath SM <bharathsm@microsoft.com>
    SMB3: drop reference to cfile before sending oplock break

Bharath SM <bharathsm@microsoft.com>
    SMB3: Close all deferred handles of inode in case of handle lease break

Ping-Ke Shih <pkshih@realtek.com>
    wifi: rtw88: use work to update rate to avoid RCU warning

Jimmy Assarsson <extja@kvaser.com>
    can: kvaser_pciefd: Disable interrupts in probe error path

Jimmy Assarsson <extja@kvaser.com>
    can: kvaser_pciefd: Do not send EFLUSH command on TFD interrupt

Jimmy Assarsson <extja@kvaser.com>
    can: kvaser_pciefd: Clear listen-only bit if not explicitly requested

Jimmy Assarsson <extja@kvaser.com>
    can: kvaser_pciefd: Empty SRB buffer in probe

Jimmy Assarsson <extja@kvaser.com>
    can: kvaser_pciefd: Call request_irq() before enabling interrupts

Jimmy Assarsson <extja@kvaser.com>
    can: kvaser_pciefd: Set CAN_STATE_STOPPED in kvaser_pciefd_stop()

Oliver Hartkopp <socketcan@hartkopp.net>
    can: isotp: recvmsg(): allow MSG_CMSG_COMPAT flag

Oliver Hartkopp <socketcan@hartkopp.net>
    can: j1939: recvmsg(): allow MSG_CMSG_COMPAT flag

Kai-Heng Feng <kai.heng.feng@canonical.com>
    ALSA: hda/realtek: Fix mute and micmute LEDs for yet another HP laptop

Vitaly Rodionov <vitalyr@opensource.cirrus.com>
    ALSA: hda/realtek: Add quirk for HP EliteBook G10 laptops

Luke D. Jones <luke@ljones.dev>
    ALSA: hda/realtek: Add quirk for 2nd ASUS GU603

Ai Chao <aichao@kylinos.cn>
    ALSA: hda/realtek: Add a quirk for HP EliteDesk 805

Jeremy Soller <jeremy@system76.com>
    ALSA: hda/realtek: Add quirk for Clevo L140AU

Nikhil Mahale <nmahale@nvidia.com>
    ALSA: hda: Add NVIDIA codec IDs a3 through a7 to patch table

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Fix Oops by 9.1 surround channel names

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix incorrect tracking of free space on transfer rings

Mario Limonciello <mario.limonciello@amd.com>
    xhci-pci: Only run d3cold avoidance quirk for s2idle

Francesco Dolcini <francesco.dolcini@toradex.com>
    Revert "usb: gadget: udc: core: Invoke usb_gadget_connect only when started"

Francesco Dolcini <francesco.dolcini@toradex.com>
    Revert "usb: gadget: udc: core: Prevent redundant calls to pullup"

Badhri Jagan Sridharan <badhri@google.com>
    usb: typec: altmodes/displayport: fix pin_assignment_show

Konrad Gräfe <k.graefe@gateware.de>
    usb: gadget: u_ether: Fix host MAC address case

Udipto Goswami <quic_ugoswami@quicinc.com>
    usb: dwc3: debugfs: Resume dwc3 before accessing registers

Roger Quadros <rogerq@kernel.org>
    usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()

Weitao Wang <WeitaoWang-oc@zhaoxin.com>
    USB: UHCI: adjust zhaoxin UHCI controllers OverCurrent bit value

Maxime Bizon <mbizon@freebox.fr>
    usb-storage: fix deadlock when a scsi command timeouts more than once

Alan Stern <stern@rowland.harvard.edu>
    USB: usbtmc: Fix direction for 0-length ioctl control messages

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Add a sample rate workaround for Line6 Pod Go

Arnd Bergmann <arnd@arndb.de>
    bridge: always declare tunnel functions

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_rbtree: fix null deref on element insertion

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix nft_trans type confusion

Benjamin Poirier <bpoirier@nvidia.com>
    net: selftests: Fix optstring

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: pcs: xpcs: fix C73 AN not getting enabled

M Chetan Kumar <m.chetan.kumar@linux.intel.com>
    net: wwan: iosm: fix NULL pointer dereference when removing device

Eric Dumazet <edumazet@google.com>
    vlan: fix a potential uninit-value in vlan_dev_hard_start_xmit()

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    igb: fix bit_shift to be in [1..8] range

Marco Migliore <m.migliore@tiesse.com>
    net: dsa: mv88e6xxx: Fix mv88e6393x EPC write command offset

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    cassini: Fix a memory leak in the error handling path of cas_init_one()

Kuniyuki Iwashima <kuniyu@amazon.com>
    tun: Fix memory leak for detached NAPI queue.

Chuang Wang <nashuiliang@gmail.com>
    net: tun: rebuild error handling in tun_get_user

Michael Kelley <mikelley@microsoft.com>
    scsi: storvsc: Don't pass unused PFNs to Hyper-V host

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: don't trust firmware n_channels

Alon Giladi <alon.giladi@intel.com>
    wifi: iwlwifi: mvm: fix OEM's name in the tas approved list

Alon Giladi <alon.giladi@intel.com>
    wifi: iwlwifi: fix OEM's name in the ppag approved list

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: fw: fix DBGI dump

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: fix cancel_delayed_work_sync() deadlock

Michael Lee <michael-cy.lee@mediatek.com>
    wifi: mac80211: Abort running color change when stopping the AP

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix min center freq offset tracing

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    wifi: mac80211: fortify the spinlock against deadlock by interrupt

Ilan Peer <ilan.peer@intel.com>
    wifi: cfg80211: Drop entries with invalid BSSIDs in RNR

Dawid Wesierski <dawidx.wesierski@intel.com>
    ice: Fix ice VF reset during iavf initialization

Jacob Keller <jacob.e.keller@intel.com>
    ice: introduce clear_reset_state operation

Florian Fainelli <f.fainelli@gmail.com>
    net: bcmgenet: Restore phy_stop() depending upon suspend/close

Florian Fainelli <f.fainelli@gmail.com>
    net: bcmgenet: Remove phy_stop() from bcmgenet_netif_stop()

Oliver Hartkopp <socketcan@hartkopp.net>
    can: dev: fix missing CAN XL support in can_put_echo_skb()

Vineeth Vijayan <vneethv@linux.ibm.com>
    s390/cio: include subchannels without devices also for evaluation

Xin Long <lucien.xin@gmail.com>
    tipc: check the bearer min mtu properly when setting it by netlink

Xin Long <lucien.xin@gmail.com>
    tipc: do not update mtu if msg_max is too small in mtu negotiation

Xin Long <lucien.xin@gmail.com>
    tipc: add tipc_bearer_min_mtu to calculate min mtu

Feng Liu <feliu@nvidia.com>
    virtio_net: Fix error unwinding of XDP initialization

Parav Pandit <parav@nvidia.com>
    virtio-net: Maintain reverse cleanup order

Dong Chenchen <dongchenchen2@huawei.com>
    net: nsh: Use correct mac_offset to unwind gso skb in nsh_gso_segment()

Arnd Bergmann <arnd@arndb.de>
    drm/exynos: fix g2d_open/close helper function definitions

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ASoC: SOF: topology: Fix logic for copying tuples

Douglas Anderson <dianders@chromium.org>
    ASoC: mediatek: mt8186: Fix use-after-free in driver remove path

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Fix trace_svc_register() call site

NeilBrown <neilb@suse.de>
    SUNRPC: always free ctxt when freeing deferred request

NeilBrown <neilb@suse.de>
    SUNRPC: double free xprt_ctxt while still in use

Duoming Zhou <duoming@zju.edu.cn>
    media: netup_unidvb: fix use-after-free at del_timer()

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix reset timeout when enable full VF

Jie Wang <wangjie125@huawei.com>
    net: hns3: fix reset delay time to avoid configuration timeout

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix sending pfc frames after reset issue

Jie Wang <wangjie125@huawei.com>
    net: hns3: fix output information incomplete for dumping tx queue info with debugfs

Clément Léger <clement.leger@bootlin.com>
    net: dsa: rzn1-a5psw: disable learning for standalone ports

Alexis Lothoré <alexis.lothore@bootlin.com>
    net: dsa: rzn1-a5psw: fix STP states handling

Clément Léger <clement.leger@bootlin.com>
    net: dsa: rzn1-a5psw: enable management frames for CPU port

Xin Long <lucien.xin@gmail.com>
    erspan: get the proto with the md version for collect_md

Doug Berger <opendmb@gmail.com>
    serial: 8250_bcm7271: fix leak in `brcmuart_probe`

Doug Berger <opendmb@gmail.com>
    serial: 8250_bcm7271: balance clk_enable calls

Ke Zhang <m202171830@hust.edu.cn>
    serial: arc_uart: fix of_iomap leak in `arc_serial_probe`

Eric Dumazet <edumazet@google.com>
    tcp: fix possible sk_priority leak in tcp_v4_send_reset()

Zhuang Shengen <zhuangshengen@huawei.com>
    vsock: avoid to close connected socket after the timeout

Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
    sfc: disable RXFCS and RXALL features by default

Ryan C. Underwood <nemesis@icequake.net>
    ALSA: hda/realtek: Apply HP B&O top speaker profile to Pavilion 15

Ryder Lee <ryder.lee@mediatek.com>
    wifi: mt76: connac: fix stats->tx_bytes calculation

Dan Carpenter <dan.carpenter@linaro.org>
    ALSA: firewire-digi00x: prevent potential use after free

Grygorii Strashko <grygorii.strashko@ti.com>
    net: phy: dp83867: add w/a for packet errors seen with short cables

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    net: fec: Better handle pm_runtime_get() failing in .remove()

Andrea Mayer <andrea.mayer@uniroma2.it>
    selftets: seg6: disable rp_filter by default in srv6_end_dt4_l3vpn_test

Andrea Mayer <andrea.mayer@uniroma2.it>
    selftests: seg6: disable DAD on IPv6 router cfg for srv6_end_dt4_l3vpn_test

Rob Clark <robdclark@chromium.org>
    drm/msm: Fix submit error-path leaks

Tobias Brunner <tobias@strongswan.org>
    af_key: Reject optional tunnel/BEET mode templates in outbound policies

Tobias Brunner <tobias@strongswan.org>
    xfrm: Reject optional tunnel/BEET mode templates in outbound policies

Wyes Karny <wyes.karny@amd.com>
    cpupower: Make TSC read per CPU for Mperf monitor

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_micfil: Fix error handler with pm_runtime_enable

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    platform: Provide a remove callback that returns no value

Jianhua Lu <lujianhua000@gmail.com>
    dt-bindings: display/msm: dsi-controller-main: Document qcom, master-dsi and qcom, sync-dual-dsi

Marijn Suijten <marijn.suijten@somainline.org>
    drm/msm/dpu: Remove duplicate register defines from INTF

Marijn Suijten <marijn.suijten@somainline.org>
    drm/msm/dpu: Move non-MDP_TOP INTF_INTR offsets out of hwio header

Marijn Suijten <marijn.suijten@somainline.org>
    drm/msm/dpu: Assign missing writeback log_mask

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    drm/msm/dp: unregister audio driver during unbind

Martin Willi <martin@strongswan.org>
    Revert "Fix XFRM-I support for nested ESP tunnels"

Sabrina Dubroca <sd@queasysnail.net>
    xfrm: don't check the default policy if the policy allows the packet

Horatio Zhang <Hongkun.Zhang@amd.com>
    drm/amdgpu: drop gfx_v11_0_cp_ecc_error_irq_funcs

Fae <faenkhauser@gmail.com>
    platform/x86: hp-wmi: add micmute to hp_wmi_keymap struct

Jorge Lopez <jorge.lopez2@hp.com>
    platform/x86: Move existing HP drivers to a new hp subdir

Guilherme G. Piccoli <gpiccoli@igalia.com>
    parisc: Replace regular spinlock with spin_trylock on panic path

Jarkko Nikula <jarkko.nikula@linux.intel.com>
    mfd: intel-lpss: Add Intel Meteor Lake PCH-S LPSS PCI IDs

Qiang Ning <qning0106@126.com>
    mfd: dln2: Fix memory leak in dln2_probe()

Hans de Goede <hdegoede@redhat.com>
    mfd: intel_soc_pmic_chtwc: Add Lenovo Yoga Book X90F to intel_cht_wc_models

Richard Fitzgerald <rf@opensource.cirrus.com>
    soundwire: bus: Fix unbalanced pm_runtime_put() causing usage count underflow

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: qcom: gracefully handle too many ports in DT

Alain Volmat <avolmat@me.com>
    phy: st: miphy28lp: use _poll_timeout functions for waits

Eugene Huang <eugene.huang99@gmail.com>
    soundwire: dmi-quirks: add remapping for Intel 'Rooks County' NUC M15

Hao Zeng <zenghao@kylinos.cn>
    recordmcount: Fix memory leaks in the uwrite function

Josh Poimboeuf <jpoimboe@kernel.org>
    lkdtm/stackleak: Fix noinstr violation

Josh Poimboeuf <jpoimboe@kernel.org>
    sched: Fix KCSAN noinstr violation

Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>
    mcb-pci: Reallocate memory region to avoid memory overlapping

Tony Lindgren <tony@atomide.com>
    serial: 8250: Reinit port->pm on port specific driver unbind

Frank Wang <frank.wang@rock-chips.com>
    usb: typec: tcpm: fix multiple times discover svids error

Jason Gerecke <killertofu@gmail.com>
    HID: wacom: generic: Set battery quirk only when we see battery data

weiliang1503 <weiliang1503@gmail.com>
    HID: Ignore battery for ELAN touchscreen on ROG Flow X13 GV301RA

Alex Henrie <alexhenrie24@gmail.com>
    HID: apple: Set the tilde quirk flag on the Geyser 3

Baishan Jiang <bjiang400@outlook.com>
    ASoC: amd: yc: Add ThinkBook 14 G5+ ARP to quirks list for acp6x

Cem Kaya <cemkaya.boun@gmail.com>
    ASoC: amd: Add Dell G15 5525 to quirks list

Fred Oh <fred.oh@linux.intel.com>
    ALSA: hda: LNL: add HD Audio PCI ID

Samuel Čavoj <samuel@cavoj.net>
    usb: typec: ucsi: acpi: add quirk for ASUS Zenbook UM325

Kevin Groeneveld <kgroeneveld@lenbrook.com>
    spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3

Bastien Nocera <hadess@hadess.net>
    HID: logitech-hidpp: Reconcile USB and Unifying serials

Bastien Nocera <hadess@hadess.net>
    HID: logitech-hidpp: Don't use the USB serial for USB devices

Prajna Sariputra <putr4.s@gmail.com>
    ASoC: amd: yc: Add DMI entries to support HP OMEN 16-n0xxx (8A42)

Khadija Kamran <kamrankhadijadj@gmail.com>
    staging: axis-fifo: initialize timeouts in init only

Alex Henrie <alexhenrie24@gmail.com>
    HID: apple: Set the tilde quirk flag on the Geyser 4 and later

Philipp Hortmann <philipp.g.hortmann@gmail.com>
    staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE

Max Chou <max.chou@realtek.com>
    Bluetooth: btrtl: Add the support for RTL8851B

Min Li <lm0963hack@gmail.com>
    Bluetooth: L2CAP: fix "bad unlock balance" in l2cap_disconnect_rsp

Raul Cheleguini <raul.cheleguini@gmail.com>
    Bluetooth: Add new quirk for broken set random RPA timeout for ATS2851

Hans de Goede <hdegoede@redhat.com>
    Bluetooth: hci_bcm: Fall back to getting bdaddr from EFI if not set

Chethan T N <chethan.tumkur.narayan@intel.com>
    Bluetooth: btintel: Add LE States quirk support

Max Chou <max.chou@realtek.com>
    Bluetooth: btrtl: check for NULL in btrtl_set_quirks()

Raul Cheleguini <rcheleguini@google.com>
    Bluetooth: Improve support for Actions Semi ATS2851 based devices

Vasily Khoruzhick <anarsoul@gmail.com>
    Bluetooth: btrtl: add support for the RTL8723CS

Vasily Khoruzhick <anarsoul@gmail.com>
    Bluetooth: Add new quirk for broken local ext features page 2

Meng Tang <tangmeng@uniontech.com>
    Bluetooth: btusb: Add new PID/VID 04ca:3801 for MT7663

Simon Horman <horms@kernel.org>
    ipvs: Update width of source for ip_vs_sync_conn_options

Zhong Jinghua <zhongjinghua@huawei.com>
    nbd: fix incomplete validation of ioctl arg

Nagarajan Maran <quic_nmaran@quicinc.com>
    wifi: ath11k: Fix SKB corruption in REO destination ring

Hans de Goede <hdegoede@redhat.com>
    wifi: iwlwifi: dvm: Fix memcpy: detected field-spanning write backtrace

Chaitanya Kulkarni <kch@nvidia.com>
    null_blk: Always check queue mode setting from configfs

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: fix iwl_mvm_max_amsdu_size() for MLO

Harshitha Prem <quic_hprem@quicinc.com>
    wifi: ath11k: Ignore frags from uninitialized peer in dp.

Colin Ian King <colin.i.king@gmail.com>
    block, bfq: Fix division by zero error on zero wsum

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: fix ptk_pn memory leak

Hyunwoo Kim <imv4bel@gmail.com>
    wifi: iwlwifi: pcie: Fix integer overflow in iwl_write_to_user_buf

Mukesh Sisodiya <mukesh.sisodiya@intel.com>
    wifi: iwlwifi: add a new PCI device ID for BZ device

Daniel Gabay <daniel.gabay@intel.com>
    wifi: iwlwifi: pcie: fix possible NULL pointer dereference

Yu Kuai <yukuai3@huawei.com>
    md: fix soft lockup in status_resync

Yafang <laoar.shao@gmail.com>
    bpf: Add preempt_count_{sub,add} into btf id deny list

Hao Zeng <zenghao@kylinos.cn>
    samples/bpf: Fix fout leak in hbm's run_bpf_prog

Chao Yu <chao@kernel.org>
    f2fs: fix to check readonly condition correctly

Chao Yu <chao@kernel.org>
    f2fs: fix to drop all dirty pages during umount() if cp_error is set

Yonggil Song <yonggil.song@samsung.com>
    f2fs: Fix system crash due to lack of free space in LFS

Stephan Müller <smueller@chronox.de>
    crypto: jitter - permanent and intermittent health errors

Ojaswin Mujoo <ojaswin@linux.ibm.com>
    ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: set goal start correctly in ext4_mb_normalize_request

Adrian Hunter <adrian.hunter@intel.com>
    scsi: ufs: ufs-pci: Add support for Intel Lunar Lake

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fix inode height consistency check

Zheng Wang <zyytlz.wz@163.com>
    scsi: message: mptlan: Fix use after free bug in mptlan_remove() due to race condition

Eli Cohen <elic@nvidia.com>
    lib: cpu_rmap: Avoid use after free on rmap->obj array entries

Dmitry Bogdanov <d.bogdanov@yadro.com>
    scsi: target: iscsit: Free cmds before session free

Nick Child <nnac123@linux.ibm.com>
    netdev: Enforce index cap in netdev_get_tx_queue

Nick Child <nnac123@linux.ibm.com>
    net: Catch invalid index in XPS mapping

Nathan Chancellor <nathan@kernel.org>
    net: pasemi: Fix return type of pasemi_mac_start_tx()

Maxim Korotkov <korotkov.maxim.s@gmail.com>
    bnxt: avoid overflow in bnxt_get_nvram_directory()

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Correct used_rpi count when devloss tmo fires with no recovery

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Prevent lpfc_debugfs_lockstat_write() buffer overflow

Jan Kara <jack@suse.cz>
    ext2: Check block size validity during mount

Hector Martin <marcan@marcan.st>
    wifi: brcmfmac: cfg80211: Pass the PMK in binary instead of hex

Hector Martin <marcan@marcan.st>
    wifi: brcmfmac: pcie: Provide a buffer of random bytes to the device

Kumar Kartikeya Dwivedi <memxor@gmail.com>
    bpf: Annotate data races in bpf_local_storage

Kees Cook <keescook@chromium.org>
    wifi: ath: Silence memcpy run-time false positive warning

Wei Chen <harperchen1110@gmail.com>
    media: mediatek: vcodec: Fix potential array out-of-bounds in decoder queue_setup

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: Prefer designated initializers over memset for subdev pad ops

lyndonli <Lyndon.Li@amd.com>
    drm/amdgpu: Fix sdma v4 sw fini error

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix an out of bounds error in BIOS parser

Paul Hsieh <Paul.Hsieh@amd.com>
    drm/amd/display: Correct DML calculation to follow HW SPEC

Hans de Goede <hdegoede@redhat.com>
    ACPI: video: Remove desktops without backlight DMI quirks

Shanker Donthineni <sdonthineni@nvidia.com>
    irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sdm845-polaris: Drop inexistent properties

void0red <30990023+void0red@users.noreply.github.com>
    ACPICA: ACPICA: check null return of ACPI_ALLOCATE_ZEROED in acpi_db_display_objects

Tamir Duberstein <tamird@google.com>
    ACPICA: Avoid undefined behavior: applying zero offset to null pointer

Douglas Anderson <dianders@chromium.org>
    drm/msm/dp: Clean up handling of DP AUX interrupts

Nur Hussein <hussein@unixcat.org>
    drm/tegra: Avoid potential 32-bit integer overflow

Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
    remoteproc: stm32_rproc: Add mutex protection for workqueue

Ayush Gupta <ayugupta@amd.com>
    drm/amd/display: fixed dcn30+ underflow issue

Armin Wolf <W_Armin@gmx.de>
    ACPI: EC: Fix oops when removing custom query handlers

Pierre Gondois <pierre.gondois@arm.com>
    firmware: arm_sdei: Fix sleep from invalid context BUG

Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
    arm64: dts: imx8mq-librem5: Remove dis_u3_susphy_quirk from usb_dwc3_0

Zheng Wang <zyytlz.wz@163.com>
    memstick: r592: Fix UAF bug in r592_remove due to race condition

Toby Chen <tobyc@nvidia.com>
    drm/rockchip: dw_hdmi: cleanup drm encoder during unbind

Kang Chen <void0red@gmail.com>
    ACPI: processor: Check for null return of devm_kzalloc() in fch_misc_setup()

Tom Rix <trix@redhat.com>
    media: pvrusb2: VIDEO_PVRUSB2 depends on DVB_CORE to use dvb_* symbols

harperchen <harperchen1110@gmail.com>
    media: pci: tw68: Fix null-ptr-deref bug in buf prepare and finish

harperchen <harperchen1110@gmail.com>
    media: cx23885: Fix a null-ptr-deref bug in buffer_prepare() and buffer_finish()

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: msm8996: Add missing DWC3 quirks

Iuliana Prodan <iuliana.prodan@nxp.com>
    remoteproc: imx_dsp_rproc: Add custom memory copy implementation for i.MX DSP Cores

Alexander Stein <alexander.stein@ew.tq-group.com>
    regmap: cache: Return error in cache sync operations for REGCACHE_NONE

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Use DC_LOG_DC in the trasform pixel function

Gabe Teeger <gabe.teeger@amd.com>
    drm/amd/display: Enable HostVM based on rIOMMU active

Hans de Goede <hdegoede@redhat.com>
    platform/x86: x86-android-tablets: Add Acer Iconia One 7 B1-750 data

Paul Hsieh <Paul.Hsieh@amd.com>
    drm/amd/display: Correct DML calculation to align HW formula

Ayush Gupta <ayush.gupta@amd.com>
    drm/amd/display: populate subvp cmd info only for the top pipe

Jani Nikula <jani.nikula@intel.com>
    drm/displayid: add displayid_get_header() and check bounds better

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fs: hfsplus: remove WARN_ON() from hfsplus_cat_{read,write}_inode()

Christian Brauner <brauner@kernel.org>
    open: return EINVAL for O_DIRECTORY | O_CREAT

Zqiang <qiang1.zhang@intel.com>
    rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access

Ivan Orlov <ivan.orlov0322@gmail.com>
    selftests: cgroup: Add 'malloc' failures checks in test_memcontrol

Paul E. McKenney <paulmck@kernel.org>
    refscale: Move shutdown from wait_event() to wait_event_idle()

Theodore Ts'o <tytso@mit.edu>
    ext4: allow ext4_get_group_info() to fail

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: allow to find by goal if EXT4_MB_HINT_GOAL_ONLY is set

Theodore Ts'o <tytso@mit.edu>
    ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled

Theodore Ts'o <tytso@mit.edu>
    ext4: reflect error codes from ext4_multi_mount_protect() to its callers

Zongjie Li <u202112089@hust.edu.cn>
    fbdev: arcfb: Fix error handling in arcfb_probe()

Jani Nikula <jani.nikula@intel.com>
    drm/i915: taint kernel when force probing unsupported devices

Rodrigo Vivi <rodrigo.vivi@intel.com>
    drm/i915: Expand force_probe to block probe of devices as well.

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    drm/i915/dp: prevent potential div-by-zero

Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
    drm/i915: Fix NULL ptr deref by checking new_crtc_state

John Harrison <John.C.Harrison@Intel.com>
    drm/i915/guc: Don't capture Gen8 regs on Xe devices

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix data races around sk->sk_shutdown.

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix a data race of sk->sk_receive_queue->qlen.

Eric Dumazet <edumazet@google.com>
    net: datagram: fix data-races in datagram_poll()

Colin Foster <colin.foster@in-advantage.com>
    net: mscc: ocelot: fix stat counter register values

t.feng <fengtao40@huawei.com>
    ipvlan:Fix out-of-bounds caused by unclear skb->cb

Ziwei Xiao <ziweixiao@google.com>
    gve: Remove the code of clearing PBA bit

Eric Dumazet <edumazet@google.com>
    tcp: add annotations around sk->sk_shutdown accesses

Eric Dumazet <edumazet@google.com>
    net: add vlan_get_protocol_and_depth() helper

Eric Dumazet <edumazet@google.com>
    net: deal with most data-races in sk_wait_event()

Eric Dumazet <edumazet@google.com>
    net: annotate sk->sk_err write from do_recvmmsg()

Eric Dumazet <edumazet@google.com>
    netlink: annotate accesses to nlk->cb_running

Hangbin Liu <liuhangbin@gmail.com>
    bonding: fix send_peer_notif overflow

Florian Westphal <fw@strlen.de>
    netfilter: conntrack: fix possible bug_on with enable_hooks=1

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: always release netdev hooks from notifier

Florian Fainelli <f.fainelli@gmail.com>
    net: phy: bcm7xx: Correct read from expansion register

Kuniyuki Iwashima <kuniyu@amazon.com>
    net: Fix load-tearing on sk->sk_stamp in sock_recv_cmsgs().

Marek Vasut <marex@denx.de>
    net: stmmac: Initialize MAC_ONEUS_TIC_COUNTER register

Roy Novich <royno@nvidia.com>
    linux/dim: Do nothing if no time delta between samples

Thomas Gleixner <tglx@linutronix.de>
    tick/broadcast: Make broadcast device replacement work correctly

Keoseong Park <keosung.park@samsung.com>
    scsi: ufs: core: Fix I/O hang that occurs when BKOPS fails in W-LUN suspend

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    net: mdio: mvusb: Fix an error handling path in mvusb_mdio_probe()

Eric Dumazet <edumazet@google.com>
    net: skb_partial_csum_set() fix against transport header magic value

Randy Dunlap <rdunlap@infradead.org>
    ARM: 9296/1: HP Jornada 7XX: fix kernel-doc warnings

Saravana Kannan <saravanak@google.com>
    drm/mipi-dsi: Set the fwnode for mipi_dsi_device

Sui Jingfeng <suijingfeng@loongson.cn>
    drm/fbdev-generic: prohibit potential out-of-bounds access


-------------

Diffstat:

 Documentation/arm64/silicon-errata.rst             |   2 +
 .../devicetree/bindings/ata/ceva,ahci-1v84.yaml    |   2 +-
 .../bindings/display/msm/dsi-controller-main.yaml  |  12 +
 MAINTAINERS                                        |   4 +-
 Makefile                                           |   4 +-
 arch/arm/mach-sa1100/jornada720_ssp.c              |   5 +-
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi  |   1 -
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   3 +
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts |   2 -
 arch/arm64/kernel/mte.c                            |   7 +-
 arch/parisc/include/asm/pdc.h                      |   1 +
 arch/parisc/kernel/firmware.c                      |  27 +-
 arch/powerpc/kernel/dma-iommu.c                    |   4 +-
 arch/powerpc/kernel/iommu.c                        |  11 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c           |   4 +-
 arch/powerpc/platforms/pseries/iommu.c             |  13 +-
 arch/riscv/kernel/probes/Makefile                  |   2 +
 arch/s390/crypto/chacha-glue.c                     |   2 +-
 arch/s390/kernel/Makefile                          |   1 +
 arch/x86/kernel/Makefile                           |   1 +
 block/bfq-iosched.c                                |   2 +
 crypto/jitterentropy-kcapi.c                       |  51 ++--
 crypto/jitterentropy.c                             | 144 ++++------
 crypto/jitterentropy.h                             |   1 -
 crypto/testmgr.c                                   | 266 +++++++++++-------
 drivers/acpi/acpi_apd.c                            |   2 +
 drivers/acpi/acpica/dbnames.c                      |   3 +
 drivers/acpi/acpica/dswstate.c                     |  11 +-
 drivers/acpi/ec.c                                  |   1 +
 drivers/acpi/video_detect.c                        |  35 ---
 drivers/base/platform.c                            |   4 +-
 drivers/base/regmap/regcache.c                     |   6 +
 drivers/block/nbd.c                                |   6 +
 drivers/block/null_blk/main.c                      |   5 +
 drivers/bluetooth/btbcm.c                          |  47 +++-
 drivers/bluetooth/btintel.c                        |   5 +-
 drivers/bluetooth/btrtl.c                          | 138 +++++++++-
 drivers/bluetooth/btrtl.h                          |   5 +
 drivers/bluetooth/btusb.c                          |   6 +
 drivers/bluetooth/hci_h5.c                         |   4 +
 drivers/char/tpm/tpm_tis.c                         |  16 ++
 drivers/firmware/arm_sdei.c                        |  37 +--
 drivers/firmware/smccc/smccc.c                     |  26 ++
 drivers/firmware/smccc/soc_id.c                    |  28 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  26 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  36 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |  21 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   7 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   2 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   7 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |   5 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |   2 +-
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |   2 +-
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c | 300 ++++++++++++++-------
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |   4 +
 .../display/dc/dml/dcn314/display_mode_vba_314.c   | 300 ++++++++++++++-------
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  18 ++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  20 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   1 +
 drivers/gpu/drm/drm_displayid.c                    |  17 +-
 drivers/gpu/drm/drm_fb_helper.c                    |  16 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.h            |   4 +-
 drivers/gpu/drm/i915/Kconfig                       |  25 +-
 drivers/gpu/drm/i915/display/intel_atomic_plane.c  |   4 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   5 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c     |   7 +-
 drivers/gpu/drm/i915/i915_params.c                 |   2 +-
 drivers/gpu/drm/i915/i915_pci.c                    |  39 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |   5 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c          |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h           |   3 -
 drivers/gpu/drm/msm/dp/dp_audio.c                  |  12 +
 drivers/gpu/drm/msm/dp/dp_audio.h                  |   2 +
 drivers/gpu/drm/msm/dp/dp_aux.c                    |  80 +++---
 drivers/gpu/drm/msm/dp/dp_catalog.c                |   2 +-
 drivers/gpu/drm/msm/dp/dp_catalog.h                |   2 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |   1 +
 drivers/gpu/drm/msm/msm_gem_submit.c               |  25 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |   1 +
 drivers/gpu/drm/tegra/sor.c                        |   2 +-
 drivers/hid/hid-apple.c                            |  19 +-
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-input.c                            |   2 +
 drivers/hid/hid-logitech-hidpp.c                   |  53 +++-
 drivers/hid/wacom_wac.c                            |  33 +--
 drivers/irqchip/Kconfig                            |   1 +
 drivers/irqchip/irq-gic-v3.c                       | 115 +++++++-
 drivers/mcb/mcb-pci.c                              |  27 +-
 drivers/md/md.c                                    |  18 +-
 drivers/media/pci/cx23885/cx23885-core.c           |   4 +-
 drivers/media/pci/cx23885/cx23885-video.c          |  13 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c |   2 +-
 drivers/media/pci/tw68/tw68-video.c                |  16 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c      |   7 +
 drivers/media/platform/renesas/vsp1/vsp1_drm.c     |  18 +-
 drivers/media/platform/renesas/vsp1/vsp1_entity.c  |  11 +-
 .../platform/samsung/exynos4-is/fimc-capture.c     |   7 +-
 drivers/media/platform/ti/am437x/am437x-vpfe.c     |  15 +-
 drivers/media/platform/ti/cal/cal-video.c          |   8 +-
 drivers/media/usb/dvb-usb/cxusb-analog.c           |  14 +-
 drivers/media/usb/pvrusb2/Kconfig                  |   2 +-
 drivers/memstick/host/r592.c                       |   2 +-
 drivers/message/fusion/mptlan.c                    |   2 +
 drivers/mfd/dln2.c                                 |   1 +
 drivers/mfd/intel-lpss-pci.c                       |  15 ++
 drivers/mfd/intel_soc_pmic_chtwc.c                 |  14 +-
 drivers/misc/lkdtm/stackleak.c                     |   6 +
 drivers/net/bonding/bond_netlink.c                 |   7 +-
 drivers/net/bonding/bond_options.c                 |   8 +-
 drivers/net/can/dev/skb.c                          |   3 +-
 drivers/net/can/kvaser_pciefd.c                    |  51 ++--
 drivers/net/dsa/mv88e6xxx/port.h                   |   2 +-
 drivers/net/dsa/rzn1_a5psw.c                       |  83 ++++--
 drivers/net/dsa/rzn1_a5psw.h                       |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   9 +-
 drivers/net/ethernet/freescale/fec_main.c          |  15 +-
 drivers/net/ethernet/google/gve/gve_main.c         |  13 -
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.c    |  25 +-
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.h    |   8 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h |   1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  15 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   4 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   5 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |  24 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |  31 ++-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |   6 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |   1 +
 drivers/net/ethernet/intel/igb/e1000_mac.c         |   4 +-
 drivers/net/ethernet/mscc/vsc7514_regs.c           |  18 +-
 drivers/net/ethernet/pasemi/pasemi_mac.c           |   2 +-
 drivers/net/ethernet/sfc/ef100_netdev.c            |   4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   5 +
 drivers/net/ethernet/sun/cassini.c                 |   2 +
 drivers/net/ipvlan/ipvlan_core.c                   |   6 +
 drivers/net/mdio/mdio-mvusb.c                      |  11 +-
 drivers/net/pcs/pcs-xpcs.c                         |   2 +-
 drivers/net/phy/bcm-phy-lib.h                      |   5 +
 drivers/net/phy/bcm7xxx.c                          |   2 +-
 drivers/net/phy/dp83867.c                          |  22 +-
 drivers/net/tap.c                                  |   4 +-
 drivers/net/tun.c                                  |  80 +++---
 drivers/net/virtio_net.c                           |  61 +++--
 drivers/net/wireless/ath/ath.h                     |  12 +-
 drivers/net/wireless/ath/ath11k/dp.c               |   4 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |  17 +-
 drivers/net/wireless/ath/ath11k/peer.h             |   1 +
 drivers/net/wireless/ath/key.c                     |   2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  13 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  32 +++
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c       |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |  10 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  37 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   4 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt76_connac2_mac.h  |   2 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   3 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |   2 +-
 drivers/net/wireless/realtek/rtw88/main.c          |  15 ++
 drivers/net/wireless/realtek/rtw88/main.h          |   3 +
 drivers/net/wwan/iosm/iosm_ipc_imem.c              |  27 +-
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.c          |  12 +-
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.h          |   6 +-
 drivers/parisc/power.c                             |  16 +-
 drivers/phy/st/phy-miphy28lp.c                     |  42 +--
 drivers/platform/x86/Kconfig                       |  43 +--
 drivers/platform/x86/Makefile                      |   4 +-
 drivers/platform/x86/hp/Kconfig                    |  63 +++++
 drivers/platform/x86/hp/Makefile                   |  10 +
 drivers/platform/x86/{ => hp}/hp-wmi.c             |   1 +
 drivers/platform/x86/{ => hp}/hp_accel.c           |   2 +-
 drivers/platform/x86/{ => hp}/tc1100-wmi.c         |   0
 drivers/platform/x86/x86-android-tablets.c         | 101 ++++++-
 drivers/remoteproc/imx_dsp_rproc.c                 | 187 ++++++++++++-
 drivers/remoteproc/stm32_rproc.c                   |   8 +
 drivers/s390/block/dasd_eckd.c                     |  33 ++-
 drivers/s390/cio/device.c                          |   2 +
 drivers/s390/cio/qdio.h                            |   2 +-
 drivers/scsi/lpfc/lpfc_debugfs.c                   |   7 +-
 drivers/scsi/lpfc/lpfc_els.c                       |  24 +-
 drivers/scsi/storvsc_drv.c                         |   8 +-
 drivers/soundwire/bus.c                            |  15 +-
 drivers/soundwire/dmi-quirks.c                     |  25 ++
 drivers/soundwire/qcom.c                           |   3 +
 drivers/spi/spi-imx.c                              |  24 +-
 drivers/staging/axis-fifo/axis-fifo.c              |  28 +-
 drivers/staging/media/imx/imx-media-capture.c      |  12 +-
 drivers/staging/media/imx/imx-media-utils.c        |   8 +-
 drivers/staging/media/omap4iss/iss_video.c         |   6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |   5 -
 drivers/target/iscsi/iscsi_target.c                |   6 +-
 drivers/thunderbolt/nhi.c                          |  29 +-
 drivers/thunderbolt/nhi_regs.h                     |   2 +
 drivers/tty/serial/8250/8250_bcm7271.c             |   7 +-
 drivers/tty/serial/8250/8250_core.c                |   1 +
 drivers/tty/serial/8250/8250_exar.c                |  17 ++
 drivers/tty/serial/8250/8250_pci.c                 |   5 +
 drivers/tty/serial/arc_uart.c                      |   7 +-
 drivers/tty/serial/qcom_geni_serial.c              |   9 +-
 drivers/tty/vt/vc_screen.c                         |  11 +-
 drivers/ufs/core/ufshcd.c                          |  10 +-
 drivers/ufs/host/ufshcd-pci.c                      |   1 +
 drivers/usb/class/usbtmc.c                         |   2 +
 drivers/usb/dwc3/debugfs.c                         | 109 ++++++++
 drivers/usb/dwc3/gadget.c                          |  67 ++---
 drivers/usb/gadget/function/u_ether.c              |   3 +
 drivers/usb/gadget/udc/core.c                      | 151 +++--------
 drivers/usb/host/uhci-pci.c                        |  10 +-
 drivers/usb/host/xhci-pci.c                        |  12 +-
 drivers/usb/host/xhci-ring.c                       |  29 +-
 drivers/usb/host/xhci.h                            |   2 +-
 drivers/usb/storage/scsiglue.c                     |  28 +-
 drivers/usb/typec/altmodes/displayport.c           |   4 +
 drivers/usb/typec/tcpm/tcpm.c                      |  16 +-
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |  44 ++-
 drivers/video/fbdev/arcfb.c                        |  15 +-
 fs/ceph/snap.c                                     |  13 +
 fs/cifs/cifsglob.h                                 |   4 +-
 fs/cifs/file.c                                     |  26 +-
 fs/cifs/smb1ops.c                                  |   9 +-
 fs/cifs/smb2ops.c                                  |   7 +-
 fs/ext2/ext2.h                                     |   1 +
 fs/ext2/super.c                                    |   7 +
 fs/ext4/balloc.c                                   |  18 +-
 fs/ext4/ext4.h                                     |  15 +-
 fs/ext4/ialloc.c                                   |  12 +-
 fs/ext4/mballoc.c                                  | 131 ++++++---
 fs/ext4/mmp.c                                      |   9 +-
 fs/ext4/super.c                                    |  24 +-
 fs/f2fs/checkpoint.c                               |  12 +-
 fs/f2fs/data.c                                     |   3 +-
 fs/f2fs/f2fs.h                                     |   5 +
 fs/f2fs/gc.c                                       |  10 +-
 fs/f2fs/gc.h                                       |   2 +
 fs/f2fs/segment.h                                  |  39 ++-
 fs/f2fs/super.c                                    |   2 +-
 fs/gfs2/glops.c                                    |   3 +-
 fs/hfsplus/inode.c                                 |  28 +-
 fs/ksmbd/connection.c                              |   3 +-
 fs/ksmbd/oplock.c                                  |   5 +-
 fs/ksmbd/oplock.h                                  |   2 +-
 fs/ksmbd/smb2misc.c                                |   5 +-
 fs/ksmbd/smb2pdu.c                                 |  19 +-
 fs/nilfs2/inode.c                                  |  18 ++
 fs/open.c                                          |  18 +-
 fs/statfs.c                                        |   4 +-
 include/linux/arm-smccc.h                          |  18 ++
 include/linux/cpuhotplug.h                         |   1 -
 include/linux/dim.h                                |   3 +-
 include/linux/if_vlan.h                            |  17 ++
 include/linux/netdevice.h                          |   1 +
 include/linux/platform_device.h                    |  11 +
 include/linux/sched/task_stack.h                   |   2 +-
 include/linux/sunrpc/svc_rdma.h                    |   2 +-
 include/linux/sunrpc/svc_xprt.h                    |   2 +-
 include/net/bluetooth/hci.h                        |  15 ++
 include/net/bonding.h                              |   2 +-
 include/net/ip_vs.h                                |   6 +-
 include/net/sock.h                                 |   2 +-
 include/uapi/asm-generic/fcntl.h                   |   1 -
 kernel/bpf/bpf_local_storage.c                     |  16 +-
 kernel/bpf/verifier.c                              |   4 +
 kernel/rcu/refscale.c                              |   2 +-
 kernel/rcu/tree_exp.h                              |   6 +-
 kernel/time/tick-broadcast.c                       | 120 ++++++---
 kernel/trace/rethook.c                             |   4 +-
 lib/cpu_rmap.c                                     |   5 +-
 lib/dim/dim.c                                      |   5 +-
 lib/dim/net_dim.c                                  |   3 +-
 lib/dim/rdma_dim.c                                 |   3 +-
 lib/maple_tree.c                                   |  12 +-
 mm/zswap.c                                         |  16 ++
 net/8021q/vlan_dev.c                               |   4 +-
 net/bluetooth/hci_event.c                          |   9 +-
 net/bluetooth/hci_sync.c                           |   6 +-
 net/bluetooth/l2cap_core.c                         |   1 -
 net/bridge/br_forward.c                            |   2 +-
 net/bridge/br_private_tunnel.h                     |   8 +-
 net/can/isotp.c                                    |   2 +-
 net/can/j1939/socket.c                             |   2 +-
 net/core/datagram.c                                |  15 +-
 net/core/dev.c                                     |   4 +-
 net/core/skbuff.c                                  |   4 +-
 net/core/stream.c                                  |  12 +-
 net/ipv4/af_inet.c                                 |   2 +-
 net/ipv4/tcp.c                                     |  14 +-
 net/ipv4/tcp_bpf.c                                 |   2 +-
 net/ipv4/tcp_input.c                               |   4 +-
 net/ipv4/tcp_ipv4.c                                |   5 +-
 net/ipv6/ip6_gre.c                                 |  13 +-
 net/key/af_key.c                                   |  12 +-
 net/llc/af_llc.c                                   |   8 +-
 net/mac80211/cfg.c                                 |   3 +-
 net/mac80211/trace.h                               |   2 +-
 net/mac80211/tx.c                                  |   5 +-
 net/netfilter/core.c                               |   6 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |   2 +-
 net/netfilter/nf_conntrack_standalone.c            |   3 +-
 net/netfilter/nf_tables_api.c                      |   4 +-
 net/netfilter/nft_chain_filter.c                   |   9 +-
 net/netfilter/nft_set_rbtree.c                     |  20 +-
 net/netlink/af_netlink.c                           |   8 +-
 net/nsh/nsh.c                                      |   8 +-
 net/packet/af_packet.c                             |   6 +-
 net/smc/smc_close.c                                |   4 +-
 net/smc/smc_rx.c                                   |   4 +-
 net/smc/smc_tx.c                                   |   4 +-
 net/socket.c                                       |   2 +-
 net/sunrpc/svc.c                                   |   2 +-
 net/sunrpc/svc_xprt.c                              |  24 +-
 net/sunrpc/svcsock.c                               |  30 ++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c            |  11 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c           |   2 +-
 net/tipc/bearer.c                                  |  17 +-
 net/tipc/bearer.h                                  |   3 +
 net/tipc/link.c                                    |   9 +-
 net/tipc/socket.c                                  |   4 +-
 net/tipc/udp_media.c                               |   5 +-
 net/tls/tls_main.c                                 |   3 +-
 net/unix/af_unix.c                                 |  22 +-
 net/vmw_vsock/af_vsock.c                           |   2 +-
 net/wireless/scan.c                                |   6 +-
 net/xfrm/xfrm_interface.c                          |  54 +---
 net/xfrm/xfrm_policy.c                             |   9 -
 net/xfrm/xfrm_user.c                               |  14 +-
 samples/bpf/hbm.c                                  |   1 +
 scripts/recordmcount.c                             |   6 +-
 sound/firewire/digi00x/digi00x-stream.c            |   4 +-
 sound/pci/hda/hda_generic.c                        |   7 +-
 sound/pci/hda/hda_intel.c                          |   3 +
 sound/pci/hda/patch_hdmi.c                         |   5 +
 sound/pci/hda/patch_realtek.c                      |  14 +-
 sound/soc/amd/yc/acp6x-mach.c                      |  21 ++
 sound/soc/fsl/fsl_micfil.c                         |  14 +-
 sound/soc/mediatek/mt8186/mt8186-afe-clk.c         |   6 -
 sound/soc/mediatek/mt8186/mt8186-afe-clk.h         |   1 -
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c         |   4 -
 sound/soc/mediatek/mt8186/mt8186-audsys-clk.c      |  46 ++--
 sound/soc/mediatek/mt8186/mt8186-audsys-clk.h      |   1 -
 sound/soc/sof/topology.c                           |   4 +
 sound/usb/format.c                                 |   1 +
 tools/include/uapi/asm-generic/fcntl.h             |   1 -
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |  31 +--
 tools/testing/selftests/cgroup/test_memcontrol.c   |  15 ++
 tools/testing/selftests/net/fib_nexthops.sh        |   2 +-
 .../selftests/net/srv6_end_dt4_l3vpn_test.sh       |  17 +-
 virt/kvm/kvm_main.c                                |  16 +-
 365 files changed, 4070 insertions(+), 1817 deletions(-)


