Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4326E82E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDSUzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDSUzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:55:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7020210E0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681937698; i=j.neuschaefer@gmx.net;
        bh=+kT0YP3mQuFkxvRs3dKBwmFcwoMeGEjZwsAtrVLnaQE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NMwY9aqoeq8XQ0fWvlzFFccAh5Z94ZRLlk5xDdZJInsph3AHas3GhJEHqNUPdEJvj
         62OwaUN9js78ucaxkOlyfqNsn/O8TnPNCHjaklmlso0YO58oVKam/HmGNZ3c7ghRwk
         h2vHIzjWrVsYjz1OongStsqmMeXDIkE9zyeEaJ70WTkRc3xeIkTkRASyPeQHvVi4KG
         NJUQohSPXa7NVI/iNKWZrk5phVNwrq+Q9dqWEAsHSNXn1LtZlSyZCAdqEdMI/zpFnj
         b18iiOvVbIwu9kWwjXEUkKIXMlrJcMgfeR4uNR2ynX6Bi/YvBAuYLht0faEeZ7jiI3
         cwq47gjqSQCJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryXH-1qd9y31nOf-00o0iM; Wed, 19
 Apr 2023 22:54:58 +0200
Date:   Wed, 19 Apr 2023 22:55:01 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/2] soc: nuvoton: Add a menu for Nuvoton SoC drivers
Message-ID: <ZEBVJYow7iOTXysB@probook>
References: <20230412183834.3769519-1-j.neuschaefer@gmx.net>
 <CAMuHMdVdJooFiLfttxeRVZO_0doWiurwg3ZkxEbyO7D8eaDeKw@mail.gmail.com>
 <CAMuHMdV_y3ctAWAWSU-PjdE_hwBJjkgwFhpBQ84WFrhcXU8_2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1l5oiu4Z09MgQTIH"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV_y3ctAWAWSU-PjdE_hwBJjkgwFhpBQ84WFrhcXU8_2Q@mail.gmail.com>
X-Provags-ID: V03:K1:LLUl0iQYg1kGBBSPdFJK3e7xC60v+e7fB3mx1XpP4p7JkI2HHRH
 SAzqJwYspI4HC9xQqvOHD/d3KoOBynrTklUEML8+ZMQuncAdzgH9eAeAWFRm0zEJD3xE2aP
 V/bc6Dz/Xu42NnI8KtSpQt4HiJV+J823BJPZQjjIbNdvRNFgI7RVJEeAwdE/Gr/Ewy1qflF
 IJW+8rxohKxE4NNUTmSpw==
UI-OutboundReport: notjunk:1;M01:P0:tJdq248S/CQ=;W4M+pD7C9TxCj+5iz+XlrIFbZXU
 4+EATc/gPcZOcbG3Io5hO4my8NtKn76KnOgJ8ZN7TJX0Ol/GxOFye/+o6CuqQJWl6Ar80PJKa
 dNAQvmZeD1z6AFgfy2vA6tDgA/fUaj4rNYKJe8d5WpCnPAJiZ23AUdzXeDuzbdhUBBou3Y/Fo
 KtbcNh34JqLeDZsYkdiZDAodb4BxW+6apcOUtXvhwvxNGd1ocYKUrRfDHWKvS+c8NndbTGhgO
 /O9mfUl9nP7EE4c6SnRGolaQNcY04HDbjWQHlCtAHoLEdyhwu39/Me+lPGulGG7Tngo52Pahh
 y1kmaLeCh9FneBN3pZXFl70W7O7fOiFKQ5YUy47AVvdWOyR6Zz5eP9aqdnKIox8p42M5DfwBa
 4Rkk0Z0gK52ndE0yaFrVFkw0zbaQigxZCdZ1Z2NI12yUMEE1SKK21RG6J43h5sradhA3GNQgv
 Ukxgsd5jjqCiKx7raXgzxN1xoI+ILlAl0UvTSCy83QGvudeL600FCDeZozN75PPuX4oSR0LM4
 DWgP91dRz12xtd6syz16RkvUCSciEcBNoRy/QFsKwzr5AMNS7Y1UxL8yl3gO+7pXuwHF5mi1U
 0ceZ3bPVyDCK23rUJmD5ai78Qfuven08DJCTRjrDuc5ZUtejL9GIm12bmsUx2+m7e0yMiDIQy
 SWbFCHl/671cp2IAu2qjwA6M1+Ytgckfw5YLf1devaB6Foa3lM/HWawj493boaSmq7byeYcKx
 tLfu5UUxLif6Uo0ujDHL1/vxD7GgiJw68h/L3+B43wkNhdJ+2dX6VckzflFgTCG/rlRy+jgLQ
 opy8623E4LrhWcQ93i5lcOYb+j8LqQm9l8drsHLTojKmaLV4151pJl2IpYDsDPM6DPiqIY7CP
 l/MxrLMybpxRcx1xIPhiOZnDekENhtR/vqeJrYQ+ZqzuXcJgE/A6uW9k+4cGJ4g+CG5wfrmuH
 OUC9eHpdaAjvNy4mcMh/PRqVPro=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1l5oiu4Z09MgQTIH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2023 at 09:28:47AM +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 17, 2023 at 9:25=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Wed, Apr 12, 2023 at 8:38=E2=80=AFPM Jonathan Neusch=C3=A4fer
> > <j.neuschaefer@gmx.net> wrote:
> > > Add a menu "Nuvoton SoC drivers" to make it easier to add other Nuvot=
on
> > > SoC drivers later on and to prevent asking about the Nuvoton WPCM450 =
SoC
> > > driver when configuring a kernel without support for Nuvoton SoCs.
> > >
> > > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Link: https://lore.kernel.org/lkml/CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-=
VbQmQ5u+4Q8c7-wYQ@mail.gmail.com/
> > > Fixes: 77b8c67b5637 ("soc: nuvoton: Add SoC info driver for WPCM450")
>=20
> This reference is wrong, it should be 7dbb4a38bff3.

Good catch, I picked a local copy of the patch/commit by accident.


Thanks,
Jonathan

--1l5oiu4Z09MgQTIH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmRAVN4ACgkQCDBEmo7z
X9tu4xAAmGQ42qqJcLh6LVuKMZ8N6ZIQRL0McYPi70/KrfcsZUvHNIe3iekQudcg
KaNINuOwVjbxbB1nb+YVBqB3HtFG0gPC0TCLNpbRsP5Nt5I157OEdq9jsxNHOIZj
1Tb82a83EEgpylxG7HTsIuwrSzaN6YFhNhkx7td1/tyYSdjLLMAeLaYBFtdDVXDA
qe/GvAH4tLPxaWzqhKmYAUj7l2jzzYYa5rqN02i1RB4SqiPpxvCSNqhFNsBlIryu
PJt3JAx4tt3vcFn4SfWut8lkmII/xh1fYCnomkF5BST3rPtbJgllsC3g+XsgX1bq
FX5Us2Uz3xB2NkxMpNCy+HN00BEEXV4L1DJa04UwD6Ub9n2uSbnD/eeKYXqFK2Wv
l52F9kGJygGIzPXzIrJ2Q7Gkc54igy3WMRZg0qB2mAFTCRxeqtryXEomxhK1lrQQ
2SBFP/867iiblf4L80Q6njrHOw5rr3q2snguVwypiZtLq4C62KGk9ESktnEY78xG
gi1VQNsRNaPg2/zGqObBNQWkCzCTPAxdCKxpm9hEbeCTVsjnfGdbAoX2FM3yiDs7
dHhhBYZoacQIIKLDrNDaHpGFfnfB5tsTx1M8/A6pjCcHBFqZn8q3fo5KD9B6RRi/
RV0fphbs+sGqqmoh7WHjOV5QRLptAYXVjOXNB7SpDEVuxJEix5M=
=H+ey
-----END PGP SIGNATURE-----

--1l5oiu4Z09MgQTIH--
