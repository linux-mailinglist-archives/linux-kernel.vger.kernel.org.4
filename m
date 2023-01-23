Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7446779CB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjAWLFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAWLFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:05:05 -0500
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB8417CC2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1674471900; bh=UKyfe3d7b7mP4eV4vd8e4mLVQeCRiO9ysqAePajzBcw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=K5yqjDHYDqwVzbVzMoHhvcgNvNnFmmJksI1ph5S9VYV7pBzHu57PTjNVZtV3AK8+m
         3TzHKXxYBIf4DluizV1eXrSd6ax9reabe/PprnHs8ez2wppDgAdYI96yYWD7esRX0z
         kvr9jqSnsY6Oky91dgtS02B9QASQJ04S4qO4RSm0zsA8eBrtJWa/a6LSBb99Jsk9fN
         nSo6cvNp4pp8HWkbldtlbviYu80jUJIuTYEeP4s0rQkXdpUpbbfpA2rhshztYak6KQ
         5bcB/3Zt0hCSaaXIMkDXlav/XspR9u0/ZLn3JjlHeI9Pw1HrxC8lVWTG4ZQX/6xTUH
         lk+eqL9eRl1jg==
Received: by gentwo.de (Postfix, from userid 1001)
        id E2E79B00229; Mon, 23 Jan 2023 12:05:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id E1544B001A1;
        Mon, 23 Jan 2023 12:05:00 +0100 (CET)
Date:   Mon, 23 Jan 2023 12:05:00 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH mm-unstable] lib/Kconfig.debug: do not enable DEBUG_PREEMPT
 by default
In-Reply-To: <Y8vSZ+gOFXWDKC8Z@hyeyoo>
Message-ID: <d23a77b8-e9dd-9fc3-4311-4597e310e7a8@gentwo.de>
References: <20230121033942.350387-1-42.hyeyoo@gmail.com> <86e68d3b-b029-5e82-5bbc-e0ccc2ae1d36@suse.cz> <Y8vSZ+gOFXWDKC8Z@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jan 2023, Hyeonggon Yoo wrote:

> Whew, I still get confused about who to Cc, thanks for adding them.
> and I also didn't include the percpu memory allocator maintainers, who may
> have opinion. let's add them too.

Well looks ok to me.

However, I thought most distro kernels disable PREEMPT anyways for
performance reasons? So DEBUG_PREEMPT should be off as well. I guess that
is why this has not been an issue so far.

