Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEA169F418
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjBVMNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBVMNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:13:48 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D705B7A87;
        Wed, 22 Feb 2023 04:13:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PMFS41Nh5z4x7W;
        Wed, 22 Feb 2023 23:13:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677068021;
        bh=CCCioTOAL95lINYsTc0QjL/cyM1/Zvh2V1qPLfQyFGk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SRhKyWt94W4krAAzBoj1L28ZgJYnMDgOjaTAYe6Tda/8TOSbtiTmlilRuzHDv6MYL
         1CZvEjFFv8fANoaBud0knqTmCxqt/iyMO8OILAOh3WymsO51T8Wp9sO0EL6TigIdb9
         6AwVbP958lhs/YVzMmjBkKZceS5tBFDIbY/3ZIT5u1vA6+2wAos48KJvr+7u1lZYqn
         eqB7/RZ7xFsFDAr05lyXspmDZJLEYjFLQSucIQNHHZ3Rei0yqylS8sWPkXbXdgF0pQ
         UB84pfphYOzHlFrb8AcuARmCN32XPGsl9eUZilYUZKswJIb+wtWZt4Ej8LNCqd+bcq
         KB3EY5p+iN4TA==
Date:   Wed, 22 Feb 2023 23:13:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>, Paulo Alcantara <pc@cjr.nz>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: linux-next: manual merge of the mm-stable tree with the cifs
 tree
Message-ID: <20230222231337.3316440a@canb.auug.org.au>
In-Reply-To: <3325858.1677054470@warthog.procyon.org.uk>
References: <20230222134927.459b036b@canb.auug.org.au>
        <20230221184225.0e734f0e@canb.auug.org.au>
        <20230221174401.7198357d@canb.auug.org.au>
        <20230220152933.1ab8fa4a@canb.auug.org.au>
        <Y/N8hVWeR3AjssUC@casper.infradead.org>
        <20230220190157.3b43b9a7@canb.auug.org.au>
        <Y/Pe2xHklSr1hDtz@casper.infradead.org>
        <2351091.1676963957@warthog.procyon.org.uk>
        <2885897.1676990364@warthog.procyon.org.uk>
        <3325858.1677054470@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ygwXD6lRg3GxyS/ln.n=Vs_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ygwXD6lRg3GxyS/ln.n=Vs_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Wed, 22 Feb 2023 08:27:50 +0000 David Howells <dhowells@redhat.com> wrot=
e:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > OK, so in the merge of mm-stable, I used the cifs version of
> > fs/cifs/file.c with this patch applied.  The merge resolution for that
> > file looks like this: =20
>=20
> I checked it out and diffed it against mine.  Looks right, thanks!

Thanks for checking.

--=20
Cheers,
Stephen Rothwell

--Sig_/ygwXD6lRg3GxyS/ln.n=Vs_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP2BvEACgkQAVBC80lX
0GxcWwf9HniWWVZROA72eHBznLGITsOKf6EmTYN1iQenlMOublvbyQroPeBnEPSa
Vm3Mv7a218GPpHnej7JrrndfFJa1s/7f7yHVx7z7wI153rtPc1gFYBgSxKeorgbg
sO94YGKRp6D3Ro0XOJgmSky+ScVUY2d5YbbogN/YGrZcQz59SkFh4bm8/VG/bvEB
ZJymKCVTugr4tRLxPCD/Tw7XDZgspbxfRSFrXZTMpe21xNHL7WNuuNZZAAKNH/33
slGBsGZ07LV6LULGyYYN/9lpB5esiGOfGTy4X0VpmppItjEm/SC8a3QabKgv0eCF
KfK3pShbs+G67Xy07ywDgAgmST7JKQ==
=gpVM
-----END PGP SIGNATURE-----

--Sig_/ygwXD6lRg3GxyS/ln.n=Vs_--
