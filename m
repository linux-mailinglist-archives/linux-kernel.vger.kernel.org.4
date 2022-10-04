Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC4F5F3E96
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiJDIlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJDIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:41:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E6012775;
        Tue,  4 Oct 2022 01:41:42 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ofdUi-0001Ci-3r; Tue, 04 Oct 2022 10:41:40 +0200
Message-ID: <eb935178-995b-84f1-6cbe-3492ba74f85b@leemhuis.info>
Date:   Tue, 4 Oct 2022 10:41:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Slade Watkins <srw@sladewatkins.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
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
 <e9dd6af0-37ef-1195-0d3b-95601d1ab902@leemhuis.info>
 <20221003112605.4d5ec4e9@gandalf.local.home>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
In-Reply-To: <20221003112605.4d5ec4e9@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1664872902;5ea00a33;
X-HE-SMSGID: 1ofdUi-0001Ci-3r
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.10.22 17:26, Steven Rostedt wrote:
> On Mon, 3 Oct 2022 14:59:54 +0200
> Thorsten Leemhuis <linux@leemhuis.info> wrote:
> 
>>> With the band-aids you outline in place: do you think it would it be
>>> beneficial to have a liaison holding users’s hands through the
>>> process, _then_ triaging to developers by contacting them with the
>>> information they need?  
>>
>> Well, yes and no. :-/
>>
>> Thing is: up to a point that's something I do already (and will likely
>> continue to do at least for a while) when the reported issue is a
>> regression. But to be fair, I often could help way more if I wanted to,
>> but there are only so many hours in a day and other things to take care
>> of (regression tracking is only a part-time thing for me currently). So
>> some help there might be handy; would get load of the developers as
>> well, as they often are more willing to help users when a report is
>> about a regression.
> 
> Are you asking for help in the regression tracking?

Well, like most people I have lots of ideas for things I'd like to work
on in the domain I'm active in, as the stuff I mentioned in my previous
mail show. But that's life, we all have todo and wish lists. Sooner or
later I'll likely get down to some of that stuff. But if somebody said
"we'd like you to work on this or that rather sooner than later", then
sure, help would be great. Especially help with maintaining and
improving regzbot would be great from my point of view.

But what right now would help most with regression tracking are two
things that can only be solved by educating people:

 * It would help tremendously if reporters and developers would at least
CC the regressions list on regression reports so I become aware of them;
and ideally they would tell regzbot about the report themselves of
course. Right now many people don't do either, so I have to scan various
mails every day to even get aware of most regression reports (I do this
with lei, which searches for things like "regress", "bisect", "revert",
"first bad commit", which generates many false positives :-/ ).

 * It would help a lot if way more developers would use "Link:" tags as
explained by our documentation (e.g. use them to link to reports), as I
have to track things manually if they are missing.

I'm working on educating people and I guess over time things will improve.

>> But for other issues (aka regular bugs) I don't think it's worth it,
>> because why only help those users that report to bugzilla (you didn't
>> say that, but it sounded to me like the focus is on it)? There are
>> people that try to use the mailing lists, but do it badly and never get
>> a reply (for example because they sent their report just to LKML). They
>> could need help, too; maybe helping them should even be priority, as
>> they at least tried to do what most kernel developers want them to do,
>> hence their reports might be better, too.
> Could do both.

Sure!

>> But there is a more important reason why I think having a liaison might
>> not be worth it for now: It IMHO would be much better to spend the time
>> and effort on other things that enable users submitting better bug
>> reports in the first place. I have no concrete and well-thought-out
>> ideas at hand what to do exactly, but here are a few vague ones:
>>
>>  * create an app (ideally usable locally and on the web) that guides
>> users through generating a good bug report (let's leave the way of
>> submission aside for now). That app could handle quite a few of the
>> steps that https://docs.kernel.org/admin-guide/reporting-issues.html
>> currently mentions. It for example could check if the kernel looks to be
>> vanilla, if the kernel is fresh, if the kernel is tainted, if an Oops is
>> the first one or just a follow-up error; maybe that app could even
>> decode stack-traces locally in some environments; and it could collect
>> and upload logs as well. It could also explain certain things to users
>> when not fulfilled, for example why it's not worth to report a problem
>> that happens with an old kernel.
> 
> Christoph mentioned Debian's reportbug utility. That does a pretty good
> job at walking people through how to report a bug. It could also get
> information about the current environment that would be useful too. Perhaps
> something like that?

Never came in contact with it but will put "take a closer look at it" on
my list.

>>    Sure, these apps never work perfect and doing it right is a lot of
>> work, but I guess one could make things a lot easier for many users
>> especially for our case. I assume other projects have done something
>> like that so that we could learn from them.
>>
>>  * Improve https://docs.kernel.org/admin-guide/reporting-issues.html
>> further. I have some ideas there, but other things are higher on my
>> priority list currently. That document in the end somehow needs to
>> become less scary looking while still providing all important details
>> for situations where a reporter might need them.
>>
>>  * Write new docs relevant for bug reporting. We for example still have
>> no well written and simple to understand text that explains bisection to
>> people that are new to git, bisection, or compiling kernels in general.
>> Speaking of which: we iirc are also missing a text that properly
>> explains how to quickly configure and compile a kernel using "make
>> localmodconfig" (I mean something like
>> http://www.h-online.com/open/features/Good-and-quick-kernel-configuration-creation-1403046.html)
> 
> The sad part is that most people that are going to report a bug is not
> going to read a full document to figure out how to do it. Usually when
> someone hits a bug, they are doing something else. And it's a burden to
> report it. Obviously, they want it to be fixed, but it's viewed as a favor
> to the developer and not the user to get it fixed, as it's likely seen as a
> mistake by the developer that the bug exists in the first place.
> 
> Having a tool like reportbug that walks you through the steps of reporting
> it would be the best way to do so. As the reporter doesn't need to think
> too hard and just answer questions and let the tool do all the work.

Yup, I'm all for such a tool (and would likely already have started one,
but I need to get regzbot to a more mature state first; and I actually
have no idea how to write a tool that ideally works locally and on the
web...).

But I consider explaining things like bisection and localmodconfig in
the documentation as also important, as that's likely something the tool
won't be able to automate any time soon (or never, as realizing that is
likely hard and better left to a separate tool anyway).

>>  * Not sure, maybe a list of things that known to be broken might be
>> good to have? Like "yes, we know that nouveau is slow, but we can't do
>> anything about this" or "driver 'wifi-foo' only supports a small subset
>> of the features the hardware offers, so don't report bugs if bar, baz
>> and foobar don't work".
> 
> The tool could possibly reply with known issues, and state something like
> "We are aware of this issue, and are currently trying to figure it out."

+1

Ciao, Thorsten
