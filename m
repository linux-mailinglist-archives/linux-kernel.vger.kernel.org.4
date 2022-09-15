Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8025B9934
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiIOK4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIOK4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:56:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70AE8B98D;
        Thu, 15 Sep 2022 03:56:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b35so26391485edf.0;
        Thu, 15 Sep 2022 03:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5KfyDy+cMltzrSXMQTDHvnQXo4AcAbZvGBQ9NxOtQFc=;
        b=AsYOEwQia6PYiexHLTq69+7G8ccRW0Zz8rL96hdUGLxBzCYuiDE2quPlqGlOfzqGrv
         nyEeojDUXIfr8IjUIzGK7ahQvMnXx/aEmpuHZIsUOFR1UEB+tJT/Y6Z3W8UCIPoeysjN
         XaLJ/Hi+GW7ByJe7IJDwbEjZCSHSjqCJrW2ZScZzfekNPs3pkPSuNzHy2K4/fHUlamxD
         nE/HuzELjZQYOSFrG/J/BOPfENM9BnrLicbO/rHrU01OAQ/oN6GKNLg8l4vIP3E0Kk2c
         CsdwACh1dssRLH8aA9mnBtmpvyUxrWHBoBC56ArL3azPWsFo8xSYFMKg72ft6CJTU4sC
         ZejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5KfyDy+cMltzrSXMQTDHvnQXo4AcAbZvGBQ9NxOtQFc=;
        b=g7V5NTSA1pZ3CIR8lJWXTZWgylmlQkR2eYbbIAKm4A34lnwgzEVN6DsSciZGJmR8MS
         3uu+OkSth5dxdprqsMMi8bzN40A+ZULlHVkigmarSiaXc+yEe5tyGihgUy5pPb7Y9Y7d
         0L8lTfxOnzVQGddJTVTjzQ2fg+CgAQO4Uky71IN+Nywgud8hx/rQRIHb7YCTBlr5WXkv
         Eb8umV5E0SlFTPfUx7IJi21wbv2Ec1niS0f5ITzXk9XO0TboX7q8GJNeR1OW2ngv9tOD
         jt+1am8wakeRF4m25xlbaLgJrcCHG3web40aBoyo0w8JSYR/DZjrstH3HkGiHpVlabxb
         WYNg==
X-Gm-Message-State: ACgBeo1rcQujfSx7ocn/nk3hPa6N7b57+sDF0xOK7uxIkBxqkr2zezQL
        hJqwsIU4etr4TUnyc+cAk4s=
X-Google-Smtp-Source: AA6agR4CVty/vhiihIZJn8i7Xt94qfHqC+VgWaV+RjG4OH/6cDTSG9doydf26HmUn7BJHsM/rOT7yQ==
X-Received: by 2002:a05:6402:1a4f:b0:44e:f731:f7d5 with SMTP id bf15-20020a0564021a4f00b0044ef731f7d5mr33619590edb.357.1663239397202;
        Thu, 15 Sep 2022 03:56:37 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7c90d000000b0044eda621b08sm11769888edt.54.2022.09.15.03.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 03:56:36 -0700 (PDT)
Date:   Thu, 15 Sep 2022 12:56:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Prathamesh Shete <pshete@nvidia.com>
Cc:     ulf.hansson@linaro.org, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
Subject: Re: [PATCH v2 3/4] mmc: sdhci-tegra: Issue CMD and DAT resets
 together
Message-ID: <YyME4i8oMI2omd0v@orome>
References: <20220914095628.26093-1-pshete@nvidia.com>
 <20220914095628.26093-3-pshete@nvidia.com>
 <YyHHIPbXnLiPe/vn@orome>
 <05686061-e17e-fcd6-e570-a9ae159cb51c@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WEzO1g9FGLaY/old"
Content-Disposition: inline
In-Reply-To: <05686061-e17e-fcd6-e570-a9ae159cb51c@intel.com>
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


--WEzO1g9FGLaY/old
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2022 at 09:21:07PM +0300, Adrian Hunter wrote:
> On 14/09/22 15:20, Thierry Reding wrote:
> > On Wed, Sep 14, 2022 at 03:26:27PM +0530, Prathamesh Shete wrote:
> >> In case of error condition to avoid system crash
> >> Tegra SDMMC controller requires CMD and DAT resets
> >> issued together.
> >=20
> > It might be worth specifying exactly what "system crash" means. Does
> > this always happen (i.e. do we have a problem right now?) or are there
> > specific circumstances that cause the crash.
> >=20
> >> This is applicable to Tegra186 and later chips.
> >>
> >> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> >> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> >> ---
> >>  drivers/mmc/host/sdhci-tegra.c |  3 ++-
> >>  drivers/mmc/host/sdhci.c       | 11 ++++++++---
> >>  drivers/mmc/host/sdhci.h       |  2 ++
> >>  3 files changed, 12 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-t=
egra.c
> >> index b66b0cc51497..7d16dc41fe91 100644
> >> --- a/drivers/mmc/host/sdhci-tegra.c
> >> +++ b/drivers/mmc/host/sdhci-tegra.c
> >> @@ -1530,7 +1530,8 @@ static const struct sdhci_pltfm_data sdhci_tegra=
186_pdata =3D {
> >>  		  SDHCI_QUIRK_NO_HISPD_BIT |
> >>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
> >>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> >> -	.quirks2 =3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> >> +	.quirks2 =3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> >> +		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
> >>  	.ops  =3D &tegra186_sdhci_ops,
> >>  };
> >> =20
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index 7689ffec5ad1..289fa8ae4866 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -3063,9 +3063,14 @@ static bool sdhci_request_done(struct sdhci_hos=
t *host)
> >>  		 * Spec says we should do both at the same time, but Ricoh
> >>  		 * controllers do not like that.
> >>  		 */
> >=20
> > The comment above seems to indicate that the current behavior (i.e.
> > splitting the CMD and DATA resets) is actually the quirk, so I wonder if
> > this perhaps should be reversed? I suppose it could be difficult to
> > track down the exact controllers that need the separate resets, but this
> > might be worth doing. It's possible that other controllers might run
> > into the same issue that we are if they work strictly to the spec.
> >=20
> > Adrian, any ideas on how much of this is just cargo-culted? Do we play
> > it safe and do the "double workaround" or do we want to attempt to
> > rectify this by adding a Ricoh-specific quirk?
>=20
> It is a good question, but it has been that way for a very long time,
> and the spec tends to document them separately anyway, so it doesn't
> seem there is much reason to change.

Fair enough. Prathamesh, perhaps revise the comment above as part of
this patch because with the change below it now sounds a bit confusing.

Thierry

--WEzO1g9FGLaY/old
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMjBOAACgkQ3SOs138+
s6GyHw//d83O3LVe/vcFhw6+YjW5uoA0K9XOIvJvi0F6ERJ3IwZjc5zi7hvq5m9J
XcPgtFLEIy5d9mND5201hatBGCus1vcdTGG14Epc3aNGTSjMjD7j2KXm4oO1eqKf
5ScMobQEd2YSXzPZUqj3dYKkJO9tRgmG6cEXwaX8rv/QJZ4d/YBwUf+eOUdEIpVL
zktakeuQUx0NsjAQJyj2425wXto6hcwUNXa8DPDGRRz9jg7ridZEbsY/8NYiVHW/
hhyZ5rSxcdCrQ7Qp+Kbg/ZaiVJOVyhEcCpSaAccWRpsqayf7JO7ADWYXu4q0iofH
mTA9yOhwkqn7vE6SgqKfjOBxhCUnmviWMXEWh+Xcysqp5LHuZ4jrdbTQpAWq1HV+
Z4DsxzlivkcVXGW6ci+SMP75IxYwUpAoIJTPOgmNrJ78TNmp7VUkl6qvahv8awMS
IChD0hJdL0YXzVkPjolspEG55X2B5cM79RYQfEJIl1r3lNoyebdbJ17Y6BZHxzV7
yRCIYAOKiEG415U8HMFTd7wGhZI6pFIWoUmAAnDEOpLj0LgqbpAVuc6L+oXiqw5O
0fYoQa35cL1wlCHG9Mf3W7M2RXdzdiRwhopT5B7YGzUJNOCdfXqZxmukTCBYpkS9
SBClYkAqgz7CghNT4apqGc7N5AtukBaECDqIh8zbj7+1puQjewE=
=dNuj
-----END PGP SIGNATURE-----

--WEzO1g9FGLaY/old--
