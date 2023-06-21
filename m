Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D7573786D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjFUA4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFUA4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:56:23 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61942183
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:56:21 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 098225C010B;
        Tue, 20 Jun 2023 20:56:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 20 Jun 2023 20:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687308979; x=1687395379; bh=MXEcmj/UjZGLXKXDuon/v3xkIoMj1zqOw+n
        JH5vv6Oc=; b=jr8FiqnqWGdnXxeAL73a5FxrVTKcSFgSW57OD3GGGMoRxxfoyUp
        j0DGI6CI0tn0ids+SDQaIRHIQLzDRhhal1oLIe259f5fQTo3I3Y5GNJ8QQkRubFc
        nOCkWSkK/wjGJwumlVs0FUG4aJm7B/ne7MUEwXIVN2/uxeUYljw7jCcSuA61KabF
        ap20kJ8csrlmwWHenOn44ZlPmv5Sy9BMqkaJTr+zMkErUT1UV0f/hmtnGHUB6rBQ
        b/dbTjjisaH7+gHVptFleFeJRtdVjT7Ldrj0wUd9brWCtIC+Xvxhc2mthDOByNLw
        TIcmf3FGX61fk2qnKS3SIcDD3qvuCeXL/qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687308979; x=1687395379; bh=MXEcmj/UjZGLX
        KXDuon/v3xkIoMj1zqOw+nJH5vv6Oc=; b=iwJqyKGz26fsO1P+iSBOLbSm5fmtr
        doc9gGG7olKrx0NyRy1SX3w/WUS7Tq7ob2f9TwNAM1afaNZTAjAarOnbI6YMr0Qq
        WTZV3yq18ku+of0PzkZe+2BfbNdYlhYDL4cVQJBCyhUq7OE1WZklicRNTnoTxPeh
        rOFYqHPlDQ9Qu7s70EUhx6H65g6Yl6vr4bJtB/MRdYMQlP9tZJyNNi64B3EKks1b
        2RGgnbUbmIJvqesoQ5EiUFZQQMtJ4+3NS5U1m0HUELG2k3Ehr7e71PIjEjRdqhdC
        Bc3jqr+JtsP0mweyh3X0avvTf2cSFYi3LFPJDblSDtM7q7hZbd7bnb8FA==
X-ME-Sender: <xms:sUqSZEcGHFwNsztNNufkZeKEnGY8yxCdBcMLSlR4Umo7WhsgC424Sw>
    <xme:sUqSZGOS_Aga-BWHM9LFvwZ3gbk6sCGvsyM0SKRttIGWk7HURfKS-aOt9yM46B-Xk
    sg1k3NW-sEGRCk>
X-ME-Received: <xmr:sUqSZFies4OJa5rJKXv6-_ps-Qb4Hjtg7V3w2v6b9k52O6dqtaY7YQ_B2K8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefiedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:sUqSZJ_nwAHPGamXqJOhbKvggSNYDsoV3dW9oRwFrBmUhCxtRgW5uA>
    <xmx:sUqSZAs9E7RBOiPEP-wIqgLInZfYbad1Jsy9KOX-tzUU-Z8UJWyHlw>
    <xmx:sUqSZAF8E0alh2dlHwPNAAxl5sKnbpPjmXyvLld_kM4Ckrea_a9eiw>
    <xmx:s0qSZB_zhbNBevBXrjCR-hrN1pkQY2Rf0Uz01AX3s2MzGPJun_KvYA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jun 2023 20:56:16 -0400 (EDT)
Date:   Tue, 20 Jun 2023 20:56:11 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 0/4] Make sscanf() stricter
Message-ID: <ZJJKr0xYvcO7P8QY@itl-email>
References: <ZId/IA41c2sJyvE0@itl-email>
 <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
 <ZIeMyQXU49OcoxY2@itl-email>
 <ec3d7ebe62654e949329785bb32c3822@AcuMS.aculab.com>
 <ZIiMrDxI5Ts0s8fK@itl-email>
 <23df90dd35874fd89c64906e6a6de164@AcuMS.aculab.com>
 <ZIoeVjC6offUywop@itl-email>
 <e354268a4efe48c9a8023a30c7292d12@AcuMS.aculab.com>
 <ZIr0z6u17xogE5+n@smile.fi.intel.com>
 <ZJGq0UTHPdEuIMal@alley>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/W/EWKP7OFW36OsZ"
Content-Disposition: inline
In-Reply-To: <ZJGq0UTHPdEuIMal@alley>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/W/EWKP7OFW36OsZ
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Jun 2023 20:56:11 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Laight <David.Laight@aculab.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 0/4] Make sscanf() stricter

On Tue, Jun 20, 2023 at 03:34:09PM +0200, Petr Mladek wrote:
> On Thu 2023-06-15 14:23:59, Andy Shevchenko wrote:
> > On Thu, Jun 15, 2023 at 08:06:46AM +0000, David Laight wrote:
> > > From: Demi Marie Obenour
> > > > Sent: 14 June 2023 21:09
> >=20
> > ...
> >=20
> > > > > What sort of formats and data are being used?
> > > >=20
> > > > Base-10 or base-16 integers, with whitespace never being valid.
> > >=20
> > > In which case sscanf() really isn't what you are looking for.
> > >=20
> > > > > The "%s" format terminates on whitespace.
> > > > > Even stroul() (and friends) will skip leading whitespace.
> > > >=20
> > > > Yes, which is a reason that strto*l() are just broken IMO.
> > >
> > > They are not 'broken', that is what is useful most of the time.
> > > The usual problem is that "020" is treated as octal.
>=20
> I do not know how many users depend on this behavior. But I believe
> that there are such users. And breaking compatibility with userspace
> implementation would make more harm then good in this case.
>=20
> > > > I=E2=80=99m trying to replace their uses in Xen with custom parsing=
 code.
> > >=20
> > > Then write a custom parser :-)
>=20
> Honestly, I dislike any sscanf() modification which have been suggested
> so far:
>=20
>   + %!d is not acceptable because it produces compiler errors
>=20
>   + %d! is not acceptable because "use 64!" is a realistic string.
>     We could not be sure that "<number>!" will never be parsed
>     in kernel.
>=20
>   + %d%[!] produces compiler error either. It is hard to parse by eyes.
>     Also the meaning of such a format would be far from obvious.
>=20
>   + %pj or another %p modifiers would be hard to understand either.
>=20
>     Yes, we have %pe but I think that only few people really use it.
>     And it is kind of self-explanatory because it is typically
>     used together with ERR_PTR() and with variables called
>     "err" or "ret".
>=20
>=20
> > Hmm... Usually we are against zillion implementations of the same with =
zillion
> > bugs hidden (each buggy implementation with its own bugs).
>=20
> I would really like to see the code depending on it. The cover letter
> suggests that there already is a patch with such a custom parser.
> I am sorry if it has already been mentioned. There were so many threads.
>=20
> Sure, we do not want two full featured sscanf() implementations. But a
> wrapper checking for leading whitespace and using kstrto<foo>
> family does not sound too complex.
>=20
> There should always be a good reason to introduce an incompatibility
> between the kernel and the userspace implementation of a commonly
> used API.
>=20
> Best Regards,
> Petr

I strongly believe that overflow should be forbidden by default, but it
turns out that I do not have time to advance this patch further.  My
understanding is that Xen never wants to allow spaces in Xenstore
entries, but that is easy to ensure via an explicit check prior to
calling vsscanf().
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--/W/EWKP7OFW36OsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSSSq4ACgkQsoi1X/+c
IsEENBAAxKtLt+LIHXO8ZpbY+RkEdtC5atusiIsk2g39Nsf6slNiN8+ayF5vXpkb
39CayIdya0GzbjCjcWO8bCVN4j5+Ek8SKBi01lswttceqTQIb97e5tg759eUXgdQ
3ylVRrG5KCav8aMUGpOZkuiqvhBy3VEr68XvVmpxf1GaLpDycP2cRuoloOdxFVbU
XNrG5iriYGjXt4l1NXK3rNSZgxmJLores9z8Z8bjRGxzotW6bVvx9Da3DwZqJoo9
1Zi2elSUlmalsBvvX5eG+Pzi5niZaK+O6aqnFpSwbwT/yT5zkBNWJGxIzbGiwYU2
W7N4kCEboYDOf/umzIxCuZUPy8Fk/+QxyDgcwIH5/VAYkt1AauilVT3iBl3SMxHY
Wv6x+eOIQAJsXvf6dkVcF5Cq+HTptjAQakbFAO7Xk23AJW0zmGhBudVTqyBG7JCe
x9iB1mQfeS2rx0MkXJUWGsJsy3XnoJvdDt+HwEbSi4+zwhfyx0nSwuaM8Ng3W2Q8
5fCYxdRykIWBqxk0kr8O8Wdd7CORVOTO4s+/zfJh4d074aFIwpor/4TLtjBjJGie
DZ134c7HCmhENkHWDaGdYY0UKxeTiILfrDX1/yhKx+590dQwxQzxiX2ag3XLCmaR
P3KzvLLz8AQelBb2BW2KS295mM3sEwDy4ggOYrLHXpc++JwK74Q=
=2uLn
-----END PGP SIGNATURE-----

--/W/EWKP7OFW36OsZ--
