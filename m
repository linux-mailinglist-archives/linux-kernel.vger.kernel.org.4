Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FF663C36B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiK2PRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbiK2PR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:17:27 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78062F001;
        Tue, 29 Nov 2022 07:17:24 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1DC623FB17;
        Tue, 29 Nov 2022 15:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1669735042; bh=keFMyCTX0usvCrLsU93OmOyWf2zkklBeuPqknM65WaM=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=zOjS9HtnS3Yl6oUchqXhplrO/uVVMgRv5tfIzFIAZFyJUCd/yiM9kl/xE0TFkj+Bm
         LiDQcFrtPIw6URVVvX6eYu45m+Mgu7iwu53VW5dQg/4pIlsSb0t8SHgwcNRV8M4RlQ
         x8/bHWU3xirXgdPPSb6IhrvmHxrIpe0Z1A8eOkoE/T54/H+uOJLU96m5buNfyOXh4v
         3CJ3H6fmr1d3Bfd0pot4fc0vJdmuSB28RPrKv8gmSnLPWNrIrVTYOeEJtH+/mhp7k2
         96S2itepvmm9tYgKw5fg1KGyu+c3K74nEtvrfqFWoFmM+pgzq3nwde1ZBfV29+kS3r
         WbTnSwEuSTfLQ==
Message-ID: <e8c481ba-02a7-f1c7-6314-ea1ddf136998@marcan.st>
Date:   Wed, 30 Nov 2022 00:17:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20221128142912.16022-1-marcan@marcan.st>
 <20221128142912.16022-3-marcan@marcan.st>
 <CAPDyKFobMvef_BWGMR=7avODh2r5XNMGpwO3xYgrN-u=DqRwbg@mail.gmail.com>
 <41c6882a-bff0-378c-edd3-160b54be7c1d@marcan.st>
 <a297079e-2dc9-d311-5415-a58332e7a711@linaro.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v5 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
In-Reply-To: <a297079e-2dc9-d311-5415-a58332e7a711@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 23.34, Krzysztof Kozlowski wrote:
> On 29/11/2022 15:00, Hector Martin wrote:
>> On 29/11/2022 20.36, Ulf Hansson wrote:
>> Please, let's introspect about this for a moment. Something is deeply
>> broken if people with 25+ years being an arch maintainer can't get a
> 
> If arch maintainer sends patches which does not build (make
> dt_binding_check), then what do you exactly expect? Accept them just
> because it is 25+ years of experience or a maintainer? So we have
> difference processes - for beginners code should compile. For
> experienced people, it does not have to build because otherwise they
> will get discouraged?

I expect the process to not be so confusing and frustrating that a
maintainer with 25+ years of experience gives up. That the bindings
didn't pass the checker is besides the point. People say the Linux
kernel community is hostile to newbies. This issue proves it's not just
newbies, the process is failing even experienced folks.

On that specific issue, any other functional open source project would
have the binding checks be a CI bot, with a friendly message telling you
what to do to fix it, and it would re-run when you push to the PR again,
which is a *much* lower friction action than sending a whole new patch
series out for review via email (if you don't agree with this, then
you're not the average contributor - the Linux kernel is by far the
scariest major open source project to contribute to, and I think most
people would agree with me on that).

I know Rob has a DT checker bot, but its error output is practically
line noise, and the error email doesn't even mention the
DT_SCHEMA_FILES= make option (which is the only way to make the check
not take *forever* to run). Absolutely nobody is going to look at those
emails without already knowing the intricacies of DT bindings and the
checker and not find them incredibly frustrating.

But it's not just the DT checker. That came after an argument where the
MFD maintainer complained about the driver while offering no solution
nor proposed path forward. I had to have an IRC conversation with him to
work it out, after which he accepted one of the options I'd already
proposed over email. If you have to change communication mediums to
resolve an issue, that means your initial medium failed at its job.

Not to mention the random drive-by reviews, nitpicks, disagreements
between maintainers about how to do things, or just plain cases of
maintainers stubbornly being *wrong* and refusing to listen while
everyone around them is telling them they're wrong (until someone above
them in the maintainer tree tells them they're wrong - then they finally
get it. If it takes someone in a position of authority telling you
you're wrong for you to accept it, you're doing a poor job at your own
position.)

And then there's the coding style. The rest of the world has
standardized on formatting tools. Here, every subsystem maintainer has
their own pet style you have to learn. "Please put your variables in
reverse christmas tree order". I once got a review comment that
complained that I re-aligned an existing #define when I added another
one (to keep them visually aligned, as the new one increased the
required tab stop). Because "cleanup patches should be separate" (I
didn't submit a cleanup patch after that, I just left the defines
misaligned). So now I need to maintain a massive mental map of exactly
what style conventions and patch breakup conventions every subsystem
maintainer wants me to use.

I'm so glad `make rustfmt` is a thing now. Maybe 50 years down the line,
most of the kernel will have been rewritten in Rust and we'll finally
fix just one of these problems /s

Some of these things are, to some extent, a natural result of working
with other humans. But the kernel community has both a number of humans
harder to work with than is reasonable in their position, and an overall
process that multiplies the resulting pain by an order of magnitude for
everyone involved.

> While I understand your point about bikeschedding, but I think your
> previous bindings got pretty nice and fast reviews, so using examples of
> non-building case is poor choice.

Yeah, after a while, because I learned how to do DT bindings the hard
way after having to submit a bunch and getting everything wrong (and
even then I still get the simplest things wrong, see: v4 here). Which is
why I'll pick up after rmk's attempt and try again with macsmc at some
point (probably after 6.1). But I'm not holding my breath that I won't
need another half dozen rounds of bikeshedding.

When it takes 10 times more man-hours to upstream a driver than to
reverse engineer and write it with zero documentation, never mind the
calendar time it takes, something is very wrong. I actively dread
submitting new drivers to new subsystems or some existing ones now. How
much pain will the next one be? Will I be asked to move files around 3
times? Spend 4 rounds bikeshedding the DT schema? Think it's finally
ready only for someone to show up and ask to change a major part of the
design at the last minute?

And this all when we're actually submitting code of decent quality (I
think I have enough experience not to submit crap most of the time). Now
imagine how much worse this all is for a newbie who submits a
well-intentioned but definitely not up to standard patch. There's a huge
chance they'll give up before ever getting the submission through.

Again, I'll keep pushing and sending out patches, because this is
important. But this is the reality. This is how bad it is. The process
is broken, and everyone outside the kernel community can see that and
has been saying that for ages. Just because some of us are willing to
put up with the pain anyway doesn't mean it's working as intended.

- Hector
