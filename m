Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4385EB4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiIZWqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIZWqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:46:49 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5AFD7D7A6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:46:33 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C4EC22224;
        Tue, 27 Sep 2022 00:46:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1664232382;
        bh=C3hEPBr6j6UhjrstG1r6AQjGDeGbYe51+BLVo6bFKs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5eqMUZstRvNKJl7b5TyTaj3fGyM/X5zdpCMq5/19JBGH1vqSgBYkniq4f38IhNk6
         srTQMkFD3CPu7zBUdvfoGUrp0SDBBQ/ZsIDYnn0pGOb/jot4RsnaNBaALk/mHHV1yn
         zocAbPw1GqOiVg7bvIrR8QmZ1mAsKmEdgCWYBJozNOtjOWq32fC6kOzhokdqH4ZxH2
         DgEe9XIQ0EboqaR8S+005VcFCH9tv5DsX/OwknFYd60J3hib5d020/OSPYgpH4SEJC
         1jTQjM5V8qy60AeLoH/N0RCrcMU6ZxVIeduy3JopMHX8XQB1P169lZX1Hg+bInvTLe
         Z18LgV3gs1xnu5t5BbMXTNoVruSUIWb2fNTRA4W25awk8/bq53VPVKyH0m0pFZzqVQ
         n5YTRoSKEbmb9LYV+ay4Ez/2aX3sWR9koM2vGmESq4YetTbPpmFWJ3KdJ5PetQCUyl
         G6k0o2v8v3y7lE4vVh2dwGuNqXkPgeaUfb/OHBLVeux2Ca1ctGuPJ0a3eB5EpnfZuQ
         TtyLrc5iymQ90fqnMIMBd884/gFJvWbeGzWE06bs85CJOEQFvdlg/RE2ZzKw2qZUJ4
         QTdYHKgqdbipSaPV0q7dXBmZ9wdZXIaYI5DjQNckBw9JpqiAzHE/07F3h3u+RhQEDD
         zHQkrbA497kpkF2X7DZv3luc=
Date:   Tue, 27 Sep 2022 00:46:21 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     broonie@kernel.org
Cc:     Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Manfred Spraul <manfred.spraul@de.bosch.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 jc_docs tree
Message-ID: <20220926224621.47llaskp6mihi4dd@tarta.nabijaczleweli.xyz>
References: <20220926210631.657728-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vwmkmt52bcos2fxv"
Content-Disposition: inline
In-Reply-To: <20220926210631.657728-1-broonie@kernel.org>
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


--vwmkmt52bcos2fxv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Mon, Sep 26, 2022 at 10:06:31PM +0100, broonie@kernel.org wrote:
> Today's linux-next merge of the driver-core tree got a conflict in:
>=20
>   Documentation/process/magic-number.rst
>=20
> between commit:
>=20
>   32ba63d4b2e1a ("Doc update: Correct magic values from nbd protocol, V2")
>=20
> from the jc_docs tree and commits:
>=20
>   82805818898dd ("Documentation: NBD_REPLY_MAGIC isn't a magic number")
>   bd5926220ffe0 ("nbd: remove define-only NBD_MAGIC, previously magic num=
ber")
>=20
> from the driver-core tree (and probably more for context).

If I'm reading the merge right (very much not a given!),
it seems that the NBD_REPLY_MAGIC (and LO_MAGIC?) constant(s) survived:
they both need to go for reasons listed in
  bd5926220ffe0: LO_MAGIC doesn't exist
  82805818898dd: NBD_REPLY_MAGIC is part of the line protocol,
                 not a magic number=20

This also reveals that I missed NBD_REQUEST_MAGIC
(needs to go, same reason as NBD_REPLY_MAGIC)
in the first pass, but that's unrelated here.

> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

The process here is unclear to me; I assume the "linux-next" here is
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
but the latest update to the default branch appears to be from
4 days ago (and pending-fixes at 7h old has this file last modified in
 2021), so I can't really validate if this merge is as I read it
(or, indeed, if it does include... the conflict markers?
 because it does appear to introduce them
 (or, at least, if I leave in the conflict markers and commit a merge,
  it sure looks like what's represented below)?),
so idk.

Diff below trimmed down to the interesting bits with two lines of
context.

Best,
=D0=BD=D0=B0=D0=B1

> diff --cc Documentation/process/magic-number.rst
> index 133ecfa106070,f420fa2d7f8b8..0000000000000
> --- a/Documentation/process/magic-number.rst
> +++ b/Documentation/process/magic-number.rst
> @@@ -88,54 -77,10 +77,11 @@@ TTY_MAGIC             0x5401          =20
> - SLOT_MAGIC            0x67267321       slot                     ``drive=
rs/hotplug/cpqphp.h``
> - SLOT_MAGIC            0x67267322       slot                     ``drive=
rs/hotplug/acpiphp.h``
>  +NBD_REPLY_MAGIC       0x67446698       nbd_reply                ``inclu=
de/uapi/linux/nbd.h``
> - LO_MAGIC              0x68797548       nbd_device               ``inclu=
de/linux/nbd.h``
> - M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound=
/oss/maestro3.c``
> - VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound=
/core/memory.c``
> diff --cc Documentation/translations/it_IT/process/magic-number.rst
> index 17401994f2e84,fa7f926649d2f..0000000000000
> --- a/Documentation/translations/it_IT/process/magic-number.rst
> +++ b/Documentation/translations/it_IT/process/magic-number.rst
> @@@ -94,54 -83,10 +83,61 @@@ TTY_MAGIC             0x5401          =20
>   TTY_DRIVER_MAGIC      0x5402           tty_driver               ``inclu=
de/linux/tty_driver.h``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drive=
rs/char/pcmcia/synclink_cs.c``
> ++<<<<<<< HEAD
>  +USB_SERIAL_MAGIC      0x6702           usb_serial               ``drive=
rs/usb/serial/usb-serial.h``
>  +FULL_DUPLEX_MAGIC     0x6969                                    ``drive=
rs/net/ethernet/dec/tulip/de2104x.c``
>  +RED_MAGIC1            0x5a2cf071       (any)                    ``mm/sl=
ab.c``
>  +EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drive=
rs/atm/lanai.c``
> ++=3D=3D=3D=3D=3D=3D=3D
> + NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``inclu=
de/linux/nbd.h``
> + BAYCOM_MAGIC          0x19730510       baycom_state             ``drive=
rs/net/baycom_epp.c``
> ++>>>>>>> driver-core/driver-core-next
>   HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``inclu=
de/linux/hdlcdrv.h``
> - PCXX_MAGIC            0x5c6df104       channel                  ``drive=
rs/char/pcxx.h``
>   KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/=
mips/include/asm/sn/klkernvars.h``
> ++<<<<<<< HEAD
>  +I810_STATE_MAGIC      0x63657373       i810_state               ``sound=
/oss/i810_audio.c``
>  +TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound=
/oss/trident.c``
>  +SLOT_MAGIC            0x67267321       slot                     ``drive=
rs/hotplug/cpqphp.h``
>  +SLOT_MAGIC            0x67267322       slot                     ``drive=
rs/hotplug/acpiphp.h``
>  +NBD_REPLY_MAGIC       0x67446698       nbd_reply                ``inclu=
de/uapi/linux/nbd.h``
>  +LO_MAGIC              0x68797548       nbd_device               ``inclu=
de/linux/nbd.h``
>  +M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound=
/oss/maestro3.c``
>  +VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound=
/core/memory.c``
>  +PWC_MAGIC             0x89DC10AB       pwc_device               ``drive=
rs/usb/media/pwc.h``
>  +ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/a=
tm/eni.h``
> ++=3D=3D=3D=3D=3D=3D=3D
> ++>>>>>>> driver-core/driver-core-next
>   CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/co=
da/coda_fs_i.h``
>   YAM_MAGIC             0xF10A7654       yam_port                 ``drive=
rs/net/hamradio/yam.c``
> diff --cc Documentation/translations/zh_CN/process/magic-number.rst
> index 1b376fe087b54,4371f16836936..0000000000000
> --- a/Documentation/translations/zh_CN/process/magic-number.rst
> +++ b/Documentation/translations/zh_CN/process/magic-number.rst
> @@@ -77,57 -66,11 +66,63 @@@ TTY_MAGIC             0x5401          =20
>   TTY_DRIVER_MAGIC      0x5402           tty_driver               ``inclu=
de/linux/tty_driver.h``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drive=
rs/char/pcmcia/synclink_cs.c``
> ++<<<<<<< HEAD
>  +USB_SERIAL_MAGIC      0x6702           usb_serial               ``drive=
rs/usb/serial/usb-serial.h``
>  +FULL_DUPLEX_MAGIC     0x6969                                    ``drive=
rs/net/ethernet/dec/tulip/de2104x.c``
>  +RED_MAGIC1            0x5a2cf071       (any)                    ``mm/sl=
ab.c``
>  +EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drive=
rs/atm/lanai.c``
> ++=3D=3D=3D=3D=3D=3D=3D
> + NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``inclu=
de/linux/nbd.h``
> + BAYCOM_MAGIC          0x19730510       baycom_state             ``drive=
rs/net/baycom_epp.c``
> ++>>>>>>> driver-core/driver-core-next
>   HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``inclu=
de/linux/hdlcdrv.h``
> - PCXX_MAGIC            0x5c6df104       channel                  ``drive=
rs/char/pcxx.h``
>   KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/=
mips/include/asm/sn/klkernvars.h``
> ++<<<<<<< HEAD
>  +I810_STATE_MAGIC      0x63657373       i810_state               ``sound=
/oss/i810_audio.c``
>  +TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound=
/oss/trident.c``
>  +SLOT_MAGIC            0x67267321       slot                     ``drive=
rs/hotplug/cpqphp.h``
>  +SLOT_MAGIC            0x67267322       slot                     ``drive=
rs/hotplug/acpiphp.h``
>  +NBD_REPLY_MAGIC       0x67446698       nbd_reply                ``inclu=
de/uapi/linux/nbd.h``
>  +LO_MAGIC              0x68797548       nbd_device               ``inclu=
de/linux/nbd.h``
>  +M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound=
/oss/maestro3.c``
>  +VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound=
/core/memory.c``
>  +PWC_MAGIC             0x89DC10AB       pwc_device               ``drive=
rs/usb/media/pwc.h``
>  +ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/a=
tm/eni.h``
> ++=3D=3D=3D=3D=3D=3D=3D
> ++>>>>>>> driver-core/driver-core-next
>   CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/co=
da/coda_fs_i.h``
> - DPMEM_MAGIC           0xc0ffee11       gdt_pci_sram             ``drive=
rs/scsi/gdth.h``
> diff --cc Documentation/translations/zh_TW/process/magic-number.rst
> index ff385a369c7b4,3e83f18b9c18e..0000000000000
> --- a/Documentation/translations/zh_TW/process/magic-number.rst
> +++ b/Documentation/translations/zh_TW/process/magic-number.rst
> @@@ -80,57 -69,11 +69,63 @@@ TTY_MAGIC             0x5401          =20
>   TTY_DRIVER_MAGIC      0x5402           tty_driver               ``inclu=
de/linux/tty_driver.h``
>   MGSLPC_MAGIC          0x5402           mgslpc_info              ``drive=
rs/char/pcmcia/synclink_cs.c``
> ++<<<<<<< HEAD
>  +USB_SERIAL_MAGIC      0x6702           usb_serial               ``drive=
rs/usb/serial/usb-serial.h``
>  +FULL_DUPLEX_MAGIC     0x6969                                    ``drive=
rs/net/ethernet/dec/tulip/de2104x.c``
>  +RED_MAGIC1            0x5a2cf071       (any)                    ``mm/sl=
ab.c``
>  +EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drive=
rs/atm/lanai.c``
> ++=3D=3D=3D=3D=3D=3D=3D
> + NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``inclu=
de/linux/nbd.h``
> + BAYCOM_MAGIC          0x19730510       baycom_state             ``drive=
rs/net/baycom_epp.c``
> ++>>>>>>> driver-core/driver-core-next
>   HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``inclu=
de/linux/hdlcdrv.h``
> - PCXX_MAGIC            0x5c6df104       channel                  ``drive=
rs/char/pcxx.h``
>   KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/=
mips/include/asm/sn/klkernvars.h``
> ++<<<<<<< HEAD
>  +I810_STATE_MAGIC      0x63657373       i810_state               ``sound=
/oss/i810_audio.c``
>  +TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound=
/oss/trident.c``
>  +SLOT_MAGIC            0x67267321       slot                     ``drive=
rs/hotplug/cpqphp.h``
>  +SLOT_MAGIC            0x67267322       slot                     ``drive=
rs/hotplug/acpiphp.h``
>  +NBD_REPLY_MAGIC       0x67446698       nbd_reply                ``inclu=
de/uapi/linux/nbd.h``
>  +LO_MAGIC              0x68797548       nbd_device               ``inclu=
de/linux/nbd.h``
>  +M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound=
/oss/maestro3.c``
>  +VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound=
/core/memory.c``
>  +PWC_MAGIC             0x89DC10AB       pwc_device               ``drive=
rs/usb/media/pwc.h``
>  +ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/a=
tm/eni.h``
> ++=3D=3D=3D=3D=3D=3D=3D
> ++>>>>>>> driver-core/driver-core-next
>   CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/co=
da/coda_fs_i.h``
> - DPMEM_MAGIC           0xc0ffee11       gdt_pci_sram             ``drive=
rs/scsi/gdth.h``

--vwmkmt52bcos2fxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMyK7kACgkQvP0LAY0m
WPEAvQ//d+l1+/+ao46CMF9OdhNlC5nyayMjuaPk4TFdeCuczySh04vSk+agGXsb
hGMebJKqf598MGiRoN9Xnd3dSFygj9A2u4i69vTH41kdzXiPgaWZPlwRil3cYPNi
b1+mUyty5JCIXgBqxnTM3bCmKtGTL3hF5RjZa3hlG++9wv4mKsQtVyldZdTEWKya
Qu2JBt74uovQVvpMw/sdAcuWbxCEJDlqFwCfB6WYzL6CyNjKhk7zCVYoUOkk3mwk
cuGiKjQcWXDKq7QbaATkHrQPAChWr5fRtjo28gbkcHVYEbjAjYn9Ye9Zu8W5/pya
QrCFztt2u8UiTfoGJvxfuhxqXGww5Box82jrgUZFLywCXGQ+45qh96z9rMogqnGm
X7yl6a1xklHxywu6RpEHnSY3VR9w7m9HI2PyP92+snl9ccjVki96POjnCzKXPh99
J3eUuV28EwriyWM/qBgFwvlrzr9iLnPFdYXe8/HE8Jd4k/QPfW2N+KkwLMvIs5G9
aJizfy9RT5qP2UhW3skgXWK4PfZjDKk1y1RP8msmESZhJkKpUFynf1irYMJqKXCZ
ZjWUIbsfRoFkgoMSLsuiiGcsbrPb+yGrxZbK2RdcrNFmBOSQopaWxdMprw3SVtw8
2mvc6UrKuLH//SUzZb3lfBN+Rs+D1mZjfxCvW7t58dNROFGv7S4=
=SSfZ
-----END PGP SIGNATURE-----

--vwmkmt52bcos2fxv--
