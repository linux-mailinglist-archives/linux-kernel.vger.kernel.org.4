Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1096131D5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJaIlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJaIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:41:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DBB2AF5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:41:40 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1opQMK-0003sM-US; Mon, 31 Oct 2022 09:41:28 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3c2a:13d:f861:4564])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5A6AC10E681;
        Mon, 31 Oct 2022 08:41:27 +0000 (UTC)
Date:   Mon, 31 Oct 2022 09:41:19 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Kenneth Lee <klee33@uw.edu>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:489:65:
 warning: array subscript 'struct kvaser_cmd_ext[0]' is partly outside array
 bounds of 'unsigned char[32]'
Message-ID: <20221031084119.bt73s33ps5naz4eh@pengutronix.de>
References: <202210310759.iwMoLzLT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u63tyxrcg47sgpwk"
Content-Disposition: inline
In-Reply-To: <202210310759.iwMoLzLT-lkp@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u63tyxrcg47sgpwk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.10.2022 07:35:36, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   30a0b95b1335e12efef89dd78518ed3e4a71a763
> commit: 00784da3e6b8c1f0e58d813272503d014de8f64b can: kvaser_usb: kvaser_=
usb_hydra: Use kzalloc for allocating only one element
> date:   8 weeks ago
> config: i386-randconfig-r021-20221031
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=3D1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D00784da3e6b8c1f0e58d813272503d014de8f64b
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 00784da3e6b8c1f0e58d813272503d014de8f64b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
>    In file included from include/linux/byteorder/little_endian.h:5,
>                     from arch/x86/include/uapi/asm/byteorder.h:5,
>                     from include/asm-generic/bitops/le.h:6,
>                     from arch/x86/include/asm/bitops.h:416,
>                     from include/linux/bitops.h:68,
>                     from include/linux/kernel.h:22,
>                     from arch/x86/include/asm/percpu.h:27,
>                     from arch/x86/include/asm/preempt.h:6,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:55,
>                     from include/linux/swait.h:7,
>                     from include/linux/completion.h:12,
>                     from drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.=
c:16:
>    drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c: In function 'kvaser=
_usb_hydra_send_simple_cmd':
> >> drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:489:65: warning: arr=
ay subscript 'struct kvaser_cmd_ext[0]' is partly outside array bounds of '=
unsigned char[32]' [-Warray-bounds]
>      489 |                 ret =3D le16_to_cpu(((struct kvaser_cmd_ext *)=
cmd)->len);
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: in definitio=
n of macro '__le16_to_cpu'
>       37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>          |                                                   ^
>    drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:489:23: note: in exp=
ansion of macro 'le16_to_cpu'
>      489 |                 ret =3D le16_to_cpu(((struct kvaser_cmd_ext *)=
cmd)->len);
>          |                       ^~~~~~~~~~~
>    drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:537:15: note: refere=
ncing an object of size 32 allocated by 'kzalloc'
>      537 |         cmd =3D kzalloc(sizeof(*cmd), GFP_KERNEL);
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I think this is a false positive.

The commit you're building 00784da3e6b8 ("can: kvaser_usb:
kvaser_usb_hydra: Use kzalloc for allocating only one element") contains
3e88445a3a5a ("can: kvaser_usb: silence a GCC 12 -Warray-bounds
warning").

In the latter commit, the -Warray-bounds warning was disabled, as gcc-12
has some problem with it. However you're using gcc-11 (Debian 11.3.0-8)
11.3.0 here. Don't know the status of gcc-11 with regards to that
warning.

In the mean time in 26117d92d001 ("can: kvaser_usb: Remove
-Warray-bounds exception") that was removed, as gcc-13 should be fixed.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--u63tyxrcg47sgpwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNfiisACgkQrX5LkNig
011hdQgArjtMO7ZspDwL/AFmWmY5KiCDgnwlDiH5Ic13zvPjWYgGImjm0/cC1wV0
G13QgNe/NSoFgb77gSatWdhqCtZznYZB4tyWx6aezsWf6RE/NaI/I/kMadKlgmbd
zgIvW7VwVOaLQmsH/eyXyhYLwoFPbF6RdLQknsKNSzFF5V0yki6G6ohmV3vpBzwc
u0tvTeyjmH/GRm1kvPZMSttyaivBi7KJTwthxfURWpW0DatGUkY04E36ulOa328/
HzTe1fkFPAUQtwdmNuc14b9xSPD17RY0DzJBLax3qJ7pUD1Xpzro4IKa++wEl5VY
aQZN0xvRYTja3NI31xotpJIEy62tIA==
=8rhB
-----END PGP SIGNATURE-----

--u63tyxrcg47sgpwk--
