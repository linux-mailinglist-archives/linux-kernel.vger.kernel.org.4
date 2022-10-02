Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7760D5F258A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 23:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJBV6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 17:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJBV6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 17:58:35 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B4F37FA5;
        Sun,  2 Oct 2022 14:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664747880;
        bh=J9jOA1o1FXQdz62pKWAShl02oO5tEkASgfZtwTI+yQg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DJ+KGjghRt1tgyrDsO+ir5lZVfl7eUbR0U/sGC9puqd+sMDzovDXUDBLssJWwvSzi
         Yj9xl/qllS67rOZ3rNKWOnuD539SMczJxuTazUrUBY/no+hMybIIBY6E5zvW3/yFjf
         /MQ5BuZZ0656ZnM2LpkuvjwO5zwyco8yYdJDd4M4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.13.110.23] ([143.244.37.73]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNsw4-1oqBhw0buq-00OIjY; Sun, 02
 Oct 2022 23:58:00 +0200
Message-ID: <9f943dfb-66d7-396e-eb99-b6cd30647a7a@gmx.com>
Date:   Sun, 2 Oct 2022 21:57:58 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
References: <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com> <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com> <YzmhoglDyEf3z0n8@kroah.com>
 <ce0b5780-a8cd-83fc-5b91-3acc574f426e@gmx.com>
 <CAHk-=wiGZEGY7kDXSD3ryL3yJ6fMp-+zzdyRFUc30kW+512-2w@mail.gmail.com>
 <7d57b7d2-b39a-881c-65e6-969c4f0948cc@gmx.com>
 <CAHk-=wjfAERC3XjZ=rF8HM+Q52LD-j_EEtv0hhiyhi6PC6MCUA@mail.gmail.com>
 <8f2ad360-8719-e275-050b-f279201a1616@gmx.com>
 <20221002214054.GB22532@1wt.eu>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20221002214054.GB22532@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TEcJbSh9IZr7Wrh1il7g1QMgcs72RJ1b9EZUf+e4lEp10eEjms1
 Mjt6Ra3L2c8YegM61W0MMckC+d6RkGDeO8ZZyxAiNF2E12g0mKI92lW7ClmQUsL3VMBhvfS
 yXW2elD062hf5YJpDbL2vXlqsUtpP8ZrCksa6PD9Yt1QEw6d6l4QL/EYVSu8jCEPtUR8N+R
 dM26yJT9p8ZVoHM89Nb/g==
X-UI-Out-Filterresults: junk:10;V03:K0:23qe81xX9kU=:ZuSzbdpVllOk8eT29yB046Ab
 Qval+jYhLuy4gkag5QiP53p74YdG7H7d8HEcx9qwoYSFCo2t82h4qDuPg03BuM7f3tO7vTHSP
 KmHbGQPZSAsHg+XDnv+fJK+WbNqsAS5JSoKH77FBiDy/Vw0ryTIC9qsomlt0viyQHIcyhqWYQ
 PETJC63A/kn9LT7aW13XBaqKTd4VQvGdtnpheZeWyC7a03QWVeCnlzdTGy+Uszi7OMZhts7dU
 wffeIBSfVuxhjMu6IIue7p6DL5OHiBlbgF2vS3mvQNErEIwbnwgXRlqCaW/LOFZkcV7Fh1npd
 1VqyRMJeSPtCwKedVvLVNGxnKcusdf6OgQ6nBFU6gOCERwtU77zxxphm+ed9weJRQw6yrZmCa
 2EJOtI0CpSsyyJxTsTrrzxakYq4P35Jh18ZPuhO/Kzt+B4qKAWEg0Kw+5nMc41Vzxj6h/VgVe
 rNASNt3tQDmK1RoYC9EwXq0KfiTJ+7sgD84d6mXbILN1Wf2pbKH1zxA5Cmkx8ua284fNhcoeG
 b4c4iiA52AavKYwh9Y8o3iXJw0RX60EsAwbKoDW528UV+Fh9EgoeQnCIP0xLNCc8H5p+5lS3h
 X5KbajcA2TWR30OAIKHFsFtd3vz3rBmiCpkM6AebtrwSNQRhVsTmXvk9ZIXAyszQCD1ZY4UiR
 wX/Epdgq557KVDs7oSc/M0vJ9rLzdskBUyzkHkCb39NHHeMfdZ1k3qzC+LjqL/xwbFtQpoUhr
 lOx1J/R68uVUeMuuS/0snr8eNdhfYCAy/4oi/L5Bx0gLSSeIqQFZQBf7ahQvks6mbSnvPaASH
 tOsWIhpfxb6hH1tqOR1YC5+4S+uUVwp3x3vtwTFKi8Kkv7oxs7KM2qq7KI9jfARLGv4G80BLu
 OElcvZUzxQULonnMb2mNugLkt4YcH+YsfXtSaIl85ZTyNHcJMZwk8R6oQu2GUXP5jPR6UQe/b
 0Kwg+5i59GJw/lsSaW4PNYWShQzb+jhEeqwQCDtw3eoq/++DvcxGc9d0Lajou6N0ISlkNIODo
 DA0Pa2OagE7c5zyHzGEWsorIjBGMta66ys5rskdzQk9MzIQ/xTYF5u7abD4Q+F0Ex1pUG2wOR
 bCsErq7L62ug/xuqTpgDw51VNULJeJRV4qI9a7QQa+28TS+/TsLI2/RVpUrjlFY2y2rmymI8W
 TaG6xdYva2JTKfI6Hpybz5zNyL+TJPbkh7UJWAy57CSTxQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 21:40, Willy Tarreau wrote:
> On Sun, Oct 02, 2022 at 09:27:40PM +0000, Artem S. Tashkinov wrote:
>>> Which is why in the general case, you really should consider email to
>>> be the "lingua franca" of kernel development communication.  It
>>> doesn't have the fundamental limitations and management issues that
>>> bugzilla has. If you want to add more people to the Cc in an email,
>>> you just do it.
>>
>> Attention, Linus, the problem is attention.
>>
>> Once something is filed in bugzilla, it's public, it's easily
>> accessible, it can easily be found, you can easily add new info.
>>
>> Emails? You've flown to Japan to a conference for a week and you have
>> much better things than to check any email updates. A week worth of
>> emails have suddenly become worthless.
>
> Serious ? Have you ever attended a conference and looked over the
> shoulder of the person in front of you ? There are 3 types of interfaces
> you see:
>    - code
>    - slides
>    - mails
>
> The last thing people will look at during a conference definitely is a
> painfully depressive bugtracker interface. However they will see bug
> reports in their mailbox as they happen to read emails from their boss
> or customers.

I meant people who are at conferences or on vacation normally stop
working with their work related mailing lists. I vividly remember Linus
mailing something like this, "I've flown somewhere, I won't have
[stable] Internet, please postpone this and that". At least a couple of
times.

>
>> Here's yet another issue, how would you send a follow up if you don't
>> know the reference ("References" email field)? Instead of a follow up
>> it'll end up being a new unrelated email.
>
> You don't have such a problem with email. It only happens when you try
> to respond via e-mail to stuff you find in a browser.

That implies you've been subscribed to the mailing list earlier. Will
not work for the vast majority of people.

Regards,
Artem
