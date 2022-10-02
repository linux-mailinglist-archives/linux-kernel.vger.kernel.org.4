Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7205F2528
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 21:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJBTnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 15:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJBTnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 15:43:47 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE49A356FF;
        Sun,  2 Oct 2022 12:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664739801;
        bh=1N/BY4GbK9OGomBQOkwPGGGCw2WbYCDrurO2rs4vxCk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gdApzSkDmhPc+4L3XvcmbzStNcFPoNitfNgvskXgISDeMWYZEbdmOEZ0CJwlT/EBu
         I6KxqtUET20Tkjm4AioLskehs0nZBNwja3R5UBwSa/syKvcP4GpAi4V+5jgBcp+rKC
         nTVAlcloL5zhAWlOC/H1ZbHbDT2oodciK9tkx3WI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.13.110.23] ([143.244.37.73]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhD6W-1pAJ591jak-00eN7p; Sun, 02
 Oct 2022 21:43:21 +0200
Message-ID: <b594681b-6b8c-ffb7-f526-3da847d160a8@gmx.com>
Date:   Sun, 2 Oct 2022 19:43:19 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
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
 <20221002150522.ul4nbtfawqjhnsag@meerkat.local>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20221002150522.ul4nbtfawqjhnsag@meerkat.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dhmH3/3j4OAaSxDMTKZ+mRy+8ACrHoYuWy9hk08q/qqA6iPwAVz
 8NwALnLWVmwgGDqkp4hS+X+tc8r51uwA37qH+vLViczeC2uG0ZMSM19ZZlf7gIAMsey1Hja
 6SDs6YLVjtaWf4qKj8f+GwetSMiFohfOrwhdR5UijAYtUl+Zkoqx64Z5htcPFI+BVSCUyWU
 WJkUx7nFhHtjusIRa3XpA==
X-UI-Out-Filterresults: junk:10;V03:K0:TmLiSiIvHl8=:s41ShGwvziyL6bVXlJIuYE8z
 cHBo7EFNN7GhJD524r0UFw/G+ZyrAkEs/eGbTiVSpmfqrxR31tLlJ1Swh+/vhe6i/Iym8P92f
 w5FzNhSLvB9Ofk/Se2hpRZPIyS4FBYQETUu2tEVuLKmCzppqt1WI26XB+8EDQoivc5ei2Dnmc
 TPm7OeqdW123cxMR2p2J4ZSEuikQiHxHFFKCE5EKU5Ins+rXW3BL8opLRzHpFsNPInNHfmOWF
 BnHJwnqwwFjzX0/zCrVzPtw5FTBcEWkEn3/A+7DU2ODQCw3Hkme++tBmAA6GH289VYq0xLx3G
 44sXeZQgoVDpYVR+eYmDmCh3zV/akycxsIRgXrj2qgXMqb6uGhbW6Waals1mai1lgZ4wwpT5F
 N6Lpfg3c8aVxVqnGdnirKXNKsw0FSpQgpx5C4C4qmue99rN1cdaypVEkRDWh0gL5+ZG+DNExp
 y86TvRfJiXVWCJkhhVcXYyrd/K4sBqSQXZL8ZGIMGYZ9JrxhzisTqCCjng3OLk9J7TZFe4LiU
 q3Pd/l2zaw+bumsfwZnuf+R69wZ5REtHUvxkBaBR35RP32x+3SzzUt9i2GZF1OEfGQ4RJ89Uj
 yiwE8X5xHnjM/BCijw3T6Y59IcM0a56UOXhenSKAHcvawiYzic353Vh6hQ9T+hWl17o5A3YSc
 +Ef/qRfwSMsQCq2/23wnEO7ZoY9mwKXBwEs/v1KdztvRc/oaL6NZVbfVnRwI+VXlbRNGhU8Uc
 Xl2S9RVLcBT5q2LQCYpEtwXzM4sfse2+nTtXjYGyQ1OjGLZNgyZoIR9rTTP7uWJjh9jeZocTS
 WWDgrrBbmyIUJaub30CRybmLyKLqDpp3frTVMuhfLzv96vMwi31YIus8VrVvyl5SILhMe/lxD
 YRubvrV/nVqVvl3Voor1LLbcKG4dhk5/Qd1siaWX11dtj9ThdfvdPr7G0+1D2SYuTSVaFvEDJ
 2u7Vd29twrIBNNoINpixr850n6tjq5dJQwjafMnj4QFsnM+2U7YI1CF9RHu6G1QpNUsCjk4uJ
 kmedAvSq4CceVic79XxZbjvVhAd3ss4VL9w8kfd1gLi2ort1i87wGF8J+GZIRzNRApiyrb2RM
 svuJFTak+gDwuEY2xFw0EIGy1Gl1TKT5CAQvHoKpGb82Tg6q0+RuVInnSzXyJ+m6YEonkprhm
 iFwMIRhHN7sV5z6Og8/2W4hgx1CRvgo5+8Ar35WFRya5MQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 15:05, Konstantin Ryabitsev wrote:
> On Sun, Oct 02, 2022 at 12:49:04PM +0000, Artem S. Tashkinov wrote:
>> I've mentioned it a dozen times already - you're unhappy with emails
>> from bugzilla? Go there and unsubscribe. It takes a minute and we're
>> talking as if it's the actual issue we are dealing with. It's not.
>> Bugzilla maintenance and its up-to-date status are the issues.
>
> I think you're working from the wrong conception that maintainers want t=
o
> receive (or even be aware) of bug reports. Maintainers want *PATCHES*, n=
ot bug
> reports. You're asking senior engineers to do first-line QA.
>
> This is why your suggestion to auto-subscribe maintainers to bug reports=
 is
> the absolutely wrong way to go about it. The maintainers will complain t=
hat
> they're being inundated with spam and junk reports, and bug reporters wi=
ll
> complain that they are being treated rudely (because this is how a senio=
r
> engineer trying to get succinct information comes across). You know that=
 meme
> from Fallout with the words "[Everyone hated that]" on it?

There's no need to exaggerate or say words like "inundated", please
refer to my previous emails about bugzilla stats.

Again, to remind everyone, bugzilla sees around ~20 bug reports
_weekly_. There are hundreds of active of kernel developers. That means
for a single bug report maybe a couple of people will receive maybe a
few emails per week.

Is this really an _issue_?

Why are people are now blowing stuff out of proportion for no reason?
This conversation alone has already seen close to three dozen emails and
no one is complaining.

>
>>> And if we force developers to get Bugzilla spam whether they want it
>>> not, and they said, "absolutely not", is it there right to have the
>>> mailing list gateway disabled --- and if so, what does that do to the
>>> user experience?  Thats basically the situation we have right now.
>>
>> As I've said many times already: bugzilla must be an opt-out, not opt-i=
n
>> experience/option.
>
> Please listen to the actual maintainers telling you that this won't work=
 and
> will just lead to bugzilla being added to everyone's block list (that's =
even
> faster than logging in to bugzilla, finding where to change the default
> assignee, etc).

It feels to me there are no actual maintainers here. Just random people
who oppose to a imaginary torrent of emails they've never actually seen.

At the same time everyone here is OK getting a hundred emails from LKML
_daily_.

Regards,
Artem
