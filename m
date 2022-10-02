Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20215F252C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 21:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJBT4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 15:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJBT4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 15:56:16 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D193F2E9D1;
        Sun,  2 Oct 2022 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664740538;
        bh=z58l+Q+IkerwN7KaPTJTK+ncZ25u4fKAErMKRvwHOLE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gQq7bojN+BiTUzUM6vBpsA7ZlZEKuEj4p3t4JXc1qaE15VIgHkUz+2KA7Bj/lFt2D
         AB2FYAOa3Sjusq7HyHkAOgumZ4w80IHf/IkIisVE1TwU1GflMF14ZAzp1pX1HsyKx9
         zs0TAwX3Qpoq/qbmTmyc3g045JDB5O+3D+bV3KHo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.13.110.23] ([143.244.37.73]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M42jK-1of53p33jc-0004Rp; Sun, 02
 Oct 2022 21:55:37 +0200
Message-ID: <4ace3c9c-f1f5-eb7e-58cd-c2081f77fa0d@gmx.com>
Date:   Sun, 2 Oct 2022 19:55:35 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Willy Tarreau <w@1wt.eu>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
References: <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com>
 <YzgY9X/DM9t/ZuJe@kroah.com> <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu> <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002175740.GA21700@1wt.eu>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20221002175740.GA21700@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QeBGdFhzym9DnEUO5i5xFh6vLgtvFsbjOg2Jz0KinZILYAbQaaj
 vXcMN9i7ahCjRGEen+0KUmMLzyP/lVzD7MRkFjygoN/xRrFHKxOigZ16+2COI2yBy3ykxkS
 gcCEC7HFHst13/b3Sql9m25P6X0E/rbL0ehIbE6K54naxGs4WJht4bjy1cY8q7Lgs3u/fdx
 XVRrh3VBH5bis4eAyCgqg==
X-UI-Out-Filterresults: junk:10;V03:K0:pXy6/7oeDAI=:b1nIzqRp4IkQGXcEc8WKjI7g
 eXi/C4lt4OESxSknAC31MWV8mBG8s4pYm0Qr61f0pvlWhxMIpvSY5/Jd4DJA2Tq6wPTR3y6Y3
 YOE/DXtB6sBY9NzT7t3OYhitzlmKWhGL1s0PgPQrPSuXJoYK1OGpazlDMRAxXGt58LXP8PKb4
 YLd8x34gMU0Grfm3fIZI5wnXjhZ0F54AsiXIJfYeS84R66T2h9qsZf9GdmnemPYTk6HDV3RYs
 fo51w1xhiZoSxZyzDYrN+ygVISostL+AASutMlE8X0lNQS7uex/C40JADIRs+M01AhxxwaMbP
 doftY/LG/NaWr66XmtaC1UFBjvIjO+Sw1+9lh7X3o4ZIRlEQALOKoL/stj0nXpRVM/0v90ooO
 YZ6eEY6tuS43xhLyFgIWKXdOrIkyX1F11LnGkwgjToXbyPXFqj8P5OD6mFZmKyKaSohCS+rK1
 S7SXJ2qsizgK18KpcWHAFuA9TI7DBhEoS1OJwH3ADt34Idn424eJzVlIiFoBewwe3xt8p/Pcr
 VPlIOcXy89Y3DNy3GnZsMqu5R1gzubYtq2/5XeI7gmlYnbVIyP1j7o4jqCuWqosffA+M9MJe9
 aI0tL3gztcqIf5Ry2CDypWAqZx/UwbmMQfzUUvhhwMNw5lOcRZkmTvatQO+mrYCRC/LCpOsO2
 z/0MjszHS0x8Hg5D7CNyGxwgJ2nqn/N2TXlu05SWVinCkzjZlvuZzJ69LUE9H8Xx/dlaajeox
 EkXnoR3w44T6qyRpTN3D+kI6g1oKHZQ7N/uxhMUauTyAJADzXmxJe88flq/kqeug/mMZzKWPj
 FCa0TWIPpIo5Dy1/hYOi82xuVPv/VmiSfaLf7W44MiyYc9yUK6SkK08/8Ng1DAgkwzX5cPZg6
 YUbhfV52jZsJ31fWKxHiI3tCem1/y7wSQHqkZciBaAJ1GtF1UDppcrm8AvRrdxO0pRY8yqB/b
 sfS3GL0GgKetqcmtVEFtPE/VJzM/1+D2u7iAufhyZPzo238C1ANYaOiEepab/9IkLfxfnoN1Q
 CixmeOuQCNvjtQrgtT5T6LAP9M8/g58qbM87zuOWSJbPWtHUyao/PhOpjnnt+epr+pe4sodcW
 n2MP+OzrdeSZrrKiBcc3cDyAd0C5xK3x2asVPP5VD2LC4FMa4Bpvj/SQZV3+PlJ1Pdm2An3jG
 k0LEFAiCurqkEuoRKCPGIv+7Ahbq1ILI7tGi33MjOiN+NQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 17:57, Willy Tarreau wrote:
> On Sun, Oct 02, 2022 at 12:49:04PM +0000, Artem S. Tashkinov wrote:
>> The current ill-maintained semi-functional bugzilla has proven to be a
>> ton more useful than random mailing lists no sane person can keep track
>> of. Bug "reports", i.e. random emails are neglected and forgotten. LKML
>> is the worst of them probably.
>
> You seem to completely miss the point. There's no need for *someone* to
> keep track of the whole mailing lists, these mailing lists are used dail=
y
> by thousands of people. It's a *collective* effort. What matters is that
> there exists someone among these people who will deal with your request.
> Do patches fall through the cracks ? Sure! And so what ? The important
> ones are eventually noticed or resent, and there's no harm in sending a
> "ping" once in a while. Actually I find bug trackers worse for this,
> because they give the reporter the impression that their report is being
> handled while many times there's noone reading at the other end due to
> the amount of stuff that has to be triaged. With mailing lists, a sender
> who gets no response starts to wonder whether anything wrong happened an=
d
> is more naturally going to ask if the message was properly received, thu=
s
> reviving it. It's extremely rare that nobody responds to a retry on a fi=
rst
> message.

I've given multiple reasons why mailing lists more often than not do not
work at all, I won't repeat them again.

You can open LKML right now and check all the unreplied emails where
people complain about various issues. There are tons of such messages.

>
>> As I've said many times already: bugzilla must be an opt-out, not opt-i=
n
>> experience/option.
>
> That's the best way to make sure those who feel annoyed by this spam wil=
l
> just redirect the bug tracker's address to /dev/null and will never ever
> receive any message from it anymore. That's quite a common pattern, I'm
> surprised that it's even still proposed as a solution...

Great, it's a single action which takes at most a minute. Why are people
creating a drama out of it I've no idea.

>
>> Let's subscribe the past six months of developers using git commits and
>> if someone doesn't like getting emails they go to the website and
>> unsubscribe _once_ which takes a minute. This is a non-issue I've no
>> clue why we're dwelling on it.
>
> Maybe because you have not yourself been spammed by bots that each
> require a different way to unsubscribe/unregister/reconfigure options ?

There's just one bugzilla. We are not talking about many bugzillas yet.

>
>> Let's operate with some examples:
>>
>> Bugzilla gets around two dozen bug reports weekly which encompass at
>> most thirty emails, which equals to four emails daily on average.
>
> That's roughly what I was getting from github when I disabled all
> notifications.
>
>> LKML alone sees up to a hundred emails _daily_.
>
> With a difference that these ones are not necessarily *read*, they're
> *scanned* by many of us before being archived via a single- or two-key
> shortcut, with a particular focus only on some messages or series
> (hence the importance of a good subject).

The problem is today you're scanning it, tomorrow you don't feel like
it. An email gets lost, a problem is never addressed.

Again most bug reports sent to LKML are completely neglected, and it's
_not_ limited to LKML.

Looks like that's what people here are advocating for. "We are not paid
to deal with bug reports, so we prefer not to even hear about them".

OK, let it be, let's deprecate bugzilla.

Regards,
Artem
