Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A0F6A676D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 06:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCAFpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 00:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCAFpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 00:45:15 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E865832E45;
        Tue, 28 Feb 2023 21:45:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PRNVb3M0cz4x5Q;
        Wed,  1 Mar 2023 16:45:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677649511;
        bh=i8i38LK0uCi56IpERjPOiZiShTJcHjrTwYvIDKyXH+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uoddxQ7tDwlTqH3MXZ419P4dG2XAuETe+YSh+DVvJGD8Gl1srIGzlFnT1KD9e70ZP
         5zGw+b9vbYRZNgde8Do8vbK6YLqYdKw6UKLvSSFyXGbk2t9AsK8ukm9G9h6WLIiHOA
         ASGICHxHor/cNuHk/ippSRG+Z/x+unslKSwiyIi4IvXmA26GmOf0B+IKOU0JaiH7Ti
         kda6R0u6rclFK3cw/YR3kqWZCJ5IGbKYYCYZV2H5y1nCxahRRW6Gpp6Uyg6va8Ydg2
         Ogn/PZG2o3Uen7Hi8Vgi2TPfYy7mQl757H6BsFf7S7abYWI6G4ymlSgw/1Qk296Orb
         E2+MqWbqbZQYA==
Date:   Wed, 1 Mar 2023 16:45:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <20230301164505.69f797f7@canb.auug.org.au>
In-Reply-To: <CAJuCfpGGCzCTyLJwSjkHhEiSed-N=5SGpscq4E=eODSQ4tMo=g@mail.gmail.com>
References: <20230301113648.7c279865@canb.auug.org.au>
        <CAJuCfpE8QwBDxRSY_dCNhias3s7K4bNoyUV6e4Ye6SU_qyYbCw@mail.gmail.com>
        <CAJuCfpGGCzCTyLJwSjkHhEiSed-N=5SGpscq4E=eODSQ4tMo=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J/w_nkUP24ZPQqiT6FATYFN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J/w_nkUP24ZPQqiT6FATYFN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Suren,

On Tue, 28 Feb 2023 18:29:36 -0800 Suren Baghdasaryan <surenb@google.com> w=
rote:
>
> On Tue, Feb 28, 2023 at 4:47=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Tue, Feb 28, 2023 at 4:37=E2=80=AFPM Stephen Rothwell <sfr@canb.auug=
.org.au> wrote: =20
> > >
> > > After merging the mm tree, today's linux-next build (htmldocs) produc=
ed
> > > this warning:
> > >
> > > include/linux/mm_types.h:1105: warning: Enum value 'FAULT_FLAG_VMA_LO=
CK' not described in enum 'fault_flag'
> > >
> > > Introduced by commit
> > >
> > >   5827f16cffd6 ("mm: add FAULT_FLAG_VMA_LOCK flag") =20
> >
> > Thanks for the notification, Stephen! I'll post a fix for this later to=
day. =20
>=20
> Fix is posted at:
> https://lore.kernel.org/all/20230301022720.1380780-2-surenb@google.com/

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/J/w_nkUP24ZPQqiT6FATYFN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP+5mEACgkQAVBC80lX
0GyGWwgAi8LbEaMRO1tzXjw4i8TYcoPblFjo1krkivQ/y0uLe9fqxHuNDSeGfm5J
WN9gFV0aYeq/JaD1o4R48x7wkQVFz1TQNhsqzCSONyVg1rBcyUolyBE9zLBPyoDG
H0RNVPX2CHj3oLnv7+Rl7XopMOcJLRNWvFdBipNjXgcJsFLje/jlqJVtOo0n64qK
XAJgwHohkAmHKOs8vzhirFdfBulhXXiSljDbl3susxDOUugKYoyVbjaC9I/c2/sq
8oShq2EiwmEUJPz6gq0f9fhPjhJI+5h0EqY3kq1JemnI34A+A/YbkSrrhgran5Ww
PEIcPQxbRY41Yzo7tJMZ4FfXGv9T7w==
=n/TW
-----END PGP SIGNATURE-----

--Sig_/J/w_nkUP24ZPQqiT6FATYFN--
