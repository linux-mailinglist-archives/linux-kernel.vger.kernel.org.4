Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2E35F6496
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiJFKwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJFKww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:52:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7140C98C81;
        Thu,  6 Oct 2022 03:52:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m3so2182054eda.12;
        Thu, 06 Oct 2022 03:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=t8o+pyb3f/qVg1V7tg8SlbaPQuVD9Bud8eOgYKBOp4E=;
        b=PU4TSIObQFqDgBqfJKx3R+EN14v0wZRDC18pHhIxXNyT5jZM9YKoz/EMDN4L/8WWWm
         nsi9XARo88knP8q83F2/170w+J81+GeGO7Cbaq9bpJEAFRlKGdQQ++WbmGXSp00xqE/w
         I/SKa0fr6nPKzN0n93r/QbniURE7kyiO2t/GCPPmbGor7pgEVTVogaBX3zj0izW5SF3C
         WjH+ZpJZTfPWL/ReGKyWZT3PZeYXmFgtxKtYUuJisbZvtO5crJeMptWZvQar+ZZAruRm
         19kjpTPDvEEJ6eBzeoKoHo/DJVxxwgYtP3v8JcaVjAJxfNy2zZIjeWyLine0SmM8+drn
         ejeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=t8o+pyb3f/qVg1V7tg8SlbaPQuVD9Bud8eOgYKBOp4E=;
        b=4tGG3y+cQcLw+ApnpNE9T0fLMj6wmt1x00tQ6hjd1PKI6E83Hj43xzejQi1GcjgZZ8
         2QQjZGkXvRQBbf8wneQJUh2qDsfjH2sx+XbJEq9TRp0qvYi2JuXvcKtCvaJJ/b4Iil8m
         t3OJQdZ/5SI6NGiaIYWwbTGRsS+DlUTmMsBKT0CySQSlXeMhFIL0V35H7dKlz4e9Bm09
         qCFcYXxyVnegpi0tGV45fO4XMAcV6oqMFzC800/iogyKBy2yAQ35BhKv2Z0zV5a81C2n
         FFUgi2WYzgqu8OIQT7Kc5fxhLYsyishZEnGEqHHJDF9aj8jqHEMvqqremfYw1LBpeW39
         AXnA==
X-Gm-Message-State: ACrzQf1MUrr4mbnCdqfPIowfALps/OW8/RT5vI+Cb+Lj3gjSSWGc30lQ
        siXssSN/dCGh833tFnAaTXQ=
X-Google-Smtp-Source: AMsMyM77X4RBaOSUIWqFPbX5N1+nuYY8E3lKPOxSOVSjz5WtuDU/HxX572kvNnKY7tGQNBY1TGeiBQ==
X-Received: by 2002:a05:6402:34cf:b0:459:f9c5:7795 with SMTP id w15-20020a05640234cf00b00459f9c57795mr624566edc.160.1665053569839;
        Thu, 06 Oct 2022 03:52:49 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o25-20020a170906769900b007829fb46a0esm10243994ejm.142.2022.10.06.03.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 03:52:48 -0700 (PDT)
Date:   Thu, 6 Oct 2022 12:52:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Prathamesh Shete <pshete@nvidia.com>
Cc:     ulf.hansson@linaro.org, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
Subject: Re: [PATCH v6 2/4] mmc: sdhci-tegra: Add support to program MC
 stream ID
Message-ID: <Yz6zfrVq9cP/wrJb@orome>
References: <a5c231e8-f28a-e692-5961-58e6838711ed@intel.com>
 <20220928125648.19636-1-pshete@nvidia.com>
 <20220928125648.19636-2-pshete@nvidia.com>
 <34f002a4-b811-106b-52b5-6041674b15e9@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GYjMp6IFoAg2M0P0"
Content-Disposition: inline
In-Reply-To: <34f002a4-b811-106b-52b5-6041674b15e9@intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GYjMp6IFoAg2M0P0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 05:18:19PM +0300, Adrian Hunter wrote:
> On 28/09/22 15:56, Prathamesh Shete wrote:
> > SMMU clients are supposed to program stream ID from
> > their respective address spaces instead of MC override.
> > Define NVQUIRK_PROGRAM_STREAMID and use it to program
> > SMMU stream ID from the SDMMC client address space.
> >=20
> > Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> > Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
>=20
> One observation below.
>=20
> Nevertheless:
>=20
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>=20
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 44 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >=20
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-te=
gra.c
> > index a6c5bbae77b4..60ce3e80f248 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -25,6 +25,10 @@
> >  #include <linux/mmc/slot-gpio.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/ktime.h>
> > +#ifdef CONFIG_IOMMU_API
> > +#include <linux/iommu.h>
> > +#include <linux/bitops.h>
> > +#endif
> > =20
> >  #include <soc/tegra/common.h>
> > =20
> > @@ -94,6 +98,8 @@
> >  #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
> >  #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
> > =20
> > +#define SDHCI_TEGRA_CIF2AXI_CTRL_0			0x1fc
> > +
> >  #define NVQUIRK_FORCE_SDHCI_SPEC_200			BIT(0)
> >  #define NVQUIRK_ENABLE_BLOCK_GAP_DET			BIT(1)
> >  #define NVQUIRK_ENABLE_SDHCI_SPEC_300			BIT(2)
> > @@ -121,6 +127,7 @@
> >  #define NVQUIRK_HAS_TMCLK				BIT(10)
> > =20
> >  #define NVQUIRK_HAS_ANDROID_GPT_SECTOR			BIT(11)
> > +#define NVQUIRK_PROGRAM_STREAMID			BIT(12)
> > =20
> >  /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
> >  #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
> > @@ -177,6 +184,9 @@ struct sdhci_tegra {
> >  	bool enable_hwcq;
> >  	unsigned long curr_clk_rate;
> >  	u8 tuned_tap_delay;
> > +#ifdef CONFIG_IOMMU_API
> > +	u32 streamid;
> > +#endif
> >  };
> > =20
> >  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> > @@ -1564,6 +1574,7 @@ static const struct sdhci_tegra_soc_data soc_data=
_tegra234 =3D {
> >  		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
> >  		    NVQUIRK_ENABLE_SDR50 |
> >  		    NVQUIRK_ENABLE_SDR104 |
> > +		    NVQUIRK_PROGRAM_STREAMID |
> >  		    NVQUIRK_HAS_TMCLK,
> >  	.min_tap_delay =3D 95,
> >  	.max_tap_delay =3D 111,
> > @@ -1775,6 +1786,25 @@ static int sdhci_tegra_probe(struct platform_dev=
ice *pdev)
> >  	if (rc)
> >  		goto err_add_host;
> > =20
> > +	/* Program MC streamID for DMA transfers */
> > +#ifdef CONFIG_IOMMU_API
> > +	if (soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
> > +		struct iommu_fwspec *fwspec;
> > +
> > +		fwspec =3D dev_iommu_fwspec_get(&pdev->dev);
> > +		if (fwspec =3D=3D NULL) {
> > +			dev_warn(mmc_dev(host->mmc),
> > +				"iommu fwspec is NULL, continue without stream ID\n");
>=20
> It will still program a zero streamid upon resume.

This was confusing to me, but I think what you mean is that the check
for fwspec =3D=3D NULL should also be done in sdhci_tegra_resume().

>=20
> > +		} else {
> > +			tegra_host->streamid =3D fwspec->ids[0] & 0xff;
> > +			tegra_sdhci_writel(host, tegra_host->streamid |
> > +						FIELD_PREP(GENMASK(15, 8),
> > +						tegra_host->streamid),
> > +						SDHCI_TEGRA_CIF2AXI_CTRL_0);
> > +		}
> > +	}
> > +#endif
> > +
> >  	return 0;
> > =20
> >  err_add_host:
> > @@ -1861,6 +1891,10 @@ static int sdhci_tegra_suspend(struct device *de=
v)
> >  static int sdhci_tegra_resume(struct device *dev)
> >  {
> >  	struct sdhci_host *host =3D dev_get_drvdata(dev);
> > +#ifdef CONFIG_IOMMU_API
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	struct sdhci_tegra *tegra_host =3D sdhci_pltfm_priv(pltfm_host);
> > +#endif
> >  	int ret;
> > =20
> >  	ret =3D mmc_gpio_set_cd_wake(host->mmc, false);
> > @@ -1871,6 +1905,16 @@ static int sdhci_tegra_resume(struct device *dev)
> >  	if (ret)
> >  		return ret;
> > =20
> > +	/* Re-program MC streamID for DMA transfers */
> > +#ifdef CONFIG_IOMMU_API
> > +	if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_STREAMID) {
> > +		tegra_sdhci_writel(host, tegra_host->streamid |
> > +					FIELD_PREP(GENMASK(15, 8),
> > +					tegra_host->streamid),
> > +					SDHCI_TEGRA_CIF2AXI_CTRL_0);
> > +	}
> > +#endif

So this here should be exactly the same as in sdhci_tegra_probe(). Which
would be an argument for putting this into a separate function.

That said, I'm not sure if this matters at all. If fwspec =3D=3D NULL, that
implies that device tree didn't have an "iommus" property, which also
implies that SMMU translations for this device will not be enabled at
all, if I recall correctly, so whether this CIF2AXI_CTRL register is
programmed or not in that case should be irrelevant.

Still, might be good to keep this the same in both sdhci_tegra_probe()
and sdhci_tegra_resume() for consistency.

With that fixed, the series:

Acked-by: Thierry Reding <treding@nvidia.com>

--GYjMp6IFoAg2M0P0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM+s3wACgkQ3SOs138+
s6EQeg//bDHPfg9KdsFStVnvP7sP/AtLWVOwl08YsFNGLAb1U6hT+lLyVkXPBw/K
zfWcP6Mg2r3mlpqRCN2rlA2B1XYPg9OIkVetZ89rOyIeOV/n/9oRbjlzqYSPqwL4
e0SNOIwGWPI84LYgSkHXi1f+wa8/XkVM2WZx/YNJR7RXVwHpourFog/va+0cq6wX
dfU6YAU6ragHdu83sJxc72VFnDLqRRmFhu3lnisO3vkWwWR2mBubj7a5Liha7Jkc
Uu9JPRtcS40BX7mlZFGA1M0ZltCB24cLCNkoLUlzlSzkLAXURvsBtZMdJwQzAj9N
t/QibHe4096yB+rP5V5O5sZzM9aTjD5KRpqbiQM/EOi/Y0orQUM6y0UhEWJF4s6V
n7fLxV/Ww9SzDSwwfPoPQylY40Adb69vDhzDxCvCa9lBjotf0iz1oiJGFZmAG41U
vD2NzIdcLX+oVx1uVfv+ZmytaKCFFtwrLmu7bsH3bNr3RoIPrWXO5vVnmvKQmyJy
IaygKAsXWac+gRvlX3yE4svgrOQ4b4XD47w4Mf6mZBzAgzpzSVVgJ3AOpxqNQw5o
ftCShW+l6mkp8NlgzEKzx2+XN/G7pPV3LFvTAbqIZWukBoSqOT5S4Egly+7ZEB39
gHgeka78NJPf2jIij0yclTiCMxT6xkEbZzGS+fnbmetvduNwMh4=
=p3hS
-----END PGP SIGNATURE-----

--GYjMp6IFoAg2M0P0--
