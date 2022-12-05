Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBEA642A30
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiLEOS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiLEOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:18:25 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7246C13DF5;
        Mon,  5 Dec 2022 06:18:24 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id a27so11432108qtw.10;
        Mon, 05 Dec 2022 06:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7fDqf1wSMUKDLZsKxEzPDkS9hYvTku/z6Qoj5KCP6Qg=;
        b=ZHzIejlViGeY54HhY5Bx8HBEbu+yYY0qBUmZVOO0dCKIIZh/QofswS5ldWI4HAUyTQ
         zbxLu1RseU/06klPi/Ai7D5Zfs5gM7nYyEhx4clHyyfmDDVjMud70TeXMARy8M56OTQw
         aeG9PmCZ/y4EYMh545azDVC2h/eTg4cyOKdWzFdpIZnlzV6IwohIZawrn6aZAcrSJaWu
         uY41p7nlJO9FIkctBhevUliWExxUHoAvtlUUkJ4D5g19Sx3EQX3qrvQsI5ohDKMhpFJr
         beyTOrdie4le47fhAL8n27OosaXKaTfP6MKjtHbiDWdBFj4AejEsg3yY9jCMguq8FUYI
         FEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fDqf1wSMUKDLZsKxEzPDkS9hYvTku/z6Qoj5KCP6Qg=;
        b=7wyrqM4jLUu/0UawfV0OG/qBM+6kGAEuMoVVD6L9GsFvCtGkK1OSF3KJxkLx6QsFYG
         r/adM614edvQrsceNuXmcG/zNp+xx+IRnm329o5jlliTK7cU6o3u6YndNslQy9UDbiC0
         YVD7iL3cF5SQLyHR3Lamx6qwznslmfh++WhPeZ+8R9vhRePxxx82BJxT8QgojM7p74vi
         eg28TiNcuuZUNNW7PWdWNU5tBxI/611AFDeSLhR21Barhc6bifeTAq4p1L+p7E7J1yZw
         pAD3W5To58PhAfTS2v56ouZO9kTpDQsjZYOV7eM0+QCym8jDZkUfNJqbL4CjABXu6cQI
         4aWA==
X-Gm-Message-State: ANoB5pks3IJNdEB4VAgBd3vJc2bFCJz4sycGQ8/Hl/JpILDh/Uhy7LMM
        UXRMqfiO29B2xbteYu3Elh5kHI+f1B+JRTe2G4A=
X-Google-Smtp-Source: AA0mqf59ZojC+8guP4DOWysVR9Oon2vtcBP3NEkk9JfdPWQSphe/niF2Ax2JjO/G+vnghJZG91azo+9rNdbLa59usKc=
X-Received: by 2002:ac8:5501:0:b0:3a5:cb82:109b with SMTP id
 j1-20020ac85501000000b003a5cb82109bmr77193629qtq.61.1670249903499; Mon, 05
 Dec 2022 06:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20221205085351.27566-1-tmaimon77@gmail.com> <20221205085351.27566-3-tmaimon77@gmail.com>
 <CAHp75VeAzgCUiH5Z1pVJ-4X29aCK44q907DRQXX75zS4oEhHHg@mail.gmail.com>
 <CAP6Zq1gi7-pA9wdO3=V9Uf0+pKPTHwWw66MfbYmOwodoXeRDqA@mail.gmail.com>
 <CAHp75VctiJvvk-6AWfQSU9psHvPeKECaCWPuKL9YQ_-Vt3GBGA@mail.gmail.com>
 <c200557f-c30a-62f9-287a-af804e818cf1@intel.com> <CAHp75VczbNpHPi-TBe81Ad=P=eXJZpAmkj=m4-apGF1e0uh5kg@mail.gmail.com>
In-Reply-To: <CAHp75VczbNpHPi-TBe81Ad=P=eXJZpAmkj=m4-apGF1e0uh5kg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Dec 2022 16:17:47 +0200
Message-ID: <CAHp75VemBiGUTspEYDe3hwA9pEzjNMQGY6_kUoVMJyCuEWgChw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, openbmc@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 4:14 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Dec 5, 2022 at 3:41 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > On 5/12/22 15:25, Andy Shevchenko wrote:
> > > On Mon, Dec 5, 2022 at 1:20 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> > >> On Mon, 5 Dec 2022 at 12:54, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > >>> On Mon, Dec 5, 2022 at 10:54 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> ...
>
> > >>>> +       pltfm_host->clk = devm_clk_get_optional(&pdev->dev, NULL);
> > >>>
> > >>> You can't mix devm with non-devm in this way.
> > >> Can you explain what you mean You can't mix devm with non-devm in this
> > >> way, where is the mix?
> > >> In version 1 used devm_clk_get, is it problematic?
> > >
> > > devm_ is problematic in your case.
> > > TL;DR: you need to use clk_get_optional() and clk_put().
> >
> > devm_ calls exactly those, so what is the issue?
>
> The issue is the error path or removal stage where it may or may be
> not problematic. To be on the safe side, the best approach is to make
> sure that allocated resources are being deallocated in the reversed
> order. That said, the
>
> 1. call non-devm_func()
> 2. call devm_func()
>
> is wrong strictly speaking.

To elaborate more, the

1. call all devm_func()
2. call only non-devm_func()

is the correct order.

Hence in this case the driver can be worked around easily (by
shuffling the order in ->probe() to call devm_ first), but as I said
looking into implementation of the _unregister() I'm pretty sure that
clock management should be in sdhci-pltfm, rather than in all callers
who won't need the full customization.

Hope this helps to understand my point.

> > > Your ->remove() callback doesn't free resources in the reversed order
> > > which may or, by luck, may not be the case of all possible crashes,
> > > UAFs, races, etc during removal stage. All the same for error path in
> > > ->probe().
>
> I also pointed out above what would be the outcome of neglecting this rule.
>
> > >>>> +       if (IS_ERR(pltfm_host->clk))
> > >>>> +               return PTR_ERR(pltfm_host->clk);
> > >>>> +
> > >>>> +       ret = clk_prepare_enable(pltfm_host->clk);
> > >>>> +       if (ret)
> > >>>> +               return ret;
> > >>>> +
> > >>>> +       caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> > >>>> +       if (caps & SDHCI_CAN_DO_8BIT)
> > >>>> +               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> > >>>> +
> > >>>> +       ret = mmc_of_parse(host->mmc);
> > >>>> +       if (ret)
> > >>>> +               goto err_sdhci_add;
> > >>>> +
> > >>>> +       ret = sdhci_add_host(host);
> > >>>> +       if (ret)
> > >>>> +               goto err_sdhci_add;
> > >>>
> > >>> Why can't you use sdhci_pltfm_register()?
> > >> two things are missing in sdhci_pltfm_register
> > >> 1. clock.
> > >
> > > Taking into account the implementation of the corresponding
> > > _unregister() I would add the clock handling to the _register() one.
> > > Perhaps via a new member of the platform data that supplies the name
> > > and index of the clock and hence all clk_get_optional() / clk_put will
> > > be moved there.
> > >
> > >> 2. Adding SDHCI_CAN_DO_8BIT capability according the eMMC capabilities.
> > >
> > > All the same, why can't platform data be utilised for this?
> > >
> > >>>> +       return 0;
> > >>>> +
> > >>>> +err_sdhci_add:
> > >>>> +       clk_disable_unprepare(pltfm_host->clk);
> > >>>> +       sdhci_pltfm_free(pdev);
> > >>>> +       return ret;
> > >>>> +}
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
