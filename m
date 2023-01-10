Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D849663877
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjAJFIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjAJFH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:07:57 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1CE1CB37;
        Mon,  9 Jan 2023 21:07:49 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.97.169]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MS3r9-1pMRH510xf-00TTj4; Tue, 10 Jan 2023 06:07:16 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id EB5363C0CA;
        Tue, 10 Jan 2023 06:07:13 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id B9D62311; Tue, 10 Jan 2023 06:07:11 +0100 (CET)
Date:   Tue, 10 Jan 2023 06:07:11 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        corbet@lwn.net, cristian.ciocaltea@collabora.com,
        gregkh@linuxfoundation.org, vipinsh@google.com,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] scripts/tags.sh: choose which directories to
 exclude from being indexed
Message-ID: <Y7zyf+d6JSPUsIDt@bergen.fjasle.eu>
References: <Y7SKBqxULPofEry7@mail.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KFxLv6UZoDjtwEPS"
Content-Disposition: inline
In-Reply-To: <Y7SKBqxULPofEry7@mail.google.com>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:q6indz7A98W6UrJv1GbsvbIAX9Z7z1Kks6ZWm4aDpR651pFkWBo
 o07uRYCoN/BUM9RYBbpunTMGKkHhlzAlXC7HClFP1Wef8yLTwNs9paxQ+qwnV/Ryk8RVhnZ
 I67erprlGi9ADXlHv506UE0ECp0kAh9QA6oJr4NTD6SxdIZL0P7IObqr65YNmT6G9OZjSVC
 vnoXGFFpTGl0R0yDkI6Qg==
UI-OutboundReport: notjunk:1;M01:P0:+WS8Rt0i9bc=;Pd1WHsE/X+g+O5KNw+cPoKbLX4a
 VvBB+WnLfXqx1U3UG3jjqiaBu5x2aY1rGpUYayiUyGGCPXUSqnCseQdxEOMxW8cpmOU9w15yT
 4qZINzJWT+zO6FmvMwAiV7BMYK6YRYUSP3sx/HhNfekQS5KMPPoWt4d+QpdwVk3ovpnBkaTqu
 CQ2xuTZpzU77BHE0ibD6WGKJfFerejSD4uvSYy8IBslRcbV8adKUs0qSblQpCiPyUP9yJ2TWP
 Hkwvsw9M9Ej0MZiJ2xI+uEz9A5F4hZk/RWyhGHzS55OAdBBXyArjjtLykh1m0dYeU90nATX+M
 OcICqxDMo6xGyqTBXO1/Q0DfOQ4SzNw9Ef8FR1h06VGD7CqHLJD49I48/o1Nenp7sTRvg76NR
 1woIQ3pDirjGZJ+nOverPzZ+7PRpUSshodVdP1O9jt9sR4G6FcPa7r/HGtqPUdZHQPa5o/5mS
 dAptEUWy8z0mpmvSXI+QYFOJDz977OmiXYPP4zGgCvPb+h1m9lr6kk5uzZJ870tsSIxm4zkko
 dJ2HkN6YVF3fi5XferEprwT84FoT8ZC6zoSqbvl6GsPOa2CfJHQbfP9w3oLPZTTamj5fOvib1
 DRTxv3hSmPUiakgoLDTFBgzPY0QKPralAQ0wLY8h/QvmAkuiisrk88CKekzHEabdinUaCtM6z
 FRRRgg1VLO5TvwBklF6DpTJvjTPOc4unoH1SsCdAdQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KFxLv6UZoDjtwEPS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 04 Jan 2023 09:03:18 GMT, Paulo Miguel Almeida wrote:
> It's common for drivers that share same physical components to also
> duplicate source code (or at least portions of it). A good example is
> both drivers/gpu/drm/amdgpu/* and drivers/gpu/drm/radeon/* have a header
> file called atombios.h.
>=20
> While their contents aren't the same, a lot of their structs have
> the exact same names which makes navigating through the code base a bit
> messy as cscope will show up 'references' across drivers which aren't
> exactly correct.
>=20
> Add IGNORE_DIRS variable, which specifies which directories
> to be ignored from indexing.
>=20
> Example:
>         make ARCH=3Dx86 IGNORE_DIRS=3D"drivers/gpu/drm/radeon tools" csco=
pe
>=20
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.c=
om>
> ---
> Changelog:
>=20
> - v3: change commit message wording and rst syntax (Req Bagas Sanjaya)
>       change makefile variable scope to global, use blank space
>       separator and change variable name to IGNORE_DIRS.
>       (Req: Vipin Sharma)
> - v2: change approach to include everything unless specified by the=20
>   IGNOREDIRS variable: (Req: Vipin Sharma)
> - v1: https://lore.kernel.org/lkml/Y5OKDvbGk4Kro6MK@mail.google.com/
>=20
> Additional notes (if relevant):
> - Patch v3 was reviewed-by Vipin Sharma here:
>   https://lore.kernel.org/lkml/CAHVum0eNp5Dup_KyrS2N0zu5TfrtcCxphRnLuBFZa=
5PxahVg7A@mail.gmail.com/
> ---
>  Documentation/kbuild/kbuild.rst | 7 +++++++
>  scripts/tags.sh                 | 7 +++++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuil=
d.rst
> index 08f575e6236c..5202186728b4 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -278,6 +278,13 @@ To get all available archs you can also specify all.=
 E.g.::
> =20
>      $ make ALLSOURCE_ARCHS=3Dall tags
> =20
> +IGNORE_DIRS
> +-----------
> +For tags/TAGS/cscope targets, you can choose which directories won't
> +be included in the databases, separated by blank space. E.g.::
> +
> +    $ make IGNORE_DIRS=3D"drivers/gpu/drm/radeon tools" cscope
> +

Thanks for the patch!

I think it might be good to add a note about that this is not ignoring=20
arch sources (here and in the commit message).  For kbuild.rst perhaps=20
something like: "For filtering-out sources below arch, see=20
ALLSOURCE_ARCHS above."

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--KFxLv6UZoDjtwEPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmO88nkACgkQB1IKcBYm
EmkXwg//W6rxak5P/dyiiBoZ5nyGyi7VIwwz5G7f+1fo7jWqb8ao9i5Y0qczgVFL
7yhZvTWpBP5SBjEgifud+GYyCFND5rLLIPmQlBnN+Iv5yjuo7wOSfG1Mce98ANK4
CHydVZ32NtHjMsM5svwpvyJ7uOppBXIc2uANHSK4devVl4FcwFi1PibVDto3o2+W
IPgTbN2k9BNMyMc4CVrjjW2MyEDYIc8ckuv7voMZXUKOtIutnm0TEC95dorrDCmS
8EvzwT7WY4cMOYnL4/+EwUNaDdBUq1PwwmNf7FjgCFNIb8YZIYMINpUSKH6kLaml
rjen7As/hWwxMd28m06LhyDzTvkmU47WYyp/0k0aTscLWAcHN1QZzlejNQcIQt3s
iTuTrB5drlboL1G/Zu+IEDq7aDeImT+oVEGhZ6JQO1FNAiWPUMtSBTPxb9ez5P1j
EeuMoBicyymgWmwosJ+EfEjYgxp7MAB0zTHG9T9Osal7rcKSuG7iSRxQLChhZOj3
RalknxFYtT/vetdu0SR96pCkdvmqiB1U0hvjo7q5P5ltN8Pf2IDzjrytMPF4OwpG
g8CcC6OICBKPNOi1v/OziOk3pEME+fkLk6ACZW4E0L6BwO8SBs5D0PI4iH44zpql
NGnAkHvxyFhMSwYHBag9jn3vc5s1ecjlo2EEW5f9WWBBrF04bdQ=
=uoTl
-----END PGP SIGNATURE-----

--KFxLv6UZoDjtwEPS--
