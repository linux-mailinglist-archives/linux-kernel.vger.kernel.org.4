Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD163E105
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiK3Tu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiK3TuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:50:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3792754375;
        Wed, 30 Nov 2022 11:50:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E328AB81CCD;
        Wed, 30 Nov 2022 19:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FCFC43147;
        Wed, 30 Nov 2022 19:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669837820;
        bh=QOqw927fxRzrbF/F3Jnf30+Wco4wM1OzEviRcFlVUEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V3zEJ+E37k+PcTuehrx445ZgWfK+r063zKQF13cD/Q9IDc5a1UsKXM1vM0X3PxAW8
         5A+ubiQPnrThXbkKEw6Kas8R20BH+ZffyYOlLplY9Cz6jJzjpdQr/IKrLZGoe3Hw3V
         7KO0pKJnrRcemGaKShSL6r0H8va1Bb3nUOMqiZ7sP6zme8H4HOKDWoqmt3Z8K8yauc
         VFdkNnx4PeUcl6Amnm2yeRQ59w1vNAPMuX7E9taqMesk+ekaBkPRmsYtnUjScumNIg
         qvr5PiSgJ7PIzDXlula4TqQ+eexBUq8hqnQlv+3C/2UmD/HvlInYbEMbQT3/2MIvTL
         M762HhtGWxJwg==
Received: by mail-vs1-f54.google.com with SMTP id c184so18394904vsc.3;
        Wed, 30 Nov 2022 11:50:20 -0800 (PST)
X-Gm-Message-State: ANoB5pkkpV7QGdpbTJjNkAHDZOolERjNh3nUniDGGT/NzfSsl9Su2xQE
        5YrRMMgxHF1MpqF6QDeVlnzcevvZHXZRe5SUWQ==
X-Google-Smtp-Source: AA0mqf52Y1Vj9n3ybkEc5FmCE5sMcIYABT3Rc5wjqxKa7c1Iw7w12pQuxt5Kk2YnjZv2U8m3ZeRxCLTHwseH2sbP40I=
X-Received: by 2002:a05:6102:2381:b0:3b0:c6ec:cc6a with SMTP id
 v1-20020a056102238100b003b0c6eccc6amr5171717vsr.0.1669837819471; Wed, 30 Nov
 2022 11:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20221128142912.16022-1-marcan@marcan.st> <20221128142912.16022-3-marcan@marcan.st>
 <CAPDyKFobMvef_BWGMR=7avODh2r5XNMGpwO3xYgrN-u=DqRwbg@mail.gmail.com>
 <41c6882a-bff0-378c-edd3-160b54be7c1d@marcan.st> <a297079e-2dc9-d311-5415-a58332e7a711@linaro.org>
 <e8c481ba-02a7-f1c7-6314-ea1ddf136998@marcan.st> <20221129232837.GA432535-robh@kernel.org>
In-Reply-To: <20221129232837.GA432535-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 30 Nov 2022 13:50:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJFEBFSeTrCc6QSCAN8C7rsiyoiy8D-9ZFr6Xk35TqhGg@mail.gmail.com>
Message-ID: <CAL_JsqJFEBFSeTrCc6QSCAN8C7rsiyoiy8D-9ZFr6Xk35TqhGg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 5:28 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 30, 2022 at 12:17:08AM +0900, Hector Martin wrote:
> > On 29/11/2022 23.34, Krzysztof Kozlowski wrote:
> > > On 29/11/2022 15:00, Hector Martin wrote:
> > >> On 29/11/2022 20.36, Ulf Hansson wrote:
> > >> Please, let's introspect about this for a moment. Something is deeply
> > >> broken if people with 25+ years being an arch maintainer can't get a
> > >
> > > If arch maintainer sends patches which does not build (make
> > > dt_binding_check), then what do you exactly expect? Accept them just
> > > because it is 25+ years of experience or a maintainer? So we have
> > > difference processes - for beginners code should compile. For
> > > experienced people, it does not have to build because otherwise they
> > > will get discouraged?
> >
> > I expect the process to not be so confusing and frustrating that a
> > maintainer with 25+ years of experience gives up. That the bindings
> > didn't pass the checker is besides the point. People say the Linux
> > kernel community is hostile to newbies. This issue proves it's not just
> > newbies, the process is failing even experienced folks.
>
> IME, a lack of response is a bigger issue and more frustrating.
>
> > On that specific issue, any other functional open source project would
> > have the binding checks be a CI bot, with a friendly message telling you
> > what to do to fix it, and it would re-run when you push to the PR again,
> > which is a *much* lower friction action than sending a whole new patch
> > series out for review via email (if you don't agree with this, then
> > you're not the average contributor - the Linux kernel is by far the
> > scariest major open source project to contribute to, and I think most
> > people would agree with me on that).
>
> We could probably add a $ci_provider job description to do that. In
> fact, I did try that once[1]. The challenge would be what to run if
> there's multiple maintainers doing something. Otherwise, it's a
> maintainer creating their own thing which we have too much of already.

Actually, turns out this pretty much already exists with my CI. I just
had to turn on merge requests on the project. If anyone actually uses
it, I'll have to tweak it to not do 'make dtbs_check' because that is
really slow. And this all runs on my machines, so that is another
issue. It already is just running it for patches on the list (which is
a different CI job).

Just create a MR here:

https://gitlab.com/robherring/linux-dt/-/merge_requests

Rob
