Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5FB65944D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 03:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiL3C4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 21:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiL3C4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 21:56:36 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B142F5A0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 18:56:35 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id o8so10722407ilo.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 18:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9RtF5SUWBqaHRppCTBd3O4hwIqgQkuxR2xGhsb6MFe0=;
        b=lslruclbd0+6oJn6TRKbB15gif/gn3Wc/xtjDc2OUeEPped+hZAa5TdxiI3gXU2DJv
         EiWhvL1H7VIC0FyS2fGa9IHiWPq5lOIjZW+/JGxIbbHeoDDlfydD5jmV4hSI8LCGZT/n
         6oUA2NqmTLyo0gNscQJHpaKjSgmHXgByYYSZDexfem4seazKlr8eHeerWpiTGrQE+tkJ
         cWIaxDr+2/DDTcuQsb2anwe+feWF+FAvSIMtOO8LEnbeY7/WdLq0UfCxWjWxJOUqqGoM
         Dx7booc74EVFqoAHmSrByrKCUFFBozQGOuQVzq+J8RzKiHVs9Os+FMq8tfv3Viop6XIs
         RwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RtF5SUWBqaHRppCTBd3O4hwIqgQkuxR2xGhsb6MFe0=;
        b=nGijk6O16qHxorJyJI5MzlwzsHaajSeyTYi7EfWvDUu28woJHik87Ors6BNrND1azt
         34hcuihkh9p2m9sfcXywX+HYPvSuoZyoPJYT2fmtTccr666YVgANWlEVVOAZupBBk5iR
         Uwbdj8SAqjKdLriLVszY/VYhtUMjFzcoILSUst9G3Ea099klJ5/8H8EUgyNiOubV6XQd
         Ltb2l9mIccDwFWe9+6fw2QMYDN8FxGrU5niwHyCnczZnmW1yvGwltay+vQbrIiV7cY+S
         yx5EF5nOKGEHRLH/NIV2SbEVPRjXED0Nxfe79+GWHUhsknciBWvbFv/+YrQSFKAljeRt
         xkRg==
X-Gm-Message-State: AFqh2kphIBrXzWAKiZ3ylJkLq7k94eGbGwgSE5h07Iv5epBmlMxo6Usq
        VPKcbELzOExHp5uHjyG0KjQ=
X-Google-Smtp-Source: AMrXdXvwR3Oc+w5mvWabBOPuNPOoCu6bC6PXnmpqNnWtMYn+S1ffyue5lhjhqQ6zTcpcEW16TJCvnQ==
X-Received: by 2002:a05:6e02:e05:b0:30c:21d5:5cdf with SMTP id a5-20020a056e020e0500b0030c21d55cdfmr4551312ilk.27.1672368994681;
        Thu, 29 Dec 2022 18:56:34 -0800 (PST)
Received: from pek-khao-d2 ([128.224.252.2])
        by smtp.gmail.com with ESMTPSA id r27-20020a02aa1b000000b0039dc4d26bd2sm4176173jam.58.2022.12.29.18.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:56:33 -0800 (PST)
Date:   Fri, 30 Dec 2022 10:56:28 +0800
From:   Kevin Hao <haokexin@gmail.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH] scripts/tags.sh: Fix the Kconfig tags generation when
 using latest ctags
Message-ID: <Y65TXGzQTJ/+5Mr5@pek-khao-d2>
References: <20221229055401.855185-1-haokexin@gmail.com>
 <5e1b0401-db1e-a7a4-787c-4b93d02f5b73@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V/Y5c8o4YZu8/fyS"
Content-Disposition: inline
In-Reply-To: <5e1b0401-db1e-a7a4-787c-4b93d02f5b73@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V/Y5c8o4YZu8/fyS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 29, 2022 at 02:33:15PM +0200, Cristian Ciocaltea wrote:
>=20
> On 12/29/22 07:54, Kevin Hao wrote:
> > The Kconfig language has already been built-in in the latest ctags, so
> > it would error exit if we try to define it as an user-defined language
> > via '--langdef=3Dkconfig'. This results that there is no Kconfig tags in
> > the final tag file. Fix this by skipping the user Kconfig definition for
> > the latest ctags.
> >=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >   scripts/tags.sh | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/scripts/tags.sh b/scripts/tags.sh
> > index e137cf15aae9..c56b13ae3fdf 100755
> > --- a/scripts/tags.sh
> > +++ b/scripts/tags.sh
> > @@ -264,10 +264,12 @@ exuberant()
> >   	--$CTAGS_EXTRA=3D+fq --c-kinds=3D+px --fields=3D+iaS --langmap=3Dc:+=
=2Eh \
> >   	"${regex[@]}"
> > -	setup_regex exuberant kconfig
> > -	all_kconfigs | xargs $1 -a                              \
> > -	--langdef=3Dkconfig --language-force=3Dkconfig "${regex[@]}"
> > -
> > +	KCONFIG_ARGS=3D""
> > +	if ! $1 --list-languages | grep -iq kconfig; then
> > +		setup_regex exuberant kconfig
> > +		KCONFIG_ARGS=3D"--langdef=3Dkconfig --language-force=3Dkconfig ${reg=
ex[@]}"
> > +	fi
> > +	all_kconfigs | xargs $1 -a $KCONFIG_ARGS
> >   }
>=20
> The 'regex' array needs quoting to prevent word splitting/globbing.

Fair enough.

> I would
> suggest to transform 'KCONFIG_ARGS' into an array as well:

Sounds great. V2 is coming.

Thanks,
Kevin

>=20
> KCONFIG_ARGS=3D()
> if ! $1 --list-languages | grep -iq kconfig; then
> 	setup_regex exuberant kconfig
> 	KCONFIG_ARGS=3D(--langdef=3Dkconfig --language-force=3Dkconfig "${regex[=
@]}")
> fi
> all_kconfigs | xargs $1 -a "${KCONFIG_ARGS[@]}"
>=20
>=20
> >   emacs()

--V/Y5c8o4YZu8/fyS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmOuU1wACgkQk1jtMN6u
sXEnlQf/Z8WDmHpzGfxDOdDP7z8nxoq+RR9f1R2LkeQg085MTAYa2V9IbNUAnsVe
DSo/3ZYhBZ9LPZjEvSRdp9qkOO9zvmJTy68myO4515bLWG56WF0w8jI/XqsbDIiI
nELY5ZLVxw2oUzUrTlBandtHMRudOpsMiHrmmoS07aiy4v8pSBCEUGg1dBZ2r05d
GLQYbQ2ptNG27LgpeElcCPJHUgLPZeRLRckZay/W8blO8G5o1e7lWzfQ4/j7HikC
GhBqQ2pyA1xNotI0UafLpmOGZTBS1dOJrYkrvu+gPILKoziBlRDP8jaopCETq3XJ
EzNxBwNdBb411Tpx+06Vz0A5IBEOBg==
=Tx68
-----END PGP SIGNATURE-----

--V/Y5c8o4YZu8/fyS--
