Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505AB60F63D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbiJ0LcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiJ0Lb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:31:57 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33F5A48CBE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:31:55 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 7CDEE4C0A;
        Thu, 27 Oct 2022 13:31:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1666870312;
        bh=UUlIZl5cAzP/NtOFIMRVxZ+RS3X8Yu21M0IB8CArKw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JeEwZfBdi3oRypgUGujWI9/p8tReDTutswb5H5azrJPGmlVD018Y4qIATFGr9G99t
         zauY2F241TCL5vHVl8Mwl2DoOV7VnfiRvT1B7mNtYdDZVEf2aKiO0qMUNn2HVHiIyX
         1fL5My+1q9n/h41n/r9nnKdR9ec/mebRo03cHHSMdMAyFsoLo4Y3K2oH3H4ty34pLF
         0Uf4o3QPkh6oZ9HwSTwNSpzUvQ8ifxlmZqDHRz9u9dEedFaTEg510CkJX9P82AXTEI
         TQHGGdNKAYOCqxGhC/rZ+5wJ3HD6NBtgC3rHGUTo7GmI0TH71eMI+0fviqp8L22Q+e
         bpi/0L6Znke0sV72e4B6gNAFpGqQ4wOHv2r15wr/6qCvfowmLw3t1hzzfQJt7yqzu0
         vjkI8+GVwtj/9GqtiotQB9zrZN+KHMFXArPeNWKv82et1t2kMYmr6s9mUWRVVO32JL
         0XtFLA/GXushjYS2BbS0AlOqJvjFNuJ8ofNlV7drO5Kx7YMpxupLHJNW5vUWnIN3hS
         Nzd8QloKO8xzLEIA2u5xl683uypSg4HVKAxvHB6ERBv/XBfYGjLTN5usRgNsTN3N1U
         yEJslbDtMM+mxlscz0nqimyV1s2RT9GThVrIMA6lPGwQYNeOO+LrSBYfrRlJkkPBOb
         cUL8KOxGFCoghEUPw6WHRm0U=
Date:   Thu, 27 Oct 2022 13:31:51 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] pcmcia: synclink_cs: remove dead paranoia_check,
 warn for missing line
Message-ID: <20221027113151.6fllc2chqgcouxh2@tarta.nabijaczleweli.xyz>
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <051083d29e5812608deb034dfa86ae0c583fee44.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAHp75Vd6iWi98WxP6ex5Thvm4QPvYj4C343dogOY_ZqXTgKDGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a2k6engvbsijmcqu"
Content-Disposition: inline
In-Reply-To: <CAHp75Vd6iWi98WxP6ex5Thvm4QPvYj4C343dogOY_ZqXTgKDGg@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a2k6engvbsijmcqu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2022 at 07:53:34AM +0300, Andy Shevchenko wrote:
> On Thu, Oct 27, 2022 at 1:42 AM =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabija=
czleweli.xyz> wrote:
> > in that case
> > ("invalid line #%d.")
>=20
> Please, respect English grammar and punctuation, in particular don't
> forget the trailing periods.
>=20
> > +       if (!info) {
> > +               printk(KERN_WARNING "%s(%d):mgslpc_open: "
> > +                       "no device for line #%d.\n",
> > +                       __FILE__, __LINE__, line);
>=20
> Even though the old code uses this awkward style for messages, please
> follow the modern one, i.e.
>=20
>                pr_warn("mgslpc_open: no device for line #%d.\n", line);

Both applied for v2.

=D0=BD=D0=B0=D0=B1

--a2k6engvbsijmcqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNabCYACgkQvP0LAY0m
WPFGkRAArZJfVdUYYKf72qXnKyu2jUqvJSc3dqTdPJk7qtON3OkKqGAdor3MYPIm
/3vZ/VXzjAdggtDuSpHBeyPz+FwKuM6Vx0UFJ+NuwRGb1EaqpiChe7B7Mb4v2sdx
Yf+GWBG/sBNrlcIkAOvCGaeW1mAOC/3wgaqPsyPsNLb9n+1q2gkDVLs6uLoyFYbB
JojFBuEaX9zrGGYBell0AYjMa2t6kjw3NSz+uB+hEghPBzSJylGaNbUsIbd5C46z
kxeDtZBxi/c4H7zCtvosqTA6B08rD9oWi+XbLWFyflKbWUk59JCT1DKDVP3JdXBN
lgEeQCKWJUWgLtiSTUn8vL5xxCBEkwD9y3dOnpUMNd4VTEGOfwCF2jJTZ74xYD1M
ixlo7sXDZ0rkNg3lDdS5TzFMUge9hCcR/iIPDm8/8wThBcCV8Z1J+k0qGhvOMwjz
3u7CBdz9qMhKQI6b60qgk3zWHzKzS2I9QZNuVWxiVJePUQ5aRjMPNnw8jhvLWk5Z
4LNkoemRF2qJheUvU+oJl/EVlXNwg/uVG9/7DnIAX+GHsTcY4yqoT8tMhzopALBT
Uiv5c86xi7NsoW7XqlPmqLp8HMih37I2Lx4vQQrTrQ7lO64hqet00ZwTUa+EQiFt
L+OpojRfKbORWS9Cmcm3RIjx/4c5UxZTACfBHSqwiaw1nUeVl1U=
=8WU0
-----END PGP SIGNATURE-----

--a2k6engvbsijmcqu--
