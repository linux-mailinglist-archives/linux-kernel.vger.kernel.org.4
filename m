Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC044642A27
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiLEOPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLEOPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:15:18 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F34DF09;
        Mon,  5 Dec 2022 06:15:17 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id g10so5003853qkl.6;
        Mon, 05 Dec 2022 06:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ETRLBr7m2UGmCQXe683KOxNheUD/IYWYoya+6Nn/uo=;
        b=d44SgSjlGvYyzFMai6sJSkp4cLcI9vtSwmIU5gPpLuZ2gk5eDt7or6p38k+Zku6Szs
         u6hC3TnhtfPDZBM5LZPcTNins2JdhZ/qwsPv1vqsvIsHKKyQjVcn5lQ7e4PJyssBkNx1
         AIcCnCS4HjLRBl8k765TGR9sypcbyl4YXdEDxpot58dMkvrtMqYCG//k+o2+Jwd+jPjQ
         STq3i2cKOGvZe+YBvA/HoYhZ7S1Ucfc0raY/HI5GMecw7yYx+PVzgyuAYh1782iMT4qH
         gHgszg5LwiOOKwQgGQpWfYWE+nnpT6wtsJyTrwi9qqWy1TtBBPyEyRTQpDMly5ykgMqR
         UUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ETRLBr7m2UGmCQXe683KOxNheUD/IYWYoya+6Nn/uo=;
        b=zBsUGqm6yuXLz/QZ5U/iKYXCGuZggS1PqBXvd5o5NSHQR7eXYKMGGdMcaVXaypRWTh
         kotfs0tAEit9bI0cVNKvfOB2fojFCCLhgG5H2dRZJiVfXFFnZQiu1Btk8pHpERPmC4kv
         qMHx0RgatrKYI6UvX2YQvngZaiUBoPdAW2nJFr71vQL48kCBwY5MWRLXtb09NqmdaJZk
         y98tbr+Pmx0FRVYFH4B6PW71icMBxDqkZqQBIb5ilCT2qkog4D2HePmR90QAcfzcMyTy
         KeDxK/Kq50xwqh4/8E1BI1nFPlL9AHOyxN3ufHe2YURWjfDG5/hPGkGnYGZ8NqeRVyt3
         u+5w==
X-Gm-Message-State: ANoB5pkhWOWes6VHAkDyf76UNz/dfWVf3Y1vp70lbP0dIUTBtoes1uCD
        mGhROVnuB4hCq/GS4+hJQTttUfJXSuJvVzywREk=
X-Google-Smtp-Source: AA0mqf7AQnWAIYBmTV2Xhgr/VzCxgXbQBlsZRglqcMfEIxw+36nUNhCIgmcpZkRhRl695byUDZO8I+ImQRD/0FJk/sI=
X-Received: by 2002:a05:620a:21ce:b0:6fa:d149:6d47 with SMTP id
 h14-20020a05620a21ce00b006fad1496d47mr57027718qka.734.1670249716789; Mon, 05
 Dec 2022 06:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20221205085351.27566-1-tmaimon77@gmail.com> <20221205085351.27566-3-tmaimon77@gmail.com>
 <CAHp75VeAzgCUiH5Z1pVJ-4X29aCK44q907DRQXX75zS4oEhHHg@mail.gmail.com>
 <CAP6Zq1gi7-pA9wdO3=V9Uf0+pKPTHwWw66MfbYmOwodoXeRDqA@mail.gmail.com>
 <CAHp75VctiJvvk-6AWfQSU9psHvPeKECaCWPuKL9YQ_-Vt3GBGA@mail.gmail.com> <c200557f-c30a-62f9-287a-af804e818cf1@intel.com>
In-Reply-To: <c200557f-c30a-62f9-287a-af804e818cf1@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Dec 2022 16:14:40 +0200
Message-ID: <CAHp75VczbNpHPi-TBe81Ad=P=eXJZpAmkj=m4-apGF1e0uh5kg@mail.gmail.com>
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

On Mon, Dec 5, 2022 at 3:41 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 5/12/22 15:25, Andy Shevchenko wrote:
> > On Mon, Dec 5, 2022 at 1:20 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> >> On Mon, 5 Dec 2022 at 12:54, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >>> On Mon, Dec 5, 2022 at 10:54 AM Tomer Maimon <tmaimon77@gmail.com> wrote:

...

> >>>> +       pltfm_host->clk = devm_clk_get_optional(&pdev->dev, NULL);
> >>>
> >>> You can't mix devm with non-devm in this way.
> >> Can you explain what you mean You can't mix devm with non-devm in this
> >> way, where is the mix?
> >> In version 1 used devm_clk_get, is it problematic?
> >
> > devm_ is problematic in your case.
> > TL;DR: you need to use clk_get_optional() and clk_put().
>
> devm_ calls exactly those, so what is the issue?

The issue is the error path or removal stage where it may or may be
not problematic. To be on the safe side, the best approach is to make
sure that allocated resources are being deallocated in the reversed
order. That said, the

1. call non-devm_func()
2. call devm_func()

is wrong strictly speaking.

> > Your ->remove() callback doesn't free resources in the reversed order
> > which may or, by luck, may not be the case of all possible crashes,
> > UAFs, races, etc during removal stage. All the same for error path in
> > ->probe().

I also pointed out above what would be the outcome of neglecting this rule.

> >>>> +       if (IS_ERR(pltfm_host->clk))
> >>>> +               return PTR_ERR(pltfm_host->clk);
> >>>> +
> >>>> +       ret = clk_prepare_enable(pltfm_host->clk);
> >>>> +       if (ret)
> >>>> +               return ret;
> >>>> +
> >>>> +       caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> >>>> +       if (caps & SDHCI_CAN_DO_8BIT)
> >>>> +               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> >>>> +
> >>>> +       ret = mmc_of_parse(host->mmc);
> >>>> +       if (ret)
> >>>> +               goto err_sdhci_add;
> >>>> +
> >>>> +       ret = sdhci_add_host(host);
> >>>> +       if (ret)
> >>>> +               goto err_sdhci_add;
> >>>
> >>> Why can't you use sdhci_pltfm_register()?
> >> two things are missing in sdhci_pltfm_register
> >> 1. clock.
> >
> > Taking into account the implementation of the corresponding
> > _unregister() I would add the clock handling to the _register() one.
> > Perhaps via a new member of the platform data that supplies the name
> > and index of the clock and hence all clk_get_optional() / clk_put will
> > be moved there.
> >
> >> 2. Adding SDHCI_CAN_DO_8BIT capability according the eMMC capabilities.
> >
> > All the same, why can't platform data be utilised for this?
> >
> >>>> +       return 0;
> >>>> +
> >>>> +err_sdhci_add:
> >>>> +       clk_disable_unprepare(pltfm_host->clk);
> >>>> +       sdhci_pltfm_free(pdev);
> >>>> +       return ret;
> >>>> +}


-- 
With Best Regards,
Andy Shevchenko
