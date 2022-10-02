Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0515F2538
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 22:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJBUOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 16:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJBUOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 16:14:39 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6256DB9;
        Sun,  2 Oct 2022 13:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664741660;
        bh=vliabfyfKiNgv3HWwtd8nfs7Jtn3DL4dkFJ5qKGEig8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=htSe16IJ7+Y/GQO/zjYNnETLrHukftvO+Y48dCD7B0EG5mzzcHZNFLeEhHnRoIwmL
         YaFk1rvxo4BTWcc0g7yD5vpF2m2y6JuFj/ZTQB9Gz2LsGpzU/8RmJitZs/553YWabF
         NGVjARLOMLMMl1a4KMuG+V+qyIi8+Z31X+O6TkFk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.13.110.23] ([143.244.37.73]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxDkw-1pP4IF3Mu8-00xZ5A; Sun, 02
 Oct 2022 22:14:20 +0200
Message-ID: <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
Date:   Sun, 2 Oct 2022 20:14:17 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com> <YzgY9X/DM9t/ZuJe@kroah.com>
 <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu> <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20221002141321.394de676@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ed089bHdiFjz5o0L2D+lbrJHYtcyjon9TLJ9IQSKUwmRaQ4uRM6
 dkX6jKcSZKr9V0CvKY5oB33I20bNQGD+CFubfgpfSB8mWV4ac7PBcVMf3/p1l9D9f7+PD3t
 p2MbzUZ7g+P1O6c0ItPus9tuwvadI8aS9qp8HoeXq6YhXzUaLIHxdzEsP20SAt6QU78hc2O
 KfECy4alSaFyLGQB0SmEw==
X-UI-Out-Filterresults: junk:10;V03:K0:46ZPmRmmsQ0=:BFmAIw56Gk9bPEz7H+dPDfAA
 k0Cu4l3DukZITA/mWbzgrylv6GA6CXb9uy33+o9ty7qbSgEOXzbrE3eTBG1NZuVXHEfq5vW1X
 kL0zwwab4vEO+RHFxtTYaOdAOrCmVE0FSqlNW/5v9/IpIYxTRAUhDRouOcwGrXpqcemqSfqEu
 QsIQqB0pFa8J4LrO509Ex1AETOxpRx2Bcye3adOd3P+VLOsNw6nJODywHBCfd7rt5DWkPXexG
 NCRfAGP8Pbtlu9v7IUsy9QzSb49yilVYIH1duwthUIKJwFHFSfacbrxMlmCBrT2Z+4G0BSC6C
 Xxq/Z+Xvlyd4wzlggIylZQ/5HxXYBU+wxikj5irgwN1YRz1v+IKEF9ji4EtW+saDcBzoOxygf
 xiFi3ma87NzFJhgb34K3QhouNkz1xCpCPJGID1FtSL8fIPQxuuemMf6jb3SGFCAc3Jy+YNGoi
 Wbvwt7iKuKVyVyFEs0bTEZZQBwcr3aTHvaWRDupCmApULv5ye4sYJM9bjU+nOijBkDYYN2dvM
 PvXh/KfiKOBsq+n3Qhe3+oX/rjAsBuFX1XKDHJKtPVg6dcoZdwi+VkCk8mOMECQ9xV6OSQkG7
 AFOb1aKQmfcsi+xPijknOn75E3glxOp6Ts9rBwRDQtiAhjSSNN6K75ylOT3lGZgI+RBbVRMuw
 M3NCpMB71e/EX2eR4VZPBgz59clHNm9+0wARL0Ikcf2y7kYpFOoK+lyuKRprfqUiK9H/vy4X2
 yBNcBOEik53b7tdjKg70Dbeo6oK6ekQsDlFbGW+WcYnOtzKNp5LfL/QHLe68IXkWaNhppoWrM
 jqQkE/4qUyI3y1U0kxZfmvXW8/2LlTbrMOVpFVkvXS5ZmJUOunSK8HXTCLykfzMYCT1vFCzsv
 YdCTikq5MQHxfk7q5kcPBuY/2GU/oBbeqYlrE9gdKMijzufeULPJi1Y/M7mXRcnbAF0BcJMgg
 Ukn3rZavZvuYJCOzUwkfGcFzght0N6+ZfkoDqC1DtgDLg7Iho8Uh1LpX63lamxuN89J9uPoOd
 F3axx2lxkJPSzhKtcIJHysmLURedaG6hXFti4LUelffNHXRPhXt9CNf6GIWysKrNeRBYksfPB
 +d8cN9Jl1R4Bo5g1XIvTq3lbC3u/v9ZEH6NAJRVL9pR9UDUSYk8JI46R+9swO5GNNaGgPu9l0
 L1p0fcDdSy1hrv8gYMgEXdYRdNxiIHbvUPVJh5SyUBlFDg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 18:13, Steven Rostedt wrote:
> On Sun, 2 Oct 2022 12:49:04 +0000
> "Artem S. Tashkinov" <aros@gmx.com> wrote:
>
>> Let's subscribe the past six months of developers using git commits and
>> if someone doesn't like getting emails they go to the website and
>> unsubscribe _once_ which takes a minute. This is a non-issue I've no
>> clue why we're dwelling on it.
>
> As one of the few kernel maintainers that actually likes bugzilla and I
> do not mind being subscribed to it, I too find the above an awful idea
> (and I agree with all those that explained why it is so).

Good, exactly what I've been advocating for, those who like it and can
help are welcome, others can go unsubscribe in under a minute. No drama.

>
> This really comes down to a manpower issue, which is common among most
> open source projects. Remember it is commonly said that the only
> warrantee you get from open source projects is that if it breaks, you
> get to keep the pieces.
>
> The issue is that the users of the Linux kernel mostly got it for free.
> And if they did pay for it, it is highly unlikely that they paid the
> kernel maintainer that owns the subsystem that they are having issues
> with. That means, for the maintainers to triage these bug reports, they
> are essentially doing it for free.

I perfectly understand it. I've _not_ asked anyone to do anything yet,
except maybe have their email in the bugzilla database, so that people
_could_ CC you.

They will _not_ do it right away. They first have to `git grep` commits,
find the relevant developers and then CC them.

>
> Some projects are better at this, and there are developers that are
> happy to give free work, but there are also other projects that have
> companies actively backing the work to debug these issues.
>
> If you are using fedora, go bug Red Hat, Ubuntu then Canonical. And
> again, it comes down to if you have a paid subscription or not if you
> are going to get anywhere with it.

This does not work, period. Most kernel bug reports in Fedora and Ubuntu
bug trackers linger for years, sometimes someone says, "Try the vanilla
kernel and if it's still an issue, please use the kernel bugzilla".

My Fedora kernel bug reports have been dealt with exactly this way.

RedHat does solve kernel issues in the RHEL kernel if you have a paid
subscription and you spend quite some time providing them with a perfect
reproducible test case. This is far outside this conversation.

>
> Can this be annoying, sure. But that's how the open source ecosystem
> works.
>
> If someone is not able to figure out how to use the mailing lists, it
> is unlikely that they will be able to be useful in working with the
> maintainer to solve their issue. As Ted mentioned, when asked to do
> something to help analyze the issue, many times there's no response
> from the reporter. Maybe because the reporter had no idea what the
> maintainer wanted them to do. Most kernel bugs requires a constant back
> and forth between the reporter and the developer. If you don't have
> that, then there's no reason to bother with trying to fix the issue.

Mailing lists more often than not do not work, and maybe worked in the
early 90s.

We don't need to resolve the issue right away. We don't have to deal
with it. We just need a place where people could find existing issues
and add their input. That's a lot better than chasing something in emails.

Here's the simplest example.

Person A installs kernel 6.0. They find a regression. They send an email
to maling list X. Not necessarily the relevant one and the email is
simply ignored.

Another person finds the same regression. This person B may not be aware
of the mailing list used earlier. They send a bug report elsewhere.

Now we have two completely disconnected bug reports which if luck allows
could be Googled. Oy, you must know what to google for. Not that many
people have a good Google foo.

Now with bugzilla.

Anyone opens the last seven days of bug reports and instantly sees that
something similar has already been filed and dealt with. Collaboration
ensues. Maybe just maybe some developer will join it and actually offer
a fix. If not, OK, fine, no big deal but at least it's _known_,
_visible_ and can be _found_.

Random unreplied emails God knows where? Good luck with that.

>
> Ideally, someone (you?) would want to be a middle man and triage the
> bugzilla reports and find those that look promising to get a fix
> completed, and then be the liaison between bugzilla and the kernel
> maintainer, then I think that could work. But the issue comes back to
> manpower. Who's going to do that?

I've already offered myself. The LF has no such position. And more
importantly I'm from a totalitarian country, so I'm unlikely to be ever
employed.

Regards,
Artem
