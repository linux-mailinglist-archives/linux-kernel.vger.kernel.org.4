Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF575F06D0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiI3Irf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiI3Ird (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:47:33 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA83B154468;
        Fri, 30 Sep 2022 01:47:31 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oeBg9-0005wX-SR; Fri, 30 Sep 2022 10:47:29 +0200
Message-ID: <5d15ec50-e0b7-dc90-9060-3583633070e8@leemhuis.info>
Date:   Fri, 30 Sep 2022 10:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US, de-DE
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Artem S. Tashkinov" <aros@gmx.com>
Cc:     workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
In-Reply-To: <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1664527651;18c2ace7;
X-HE-SMSGID: 1oeBg9-0005wX-SR
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.22 15:04, Konstantin Ryabitsev wrote:
> On Thu, Sep 29, 2022 at 12:22:35PM +0000, Artem S. Tashkinov wrote:
> [...]
> We do have ability to fund development efforts -- LF has been the primary
> sponsor behind public-inbox.org over the past 3 years. However, there must be
> a clear, strong, and well-articulated mandate from the community. From what I
> heard, the vast majority of maintainers simply want a web form that would
> allow someone to:
> 
> 1. clearly state what kernel version they are using
> 2. clearly describe what they were trying to do
> 3. explain what they expected vs. what they got
> 4. attach any files
> 5. give this bug report a unique identifier

Sometimes there are days where I think "let's go down the 'do everything
by mail' rabbit hole some more and couple a pastebin and a somewhat
improved regzbot with an app (usable both locally and on the web) that
helps users preparing a report they can then send with their usual
mailer". And then there are days "ohh, no, that might be a totally
stupid thing to do". :-/

> Then a designated person would look through the bug report and either:
> 
> a. quick-close it (with the usual "talk to your distro" or "don't use a
>    tainted kernel" etc)

I think having some app would be good here, as it could help gathering
everything and catch problems early, to prevent users from spending a
lot of time on preparing a report that will be ignored.

> b. identify the responsible maintainers and notify them
> 
> The hard part is not technical -- the hard part is that "designated person."

+1

> Being a bugmaster is a thankless job that leads to burnout, regardless of how
> well you are paid. Everyone is constantly irate at you from both ends [...]

Tell me about it. Nevertheless I sometimes wonder if I should give it a
try once I got all this regression tracking thing established somewhat
more, as in the end there I'm kind of a bugmaster for regressions already...

> Before we try to fix/replace bugzilla,

Just to be sure: I assume you meant "replacing bugzilla or fixing it for
real" here, and not my band-aid efforts outlined at the start of this
thread? Or do you have a problem with what I proposed to at least make
things less bad for now?

> we really need to figure out the entire
> process and pinpoint who is going to be the one in charge of bug reports. If
> you think that LF should establish a fund for a position like that, then you
> should probably approach LF fellows (Greg KH, Shuah Khan), who can then talk
> to LF management. The IT team will be happy to support you with the tooling,
> but tooling should come second to that -- otherwise we'll just be replacing an
> old and rusty dumpster on fire with a new and shiny dumpster on fire.

+1

Ciao, Thorsten
