Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E939A70C5F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjEVTNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjEVTNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:13:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6783AB0;
        Mon, 22 May 2023 12:13:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E307861F18;
        Mon, 22 May 2023 19:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E82C4339B;
        Mon, 22 May 2023 19:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684782820;
        bh=M/IXOX/s7YN9GJCuUndV7tzueVZqCpuiiOTmTMW2Wa8=;
        h=From:To:Cc:Subject:Date:From;
        b=ND6ZWb/0OBR6wHoGp8Pr47+YriSQRB9Y1aa5jdZ5sJYxVzVKupiNFqpKmagzIVuEx
         8TYWdSbg6i6bR837K4rgkArM9PPoe3V3QC7pbhJPOG64yQWGsOLw/EqmuNtXvtfVEw
         y8U1unED5kIlkkBlRkw22QIoPJykEHDHmdU7ZM1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.15 000/203] 5.15.113-rc1 review
Date:   Mon, 22 May 2023 20:07:04 +0100
Message-Id: <20230522190354.935300867@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.113-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.113-rc1
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

This is the start of the stable review cycle for the 5.15.113 release.
There are 203 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.113-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.113-rc1

Ping Cheng <pinglinux@gmail.com>
    HID: wacom: add three styli to wacom_intuos_get_tool_type

Ping Cheng <pinglinux@gmail.com>
    HID: wacom: Add new Intuos Pro Small (PTH-460) device IDs

Jason Gerecke <killertofu@gmail.com>
    HID: wacom: Force pen out of prox if no events have been received in a while

Heiko Carstens <hca@linux.ibm.com>
    s390/qdio: fix do_sqbs() inline assembly constraint

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix use-after-free bug of nilfs_root in nilfs_evict_inode()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s/radix: Fix soft dirty tracking

Jerry Snitselaar <jsnitsel@redhat.com>
    tpm/tpm_tis: Disable interrupts for more Lenovo devices

Gaurav Batra <gbatra@linux.vnet.ibm.com>
    powerpc/iommu: Incorrect DDW Table is referenced for SR-IOV device

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

Ilya Leoshkevich <iii@linux.ibm.com>
    statfs: enforce statfs[64] structure initialization

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

Badhri Jagan Sridharan <badhri@google.com>
    usb: typec: altmodes/displayport: fix pin_assignment_show

Konrad Gräfe <k.graefe@gateware.de>
    usb: gadget: u_ether: Fix host MAC address case

Udipto Goswami <quic_ugoswami@quicinc.com>
    usb: dwc3: debugfs: Resume dwc3 before accessing registers

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

Eric Dumazet <edumazet@google.com>
    vlan: fix a potential uninit-value in vlan_dev_hard_start_xmit()

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    igb: fix bit_shift to be in [1..8] range

Marco Migliore <m.migliore@tiesse.com>
    net: dsa: mv88e6xxx: Fix mv88e6393x EPC write command offset

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    cassini: Fix a memory leak in the error handling path of cas_init_one()

Michael Kelley <mikelley@microsoft.com>
    scsi: storvsc: Don't pass unused PFNs to Hyper-V host

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: don't trust firmware n_channels

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: fix cancel_delayed_work_sync() deadlock

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix min center freq offset tracing

Florian Fainelli <f.fainelli@gmail.com>
    net: bcmgenet: Restore phy_stop() depending upon suspend/close

Florian Fainelli <f.fainelli@gmail.com>
    net: bcmgenet: Remove phy_stop() from bcmgenet_netif_stop()

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

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Fix trace_svc_register() call site

NeilBrown <neilb@suse.de>
    SUNRPC: always free ctxt when freeing deferred request

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Remove svc_rqst::rq_xprt_hlen

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Remove dead code in svc_tcp_release_rqst()

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Clean up svc_deferred_class trace events

Chuck Lever <chuck.lever@oracle.com>
    tracing: Introduce helpers to safely handle dynamic-sized sockaddrs

NeilBrown <neilb@suse.de>
    SUNRPC: double free xprt_ctxt while still in use

Duoming Zhou <duoming@zju.edu.cn>
    media: netup_unidvb: fix use-after-free at del_timer()

Jie Wang <wangjie125@huawei.com>
    net: hns3: fix reset delay time to avoid configuration timeout

Jijie Shao <shaojijie@huawei.com>
    net: hns3: fix sending pfc frames after reset issue

Jie Wang <wangjie125@huawei.com>
    net: hns3: fix output information incomplete for dumping tx queue info with debugfs

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

Ryan C. Underwood <nemesis@icequake.net>
    ALSA: hda/realtek: Apply HP B&O top speaker profile to Pavilion 15

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

Tobias Brunner <tobias@strongswan.org>
    af_key: Reject optional tunnel/BEET mode templates in outbound policies

Wyes Karny <wyes.karny@amd.com>
    cpupower: Make TSC read per CPU for Mperf monitor

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_micfil: Fix error handler with pm_runtime_enable

Jianhua Lu <lujianhua000@gmail.com>
    dt-bindings: display/msm: dsi-controller-main: Document qcom, master-dsi and qcom, sync-dual-dsi

Marijn Suijten <marijn.suijten@somainline.org>
    drm/msm/dpu: Remove duplicate register defines from INTF

Marijn Suijten <marijn.suijten@somainline.org>
    drm/msm/dpu: Move non-MDP_TOP INTF_INTR offsets out of hwio header

Bjorn Andersson <bjorn.andersson@linaro.org>
    drm/msm/dpu: Add INTF_5 interrupts

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    drm/msm/dp: unregister audio driver during unbind

Martin Willi <martin@strongswan.org>
    Revert "Fix XFRM-I support for nested ESP tunnels"

Sabrina Dubroca <sd@queasysnail.net>
    xfrm: don't check the default policy if the policy allows the packet

Fae <faenkhauser@gmail.com>
    platform/x86: hp-wmi: add micmute to hp_wmi_keymap struct

Jorge Lopez <jorge.lopez2@hp.com>
    platform/x86: Move existing HP drivers to a new hp subdir

Daniel Houldsworth <dhould3@gmail.com>
    platform/x86: hp-wmi: Support touchpad on/off

Guilherme G. Piccoli <gpiccoli@igalia.com>
    parisc: Replace regular spinlock with spin_trylock on panic path

Qiang Ning <qning0106@126.com>
    mfd: dln2: Fix memory leak in dln2_probe()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: qcom: gracefully handle too many ports in DT

Alain Volmat <avolmat@me.com>
    phy: st: miphy28lp: use _poll_timeout functions for waits

Vicki Pfau <vi@endrift.com>
    Input: xpad - add constants for GIP interface numbers

Chunyan Zhang <chunyan.zhang@unisoc.com>
    iommu/sprd: Release dma buffer to avoid memory leak

Tomas Krcka <krckatom@amazon.de>
    iommu/arm-smmu-v3: Acknowledge pri/event queue overflow if any

Arnd Bergmann <arnd@arndb.de>
    clk: tegra20: fix gcc-7 constant overflow warning

Jia-Ju Bai <baijiaju1990@gmail.com>
    fs/ntfs3: Fix a possible null-pointer dereference in ni_clear()

Edward Lo <edward.lo@ambergroup.io>
    fs/ntfs3: Add length check in indx_get_root

Edward Lo <edward.lo@ambergroup.io>
    fs/ntfs3: Validate MFT flags before replaying logs

Abdun Nihaal <abdun.nihaal@gmail.com>
    fs/ntfs3: Fix NULL dereference in ni_write_inode

Edward Lo <edward.lo@ambergroup.io>
    fs/ntfs3: Enhance the attribute size check

Ye Bin <yebin10@huawei.com>
    fs/ntfs3: Fix NULL pointer dereference in 'ni_write_inode'

Manivannan Sadhasivam <mani@kernel.org>
    iommu/arm-smmu-qcom: Limit the SMR groups to 128

Gustavo A. R. Silva <gustavoars@kernel.org>
    RDMA/core: Fix multiple -Warray-bounds warnings

Hao Zeng <zenghao@kylinos.cn>
    recordmcount: Fix memory leaks in the uwrite function

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

Kevin Groeneveld <kgroeneveld@lenbrook.com>
    spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3

Bastien Nocera <hadess@hadess.net>
    HID: logitech-hidpp: Reconcile USB and Unifying serials

Bastien Nocera <hadess@hadess.net>
    HID: logitech-hidpp: Don't use the USB serial for USB devices

Philipp Hortmann <philipp.g.hortmann@gmail.com>
    staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE

Min Li <lm0963hack@gmail.com>
    Bluetooth: L2CAP: fix "bad unlock balance" in l2cap_disconnect_rsp

Hans de Goede <hdegoede@redhat.com>
    Bluetooth: hci_bcm: Fall back to getting bdaddr from EFI if not set

Chethan T N <chethan.tumkur.narayan@intel.com>
    Bluetooth: btintel: Add LE States quirk support

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

Hyunwoo Kim <imv4bel@gmail.com>
    wifi: iwlwifi: pcie: Fix integer overflow in iwl_write_to_user_buf

Daniel Gabay <daniel.gabay@intel.com>
    wifi: iwlwifi: pcie: fix possible NULL pointer dereference

Yafang <laoar.shao@gmail.com>
    bpf: Add preempt_count_{sub,add} into btf id deny list

Hao Zeng <zenghao@kylinos.cn>
    samples/bpf: Fix fout leak in hbm's run_bpf_prog

Chao Yu <chao@kernel.org>
    f2fs: fix to check readonly condition correctly

Chao Yu <chao@kernel.org>
    f2fs: fix to drop all dirty pages during umount() if cp_error is set

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
    net: Catch invalid index in XPS mapping

Nathan Chancellor <nathan@kernel.org>
    net: pasemi: Fix return type of pasemi_mac_start_tx()

Maxim Korotkov <korotkov.maxim.s@gmail.com>
    bnxt: avoid overflow in bnxt_get_nvram_directory()

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Prevent lpfc_debugfs_lockstat_write() buffer overflow

Jan Kara <jack@suse.cz>
    ext2: Check block size validity during mount

Hector Martin <marcan@marcan.st>
    wifi: brcmfmac: cfg80211: Pass the PMK in binary instead of hex

Kumar Kartikeya Dwivedi <memxor@gmail.com>
    bpf: Annotate data races in bpf_local_storage

Kees Cook <keescook@chromium.org>
    wifi: ath: Silence memcpy run-time false positive warning

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: Prefer designated initializers over memset for subdev pad ops

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix an out of bounds error in BIOS parser

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

Armin Wolf <W_Armin@gmx.de>
    ACPI: EC: Fix oops when removing custom query handlers

Pierre Gondois <pierre.gondois@arm.com>
    firmware: arm_sdei: Fix sleep from invalid context BUG

Zheng Wang <zyytlz.wz@163.com>
    memstick: r592: Fix UAF bug in r592_remove due to race condition

harperchen <harperchen1110@gmail.com>
    media: pci: tw68: Fix null-ptr-deref bug in buf prepare and finish

harperchen <harperchen1110@gmail.com>
    media: cx23885: Fix a null-ptr-deref bug in buffer_prepare() and buffer_finish()

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: msm8996: Add missing DWC3 quirks

Alexander Stein <alexander.stein@ew.tq-group.com>
    regmap: cache: Return error in cache sync operations for REGCACHE_NONE

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Use DC_LOG_DC in the trasform pixel function

Jani Nikula <jani.nikula@intel.com>
    drm/displayid: add displayid_get_header() and check bounds better

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fs: hfsplus: remove WARN_ON() from hfsplus_cat_{read,write}_inode()

Zqiang <qiang1.zhang@intel.com>
    rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access

Paul E. McKenney <paulmck@kernel.org>
    refscale: Move shutdown from wait_event() to wait_event_idle()

Theodore Ts'o <tytso@mit.edu>
    ext4: allow ext4_get_group_info() to fail

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: allow to find by goal if EXT4_MB_HINT_GOAL_ONLY is set

Jan Kara <jack@suse.cz>
    ext4: fix lockdep warning when enabling MMP

Theodore Ts'o <tytso@mit.edu>
    ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled

Theodore Ts'o <tytso@mit.edu>
    ext4: reflect error codes from ext4_multi_mount_protect() to its callers

Austin Kim <austindh.kim@gmail.com>
    ext4: remove an unused variable warning with CONFIG_QUOTA=n

Zongjie Li <u202112089@hust.edu.cn>
    fbdev: arcfb: Fix error handling in arcfb_probe()

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    drm/i915/dp: prevent potential div-by-zero

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix data races around sk->sk_shutdown.

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix a data race of sk->sk_receive_queue->qlen.

Eric Dumazet <edumazet@google.com>
    net: datagram: fix data-races in datagram_poll()

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

Florian Westphal <fw@strlen.de>
    netfilter: conntrack: fix possible bug_on with enable_hooks=1

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: always release netdev hooks from notifier

Kuniyuki Iwashima <kuniyu@amazon.com>
    net: Fix load-tearing on sk->sk_stamp in sock_recv_cmsgs().

Marek Vasut <marex@denx.de>
    net: stmmac: Initialize MAC_ONEUS_TIC_COUNTER register

Wong Vee Khee <vee.khee.wong@linux.intel.com>
    net: stmmac: switch to use interrupt for hw crosstimestamping

Roy Novich <royno@nvidia.com>
    linux/dim: Do nothing if no time delta between samples

Thomas Gleixner <tglx@linutronix.de>
    tick/broadcast: Make broadcast device replacement work correctly

Keoseong Park <keosung.park@samsung.com>
    scsi: ufs: core: Fix I/O hang that occurs when BKOPS fails in W-LUN suspend

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    net: mdio: mvusb: Fix an error handling path in mvusb_mdio_probe()

Randy Dunlap <rdunlap@infradead.org>
    ARM: 9296/1: HP Jornada 7XX: fix kernel-doc warnings

Saravana Kannan <saravanak@google.com>
    drm/mipi-dsi: Set the fwnode for mipi_dsi_device


-------------

Diffstat:

 .../bindings/display/msm/dsi-controller-main.yaml  |  12 ++
 MAINTAINERS                                        |   4 +-
 Makefile                                           |   4 +-
 arch/arm/mach-sa1100/jornada720_ssp.c              |   5 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   3 +
 arch/parisc/include/asm/pdc.h                      |   1 +
 arch/parisc/kernel/firmware.c                      |  27 ++++-
 arch/powerpc/kernel/dma-iommu.c                    |   4 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c           |   4 +-
 arch/powerpc/platforms/pseries/iommu.c             |  13 +-
 drivers/acpi/acpica/dbnames.c                      |   3 +
 drivers/acpi/acpica/dswstate.c                     |  11 +-
 drivers/acpi/ec.c                                  |   1 +
 drivers/base/regmap/regcache.c                     |   6 +
 drivers/block/nbd.c                                |   6 +
 drivers/block/null_blk/main.c                      |   5 +
 drivers/bluetooth/btbcm.c                          |  47 +++++++-
 drivers/bluetooth/btintel.c                        |   5 +-
 drivers/char/tpm/tpm_tis.c                         |  16 +++
 drivers/clk/tegra/clk-tegra20.c                    |  28 ++---
 drivers/firmware/arm_sdei.c                        |  37 +++---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   7 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |   5 +-
 drivers/gpu/drm/drm_displayid.c                    |  17 ++-
 drivers/gpu/drm/drm_mipi_dsi.c                     |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.h            |   4 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   5 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  |  11 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h  |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |   5 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h           |   3 -
 drivers/gpu/drm/msm/dp/dp_audio.c                  |  12 ++
 drivers/gpu/drm/msm/dp/dp_audio.h                  |   2 +
 drivers/gpu/drm/msm/dp/dp_aux.c                    |  80 ++++++-------
 drivers/gpu/drm/msm/dp/dp_catalog.c                |   2 +-
 drivers/gpu/drm/msm/dp/dp_catalog.h                |   2 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |   1 +
 drivers/gpu/drm/tegra/sor.c                        |   2 +-
 drivers/hid/hid-logitech-hidpp.c                   |  53 ++++++++-
 drivers/hid/wacom.h                                |   3 +
 drivers/hid/wacom_sys.c                            |   2 +
 drivers/hid/wacom_wac.c                            |  80 +++++++++----
 drivers/infiniband/core/user_mad.c                 |  23 ++--
 drivers/input/joystick/xpad.c                      |   5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  19 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  16 ++-
 drivers/iommu/sprd-iommu.c                         |  29 +++--
 drivers/mcb/mcb-pci.c                              |  27 ++++-
 drivers/media/pci/cx23885/cx23885-core.c           |   4 +-
 drivers/media/pci/cx23885/cx23885-video.c          |  13 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c |   2 +-
 drivers/media/pci/tw68/tw68-video.c                |  16 +--
 drivers/media/platform/am437x/am437x-vpfe.c        |  15 +--
 drivers/media/platform/exynos4-is/fimc-capture.c   |   7 +-
 drivers/media/platform/ti-vpe/cal-video.c          |   8 +-
 drivers/media/platform/vsp1/vsp1_drm.c             |  18 +--
 drivers/media/platform/vsp1/vsp1_entity.c          |  11 +-
 drivers/media/usb/dvb-usb/cxusb-analog.c           |  14 +--
 drivers/memstick/host/r592.c                       |   2 +-
 drivers/message/fusion/mptlan.c                    |   2 +
 drivers/mfd/dln2.c                                 |   1 +
 drivers/net/can/kvaser_pciefd.c                    |  51 ++++----
 drivers/net/dsa/mv88e6xxx/port.h                   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   9 +-
 drivers/net/ethernet/freescale/fec_main.c          |  15 ++-
 drivers/net/ethernet/google/gve/gve_main.c         |  13 --
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h |   1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  15 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   4 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   5 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   5 +-
 drivers/net/ethernet/intel/igb/e1000_mac.c         |   4 +-
 drivers/net/ethernet/pasemi/pasemi_mac.c           |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |  25 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |   4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   9 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   1 +
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |   5 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |  12 +-
 drivers/net/ethernet/sun/cassini.c                 |   2 +
 drivers/net/ipvlan/ipvlan_core.c                   |   6 +
 drivers/net/mdio/mdio-mvusb.c                      |  11 +-
 drivers/net/phy/dp83867.c                          |  22 +++-
 drivers/net/tap.c                                  |   4 +-
 drivers/net/virtio_net.c                           |  61 +++++++---
 drivers/net/wireless/ath/ath.h                     |  12 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   9 +-
 drivers/net/wireless/ath/key.c                     |   2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  13 +-
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c       |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |  10 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   3 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   2 +-
 drivers/parisc/power.c                             |  16 ++-
 drivers/phy/st/phy-miphy28lp.c                     |  42 ++-----
 drivers/platform/x86/Kconfig                       |  42 +------
 drivers/platform/x86/Makefile                      |   4 +-
 drivers/platform/x86/hp/Kconfig                    |  63 ++++++++++
 drivers/platform/x86/hp/Makefile                   |  10 ++
 drivers/platform/x86/{ => hp}/hp-wmi.c             |  21 ++--
 drivers/platform/x86/{ => hp}/hp_accel.c           |   2 +-
 drivers/platform/x86/{ => hp}/tc1100-wmi.c         |   0
 drivers/remoteproc/stm32_rproc.c                   |   8 ++
 drivers/s390/cio/device.c                          |   2 +
 drivers/s390/cio/qdio.h                            |   2 +-
 drivers/scsi/lpfc/lpfc_debugfs.c                   |   7 +-
 drivers/scsi/storvsc_drv.c                         |   8 +-
 drivers/scsi/ufs/ufshcd-pci.c                      |   1 +
 drivers/scsi/ufs/ufshcd.c                          |  10 +-
 drivers/soundwire/qcom.c                           |   3 +
 drivers/spi/spi-imx.c                              |  24 +++-
 drivers/staging/media/imx/imx-media-capture.c      |  12 +-
 drivers/staging/media/imx/imx-media-utils.c        |   8 +-
 drivers/staging/media/omap4iss/iss_video.c         |   6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |   5 -
 drivers/target/iscsi/iscsi_target.c                |   6 +-
 drivers/thunderbolt/nhi.c                          |  29 ++++-
 drivers/thunderbolt/nhi_regs.h                     |   2 +
 drivers/tty/serial/8250/8250_bcm7271.c             |   7 +-
 drivers/tty/serial/8250/8250_core.c                |   1 +
 drivers/tty/serial/8250/8250_exar.c                |  17 +++
 drivers/tty/serial/8250/8250_pci.c                 |   5 +
 drivers/tty/serial/arc_uart.c                      |   7 +-
 drivers/tty/serial/qcom_geni_serial.c              |   9 +-
 drivers/tty/vt/vc_screen.c                         |  11 +-
 drivers/usb/class/usbtmc.c                         |   2 +
 drivers/usb/dwc3/debugfs.c                         | 109 +++++++++++++++++
 drivers/usb/gadget/function/u_ether.c              |   3 +
 drivers/usb/host/uhci-pci.c                        |  10 +-
 drivers/usb/host/xhci-pci.c                        |  12 +-
 drivers/usb/host/xhci-ring.c                       |  29 ++++-
 drivers/usb/host/xhci.h                            |   2 +-
 drivers/usb/storage/scsiglue.c                     |  28 +++--
 drivers/usb/typec/altmodes/displayport.c           |   4 +
 drivers/usb/typec/tcpm/tcpm.c                      |  16 ++-
 drivers/video/fbdev/arcfb.c                        |  15 ++-
 fs/ceph/snap.c                                     |  13 ++
 fs/cifs/cifsglob.h                                 |   4 +-
 fs/cifs/file.c                                     |  26 ++--
 fs/cifs/smb1ops.c                                  |   9 +-
 fs/cifs/smb2ops.c                                  |   7 +-
 fs/ext2/ext2.h                                     |   1 +
 fs/ext2/super.c                                    |   7 ++
 fs/ext4/balloc.c                                   |  18 ++-
 fs/ext4/ext4.h                                     |  15 +--
 fs/ext4/ialloc.c                                   |  12 +-
 fs/ext4/mballoc.c                                  | 131 +++++++++++++++------
 fs/ext4/mmp.c                                      |  39 ++++--
 fs/ext4/super.c                                    |  28 +++--
 fs/f2fs/checkpoint.c                               |  12 +-
 fs/f2fs/data.c                                     |   3 +-
 fs/f2fs/f2fs.h                                     |   5 +
 fs/f2fs/super.c                                    |   2 +-
 fs/gfs2/glops.c                                    |   3 +-
 fs/hfsplus/inode.c                                 |  28 ++++-
 fs/ksmbd/connection.c                              |   3 +-
 fs/ksmbd/oplock.c                                  |   5 +-
 fs/ksmbd/oplock.h                                  |   2 +-
 fs/ksmbd/smb2misc.c                                |   5 +-
 fs/ksmbd/smb2pdu.c                                 |  19 ++-
 fs/nilfs2/inode.c                                  |  18 +++
 fs/ntfs3/frecord.c                                 |   5 +-
 fs/ntfs3/fsntfs.c                                  |   1 +
 fs/ntfs3/index.c                                   |  11 +-
 fs/ntfs3/inode.c                                   |   6 +
 fs/ntfs3/record.c                                  |   9 +-
 fs/statfs.c                                        |   4 +-
 include/linux/cpuhotplug.h                         |   1 -
 include/linux/dim.h                                |   3 +-
 include/linux/if_vlan.h                            |  17 +++
 include/linux/sched/task_stack.h                   |   2 +-
 include/linux/stmmac.h                             |   1 +
 include/linux/sunrpc/svc.h                         |   2 -
 include/linux/sunrpc/svc_rdma.h                    |   2 +-
 include/linux/sunrpc/svc_xprt.h                    |   2 +-
 include/net/ip_vs.h                                |   6 +-
 include/net/sock.h                                 |   2 +-
 include/trace/bpf_probe.h                          |   6 +
 include/trace/events/sunrpc.h                      |  12 +-
 include/trace/perf.h                               |   6 +
 include/trace/trace_events.h                       |  55 ++++++++-
 kernel/bpf/bpf_local_storage.c                     |  16 ++-
 kernel/bpf/verifier.c                              |   4 +
 kernel/rcu/refscale.c                              |   2 +-
 kernel/rcu/tree_exp.h                              |   6 +-
 kernel/time/tick-broadcast.c                       | 120 ++++++++++++++-----
 lib/cpu_rmap.c                                     |   5 +-
 lib/dim/dim.c                                      |   5 +-
 lib/dim/net_dim.c                                  |   3 +-
 lib/dim/rdma_dim.c                                 |   3 +-
 net/8021q/vlan_dev.c                               |   4 +-
 net/bluetooth/l2cap_core.c                         |   1 -
 net/bridge/br_forward.c                            |   2 +-
 net/bridge/br_private_tunnel.h                     |   8 +-
 net/can/isotp.c                                    |   2 +-
 net/can/j1939/socket.c                             |   2 +-
 net/core/datagram.c                                |  15 ++-
 net/core/dev.c                                     |   4 +-
 net/core/stream.c                                  |  12 +-
 net/ipv4/af_inet.c                                 |   2 +-
 net/ipv4/tcp.c                                     |  14 ++-
 net/ipv4/tcp_bpf.c                                 |   2 +-
 net/ipv4/tcp_input.c                               |   4 +-
 net/ipv4/tcp_ipv4.c                                |   5 +-
 net/ipv6/ip6_gre.c                                 |  13 +-
 net/key/af_key.c                                   |  12 +-
 net/llc/af_llc.c                                   |   8 +-
 net/mac80211/trace.h                               |   2 +-
 net/netfilter/core.c                               |   6 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |   2 +-
 net/netfilter/nf_conntrack_standalone.c            |   3 +-
 net/netfilter/nf_tables_api.c                      |   4 +-
 net/netfilter/nft_chain_filter.c                   |   9 +-
 net/netfilter/nft_set_rbtree.c                     |  20 ++--
 net/netlink/af_netlink.c                           |   8 +-
 net/nsh/nsh.c                                      |   8 +-
 net/packet/af_packet.c                             |   6 +-
 net/smc/smc_close.c                                |   4 +-
 net/smc/smc_rx.c                                   |   4 +-
 net/smc/smc_tx.c                                   |   4 +-
 net/socket.c                                       |   2 +-
 net/sunrpc/svc.c                                   |   2 +-
 net/sunrpc/svc_xprt.c                              |  34 ++++--
 net/sunrpc/svcsock.c                               |  41 +++----
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c            |  12 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c           |   2 +-
 net/tipc/bearer.c                                  |  17 ++-
 net/tipc/bearer.h                                  |   3 +
 net/tipc/link.c                                    |   9 +-
 net/tipc/socket.c                                  |   4 +-
 net/tipc/udp_media.c                               |   5 +-
 net/tls/tls_main.c                                 |   3 +-
 net/unix/af_unix.c                                 |  22 ++--
 net/vmw_vsock/af_vsock.c                           |   2 +-
 net/xfrm/xfrm_interface.c                          |  54 +--------
 net/xfrm/xfrm_policy.c                             |   9 --
 samples/bpf/hbm.c                                  |   1 +
 scripts/recordmcount.c                             |   6 +-
 sound/firewire/digi00x/digi00x-stream.c            |   4 +-
 sound/pci/hda/hda_generic.c                        |   7 +-
 sound/pci/hda/patch_hdmi.c                         |   5 +
 sound/pci/hda/patch_realtek.c                      |   5 +-
 sound/soc/fsl/fsl_micfil.c                         |  14 ++-
 sound/usb/format.c                                 |   1 +
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |  31 +++--
 .../selftests/net/srv6_end_dt4_l3vpn_test.sh       |  17 ++-
 250 files changed, 2035 insertions(+), 948 deletions(-)


