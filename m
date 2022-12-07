Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4899645995
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiLGMDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiLGMDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:03:39 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E6425E9F;
        Wed,  7 Dec 2022 04:03:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NRwsw2Rjvz4xVH;
        Wed,  7 Dec 2022 23:03:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670414612;
        bh=SUeN5NLWNEE9mx0glx2Prtl5W/yRPcJJJmfxMVdj4jU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jYhRAGxbLi8Bn0UGkotCn0sXxP2lE9iowK5Em2q425yqQ6LW59TdgMieaWEIEZGDS
         4JkVAUGevu7Jf1l8zZbqtmcv+UZPwN4cjH/pyuQEKu/dCfysAejHYNUBXYMlniIApV
         qwBIUzHhcR3LdADMjgiws/FKV7zMdLyVYMCF7HnZQuqIWCh9vMUKDR4P/XvIEbZSd8
         tmziJJnlUHk1PHHnO1SJtXsmfBNl39ewJsAf4VKinCyUfPAE8ctCljGHWFLtHcSagW
         WkbZEhmClLvLPc8gJhrDNXGgYDTCdGafQsjZnABB+aa9YbmnPMgyQ+FAJQu8QlhU2n
         vxH5ZdS1v+qcw==
Date:   Wed, 7 Dec 2022 23:03:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 v4l-dvb-next tree
Message-ID: <20221207212220.66670e30@canb.auug.org.au>
In-Reply-To: <e250c025-65c4-1760-bcfe-7efb116b5c9d@xs4all.nl>
References: <20221207075657.39b5552c@canb.auug.org.au>
 <e250c025-65c4-1760-bcfe-7efb116b5c9d@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xo+/OdhNU7blp0uI5XJQ6y=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xo+/OdhNU7blp0uI5XJQ6y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Wed, 7 Dec 2022 11:08:37 +0100 Hans Verkuil <hverkuil-cisco@xs4all.nl> w=
rote:
>
> On 12/6/22 21:56, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Commits
> >=20
> >   85abf40b56af ("media: ipu3-cio2: make the bridge depend on i2c")
> >   ca61babacbe8 ("media: MAINTAINERS: Add Hans de Goede as staging/atomi=
sp maintainer")
> >=20
> > are missing a Signed-off-by from their committer.
> >  =20
>=20
> They have a SoB, but there is a 'Link:' tag right before that:
>=20
> commit 85abf40b56af5f3130a4f9dcdb808c7feb64e083
> Author: Adam Borowski <kilobyte@angband.pl>
> Date:   Fri Sep 16 00:33:18 2022 +0100
>=20
>     media: ipu3-cio2: make the bridge depend on i2c
>=20
>     drivers/media/pci/intel/ipu3/cio2-bridge.c: In function =E2=80=98cio2=
_bridge_unregister_sensors=E2=80=99:
>     drivers/media/pci/intel/ipu3/cio2-bridge.c:258:17: error: implicit de=
claration of function =E2=80=98i2c_unregister_device=E2=80=99; did you mean=
 =E2=80=98spi_unregister_device=E2=80=99? [-Werror=3Dimplicit-function-decl=
aration]
>       258 |                 i2c_unregister_device(sensor->vcm_i2c_client);
>           |                 ^~~~~~~~~~~~~~~~~~~~~
>           |                 spi_unregister_device
>=20
>     Link: https://lore.kernel.org/linux-media/S230142AbiJTWql/20221020224=
641Z+958@vger.kernel.org
>     Signed-off-by: Adam Borowski <kilobyte@angband.pl>
>     Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>=20
> commit ca61babacbe8ada7a0671f910c22b8758f481c0c
> Author: Hans de Goede <hdegoede@redhat.com>
> Date:   Wed Nov 23 16:14:47 2022 +0000
>=20
>     media: MAINTAINERS: Add Hans de Goede as staging/atomisp maintainer
>=20
>     Add myself as maintainer for the drivers/staging/media/atomisp code.
>=20
>     Link: https://lore.kernel.org/linux-media/20221123161447.15834-1-hdeg=
oede@redhat.com
>     Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>     Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>     Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>=20
> Could that be the cause? checkpatch doesn't complain about this.

They have no SOB line from you and you are the one who committed them.

--=20
Cheers,
Stephen Rothwell

--Sig_/xo+/OdhNU7blp0uI5XJQ6y=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOQgQMACgkQAVBC80lX
0Gxu4wf9HbHT2hMXbDlhb6FwDFzpdWQ/LMA5HSpW5dILV9U1zO7faQsn7Blf4lUC
ZGROQAYefTQ9w8Rk968prJYkEhQgnzF+jx4O8Fuxsci6cf/TI764dDt4pS27qb/U
X5qfSCALyp+WkhvRtYjf5zAYxS1y/RYLhNAFpUfZos00iXdVvQZqa+UGhTyBfQwn
L+L4zmAs09kBCJ5RyQra1cXP/gpZ0vvarq73K6Dn/GLVrbgFhdNrBIeLx2G+z8Jr
0a06Ujl4Fy6ufgg/WhsyCxMcJFQ78dif5vV/6bZmXimdSxjcjQg+eFbkZW0yEOGo
hwZpL0BUqvpusqqojDv4iXic6ibWuQ==
=q5Ke
-----END PGP SIGNATURE-----

--Sig_/xo+/OdhNU7blp0uI5XJQ6y=--
