Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA545F2337
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 14:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJBMt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 08:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBMtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 08:49:24 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CBB33E23;
        Sun,  2 Oct 2022 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664714947;
        bh=b6nOSk+G6/M2t++jcFr9o70FWRqfaeJouX4moFYQdbc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bxvMmrx9ogGxufUX/VcpfWDfXP/7wrs1l9xvGM+IepdBpwC03CA6Hv2+D857iJZpG
         6PoOwOeGCCOC6Qt/GjoTNPX25oFS3nKAcaRCrTcDpjW8o4Z6Uq7QCsc/KCdPnN2Ox6
         BoGSPOYxYsf1rn4WczFOD/Y9WmG7AZwyAbEQeyr8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.40.110.21] ([143.244.36.77]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiTt-1omUud3bSf-00U4S1; Sun, 02
 Oct 2022 14:49:07 +0200
Message-ID: <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
Date:   Sun, 2 Oct 2022 12:49:04 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
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
 <YzmBjgXq9geMnL1B@mit.edu>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <YzmBjgXq9geMnL1B@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G+pB4us8oEMVimmpccHY45xPmaHgr0GlITE2eriHZ5ULotrX5Xl
 zpGdTKFX/MkRYIDzjnt3V3dGBVr9nQt2mdUNyFuHuNSWhE6x3wNS6EZruu2efSHIsMpmMVq
 QZEOF/jY0ivJBKvG5ZTTu4dNaZ/FnDGRHzXv6dikeq2LHD0jnUXlUd13N8/tmq+6MkbGNRk
 s+NkyIhr3GXnmkBdwwf8w==
X-UI-Out-Filterresults: junk:10;V03:K0:vq21Cph/e2E=:Mardtgpnm09Znl7GMi/s6tVU
 e2sfMdLcEBr40XreaYx2SiH1yIaznKy6MqvsrJ4gBdM8CELgpfp8gwDR9GHndu75YvSNFKVMJ
 aKTkwj+Fzq3pGENP9xJ7vQkHyj8LlGjkNLeUt2f1KGxUMMIPRBm0yfN1vsq4RNMAP8qiwqo/S
 okxv3YpdJfy0HwzmeODaUtyGJGL8u7ITPUo7MrmbjFaGUYYk0V+3ipcWX22d67tT6EF4uKn1x
 nu5Vr9tzb1Qm2TUzNSQSAMAUaMGXBWjzao7A50quKCvEdu6/ueRsXFz6CYlc7qtC4CTNooRp3
 YK6kyE/He86mrTb8Oeq7Z6AcPKyqF/GGwP6Zx5jsHAZY5HZK3nOAS04AWVbLzcuCu5jbJYlWU
 DznqRUOWYz5f/aRPtKof7GY1XiN0Geh3Qy4FnA7vjom2BVbyL/TBYOOVWXEnVKROF0oF4Gg51
 eUUHgilKqsHcgm/tGYaOyk4icYs3+NVf09PTjO7yOJ60IZNqhJdpwBkZr15AK94qI+JAu3zKk
 o1mb6LCs/O1O8/cdkYq0psOBFGzsaiHylzKprHCGrisvtkRlGfsmjtGWxka3dgXXOr+jzlMnD
 SAa0DFycyp5vBuKZV5Lt/edO2OnMxeGLg6BBb7yfC/1GZqrYVMYkEiKbgSQZ8ojL4H2Q1n6g9
 VdkZsB1X4/sikvYbMoH1F2MMnGet8+7Zr6cs0KrEESjSKVRAnrmMx1S9EJroOf+7XuB/fyheh
 bNvOWEC3zZuNksZNQQCr5v97zqSIeZwLdN4WgwYXEQFDkG2cv3+lz9pzEmGOxECtzMqzD4mIq
 OCgE4tyu5F4mx8a+gXwHu4GNpn5ilJud+aL6yK6uazwoAiFOqWXecUFmtGPd6DnJazapfq9SF
 pDccZN09Qox8+NLty/WHgfqcbnV5BOx2LE/C90v2D3tWjiyDZIn1t8jvnoQ5p/Z1aDqWf6K/i
 S8RNpMLMOBWcJ1NK0x6aiSrQQrj48E8BqiZie558E22oGOEK1A1eEN5fATBWz1vkzmBEdX97N
 egUTBV+tBtBUOEPYMgOwPAojgnZD6hohE/ho9G8Q6ISIvL4r9gl6aH+lU6QRoNykuwaBdOI1s
 NvY0cpW1F0kAwM11bo1evtFIJw1jc5mxiZUbBGZ1qnVEU4VRZbkX3iMpuJ87myrS4+FBEAIIF
 L2QQk0On9uBp0Oi6qXKN00YZd2NFBNljNjbYslTSTLxciQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 12:18, Theodore Ts'o wrote:
> On Sat, Oct 01, 2022 at 02:58:04PM +0000, Artem S. Tashkinov wrote:
>>
>> My expectations are actually quite low:
>>
>> * A central place to collect bugs (yeah, bugzilla)
>> * Proper up to date components (they don't change too often, so there's
>> not a lot of work to be done - you can refresh them probably every 12-2=
4
>> months and it's gonna be totally OK)
>> * An ability to CC the relevant people/mailing lists (this is the only
>> serious missing feature)
>>
>> That's it. It's a billion times better than random emails sent to rando=
m
>> mailing lists. Signing up once is easier that to keep track of whom and
>> where you've emailed or not. And of course it's a ton lot easier to fin=
d
>> the existing bug reports.
>
> First of all, some of the components do CC the relevant mailing lists
> automatically.  And this is the part of Bugzilla which is hand-hacked
> and has no, zero, nada support upstream.  I'll defer to Konstantin
> about how easy it is to keep that working.
>
> Secondly, not everyone is happy with getting an e-mail message sent to
> a mailing list that has a lot of bugzilla metadata associated with it,
> and depending on how they respond, the response might not make it back
> to bugzilla.

I've mentioned it a dozen times already - you're unhappy with emails
from bugzilla? Go there and unsubscribe. It takes a minute and we're
talking as if it's the actual issue we are dealing with. It's not.
Bugzilla maintenance and its up-to-date status are the issues.

>
> Finally, in the absense of someone to actually close bugzilla entries
> and do other necessary grooming, the bugzilla database will rapidly
> become useless --- in which case, you might as well have a web form
> that just helps the user send e-mail to the mailing list, and hope it
> doesn't become a SPAM magnet.

The current ill-maintained semi-functional bugzilla has proven to be a
ton more useful than random mailing lists no sane person can keep track
of. Bug "reports", i.e. random emails are neglected and forgotten. LKML
is the worst of them probably.

>
>> Bugzilla as it is works nearly perfectly. We have a number of developer=
s
>> who don't want to touch it or get emails from it - it's their right.
>> However it would be madness to take it from users. That will make filin=
g
>> and following up on bug reports an absolutely poor experience for
>> absolute most users.
>
> At the moment, developers aren't following up on the bug reports.
> There is some debate as to why.  Is it because users who can't figure
> out how to send e-mail, and who send web-form based e-mails send low
> quality bug reports that can't be easily responded to unless someone
> is paid $$$ and/or has the patience of a saint?  Is it because
> components aren't being gatewayed to mailing lists?

This is not always true, some of them do, some of them actually check
new bug reports and do a tremendous job at helping people, e.g. Mario
Limonciello who helps resolve bugs which are not even his direct
responsibility. BTW, I'll now CC him since he's so active over there.
Would be great if he chimed in.

>
> And if we force developers to get Bugzilla spam whether they want it
> not, and they said, "absolutely not", is it there right to have the
> mailing list gateway disabled --- and if so, what does that do to the
> user experience?  Thats basically the situation we have right now.

As I've said many times already: bugzilla must be an opt-out, not opt-in
experience/option.

Let's subscribe the past six months of developers using git commits and
if someone doesn't like getting emails they go to the website and
unsubscribe _once_ which takes a minute. This is a non-issue I've no
clue why we're dwelling on it.

Let's operate with some examples:

Bugzilla gets around two dozen bug reports weekly which encompass at
most thirty emails, which equals to four emails daily on average.

LKML alone sees up to a hundred emails _daily_.

Getting worked up about it? I'm dumbfounded to be honest.

Best regards,
Artem
