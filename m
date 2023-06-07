Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5615726C95
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjFGUem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjFGUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:34:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09568211C;
        Wed,  7 Jun 2023 13:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B0D064559;
        Wed,  7 Jun 2023 20:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4B5C433D2;
        Wed,  7 Jun 2023 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170062;
        bh=0R131Xb9AVkbXqbpRlXkPj1EUrV8txlha6/K7r/PujI=;
        h=From:To:Cc:Subject:Date:From;
        b=oHk8YEubXcFS89jDlDA5L8g4HBT//7CpxR2uU/KiI0ieGSsxSAvh0EAKV/vqBDCi8
         WRqSvsUC6iBVpuV68dzU/a6raPd05KmYxfhiYiO2a2najCuadmORG2oUfE5JMO7cZt
         UFbdLX0DfEAeUIKZAoIhUyfSn8xajQusX+esAZLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 4.19 00/88] 4.19.285-rc1 review
Date:   Wed,  7 Jun 2023 22:15:17 +0200
Message-ID: <20230607200854.030202132@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.285-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.285-rc1
X-KernelTest-Deadline: 2023-06-09T20:09+00:00
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

This is the start of the stable review cycle for the 4.19.285 release.
There are 88 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.285-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.285-rc1

Ping-Ke Shih <pkshih@realtek.com>
    wifi: rtlwifi: 8192de: correct checking of IQK reload

Ben Hutchings <benh@debian.org>
    scsi: dpt_i2o: Do not process completions with invalid addresses

Ben Hutchings <benh@debian.org>
    scsi: dpt_i2o: Remove broken pass-through ioctl (I2OUSERCMD)

Jim Wylder <jwylder@google.com>
    regmap: Account for register length when chunking

Helge Deller <deller@gmx.de>
    fbcon: Fix null-ptr-deref in soft_cursor

Theodore Ts'o <tytso@mit.edu>
    ext4: add lockdep annotations for i_data_sem for ea_inode's

Paul Moore <paul@paul-moore.com>
    selinux: don't use make's grouped targets feature yet

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: use UARTCTRL_TXINV to send break instead of UARTCTRL_SBK

Deren Wu <deren.wu@mediatek.com>
    mmc: vub300: fix invalid response handling

Nathan Chancellor <natechancellor@gmail.com>
    rsi: Remove unnecessary boolean condition

Nathan Chancellor <natechancellor@gmail.com>
    regulator: da905{2,5}: Remove unnecessary array check

Nathan Chancellor <natechancellor@gmail.com>
    hwmon: (scmi) Remove redundant pointer check

Jakub Kicinski <kuba@kernel.org>
    wifi: rtlwifi: remove always-true condition pointed out by GCC 12

Nathan Chancellor <natechancellor@gmail.com>
    lib/dynamic_debug.c: use address-of operator on section symbols

Nathan Chancellor <natechancellor@gmail.com>
    kernel/extable.c: use address-of operator on section symbols

Martin Liška <mliska@suse.cz>
    eth: sun: cassini: remove dead code

Linus Torvalds <torvalds@linux-foundation.org>
    gcc-12: disable '-Wdangling-pointer' warning for now

Adam Borowski <kilobyte@angband.pl>
    ACPI: thermal: drop an always true check

Kees Cook <keescook@chromium.org>
    x86/boot: Wrap literal addresses in absolute_pointer()

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-scsi: Use correct device no in ata_find_dev()

Bart Van Assche <bvanassche@acm.org>
    scsi: stex: Fix gcc 13 warnings

Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
    usb: gadget: f_fs: Add unbind event before functionfs_unbind

Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
    net: usb: qmi_wwan: Set DTR quirk for BroadMobi BM818

Lukas Bulwahn <lukas.bulwahn@gmail.com>
    iio: dac: build ad5758 driver when AD5758 is selected

Marek Vasut <marex@denx.de>
    iio: dac: mcp4725: Fix i2c_master_send() return value handling

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    HID: wacom: avoid integer overflow in wacom_intuos_inout()

Sung-Chi Li <lschyi@chromium.org>
    HID: google: add jewel USB id

Jiakai Luo <jkluo@hust.edu.cn>
    iio: adc: mxs-lradc: fix the order of two cleanup operations

Dan Carpenter <dan.carpenter@linaro.org>
    mailbox: mailbox-test: fix a locking issue in mbox_test_message_write()

Arnd Bergmann <arnd@arndb.de>
    atm: hide unused procfs functions

Arnd Bergmann <arnd@arndb.de>
    ALSA: oss: avoid missing-prototype warnings

Tom Rix <trix@redhat.com>
    netfilter: conntrack: define variables exp_nat_nla_policy and any_addr with CONFIG_NF_NAT

Arnd Bergmann <arnd@arndb.de>
    wifi: b43: fix incorrect __packed annotation

Wenchao Hao <haowenchao2@huawei.com>
    scsi: core: Decrease scsi_device's iorequest_cnt if dispatch failed

Min-Hua Chen <minhuadotchen@gmail.com>
    arm64/mm: mark private VM_FAULT_X defines as vm_fault_t

Dario Binacchi <dario.binacchi@amarulasolutions.com>
    ARM: dts: stm32: add pin map for CAN controller on stm32f7

Yun Lu <luyun@kylinos.cn>
    wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value

Hyunwoo Kim <v4bel@theori.io>
    media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221

Takashi Iwai <tiwai@suse.de>
    media: dvb-core: Fix kernel WARNING for blocking operation in wait_event*()

Hyunwoo Kim <imv4bel@gmail.com>
    media: dvb-core: Fix use-after-free due on race condition at dvb_net

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    media: mn88443x: fix !CONFIG_OF error by drop of_match_ptr from ID table

Hyunwoo Kim <imv4bel@gmail.com>
    media: ttusb-dec: fix memory leak in ttusb_dec_exit_dvb()

YongSu Yoo <yongsuyoo0215@gmail.com>
    media: dvb_ca_en50221: fix a size write bug

Wei Chen <harperchen1110@gmail.com>
    media: netup_unidvb: fix irq init by register it at the end of probe

Wei Chen <harperchen1110@gmail.com>
    media: dvb-usb: dw2102: fix uninit-value in su3000_read_mac_address

Wei Chen <harperchen1110@gmail.com>
    media: dvb-usb: digitv: fix null-ptr-deref in digitv_i2c_xfer()

Zhang Shurong <zhang_shurong@foxmail.com>
    media: dvb-usb-v2: rtl28xxu: fix null-ptr-deref in rtl28xxu_i2c_xfer

Wei Chen <harperchen1110@gmail.com>
    media: dvb-usb-v2: ce6230: fix null-ptr-deref in ce6230_i2c_master_xfer()

Wei Chen <harperchen1110@gmail.com>
    media: dvb-usb-v2: ec168: fix null-ptr-deref in ec168_i2c_xfer()

Wei Chen <harperchen1110@gmail.com>
    media: dvb-usb: az6027: fix three null-ptr-deref in az6027_i2c_xfer()

YongSu Yoo <yongsuyoo0215@gmail.com>
    media: dvb_demux: fix a bug for the continuity counter

Paweł Anikiel <pan@semihalf.com>
    ASoC: ssm2602: Add workaround for playback distortions

Benedict Wong <benedictwong@google.com>
    xfrm: Check if_id in inbound policy/secpath match

Maxim Kochetkov <fido_max@inbox.ru>
    ASoC: dwc: limit the number of overrun messages

Ivan Orlov <ivan.orlov0322@gmail.com>
    nbd: Fix debugfs_create_dir error checking

Helge Deller <deller@gmx.de>
    fbdev: stifb: Fix info entry in sti_struct on error path

Helge Deller <deller@gmx.de>
    fbdev: modedb: Add 1920x1080 at 60 Hz video mode

Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
    media: rcar-vin: Select correct interrupt mode for V4L2_FIELD_ALTERNATE

Haibo Li <haibo.li@mediatek.com>
    ARM: 9295/1: unwind:fix unwind abort for uleb128 case

Lee Jones <lee@kernel.org>
    mailbox: mailbox-test: Fix potential double-free in mbox_test_message_write()

Johannes Thumshirn <jth@kernel.org>
    watchdog: menz069_wdt: fix watchdog initialisation

Andreas Svensson <andreas.svensson@axis.com>
    net: dsa: mv88e6xxx: Increase wait after reset deactivation

Hangyu Hua <hbh25y@gmail.com>
    net/sched: flower: fix possible OOB write in fl_set_geneve_opt()

Vladislav Efanov <VEfanov@ispras.ru>
    udp6: Fix race condition in udp6_sendmsg & connect

Pedro Tammela <pctammela@mojatatu.com>
    net/netlink: fix NETLINK_LIST_MEMBERSHIPS length report

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    ocfs2/dlm: move BITS_TO_BYTES() to bitops.h for wider use

Zhengchao Shao <shaozhengchao@huawei.com>
    net: sched: fix NULL pointer dereference in mq_attach

Peilin Ye <peilin.ye@bytedance.com>
    net/sched: Prohibit regrafting ingress or clsact Qdiscs

Peilin Ye <peilin.ye@bytedance.com>
    net/sched: Reserve TC_H_INGRESS (TC_H_CLSACT) for ingress (clsact) Qdiscs

Peilin Ye <peilin.ye@bytedance.com>
    net/sched: sch_clsact: Only create under TC_H_CLSACT

Peilin Ye <peilin.ye@bytedance.com>
    net/sched: sch_ingress: Only create under TC_H_INGRESS

Cambda Zhu <cambda@linux.alibaba.com>
    tcp: Return user_mss for TCP_MAXSEG in CLOSE/LISTEN state if user_mss set

Eric Dumazet <edumazet@google.com>
    tcp: deny tcp_disconnect() when threads are waiting

Eric Dumazet <edumazet@google.com>
    af_packet: do not use READ_ONCE() in packet_bind()

Raju Rangoju <Raju.Rangoju@amd.com>
    amd-xgbe: fix the false linkup in xgbe_phy_status

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_packet: Fix data-races of pkt_sk(sk)->num.

Eric Dumazet <edumazet@google.com>
    netrom: fix info-leak in nr_write_internal()

Shay Drory <shayd@nvidia.com>
    net/mlx5: fw_tracer, Fix event handling

Randy Dunlap <rdunlap@infradead.org>
    dmaengine: pl330: rename _start to prevent build error

Paul Blakey <paulb@nvidia.com>
    netfilter: ctnetlink: Support offloaded conntrack entry deletion

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    ipv{4,6}/raw: fix output xfrm lookup wrt protocol

Ruihan Li <lrh2000@pku.edu.cn>
    bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()

Alexander Bersenev <bay@hackerdom.ru>
    cdc_ncm: Fix the build warning

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq24190: Call power_supply_changed() after updating input current

Hans de Goede <hdegoede@redhat.com>
    power: supply: core: Refactor power_supply_set_input_current_limit_from_supplier()

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize

Tudor Ambarus <tudor.ambarus@linaro.org>
    net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize

Alexander Bersenev <bay@hackerdom.ru>
    cdc_ncm: Implement the 32-bit version of NCM Transfer Block


-------------

Diffstat:

 Makefile                                           |   8 +-
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi             |  82 ++++
 arch/arm/kernel/unwind.c                           |  25 +-
 arch/arm64/mm/fault.c                              |   4 +-
 arch/x86/boot/boot.h                               |  36 +-
 arch/x86/boot/main.c                               |   2 +-
 drivers/acpi/thermal.c                             |   2 -
 drivers/ata/libata-scsi.c                          |  34 +-
 drivers/base/regmap/regmap.c                       |   6 +-
 drivers/block/nbd.c                                |   4 +-
 drivers/dma/pl330.c                                |   8 +-
 drivers/hid/hid-google-hammer.c                    |   2 +
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/wacom_wac.c                            |   2 +-
 drivers/hwmon/scmi-hwmon.c                         |   2 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |  10 +-
 drivers/iio/dac/Makefile                           |   2 +-
 drivers/iio/dac/mcp4725.c                          |  16 +-
 drivers/mailbox/mailbox-test.c                     |  13 +-
 drivers/media/dvb-core/dvb_ca_en50221.c            |  49 ++-
 drivers/media/dvb-core/dvb_demux.c                 |   4 +-
 drivers/media/dvb-core/dvb_frontend.c              |  16 +-
 drivers/media/dvb-core/dvb_net.c                   |  38 +-
 drivers/media/dvb-frontends/mn88443x.c             |   2 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c |  17 +-
 drivers/media/platform/rcar-vin/rcar-dma.c         |   1 +
 drivers/media/usb/dvb-usb-v2/ce6230.c              |   8 +
 drivers/media/usb/dvb-usb-v2/ec168.c               |  12 +
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c            |  20 +
 drivers/media/usb/dvb-usb/az6027.c                 |  12 +
 drivers/media/usb/dvb-usb/digitv.c                 |   4 +
 drivers/media/usb/dvb-usb/dw2102.c                 |   2 +-
 drivers/media/usb/ttusb-dec/ttusb_dec.c            |   3 +-
 drivers/mmc/host/vub300.c                          |   3 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  12 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h   |   1 -
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   2 +-
 drivers/net/ethernet/sun/cassini.c                 |   4 +-
 drivers/net/usb/cdc_ncm.c                          | 435 ++++++++++++++++-----
 drivers/net/usb/huawei_cdc_ncm.c                   |   8 +-
 drivers/net/usb/qmi_wwan.c                         |   2 +-
 drivers/net/wireless/broadcom/b43/b43.h            |   2 +-
 .../net/wireless/broadcom/b43legacy/b43legacy.h    |   2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   4 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |  10 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |   2 +-
 drivers/power/supply/bq24190_charger.c             |  13 +-
 drivers/power/supply/bq27xxx_battery.c             |   4 +-
 drivers/power/supply/power_supply_core.c           |  57 +--
 drivers/regulator/da9052-regulator.c               |   2 +-
 drivers/regulator/da9055-regulator.c               |   2 +-
 drivers/scsi/Kconfig                               |   2 +-
 drivers/scsi/dpt_i2o.c                             | 269 +------------
 drivers/scsi/dpti.h                                |   1 -
 drivers/scsi/scsi_lib.c                            |   2 +
 drivers/scsi/stex.c                                |   4 +
 drivers/tty/serial/fsl_lpuart.c                    |  44 ++-
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 drivers/video/fbdev/core/bitblit.c                 |   3 +
 drivers/video/fbdev/core/modedb.c                  |   5 +
 drivers/video/fbdev/stifb.c                        |   1 +
 drivers/watchdog/menz69_wdt.c                      |  16 +-
 fs/ext4/ext4.h                                     |   2 +
 fs/ext4/xattr.c                                    |   4 +
 fs/ocfs2/dlm/dlmcommon.h                           |   4 -
 include/linux/bitops.h                             |   1 +
 include/linux/power_supply.h                       |   5 +-
 include/linux/usb/cdc_ncm.h                        |  15 +-
 include/media/dvb_net.h                            |   4 +
 include/net/ip.h                                   |   2 +
 include/net/sock.h                                 |   4 +
 include/uapi/linux/in.h                            |   2 +
 kernel/extable.c                                   |   3 +-
 lib/dynamic_debug.c                                |   2 +-
 net/atm/resources.c                                |   2 +
 net/bluetooth/hci_sock.c                           |  28 ++
 net/core/sock.c                                    |   2 +-
 net/ipv4/af_inet.c                                 |   2 +
 net/ipv4/inet_connection_sock.c                    |   1 +
 net/ipv4/ip_sockglue.c                             |  12 +-
 net/ipv4/raw.c                                     |   5 +-
 net/ipv4/tcp.c                                     |   9 +-
 net/ipv6/raw.c                                     |   3 +-
 net/netfilter/nf_conntrack_netlink.c               |  12 +-
 net/netlink/af_netlink.c                           |   2 +-
 net/netrom/nr_subr.c                               |   7 +-
 net/packet/af_packet.c                             |   8 +-
 net/packet/diag.c                                  |   2 +-
 net/sched/cls_flower.c                             |   3 +
 net/sched/sch_api.c                                |  16 +-
 net/sched/sch_ingress.c                            |  16 +-
 net/xfrm/xfrm_policy.c                             |  11 +-
 security/selinux/Makefile                          |   6 +-
 sound/core/oss/pcm_plugin.h                        |  16 +-
 sound/soc/codecs/ssm2602.c                         |  15 +
 sound/soc/dwc/dwc-i2s.c                            |   4 +-
 98 files changed, 1018 insertions(+), 576 deletions(-)


