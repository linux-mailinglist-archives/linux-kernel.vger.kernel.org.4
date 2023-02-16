Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A444699AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjBPQ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBPQ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:59:20 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816877AAB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:59:19 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pShbJ-0007uE-5Z; Thu, 16 Feb 2023 17:59:17 +0100
Message-ID: <611c1202-1978-8886-eec3-929933ee75cd@leemhuis.info>
Date:   Thu, 16 Feb 2023 17:59:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] mm/migrate: Fix wrongly apply write bit after mkdirty on
 sparc64
Content-Language: en-US, de-DE
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Bowler <nbowler@draconx.ca>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230216153059.256739-1-peterx@redhat.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230216153059.256739-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676566759;174ec9e1;
X-HE-SMSGID: 1pShbJ-0007uE-5Z
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.23 16:30, Peter Xu wrote:
> Nick Bowler reported another sparc64 breakage after the young/dirty
> persistent work for page migration (per "Link:" below).  That's after a
> similar report [2].

Thx for handling this.

> [...]
>
> Note: this is based on mm-unstable, because the breakage was since 6.1 and
> we're at a very late stage of 6.2 (-rc8), so I assume for this specific
> case we should target this at 6.3.
> 
> [1] https://lore.kernel.org/all/20221021160603.GA23307@u164.east.ru/
> [2] https://lore.kernel.org/all/20221212130213.136267-1-david@redhat.com/
> 
> Cc: regressions@leemhuis.info

Not that it matters much, but feel free to use this instead:

CC: regressions@lists.linux.dev

Then things don't depend on me (in case I ever get help with my cat
herding job). And it also make it even more obvious that this patch
fixes a regression to anyone who handles it downstream.

> Fixes: 2e3468778dbe ("mm: remember young/dirty bit for page migrations")

That's a commit from 6.1, hence this should likely have:

Cc: stable@vger.kernel.org # 6.1.y

[no, a fixes tag alone does not suffice, see docs]

> Link: https://lore.kernel.org/all/CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com/
> Reported-by: Nick Bowler <nbowler@draconx.ca>
> [...]

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
