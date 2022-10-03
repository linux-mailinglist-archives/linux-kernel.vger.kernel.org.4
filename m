Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC055F3099
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiJCNAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJCNAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:00:06 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C722FC21;
        Mon,  3 Oct 2022 06:00:03 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ofL3B-0005Sn-2N; Mon, 03 Oct 2022 15:00:01 +0200
Message-ID: <e9dd6af0-37ef-1195-0d3b-95601d1ab902@leemhuis.info>
Date:   Mon, 3 Oct 2022 14:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
To:     Slade Watkins <srw@sladewatkins.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Artem S. Tashkinov" <aros@gmx.com>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <63a8403d-b937-f870-3a9e-f92232d5306c@leemhuis.info>
 <534EB870-3AAE-4986-95F3-0E9AD9FCE45B@sladewatkins.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
In-Reply-To: <534EB870-3AAE-4986-95F3-0E9AD9FCE45B@sladewatkins.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1664802004;736a5d1b;
X-HE-SMSGID: 1ofL3B-0005Sn-2N
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.10.22 13:18, Slade Watkins wrote:
> 
>> On Oct 3, 2022, at 6:10 AM, Thorsten Leemhuis <linux@leemhuis.info>
>> wrote:
>> 
>> Thing is: bugzilla.kernel.org is there and will be for a while, as
>> it provides services that some developers rely on. And it has some 
>> problems, as widely known and outlined in my mail. Reducing those
>> for now by performing a few small changes (aka applying some
>> band-aids here and there) as outlined above IMHO is worth it to
>> reduce the pain. There was no opposition to that plan from
>> Konstantin or core Linux kernel developers afaics (please correct
>> me if I'm wrong), so I'll likely start working on realizing it
>> later this week, unless I get "no, please don't/please wait" from
>> those people.
> 
> With the band-aids you outline in place: do you think it would it be
> beneficial to have a liaison holding users’s hands through the
> process, _then_ triaging to developers by contacting them with the
> information they need?

Well, yes and no. :-/

Thing is: up to a point that's something I do already (and will likely
continue to do at least for a while) when the reported issue is a
regression. But to be fair, I often could help way more if I wanted to,
but there are only so many hours in a day and other things to take care
of (regression tracking is only a part-time thing for me currently). So
some help there might be handy; would get load of the developers as
well, as they often are more willing to help users when a report is
about a regression.

But for other issues (aka regular bugs) I don't think it's worth it,
because why only help those users that report to bugzilla (you didn't
say that, but it sounded to me like the focus is on it)? There are
people that try to use the mailing lists, but do it badly and never get
a reply (for example because they sent their report just to LKML). They
could need help, too; maybe helping them should even be priority, as
they at least tried to do what most kernel developers want them to do,
hence their reports might be better, too.

But there is a more important reason why I think having a liaison might
not be worth it for now: It IMHO would be much better to spend the time
and effort on other things that enable users submitting better bug
reports in the first place. I have no concrete and well-thought-out
ideas at hand what to do exactly, but here are a few vague ones:

 * create an app (ideally usable locally and on the web) that guides
users through generating a good bug report (let's leave the way of
submission aside for now). That app could handle quite a few of the
steps that https://docs.kernel.org/admin-guide/reporting-issues.html
currently mentions. It for example could check if the kernel looks to be
vanilla, if the kernel is fresh, if the kernel is tainted, if an Oops is
the first one or just a follow-up error; maybe that app could even
decode stack-traces locally in some environments; and it could collect
and upload logs as well. It could also explain certain things to users
when not fulfilled, for example why it's not worth to report a problem
that happens with an old kernel.

   Sure, these apps never work perfect and doing it right is a lot of
work, but I guess one could make things a lot easier for many users
especially for our case. I assume other projects have done something
like that so that we could learn from them.

 * Improve https://docs.kernel.org/admin-guide/reporting-issues.html
further. I have some ideas there, but other things are higher on my
priority list currently. That document in the end somehow needs to
become less scary looking while still providing all important details
for situations where a reporter might need them.

 * Write new docs relevant for bug reporting. We for example still have
no well written and simple to understand text that explains bisection to
people that are new to git, bisection, or compiling kernels in general.
Speaking of which: we iirc are also missing a text that properly
explains how to quickly configure and compile a kernel using "make
localmodconfig" (I mean something like
http://www.h-online.com/open/features/Good-and-quick-kernel-configuration-creation-1403046.html)

 * Not sure, maybe a list of things that known to be broken might be
good to have? Like "yes, we know that nouveau is slow, but we can't do
anything about this" or "driver 'wifi-foo' only supports a small subset
of the features the hardware offers, so don't report bugs if bar, baz
and foobar don't work".

* Once things improved with steps like the above try to form a "kernel
tester community" where people can help each other when they run into
problems or want to report an issue. We should try to get distributions
like Arch Linux, openSUSE Tumbleweed or Fedora on board here as well, as
they and their users have an interest in ensuring new mainline releases
work well, because they regularly rebase to the latest series.

  At that point it likely would be good to have someone that is at least
somewhat paid to act as "Community Manager"; that person then could also
act as liaison between users and developers and fine-tune things (docs
etc.) further when needed.

Those were just the things that came from the top of my head that IMHO
should be a priority.

Ciao, Thorsten
