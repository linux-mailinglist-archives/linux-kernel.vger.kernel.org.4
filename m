Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6995F06E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiI3IxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiI3IxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:53:19 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDE1166F3E;
        Fri, 30 Sep 2022 01:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664527981;
        bh=UKcFQEl9YGsBq1PFrGhUlEsNLLsh4x0iNQsYbO3vRh8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MjJWG7/UnIL7Gg/ohoEQKqreNi6BnepL36kKbAdAtv89CFGhWDaooVdoWTBHLFamH
         FoqEwf2Oa0wYyQbjYJrKP6vu8lDtV1bPKx4q0zFp/mf9WZCIrdl3/+ldVzfC7sdCeF
         1Fm4M3qOIs36vMytZ84Da4/OwoY3mvaNOMWtzOfQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.5.110.31] ([143.244.37.65]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNt0C-1otfHg4BYG-00OJRG; Fri, 30
 Sep 2022 10:53:01 +0200
Message-ID: <4dda937d-a295-faba-196f-56af3659fb08@gmx.com>
Date:   Fri, 30 Sep 2022 08:52:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <238f5350125e618c323f42e3885b5ff887241ae0.camel@HansenPartnership.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <238f5350125e618c323f42e3885b5ff887241ae0.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jYpz/bmNn8jnB1nUQJgBZSc3mh/yf1seHK/m19kNIESJMHwLUPK
 zgyzzYYSIy2DbbK2tToKAXq/l8HH3pIFh+/arLqNHT4GoUcYiDyQaKX+B6iZqAYrsLqdQ1+
 EDcxyZcg3xw2CsLzTF/tK78GJKuNLxYC+dnqdH2jH3uy3VQ09C3vHUbTbF5l+2M3zgGFkUd
 WcuAp34skeQF8TfRgOcPA==
X-UI-Out-Filterresults: junk:10;V03:K0:IYI/uC7CvXA=:LgE3CX+V7ZGzmk9n2A5vYFVa
 v6Dz4ERep1D78JhxLnBYlrYUKdYtByqT5blnJiGN4OACbpTbBA5haWLFaTjRTdlTCebJmTG2e
 p/gk4etXapHpjBe71/spq9qM589M8n8xYqeRYxPK80Ekm0snF4xN6D7ovAwsmYg5ub6NjAEnz
 N6RQCzqE1JqtykSqqrAeH1/no0WL1y2XviDWipazF1Z/Nn1ChRx0jDXtAunmPRot3Ae50evOx
 H7VqjhgTW5T2H1meZ9PSBqJUx9fA0SFPaRM+JPybtCC8ZWBVEAJP9YKwEklJOXKHho8fJXifZ
 PY2QYkzoB9MNf2AfDKWjy+dBKi9umF76ZPpBPvmA7YZf+uBSu++K45oEvtrPu/0GfXkSXKVWd
 FxNLt3zc5FHZDqRiD+4Q6+mcYjHNla15thUIj11+wUWxAouRYgpcn6ZQUJJ1/GAoBfGJolOkz
 AuAD9q8bpsbWD2w1hrjcMOZZKV3WaI2NO3hTMaiS+/95z+PXzu5VK3yIlfqQPO1Gg0QXutHp7
 NiIz4aXq1hFWkeBtfrivkXZw6Q9qZ57W7BWq6gXm8yZmZGP8Q+63JeQmmq6Ap+FnHpO/TRqLP
 8JtucRUr99Yn8XSPF1QPwD8LH2FFBST6EZG4gZr5i2w1KB4PD/rj97t2gLS1nmYMLWaPPN8cu
 bZoOtEmaNDsAt4WDbwfZ7dgpO5LtBezIPfoRvGnYT8CShD3C4H9Up0aQz4NqqntFytRuANtAL
 8eC4rcvpdGMSKM1d3qkZeY1fY+Hb7bgqjcNhEHaWpfXbkqfzfryLbTYLVWsc5VRx1QT3vyjTN
 z5Jhhm1DMcMEnYGQSnPfSmhe6h9s/31yMP8TVsMi1R1BteF60lOetsZNZl2MkIJDEsDEJxdY+
 i2j69VY0SyjlmbvyyDsfusmbsm710sYRQiVU+0C3epWM94WVLAcxQ1wafmwk9Xv7yNOX23ibk
 Pw/YWbbjOV4Hn6y2dRo7Z+RPQ0tVGlfdVbzJGlQheIoX/z3tAesOSJngNFpjneZBNoQFfh0S5
 gtHvH4Lhd6Wa5x1UvNWcISH7K3P5xxCAl44VAE6nC5D/J4I3X99aIAKEoebCTsJ/us0aUDM+5
 i1FucA19XqehCc2SE+kLmA3Sm7MVD7r+M38AzWoOKI64yzjXXGk15FlPc0zuyOC6vGEI4eY4J
 xj3caR8JeVBuswvfSjuy1VwQell+w4SOiGgzBfWjGf6BHg==
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/22 15:26, James Bottomley wrote:
> On Thu, 2022-09-29 at 12:22 +0000, Artem S. Tashkinov wrote:
>> Let me be brutally honest here, if you're working on the kernel,
>> specially for a large company such as e.g. Intel, you're _expected_
>> to address the issues which are related to the kernel component[s]
>> you're maintaining/developing otherwise it's not "development" it's
>> "I'm dumping my code because my employer pays me to do that". That
>> also means you're expected to address bug reports.
>>
>> It's correct I've tried to help people with bug reports posted on
>> bugzilla.kernel.org but it's a tough task considering that absolute
>> most kernel developers are not signed up, thus most bug reports are
>> never seen by respective developers.
>
> The never seen/never responded to metric is rather bogus.  The sad fact
> is that a lot of bug reports aren't actionable, meaning the reporter
> can't give a reproducer and also can't easily test patches  sometimes
> by luck the maintainers can work out what the issue is but a lot of the
> time they have no idea.  Then there are ton's of bug reports with
> responses like "I think xxx commit fixes your problem, can you test it"
> for which the conversation dies there.  There's also the thundering
> herd problem: some bugs get reported by many different people (as
> different bug reports) but usually the subsystem only engages with one
> to fix the issue.  In theory bugzilla can mark the latter as dups, but
> that requires someone to spend an enormous amount of time on evaluation
> and admin.

   Not only that, many bug reporters simply report something only not to
ever follow up - you ask them for additional information and it looks
like as if they don't receive emails from bugzilla or don't understand
English despite their report being in English.

>
> That's not to say we can't improve our process, it's just to set
> expectations that we're never going to approach anywhere near a perfect
> bug process.  Most of the improvements that worked so far involve
> having someone coach bug reporters through the process of either
> testing patches or reproducing the problem in a more generic
> environment ... which I think most people would agree can't really fall
> wholly on maintainers.


   Bug reporting is an intricate process which requires certain
experience and skills and it's far outside the scope of this
conversation. I still absolutely prefer Bugzilla or a similar bug
tracker to stay. There has to be a place where all the bug reports are
congregated together in an easy to search for form. Someone has proposed
alternatives but I know nothing about them. What I'm looking forward  to
from a new bug tracker:

* An ability to CC anyone and everyone
* Preferably an email interface since some developers just love replying
to emails instead of opening a website
* Categories representing major kernel components

To be honest it feels like refreshing Bugzilla is a lot more easier than
migrating to something new. If I'm given access to it, I could certainly
try to do that.

It's been mentioned that the product is "dead" and "unmaintained" but
that's not what I see on bugzilla.mozilla.org - it has become extremely
powerful. Maybe it's not even Bugzilla but something totally new which
looks like bugzilla.

Other major projects continue to use Bugzilla seemingly without big
problems:

* KDE ( https://bugs.kde.org/ )
* GCC ( https://gcc.gnu.org/bugzilla/ )
* Wine ( https://bugs.winehq.org/ )

It feels to me we just need a dedicated Bugzilla maintainer. That's it.
I could probably do it.

Best regards,
Artem
