Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F256A0167
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjBWDHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjBWDHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:07:33 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36415474F6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:07:05 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id e21so10381226oie.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IsFwDXDFyAwgQgN7Ezx7sftsdxjHjlTMYKQ/wYMhb78=;
        b=LYqxKMnouYu+dT0bW6p/08eh4jCaQkaoyhaFcxvkvtnTfzDxG1y2Z/9DRZX6i1GC7V
         Cdo8AIq4N2MlbgqaTZ4cJj5JOtTyQ1fWn863StHyjchSiOPUFn/yONZHO8XPaatHM9sA
         o7W0TFCDXXNN5gZ1QTuUh2Q+zuVH23qrK1ouMPYfCml5Y5DrhDrkr9nW+OBw71GHcsQu
         OeEQmv1rKLoiknsFdQzFgJ59UZeqM8+7BfTfe1o8dYJl3mS0BZKD1+0K3weTVJ5YK0wF
         X+E2lG5qS9EG8l09dAxn6SJd6b/piYWzZpBIPQ/Np0VY/oSY2Rin6QVLURQeSPAVKlmP
         Pz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsFwDXDFyAwgQgN7Ezx7sftsdxjHjlTMYKQ/wYMhb78=;
        b=ISUZBqJswHB3ACZ6VDXQtqiFoEpqJpbfJUFqAVoAgYWEl3lMici7hh1WenR61mmy70
         eR8NmWQYMg1PwnRF4wy2GOvGk9CeI2W0/nxCtMYyiPZRnSawSfVt/QAuUJfLRHJDWk/R
         ZoatnXfgfVfHoHuGnXLaAKVy5CPGrjByMA2LcADlVoqNdI6j47AH+otglBmrxBikhxjI
         YaKtaNBWm3y2/5ELmBGx54+/qo2XcdKnaryzfO05V1rd8992Mkw7fyufs7u0dRSZor3w
         dmbv3TYi86vdADCIWdOSDThzLZOQaP0zJ4iUR/xu8Ovq28foC0Bp3fifgekqkBuzJ7sd
         ekOQ==
X-Gm-Message-State: AO0yUKVMkp1E3vaeUCahnj6RjJcYdtlST3ncbxGax9YSbJT+nCFab1Mu
        Bc/9zZUy+TsdNBvs7k+u8HBaZmy0bV4zUsvAKO8eBQ==
X-Google-Smtp-Source: AK7set/bRL8ou0SIq3OLr/c87FxzRtrMmLfqzNaV86gtbWiVwJCusOZBWjZSfPj1zOwVal0nGhV9hZTSLlo+b09gssU=
X-Received: by 2002:a05:6808:20a5:b0:37f:9ac7:826e with SMTP id
 s37-20020a05680820a500b0037f9ac7826emr1361934oiw.62.1677121622447; Wed, 22
 Feb 2023 19:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20230208234313.23863-1-semen.protsenko@linaro.org>
 <20230208234313.23863-7-semen.protsenko@linaro.org> <CGME20230219173642eucas1p1ddff7399223df763ff9fb48c4f7fc5f9@eucas1p1.samsung.com>
 <CAPLW+4=cOV8J+Ho1t8Tkg8X_3m4npyy3FUC2zcQAYywE12uEkw@mail.gmail.com> <ea0055c7-34d4-3da0-0d3a-52020a783922@samsung.com>
In-Reply-To: <ea0055c7-34d4-3da0-0d3a-52020a783922@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 22 Feb 2023 21:07:06 -0600
Message-ID: <CAPLW+4=pFb2HZ8bhAs9hfm_trXUUQCiS7zf8G+VBA-i0qpLJJQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] clk: samsung: exynos5433: Extract PM support to
 common ARM64 layer
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
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

On Tue, 21 Feb 2023 at 01:22, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 19.02.2023 18:36, Sam Protsenko wrote:
> > On Wed, 8 Feb 2023 at 17:43, Sam Protsenko <semen.protsenko@linaro.org> wrote:
> >> Exynos5433 clock driver implements PM support internally, which might be
> >> also useful for other Exynos clock drivers. Extract all PM related code
> >> from clk-exynos5433 to common ARM64 functions.
> >>
> >> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> >> ---
> >> Changes in v2:
> >>    - Rebased on top of latest soc/for-next tree
> >>    - Included linux/slab.h for kfree (found by kernel test robot)
> >>
> >>   drivers/clk/samsung/clk-exynos-arm64.c | 171 ++++++++++++++++++++++++-
> >>   drivers/clk/samsung/clk-exynos-arm64.h |   3 +
> >>   drivers/clk/samsung/clk-exynos5433.c   | 157 +----------------------
> >>   3 files changed, 175 insertions(+), 156 deletions(-)
> >>
> >> diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsung/clk-exynos-arm64.c
> >> index 2aa3f0a5644e..7ad7fd353dda 100644
> >> --- a/drivers/clk/samsung/clk-exynos-arm64.c
> >> +++ b/drivers/clk/samsung/clk-exynos-arm64.c
> >> @@ -10,6 +10,9 @@
> >>    */
> > Hi Marek,
> >
> > It just occurred to me that as I'm pulling your code from
> > clk-exynos5433.c here, I should've probably added you to this file's
> > author list in the header comment. Does that sound right to you? If
> > so, I can re-send v3 with fixes.
>
> Fine for me.
>
> > Also, could you please review this series, if possible? I'm working
> > right now on PM_DOMAINS support for Exynos850, so along with this
> > series that would bring the initial PM support for ARM64 Exynos chips.
>
> Well, feel free to add:
>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> to v3 (the whole patchset).
>

Thanks, Marek!

> The only remark I have is not strictly related to this patchset, but the
> code that is already in drivers/clk/samsung/clk-exynos-arm64.c. Playing
> with GATE_ENABLE_HWACG/GATE_MANUAL is not strictly specific to all
> Exynos ARM64 SoCs. GATE_OFF_START/GATE_OFF_END and the enable register
> bits are something specific to recent Exynos SoCs (like 7885/850/auto9)
> and don't fit well into the generic arm64 clk PM code, but I don't have
> a good idea how to move it to the respective clk drivers and keep it simple.
>

Yeah, maybe having some sort of HW variants would be a better choice.
That can be implemented later. I suggest we wait a bit first (after
applying this series) and see if there going be any new users for that
PM code. Once we gather more knowledge about current platforms (or
no), the desired design decisions should become more obvious.

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
