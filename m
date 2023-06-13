Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A464672E768
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242971AbjFMPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242945AbjFMPfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:35:13 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DA7127
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:35:12 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CAF365C0143;
        Tue, 13 Jun 2023 11:35:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 13 Jun 2023 11:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686670511; x=1686756911; bh=arSfmSsp6qMAGSwGIzR20rLDf4VrfVXnKoh
        BNMEZvus=; b=AV/GnTdCBzJnwntFBVhC5JKSzuoA+EVWhxbt6wYkN0YeL0VhKIS
        vJZJqik3jvIzbPH6cFeCjyh/EzBCrFIGLMWAse9nsI3Z2pK2CuEB+qp/gX/je2yb
        aug5+i8FS7RHaP9diJhkorAa5Vr0f4Jsdhc5IOcBpfBEYcjBjLXbQxldqDmSrKuO
        O+bKep2ng30VHkGTtZZdvJBRRJ4oyPXLu7ANJOs9b+xMkxbB4vVHSU5hCj0uWXfs
        fGlg5PnP3vA/qtMx7XPJ0Vw/OseWV5IVsjq4AfcK61GLnW/mF9lwbmEI0o2eTQfa
        EKOfsXSafLbC+wSXCJHL8b9gPhXWf2q+liQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686670511; x=1686756911; bh=arSfmSsp6qMAG
        SwGIzR20rLDf4VrfVXnKohBNMEZvus=; b=cOiyTjTqzBhRBNqmf8S95wJRwaw62
        UcW6WbcQKcIuMG7m9I6Db2uvrQmHRj4K0/5094hgjj6azM79iS2H8gj8eNAel55X
        id64B9655GZkxA/AFA+KTH93FJea4HFJTFFVUAWe5at4W4dcaw9C/TtYBEgNm90K
        sdKHRzmS2bSn34Cr2eifw1tADLhjuVVa82CC7AeAdkTBXQnAjAnaXF8VHg16sU/e
        aBZRFz+9/WkEl6sKxUfUK545A0S08Fb0/LFHcwACIhoIGIoAGfTOwvg/rJ/YxE0b
        pUQ+Gzo1SOfGeGbUOE37UU0lfY4zMA2JUbjowZTSfh69Ot0ETGlCRpJZw==
X-ME-Sender: <xms:r4yIZHrTqZEB0sSjQ79_YUcgFpHtEi5vbzy0M7KiAE-TPNaosVccqA>
    <xme:r4yIZBrDvKEhvKxVTxthMuYWFUORPOrUBSxMGLmyMkuxVH0_RH6KJLO1u-n7Ni_j1
    Vo_ci-DmT8w0_Y>
X-ME-Received: <xmr:r4yIZEPGANQuS3i-X8LkVWnSee-JOkKKVqCAFmZxAaAbBaYote7f_DAXHAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedujedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:r4yIZK4IHBt8QT7Xy44-sxA0-qLaLvTeqm5-A1Sgm3YVAKJQctu3QA>
    <xmx:r4yIZG7KZ9tinf0OBr4xw9OpoUQIhUlUuuC7l9nlaGKpYR-CZ9e0aA>
    <xmx:r4yIZCihXi2fxyU0_z8KCbv7XzlrY-rTtKr8m2O1iT9rWBETDnUBrA>
    <xmx:r4yIZCo2cRKNCK-eMLHJo4rTNfo8BvpbVzDDV-OpPyyoI9i7xmRhlg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jun 2023 11:35:10 -0400 (EDT)
Date:   Tue, 13 Jun 2023 11:35:05 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     David Laight <David.Laight@aculab.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
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
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 0/4] Make sscanf() stricter
Message-ID: <ZIiMrDxI5Ts0s8fK@itl-email>
References: <6ab6adce-2318-4ae6-bde6-4317485639fd@p183>
 <ZId/IA41c2sJyvE0@itl-email>
 <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
 <ZIeMyQXU49OcoxY2@itl-email>
 <ec3d7ebe62654e949329785bb32c3822@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fNICznYAU3QlUDGM"
Content-Disposition: inline
In-Reply-To: <ec3d7ebe62654e949329785bb32c3822@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fNICznYAU3QlUDGM
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2023 11:35:05 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: David Laight <David.Laight@aculab.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
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
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 0/4] Make sscanf() stricter

On Tue, Jun 13, 2023 at 01:02:59PM +0000, David Laight wrote:
> From: Demi Marie Obenour
> > Sent: 12 June 2023 22:23
> ....
> > sscanf(), except to the extent that -Werror=3Dformat can keep working.
> > Userspace sscanf() is almost useless: it has undefined behavior on
> > integer overflow and swallows spaces that should usually be rejected.
>=20
> scanf() is designed for parsing space separated data.
> Eating spaces it part of its job description.
>=20
> 	David

In this case I would prefer to have two versions: one that eats spaces
and one that does not.  For instance, I don=E2=80=99t think any user of
xenbus_scanf() wants the space-swallowing behavior.  This can be worked
around in xenbus_scanf(), of course, by having it reject strings with
spaces (as determened by isspace()) before calling vsscanf().
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--fNICznYAU3QlUDGM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSIjKwACgkQsoi1X/+c
IsH7BBAAvFNPcgApcQwpZ3D3vyZvEJ6//ENiuEPS3e9FzSqjwejzAuIzUMK15zNv
mgfy2bVAeWvpxNgvYE6tuJ182pcZosJgxnzi5R2a5ft9eEs2OvNQgUskgxD+BT1C
4sPw09VkTVrYQ+UO7wQ+fyM6LsLF+G3fukQP9wrejFETpS9Sk+4yonELFHlvN13K
WJ7lU56W8QVnyd8nDyVo7v/MeXAPITGyFPAV7zN3uP9NsFJmAcR1QCP+6WubO5rm
67VcxkLSvxh+ch8gttagXNGZTGLnjQaaDU3VygNCAEV+vOJe4SUcDSKC5VhKMoad
Ew6Ki2fiA/zMk1jJvBCmN6JU+8JyVPU2t2ITccVS9VG/S2eTQrwTlHjba16IRTTV
D9Ai5CdkI9aYJk482BlurVYjoYPQqFrpFDOw+nhxclhvdruxSmo3us1jwPyoLVJY
iTbRoyLKV5NnOb+AkVtGN6XqgBklPCSZty8QWPts3tXvzt30miS+4tL8+vUH853s
aXsQtFxmQ4iw3GdQyjyuY0DnKzTw3s7jKHnm6H4O5iokF8f2YfMNxAj5NfeginVo
lrDgGhnbIOknNK6azyx0jGEmzWQUzqQLGHYn2GWCI8/90BACz6Cp6/beH6HF3VO6
oC/WHx1YtttkGKO+R1yEp9lMKy/elfIYJGVBxHjoJoR0A5VPr8Y=
=Uv3f
-----END PGP SIGNATURE-----

--fNICznYAU3QlUDGM--
