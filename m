Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA26D54F3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjDCWxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjDCWxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:53:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA3F19A9;
        Mon,  3 Apr 2023 15:52:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pr5l875Gbz4x4r;
        Tue,  4 Apr 2023 08:52:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680562373;
        bh=SYaIKZ+ajoRiBsT2jMRGQlpJDQte1oTrH+VBxkS6uWc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ui0dmZO32c2bFn6/PIml5CJzHrk0aVQj+r4eRzHLiiXf0ujjvb6C8o6yWhG/mjgWN
         62OXGWpSnJanH+WXn09UvLUL4zOhukQcmjua/8O5tXbvAUkciHchWqIXqjdg5Q+J5p
         h1CbiwpbQyhkALN+QQU0N9WtbTnRczCQuauR38gUKy2Oc8mWTULgxvaiDJNJIx2FRo
         WtV/UJg81hcte65dx1vB7crII4EQoFUunDUUC93op0qNqIJACf0P8fuYsVC38/XZhH
         4MHXPDuJxR5JkwnbOU7pKJPNJ2yMWA3ZLEHjIdNEoXUwo2Eh8IVNDkiardlBm7p2nY
         Ged2ZqXRghtAA==
Date:   Tue, 4 Apr 2023 08:52:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Apr 3
Message-ID: <20230404085224.21843f6e@canb.auug.org.au>
In-Reply-To: <2023040305-childlike-stew-4f8e@gregkh>
References: <20230403202412.66d43f13@canb.auug.org.au>
        <20230403155147.GA239124@dev-arch.thelio-3990X>
        <2023040305-childlike-stew-4f8e@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/t1Iy2OJH1p5M2l_wF3K7gWE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t1Iy2OJH1p5M2l_wF3K7gWE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, 3 Apr 2023 18:01:38 +0200 Greg Kroah-Hartman <gregkh@linuxfoundatio=
n.org> wrote:
>
> On Mon, Apr 03, 2023 at 08:51:47AM -0700, Nathan Chancellor wrote:
> > Hi Stephen (and Greg, just as an FYI):
> >=20
> > On Mon, Apr 03, 2023 at 08:24:12PM +1000, Stephen Rothwell wrote:
> >=20
> > ...
> >  =20
> > > Merging driver-core/driver-core-next (43ba3d4af7a7 pktcdvd: simplify =
the class_pktcdvd logic) =20
> >=20
> > ...
> >  =20
> > > Merging char-misc/char-misc-next (48a6c7bced2a cdx: add device attrib=
utes) =20
> >=20
> > There is a semantic conflict between these two trees:
> >=20
> >   drivers/cdx/cdx.c:393:8: error: incompatible function pointer types i=
nitializing 'ssize_t (*)(const struct bus_type *, const char *, size_t)' (a=
ka 'long (*)(const struct bus_type *, const char *, unsigned long)') with a=
n expression of type
> >    'ssize_t (struct bus_type *, const char *, size_t)' (aka 'long (stru=
ct bus_type *, const char *, unsigned long)') [-Wincompatible-function-poin=
ter-types]
> >   static BUS_ATTR_WO(rescan);
> >          ^~~~~~~~~~~~~~~~~~~
> >   include/linux/device/bus.h:129:42: note: expanded from macro 'BUS_ATT=
R_WO'
> >           struct bus_attribute bus_attr_##_name =3D __ATTR_WO(_name)
> >                                                   ^~~~~~~~~~~~~~~~
> >   include/linux/sysfs.h:135:11: note: expanded from macro '__ATTR_WO'
> >           .store  =3D _name##_store,                                   =
     \
> >                     ^~~~~~~~~~~~~
> >   <scratch space>:30:1: note: expanded from here
> >   rescan_store
> >   ^~~~~~~~~~~~
> >   1 error generated.
> >=20
> > caused by commit 75cff725d956 ("driver core: bus: mark the struct
> > bus_type for sysfs callbacks as constant") in the driver-core tree
> > interacting with commit 2959ab247061 ("cdx: add the cdx bus driver") in
> > the char-misc tree. The following diff fixes it for me, could it be
> > applied to the merge of the char-misc tree (if I am reading the order of
> > your merges correctly)?
> >=20
> > If there is a better or more appropriate way to report this, please let
> > me know.
> >=20
> > Cheers,
> > Nathan
> >=20
> > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > index 67c32cb2c006..38511fd36325 100644
> > --- a/drivers/cdx/cdx.c
> > +++ b/drivers/cdx/cdx.c
> > @@ -363,7 +363,7 @@ static struct attribute *cdx_dev_attrs[] =3D {
> >  };
> >  ATTRIBUTE_GROUPS(cdx_dev);
> > =20
> > -static ssize_t rescan_store(struct bus_type *bus,
> > +static ssize_t rescan_store(const struct bus_type *bus,
> >  			    const char *buf, size_t count)
> >  {
> >  	struct cdx_controller *cdx; =20
>=20
>=20
> A patch was already sent for this:
> 	https://lore.kernel.org/r/20230403140416.28183-1-nipun.gupta@amd.com

I will apply that to the chat-misc tree merge from today.

--=20
Cheers,
Stephen Rothwell

--Sig_/t1Iy2OJH1p5M2l_wF3K7gWE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQrWMIACgkQAVBC80lX
0GzjxAgAiaKsnm1hcxS5FDhw4tg18TgFTO4lNGGIiYxYW2lRTcgRW3/KawdsH9S6
zNaBTcVV06FVnMZW4oMc6I0aTSvwUCvbkfpNQYoDLpv4TEnjGOWRbLxhZE078MYx
LLnkm/nJJE+zAZJPX4ec2KKzkbKxNVmwOsZ62EJeLAXreaB0z1aeG4fW8/gyEzOM
b7EnX8v4bsxSrvRsC2EHTKSswMympAJdkEQOKNOtdNUI8rF7/h7Ewb+m096MFo8B
m/jqaVrEl7gKs+eJTAlH05pRwsnQSvZ09lO49qmOLsZHnaboWHIzj02gSddTumzY
3wmipIm+eaCqEkrBagRpABsw5z+Fkg==
=2Awa
-----END PGP SIGNATURE-----

--Sig_/t1Iy2OJH1p5M2l_wF3K7gWE--
