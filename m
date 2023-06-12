Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6036272C1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbjFLK7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbjFLK6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:58:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0706659E5;
        Mon, 12 Jun 2023 03:46:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88CD562433;
        Mon, 12 Jun 2023 10:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46660C433D2;
        Mon, 12 Jun 2023 10:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566767;
        bh=EK6lmMQIQVtOb1swuL9kttGbtMjRxqVTGjGdi+eNQ9g=;
        h=From:To:Cc:Subject:Date:From;
        b=qF6OolA55zHPifv/ig7Ap5HzO5PfZd27yLcJgLz0RzG4eG6LhGpNgaUuvZfYwoCby
         4CT+uHgE+ZG8WIsrycnTFPV4hMq7HrZa7pgQdW8JKQ8HBlO+NJvcTdFMRe2DN4ZTVP
         fOKz96sBKNVlOf7tSWhnQ9oGoFgaMbmgIgzFBFLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 6.3 000/160] 6.3.8-rc1 review
Date:   Mon, 12 Jun 2023 12:25:32 +0200
Message-ID: <20230612101715.129581706@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.8-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.3.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.3.8-rc1
X-KernelTest-Deadline: 2023-06-14T10:17+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.3.8 release.
There are 160 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.8-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.3.8-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE"

Ping-Ke Shih <pkshih@realtek.com>
    wifi: rtw88: correct PS calculation for SUPPORTS_DYNAMIC_PS

Ping-Ke Shih <pkshih@realtek.com>
    wifi: rtw89: correct PS calculation for SUPPORTS_DYNAMIC_PS

Theodore Ts'o <tytso@mit.edu>
    ext4: only check dquot_initialize_needed() when debugging

Theodore Ts'o <tytso@mit.edu>
    Revert "ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled"

Ruihan Li <lrh2000@pku.edu.cn>
    Bluetooth: Fix UAF in hci_conn_hash_flush again

Ruihan Li <lrh2000@pku.edu.cn>
    Bluetooth: Refcnt drop must be placed last in hci_conn_unlink

Ruihan Li <lrh2000@pku.edu.cn>
    Bluetooth: Fix potential double free caused by hci_conn_unlink

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix posix_acls and acls dereferencing possible ERR_PTR()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix out-of-bound read in parse_lease_state()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix out-of-bound read in deassemble_neg_contexts()

Shannon Nelson <shannon.nelson@amd.com>
    vhost_vdpa: support PACKED when setting-getting vring_base

Shannon Nelson <shannon.nelson@amd.com>
    vhost: support PACKED when setting-getting vring_base

Dragos Tatulea <dtatulea@nvidia.com>
    vdpa/mlx5: Fix hang when cvq commands are triggered during device unregister

Sheng Zhao <sheng.zhao@bytedance.com>
    vduse: avoid empty string for dev name

Ruan Jinjie <ruanjinjie@huawei.com>
    riscv: fix kprobe __user string arg print fault issue

Charles Keepax <ckeepax@opensource.cirrus.com>
    soundwire: stream: Add missing clear of alloc_slave_rt

Randy Dunlap <rdunlap@infradead.org>
    eeprom: at24: also select REGMAP

Hsieh-Tseng Shen <woodrow.shen@sifive.com>
    riscv: mm: Ensure prot of VM_WRITE and VM_EXEC must be readable

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    i2c: sprd: Delete i2c adapter in .remove's error path

Kent Gibson <warthog618@gmail.com>
    gpio: sim: fix memory corruption when adding named lines and unnamed hogs

Balint Dobszay <balint.dobszay@arm.com>
    firmware: arm_ffa: Set handle field to zero in memory descriptor

Marek Behún <kabel@kernel.org>
    i2c: mv64xxx: Fix reading invalid status value in atomic mode

Adam Ford <aford173@gmail.com>
    arm64: dts: imx8mn-beacon: Fix SPI CS pinmux

Tian Lan <tian.lan@twosigma.com>
    blk-mq: fix blk_mq_hw_ctx active request accounting

Robert Hancock <robert.hancock@calian.com>
    ASoC: simple-card-utils: fix PCM constraint error check

Trevor Wu <trevor.wu@mediatek.com>
    ASoC: mediatek: mt8195: fix use-after-free in driver remove path

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    ASoC: mediatek: mt8195-afe-pcm: Convert to platform remove callback returning void

Trevor Wu <trevor.wu@mediatek.com>
    ASoC: mediatek: mt8188: fix use-after-free in driver remove path

Vijendar Mukunda <Vijendar.Mukunda@amd.com>
    ASoC: amd: ps: fix for acp_lock access in pdm driver

Shenwei Wang <shenwei.wang@nxp.com>
    arm64: dts: imx8-ss-dma: assign default clock rate for lpuarts

Shenwei Wang <shenwei.wang@nxp.com>
    arm64: dts: imx8qm-mek: correct GPIOs for USDHC2 CD and WP signals

Douglas Anderson <dianders@chromium.org>
    arm64: dts: qcom: sc7180-lite: Fix SDRAM freq for misidentified sc7180-lite boards

Dan Carpenter <dan.carpenter@linaro.org>
    soc: qcom: rmtfs: Fix error code in probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    soc: qcom: ramp_controller: Fix an error handling path in qcom_ramp_controller_probe()

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: codecs: wsa881x: do not set can_multi_write flag

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: codecs: wsa883x: do not set can_multi_write flag

Claudiu Beznea <claudiu.beznea@microchip.com>
    ARM: dts: at91: sama7g5ek: fix debounce delay property for shdwc

Claudiu Beznea <claudiu.beznea@microchip.com>
    ARM: at91: pm: fix imbalanced reference counter for ethernet devices

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sm6375-pdx225: Fix remoteproc firmware paths

Bjorn Andersson <quic_bjorande@quicinc.com>
    arm64: dts: qcom: sc8280xp: Flush RSC sleep & wake votes

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soc: qcom: rpmh-rsc: drop redundant unsigned >=0 comparision

Ruihan Li <lrh2000@pku.edu.cn>
    mm: page_table_check: Ensure user pages are not slab pages

Ruihan Li <lrh2000@pku.edu.cn>
    mm: page_table_check: Make it dependent on EXCLUSIVE_SYSTEM_RAM

Ruihan Li <lrh2000@pku.edu.cn>
    usb: usbfs: Use consistent mmap functions

Ruihan Li <lrh2000@pku.edu.cn>
    usb: usbfs: Enforce page requirements for mmap

Martin Hundebøll <martin@geanix.com>
    pinctrl: meson-axg: add missing GPIOA_18 gpio group

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soc: qcom: icc-bwmon: fix incorrect error code passed to dev_err_probe()

Brett Creeley <brett.creeley@amd.com>
    virtio_net: use control_buf for coalesce params

Ilya Dryomov <idryomov@gmail.com>
    rbd: get snapshot context after exclusive lock is ensured to be held

Ilya Dryomov <idryomov@gmail.com>
    rbd: move RBD_OBJ_FLAG_COPYUP_ENABLED flag setting

Rijo Thomas <Rijo-john.Thomas@amd.com>
    tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'

Johan Hovold <johan+linaro@kernel.org>
    Bluetooth: hci_qca: fix debugfs registration

Johan Hovold <johan+linaro@kernel.org>
    Bluetooth: fix debugfs registration

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: Fix use-after-free in hci_remove_ltk/hci_remove_irk

Jan Höppner <hoeppner@linux.ibm.com>
    s390/dasd: Use correct lock while counting channel queue length

Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
    accel/ivpu: Fix sporadic VPU boot failure

Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
    accel/ivpu: Do not trigger extra VPU reset if the VPU is idle

Xiubo Li <xiubli@redhat.com>
    ceph: fix use-after-free bug for inodes when flushing capsnaps

Geliang Tang <geliang.tang@suse.com>
    selftests: mptcp: update userspace pm subflow tests

Geliang Tang <geliang.tang@suse.com>
    selftests: mptcp: update userspace pm addr tests

Geliang Tang <geliang.tang@suse.com>
    mptcp: update userspace pm infos

Geliang Tang <geliang.tang@suse.com>
    mptcp: add address into userspace pm list

Geliang Tang <geliang.tang@suse.com>
    mptcp: only send RM_ADDR in nl_cmd_remove

Fedor Pchelkin <pchelkin@ispras.ru>
    can: j1939: avoid possible use-after-free when j1939_can_rx_register fails

Fedor Pchelkin <pchelkin@ispras.ru>
    can: j1939: change j1939_netdev_lock type to mutex

Oleksij Rempel <linux@rempel-privat.de>
    can: j1939: j1939_sk_send_loop_abort(): improved error queue handling in J1939 Socket

Gustavo A. R. Silva <gustavoars@kernel.org>
    wifi: iwlwifi: mvm: Fix -Warray-bounds bug in iwl_mvm_wait_d3_notif()

Samson Tam <samson.tam@amd.com>
    drm/amd/display: add ODM case when looking for first split pipe

Alvin Lee <alvin.lee2@amd.com>
    drm/amd/display: Reduce sdp bw after urgent to 90%

Lijo Lazar <lijo.lazar@amd.com>
    drm/amd/pm: Fix power context allocation in SMU13

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Disallow s0ix without BIOS support again

YiPeng Chai <YiPeng.Chai@amd.com>
    drm/amdgpu: change reserved vram info print

Chia-I Wu <olvaffe@gmail.com>
    drm/amdgpu: fix xclk freq on CHIP_STONEY

Evan Quan <evan.quan@amd.com>
    drm/amd/pm: conditionally disable pcie lane switching for some sienna_cichlid SKUs

Andi Shyti <andi.shyti@linux.intel.com>
    drm/i915/gt: Use the correct error value when kernel_context() fails

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda/realtek: Add quirks for Asus ROG 2024 laptops using CS35L41

RenHai <kean0048@gmail.com>
    ALSA: hda/realtek: Add Lenovo P3 Tower platform

Ai Chao <aichao@kylinos.cn>
    ALSA: hda/realtek: Add a quirk for HP Slim Desktop S01

Jaroslav Kysela <perex@perex.cz>
    ALSA: ice1712,ice1724: fix the kcontrol->id initialization

Tim Crawford <tcrawford@system76.com>
    ALSA: hda/realtek: Add quirk for Clevo NS50AU

Takashi Iwai <tiwai@suse.de>
    ALSA: cmipci: Fix kctl->id initialization

Takashi Iwai <tiwai@suse.de>
    ALSA: gus: Fix kctl->id initialization

Takashi Iwai <tiwai@suse.de>
    ALSA: ymfpci: Fix kctl->id initialization

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Fix kctl->id initialization

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: fix open count when closing inhibited device

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: psmouse - fix OOB access in Elantech protocol

Maximilian Weigand <mweigand@mweigand.net>
    Input: cyttsp5 - fix array length

Ismael Ferreras Morezuelas <swyterzone@gmail.com>
    Input: xpad - delete a Razer DeathAdder mouse VID/PID entry

Vladislav Efanov <VEfanov@ispras.ru>
    batman-adv: Broken sync while rescheduling delayed work

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/a6xx: initialize GMU mutex earlier

Somnath Kotur <somnath.kotur@broadcom.com>
    bnxt_en: Implement .set_port / .unset_port UDP tunnel callbacks

Pavan Chebbi <pavan.chebbi@broadcom.com>
    bnxt_en: Prevent kernel panic when receiving unexpected PHC_UPDATE event

Vikas Gupta <vikas.gupta@broadcom.com>
    bnxt_en: Skip firmware fatal error recovery if chip is not accessible

Somnath Kotur <somnath.kotur@broadcom.com>
    bnxt_en: Query default VLAN before VNIC setup on a VF

Sreekanth Reddy <sreekanth.reddy@broadcom.com>
    bnxt_en: Don't issue AP reset during ethtool's reset operation

Pavan Chebbi <pavan.chebbi@broadcom.com>
    bnxt_en: Fix bnxt_hwrm_update_rss_hash_cfg()

Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
    accel/ivpu: Do not use mutex_lock_interruptible

Florian Fainelli <florian.fainelli@broadcom.com>
    net: bcmgenet: Fix EEE implementation

Ben Hutchings <ben@decadent.org.uk>
    lib: cpu_rmap: Fix potential use-after-free in irq_cpu_rmap_release()

Horatio Zhang <Hongkun.Zhang@amd.com>
    drm/amdgpu: fix Null pointer dereference error in amdgpu_device_recover_vram

Jiri Olsa <jolsa@kernel.org>
    bpf: Add extra path pointer check to d_path helper

Hangyu Hua <hbh25y@gmail.com>
    net: sched: fix possible refcount leak in tc_chain_tmplt_add()

Eric Dumazet <edumazet@google.com>
    net: sched: act_police: fix sparse errors in tcf_police_dump()

Eelco Chaudron <echaudro@redhat.com>
    net: openvswitch: fix upcall counter access before allocation

Eric Dumazet <edumazet@google.com>
    net: sched: move rtm_tca_policy declaration to include file

Michal Schmidt <mschmidt@redhat.com>
    ice: make writes to /dev/gnssX synchronous

Tvrtko Ursulin <tvrtko.ursulin@intel.com>
    drm/i915/selftests: Add some missing error propagation

Eric Dumazet <edumazet@google.com>
    net: sched: add rcu annotations around qdisc->qdisc_sleeping

Eric Dumazet <edumazet@google.com>
    rfs: annotate lockless accesses to RFS sock flow table

Eric Dumazet <edumazet@google.com>
    rfs: annotate lockless accesses to sk->sk_rxhash

Eric Dumazet <edumazet@google.com>
    tcp: gso: really support BIG TCP

Kuniyuki Iwashima <kuniyu@amazon.com>
    ipv6: rpl: Fix Route of Death.

Erico Nunes <nunes.erico@gmail.com>
    drm/lima: fix sched context destroy

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: out-of-bound check in chain blob

Kuniyuki Iwashima <kuniyu@amazon.com>
    netfilter: ipset: Add schedule point in call_ad().

Tijs Van Buggenhout <tijs.van.buggenhout@axsguard.com>
    netfilter: conntrack: fix NULL pointer dereference in nf_confirm_cthelper

Jeremy Sowden <jeremy@azazel.net>
    netfilter: nft_bitwise: fix register tracking

Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
    netfilter: nf_tables: Add null check for nla_nest_start_noflag() in nft_dump_basechain_hook()

Yonghong Song <yhs@fb.com>
    selftests/bpf: Fix sockopt_sk selftest

Stanislav Fomichev <sdf@google.com>
    selftests/bpf: Verify optval=NULL case

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix locking in regulatory disconnect

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix locking in sched scan stop work

Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
    accel/ivpu: Reserve all non-command bo's using DMA_RESV_USAGE_BOOKKEEP

Randy Dunlap <rdunlap@infradead.org>
    accel/ivpu: ivpu_ipc needs GENERIC_ALLOCATOR

Manish Chopra <manishc@marvell.com>
    qed/qede: Fix scheduling while atomic

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: don't translate beacon/presp addrs

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: mlme: fix non-inheritence element

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: reject bad AP MLD address

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: use correct iftype HE cap

Sungwoo Kim <iam@sung-woo.kim>
    Bluetooth: L2CAP: Add missing checks for invalid DCID

Pauli Virtanen <pav@iki.fi>
    Bluetooth: ISO: use correct CIS order in Set CIG Parameters event

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_conn: Fix not matching by CIS ID

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_conn: Add support for linking multiple hcon

Pauli Virtanen <pav@iki.fi>
    Bluetooth: ISO: don't try to remove CIG if there are bound CIS left

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Fix l2cap_disconnect_req deadlock

Zhengping Jiang <jiangzp@google.com>
    Bluetooth: hci_sync: add lock to protect HCI_UNREGISTER

Pauli Virtanen <pav@iki.fi>
    Bluetooth: ISO: Fix CIG auto-allocation to select configurable CIG

Pauli Virtanen <pav@iki.fi>
    Bluetooth: ISO: consider right CIS when removing CIG at cleanup

Iulia Tanasescu <iulia.tanasescu@nxp.com>
    Bluetooth: Split bt_iso_qos into dedicated structures

Jouni Högander <jouni.hogander@intel.com>
    drm/i915: Use 18 fast wake AUX sync len

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Explain the magic numbers for AUX SYNC/precharge length

Eric Dumazet <edumazet@google.com>
    net/sched: fq_pie: ensure reasonable TCA_FQ_PIE_QUANTUM values

Wei Fang <wei.fang@nxp.com>
    net: enetc: correct rx_bytes statistics of XDP

Wei Fang <wei.fang@nxp.com>
    net: enetc: correct the statistics of rx bytes

Wen Gu <guwen@linux.alibaba.com>
    net/smc: Avoid to access invalid RMBs' MRs in SMCRv1 ADD LINK CONT

Eric Dumazet <edumazet@google.com>
    net/ipv6: fix bool/int mismatch for skip_notify_on_dev_down

Rhys Rustad-Elliott <me@rhysre.net>
    bpf: Fix elem_size not being set for inner maps

KP Singh <kpsingh@kernel.org>
    bpf: Fix UAF in task local storage

Akihiro Suda <suda.gitsendemail@gmail.com>
    net/ipv4: ping_group_range: allow GID from 2147483648 to 4294967294

Alexander Sverdlin <alexander.sverdlin@siemens.com>
    net: dsa: lan9303: allow vid != 0 in port_fdb_{add|del} methods

Qingfang DENG <qingfang.deng@siflower.com.cn>
    neighbour: fix unaligned access to pneigh_entry

Eric Dumazet <edumazet@google.com>
    bpf, sockmap: Avoid potential NULL dereference in sk_psock_verdict_data_ready()

Lorenzo Bianconi <lorenzo@kernel.org>
    wifi: mt76: mt7615: fix possible race in mt7615_mac_sta_poll

David Howells <dhowells@redhat.com>
    afs: Fix setting of mtime when creating a file/dir/symlink

Stephan Gerhold <stephan@gerhold.net>
    spi: qup: Request DMA before enabling clocks

Maximilian Luz <luzmaximilian@gmail.com>
    platform/surface: aggregator_tabletsw: Add support for book mode in KIP subsystem

Maximilian Luz <luzmaximilian@gmail.com>
    platform/surface: aggregator: Allow completion work-items to be executed in parallel

Daniel Golle <daniel@makrotopia.org>
    spi: mt65xx: make sure operations completed before unloading


-------------

Diffstat:

 Documentation/mm/page_table_check.rst              |  19 ++
 Documentation/networking/ip-sysctl.rst             |   4 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/at91-sama7g5ek.dts               |   2 +-
 arch/arm/mach-at91/pm.c                            |  20 +-
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     |   8 +
 .../dts/freescale/imx8mn-beacon-baseboard.dtsi     |   4 +-
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts       |   4 +-
 arch/arm64/boot/dts/qcom/sc7180-lite.dtsi          |   8 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   1 +
 .../dts/qcom/sm6375-sony-xperia-murray-pdx225.dts  |   4 +-
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/include/asm/pgtable.h                   |   3 +-
 arch/riscv/mm/init.c                               |   2 +-
 block/blk-mq.c                                     |   8 +-
 drivers/accel/ivpu/Kconfig                         |   1 +
 drivers/accel/ivpu/ivpu_hw_mtl.c                   |  22 +-
 drivers/accel/ivpu/ivpu_hw_mtl_reg.h               |   1 +
 drivers/accel/ivpu/ivpu_ipc.c                      |   4 +-
 drivers/accel/ivpu/ivpu_job.c                      |  21 +-
 drivers/accel/ivpu/ivpu_mmu.c                      |  22 +-
 drivers/block/rbd.c                                |  62 +++-
 drivers/bluetooth/hci_qca.c                        |   6 +-
 drivers/firmware/arm_ffa/driver.c                  |   1 +
 drivers/gpio/gpio-sim.c                            |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |   7 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |  11 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  36 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  20 ++
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |   2 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  92 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   4 +-
 drivers/gpu/drm/i915/display/intel_dp_aux.c        |  32 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c  |  14 +-
 drivers/gpu/drm/i915/gt/selftest_execlists.c       |  12 +-
 drivers/gpu/drm/lima/lima_sched.c                  |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   2 -
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   2 +
 drivers/i2c/busses/i2c-mv64xxx.c                   |  11 +
 drivers/i2c/busses/i2c-sprd.c                      |   8 +-
 drivers/input/input.c                              |   2 +-
 drivers/input/joystick/xpad.c                      |   1 -
 drivers/input/mouse/elantech.c                     |   9 +-
 drivers/input/touchscreen/cyttsp5.c                |   2 +-
 drivers/misc/eeprom/Kconfig                        |   1 +
 drivers/net/dsa/lan9303-core.c                     |   4 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  40 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |   1 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  22 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |   3 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   5 +
 drivers/net/ethernet/freescale/enetc/enetc.c       |  16 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |   2 +-
 drivers/net/ethernet/intel/ice/ice_common.h        |   2 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c          |  64 +---
 drivers/net/ethernet/intel/ice/ice_gnss.h          |  10 -
 drivers/net/ethernet/qlogic/qed/qed_l2.c           |   2 +-
 drivers/net/ethernet/qlogic/qede/qede.h            |   4 +
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |  24 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c       |  34 +-
 drivers/net/virtio_net.c                           |  16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |   3 +
 drivers/net/wireless/realtek/rtw88/mac80211.c      |  14 +-
 drivers/net/wireless/realtek/rtw88/main.c          |   4 +-
 drivers/net/wireless/realtek/rtw88/ps.c            |  43 +++
 drivers/net/wireless/realtek/rtw88/ps.h            |   2 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  16 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |  26 ++
 drivers/net/wireless/realtek/rtw89/ps.h            |   1 +
 drivers/pinctrl/meson/pinctrl-meson-axg.c          |   1 +
 drivers/platform/surface/aggregator/controller.c   |   2 +-
 .../platform/surface/surface_aggregator_tabletsw.c |   5 +
 drivers/s390/block/dasd_ioctl.c                    |   4 +-
 drivers/soc/qcom/icc-bwmon.c                       |   4 +-
 drivers/soc/qcom/ramp_controller.c                 |   2 +-
 drivers/soc/qcom/rmtfs_mem.c                       |   1 +
 drivers/soc/qcom/rpmh-rsc.c                        |   2 +-
 drivers/soundwire/stream.c                         |   4 +-
 drivers/spi/spi-mt65xx.c                           |   3 +
 drivers/spi/spi-qup.c                              |  37 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |   5 +
 drivers/tee/amdtee/amdtee_if.h                     |  10 +-
 drivers/tee/amdtee/call.c                          |  28 +-
 drivers/usb/core/buffer.c                          |  41 +++
 drivers/usb/core/devio.c                           |  20 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |   2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c                 |   3 +
 drivers/vhost/vdpa.c                               |  21 +-
 drivers/vhost/vhost.c                              |  18 +-
 drivers/vhost/vhost.h                              |   8 +-
 fs/afs/dir.c                                       |   3 +
 fs/ceph/caps.c                                     |   6 +
 fs/ceph/snap.c                                     |   4 +-
 fs/ext4/super.c                                    |   6 +-
 fs/ext4/xattr.c                                    |   6 +-
 fs/ksmbd/connection.c                              |  12 +
 fs/ksmbd/oplock.c                                  |  66 ++--
 fs/ksmbd/smb2pdu.c                                 |  13 +-
 fs/ksmbd/smbacl.c                                  |   4 +-
 fs/ksmbd/vfs.c                                     |   4 +-
 include/linux/netdevice.h                          |   9 +-
 include/linux/page-flags.h                         |   6 +
 include/linux/usb/hcd.h                            |   5 +
 include/net/bluetooth/bluetooth.h                  |  43 ++-
 include/net/bluetooth/hci.h                        |   1 +
 include/net/bluetooth/hci_core.h                   |  41 ++-
 include/net/neighbour.h                            |   2 +-
 include/net/netns/ipv6.h                           |   2 +-
 include/net/ping.h                                 |   6 +-
 include/net/pkt_sched.h                            |   2 +
 include/net/rpl.h                                  |   3 -
 include/net/sch_generic.h                          |   6 +-
 include/net/sock.h                                 |  18 +-
 kernel/bpf/map_in_map.c                            |   8 +-
 kernel/fork.c                                      |   2 +-
 kernel/trace/bpf_trace.c                           |  12 +-
 lib/cpu_rmap.c                                     |   2 +-
 mm/Kconfig.debug                                   |   1 +
 mm/page_table_check.c                              |   6 +
 net/batman-adv/distributed-arp-table.c             |   2 +-
 net/bluetooth/hci_conn.c                           | 378 +++++++++++++--------
 net/bluetooth/hci_core.c                           |  10 +-
 net/bluetooth/hci_event.c                          | 165 +++++----
 net/bluetooth/hci_sync.c                           |  23 +-
 net/bluetooth/iso.c                                | 133 ++++++--
 net/bluetooth/l2cap_core.c                         |  13 +
 net/can/j1939/main.c                               |  24 +-
 net/can/j1939/socket.c                             |   5 +
 net/core/dev.c                                     |   8 +-
 net/core/skmsg.c                                   |   3 +-
 net/ipv4/sysctl_net_ipv4.c                         |   8 +-
 net/ipv4/tcp_offload.c                             |  19 +-
 net/ipv6/exthdrs.c                                 |  29 +-
 net/mac80211/he.c                                  |  15 +-
 net/mac80211/mlme.c                                |   8 +-
 net/mac80211/rx.c                                  |   4 +-
 net/mptcp/pm.c                                     |  23 +-
 net/mptcp/pm_netlink.c                             |  18 +
 net/mptcp/pm_userspace.c                           |  48 ++-
 net/mptcp/protocol.h                               |   1 +
 net/netfilter/ipset/ip_set_core.c                  |   8 +
 net/netfilter/nf_conntrack_core.c                  |   3 +
 net/netfilter/nf_tables_api.c                      |   4 +-
 net/netfilter/nft_bitwise.c                        |   2 +-
 net/openvswitch/datapath.c                         |  19 --
 net/openvswitch/vport.c                            |  18 +-
 net/sched/act_police.c                             |  10 +-
 net/sched/cls_api.c                                |   3 +-
 net/sched/sch_api.c                                |  26 +-
 net/sched/sch_fq_pie.c                             |  10 +-
 net/sched/sch_generic.c                            |  30 +-
 net/sched/sch_mq.c                                 |   8 +-
 net/sched/sch_mqprio.c                             |   8 +-
 net/sched/sch_pie.c                                |   5 +-
 net/sched/sch_red.c                                |   5 +-
 net/sched/sch_sfq.c                                |   5 +-
 net/sched/sch_taprio.c                             |   6 +-
 net/sched/sch_teql.c                               |   2 +-
 net/smc/smc_llc.c                                  |   4 +-
 net/wireless/core.c                                |   4 +-
 net/wireless/nl80211.c                             |   2 +
 net/wireless/reg.c                                 |   4 +-
 sound/isa/gus/gus_pcm.c                            |   2 +-
 sound/pci/cmipci.c                                 |   6 +-
 sound/pci/hda/hda_codec.c                          |   6 +-
 sound/pci/hda/patch_realtek.c                      |   9 +
 sound/pci/ice1712/aureon.c                         |   7 +-
 sound/pci/ice1712/ice1712.c                        |  14 +-
 sound/pci/ice1712/ice1724.c                        |  16 +-
 sound/pci/ymfpci/ymfpci_main.c                     |   6 +-
 sound/soc/amd/ps/pci-ps.c                          |   3 +-
 sound/soc/amd/ps/ps-pdm-dma.c                      |  10 +-
 sound/soc/codecs/wsa881x.c                         |   1 -
 sound/soc/codecs/wsa883x.c                         |   1 -
 sound/soc/generic/simple-card-utils.c              |   2 +-
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c         |   7 -
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h         |   1 -
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c         |   4 -
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c      |  47 +--
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.h      |   1 -
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c         |   5 -
 sound/soc/mediatek/mt8195/mt8195-afe-clk.h         |   1 -
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c         |   9 +-
 sound/soc/mediatek/mt8195/mt8195-audsys-clk.c      |  47 +--
 sound/soc/mediatek/mt8195/mt8195-audsys-clk.h      |   1 -
 .../testing/selftests/bpf/prog_tests/sockopt_sk.c  |  28 ++
 tools/testing/selftests/bpf/progs/sockopt_sk.c     |  12 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  11 +-
 194 files changed, 1846 insertions(+), 955 deletions(-)


