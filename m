Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3785F42CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJDMQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJDMQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:16:56 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B202018B;
        Tue,  4 Oct 2022 05:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664885791;
        bh=bpj4hT8aKCM5j/PSqq2l+Mhtjnt1+/PxDY0aFNs17Cs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XaCpZHtgZZcIk8afsOe0AFcPyFP3S8cNcnJucbF/apJ6KM8zz2HmSQEeZqzzIwsVL
         bh+504f+eodqQA5p0vMEeVCE5kmiSaTZcyA9OJX1/+dZ/ITCFit6bvgkmqPVCRoUjD
         EmlEHXAKdyj/yqs9FkIoeCd01LoGKe9n+QMolCLg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.17.110.14] ([143.244.37.77]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DJl-1ocfdj438n-003dB9; Tue, 04
 Oct 2022 14:16:31 +0200
Message-ID: <fde043f3-da34-9fc6-379b-922f29284e66@gmx.com>
Date:   Tue, 4 Oct 2022 12:16:28 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
References: <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com> <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
 <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home>
 <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com> <YzoY+dxLuCfOp0sL@ZenIV>
 <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com> <YzqjfU66alRlGk5y@kernel.org>
 <251201be-9552-3a51-749c-3daf4d181250@gmx.com>
 <CAMuHMdX8Ko_LiqsWafzcqheW_7SZmtzEvgrpBbyoCLxyWqjqBg@mail.gmail.com>
 <1d3fdc6a-a98a-fe3b-2e3e-acc2ffa24f9d@gmx.com>
 <20221003102029.1fe4f31b@gandalf.local.home>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20221003102029.1fe4f31b@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SLfgjVdlF7X2l/Rg+z8mjWCt4AvRLhhZPbCaKSNbyrV4j/6O0gj
 uk2033ABnu5nBei7NAIDbVgfLGxK5/Fh+BXc88Nw4CpMU/JCJbfcw3Lv6E4ZrjcaueKDtnJ
 BDZ+Khl6ICrWZ0D323ER/PZaeHYgVduAC5rOku2OHxS/i7vYSkLCpKBgnm90va2y5mqdw9L
 RKF8TM4TQgrKoHSISVnRA==
X-UI-Out-Filterresults: junk:10;V03:K0:TkA4SQZEqIQ=:VI+bDZS2UvDLj2IMmM+ofbOH
 PJr68FLrJFgSaJIT2PY/2K8MspuiefGLtIxN7rxW4LyYzFD67vFJQ9GvzLx7siIIvZ2rU/OvS
 r7c+B71IqGDHCmmJ+gmaT4lv6+O+rWl/YEn93X1PXg2VKvagZ04zCF5yeqfiJtUqEh3NSFtYF
 3Lptld4ic7OIEG75xC7DhTgEaLSeJEQME2rP4MedTirZL2uHvWHq8l5pnffkMg3W42SuoEOA6
 BTElgax42aOtaXRduBevj05D/c0kvuKhWFQCmfNyFDe65kh5uXLB90/fsE1Hsrr2It650v9wK
 0Xbw/TsqH8msdIKLKaHUc5+aqGuYELccEmA7v2+R17ZH+6cYEewf5mc9mIZfE8MgORYPfrRu7
 E1oTEaQFNNgU2MurWBrdsAbkKvMc55p8D9EgS0QQk+Z10J8UjvwNfoXZFZUcGYvjbTie/s4+m
 oO+eXSPkVr28g+IQWj1wuEE1zDBZGUWSJRMzb7WlQRY6JYIyje64VwkZ9a2nDS5AiGSVUNpga
 P7rlc94OmTScgQN04WAxaRWCeLusd4k3bH9V4PnCQvVMCdl7WgV0eyHDliD6cA15HuVeVo9CR
 0NVmDpOi4PU37N+WoBc0k12vZeBoqHCOAm1KM2VNzHQHpw65zNbww9ypIiMWiI2gj+u4QDg+R
 EnL+rqbEjCVfdwFl8dUnXMl90PGhfvT8lwAoO0y5Lq/o/KTpo/8R8N3+cnBOOm+KFh0dxgv+O
 t5LQ0/dvEghPWwZpDobXOMpqetwTCVbaH8gXj07TnXU0Wu9nQRi5w9R9UeslvgxJiODBmcC24
 9wLlVduDd/Nw7qDDkyGJgqHPAUrCPtLkXQRearVWm2bwhKWIeXeSLhlPrAWbcGzQfPlvUu7pB
 dhH7ORMfbefwnqSUzxG3qr/0oAx6t4HorYzLany6VG7Vhw5VsxctRLkR1pM2vMBY5hcz4/XtG
 k/SPvH+WBj56cmNvgi4M0QsLqV4VrJWYyMLO/9rpudLLNzqoUyuNAluCI+UjfusrXbDlsr14Z
 PRDKwf645+Fd/I9CYGhHDgVX6ZzjnVIZUF4akC+GnALGv6ejEWLGov8zmdt0LtDyn/BRwkjkd
 MkolhIMjrK6BboYAJCbGJbwetRMrxuybG3yRMZ7D2R1c4ULRyKRfvKc2e5q43+elnr3/2c3Ip
 HncEsiGEqaqPjRwd/ww9bjybnU1Qsnq3owKAHB+2fGCDnQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/22 14:20, Steven Rostedt wrote:
> On Mon, 3 Oct 2022 09:40:43 +0000
> "Artem S. Tashkinov" <aros@gmx.com> wrote:
>
>> For instance, I've CC'ed Linus Torvalds _privately_ from Bugzilla twice
>> and he _chimed_ in and _helped_ resolve the bugs.
>
> You didn't Cc Linus _privately_, because you Cc'd him from Bugzilla. I'm
> guessing that means it's a public conversation. Which is similar to Cc'i=
ng
> a maintainer and a public mailing list.

I _did_ CC him privately by adding his _personal_ e-mail. I'm astonished
not only you don't believe me you turn my words inside out.

>
>> My messages to LKML
>> were _ignored_ by +1000 people subscribed to it.
>
> LKML gets 800 emails a day. Nobody reads it (besides Jon Corbet and Andr=
ew
> Morton). But if you send email to a maintainer privately without Cc'ing =
any
> public mailing list (or Bugzilla), then it will likely be ignored.

Wow, so pretty much the vast majority of people here advocate for
deprecating Bugzilla and asking non-IT people to use something which is
essentially a ... SPAM list?

Woah.

I've given almost a dozen reasons why mailing lists simply don't work as
a bug tracker in absolute most cases.

BTW, this discussion is a perfect f-ing example of that. What could have
been easily read in a tracker needs to be repeated over and over and
over again because you didn't bother to read previous messages 'cause
you were busy, not paying attention, simply forgot and you don't want to
scroll days of messages in your inbox.

God, this is so ugly it's cringe worthy.

Most people here who advocate for killing off Bugzilla:

1) Have _never_ used it
2) Have troubles even following _this_ conversation

That' ridiculous.

>
> What we are saying is, you need to do both. Cc the maintainer _and_ a
> public mailing list. That way the maintainer knows others can see it, an=
d
> could point someone else to look at it if they do not have the time, or
> they know someone who can better help.
>
> -- Steve
