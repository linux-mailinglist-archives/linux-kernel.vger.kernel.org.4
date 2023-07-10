Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35EC74D320
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjGJKQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjGJKQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:16:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12B318D;
        Mon, 10 Jul 2023 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688984159;
        bh=J4DgViDN/Qmz2EEqXoHXWIKQ+GA3FvdJS+EF395iAWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i35xru2+kKtqCxkp2nPFJJGUfpipGR97iDGizWhmmUeEghmsoMJ5AxAu7HY2eaU3Z
         HpED5CRTVontCDAhy9Hu/XkMtMZvW3L1KDhG4coZB15JdwSS+6nLsciS5YPXhho7d8
         C9xVmKUWGQvhSAchHZCJ52V7jmXzH7r5G5fcOqmc0tCU/EYvL7ogYyt5dJUhQcz4o4
         3H2jZ7PErwvQStSkDaWWQxBRx2ROi8xpd5yJXfludXLEdebctRijraD5sgIckmyHu5
         iIs2hVnbVrCInQXMu2PL0UfGoLpkU9suwwHgxi3X7mnxy8k04GGArUtD+rYCh6zCVW
         WDiJdwgjfnbQg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R00JY5YJ4z4whq;
        Mon, 10 Jul 2023 20:15:57 +1000 (AEST)
Date:   Mon, 10 Jul 2023 18:22:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Leo Li <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vineet Gupta <vgupta@kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: linux-next: branches to be removed
Message-ID: <20230710182229.36bcf79d@canb.auug.org.au>
In-Reply-To: <CANiq72npQiWMebvYTu8Z+XuJAyUH6-iygGtbF9V6y+R2aD1-vw@mail.gmail.com>
References: <20230710172602.05d32c03@canb.auug.org.au>
        <CANiq72npQiWMebvYTu8Z+XuJAyUH6-iygGtbF9V6y+R2aD1-vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Iq+6EUT/iK/lxxbiiPPNgBx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Iq+6EUT/iK/lxxbiiPPNgBx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Mon, 10 Jul 2023 11:11:08 +0200 Miguel Ojeda <miguel.ojeda.sandonis@gmai=
l.com> wrote:
>
> On Mon, Jul 10, 2023 at 9:32=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.o=
rg.au> wrote:
> >
> > clang-format            2022-05-20 19:27:16 +0200
> >   https://github.com/ojeda/linux.git      clang-format =20
>=20
> We will eventually have updates for clang-format -- if it doesn't hurt
> too much keeping it, then I would prefer to have it around vs.
> creating it again later.

I have resurrected it.  You might consider just resetting the branch to
something recent in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Iq+6EUT/iK/lxxbiiPPNgBx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSrv8UACgkQAVBC80lX
0GwniAf/WIPkHZWkWcmFNqefdLpUfathw/ArqmreAm1xN4jF8ybG5Bn7jl/v5WlY
laF02ryFDYOZZh1sLB3763DBQjUlm9OFi+ifucbt+g/E6Ijhhn8iUc7XI4XwrUmU
5M0DB9idPYhxf+A6Sa27ZdPraivWCYETAkLbxT/jHcERP4vMvglA2YmdDvMVFF6A
QnrBWdDUizsdZAyzrcYttvepXysDGcoxiSlQG5d4PQpHTW6F8LP18IEjOr/pmWSU
Qha/1Y8O0kenviT1/Xdh9lXvbjYhAmRK9MYjPBczEEmzJ8ZMMh8T+PFNDSWPFp40
deTFS4h8GpSlDVuzHfCA8tDR6oexng==
=hgy+
-----END PGP SIGNATURE-----

--Sig_/Iq+6EUT/iK/lxxbiiPPNgBx--
