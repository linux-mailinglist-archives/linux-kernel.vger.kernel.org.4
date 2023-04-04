Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C0A6D5EC8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjDDLPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjDDLPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:15:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F661BF;
        Tue,  4 Apr 2023 04:15:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so129112260edo.2;
        Tue, 04 Apr 2023 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680606931;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNX9K8ck0uUOzT2dTHFGkWC9/9Gij8pMO/80UWewFWk=;
        b=poqjbSv1ZVSUR04cF3S6ZY8DN1RMI06+QRQSSmIw4M4Cd0+1AJxLicIb0AMuZURxiR
         XnwQx549KTEHyr0OT1yJfBqJgDj5WxvKR96Pq5SgAFRkPzZ3B5osov6GaeW5attluhBd
         L5DsuHrD/P+uxJgqKJRziHzDuXp6fVMNXiNgaED0NJOu71PCEYqLgUHF1D5jzfCcMaXF
         j3M4d+tl1yrvCb2mM7C519tXa55d9SqwWcKPJA0o5XByS2YHltirR5x9TCV1PKrY92av
         WSjEPUd1s1V05CcDyFt8LPZNeBcnzOsK6LhUUH1wN2imbbE/cY0JOiTJhv8xsKMrHUx+
         FSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680606931;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNX9K8ck0uUOzT2dTHFGkWC9/9Gij8pMO/80UWewFWk=;
        b=1EJbQFHe5MaZs4He7vqfvaAL+L1oEyJKnYN0cB+oOVvJ+N3FdhIrUJsWqBo8qlNCQ+
         g3FGWJVM18FNb6hmD8rcBG9JQTT2dP+QcjWW5ylxmx89cZXs5YrKKK/EEgxc230vM7gj
         1lYVj9/Gxmuhxwzrz/QwnH3kmY5zX39IOBvZ9XnqBVo3ihYTL4M3OBu+CF5WSXh4W1qA
         w9b4lPjvsLuhPvBf5gKWOo8FBZYmPdKxuT5uFpEPhtrXkfVThQfEXESaMM9PFMHQeEJC
         di6aVJeP3TreRFsyC/DaO0jZO/Fq5Tcn/sfWPHL3Lv4GtnOGU/tMb9m/vEx/RyW2gl6J
         VSlg==
X-Gm-Message-State: AAQBX9ebpHH7kZMeNgPzSzabRPc10uCC90YQbxiYpoIOyoHyFMu1voyq
        oBYnAz6qkFB8BO6JNRZV86aOplWn7+8=
X-Google-Smtp-Source: AKy350Z6C9Gw8Vh96AW+yrfxA4Sgu7/Hq0BsTNLvh87HFfmUa8xTE/s5AyENeayPg5tTBF+PBwbciA==
X-Received: by 2002:a17:906:f244:b0:947:fb8a:f2d2 with SMTP id gy4-20020a170906f24400b00947fb8af2d2mr1597820ejb.62.1680606931134;
        Tue, 04 Apr 2023 04:15:31 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906454500b008e54ac90de1sm5844791ejq.74.2023.04.04.04.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:15:30 -0700 (PDT)
Date:   Tue, 4 Apr 2023 13:15:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Petlozu Pravareshwar <petlozup@nvidia.com>, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, ulf.hansson@linaro.org, kkartik@nvidia.com,
        cai.huoqing@linux.dev, spatra@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viswanath L <viswanathl@nvidia.com>
Subject: Re: [PATCH v2] soc/tegra: pmc: Support software wake-up for SPE
Message-ID: <ZCwG0SM9szT6toGG@orome>
References: <20230330170621.258068-1-petlozup@nvidia.com>
 <f70c6d62-a7fd-c153-932f-16886e46329b@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HWENIabzcbjHRvPD"
Content-Disposition: inline
In-Reply-To: <f70c6d62-a7fd-c153-932f-16886e46329b@collabora.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HWENIabzcbjHRvPD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 07:06:12PM +0300, Dmitry Osipenko wrote:
> On 3/30/23 20:06, Petlozu Pravareshwar wrote:
> > The Sensor Processing Engine(SPE) can trigger a software wake-up of
> > the device. To support this wake-up for the SPE, set SR_CAPTURE_EN
> > bit in WAKE_AOWAKE_CNTRL register associated with the wake-up for
> > the SPE. This SR capturing logic is expected to be enabled for wakes
> > with short pulse signalling requirements.
> >=20
> > Signed-off-by: Viswanath L <viswanathl@nvidia.com>
> > Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> > ---
> > v1->v2:
> > * Rebase the change on latest code.
> > ---
> >  drivers/soc/tegra/pmc.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> > index cf4cfbf9f7c5..2a2342eff622 100644
> > --- a/drivers/soc/tegra/pmc.c
> > +++ b/drivers/soc/tegra/pmc.c
> > @@ -3,7 +3,7 @@
> >   * drivers/soc/tegra/pmc.c
> >   *
> >   * Copyright (c) 2010 Google, Inc
> > - * Copyright (c) 2018-2022, NVIDIA CORPORATION. All rights reserved.
> > + * Copyright (c) 2018-2023, NVIDIA CORPORATION. All rights reserved.
> >   *
> >   * Author:
> >   *	Colin Cross <ccross@google.com>
> > @@ -177,6 +177,7 @@
> >  /* Tegra186 and later */
> >  #define WAKE_AOWAKE_CNTRL(x) (0x000 + ((x) << 2))
> >  #define WAKE_AOWAKE_CNTRL_LEVEL (1 << 3)
> > +#define WAKE_AOWAKE_CNTRL_SR_CAPTURE_EN (1 << 1)
> >  #define WAKE_AOWAKE_MASK_W(x) (0x180 + ((x) << 2))
> >  #define WAKE_AOWAKE_MASK_R(x) (0x300 + ((x) << 2))
> >  #define WAKE_AOWAKE_STATUS_W(x) (0x30c + ((x) << 2))
> > @@ -191,6 +192,8 @@
> >  #define WAKE_AOWAKE_CTRL 0x4f4
> >  #define  WAKE_AOWAKE_CTRL_INTR_POLARITY BIT(0)
> > =20
> > +#define SW_WAKE_ID		83 /* wake83 */
> > +
> >  /* for secure PMC */
> >  #define TEGRA_SMC_PMC		0xc2fffe00
> >  #define  TEGRA_SMC_PMC_READ	0xaa
> > @@ -355,6 +358,7 @@ struct tegra_pmc_soc {
> >  	void (*setup_irq_polarity)(struct tegra_pmc *pmc,
> >  				   struct device_node *np,
> >  				   bool invert);
> > +	void (*set_wake_filters)(struct tegra_pmc *pmc);
> >  	int (*irq_set_wake)(struct irq_data *data, unsigned int on);
> >  	int (*irq_set_type)(struct irq_data *data, unsigned int type);
> >  	int (*powergate_set)(struct tegra_pmc *pmc, unsigned int id,
> > @@ -2416,6 +2420,17 @@ static int tegra210_pmc_irq_set_type(struct irq_=
data *data, unsigned int type)
> >  	return 0;
> >  }
> > =20
> > +static void tegra186_pmc_set_wake_filters(struct tegra_pmc *pmc)
> > +{
> > +	u32 value;
> > +
> > +	/* SW Wake (wake83) needs SR_CAPTURE filter to be enabled */
> > +	value =3D readl(pmc->wake + WAKE_AOWAKE_CNTRL(SW_WAKE_ID));
> > +	value |=3D WAKE_AOWAKE_CNTRL_SR_CAPTURE_EN;
> > +	writel(value, pmc->wake + WAKE_AOWAKE_CNTRL(SW_WAKE_ID));
> > +	dev_dbg(pmc->dev, "WAKE_AOWAKE_CNTRL_83 =3D 0x%x\n", value);
> > +}
>=20
> To me this needs to be moved to the SPE driver, which should get the PMC
> regmap handle and enable wake only when needed, similarly how it's done
> by USB Tegra drivers that also need to configure PMC. Otherwise this
> looks like a hack/workaround.

Wake is still only enabled when needed via the irq_set_wake() callback.
And this is slightly different in that it pretty has no side-effects. It
isn't a configuration option that needs to be switched every now and
then but rather just a bit in a register that happens to have the wrong
default value (or an inconvenient default value).

For USB there are actual side-effects and some of the settings only make
sense if a given USB port is actually used, etc. So doing the regmap
dance is actually worth it.

For SPE it just doesn't seem worth it to have all of these inter-
dependencies just for the sake of statically setting one bit once during
boot.

Thierry

--HWENIabzcbjHRvPD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQsBs4ACgkQ3SOs138+
s6En+RAAvRL37e270TWQhnw+WuuJchdJ3i+kJ9KFpCRbWXBoHv/4JB+WQHHiOpI9
LYi231NgMEDgQvmgyRgB5sPJIGA4+9aLVqhitOHU3wm3tZBQ1lrMaymPALSOGcQs
pHpXPFd8FO+vYdWYjVdh7K2mGT0V4eDkgNdPzdFFfMdxFSqs3taoMxUCnsKOGEZg
JScNPs6bws+5+5qmvgkm0Uei7OuKW8UTsJOdHyma66CHF4oql2WEDB84/a2reKUB
fIqwEI+jfHH80ilXuf755Q3zssgcePK4b3A86LqlXfgIqB0Gw+25W3a5S1pfMosk
8mYoVIpwsXRK0jOazims3KZIMA3ILwJBgm4uC5Vj3bzcmsqlvEEoVzSXTkhdGE7I
0cvXkXXlpx59w370QvvPPxS0yiiU/V3xBA4WUl+p3mI7MuQx/26cZ2PSIPT+VuK4
WnyblJ9ssV7OQCSzebeR/oxmDhfsB2lqLFNCfMt4f7GUd9idkHqitr11W6rYclCp
AJ2ZDqXLHDSlmrL3MIBd9CIpwCPVav8N3Ez7FNFj1/aly7wuqL9EW9lgIqj+7ZI+
hCE4Txl8XaJ0GdTUWC4Dh00QqaRCBHtgeVvgGGbg/fC0tyuwYqGlvTb4Zg8MHQrD
VxXGDdyqOtysE6dT9wRIAhDOEgzWYLYGO4GhjIhBpbDQ3TYJWQ8=
=YpjT
-----END PGP SIGNATURE-----

--HWENIabzcbjHRvPD--
