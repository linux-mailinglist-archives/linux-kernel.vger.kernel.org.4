Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A70702467
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbjEOGVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjEOGU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:20:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9251C1722
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:20:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24e14a24c9dso8831635a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684131656; x=1686723656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LARrOAVaP/IDsHol71+sHhGKO46uV2gVn9ak5k+kCUc=;
        b=cRawtnnAvP3xdFTpW6rRrEfDiSezeNJ24x6dAszCC/CIpcTae9eFRbEwoSYdjAmgHd
         hXH2QAPtGXvS6DbPRy1j1b79Vxlf+cXddpRQN3tOaXiwxVfSz0Ir3yTIUqJFYzc0Oafs
         jobJb12cYBuM0tT6/6cI86NscTYeqQM23ULp+4wL0tmTsVlb6O7syRucvOB0a66WwoRI
         kvOrgEtJaC1hfUkvfppKLdZVH7AbfsElENjs+7IGbx40IioldKHrCUne0QgTnAL/8qGx
         gh9NUkbd1ZT6K6liWFmh54ztMmfPy6r8mM8olOtdbzGVambg/1xGi1LrDkpaDT/1VZWS
         wB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684131656; x=1686723656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LARrOAVaP/IDsHol71+sHhGKO46uV2gVn9ak5k+kCUc=;
        b=GPmRLUIxckxemud6mlKUyLt5e/YShTIrEL5vQCZjkXWDwDVsn/t/o+sktg4QQWGzga
         yaN0mh5OWZN7wF+eH5DCCr6jVL/fSnAiURV5SXWPpxtXoU1j7i8Wf4+Ekl06j+ehTXtn
         HfJ9sPyHVHfYCeIiipeNuODM3dzHY8ny4Bk90NpDX7lzSTN2qsJ4kWsigHlu9dJ6dKFb
         RoYUJ7yIqIH4atcpEWTUofyN32QPxOiYf+EV26k7P9PzQ+w/S2px7NfbgAU/NmyVCMUl
         sXlxUFA4q1w7airRPIetIr854V1EmfLEOc1sdoIoe0TQYShTiyMBWLB5jdoc83bLGX/W
         /miA==
X-Gm-Message-State: AC+VfDwKxASUvqrHnhFCsZFUHn5rbjUpDtQNvA71j3JnoYLMrvy+cEzI
        ZiD97Yb9elA2fd4GTUNBHnqeja0ueFQ=
X-Google-Smtp-Source: ACHHUZ5vryoMACtnCkOhDjDk6g1xo3zm/ryLFdrhS2un9KrOLPcTI9EDNONuPoCeMaG1ff+IXIIqbg==
X-Received: by 2002:a17:90a:c245:b0:250:69e4:9ed2 with SMTP id d5-20020a17090ac24500b0025069e49ed2mr24851178pjx.48.1684131655815;
        Sun, 14 May 2023 23:20:55 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-77.three.co.id. [180.214.232.77])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090ae50f00b0024b9e62c1d9sm10487244pjy.41.2023.05.14.23.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:20:55 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 69BFB10697E; Mon, 15 May 2023 13:20:52 +0700 (WIB)
Date:   Mon, 15 May 2023 13:20:52 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     liming.wu@jaguarmicro.com, will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com
Subject: Re: [PATCH] perf/arm-cmn: fix compilation issue
Message-ID: <ZGHPRHj1gb3tPR9C@debian.me>
References: <20230515012930.946-1-liming.wu@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H2fnbjCMW2orwer3"
Content-Disposition: inline
In-Reply-To: <20230515012930.946-1-liming.wu@jaguarmicro.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H2fnbjCMW2orwer3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 09:29:30AM +0800, liming.wu@jaguarmicro.com wrote:
> From: Liming Wu <liming.wu@jaguarmicro.com>
>=20
> This patch is used to fix following compilation issue with legacy gcc
> and define variables at the beginning of the function

What GCC version?

>=20
> error: =E2=80=98for=E2=80=99 loop initial declarations are only allowed i=
n C99 or C11 mode
> 2098 |                 for (int p =3D 0; p < CMN_MAX_PORTS; p++)
>=20
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> ---
>  drivers/perf/arm-cmn.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 47d359f72957..2299fcde5b4a 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2009,8 +2009,11 @@ static int arm_cmn_discover(struct arm_cmn *cmn, u=
nsigned int rgn_offset)
>  	u16 child_count, child_poff;
>  	u32 xp_offset[CMN_MAX_XPS];
>  	u64 reg;
> -	int i, j;
> +	int i, j, p;
>  	size_t sz;
> +	void __iomem *xp_region;
> +	struct arm_cmn_node *xp;
> +	unsigned int xp_ports;
> =20
>  	arm_cmn_init_node_info(cmn, rgn_offset, &cfg);
>  	if (cfg.type !=3D CMN_TYPE_CFG)
> @@ -2067,9 +2070,9 @@ static int arm_cmn_discover(struct arm_cmn *cmn, un=
signed int rgn_offset)
>  	cmn->dns =3D dn;
>  	cmn->dtms =3D dtm;
>  	for (i =3D 0; i < cmn->num_xps; i++) {
> -		void __iomem *xp_region =3D cmn->base + xp_offset[i];
> -		struct arm_cmn_node *xp =3D dn++;
> -		unsigned int xp_ports =3D 0;
> +		xp_region =3D cmn->base + xp_offset[i];
> +		xp =3D dn++;
> +		xp_ports =3D 0;
> =20
>  		arm_cmn_init_node_info(cmn, xp_offset[i], xp);
>  		/*
> @@ -2095,7 +2098,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, un=
signed int rgn_offset)
>  		 * from this, since in that case we will see at least one XP
>  		 * with port 2 connected, for the HN-D.
>  		 */
> -		for (int p =3D 0; p < CMN_MAX_PORTS; p++)
> +		for (p =3D 0; p < CMN_MAX_PORTS; p++)
>  			if (arm_cmn_device_connect_info(cmn, xp, p))
>  				xp_ports |=3D BIT(p);
> =20

Is above manually tracking xp* variables?

I'm confused...

--=20
An old man doll... just what I always wanted! - Clara

--H2fnbjCMW2orwer3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGHPRAAKCRD2uYlJVVFO
o4sjAQCp49jf7V3MjKpce1LZwM/YKQbpqc5FWg36EPVfX+fFiwEAuXOHihstoHRW
Vm+NdnITZUtgCY/YQE5pw7JGFQVk1wA=
=TmGt
-----END PGP SIGNATURE-----

--H2fnbjCMW2orwer3--
