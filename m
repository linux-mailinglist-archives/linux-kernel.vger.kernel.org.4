Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B57728B15
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbjFHW3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjFHW3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:29:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D023326BA;
        Thu,  8 Jun 2023 15:29:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qcf582RF6z4x42;
        Fri,  9 Jun 2023 08:29:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686263340;
        bh=cspuzk64MOUScPxCN7wxtwuAQeNakfDrg/bllSm7GcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=psBloCRQqdSs1UOvhFgxpHABt0ahYz5DFOLOdZ4kXvh9mTGu27mqKjt7HIcHVIfw6
         qMTrm0rTtN0PYwDHilDmnNvDbBBy9UKm8mBE3ZL1QI/LraujNMf0ft+ssHuM/mfsXt
         1B0YBg9SLMtVcOWDy/AgEJPfDrNHM37XouYHKpUV2KChp6IgkM4VuPCBG/Z5CsxOwB
         gB3Ze2bTKgZHmEn0SoQHS4rIyaK+gnKPPPlwDXUSwsBmHJ+k4Fwq4aicfDbyZ2IwZu
         OxI7C1xUcqnHQngvbGqbZMNqOn3R9wq9ejs4Y+CqhN1BGvEHOkx8tGviCtDk6vN20U
         xB5Pr/9sFs8tQ==
Date:   Fri, 9 Jun 2023 08:28:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <20230609082858.5e1b4424@canb.auug.org.au>
In-Reply-To: <20230609082722.1a7a4d12@canb.auug.org.au>
References: <20230609082722.1a7a4d12@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zrkZZ315U1JS_MmVkwtsb0p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zrkZZ315U1JS_MmVkwtsb0p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Sorry, the subject should have been "linux-next: fixes tag needs work
in rcu tree".

On Fri, 9 Jun 2023 08:27:22 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> In commit
>=20
>   df772c12508a ("selftests/nolibc: syscall_args: use generic __NR_statx")
>=20
> Fixes tag
>=20
>   Fixes: 8e3ab529bef9 ("tools/nolibc/unistd: add syscall()")
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> Maybe you meant
>=20
> Fixes: 6bff2a1e97e3 ("tools/nolibc/unistd: add syscall()")
--=20
Cheers,
Stephen Rothwell

--Sig_/zrkZZ315U1JS_MmVkwtsb0p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSCVioACgkQAVBC80lX
0Gzh6gf/TnCF1paW+mfBiLdAawfAxtTksb21zeGtcDGTyF5b/L9HfjATYgRRNUDh
3H6GjxmC6z36atNZH1SSZJkZVKDTg2SSzE+7JwComYMQbhPnyCueXm4cVkLmubqP
YKCMTjF1QJUPt5tWdBuBVKYiV4aGGKK0rRM1Uzv8FPn5nbEABbUoO92U9b8czMHE
YLBu20JtudLR1OxHEWaFK9SUxXp6fSZj91DOgDmrTMjdKkK0xmb2HqygvxvERLV0
9woGeWkqTFS85i3YD11kDsH56rUki2nKuW0/I4CabxP2tGqa04khpFyLo4Wa7Bn2
jHDFDB/yRrobnK6uEhWa/r9/VOfL1Q==
=+4uJ
-----END PGP SIGNATURE-----

--Sig_/zrkZZ315U1JS_MmVkwtsb0p--
