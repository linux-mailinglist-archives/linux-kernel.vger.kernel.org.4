Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1855F252A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 21:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJBTqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 15:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJBTqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 15:46:44 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959E02C125;
        Sun,  2 Oct 2022 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664739988;
        bh=6Kl+OQnone/lcVrvuxSt7WtLUF4kmTmxDXwKD2lKkFw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KcjFNuX2QUi6Dx1g7IzpzW0pHWKJwl7w8e444OvixBf+S/WqMmY0tgeS49Eu20OrQ
         TzSbLfnth4KeB/ddHT//oRdD6ppKfOVzgG2NQIv9Q2G/nPwrIdprnGrQvlvF5XTpUY
         3ly/HG1L7dWU7JzJkAVtgF3ZrefpGIAqMDnxZxaY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.13.110.23] ([143.244.37.73]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgeoI-1p8eRE2iKa-00h7lM; Sun, 02
 Oct 2022 21:46:28 +0200
Message-ID: <958c557f-6bc1-4126-026d-8a5f685df47a@gmx.com>
Date:   Sun, 2 Oct 2022 19:46:26 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
 <CAMuHMdWLbS5jnOpdq0a6ie3eB5rmM6Rof3390t0u5FeO4Hmt5g@mail.gmail.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <CAMuHMdWLbS5jnOpdq0a6ie3eB5rmM6Rof3390t0u5FeO4Hmt5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Unn7MI7g42hwVYE44CvJEt2cFDsQS+a3XlJh3dV9v1js8r2X69b
 urvccO5wBa9zhrdGj/6ONZoar/yZCeE9079fthXYBSgcMq4Yobxn3pu3HeZTntf3rH4M5U1
 6AZMNI6YCtGQJeM75EPbg3kI0+NjaTvo+eETxoMWKjKT47YF0u1zIG7Sk4uLTO0WPC4vVe9
 KE+ZeW1dDCP3wvCNScj7g==
X-UI-Out-Filterresults: junk:10;V03:K0:nktRTY4l4ao=:sOCUvY0nI/yplMakPAR+Ne6k
 CHWRGSkh0R4ob/+Zk+jAS5Iihet9tmLmn4psjToun1XmhYHQzYTE/p4I6A7krPw6jXuy9gUFN
 151ppivz9DbAZEyIb3GGmvglI71MpaiY6RfwPVfY58qTgMvw3hsDPAE+pZEmr06BHJnXc6aIx
 JVESW6k0PcvS69f5Xh/bODxsjAUQEC/sKGnK9egioj2982idJ8FakgMg7SCBpD7+A4Mn5GjNo
 wQnf3biBU5E21KP9P9WIqH3smC0NAdTlvZNJdZhnp/9iJEsvWrIm01LiKIDFOzHMh5oTzK43g
 VAI7dGX5OLEB409omL8Xg5tvITT4HbLaLdXYCPdgz9WOXIKgfaD8nOZyl31oElFwtLHRut+5Q
 MhKL6dvTGEiyumf9+/7OC0HTcU0bC7TdW2kH8QXoxEnUsgKxogZYUCLwj0o3T1aEl7kLwtKOB
 NZW7QdaYzykrxvklHB7B/m1KH7dEZNSZORVwY5h0El2pfE8Ig1CEZ33sA0ngEBMkEKebIMjzb
 uIpKe7iBhTCIDnemipb40R4OoRQnzHh0J+BMevslRHY3rmM72QuuIwuWmMD4Qro4shq3WkN4T
 KWh0wjrKKHrnF+8Id19+hhAqccKd7oH+Hy14jiv7dQj5Vp8tzXxh36k1qtIMFjgF4jKepvTBV
 orXKZRHbASigu+ZceFi0FmLeDWzsOY+3quec+jnmDgv0XvPnT0YBa3cjW4ObzSSs/nGt6tUw8
 bHxuv7FS/F91ITJBYEiJcBbrUKRcU/BHMNFv1H+VBo6BfKbc1Mg4eqlI4ubIWVtIKJcVMMRzM
 QILvQsYLmMpRcgqEdGg7pzKvhVGgtveS0xey4bG8ImA0FDu8pj5mnNUuaa8A6LBbWQ8S247UZ
 mROhLl+47M+9VE8hqoPCWevNo07B0NkF7Am3PkPQ9FBaW8HX0dFn4VmpG2KKrJHh/MWqQ00aD
 AAsQtuf38iusozGfsHH6RUqtpPnyfZyq/by+epET+u+FJuvtCWHYPnI8OWd6D4AB7bPW8feQb
 U1T7HoG2mvVm/qJ4dElGgWT7F8pf+eUt8dNALdd0KDiaTevmjJ6DOkC7YaRQmIT7nbJlisvV9
 S5PGsODDuXAWKq3tdZdR0Z8gRXIDgw5R2bZTP0lOsZapWJ9P54UoQV9hx8Wr4FDBgris8UY8h
 5cTywVdeUIEqoJkxPEeMuyhG3NXMrnEpkVT404M/d4RuBQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 16:08, Geert Uytterhoeven wrote:
> Hi Artem,
>
> On Sun, Oct 2, 2022 at 2:49 PM Artem S. Tashkinov <aros@gmx.com> wrote:
>> The current ill-maintained semi-functional bugzilla has proven to be a
>> ton more useful than random mailing lists no sane person can keep track
>> of. Bug "reports", i.e. random emails are neglected and forgotten. LKML
>> is the worst of them probably.
>
> Such a statement really needs to be backed by numbers...
>
>> Let's operate with some examples:
>>
>> Bugzilla gets around two dozen bug reports weekly which encompass at
>> most thirty emails, which equals to four emails daily on average.
>
> This immediately debunks your statement above.
>
> $ git log v5.19..linus/master | grep Fixes: | wc -l
> 2928
>
> So that's 46 bugs fixed per _day_.  Most of them not reported
> through bugzilla...

I don't know what it debunks.

Bugs reported in the last 7 days:

https://bugzilla.kernel.org/buglist.cgi?chfield=3D%5BBug%20creation%5D&chf=
ieldfrom=3D7d

Check for yourself please.

I don't see anything even remotely close to your numbers and I tend to
believe you've calculated something incorrectly.

Regards,
Artem
