Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EFE5F2C2E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJCImi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJCImI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:42:08 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6439D5AA0A;
        Mon,  3 Oct 2022 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664785085;
        bh=XJ3yLIRRwz1eAbA1d81tgni1urtwHc90e4KEWk3oQUY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bGoLBaaoefiHB/Mo7Z4T2N1QEEPe3sgFfXgQl3GCXu/NcCH8sQIZVWXQoJJYq/ZCw
         bEGXf0nWzlsWSaep2efUOpTxGtBOGVjS4Mfh1loy7NLyG4l6/2LUHBNQGVWyM9NrZI
         OPaQqNSaOtabYuNNXd1+/19qiJ0dtzmcSzeI7aos=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.25.110.16] ([143.244.37.214]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DJl-1oeROY484L-003dqo; Mon, 03
 Oct 2022 09:49:40 +0200
Message-ID: <c828f525-8fdf-186a-2d18-582f534ecb61@gmx.com>
Date:   Mon, 3 Oct 2022 07:49:38 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
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
 <867b35b7-da2b-fed0-1f75-b2021d9be499@gmx.com>
 <CAMuHMdVkFdXiqV-k2X8yDh5VkR3cv0a4z78z+uCF_PfgHgGx=Q@mail.gmail.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <CAMuHMdVkFdXiqV-k2X8yDh5VkR3cv0a4z78z+uCF_PfgHgGx=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mWPRkpUwznFoXen54lwUDHYoG8g+JNyj2hfp3ybTKUdR+tOxStu
 G9Apot6jK42gV9UmZ9qStUhhErPzgODzzfhHCJc6n2Z1IMSHBeNL90AKd0vCNXhZZmLwsXz
 Bi1dTT8NZLbVpIQfcYKazScIdY4XADEJ8CyNRTnRcfihCaRyn4BECQgBXDJIU1l3z1ai5mM
 IWOSfokpeCpVP0qQy2yvg==
X-UI-Out-Filterresults: junk:10;V03:K0:Hw1HS/MjyYQ=:cs0BYDL7pxejYdoweAqaRxUC
 vDl13Ms8IUIGgdkY/h7M8x84v3Cw+Cnw2NQBhqgXqJ/UlQ3ZjIkZcsKpyQIE4247VOb5Zc9UT
 AIKhbRwlxZROL2BAZQr1iF8QoHGVoVdjGkK5w4dvsJHGPtSwtEp+vLADiBSf8H+hAng08f3nr
 AEgNtqBdJwR99k4HYnnZLz5QCW7eZGvhjD8ylLV+zcSRzAINLJ/HkaQ/IT4Jl35X8LsWpIBL0
 6hJFApuEdUKuOvzDJmhEFqgp+HVtdDAR0FpHHs6D/1BxGIu8xWvdx8FgKBoJsdOQ5RZP0ywRI
 r6FGKRSq6RXwSSxR61sDEchI+DThrP2/vZcbaXtMsjWbO6VS6uDr5igr2PYToLLuLp8pcL7i/
 RuhXdsPo14mWhq+9vcW+TEjDkr7lV51RzjRaVOmYziMZ5tHQgQd5le/IGteCqxgqBjS8kxFiI
 CjriGX8B5wzK42kLzX6AOgViNrAG5D7YvZIdP+IyO8y4BN5KSeDkzuB68wjosdRyF7NkAj1+2
 h5LR6TaCukNtmGudRFCalsqCwm5UHCv3Vd7ScBhOfhSv3qrMhWnA9bbn1NGzhIjm4A3LKol2i
 t6huW7svRHxJ9rjgveuqZjUnZaPZ22tgbuW9uCzNVJcHn7qxeEPHEfUAFNCbgPcFvbQJHYkOV
 IZ6nr7ixG27GgW1XmD+JTiWSPSPR39VQaPAiR+0rgzfUmdKaAILudbybYIJw5OjEjZ8UMFzEL
 FWKmNxh+oMmBJvAELk/bmfugYa79RHDMFp2IKQTg7J2TY91AZ4kB+3ynRL3GA+h8TU4BFzUih
 DIh7cyuMCJj6bDXY3DyMCejv08FAVty1SMvEj6g6fyqASaCQlRih5cAcGXfuveR7VQ22rv3vD
 Uvey5/nh7L79J9SlacmYUlke4Mbqms1UY0rG40tnNkWP7XGe5rYWRtBVR1Gvay7tziRuTY37O
 wtxrjtUpqYE87unpQxsUESq34jFawtq7FhaXYSyaPx/FS7Sd77s3b6DR8z34TenKhWbf4u1u5
 /QpWlFMsxEJl0SYU92nRTn+ptEB1TEV1/AkDOMPHRzkvs+V70lg/Qy4DCb9364v4xfXD88/9j
 W6j6p39EIco+DpiYAV8atSvaOA4FVJjx4AJq/gmx0zLEH3/rmC2KgsT2mEkTdi2dpdf6IOLrZ
 V/vyAiFPkMUOMmHANDUHBUXtNIguJkJ5U/vvYzPmMGrJIg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/22 06:37, Geert Uytterhoeven wrote:
> Hi Artem,
>
> On Sun, Oct 2, 2022 at 11:54 PM Artem S. Tashkinov <aros@gmx.com> wrote:
>> It's easy to join an existing bug report. Tell me how can I join an
>> existing email thread without being first subscribed to it? I certainly
>> can, absolute most people will not be able to.
>
> lore.kernel.org
>
>> What about sending large dump files? Should everyone on the mailing lis=
t
>> receive it?
>
> post a link
>
>> A bug report is a simple plain list of messages in a single place which
>> could be read with a web browser. An email thread is anything but.
>
> lore.kernel.org
>
>> Searching through many emails at once? Good luck with that.
>
> lore.kernel.org
>
>> Replying to a particular email? Good luck with that.
>
> lore.kernel.org
>
>> It looks like you're under the impression that every Linux user who is
>> willing to ever use Linux must:
>>
>> 1) Subscribe to _all_ the existing mailing lists (just in case - what i=
f
>> you need to work on something which was started by someone else)
>
> lore.kernel.org
>
>> 2) Know the email etiquette
>
> Just Be Polite
>
>> 3) Learn to be persistent and resend (an unknown number of times) your
>> concerns hoping they will eventually be addressed.
>>
>> Bugzilla: sign up once. Follow up. If you file a dupe, hopefully it wil=
l
>> be marked as a dupe. Everyone's happy. No particular skills, email
>> clients, formatting, referencing, etc. etc. etc.
>
> Having at last the skill to provide a good rebug port would be nice...
>
> Now, back to work. The merge window has opened, so there will be
> bugs to report and/or fix...

Lore looks alien to me and in my life I've worked with a dozen bug tracker=
s.

* Where are open "issues"?
* Which issues are now resolved?
* What's the status of the "issue"?
* Which kernel subsystem is responsible for this or that "bug report"?
* How to change the assignee? How to know the new assignee has been
notified?

This thing looks interesting to discuss patches and merge requests
between developers who know each other and even at that it's not exactly
super intuitive. Again, you're not thinking about users who have no idea
how the kernel is developed.

If you remove bugzilla I'll never use lore.kernel.org, I promise. I'm
frightened by it.

Regards,
Artem
