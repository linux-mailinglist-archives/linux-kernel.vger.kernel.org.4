Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300835EF544
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiI2MXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiI2MWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:22:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE53A13AF00;
        Thu, 29 Sep 2022 05:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664454157;
        bh=BKOUmNz0VMxDE3a5HZh5+nnKKGxXZ1pqkRug/c4AJ2M=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=b7Arsn2QWdK2wBowAzFCcZs+jKi4wC4IA0ThEctkY5pQav0XmWTMK7FF1OqV7HUxq
         jUk2HqGZHYrXoCsNlSmfR5Seup2k0SayJ/4qiDnzxntxXUgPzEiycbBwXU4GVRbBgz
         WAtBqevSSstrz7nmwfbM4JPtJAKeuhWqPndZ0Tug=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.252] ([5.166.161.56]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrhUK-1oygjB1BAa-00ndq0; Thu, 29
 Sep 2022 14:22:37 +0200
Message-ID: <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
Date:   Thu, 29 Sep 2022 12:22:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sSi2RpEt7iUELbPcTuzS5lZuuC+vBpCGNK+xtWoSsn9P56JrxyH
 tD8mLziIDtevVSppqUd/VxJUq9tYbR2OLGeVlm2q4JznhEUC07k0rfv1SW2GEAKjVUJqK8E
 vEEkN8Xx87VOgOyERjCunY88SWcmOcmYZvmIY+9GwPrHLxsHXkz5Z1YOwZhDDDd4iwAGNXk
 q04lXdvyoAN+IUC0aSMvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DactUNU072c=:B8o7evV1I+Jq/tVc/DWB3+
 SGVz/v4kKrIUiAC+bnZpkUf3cXggSLmQuzUR5YmIKOvJX/gQNYPElq2vTgCxR/lUzpQGGH6FC
 2FxDgzzvs5jvwdp/FV91AibI/qHf/1/zYB2gjPgEwbBbI6yMbD2MVwO7V+ZWIS7uMlIDyBQjL
 C7TuXU2zUKGCOGfohrsGJkJUKhURbMvYa9Mrvpk/WEXewwObkO1yGjv/bzsBYQ0RKdZczLWsR
 YwqEJZ4Pax981R9iYNV4Sbc32DQUgD0ZAmdne3svsG/JWlk+mo0wTbTEeCrOHdMHfbbFm9MU+
 5j/ir9b0S4573p/BtfHoS1Jfrn2fmHGch2oEo1HzOMbz49wWQF51474nTVIVKnZ1prnG4ZJ4x
 hlNCLVIeWzn0RnsNOWtJnNCJa1gr/sosVHRC4t3U5rlxpxHq6M4xmPlh//zeNtK3CcshwYGH6
 /bUFg3ep9TuEze/oYBtdWZkQJh6TwR10oZZq1sogJh589u7QqS0Vhgc+h1vXBqzn/dkZLQXDd
 fj9YczaYdZUMBqdO5PJtULmP1FdnzEklwoOCztjZWooHwIzKhLI2hmH5VVxPVMF5VAkq060Wp
 Sbnk+cys0PCZhMkzYY84aDmQYIW8rBeGgbOxs4qqww0CsjKuR9hzzRC25sTeas1f6HT2A8a30
 NJhSpD2/WR2Dak6SUjPzvOYkeM7nuio5mF6LA5KB1vDoFTJ8gdtgHcPKPgU7k1WQ4pTmM85cc
 66Qf+FMwzOJZVr1Fjf5WlfGPI7H3bHQIJXafMP+Qga4u7adio9PMSQjnTZUOcB2K2+5+Gobl9
 XVDA25wgjReUluCiY97JwirNFihvJq/psxQ6ndKB/3g7/7pK6MrI+rZd7CxU2MDDmZwek5inQ
 wt1IWvVq6DhESu8MztVe18uJXuTS/6M41zszAvh8D6o3hRdF0IlvXc6BmvKR32I2xVrWKMQJR
 XFc6u+RUsMReAvfJ/wHOjtIkj9k5bgqiGCRSfQm0SXcU0gl55/XNsnqQgCzXt3Q1lSDH252EA
 4bcO5obGUTJ0nAJFlSAyZmkKmULqrrbZeZfkahBvgQCdaGCQjdsfJkBUdeq+BB0Hj8+7NOZsB
 VlS5iBt0+J1aQ+2Q7pE/KhcigNTEslS50gMpDm0NuRxfLRItVgT+gni7L4z6g/B0haquAl/jR
 l7R8kcjX63sY3bGQPkHSaEtEs6
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I'm glad the issue has been brought up again, I did it earlier but the
discussion never gained any traction:

https://lkml.org/lkml/2021/11/5/425
https://lore.kernel.org/lkml/6abc7248-efda-b569-9030-5384e5ce1f29@gmx.com/

Let me be brutally honest here, if you're working on the kernel,
specially for a large company such as e.g. Intel, you're _expected_ to
address the issues which are related to the kernel component[s] you're
maintaining/developing otherwise it's not "development" it's "I'm
dumping my code because my employer pays me to do that". That also means
you're expected to address bug reports.

It's correct I've tried to help people with bug reports posted on
bugzilla.kernel.org but it's a tough task considering that absolute most
kernel developers are not signed up, thus most bug reports are never
seen by respective developers.

How I'd go about the whole situation:

* Bugzilla must be there whether people like it or not. I've dealt with
LKML and other subsystems' mailing lists and the situation is even
_worse_: absolute most emails are simply completely ignored and _never_
replied to. The related bug reports, of course, are rarely if ever
addressed. It's so easy to say "sorry, yesterday I received 200 new
emails and simply didn't notice a new issue". That's ugly.

* All the components in the kernel bugzilla must be synchronized with
Kconfig's, in a perfect world automatically.

* Some kernel components, e.g. amdgpu, i915 and others have their own
bug trackers. Here's my proposal. People don't need to dig deep and
understand the intricacies of kernel development, all the components
must be there.

   Whenever a person tries to file a bug report for e.g. Drivers ->
Video Intel (not currently there),

   * * they either must be redirected to the appropriate bug tracker (
https://gitlab.freedesktop.org/drm/intel ) automatically, or

   * * a copy of the bug report in the appropriate bug tracker must be
created, or

   * * an email must be sent to the appropriate mailing list.

   Not sure if Bugzilla supports any of that but it's hugely important.

* Subsystem _maintainers_ must be present in the bugzilla by definition.
You're a maintainer after all. You're expected to be responsible (that
excludes the previous point if it's addressed).

* Kernel bugzilla must be opt-out, not opt-in. To be honest I'd
automatally add everyone who's commited to the kernel in the past 6
months and of course if new developers commit to the kernel, I'll add
them as well. Only if they _hate_ getting bugzilla emails, they are free
to unsubscribe.

* Speaking of a catch-all component. Mozilla does exactly that: bug
reports are filed under such a component however then AI/agorithm or a
person assigns them to a proper component. As a person someone could
certainly do that but I've not seen any open positions/vacancies for that.

TLDR: it's so easy to hate/dismiss bugzilla and say "use our mailing
list instead". Practice shows that "your mailing lists" are too often
completely disfunctional and allow [bug] reports to linger and get never
addressed which is not good for the kernel. I strongly oppose the idea
of kernel bugzilla deprecation.

AFAIK, the kernel bugzilla is a Linux Foundation project and the
organization receives funding from its very rich members including
Google, Meta, Intel, and even Microsoft. The fact that no one is
seriously working on it looks shameful and sad. We are not talking about
a minor odd library with a dozen users we are talking about the kernel.

Sorry about the tone of the message, I'm just too invested. It pains to
see how the kernel issues in regard to its use on the desktop receive
very little attention and how things which are important for major
companies (server use and Android) are all the rage and there are
specific people addressing them.

Best regards,
Artem

On 9/29/22 11:33, Thorsten Leemhuis wrote:
> [resent with the right ksummit list in CC]
>
> On 29.09.22 13:19, Thorsten Leemhuis wrote:
>> Hi!
>>
>> TLDR: Core Linux kernel developers are unhappy with the state of
>> bugzilla.kernel.org; to improve things I plan to change a few important
>> aspects of its configuration, unless somebody comes up with better idea=
s
>> to tackle current problems: (1) Create a catch-all product making it
>> totally obvious to submitters that likely nobody will look into the
>> ticket. (2) Remove or hide all products & components where the subsyste=
m
>> didn't fully commit to look into newly submitted reports. (3) Change th=
e
>> text on the front page to make it clear that most kernel bug reports
>> need to be sent by mail.
>>
>> I recently brought the state of bugzilla.kernel.org up for discussion o=
n
>> the kernel summit and the kernel maintainers summit in sessions about m=
y
>> regression tracking efforts. Long story short and rough: in both
>> sessions attendees were quite unhappy about the current state and wante=
d
>> things to change for the better. As I brought that topic up, I guess I
>> have to get things rolling now.
>>
>> But before getting into the details, a quick & rough reminder about the
>> current state of bugzilla.kernel.org:
>>
>>   * The server and the software running on it are well maintained by th=
e
>> the infrastructure team (Konstantin et al.); many thx for this!
>>
>>   * Products, components, default assignees, et al. OTOH are heavily
>> outdated, incomplete, or wrong: maintaining this is not the job of the
>> infrastructure team and nobody else has stepped up to take care of this
>> (for a few more details see:
>> https://lore.kernel.org/lkml/20220420163223.kz32qomzj3y4hjj5@nitro.loca=
l/).
>>
>>   * To the best of my knowledge bugzilla.kernel.org was never really
>> sanctioned as the official place to report all sorts of kernel bugs:
>> only 20 (most of them from the area of ACPI/PM and PCI) out of ~2500
>> entries in MAINTAINERS currently tell users to report issues there; mos=
t
>> other subsystems just mention email contacts, a few (like the DRM
>> developers) point reporters to external bugtrackers.
>>
>>   * Developers of subsystems committed to the bug-tracker afaics usuall=
y
>> react to reports submitted in bugzilla.kernel.org. A few other
>> developers & subsystems keep an eye on reports, too; some do this
>> directly, others rely on bugzilla forwarding reports for certain
>> products/components by mail to the subsystem's mailing list. Quite some
>> or a lot of tickets are not forwarded to any developer or mailing list
>> at all.
>>
>>   * In the end lots of bug and regression reports (even good ones!) nev=
er
>> get a reply from a developer, as a brief analysis of mine showed
>> (https://lore.kernel.org/lkml/6808cd17-b48c-657d-de60-ef9d8bfa151e@leem=
huis.info/
>> ). I at least currently try to work a bit against this by briefly
>> looking at each new report and forwarding any by mail that looks like a
>> regression worth forwarding (I ignore everything else). Artem S.
>> Tashkinov also looks into some (all?) reports and tries to help reporte=
rs.
>>
>> The sessions on kernel summit and the kernel maintainers summit
>> discussed the current state only for a few minutes. It's hard to
>> summarize these discussions, but let me try to mention the aspects that
>> are important for now:
>>
>>   * In both sessions members of the audience seemed pretty unhappy to m=
e
>> about the current state of things.
>>
>>   * In the kernel summit sessions (recording:
>> https://youtu.be/e2SZoUPhDRg?t=3D5370 ) Len Brown stated that he and
>> fellow ACPI/PM developers rely on bugzilla.kernel.org and would need
>> some replacement if it's decommissioned.
>>
>>   * On the maintainers summit (see the last section of
>> https://lwn.net/Articles/908324/ for a brief write-up that coined the
>> term "Bugzilla blues") someone brought up the upstream development of
>> bugzilla the software seems to be dead; there was not even one strong
>> advocate for bugzilla.kernel.org and the general vibe tented into the
>> direction of "let's get rid of it". But it was also mentioned that
>> bugzilla.kernel.org does something useful which will need a replacement=
:
>> a place where reporters can upload big files needed for debugging probl=
ems.
>>
>> In the end that made me settle on this plan of action:
>>
>>   1. Finding a replacement for bugzilla will take a while, so for now
>> let's try to reduce some of its aspects that are bothering people:
>>
>>    1a. Create a new product/component that can act as a catch-all bug,
>> but makes it pretty clear that nobody might see the report because it's
>> not forwarded to anyone. People can use it to upload files for debuggin=
g
>> and link to them in mailed reports. People unable or unwilling to repor=
t
>> issues my mail (see 1c) could use it to submit issues, too. The outcome
>> then is the same as before, but at least people were told upfront about
>> the likely outcome; it also gives users a chance to help each other or
>> to coordinate before properly reporting an issue.
>>
>>    1b. Go through the list of products and components and hide or remov=
e
>> *all* where the subsystem didn't fully commit to look into newly
>> submitted reports. Minimum requirements to remain listed will be along
>> these lines: subsystem mentions bugzilla.kernel.org in MAINTAINERS or a
>> developer listed in MAINTAINERS is one of the default assignees in
>> bugzilla. Subsystems where bugzilla forwards mails to a mailing list ca=
n
>> remain listed as well, if the recent history shows the developers look
>> into newly filed bugs. I'll use my best judgment in the transition
>> process and will file "anyone listening?" bugs if in a doubt.
>>
>>    1c. Make it obvious on the front-page of bugzilla.kernel.org that mo=
st
>> kernel developers want bug reports to be submitted by mail; mention the
>> subsystems that accept reports there and point to the catch-all bug (se=
e
>> 1a) as a last straw.
>>
>>   2. See if everybody is happy with the new state for the time being; i=
f
>> not further fine-tune things or speed up step (3).
>>
>>   3. Work out what we want as replacement.
>>
>> Anyone any comments on this or helpful ideas how to make things even
>> better? Otherwise, I'll in a week or two get down and start working on
>> realizing the points listed under step (1).
>>
>> Ciao, Thorsten
