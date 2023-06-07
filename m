Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD281726ACF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjFGUU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjFGUUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E08B2122;
        Wed,  7 Jun 2023 13:19:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 006E3643A1;
        Wed,  7 Jun 2023 20:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB70CC433D2;
        Wed,  7 Jun 2023 20:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169161;
        bh=OAGFqUd4/rBVMwGN9fnvbbjnNyAmRXQ2WgMWS3nnCjk=;
        h=From:To:Cc:Subject:Date:From;
        b=2aT4C8Qa6N4jpAFyUhdDXvN5aH7zW4qzE/rR/bNXO9SC7RJfHj4hQf7ROCZc8guy0
         l1hcT+HIu9UdoCUKGaQ4pijw4GWecnClqN2JEPsKuKlSDTbl9oIKrU4fsH5Zny47NY
         vjOkTkWTVE5L/DMZL9KbsC/j0IIgwdiwMllUj+hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 4.14 00/61] 4.14.317-rc1 review
Date:   Wed,  7 Jun 2023 22:15:14 +0200
Message-ID: <20230607200835.310274198@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.317-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.317-rc1
X-KernelTest-Deadline: 2023-06-09T20:08+00:00
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

This is the start of the stable review cycle for the 4.14.317 release.
There are 61 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.317-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.317-rc1

Ping-Ke Shih <pkshih@realtek.com>
    wifi: rtlwifi: 8192de: correct checking of IQK reload

Al Viro <viro@zeniv.linux.org.uk>
    Fix double fget() in vhost_net_set_backend()

Tudor Ambarus <tudor.ambarus@linaro.org>
    net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize

Alexander Bersenev <bay@hackerdom.ru>
    cdc_ncm: Fix the build warning

Alexander Bersenev <bay@hackerdom.ru>
    cdc_ncm: Implement the 32-bit version of NCM Transfer Block

Ben Hutchings <benh@debian.org>
    scsi: dpt_i2o: Do not process completions with invalid addresses

Ben Hutchings <benh@debian.org>
    scsi: dpt_i2o: Remove broken pass-through ioctl (I2OUSERCMD)

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
    regulator: da905{2,5}: Remove unnecessary array check

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

Marek Vasut <marex@denx.de>
    iio: dac: mcp4725: Fix i2c_master_send() return value handling

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    HID: wacom: avoid integer overflow in wacom_intuos_inout()

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

Yun Lu <luyun@kylinos.cn>
    wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value

Hyunwoo Kim <v4bel@theori.io>
    media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221

Takashi Iwai <tiwai@suse.de>
    media: dvb-core: Fix kernel WARNING for blocking operation in wait_event*()

Hyunwoo Kim <imv4bel@gmail.com>
    media: ttusb-dec: fix memory leak in ttusb_dec_exit_dvb()

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

Paweł Anikiel <pan@semihalf.com>
    ASoC: ssm2602: Add workaround for playback distortions

Maxim Kochetkov <fido_max@inbox.ru>
    ASoC: dwc: limit the number of overrun messages

Ivan Orlov <ivan.orlov0322@gmail.com>
    nbd: Fix debugfs_create_dir error checking

Helge Deller <deller@gmx.de>
    fbdev: stifb: Fix info entry in sti_struct on error path

Helge Deller <deller@gmx.de>
    fbdev: modedb: Add 1920x1080 at 60 Hz video mode

Haibo Li <haibo.li@mediatek.com>
    ARM: 9295/1: unwind:fix unwind abort for uleb128 case

Lee Jones <lee@kernel.org>
    mailbox: mailbox-test: Fix potential double-free in mbox_test_message_write()

Andreas Svensson <andreas.svensson@axis.com>
    net: dsa: mv88e6xxx: Increase wait after reset deactivation

Vladislav Efanov <VEfanov@ispras.ru>
    udp6: Fix race condition in udp6_sendmsg & connect

Cambda Zhu <cambda@linux.alibaba.com>
    tcp: Return user_mss for TCP_MAXSEG in CLOSE/LISTEN state if user_mss set

Eric Dumazet <edumazet@google.com>
    af_packet: do not use READ_ONCE() in packet_bind()

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_packet: Fix data-races of pkt_sk(sk)->num.

Eric Dumazet <edumazet@google.com>
    netrom: fix info-leak in nr_write_internal()

Randy Dunlap <rdunlap@infradead.org>
    dmaengine: pl330: rename _start to prevent build error

Ruihan Li <lrh2000@pku.edu.cn>
    bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()

Cezary Rojewski <cezary.rojewski@intel.com>
    ASoC: Intel: Skylake: Fix declaration of enum skl_ch_cfg

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize


-------------

Diffstat:

 Makefile                                           |   8 +-
 arch/arm/kernel/unwind.c                           |  25 +-
 arch/x86/boot/boot.h                               |  36 +-
 arch/x86/boot/main.c                               |   2 +-
 drivers/acpi/thermal.c                             |   2 -
 drivers/ata/libata-scsi.c                          |  34 +-
 drivers/block/nbd.c                                |   4 +-
 drivers/dma/pl330.c                                |   8 +-
 drivers/hid/wacom_wac.c                            |   2 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |  10 +-
 drivers/iio/dac/mcp4725.c                          |  16 +-
 drivers/mailbox/mailbox-test.c                     |  13 +-
 drivers/media/dvb-core/dvb_ca_en50221.c            |  37 +-
 drivers/media/dvb-core/dvb_frontend.c              |  16 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c |  17 +-
 drivers/media/usb/dvb-usb-v2/ce6230.c              |   8 +
 drivers/media/usb/dvb-usb-v2/ec168.c               |  12 +
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c            |  20 +
 drivers/media/usb/dvb-usb/az6027.c                 |  12 +
 drivers/media/usb/dvb-usb/digitv.c                 |   4 +
 drivers/media/usb/dvb-usb/dw2102.c                 |   2 +-
 drivers/media/usb/ttusb-dec/ttusb_dec.c            |   3 +-
 drivers/mmc/host/vub300.c                          |   3 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |   2 +-
 drivers/net/ethernet/sun/cassini.c                 |   4 +-
 drivers/net/usb/cdc_ncm.c                          | 435 ++++++++++++++++-----
 drivers/net/usb/huawei_cdc_ncm.c                   |   8 +-
 drivers/net/usb/qmi_wwan.c                         |   2 +-
 drivers/net/wireless/broadcom/b43/b43.h            |   2 +-
 .../net/wireless/broadcom/b43legacy/b43legacy.h    |   2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   4 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |  10 +-
 drivers/power/supply/bq27xxx_battery.c             |   4 +-
 drivers/regulator/da9052-regulator.c               |   2 +-
 drivers/regulator/da9055-regulator.c               |   2 +-
 drivers/scsi/Kconfig                               |   2 +-
 drivers/scsi/dpt_i2o.c                             | 262 +------------
 drivers/scsi/dpti.h                                |   1 -
 drivers/scsi/scsi_lib.c                            |   2 +
 drivers/scsi/stex.c                                |   4 +
 drivers/tty/serial/fsl_lpuart.c                    |  44 ++-
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 drivers/vhost/net.c                                |  15 +-
 drivers/video/fbdev/core/bitblit.c                 |   3 +
 drivers/video/fbdev/core/modedb.c                  |   5 +
 drivers/video/fbdev/stifb.c                        |   1 +
 fs/ext4/ext4.h                                     |   2 +
 fs/ext4/xattr.c                                    |   4 +
 include/linux/usb/cdc_ncm.h                        |  15 +-
 kernel/extable.c                                   |   3 +-
 lib/dynamic_debug.c                                |   2 +-
 net/atm/resources.c                                |   2 +
 net/bluetooth/hci_sock.c                           |  28 ++
 net/core/sock.c                                    |   2 +-
 net/ipv4/tcp.c                                     |   3 +-
 net/netfilter/nf_conntrack_netlink.c               |   4 +
 net/netrom/nr_subr.c                               |   7 +-
 net/packet/af_packet.c                             |   8 +-
 net/packet/diag.c                                  |   2 +-
 security/selinux/Makefile                          |   6 +-
 sound/core/oss/pcm_plugin.h                        |  16 +-
 sound/soc/codecs/ssm2602.c                         |  15 +
 sound/soc/dwc/dwc-i2s.c                            |   4 +-
 sound/soc/intel/skylake/skl-tplg-interface.h       |   3 +-
 65 files changed, 748 insertions(+), 491 deletions(-)


