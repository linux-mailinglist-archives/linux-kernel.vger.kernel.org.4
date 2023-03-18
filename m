Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF43C6BF749
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 02:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCRBuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 21:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRBuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 21:50:14 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BAEDC097;
        Fri, 17 Mar 2023 18:50:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 749275C012D;
        Fri, 17 Mar 2023 21:50:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 17 Mar 2023 21:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679104209; x=1679190609; bh=jX
        40F1Gn9Mrsra0gVrUGc1qG3Xa5ngk9FhJUOJ7Syrg=; b=Ttr8Qo+h7FiWWee1vZ
        621HWHTxh9ul7KMWsx8/5EEDZeTXuFaVSNqt0HRemXJB3sDPxHR2Z4qREdn/iRoZ
        RBNYMKqyrZLn42Q5GwB82tuqmRkoxeGwC36btqG83U29SCw5FRZbZWDuGHlD+oEz
        zvPQvtYwSDQq+scDh6jDParZ+EcYrX/EvQBnABICp8bfAFKGptZOhhJkecAIRx98
        pIxwSIm265CfYyS7d/5fy+CBBHQoV4yoROBmvbrKi36dZuNqk4skCp4QEYJR2mTO
        oMMC07rmVjbUFuTKDqds5wK7ET/eQAyJJO4SrDtFgM04T6hSepQZCenhAAvM1Ofq
        cxLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679104209; x=1679190609; bh=jX40F1Gn9Mrsr
        a0gVrUGc1qG3Xa5ngk9FhJUOJ7Syrg=; b=RMfGo0RXRsYVdBzrkNgzsAhE8xxnU
        h8LXr0ZAMCkmtHlQCmOjl7iz94VaDL6SeFCNN+DltlKGwCcpACp+I1dJhICTxzfo
        JEyNKzM1BGe4KtBlzE+XAn8AHYfXAHy7qOj1rz7osWsGHanLkDMtmuLqDiTv54GV
        +hn/oYMBZr0VjI84kN426aJxDTAMwhiEU7bUpYozAKom3q1ia89B61coIM97GRsi
        t+rvijVpUH2gOlxrOBh7JVNW6LbDt8V5NX5zq0SU1IaRaUH+cgNeQ5jzaozA6cI8
        DKSVXgLUjOM7EYyIK+XtQfAwVJCgoqyqXaBVE48zZD3TmC7ixkKfzsy4g==
X-ME-Sender: <xms:0BgVZMrChpoKr5CVE9AHeD5i4oVv4pBHmZq2yOcWsLZ7_k1HTP2Krg>
    <xme:0BgVZCqIkOQnUmwkX4cg0DJibOB23OqF9bA8Sm_9DzGLzo7JOO5uz55NlhWYPYhtv
    TmDqrfVz1_LswoM3A>
X-ME-Received: <xmr:0BgVZBMO-BVuxjxWLw3M75usR0juiVASqpGIA-DI7JDU8YmKb6bfJ-5L7ZrdyOuJBwZtWOkkvHh5uuFFBFCAPmCsQmiDqJ87>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeffedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheptehlhihs
    shgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepge
    ejieegjefhgfffheeuleduvefhiefffedugedvgeduhfdujeehfefhuefggefhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihsh
    hsrgdrihhs
X-ME-Proxy: <xmx:0BgVZD58qu-_xUkwLZSX-CmxGXTy8uX0EtgbWaPfsJY6xKKQbNYJcQ>
    <xmx:0BgVZL5eosARyH7t4n5LqhVO_dAD2tsS2-SgopdJWWVApDbOPwbZYw>
    <xmx:0BgVZDinT4IGRiwsAqFnRbgRC4r3jjoJgjOQB12Abo9BfUcGfxy4iA>
    <xmx:0RgVZNm74B3dT_PC9VWJTXX4PnaJrQYh0MNDmmS1-zZ8w9yhbGn6HQ>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 21:50:08 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id DBBFFAE0; Sat, 18 Mar 2023 01:50:05 +0000 (UTC)
Date:   Sat, 18 Mar 2023 01:50:05 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: LOOP_CONFIGURE: send uevents for partitions
Message-ID: <20230318015005.czydsbqpw6hnej3z@x220>
References: <20230312191031.551204-1-hi@alyssa.is>
 <ZBHo2AXYM0iVkXvO@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="br25mg72tdjmjgjf"
Content-Disposition: inline
In-Reply-To: <ZBHo2AXYM0iVkXvO@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--br25mg72tdjmjgjf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2023 at 08:48:40AM -0700, Christoph Hellwig wrote:
> On Sun, Mar 12, 2023 at 07:10:31PM +0000, Alyssa Ross wrote:
> > +	 * Now that we are done, reread the partitions with uevent
> > +	 * re-enabled if appropriate to let userspace know about the
> > +	 * changes.
> > +	 */
> > +	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), !partscan_uevent);
> > +	if (partscan)
> > +		loop_reread_partitions(lo);
> > +	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
>
> What worries me here is that you move the partition re-read out of
> the exclusive claim, which is another potentially user visible
> change (and user visible behavior changes are a field of landmines
> in loop as you have noticed).

Makes sense.

> But in the end we only need to suppress the events until Lo_Bound
> is set.  So something like the patch below that reduces the no even
> critical section might do the job?

If you say so!  I had trouble understanding which parts of the function
uevents needed to be suppressed for, so I was trying to move as little
as possible out of that section.

What happens next?  I'm still getting up to speed on the kernel
development process =E2=80=94 will you submit this as a patch with a patch =
body
and a S-o-b?  Or am I supposed to do something with it?

I know enough to know that I should give you a:

Tested-by: Alyssa Ross <hi@alyssa.is>

> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 839373451c2b7d..9d61c027185141 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1010,9 +1010,6 @@ static int loop_configure(struct loop_device *lo, f=
mode_t mode,
>  	/* This is safe, since we have a reference from open(). */
>  	__module_get(THIS_MODULE);
>
> -	/* suppress uevents while reconfiguring the device */
> -	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
> -
>  	/*
>  	 * If we don't hold exclusive handle for the device, upgrade to it
>  	 * here to avoid changing device under exclusive owner.
> @@ -1067,6 +1064,9 @@ static int loop_configure(struct loop_device *lo, f=
mode_t mode,
>  		}
>  	}
>
> +	/* suppress uevents while reconfiguring the device */
> +	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
> +
>  	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
>  	set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) !=3D 0);
>
> @@ -1109,17 +1109,17 @@ static int loop_configure(struct loop_device *lo,=
 fmode_t mode,
>  	if (partscan)
>  		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
>
> +	/* enable and uncork uevent now that we are done */
> +	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> +
>  	loop_global_unlock(lo, is_loop);
>  	if (partscan)
>  		loop_reread_partitions(lo);
> +
>  	if (!(mode & FMODE_EXCL))
>  		bd_abort_claiming(bdev, loop_configure);
>
> -	error =3D 0;
> -done:
> -	/* enable and uncork uevent now that we are done */
> -	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> -	return error;
> +	return 0;
>
>  out_unlock:
>  	loop_global_unlock(lo, is_loop);
> @@ -1130,7 +1130,7 @@ static int loop_configure(struct loop_device *lo, f=
mode_t mode,
>  	fput(file);
>  	/* This is safe: open() is still holding a reference. */
>  	module_put(THIS_MODULE);
> -	goto done;
> +	return error;
>  }
>
>  static void __loop_clr_fd(struct loop_device *lo, bool release)

--br25mg72tdjmjgjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmQVGMsACgkQ+dvtSFmy
ccA1pw//S4bRusb/civnT/kkdp/QLhDLd2sRRJX5sfU2YjNCr9kWM9CciuLrFAPE
lVLpUpygKWVMWwby2WcLD02EVVLqzyYRMt+bPl8ynA4tZsxryC9Do9q87vB+yWLh
z9gko75rR1rauESCWq12Kbvp0UQrm98PsWm5bqZrt+1lugnJH+ovvxpZ7NlVB9TO
zO4RW2BCfPP1mrNjcKOQCw0tC+3HRXqbMMTnHvKgJA+kyW3qf3zLX7RWlPm9+WFI
glxOHwQgnopBjHVYdxkgqIBpkS8/Kh+ellFxspJkpT0YDZHmqPmAw/SAdCUrfbk/
oVKyiSE4NkZ8h0MxnMta2RyuMLrRNWgTO9twEw2V1Kt/z/U3jCFDz4fw1Nj8iKNM
TouZe71Xa6KPUPCTkypWT3pDEDbQ/JM5uNc45XS7wi6LfaMa1d/BwBXstDH1+brY
TEssldSfMMvp1fU4kZ3RNz8nS5Xx29jFEQ+qsZoVY7JGIDHV3g3XHFL7s3GZLjtF
m5/ZMyJma/9KEzi2UXAI3I4dcACUrZQ3MUwo1TKdpkPIB/bx5m3ja2NyQeZAoZvR
3GoFd8ShR8FNdYPy+SK2SIbFBoy/OveRgw053U3VdGUEPKwqZlJynT2QFpnuvzqq
WEP/3aQ2AlFa1pFjFJrGsbvtu+2ZUlaSNS9V7ndrrGTISsaKfKU=
=MXQQ
-----END PGP SIGNATURE-----

--br25mg72tdjmjgjf--
