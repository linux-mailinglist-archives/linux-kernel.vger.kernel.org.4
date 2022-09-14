Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEB35B8682
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiINKkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiINKkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:40:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894CE58097;
        Wed, 14 Sep 2022 03:40:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sb3so4052481ejb.9;
        Wed, 14 Sep 2022 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2q8cWxTdOT7NEjEAm48iQBXKuIhQLyWS2hOWoDR0iTY=;
        b=DylVZ1TI5IYuSNnbh4HQypPHh3hxW8yETwHZ7tK0BXws5BOr1VdvOaNfaqTqAZzeSy
         iVZLHCZ4IDW5C99L/FnrJjiKqfLCxjLpBeQ2XX/4MiU2z5adY+JbdVnrjcSrrGmjyQxC
         1GX5lUGb/rcLVVkxep8ENB2iUhltpSeabSGZfHSelMzRhNFw0Eqxd3QgJ4meRdDu80BY
         UvvqwtY6zFX79xh2/VKWStJjJV8PdxE3T/E23TtdBmw1oumC8GyThADXG6uRMU3nmh6U
         FBowGk/gAa2xiyOQTjWmnQw71ItLgiUnzdIyEiGYwryC2WrB+jCu8OLyVqyKUnx/kgDg
         MXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2q8cWxTdOT7NEjEAm48iQBXKuIhQLyWS2hOWoDR0iTY=;
        b=XLLZ3Bl6QTy26NtT5rDNm9zH8C28hfCXaYorQlUuhbtxMvx2iT7VzeE1hCb1sP3+mo
         Nubh5yJPfgl9sORQkIozSw+OdEwZrSjJaA/0jTeM76Ft9l8/PHYAe2+J5msk8DkKCUZf
         +Le+aEMsRJH4YHe8CE5g+NM3uB/pWFSsf3NoMLp198AN6kXZ7+3nrleQ/wtkNw0fXkpH
         D1mBUThJ6gr2xS7tTUE35t0MRJm2db0oa7UGd/pCeqgdcCj+xm3Ho5gmFcLWljgdOfPo
         x/XtwZ63v4RljcntZsF+NucD7YJ3+TRTAwUYuXNTNPwjYTzJCEAwBi6g/ppce7cIqok+
         2tsw==
X-Gm-Message-State: ACgBeo008waOuOqMR0qK34PIQhOtj0UWCC2jMe0veiMky/On+guORIf0
        kq99px3DbmdR1cMsa/jTA4w=
X-Google-Smtp-Source: AA6agR548FPwc28DxYS445PZ5foFlZ/dWDKKUyLcm97KljK1vuY6/Kce2cqT8VdhjBo499zB+vRNZg==
X-Received: by 2002:a17:907:2cf6:b0:77b:2dd9:7cd7 with SMTP id hz22-20020a1709072cf600b0077b2dd97cd7mr13428182ejc.334.1663152009082;
        Wed, 14 Sep 2022 03:40:09 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s16-20020a1709064d9000b00772eb5e9f51sm7262675eju.118.2022.09.14.03.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 03:40:07 -0700 (PDT)
Date:   Wed, 14 Sep 2022 12:40:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, anrao@nvidia.com,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com
Subject: Re: [PATCH v2 1/4] mmc: sdhci-tegra: Separate T19x and T23x SoC data
Message-ID: <YyGvhT4bvNb55kZK@orome>
References: <20220914095628.26093-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bPE/XjzJQ2fi1dxO"
Content-Disposition: inline
In-Reply-To: <20220914095628.26093-1-pshete@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bPE/XjzJQ2fi1dxO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2022 at 03:26:25PM +0530, Prathamesh Shete wrote:
> Create new SoC data structure for T23x platforms.

Can you please use consistent spelling of Tegra194 and Tegra234 here and
in the subject? That makes it a bit easier to search for things.

> StreamID programming is one of the additional feature
> added in Tegra234 and later chips

That's a bit confusing because this patch doesn't do anything with
stream ID programming. Perhaps defer that comment to when it becomes
relevant?

Thierry

>=20
> Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 2d2d8260c681..a6c5bbae77b4 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1556,7 +1556,21 @@ static const struct sdhci_tegra_soc_data soc_data_=
tegra194 =3D {
>  	.max_tap_delay =3D 139,
>  };
> =20
> +static const struct sdhci_tegra_soc_data soc_data_tegra234 =3D {
> +	.pdata =3D &sdhci_tegra186_pdata,
> +	.dma_mask =3D DMA_BIT_MASK(39),
> +	.nvquirks =3D NVQUIRK_NEEDS_PAD_CONTROL |
> +		    NVQUIRK_HAS_PADCALIB |
> +		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
> +		    NVQUIRK_ENABLE_SDR50 |
> +		    NVQUIRK_ENABLE_SDR104 |
> +		    NVQUIRK_HAS_TMCLK,
> +	.min_tap_delay =3D 95,
> +	.max_tap_delay =3D 111,
> +};
> +
>  static const struct of_device_id sdhci_tegra_dt_match[] =3D {
> +	{ .compatible =3D "nvidia,tegra234-sdhci", .data =3D &soc_data_tegra234=
 },
>  	{ .compatible =3D "nvidia,tegra194-sdhci", .data =3D &soc_data_tegra194=
 },
>  	{ .compatible =3D "nvidia,tegra186-sdhci", .data =3D &soc_data_tegra186=
 },
>  	{ .compatible =3D "nvidia,tegra210-sdhci", .data =3D &soc_data_tegra210=
 },
> --=20
> 2.17.1
>=20

--bPE/XjzJQ2fi1dxO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMhr4MACgkQ3SOs138+
s6GIBQ//RafadWYDI+Sx2L96z9hC8zerwG/M9qu5ohqQc2Mt3pb1XzUE/lPdT/d9
rXcsOe/1YBz7KJsKnVOSCHt+paplUHTnLsZvyZPAaNsjxWD38s5bARMoVfOPJMRq
355bNDdYfZwmIdGGsMSu8Kf4CXXM2ASkhgztJwu/2mLOROJmV9jujYho6n8T+9tE
emNKSQeGQPnsjrTJkVY53cfGO9OAV8s9l1k5AbDwhE2Atw8bV8PWNsCyR+0shY3S
w26o5sCUoVKXs5mGCg4uQzY90bG0e1/R3PH8yxBj1+1aTGudeadsdn/6i+KqUFoV
LQUfV7eILj8Fv7wk+yFfIk8Qn66MyE9omR7s4ArV/IUOQAe4VoJWYiOCji5c1WyN
ozMAMZfnU6iKr5tb+FhBpwrsez3lCQ7LKM7CyYDkMGm0pIxBU+zQQDsP6SCkohAK
y5iEOXID+ww180/aB3sVNjKSNookWaR9Nffp/h96ySFzELK6PhSxOtEMKrCqDoji
wU8flrhVJYzwtzNcUh81OqYKnoOU8RU755eIpxGHZHehX8No5dZV3fNN9gCTHLeA
aPudvlmrX3uXzBrp5S0iGzxTLeA470ruC8wHczh0xu31mvsGjGMj8SSI+vEffkUa
+1hymqH51i/B3UlblSaSIeOng5CRBpXrd3uOt/nLZ+vdjaPC68I=
=dWyL
-----END PGP SIGNATURE-----

--bPE/XjzJQ2fi1dxO--
