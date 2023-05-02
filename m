Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB406F41AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjEBKcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjEBKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:32:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBE75273;
        Tue,  2 May 2023 03:30:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-956ff2399b1so747256666b.3;
        Tue, 02 May 2023 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683023414; x=1685615414;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoz9JAbN5f+BVMAIJU5OP6UpMSWt3PXfSC9zASQ8+H0=;
        b=qPJ2Hw6amNfB8lmXOrdvIl9FoT5xySIqwZYWNum7nfccE3LyonUmxVC4xvOcGkIACz
         307kXPO/NEqxiW/gL534TetAjXFMoxa712gCWzKQ9ryZyTyQGMomA1FstyAd9rudnxDJ
         7fxgC6AH+COjiSwLoolMULeoK+VOXPx+4clNKCXfmDkRZ6m4hSGBl+TNH9oRewB4vJ7s
         GGDFrB5+hrF9djGr072zaTtShx1WWAkMkalYHIxnaA/YwcHurRqoQVgEEGcgHzSDCIV5
         TcF93MCyDjYjmn8HxsAncCUR7fkPNCJmvVqGqCCZtOSZA9/R8phHp/VwRwXcb4ea7wMM
         ejrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683023414; x=1685615414;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoz9JAbN5f+BVMAIJU5OP6UpMSWt3PXfSC9zASQ8+H0=;
        b=gcGVJyfRTWBVUL0f08RkYXuHH1NBWUH2YB1Fis8XfVFwAEUOJ6nW8mBf0E4Tqt5G9G
         mQFCADBwfhiHM9W2KtheliLn1y3HFPOQw8PymzWvCfoCzjyT9XVIViN4nB54JOr4MvA8
         wXS83Ruckb1wHrZ/RFl4JUDfQ3VFkcFYmxq6ecu7SDq7xLrOG6uc6htPylPAWIs/oyD1
         eOAfAy6ubMwuXULdHicAsC1Q+hug630Og1h7tnwcJARt+E2FG4bdy3PKt16xnoJcOIS2
         Cmg3rFVPAtlvLlYDYReNGJU8PCIHVfBB2Vjcq3+q+gdU4duyv5kS6p8U8NiNDU7py5T3
         U0Jg==
X-Gm-Message-State: AC+VfDzGE23YqpQJwx3aKVBw+jdUi1sU9M7Mgbcm/k0qSvIwZ/XPYKWr
        MMR+2tSB+gGzqUMa+PzqksU=
X-Google-Smtp-Source: ACHHUZ6YZ5pgw9VrLJ2fqMsSEx0tEiCLwIYXUGSFpKeEuP8/APOwu3MjFq79vENWW/sdJ/Brfn0IHw==
X-Received: by 2002:a17:907:94cc:b0:948:b9ea:3302 with SMTP id dn12-20020a17090794cc00b00948b9ea3302mr15065573ejc.1.1683023413633;
        Tue, 02 May 2023 03:30:13 -0700 (PDT)
Received: from orome (p200300e41f053a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f05:3a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906c40d00b0094aa087578csm16154555ejz.171.2023.05.02.03.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 03:30:13 -0700 (PDT)
Date:   Tue, 2 May 2023 12:30:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] cpufreq: tegra194: Fix an error handling path in
 tegra194_cpufreq_probe()
Message-ID: <ZFDmMydAy4CiJjfQ@orome>
References: <30b17e2219abc3a9a137d28bb51e53732bba5103.1682428267.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gK1WG8+Pg3vMnVql"
Content-Disposition: inline
In-Reply-To: <30b17e2219abc3a9a137d28bb51e53732bba5103.1682428267.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gK1WG8+Pg3vMnVql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2023 at 03:11:19PM +0200, Christophe JAILLET wrote:
> If the probe needs to be deferred, some resources still need to be
> released. So branch to the error handling path instead of returning
> directly.
>=20
> Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidt=
h")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra19=
4-cpufreq.c
> index c8d03346068a..36dad5ea5947 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -686,8 +686,10 @@ static int tegra194_cpufreq_probe(struct platform_de=
vice *pdev)
> =20
>  	/* Check for optional OPPv2 and interconnect paths on CPU0 to enable IC=
C scaling */
>  	cpu_dev =3D get_cpu_device(0);
> -	if (!cpu_dev)
> -		return -EPROBE_DEFER;
> +	if (!cpu_dev) {
> +		err =3D -EPROBE_DEFER;
> +		goto err_free_res;
> +	}

I think ultimately it'd be better to try get_cpu_device(0) earlier so
that we don't do all that work upfront before we fail. However, it looks
like there's some other improvements that could be done in that area, so
this looks like a good fix in the meantime:

Acked-by: Thierry Reding <treding@nvidia.com>

--gK1WG8+Pg3vMnVql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRQ5jMACgkQ3SOs138+
s6G2Wg//TRLHO0MURhGFW5IfnB5xXcvKaHVeurXxBdRWI4KuA8CQv5+2plHnEci6
BlU7+GHpOB+3Ch+bfnUVuhFN4WleYecoD69FS9GxwLaYukg7R7ynqVhYX/tccT1w
lzkZFUzYqrJMxY4ZAKMD14PmnY7tm/DFQO8Ht7Iu1DWKCRVZTd1udfXpqw4z8spc
ndm1uxVz3d2ojvkhevIWOpHYpsCXgbzYMasi1lHpbui/RGUyr6JE1L2CY23+Ne4s
KcF/QrhXWRXs6+s40Xi7rQrAgtj/evq0wOlly/YGLBtP4mKpQB1T/o8MlF0NfW3x
iQoKEAfBIbmOYodXCYjrZvj8ftq7pOtQbzXWW67wzjOxyDuXc/j2XVodHdoDtJ+0
VSabbpTT+RQsXDM61RxBqeH56mXl6TpJaBLL/reh6BVRESmTPfaqXOkw12BXLYhZ
IHDOfbuXvHAT1fhJjOWj2yxiqOhwcsIJVIyQlrBfUIjjf1AKOkaUGgiO4jffHjSG
uYyglby74dbDWqLXnotxaMpSNRSCY94kxEw99p2MtsAb/HTOzCpw2SX/PGBePjwI
XJCyZ54FOIBBvi+0LBZhjbDitkbILO0zvPZ6etx99jFC2ZRndIqLks22WO/B0h34
mHYcuakHBmhjbnPK+Yt8YbNQtgUo2O401FTHT/Cm78Y5vYybem4=
=WBsp
-----END PGP SIGNATURE-----

--gK1WG8+Pg3vMnVql--
