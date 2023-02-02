Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF75688553
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjBBRZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjBBRZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:25:06 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E876B34A;
        Thu,  2 Feb 2023 09:25:01 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E89CD32003D3;
        Thu,  2 Feb 2023 12:24:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 02 Feb 2023 12:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1675358697; x=
        1675445097; bh=TdYzennOAnAw0WjtkRlObGkWlu+kdBTnfKrmn3VbjsQ=; b=P
        jCdE8pvN6Qx+Y0zL/Tj1zF45e5AO+a0haIl6mV9FX8LuMXpN5BmZx1IepTwho0Y6
        msOL6mhGV6lQRd8whzeK9EFUERrb90vvUj3+jE9AHNlwUr9LbwJVwWFxJcN/6034
        nmkeL7P4St2MkGhvG5CtohOWzVmuNSiw91Rrzy8itnqY1qWKdjb03kdfNqtIv1xx
        Q66pmjyU8ZLMhGU1U6/gvfmSTaJpmK3op3fF/ft40nYnInh60/tAU/FfNsd8nF8M
        7fwIct3uFYMmcLEejSLFb97ECcbwVnBiwAKIbSPdVc4BGY8fmzyuLhHpo62diulY
        d+PuG/kgyarexLbSEU9mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675358697; x=1675445097; bh=TdYzennOAnAw0WjtkRlObGkWlu+k
        dBTnfKrmn3VbjsQ=; b=AIXqg7SbjBcl4gHqfwOVHJ9z5LuJF0C9DbJgQHWTlLSH
        asjcLBz9SUcOSJp8vgi9DfP5n37M00IZkUaOQXfl+ewpLHNVrt7sK5N2haEvrYwG
        DdJhi5vNH9NryWLC2BhJgm1+ZSBYuxw432OVxK68FzZeVnodjaitrNc6vpzI7fEJ
        zpwOpxHm42UzrJq9DVTXdZAbTCwtpIGnjL0zZxkhWnrPjT95yHUlmO9rFNZhlIzz
        ffsnTcafuXA7h7MeAJHQ0VmKKCEbO3TdLkJAYpi4TZRBwunt7hXB0KOsoR6tYN1a
        hTjP1dx3cM7tTMAk/81GRN4cIF8oOXec+urxt7nxRw==
X-ME-Sender: <xms:6fHbY0i7gcYER7wJ7gUEsUve1nRA70KaOYBOpPqX5F2DDp4rtabztQ>
    <xme:6fHbY9CJ1XGatCW0WDNg8sNnPtLttFURiNjOYV_wGHp5BALxxjAWGnkPtKGVcKSdW
    Q8BlErBNMpGVQU>
X-ME-Received: <xmr:6fHbY8Hl3LSEYJrk_bVvk73LP0MPYUL_ALlt1718mbj1oxktyEiE1Ti2XrM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefkedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:6fHbY1SlSOlJod2Y_RaPGYUaAl-1b674IMVYYtGxMot7Zlo1Iquu4A>
    <xmx:6fHbYxyhKxYt3rMK_yRTfiynjrDVrgwl6vzamKMa6np-RHwikIxs9A>
    <xmx:6fHbYz5dCfLB7rZmvW3cxzH1ROgtfu9z6lIOiStcdXjeOmYh3_WIbA>
    <xmx:6fHbY5_svOWbAZ0q3BsVbOy0OUAFls6hqUW_mftshQ5HaLG_Ke1EsA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Feb 2023 12:24:56 -0500 (EST)
Date:   Thu, 2 Feb 2023 12:24:51 -0500
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] block: Support creating a struct file from a
 block device
Message-ID: <Y9vx5spqFqDit0uA@itl-email>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
 <20230126033358.1880-2-demi@invisiblethingslab.com>
 <Y9d692WEX/ZvBhXI@infradead.org>
 <Y9gZAJGgdjFtsm9I@itl-email>
 <Y9jW73uAtE3HdCou@infradead.org>
 <Y9lBlKD3U/jMug9j@itl-email>
 <Y9t5MtE2Xg53u07O@T590>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fpYsSSW8xpDjRdr5"
Content-Disposition: inline
In-Reply-To: <Y9t5MtE2Xg53u07O@T590>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fpYsSSW8xpDjRdr5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 2 Feb 2023 12:24:51 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] block: Support creating a struct file from a
 block device

On Thu, Feb 02, 2023 at 04:49:54PM +0800, Ming Lei wrote:
> On Tue, Jan 31, 2023 at 11:27:59AM -0500, Demi Marie Obenour wrote:
> > On Tue, Jan 31, 2023 at 12:53:03AM -0800, Christoph Hellwig wrote:
> > > On Mon, Jan 30, 2023 at 02:22:39PM -0500, Demi Marie Obenour wrote:
> > > > What do you recommend instead?  This solves a real problem for
> > > > device-mapper users and I am not aware of a better solution.
> > >=20
> > > You could start with explaining the problem and what other methods
> > > you tried that failed.  In the end it's not my job to fix your proble=
m.
> >=20
> > I=E2=80=99m working on a =E2=80=9Cblock not-script=E2=80=9D (Xen block =
device hotplug script
> > written in C) for Qubes OS.  The current hotplug script is a shell
> > script that takes a global lock, which serializes all invocations and
> > significantly slows down VM creation and destruction.  My C program
> > avoids this problem.
> >=20
> > One of the goals of the not-script is to never leak resources, even if
> > it dies with SIGKILL or is never called with the =E2=80=9Cremove=E2=80=
=9D argument to
>=20
> If it dies, you still can restart one new instance for handling the device
> leak by running one simple daemon to monitor if not-script is live.

This requires userspace to maintain state that persists across process
restarts, and is also non-compositional.  If there was a userspace
daemon that was responsible for all block device management in the
system, this would be more reasonable, but no such daemon exists.
Furthermore, the amount of code required in userspace dwarfs the amount
of code my patches add to the kernel, both in size and complexity.

> > destroy the devices it created.  Therefore, whenever possible, it relies
> > on automatic destruction of devices that are no longer used.  I have
>=20
> This automatic destruction of devices is supposed to be done in
> userspace, cause only userspace knows when device is needed, when
> it is needed.

In my use-case, the last reference to the device is held by the blkback
driver in the kernel.  More generally, any case where a device is
created for a single purpose and should be destroyed when no longer
used will benefit from this.  Encrypted swap devices are a simple
example, as they can be destroyed with a single =E2=80=9Cswapoff=E2=80=9D c=
ommand.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--fpYsSSW8xpDjRdr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmPb8eUACgkQsoi1X/+c
IsE57xAAorX9YUQEbfy0qh0sYcYBgp0kuH+jyjBKzwTNRnJG0dMtJPaWwnij/UBt
GQkzQKfiefDJE69G1L2KJvmel2JMvHoYV77OkU1y4yaQ9IoY4doM320pVN5qy2+v
e9UgA8L0y/ZcAiO83y/Oie/q9ZWleJwAdPDjoggEKWA/Rd6oSLqSXEondwgLCSfT
huHPPH5knGx1mcpUv2WBYimuzeBg37cryCZzVhjFxsIejJhyrMZ8v2LxAeCMBRo/
M23QxvPV6ozIWCWMYRa7oaCYGZVLh9pI8ALm2pLpRHH85VY7vyt9bBLUeB6Xx2/0
fXSmWqJ0v7u/CnvOxY0qx5Pmj2Idf6T0eddZqvpUKz2fkrKw+H/lizHwZggi34wt
UmQ9Y/Gd4V/byryJ3anbMbyuxvLqprxTkzVeuYtfWogmToF2uMgvtKRSvxlDBIw3
v80kLHeeYHLyiCuAUzPwQF9esPTm5aWvGr3XhPUq0gv0SZRD50XBiKhL8Mxt7LjA
2Y2Q96fdnj6+ARJdVkBysNS8FL9XfFhzOx5NmzIhXlmK+sTHujLtpJCgfzTPgCs+
3/R9peIxnmFPzlzWAgkVcx9QLnR9jetv+NULAQgFsIW01Z7zVbvyN32XUS9OrdnY
6uPQOxDx4YpHPIcN4aKz1Yu6/AQ62SkR663hJI/dT5t0gGMoDdg=
=qgsi
-----END PGP SIGNATURE-----

--fpYsSSW8xpDjRdr5--
