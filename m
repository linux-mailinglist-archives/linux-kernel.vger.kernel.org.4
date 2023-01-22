Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED67676D3E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 14:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjAVNtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 08:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjAVNtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 08:49:31 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212A294
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 05:49:26 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pJaip-0003eP-0I; Sun, 22 Jan 2023 14:49:23 +0100
Message-ID: <8ec65f01-89fe-bd6f-a2c2-f4dfc0555cc2@leemhuis.info>
Date:   Sun, 22 Jan 2023 14:49:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Linux 6.2-rc5
Content-Language: en-US, de-DE
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wg+E9tTCrSqBOxejUX11f8ebyRWQ+4exC=cmOEupX_d7Q@mail.gmail.com>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
In-Reply-To: <CAHk-=wg+E9tTCrSqBOxejUX11f8ebyRWQ+4exC=cmOEupX_d7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674395366;823d4a2c;
X-HE-SMSGID: 1pJaip-0003eP-0I
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing Vlastimil, akpm, and Greg]

On 22.01.23 01:44, Linus Torvalds wrote:
> Ok, so I thought we were back to normal after the winter holidays at
> rc4. Now, a week later, I think I was mistaken - we have fairly
> sizable rc5, so I suspect there was still pent up testing and fixes
> from people being off. [...]

Huh, a -rc on Saturday evening? That's unusual. But well, in that case I
can wait till tomorrow with my regression report, as it's too late for
the rc anyway. :-D

But nevertheless there is one thing I want to bring up, even if -rc5 is
already out: Vlastimil asked me explicitly to highlight ```Revert
"mm/compaction: fix set skip in fast_find_migrateblock"```[1] in my
weekly report[2], as me would prefer if that patch could head to
mainline and especially stable rather sooner than later. He wrote:

```I consider this serious enough to be fixed in mainline+stable ASAP,
hopefully in rc5, as it does hurt people using 6.1.```

See [3] and [4] for the regression reports.

Andrew merged that patch on the 13th[5]. The fix thus by now spend a few
days in linux-next. But that hasn't been the the case yet when Andrew
sent the latest -mm hotfixes to you on the 16th, that's why it's still
in mm.

It's too late now to get it included in -rc5, but maybe Greg is willing
to pick it up for the next stable cycle if you merge it to mainline
today. But obviously it's your decision if that's worth it. And yes,
ideally I should have asked Andrew to send a extra pull request your
way, but I was busy with other stuff and only saw Vlastimil a few hours
ago. :-/ Sorry.

Ciao, Thorsten

[1] https://lore.kernel.org/all/20230113173345.9692-1-vbabka@suse.cz/
[2]
https://lore.kernel.org/all/f47f69f9-7378-f18c-399b-b277c753532e@suse.cz/
[3] https://bugzilla.suse.com/show_bug.cgi?id=1206848
[4]
[5] https://lore.kernel.org/all/20230114041117.B372AC43392@smtp.kernel.org/
