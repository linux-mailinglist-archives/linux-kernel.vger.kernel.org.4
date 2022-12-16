Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D981764E9C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLPKwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLPKwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:52:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1619E26AEE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HFZW+ScVdcPWKQMgjNUiNj4ZAmrpCGheNMzUBN6ydSo=; b=ZRVeW0e6MSlsI1dej8KrH406u3
        DNHFgykFazkrQI0T1rSGLc4mUY8uwYyDyt7ju9Wi9RzuQlLroxQR7K+ZiSYj/f1GYgSj9lEybHy+Z
        3JvLSK1qvxC4pMSISeuc2apajW6gOrx4HEveLWUrHqv+0Gtil7c/fmw5qV0UpslEmi6pINDO2Ggls
        dERzr5G620h07p9NoQf98Xl3AaJ/gc1VuG4lA3vp+0vvkPikX37StHOanw7fhoqIzceaiViHkah1I
        iae0uod51scqCMz9Kg39w9XILRDAcNSmU4NFo52z2TclzMLxP13pCFTIeFyQiRlLApyCu+4Uaj3dT
        hImlOHNw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p68Jx-00B7xx-AN; Fri, 16 Dec 2022 10:52:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D4673001E7;
        Fri, 16 Dec 2022 11:52:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02D67201D817F; Fri, 16 Dec 2022 11:52:03 +0100 (CET)
Date:   Fri, 16 Dec 2022 11:52:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Clean up the process of scanning the CPU for some
 functions
Message-ID: <Y5xN0w/NUM9sSabJ@hirez.programming.kicks-ass.net>
References: <20221216062406.7812-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216062406.7812-1-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 02:24:04PM +0800, Hao Jia wrote:

> Hao Jia (2):
>   sched/numa: Stop an exhastive search if an idle core is found
>   sched/core: Adjusting the order of scanning CPU
> 
>  kernel/sched/core.c | 2 +-
>  kernel/sched/fair.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Thanks!
