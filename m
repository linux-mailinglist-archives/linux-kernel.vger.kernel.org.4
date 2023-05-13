Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B421701985
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 21:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjEMTdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 15:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjEMTdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 15:33:41 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9311FD5
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 12:33:40 -0700 (PDT)
Received: from [213.219.167.32] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1pxuzi-00083K-1j; Sat, 13 May 2023 21:33:30 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1pxuzh-007Ro8-1n;
        Sat, 13 May 2023 21:33:29 +0200
Message-ID: <35033902c5ff4f34bc64710becda4f0bea8ab130.camel@decadent.org.uk>
Subject: Re: [PATCH] perf tools: Use $KBUILD_BUILD_TIMESTAMP as man page date
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 13 May 2023 21:33:24 +0200
In-Reply-To: <9fcf1d5f1612d45b60a65340d125364c5ae26dfb.camel@decadent.org.uk>
References: <20160517132809.GE7555@decadent.org.uk>
         <ZFqZAB2ZShmdKtvy@eldamar.lan> <ZFuVRK4cKapgaRwD@kernel.org>
         <9fcf1d5f1612d45b60a65340d125364c5ae26dfb.camel@decadent.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-JobbunylqZrV53NWU+0v"
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.167.32
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JobbunylqZrV53NWU+0v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2023-05-13 at 20:51 +0200, Ben Hutchings wrote:
> On Wed, 2023-05-10 at 09:59 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, May 09, 2023 at 09:03:28PM +0200, Salvatore Bonaccorso escreveu=
:
> > > Hi Peter, Ingo, Arnaldo,
> > >=20
> > > On Tue, May 17, 2016 at 02:28:09PM +0100, Ben Hutchings wrote:
> > > > This allows man pages to be built reproducibly.
> > > >=20
> > > > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > > > ---
> > > > --- a/tools/perf/Documentation/Makefile
> > > > +++ b/tools/perf/Documentation/Makefile
> > > > @@ -120,6 +120,9 @@ endif
> > > >  ifdef DOCBOOK_SUPPRESS_SP
> > > >  XMLTO_EXTRA +=3D -m manpage-suppress-sp.xsl
> > > >  endif
> > > > +ifdef KBUILD_BUILD_TIMESTAMP
> > > > +ASCIIDOC_EXTRA +=3D -a revdate=3D$(shell date -u -d '$(KBUILD_BUIL=
D_TIMESTAMP)' +%Y-%m-%d)
> > > > +endif
> > > > =20
> > > >  SHELL_PATH ?=3D $(SHELL)
> > > >  # Shell quote;
> > > > --- a/tools/perf/Documentation/asciidoc.conf
> > > > +++ b/tools/perf/Documentation/asciidoc.conf
> > > > @@ -71,6 +71,9 @@ ifdef::backend-docbook[]
> > > >  [header]
> > > >  template::[header-declarations]
> > > >  <refentry>
> > > > +<refentryinfo>
> > > > +template::[docinfo]
> > > > +</refentryinfo>
> > > >  <refmeta>
> > > >  <refentrytitle>{mantitle}</refentrytitle>
> > > >  <manvolnum>{manvolnum}</manvolnum>
> > >=20
> > > As we do apply the change in Downstream in Debian, I was wondering if
> > > it just felt trough the cracks and could still be applied. Is there
> > > anything missing?
> >=20
> > Isn't this fixed in:
> >=20
> > commit d586ac10ce56b2381b8e1d8ed74660c1b2b8ab0d
> > Author: Ian Rogers <irogers@google.com>
> > Date:   Fri Sep 20 21:13:27 2019 -0700
> >=20
> >     perf docs: Allow man page date to be specified
> >=20
> >     With this change if a perf_date parameter is provided to asciidoc t=
hen
> >     it will override the default date written to the man page metadata.
> [...]
>=20
> Not entirely, because the value for perf_date is currently generated
> with "git log", and Debian package builds are not done from a Git
> checkout.

Also, that only affects doc builds using the original asciidoc, not
asciidoctor.

By the way, the perf_version variable mentioned in that commit is now
always empty because PERF_VERSION is no longer defined in Makefiles.=20
But at least when using asciidoctor, the value of perf_version doesn't
seem to affect the output anyway.

Ben.

>   I'll revise my patch to allow perf_date to be set from
> KBUILD_BUILD_TIMESTAMP, which is already used in the kernel build.
>=20
> Ben.
>=20

--=20
Ben Hutchings
Life would be so much easier if we could look at the source code.

--=-JobbunylqZrV53NWU+0v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmRf5gQACgkQ57/I7JWG
EQnt8BAApJPB5GPbxOK+r6nZ3OUh1+18aWjgdyE8yLKxDB81DOhOgSXbJp50vlzM
9mxKnWpgDERiLP4HErRc/DbrB3QyRyGJt1ODRhnqkRk+hlL5DKAPlnLyDa1HTIug
wJHr79jvgxweMMIsgfv6Ds5/MU71zQnk+DeLszW9ou0QWbGfdPHTJsPvgeMSc8uw
U17iHbXAobZ5jbadfC5wATSNhad9GBNgpUIFjc35v2MXWwlv7xqZqP35S6UZYL7D
uNx2m3oNQ8wnrvPXycYfkUGzd/SgHbuXRZ5nBgtNx6K4GgJV5paVVNwDYs89D9s8
wYK2DWoWokwg60Ti3fhPMdqORz+XgaSA/EIU64SxLTPzTJTlS9gXyhC4NVIuMIf+
8Tpk6kcV8rJweWBptaCspk/IlXWEqxM0DeU2d3q/Cztjwo2f679KQBbZ6AK2Txxa
1Fui19GZgr31THF6FuKUwTbfSEKktC7A3MhQJ9LrewIfy0Vh/brc73meJzcYbp3d
APFeMqyyr8eoiv5CFKYIe86jgfFb8E59yF/NPh9PPIteLeLRQuiGn+i74aIt5nS0
+3r9iqbKZ1k6e0coqIj/pNyuaTu+9D6LxZzC0lX8mQKqSsx64EC/ubJVe6BeOsZQ
KgvlyoQunM5u1Bcs+cXSFPs4zM9YljQZUIhxA4isEIEK5eu7M8Q=
=xom9
-----END PGP SIGNATURE-----

--=-JobbunylqZrV53NWU+0v--
