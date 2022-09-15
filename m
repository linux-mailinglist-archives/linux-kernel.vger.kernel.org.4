Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D9D5BA2C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiIOWin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiIOWil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:38:41 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E98E4DB0F;
        Thu, 15 Sep 2022 15:38:37 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id A9D7711FC;
        Fri, 16 Sep 2022 00:38:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281514;
        bh=r1VyE7EmKiNzn3LnCZ3m17d23IWgpQQmBETrrC/1Hzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUVBLZRb9jUupiUEoIGMeVjom5VpV152f7wiQ+Pzp4hZrGUc+Omxd6mmz6LSmQh4w
         T4WNrKJPAq7TeqgeuXU+tM6bkJP8oKoBNeLlSq8JYf5gW15FiTlXF8tkCse5k07Zcf
         CdEN28YXOvnjO86buW/GToYVcGI6BfxQmgLx0dxIHZntYPjr/VZBBZyarRtbFS8vSV
         5JgoQYHw2gop5GcSYOGuYJ8XW93HnzQqv8tlzWqSjRcwCDTRgwfRM5YRITjXvUXRKw
         Yd/hwUg1hL2OGS3k7c/3tZhd66bAuKhmvfMnr5cKu/KMJ8VI61kxzfGvnZvNgXNtz1
         IspY461mKBq5YhO1JwOWj76XFVTClqDo2Rb3MODYxT6uaTxRiBeWew9lSn6ATWCBxO
         2e6F7gqgFx1YmXKikCW7ivHih1noNwW/13bZs/tcL2MeRy21xcfysj4coNFzRDJ+QP
         sUwP/p8BjJGD3XQ/JptlJrWwBMSYYtEDh1U4rjCGxYjuRhOYNNnmCQZRnNstWynZGn
         06WhuPOon50S0T1dp9FnvsmiFG1i2SyIw3ZwOI9UoPhbckCfbGp3Eq1IPrCoj8Qhm8
         +iafa80qFIaxN0zHZzcAJyIeW8481ucQChJAO/wegtxDxTre/bbvzWghYFcMpLypkw
         JO6vJzMTaB/JatcAw0pMfRcI=
Date:   Fri, 16 Sep 2022 00:38:33 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: [PATCH v4 01/18] Documentation: remove nonexistent magic numbers
Message-ID: <8389a7b85b5c660c6891b1740b5dacc53491a41b.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tbi25wg7fxdpfvam"
Content-Disposition: inline
In-Reply-To: <YyMlovoskUcHLEb7@kroah.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tbi25wg7fxdpfvam
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The entire file blames back to the start of git
(minus whitespace from the RST translation and a typo fix):
  * there are changelog comments for March 1994 through to Linux 2.5.74
  * struct tty_ldisc is two pointers nowadays, so naturally no magic
  * GDA_MAGIC is defined but unused, and it's been this way
    since start-of-git
  * M3_CARD_MAGIC isn't defined, because
    commit d56b9b9c464a ("[PATCH] The scheduled removal of some OSS
    drivers") removed the entire driver in 2006
  * CS_CARD_MAGIC likewise since
    commit b5d425c97f7d ("more scheduled OSS driver removal") in 2007
  * KMALLOC_MAGIC and VMALLOC_MAGIC were removed in
    commit e38e0cfa48ac ("[ALSA] Remove kmalloc wrappers"),
    six months after start of git
  * SLAB_C_MAGIC has never even appeared in git
    (removed in 2.4.0-test3pre6)

magic-number.rst is a low-value historial relic at best and
misleading cruft at worst, so start with cleaning out ones that only
appear therein

Automated:
grep MAGIC Documentation/process/magic-number.rst | while read -r mag _;
do git grep -wF "$mag" | grep -vq '^Documentation.*magic-number.rst:' ||
sed -i "/^$mag/d" \
Documentation/{,translations/{zh_CN,zh_TW,it_IT}/}process/magic-number.rst
done

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst        | 42 -------------------
 .../it_IT/process/magic-number.rst            | 42 -------------------
 .../zh_CN/process/magic-number.rst            | 42 -------------------
 .../zh_TW/process/magic-number.rst            | 42 -------------------
 4 files changed, 168 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index f5ba36e96461..eb2db3608a15 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -70,70 +70,29 @@ Magic Name            Number           Structure       =
         File
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
 CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
-MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
 HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
-DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
-DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
-FF_MAGIC              0x4646           fc_info                  ``drivers/=
net/iph5526_novram.c``
-PTY_MAGIC             0x5001                                    ``drivers/=
char/pty.c``
-PPP_MAGIC             0x5002           ppp                      ``include/=
linux/if_pppvar.h``
-SSTATE_MAGIC          0x5302           serial_state             ``include/=
linux/serial.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
-SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
-AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
 TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
-USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/=
usb/class/bluetty.c``
 RFCOMM_TTY_MAGIC      0x6d02                                    ``net/blue=
tooth/rfcomm/tty.c``
-USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/=
usb/serial/usb-serial.h``
 CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
-LSEMAGIC              0x05091998       lse                      ``drivers/=
fc4/fc.c``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
-RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.=
c``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/=
isdn/isdn_x25iface.h``
-ECP_MAGIC             0x21504345       cdkecpsig                ``include/=
linux/cdk.h``
-LSOMAGIC              0x27091997       lso                      ``drivers/=
fc4/fc.c``
-LSMAGIC               0x2a3b4d2a       ls                       ``drivers/=
fc4/fc.c``
-WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/=
linux/wanpipe.h``
-CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/os=
s/cs46xx.c``
-LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/=
asm/ia64/sn/labelcl.h``
-ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/=
linux/isdn.h``
-CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/=
s390/net/ctctty.c``
-ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/=
isdn/i4l/isdn_net_lib.h``
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
-CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/os=
s/cs46xx.c``
-SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.=
c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/os=
s/i810_audio.c``
-TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/os=
s/trident.c``
-ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanr=
outer.h`` pre 3.9]
 SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
 GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
-RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.=
c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-PCXX_MAGIC            0x5c6df104       channel                  ``drivers/=
char/pcxx.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-I810_STATE_MAGIC      0x63657373       i810_state               ``sound/os=
s/i810_audio.c``
-TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/os=
s/trident.c``
-M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/os=
s/maestro3.c``
 FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
-SLOT_MAGIC            0x67267321       slot                     ``drivers/=
hotplug/cpqphp.h``
-SLOT_MAGIC            0x67267322       slot                     ``drivers/=
hotplug/acpiphp.h``
 LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
-M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/os=
s/maestro3.c``
-VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/co=
re/memory.c``
-KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/co=
re/memory.c``
-PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/=
usb/media/pwc.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
@@ -141,7 +100,6 @@ YAM_MAGIC             0xF10A7654       yam_port        =
         ``drivers/net/ha
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-HTB_CMAGIC            0xFEFAFEF1       htb_class                ``net/sche=
d/sch_htb.c``
 NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index f452fafb1e84..86ef47906f37 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -76,70 +76,29 @@ Nome magico           Numero           Struttura       =
         File
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
 CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
-MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
 HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
-DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
-DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
-FF_MAGIC              0x4646           fc_info                  ``drivers/=
net/iph5526_novram.c``
-PTY_MAGIC             0x5001                                    ``drivers/=
char/pty.c``
-PPP_MAGIC             0x5002           ppp                      ``include/=
linux/if_pppvar.h``
-SSTATE_MAGIC          0x5302           serial_state             ``include/=
linux/serial.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
-SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
-AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
 TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
-USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/=
usb/class/bluetty.c``
 RFCOMM_TTY_MAGIC      0x6d02                                    ``net/blue=
tooth/rfcomm/tty.c``
-USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/=
usb/serial/usb-serial.h``
 CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
-LSEMAGIC              0x05091998       lse                      ``drivers/=
fc4/fc.c``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
-RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.=
c``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/=
isdn/isdn_x25iface.h``
-ECP_MAGIC             0x21504345       cdkecpsig                ``include/=
linux/cdk.h``
-LSOMAGIC              0x27091997       lso                      ``drivers/=
fc4/fc.c``
-LSMAGIC               0x2a3b4d2a       ls                       ``drivers/=
fc4/fc.c``
-WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/=
linux/wanpipe.h``
-CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/os=
s/cs46xx.c``
-LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/=
asm/ia64/sn/labelcl.h``
-ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/=
linux/isdn.h``
-CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/=
s390/net/ctctty.c``
-ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/=
isdn/i4l/isdn_net_lib.h``
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
-CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/os=
s/cs46xx.c``
-SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.=
c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/os=
s/i810_audio.c``
-TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/os=
s/trident.c``
-ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanr=
outer.h`` pre 3.9]
 SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
 GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
-RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.=
c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-PCXX_MAGIC            0x5c6df104       channel                  ``drivers/=
char/pcxx.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-I810_STATE_MAGIC      0x63657373       i810_state               ``sound/os=
s/i810_audio.c``
-TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/os=
s/trident.c``
-M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/os=
s/maestro3.c``
 FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
-SLOT_MAGIC            0x67267321       slot                     ``drivers/=
hotplug/cpqphp.h``
-SLOT_MAGIC            0x67267322       slot                     ``drivers/=
hotplug/acpiphp.h``
 LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
-M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/os=
s/maestro3.c``
-VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/co=
re/memory.c``
-KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/co=
re/memory.c``
-PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/=
usb/media/pwc.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
@@ -147,7 +106,6 @@ YAM_MAGIC             0xF10A7654       yam_port        =
         ``drivers/net/ha
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-HTB_CMAGIC            0xFEFAFEF1       htb_class                ``net/sche=
d/sch_htb.c``
 NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 42f0635ca70a..cbefdcbfbf53 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -59,71 +59,30 @@ Linux =E9=AD=94=E6=9C=AF=E6=95=B0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
 CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
-MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
 HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
-DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
-DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
-FF_MAGIC              0x4646           fc_info                  ``drivers/=
net/iph5526_novram.c``
-PTY_MAGIC             0x5001                                    ``drivers/=
char/pty.c``
-PPP_MAGIC             0x5002           ppp                      ``include/=
linux/if_pppvar.h``
-SSTATE_MAGIC          0x5302           serial_state             ``include/=
linux/serial.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
-SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
-AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
 TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
-USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/=
usb/class/bluetty.c``
 RFCOMM_TTY_MAGIC      0x6d02                                    ``net/blue=
tooth/rfcomm/tty.c``
-USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/=
usb/serial/usb-serial.h``
 CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
-LSEMAGIC              0x05091998       lse                      ``drivers/=
fc4/fc.c``
 GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str            ``drivers/=
scsi/gdth_ioctl.h``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
-RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.=
c``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/=
isdn/isdn_x25iface.h``
-ECP_MAGIC             0x21504345       cdkecpsig                ``include/=
linux/cdk.h``
-LSOMAGIC              0x27091997       lso                      ``drivers/=
fc4/fc.c``
-LSMAGIC               0x2a3b4d2a       ls                       ``drivers/=
fc4/fc.c``
-WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/=
linux/wanpipe.h``
-CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/os=
s/cs46xx.c``
-LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/=
asm/ia64/sn/labelcl.h``
-ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/=
linux/isdn.h``
-CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/=
s390/net/ctctty.c``
-ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/=
isdn/i4l/isdn_net_lib.h``
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
-CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/os=
s/cs46xx.c``
-SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.=
c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/os=
s/i810_audio.c``
-TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/os=
s/trident.c``
-ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanr=
outer.h`` pre 3.9]
 SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
 GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
-RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.=
c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-PCXX_MAGIC            0x5c6df104       channel                  ``drivers/=
char/pcxx.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-I810_STATE_MAGIC      0x63657373       i810_state               ``sound/os=
s/i810_audio.c``
-TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/os=
s/trident.c``
-M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/os=
s/maestro3.c``
 FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
-SLOT_MAGIC            0x67267321       slot                     ``drivers/=
hotplug/cpqphp.h``
-SLOT_MAGIC            0x67267322       slot                     ``drivers/=
hotplug/acpiphp.h``
 LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
-M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/os=
s/maestro3.c``
-VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/co=
re/memory.c``
-KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/co=
re/memory.c``
-PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/=
usb/media/pwc.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
@@ -132,7 +91,6 @@ YAM_MAGIC             0xF10A7654       yam_port         =
        ``drivers/net/ha
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-HTB_CMAGIC            0xFEFAFEF1       htb_class                ``net/sche=
d/sch_htb.c``
 NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index ae321a9aaece..7fd6e494467b 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -62,71 +62,30 @@ Linux =E9=AD=94=E8=A1=93=E6=95=B8
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
 CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
-MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
 HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
-DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
-DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
-FF_MAGIC              0x4646           fc_info                  ``drivers/=
net/iph5526_novram.c``
-PTY_MAGIC             0x5001                                    ``drivers/=
char/pty.c``
-PPP_MAGIC             0x5002           ppp                      ``include/=
linux/if_pppvar.h``
-SSTATE_MAGIC          0x5302           serial_state             ``include/=
linux/serial.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
-SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
-AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
 TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
-USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/=
usb/class/bluetty.c``
 RFCOMM_TTY_MAGIC      0x6d02                                    ``net/blue=
tooth/rfcomm/tty.c``
-USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/=
usb/serial/usb-serial.h``
 CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
-LSEMAGIC              0x05091998       lse                      ``drivers/=
fc4/fc.c``
 GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str            ``drivers/=
scsi/gdth_ioctl.h``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
-RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.=
c``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/=
isdn/isdn_x25iface.h``
-ECP_MAGIC             0x21504345       cdkecpsig                ``include/=
linux/cdk.h``
-LSOMAGIC              0x27091997       lso                      ``drivers/=
fc4/fc.c``
-LSMAGIC               0x2a3b4d2a       ls                       ``drivers/=
fc4/fc.c``
-WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/=
linux/wanpipe.h``
-CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/os=
s/cs46xx.c``
-LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/=
asm/ia64/sn/labelcl.h``
-ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/=
linux/isdn.h``
-CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/=
s390/net/ctctty.c``
-ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/=
isdn/i4l/isdn_net_lib.h``
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
-CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/os=
s/cs46xx.c``
-SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.=
c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/os=
s/i810_audio.c``
-TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/os=
s/trident.c``
-ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanr=
outer.h`` pre 3.9]
 SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
 GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
-RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.=
c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-PCXX_MAGIC            0x5c6df104       channel                  ``drivers/=
char/pcxx.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-I810_STATE_MAGIC      0x63657373       i810_state               ``sound/os=
s/i810_audio.c``
-TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/os=
s/trident.c``
-M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/os=
s/maestro3.c``
 FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
-SLOT_MAGIC            0x67267321       slot                     ``drivers/=
hotplug/cpqphp.h``
-SLOT_MAGIC            0x67267322       slot                     ``drivers/=
hotplug/acpiphp.h``
 LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
-M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/os=
s/maestro3.c``
-VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/co=
re/memory.c``
-KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/co=
re/memory.c``
-PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/=
usb/media/pwc.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
@@ -135,7 +94,6 @@ YAM_MAGIC             0xF10A7654       yam_port         =
        ``drivers/net/ha
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-HTB_CMAGIC            0xFEFAFEF1       htb_class                ``net/sche=
d/sch_htb.c``
 NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
--=20
2.30.2

--tbi25wg7fxdpfvam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqWQACgkQvP0LAY0m
WPFIgQ/+Pj18wW7Vo8WTHzLhNGGDqZjSQUd+DrqvNXt+9jAAvnmhWxH97ef6hG+B
8tWkSm+296bXeKZEqGtGMyzkTHDNx9XISwSAJpEaCsFVeUTpahj3yegNLZyKVUnK
Xie/iLmiIDBGNjatYz+bhRii6rthcMdlLp1ueSVNqOk3ncB9n0lc761PY4AkjDsY
oIggeY9P5YqZejIW9HPBBnXwbSK6ubTsSeBlUtQ2a7JEW1GM6hwQNDsMsuFX091m
tMsY4aLg+xNudW5GNjeCrnngT0YAjB5KIuLN/JFjgWMNwFZp53DggWHhLC73Qcpg
vAvC8T2Rzi84i+FEWo3Pn8aGtbDYyjFreq51kaYYh2NZPlzVkHf1rzcAVYTjxppy
9c6PqTYkhavD0+PdFspoNnPN2dhherqhH2w4p/Lz0PXPq1r45pC7JHK6+QWRSuJz
j0HV/9T6YI+gPnjQ59Z1+JvkiNVJdKNuhtFBVL+gt+BZnWRdtQ2hIsj4J38bHuF9
bmPntabFjp1vIi3WRhoibcrsuH9XSSUJjgQbjP4Pyj96CZAn5FWPTZXC51VZkNWo
eYRYyw7vW/g6w6ZPq+bRwQxhbYrDWuk5LwFXTvi3ClFy4MdDZWbmqoVGKz1JFoTv
/cR3UBCuV6d22VD9ZvpwkrQn2t2agXCWmzbgCW+e/fQqc/jSl/4=
=E/yn
-----END PGP SIGNATURE-----

--tbi25wg7fxdpfvam--
