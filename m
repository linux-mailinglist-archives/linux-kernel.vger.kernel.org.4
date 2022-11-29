Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894EE63CBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiK2X2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiK2X2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:28:42 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979AC31EE1;
        Tue, 29 Nov 2022 15:28:39 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-142306beb9aso19014679fac.11;
        Tue, 29 Nov 2022 15:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUKc4mR/Mfwu7jkjJVB/sckWcE9ThlfDvPuBAfuHKEo=;
        b=ZBkK2YWaNdBmfKD3VYimc/DwPmMzkcuK8+HnzVm/e2/baAKFjrpAN9R8v7IbyKbiL8
         5i4WtKz0BaCbHQ6aCUQVcPuUnvgKLAaTPjZKoqyLhqKjOq1R7MhZtH8dGrNawKZAekH9
         m5XbXjSrrBYBSKHnk04za1+mQopDT8eaJu06t8rtdV7mJVpwUohQ+6TMfYj3x0qUloNG
         jjwKWIb1ffTjR8A/mCIy9QhpKJJWrazYUUpZyDBBe9EFksSpOYyfARBt+z3JoY7XAXXt
         C210nwnzKtGyIFdpmDV2rVNe6HyTVw1E94GwReng4Yb5cl4v4N4Unfz4DeykyrEdN5Yo
         eaLg==
X-Gm-Message-State: ANoB5plbBYIjN9439vIx6gzN9NKpWm84SedogeGgNg024kITjleatmRd
        1CpC7XQ9zSvtWQprKd2j0shTncwyKA==
X-Google-Smtp-Source: AA0mqf6FDuUQ7oa2sK/OhFmCAUSB/DBnyAam5tNbnNb+uAHO0524fMqAUn+O+NGJ3cxGm0IrsquNlA==
X-Received: by 2002:a05:6870:8183:b0:137:5344:7776 with SMTP id k3-20020a056870818300b0013753447776mr31801448oae.208.1669764518884;
        Tue, 29 Nov 2022 15:28:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w12-20020a056830410c00b006619295af60sm15421ott.70.2022.11.29.15.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 15:28:38 -0800 (PST)
Received: (nullmailer pid 492448 invoked by uid 1000);
        Tue, 29 Nov 2022 23:28:37 -0000
Date:   Tue, 29 Nov 2022 17:28:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
Message-ID: <20221129232837.GA432535-robh@kernel.org>
References: <20221128142912.16022-1-marcan@marcan.st>
 <20221128142912.16022-3-marcan@marcan.st>
 <CAPDyKFobMvef_BWGMR=7avODh2r5XNMGpwO3xYgrN-u=DqRwbg@mail.gmail.com>
 <41c6882a-bff0-378c-edd3-160b54be7c1d@marcan.st>
 <a297079e-2dc9-d311-5415-a58332e7a711@linaro.org>
 <e8c481ba-02a7-f1c7-6314-ea1ddf136998@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8c481ba-02a7-f1c7-6314-ea1ddf136998@marcan.st>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:17:08AM +0900, Hector Martin wrote:
> On 29/11/2022 23.34, Krzysztof Kozlowski wrote:
> > On 29/11/2022 15:00, Hector Martin wrote:
> >> On 29/11/2022 20.36, Ulf Hansson wrote:
> >> Please, let's introspect about this for a moment. Something is deeply
> >> broken if people with 25+ years being an arch maintainer can't get a
> > 
> > If arch maintainer sends patches which does not build (make
> > dt_binding_check), then what do you exactly expect? Accept them just
> > because it is 25+ years of experience or a maintainer? So we have
> > difference processes - for beginners code should compile. For
> > experienced people, it does not have to build because otherwise they
> > will get discouraged?
> 
> I expect the process to not be so confusing and frustrating that a
> maintainer with 25+ years of experience gives up. That the bindings
> didn't pass the checker is besides the point. People say the Linux
> kernel community is hostile to newbies. This issue proves it's not just
> newbies, the process is failing even experienced folks.

IME, a lack of response is a bigger issue and more frustrating.

> On that specific issue, any other functional open source project would
> have the binding checks be a CI bot, with a friendly message telling you
> what to do to fix it, and it would re-run when you push to the PR again,
> which is a *much* lower friction action than sending a whole new patch
> series out for review via email (if you don't agree with this, then
> you're not the average contributor - the Linux kernel is by far the
> scariest major open source project to contribute to, and I think most
> people would agree with me on that).

We could probably add a $ci_provider job description to do that. In 
fact, I did try that once[1]. The challenge would be what to run if 
there's multiple maintainers doing something. Otherwise, it's a 
maintainer creating their own thing which we have too much of already.

> I know Rob has a DT checker bot, but its error output is practically
> line noise,

I'm not sure what to do there beyond the 'hint' lines I've added. It's 
kind of how json-schema functions unfortunately. I think it stems from 
each schema keyword being evaluated independently.

>  and the error email doesn't even mention the
> DT_SCHEMA_FILES= make option (which is the only way to make the check
> not take *forever* to run).

That's easy enough to add and a specific suggestion I can act on.

However, note that the full thing still has to be run because any 
schema change can affect any other example (which is a large part of 
why it's slow).

>  Absolutely nobody is going to look at those
> emails without already knowing the intricacies of DT bindings and the
> checker and not find them incredibly frustrating.

I don't know how else to enable someone not understanding DT bindings 
nor json-schema to write DT bindings. I get that json-schema is not 
something kernel developers typically know already. Trust me, the 
alternatives proposed for a schema over the years would have been 
much worse.

Rob

[1] https://lore.kernel.org/all/20181003222715.28667-1-robh@kernel.org/

