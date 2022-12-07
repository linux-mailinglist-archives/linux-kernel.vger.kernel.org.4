Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2445645F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiLGQtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLGQtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:49:19 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4494858BD0;
        Wed,  7 Dec 2022 08:49:18 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id c2so10416540qko.1;
        Wed, 07 Dec 2022 08:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y18DIpbfCukk25TWC8zheO2SUvaGDQaONDYCY89KTGU=;
        b=SMK2V74sU8D3TcIrRaSUNwZYnaaTCeoM4k+ZcZTFw/ydUkhwZLbo1yEKDxUMIBS4gA
         iwNJGXqzS6w1suvYGlU8ecRhl6NNxEKbu7JAvBOIviytxXOltcSBfBeWp+TnxyBxXr9j
         aMWtjDuBUNQOGk7gO4jGnxDWTQ8/yXDvz53Y4z4R9i7/KWUTuiCGkDsrHLRa/o9SuTb7
         KqorQSVIORS6lv2KWgYWjY+eZry7XlEBoWrdcJ1POsluOkv3Gc8qESPlNGyPzJ94Jsq1
         5AvRk0IRxLOSHpjNN6gxt9LAglz7AWcGJObOYuX4CKqkCJ0dV+a7TLBA1pKfycAlJzKC
         YqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y18DIpbfCukk25TWC8zheO2SUvaGDQaONDYCY89KTGU=;
        b=mtKrzpYlOQ6xEDqaXzPNF4YAcmytXfDrb+h/1hUvV1GVXU2/uSmFYdqBl4H0gIYzq9
         wgmcWiAwFCYtG+yjdPyYXu3J83VPiev2NylKlotcMZKdVzaSOsqYt7/X18vgcm4zO+vY
         tn/6zrPdjBoJFNNqq4kh6r+ZQgd2mrIVukm3O9cltaN7sJL7vR/LNdj6o5k0T7Z5mmXM
         JD2Wgivev6TRLaldbkEBbhVkzb9PnywtADQj9XR4i3qgkb+EFITdXXPjK0K3rc/OFFcM
         PHTgcvkAfqp2K1W8nPlAhmC+19Ppoj0eD0JLxHbc1Ix/OVhLyvhcRSRAhPvPh8/OwBvr
         KkWQ==
X-Gm-Message-State: ANoB5pl5eOAT6pfydNLuQ8J29ogf6Gjn+LdqxbVVdT7zH9QjqMrm75Pp
        5wL6rcPRLapYiFhG3lcM55BEgyQee0RodUqFgmE=
X-Google-Smtp-Source: AA0mqf6Z3cBlsiKEerUxS5aa9mOeKvWW6A2uIvZwb1fbjWfE4NyTIrR4VodmXjDwbwquQncYrV7lhOxx/sjwJ4ekXxA=
X-Received: by 2002:a37:f504:0:b0:6cf:5fa1:15f8 with SMTP id
 l4-20020a37f504000000b006cf5fa115f8mr81140787qkk.748.1670431757330; Wed, 07
 Dec 2022 08:49:17 -0800 (PST)
MIME-Version: 1.0
References: <20221205085351.27566-1-tmaimon77@gmail.com> <20221205085351.27566-3-tmaimon77@gmail.com>
 <CAHp75VeAzgCUiH5Z1pVJ-4X29aCK44q907DRQXX75zS4oEhHHg@mail.gmail.com>
 <CAP6Zq1gi7-pA9wdO3=V9Uf0+pKPTHwWw66MfbYmOwodoXeRDqA@mail.gmail.com>
 <CAHp75VctiJvvk-6AWfQSU9psHvPeKECaCWPuKL9YQ_-Vt3GBGA@mail.gmail.com>
 <c200557f-c30a-62f9-287a-af804e818cf1@intel.com> <CAHp75VczbNpHPi-TBe81Ad=P=eXJZpAmkj=m4-apGF1e0uh5kg@mail.gmail.com>
 <CAHp75VemBiGUTspEYDe3hwA9pEzjNMQGY6_kUoVMJyCuEWgChw@mail.gmail.com>
 <c4e2a00c-d09e-95e2-eaf2-1de6b820ac6e@intel.com> <CAP6Zq1h9XvH501e_nH9TkUCKPNOuH7dhOM8FrsUM=PYX4gt0qw@mail.gmail.com>
 <CAHp75Vd5DzkCW0Gpouv+0Or=Yhjp_KdFGP-jXkpHD=UZrG2ajA@mail.gmail.com> <cae6475a-a1e9-ae57-6e64-59931f467050@intel.com>
In-Reply-To: <cae6475a-a1e9-ae57-6e64-59931f467050@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Dec 2022 18:48:41 +0200
Message-ID: <CAHp75VfVRa5m3WeEvMvGCRK7YRBD5BCxOL2DHDzyuQ1cD4J9UA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, ulf.hansson@linaro.org,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, openbmc@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Dec 7, 2022 at 3:49 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 7/12/22 15:25, Andy Shevchenko wrote:
> > On Wed, Dec 7, 2022 at 3:01 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> >> On Mon, 5 Dec 2022 at 16:33, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>> On 5/12/22 16:17, Andy Shevchenko wrote:
> >>>> On Mon, Dec 5, 2022 at 4:14 PM Andy Shevchenko
> >>>> <andy.shevchenko@gmail.com> wrote:
> >>>>> On Mon, Dec 5, 2022 at 3:41 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>>> On 5/12/22 15:25, Andy Shevchenko wrote:
> >>>>>>> On Mon, Dec 5, 2022 at 1:20 PM Tomer Maimon <tmaimon77@gmail.com> wrote:

...

> >>>>>>> devm_ is problematic in your case.
> >>>>>>> TL;DR: you need to use clk_get_optional() and clk_put().
> >>>>>>
> >>>>>> devm_ calls exactly those, so what is the issue?
> >>>>>
> >>>>> The issue is the error path or removal stage where it may or may be
> >>>>> not problematic. To be on the safe side, the best approach is to make
> >>>>> sure that allocated resources are being deallocated in the reversed
> >>>>> order. That said, the
> >>>>>
> >>>>> 1. call non-devm_func()
> >>>>> 2. call devm_func()
> >>>>>
> >>>>> is wrong strictly speaking.
> >>>>
> >>>> To elaborate more, the
> >>>>
> >>>> 1. call all devm_func()
> >>>> 2. call only non-devm_func()
> >>>>
> >>>> is the correct order.
> >>>
> >>> 1. WRT pltfm_host->clk, that is what is happening
> >>> 2. WRT other resources that is simply not always possible because not every resource is wrapped by devm_
> >>> e.g. mmc_alloc_host() / mmc_free_host()
> >> I little confused about what to decide, should I use only
> >> non-devm_func because mmc_alloc_host() / mmc_free_host() is not
> >> warrped with devm_?
> >
> > It is up to you how to proceed. I pointed out the problem with your
> > code which may or may not be fatal.
> >
> > If you want to solve it, there are several approaches:
> > 1) get rid of devm_ completely;
> > 2) properly shuffle the ordering in ->probe(), so all devm_ calls are
> > followed by non-devm_;
> > 3) wrap non-devm_ cals to become managed (see
> > devm_add_action_or_reset() approach);
> > 4) fix SDHCI / MMC layer by providing necessary devm_ calls and/or fix
> > sdhci_pltfm_register() to handle the clock.
>
> I can take care of sdhci_pltfm when I next have some time.
> Otherwise it looks OK to me, so I am acking it.

Thank you!

> > Personally, the list order is from the least, what I prefer, to the
> > most (i.o.w. I would like to see rather 4) than 1) to be implemented).
> >
> >>>> Hence in this case the driver can be worked around easily (by
> >>>> shuffling the order in ->probe() to call devm_ first), but as I said
> >>>> looking into implementation of the _unregister() I'm pretty sure that
> >>>> clock management should be in sdhci-pltfm, rather than in all callers
> >>>> who won't need the full customization.
> >>>>
> >>>> Hope this helps to understand my point.
> >>>>
> >>>>>>> Your ->remove() callback doesn't free resources in the reversed order
> >>>>>>> which may or, by luck, may not be the case of all possible crashes,
> >>>>>>> UAFs, races, etc during removal stage. All the same for error path in
> >>>>>>> ->probe().
> >>>>>
> >>>>> I also pointed out above what would be the outcome of neglecting this rule.

...

> >>>>>>>>> Why can't you use sdhci_pltfm_register()?
> >>>>>>>> two things are missing in sdhci_pltfm_register
> >>>>>>>> 1. clock.
> >>>>>>>
> >>>>>>> Taking into account the implementation of the corresponding
> >>>>>>> _unregister() I would add the clock handling to the _register() one.
> >>>>>>> Perhaps via a new member of the platform data that supplies the name
> >>>>>>> and index of the clock and hence all clk_get_optional() / clk_put will
> >>>>>>> be moved there.
> >> Do you mean to add it to sdhci_pltfm_register function? if yes I
> >> believe it will take some time to modify sdhci_pltfm_register
> >> I prefer not to use sdhci_pltfm_register.
> >
> > In the Linux kernel we are trying hard to avoid code duplication. Why
> > do you need it to be open coded? (Yes, I heard you, but somebody
> > should fix the issues with that funcion at some point, right?)
> >
> >>>>>>>> 2. Adding SDHCI_CAN_DO_8BIT capability according the eMMC capabilities.
> >>>>>>>
> >>>>>>> All the same, why can't platform data be utilised for this?

-- 
With Best Regards,
Andy Shevchenko
