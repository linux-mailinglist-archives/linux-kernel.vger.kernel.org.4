Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5415F622B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiJFH4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiJFH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:56:36 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B087527CD6;
        Thu,  6 Oct 2022 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665042986;
        bh=UxqOWl+5Fnu5BtMbVy/UIVQ40JwvSPGP9jrVh2B1CO8=;
        h=X-UI-Sender-Class:Date:Subject:Cc:References:From:In-Reply-To;
        b=CZtDCWr9IbSPn/tM+zuzLY1JZnhRZH00lkKITVTEZVK+THtBe3QEMlUUlPVkeWcHM
         QJf8z86cSslIvvtCuEHOtMm00bAApWryE9p06pAJcTBPWIjcfQFe1kepW4a9wxnERL
         Zo7HmL8PU6iKlzVqdrBciINrTyPY5evWL3VD0ktc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.24.110.15] ([143.244.37.25]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Daq-1oZl6Q2Iem-006eJS; Thu, 06
 Oct 2022 09:56:26 +0200
Message-ID: <3ee2a3d6-5711-3240-c181-cd34426932ed@gmx.com>
Date:   Thu, 6 Oct 2022 07:56:24 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <20221004175354.bfvg3vhfqch35ib5@meerkat.local>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20221004175354.bfvg3vhfqch35ib5@meerkat.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pXQ1jKnLz0YSBlquK4q7D7JoQVjjVm62KF2orsKZYLNPYNAj+h3
 MVJJZhpolAu2PeU1r3bkYJozjk8FLElf36L9FQA3wWpdUoVsIAUY08Jiog+u4WiOBzh7V6/
 hQ0v2ifDq5S0tZzW4yQiwegFTtA5ckez8WhoTzEjMaOcWr7tPFz26arLSBcAhEE/PBr1SFC
 nwcegtu+eaHRIqjxn/Sag==
X-UI-Out-Filterresults: junk:10;V03:K0:wJa772Smk1s=:s2w1iITOWIn6kRqZiH1Oo2pZ
 tSwHrSi8YZS0GHfw/4Dwx+A3k+9M8JKHB+HpN/2tURgfnVvRWlj5t+n39p4I/IQ4B9g4IN1dI
 R8SE2cQN1sAE9NRgKB7TasMzQb0omodxG7smA3/lkjJjdp8Le6O2v8ncLSIUmsXbIZS9xYySx
 wOcEyCcvhy77OLHyj4reUihMknpSL8wLY23IDe3byzWnnhDE15Jk4rNyptUmdF1bBa3jmmzaP
 67/wOSaQNL8SUY+QGYjFyVV2EbtjDmhebn+psljW7mRa+ly0aBqgbp3aeGP0auLxC/maI6pXA
 isUd84kbw9q+YY2U8wgBJk1SUH9dAq15f90NaMT8eB1FfGsJiSxfEPcRaXv7DaqoA4uyDUvBH
 +P8TSwYbPwzRZafqBD8UnFjuFzZ8xMYyNe+l8Q2jr8BGXXMoe0YsBK0uaAvix7NrxtPKQxJVF
 5oXcwlfgOFxapb3lVXmMA8qp2CpUGHO3hnxQwFRNfLq0y0vJJORRp4tx1qOKznd7+lUMzAt9r
 O6htHm8AHW0awmjftmhciYGNvZf8q8J/QLbKQQrV4ZGplL585Xl5wXj6E4H2rWN7ZhTpaEzPX
 DsQHub/ffIvo8Wlo26Bf3I7zMu6UhTGNXYPS/aCO3ERyGTojU1WEVBxfloCIrfvQlEfOemeVQ
 PdP1eJBn7zBzkhy32/zxUz2YZByLOrWTMBH/W8Dyiaq/HfysIT6BWqgmbchthqPw+jMPwSv48
 8YI7PCj97kbY2pQVFwnGx1Tigfb7rRSsR8MR1vE62CSe5ultFld1EFwejYv9OYzwFjLmDBhF7
 nzNpJSIBpYvz6B07boRqoKn/CAiymY/5MUxh0pI1L1ecgOunqvNeN/v9Xfzq15r9NtPhtx1o3
 OhcTb+s71dUoCcHN88RMdP+MmGH3Lu7VzSYbE/Io4gV3NaxdoTmtfbadwdRd7R9WvC6Usedtg
 ypHVmH5EY05W++soDvt3JTgBQ4uJyQZehNDiRCJMLWApij6IWoxgaPn0TyDaxaww03Y7S70TK
 D1mIXFiH/dgrjG7dNCApaGg/wlaOXWaWVn8a/X041ki6sGzbZyo91eImJ+L3McSOVAmDoxLgg
 NGeCJAeQ8giC97578l2bPMgyQQZzLhnx2zO1t7JdxXeyBW2k48Ii8ZfZANISrzV5sW7qM972x
 i0TP7yAnpbdEeLhLwj1ralEWsolG7TqoVQXnmdcCq43lggKRcqOGJrIQRWUDH2Y+xQaJ+lwGL
 rdnhxOeAt0Hq5Wprdc+oOCiLC7xsmvXXDd3iT/kvNwYqEiZZXm5LvkRIMHt6sDq5VY31b2feU
 N34UOdXwTB0YBvMlYPCJi6BAaPI3a26LE22hfpUENaxeQW0zDF+UmIQiFMaV48l75R+XW7Fz4
 doV5DsQ3UvaBfBsNKKEL+CUtFWViNlrE/i3EH/Wotp2f3lDz8trT/drPJ20wLO5nWj8nU/4tv
 Lqp7n0SGDNrRo9BpdQWOAcggiykV3qZ/DZAErwK1hvBuv7IZJcg2aZeIDs+NjlCFeR7O5+7KP
 u3Ne+i7UAYVn7ThkS0nQ0lxpGEyIfNcrQ7BGhcvgfw7/ZHD/46/m7sraWNzZtwVXw==
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MISSING_HEADERS,RCVD_IN_SBL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/22 17:53, Konstantin Ryabitsev wrote:
> On Thu, Sep 29, 2022 at 01:19:24PM +0200, Thorsten Leemhuis wrote:
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
>
> Here's my counter-plan, which builds on top of yours.
>
> 1. Create a Kernel/Kernel product that acts as a starting point for all =
bug
>     submissions.
> 2. Create and maintain a mapping from MAINTAINER subsystem entries to
>     Product/Component categories in Bugzilla (the scheme to be establish=
ed).
> 3. Establish and maintain a team of designated triage people who are wil=
ling
>     to look at incoming bugs to either:
>
>     a. quick-close them as non-actionable (tainted kernel, distro kernel=
, spam)
>     b. obtain missing information from the submitter as necessary
>     c. figure out the correct component to assign, to the best of their =
ability
>     d. set a "triaged" flag
>
> 4. a backend monitoring bot will track all bug changes and, when it sees=
 a bug
>     get the "triaged" state, it will:
>
>     a. create a useful bug summary from all bug comments
>     b. figure out who to notify based on the mapping (see #2 above)
>     c. send out the email to everyone identified
>
> 5. the same backend monitoring bot will track responses and update the b=
ug
>     comments as needed; any comments added via the bugzilla site will be
>     similarly sent out as follow-up messages.
>
> 6. the bot can also monitor commits and other discussions via lore.kerne=
l.org
>     and automatically add comments/links when it sees the bug mentioned
>     elsewhere.
>
> I'm happy to take care of everything bot-related (apparently, programmin=
g bots
> is what I do now -- I just wish it was the cool and glamorous kind).
>
> As I have stated multiple times, the hard part will be keeping a team of
> people who are willing to do the bug triage work, but maybe we can start=
 with
> Greg KH using his intern funds to hire someone (assuming he's not alread=
y
> using these funds for someone to help him with all the other tasks).
>
> Does that sound like a plan for everyone?

This looks fabulous.

Except, I'd love to let users have an option of submitting bugs to the
component they specify manually.

(I've removed a ton of people from CC because my email provider
absolutely hates when I send emails to many addresseses simultaneously -
my account was completely blocked for five days while I tried hard to
reach support).
