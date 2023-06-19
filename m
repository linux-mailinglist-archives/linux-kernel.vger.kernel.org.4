Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8CD73568E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjFSMSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjFSMSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:18:13 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604B3E68
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:18:12 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b58351327eso582965a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687177091; x=1689769091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=891wrm9M9PHwifTQT0DHdUPvqqOrY7jEVcZy1G14/Zs=;
        b=i6pWJdQ8p9TeXOdxPvcqbbh3Iv1t+UQQMFkxZrRq6hPmmXwz5xaRXrk+LjVn9u1LXg
         nYPMUF7ugs9T9xXAf11zTMdIOdLDSibQTvv5npFCVHvKG1kyGg23Nc6NttxMiIIHBF0P
         IH8RvDDV+PCFhyW82QM3F+m6mFX0nK1l/HKIU47c8//0LUjQOmKpqjs1BTQAxRG3t6pj
         DOYxBtQbiq0URkxuf/osy+GV4enbt/mPLd0IGUDvmInvUBANKdezmgk0loyzUpBM7mM1
         O+w977Bz5S4F/1x5HRxKILZ7gABF8Y8+S9p8/rdB7yJQ2U+m7zisEEMqi2UIuWI+E0W9
         p9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687177091; x=1689769091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=891wrm9M9PHwifTQT0DHdUPvqqOrY7jEVcZy1G14/Zs=;
        b=MmK23ziTbo46jxFACt1JT2Ycf3HpLCJgVmDELCfGQmSH4xTdnASF79JztlPZTeDeaJ
         luAvKjDWhCnezDggKOqVKUDDOcjaDenUPl2TKy2jVactuApkzCQnIm3tdWfDurSrKYUp
         m34ei7zIQuOAbxtiAISRAhQcHa1AFlAG59UHWVGqrqnZkbBO5HroXNzt9CQVnsJMJPIL
         858zUFGiV6ZeQZ4gbMJofTdIA4AtF4hUWO4PxH+5NOCbH7N38JjxqFA9nut7Ld+Jxx8s
         JrHRsZIbmAqr/lvNiyb4tN6pJdxR5vfiM7YDXDtStoqLgmVF/Wmy2jqXUCvHIvNiagxx
         Q4Lg==
X-Gm-Message-State: AC+VfDyXfI6AThFT6hQ4nV+qGF62bmScU+6zJIxTeAUFeN0KHRXxBc+c
        G6zmQJHY1zyRNUMlEeQMpJMr2w==
X-Google-Smtp-Source: ACHHUZ6a1K6bhpuQp3EEGfeS8gTLH92oXcoGnkyHsxLc+nIF8Xq5bBOcyRwV0WRLPglROKSUIYILOQ==
X-Received: by 2002:a05:6359:a26:b0:12c:9960:ec1e with SMTP id el38-20020a0563590a2600b0012c9960ec1emr3550251rwb.19.1687177091220;
        Mon, 19 Jun 2023 05:18:11 -0700 (PDT)
Received: from [10.85.115.102] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id i19-20020aa78d93000000b0064d45eea573sm16385459pfr.41.2023.06.19.05.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 05:18:10 -0700 (PDT)
Message-ID: <56ef1ccc-f707-b121-76fb-f2096e75a01a@bytedance.com>
Date:   Mon, 19 Jun 2023 20:18:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [External] [tip: sched/core] sched/core: Avoid double calling
 update_rq_clock() in __balance_push_cpu_stop()
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230613082012.49615-3-jiahao.os@bytedance.com>
 <168717269089.404.10438864985621759181.tip-bot2@tip-bot2>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <168717269089.404.10438864985621759181.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/19 tip-bot2 for Hao Jia wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     96500560f0c73c71bca1b27536c6254fa0e8ce37
> Gitweb:        https://git.kernel.org/tip/96500560f0c73c71bca1b27536c6254fa0e8ce37
> Author:        Hao Jia <jiahao.os@bytedance.com>
> AuthorDate:    Tue, 13 Jun 2023 16:20:10 +08:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 16 Jun 2023 22:08:12 +02:00
> 
> sched/core: Avoid double calling update_rq_clock() in __balance_push_cpu_stop()
> 
> There is a double update_rq_clock() invocation:
> 
>    __balance_push_cpu_stop()
>      update_rq_clock()
>      __migrate_task()
>        update_rq_clock()
> 
> Sadly select_fallback_rq() also needs update_rq_clock() for
> __do_set_cpus_allowed(), it is not possible to remove the update from
> __balance_push_cpu_stop(). So remove it from __migrate_task() and
> ensure all callers of this function call update_rq_clock() prior to
> calling it.
> 
Hi Peter,

Thank you very much for refactoring these commit messages to make it 
clearer and more concise.

Thanks,
Hao

> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Link: https://lkml.kernel.org/r/20230613082012.49615-3-jiahao.os@bytedance.com
> ---
>   kernel/sched/core.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 442efe5..c7db597 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2546,7 +2546,6 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
>   	if (!is_cpu_allowed(p, dest_cpu))
>   		return rq;
>   
> -	update_rq_clock(rq);
>   	rq = move_queued_task(rq, rf, p, dest_cpu);
>   
>   	return rq;
> @@ -2604,10 +2603,12 @@ static int migration_cpu_stop(void *data)
>   				goto out;
>   		}
>   
> -		if (task_on_rq_queued(p))
> +		if (task_on_rq_queued(p)) {
> +			update_rq_clock(rq);
>   			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
> -		else
> +		} else {
>   			p->wake_cpu = arg->dest_cpu;
> +		}
>   
>   		/*
>   		 * XXX __migrate_task() can fail, at which point we might end
