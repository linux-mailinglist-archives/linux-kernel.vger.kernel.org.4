Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582BB5EB670
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiI0ArE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiI0ArB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:47:01 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F92DDE84;
        Mon, 26 Sep 2022 17:47:00 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 81AA5AE4;
        Tue, 27 Sep 2022 02:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1664239578;
        bh=wSCmoahme/wBO9azmqpH+7KdgABDfd0O10sTNVFQMxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dpc2wT+V6SjuHtqfoU5ZFjexa5Aahr35WX0+p7fRP5umzpZ5FzBVPQocDisMDSdC2
         w1t7ng3+S1p/pWKu0j4fyag/Npjoz8eZcUqZihyN3rxfgR98PtgFWnMYZOZRS492ZV
         shDVeT7LfYTMqO8Efj4XJCGvj438D1ugoKy9g2E4gUsHZT185i67hDAiC/Km9fH4Zn
         zMYDrJC2LltYfWolndN79lZST9A17523To/LAbsov0JlrTgZlYSMxv+74FzncUsUAo
         rhaiIKYVofjoAE0NbijnBdlhrM7KWDICYzsjL1gqEdho1r6Hau5R0QO48fP7miNyBp
         f2JCK0mdezpPuq1LzHunB99KFnf6JtM4uN099zqzd2cPcF1DrbMRSz6TKJviiPhjMH
         qoRzqRy+n7a92SfTp+oQeUVJVPe4a5QRSZ+sn00wd8kHYUD+Fn1TECGRNdqsOyzpFq
         zrTJ0xwneOOKZyGYhWou1+2exwau/r2eODcncszB2QjBQ1ADZogsDznlVPCtd9ig8K
         24XORnKXUnQ3OVdmXoJcYwkeZ6BvlfBik4TwnmW8fXLEvk/1LnO6OX3eIRmUWb3D9Z
         YHAIGw3Xw1hJFE2tjxrinhTppHnPr5aWqnNdYk20zlHdAS9eXSYciLiH8p7dBg+3VM
         oDzqlpvTYYC2GG7sFnqKIMI0=
Date:   Tue, 27 Sep 2022 02:46:17 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Manfred Spraul <manfred.spraul@de.bosch.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 jc_docs tree
Message-ID: <20220927004617.xwlicwiwekxp2dna@tarta.nabijaczleweli.xyz>
References: <20220926210631.657728-1-broonie@kernel.org>
 <20220926224621.47llaskp6mihi4dd@tarta.nabijaczleweli.xyz>
 <YzI5SmGq9sK4gnFT@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="okozqc7em33lbxec"
Content-Disposition: inline
In-Reply-To: <YzI5SmGq9sK4gnFT@sirena.org.uk>
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


--okozqc7em33lbxec
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2022 at 12:44:10AM +0100, Mark Brown wrote:
> On Tue, Sep 27, 2022 at 12:46:21AM +0200, =D0=BD=D0=B0=D0=B1 wrote:
>=20
> > If I'm reading the merge right (very much not a given!),
> > it seems that the NBD_REPLY_MAGIC (and LO_MAGIC?) constant(s) survived:
> > they both need to go for reasons listed in
> >   bd5926220ffe0: LO_MAGIC doesn't exist
> >   82805818898dd: NBD_REPLY_MAGIC is part of the line protocol,
> >                  not a magic number=20
>=20
> > This also reveals that I missed NBD_REQUEST_MAGIC
> > (needs to go, same reason as NBD_REPLY_MAGIC)
> > in the first pass, but that's unrelated here.
>=20
> I preserved NBD_REPLY_MAGIC since the conflict was due to it being
> updated by the NBD maintainer, I went with their logic instead.  IIRC
> they'd also moved it within the file which might make the resolution
> harder to read.  LO_MAGIC is gone.
>=20
> It's not at all clear from what's in the file that your logic about not
> including magic numbers defined elsewhere means we shouldn't include
> them in the table here, though the commit messages are rather brief so
> perhaps there is more to it.  It's certainly a very strong definition of
> need as far as I can tell.
>
> > (or, indeed, if it does include... the conflict markers?
> >  because it does appear to introduce them
> >  (or, at least, if I leave in the conflict markers and commit a merge,
> >   it sure looks like what's represented below)?),
> > so idk.
>=20
> I skipped out on resolving the conflicts in the translated copies of the
> file but messed up on resetting the to the base state.

It seems I've overestimated the degree to which this matters
in this case, my b. Put me down as "don't care".

=D0=BD=D0=B0=D0=B1

--okozqc7em33lbxec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMyR9kACgkQvP0LAY0m
WPG28Q//cxas1ROh5VTtMbi01t/T1Qsa3qWSvN4sIUI3AcRJaoEGqMsnMguXz7LR
3DjQ5tZbc6lYjuU0vGrCtsVzdYDitH1FkNpovpUJ5GEq6E5qtbJCj8wYyAEdd4cl
JqCD+W7WgMM9FYiHIKTpsS7yYhdbjBp2a+8SNXqFZlf/99CeGMmYEW07V8slZFMq
Sl7KUZHuw9VsgjE703z3gpD3dL6AFQd9iEClUscyUeiUek+OipI2gTXsGVXQCoH4
A8FgYqHxKV0vbBSeVverMI8lTwOU4J4uYZpNORyc1o2QlzyXgji2Wh1ThAEkrPbt
HMnB3919YUj7zBYZOoRbhanqdRhH0SaP7hAq2R+4z5TH/wrXsS6vGps00U9gJ9ej
YHmjSCj35R0gDJ70Kg+2YqYVS8/OhrKnLU/sOVXHb+SegCR4tW7WWWhwkDeI+09g
4B4RYIC6/bec/RBIqstfjxBsHoo1LMzM7kqDMPOj2ZNqEgKQjMC6jzHtWi10ISm/
kqKw5OnA8H31LFERYP7QxmCSQOrusgicFan2j4DWW8f4WMNycjqrnBIht5ZrIqSI
EQ09I6ZugKHatpWhAIHPLrYkyvO1XFsDrKgqpuuhyhURWWvR0P36kBR3NC/Ng1aC
2EewTL9obhBmN8viZSFbc6GV7aqlFSvDXGMb5GPTLhQutwy3Gw0=
=3Zoq
-----END PGP SIGNATURE-----

--okozqc7em33lbxec--
