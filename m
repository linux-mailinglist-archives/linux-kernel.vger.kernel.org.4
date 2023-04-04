Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1CE6D56E7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 04:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjDDCu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 22:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDDCuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:50:54 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472821FD3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 19:50:47 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id y184so23291046oiy.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 19:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680576646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XofY8x5MeQRpt2Pp1DmyLIEcV5jICvunInGd53WZu+o=;
        b=MPXKFvVIvzBj3nPjmR6E5eI+tv/dKzIV7fsnj5e0SNo3sXxOIfbBbMNPdL3lAydrpO
         7zXFSHlQsfoy9seplKMVEyzLw6V/O7TqA+KfmsmJEuaFqFBFBnUF+3hDyUhWZjYhU5Vn
         KsFOqlTTtJPPBWbHjppI8Z0r1ctzgyPX2FLtNWOIGtHrEcpw4mqWQbQ1GoterWVdC+uk
         0AOvTom9KbMDl3WmAEoJtDftEKeBGrLaLkzdh2yOrZAStVFJY6Uu7sViCCcLI9iCOYrr
         tzxN6r+5dc9HatSy5yHC04RXoEkwBC/GVyfgljAcuNvakDxHeLo5qACX9SR5aI83+xs6
         1MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680576646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XofY8x5MeQRpt2Pp1DmyLIEcV5jICvunInGd53WZu+o=;
        b=L6sQEwI9ru5Q5j7WDz4aFGbXahFsTFEmsvyXMLFq1oqkfv3VAFfYsKK6M7kWO5oYR3
         0I3tJ+TmeEvkqfeR62BmjjqzMyOn75loodu8SDCwKuA9ww8Gs5iMpnXeWOtb2qbc5zIf
         e953j3ldt55TQs+wXmbGD5uT/ri7FwQnYwPkhi7qIgsTWvkr4Sd6otQTKHKeqohlOds0
         tFTJjUoJMebQXdNqcy71wYw284sJ8N+HotzPKFg+A73s4v9IdC6BOQBNu492BDfrNK3W
         QHoe+7Jio5s37c3MK33cpY4Dyk5wI61pYVXzHWrE/BOUARzhf3QuuQRli7pdYVs4vRb1
         Iz1Q==
X-Gm-Message-State: AAQBX9dJP5WFNVdKLyM96U7TDd/+Z1j6+8EjjF+HuLJuXsFZnBxZ3DH+
        h8CuDMbsX6a0KeHtnbHyTrQ=
X-Google-Smtp-Source: AKy350Zu+r7jlAU33Q2ZbeqlfS7gzvqDQC5DO3QuZAPqWgw18Y+CQ1y/OlZ6bq27RCi5tqoiNHjtnA==
X-Received: by 2002:aca:1812:0:b0:389:93a5:5b03 with SMTP id h18-20020aca1812000000b0038993a55b03mr652229oih.3.1680576646442;
        Mon, 03 Apr 2023 19:50:46 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id x14-20020a056808144e00b00387160bcd46sm4541289oiv.46.2023.04.03.19.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 19:50:45 -0700 (PDT)
Date:   Mon, 3 Apr 2023 19:50:44 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, dchinner@redhat.com,
        yebin10@huawei.com
Subject: Re: [PATCH 2/2] lib/percpu_counter: fix dying cpu compare race
Message-ID: <ZCuQhDLkRhJy081W@yury-laptop>
References: <20230404014206.3752945-1-yebin@huaweicloud.com>
 <20230404014206.3752945-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404014206.3752945-3-yebin@huaweicloud.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 09:42:06AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> In commit 8b57b11cca88 ("pcpcntrs: fix dying cpu summation race") a race
> condition between a cpu dying and percpu_counter_sum() iterating online CPUs
> was identified.
> Acctually, there's the same race condition between a cpu dying and
> __percpu_counter_compare(). Here, use 'num_online_cpus()' for quick judgment.
> But 'num_online_cpus()' will be decreased before call 'percpu_counter_cpu_dead()',
> then maybe return incorrect result.
> To solve above issue, also need to add dying CPUs count when do quick judgment
> in __percpu_counter_compare().

Not sure I completely understood the race you are describing. All CPU
accounting is protected with percpu_counters_lock. Is it a real race
that you've faced, or hypothetical? If it's real, can you share stack
traces?
 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  lib/percpu_counter.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index 5004463c4f9f..399840cb0012 100644
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -227,6 +227,15 @@ static int percpu_counter_cpu_dead(unsigned int cpu)
>  	return 0;
>  }
>  
> +static __always_inline unsigned int num_count_cpus(void)

This doesn't look like a good name. Maybe num_offline_cpus?

> +{
> +#ifdef CONFIG_HOTPLUG_CPU
> +	return (num_online_cpus() + num_dying_cpus());

               ^                                    ^ 
         'return' is not a function. Braces are not needed

Generally speaking, a sequence of atomic operations is not an atomic
operation, so the above doesn't look correct. I don't think that it
would be possible to implement raceless accounting based on 2 separate
counters.

Most probably, you'd have to use the same approach as in 8b57b11cca88:

        lock();
        for_each_cpu_or(cpu, cpu_online_mask, cpu_dying_mask)
                cnt++;
        unlock();

And if so, I'd suggest to implement cpumask_weight_or() for that.

> +#else
> +	return num_online_cpus();
> +#endif
> +}
> +
>  /*
>   * Compare counter against given value.
>   * Return 1 if greater, 0 if equal and -1 if less
> @@ -237,7 +246,7 @@ int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch)
>  
>  	count = percpu_counter_read(fbc);
>  	/* Check to see if rough count will be sufficient for comparison */
> -	if (abs(count - rhs) > (batch * num_online_cpus())) {
> +	if (abs(count - rhs) > (batch * num_count_cpus())) {
>  		if (count > rhs)
>  			return 1;
>  		else
> -- 
> 2.31.1
