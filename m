Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F32D6AE3BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCGPDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCGPDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:03:13 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2CB1BAEB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:54:03 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x3so53231039edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 06:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1678200842;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj7y4N3ePwX14+nHHf5Pti3mGaulowmSTqrODOj/EV0=;
        b=wH2l0MW4NuRZWC1yIqat3/ga4LSrTEGVaBH/acRBbQG691H5P8tSibeda3HjfL3S40
         Ps3i/0zbKpkeyLTTLdKY+/+BvyFWeWXn/CRvqcTaABrP+i569MizyvjgBZMRienA+Mud
         D4Wg3vpp9GPulYu5i86C5o74TmbEFTZUDMEtFiFSpV/VryY122hrmDbAoqR9r2KqCy5v
         iSknzeBu5Lexq57XnhIC1vY/tq7LBQ6vYGvawBfv821NNCQtJZahwLLpYe2ydrPWTDwV
         ZoXD2T30czsOLi+KwfSEdG27jakuJilm72LClgLHmWWWJqyEvMgiQrn0+lXwHBGwKi8M
         PQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678200842;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zj7y4N3ePwX14+nHHf5Pti3mGaulowmSTqrODOj/EV0=;
        b=fAUMiGyLESD/7sm1IuFjgcLvPdR8+qD6RkDFtGmWgBk0cgAR5o7GNntdBgSo2RIr2B
         PPsnZgV+BabuHNG7+wc3o7jbT0Imne7CnFFMJgR98NV481PZD+MDJuAXtYaM6kCdVXh4
         bRRTVEqnyaO7dgSRuBmdzkHN7E9KFB2cieL0peIBdKIkmkuFbmp94cChB1zrkXGH3q0Z
         ptmp7BVmJd2vjslOGuVAda792Xo/SobqLDLEowhMhHMLH5w8bXh06Ukk72pbNXNBI1+q
         0PgvyMKNfI6fB8rcVsOW1nnWGw1KpPCwirsMR1OlYftRuDO+OJHjgfuTUqLmHa2NVGI/
         0/UQ==
X-Gm-Message-State: AO0yUKV0te+rGcgg1QG24fJ2oRFIGdoviFZpQDdgLFCkuxPeM4zODbN0
        VcxmCH7mtHNcHB+WuDjEGnOdfg==
X-Google-Smtp-Source: AK7set9pTneDqAfWzdgkDz+oxkoh3eJS8BdlVl2szyGPHO8KIqy3p1+Q6ZMHFPplEc9pd1lByN6Y5w==
X-Received: by 2002:a17:906:ae4b:b0:88a:724:244c with SMTP id lf11-20020a170906ae4b00b0088a0724244cmr13751926ejb.71.1678200842148;
        Tue, 07 Mar 2023 06:54:02 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id j17-20020a50d011000000b004e48f8df7e2sm3400420edf.72.2023.03.07.06.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 06:54:01 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 07 Mar 2023 15:54:01 +0100
Message-Id: <CR08JR9XAIUO.3KF8TBTQ9UQP1@otso>
Subject: Re: [PATCH v3 1/2] clk: qcom: camcc-sm6350: add pm_runtime support
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Cc:     "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230213-sm6350-camcc-runtime_pm-v3-0-d35e0d833cc4@fairphone.com> <20230213-sm6350-camcc-runtime_pm-v3-1-d35e0d833cc4@fairphone.com> <CAA8EJprzOLuLU8_tvRtQ9bX8M9xOqMFFnjuj-DwGz+24XPAQFg@mail.gmail.com>
In-Reply-To: <CAA8EJprzOLuLU8_tvRtQ9bX8M9xOqMFFnjuj-DwGz+24XPAQFg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Feb 14, 2023 at 1:32 PM CET, Dmitry Baryshkov wrote:
> On Tue, 14 Feb 2023 at 13:01, Luca Weiss <luca.weiss@fairphone.com> wrote=
:
> >
> > Make sure that we can enable and disable the power domains used for
> > camcc when the clocks are and aren't used.
> >
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  drivers/clk/qcom/camcc-sm6350.c | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/qcom/camcc-sm6350.c b/drivers/clk/qcom/camcc-s=
m6350.c
> > index acba9f99d960..fc5532e2ee5b 100644
> > --- a/drivers/clk/qcom/camcc-sm6350.c
> > +++ b/drivers/clk/qcom/camcc-sm6350.c
> > @@ -7,6 +7,8 @@
> >  #include <linux/clk-provider.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_clock.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> >
> >  #include <dt-bindings/clock/qcom,sm6350-camcc.h>
> > @@ -1869,6 +1871,19 @@ MODULE_DEVICE_TABLE(of, camcc_sm6350_match_table=
);
> >  static int camcc_sm6350_probe(struct platform_device *pdev)
> >  {
> >         struct regmap *regmap;
> > +       int ret;
> > +
> > +       ret =3D devm_pm_runtime_enable(&pdev->dev);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret =3D devm_pm_clk_create(&pdev->dev);
> > +       if (ret < 0)
> > +               return ret;
>
> This makes me wonder, what is the use for the pm_clk in your case? The
> driver doesn't seem to use of_pm_clk_add_clk(), of_pm_clk_add_clks()
> or pm_clk_add_clk(). So pm_clk_suspend() and pm_clk_resume() do
> nothing.

You're right that we're not using any of these functions in the driver.
However still when camcc is not used, the associated power domain turns
off correctly so that part works as expected.

Honestly these lines have been copied from a different driver and I'm
not familiar enough with the pm_runtime APIs to know what to use here
without using the pm_clk* and pm_clk_suspend.

Basically we need, if any clock is being used in the driver, the
power-domain needs to be enabled as well, and if nothing is used the
power-domain can be disabled again.

Please advise.

Regards
Luca

>
> > +
> > +       ret =3D pm_runtime_get(&pdev->dev);
> > +       if (ret)
> > +               return ret;
> >
> >         regmap =3D qcom_cc_map(pdev, &camcc_sm6350_desc);
> >         if (IS_ERR(regmap))
> > @@ -1879,14 +1894,22 @@ static int camcc_sm6350_probe(struct platform_d=
evice *pdev)
> >         clk_agera_pll_configure(&camcc_pll2, regmap, &camcc_pll2_config=
);
> >         clk_fabia_pll_configure(&camcc_pll3, regmap, &camcc_pll3_config=
);
> >
> > -       return qcom_cc_really_probe(pdev, &camcc_sm6350_desc, regmap);
> > +       ret =3D qcom_cc_really_probe(pdev, &camcc_sm6350_desc, regmap);
> > +       pm_runtime_put(&pdev->dev);
> > +
> > +       return ret;
> >  }
> >
> > +static const struct dev_pm_ops camcc_pm_ops =3D {
> > +       SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
> > +};
> > +
> >  static struct platform_driver camcc_sm6350_driver =3D {
> >         .probe =3D camcc_sm6350_probe,
> >         .driver =3D {
> >                 .name =3D "sm6350-camcc",
> >                 .of_match_table =3D camcc_sm6350_match_table,
> > +               .pm =3D &camcc_pm_ops,
> >         },
> >  };
> >
> >
> > --
> > 2.39.1
> >
>
>
> --=20
> With best wishes
> Dmitry

