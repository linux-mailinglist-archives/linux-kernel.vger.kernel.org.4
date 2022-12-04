Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92596420A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 00:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiLDXwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 18:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiLDXw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 18:52:29 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF0B12AF4;
        Sun,  4 Dec 2022 15:52:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NQNlH0g92z4x1H;
        Mon,  5 Dec 2022 10:52:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670197947;
        bh=DT7W5IgwDWV6hM6pj/xWqOLA5IrhhVNwym6MmH4hJX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AleDbY0CMfFUM5aIqeKthFCwYsOwsPbAc2F4+4JpekaVi6SRp4+sco1VoQbcngrRo
         lIC671ZBHnqu/P6RoW49TTI0fFd7j60FmiLT03S+AJJq0e+Rvf0UdmSVzmsA4Uw2br
         gZBq33uiAojBxv/9RpulT5sP8rcGumQARbFcRuV9ZfuSSipcKdl7KQU+ID+DGQDy1k
         Gut83pLTuhf2z8jJerVJK7XP+SLDM4djUyVZo+LJt/FBHHPXi9k5+I0Q7UaP4Jm9bJ
         2KLNU106o0uej0RFDJYGkecRtOGBftf+cgoHbBmPoSIe1GLB8E6lrX5pdZunKCp36R
         VWRxXTqrsRijw==
Date:   Mon, 5 Dec 2022 10:52:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <20221205105225.502d2278@canb.auug.org.au>
In-Reply-To: <20221205104857.2dab1586@canb.auug.org.au>
References: <20221205104857.2dab1586@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3O6KPx5Zsaa1u95P3VOcixO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3O6KPx5Zsaa1u95P3VOcixO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 5 Dec 2022 10:48:57 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> It could be (easily) argued that arch/powerpc/include/asm/cache.h should
> include linus/types.h, but it is also unusual to include an asm/... file
> before all the linux/... files.

Or maybe you should have included linux/cache.h instead of asm/cache.h?

--=20
Cheers,
Stephen Rothwell

--Sig_/3O6KPx5Zsaa1u95P3VOcixO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmONMroACgkQAVBC80lX
0Gz+UggAi8mAW4yDJzKsYQ0UKBCAnWxolGt7tWnVF38OLG7ZWrvmxmU/sTTWA1DL
QguCLzbg/NoN6tncqpL50+iYrC5R5IeF+Q2Od/mjCrgQNTGrs0GLWrJxQ3QEAqyS
7ibxucFAhEbg2q4xycf6zC0E7iZ+KpK6T2fALNQ8+x8cdZVsJijAUdamRsbF5+5w
Y52lcQW60AFKpLaUFtvyhnjZ0991pUF/pFzQu5Cegzt0f2mAKNwgtlAlLGOyaXAA
4pDycUrNmu1fFmH33KsiYDRZ1XCm/3Cknn3qeDVt5vliszRLXb/IkO4EWcdlCvWK
/HeB6U1H2cZQR6m37aoy9isMEpTT/Q==
=GEsa
-----END PGP SIGNATURE-----

--Sig_/3O6KPx5Zsaa1u95P3VOcixO--
