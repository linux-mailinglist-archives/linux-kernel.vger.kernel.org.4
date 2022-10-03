Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3814C5F2BF2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiJCIgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiJCIgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:36:16 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA23275FC;
        Mon,  3 Oct 2022 01:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664784553;
        bh=gucUevQeUc5hHlWYZ1t++7IBfAQIeAFhv0oKVclAfIg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GVDIvyINq8J9hfGX4AkL5aMfzaKQQClit+aZtDdwFCp1eGlrRMfQeBAeV0YImcdcR
         xft++okYhmgF5CH2kir0A7J6Q7m2tqD1fpesl86RjFEgnWxVCHRvLxGjO7zdEJA4YX
         9ErBdCWbCpD2NT7Lieo0RpMQUilgS9GMV53wpIx0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.25.110.16] ([143.244.37.214]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCbB-1ok1Jv3NsP-00V9JH; Mon, 03
 Oct 2022 09:41:11 +0200
Message-ID: <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com>
Date:   Mon, 3 Oct 2022 07:41:08 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
References: <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu> <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
 <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home>
 <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com> <YzoY+dxLuCfOp0sL@ZenIV>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <YzoY+dxLuCfOp0sL@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DrgNFBxbBqk2s5Xnd5PRKt9UfYXricJ/EagAW0B9qrRTS4uYGrL
 Sy8BI4SytsvmGYtePFS3P0kMJWuczigBCyTfVCaTlYZ04ms1wp0oLvwbZqfM8jyKv7n2VRU
 8PX2fIBmOulVnDNumjjryF8/NyLnR4DUk6cqUz3kjUqlE+rINg42rKrYqDoq/YMNUl2X4wy
 ztXBa3EbIk6W+SHrE/l8w==
X-UI-Out-Filterresults: junk:10;V03:K0:gQ/lok7QW9I=:zgw0wtN3N6tgjjzk1HxqgM2s
 DO6sR6dORNdawEUkws5LvaI9mRxg5QZrDqjdL2l1jG4ts+6zVRLNxcxaqIOspqtyes7p9OyON
 J+zLVY4baooP55wIGTg98lE8JuCqrGbnbxSy3ttRuPv21r1gjuUM9wEKf27iWMaZnD/OINkfS
 6UcUxYuROd/W6Z0hdDAnBg8L4NiYi+FYf2rEeKjKD1Bb4hjIWXKvu33SRiQIfLLyQCO0xV1aY
 qbAFw6lu814OEJM9EBJ0nA6XtCnImpUDdiibH2mj+gUs0tOW5swl3r9Y+zpeYlKuEP1JgjaZt
 +j4fUfzwXC9d6QzITp3tIPD2VXmu2rpjxw0cQRQIF+9bLRxxB2msWnuIpFnqhsI22pPa4c2Uk
 k/h6DqHwLG1EG9OWyIylTOcNXe+u1aS+CSfR9P6gBJiWQTGt9H76Saf2hTs/mqBcX8NTrz5ui
 PF9VEFEUF8T/M56lorElfB351i1Yk78G2C5jAzFkYEgp/LYdh1njT8gFYlB2jazYvr1xUIPhr
 9E7Xc9919MwI32Eb0DVoGlnOLkqBHMadZfeIofbm8L5FNoIT0QiuqctwNxUe+0zITFI4Ht2DN
 LK0UyHVOEjDJdszcXscCLIoLj3G73jRr/lIi6jxpmmoi1aWAekMsg+m1ONd1olb8l8a76RFB9
 WzoYrrCbLX3yktnejMTSlWg6onhgKhZ6FgH3P+VyjUrwSD63WoSeNwm4wtHD7JAnQba3LHTNV
 Kfy07ghd5c5pMT0hhwgSwYWtdim2VIF+PYLfSgPY1ndrfLlqp68pfmj5V7yfpi2yJV/8uZu7Y
 ocGTzhDgBKJVGjCLZFS+5HDSYv8O9/NoFVDiBKVV1TeCMyNeztkHe0vRacusxrnYKtVV8JgBd
 ZEqmpcsqkFZ8hiK4+etEhkjuI5TQj2SSGyz/FE4e0MlwsxrwLr4if0JhCRiUAo9mFwJLQHwb1
 H0zrooe1Z2DYGlKKMTH2Ux7AfYC0FB+n4iXaP7PxXNYcHLj7sTFj1KavNPkUbe8n+5ysvm6Cl
 I2p/ow0lMttEBATcfPQMqOnVY+W+FBE4WMuqvxWofw04NRlcfEY2o5RE+nJO3vbcwQZzT0/lk
 UQG4bM/SYX2432+8HGSWJqghjBOG//xuC073E9Wi9PM3fdnkesMWccANlEXEuGyNea8kk73y7
 OMf1eTEIfz+tOFBS6ufAWg5UqGI3nW6et5y6GCswB8mXpw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 23:04, Al Viro wrote:
> On Sun, Oct 02, 2022 at 10:20:40PM +0000, Artem S. Tashkinov wrote:
>
>> Bugzilla hasn't been updated in a very long time so it's missing both
>> mailing lists and individual kernel developers.
>>
>> AFAIK, some pieces of kernel have no appropriate mailing lists at all.
>> What about that? I've no clue.
>
> There's that file, right in the root of the source tree.  Called "MAINTA=
INERS",
> in all-caps...  Could have something to do with locating maintainers, co=
uld it not?
>
>> Opt-in will work, except I've no idea how to make it work. Mass email
>> all the kernel developers and politely invite them to sign up? Most wil=
l
>> simply ignore it.
>
> Sigh...   You really don't seem to appreciate just how deep a septic
> tank you've jumped into with your combination of "it should be opt-out"
> and "but unsubscribing takes just a minute, what are you unhappy about?!=
?"
>
> Maybe you are not using email a lot, but for just about everyone who doe=
s...
> We have heard that.  Many, many times.  From many sources - spammers,
> "legitimate" companies' marketing departments, etc.
>
> And you keep moving along the same track - the usual reaction of some
> company after having pulled back a bloody stump and enjoyed the pile of
> explanations of the reasons why opt-out is *NOT* *ACCEPTABLE*, *EVER*
> is along the lines of "OK, we'll just spam everyone in our database once
> and ask them to opt-in - that must be OK, right?"

Being on bugzilla does _not_ mean you'll receive a single email unless
someone _specifically_ CC's you.

(Except for relevant mailing lists and already specified maintainers who
are confirmed to manage certain kernel subsystems).

We've had over40 messages in this conversation and not a single person
has complained about SPAM ever coming from bugzilla.

With what I proposed that would _not_ change.

Weird to read this torrent of hatred and aggression towards purely
imaginary SPAM.

Anyways, Bugzilla is bad but it surely works. Let's have 100+ more
interchanges inventing something most users (for whom Bugzilla exists -
which people here keep forgetting all the time) will a have hard time
working with.

I repeat: Bugzilla exists for end users primarily.

Regards,
Artem
