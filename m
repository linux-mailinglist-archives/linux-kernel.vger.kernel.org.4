Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61425F1D06
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJAO6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJAO6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:58:21 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEFD9AF96;
        Sat,  1 Oct 2022 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664636287;
        bh=NvgCwQjTUGpaDRHF+TbZEl0vERpFRUrG7TUCO6mpSls=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cejGEoXA2j834UrlarVRFIZmrjxRUJJPLMI8g3WhI8ITqzoIA11XZbM7I60cS+hsd
         5Z+QHdoDnjebQQDVwVMMc4+S4bB0FsVpfyMAZooC9Y5xPz1Fc8ENlknm5sXv2cKfMb
         6CPtCoSoahEVvV9I68bNfseYdZCg9m8qm6YeWKKc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.30.110.10] ([143.244.37.31]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQ5rU-1orkwI2rAW-00M6lj; Sat, 01
 Oct 2022 16:58:06 +0200
Message-ID: <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
Date:   Sat, 1 Oct 2022 14:58:04 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <Yzg7pHspc72I7TAb@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ub+LRiOF6H3rAj+auoLNuKkkYjgV7oeZDzvEDGWdJSndBBYtFeg
 gdNrV1KxRsJ2WWNtXRquEKRrReXjAa3N3ncT0CULMdKCjQKx7/hjje5byEEKUdjh8TSjBJA
 1PJ6367ovXwJdQGfg1ZwB6BBb0nRTXRdikJnMZqozHgkgAahxtzuior0+LBYl2mb9ScML+i
 kv4T9taLHxDWxd5Lb4FSQ==
X-UI-Out-Filterresults: junk:10;V03:K0:V2n2slJShMc=:WgFWTJMRNKn3SrO8hy19PVlM
 AfBFRFIlUmXGEKK+rd7JMWLWoGjFmjDi55JVHoDygF9ECOcl2Io8IXI4g2s6vJtBKVVPOu3qH
 d17ii0JPlHRTrJXnS5248z05qEPoCAmV/ToSxd8yaQbVHDp+AWP+mLHMEPaAtl935Nmz45SX+
 2rWouF5Pra8NbLxyVgWp1j7PRqy9MZkPB/lBcN69S1Vz1hB1j2SLdh3UrGwGLJrJruRirAsWS
 0nJ1KzL+WIOSjQxna7j9+LsCX5t4h3+znnXAShknUcg8r3P3fjYb5RP0hbolBhsmbN+eH+P6m
 coy6ynhB+piu/icsk4OcEOg9Qtp4n97vYbax+1nP7KN0ayDYVZe1C+InZZcP+Cw5DIt9SRp9o
 BDpUzQvC2hwO0XzGGz3A+L+VZDitL0il7dcM4KwHfbCb9GY/9LfTyWQctm0ZMtLvtKaZDhELd
 qCsB4MS/IkjMMT80l0SzwQQQwcP2bsxVW0FVRyEn/bOPiU5R5BibWHbMOvEalhjmQktxlLRLk
 c6UlvR1J1RG60MlNMf6DhdTOEBZFSb3SBhO0YfP1YhxTy/wK9Rn4s0DUGL/46yDjbTKBtNuaM
 7UgfAGTJhu4VmHsBR80OR4ssiiodqhbhZ/sQjGcGiE1Kq+hgKknp+tF/QDYaYLs1RWG2JyD8r
 sgQwudrSHT+5041atkIfcWIMN+ylDxxqLzfaxHuarSR4A7vQbUJCUIsDiAS0ZUtKjN1dNjMDQ
 HgLyrFAYxmJB0UT54Mi9viOd8J/C3V24KAcUcBZFhhZToDgYJgrO7XhOgzIwgw8Js9LmvlnPi
 vYrYRBPW/UVJUw5NfOdN7ulAQjGOrUQ6QAqogdgI5s6Ha+KF+CIInY3opipESUy8s47yL1ViQ
 PWBCt41yON2a/BuOmMniIg1FTGRvI2Nmx62jrXkGDg/yvO/p0xrKGUUZzkjwem9mcMoMtuxzj
 a9wvzmOGv4biDnmavX0U3Yb8CJSgwLqalvf2RtjYJSBbZLfCQc7tgSY1doN+gaV+CNVYkQyc8
 Jmjoimrbtd2RutT+rMHkgyTJCzfmiaHX76DX1AJCwhuVpCwiWgmONaoanqVPc06WFxiisXDNe
 VsqSSDTRgOp9K7Q9qgcTQLMgBuS1K84je7LIKdcb2cm2msGFs4GQ/saraJwSn4KpMDER9E+Pe
 H01b1QnBT2zGPnMvGNXeU6j+cutEpX5iBEX3eBYnaEryVQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/22 13:07, Theodore Ts'o wrote:
> On Sat, Oct 01, 2022 at 01:34:26PM +0200, Thorsten Leemhuis wrote:
>>
>> Is that perfect and will in work in 100% of the cases? No, definitely
>> not. Would it be good to have a a kind of first level support group tha=
t
>> can help in this case? Sure. But we don't have one right now. I sooner
>> or later hope to work towards forming such a group, but there are other
>> things that are higher on my todo list for now.
>
> I think the other thing which we really need to say is that if you
> really want better support, there are plenty of places who will
> happily accept your money and provide you that support.
>
> Artem, it seems to me that you are hoping that volunteers will provide
> a commercial level of support --- and that's just never going to
> happen.
>
> The users vastly outnumber us developers by orders of magnitude, and
> if someone needs a huge amount of hand-holding, maybe they should be
> paying for a support contract with Red Hat, or Suse or Canonical, or
> CIQ.
>
> Can we do better?  Sure!  But I think we need to clearly set
> expectations for what upstream developers will and will not provide
> support for.  (Example: bug reports for LTS kernels are not
> interesting to me, unless you can also reproduce them in the latest
> upstream kernel --- and if you can't build your own kernel from
> scratch --- boo, hoo, maybe you need to pay someone to help you out.)
>
> I also think that we need to clearly express that any kind of support
> is best efforts only, and if someone has anything business-, mission-,
> or life-critical, they should darned well pay $$$ for a proper support
> contract.

My expectations are actually quite low:

* A central place to collect bugs (yeah, bugzilla)
* Proper up to date components (they don't change too often, so there's
not a lot of work to be done - you can refresh them probably every 12-24
months and it's gonna be totally OK)
* An ability to CC the relevant people/mailing lists (this is the only
serious missing feature)

That's it. It's a billion times better than random emails sent to random
mailing lists. Signing up once is easier that to keep track of whom and
where you've emailed or not. And of course it's a ton lot easier to find
the existing bug reports.

Bugzilla as it is works nearly perfectly. We have a number of developers
who don't want to touch it or get emails from it - it's their right.
However it would be madness to take it from users. That will make filing
and following up on bug reports an absolutely poor experience for
absolute most users.

Here's a recent fresh example:

https://bugzilla.kernel.org/show_bug.cgi?id=3D204807

255 comments along with patches, ideas, contributions, etc. etc. over
the span of _two years_. Email will not work for such collabs, period.
No email client can even show you more than a dozen emails in such a way
you can easily follow the topic. Email is good maybe for slow-paced
interchanges of a small circle of people working on a particular
well-known issue. Even the issue we've been discussing here has become
nearly impossible to reach consensus on or remember who said who.

Best regards,
Artem
