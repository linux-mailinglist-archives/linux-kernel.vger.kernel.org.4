Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ABB6C1EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjCTSEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCTSDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:03:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880839EE1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:57:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id ix20so13355525plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679335045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TTLqYdGFZkGom4FYP+0l2YM3DyL4CPb+gNvcjA2sta8=;
        b=GGRc6NHuQPNvdJDi95tsj9Fdk98zaHEOdlFFVHCPwB77yfj5hO5wyG0vtfUn/RUfLn
         sv6LnNalBQnWQQZ8kgahN6tTrF0kCh2uHkmat5sxdpRSNyh5y9oT72mvSbEbSANW3XsO
         BcUSqICRFrhMxN/VNdP78YVQUJ1RIfHBdLJhRHPOMAB/PLH/+dzINbZRSPXqR4zJ9RXg
         TGy8odYm98NW+d8uMAd61KqopiHA8Uee8b9oN0TdfT7V0zUteKJzjWgdjjhnOGBW+8bN
         n3qQyFpUCn3FWIU8Zt/r6W3FNmiPWihhZWFHgiuzl9VmGTY0fuGoQ+OC8St99GJYn3ro
         MiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTLqYdGFZkGom4FYP+0l2YM3DyL4CPb+gNvcjA2sta8=;
        b=SqhVe5bq2Hc5w1IDKFeWZduHGDgRH251/PuMgd4Z0gux9Z7tVxPrBr4hqLd2ipSLgH
         n0fkXY3yTEkZmlpokjRhDJ47K1biula+TkGjt8MFVamcbndSzTXIKUqByvb3XOHnzeZO
         WGZ6cfebXzRf+zB4o59aPJYzIcuNF0RNRsJe+T3LebSAJwAzBUSKVgeMz2XuXDled6NF
         7KFy76yGiTZNoNyGdg4tMSmtpJTVJOZej8P1eqTVBEmTRtXUPwvSmFHmdLFzqbWg3/d7
         dh7JB9ZuTEj8Qq/nE068pqOZwyfOEY8N+58Cs2kRZZbkGchLrkaRU7lyWxCPScjDpWgv
         WCiA==
X-Gm-Message-State: AO0yUKVfUI3iCIO1yferpJfRkUZQdB3mWFaEG/VOrbqlqACabHrnsuUb
        9zGiFG64Sw8OvlGSiWit3+WhxLZDyMZ00ctQq+D6HQ==
X-Google-Smtp-Source: AK7set8/YwBWDFBpyHo0/hfquyhBJpFJp9n/0UHpqT5eybpBB6edSz10AhON/8lghXTurJ3D2NDuSZ4yQF7ho2AvGmA=
X-Received: by 2002:a17:90a:7ac8:b0:23d:4ab8:b1a3 with SMTP id
 b8-20020a17090a7ac800b0023d4ab8b1a3mr33238pjl.1.1679335045509; Mon, 20 Mar
 2023 10:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230308230935eucas1p1e919f4d4b020e3386ce0eac8b4c8d299@eucas1p1.samsung.com>
 <20230308230931.27261-1-semen.protsenko@linaro.org> <d1175c3e-301d-1cbc-607c-e94051780806@samsung.com>
 <611fe922-1937-d37d-a2ce-cc0a13aed9e0@linaro.org>
In-Reply-To: <611fe922-1937-d37d-a2ce-cc0a13aed9e0@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 20 Mar 2023 12:57:14 -0500
Message-ID: <CAPLW+4=Yd0KfaMp+oSA=rOrqJfUotHjB=QOKpaPitMh3V2fMrA@mail.gmail.com>
Subject: Re: [PATCH 0/6] soc: samsung: pm_domains: Add Exynos850 support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, 10 Mar 2023 at 08:41, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/03/2023 11:12, Marek Szyprowski wrote:
> > Hi Sam,
> >
> > On 09.03.2023 00:09, Sam Protsenko wrote:
> >> Power Domains in Exynos850 are not really different from other Exynos
> >> platforms. Enabling Exynos850 support in the PD driver is really just a
> >> matter of adding:
> >>
> >>      static const struct exynos_pm_domain_config exynos850_cfg = {
> >>          .local_pwr_cfg = 0x1,
> >>      };
> >>
> >> to the driver. But in the face of recent developments, e.g. this patch:
> >>
> >>      arm64: dts: exynos: move MIPI phy to PMU node in Exynos5433
> >>
> >> it looked logical to rework the PD driver a bit to support its nesting
> >> under the PMU node, while adding Exynos850 support to it. Initially I
> >> only wanted to add syscon regmap support via some dedicated property,
> >> but pulling PD nodes under the PMU syscon looks like more correct way.
> >
> > Frankly speaking if you are changing this, you can go even further.
> > Simply make PMU node a PM domain provider and specify the power domain
> > as a phandle parameter. This is how it should have been done from the
> > beginning, but for some unknown reasons wasn't. There is really no need
> > to have a separate node for each power domain. This will also move
> > implementation details to the PMU / power domain drivers and it will
> > make it much easier to extend/modify it in the future. IMHO same applies
> > for PHY nodes.
>
> I agree. The "samsung,pd-index" property is not a correct approach.
> Either you use address space or not. If not, then this should be part of
> power domain provider, which is also matching most of other SoC
> architectures.
>

Did a bit of research, looked at how it's implemented on other
platforms. Before I start reworking it, want to check with you on a
couple of decisions, to avoid unnecessary resubmissions later, if it's
ok:

1. Instead of actually merging PD driver into PMU driver, guess it
might be better to create a new power-controller driver (e.g.
drivers/soc/samsung/exynos-power.c). This is how it's implemented for
the most of platforms, and this way we can neatly separate it from
what we already have in the PMU driver (not really power controller
related things). This way, in device tree we'll have a
power-controller node under PMU node, and this node can be referenced
further as a phandle in power-domains properties of users.

2. After moving PD implementation into a new power-controller driver
(with new compatibility string), the old one (pm_domains.c) should be
probably removed. Is it reasonable, e.g. from point of view of
compatibility with out-of-tree (downstream) dts's? Also, if I remove
the PD driver, probably all existing (upstream) Exynos dts's should be
reworked to use the new power-controller compatibility string?

3. Where to keep offsets for each power domain (inside of PMU register
area). Can be done in dts (a separate child node of power-controller
for each power domain), or in the power-controller driver. I saw both
of those ways for different platforms actually. But I guess offsets
are more like internal details, and should be kept inside the driver,
for each supported SoC.

4. Specifying particular power domain in power-domains property. Guess
the best way would be to have some indexes defined in dt-bindings
header, and use those like this:

        power-domains = <&power_controller EXYNOS850_PD_G3D>;

   Those constants can be also used then in the driver, to keep PD
offsets in the array, etc. Another way would be to use reg offsets,
but indices look better: can provide more flexibility in the driver in
future, e.g. if we'd need to add some more details other that offsets
later.

Please let me know what you think. At the moment I have to switch to
another task temporarily. When I get back to this one, discussing the
above items would help me a great deal.

Thanks!

>
> Best regards,
> Krzysztof
>
