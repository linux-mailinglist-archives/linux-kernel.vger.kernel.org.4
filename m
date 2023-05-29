Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561BB714D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjE2Pkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjE2Pkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B65C4;
        Mon, 29 May 2023 08:40:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 482146202C;
        Mon, 29 May 2023 15:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE35C433D2;
        Mon, 29 May 2023 15:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685374841;
        bh=Dka7VPLoFpaaBR/G7VMIEXyKGIJfCCsJHN3q0ex5YQc=;
        h=From:To:Cc:Subject:Date:From;
        b=zBrYL38n/OcNhin0ojXPsCY+k9uZiplbAeyXGnJcTrZa808VV4i+2r+O8om13NRIF
         Y8SwQO5Rtxu8uftGm5mzOrIUxFIrIQOVmTscRx0j1ROhtRUnLd+iYesWaJB+FSctPW
         b4VhULfWbBl1aMxkPevoiHVVnQn9iZ6VHlKD5Y9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 4.19 000/133] 4.19.284-rc2 review
Date:   Mon, 29 May 2023 16:40:38 +0100
Message-Id: <20230529153919.729418186@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.284-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.284-rc2
X-KernelTest-Deadline: 2023-05-31T15:39+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.284 release.
There are 133 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 31 May 2023 15:39:00 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.284-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.284-rc2

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    drivers: depend on HAS_IOMEM for devm_platform_ioremap_resource()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    3c589_cs: Fix an error handling path in tc589_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    forcedeth: Fix an error handling path in nv_probe()

Cezary Rojewski <cezary.rojewski@intel.com>
    ASoC: Intel: Skylake: Fix declaration of enum skl_ch_cfg

Vernon Lovejoy <vlovejoy@redhat.com>
    x86/show_trace_log_lvl: Ensure stack pointer is aligned, again

Dan Carpenter <dan.carpenter@linaro.org>
    xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()

Dan Carpenter <dan.carpenter@linaro.org>
    coresight: Fix signedness bug in tmc_etr_buf_insert_barrier_packet()

Daisuke Nojiri <dnojiri@chromium.org>
    power: supply: sbs-charger: Fix INHIBITED bit for Status reg

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Fix poll_interval handling and races on remove

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Fix I2C IRQ race on remove

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition

Hans de Goede <hdegoede@redhat.com>
    power: supply: leds: Fix blink to LED on transition

Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
    ipv6: Fix out-of-bounds access in ipv6_find_tlv()

Will Deacon <will@kernel.org>
    bpf: Fix mask generation for 32-bit narrow loads of 64-bit fields

Pratyush Yadav <ptyadav@amazon.de>
    net: fix skb leak in __skb_tstamp_tx()

Alan Stern <stern@rowland.harvard.edu>
    media: radio-shark: Add endpoint checks

Alan Stern <stern@rowland.harvard.edu>
    USB: sisusbvga: Add endpoint checks

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Add routines for endpoint checks in old drivers

Kuniyuki Iwashima <kuniyu@amazon.com>
    udplite: Fix NULL pointer dereference in __sk_mem_raise_allocated().

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Fix inverted bass GPIO pin on Acer 8951G

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fixed one of HP ALC671 platform Headset Mic supported

Helge Deller <deller@gmx.de>
    parisc: Fix flush_dcache_page() for usage from irq context

Hardik Garg <hargar@linux.microsoft.com>
    selftests/memfd: Fix unknown type name build failure

Dave Hansen <dave.hansen@linux.intel.com>
    x86/mm: Avoid incomplete Global INVLPG flushes

Josef Bacik <josef@toxicpanda.com>
    btrfs: use nofs when cleaning up aborted transactions

Helge Deller <deller@gmx.de>
    parisc: Allow to reboot machine after system halt

Finn Thain <fthain@linux-m68k.org>
    m68k: Move signal frame following exception on 68020/030

Adam Stylinski <kungfujesus06@gmail.com>
    ALSA: hda/ca0132: add quirk for EVGA X299 DARK

Christophe Leroy <christophe.leroy@csgroup.eu>
    spi: fsl-cpm: Use 16 bit mode for large transfers with even size

Christophe Leroy <christophe.leroy@csgroup.eu>
    spi: fsl-spi: Re-organise transfer bits_per_word adaptation

Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    spi: spi-fsl-spi: automatically adapt bits-per-word in cpu mode

Heiko Carstens <hca@linux.ibm.com>
    s390/qdio: fix do_sqbs() inline assembly constraint

Heiko Carstens <hca@linux.ibm.com>
    s390/qdio: get rid of register asm

George Kennedy <george.kennedy@oracle.com>
    vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF

Jiri Slaby <jslaby@suse.cz>
    vc_screen: rewrite vcs_size to accept vc, not inode

Konrad Gräfe <k.graefe@gateware.de>
    usb: gadget: u_ether: Fix host MAC address case

Jon Hunter <jonathanh@nvidia.com>
    usb: gadget: u_ether: Convert prints to device prints

Vadim Pasternak <vadimp@mellanox.com>
    lib/string_helpers: Introduce string_upper() and string_lower() helpers

Ai Chao <aichao@kylinos.cn>
    ALSA: hda/realtek: Add a quirk for HP EliteDesk 805

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - ALC897 headset MIC no sound

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add headset Mic support for Lenovo ALC897 platform

Hui Wang <hui.wang@canonical.com>
    ALSA: hda/realtek: Fix the mic type detection issue for ASUS G551JW

Jeremy Szu <jeremy.szu@canonical.com>
    ALSA: hda/realtek - The front Mic on a HP machine doesn't work

Jian-Hong Pan <jian-hong@endlessm.com>
    ALSA: hda/realtek - Enable the headset of Acer N50-600 with ALC662

Jian-Hong Pan <jian-hong@endlessm.com>
    ALSA: hda/realtek - Enable headset mic of Acer X2660G with ALC662

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add Headset Mic supported for HP cPC

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - More constifications

Sergey Bostandzhyan <jin@mediatomb.cc>
    Add Acer Aspire Ethos 8951G model quirk

Jason Gerecke <killertofu@gmail.com>
    HID: wacom: Force pen out of prox if no events have been received in a while

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: do not allow RULE_ID to refer to another chain

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: validate NFTA_SET_ELEM_OBJREF based on NFT_SET_OBJECT flag

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: stricter validation of element data

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: allow up to 64 bytes in the set element data area

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: add nft_setelem_parse_key()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: validate registers coming from userspace.

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nftables: statify nft_parse_register()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nftables: add nft_parse_register_store() and use it

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nftables: add nft_parse_register_load() and use it

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix use-after-free bug of nilfs_root in nilfs_evict_inode()

Jerry Snitselaar <jsnitsel@redhat.com>
    tpm/tpm_tis: Disable interrupts for more Lenovo devices

Xiubo Li <xiubli@redhat.com>
    ceph: force updating the msg pointer in non-split case

Vitaliy Tomin <tomin@iszf.irk.ru>
    serial: Add support for Advantech PCI-1611U card

Ilya Leoshkevich <iii@linux.ibm.com>
    statfs: enforce statfs[64] structure initialization

Nikhil Mahale <nmahale@nvidia.com>
    ALSA: hda: Add NVIDIA codec IDs a3 through a7 to patch table

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Fix Oops by 9.1 surround channel names

Badhri Jagan Sridharan <badhri@google.com>
    usb: typec: altmodes/displayport: fix pin_assignment_show

Maxime Bizon <mbizon@freebox.fr>
    usb-storage: fix deadlock when a scsi command timeouts more than once

Eric Dumazet <edumazet@google.com>
    vlan: fix a potential uninit-value in vlan_dev_hard_start_xmit()

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    igb: fix bit_shift to be in [1..8] range

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    cassini: Fix a memory leak in the error handling path of cas_init_one()

Florian Fainelli <f.fainelli@gmail.com>
    net: bcmgenet: Restore phy_stop() depending upon suspend/close

Florian Fainelli <f.fainelli@gmail.com>
    net: bcmgenet: Remove phy_stop() from bcmgenet_netif_stop()

Dong Chenchen <dongchenchen2@huawei.com>
    net: nsh: Use correct mac_offset to unwind gso skb in nsh_gso_segment()

Arnd Bergmann <arnd@arndb.de>
    drm/exynos: fix g2d_open/close helper function definitions

Duoming Zhou <duoming@zju.edu.cn>
    media: netup_unidvb: fix use-after-free at del_timer()

Xin Long <lucien.xin@gmail.com>
    erspan: get the proto with the md version for collect_md

Peilin Ye <peilin.ye@bytedance.com>
    ip_gre, ip6_gre: Fix race condition on o_seqno in collect_md mode

Peilin Ye <peilin.ye@bytedance.com>
    ip6_gre: Make o_seqno start from 0 in native mode

Peilin Ye <peilin.ye@bytedance.com>
    ip6_gre: Fix skb_under_panic in __gre6_xmit()

Ke Zhang <m202171830@hust.edu.cn>
    serial: arc_uart: fix of_iomap leak in `arc_serial_probe`

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    drivers: provide devm_platform_ioremap_resource()

Zhuang Shengen <zhuangshengen@huawei.com>
    vsock: avoid to close connected socket after the timeout

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    net: fec: Better handle pm_runtime_get() failing in .remove()

Tobias Brunner <tobias@strongswan.org>
    af_key: Reject optional tunnel/BEET mode templates in outbound policies

Wyes Karny <wyes.karny@amd.com>
    cpupower: Make TSC read per CPU for Mperf monitor

Filipe Manana <fdmanana@suse.com>
    btrfs: fix space cache inconsistency after error loading it from disk

Nikolay Borisov <nborisov@suse.com>
    btrfs: replace calls to btrfs_find_free_ino with btrfs_find_free_objectid

Qiang Ning <qning0106@126.com>
    mfd: dln2: Fix memory leak in dln2_probe()

Alain Volmat <avolmat@me.com>
    phy: st: miphy28lp: use _poll_timeout functions for waits

Vicki Pfau <vi@endrift.com>
    Input: xpad - add constants for GIP interface numbers

Arnd Bergmann <arnd@arndb.de>
    clk: tegra20: fix gcc-7 constant overflow warning

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
    wifi: iwlwifi: dvm: Fix memcpy: detected field-spanning write backtrace

Chao Yu <chao@kernel.org>
    f2fs: fix to drop all dirty pages during umount() if cp_error is set

Ojaswin Mujoo <ojaswin@linux.ibm.com>
    ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: set goal start correctly in ext4_mb_normalize_request

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fix inode height consistency check

Zheng Wang <zyytlz.wz@163.com>
    scsi: message: mptlan: Fix use after free bug in mptlan_remove() due to race condition

Eli Cohen <elic@nvidia.com>
    lib: cpu_rmap: Avoid use after free on rmap->obj array entries

Nick Child <nnac123@linux.ibm.com>
    net: Catch invalid index in XPS mapping

Nathan Chancellor <nathan@kernel.org>
    net: pasemi: Fix return type of pasemi_mac_start_tx()

Jan Kara <jack@suse.cz>
    ext2: Check block size validity during mount

Hector Martin <marcan@marcan.st>
    wifi: brcmfmac: cfg80211: Pass the PMK in binary instead of hex

void0red <30990023+void0red@users.noreply.github.com>
    ACPICA: ACPICA: check null return of ACPI_ALLOCATE_ZEROED in acpi_db_display_objects

Tamir Duberstein <tamird@google.com>
    ACPICA: Avoid undefined behavior: applying zero offset to null pointer

Nur Hussein <hussein@unixcat.org>
    drm/tegra: Avoid potential 32-bit integer overflow

Armin Wolf <W_Armin@gmx.de>
    ACPI: EC: Fix oops when removing custom query handlers

Pierre Gondois <pierre.gondois@arm.com>
    firmware: arm_sdei: Fix sleep from invalid context BUG

Zheng Wang <zyytlz.wz@163.com>
    memstick: r592: Fix UAF bug in r592_remove due to race condition

Alexander Stein <alexander.stein@ew.tq-group.com>
    regmap: cache: Return error in cache sync operations for REGCACHE_NONE

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Use DC_LOG_DC in the trasform pixel function

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fs: hfsplus: remove WARN_ON() from hfsplus_cat_{read,write}_inode()

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix data races around sk->sk_shutdown.

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix a data race of sk->sk_receive_queue->qlen.

Eric Dumazet <edumazet@google.com>
    net: datagram: fix data-races in datagram_poll()

t.feng <fengtao40@huawei.com>
    ipvlan:Fix out-of-bounds caused by unclear skb->cb

Eric Dumazet <edumazet@google.com>
    tcp: add annotations around sk->sk_shutdown accesses

Paolo Abeni <pabeni@redhat.com>
    tcp: factor out __tcp_close() helper

Soheil Hassas Yeganeh <soheil@google.com>
    tcp: return EPOLLOUT from tcp_poll only when notsent_bytes is half the limit

Eric Dumazet <edumazet@google.com>
    tcp: reduce POLLOUT events caused by TCP_NOTSENT_LOWAT

Eric Dumazet <edumazet@google.com>
    net: annotate sk->sk_err write from do_recvmmsg()

Eric Dumazet <edumazet@google.com>
    netlink: annotate accesses to nlk->cb_running

Kuniyuki Iwashima <kuniyu@amazon.com>
    net: Fix load-tearing on sk->sk_stamp in sock_recv_cmsgs().


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/m68k/kernel/signal.c                          |  14 +-
 arch/parisc/include/asm/cacheflush.h               |   5 +
 arch/parisc/kernel/cache.c                         |   5 +-
 arch/parisc/kernel/process.c                       |  11 +-
 arch/x86/include/asm/intel-family.h                |   5 +
 arch/x86/kernel/dumpstack.c                        |   7 +-
 arch/x86/mm/init.c                                 |  25 ++
 drivers/acpi/acpica/dbnames.c                      |   3 +
 drivers/acpi/acpica/dswstate.c                     |  11 +-
 drivers/acpi/ec.c                                  |   1 +
 drivers/base/platform.c                            |  20 ++
 drivers/base/regmap/regcache.c                     |   6 +
 drivers/char/tpm/tpm_tis.c                         |  16 +
 drivers/clk/tegra/clk-tegra20.c                    |  28 +-
 drivers/firmware/arm_sdei.c                        |  37 +--
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |   5 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.h            |   4 +-
 drivers/gpu/drm/tegra/sor.c                        |   2 +-
 drivers/hid/hid-logitech-hidpp.c                   |  53 +++-
 drivers/hid/wacom.h                                |   3 +
 drivers/hid/wacom_sys.c                            |   2 +
 drivers/hid/wacom_wac.c                            |  72 +++--
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   2 +-
 drivers/input/joystick/xpad.c                      |   5 +-
 drivers/mcb/mcb-pci.c                              |  27 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c |   2 +-
 drivers/media/radio/radio-shark.c                  |  10 +
 drivers/media/radio/radio-shark2.c                 |  10 +
 drivers/memstick/host/r592.c                       |   2 +-
 drivers/message/fusion/mptlan.c                    |   2 +
 drivers/mfd/dln2.c                                 |   1 +
 drivers/net/ethernet/3com/3c589_cs.c               |  11 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   9 +-
 drivers/net/ethernet/freescale/fec_main.c          |  13 +-
 drivers/net/ethernet/intel/igb/e1000_mac.c         |   4 +-
 drivers/net/ethernet/nvidia/forcedeth.c            |   1 +
 drivers/net/ethernet/pasemi/pasemi_mac.c           |   2 +-
 drivers/net/ethernet/sun/cassini.c                 |   2 +
 drivers/net/ipvlan/ipvlan_core.c                   |   6 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  13 +-
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c       |   5 +-
 drivers/phy/st/phy-miphy28lp.c                     |  42 +--
 drivers/power/supply/bq27xxx_battery.c             |  41 +--
 drivers/power/supply/bq27xxx_battery_i2c.c         |   3 +-
 drivers/power/supply/power_supply_leds.c           |   5 +-
 drivers/power/supply/sbs-charger.c                 |   2 +-
 drivers/s390/cio/qdio.h                            |  25 +-
 drivers/s390/cio/qdio_main.c                       |  62 ++--
 drivers/spi/spi-fsl-cpm.c                          |  23 ++
 drivers/spi/spi-fsl-spi.c                          |  65 +++--
 drivers/spi/spi-imx.c                              |  24 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |   5 -
 drivers/tty/serial/8250/8250_core.c                |   1 +
 drivers/tty/serial/8250/8250_pci.c                 |   5 +
 drivers/tty/serial/arc_uart.c                      |   7 +-
 drivers/tty/vt/vc_screen.c                         |  57 ++--
 drivers/usb/core/usb.c                             |  76 +++++
 drivers/usb/gadget/function/u_ether.c              |  39 +--
 drivers/usb/misc/sisusbvga/sisusb.c                |  14 +
 drivers/usb/storage/scsiglue.c                     |  28 +-
 drivers/usb/typec/altmodes/displayport.c           |   4 +
 drivers/usb/typec/tcpm.c                           |  16 +-
 drivers/xen/pvcalls-back.c                         |   9 +-
 fs/btrfs/disk-io.c                                 |   9 +
 fs/btrfs/free-space-cache.c                        |   7 +-
 fs/btrfs/inode.c                                   |  12 +-
 fs/ceph/snap.c                                     |  13 +
 fs/ext2/ext2.h                                     |   1 +
 fs/ext2/super.c                                    |   7 +
 fs/ext4/mballoc.c                                  |  65 +++--
 fs/f2fs/checkpoint.c                               |  12 +-
 fs/f2fs/data.c                                     |   3 +-
 fs/gfs2/glops.c                                    |   3 +-
 fs/hfsplus/inode.c                                 |  28 +-
 fs/nilfs2/inode.c                                  |  18 ++
 fs/statfs.c                                        |   4 +-
 include/linux/cpuhotplug.h                         |   1 -
 include/linux/platform_device.h                    |   3 +
 include/linux/power/bq27xxx_battery.h              |   1 +
 include/linux/sched/task_stack.h                   |   2 +-
 include/linux/string_helpers.h                     |  15 +
 include/linux/usb.h                                |   5 +
 include/net/ip6_tunnel.h                           |   2 +-
 include/net/ip_tunnels.h                           |   2 +-
 include/net/netfilter/nf_tables.h                  |  15 +-
 include/net/netfilter/nf_tables_core.h             |   9 +-
 include/net/netfilter/nft_fib.h                    |   2 +-
 include/net/netfilter/nft_masq.h                   |   4 +-
 include/net/netfilter/nft_redir.h                  |   4 +-
 include/net/sock.h                                 |  22 +-
 include/net/tcp.h                                  |   9 +-
 include/uapi/sound/skl-tplg-interface.h            |   3 +-
 kernel/bpf/verifier.c                              |   2 +-
 lib/cpu_rmap.c                                     |   5 +-
 net/8021q/vlan_dev.c                               |   4 +-
 net/bluetooth/l2cap_core.c                         |   1 -
 net/core/datagram.c                                |  15 +-
 net/core/dev.c                                     |   2 +
 net/core/skbuff.c                                  |   4 +-
 net/core/stream.c                                  |   2 +-
 net/ipv4/af_inet.c                                 |   2 +-
 net/ipv4/ip_gre.c                                  |   6 +-
 net/ipv4/netfilter/nft_dup_ipv4.c                  |  18 +-
 net/ipv4/tcp.c                                     |  27 +-
 net/ipv4/tcp_input.c                               |   4 +-
 net/ipv4/udplite.c                                 |   2 +
 net/ipv6/exthdrs_core.c                            |   2 +
 net/ipv6/ip6_gre.c                                 |  36 ++-
 net/ipv6/netfilter/nft_dup_ipv6.c                  |  18 +-
 net/ipv6/udplite.c                                 |   2 +
 net/key/af_key.c                                   |  12 +-
 net/netfilter/nf_tables_api.c                      | 228 ++++++++++-----
 net/netfilter/nft_bitwise.c                        |  14 +-
 net/netfilter/nft_byteorder.c                      |  14 +-
 net/netfilter/nft_cmp.c                            |   8 +-
 net/netfilter/nft_ct.c                             |  12 +-
 net/netfilter/nft_dup_netdev.c                     |   6 +-
 net/netfilter/nft_dynset.c                         |  12 +-
 net/netfilter/nft_exthdr.c                         |  14 +-
 net/netfilter/nft_fib.c                            |   5 +-
 net/netfilter/nft_fwd_netdev.c                     |  18 +-
 net/netfilter/nft_hash.c                           |  25 +-
 net/netfilter/nft_immediate.c                      |   6 +-
 net/netfilter/nft_lookup.c                         |  14 +-
 net/netfilter/nft_masq.c                           |  14 +-
 net/netfilter/nft_meta.c                           |  12 +-
 net/netfilter/nft_nat.c                            |  35 +--
 net/netfilter/nft_numgen.c                         |  15 +-
 net/netfilter/nft_objref.c                         |   6 +-
 net/netfilter/nft_osf.c                            |   8 +-
 net/netfilter/nft_payload.c                        |  10 +-
 net/netfilter/nft_queue.c                          |  12 +-
 net/netfilter/nft_range.c                          |   6 +-
 net/netfilter/nft_redir.c                          |  14 +-
 net/netfilter/nft_rt.c                             |   7 +-
 net/netfilter/nft_socket.c                         |   7 +-
 net/netfilter/nft_tproxy.c                         |  14 +-
 net/netfilter/nft_tunnel.c                         |   8 +-
 net/netlink/af_netlink.c                           |   8 +-
 net/nsh/nsh.c                                      |   8 +-
 net/socket.c                                       |   2 +-
 net/unix/af_unix.c                                 |  22 +-
 net/vmw_vsock/af_vsock.c                           |   2 +-
 scripts/recordmcount.c                             |   6 +-
 sound/pci/hda/hda_generic.c                        |   7 +-
 sound/pci/hda/patch_ca0132.c                       |   1 +
 sound/pci/hda/patch_hdmi.c                         |   5 +
 sound/pci/hda/patch_realtek.c                      | 324 +++++++++++++++++----
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |  31 +-
 tools/testing/selftests/memfd/fuse_test.c          |   1 +
 152 files changed, 1634 insertions(+), 797 deletions(-)


