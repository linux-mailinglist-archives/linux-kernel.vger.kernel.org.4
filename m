Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944DC701F48
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 21:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjENTdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 15:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjENTdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 15:33:19 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4741E68
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 12:33:16 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pyHSz-0007FP-L3; Sun, 14 May 2023 21:33:13 +0200
Message-ID: <b4dbdc40-a074-0ee5-734b-93ab6703c6ad@leemhuis.info>
Date:   Sun, 14 May 2023 21:33:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Linux regressions report for mainline [2023-05-14]
Content-Language: en-US, de-DE
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <168407416011.74685.9039980276616254723@leemhuis.info>
 <CAHk-=wjVxkvY0n2ZDv=oMB4WSaz1RxQmL1DxUjwFSbBfNiUFgQ@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAHk-=wjVxkvY0n2ZDv=oMB4WSaz1RxQmL1DxUjwFSbBfNiUFgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684092796;d8ab976f;
X-HE-SMSGID: 1pyHSz-0007FP-L3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.23 18:24, Linus Torvalds wrote:
> On Sun, May 14, 2023 at 7:24 AM Regzbot (on behalf of Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> What I can't see yet though is a pull request from Russell with a fix
>> from Ard[2] (in next as 2b951b0efbaa) for boot issues[3] that apparently
>> break a lot of arm32 configs, which among others lead to "tons of
>> different boot time errors on the syzbot arm32 qemu instance"[4].
> 
> I have that. You may not have seen it because rmk just cc's the ARM SoC list.

Ahh, yeah, that's why I missed it. Good that it made it, will set up lei
to not miss such pulls in the future.

> We also have some vhost regressions due to the move to user worker
> threads (rather than kthreads), they don't seem to be on your list.
> They're being worked on.

Yeah, funny story, I seem to share the name with someone that joined the
discussion yesterday, as he also ran into a problem with that stuff. He
even uses my own private domain for his email address, too. I bet that's
the guy with strange hair that often looks me in the eye first thing in
the morning when I see this silver thingy on the wall. I'll have a word
with him to ensure he from now on will add his regressions to the
tracking himself. ;)

Ciao, Thorsten 'the regression tracker who forgets to add regressions to
 the tracking that plague himself' Leemhuis
