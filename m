Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C302F710259
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjEYBZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEYBZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:25:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D620AF5;
        Wed, 24 May 2023 18:25:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QRVk44c6gz4x4N;
        Thu, 25 May 2023 11:25:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684977949;
        bh=LL0LczuKg+G9HWFDEaDIO2VCeLIMzL+Gu+5X/x5Ia2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qhD9yMYhTOo1JNmf+jr7SOyHfWJ3vdOdSP4uCqyv+c4KuI+tTo/+7pGmSQ9+KjzS6
         +Ere/HJ1UZPnfRFEbkcj8ftWolTjEvIElBg7ULaJPrImDnYAoZg19wl3FfcZMdrtZW
         2TuOS2AGyopVBrDIJbC1m9mYZMY+ZBpE/SIgfI8yA+JgtveXE4McDMU+mgwEW8FABa
         Cp97blqnZrDRBdKfVNXVGO7k7UTp6326eOO7RRjXxuUAgqVrZhE+nycsoKBVdF0iUs
         FEtDe7Hn87ltrRaWrNGCDbXkuFrQhBq1UBHV5EYRaXhU9F/6C8EgEazKXKwLkXjMUH
         k7uFzHdyWAilQ==
Date:   Thu, 25 May 2023 11:25:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Huan Feng <huan.feng@starfivetech.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] crypto: starfive - Depend on AMBA_PL08X instead of
 selecting it
Message-ID: <20230525112544.4848659a@canb.auug.org.au>
In-Reply-To: <ZGwmAp5RPqAjVMCg@gondor.apana.org.au>
References: <20230522105257.562cb1ec@canb.auug.org.au>
        <ZGr6aB9uJVnyfJQ9@gondor.apana.org.au>
        <20230523103637.20175fbc@canb.auug.org.au>
        <ZGwmAp5RPqAjVMCg@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oVlWqZtlV47Kk5/Hqz/IfHY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oVlWqZtlV47Kk5/Hqz/IfHY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On Tue, 23 May 2023 10:33:38 +0800 Herbert Xu <herbert@gondor.apana.org.au>=
 wrote:
>
> On Tue, May 23, 2023 at 10:36:37AM +1000, Stephen Rothwell wrote:
> >=20
> > That did not fix it :-( =20
>=20
> OK, this patch should fix it:

That seems to have fixed it, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/oVlWqZtlV47Kk5/Hqz/IfHY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRuuRgACgkQAVBC80lX
0GyYuggAlKz2O2Mju74tsbyB/6gEAG9NBji6rVr5c2Pxqh8E6rqs+bnTND3oBHpr
AC4IytuQqvgO+9lhKR6d0zIjAZEGOx0b71GSqEmUKHXwM9W0uZsLerQzgII7Oj41
tdxkYUYK7vBKHpGC4QWX29kNWESpndWm90gAUjZt3Tjfu1sGsVX7LiheK0O2my2k
khRMrW6TvS5xEBHrvnFti4INFfSBlLunjTh3ki0ruqqsxIpRoy36ncAzX9rvX9B9
yb+se1xYXbR/HxGxJ7MPMvv/+7SFk9DPj4G/131jHF5veE7NhASXED0qcVcI9Dn+
SK/c0JE0KQxf++D4GfKiveu56Ur1MA==
=dvte
-----END PGP SIGNATURE-----

--Sig_/oVlWqZtlV47Kk5/Hqz/IfHY--
