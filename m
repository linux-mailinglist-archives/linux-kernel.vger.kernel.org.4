Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432C0652B22
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 03:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbiLUCCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 21:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLUCCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 21:02:08 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C585186D5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 18:01:42 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso708411pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 18:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zQEUHbVoMRZdqdXl0f6UHd/WvWI7JLs5FDI1gkZIurU=;
        b=fygB+zg4HxJHbHL8GWFwzTRr2qDAaxHPnmyJZnE6hsSOeCRf3S9VYqPFTZj7A9sVOA
         JtpofC7t+HXsGsxKLKRX95noSaqGNsF7zyG1bkyhr52CXequgXSGlCdczTHJ7lAA2e4c
         9Ob9YFSZzwD2hJdKepi09URgQPdTt4u0tlNttloOPZrMu95JUrXXXcg2rHfB4gI6b6jo
         gFg4JwKtkzv27mvznQmMSMJCefTjeebRDgkFXfxxtCiztNSpUJn/tWknv/uViuV9/tqs
         9K39Be9RqMLJ9OtgJdPJIb47Dt6sAV2hUxFKM1Wxg3Fqe9yZmyen9U+N6x2iHCvmtJMx
         w2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQEUHbVoMRZdqdXl0f6UHd/WvWI7JLs5FDI1gkZIurU=;
        b=G2O8M/KQbjUxTtezSIkcq9+SB+8hCXB8tDm3uN4tLl1+YBLVwK5vOM0s4pGWJsobUW
         6QfUW4OQ31cwaxjHdA82cyK2mtIROjoXX2hPMU7M0qR+eBr6HjnLKSrtHp/aG+T7IiKq
         MQ22KwGoin+WxDhcg98cfNblaDO8fJA2lIbDQxr+hOaV/TdNy8Qo88rNzkhEv21CfFus
         8JzrOK6zw28EPEYzRU4AO7dVRv6n5tFsj9bUvZ9ziVXb5rGbwxfeWxIgqhaOc1M9+iZK
         ERVZ6DSxIg5+UMKYUf/Zaaqd9CGoIagIWigUDQm73q7//DBWpIfrmKn2lmP841jyP8mL
         bJIw==
X-Gm-Message-State: AFqh2kpuyMZlSGAy33Mq67bQbJi/GnZUWGQO9pkYwNr2KBk8Ts+S/znA
        zkhfM3T/dWoWV/KFLhJ+3mkWNw==
X-Google-Smtp-Source: AMrXdXsO0JRD6wYYAIXYBqKcELLABb0gI3rrDVrhgglm07MyEUS+7OrRvXk577RfQAlFW+nRPDWEtQ==
X-Received: by 2002:a17:902:cf12:b0:189:aa51:e27f with SMTP id i18-20020a170902cf1200b00189aa51e27fmr17848956plg.44.1671588102115;
        Tue, 20 Dec 2022 18:01:42 -0800 (PST)
Received: from ?IPV6:2409:8a28:e63:2da0:b0e9:bb47:3cf6:6095? ([2409:8a28:e63:2da0:b0e9:bb47:3cf6:6095])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b0018699e6afd8sm10012068pln.265.2022.12.20.18.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 18:01:41 -0800 (PST)
Message-ID: <6d7288f0-1b85-6a4f-d39e-a46675f60d5f@bytedance.com>
Date:   Wed, 21 Dec 2022 10:01:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH v5 1/2] sched/core: Minor optimize ttwu_runnable()
To:     mingo@redhat.com, peterz@infradead.org
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, bagasdotme@gmail.com,
        yu.c.chen@intel.com
References: <20221208032007.94459-1-zhouchengming@bytedance.com>
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20221208032007.94459-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, ping :-)


On 2022/12/8 11:20, Chengming Zhou wrote:
> ttwu_runnable() is used as a fast wakeup path when the wakee task
> is running on CPU or runnable on RQ, in both cases we can just
> set its state to TASK_RUNNING to prevent a sleep.
> 
> If the wakee task is on_cpu running, we don't need to update_rq_clock()
> or check_preempt_curr().
> 
> But if the wakee task is on_rq && !on_cpu (e.g. an IRQ hit before
> the task got to schedule() and the task been preempted), we should
> check_preempt_curr() to see if it can preempt the current running.
> 
> This also removes the class->task_woken() callback from ttwu_runnable(),
> which wasn't required per the RT/DL implementations: any required push
> operation would have been queued during class->set_next_task() when p
> got preempted.
> 
> ttwu_runnable() also loses the update to rq->idle_stamp, as by definition
> the rq cannot be idle in this scenario.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Suggested-by: Valentin Schneider <vschneid@redhat.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> ---
> v5:
>  - Split the reorganization and optimization into two patches
>    per Chen Yu. Thanks!
> 
> v4:
>  - s/This patch reorg/Reorganize/ per Bagas Sanjaya. Thanks!
> 
> v3:
>  - Improve the changelog per Valentin Schneider. Thanks!
> 
> v2:
>  - keep check_preempt_curr() for on_rq && !on_cpu case in ttwu_runnable(),
>    per Valentin Schneider.
>  - reorg ttwu_do_wakeup() and ttwu_do_activate() code, so ttwu_do_wakeup()
>    can be reused in ttwu_runnable(), per Peter Zijlstra.
>  - reuse ttwu_do_wakeup() in try_to_wake_up() (p == current) fast path too,
>    so ttwu_do_wakeup() become the only place we mark task runnable.
> ---
>  kernel/sched/core.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 314c2c0219d9..60aa7774e5f4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3718,9 +3718,16 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  
>  	rq = __task_rq_lock(p, &rf);
>  	if (task_on_rq_queued(p)) {
> -		/* check_preempt_curr() may use rq clock */
> -		update_rq_clock(rq);
> -		ttwu_do_wakeup(rq, p, wake_flags, &rf);
> +		if (!task_on_cpu(rq, p)) {
> +			/*
> +			 * When on_rq && !on_cpu the task is preempted, see if
> +			 * it should preempt whatever is current there now.
> +			 */
> +			update_rq_clock(rq);
> +			check_preempt_curr(rq, p, wake_flags);
> +		}
> +		WRITE_ONCE(p->__state, TASK_RUNNING);
> +		trace_sched_wakeup(p);
>  		ret = 1;
>  	}
>  	__task_rq_unlock(rq, &rf);
