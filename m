Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048326E2E5A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 04:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDOCB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 22:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOCB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:01:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2530D4692
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 19:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681524037; i=j.neuschaefer@gmx.net;
        bh=bsr0bAHoqx4KWsAQJ5qoM8LRveyj5CWzKISZ7bzRopU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VOHITXrqPbCQLym8qEuM43l5zyjRUSSDXvswddBnFGS23rQLnhuPsYw3YQ+O0LRhy
         Ux6P5ScPSAZc7jpmjw+mu1FC2aihgoyImrAGSj86HZhArUQHm1rpLbqiNdCIUbrnwR
         nbLQ9tHKXO1XCU4isdDYphfHvJdclqbZhUYcb1PsgQsD18rsY9qn6Di8hE++a9eOjv
         E+Vrc1oFoUq+c8CRMBxXiKjhDCz9q35Jx9UlmF0nkKE2zV4oiulOiz+bMAo0DWDdv6
         bZKSHonVKdJzx1us1qJRhBbF6cF3Aa1DOD58k1qEFfYtY36On7i6myC6l3J4jiMMgf
         90wiS0NAoocrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([81.173.153.53]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4z6q-1qWpua3ccm-010tPQ; Sat, 15
 Apr 2023 04:00:37 +0200
Date:   Sat, 15 Apr 2023 04:00:33 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nick Terrell <terrelln@fb.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM ZSTD boot compression
Message-ID: <ZDoFQUYMZykLdTbX@probook>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
 <9ae523ae-aad4-40b1-8b6b-d5e18bf8b92a@app.fastmail.com>
 <ecf9f34c-1f1f-47af-a470-0a6ae7773724@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tUChAbDuev3sy1VC"
Content-Disposition: inline
In-Reply-To: <ecf9f34c-1f1f-47af-a470-0a6ae7773724@app.fastmail.com>
X-Provags-ID: V03:K1:dM6Pk1H8/3BPe+XLgtnk5l30A5hDSGMhXcW4Baf8aIZBbz1Q5Lj
 gijykOFKwz9kAkn5OGnh8S0uPrpIv9hy0mlwr7GQ7bLVzP9SL0NE9knZyt/eXJDuu2sFjEB
 5pCUv2Hq1J16EqqzrQ7aOoZIrvL8Bz0tS4EkYjBI40t5H088blsLIMIeh8W/BVxiNuB0+Ok
 P7RUU/wVxULGhH51boavQ==
UI-OutboundReport: notjunk:1;M01:P0:5T46tHmqSH0=;8aLgwAkeX0DLCn04ncyL4b0nqUJ
 CmeouTgLEk8A964S8R6xrM9vKibBFJ52+olRxLPfvRRA2udb67oAbTnfjTjjEv3ZkhGpES7+O
 oSC4ybRqx7c+/4GorI8u45UKTXFeVzDM45EqR7lOqYcdSiGpLJkNd4eJOC6PNyM9B4e4LVUNS
 2TPKL34ZFPg58EZT9R1/27fMvlV0iVoUG1BDLrGL12bpo7Xjs8p1wAaPCdJRdcej1hgnFdGjw
 5v709vvZUu0VoZmP+3JeD0t1KMtf+T/CwdH9kPbQDI3HZnmPZfYb3VEmw1RmKPpXoWjM+H3Xv
 gg+/ubN5MCyzozpyBQbUYlfga5BVId6iUmS1G1xdx41LZ7sRPPWuR236dE5IcaijUxH67311r
 Fa+bhH5jHSdR68gYGy/2oi53iwFOqBAAI0iUvbwH0V3D99PjzC8OAqDk56iw1ExteJj/XbofQ
 IAwZMx/r97+lTLCmCNWh9KUZlTOiCXbklFTNpNwtG1H7L18nFI8SeJJe2JtWzr2DntBKNh70I
 ea1eLQND/d6lQ2sN2hohAunPwS19LnMM5jUHP1j6Ey3vWtnUaXRXnecK4FFGvkQr9u4GFRdCI
 1HmkAywsDe9CB+ScpJSTiecsGnxaqz4ilaQKDdKOOa9Yi57JEQn+yBaVRY9wghxLwl5XyFfff
 QJZBImdWhNmcbK12Yd6FvXuqnq6kHUuVAcgjDA/cubGFsf6A4yvoqgeTUvCyM0v1MOd7P+sC8
 LnDgyWEI6zhgjIU59rl31TACk6We0R5DrSiLi22C+WYGTUICgZ0DUYDFaS+r7r5OgjOw2uytI
 yiFuG8tnhQ24BvCl5qHqr9phKf/RpjYTcjWQh+/gCAZbc/UpJn4RYaDZV0o5zP9ormxSt3PkI
 /NheVePPDWjwGEYTdkwPmAOKK2lzfjnBIoN6PeR1AGR0ZTbzK7GY3mn6h/0+DRptvc0GjBEB8
 r3Njej1skLqOwmyRARfuESmJXBg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tUChAbDuev3sy1VC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 01:13:21PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 12, 2023, at 23:33, Arnd Bergmann wrote:
> > On Wed, Apr 12, 2023, at 23:21, Jonathan Neusch=C3=A4fer wrote:
> >> This patchset enables ZSTD kernel (de)compression on 32-bit ARM.
> >> Unfortunately, it is much slower than I hoped (tested on ARM926EJ-S):
> >>
> >>  - LZO:  7.2 MiB,  6 seconds
> >>  - ZSTD: 5.6 MiB, 60 seconds
> >
> > That seems unexpected, as the usual numbers say it's about 25%
> > slower than LZO. Do  you have an idea why it is so much slower
> > here? How long does it take to decompress the
> > generated arch/arm/boot/Image file in user space on the same
> > hardware using lzop and zstd?
>=20
> I looked through this a bit more and found two interesting points:
>=20
> - zstd uses a lot more unaligned loads and stores while
>   decompressing. On armv5 those turn into individual byte
>   accesses, while the others can likely use word-aligned
>   accesses. This could make a huge difference if caches are
>   disabled during the decompression.
>=20
> - The sliding window on zstd is much larger, with the kernel
>   using an 8MB window (zstd=3D23), compared to the normal 32kb
>   for deflate (couldn't find the default for lzo), so on
>   machines with no L2 cache, it is much likely to thrash a
>   small L1 dcache that are used on most arm9.
>=20
>       Arnd

Make sense.

For ZSTD as used in kernel decompression (the zstd22 configuration), the
window is even bigger, 128 MiB. (AFAIU)


Thanks

Jonathan

--tUChAbDuev3sy1VC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmQ6BUEACgkQCDBEmo7z
X9tlOA//SDYTuVEU43pN9k/3lyWTymKfJ7d9WXttxT9YJ+pIeNougz1W0HipefGr
sfmBu4Z47iRaJYPAUDXGo28UFXUgAHxPmJ0CbPOpOkdV11IdB545eT63t9xajH7Q
yUF3CH3gPU2wKX9stnD+i5B5UuoY5cK+AproPBoMmADR3hTepama8DsFwXmGrsuT
e39oUsp/7G0l8rWfRJ0y+CWQIXDJWXattL/kIofVZXTSxKbj+zntzqVDKjgZDVcZ
3BNUWi3BSDFiHrULQAY2KKBCxK4RN/av0SwCKb6E2q5iqxenLw4y/aCQImjrx7Y3
Tf8lLAnPwmRI8acWIVuCU86JXAO6XR8Z8/ciDJ6apWaHhYQDm6VGw4dp5/M9f2KL
XOXne4jGfPHamLORYx4Gg+5z3mxqORTO2SsJdjN1fp7uDg/QcA7CEhucx0e0V/2e
fE66F7BlqCBBv+rlStoaBaJE2VPLhslpZGJN/htI/8kkItQxvGJlYXdeJpreuMZA
fB4XNk9pacFx/m6RfvDxLQRvuKQTP0uWgRsbVCix4C7BZKR2yPhB1jPedZ/kROGY
ptDqwJmEQxhxnTvdvbsrXgebltx8a7zNmcVERYWCRaElgvDv1PmPX7DoAqTnWRC+
de3ra8/aJJcWIjHrGKpBNaAsO86+TVr+p8vC/xGbEiC7/F36QEQ=
=uukq
-----END PGP SIGNATURE-----

--tUChAbDuev3sy1VC--
