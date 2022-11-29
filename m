Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E79B63C40D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiK2Pqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiK2Pqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:46:48 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B211D42F52
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:46:46 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u27so11654179lfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eao8kVaGm6vtNieE8U5gWdmiaP7djGvEGVzI1sPPoz0=;
        b=UR1TG1xNPSEMHx/i+CYCrKrY3mHy0JrJUS/XzmhOMJ8yEj/BOytiR4eN/+sXrVa7gv
         uLHyWK1UByO0oI4LyetUIZfK6fiJCFm9QPAuvBUo+K0b53MCedoNq1319g94jVmfP/QU
         O1k8fCnEbfg4krzmMyM0lFLRqhfi5pQMXRR8WYdROyBQpDessgKXUsHiHubLZV5AXYSK
         vKZ/SOp0rBRSt43s2T4G7N7bXQmTtncJBtOpHluIkT0QgVvf9IGnhz3LsT/0Yf9KNNN4
         LuV0dT/8ZzEkFfvaifKpVYfqXHVMi1gsgfV2chcGIz+cKuzehDrp8+aJC1jj2kqt1Vk6
         UwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eao8kVaGm6vtNieE8U5gWdmiaP7djGvEGVzI1sPPoz0=;
        b=Y7laBsnJRMjilDgfsrtw4JRUOu8QsTgXnhvIY6S8/jPpIlq0Qd3U7b+HXJh/CGNImj
         hMUc46AAxoqJkgmTn8YJmjl5t9TEZe5TTtmkqyS66n2DKw9nvL8FakaslvSThnsLMAvM
         UhSQc193K+bsP40dukmRrij7E67bJZ+CxwoXByhvYbNDb+RyP3UbhJwIpMtAzNj64pM8
         eX3UxLdrS+XFkANM7PoPz5j4HK/igMnU+DVGZHLvT3vkdHhp0N6XGev/QP3J0lOmHgnR
         7pNUBfQ7nxBGJGAgCDCp4VXHuW2WXgbPWyqEGOnMYynUmeQ6ia4DAoZPRwy/hYhuoQKk
         C6Vg==
X-Gm-Message-State: ANoB5plHU8vOaNdGHyDFg/k4qOWPqRI1ixraSwnTEcxMFCq2dGYxDM1e
        pl9H8O7y+b7rscFK0I6kf7AzVQ==
X-Google-Smtp-Source: AA0mqf53DsdFYQJfi/Q9URNzSLkqg99wIGExsFNfyhACV9rG0dzaqzzqeOEN9a/k+2SIMQd9r9jvUw==
X-Received: by 2002:ac2:48a8:0:b0:4b5:eef:b810 with SMTP id u8-20020ac248a8000000b004b50eefb810mr4483599lfg.109.1669736803596;
        Tue, 29 Nov 2022 07:46:43 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l18-20020a194952000000b004aa427febe5sm2238721lfj.64.2022.11.29.07.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 07:46:43 -0800 (PST)
Message-ID: <4c6b5d55-f6a0-f042-ef10-e282e153a358@linaro.org>
Date:   Tue, 29 Nov 2022 16:46:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
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
 <e8c481ba-02a7-f1c7-6314-ea1ddf136998@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e8c481ba-02a7-f1c7-6314-ea1ddf136998@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 16:17, Hector Martin wrote:
> On 29/11/2022 23.34, Krzysztof Kozlowski wrote:
>> On 29/11/2022 15:00, Hector Martin wrote:
>>> On 29/11/2022 20.36, Ulf Hansson wrote:
>>> Please, let's introspect about this for a moment. Something is deeply
>>> broken if people with 25+ years being an arch maintainer can't get a
>>
>> If arch maintainer sends patches which does not build (make
>> dt_binding_check), then what do you exactly expect? Accept them just
>> because it is 25+ years of experience or a maintainer? So we have
>> difference processes - for beginners code should compile. For
>> experienced people, it does not have to build because otherwise they
>> will get discouraged?
> 
> I expect the process to not be so confusing and frustrating that a
> maintainer with 25+ years of experience gives up. That the bindings
> didn't pass the checker is besides the point. People say the Linux
> kernel community is hostile to newbies. This issue proves it's not just
> newbies, the process is failing even experienced folks.
> 
> On that specific issue, any other functional open source project would
> have the binding checks be a CI bot, with a friendly message telling you
> what to do to fix it, and it would re-run when you push to the PR again,
> which is a *much* lower friction action than sending a whole new patch
> series out for review via email (if you don't agree with this, then
> you're not the average contributor - the Linux kernel is by far the
> scariest major open source project to contribute to, and I think most
> people would agree with me on that).

I agree with this entirely. Not only DT checks, but also for driver code
with sparse/smatch/coccinelle/W=1/clang builds.

> I know Rob has a DT checker bot, but its error output is practically
> line noise, and the error email doesn't even mention the
> DT_SCHEMA_FILES= make option (which is the only way to make the check
> not take *forever* to run). Absolutely nobody is going to look at those
> emails without already knowing the intricacies of DT bindings and the
> checker and not find them incredibly frustrating.

Ack

> 
> But it's not just the DT checker. That came after an argument where the
> MFD maintainer complained about the driver while offering no solution
> nor proposed path forward. I had to have an IRC conversation with him to
> work it out, after which he accepted one of the options I'd already
> proposed over email. If you have to change communication mediums to
> resolve an issue, that means your initial medium failed at its job.

Ack

> 
> Not to mention the random drive-by reviews, nitpicks, disagreements
> between maintainers about how to do things, or just plain cases of
> maintainers stubbornly being *wrong* and refusing to listen while
> everyone around them is telling them they're wrong (until someone above
> them in the maintainer tree tells them they're wrong - then they finally
> get it. If it takes someone in a position of authority telling you
> you're wrong for you to accept it, you're doing a poor job at your own
> position.)

Ack

> 
> And then there's the coding style. The rest of the world has
> standardized on formatting tools. Here, every subsystem maintainer has
> their own pet style you have to learn. "Please put your variables in
> reverse christmas tree order".

Ack here as well, and by above Acks I meant - I agree, you are right.  I
don't think we should discuss people's differences, I mean, different
people can give you different review, sometimes less sometimes more
thorough. However at least policies/processes and coding style should be
heavily unified.

> I once got a review comment that
> complained that I re-aligned an existing #define when I added another
> one (to keep them visually aligned, as the new one increased the
> required tab stop). Because "cleanup patches should be separate" (I
> didn't submit a cleanup patch after that, I just left the defines
> misaligned). So now I need to maintain a massive mental map of exactly
> what style conventions and patch breakup conventions every subsystem
> maintainer wants me to use.

Yep. I just have a doc, instead of mental map. :)

> 
> I'm so glad `make rustfmt` is a thing now. Maybe 50 years down the line,
> most of the kernel will have been rewritten in Rust and we'll finally
> fix just one of these problems /s

+1

> 
> Some of these things are, to some extent, a natural result of working
> with other humans. But the kernel community has both a number of humans
> harder to work with than is reasonable in their position, and an overall
> process that multiplies the resulting pain by an order of magnitude for
> everyone involved.
> 
>> While I understand your point about bikeschedding, but I think your
>> previous bindings got pretty nice and fast reviews, so using examples of
>> non-building case is poor choice.
> 
> Yeah, after a while, because I learned how to do DT bindings the hard
> way after having to submit a bunch and getting everything wrong (and
> even then I still get the simplest things wrong, see: v4 here). Which is
> why I'll pick up after rmk's attempt and try again with macsmc at some
> point (probably after 6.1). But I'm not holding my breath that I won't
> need another half dozen rounds of bikeshedding.
> 
> When it takes 10 times more man-hours to upstream a driver than to
> reverse engineer and write it with zero documentation, never mind the
> calendar time it takes, something is very wrong. 

Yes, that's a point. Yet we (community) still have another goal here
than the pure goal of submitter. The submitter wants its stuff upstream.
Therefore this upstreaming effort is for submitter a bit wasted (as I
agree that reverse-engineering should be the biggest task).

However the community (expressed maybe mostly as maintainers) wants
something which will be maintainable and usable also for others, not
only for patch submitters.

Indeed maybe 10x difference between writing code and upstreaming is
something to improve, but please do not forget that the concept is here
to be able to manage this big codebase.

> I actively dread
> submitting new drivers to new subsystems or some existing ones now. How
> much pain will the next one be? Will I be asked to move files around 3
> times? Spend 4 rounds bikeshedding the DT schema? Think it's finally
> ready only for someone to show up and ask to change a major part of the
> design at the last minute?
> 
> And this all when we're actually submitting code of decent quality (I
> think I have enough experience not to submit crap most of the time). Now
> imagine how much worse this all is for a newbie who submits a
> well-intentioned but definitely not up to standard patch. There's a huge
> chance they'll give up before ever getting the submission through.

You say this like any newbie should be able to send a patch and get it
accepted right away, regardless of actually what is in that patch (not
up to standard). It's not newbie's right. No one said it's easy and fast
process... If you want easy and fast, do JavaScript... If you want to
make it easier and faster in the kernel, then we need more reviewers and
maintainers. Somehow many, many people want to send patches, but not
that many want to review them.

> 
> Again, I'll keep pushing and sending out patches, because this is
> important. But this is the reality. This is how bad it is. The process
> is broken, and everyone outside the kernel community can see that and
> has been saying that for ages. Just because some of us are willing to
> put up with the pain anyway doesn't mean it's working as intended.
Best regards,
Krzysztof

