Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81F16A6B12
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCAKst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCAKsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:48:47 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07FC18B09
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:48:46 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d7so13618894qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 02:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4HkARXzF8TlGnOQDulEJeGpVxYMh1KtAjEWT2EqlMU=;
        b=ku6FAjlfOlx2faYGMvRo6ZfacPwmYl/FrRqaAGrELaQgvycbWOnz7IHA3eMQAuZffp
         MSSaNfXxA8ayBJG4MfszFUxAbNZPa5dN5897deJfIOHrKcK9HTLzcYlGloupjoW4FHuz
         6kJOAqxtsn1KffirNUCAuZ1S8qv48zp6XsLNy1f6cbwfKbWWf71I0Ci2lSl42ycPUEqS
         O0PDOP/8QqLBogxTuV6alK4U0C8cSuRgXuAaKfbXW2jpS/cftlTRw9hJ0aDwBf2YbdEr
         LBHt7Izxrk61n3LO+ZnZHYzFcfmNvXWqa25HYM53e4lqQX+H2RD6pBR3qtWJT6BIdpjW
         1fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4HkARXzF8TlGnOQDulEJeGpVxYMh1KtAjEWT2EqlMU=;
        b=DNhDpM3ZCfmb6R8fdowIaSp0tAtrP9lPUAgxqQATPxIaT1raPmPIw2VnR99IVtBTx8
         2k/Sf/uYn0IqEDNISQI8WvGawVW95dt2alZ/etm9gSroLifQHMu4DCwp0a87ScLaSwS6
         3C36nrwc9NuaBuHO2G0I06d4sxUsiIMYpmCXQui3OpJbIMVCfBb0DSgy74QQE0QCluzA
         Ev9EyyFvjJg/ymffCh7qdGgSyNJcU7huvtVsbBIDLKJkfzKdLo/6tL3zj++l0C2tVoBs
         pjYYfAezRYEXgJ27aFY/v6DSeUBv+50W0d5yE0RLkSQZL7tFKLw+qwJzM873NQtnnnqH
         89pw==
X-Gm-Message-State: AO0yUKUPe94t0a2FV1mtDWcwCcEujf1NmdN0S5w6uM+fDGOt4tsayBPz
        A8lMu7D8wx22AklcxNEfEO8Depmh5ZbKQWZ+2p0jW4Bx/q93UQ==
X-Google-Smtp-Source: AK7set9SyLgqr1kDAksJiidD5Y0PSb/+K6D/mmPlDTKYK07jqcfdijOIhng1V2D9ELDbJhmkEHl05s3WSGv+44yO/gA=
X-Received: by 2002:ac8:4049:0:b0:3bf:b9a7:c550 with SMTP id
 j9-20020ac84049000000b003bfb9a7c550mr1581979qtl.1.1677667725806; Wed, 01 Mar
 2023 02:48:45 -0800 (PST)
MIME-Version: 1.0
References: <20230301095402.28582-1-hdegoede@redhat.com>
In-Reply-To: <20230301095402.28582-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Mar 2023 12:48:09 +0200
Message-ID: <CAHp75VeEnJ5fnme6QTjxN6XjNg82PB5SFMWAHkZBfKTc07tGkQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mfd: intel_soc_pmic_chtwc: Add Lenovo Yoga Book X90F
 to intel_cht_wc_models
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 11:54=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> The Android Lenovo Yoga Book X90F / X90L uses the same charger / fuelgaug=
e
> setup as the already supported Windows Lenovo Yoga Book X91F/L, add
> a DMI match for this to intel_cht_wc_models with driver_data
> set to INTEL_CHT_WC_LENOVO_YOGABOOK1.
>
> When the quirk for the X91F/L was initially added it was written to
> also apply to the X90F/L but this does not work because the Android
> version of the Yoga Book uses completely different DMI strings.
> Also adjust the X91F/L quirk to reflect that it only applies to
> the X91F/L models.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

(Please, update the subject in the next version)

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/intel_soc_pmic_chtwc.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_p=
mic_chtwc.c
> index d53dae255490..871776d511e3 100644
> --- a/drivers/mfd/intel_soc_pmic_chtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_chtwc.c
> @@ -159,11 +159,19 @@ static const struct dmi_system_id cht_wc_model_dmi_=
ids[] =3D {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
>                 },
>         }, {
> -               /* Lenovo Yoga Book X90F / X91F / X91L */
> +               /* Lenovo Yoga Book X90F / X90L */
>                 .driver_data =3D (void *)(long)INTEL_CHT_WC_LENOVO_YOGABO=
OK1,
>                 .matches =3D {
> -                       /* Non exact match to match all versions */
> -                       DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporatio=
n"),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 =
PLATFORM"),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
> +               },
> +       }, {
> +               /* Lenovo Yoga Book X91F / X91L */
> +               .driver_data =3D (void *)(long)INTEL_CHT_WC_LENOVO_YOGABO=
OK1,
> +               .matches =3D {
> +                       /* Non exact match to match F + L versions */
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
>                 },
>         }, {
>                 /* Lenovo Yoga Tab 3 Pro YT3-X90F */
> --
> 2.39.1
>


--=20
With Best Regards,
Andy Shevchenko
