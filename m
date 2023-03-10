Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9186F6B3AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjCJJlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjCJJkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:40:14 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBF922123
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:39:35 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cw28so18052405edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1678441174;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEjUvqR9H0ur1xoRA47tcbz6Upz6yH1KVdChgtaJUfQ=;
        b=KFKWfzgJVAn4LzDwMcKA9vIUSdx/55oM5jFVfJbcVT5ng+a3sdQhsOXKW6fh6uwmjJ
         JtIv7NaB+cdpgFuUTOkDY8yyFUm2XYpCFjMFqIeW/QowZLobDkglbsFtYPFOaELXPMmM
         Cerc7U+RWUf8/+hU6naOXx2fi9RLMurMWKpFcfPxeTUaxwMbsgaKG9QVh+CdnMVq3s7n
         5NglrsGE+8ayKsFYhvOQTSZOcC0Rot33cpfpowTJHppOWtNaY8w4DkNhiEdYiyG17Tew
         Hm3qfY+6Bh9453YOTBN/BMXClbCuQhEXx2P9z40u8exhBWEitI/FQDAd2iPrjm3Wy4Lm
         Y8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678441174;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VEjUvqR9H0ur1xoRA47tcbz6Upz6yH1KVdChgtaJUfQ=;
        b=EMXvJnfhMrd0K8qvRRhbbxarJ3qKgEObQ8yKb6Px5CO7scMdfg5HmV5tam55RFr2Qx
         T7he8UV3a8pqIYi/RGXPISqkbVIioBDypD1I0dnF1RAFnJc2V3hK0vSKH/Rz+YeSTVCx
         yKj91zpTz5l31mGKWKJtcYazgxbvruvQWkgzBB6DnBotFaFkoPN6vZPAlXufU8x5esLd
         1pioL5e5mSbn/CgFgNY19FPesLJ3uznhQ9XfCg5QIPORzEufcWS12m4DNfyD55uU9wB9
         HeFiWPpWQdkiuePVD+nRQOx8AwdeLF8hPWZDTxKorIHH1zXbQqEmTLEo93Wv5VjdRdrW
         pK+g==
X-Gm-Message-State: AO0yUKUtM3HTe8viSCXxO4ksx+cCkkK3bbr7glU5SwEo9pht2F4SCB8T
        rDgLUVfRJs/A0QhcW2jINjWNjw==
X-Google-Smtp-Source: AK7set/qV6J8fl2ICtznNkCQ11DqNYZF5/eM+6z8azD98m/0SLpXUnuyoQep0E69hIOQyDvVqfc0JQ==
X-Received: by 2002:a17:906:da82:b0:88f:9f5e:f40 with SMTP id xh2-20020a170906da8200b0088f9f5e0f40mr35586656ejb.68.1678441174281;
        Fri, 10 Mar 2023 01:39:34 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id k7-20020a1709062a4700b008e385438c76sm748638eje.55.2023.03.10.01.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 01:39:33 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Mar 2023 10:39:32 +0100
Message-Id: <CR2LQM36RPYX.200B6XV5RJO7U@otso>
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
Subject: Re: [PATCH v3 1/2] clk: qcom: camcc-sm6350: add pm_runtime support
X-Mailer: aerc 0.14.0
References: <20230213-sm6350-camcc-runtime_pm-v3-0-d35e0d833cc4@fairphone.com> <20230213-sm6350-camcc-runtime_pm-v3-1-d35e0d833cc4@fairphone.com> <CAA8EJprzOLuLU8_tvRtQ9bX8M9xOqMFFnjuj-DwGz+24XPAQFg@mail.gmail.com> <CR08JR9XAIUO.3KF8TBTQ9UQP1@otso> <CAA8EJpotZjNqo72xhNVS+Fq7gbdADVF+tq8Ph4+tnPyO3HyQoA@mail.gmail.com>
In-Reply-To: <CAA8EJpotZjNqo72xhNVS+Fq7gbdADVF+tq8Ph4+tnPyO3HyQoA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Mar 7, 2023 at 4:06 PM CET, Dmitry Baryshkov wrote:
> On Tue, 7 Mar 2023 at 16:54, Luca Weiss <luca.weiss@fairphone.com> wrote:
> >
> > On Tue Feb 14, 2023 at 1:32 PM CET, Dmitry Baryshkov wrote:
> > > On Tue, 14 Feb 2023 at 13:01, Luca Weiss <luca.weiss@fairphone.com> w=
rote:
> > > >
> > > > Make sure that we can enable and disable the power domains used for
> > > > camcc when the clocks are and aren't used.
> > > >
> > > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > > ---
> > > >  drivers/clk/qcom/camcc-sm6350.c | 25 ++++++++++++++++++++++++-
> > > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/clk/qcom/camcc-sm6350.c b/drivers/clk/qcom/cam=
cc-sm6350.c
> > > > index acba9f99d960..fc5532e2ee5b 100644
> > > > --- a/drivers/clk/qcom/camcc-sm6350.c
> > > > +++ b/drivers/clk/qcom/camcc-sm6350.c
> > > > @@ -7,6 +7,8 @@
> > > >  #include <linux/clk-provider.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/platform_device.h>
> > > > +#include <linux/pm_clock.h>
> > > > +#include <linux/pm_runtime.h>
> > > >  #include <linux/regmap.h>
> > > >
> > > >  #include <dt-bindings/clock/qcom,sm6350-camcc.h>
> > > > @@ -1869,6 +1871,19 @@ MODULE_DEVICE_TABLE(of, camcc_sm6350_match_t=
able);
> > > >  static int camcc_sm6350_probe(struct platform_device *pdev)
> > > >  {
> > > >         struct regmap *regmap;
> > > > +       int ret;
> > > > +
> > > > +       ret =3D devm_pm_runtime_enable(&pdev->dev);
> > > > +       if (ret < 0)
> > > > +               return ret;
> > > > +
> > > > +       ret =3D devm_pm_clk_create(&pdev->dev);
> > > > +       if (ret < 0)
> > > > +               return ret;
> > >
> > > This makes me wonder, what is the use for the pm_clk in your case? Th=
e
> > > driver doesn't seem to use of_pm_clk_add_clk(), of_pm_clk_add_clks()
> > > or pm_clk_add_clk(). So pm_clk_suspend() and pm_clk_resume() do
> > > nothing.
> >
> > You're right that we're not using any of these functions in the driver.
> > However still when camcc is not used, the associated power domain turns
> > off correctly so that part works as expected.
> >
> > Honestly these lines have been copied from a different driver and I'm
> > not familiar enough with the pm_runtime APIs to know what to use here
> > without using the pm_clk* and pm_clk_suspend.
>
> Please don't blindly C&P code.

I normally try to avoid this.. however pm_runtime is still quite a
mystery to me.

>
> >
> > Basically we need, if any clock is being used in the driver, the
> > power-domain needs to be enabled as well, and if nothing is used the
> > power-domain can be disabled again.
>
> Adding power-domains to the camcc node and calling
> devm_pm_runtime_enable() should be enough. Please see how this is
> managed for dispcc on sm8250.

Following that driver, so just using devm_pm_runtime_enable and
pm_runtime_resume_and_get doesn't seem to enable runtime_pm for the
device..

  $ cat /sys/devices/platform/soc@0/ad00000.clock-controller/power/runtime_=
status=20
  unsupported

Also then I don't see the device in /sys/kernel/debug/pm_genpd/pm_genpd_sum=
mary

I'm guessing we still need to set the dev_pm_ops with something? Not
sure what to use here if it should just enable/disable the power domains
that are not handled by the driver directly. I also couldn't find any
example in existing code unfortuantely.

Any pointers?

Regards
Luca

>
> --=20
> With best wishes
> Dmitry

