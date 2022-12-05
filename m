Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658C4642953
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiLEN0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiLEN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:26:32 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD08F1C915;
        Mon,  5 Dec 2022 05:26:31 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id r19so11329753qtx.6;
        Mon, 05 Dec 2022 05:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fqO7gETqNiqkQHJ70u+gRoEEZZbEF0uchp8/3StvR/w=;
        b=qC4qOoUiygaHcIcrhaQHV710EKKfWWefLKnQ3oKru+iD1vRQ7OAPRvSKvSYJjLTVEx
         GB6THHRMOgPyolYORzCLGm1kOMUfPLP2w7pTn59xzaoFM3WfNFpsrUsF8K8eOxlQUyFi
         k4mqiqqWZTLNiDQbj426UMKLz7jVgRlSivyo6kyG5KbM08UiKPN863qcBfbg+Tb3paQv
         H7iX82FtdhXY/nHWCwT+cythGxdJDtkkOf888FJmUFEeZ4njbfJvhti18TaGd7g9zZh+
         Qu6uSWYi5wpwzm9prkw9yAKqBWMgpGOWbmXVbGPHMJciqA5RzTEFcApOrzFPS0ZD82nf
         J50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqO7gETqNiqkQHJ70u+gRoEEZZbEF0uchp8/3StvR/w=;
        b=0+6i5dMReb/Hm9L1l/5Erm9UFp+qOwN290tCi9Hs0ibR27IRk5Wzg8NV7t/hJlLRnO
         tKf2xBfLtiA7MFpk654adG2OVVpsQi39FwBwxc0HcuOah081q63jkJRTashEXfTe3ZWK
         T/o2YyCvxi/y9E9deA2xoAbhUmEukZyE1doaTCVHJUNbsEv7QdSfUGtfthsFIpQ2aPX+
         hdXDSjaGRalRKKxPpyaY/PoZMUyQN/Zoj5msPEs9RZcj5iSFxMOpg1nUI+J4JAktzsbi
         hFOtYIOXIGWXVMOzThVGRM0hHXk/jEOed5g7Q3XazZwoRWow4BrPzhtpNmVqEaEpohIc
         NZeg==
X-Gm-Message-State: ANoB5pmA4NocaJLHvrnvfII7ELpseE5NMwn8QNFktCWoV20jJRWNG61B
        UIRfmFI0paflIQ0mRSrJnlSL74HsIF+sEnYpQBs=
X-Google-Smtp-Source: AA0mqf4dvL/+Sat88nAYdYD7lP5p89SnGizPGaaXtTpRp9ieg6LHpcABFhjTocjv4QvpR07o/YZlNOMmACR1oMaJBY4=
X-Received: by 2002:ac8:5501:0:b0:3a5:cb82:109b with SMTP id
 j1-20020ac85501000000b003a5cb82109bmr76982863qtq.61.1670246790901; Mon, 05
 Dec 2022 05:26:30 -0800 (PST)
MIME-Version: 1.0
References: <20221205085351.27566-1-tmaimon77@gmail.com> <20221205085351.27566-3-tmaimon77@gmail.com>
 <CAHp75VeAzgCUiH5Z1pVJ-4X29aCK44q907DRQXX75zS4oEhHHg@mail.gmail.com> <CAP6Zq1gi7-pA9wdO3=V9Uf0+pKPTHwWw66MfbYmOwodoXeRDqA@mail.gmail.com>
In-Reply-To: <CAP6Zq1gi7-pA9wdO3=V9Uf0+pKPTHwWw66MfbYmOwodoXeRDqA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Dec 2022 15:25:55 +0200
Message-ID: <CAHp75VctiJvvk-6AWfQSU9psHvPeKECaCWPuKL9YQ_-Vt3GBGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     ulf.hansson@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, adrian.hunter@intel.com,
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

On Mon, Dec 5, 2022 at 1:20 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> On Mon, 5 Dec 2022 at 12:54, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Dec 5, 2022 at 10:54 AM Tomer Maimon <tmaimon77@gmail.com> wrote:

...

> > > +#include <linux/clk.h>
> > > +#include <linux/err.h>
> > > +#include <linux/io.h>
> > > +#include <linux/mmc/host.h>
> > > +#include <linux/mmc/mmc.h>
> > > +#include <linux/module.h>
> >
> > I guess platform_device.h is missing here.
> Build and work without platform_device.h, do I need it for module use?

The rule of thumb is to include headers we are the direct user of. I
believe you have a data type and API that are defined in that header.

...

> > > +static int npcm_sdhci_probe(struct platform_device *pdev)
> > > +{
> > > +       struct sdhci_pltfm_host *pltfm_host;
> > > +       struct sdhci_host *host;
> > > +       u32 caps;
> > > +       int ret;
> > > +
> > > +       host = sdhci_pltfm_init(pdev, &npcm_sdhci_pdata, 0);
> > > +       if (IS_ERR(host))
> > > +               return PTR_ERR(host);
> > > +
> > > +       pltfm_host = sdhci_priv(host);
> >
> > > +       pltfm_host->clk = devm_clk_get_optional(&pdev->dev, NULL);
> >
> > You can't mix devm with non-devm in this way.
> Can you explain what you mean You can't mix devm with non-devm in this
> way, where is the mix?
> In version 1 used devm_clk_get, is it problematic?

devm_ is problematic in your case.
TL;DR: you need to use clk_get_optional() and clk_put().

Your ->remove() callback doesn't free resources in the reversed order
which may or, by luck, may not be the case of all possible crashes,
UAFs, races, etc during removal stage. All the same for error path in
->probe().

> > > +       if (IS_ERR(pltfm_host->clk))
> > > +               return PTR_ERR(pltfm_host->clk);
> > > +
> > > +       ret = clk_prepare_enable(pltfm_host->clk);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> > > +       if (caps & SDHCI_CAN_DO_8BIT)
> > > +               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> > > +
> > > +       ret = mmc_of_parse(host->mmc);
> > > +       if (ret)
> > > +               goto err_sdhci_add;
> > > +
> > > +       ret = sdhci_add_host(host);
> > > +       if (ret)
> > > +               goto err_sdhci_add;
> >
> > Why can't you use sdhci_pltfm_register()?
> two things are missing in sdhci_pltfm_register
> 1. clock.

Taking into account the implementation of the corresponding
_unregister() I would add the clock handling to the _register() one.
Perhaps via a new member of the platform data that supplies the name
and index of the clock and hence all clk_get_optional() / clk_put will
be moved there.

> 2. Adding SDHCI_CAN_DO_8BIT capability according the eMMC capabilities.

All the same, why can't platform data be utilised for this?

> > > +       return 0;
> > > +
> > > +err_sdhci_add:
> > > +       clk_disable_unprepare(pltfm_host->clk);
> > > +       sdhci_pltfm_free(pdev);
> > > +       return ret;
> > > +}

-- 
With Best Regards,
Andy Shevchenko
