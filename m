Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584A65F2563
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 23:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJBVH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 17:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJBVHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 17:07:53 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF2A2CCB3;
        Sun,  2 Oct 2022 14:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664744836;
        bh=rUPWwxQghqBoTsy1GL3TJG6JijaqINIBDDwimlKpQ2A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WURI/5rrVB0y11dS4o5pEw4pdy7ok84JQ7pRHat9OLq7xmLN19WrDrO+sGeNF6zaG
         ZXNDoTxvG/EP4RIMJ93z6lBrvXnx5O3eAmKtL2iwyQH3PGx3dfk5B+sANNeqgtrZsq
         3AQqkwN7iEfLYbTwq8ibOsfPQGOwyn6aH+CYvdgA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.13.110.23] ([143.244.37.73]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCbEp-1oWXbc30Lb-009eAV; Sun, 02
 Oct 2022 23:07:15 +0200
Message-ID: <d1f99826-2a66-c2d5-c9cd-d2fadd35eca4@gmx.com>
Date:   Sun, 2 Oct 2022 21:07:13 +0000
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
References: <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu> <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002150522.ul4nbtfawqjhnsag@meerkat.local>
 <b594681b-6b8c-ffb7-f526-3da847d160a8@gmx.com>
 <20221002205430.GC22129@1wt.eu>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20221002205430.GC22129@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OOGCfeol/3qU55wo6wmgNNZwCIlcy1sEWv8KdnSgTkop3eIwVg8
 Hi80881OmBGlcHf6GL59BudNRA5SF9LUHl7icLNG18ygjeXhLlwT2f+iKHk8VvTFbodc35w
 lmyM36KqhosAzMRs46ogkP5Sxy5BgGZX0HcSkONrlalo4bv3gdZl0W0XgoUnaFiwO18kutB
 SmfD6QWErw/MRbP8wbZFg==
X-UI-Out-Filterresults: junk:10;V03:K0:LXbn3my7Qjg=:sEapeLsGTqe45Xt8L0+hmV6R
 jNmuWsa0yQeYKgUHxjxVGhEXUW4Xm3lGJx+LwW86X4Bf1O1cXn8NMM+piTr4zJORUcKoKb8OF
 8jVt5JS/S+OK/bk/MYhw074I2AwdcDmL+XsdHndr8qN6Hw7/jqFe5OqYcfgas6svDKhZSBukP
 cm6re0VgDe/oPmIaI4NkIAT7D7EaGUTJLIFsTnqNebGcNaALaLuFz/Gs/bvfXhdiGEPB+64j5
 3O3Pftz2ex6khQZQDUI9lAe1D7dYO1SkoMtZ/nMa/nWO72e8lewL99JwSIO1sJBGCSx4Zv2RH
 tFNRBT/6C4+7ypYuPeuSkN3fmKk3KmXxYhqnPPWaXc2JrKBxJw6syeKPQvrEAfSh1IFT8BuQf
 9gFNh5V5YxwDzFI+rn084gnXH94eiodorZNQ3XlW4Jv6sXXSUsh/xSqcjHcawdfMrRvRd5T0f
 XdeAnQ8/vjE7iFb6OdoDDmyJ6vZMK/p8v2n7NyIxaZD5Cl3ZHiRHLVg5cAL1rVlhBmznpdpvk
 xSI0IP7XSQ9UiKXQythbmKeLrG2snuEHtFQaSyU2/Emqlc7qhTzAb4e6BO85Fm3Io99xwh8ci
 wHg+8/md1lEjwEBDdS2E895LqsJzobQCPtXy4xWl1e9y1+F4uymfTOojmJHuegDc+tT3mk7Wi
 orKkUXKAtBd6EjP7cOfLO1p9U8lwjUZFxgCE5d6dgdK4riyAEXQAgEM0O8llXByG3UAOSHdlA
 DOPOuJmZAAwfGqOUTkMavzIfNSnmVRDZBYyIkk9IzbhQx+1gvRplkAO35jqUY8f+/mhdJUnat
 QzGDAhtuLgUjvO/kEVVC7tkYoJJJsHI23eprtx59BmLB+NRnpBXQG0ruWIohDdszPhbbFe4BI
 yUhJqFl6+3o7U/gD8nSHkOESTNGifztjNQcd3JnMuMOmgJ1oc62FTv3PIsfGrachhGQqeysLV
 ViDN3VvoAHbmgFn1+PuvmuvZmtDhkchJC5t5AoQ5+d6BBNxSHJd8an93lHn23yQQnR98KE64D
 6sNd6EcWBY4Hjt2q7woaxOPWRG006poJTVZl1OgWU8esYbDIuIhZhFxPwa2PN+vfZhNRuFk5X
 5v78j70JCFhBwhIkKUpQI9DpjflrTtJCqWu+u+dhoGHyjT0v1H8sVc44OSl3ZytspITffmwOI
 AglF7eM5STOLExjidm55Sq4HOGMfYKv97lRSG4j79PzpSw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 20:54, Willy Tarreau wrote:
> On Sun, Oct 02, 2022 at 07:43:19PM +0000, Artem S. Tashkinov wrote:
>> Again, to remind everyone, bugzilla sees around ~20 bug reports
>> _weekly_. There are hundreds of active of kernel developers. That means
>> for a single bug report maybe a couple of people will receive maybe a
>> few emails per week.
>>
>> Is this really an _issue_?
>>
>> Why are people are now blowing stuff out of proportion for no reason?
>
> Because the approach is wrong. As I explained it gives a false sense to
> the reporter that their issue is being handled while the simple fact tha=
t
> a message was sent to a person is in no way an engagement to do anything
> about it. LKML is a broadcast area. Everyone hopes someone else will
> respond and that eventually happens. When the reports are targetted, it

No, it doesn't happen. Should I open LKML and send you a hundred of
unreplied emails over the past year alone?

> puts pressure on the few developers receiving the message who know that
> it's unlikely anyone else will deal with that report.

"Pressure", "spam", I've completely lost you.

My first proposal was to let people _unsubscribe_ which takes a _minute_
if they hate this kind of workflow. And then I calculated how many
emails a particular developer may receive. In the worst case scenario
fewer than five in a week.

What a drama.



Just before I GTFO I will leave this bug report here (already posted it
here but maybe I need to do it again and again):

https://bugzilla.kernel.org/show_bug.cgi?id=3D204807

Tell me honestly how ~255 comments, and a ton of collaboration over the
span of 2.5 years can be managed using email.

>
>> This conversation alone has already seen close to three dozen emails an=
d
>> no one is complaining.
>
> Because it's easy to ignore. Try to setup this conversation in your
> favorite bug tracker and you'll feel alone discussing with yourself.
> This is a great indication that participation is much more powerful
> in the mailing list model than in the bug tracker model.

OK, let's kill the damn thing.

Let's have random emails with duplicated issues over 50+ mailing lists
no one sees, maybe some of them are replied to. Maybe 1% of them are
actually dealt with.

After all, it's all for fun despite > 95% of kernel contributions coming
from people who are really well paid working for major corporations such
as Intel and AMD.

Regards,
Artem
