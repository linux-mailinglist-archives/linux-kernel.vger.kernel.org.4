Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3736FD3FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjEJDFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEJDFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:05:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259F21FE9;
        Tue,  9 May 2023 20:05:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QGKdn1TVJz4x3p;
        Wed, 10 May 2023 13:05:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683687918;
        bh=QroF8bh9U0WeAjMaejAfADav6vEy36poqnKHClMnMuw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tx5lGLZBb7JBw2yWi0j+YNlYXYQRMw5y4AABZYCwCHbZKpWhFTymKuu1BDL39sb8C
         YsYycYJy7GqfWXhqaoB8NUV0iT9hnEORAnXiwmFosw+wPJCh2jRGpIRyOvy5VA/1Yc
         RlB+aMkEC/rAaukiI4z+iH4Ae3TOKrN0z2AVSNXnkA8BzzQ2TOUSwEUoLAv11jDngt
         HbD2AGEWzM1zLer6mIbp6vRKxbz3nVF1F4tTUDUUkjme/k5LbpLOVAyTq3LOdlMe5s
         vPbcvRY91JFPAsTntyDo/6c8P4Xi84lasUkCfSXxM1l9c1bLbncyZU/COopRQNcFqe
         aI2LXprS++Cww==
Date:   Wed, 10 May 2023 13:05:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boot warning
Message-ID: <20230510130515.5bd2e73e@canb.auug.org.au>
In-Reply-To: <ZFpnroBw-tJnyDbF@slm.duckdns.org>
References: <20230509122440.418068cb@canb.auug.org.au>
        <87mt2ex9oo.fsf@mail.lhotse>
        <ZFpnroBw-tJnyDbF@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sSVC3+1Rang__bXKLFAtY6E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sSVC3+1Rang__bXKLFAtY6E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

On Tue, 9 May 2023 05:33:02 -1000 Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, May 09, 2023 at 05:09:43PM +1000, Michael Ellerman wrote:
> > Stephen Rothwell <sfr@canb.auug.org.au> writes: =20
> > > Hi all,
> > >
> > > Today's qemu test boot (powerpc pseries_le_defconfig) produced this
> > > warning:
> > >
> > > [    2.048588][    T1] ipr: IBM Power RAID SCSI Device Driver version=
: 2.6.4 (March 14, 2017)
> > > [    2.051560][    T1] ------------[ cut here ]------------
> > > [    2.052297][    T1] WARNING: CPU: 0 PID: 1 at kernel/workqueue.c:5=
925 workqueue_sysfs_register+0x20/0x1f0 =20
> >=20
> > Caused by 59709bb84c22 scsi: Use alloc_ordered_workqueue() to create or=
dered workqueues. =20
>=20
> The patch is already dropped. It was applied only for a short window
> yesterday. Should be okay now.

Confirmed, the warning is gone.

--=20
Cheers,
Stephen Rothwell

--Sig_/sSVC3+1Rang__bXKLFAtY6E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRbCesACgkQAVBC80lX
0GwMjwgAoD4s8qBwKo4vlC6Bb8Ht4bgGBS4gcAXhRl6ltGV7Cskbx1qIYr4OMRA6
jn9WojQ1HxiFKOtQF/FFL+DvqSyKPw/H9XSwccmNRJSFKPgmmDcMfLIRIgWhGGhw
9RlY3a2GRrFynBHmGA4riczgeJwHFQApE7gPwqylsiSDRhnrjKG/B2c7bBeJ9oCf
A/vIrasXAu9PSUu0zk7zuCXLzKJ2vGbTXahuazaXxqOfwASedG4XkuUfjDxbRMga
1hFz6zpcE9QsfTlGD+ZynTevn0RMl/lowgf5BQ9G1gZBTcr3w4LpD89q7KeRJD0X
CWot8FRKgKk2jPBo+bFbt+36oHaszw==
=142R
-----END PGP SIGNATURE-----

--Sig_/sSVC3+1Rang__bXKLFAtY6E--
