Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACB372D069
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbjFLUZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbjFLUZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:25:08 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC94D191
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:25:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 471335C003F;
        Mon, 12 Jun 2023 16:25:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 12 Jun 2023 16:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686601507; x=1686687907; bh=5/ryBt9ZvozkAtMkTKZdMMTn2JRB5m11moy
        MFTsx680=; b=VbT98QdafwqB/tmVRvJiC4NIlT3+BAmZTgye5asLoYLvkDvvn0h
        q1VSLAc3WdwURv5S0WlBi/5BTnLXacUrVvB8InPVKzWH3a35gk/nnkIOf/hQWvMm
        0XqhPWLjfLzn2WVeSKFlGSIZZBSn0PGawlYCZXoGl9cEWMbZkml8po93jhTpKV73
        IsqpobRrxGvhezL6vnO9jg3cHVgYs5F0jEjeheMmiMD00RL37OCWfngfB3CJlcB6
        9+s2y08uPhoMoLROkggwaLc5Xu3smBM/S6Ujribz3r4S9dlnsLqOwb8BIXfnstyJ
        XLgAlHw0oyM/As/CW5enPUXrZ2FVawIm78w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686601507; x=1686687907; bh=5/ryBt9ZvozkA
        tMkTKZdMMTn2JRB5m11moyMFTsx680=; b=P9Irt2nsuLsansx1DD69O8hlluDZE
        U+ELE7H73gAPocd97Sdjruz2E+b3OQ+vtna+I84ULYY90v/wWfVx3TRJW+UaMF6M
        Z1cb16aWRfj+stOwmi2rQwtl07L8doZFfQj82DUHurW+8fTeB0KQqKslL0sUcEhe
        Fv2sEKyUO19YAfZdX9ILXMbNUdI3Ca3e6P/XUsqU21eFj7Tb/f2m/YnGUBGpTJTo
        pjOlS9/FTTrpVb9eZ/pcZaVZ03zDCxHXFvINuEkymDUWDJK2NIevw93+ReKnV1vy
        Eg/AO++DRE7s/9eDOFzRho3ok6FVHsc1v44gwbF+mLthDZ51HxH7aineg==
X-ME-Sender: <xms:In-HZIQi7WzLzoxajS418DnaT_XNKPo-T7dtixUl_rwygtSM76_vGg>
    <xme:In-HZFxmoP-Qhb4A76bKCVuwATQjQaQLm4JntHl2jE15uB0vMuE7epa8LBV0O6Rhv
    IXq5MpMK1gjpPg>
X-ME-Received: <xmr:In-HZF2Vcg_UPfFA5QoXua679a7ZSSkqWJn6aF7TKMvpx03yYxBbZGY2oQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduhedgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:In-HZMCSmiJ7USqJCTrwnm1FcPpRNDInffBYJ2_ZrcOBM_XflVQ8jQ>
    <xmx:In-HZBjA7KBmHncubCahNgWABKXWWJQqovBg_cNAtgShulu2S3XV7Q>
    <xmx:In-HZIr2aaAEGuAqPdU4jWlxf5xzICux5oZwkPhmKDrQIyNkqBFWvg>
    <xmx:I3-HZJym_bgS67oacCk4HR4i76vSjH86PSWhmUsR0rdGhLJXauhPyw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jun 2023 16:25:05 -0400 (EDT)
Date:   Mon, 12 Jun 2023 16:25:01 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
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
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/4] Make sscanf() stricter
Message-ID: <ZId/IA41c2sJyvE0@itl-email>
References: <6ab6adce-2318-4ae6-bde6-4317485639fd@p183>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PjrwJQtKdb92ybe3"
Content-Disposition: inline
In-Reply-To: <6ab6adce-2318-4ae6-bde6-4317485639fd@p183>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PjrwJQtKdb92ybe3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jun 2023 16:25:01 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org,
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
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/4] Make sscanf() stricter

On Mon, Jun 12, 2023 at 02:59:38PM +0300, Alexey Dobriyan wrote:
> > +	bool _placeholder;
> > +	return simple_strntoull(cp, INT_MAX, endp, base, &_placeholder);
>=20
> This can be done without introducing dummy variables:
>=20
> 	void f(bool *b)
> 	{
> 	}
>=20
> 	f((bool[1]){});

This is more consise, but (at least to me) significantly less readable.

> > > lib/vsprintf.c:3727:26: error: unknown conversion type character =E2=
=80=98!=E2=80=99 in format [-Werror=3Dformat=3D]
> > So NAK.
>=20
> Yeah, ! should go after format specifier like it does for %p.

I hadn't considered that.  Is the typical approach in Linux to use e.g.
%d%[!] if one wants a literal '!'?
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--PjrwJQtKdb92ybe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSHfyEACgkQsoi1X/+c
IsHM8BAArfYIa3ISJO/sXxxYMbF1z45VuZ+APs6Jy06/KZBRK9BfvdjOIYICgJLj
dDEWB1JaM9Z5wtu37GhiwkMBHueuQ1VUsHk2PFcdsqs0VeTBgcKYq7H/doMRwPhh
ihF9OP2Fcl1CnPBJv3WrZFfiRvm0iNjJdglt/Uqp1Qxbf0/x/QrtpqRPm3dzyQbA
ofRGw161bV/vu/PzcYNnjeMtUHZvz2skcC7OiFb1q/RYxowXz3w0xydLRXBL/YAf
12X+z6xCy6iZTHYT47h7WdQODjOUyscEeUyMYjqM2McveM6gnRGLbaKTYmKc4yMD
Gb/TwOyyGpm5BVyDYSxqxJBUvX3NATyEz6x4+uD6CS50c+mdXzhs7BjWGlqEzsg/
t2hHAfEQU4gef3y8aE6x34jFXJxl4YEHXwX97w+h0imIK0v02qwQkUD1GxWIWobo
4uPjxeEM3rH2aYnHW/Vpr7EfYW7GDYdz79EZGfxsZE0kXcSPfmUNb/jsMvO+Ezit
5am01alceJr8fYnWaD0ot999X9LX52PqizPbENVkVIKrd8ZAUcyxykQ7FZGI2loA
vBz58sEOK3GuPwl5C0p4Ll1pRvbU5lRBScxmu9i+ElELYb66xh1805XgBKw1uAZe
tg2qXZ2bdKM+/e4eDA2V4ceLzeHUGD2/AjVlsY+sOIPAyrxQWEw=
=K6Gh
-----END PGP SIGNATURE-----

--PjrwJQtKdb92ybe3--
