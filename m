Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36FC729425
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbjFIJFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240766AbjFIJFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:05:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A411A2;
        Fri,  9 Jun 2023 02:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7295764C4D;
        Fri,  9 Jun 2023 09:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FAFC433EF;
        Fri,  9 Jun 2023 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686301518;
        bh=+qOCLyNoLukmL9HG0OVBJ/7vftDW+oa6a+/BzEr9ifY=;
        h=From:To:Cc:Subject:Date:From;
        b=lUlXZdg56Qw5dIBK4CbIyAcSiNVOJZpq+NgYeqg9d2DdwzhmnGDvILb7KGxvDIpoY
         nD4l5fk8PIIorKVsy7OR3EmQ4PtSzYNBp4CFdsyICbeu6qIfGadixcKzvyXfqR9UFW
         p5ReD5Y1sRDIQEjnACP1af9kgwJrfrqJCKZDYpVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.285
Date:   Fri,  9 Jun 2023 11:05:12 +0200
Message-ID: <2023060912-blurred-battering-3319@gregkh>
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

I'm announcing the release of the 4.19.285 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                 |    6 
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi                   |   82 ++
 arch/arm/kernel/unwind.c                                 |   25 
 arch/arm64/mm/fault.c                                    |    4 
 arch/x86/boot/boot.h                                     |   36 -
 arch/x86/boot/main.c                                     |    2 
 drivers/acpi/thermal.c                                   |    2 
 drivers/ata/libata-scsi.c                                |   34 -
 drivers/base/regmap/regmap.c                             |    6 
 drivers/block/nbd.c                                      |    4 
 drivers/dma/pl330.c                                      |    8 
 drivers/hid/hid-google-hammer.c                          |    2 
 drivers/hid/hid-ids.h                                    |    1 
 drivers/hid/wacom_wac.c                                  |    2 
 drivers/hwmon/scmi-hwmon.c                               |    2 
 drivers/iio/adc/mxs-lradc-adc.c                          |   10 
 drivers/iio/dac/Makefile                                 |    2 
 drivers/iio/dac/mcp4725.c                                |   16 
 drivers/mailbox/mailbox-test.c                           |   13 
 drivers/media/dvb-core/dvb_ca_en50221.c                  |   49 +
 drivers/media/dvb-core/dvb_demux.c                       |    4 
 drivers/media/dvb-core/dvb_frontend.c                    |   16 
 drivers/media/dvb-core/dvb_net.c                         |   38 +
 drivers/media/dvb-frontends/mn88443x.c                   |    2 
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c       |   17 
 drivers/media/platform/rcar-vin/rcar-dma.c               |    1 
 drivers/media/usb/dvb-usb-v2/ce6230.c                    |    8 
 drivers/media/usb/dvb-usb-v2/ec168.c                     |   12 
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c                  |   20 
 drivers/media/usb/dvb-usb/az6027.c                       |   12 
 drivers/media/usb/dvb-usb/digitv.c                       |    4 
 drivers/media/usb/dvb-usb/dw2102.c                       |    2 
 drivers/media/usb/ttusb-dec/ttusb_dec.c                  |    3 
 drivers/mmc/host/vub300.c                                |    3 
 drivers/net/dsa/mv88e6xxx/chip.c                         |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                |   12 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h         |    1 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c |    2 
 drivers/net/ethernet/sun/cassini.c                       |    4 
 drivers/net/usb/cdc_ncm.c                                |  435 +++++++++++----
 drivers/net/usb/huawei_cdc_ncm.c                         |    8 
 drivers/net/usb/qmi_wwan.c                               |    2 
 drivers/net/wireless/broadcom/b43/b43.h                  |    2 
 drivers/net/wireless/broadcom/b43legacy/b43legacy.h      |    2 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h         |    1 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c    |    4 
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c     |   10 
 drivers/net/wireless/rsi/rsi_91x_mac80211.c              |    2 
 drivers/power/supply/bq24190_charger.c                   |   13 
 drivers/power/supply/bq27xxx_battery.c                   |    4 
 drivers/power/supply/power_supply_core.c                 |   57 +
 drivers/regulator/da9052-regulator.c                     |    2 
 drivers/regulator/da9055-regulator.c                     |    2 
 drivers/scsi/Kconfig                                     |    2 
 drivers/scsi/dpt_i2o.c                                   |  269 ---------
 drivers/scsi/dpti.h                                      |    1 
 drivers/scsi/scsi_lib.c                                  |    2 
 drivers/scsi/stex.c                                      |    4 
 drivers/tty/serial/fsl_lpuart.c                          |   44 -
 drivers/usb/gadget/function/f_fs.c                       |    2 
 drivers/video/fbdev/core/bitblit.c                       |    3 
 drivers/video/fbdev/core/modedb.c                        |    5 
 drivers/video/fbdev/stifb.c                              |    1 
 drivers/watchdog/menz69_wdt.c                            |   16 
 fs/ext4/ext4.h                                           |    2 
 fs/ext4/xattr.c                                          |    4 
 fs/ocfs2/dlm/dlmcommon.h                                 |    4 
 include/linux/bitops.h                                   |    1 
 include/linux/power_supply.h                             |    5 
 include/linux/usb/cdc_ncm.h                              |   15 
 include/media/dvb_net.h                                  |    4 
 include/net/ip.h                                         |    2 
 include/net/sock.h                                       |    4 
 include/uapi/linux/in.h                                  |    2 
 kernel/extable.c                                         |    3 
 lib/dynamic_debug.c                                      |    2 
 net/atm/resources.c                                      |    2 
 net/bluetooth/hci_sock.c                                 |   28 
 net/core/sock.c                                          |    2 
 net/ipv4/af_inet.c                                       |    2 
 net/ipv4/inet_connection_sock.c                          |    1 
 net/ipv4/ip_sockglue.c                                   |   12 
 net/ipv4/raw.c                                           |    5 
 net/ipv4/tcp.c                                           |    9 
 net/ipv6/raw.c                                           |    3 
 net/netfilter/nf_conntrack_netlink.c                     |   12 
 net/netlink/af_netlink.c                                 |    2 
 net/netrom/nr_subr.c                                     |    7 
 net/packet/af_packet.c                                   |    8 
 net/packet/diag.c                                        |    2 
 net/sched/cls_flower.c                                   |    3 
 net/sched/sch_api.c                                      |   16 
 net/sched/sch_ingress.c                                  |   16 
 net/xfrm/xfrm_policy.c                                   |   11 
 security/selinux/Makefile                                |    6 
 sound/core/oss/pcm_plugin.h                              |   16 
 sound/soc/codecs/ssm2602.c                               |   15 
 sound/soc/dwc/dwc-i2s.c                                  |    4 
 98 files changed, 1017 insertions(+), 575 deletions(-)

Adam Borowski (1):
      ACPI: thermal: drop an always true check

Alexander Bersenev (2):
      cdc_ncm: Implement the 32-bit version of NCM Transfer Block
      cdc_ncm: Fix the build warning

Andreas Svensson (1):
      net: dsa: mv88e6xxx: Increase wait after reset deactivation

Andy Shevchenko (1):
      ocfs2/dlm: move BITS_TO_BYTES() to bitops.h for wider use

Arnd Bergmann (3):
      wifi: b43: fix incorrect __packed annotation
      ALSA: oss: avoid missing-prototype warnings
      atm: hide unused procfs functions

Bart Van Assche (1):
      scsi: stex: Fix gcc 13 warnings

Ben Hutchings (2):
      scsi: dpt_i2o: Remove broken pass-through ioctl (I2OUSERCMD)
      scsi: dpt_i2o: Do not process completions with invalid addresses

Benedict Wong (1):
      xfrm: Check if_id in inbound policy/secpath match

Cambda Zhu (1):
      tcp: Return user_mss for TCP_MAXSEG in CLOSE/LISTEN state if user_mss set

Damien Le Moal (1):
      ata: libata-scsi: Use correct device no in ata_find_dev()

Dan Carpenter (1):
      mailbox: mailbox-test: fix a locking issue in mbox_test_message_write()

Dario Binacchi (1):
      ARM: dts: stm32: add pin map for CAN controller on stm32f7

Deren Wu (1):
      mmc: vub300: fix invalid response handling

Eric Dumazet (3):
      netrom: fix info-leak in nr_write_internal()
      af_packet: do not use READ_ONCE() in packet_bind()
      tcp: deny tcp_disconnect() when threads are waiting

Greg Kroah-Hartman (1):
      Linux 4.19.285

Haibo Li (1):
      ARM: 9295/1: unwind:fix unwind abort for uleb128 case

Hangyu Hua (1):
      net/sched: flower: fix possible OOB write in fl_set_geneve_opt()

Hans de Goede (3):
      power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize
      power: supply: core: Refactor power_supply_set_input_current_limit_from_supplier()
      power: supply: bq24190: Call power_supply_changed() after updating input current

Helge Deller (3):
      fbdev: modedb: Add 1920x1080 at 60 Hz video mode
      fbdev: stifb: Fix info entry in sti_struct on error path
      fbcon: Fix null-ptr-deref in soft_cursor

Hyunwoo Kim (3):
      media: ttusb-dec: fix memory leak in ttusb_dec_exit_dvb()
      media: dvb-core: Fix use-after-free due on race condition at dvb_net
      media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221

Ivan Orlov (1):
      nbd: Fix debugfs_create_dir error checking

Jakub Kicinski (1):
      wifi: rtlwifi: remove always-true condition pointed out by GCC 12

Jiakai Luo (1):
      iio: adc: mxs-lradc: fix the order of two cleanup operations

Jim Wylder (1):
      regmap: Account for register length when chunking

Johannes Thumshirn (1):
      watchdog: menz069_wdt: fix watchdog initialisation

Kees Cook (1):
      x86/boot: Wrap literal addresses in absolute_pointer()

Krzysztof Kozlowski (1):
      media: mn88443x: fix !CONFIG_OF error by drop of_match_ptr from ID table

Kuniyuki Iwashima (1):
      af_packet: Fix data-races of pkt_sk(sk)->num.

Lee Jones (1):
      mailbox: mailbox-test: Fix potential double-free in mbox_test_message_write()

Linus Torvalds (1):
      gcc-12: disable '-Wdangling-pointer' warning for now

Lukas Bulwahn (1):
      iio: dac: build ad5758 driver when AD5758 is selected

Marek Vasut (1):
      iio: dac: mcp4725: Fix i2c_master_send() return value handling

Martin Liška (1):
      eth: sun: cassini: remove dead code

Maxim Kochetkov (1):
      ASoC: dwc: limit the number of overrun messages

Min-Hua Chen (1):
      arm64/mm: mark private VM_FAULT_X defines as vm_fault_t

Nathan Chancellor (5):
      kernel/extable.c: use address-of operator on section symbols
      lib/dynamic_debug.c: use address-of operator on section symbols
      hwmon: (scmi) Remove redundant pointer check
      regulator: da905{2,5}: Remove unnecessary array check
      rsi: Remove unnecessary boolean condition

Nicolas Dichtel (1):
      ipv{4,6}/raw: fix output xfrm lookup wrt protocol

Nikita Zhandarovich (1):
      HID: wacom: avoid integer overflow in wacom_intuos_inout()

Niklas Söderlund (1):
      media: rcar-vin: Select correct interrupt mode for V4L2_FIELD_ALTERNATE

Paul Blakey (1):
      netfilter: ctnetlink: Support offloaded conntrack entry deletion

Paul Moore (1):
      selinux: don't use make's grouped targets feature yet

Paweł Anikiel (1):
      ASoC: ssm2602: Add workaround for playback distortions

Pedro Tammela (1):
      net/netlink: fix NETLINK_LIST_MEMBERSHIPS length report

Peilin Ye (4):
      net/sched: sch_ingress: Only create under TC_H_INGRESS
      net/sched: sch_clsact: Only create under TC_H_CLSACT
      net/sched: Reserve TC_H_INGRESS (TC_H_CLSACT) for ingress (clsact) Qdiscs
      net/sched: Prohibit regrafting ingress or clsact Qdiscs

Ping-Ke Shih (1):
      wifi: rtlwifi: 8192de: correct checking of IQK reload

Raju Rangoju (1):
      amd-xgbe: fix the false linkup in xgbe_phy_status

Randy Dunlap (1):
      dmaengine: pl330: rename _start to prevent build error

Ruihan Li (1):
      bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()

Sebastian Krzyszkowiak (1):
      net: usb: qmi_wwan: Set DTR quirk for BroadMobi BM818

Shay Drory (1):
      net/mlx5: fw_tracer, Fix event handling

Sherry Sun (1):
      tty: serial: fsl_lpuart: use UARTCTRL_TXINV to send break instead of UARTCTRL_SBK

Sung-Chi Li (1):
      HID: google: add jewel USB id

Takashi Iwai (1):
      media: dvb-core: Fix kernel WARNING for blocking operation in wait_event*()

Theodore Ts'o (1):
      ext4: add lockdep annotations for i_data_sem for ea_inode's

Tom Rix (1):
      netfilter: conntrack: define variables exp_nat_nla_policy and any_addr with CONFIG_NF_NAT

Tudor Ambarus (1):
      net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize

Uttkarsh Aggarwal (1):
      usb: gadget: f_fs: Add unbind event before functionfs_unbind

Vladislav Efanov (1):
      udp6: Fix race condition in udp6_sendmsg & connect

Wei Chen (6):
      media: dvb-usb: az6027: fix three null-ptr-deref in az6027_i2c_xfer()
      media: dvb-usb-v2: ec168: fix null-ptr-deref in ec168_i2c_xfer()
      media: dvb-usb-v2: ce6230: fix null-ptr-deref in ce6230_i2c_master_xfer()
      media: dvb-usb: digitv: fix null-ptr-deref in digitv_i2c_xfer()
      media: dvb-usb: dw2102: fix uninit-value in su3000_read_mac_address
      media: netup_unidvb: fix irq init by register it at the end of probe

Wenchao Hao (1):
      scsi: core: Decrease scsi_device's iorequest_cnt if dispatch failed

YongSu Yoo (2):
      media: dvb_demux: fix a bug for the continuity counter
      media: dvb_ca_en50221: fix a size write bug

Yun Lu (1):
      wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value

Zhang Shurong (1):
      media: dvb-usb-v2: rtl28xxu: fix null-ptr-deref in rtl28xxu_i2c_xfer

Zhengchao Shao (1):
      net: sched: fix NULL pointer dereference in mq_attach

