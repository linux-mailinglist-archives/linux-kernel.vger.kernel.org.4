Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAB868243F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjAaF5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAaF5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:57:47 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAAB2FCE1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 21:57:45 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id a20-20020a17090ad81400b0022c3185ebbeso5268708pjv.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 21:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7exrOe2on2riTg2cmysFL7OOGBYQJlqYnbFHy7kj8SQ=;
        b=TWSTimuwBiO123TlBjYWCTliEIrPxGdALcNi4MdFFrlvRGKAndrgyhBUDw3fHKwxT+
         k7wWg3I9XQZYnnY8N8pFkaA1ZvoSNjKF+FexKZ6uWuGH26jZ+bOjwlsHWTzmfstcNpj/
         1JEPBdPTfBynboPGiFIFOz+DOLEjJJXHpSpmZLkzj084c/QkCzS5QrflnCw/nGAJcQar
         uBKfDU4xqaw6L4XdiPwsIVYymwpjjd6xVNB/PfLFSaxdsqTyo4WEtmL0/QAQD8byWlKG
         zdaHgS6rjFndbKQ9aD+G3XframQKx41QHAKJQcEe2yExT4cM6nfAjVm3QBwXBAx0oKZk
         Ra1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7exrOe2on2riTg2cmysFL7OOGBYQJlqYnbFHy7kj8SQ=;
        b=7RIKn98ffpY3GDErKqPOf3EYfbw01iYyhQWRzAfKy9S3B/J39JOmfngL5lpK5UyxOr
         FNmoyFZg45u4REPw5IgHqah0AAqh4mULHYqLRJT2oMN5YT2/7NsC1TCt43sXg8RyQhZh
         HPj//IZWmJp06foAd4620JLVYRFjwddMsUrvLUWcRFFK41YFTzZUKB79ylbSY7zwi5nc
         J1LeaZf0Q6KO5j+e6qs3Nu5bdBdsAFd9KhLZPwKhmNvytaG8uiYh9l8MRg3Y5yp6ymYw
         fH2PXueBvPqA0P+cUKay9fibO+/bTBhqyZbjRSdnK5lMhZbAqcqtM1nwibNqcTIa8dcD
         hphg==
X-Gm-Message-State: AFqh2kqikVcMocHM2trxXZsZeJxHLAL1/1nYUtpWF+0szd3WUv5wTjhv
        0MarpqVyqBN5qsvluNFEIAQ9Mnz1uIpZaw==
X-Google-Smtp-Source: AMrXdXuHKCfB2pyWuLh0HSd4OVD5BMeJyszPXnBbqYqJ146ngSaToqqFicpkrv8GNUM55+3EZREsbS5dolzSpQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:6b07:b0:22b:b70f:fa46 with SMTP
 id v7-20020a17090a6b0700b0022bb70ffa46mr5730992pjj.107.1675144665182; Mon, 30
 Jan 2023 21:57:45 -0800 (PST)
Date:   Tue, 31 Jan 2023 05:57:43 +0000
In-Reply-To: <Y9iq8fRT4sDgIwQN@casper.infradead.org>
Mime-Version: 1.0
References: <202301301057.e55dad5b-oliver.sang@intel.com> <Y9dETROtv9Bld9TI@casper.infradead.org>
 <20230131052352.5qnqegzwmt7akk7t@google.com> <Y9iq8fRT4sDgIwQN@casper.infradead.org>
Message-ID: <20230131055743.tsilxx5vfl6gx4dj@google.com>
Subject: Re: [linus:master] [mm]  f1a7941243:  unixbench.score -19.2% regression
From:   Shakeel Butt <shakeelb@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 05:45:21AM +0000, Matthew Wilcox wrote:
[...]
> > I ran perf and it seems like percpu counter allocation is the additional
> > cost with this patch. See the report below. However I made spawn a bit
> > more sophisticated by adding a mmap() of a GiB then the page table
> > copy became the significant cost and no difference without or with the
> > given patch.
> > 
> > I am now wondering if this fork ping pong really an important workload
> > that we should revert the patch or ignore for now but work on improving
> > the performance of __alloc_percpu_gfp code.
> > 
> > 
> > -   90.97%     0.06%  spawn    [kernel.kallsyms]  [k] entry_SYSCALL_64_after_hwframe
> >    - 90.91% entry_SYSCALL_64_after_hwframe
> >       - 90.86% do_syscall_64
> >          - 80.03% __x64_sys_clone
> >             - 79.98% kernel_clone
> >                - 75.97% copy_process
> >                   + 46.04% perf_event_init_task
> >                   - 21.50% copy_mm
> >                      - 10.05% mm_init
> > ----------------------> - 8.92% __percpu_counter_init
> >                            - 8.67% __alloc_percpu_gfp
> >                               - 5.70% pcpu_alloc
> 
> 5.7% of our time spent in pcpu_alloc seems excessive.  Are we contending
> on pcpu_alloc_mutex perhaps?  Also, are you doing this on a 4-socket
> machine like the kernel test robot ran on?

I ran on 2-socket machine and I am not sure about pcpu_alloc_mutex but I
doubt that because I ran a single instance of the spawn test i.e. a
single fork ping pong.

> 
> We could cut down the number of calls to pcpu_alloc() by a factor of 4
> by having a pcpu_alloc_bulk() that would allocate all four RSS counters
> at once.
> 
> Just throwing out ideas ...

Thanks, I will take a stab at pcpu_alloc_bulk() and will share the
result tomorrow.

thanks,
Shakeel
