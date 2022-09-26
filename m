Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75BD5EB5E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiIZXkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIZXj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:39:56 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39A5B2870C;
        Mon, 26 Sep 2022 16:39:45 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E20CE19F2;
        Tue, 27 Sep 2022 01:11:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1664233872;
        bh=aaetmTXzKafDMA1XUOEdjLS6/TXFJ+gsNbisWF/vIkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGeVr2jnxJi7jYyEzdYmVa4UWpJmD76mrVh9kIZ2NVyBB7ak4J2l5LzGfg2jUGUuq
         TrNxSAZtAhFDxE+T+Xg0AquaHYALxn5h0tJXy4TnPf7M30TTL3EI9fUPXc7YrBVkj5
         Z2Zs8y14MtRE8gGVPOPOJGH4Cbkqt2uQUjeQtoUa4PnyoATA3O/nYHPgnXsT8kku4u
         +bkoMfyD01TC3P+99LMG6XrLsIY9gRJd1O0SSQkAD7ABNH3wETU6hEcAIqQOHe2cOR
         prmoxTjYRRw9HGWHVwS6IUt4r1lbd/9aaGR4iRGUPi5Nq0xTiHGnFzFoowyFA21N6z
         1VxzQdahxSLStSWOcRsKiYePDPuO39UctCKifk+4nr5F1xmyLWoO3nGrSlNNWc7uUr
         hqiG8lMut+WEGBjZDyRDeiCx/awl52WKQiwHw3P/Ls8KC403+Je1lPPBKy4/+G6eWZ
         wumnxb8+uXncfNaR/KVr4zVSu8w19JdzZSXcTMu5XTDGofN8z7Ai35jA1DnnEWIgun
         qXr0ES7pPcV0tDm2haV25j1VowrpSzT35GBmUAj3oaGIIvMEfXD6jphYlqo+iaFQuZ
         v7dtvyARX4+OFBkDO+a5CDBgFor8DIxDmc4lXKqQQl3iK3IDff7zUUo12or/HqIJIw
         rBbtIdrTsC2CB0mHl8cKeLGM=
Date:   Tue, 27 Sep 2022 01:11:11 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     broonie@kernel.org
Cc:     Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the drivers-misc
 tree
Message-ID: <20220926231111.grxrydvfksyyk6t3@tarta.nabijaczleweli.xyz>
References: <20220926213414.792065-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fughf6hpeb5qyzvv"
Content-Disposition: inline
In-Reply-To: <20220926213414.792065-1-broonie@kernel.org>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fughf6hpeb5qyzvv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 10:34:14PM +0100, broonie@kernel.org wrote:
> Today's linux-next merge of the tty tree got a conflict in:
>=20
>   Documentation/process/magic-number.rst
>=20
> between commits:
>=20
>   766c5a3ecb319 ("Documentation: remove nonexistent magic numbers")
>   53c2bd6790172 ("a.out: remove define-only CMAGIC, previously magic numb=
er")
>=20
> from the drivers-misc tree and commits:
>=20
>   7a4e0d2c7fb8e ("tty: remove TTY_MAGIC")
>   5052df99d3bc3 ("tty: remove TTY_DRIVER_MAGIC")
>   14f9ed6153705 ("tty: n_hdlc: remove HDLC_MAGIC")
>   0e6357c3b61d6 ("tty: synclink_gt: remove MGSL_MAGIC")
>=20
> from the tty tree.

Similar situation as
  https://lore.kernel.org/all/20220926210631.657728-1-broonie@kernel.org/t
but the merge appears horribly broken only in the non-english files,
the english diff seems mostly fine.

=D0=BD=D0=B0=D0=B1

> diff --cc Documentation/process/magic-number.rst
> index 0387e8014074a,2326c3be94fc6..0000000000000
> --- a/Documentation/process/magic-number.rst
> +++ b/Documentation/process/magic-number.rst
> @@@ -69,19 -69,69 +69,15 @@@ Changelog:
>   Magic Name            Number           Structure                File
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>   PG_MAGIC              'P'              pg_{read,write}_hdr      ``inclu=
de/linux/pg.h``
> - HDLC_MAGIC            0x239e           n_hdlc                   ``drive=
rs/char/n_hdlc.c``
>  -CMAGIC                0x0111           user                     ``inclu=
de/linux/a.out.h``
>  -MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drive=
rs/net/mkiss.h``
>   APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/=
x86/kernel/apm_32.c``
>  -DB_MAGIC              0x4442           fc_info                  ``drive=
rs/net/iph5526_novram.c``
>  -DL_MAGIC              0x444d           fc_info                  ``drive=
rs/net/iph5526_novram.c``
>   FASYNC_MAGIC          0x4601           fasync_struct            ``inclu=
de/linux/fs.h``
>  -FF_MAGIC              0x4646           fc_info                  ``drive=
rs/net/iph5526_novram.c``
>  -PTY_MAGIC             0x5001                                    ``drive=
rs/char/pty.c``
>  -PPP_MAGIC             0x5002           ppp                      ``inclu=
de/linux/if_pppvar.h``
>  -SSTATE_MAGIC          0x5302           serial_state             ``inclu=
de/linux/serial.h``
>   SLIP_MAGIC            0x5302           slip                     ``drive=
rs/net/slip.h``
> - TTY_MAGIC             0x5401           tty_struct               ``inclu=
de/linux/tty.h``
> - MGSL_MAGIC            0x5401           mgsl_info                ``drive=
rs/char/synclink.c``
> - TTY_DRIVER_MAGIC      0x5402           tty_driver               ``inclu=
de/linux/tty_driver.h``
>  -STRIP_MAGIC           0x5303           strip                    ``drive=
rs/net/strip.c``
>  -SIXPACK_MAGIC         0x5304           sixpack                  ``drive=
rs/net/hamradio/6pack.h``
>  -AX25_MAGIC            0x5316           ax_disp                  ``drive=
rs/net/mkiss.h``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drive=
rs/char/pcmcia/synclink_cs.c``
>  -USB_SERIAL_MAGIC      0x6702           usb_serial               ``drive=
rs/usb/serial/usb-serial.h``
>  -FULL_DUPLEX_MAGIC     0x6969                                    ``drive=
rs/net/ethernet/dec/tulip/de2104x.c``
>  -USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drive=
rs/usb/class/bluetty.c``
>  -RFCOMM_TTY_MAGIC      0x6d02                                    ``net/b=
luetooth/rfcomm/tty.c``
>  -USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drive=
rs/usb/serial/usb-serial.h``
>  -CG_MAGIC              0x00090255       ufs_cylinder_group       ``inclu=
de/linux/ufs_fs.h``
>  -LSEMAGIC              0x05091998       lse                      ``drive=
rs/fc4/fc.c``
>  -RIEBL_MAGIC           0x09051990                                ``drive=
rs/net/atarilance.c``
>  -NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``inclu=
de/linux/nbd.h``
>  -RED_MAGIC2            0x170fc2a5       (any)                    ``mm/sl=
ab.c``
>  +NBD_REQUEST_MAGIC     0x25609513       nbd_request              ``inclu=
de/uapi/linux/nbd.h``
>   BAYCOM_MAGIC          0x19730510       baycom_state             ``drive=
rs/net/baycom_epp.c``
>  -ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drive=
rs/isdn/isdn_x25iface.h``
>  -ECP_MAGIC             0x21504345       cdkecpsig                ``inclu=
de/linux/cdk.h``
>  -LSOMAGIC              0x27091997       lso                      ``drive=
rs/fc4/fc.c``
>  -LSMAGIC               0x2a3b4d2a       ls                       ``drive=
rs/fc4/fc.c``
>  -WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``inclu=
de/linux/wanpipe.h``
>  -CS_CARD_MAGIC         0x43525553       cs_card                  ``sound=
/oss/cs46xx.c``
>  -LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``inclu=
de/asm/ia64/sn/labelcl.h``
>  -ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``inclu=
de/linux/isdn.h``
>  -CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drive=
rs/s390/net/ctctty.c``
>  -ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drive=
rs/isdn/i4l/isdn_net_lib.h``
>  -SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/=
*/amiga/config.c``
>  -CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound=
/oss/cs46xx.c``
>  -SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/sl=
ab.c``
>  -COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/=
um/drivers/ubd_user.c``
>  -I810_CARD_MAGIC       0x5072696E       i810_card                ``sound=
/oss/i810_audio.c``
>  -TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound=
/oss/trident.c``
>  -ROUTER_MAGIC          0x524d4157       wan_device               [in ``w=
anrouter.h`` pre 3.9]
>  -SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/=
*/amiga/config.c``
>  -GDA_MAGIC             0x58464552       gda                      ``arch/=
mips/include/asm/sn/gda.h``
>  -RED_MAGIC1            0x5a2cf071       (any)                    ``mm/sl=
ab.c``
>  -EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drive=
rs/atm/lanai.c``
>   HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``inclu=
de/linux/hdlcdrv.h``
>  -PCXX_MAGIC            0x5c6df104       channel                  ``drive=
rs/char/pcxx.h``
>   KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/=
mips/include/asm/sn/klkernvars.h``
>  -I810_STATE_MAGIC      0x63657373       i810_state               ``sound=
/oss/i810_audio.c``
>  -TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound=
/oss/trident.c``
>  -M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound=
/oss/maestro3.c``
>  -FW_HEADER_MAGIC       0x65726F66       fw_header                ``drive=
rs/atm/fore200e.h``
>  -SLOT_MAGIC            0x67267321       slot                     ``drive=
rs/hotplug/cpqphp.h``
>  -SLOT_MAGIC            0x67267322       slot                     ``drive=
rs/hotplug/acpiphp.h``
>  -LO_MAGIC              0x68797548       nbd_device               ``inclu=
de/linux/nbd.h``
>  -M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound=
/oss/maestro3.c``
>  -VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound=
/core/memory.c``
>  -KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound=
/core/memory.c``
>  -PWC_MAGIC             0x89DC10AB       pwc_device               ``drive=
rs/usb/media/pwc.h``
>  -NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``inclu=
de/linux/nbd.h``
>  -ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/a=
tm/eni.h``
>  +NBD_REPLY_MAGIC       0x67446698       nbd_reply                ``inclu=
de/uapi/linux/nbd.h``
>   CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/co=
da/coda_fs_i.h``
>   YAM_MAGIC             0xF10A7654       yam_port                 ``drive=
rs/net/hamradio/yam.c``
>   CCB_MAGIC             0xf2691ad2       ccb                      ``drive=
rs/scsi/ncr53c8xx.c``
> diff --cc Documentation/translations/it_IT/process/magic-number.rst
> index cfb8d69768aae,1803497816f1e..0000000000000
> --- a/Documentation/translations/it_IT/process/magic-number.rst
> +++ b/Documentation/translations/it_IT/process/magic-number.rst
> @@@ -75,15 -75,21 +75,26 @@@ Registro dei cambiamenti:
>   Nome magico           Numero           Struttura                File
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>   PG_MAGIC              'P'              pg_{read,write}_hdr      ``inclu=
de/linux/pg.h``
> ++<<<<<<< HEAD
>  +HDLC_MAGIC            0x239e           n_hdlc                   ``drive=
rs/char/n_hdlc.c``
> ++=3D=3D=3D=3D=3D=3D=3D
> + CMAGIC                0x0111           user                     ``inclu=
de/linux/a.out.h``
> + MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drive=
rs/net/mkiss.h``
> ++>>>>>>> tty/tty-next
>   APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/=
x86/kernel/apm_32.c``
>  -DB_MAGIC              0x4442           fc_info                  ``drive=
rs/net/iph5526_novram.c``
>  -DL_MAGIC              0x444d           fc_info                  ``drive=
rs/net/iph5526_novram.c``
>   FASYNC_MAGIC          0x4601           fasync_struct            ``inclu=
de/linux/fs.h``
>  -FF_MAGIC              0x4646           fc_info                  ``drive=
rs/net/iph5526_novram.c``
>  -PTY_MAGIC             0x5001                                    ``drive=
rs/char/pty.c``
>  -PPP_MAGIC             0x5002           ppp                      ``inclu=
de/linux/if_pppvar.h``
>  -SSTATE_MAGIC          0x5302           serial_state             ``inclu=
de/linux/serial.h``
>   SLIP_MAGIC            0x5302           slip                     ``drive=
rs/net/slip.h``
> ++<<<<<<< HEAD
>  +TTY_MAGIC             0x5401           tty_struct               ``inclu=
de/linux/tty.h``
>  +MGSL_MAGIC            0x5401           mgsl_info                ``drive=
rs/char/synclink.c``
>  +TTY_DRIVER_MAGIC      0x5402           tty_driver               ``inclu=
de/linux/tty_driver.h``
> ++=3D=3D=3D=3D=3D=3D=3D
> + STRIP_MAGIC           0x5303           strip                    ``drive=
rs/net/strip.c``
> + SIXPACK_MAGIC         0x5304           sixpack                  ``drive=
rs/net/hamradio/6pack.h``
> + AX25_MAGIC            0x5316           ax_disp                  ``drive=
rs/net/mkiss.h``
> ++>>>>>>> tty/tty-next
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drive=
rs/char/pcmcia/synclink_cs.c``
>  +<<<<<<< HEAD
>   USB_SERIAL_MAGIC      0x6702           usb_serial               ``drive=
rs/usb/serial/usb-serial.h``
>   FULL_DUPLEX_MAGIC     0x6969                                    ``drive=
rs/net/ethernet/dec/tulip/de2104x.c``
>   USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drive=
rs/usb/class/bluetty.c``
> diff --cc Documentation/translations/zh_CN/process/magic-number.rst
> index 2df729592547f,9780bf710eebc..0000000000000
> --- a/Documentation/translations/zh_CN/process/magic-number.rst
> +++ b/Documentation/translations/zh_CN/process/magic-number.rst
> @@@ -58,15 -58,21 +58,26 @@@ Linux =C3=A9=C2=AD=C2=94=C3=A6=C2=9C=C2=AF=
=C3=A6=C2=95
>   =C3=A9=C2=AD=C2=94=C3=A6=C2=9C=C2=AF=C3=A6=C2=95=C2=B0=C3=A5=C2=90=C2=
=8D              =C3=A6=C2=95=C2=B0=C3=A5=C2=AD=C2=97             =C3=A7=C2=
=BB=C2=93=C3=A6=C2=9E=C2=84                     =C3=A6=C2=96=C2=87=C3=A4=C2=
=BB=C2=B6
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>   PG_MAGIC              'P'              pg_{read,write}_hdr      ``inclu=
de/linux/pg.h``
> ++<<<<<<< HEAD
>  +HDLC_MAGIC            0x239e           n_hdlc                   ``drive=
rs/char/n_hdlc.c``
> ++=3D=3D=3D=3D=3D=3D=3D
> + CMAGIC                0x0111           user                     ``inclu=
de/linux/a.out.h``
> + MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drive=
rs/net/mkiss.h``
> ++>>>>>>> tty/tty-next
>   APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/=
x86/kernel/apm_32.c``
>  -DB_MAGIC              0x4442           fc_info                  ``drive=
rs/net/iph5526_novram.c``
>  -DL_MAGIC              0x444d           fc_info                  ``drive=
rs/net/iph5526_novram.c``
>   FASYNC_MAGIC          0x4601           fasync_struct            ``inclu=
de/linux/fs.h``
>  -FF_MAGIC              0x4646           fc_info                  ``drive=
rs/net/iph5526_novram.c``
>  -PTY_MAGIC             0x5001                                    ``drive=
rs/char/pty.c``
>  -PPP_MAGIC             0x5002           ppp                      ``inclu=
de/linux/if_pppvar.h``
>  -SSTATE_MAGIC          0x5302           serial_state             ``inclu=
de/linux/serial.h``
>   SLIP_MAGIC            0x5302           slip                     ``drive=
rs/net/slip.h``
> ++<<<<<<< HEAD
>  +TTY_MAGIC             0x5401           tty_struct               ``inclu=
de/linux/tty.h``
>  +MGSL_MAGIC            0x5401           mgsl_info                ``drive=
rs/char/synclink.c``
>  +TTY_DRIVER_MAGIC      0x5402           tty_driver               ``inclu=
de/linux/tty_driver.h``
> ++=3D=3D=3D=3D=3D=3D=3D
> + STRIP_MAGIC           0x5303           strip                    ``drive=
rs/net/strip.c``
> + SIXPACK_MAGIC         0x5304           sixpack                  ``drive=
rs/net/hamradio/6pack.h``
> + AX25_MAGIC            0x5316           ax_disp                  ``drive=
rs/net/mkiss.h``
> ++>>>>>>> tty/tty-next
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drive=
rs/char/pcmcia/synclink_cs.c``
>  +<<<<<<< HEAD
>   USB_SERIAL_MAGIC      0x6702           usb_serial               ``drive=
rs/usb/serial/usb-serial.h``
>   FULL_DUPLEX_MAGIC     0x6969                                    ``drive=
rs/net/ethernet/dec/tulip/de2104x.c``
>   USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drive=
rs/usb/class/bluetty.c``
> diff --cc Documentation/translations/zh_TW/process/magic-number.rst
> index 4cbb93dadef78,933545e92137a..0000000000000
> --- a/Documentation/translations/zh_TW/process/magic-number.rst
> +++ b/Documentation/translations/zh_TW/process/magic-number.rst
> @@@ -61,15 -61,21 +61,26 @@@ Linux =C3=A9=C2=AD=C2=94=C3=A8=C2=A1=C2=93=
=C3=A6=C2=95
>   =C3=A9=C2=AD=C2=94=C3=A8=C2=A1=C2=93=C3=A6=C2=95=C2=B8=C3=A5=C2=90=C2=
=8D              =C3=A6=C2=95=C2=B8=C3=A5=C2=AD=C2=97             =C3=A7=C2=
=B5=C2=90=C3=A6=C2=A7=C2=8B                     =C3=A6=C2=96=C2=87=C3=A4=C2=
=BB=C2=B6
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>   PG_MAGIC              'P'              pg_{read,write}_hdr      ``inclu=
de/linux/pg.h``
> ++<<<<<<< HEAD
>  +HDLC_MAGIC            0x239e           n_hdlc                   ``drive=
rs/char/n_hdlc.c``
> ++=3D=3D=3D=3D=3D=3D=3D
> + CMAGIC                0x0111           user                     ``inclu=
de/linux/a.out.h``
> + MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drive=
rs/net/mkiss.h``
> ++>>>>>>> tty/tty-next
>   APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/=
x86/kernel/apm_32.c``
>  -DB_MAGIC              0x4442           fc_info                  ``drive=
rs/net/iph5526_novram.c``
>  -DL_MAGIC              0x444d           fc_info                  ``drive=
rs/net/iph5526_novram.c``
>   FASYNC_MAGIC          0x4601           fasync_struct            ``inclu=
de/linux/fs.h``
>  -FF_MAGIC              0x4646           fc_info                  ``drive=
rs/net/iph5526_novram.c``
>  -PTY_MAGIC             0x5001                                    ``drive=
rs/char/pty.c``
>  -PPP_MAGIC             0x5002           ppp                      ``inclu=
de/linux/if_pppvar.h``
>  -SSTATE_MAGIC          0x5302           serial_state             ``inclu=
de/linux/serial.h``
>   SLIP_MAGIC            0x5302           slip                     ``drive=
rs/net/slip.h``
> ++<<<<<<< HEAD
>  +TTY_MAGIC             0x5401           tty_struct               ``inclu=
de/linux/tty.h``
>  +MGSL_MAGIC            0x5401           mgsl_info                ``drive=
rs/char/synclink.c``
>  +TTY_DRIVER_MAGIC      0x5402           tty_driver               ``inclu=
de/linux/tty_driver.h``
> ++=3D=3D=3D=3D=3D=3D=3D
> + STRIP_MAGIC           0x5303           strip                    ``drive=
rs/net/strip.c``
> + SIXPACK_MAGIC         0x5304           sixpack                  ``drive=
rs/net/hamradio/6pack.h``
> + AX25_MAGIC            0x5316           ax_disp                  ``drive=
rs/net/mkiss.h``
> ++>>>>>>> tty/tty-next
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drive=
rs/char/pcmcia/synclink_cs.c``
>  +<<<<<<< HEAD
>   USB_SERIAL_MAGIC      0x6702           usb_serial               ``drive=
rs/usb/serial/usb-serial.h``
>   FULL_DUPLEX_MAGIC     0x6969                                    ``drive=
rs/net/ethernet/dec/tulip/de2104x.c``
>   USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drive=
rs/usb/class/bluetty.c``

--fughf6hpeb5qyzvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMyMY0ACgkQvP0LAY0m
WPEexRAAhphfMbwisdBgJh+hqsxAtpoCBHL7rMmIby4f/Bt06cBhO/8ycZAbIku5
jmKaxcgm/VVDGlXU7PAOCxxwYf5tgqbsfsAWp15mzmk7YVDsVNP+nQo7xtj7dKyy
V7kFaGe51dzVLehQmuFNVd/oFPwiYLDCuJuO6F7pfARjOVGku7CflUoTYmU7JYWe
y1HBzGfMthrChKjNHZGMzE2Kg6zMtYz0EXYVYrMm/LXWkDlIdqcwGz0fUN7CzV5U
6E0FhtBG0tCXCYI+MrU7HfaCvRQ+7sWXnL1OViNX0o8agReDBabVqya3KtIEA1rf
eIw3aN4u4ywSbAynlbZSG5sOBa/VXCCZ2MVZjqYqVuLz7sMaC3nXkulqussIcahO
eHoWXXx6PqJ72MNiXWR+dhk7zrw5msLw8fcCEgVrO8CmVTk7WrCk2QKv6ux34brh
ZFYbfYZqUzWSCxuOEDbD+BBjuhcKAUDjd03/ra7wYJz4svX22UeKrPrNJXaClbx2
KD0F7AhAmbph8B7ETFCkYQkZeba6MAt8hgcowOjqxvxgO+5arkVFIlsr66hjxJrE
EWEAzqSc6QeFboNZkgC1YqMyMauNr2JaIoN1xwqHeVxrKgkgp1F8dNA0pKkAh885
KKMVld2b3DSZ852FwP+Zt1g3kZhldEDMlYbdz+JU0FrEa/SdBqc=
=Rz1S
-----END PGP SIGNATURE-----

--fughf6hpeb5qyzvv--
