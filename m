Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0342760CD42
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiJYNSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiJYNS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:18:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A560E4E64
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:18:27 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b29so7347251pfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J8iBlKsLRePu8lxeGZNajhb3cTDeiUEJCk/+foleLtE=;
        b=F2g+U3MIymcr3dy7K3a7VGX7/VsGlDl+sjNOuT90x/XOtQ/k0IYtJoC8W5oQZS1qg4
         ZhDGhUrDa085/cjO/WleqObr3pwVjr44tZLR2hBspLRyvzVJVhAX0n60E2TANBr4RUaS
         Qe6UEwceOwpnpy/KxjF1wRxo1Nlc+Hk65tcBXdNfdMiW3wSD4LrK/0a3UB7YzdXcQZCh
         gJhZ8Ol/X8R4BS6LsnBpzFC0VYqHta9gFz85+z5xe1dXNTn3XWpByt8BQEXc0Br64qCM
         fiL+GTNC7oUz/XtlA5psGQD9/WEpbwFZrTFwZqXsD5kD//8mXM0Jbf6Da/kRLi/GPlhB
         jsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8iBlKsLRePu8lxeGZNajhb3cTDeiUEJCk/+foleLtE=;
        b=RfJJelsqoVieH2T8A/XWhY6HHbo6PDCN1yNNBlfcbKC+fDS1X4R3dH5xNFGjd7zUzx
         HUyKFHU0TWVrdj4mZ9INdTbaRfTldEVfhysxlZsJXRVpUR0g3Ru+dlB4MWH8kzTol7cK
         vMi0XJjGQMMfTy/29DwJi8qLY3HtdaEk6vIPEoNQ4RoU4piQZrxhCIAk8k1m84gXAvRe
         /yXDdRdghy6soDK6VH8DJ1xEn0UKfUsZs0CG+u4BfS8ypb3HXQj2qmOHsYxNaTcHpwpy
         C6aclauqvdWdwTSZjAxTWks1UJxtFeEA9y97wDpZJZ0XJTzWxLA1cQ9AwbGzHFqpdZzS
         LOwg==
X-Gm-Message-State: ACrzQf0ZoGJpPI2AEEPe1FtzUgVlkyY0KK5PzrsuhGwDqQ5gYv+FDvEF
        H7oHbFrjcyO6o7S2g0puzDyVwxhUFZitIMxqW2nC4A==
X-Google-Smtp-Source: AMsMyM6oe8u33WL7gbbjZJ0AfgfwnLmB4YCqjQEdI/GORqNhLNw1ggdtAwwdYKmzQxFKRJum9UW9SSr3clLixLnRXPQ=
X-Received: by 2002:a63:1612:0:b0:461:4180:d88b with SMTP id
 w18-20020a631612000000b004614180d88bmr33596437pgl.434.1666703907223; Tue, 25
 Oct 2022 06:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221020115513.93809-1-ulf.hansson@linaro.org> <CAJZ5v0iPaP60OxzS4RQv8-JO1-cuv=JAW8zHwjCbyVXgLDa-RA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iPaP60OxzS4RQv8-JO1-cuv=JAW8zHwjCbyVXgLDa-RA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Oct 2022 15:17:50 +0200
Message-ID: <CAPDyKFpo_JhpGRZwJExMxPoit7yzp_LByfUEbkkLZxgUdNGRFw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Extend information in log about OSI/PC mode
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 at 15:16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 20, 2022 at 1:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > It's useful to understand whether we are using OS-initiated (OSI) mode or
> > Platform Coordinated (PC) mode, when initializing the CPU PM domains.
> > Therefore, let's extend the print in the log after a successful probe with
> > this information.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > index 821984947ed9..c80cf9ddabd8 100644
> > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > @@ -181,7 +181,8 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
> >         if (ret)
> >                 goto remove_pd;
> >
> > -       pr_info("Initialized CPU PM domain topology\n");
> > +       pr_info("Initialized CPU PM domain topology using %s mode\n",
> > +               use_osi ? "OSI" : "PC");
> >         return 0;
> >
> >  put_node:
> > --
>
> Am I expected to pick up this one?

Yes, please!

Kind regards
Uffe
