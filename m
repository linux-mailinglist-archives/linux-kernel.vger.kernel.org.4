Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD635F350D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiJCR6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJCR5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:57:19 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82706242;
        Mon,  3 Oct 2022 10:56:35 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so7242933oop.9;
        Mon, 03 Oct 2022 10:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=gqeG2bk/2Oil9VANRyGxn3QzmZoAZRDSrhJ8M9gUamM=;
        b=aqTFzRRrRwAPGWpJkPmp5dgY5kaqOXORBz5lRuAKAXu3kSD3gznaU1TWDG+6jMnvvo
         wVm9tpjrdzeJy7NTi16105FqlVYN4i5sst0rirsdDa15EUhKzg8DDwKupD0MzXCKKX7R
         xudFcwY4zShcN9RCcZu0lgk6WGdbs6yr8QG1AawI1te2JW4fHjip0vhZ96BENxHaw9Hs
         VrwP7ioiMGvxyFPQfRZ4N5YCtGY09HWs2LM6qSw0prViZoU2HKJ5B03pglDN8CkNjaRu
         FctO3GLKWq8/ptHnN4l6U1T4G6MnY8ojSs+v8QwUHr9vlrx6d2ol+f5R+K79Bii72kKX
         gBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gqeG2bk/2Oil9VANRyGxn3QzmZoAZRDSrhJ8M9gUamM=;
        b=PhJNzkK4iPNztyPkFBXzyoomNJ+u4E/FPocub/unFXeGW/eSD2ODs+e628Zml9sY9Q
         RBQ9m/9E9wTMDBzaKcx89wnvZKqwKpM6ZWXoQfl8gq3QmEiMJBD6wY+ffNHSoJ2abHHU
         oS/VawGGYC5/RfuqsyQtKZqKjcq4m7jMgVkSgU4GWCNQEQIc37FeiIFsdrz3AuTU/0ZA
         762BrKS+P4iOT5t0IiN2gn9PP+xAfsX8A170xB2NbZuXRiHZJcRIYSJP7Ji1uEmktuWL
         7I23AHByBbRloQtVoxtYzdYvv8KPaW/PbuL6IHItzFGJrrRQBb4oeZ4M3MrFNJe1MYUU
         ZGmQ==
X-Gm-Message-State: ACrzQf0nY1gnQYKU2LF/QV5tmpZg94VuIsbNaA1JTAWWTKkRpoS5rLIu
        BZTZCWMQgL7TbaVoWxpT5Xg=
X-Google-Smtp-Source: AMsMyM7hO1K+jJ3gpx+FucxtVuPmD5Hp0gqszRg+EdZE3vHcIUiIUAlj2oefskAejxW+YHYsHqhC/A==
X-Received: by 2002:a9d:72d1:0:b0:65c:6650:a3c5 with SMTP id d17-20020a9d72d1000000b0065c6650a3c5mr8124998otk.286.1664819794817;
        Mon, 03 Oct 2022 10:56:34 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id e17-20020a9d7311000000b0063715f7eef8sm2489013otk.38.2022.10.03.10.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:56:34 -0700 (PDT)
Date:   Mon, 3 Oct 2022 10:54:23 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH bitmap-for-next 1/5] blk_mq: Fix cpumask_check() warning
 in blk_mq_hctx_next_cpu()
Message-ID: <Yzshzw6hKhbtdxSd@yury-laptop>
References: <20221003153420.285896-1-vschneid@redhat.com>
 <20221003153420.285896-2-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003153420.285896-2-vschneid@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 04:34:16PM +0100, Valentin Schneider wrote:
> A recent commit made cpumask_next*() trigger a warning when passed
> n = nr_cpu_ids - 1. This means extra care must be taken when feeding CPU
> numbers back into cpumask_next*().
> 
> The warning occurs nearly every boot on QEMU:

[...]
 
> Fixes: 78e5a3399421 ("cpumask: fix checking valid cpu range")

No! It fixes blk-mq bug, which has been revealed after 78e5a3399421.

> Suggested-by: Yury Norov <yury.norov@gmail.com>

OK, maybe I suggested something like this. But after looking into the code
of blk_mq_hctx_next_cpu() code for more, I have a feeling that this should
be overridden deeper. 

Can you check - did this warning raise because hctx->next_cpu, or
because cpumask_next_and() was called twice after jumping on
select_cpu label?

> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  block/blk-mq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c96c8c4f751b..30ae51eda95e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2046,8 +2046,13 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>  
>  	if (--hctx->next_cpu_batch <= 0) {
>  select_cpu:

Because we have backward looking goto, I have a strong feeling that the
code should be reorganized.

> -		next_cpu = cpumask_next_and(next_cpu, hctx->cpumask,
> -				cpu_online_mask);
> +		if (next_cpu == nr_cpu_ids - 1)
> +			next_cpu = nr_cpu_ids;
> +		else
> +			next_cpu = cpumask_next_and(next_cpu,
> +						    hctx->cpumask,
> +						    cpu_online_mask);
> +
>  		if (next_cpu >= nr_cpu_ids)
>  			next_cpu = blk_mq_first_mapped_cpu(hctx);

This simply means 'let's start from the beginning', and should be
replaced with cpumask_next_and_wrap().

>  		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;


Maybe something like this would work?

        if (--hctx->next_cpu_batch > 0 && cpu_online(next_cpu)) {
                hctx->next_cpu = next_cpu;
                return next_cpu;
        }

        next_cpu = cpumask_next_and_wrap(next_cpu, hctx->cpumask, cpu_online_mask)
        if (next_cpu < nr_cpu_ids) {
                hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
                hctx->next_cpu = next_cpu;
                return next_cpu;
        }

        /*
         * Make sure to re-select CPU next time once after CPUs
         * in hctx->cpumask become online again.
         */
        hctx->next_cpu = next_cpu;
        hctx->next_cpu_batch = 1;
        return WORK_CPU_UNBOUND;

I didn't test it and likely screwed some corner case. I'm just
trying to say that picking next cpu should be an easier thing.

Thanks,
Yury
