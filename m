Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073C4652E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiLUJ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiLUJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:29:41 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9322821274
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:29:40 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p7vPu-0007Nq-37; Wed, 21 Dec 2022 10:29:38 +0100
Message-ID: <ff898c8d-4ffb-061e-641b-0295578ea24c@leemhuis.info>
Date:   Wed, 21 Dec 2022 10:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH RFC] ipc/mqueue: introduce msg cache
Content-Language: en-US, de-DE
To:     Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Sven Luther <Sven.Luther@windriver.com>
References: <20221220184813.1908318-1-roman.gushchin@linux.dev>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20221220184813.1908318-1-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1671614980;9141bc7a;
X-HE-SMSGID: 1p7vPu-0007Nq-37
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.22 19:48, Roman Gushchin wrote:
> Sven Luther reported a regression in the posix message queues
> performance caused by switching to the per-object tracking of
> slab objects introduced by patch series ending with the
> commit 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for all
> allocations").
> [...]

Thx for looking into this

> The last line reflects the result with this patch ("6.1-rc8+p").
> 
> [1]: https://lore.kernel.org/linux-mm/Y46lqCToUa%2FBgt%2Fc@P9FQF9L96D/T/

This link...

> Reported-by: Sven Luther <Sven.Luther@windriver.com>

...should be here and look like this, as tools like regzbot otherwise
won't do the right thing:

Link: https://lore.kernel.org/linux-mm/Y46lqCToUa%2FBgt%2Fc@P9FQF9L96D/ [1]

For details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/
Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html)
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)

> Tested-by: Sven Luther <Sven.Luther@windriver.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

#regzbot ^backmonitor:
https://lore.kernel.org/linux-mm/Y46lqCToUa%2FBgt%2Fc@P9FQF9L96D/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.


