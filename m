Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAAD73BCF4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjFWQrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjFWQrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:47:17 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8590B10C;
        Fri, 23 Jun 2023 09:47:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E017E5C0048;
        Fri, 23 Jun 2023 12:47:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 23 Jun 2023 12:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687538835; x=1687625235; bh=FxZNrWvPKPTmkKt5iB7ImZO3THwWpV5+Ltb
        CehNa1QQ=; b=Xx8eLf6FvI9QvBbx2NwBBbOsmcGespbXP7jpO3YIoJOsmmCs05F
        G1GxEpmNgfJglbMjEtyEqGH0Zf+cSVoWPhh3/DEc8SmFLxap9J+Azi2CcLaSZggg
        ir5DbER1EEFN+iffZq18yjjH1FtW3EHnkZ1h3p+CTXXwRi6Tp8EabSFgma5zIzT4
        kAjcHYzZW2vD/Fh3f2NMrJjUhVniitoadBGEE8TzobZh6lKarAlvGG2Hb7P8V2x1
        GAuewE4l9NMkJkPswneD7FzDRMbIkLa3A5MsKEnaIEcrLhfFUA2W4twOSgqRYWxt
        8S2kIb13ZS+T/dshV+dsr69hu4KjOeSIpYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687538835; x=1687625235; bh=FxZNrWvPKPTmk
        Kt5iB7ImZO3THwWpV5+LtbCehNa1QQ=; b=TQ9kPjqDlLIibATgeZ6muabnXmhlp
        VGKp/xsc8zKPY+j1gBMNgiG8d2qfy1ALB024SWI9D+fCTDX3Aa/0uC1PjtXtULDw
        QuiOnO8s0OQJ55y6XbSDK3Ifg4i4MwMML80ysJPrW0bZWUxo3WMhwmxcq9rFlFBz
        t9w+3znKnGw/dgpQe5gERY3kRjwdA5FUMIVhP0K2mcUa96HJCXLuxu7LEFRw2o0j
        JqmfcP5OnNcuop7kmobJD00YDRyuFvayeRbZ+Q1/UDclW/hT/oC9zqCQ3LNnG3q3
        yYRmZV+UZP3+apd8ueDHFda9F5RDFgA86rIekeSD+UqM6H4wL1QReiOCQ==
X-ME-Sender: <xms:k8yVZOcnm0yfnoZHOD7OmutPEAOQ7iHZVeJ5T3mpMh5RvVAGBHawgg>
    <xme:k8yVZIOj02ZVTSaNvSo6l7bhsoEbYPb2v3LKZ_o310PCcKFUl0MLqaLXuG1_ujMSy
    459YcjrZv20-5s>
X-ME-Received: <xmr:k8yVZPioKDsGHcBZB5wzyJ3rd4NCUIsjkQlFmSXD1R8nbhgUzBVqkvI6-aY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeggedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:k8yVZL8totFP0UytnB7btrCcVJyQMWgcltBdCFWncCkVgBcrGkTs-A>
    <xmx:k8yVZKvYfgGMY0uteS8dddhJaFJGPDYr_ToA17AT4KVzuWM7hQwkKw>
    <xmx:k8yVZCF_NiI4fvwFgBLLkKLLBGRSVK1XIZvFw2UWndiAnb0n-3KnAQ>
    <xmx:k8yVZD4wbjyrPMD2n47WouCHuuVVFM6dG6MarbQw5-nSEHkPQdWcww>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jun 2023 12:47:14 -0400 (EDT)
Date:   Fri, 23 Jun 2023 12:47:08 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the device-mapper tree
Message-ID: <ZJXMkd0eOEBnpUw2@itl-email>
References: <20230623143011.7deba53c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNJM2LfTtJi3ok2p"
Content-Disposition: inline
In-Reply-To: <20230623143011.7deba53c@canb.auug.org.au>
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


--PNJM2LfTtJi3ok2p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Jun 2023 12:47:08 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Alasdair G Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the device-mapper tree

On Fri, Jun 23, 2023 at 02:30:11PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the device-mapper tree, today's linux-next build (i386
> defconfig) failed like this:
>=20
> In file included from include/linux/kernel.h:30,
>                  from arch/x86/include/asm/percpu.h:27,
>                  from arch/x86/include/asm/current.h:10,
>                  from include/linux/sched.h:12,
>                  from include/linux/kthread.h:6,
>                  from drivers/md/dm-core.h:13,
>                  from drivers/md/dm-ioctl.c:9:
> drivers/md/dm-ioctl.c: In function 'next_target':
> include/linux/kern_levels.h:5:25: error: format '%lu' expects argument of=
 type 'long unsigned int', but argument 3 has type 'unsigned int' [-Werror=
=3Dformat=3D]
>     5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header =
*/
>       |                         ^~~~~~
> include/linux/printk.h:427:25: note: in definition of macro 'printk_index=
_wrap'
>   427 |                 _p_func(_fmt, ##__VA_ARGS__);                    =
       \
>       |                         ^~~~
> include/linux/printk.h:498:9: note: in expansion of macro 'printk'
>   498 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>       |         ^~~~~~
> include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
>    11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
>       |                         ^~~~~~~~
> include/linux/printk.h:498:16: note: in expansion of macro 'KERN_ERR'
>   498 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>       |                ^~~~~~~~
> include/linux/device-mapper.h:626:25: note: in expansion of macro 'pr_err'
>   626 | #define DMERR(fmt, ...) pr_err(DM_FMT(fmt), ##__VA_ARGS__)
>       |                         ^~~~~~
> drivers/md/dm-ioctl.c:1421:17: note: in expansion of macro 'DMERR'
>  1421 |                 DMERR("Next dm_target_spec (offset %u) is not %lu=
-byte aligned",
>       |                 ^~~~~
> cc1: all warnings being treated as errors
>=20
> Caused by commit
>=20
>   5df1daff2cc6 ("dm ioctl: Check dm_target_spec is sufficiently aligned")

Ugh, sorry about that.  I=E2=80=99m pretty sure the code would actually work
okay at runtime since unsigned long and unsigned int are passed the same
way, but this is still a bug.

> I have applied the following patch for today:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 23 Jun 2023 14:24:29 +1000
> Subject: [PATCH] fix up for "dm ioctl: Check dm_target_spec is sufficient=
ly aligned"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/md/dm-ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index 5f0b641538d8..8b480d7825fe 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -1418,7 +1418,7 @@ static int next_target(struct dm_target_spec *last,=
 uint32_t next, const char *e
>  	}
> =20
>  	if (next % __alignof__(struct dm_target_spec)) {
> -		DMERR("Next dm_target_spec (offset %u) is not %lu-byte aligned",
> +		DMERR("Next dm_target_spec (offset %u) is not %zu-byte aligned",
>  		      next, __alignof__(struct dm_target_spec));
>  		return -EINVAL;
>  	}
> --=20
> 2.39.2

That fix is correct, thanks!
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--PNJM2LfTtJi3ok2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSVzJAACgkQsoi1X/+c
IsH60g/+NCH4eD7P5GyFdcqFNWM/aI3nn9Uu7FNb6Xr4y2T3cmIKrGvGHOYAunm4
AF00Y0OuDq53do4Ruf6fc2Jufb4IDJR19rHU4dFX5r1L462SOno0e1eFmsgzvTat
P9GnKuPTsHTgLf9oWV6ACNqdM7G4v57sRsGCm4cvpFSz8CreOM7P8lwer0gyJy0+
Lfk+CIWJat+ICEhj2+qmXert16D3eQVNpnFHCMs09414J/GnL1E717bdJycZ3dug
FSidDTf4t66rGcuU95AEzEFCrHEBnn5hJmKdQuW/Bg+QXFcPMWqPhOZ0DG/Yqw+S
VKbaDfYcmCA03bwgVP9kNX8nU3sipJifXmqyGrFo6pOHbMcr3SBcW7SLeGSiPd3J
TDja4Ja+bOIQjIPCrxzqwnNxS/FrGgiOwvHwNPJjxfpIsSGTonPDsq4D4A7S9D9k
JtRx6U+mscjIwvz2O8qcsl9z0mwHBCIhQe28TZ1u3Yo1e9OLazrAkO28fHb3/U80
l6arsce9dpWpKB4Dtc/sw6u/2XhnlCIUa2hoF8wzPVdOGcvlsX5utQG+vbiu04yW
y+5bB/i2z09q2gZzCA+19qE0q8gvRSgSuKIDTVWgeTAndUb1YzUaOKAgk0izt/KQ
pcgcv15XK19taV1Jo/LGey7jt6I3j2SQfwIMM4u8AX5+WAHxeqc=
=qJJP
-----END PGP SIGNATURE-----

--PNJM2LfTtJi3ok2p--
