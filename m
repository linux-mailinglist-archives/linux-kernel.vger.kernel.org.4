Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92C864AE8B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 05:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiLMEEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 23:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiLMEEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 23:04:33 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935B51DF22;
        Mon, 12 Dec 2022 20:04:26 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.49.245]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MuDoR-1onxTw0NQb-00uWbT; Tue, 13 Dec 2022 04:58:33 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 966C03C0C9;
        Tue, 13 Dec 2022 04:58:31 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 26F47381; Tue, 13 Dec 2022 04:58:30 +0100 (CET)
Date:   Tue, 13 Dec 2022 04:58:30 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: ensure Make >= 3.82 is used
Message-ID: <Y5f4ZgyK7QlqYu31@bergen.fjasle.eu>
References: <20221211030352.2622425-1-masahiroy@kernel.org>
 <Y5djBr9rVhSq8+iK@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qiUajzA37JnJs5lE"
Content-Disposition: inline
In-Reply-To: <Y5djBr9rVhSq8+iK@dev-arch.thelio-3990X>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:ce7jmiET6SD91dPNTFBj5cbC8cWGi2R4bwN/lR4AU2vdLr78uuA
 Iq63o2NlBELuR5VRhCoH0kFildRiPNLWOuBIpIfzvmFOrotTeFUG4v5ELaJcDYwvzYxnvbV
 rAWVJUJYqj3rWf3vw0rSC4P+U2JKIH26SaMhF4U1lPshMwJrNOVQIfghreXzg54wbzKxwG6
 dBB5mZalBqOjFgLWX8m+Q==
UI-OutboundReport: notjunk:1;M01:P0:kBqmWvQ7KL8=;8Sy5dR218fiTyPQQE8QCXLaTeLD
 xns9cDIA+DxoZ/6xUJE+EJ3X8kXLSEmU84lkD/wCAUgNtnFDFUdGJn+/lZD3fPRhybnWEepuH
 k0koNGFv70KVhMhDojpxnAk+rkVxjEjS9KjbBS/gTCZ1UKjTBi/aem+KEX/Vn7/C/GX2ZhM3V
 vOsyTm0e7QBK3mxUvDk9qVBmCApqcAYyVhIpBoiwuyU3JP4FV3j7/A3awyJ4hR+xuBGKoe6Ok
 MuK4eYJX78hjwKYngpYDLmNQsyPdLgQx2C6QkPv8UPX5w02JkltlEk5urcRrrbzvkW+09tVfM
 nkJaHGNNIxCFLuxfB7ktUdfGQr0BtqXlNWkoWSpRP8OeFE89KiRRgmzH8eszejTLR5BAix9RY
 C1bO1GWvxRLHSJY2SXAwXIViW5V5VdDfZwzibKJP9p+bGkodR242N+wjcD/khqgwv1O57RRJc
 eQVlrnKZTtdRDAzTdyyTrpMRD1xbYk4mu6q/wjTeKeIBRBnmQB5b3qieVk+zA0tvkT8OQx5wF
 fuTGCkN4PA3KRM37aLT+xs13QPQ17bCZtS0ICzpnlt+MWfmrLI9duOhsQis1CmSGIn8cM23HJ
 F35dIjMxLdbE3voHf/DsoOkD9KZ9rrCeTPFj/dum3d/NBVObQfl0fWA8Wzy6so+Tr+odGD/Op
 xhGHF7MJah61ZsKIcJGNV1WB6zQGzRuMdv9HxZsNyg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qiUajzA37JnJs5lE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 12 Dec 2022 10:21:10 GMT, Nathan Chancellor wrote:
> On Sun, Dec 11, 2022 at 12:03:52PM +0900, Masahiro Yamada wrote:
> > Documentation/process/changes.rst notes the minimal GNU Make version,
> > but it is not checked anywhere.
> >=20
> > We could check $(MAKE_VERSION), but another simple way is to check
> > $(.FEATURES) since the feature list always grows although this way
> > is not always possible. For example Make 4.0 through 4.2 have the
> > same set of $(.FEATURES).
> >=20
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>=20
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> > ---
> >=20
> > Changes in v3:
> >   - Check the version in a different way
> >=20
> >  Makefile | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/Makefile b/Makefile
> > index 2dda1e9a717a..66dfc5751470 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -11,6 +11,11 @@ NAME =3D Hurr durr I'ma ninja sloth
> >  # Comments in this file are targeted only to the developer, do not
> >  # expect to learn how to build the kernel reading this file.
> > =20
> > +# Ensure Make >=3D 3.82
> > +ifeq ($(filter undefine,$(.FEATURES)),)
> > +$(error Make $(MAKE_VERSION) is too old)
>=20
> Would it make sense to state what version is needed, similar to the
> Kconfig checks for compiler and binutils?

Checking against 'undefine' (introduced in make-3.82~38) is quite a=20
nice way, I think.  Otherwise we needed something like
$(filter 3.82% 3.9% 4.% 5.% ..., $(MAKE_VERSION)).

Kind regards,
Nicolas

--qiUajzA37JnJs5lE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOX+GAACgkQB1IKcBYm
EmmqMRAA1vftfyhTMiJEISX7t3qa8wCAh+1VeF5PU9lURhfbjBQ+FnKhwP1zjwzG
Jc0SlnaS/1kAHnl14G6l9bUJ160D5x0adWAj5t4DGhNIwhWu/S5yE6rFvteTGJSN
FinR+NzfKTHq+N19XutmPzxgh8P/ZusMUqgtsTyma4JLWXVZe/JYC4yJgFfDRa2m
7/0YriULcEs6F4SnoFnsr+iI1ega4hsQC8+OPvK3JFltot4RVc7Oz6lwARaaeJoI
c0nPFlgpoM0sryZOxRqt3niccJmxf1kBB7i4AZfXet9bFVwAwRCGpG7O/lzIXqgk
/HbYCK7dtt3AxlCJhk61efXl2vTSY0Keb60/tkQltCUMCgNn5BwcJ8StW/lKbrXD
UHL/AM2LPubXGftn8MACblkGoWEczOCWPD82GCRlhaJkqBFTYDtWxQ8vQkZCIOLV
8AIYdL7urwAnxoP3aGmeBPDGZFk+Pm2ZQQFqPOzs31uHpWMySCAzn4zXLaXJpbGw
lFMX61p/v8VQLVOsyTg+Ve3wkEPyjdWrMaEf84rEQ4gTmMm3FgflX3qP1q9OePJN
6923JwsEsZnswzetBOfnCnxDui+yCuSkEIMCdTzpzx4Z6una42E7N8og0so6q8Uq
YX2doQgdo+UGI6Q0JuoHWOj6xTDGyqhiV/iWGbUuSmT3pw0BKAI=
=tiub
-----END PGP SIGNATURE-----

--qiUajzA37JnJs5lE--
