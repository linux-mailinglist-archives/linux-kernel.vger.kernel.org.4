Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4463C4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiK2QGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiK2QF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:05:56 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B3349083;
        Tue, 29 Nov 2022 08:05:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C18E941E2F;
        Tue, 29 Nov 2022 16:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1669737913; bh=+fXKO7nYcSqOfbCc7xjBkYcmUHsZizo/Xgv/Sfz9gTw=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=GrWvkywUFBvAgljJBeOX4iz7MQrnlt0WVX65RzvluTRP9Xa76AYt5fmpnq2Bp0bRY
         MuRmcFkbcowdxv8K7Kto28HLhHC0PmolIlHNeW5oQR52p8mXDevBcO817IfqGna5H5
         hOlyKN+wxbQZzyB+izJSSyzyy7zL1pEApAlewsPZXSbySy307bnGlxfpaNTB6NjUcS
         a6ORitLsMZD1Bj7u3Xo7bPoGw0Z9VvrYBIx1IYuIOhZveoH9YUqWywMZb8RtkFzBIE
         GwYKNCyDM72J6J6X9/bN+VvJaO1xFuVI7nwwWJoyaQr5quw0s5jaKtVJp347C7Q0GM
         4n/KUI9pzc1Dg==
Message-ID: <ff4273fe-e57f-8ce0-be60-b6b05386ffb4@marcan.st>
Date:   Wed, 30 Nov 2022 01:05:01 +0900
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
 <e8c481ba-02a7-f1c7-6314-ea1ddf136998@marcan.st>
 <4c6b5d55-f6a0-f042-ef10-e282e153a358@linaro.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v5 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
In-Reply-To: <4c6b5d55-f6a0-f042-ef10-e282e153a358@linaro.org>
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

On 30/11/2022 00.46, Krzysztof Kozlowski wrote:
> On 29/11/2022 16:17, Hector Martin wrote:
>> When it takes 10 times more man-hours to upstream a driver than to
>> reverse engineer and write it with zero documentation, never mind the
>> calendar time it takes, something is very wrong. 
> 
> Yes, that's a point. Yet we (community) still have another goal here
> than the pure goal of submitter. The submitter wants its stuff upstream.
> Therefore this upstreaming effort is for submitter a bit wasted (as I
> agree that reverse-engineering should be the biggest task).
> 
> However the community (expressed maybe mostly as maintainers) wants
> something which will be maintainable and usable also for others, not
> only for patch submitters.
> 
> Indeed maybe 10x difference between writing code and upstreaming is
> something to improve, but please do not forget that the concept is here
> to be able to manage this big codebase.

You're misunderstanding me here. The problem isn't the goal of keeping
things maintainable. The problem is that the process involved makes the
entire experience take much, much longer than it should. A more
efficient process could maintain the same (actual) code quality with a
lot less time wasted for everyone, both in process issues and in
bikeshedding details that don't actually increase code quality.

>> I actively dread
>> submitting new drivers to new subsystems or some existing ones now. How
>> much pain will the next one be? Will I be asked to move files around 3
>> times? Spend 4 rounds bikeshedding the DT schema? Think it's finally
>> ready only for someone to show up and ask to change a major part of the
>> design at the last minute?
>>
>> And this all when we're actually submitting code of decent quality (I
>> think I have enough experience not to submit crap most of the time). Now
>> imagine how much worse this all is for a newbie who submits a
>> well-intentioned but definitely not up to standard patch. There's a huge
>> chance they'll give up before ever getting the submission through.
> 
> You say this like any newbie should be able to send a patch and get it
> accepted right away, regardless of actually what is in that patch (not
> up to standard). It's not newbie's right. No one said it's easy and fast
> process... If you want easy and fast, do JavaScript... If you want to
> make it easier and faster in the kernel, then we need more reviewers and
> maintainers. Somehow many, many people want to send patches, but not
> that many want to review them.

Again, I'm not saying the bad code should go in. I'm saying the
*process* is so frustrating that most newbies will give up before the
code has a chance to evolve from bad to good and go in. The solution
isn't to let more bad code in, it's to make the process less painful.

And yes, some of it does mean either relaxing style rules or just
adopting a formatter, because let's face it: complaints that a line is
81 characters instead of 80 don't *actually* increase code quality to
any measurable extent, they just waste everyone's time, and if that
level of style pickiness is desired, that's what formatters are for.

I have personal experience with this with the Asahi Linux bootloader
(m1n1). We use a formatter for C; the CI tells people when they have to
run `make format` to fix their style and that solves all our C
formatting issues (incidentally, we also have a CI bot to check for
S-o-b lines - very handy). We don't use a formatter for Python, and as a
result, I don't impose overly strict rules on things like exactly how
many lines of whitespace should exist between functions or exactly how
expression continuations should be indented or what the maximum line
length is (within reason), because code doesn't have to look like it was
written by a homogeneous robot to still be completely understandable and
readable to humans using modern editing tools, and trying to teach every
contributor my own personal style (which isn't even 100% consistent, I'm
not a robot either!) would be a waste of my and their time. Most
contributors are capable of defaulting to a readable coding style
similar to the rest of the code around it, and it's rare I have to tell
someone to fix the formatting because something is clearly wrong (like
blatantly inconsistent block indentation).

- Hector
