Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF9769CA9A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjBTMQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjBTMQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:16:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E251B33A;
        Mon, 20 Feb 2023 04:16:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PL1c12Crwz4x4p;
        Mon, 20 Feb 2023 23:16:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676895378;
        bh=N4TG4gGFRHnE28Si8js6f2rag25mIHAHZaYiIzZm1jQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bQJf0aq7N00nGNTO61pCnvFhpNPPxUwQgaCPo9haUXtlfKPBx2N+e6MsquTA5zQA8
         DGV+u2CdY8KsSs3Z05xxtvoln32nNx4+nzWxCPl6sTMUpzujMBALGSaQU18gRGVRGV
         WGzVU8Zi1iYyPfR8tEAAhB3yt7GZumFyAt+6oKUjON/hc3MWVGl863OF6EMRF0NvsE
         pPV4S5AZyZWKxmhe8hAcZMSEagsU05ihrKW8xF3iHahBEyJmFJTVv7EVLKnEKsBeYp
         h4d4/ZG5vONU8/QS3XroN2dhknMzdBFu+DdcPMlZOaBpDj+74GL4TmDK5t3NMrok32
         sdYcEnx8tXXsg==
Date:   Mon, 20 Feb 2023 23:16:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the driver-core tree
Message-ID: <20230220231614.252a5fda@canb.auug.org.au>
In-Reply-To: <Y+u+B/yi51JB26If@kroah.com>
References: <20230214125700.606a89d7@canb.auug.org.au>
        <Y+suRQBtzCWx+mjo@kroah.com>
        <eade11f9-22a2-1e7b-93da-d52b63cf9a5f@intel.com>
        <Y+u+B/yi51JB26If@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7W.xPThyC_4G4PI/3AY_be3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7W.xPThyC_4G4PI/3AY_be3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, 14 Feb 2023 17:59:51 +0100 Greg KH <greg@kroah.com> wrote:
>
> On Tue, Feb 14, 2023 at 05:47:16PM +0100, Wysocki, Rafael J wrote:
> >=20
> > On 2/14/2023 7:46 AM, Greg KH wrote: =20
> > > On Tue, Feb 14, 2023 at 12:57:00PM +1100, Stephen Rothwell wrote: =20
> > > > Hi all,
> > > >=20
> > > > The following commit is also in the pm tree as a different commit (=
but
> > > > the same patch):
> > > >=20
> > > >    a0bc3f78d0ff ("kernel/power/energy_model.c: fix memory leak with=
 using debugfs_lookup()")
> > > >=20
> > > > This is commit
> > > >=20
> > > >    a0e8c13ccd6a ("PM: EM: fix memory leak with using debugfs_lookup=
()")
> > > >=20
> > > > in the pm tree. =20
> > > That will be fine, thanks for the warning. =20
> >=20
> > I can drop the EM change, though, if you are going to carry it. =20
>=20
> When one branch adds it, and another adds and then removes it, and then
> the two branches are merged, what is the result?  The patch added, or
> removed?

Well, as far as git is concerned that is as if one side did nothing and
the other added the patch.  So the resolution would be the patch added.
This could still possibly be not what you want, though.

> It's safer to just leave this as a duplicate, I know git can handle that
> just fine.

In a simple case when no further conflicting changes occur, that is
fine.  I have been getting quite a few (especially today) where that is
not the case, however.

--=20
Cheers,
Stephen Rothwell

--Sig_/7W.xPThyC_4G4PI/3AY_be3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPzZI4ACgkQAVBC80lX
0GzjSwgAhlZCslZFgM8FxbJsSwex5l1ESDGzr1l/RFhQq6xWVaRs3sDKPeb5DAcZ
xT1QmRsVAICaCBh8aNzk8BcY5Tck/NAKaM7Pp6afwSmDU8fnjQi2srOyzTI6Uqio
mu6Kc25sJoYEizR+IPV+cNxVAEJdsmB2HD1ZpVV6bC5ym2aopIGBBDp++POXivoq
bJm4it38GKWFbjzhQIvlL430nzTKDUY7HlorXTUz/FCsU4OWzrV/L2ZLwewWu1H6
zMmEFv5v6J2FibuiSwvU5VMV3X7140FS1Q1Hq99ExVhdhaw2Ng5HPotDeZYNB5O3
FJ66HwkN6CK90TRd9IRlb2AOZblo9w==
=NRDq
-----END PGP SIGNATURE-----

--Sig_/7W.xPThyC_4G4PI/3AY_be3--
