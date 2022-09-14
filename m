Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D56E5B87E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiINMLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiINMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:11:40 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711FB2B614;
        Wed, 14 Sep 2022 05:11:38 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id g12so10539074qts.1;
        Wed, 14 Sep 2022 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MWI6ksoWEvGKKGInpG97Zb5wVLWjuPxRovchnQ7RsgA=;
        b=kKP1Lk1I30g6xZ2cNiXfYOWOWBlE+p5AeJfoBRIwMIBA04jPu/gv84KCYkzhD/BQal
         nI3yBzoXUKpNbIy8q+aEC7zBN6hKtocA6vZh0449ujR6MecPYj+fhEsMiSOhAQokmlZM
         pmaX5I2Jqb1otNacfAoe7kGFCvD9L7Ui8D43W4lLpOcQt+qYe5ZXuehC/GyMAfweJhCO
         0Dv4E5dddaeYsNHj5+rJmGvKl9Zbzq2lbhiWxcJeKhN5pgZTWkfdY4vlxbIrFVXEfKgx
         Y+9g0a8bEXndjzbqy06qtqPBvKpjwps1ykZwZ62RsF9rlyDJRFG7ltivdijnmuMCPEvo
         wrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MWI6ksoWEvGKKGInpG97Zb5wVLWjuPxRovchnQ7RsgA=;
        b=CZ7kooO7GQgCgwgzIjanQhxVj7wgkZ8RElvCjU+57UbdItOQUHvQ4EwAasw9v/6+OI
         oLFcuKNvZfJAz81EYiakvhinKWktFPb0tvS2f7GMar77LRG56Pfd9lGK6MvmG8REOikY
         tapU9m2m7Bq+31u8MwsrVgEKFJHnFVVYl1eJD+Cl38g3+1jAeHQPlxyfihT2gZxrYXVb
         WB4gE96H6U6jaJjMkkPEJjXHdnSu/JDPqS+n6+6UM0DGKH4foO7tq/dFQq/MQHmPN8zj
         S6mc3VswZJEeO1uhHi50vCbjFDdAl/ZyOgW/tvVL02ayzELS8Gw+Ib26bOHaBqRFh9eo
         RoIw==
X-Gm-Message-State: ACgBeo0UzQ9/kDFXP2Yhllz9FbXY0MCIexOv0QipHRwOm3g8IkwJczI8
        hL06X0sQDMs4aRyMqASn/f8=
X-Google-Smtp-Source: AA6agR7veKDRhklijiXZjy8uqnbrvyeEqF5YFSFrdTNbG4I1dhQW7MDwZdPQfJqdTGvN+H86r/gtkQ==
X-Received: by 2002:a05:622a:1304:b0:35c:b77b:73b6 with SMTP id v4-20020a05622a130400b0035cb77b73b6mr4669413qtk.498.1663157496528;
        Wed, 14 Sep 2022 05:11:36 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id j26-20020ac874da000000b0035a70a25651sm1432429qtr.55.2022.09.14.05.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 05:11:35 -0700 (PDT)
Date:   Wed, 14 Sep 2022 14:11:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, anrao@nvidia.com,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com
Subject: Re: [PATCH v2 2/4] mmc: sdhci-tegra: Add support to program MC
 streamID
Message-ID: <YyHE86HI43lPcQQr@orome>
References: <20220914095628.26093-1-pshete@nvidia.com>
 <20220914095628.26093-2-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d9HozaUaSmPczMoU"
Content-Disposition: inline
In-Reply-To: <20220914095628.26093-2-pshete@nvidia.com>
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


--d9HozaUaSmPczMoU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2022 at 03:26:26PM +0530, Prathamesh Shete wrote:
> As per T23x MSS IAS SMMU clients are supposed

This reference isn't useful because this document is not available
publicly. If this information exists in the TRM, then make a reference
to that, otherwise just leave out the reference and keep the rest of the
comment.

> to program streamid from their respective address spaces instead of MC

s/streamid/stream ID/ to match the ARM SMMU spelling.

> override
> Define NVQUIRK_PROGRAM_MC_STREAMID and use it to program SMMU streamid
> from the SDMMC client address space

Maybe make this all look more like one big paragraph. Right now it looks
fragments of sentences thrown together and is difficult to read.

>=20
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index a6c5bbae77b4..b66b0cc51497 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -25,6 +25,7 @@
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/ktime.h>
> +#include <linux/iommu.h>
> =20
>  #include <soc/tegra/common.h>
> =20
> @@ -94,6 +95,8 @@
>  #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
>  #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
> =20
> +#define SDHCI_TEGRA_CIF2AXI_CTRL_0			0x1fc
> +
>  #define NVQUIRK_FORCE_SDHCI_SPEC_200			BIT(0)
>  #define NVQUIRK_ENABLE_BLOCK_GAP_DET			BIT(1)
>  #define NVQUIRK_ENABLE_SDHCI_SPEC_300			BIT(2)
> @@ -121,6 +124,7 @@
>  #define NVQUIRK_HAS_TMCLK				BIT(10)
> =20
>  #define NVQUIRK_HAS_ANDROID_GPT_SECTOR			BIT(11)
> +#define NVQUIRK_PROGRAM_MC_STREAMID			BIT(17)

Why is this called "program MC stream ID"? What's programmed is the SMMU
stream ID, right? Perhaps just leave out that MC_ prefix altogether
since there's no ambiguity with any other quirk to begin with.

Also, why skip from bit 11 (of the GPT sector quirk) to bit 17? Can we
not use bit 12 as the next one?

> =20
>  /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
>  #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
> @@ -177,6 +181,7 @@ struct sdhci_tegra {
>  	bool enable_hwcq;
>  	unsigned long curr_clk_rate;
>  	u8 tuned_tap_delay;
> +	u32 streamid;
>  };
> =20
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -1564,6 +1569,7 @@ static const struct sdhci_tegra_soc_data soc_data_t=
egra234 =3D {
>  		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
>  		    NVQUIRK_ENABLE_SDR50 |
>  		    NVQUIRK_ENABLE_SDR104 |
> +		    NVQUIRK_PROGRAM_MC_STREAMID |
>  		    NVQUIRK_HAS_TMCLK,
>  	.min_tap_delay =3D 95,
>  	.max_tap_delay =3D 111,
> @@ -1637,6 +1643,7 @@ static int sdhci_tegra_probe(struct platform_device=
 *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_tegra *tegra_host;
>  	struct clk *clk;
> +	struct iommu_fwspec *fwspec;

The above is largely sorted in reverse christmas tree order, so this one
sticks out a bit. Maybe put it before the clk declaration. Not usually a
big deal, really, but since you're going to touch this anyway, may as
well touch that up.

>  	int rc;
> =20
>  	soc_data =3D of_device_get_match_data(&pdev->dev);
> @@ -1775,6 +1782,23 @@ static int sdhci_tegra_probe(struct platform_devic=
e *pdev)
>  	if (rc)
>  		goto err_add_host;
> =20
> +	/* Program MC streamID for DMA transfers */
> +	if (soc_data->nvquirks & NVQUIRK_PROGRAM_MC_STREAMID) {
> +		fwspec =3D dev_iommu_fwspec_get(&pdev->dev);
> +		if (fwspec =3D=3D NULL) {
> +			rc =3D -ENODEV;
> +			dev_err(mmc_dev(host->mmc),
> +				"failed to get MC streamid: %d\n",
> +				rc);
> +			goto err_rst_get;

Do we really want to make this fatal? What if somebody really wants to
not put the SD/MMC controllers behind an IOMMU? It's quite unlikely to
happen, but it's technically possible.

Also, there was a brief time where the DTS files didn't have any iommus
properties, so if somebody were to use a DTS from that era and a kernel
with this patch applied, they'd end up with non-functional SD/MMC.
Again, that's very unlikely to happen, but it could, if for example this
patch ends up being back-ported or something like that.

I think it's safe (and easier) to ignore this case. Perhaps if you
really want people to use SD/MMC you may want to add a warning here
instead. But even that shouldn't be necessary. If the stream ID is not
programmed as required, the SMMU should fault and give people the hint
that they need to fix this.

> +		} else {
> +			tegra_host->streamid =3D fwspec->ids[0] & 0xffff;
> +			tegra_sdhci_writel(host, tegra_host->streamid |
> +						(tegra_host->streamid << 8),
> +						SDHCI_TEGRA_CIF2AXI_CTRL_0);

Perhaps define macros for the read/write stream ID fields in this
register? Otherwise it might be confusing why you're writing the value
twice.

Thierry

> +		}
> +	}
> +
>  	return 0;
> =20
>  err_add_host:
> @@ -1861,6 +1885,8 @@ static int sdhci_tegra_suspend(struct device *dev)
>  static int sdhci_tegra_resume(struct device *dev)
>  {
>  	struct sdhci_host *host =3D dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host =3D sdhci_pltfm_priv(pltfm_host);
>  	int ret;
> =20
>  	ret =3D mmc_gpio_set_cd_wake(host->mmc, false);
> @@ -1871,6 +1897,13 @@ static int sdhci_tegra_resume(struct device *dev)
>  	if (ret)
>  		return ret;
> =20
> +	/* Re-program MC streamID for DMA transfers */
> +	if (tegra_host->soc_data->nvquirks & NVQUIRK_PROGRAM_MC_STREAMID) {
> +		tegra_sdhci_writel(host, tegra_host->streamid |
> +					(tegra_host->streamid << 8),
> +					SDHCI_TEGRA_CIF2AXI_CTRL_0);
> +	}
> +
>  	ret =3D sdhci_resume_host(host);
>  	if (ret)
>  		goto disable_clk;
> --=20
> 2.17.1
>=20

--d9HozaUaSmPczMoU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMhxPAACgkQ3SOs138+
s6FXtA/+L8oY9D7fdk1/CjyE/Jid9EeiLyvZ7cYDG+G5LFimtkkaw21W3gWQ1aaS
U6t9QkEywezcEaUmSKEThgLFE6fOmMZkfk6NQ3J801VGz469AQmNJIXjLAZ0spZW
BKWFisX7q2FnHhu/+ajTEnIQlg8z8VgDvFLmbiiRw4fphkKiuditoll55YbGXHCL
4/5UuqTN6k3dTXdFwFH8h6p99IQCbzJXYLkfINAR5vXpiS6TALIrlXO91omiBl37
9Zh1TJsgspTQML+4n2+nAhaJWwcNUO+dDVmkmVcH3XruWzMlZb81xeCcYm/tWyVS
5f51HlrPwSmtwExz4Wmu/ntRyb4Pen1Zx7EeaxO4RecpwI8ZHfCM/WCcWGOVApiW
n9fO84USa0UsZC57S0No07U54A+1DFqcsAop0thS0fVpYzf1bkQWz2YVXmGpJ+h/
n8Ydch9HcYyKLR2Nhe94raFoc3ESCiA2l4vMec7fCjdp9acspC9fi+7lKhFrQjA+
H+Ve0gRw8wCf7vweAJSOljYL7WDnbRo/uSJ762oDzIFlJoa7hY4N5Oc6F3H0/bPL
gSc8slZDsf7eC7ySWAWr+7lNv7CeBiD/NJmCU3u0+l26XPqyYTrkoqy9uqfzlWeb
m3Bv05ZP6VcKenJcuu/1wCyhn+hNPtky6QME0ojEvLcrChyyApE=
=Cinl
-----END PGP SIGNATURE-----

--d9HozaUaSmPczMoU--
