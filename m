Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016455F251F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 21:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJBT1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 15:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJBT1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 15:27:38 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E3520BF1;
        Sun,  2 Oct 2022 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664738840;
        bh=PnsdAQG+3LedJrzKk88SUnzHmapW6fQ3bk8bEzbFTrM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=K+CB9yDanv+y7MTlFwXL5bso5hLkLj0guKNx6On2sf2HUg2G3WrbwbhRtyeWNwP/X
         MBRe3I6dBnRmQm3lr48Y4y8a/T15co+A16bCQ2HcO75rSgkWZYgUpKdE+BCLmDy0Ol
         Nl1HrcYGuBYSVfuiks29n+nrUPfLrTSXGx8GmF04=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.13.110.23] ([143.244.37.73]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCsPy-1oWEvo1blo-008uMY; Sun, 02
 Oct 2022 21:27:20 +0200
Message-ID: <ce0b5780-a8cd-83fc-5b91-3acc574f426e@gmx.com>
Date:   Sun, 2 Oct 2022 19:27:18 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Greg KH <gregkh@linuxfoundation.org>
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
 <YzmhoglDyEf3z0n8@kroah.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <YzmhoglDyEf3z0n8@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yBlTZMAd1MjRkbigKywKPwJlNZ9mje08h0qh7y/Ne3FFEr+mRSs
 BNjExFhe9S2nSyWHe8zjaqyhHTLkl4hT3lfQ9zqqU0EHWJNe3bkRTzoj4Np9mLlBngKU1E0
 un1hTY+GkcY/8W1Wso8AE6RGH6Ye4rGLbE2Q/D85aWv+yF46yxlob7jN0zvZ/smVUYrMrbm
 cVUGeGtwDa2aeA2DGR8dg==
X-UI-Out-Filterresults: junk:10;V03:K0:OAomWW9bDOk=:hUixD3v5XmY1xVXvel+7CiHB
 /faQHbBA/xX6i0vNZf6sCBwioQcKgzMK8VgrndLtzWxSL2/6sTurLAefLKrDe0X8SBaKtxN4Y
 wuCppE9e8vc8v/0ERiy/Xh/eDefOAYP+7TbX2EkwwKplXK80Y1ySj8zO2Ry++BIV0dheZ6Pz2
 6VrRdWKzAURJkViZ/0tBod3LpX3esr8+oDBmNqDSs11QtisxBRKwEH9bo7veARDMKok61aebj
 q+dvR+7ZVrmHSFqTWHSjYQDU1pQKFPDTF8IZtcoY1UxKkd2ylJEX9ORmx2OOXPE9sGMluo+/q
 dDLme8BcfNnlFgp5I1U/wbUoZs/E6055xhKRSKERfPq3WIBva8blYQcSifmA4+aH4XuEu8lii
 tf38JHoD0A6TOdQ68AoXyIG/W1LBYZRcOC1uDhahCb9wA8Eadme9vdBmPUE5gDeXcKeIIlnIj
 uE/6kzEwWBDg1y+2IYBjAKLLNRiczMm/5aC/8ZESMYV/CkzmXRBN0xH054ROILe5UaXQh5Wvo
 W0fTkDijDP8Ibbiq4rX0kI5si9tPYnziyDhbwaIdCWlW/jZBZCLGLoPaUvV3oQYOmb9iJarrQ
 hPDq+uViDN/OT/yWKy4ZuBw0VI+VRRrDtKSj3N5oYg4mE5lttlz1s1APKEuZxrVt0c9LrdCNe
 IigiDeC5Vd8sVxeaaZwL2fCcC3c3QrtXfSoOpWBJtoE12ajTzz1gXUPEo2dNWNxBfNhtYfJ7U
 clmKiy1EC17Hx2j9y+IDVxII/jcMOwAHZhgSIC/PAJ1+pUWpaDsPjQIaDfkvrnvDTnGg4gmiT
 JYydK8Kffg2lf0t3ncmo1xrfwzb1+VQZGVOBUbUbvv4204nOkyt8zNhLyR4S3/FZBboWnMNI2
 jKcpoMYAj1hkjOFe7SuRMC9dotbVViJOhbyGHnpSH8cbgktEAPVKtwanjRuX56hJct6UgJNpJ
 76ATOcUoRt9JAkU2AuuC36reKJ+R0MCQ5IY2U6sTD/bxCs25ypUT7/2PJkfWRz42whuWAe6B4
 lJ1YtAvNq194pXOIFvZ7IlCzvVLYkdrfSCBUY/Vi852fEz/n1FisLArx1Rlh3QF5iD8rUKi/a
 cfz2toyFvc5mqNj2UFgKrRfPBQ4YTcH5W8xNL0mbzCn8cDB7EEKL4nlZ7iyU1foxneZdSbFJH
 0Md6uxKZ1lRe+5lixn3IruIe/3O7TU26KIQg3e/1M3VQCQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 14:35, Greg KH wrote:
> On Sun, Oct 02, 2022 at 12:49:04PM +0000, Artem S. Tashkinov wrote:
>>> And if we force developers to get Bugzilla spam whether they want it
>>> not, and they said, "absolutely not", is it there right to have the
>>> mailing list gateway disabled --- and if so, what does that do to the
>>> user experience?  Thats basically the situation we have right now.
>>
>> As I've said many times already: bugzilla must be an opt-out, not opt-i=
n
>> experience/option.
>>
>> Let's subscribe the past six months of developers using git commits and
>> if someone doesn't like getting emails they go to the website and
>> unsubscribe _once_ which takes a minute. This is a non-issue I've no
>> clue why we're dwelling on it.
>
> auto-subscribing people to anything is a sure way to get lots of people
> instantly mad at you and have them add the address to their filters.
>
> That's just not how to do things well, sorry.
>
> If you wish to be the one triaging all bugzilla bugs, wonderful, please
> start doing so.  But to volunteer others and insist that they do it is a
> non-starter for obvious reasons.

It's so weird to read this I'm just dumbfounded.

People won't even receive emails if they are simply on bugzilla. It's
only if they get CC'ed to certain bug reports they'll receive them.

And they can unsubcribe literally after getting a single email. Can
anyone even get mad because of this? To me it feels like someone
sees/creates a drama where there's none.

If you're doing kernel development it's obvious that your email address
has been revealed and people are expected to deal with it.

I receive emails about Linux from random people I don't know and it's
never freaked me out. We are talking about service emails (not spam, not
automatic subscription) about their _work_.

Regards,
Artem
