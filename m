Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15113696386
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjBNMc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjBNMcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:32:54 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A167288
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:32:52 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-52f1b1d08c2so79447757b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oxKCQRN8kliMAds7bxWTjhzMHLjHvEjXGywgi7rr6WQ=;
        b=rDAO2a38P7zgbx3Y2kJ3cH2rJGvgmDUtI0kxkXaLWSE8wUnGuoVNMk75UaizZ0MRld
         2lKNqohuKqTYlQYOylf9VEZNma/yc1FDnQhDCTvnsZML7p7u9hndmVlWZ/wP6rRAjSoF
         q8H20DJI5ndfFdULUU0WdpatDZ5pHlaXTwNGzNW3qrN6IXTGcQffw+NM/NlbX8HRa+CM
         rAQVSEKkV436220SmU1TeyciTKg/oWERjAVwqME1oSH9J0Iv5CSouGCqlzhrnk/OTEGp
         i93wmZTWZxLze5M+/EYeLpggNjjGY9wKL9uQZudgpHzUETAMxL6kW/dGmF45egSLKLnH
         +QIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxKCQRN8kliMAds7bxWTjhzMHLjHvEjXGywgi7rr6WQ=;
        b=nQJBowVr9eiIc+H5mku5f0HteWsDQo2ZK7uZq5zoAw8P5n8+yZMDSNDyz4oQmZu+R2
         6pUcvASv42BZV+sdXgnzr5KtFsZyKFgja2MnYqONS0hKDFvDuw+YANaDQI9Elknuz3yC
         KxGgBcK3Xkh0Kp1rzap+OQfYYCx44Vg+CYCYYygztj3R1WtB72ZZcrCIHGeIL+zRlVnz
         oQ7er2HRla/Cg8jsZKRWJCXjRK8ra+IkzLxs4FF3canA2ZSp8FQNLJWZIVISzInkykzA
         gxhTpt3Tc5Dlon8u/0vndgJoaYaDIr3OnVuhbsCvMuA8BZWF/2BdWOvZeyOGmj91o2NH
         NxHw==
X-Gm-Message-State: AO0yUKWcQddGR5c6yZVkydwda6OzBfbQ4JQTE6slXW5HjbjkPYNQ9/ex
        c2ZPD/iJVvBsjuAwNclGFfkdkoZh35+KJcv/i/B5Kw==
X-Google-Smtp-Source: AK7set+00u4h+tFkq8Glzv8b9Z3L7I7jdWbbm+6ltv7HBmZJJqJvtilmdl7vCzM+yNUvcFDoJrAKD3a0h3t/rRZSoMU=
X-Received: by 2002:a0d:cc8c:0:b0:52f:3c7:e64c with SMTP id
 o134-20020a0dcc8c000000b0052f03c7e64cmr236460ywd.503.1676377971221; Tue, 14
 Feb 2023 04:32:51 -0800 (PST)
MIME-Version: 1.0
References: <20230213-sm6350-camcc-runtime_pm-v3-0-d35e0d833cc4@fairphone.com> <20230213-sm6350-camcc-runtime_pm-v3-1-d35e0d833cc4@fairphone.com>
In-Reply-To: <20230213-sm6350-camcc-runtime_pm-v3-1-d35e0d833cc4@fairphone.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Feb 2023 14:32:40 +0200
Message-ID: <CAA8EJprzOLuLU8_tvRtQ9bX8M9xOqMFFnjuj-DwGz+24XPAQFg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] clk: qcom: camcc-sm6350: add pm_runtime support
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 at 13:01, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> Make sure that we can enable and disable the power domains used for
> camcc when the clocks are and aren't used.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/clk/qcom/camcc-sm6350.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/camcc-sm6350.c b/drivers/clk/qcom/camcc-sm6350.c
> index acba9f99d960..fc5532e2ee5b 100644
> --- a/drivers/clk/qcom/camcc-sm6350.c
> +++ b/drivers/clk/qcom/camcc-sm6350.c
> @@ -7,6 +7,8 @@
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_clock.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>
>  #include <dt-bindings/clock/qcom,sm6350-camcc.h>
> @@ -1869,6 +1871,19 @@ MODULE_DEVICE_TABLE(of, camcc_sm6350_match_table);
>  static int camcc_sm6350_probe(struct platform_device *pdev)
>  {
>         struct regmap *regmap;
> +       int ret;
> +
> +       ret = devm_pm_runtime_enable(&pdev->dev);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = devm_pm_clk_create(&pdev->dev);
> +       if (ret < 0)
> +               return ret;

This makes me wonder, what is the use for the pm_clk in your case? The
driver doesn't seem to use of_pm_clk_add_clk(), of_pm_clk_add_clks()
or pm_clk_add_clk(). So pm_clk_suspend() and pm_clk_resume() do
nothing.

> +
> +       ret = pm_runtime_get(&pdev->dev);
> +       if (ret)
> +               return ret;
>
>         regmap = qcom_cc_map(pdev, &camcc_sm6350_desc);
>         if (IS_ERR(regmap))
> @@ -1879,14 +1894,22 @@ static int camcc_sm6350_probe(struct platform_device *pdev)
>         clk_agera_pll_configure(&camcc_pll2, regmap, &camcc_pll2_config);
>         clk_fabia_pll_configure(&camcc_pll3, regmap, &camcc_pll3_config);
>
> -       return qcom_cc_really_probe(pdev, &camcc_sm6350_desc, regmap);
> +       ret = qcom_cc_really_probe(pdev, &camcc_sm6350_desc, regmap);
> +       pm_runtime_put(&pdev->dev);
> +
> +       return ret;
>  }
>
> +static const struct dev_pm_ops camcc_pm_ops = {
> +       SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
> +};
> +
>  static struct platform_driver camcc_sm6350_driver = {
>         .probe = camcc_sm6350_probe,
>         .driver = {
>                 .name = "sm6350-camcc",
>                 .of_match_table = camcc_sm6350_match_table,
> +               .pm = &camcc_pm_ops,
>         },
>  };
>
>
> --
> 2.39.1
>


-- 
With best wishes
Dmitry
