Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EB46A2F21
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 11:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBZKqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 05:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBZKqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 05:46:20 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B354012F08;
        Sun, 26 Feb 2023 02:46:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PPgKJ0S8Fz4x80;
        Sun, 26 Feb 2023 21:46:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677408372;
        bh=Qf69gqalS+erSQr23jCazSB1VxuPBCS5Msd8dRmHN5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UFP+HN0CMDRK+bUKltreDR7LVG151tcmDKU/KgtmM7N4invGBuiQz0o6X567n0nMl
         LaS0eHTaTcIxn12ao00/qFC3HADENwtzemxbnFCwPBtXJ7+WcQXqSCYTZAdm+KI9t2
         HYrQNvHO+BF0HeowFpSAiyCmgRZHm9fkGDGHZf93lt0A9cgCXwJ1e7WFWBuQRQAnGh
         EzMOr3ROTfMi2APzPUT2WnkokqLnsBMUc81Iw1gWX3thcgMxGBqyfuM1nYcIfAxiSt
         q07hRHx44S2EShs1+AOA1jGd3bWgvr49UeJEL+xGNzutjXOvIkQhxsOFDZjqhhqVU2
         VPKkyBSXi8Gtw==
Date:   Sun, 26 Feb 2023 21:46:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Matt Turner" <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alpha: Implement "current_stack_pointer"
Message-ID: <20230226214607.59ac22b2@canb.auug.org.au>
In-Reply-To: <29763841-bdaa-4a4b-aa0e-5e1b3935317d@app.fastmail.com>
References: <20220224060558.1856804-1-keescook@chromium.org>
        <CAEdQ38Fg=Au5=BbyTHiEO+GaivheCe6hPBjcZhjgALxn4503Mg@mail.gmail.com>
        <29763841-bdaa-4a4b-aa0e-5e1b3935317d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oSZx5=AKndJNoGljDYvlgrZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oSZx5=AKndJNoGljDYvlgrZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Sun, 26 Feb 2023 11:24:13 +0100 "Arnd Bergmann" <arnd@arndb.de> wrote:
>
> On Sun, Feb 26, 2023, at 03:08, Matt Turner wrote:
> >
> > Thanks for the patch! This was included in my pull request today and
> > is now upstream in Linus' tree. =20
>=20
> [trimming Cc list for hijacked thread]
>=20
> Hi Matt,
>=20
> I remember that Stephen Rothwell mentioned he dropped a couple of
> architecture trees from linux-next due to long inactivity, and I
> see that none of your branches are included any more. Should
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git/log/?h=
=3Dfor-linus
>=20
> or the (currently empty) alpha-next branch be added back there?

There has never been an alpha branch in linux-next.

I would welcome one, however ;-)
--=20
Cheers,
Stephen Rothwell

--Sig_/oSZx5=AKndJNoGljDYvlgrZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP7OG8ACgkQAVBC80lX
0Gwl9gf6A6wzfVk3CbJvPQR/zksvj1uYtWMzL5VncjHOnvqoo+/PBEytPoCVOAu0
R9XVVULKy7Q03rTJFIOtwQYPtwip8Wjp3zP3EvyGTGG5VRgscPgEQo3pD/lXojBy
adw4ndru+1QKm19tLbKWSHGDKM2FkO8WNT6y42movf9NTE2yGkDJIf8LuCoaNmUy
Q4mIUlrfc42ZOk1qLfMgekyRtHR+rh8Hgt4eIkjAprJ00qoro/X9vYXwJGmkhU+9
GmEgNuRjWY4a74akiDENqztix9xfkrfxVFAra1vyvrwNYUuLlP2zHSNznBNFWCan
8zOWvzk3FK97ris0QskLxyNzDmq0nw==
=AQxy
-----END PGP SIGNATURE-----

--Sig_/oSZx5=AKndJNoGljDYvlgrZ--
