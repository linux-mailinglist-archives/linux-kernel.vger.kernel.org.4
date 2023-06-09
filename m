Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F372942E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbjFIJGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbjFIJFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:05:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88091272A;
        Fri,  9 Jun 2023 02:05:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D04965506;
        Fri,  9 Jun 2023 09:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363ABC433EF;
        Fri,  9 Jun 2023 09:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686301510;
        bh=yw4+bieT7AJCuXqykSf1Bhj5f15bFbxAIdfzMoutoNY=;
        h=From:To:Cc:Subject:Date:From;
        b=ibDCGsCio1NLMn5sYvNeVIrerrYV9J+xGzrzMn4ihh+YgnmeEUydiYbKT4Doq8o5/
         q6KSq0WlKBpYZyubbXPhMeiS/5d9fWtgdXn4SVDxalO1/HiTJYnVsDfeHOjgEiE7IT
         aoxXtDDhXEGjX1KGK19iIeyjhUCpqpQ+WUds/bGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.317
Date:   Fri,  9 Jun 2023 11:05:06 +0200
Message-ID: <2023060906-chevy-throwing-aed3@gregkh>
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

I'm announcing the release of the 4.14.317 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                              |    6 
 arch/arm/kernel/unwind.c                              |   25 -
 arch/x86/boot/boot.h                                  |   36 -
 arch/x86/boot/main.c                                  |    2 
 drivers/acpi/thermal.c                                |    2 
 drivers/ata/libata-scsi.c                             |   34 +
 drivers/block/nbd.c                                   |    4 
 drivers/dma/pl330.c                                   |    8 
 drivers/hid/wacom_wac.c                               |    2 
 drivers/iio/adc/mxs-lradc-adc.c                       |   10 
 drivers/iio/dac/mcp4725.c                             |   16 
 drivers/mailbox/mailbox-test.c                        |   13 
 drivers/media/dvb-core/dvb_ca_en50221.c               |   37 +
 drivers/media/dvb-core/dvb_frontend.c                 |   16 
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c    |   17 
 drivers/media/usb/dvb-usb-v2/ce6230.c                 |    8 
 drivers/media/usb/dvb-usb-v2/ec168.c                  |   12 
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c               |   20 
 drivers/media/usb/dvb-usb/az6027.c                    |   12 
 drivers/media/usb/dvb-usb/digitv.c                    |    4 
 drivers/media/usb/dvb-usb/dw2102.c                    |    2 
 drivers/media/usb/ttusb-dec/ttusb_dec.c               |    3 
 drivers/mmc/host/vub300.c                             |    3 
 drivers/net/dsa/mv88e6xxx/chip.c                      |    2 
 drivers/net/ethernet/sun/cassini.c                    |    4 
 drivers/net/usb/cdc_ncm.c                             |  435 ++++++++++++++----
 drivers/net/usb/huawei_cdc_ncm.c                      |    8 
 drivers/net/usb/qmi_wwan.c                            |    2 
 drivers/net/wireless/broadcom/b43/b43.h               |    2 
 drivers/net/wireless/broadcom/b43legacy/b43legacy.h   |    2 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      |    1 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |    4 
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c  |   10 
 drivers/power/supply/bq27xxx_battery.c                |    4 
 drivers/regulator/da9052-regulator.c                  |    2 
 drivers/regulator/da9055-regulator.c                  |    2 
 drivers/scsi/Kconfig                                  |    2 
 drivers/scsi/dpt_i2o.c                                |  262 ----------
 drivers/scsi/dpti.h                                   |    1 
 drivers/scsi/scsi_lib.c                               |    2 
 drivers/scsi/stex.c                                   |    4 
 drivers/tty/serial/fsl_lpuart.c                       |   44 -
 drivers/usb/gadget/function/f_fs.c                    |    2 
 drivers/vhost/net.c                                   |   15 
 drivers/video/fbdev/core/bitblit.c                    |    3 
 drivers/video/fbdev/core/modedb.c                     |    5 
 drivers/video/fbdev/stifb.c                           |    1 
 fs/ext4/ext4.h                                        |    2 
 fs/ext4/xattr.c                                       |    4 
 include/linux/usb/cdc_ncm.h                           |   15 
 kernel/extable.c                                      |    3 
 lib/dynamic_debug.c                                   |    2 
 net/atm/resources.c                                   |    2 
 net/bluetooth/hci_sock.c                              |   28 +
 net/core/sock.c                                       |    2 
 net/ipv4/tcp.c                                        |    3 
 net/netfilter/nf_conntrack_netlink.c                  |    4 
 net/netrom/nr_subr.c                                  |    7 
 net/packet/af_packet.c                                |    8 
 net/packet/diag.c                                     |    2 
 security/selinux/Makefile                             |    6 
 sound/core/oss/pcm_plugin.h                           |   16 
 sound/soc/codecs/ssm2602.c                            |   15 
 sound/soc/dwc/dwc-i2s.c                               |    4 
 sound/soc/intel/skylake/skl-tplg-interface.h          |    3 
 65 files changed, 747 insertions(+), 490 deletions(-)

Adam Borowski (1):
      ACPI: thermal: drop an always true check

Al Viro (1):
      Fix double fget() in vhost_net_set_backend()

Alexander Bersenev (2):
      cdc_ncm: Implement the 32-bit version of NCM Transfer Block
      cdc_ncm: Fix the build warning

Andreas Svensson (1):
      net: dsa: mv88e6xxx: Increase wait after reset deactivation

Arnd Bergmann (3):
      wifi: b43: fix incorrect __packed annotation
      ALSA: oss: avoid missing-prototype warnings
      atm: hide unused procfs functions

Bart Van Assche (1):
      scsi: stex: Fix gcc 13 warnings

Ben Hutchings (2):
      scsi: dpt_i2o: Remove broken pass-through ioctl (I2OUSERCMD)
      scsi: dpt_i2o: Do not process completions with invalid addresses

Cambda Zhu (1):
      tcp: Return user_mss for TCP_MAXSEG in CLOSE/LISTEN state if user_mss set

Cezary Rojewski (1):
      ASoC: Intel: Skylake: Fix declaration of enum skl_ch_cfg

Damien Le Moal (1):
      ata: libata-scsi: Use correct device no in ata_find_dev()

Dan Carpenter (1):
      mailbox: mailbox-test: fix a locking issue in mbox_test_message_write()

Deren Wu (1):
      mmc: vub300: fix invalid response handling

Eric Dumazet (2):
      netrom: fix info-leak in nr_write_internal()
      af_packet: do not use READ_ONCE() in packet_bind()

Greg Kroah-Hartman (1):
      Linux 4.14.317

Haibo Li (1):
      ARM: 9295/1: unwind:fix unwind abort for uleb128 case

Hans de Goede (1):
      power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize

Helge Deller (3):
      fbdev: modedb: Add 1920x1080 at 60 Hz video mode
      fbdev: stifb: Fix info entry in sti_struct on error path
      fbcon: Fix null-ptr-deref in soft_cursor

Hyunwoo Kim (2):
      media: ttusb-dec: fix memory leak in ttusb_dec_exit_dvb()
      media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221

Ivan Orlov (1):
      nbd: Fix debugfs_create_dir error checking

Jakub Kicinski (1):
      wifi: rtlwifi: remove always-true condition pointed out by GCC 12

Jiakai Luo (1):
      iio: adc: mxs-lradc: fix the order of two cleanup operations

Kees Cook (1):
      x86/boot: Wrap literal addresses in absolute_pointer()

Kuniyuki Iwashima (1):
      af_packet: Fix data-races of pkt_sk(sk)->num.

Lee Jones (1):
      mailbox: mailbox-test: Fix potential double-free in mbox_test_message_write()

Linus Torvalds (1):
      gcc-12: disable '-Wdangling-pointer' warning for now

Marek Vasut (1):
      iio: dac: mcp4725: Fix i2c_master_send() return value handling

Martin Liška (1):
      eth: sun: cassini: remove dead code

Maxim Kochetkov (1):
      ASoC: dwc: limit the number of overrun messages

Nathan Chancellor (3):
      kernel/extable.c: use address-of operator on section symbols
      lib/dynamic_debug.c: use address-of operator on section symbols
      regulator: da905{2,5}: Remove unnecessary array check

Nikita Zhandarovich (1):
      HID: wacom: avoid integer overflow in wacom_intuos_inout()

Paul Moore (1):
      selinux: don't use make's grouped targets feature yet

Paweł Anikiel (1):
      ASoC: ssm2602: Add workaround for playback distortions

Ping-Ke Shih (1):
      wifi: rtlwifi: 8192de: correct checking of IQK reload

Randy Dunlap (1):
      dmaengine: pl330: rename _start to prevent build error

Ruihan Li (1):
      bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()

Sebastian Krzyszkowiak (1):
      net: usb: qmi_wwan: Set DTR quirk for BroadMobi BM818

Sherry Sun (1):
      tty: serial: fsl_lpuart: use UARTCTRL_TXINV to send break instead of UARTCTRL_SBK

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

Yun Lu (1):
      wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value

Zhang Shurong (1):
      media: dvb-usb-v2: rtl28xxu: fix null-ptr-deref in rtl28xxu_i2c_xfer

