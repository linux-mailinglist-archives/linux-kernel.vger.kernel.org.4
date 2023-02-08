Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CAD68E804
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjBHGFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBHGFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:05:21 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1A023C6B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 22:05:19 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so1237839pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 22:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NLHiM9iHrMUPA2U9+RDXtI5+2voe6qTBsZxm0AU5vWk=;
        b=nAnfys34bYLlhHpscHAOLy+SDz6itQ+Cpf5jrt3+7Fl6l8WuzZORY+d/AHEW1b+WXZ
         9PbTJ6GzgocQK3IeRRMln6NS8tBTEVc+OfP+curJiU5xd0geEq54oCGFV71w3858MLR4
         PIM12w+oBEEPlmi5s+RlOEIF1TXCIBn+mA+1q2yp1ns8mcyD6aqYnt1XyYFZ7fG/Z4J8
         gcCR+2dVmqjfqyCkQuISaV0/e6PFjHI6T9M8RUOTJENbCfsj7b9iAz4RirOkgy36Jpx3
         Ohro/OUuGeMpCJAyueACCkFVV1LMBss6Log7H7c+8TycGrnI6akq0kVROnWHaMFwZd4S
         vW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLHiM9iHrMUPA2U9+RDXtI5+2voe6qTBsZxm0AU5vWk=;
        b=l6WsiTwlIBCAGNSh1+M/aKtPyLfkmKzHwIyQ6m/o4Aq3LJ4ApG3XAp63Z6YRE2XeOT
         M6zVQqfMDgO2oOzOhlTIxb9vDzq961RVBIE9Z0y+Mut4qpQhD335ED6YnJNeEt/xwYW0
         mGRzIviGnXDNoNXGvnFXbDDkEpvXEF4eZhCg7jo0bV3moqbLsU8lMAKzhsDXqcAyMpED
         9pBjrvGHtBtEZdld3lG9T3TpXGXwlJNPQrh8hAi4YYv6ay6agFsTZp7wIGuILx+qMuoh
         vkjE76P8SmWfBj9PEdg9/eCuci7hedvYyqMF2hSxyuSiYRdTleOSwhLJl7dA6iVa8tH+
         n7lg==
X-Gm-Message-State: AO0yUKXqAxK4csQ9OWyGLqsotE71rNMRLRfcvQGeq/qDlZLgAoPQDCDm
        TjlGXiQlyHiPgkmhal/nvHjVTr25Pw6c2FDssjxBBw==
X-Google-Smtp-Source: AK7set+QPd5rkoPU0BAuWog1NDjuujjAB+BeX5qLWbYBa3zE9r7B5kW5wzpkt1VKBC89ybuuq+7oxh4cWiXoFusyKRo=
X-Received: by 2002:a17:90a:5a0e:b0:22c:2f61:72b9 with SMTP id
 b14-20020a17090a5a0e00b0022c2f6172b9mr404088pjd.105.1675836318562; Tue, 07
 Feb 2023 22:05:18 -0800 (PST)
MIME-Version: 1.0
References: <CGME20230203060905eucas1p20dc8b2dbf93ec2b0c604bd461afbae94@eucas1p2.samsung.com>
 <20230203060924.8257-1-semen.protsenko@linaro.org> <cc9734eb-4157-eea3-90a2-4f7eb36de744@samsung.com>
In-Reply-To: <cc9734eb-4157-eea3-90a2-4f7eb36de744@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 8 Feb 2023 00:05:27 -0600
Message-ID: <CAPLW+4=D2PR_ntbK+G6XSkWEXF4jm=wfnZE9ZQsi6pvdfQmkYw@mail.gmail.com>
Subject: Re: [PATCH 0/6] clk: samsung: Add PM support for ARM64 Exynos chips
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, 3 Feb 2023 at 08:33, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 03.02.2023 07:09, Sam Protsenko wrote:
> > In order to prepare for PM enablement in clk-exynos850, common PM code
> > was extracted from clk-exynos5433 to clk-exynos-arm64. Also some related
> > cleanups were done prior to that. More specifically:
> >
> >    - patches #1..5: cleanups
> >    - patch #6: PM code extraction
> >
> > During the extraction of the exynos5433_cmu_probe() content to
> > exynos_arm64_register_cmu_pm() some code was reworked a bit, and also
> > split into smaller functions. In particular:
> >
> >    - cmu_data structure now contains a pointer to ctx, which is now
> >      allocated in samsung_clk_init()
> >    - cmu_data structure initialization was moved into separate function
> >    - code for configuring gate clocks was added (optional)
> >
> > Which in turn resulted in somehow modified code of probe function:
> >
> >    Original
> >    --------
> >
> >      ...
> >      devm_platform_ioremap_resource(...);
> >      samsung_clk_init(...);
> >      exynos_arm64_cmu_prepare_pm(...);
> >      exynos_arm64_enable_bus_clk(...);
> >      platform_set_drvdata(...);
> >      ...
> >
> >    Modified
> >    --------
> >
> >      ...
> >      platform_set_drvdata(...);
> >      exynos_arm64_cmu_prepare_pm(...);
> >      exynos_arm64_enable_bus_clk(...);
> >      exynos_arm64_init_clocks(...);
> >      devm_platform_ioremap_resource(...);
> >      samsung_clk_init(...);
> >      ...
> >
> > That shouldn't really change the logic or mode of operation. It was
> > preliminary tested on Exynos850 based board, with some extra patches on
> > top of this series (will be submitted later).
> >
> > Marek, could you please test these patches on Exynos5433 platform, and
> > also review accordingly?
>
> I've tested and Exynos5433 still works fine after applying your changes.
> Btw, you should probably rebase your changes onto arm-soc tree (or
> recent linux-next), as there are some conflicts between your changes and
> the s3c24xx removal merged there.
>

Thanks, Marek! Will send v2 soon, which will be rebased on top of
soc/for-next tree.

> Feel free to add:
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>

I have some (small) functional changes in v2, so I guess it'll nice
ideally to re-test those first, if possible.

> I will try to review the individual patches on Monday though.
>
>
> > Thanks!
> >
> > Sam Protsenko (6):
> >    clk: samsung: Don't pass reg_base to samsung_clk_register_pll()
> >    clk: samsung: Remove np argument from samsung_clk_init()
> >    clk: samsung: Set dev in samsung_clk_init()
> >    clk: samsung: Extract clocks registration to common function
> >    clk: samsung: Extract parent clock enabling to common function
> >    clk: samsung: exynos5433: Extract PM support to common ARM64 layer
> >
> >   drivers/clk/samsung/clk-exynos-arm64.c   | 219 +++++++++++++++++++++--
> >   drivers/clk/samsung/clk-exynos-arm64.h   |   3 +
> >   drivers/clk/samsung/clk-exynos4.c        |   6 +-
> >   drivers/clk/samsung/clk-exynos4412-isp.c |   3 +-
> >   drivers/clk/samsung/clk-exynos5250.c     |   5 +-
> >   drivers/clk/samsung/clk-exynos5420.c     |   5 +-
> >   drivers/clk/samsung/clk-exynos5433.c     | 157 +---------------
> >   drivers/clk/samsung/clk-pll.c            |  11 +-
> >   drivers/clk/samsung/clk-s3c2410.c        |   6 +-
> >   drivers/clk/samsung/clk-s3c2412.c        |   5 +-
> >   drivers/clk/samsung/clk-s3c2443.c        |   6 +-
> >   drivers/clk/samsung/clk-s3c64xx.c        |   4 +-
> >   drivers/clk/samsung/clk-s5pv210.c        |   6 +-
> >   drivers/clk/samsung/clk.c                |  64 ++++---
> >   drivers/clk/samsung/clk.h                |  10 +-
> >   15 files changed, 282 insertions(+), 228 deletions(-)
> >
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
