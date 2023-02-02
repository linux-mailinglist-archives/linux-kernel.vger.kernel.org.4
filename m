Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E813B6886EB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjBBSnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjBBSnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:43:46 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55BF5454F;
        Thu,  2 Feb 2023 10:43:15 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8123A3200645;
        Thu,  2 Feb 2023 13:42:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 02 Feb 2023 13:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1675363355; x=
        1675449755; bh=lg2mMVgKWzumdcP+F9hZgcsYrteBCJhK/JelW6EYdVY=; b=C
        uTXDseVzBiQj9h2D+NuYP2jUT0tW3Lmilaa0/HVSPpcoiD3KfygKzgQY6EimkjGJ
        r5FPB9IdV+dObh+fV0OrZLfZju61Sb6vtG1NmYLcIF3/TDhRTlZSI3Pu/JQhgjs5
        zeRqriMqf8Jbp0rN18pCjM+1Lt5t/VTltANRbn4K9r5dCYs5JqXLdqLwY0TsTT3j
        31hBdBZCBzFrcgq7waSac0sKHGrR/49IS6TWidI6ddBpWjEPzPR7SFcCRg6b4FUR
        GRYPIRccsAsOCVdMLmydp4wk+cRTUS5Xxon9Fq4sn8BQsZP+FfM/yxM/3FqncdQ2
        BPo8XZ+FTMxYV+HznS63Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675363355; x=1675449755; bh=lg2mMVgKWzumdcP+F9hZgcsYrteB
        CJhK/JelW6EYdVY=; b=cxgzpT9otQWxsLIA+yjsDC7ZP5F0KwVUpP3jph2vdxZ5
        +mitzO+3QYTvVvmnpmL8EKvzBAOOpiKA0KefZzv7ciC8KpwXn3TYPeIYKEQpHe7O
        H0pbjMXOqtg5yoRYP3hsvSdXQz7CwXFX/HIQ7fJ5wURTZGtn01qKIf1v7RCIoaw9
        KzXvF2sdBjzYNlhKlrJ+2dde8e9oV5rizIAthd4k6Q22qZzoKVRj6R2UMwQOFMnW
        BVM5W5A2aZAJVzpHPoIqj9GNAFpK/H+Rbs09rSxRASrPjVDyjJtMFuZop9KbSzaj
        2PUaxc67TE8Tua6UJ1edW8stqxg4x7nrkZ/k9QJsUQ==
X-ME-Sender: <xms:GgTcY74wnNYRNp3neyFioCfGY8gsdr3kkbZ9pBLxQDI8nBScyPiT-A>
    <xme:GgTcYw6Raa_0cT5CF0vH53DC7qhHu1c4ldmSTDbYu_ApbkSwpwgEOQ6B8dI-8kN9-
    meCH_9gcInE36s>
X-ME-Received: <xmr:GgTcYyevjVy9ZEXxI7N76kG2I57m3hoyPOkTgeDH3NCz60GkNk1wkK_tBk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefkedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:GgTcY8IJiELPiUPl16hearWJ8KrYflnS8vJ3WcyZZjvqvQzEHt65DA>
    <xmx:GgTcY_I3zAOvarV3gwgLMxeoGw3-GDJ7cFbqKY6IHEJ773hLxHQ2wg>
    <xmx:GgTcY1zaNQiMs9pq8JTL8Jk0u2h4Pdy67KTvedibqCA-tnGC7CQuEA>
    <xmx:GwTcY8p6sUmqTz0YfWHoddsK_tGu_jBhadfD6KT9DQiI0nHglxbFRw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Feb 2023 13:42:33 -0500 (EST)
Date:   Thu, 2 Feb 2023 13:41:29 -0500
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, dm-devel@redhat.com
Subject: Re: [RFC PATCH 0/7] Allow race-free block device handling
Message-ID: <Y9wEF3rWfpiCKc2i@itl-email>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
 <Y9vp3XDEQAl7TLND@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0LK2ZHUlLOwPgDgy"
Content-Disposition: inline
In-Reply-To: <Y9vp3XDEQAl7TLND@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0LK2ZHUlLOwPgDgy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 2 Feb 2023 13:41:29 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Juergen Gross <jgross@suse.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	dm-devel@redhat.com
Subject: Re: [RFC PATCH 0/7] Allow race-free block device handling

On Thu, Feb 02, 2023 at 11:50:37AM -0500, Mike Snitzer wrote:
> On Wed, Jan 25 2023 at 10:33P -0500,
> Demi Marie Obenour <demi@invisiblethingslab.com> wrote:
>=20
> > This work aims to allow userspace to create and destroy block devices
> > in a race-free and leak-free way,
>=20
> "race-free and leak-free way" implies there both races and leaks in
> existing code. You're making claims that are likely very specific to
> your Xen use-case.  Please explain more carefully.

Will do in v2.

> > and to allow them to be exposed to
> > other Xen VMs via blkback without leaks or races.  It=E2=80=99s marked =
as RFC
> > for a few reasons:
> >=20
> > - The code has been only lightly tested.  It might be unstable or
> >   insecure.
> >=20
> > - The DM_DEV_CREATE ioctl gains a new flag.  Unknown flags were
> >   previously ignored, so this could theoretically break buggy userspace
> >   tools.
>=20
> Not seeing a reason that type of DM change is needed. If you feel
> strongly about it send a separate patch and we can discuss it.

Patch 2/7 is the diskseq change.  v2 will contain a revised and tested
version with a greatly expanded commit message.

> > - I have no idea if I got the block device reference counting and
> >   locking correct.
>=20
> Your headers and justifcation for this line of work are really way too
> terse. Please take the time to clearly make the case for your changes
> in both the patch headers and code.

I will expand the commit message in v2, but I am not sure what you want
me to add to the code comments.  Would you mind explaining?
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--0LK2ZHUlLOwPgDgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmPcBBUACgkQsoi1X/+c
IsEkFA/9GXzWAuv/0q2ZJqJ64sluumHTrJNuenjIiibpb2PmaUs036H9r2jQYDI4
Lsxw3M3/9AYwGFpj/mhV5uBJutDasM3xTROoY5VqdO6vTeueaXUCefc+CGNzXNzZ
3o018mxFSPwKDaOBrCsiOuNsHtVzaOnO/TGuBW3HcYafDKFTWhDoprhfzL9mkwBY
21Ly74WUVB+S3fhURF+XgGoPKlQlaI8u6uJvW+wPQYei/LZqm5Gcpj5sqIhomFgM
yTA6l097aOj6ULLkScDW91sj30OJLc7qN5V+FtU27tRZWEzIcY5cl4/IL9KcAfGi
bcQcQ2Z7WPcjqLLuUxB2C5dfR6id/CmDnplOBRD0TAVzbUCJCEciClYHxPxljE6q
/mSqAfuBhO3ryA7z8xMYsYVz0SpdgnQqXXhxaZslSA4r0ACdEsytMu0YPPpIby7M
BjV5Sx2xuLaw/McuiptVktbvKknJAqw79ZecjU03d3Ga3/sA8dZC4JBGRj90cOMT
WPHUORPPmepxyX6n28rH/mdcsFDAzllbi37fReeJCKEEmrT5aCa8pyry1Rl2V6fi
ub+T46oghFHgl63y0Timr6eamgqV3CHGczHiKMcA0Mclv4shWUyaId0bzAGn/RLR
vpbwX0CGu7m1vnqsskbtLq1ThblONmQWtVFcFrqykfZMeqs2KtM=
=aeu1
-----END PGP SIGNATURE-----

--0LK2ZHUlLOwPgDgy--
