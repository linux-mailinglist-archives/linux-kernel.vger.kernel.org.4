Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A0E5EF767
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiI2OW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiI2OW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:22:27 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919BC7A536;
        Thu, 29 Sep 2022 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664461332;
        bh=2fThASwlJVTGKS8fJvwWcsEXNvkGqFnHYBOOtapWk3I=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JokmMOdpxN1gdLxHog2uUsCrX8W6cV/GV0lph15MwVqc46xa2FRZlwq4WoWPoNPPR
         zxIFDhgXNLMrlvk3zLdKpigfKQH7MQo/WaMpQhdVFd8q8Gv0lPdgdZaJl0mKDskGVb
         L4oFyAR80R9H2L6PAdwwvw8r+s+xqnvZFS461PXU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.7.110.20] ([143.244.37.136]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzfl-1okHIz0xy5-00XLJ5; Thu, 29
 Sep 2022 16:22:12 +0200
Message-ID: <95c3384b-53d0-fd6c-6ec5-a7e03fdeddfc@gmx.com>
Date:   Thu, 29 Sep 2022 14:22:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
 <7b427b41-9446-063d-3161-e43eb2e353f9@gmx.com>
 <20220929135325.4riz4ijva2vc7q5p@meerkat.local>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20220929135325.4riz4ijva2vc7q5p@meerkat.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hq6E+l7ZjZf7AgVXm4YFu2GewKGauDtFDeuZWNJqMUHf58iz2/X
 i5erProm1PF5iyzsm5F61zF+TmLGUkApj1pOLjEQUK7qULwIr6Top4qHxELTZ1+Qu7Wdh1d
 og27QLUM+uR4+s+vaM2xEh4APxhmsFEpX/9ADDhq/F+XZWtJ22M1R1+s4co319s0vTulP2M
 /nTOV2+P0Tt8+7hYtBrNQ==
X-UI-Out-Filterresults: junk:10;V03:K0:floRUNFVnnQ=:kDidARWMp5cNdV7scF94BOAo
 eXtOY7uxTtc9Ive55aWRV18GG+ZDpVQ5CD9Q5FUBErdTX7CePB8M4zfTAOuo/kk3k6SpdAm+E
 W/AXPcBfwhQAOfa25sluRL6swkyHvwDxRjDo50FWzU8wKyaL224OSHrSOSssuY1BEO5TZNrIx
 1eI4EXENz7MbNYSdo1/zO4YrEFB8/9hpbToseLvBWKvclNVHkA6dlLNcoDaxZWKkQA0XJxVB5
 Our9ToUYduZorNK/py0IftHpOVEwGjXQx1o2jiQLqAohQ5xMQeAsBZjhwAanZPPrOpqP3KVBA
 ueZy+EUxTaQuZ1R1Pmx1SFTL1eQCOJNF+mNTUS6umJrqgqwxaFQHaDHPlmXLMO+pdd8W78u2w
 I4UggSjylQmpiBjIbZwveMK0fibh2gvprU5ouLNqTS6ODffMkZ6D9IBAT8gSm+6QtcO3JoJUR
 EGxf3k1W5U/SjW4jyqwo9bHouOVxcLT1zUqqwNK1MA+sasg6g5mDYIx3YegfVizLKaOMeFiiI
 XBeQhgQK/IEu4umtbshg9dohREBp+IDVIapipbbKzxNisYckoJAdR+0xZXhoS7eZgP358D1kb
 PbkpkYlbHMh4k8r0nl5SHW/k8PU9ebOtno1OVrMHt1R1NnK04g6meCNyqa9fmkeAfKwzs48dt
 PEfC8TiA1xrx21Cio2tuSZCx3CoG6Hiai2aKPkdjTLw6uNp4I3sv3tSed+N71jQ21FFAuVvDg
 BIUw/+wK8Um3IQQu5hVMBwvl+wRKafPMFpl/IpHpqO8BXcMyory6GZoT3nRYqQ+LJpOUgOgeK
 2VjqWeV+N76RH/ilBp0h1CMFMyKUs3Mlw9ihKExDk4EvYDkfsmajKQyhYOGNsW7Xz1FMsXzEX
 fhlJEcHQcdfKL+CuOQGDkJK03JxEsCD7MtxWn3BEJuDEKCEP1ymf7GGcQzTzAZBTj4UB7mePL
 BzcsyFvpzcPsauRHUV6pZX+7Son37rZt5y0twbM4uLYC4Tke8gJqsiREhM/GQof+/9Q7hObKP
 Lj3mz4IEYbx49yk/VLQLldrQ7op19YJaRf06fxYF+gV60otoaw+mCdHigAygi4IekS26YdZs3
 ZvhNwRGsBC28gVZ9ovEzBuyT7eskpFnkSy4Cl5e1JPaX7JGjsJzVdMrgh2NVINf8M9AttK0ew
 gigtcjB/IBOAtdORLutE9Qjyf/t22IoV/KDf2UqdY6bdMw==
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/22 13:53, Konstantin Ryabitsev wrote:
> On Thu, Sep 29, 2022 at 01:31:49PM +0000, Artem S. Tashkinov wrote:
>> To me it sounds like the best way to keep moving forward is simply
>> convert git.kernel.org + patchwork.kernel.org + bugzilla to
>> gitlab.kernel.org and that will solve all the issues immediately.
>
> No, you will still have all the exact same problems as long as nobody is=
 in
> charge of handling incoming bugs. There are plenty of active github/gitl=
ab
> projects with thousands of open issues that nobody is working on for the=
 exact
> same reason nobody is working on bugs filed via bugzilla -- the right pe=
ople
> didn't see it (or are actively ignoring it, because they are working on
> something else).
>
>> That will require of course a ton of work but:
>>
>> 1) All the commiters will be automatically present and you can easily C=
C
>>     them
>
> Just like with bugzilla.
>
>> 2) All the kernel directories could be split into components with the
>>     respective developers being subscribed to them automatically. There=
's an
>>     issue though: sometimes directories/components are rearranged. Gitl=
ab
>>     however is quite powerful, so issues can be easily moved between
>>     components.
>
> Just like bugzilla.
>
>> 3) It's gonna be a ton easier to keep track of commits and discuss/revi=
ew
>>     them. AFAIK it's now done using LKML + patchwork.kernel.org and the=
n
>>     commits are merged by maintainers. So many places to keep track of.
>
> Now there will be a single place someone can knock out to stop all kerne=
l
> development and coordination, subject to countrywide IP blocks, politica=
l
> influence, etc.
>
> Besides, maintainers already have a single place to keep track of things=
 --
> their inbox. If they didn't see something in their inbox, how is it goin=
g to
> be different when it's a web interface?
>
>> 4) Gitlab probably can be integrated with other gitlabs (at least AMD, =
Intel
>>     and Nouveau drivers are developed on gitlab.freedesktop.org).
>>
>> Gitlab simplifies all of that tremendously. Github will work as well bu=
t I
>> know many people don't like it.
>
> Gitlab is also a commercial open-core project. It is permanently in dang=
er of
> being swallowed by some $ENTITY_NOBODY_LIKES, who will for sure look to
> prioritize what kinds of things go in to the "open core" part and what k=
inds
> of things are only available with subscription, in order to improve prof=
it
> margins.
>
> -K

Not going to argue about that.

That leaves us with Bugzilla that no one wants to touch and some people
actively want to delete altogether. In other words, no central place to
report bugs or keep track of them.

I've mentioned several times already that mailing lists are _even worse_
in terms of reporting issues. Developers get emails and simply ignore
them (for a multitude of reasons).

And finding and engaging with existing issues becomes near impossible.
With Bugzilla you can easily leave a comment, attach a patch, attach
debug files, etc. For many mailing lists following up on an old message
is not possible unless you know the old message ID (the nature of mail
clients). With bugzilla you can see a list of reported/open bugs. With
bugzilla you can easily engage with other bug reporters.

To me it all sounds like kernel developers simply do not want any
responsibility or any extra emails whatsoever and instead would love
everyone to spam LKML: when you feel like it, you can check your inbox,
maybe leave a message, maybe not. Who cares? It's LKML.

Getting back to my first message in this discussion,

* Let's refresh all the components in Bugzilla
* Components may not have any people responsible for them at all. Bug
reporters will have to CC the people they are interested in.
* Let's subscribe the past six months of developers (using git commit logs=
)
* Whoever wants to unsubscribe is free to do so.

Alternatively:

* Delete all the components.
* Leave a catch-all one.
* Let bug reports rot because no one will ever see them. Almost just
like now. Don't remind me of mailing lists.

If not for bugzilla, let's use something more modern. I don't know any
comparable projects however. Trac is truly horrible. You cannot even
unsubscribe from bug reports. Maybe I've missed something. Discourse?
Not a bug tracker per se but can certainly work this way.

To me it all sounds like the sentiment is to absolve from any and all
responsibility and shut your ears and eyes to any reports of your code
malfunctioning/breaking. Fine, let's do it.

Sarcasm and pain aside, Linus Torvalds himself _via Bugzilla_ has helped
me resolve critical issues on several occasions while my messages to
LKML were simply _ignored_. Think about that.

Mailing lists will not work for such a huge project. Period. In the
early 90s they worked, but we are 25 years later with millions more
users. With a ton more of a ton more complicated hardware.

Maybe let's try Discourse with just a few "forums":

* arch
* drivers
* fs
* block/init/ipc/kernel/mm/crypto/virt/scripts - a single core component
* net
* security
* sound
* tools

That's it. Just 8 forums, zero maintenance, no need to add/remove/manage
anything.

Best regards,
Artem
