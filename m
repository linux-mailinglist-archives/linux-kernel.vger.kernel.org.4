Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D131164ADFA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 03:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiLMC6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 21:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiLMC6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:58:16 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C050413F2C;
        Mon, 12 Dec 2022 18:58:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWNTw2Hdlz4xN4;
        Tue, 13 Dec 2022 13:58:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670900293;
        bh=0dc9lgZjVANauji2m70gBAeV2LINYSzAa3eEsrS3Gs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uKN/mflFOkoC+pzOQcTxJdDlh8T6HJjDg1xC93hF8UcpGEuHSxmiBjXb0g2dDkS5p
         5F9YdMZf+4+aFiZZN2nwemZVTxZJjJNvv6lTWmeXoJFJbq/NjjdGh8dpfJ+3zRHmAH
         Bn/lC+CNBrwakh69Hh2l25iW6+zAvw0StV/UIytCRMJr0SvYGhNj8H/OXgNoJWNO25
         oVoOBHbyOLLNfFHUDVK4L7sQlyWXjTF1FCquB9QhHqES/FvtRpIWOUdZGNOZuAoe/+
         OYhhwELvpUbQ8BOKqfrhjanOlu8MDI519h2sBYGERFY2AjMfKL50SHgooDX1hw7Y09
         UrFYxumW501Og==
Date:   Tue, 13 Dec 2022 13:58:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] non-MM commits for 6.2-rc1
Message-ID: <20221213135811.3f0b07b2@canb.auug.org.au>
In-Reply-To: <20221212183554.e0a2536e860172282b189ca4@linux-foundation.org>
References: <20221212134425.b20b80955e5e8a4a36ce1b9a@linux-foundation.org>
        <Y5eoS/UfBhovR70j@zx2c4.com>
        <20221212142754.5f699c4ff515fd9d42768fb2@linux-foundation.org>
        <e7c6b99a-743f-f40a-0b0f-31730964cb36@suse.cz>
        <20221212183554.e0a2536e860172282b189ca4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZdDhwBg7FNFHWcu.l8kupo_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZdDhwBg7FNFHWcu.l8kupo_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, 12 Dec 2022 18:35:54 -0800 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Tue, 13 Dec 2022 00:16:07 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:
>=20
> > On 12/12/22 23:27, Andrew Morton wrote: =20
> > > On Mon, 12 Dec 2022 15:16:43 -0700 "Jason A. Donenfeld" <Jason@zx2c4.=
com> wrote:
> > >  =20
> > >> On Mon, Dec 12, 2022 at 01:44:25PM -0800, Andrew Morton wrote: =20
> > >> >       wifi: rt2x00: use explicitly signed or unsigned types =20
> > >>=20
> > >> Why is this part of your PULL? This was a netdev/wireless tree fix w=
hich
> > >> was in 6.1-rc5. Kalle wrote that he took it on 21 Oct 2022 in:
> > >> https://lore.kernel.org/all/166633563389.6242.13987912613257140089.k=
valo@kernel.org/
> > >>  =20
> > >=20
> > > Huh.  I guess git quietly accepts the identical commit, so Stephen
> > > never told me and my test-merge-with-Linus-latest also came up clean.=
=20
> > > Which leaves it to me to manually handle these things, and that's
> > > unreliable.
> > >=20
> > > Is there some way of telling git to complain about identical changes
> > > when doing a trial merge? =20
> > =20
> > Probably not exactly that, but there seems to be a way with "git cherry=
". Dunno
> > how reliable in practice, seems to be based on patch-id so probably can=
 fail
> > easily if the commit or context changes slightly? =20
>=20
> Well here's a hacky thing - just look for duplicated patch titles after
> stripping away the hashes.
>=20
>=20
> $ git log --oneline --no-merges v6.0..HEAD | sed -e "s/[^ ]* //" | sort >=
 /tmp/1       =20
> $ uniq < /tmp/1 > /tmp/2
> $ diff -u /tmp/1 /tmp/2 | grep "^-.*"
>=20
> The above turns up 67 duplicates in Linus's tree and 382 in linux-next.
> Maybe this is wrong - I'm just tossing it out there in the hope that
> someone will do the work for me :)

I already do this when I produce my stats after the merge window - I
produce three lines like these (from last time):

Commits with the same SHA1:                        10436
Commits with the same patch_id:                      342
Commits with the same subject line:                   20

The above is pretty easy, but takes a while (looking at 11000+ commits)
because I am just conparing Linus' tree to one of my trees (so 2
branches in my tree).  During out development phase, these commits
could be spread over 350+ branches in my tree :-(

I will have a play and see what I can come up with.  The plan would be
to figure these out when I fetch trees and only report them to people
who care (just you, Andrew, initially) as there are trees out there for
which duplicating patches between the development branches and -fixes
branches (and Linus' tree) is part of the process :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/ZdDhwBg7FNFHWcu.l8kupo_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOX6kMACgkQAVBC80lX
0GwwzQf/epFGs2COgU6byJ1MNtBGxAku6cVVwjJG7M1+s2Ftfq1moVxyEFiEBf2o
ZsGFiSMOe7GH/zfbFY/RmpIeZtTh1MBhcWkY9V++qX7pv+c3EUfvVnPHQJXZqPJ7
1nlzLWde1FuYiPl+s9l+9RXjF412nG/pADsi71KqSE88yxc7OeHAopajYeOXYV9j
uMriMp2KblJy3po9JyUotyYUSKFaWEMnmfN6ZB+8XMxhkZevbkjkJmsT/ojK78so
IZmJX97KVVizoK5acJJTwR5BKWzEEvnyKD+ErWp+LSO+QiMj1iSUfYWUC7D+CMBf
t9E2bpmO8cZyMAglK9+PNyeqyPX7KA==
=9yiP
-----END PGP SIGNATURE-----

--Sig_/ZdDhwBg7FNFHWcu.l8kupo_--
