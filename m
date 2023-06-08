Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFB8727F5A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjFHLrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbjFHLqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:46:49 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188BF3594
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:46:19 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba829e17aacso630213276.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686224778; x=1688816778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UtSk9xDn8CsZW/wCpBfq6RyeGmVvXlUwVu3BaunqnL4=;
        b=RcD9LjhuC/OPsU25KsUoWP0yPXGB8Y1IRUigOs6+zhTPTJubZR1d7bobRYsDB1PXry
         rpO9hJ89Tp9nP04kruB7YAHGLUaXTKQbe6Gkikd+8eBILh0Y9teKYC3aDYhBYFih+x+2
         zbWEJ7m6wjixKAcLmw2yM9HEG3YFEYptS+Dngj6mWNI0kiWFCyLKp1iZ3leJr57Ye4w6
         k7i5fuDXguYAS5fvTLG1vEIWpwOJ4przqqOg/Bnkui7zGkigshcXEd9PfSOpReA6YbRs
         gQLgciZpcLBCEQ++j+vHT9GSj/KTbWB+HCSXIZfRUyAUFuj16t+woe221GDUTKT73zhl
         YU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686224778; x=1688816778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtSk9xDn8CsZW/wCpBfq6RyeGmVvXlUwVu3BaunqnL4=;
        b=Jm7646vOnt5sBJu9TX457hy8q+nrhc6cadIc1OwQ3Bz6dsZLGmZH1IQNTjFXomSdMN
         06IBButSCM2nnamJYHbxQVhjzZU2jQMWV2T+qjTYnU8aPFbeFPeC+580plhYX7F4TN52
         w5xHyx1BBWgXPy1Xxuzcoh/KOMZraxmTJ68BWKc21B8qYnkpBRVwIi+3nqxr4lAzywEZ
         OBbYFikxbZ42jYdVw6LXH2nf4BChOBd9va7TN7bwGFPPii9K1HuqmgmUJK3g95Rs0I1x
         oq9b3khNyoKNr+Q8HCZfSrTNZNaHML/LMY32BXSTd0wE2t3Vx5Synm6i9KIgP4szkG4n
         5M3A==
X-Gm-Message-State: AC+VfDzY91BGehnPSbNvi83uNGefZ+m6iuN5bzmdu5gyfUsTA2h0HKkR
        tY5oS4KIWxJIVbjwgP+zY86th2lPA9mpO5Pla9n57Q==
X-Google-Smtp-Source: ACHHUZ4y2+88M7dpE5kCj2m5CnEGYb4DaLh+1mYwJ8lVCokkrPZ3A9nP8+tAx041dQggLJUaQdxZo7KY7+N4mHlHHRM=
X-Received: by 2002:a81:a190:0:b0:561:e2dc:fc60 with SMTP id
 y138-20020a81a190000000b00561e2dcfc60mr9506753ywg.25.1686224778235; Thu, 08
 Jun 2023 04:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-14-ulf.hansson@linaro.org> <20230608053446.ngoxh7zo7drnr32z@vireshk-i7>
 <CAPDyKFqUWhdmctKRpQoqwZ2nsx_P2FiWvLzfm_d39QdECWoytA@mail.gmail.com> <20230608104540.tykxtvwhoyogthw5@vireshk-i7>
In-Reply-To: <20230608104540.tykxtvwhoyogthw5@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jun 2023 13:45:42 +0200
Message-ID: <CAPDyKFrbpm0W1Hdv+85MqMAC2-UbPOE6qp26L0UvVF0sSL2ayA@mail.gmail.com>
Subject: Re: [PATCH 13/16] OPP: Extend dev_pm_opp_data with OPP provider support
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 at 12:45, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-06-23, 11:37, Ulf Hansson wrote:
> > The required opps are also different, as it's getting parsed from DT
> > both for the genpd provider and the consumer. The point is, there are
> > more code involved but just _set_required_opps().
> >
> > For example, _set_performance_state() (which is the one that calls
> > dev_pm_genpd_set_performance_state()) is designed to be used for
> > required opps. Does it really make sense to rework
> > _set_performance_state() so it can be used for this case too, just to
> > avoid another call to dev_pm_genpd_set_performance_state() somewhere
> > in the code?
>
> What we need here, in you case, is really the required-opp thing, without the
> DT parsing. The genpd will have an OPP table here, and devices (you are adding
> OPP table dynamically for) shall have the genpd's OPPs as their required OPPs,
> since for setting OPPs of the device, it is *required* to have OPP of the genpd
> set too. Just like how it happens with DT. No special handling will be required
> in dev_pm_opp_set_opp() path in this case and existing code will just work. You
> just need to set the required-opp tables properly.

Okay, if I understand your point you want to avoid creating OPPs for
each device, but rather coupling them with the genpd provider's OPP
table. Right?

Note that, there is no such thing as a "required opp" in the SCMI
performance protocol case. A device is compatible to use all of the
OPPs that its corresponding SCMI performance domain provides. Should
we rename the required opp things in the OPP core to better reflect
this too?

That said, we still need to be able to add OPPs dynamically when not
based on DT. The difference would be that we add the OPPs when
initializing the genpd provider instead of when attaching the devices.
In other words, we still need something along the lines of the new
dev_pm_opp_add_dynamic() API that $subject series is introducing, I
think.

Moreover, to tie the consumer device's OPP table to their genpd
provider's OPP table (call it required-opp or whatever), we need
another OPP helper function that we can call from the genpd provider's
->attach_dev() callback. Similarly, we need to be able to remove this
connection when genpd's ->detach_dev() callback is invoked. I will
think of something here.

Finally, I want to point out that there is work going on in parallel
with this, that is adding performance state support for the ACPI PM
domain. The ACPI PM domain, isn't a genpd provider but implements it's
own PM domain. The important point is, that it will have its own
variant of the dev_pm_genpd_set_performance_state() that we may need
to call from the OPP library.

Kind regards
Uffe
