Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7D35F2231
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJBJHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJBJHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:07:13 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C68E2FC1A;
        Sun,  2 Oct 2022 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664701621;
        bh=PqGSxs4/w7tewH00w09AppSCiGB3tMkx+FCb9dz72WU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VezIpafB6rACnpjZZZz2ljMxJbFK0H/HOZTHm9iqcOZ7jIxJeuOpNLOtMXMvNIjR+
         D+OihCAtH8RJxTvdxJiyDmxgBCkxvBIq6FpY/JZmaV05dH5ywNS1RL2T4rAJIi5HkA
         Upn+CwuFnH3SIF4iUb58vhDrSflaAY+UBucW1Kt0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.40.110.21] ([143.244.36.77]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJVG-1pBTzn0puw-00fQ5x; Sun, 02
 Oct 2022 11:07:01 +0200
Message-ID: <90b7db52-38c3-aafe-2b8e-c7ebd6a484c0@gmx.com>
Date:   Sun, 2 Oct 2022 09:06:59 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com> <YzgY9X/DM9t/ZuJe@kroah.com>
 <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <CAMuHMdUWontzcX=ww8HbVWc2j418SdyzoPyKa4HHFsxzijbVSw@mail.gmail.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <CAMuHMdUWontzcX=ww8HbVWc2j418SdyzoPyKa4HHFsxzijbVSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/OFvAW/ncK7MKc7xcAZb0oabkWorTZj/NhPPscZUap8y+SC4X36
 kmxokWjVqa/sjZJVX0hY1+WSYvLMZhe+1xGqUYXCoqOrQ0vAK+AE8DTqToioPNok2e6GDRU
 z2MRtb70t1IsbFR+Stn4RTazVf5IzvhgJHJ5I1ubPM93LDEWY8lb85vma4bOVgqZsk4WNrP
 Q/kgStgoa806AcDIEXEIg==
X-UI-Out-Filterresults: junk:10;V03:K0:Xiol7dYWX+w=:XI4jLISyTahNS5yMly5nMQ+1
 uq4yVR63FaPF5NqKglEOg2fn8z0q79bwBKi82dsgnq2aOqMK14yNFS6l0zgUx7mdzj11fPIvt
 Jtprq5jRIiB7D+7tAv6+U9gtN4RdKxBYHpS4Z7HInetQBIAjH5txh/GpdbCTSyWbhOJUm2bMK
 yF6F5bPszD83CcyTlLCPCro/l1uvn034XzAatNnrvbBYzf8ez28+4ghZBNOAAPBzvv1rhtT8l
 nXb3BPbLLjrUi3/GoBlygB8kx2E+Ts3yYBaZaqg6IYNQ93vOxH+W1wLgkBrCw0UC7d+Pmpnpf
 XtNtgY8yyX88huDjQVd2Z2W9abTTSKSMgsAtqun/4h6c9FHzjFs1KfbZMe644G8yAoYikcNJj
 DHCkSDphRO6hanPTGoQAD0IwQYclswqFM5wDnsNmaIjXuYrUPvOCDgkOuwy7hYwN+GMC9Uh4j
 0k0d5R4YeAmZnUTZqOJuZwUfmXuQogVvPJtEzhAHUJ0aPy+NxcAdpCV1LjIDqay5/QiYUT4D7
 XuYTCYIEYwrn1sBR/07SXVEb5qeThrpxgBScVBJpasZkYn8NaWA+c9/pTpffYW8A7i6nVFBAQ
 cI48SG1y3tyrf3W0Og719hrMwGqFctR4SM1GzWc/J9OwW3Na/WYSclDSdhZxvUUTin2c0rDXZ
 j6z1p6dHg2ytgzJm4DH5rqCll/XDy7FIXBMeVPi2LtxU5YM+XTqQVSVtPkrdQN/kHQXDyIRr7
 eklGPEfetqQfGfFhEo1C/+8m2OpuIMj8HQe0CUYryhIKMU8eGAo89LTU0u4wo/9bwMRV3Dtvz
 OfBk8Un1AJn7bD96q+OBfQ0s+CDrDqOoeQy55FsYSLieT0YecjFWLYLlygMLuO1fKy830lUVA
 chzOx0hlyjkv0k7fNitXLgz95yR7nYG04WE9e+ylnUrQICd91+WPzPmKImaaJHHI5/BLHHQ20
 ejnq8NVzgJ7lkrrb6f3552qAajypoVnGy6qECrMR3X9PghlMQbHurGLcbFfex9mA/0lB8AAN7
 KF0CsEU9f9KwEAWiHZA7yBHEeFOW/NIGAZjjZpUTL9vOfxmEqzZWbLBLQZ84uSkIToIRbXidn
 uEUDSO4LfyEnDrvTl/DlBVaNWgUzrL2XbxXLxTCKDcd8Gw1l4xpJGwP190vpTN67Y6VtopzeD
 lHdwlf9l0Z2hbOyPSt+kgmKKF3N93QOrWBfPd7DF+dqeNg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 09:03, Geert Uytterhoeven wrote:
> Hi Artem,
>
> On Sat, Oct 1, 2022 at 1:21 PM Artem S. Tashkinov <aros@gmx.com> wrote:
>> On 10/1/22 10:57, Thorsten Leemhuis wrote:
>>> On 01.10.22 12:47, Artem S. Tashkinov wrote:
>>>> On 10/1/22 10:39, Greg KH wrote:
>>>>> On Sat, Oct 01, 2022 at 10:30:22AM +0000, Artem S. Tashkinov wrote:
>>>
>>>>>> I have a 20+ years experience in IT and some kernel issues are just
>>>>>> baffling in terms of trying to understand what to do about them.
>>>>>>
>>>>>> Here's an example: https://bugzilla.kernel.org/show_bug.cgi?id=3D21=
6274
>>>>>>
>>>>>> What should I do about that? Who's responsible for this? Who should=
 I
>>>>>> CC?
>>>>>
>>>>> Input subsystem.
>>>>
>>>> It's great you've replied immediately, what about hundreds or even
>>>> thousands of other bug reports where people have no clue who has to b=
e
>>>> CC'ed?
>>>
>>> Quoting from https://docs.kernel.org/admin-guide/reporting-issues.html=
:
>>>
>>> "[...] try your best guess which kernel part might be causing the issu=
e.
>>> Check the MAINTAINERS file [...] In case tricks like these don=E2=80=
=99t bring
>>> you any further, try to search the internet on how to narrow down the
>>> driver or subsystem in question. And if you are unsure which it is: ju=
st
>>> try your best guess, somebody will help you if you guessed poorly. [..=
.]"
>>>
>>> HTH, Ciao, Thorsten
>>
>> Absolute most people:
>>
>> * Will never read this document
>> * Will not be able to "search the internet on how to narrow down the
>> driver or subsystem in question"
>
> So how did these people arrive at "bugzilla" in the first place? ;-)

Google kernel bug -> bugzilla.kernel.org

>
> Or is this a case of "if all you have is a hammer...", so you
> actively start looking for a bugzilla?
> I.e. people who are used to bugzilla/discourse/slack/irc/trac/... will
> look for how to use bugzilla/discourse/slack/irc/trac/... to interact
> with the developer and/or maintainer.
>
> The definitive guide is the MAINTAINERS file.  If there is a (rare)
> corresponding "B" entry, you can use that.  Else fall back to the
> "M" and "L" entries.  "C" might be good for an initial query, but not
> for the actual reporting, as there's even less traceability than with
> mailing lists (the latter are archived by lore).

Just like I said before email sucks terribly for bug reporting except
for rare cases when the developer notices your email right away and
promptly submits a patch. This happens once in a blue moon unfortunately.

Best regards,
Artem
