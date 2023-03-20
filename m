Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279FF6C0EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCTKV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjCTKVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:21:18 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301F312CCA;
        Mon, 20 Mar 2023 03:20:57 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 629DD3200124;
        Mon, 20 Mar 2023 06:20:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 20 Mar 2023 06:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679307655; x=1679394055; bh=zd
        tu/EQoS4ubonz91LB5myB03/gZeyMcyiaiN6cyoaE=; b=BscOjOIfRtg01UNhWL
        eOf7KYzmUIvK5Fyn/YjgIY2FR3+XPNsXRHu7WNoJJAVg8+Ihzkpt5cQ5y1/Z5/gM
        IGKBZi1E7LTKNBCp6wlMTFm+2OvQVXFP2TKfIyK//2mOihm0J3d+7Fi+B6spQGZs
        slHRq47MegU/ypRvjX6Kh0SEGF68cfFo2lWTB7W5Qtq7WRLE8foES+Y5RVI/Nnvv
        FlNVwniD7MoeHmx28E9ia1UKAZF3ZOiTG0vZ7K/C8DAzMlxdDg2ejdYajKHnA92C
        O/pfkPUBjHWN8MIAFDBa7ClzKOXj79sNzt8D92x6nNSweoDbmqtrFTTST3cPUSjU
        b6LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679307655; x=1679394055; bh=zdtu/EQoS4ubo
        nz91LB5myB03/gZeyMcyiaiN6cyoaE=; b=ggjv5A0oCEO/8Xk+Kp33JmNhhWwET
        W7m3u0J19xpVYFZrGot9sRr45UOsfmLpDV2m9e+4r13ut1G8++2KziHU7lB9ZRVy
        6FWpQkjO+sgfIlJeu3c5iolXFP0o5d3TCjIqMdG/nvkftb6Ine1XTPXnEUAzzPP0
        cNwLDgoMlZ6iEsGa3LrpjqQEvDd51a1duKNpx0WYlXRA6Abcy+yX8AEMQuZV1Wwl
        QmUtcuPZTKCg+gUl45N8nkkMVWzyBXbf3HRHTcnaEfCSodjPr7kkH1OTfdNkvRBY
        bet8PbKdtkzTsJnNXlMIcHtkBE0uv/N9OMSryQUK7VscxMWoPfH4tZZ/g==
X-ME-Sender: <xms:hTMYZGOZwh5MJ3SD24xBCvE-spjxwuw7d7POwQdOyznH8e4z2bSOHw>
    <xme:hTMYZE9d5HfoaHowCM2ba8MkSwZYewFlaXet1M5NhbrqS0Odf9PunutqDunpHQqBG
    _KIKBhc8H_pGZuLQg>
X-ME-Received: <xmr:hTMYZNQMRbbEzh3Ix8DYJ7c155VOu7bmKMkAu6V42Hmc0Spkl8DPwUgaYZNBF7xP5wjAvtTviT1EN23FO4ic40l-o6VLmKPq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheptehlhihs
    shgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepge
    ejieegjefhgfffheeuleduvefhiefffedugedvgeduhfdujeehfefhuefggefhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihsh
    hsrgdrihhs
X-ME-Proxy: <xmx:hTMYZGtaQJWQBkRaKzjDu038fkGEYQXmcU_zle5xRW7Vcf80FAH_vA>
    <xmx:hTMYZOdlir5PwvIEWT0Nx9RImPLz89Vi6zyJY2LM62FUQtO_DYGz8w>
    <xmx:hTMYZK2JVTyYb5uAImN5upRndyAWG9zoPNpNi6M1Yhfppo2tpqCsEA>
    <xmx:hzMYZO6XMiZQGhTKw9zqwJxzPdjPP2VVxYBl9pLCl6S6xCmEDH75gQ>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 06:20:53 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 861151452D2; Mon, 20 Mar 2023 10:20:51 +0000 (UTC)
Date:   Mon, 20 Mar 2023 10:20:51 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: LOOP_CONFIGURE: send uevents for partitions
Message-ID: <20230320102051.p4rrvjjhaq35amcr@x220>
References: <20230312191031.551204-1-hi@alyssa.is>
 <ZBHo2AXYM0iVkXvO@infradead.org>
 <20230318015005.czydsbqpw6hnej3z@x220>
 <ZBf7oYDLoFzOSabH@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qzb5e35alucfu2fx"
Content-Disposition: inline
In-Reply-To: <ZBf7oYDLoFzOSabH@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qzb5e35alucfu2fx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 19, 2023 at 11:22:25PM -0700, Christoph Hellwig wrote:
> On Sat, Mar 18, 2023 at 01:50:05AM +0000, Alyssa Ross wrote:
> > What happens next?  I'm still getting up to speed on the kernel
> > development process =E2=80=94 will you submit this as a patch with a pa=
tch body
> > and a S-o-b?  Or am I supposed to do something with it?
>
> Given that you're done all the hard work, and I've just reduced the
> critical section, I'd prefer to give all the credit to you.  If you're
> fine with it, I'll send out this version later:

LGTM, thanks!

> ---
> From 4648015b4193c81d3de8c1632876314b4a2ab40d Mon Sep 17 00:00:00 2001
> Subject: loop: LOOP_CONFIGURE: send uevents for partitions
>
> LOOP_CONFIGURE is, as far as I understand it, supposed to be a way to
> combine LOOP_SET_FD and LOOP_SET_STATUS64 into a single syscall.  When
> using LOOP_SET_FD+LOOP_SET_STATUS64, a single uevent would be sent for
> each partition found on the loop device after the second ioctl(), but
> when using LOOP_CONFIGURE, no such uevent was being sent.
>
> In the old setup, uevents are disabled for LOOP_SET_FD, but not for
> LOOP_SET_STATUS64.  This makes sense, as it prevents uevents being
> sent for a partially configured device during LOOP_SET_FD - they're
> only sent at the end of LOOP_SET_STATUS64.  But for LOOP_CONFIGURE,
> uevents were disabled for the entire operation, so that final
> notification was never issued.  To fix this, reduce the critical
> section to exclude the loop_reread_partitions() call, which causes
> the uevents to be issued, to after uevents are re-enabled, matching
> the behaviour of the LOOP_SET_FD+LOOP_SET_STATUS64 combination.
>
> I noticed this because Busybox's losetup program recently changed from
> using LOOP_SET_FD+LOOP_SET_STATUS64 to LOOP_CONFIGURE, and this broke
> my setup, for which I want a notification from the kernel any time a
> new partition becomes available.
>
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> [hch: reduced the critical section]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Fixes: 3448914e8cc5 ("loop: Add LOOP_CONFIGURE ioctl")
> ---
>  drivers/block/loop.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
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
> --
> 2.39.2
>

--qzb5e35alucfu2fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmQYM4AACgkQ+dvtSFmy
ccBnEA//VgWoGC9VRthd9MXyOEndaz8Y9hLh6rAshgTLfyfUIEUzSzB+l0qJr+IZ
oD9OTVgRoouDTOH6ze88ft4E8rxFk+Dhbg/lci0vkj/j7tTfOOpxQ62O4p1d6kTf
pTHpjd7KtL44B4cEnUX6B9yBmZypJ77994qL6L/62mySRri0CjTiboXUVC/UTiEr
cjpP0FF8sQfg4vBmD6/ht3CS7HOrZE7RDrGXqU5+6rDcZIDwJCfJ1sHUbqQZimGu
MZXVJhhKvMBaJ/8r+HSuNgHOsFdGdPIqqmw4rOF0p5AnMq6PkwlR6C8ScPYfJgu9
KSjsTC3fLMaR+oOa7f1ImQlBro+vuYNmd4liiz3Dbor2Y6S+LC0+tCWAtPgDxbTt
Ri4rz/orq2mB2zRy8MX3wlJSaFu7cNHR81xjNs2PIm8EC/O38EkevD2AL+bth1vm
kHfW7RDTXwigugwRpgKruNbd39zc6MDKCSQaH+S+e+JKUaNGnrWbeGlsQrBlapmZ
cwKSu5Z+E+/hG5wDxbrqEE2RqUXD8UAPAh1x3wOjC6S2chWtuw3mRmgnuImrU7XV
4P/WCP4Iwn4MR2nmQqoTbmGe1lZ1COGO1RgW8LaTBO11J9+ZIMJ17NOz+lLxwDFv
EEdEQ0KGkX3+iUf9g0fgxbQL5F42aJM68Wm+IAKbvcR1jtl9BbU=
=4M5M
-----END PGP SIGNATURE-----

--qzb5e35alucfu2fx--
