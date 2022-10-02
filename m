Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC945F2587
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 23:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJBVyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 17:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJBVyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 17:54:17 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B44237F89;
        Sun,  2 Oct 2022 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664747640;
        bh=5LO6qyEA+cjuarBaf+/5igvJpoKOtXKDMvqDtaBSjH4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CnaLOlY/qQDtKC7PTE6IeUrnaRYm8Pzh17mIszvkr3/FOysYqR/2YyzT948RotrhE
         bIqLYdH8LnBMiJwgvcz+xerje109g6hJ8dLtbZ0SJHLjg4W8uvn5qsumFwqZAsEpMQ
         W+i6MTqDjtlObvtiEIN6ygZ+I62lpBTckcqHZDEI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.13.110.23] ([143.244.37.73]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6ll8-1oZ4lC13ny-008I3k; Sun, 02
 Oct 2022 23:54:00 +0200
Message-ID: <867b35b7-da2b-fed0-1f75-b2021d9be499@gmx.com>
Date:   Sun, 2 Oct 2022 21:53:58 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Willy Tarreau <w@1wt.eu>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
References: <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu> <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002150522.ul4nbtfawqjhnsag@meerkat.local>
 <b594681b-6b8c-ffb7-f526-3da847d160a8@gmx.com>
 <20221002205430.GC22129@1wt.eu>
 <d1f99826-2a66-c2d5-c9cd-d2fadd35eca4@gmx.com>
 <20221002213235.GA22532@1wt.eu>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20221002213235.GA22532@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i0y2oJPeNav/Ehn7JneId96ETemrst6Ju+njRRukNJlp1z0zJZa
 ual7h65AJ5tIdYHJrxzcTA34YCuuAMuxPmd5jfePmxw3x5yILPfXMnsGshsV0yvkkzC5wb5
 QlpPMqF49mS8TkAUxwdN5hwxCrGzWSJo8wthwPvysnqvSCKCCLUKWDTkKZkaS+HQAVeZkqF
 VmV/Eib1FOkQtIYpkueYw==
X-UI-Out-Filterresults: junk:10;V03:K0:/JUxT2HfbaA=:vdd56g1gJlgMuGm1FS4iAQeY
 EUaOLuLUuvo4WuqaK6zacrEqTTAHgIfv0wkyaF/Cag/8YVzzteHYU9VWyp9tHUTt/hxuY9GND
 TAL3sBiCAP4dhcjawC+LlVsgrMqQVBt/ZxAkS2VueQvq4c87Q9vqmPMHtNiXPCD9CZ3abBRAZ
 8TRnUa5EpAtYtkbvi+FMiac4C8/Fl39VvwSr9CnX2L0w4QTxIF7zIVqNruZim64LCF1r1MNbV
 e1dJg4eO3ehyQ485ndIfqjwZs1FFSvVndMl32JiUwCL1S1t9hsjbCtnCGl/Dam8OKkLcMyN7x
 l7vgTsazEd7BLMqeLr4DBWXiiIWjE4ZnvavOo7IzFV+kD/zC1iySmNC0jS9kgGkdqZNawwnzs
 CJfo8An3a4K7IC7nYfaAk+fIgeTh+1n8dsEa+46MUB/MWomp0e4O8Y6Jfr8S4+UOJPMkXodBw
 esCo7cq2GhhIz9GEnU+Eeu6iqNtRSxBGQU24zBWVxdk/jX/Br1MvtMIZVYr/B15hpFO67pfi6
 fGEaCq531EKw/DwBlZW1fPO8jPO3F5eX6MlP3E9fXmFGII0hvt+T2rH4WigNMAje1k+rE+Yls
 4tYhlqa50rwvuZTbaILOyzsUAT8zxIBJnf4v2PxFx64+08uuzQaoUMrewCWmqmFDrUUECeXpE
 EjdK0X0s8OsY3cL/+dmXWxogZhvcFtwOg7IJOx3KEmYI1KjKmtlStYSdfm9vdLNSZfgyDkUgK
 PVfzQ9BLFKPW64qSU59CUW2IaArqbiwshcbw2pWQoyjKcCSD8Lr1RxQILe49gw1sXoWdBBMRu
 3qehR5Yo/9G2Dk7lX+BC6BA/YVjwx1wQt4ewU8hQ3HQ/HNXQmUCMTjmgBlP3kuWZw48LubaD6
 X+YD750V689Cl2W8c5vRZZFfdisHkPmn6ucDWEmaOpdsPFNTUUi7CPfyeEsuaTrxAKIhZgGh6
 6RhMs/GcyO5J4nUNS2JDQADORMwZd2QPNegrz+VafRUUVWdoh8/vTwODjpdMksvlJp3J+K2My
 7wtsAcZbG/1M6EaDQmKR2e2ynvcrF2YXYGQBXT6bi+dbFdKsr3j17van7yM3ZpceNeeqWUkvF
 04eHu4dprbb9B8CeJwzjfGC2tLUpFYbZGbmzfdVZr6JiIf3LfPGjVG+JZINaN2WpRZ4WglqDI
 UbCtcRdJiAd7cPr5V3GpGVWUZdSe6i97Ki5ddRkx1rDJew==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 21:32, Willy Tarreau wrote:
> On Sun, Oct 02, 2022 at 09:07:13PM +0000, Artem S. Tashkinov wrote:
>>>> Why are people are now blowing stuff out of proportion for no reason?
>>>
>>> Because the approach is wrong. As I explained it gives a false sense t=
o
>>> the reporter that their issue is being handled while the simple fact t=
hat
>>> a message was sent to a person is in no way an engagement to do anythi=
ng
>>> about it. LKML is a broadcast area. Everyone hopes someone else will
>>> respond and that eventually happens. When the reports are targetted, i=
t
>>
>> No, it doesn't happen. Should I open LKML and send you a hundred of
>> unreplied emails over the past year alone?
>
> If that makes you feel better, feel free to do so. I'm not scared by
> only one hundred e-mails. What I'm impressed by, however, is that you're
> able to spot that many unreplied e-mails because I don't see as many. If
> you're that efficient at spotting them, maybe these are the ones you
> should just resend to make sure they're seen, and it would require less
> work (even on your side) than triaging issues.

So, we've been worked up about a _possible_ SPAM issue and your response
is ... create more SPAM? How does it solve all the other issues with
email I've identified?

>
>> Just before I GTFO I will leave this bug report here (already posted it
>> here but maybe I need to do it again and again):
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D204807
>>
>> Tell me honestly how ~255 comments, and a ton of collaboration over the
>> span of 2.5 years can be managed using email.
>
> What makes you think it would have taken that long over e-mail ? Between
> your first report and the first reply "this is not a bug", 18 months had
> elapsed already. The most active part of the discussion happened grouped
> on 3 days (2021-03-19 -> 22), where there were already some "I'm removin=
g
> myself from the CC because the discussion isn't productive", then a larg=
e
> number of "me too" happened. Not sure how much useful this has been
> overall to the involved developers, given that it's impossible to stay
> focused on that long a thread and sum up all the information spanning
> over that many kernel versions and that many different hardware.

It's easy to join an existing bug report. Tell me how can I join an
existing email thread without being first subscribed to it? I certainly
can, absolute most people will not be able to.

What about sending large dump files? Should everyone on the mailing list
receive it?

A bug report is a simple plain list of messages in a single place which
could be read with a web browser. An email thread is anything but.

Searching through many emails at once? Good luck with that.

Replying to a particular email? Good luck with that.

It looks like you're under the impression that every Linux user who is
willing to ever use Linux must:

1) Subscribe to _all_ the existing mailing lists (just in case - what if
you need to work on something which was started by someone else)
2) Know the email etiquette
3) Learn to be persistent and resend (an unknown number of times) your
concerns hoping they will eventually be addressed.

Bugzilla: sign up once. Follow up. If you file a dupe, hopefully it will
be marked as a dupe. Everyone's happy. No particular skills, email
clients, formatting, referencing, etc. etc. etc.

All the developers busy and no one wants to work on your bug report?
That's Linux, you've got it for free. Submit a patch or pay someone
who'll fix your issue.

Regards,
Artem

>
> My gut feeling is that handling this over the ML would have resulted in:
>    - a few "sorry, no solution, try to fix your BIOS"
>    - "try this" =3D> "it works, thank you".
>    - "this fix above broke for me"
>    - and a few such iterations until a satisfying enough solution would
>      have been found. Maybe not in 2.5 years, maybe 6 months.
>
> But I could be wrong. I'm not claiming I know how people feel the most
> efficient. Just observing what we're seeing on the lists and what I'm
> used to dealing with in some bug trackers. If you want I can as well
> show you a bug I reported 19 years ago that's still in state "NEW",
> having seen little updates over the years. It had better been closed
> since then, TBH:
>
>     https://gcc.gnu.org/bugzilla/show_bug.cgi?format=3Dmultiple&id=3D118=
73
>
> Pretty close to your demo above except it lasted 8 times longer and
> has not seen progress by lack of interest. How's that different from
> what you complain about mailing lists ? Hmm ?
>
> Willy
