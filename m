Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E7D72D33B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbjFLVZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239039AbjFLVZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:25:24 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA424204
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:23:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 036C25C0159;
        Mon, 12 Jun 2023 17:23:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 12 Jun 2023 17:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686605004; x=1686691404; bh=8jihgvEIZdo23thuvLLLAAsXI5uRYfTJPlt
        AxmBuMfQ=; b=H8YwY/GQjZWoYO5QIsxoeCCV4Vw+plGGMjhIcy5xyUwQ9S9Hzkg
        3w9cAcywPvue9ZyXRF5+7D9fJCk/gsZdLKQI8G7wtkB3u91b2qh8u4FyMA0+qT7x
        xSsKUOzT6ZSUs74RZUZ2XP3PehFCWIobWfCWrH+EGCqQecnDGSyBjakr0Hu/H/IC
        TJjqYBMpgz91UO/m4A53XY8WaTtyVKfymGprTVIBqpGnIij7RVFWdpS/+30jYJhI
        cbrW1DBuxtrscwaqOP7AniIpuCOpTjU+wYMdgxQLl0STtrmDnej0XA4u5+fLgsfw
        U3UNgsAtmqb+OL6qwH+HKAZVs8mg9LNRNbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686605004; x=1686691404; bh=8jihgvEIZdo23
        thuvLLLAAsXI5uRYfTJPltAxmBuMfQ=; b=osF9P45Fc5n2xA29iiZOKiFVhv2yC
        zTLgW8lZNM+9aDDV2ZksDOjxInfd+zcZ4xtdurYW9mEynTAhDiJ/eUfcElMTsx6q
        vZKo3qbmv4gamirIXllUu30uiYro4Epepi1e4bpGknB7JPZH1NEq/xFrCsluG36w
        YdDh5dtZd9HqfJxY8CJLWlPk3+YfTw6gUIrFFdEjeaCtJ58UDxj3e7q7mJf+1leZ
        L6V2+NUTMX5ftiDdZ3JO4fDrtLqdqvi5x/Yjl8F+ch4tGUpVMxI8V+dkYRyrgUA6
        6ATxg4Tja6tGj0LRs6n2p6CuBOI0tNjZCTOirb9WJfC2iJih03PlKK+3A==
X-ME-Sender: <xms:zIyHZLrNS-2Rr_eXLy8sfddYIdjGnGGINbdwMUKCzIt8ZVC7-QDbwA>
    <xme:zIyHZFrQiV9RAOvk9v1vNCE0FAp9zAyVwhobfWI6_Ip47U77KfYBuyFFg7JbiiOrc
    mvZ25p8F9-x6Zs>
X-ME-Received: <xmr:zIyHZIPqNpWK2BxMMsKehnV8tzBpcWuvelNnrZs7SJ4f4U1bs1OOEvQyIbc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduhedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:zIyHZO73uu505hOIft1vBM9SizTF01K9m4H7xcpJAx2MyxNhp-MYVw>
    <xmx:zIyHZK4oB9ArumM48lwV4QTCSWc_IjsjKqIe_RlZE3qXUyqGPG9gOg>
    <xmx:zIyHZGhC5-bwDY-u2QY4FoHAGnEkn6y4VtpmZwxnJ_600c_UTptelA>
    <xmx:zIyHZNp96d_vJgqcwHM07KWDnaCt3BlLWZnBUKnADJGDHtX9rABBRw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jun 2023 17:23:23 -0400 (EDT)
Date:   Mon, 12 Jun 2023 17:23:18 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
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
Message-ID: <ZIeMyQXU49OcoxY2@itl-email>
References: <6ab6adce-2318-4ae6-bde6-4317485639fd@p183>
 <ZId/IA41c2sJyvE0@itl-email>
 <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1qNhvq2VHyxB7HMQ"
Content-Disposition: inline
In-Reply-To: <ZIeHfBf3aB3vUgRM@smile.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1qNhvq2VHyxB7HMQ
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jun 2023 17:23:18 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
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

On Tue, Jun 13, 2023 at 12:00:44AM +0300, Andy Shevchenko wrote:
> On Mon, Jun 12, 2023 at 04:25:01PM -0400, Demi Marie Obenour wrote:
> > On Mon, Jun 12, 2023 at 02:59:38PM +0300, Alexey Dobriyan wrote:
> > > > +	bool _placeholder;
> > > > +	return simple_strntoull(cp, INT_MAX, endp, base, &_placeholder);
> > >=20
> > > This can be done without introducing dummy variables:
> > >=20
> > > 	void f(bool *b)
> > > 	{
> > > 	}
> > >=20
> > > 	f((bool[1]){});
> >=20
> > This is more consise, but (at least to me) significantly less readable.
> >=20
> > > > > lib/vsprintf.c:3727:26: error: unknown conversion type character =
=E2=80=98!=E2=80=99 in format [-Werror=3Dformat=3D]
> > > > So NAK.
> > >=20
> > > Yeah, ! should go after format specifier like it does for %p.
> >=20
> > I hadn't considered that.  Is the typical approach in Linux to use e.g.
> > %d%[!] if one wants a literal '!'?
>=20
> It might be that the cleanest way we have is to create %p-like extensions=
 to
> sscanf(). %p takes alnum as parameter and that is usually works since it =
makes
> a little sense to attach alnum suffix to the pointer.
>=20
> (I don't like to have %dX, where X is alnum as we expanding our hack to
>  something which people don't expect to be altered even in the kernelm, y=
ou may
>  refer to the discussion about %de for printing errors)

Personally I=E2=80=99m not too worried about compatibility with userspace
sscanf(), except to the extent that -Werror=3Dformat can keep working.
Userspace sscanf() is almost useless: it has undefined behavior on
integer overflow and swallows spaces that should usually be rejected.
I typically either use strto*l() or (as I am currently doing for Xen=E2=80=
=99s
toolstack) just write my own parsing functions from scratch.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--1qNhvq2VHyxB7HMQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSHjMoACgkQsoi1X/+c
IsFFLg/+IexZNCutgAvzB9QpLaKvrRK1RyCLLOexeqRIrLpsZxC5ph43KrBFdEye
ORcumc8hllJ6geaozUFYZWZi1bEq2pELnftswyZzwzHq2JXrRoDfJDwidQd9fSui
8OThDF5rcDips9C3kaD1LjTkFkeNDqz68bh4ns78PWIZVt6m4Vct9FV1Qj1cPD1b
Er7B7eb9OY+mT9+/k02JNejJ56zw8VxB0+UKeFpdnl5aZHRS75lkEPaQe7y0F+bB
WbAjCzlac8sDrMJYi5GwumwarFDQRIPKgLff0VE/qeQl+c9l6jFHzBwH6TnYSd33
evxkYU+PID/GlsXTVSuSBbRdXRZ8TACoN78xjK5dk9PWKfZ56oTNLNVs8gSw47Ci
MSIVZoGD5Nm7tEPY+5BSQSwHE4NmWVcK8kfbI0xfc3Kkg8mfiWmO5chg44+EZD9y
ui+SaDuras2bVsLiie4y/nvznEmLd8sGW2MmZErtTJUZlMpaZ8zxmWPO041UceQc
hCYmOTu5W9GQaRW/mkEAxFXDKWXHuNiRezAKNGQLLP7UZAxpOWiIYsnMQTbdMwjC
Xa1k75R1qKbXqmFOULaT2ng5+vI1KUQe1XRjLbr9UDD10x8HnjCSDOBcuqJVX4mK
etxenamwRW1++pcZDGPJh26vWrBn3Vkxd0doGvHdUM96A4pz6cQ=
=KpGC
-----END PGP SIGNATURE-----

--1qNhvq2VHyxB7HMQ--
