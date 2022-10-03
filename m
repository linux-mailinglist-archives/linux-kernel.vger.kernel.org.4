Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58F85F2E5E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiJCJps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJCJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:45:25 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09830402FD;
        Mon,  3 Oct 2022 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664790047;
        bh=EUJB6wfy+c3lmgBfbDPSdjQQPEEfd/Wc3Hc6k/SbItY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gTReBW0CrahOsdE7aoLD5kJgC2/CMOPA66/TiLrPPhJjfRhnKt6k80vd+fP45TPOy
         DAdavxlFRFvrCLzKLMvepfZwrc+aUDEFFt42AwjaGulnZHU4aDjtxGGxFN6xq2dfYg
         CMV7QYMm38WEXs6KxWqkO4zoS+QzwHHCQDHVrfw8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.25.110.16] ([143.244.37.214]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8ofO-1pJLPE2bh8-015qpn; Mon, 03
 Oct 2022 11:40:46 +0200
Message-ID: <1d3fdc6a-a98a-fe3b-2e3e-acc2ffa24f9d@gmx.com>
Date:   Mon, 3 Oct 2022 09:40:43 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
References: <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com> <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
 <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home>
 <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com> <YzoY+dxLuCfOp0sL@ZenIV>
 <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com> <YzqjfU66alRlGk5y@kernel.org>
 <251201be-9552-3a51-749c-3daf4d181250@gmx.com>
 <CAMuHMdX8Ko_LiqsWafzcqheW_7SZmtzEvgrpBbyoCLxyWqjqBg@mail.gmail.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <CAMuHMdX8Ko_LiqsWafzcqheW_7SZmtzEvgrpBbyoCLxyWqjqBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hhEu9piEIkivO3JYpjS4M1eC21F6vmB8UqEA8VGqfUg0C8DeYlc
 QWrb+ObAZIocgkIh7Jbwxpq9MZ3fCE/KjLaeH2agg6+3QvS9uNQGc/N6uVkoXEXoGn3F5kN
 EXJW7wfzx9as+7cOYSLw/izXFjXpIEfB0cOcFF7e4PpG4UkbJ6O3ccQ86ymg5xLgk/eJ67/
 EbxeoG2rod47rSU20BQaA==
X-UI-Out-Filterresults: junk:10;V03:K0:NpW1KbfyJ7A=:KX7pKYpEkG3mc+P95QywrIOB
 XeJ3275pdF1QKns7LNbjj8DgXRusRSPxziWtP2qZfHLCr6g6lYPfqymyPEdMdNaIhqOI2qE/V
 HJNQY1ia9Wrk5AvzsByE1SGKubW9ytfbuw6mlcsG75phG86mbgCEFhHwO6LK49pIRUhstQX9z
 YyM5Xfc1Sukk89Z59LNGmQxMYL4QvFen8fccYV8ElrQNH9Aaa3/NuXjseqiTckUSYVqh9ZKLn
 un+sB72ww4BWXTluKuQXYUqCJLdPtX48izzxE6hMMCktRTVBP4wlvAe95KqA9CSBZIvJSa70y
 Cxxktz5/nQr812OR8Rc+BqF43gVxunCdaOM3sP5kkNuQ2fRbSHR37o5hBNwZyPLEuJT+sOAUq
 ecVBwtR2p0JAvsf4I6ds79XPSx76YYMQRrn2d1WmdD0PZfshpHHkDXSobMddoN5pR0D5kSuJQ
 DmGLxvNoT1iZkLkNDcelykD1fNkPqPJtN7lOdH/pajFp9bkCxB08E/DFUKVOgLqsFnkgVM4VO
 zO/YVCrOnvFkUSRLxSFAr0Fkm2K+VjlrrAM44WpHRPWwe42NbedFt+lSwecZIlOgUfQfKa5AZ
 jSGOPZkyvmpR4v8LjMGiv1dR6yR/0naps0iRrbe3IusiaKTchlR7uDoBSFpGmFbDjLb3xMOwm
 9eHEjgd1ou9UMjU50yL1msFkBHU6u7TeXDqxVEorJK1B2bX0/q/wGT1n24JKpiUVxZqNnnQKS
 sL2DpVYQNK3sx8ao/ouIihjiCSBBNC1DMVl6YI7X+OH9SbxKZh51e44UOl+gkdJrcl6VnO6hZ
 M/0TlW0Xoa8pdEeVpI340xc3vbhcOj5Zlr1E3NZwimu+RixEspgMJBrGJ/PIDK3Yme7MB0cK7
 eo6uQZUbO/hXPiYn7fqXZibp33sd9ONsvALXC6/oC53GE+6nOiBeAsp946A5bwnZUfCT671jl
 da8flxUPPN8/an3rb30f/TqGPBkvZZEpTeEUoM7os/dQP4t1iVmTiWs4HHkbIg+0j9/opuJYV
 Jru8IujKX4dbUV3/sNedHvrtHf/8D87kXiOCQvt38Bv3Id+04jKj5AXJPtsqEgcnfPBDdB8hs
 WhbcKpkfJqcbBGPExKPGHH6J7ZfhfnkeGYYIL10SoUkJJycfFuQV2dM1txvZZOwqyF1VxdXca
 bgryWjWwu7poorw6p5nyDWf7dkheQczbAJZ2nOcK9pBklw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/22 09:26, Geert Uytterhoeven wrote:
>
>> Imagine instead you send your issue to a random mailing list. What is
>> the chance another person with a similar issue will even find it?
>
> Do not underestimate the power of search engines.

I don't. In many situations the same issue can be described completely
differently and finding duplicates becomes near impossible. You
overestimate the power of search engines and the person's ability to use
very specific wording.

>> Again the volume of bug reports is relatively low, fewer than two dozen
>> a week.
>
> Which proves this tool is insignificant in the grant scheme of (Linux)
> things.


https://bugzilla.kernel.org/show_bug.cgi?id=3D204807

A very insignificant exchange of over 2 hundred comments, patches,
suggestions, etc. by the people absolute most of whom would have failed
to do that via email.

Nothing was lost, no messages were accidentally sent to SPAM, all the
people in the conversation _retained_ their privacy as Bugzilla _hides_
emails.

Hasn't privacy been raised as the cornerstone of this discussion several
times already? You're _far more private_ on Bugzilla.


>> * Multiple reporters can perfectly find the people who have made bad
>> commits or who are responsible for certain drivers - it's safer to CC
>> them _via_ Bugzilla than to email them _privately_ or via mailing lists
>> which entails multiple issues including trust, SPAM, formatting,
>> English, net etiquette, etc. etc. etc.
>
> Never send bug reports privately, unless you have a monetary
> relationship with the receiving end.  Always Cc the subsystem
> mailing list, so anyone involved can help.


I've done that on multiple occasions and in _many_ cases actually
received help vs. sending to a mailing list where my messages were
completely neglected.

For instance, I've CC'ed Linus Torvalds _privately_ from Bugzilla twice
and he _chimed_ in and _helped_ resolve the bugs. My messages to LKML
were _ignored_ by +1000 people subscribed to it.

You continue to talk as if random messages to mailing lists are
_actively_ monitored by developers. That's _not_ the case.

Absolute most developers actively monitor only messages from the people
they constantly work with. That's it.

Maybe I should start the list of "Why email sucks in terms of bug
reporting" because I keep saying the same stuff over and over again.



Regards,
Artem
