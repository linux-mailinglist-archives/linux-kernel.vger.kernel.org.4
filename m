Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C68645AE2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLGN0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiLGN0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:26:23 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E135358BF1;
        Wed,  7 Dec 2022 05:26:04 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id p18so9951994qkg.2;
        Wed, 07 Dec 2022 05:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gasjj2Warc1QIbknNKNkywz6J4OpsWmMf8ktNJGJzxM=;
        b=bIHdWFbwnlgZ9X7ycTDJihFthCsDpZiozQ8aRPo5JuLh15PEb9zZRUQK8qp8nDk0Vz
         JfuW+6fXd6v1zosJUbmBo1DSHPZzrgeQ4NH/RuGTFXM+l6tzYjFEJMqAyK/DnvtK+WRG
         hYaFKDNCwaycPkz7L9zlXE/Dh2jw9yLebTR8VYUV0c2DQ5oY9Q/X4PuouvFypRwhA5Wx
         USwVkgVJOjDKx/mSlCC/Kr/dZi+q8x8bV3j/UfJaDxQ/ivdISebJdeQQlFG1qs5GNxHU
         M33kyTUKZI9LbjBWr9Icf107BKr2qSF8tmIgdHAQyMvy3YmTtB8gmVUXeCoUjH5wwazP
         ivxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gasjj2Warc1QIbknNKNkywz6J4OpsWmMf8ktNJGJzxM=;
        b=tyaC/cwwQYvyUMX3VAeYh0jZ++iXHrLp7jNpQVg60nMI0i1aIIp23y6W+LBZOFbyEP
         jKm5FgN+vBNdNG8idp1T7TIRAts3SifyM+b3V0/qCc02WK3LHrLw/eQnqjloBoMar6Cd
         lUrGDc/lIoumo3rIXZ+ZHQVGbDic72k2TDKu5S9x5VVS0IoiVXDmvjUYvjy+dwixf/t/
         fdkWk0E819eS9nx6Y91ijx9QAkWA0lMiy1TsM04Cqu3Td2BXso3qNqGMtB4Kd2vQJu/6
         Z6WmvWMGAa9LANOT0+oCHcBCD8uLd2k6m9dcgdkz3ogTMI/CA3Btt5zGPJwnUA9LZqTp
         Tydg==
X-Gm-Message-State: ANoB5plb6nHO5+JNgZMC9lfSJR3QtqIa5AIHUv+s24/l29en8tzBoSbC
        ww5e1SIIND/dg/HisQ4VYM9zfc2l6NqTqcrZRbU=
X-Google-Smtp-Source: AA0mqf5RnWnS+hISdVDsA/In+NITv+EGTmDYWDSf+CwqqDeU+RkT3eKO4lbUN9HJ6WbQczEee6OKmp48cqrdxu9QXDs=
X-Received: by 2002:a05:620a:1aa3:b0:6fa:b56f:7ede with SMTP id
 bl35-20020a05620a1aa300b006fab56f7edemr80678604qkb.383.1670419563989; Wed, 07
 Dec 2022 05:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20221205085351.27566-1-tmaimon77@gmail.com> <20221205085351.27566-3-tmaimon77@gmail.com>
 <CAHp75VeAzgCUiH5Z1pVJ-4X29aCK44q907DRQXX75zS4oEhHHg@mail.gmail.com>
 <CAP6Zq1gi7-pA9wdO3=V9Uf0+pKPTHwWw66MfbYmOwodoXeRDqA@mail.gmail.com>
 <CAHp75VctiJvvk-6AWfQSU9psHvPeKECaCWPuKL9YQ_-Vt3GBGA@mail.gmail.com>
 <c200557f-c30a-62f9-287a-af804e818cf1@intel.com> <CAHp75VczbNpHPi-TBe81Ad=P=eXJZpAmkj=m4-apGF1e0uh5kg@mail.gmail.com>
 <CAHp75VemBiGUTspEYDe3hwA9pEzjNMQGY6_kUoVMJyCuEWgChw@mail.gmail.com>
 <c4e2a00c-d09e-95e2-eaf2-1de6b820ac6e@intel.com> <CAP6Zq1h9XvH501e_nH9TkUCKPNOuH7dhOM8FrsUM=PYX4gt0qw@mail.gmail.com>
In-Reply-To: <CAP6Zq1h9XvH501e_nH9TkUCKPNOuH7dhOM8FrsUM=PYX4gt0qw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Dec 2022 15:25:27 +0200
Message-ID: <CAHp75Vd5DzkCW0Gpouv+0Or=Yhjp_KdFGP-jXkpHD=UZrG2ajA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
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

On Wed, Dec 7, 2022 at 3:01 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> On Mon, 5 Dec 2022 at 16:33, Adrian Hunter <adrian.hunter@intel.com> wrote:
> > On 5/12/22 16:17, Andy Shevchenko wrote:
> > > On Mon, Dec 5, 2022 at 4:14 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > >> On Mon, Dec 5, 2022 at 3:41 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > >>> On 5/12/22 15:25, Andy Shevchenko wrote:
> > >>>> On Mon, Dec 5, 2022 at 1:20 PM Tomer Maimon <tmaimon77@gmail.com> wrote:

...

> > >>>> devm_ is problematic in your case.
> > >>>> TL;DR: you need to use clk_get_optional() and clk_put().
> > >>>
> > >>> devm_ calls exactly those, so what is the issue?
> > >>
> > >> The issue is the error path or removal stage where it may or may be
> > >> not problematic. To be on the safe side, the best approach is to make
> > >> sure that allocated resources are being deallocated in the reversed
> > >> order. That said, the
> > >>
> > >> 1. call non-devm_func()
> > >> 2. call devm_func()
> > >>
> > >> is wrong strictly speaking.
> > >
> > > To elaborate more, the
> > >
> > > 1. call all devm_func()
> > > 2. call only non-devm_func()
> > >
> > > is the correct order.
> >
> > 1. WRT pltfm_host->clk, that is what is happening
> > 2. WRT other resources that is simply not always possible because not every resource is wrapped by devm_
> > e.g. mmc_alloc_host() / mmc_free_host()
> I little confused about what to decide, should I use only
> non-devm_func because mmc_alloc_host() / mmc_free_host() is not
> warrped with devm_?

It is up to you how to proceed. I pointed out the problem with your
code which may or may not be fatal.

If you want to solve it, there are several approaches:
1) get rid of devm_ completely;
2) properly shuffle the ordering in ->probe(), so all devm_ calls are
followed by non-devm_;
3) wrap non-devm_ cals to become managed (see
devm_add_action_or_reset() approach);
4) fix SDHCI / MMC layer by providing necessary devm_ calls and/or fix
sdhci_pltfm_register() to handle the clock.

Personally, the list order is from the least, what I prefer, to the
most (i.o.w. I would like to see rather 4) than 1) to be implemented).

> > > Hence in this case the driver can be worked around easily (by
> > > shuffling the order in ->probe() to call devm_ first), but as I said
> > > looking into implementation of the _unregister() I'm pretty sure that
> > > clock management should be in sdhci-pltfm, rather than in all callers
> > > who won't need the full customization.
> > >
> > > Hope this helps to understand my point.
> > >
> > >>>> Your ->remove() callback doesn't free resources in the reversed order
> > >>>> which may or, by luck, may not be the case of all possible crashes,
> > >>>> UAFs, races, etc during removal stage. All the same for error path in
> > >>>> ->probe().
> > >>
> > >> I also pointed out above what would be the outcome of neglecting this rule.

...

> > >>>>>> Why can't you use sdhci_pltfm_register()?
> > >>>>> two things are missing in sdhci_pltfm_register
> > >>>>> 1. clock.
> > >>>>
> > >>>> Taking into account the implementation of the corresponding
> > >>>> _unregister() I would add the clock handling to the _register() one.
> > >>>> Perhaps via a new member of the platform data that supplies the name
> > >>>> and index of the clock and hence all clk_get_optional() / clk_put will
> > >>>> be moved there.
> Do you mean to add it to sdhci_pltfm_register function? if yes I
> believe it will take some time to modify sdhci_pltfm_register
> I prefer not to use sdhci_pltfm_register.

In the Linux kernel we are trying hard to avoid code duplication. Why
do you need it to be open coded? (Yes, I heard you, but somebody
should fix the issues with that funcion at some point, right?)

> > >>>>> 2. Adding SDHCI_CAN_DO_8BIT capability according the eMMC capabilities.
> > >>>>
> > >>>> All the same, why can't platform data be utilised for this?

-- 
With Best Regards,
Andy Shevchenko
