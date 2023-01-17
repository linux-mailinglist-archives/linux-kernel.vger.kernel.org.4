Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1720670CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjAQXNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjAQXNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:13:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E5B8874B;
        Tue, 17 Jan 2023 12:56:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NxLlp56Rcz4xMx;
        Wed, 18 Jan 2023 07:56:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673988983;
        bh=JURaEdE8CMeLGxxVxQfYP3YHQFwTCFjuZtmFFKcP1SY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HFmgvjCT4hnwui+3XW3WWuRB/ZIVIC+IvKxZIORl3JzW7D3Dm+e/f2BbxlzOit7dB
         aYa2A0tj4hieeB1cVpYvFKoi1ym6wqlZUF2HWC9ki0DiKX+S4jU3zgkfGTrZO/UJQF
         0p3veyIeqJAofiIQ5NOl+UyqPKCfrNBaB7qMPitdxe6qQjN7XrF1z+B8GXWnHebQ0a
         WSXmBGIgSkmVJBThKSpi5pK8pMTkNyQM7xF52KYxs5hxI+J3lB1ODjitcrpwpVHEtj
         mXqJkhe0LPCrOU4kVHGLb6XY3V014E2Mk/8BTy3uY9/98xV3kXR0i3Ui1jyY9xgmxc
         vF6QTl2YiFpdw==
Date:   Wed, 18 Jan 2023 07:56:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the kspp tree
Message-ID: <20230118075620.60250ca2@canb.auug.org.au>
In-Reply-To: <CACO55ttvqwnmGS=4gig-AOy+67bDesdj2S9HDJ3hS=uyN0NGOQ@mail.gmail.com>
References: <20230117150212.3d8ee843@canb.auug.org.au>
        <CACO55ttvqwnmGS=4gig-AOy+67bDesdj2S9HDJ3hS=uyN0NGOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/roh3be+LjwRG1po+YE_hoN2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/roh3be+LjwRG1po+YE_hoN2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Karol,

On Tue, 17 Jan 2023 14:52:12 +0100 Karol Herbst <kherbst@redhat.com> wrote:
>
> On Tue, Jan 17, 2023 at 5:02 AM Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> >
> > The following commit is also in the drm-misc tree as a different commit
> > (but the same patch):
> >
> >   06b19f46455c ("drm/nouveau/fb/ga102: Replace zero-length array of tra=
iling structs with flex-array")
> > =20
>=20
> which branch? Because I just fetched the remote and don't have this
> commit in my local repo

That was from
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git (branch
for-next/kspp) yesterday.  It was the top commit in that branch.  It is
still there today (I am not saying it should not be).

> > This is commit
> >
> >   54d47689c6e3 ("drm/nouveau/fb/ga102: Replace zero-length array of tra=
iling structs with flex-array")
> >
> > in the drm-misc tree.

That was from git://anongit.freedesktop.org/drm/drm-misc (branch
for-linux-next) yesterday.  It was the top commit in that branch.  It
is still there today (again, I am not saying it should not be) but the
branch has moved on.

--=20
Cheers,
Stephen Rothwell

--Sig_/roh3be+LjwRG1po+YE_hoN2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPHC3QACgkQAVBC80lX
0GzxyAf9FiQpvKWIWXkG5ENB8aCFwuWvd/MajLzDeMrtpfRzTMdkzo6kA5CM4Axq
r1sYV2d/rY305uM6Wt3t32Fo/nzKZubPR1AjaGgXhXXqCgHjDmFDR/h2P1YR9Rxv
6/kauy8dJ5HacdmR9mFvz9fSjWAzwKITyzCF/njYxnRiUGUGTYt0AQd0g+0Iuv8q
4AlvdN/bue/gqHbrgLbg+crMxEZ/PVz/fJrL4eLi72Zst1lBomuoaOGzwyzd6sqt
E63o5dyUu21n2ABGNgHKUi9mcKlI419DYWPxlR55O3dHnLLaISFJj9y1Rti9psT4
ABukiUOMWYiUbODihnq6hhApP4aopQ==
=pYPj
-----END PGP SIGNATURE-----

--Sig_/roh3be+LjwRG1po+YE_hoN2--
