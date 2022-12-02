Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310FB640BC7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiLBRIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiLBRIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:08:34 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741F1CC67B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:08:30 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id jr1so6015987qtb.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ijOKz8foluJ3i9Qm1oJ9IBp26bq+WaSPlqT8hTWxtV0=;
        b=YjE8l/XLABJabG+MbrNIKMporuqCCJXq9OxoKQAhTn3vy8sXljxVYu+mGGu5N0M5Nb
         x8GKTwyLsZt5qEv9LAttCXY+8SQ9pnaCk5/brVhdee7W0b0H6jx2XaAqmmxZf/m3MCIJ
         wllLpSOlER6qjdRH4HPejMUXHFzRuDor/6YeQbHY70nVr3Wcqy891t0upjZcm+HK5I4S
         Cza/ZjriXje6CnYhCvaa/dfnXlMDqcXpWdLUivJ5t5Gp1XnAHv055LZ3XT3WJ4k9RgOC
         ss2NUJr+VK1ZmTwIgu/AesP9ufnGEi3idAy6QDmfXHp4t3mQcig7Ky37IcEzUEdv2IcV
         L/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijOKz8foluJ3i9Qm1oJ9IBp26bq+WaSPlqT8hTWxtV0=;
        b=x2/GB/YMBGIOQRtw/gIG7f0Oc9S8BCJKZahDWKVp+Yk0ifvrBnF7DZeP6/VSKJY5wv
         yqUfm73MydhQ0zlB6H0XuM26eP8l/AAVzT+i8OxbuaVLu518J2GwYAfzXquDRuGLh4rD
         +zeBpxEVfzg8ZW/YZRPfwOZUxGoUxcreDFj3IB2x2gSvp63BDk/8sbRjLtt3O09c4PZx
         DaNHuGj/trZohLpt311Ul1e0lCWuw2R+RIaIrBVCAMwSxhpzum+MvSAYIYyHRqlJzrRU
         ZyvaYxAqIsEEN/LjDQMbihfdoTfRf/XkEValpVt7WRbcN5+vDXTuvm7ZGReNx81nH/Ep
         n+KA==
X-Gm-Message-State: ANoB5pnwZPwS54t1l0KWgsz6fAs60dhH/W0MTZgDyeZaw2Qea3gGe3Ck
        zlx5cH38WtO/NxQzsSWh4ZJ9MQ==
X-Google-Smtp-Source: AA0mqf4h7uhYKeeaEd4CL1ukDcn287yUwTC3NimzxXhpwcJi51og7aL4TE0nKoepn9D9ljldF7tqEA==
X-Received: by 2002:a05:622a:260d:b0:3a5:829a:7e92 with SMTP id ci13-20020a05622a260d00b003a5829a7e92mr51804046qtb.528.1670000909654;
        Fri, 02 Dec 2022 09:08:29 -0800 (PST)
Received: from [192.168.1.31] (d-216-10-177-134.nh.cpe.atlanticbb.net. [216.10.177.134])
        by smtp.gmail.com with ESMTPSA id de7-20020a05620a370700b006b615cd8c13sm5895455qkb.106.2022.12.02.09.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 09:08:29 -0800 (PST)
Message-ID: <8d146099-a12a-c5a1-4829-dec95497fdca@google.com>
Date:   Fri, 2 Dec 2022 12:08:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH 14/31] sched_ext: Implement BPF extensible scheduler class
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-15-tj@kernel.org>
From:   Barret Rhoden <brho@google.com>
In-Reply-To: <20221130082313.3241517-15-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi -

On 11/30/22 03:22, Tejun Heo wrote:
[...]
> +static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
> +			       struct scx_dispatch_q *dsq)
> +{
> +	struct scx_rq *scx_rq = &rq->scx;
> +	struct task_struct *p;
> +	struct rq *task_rq;
> +	bool moved = false;
> +retry:
> +	if (list_empty(&dsq->fifo))
> +		return false;
> +
> +	raw_spin_lock(&dsq->lock);
> +	list_for_each_entry(p, &dsq->fifo, scx.dsq_node) {
> +		task_rq = task_rq(p);
> +		if (rq == task_rq)
> +			goto this_rq;
> +		if (likely(rq->online) && !is_migration_disabled(p) &&
> +		    cpumask_test_cpu(cpu_of(rq), p->cpus_ptr))
> +			goto remote_rq;
> +	}
> +	raw_spin_unlock(&dsq->lock);
> +	return false;
> +
> +this_rq:
> +	/* @dsq is locked and @p is on this rq */
> +	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
> +	list_move_tail(&p->scx.dsq_node, &scx_rq->local_dsq.fifo);
> +	dsq->nr--;
> +	scx_rq->local_dsq.nr++;
> +	p->scx.dsq = &scx_rq->local_dsq;
> +	raw_spin_unlock(&dsq->lock);
> +	return true;
> +
> +remote_rq:
> +#ifdef CONFIG_SMP
> +	/*
> +	 * @dsq is locked and @p is on a remote rq. @p is currently protected by
> +	 * @dsq->lock. We want to pull @p to @rq but may deadlock if we grab
> +	 * @task_rq while holding @dsq and @rq locks. As dequeue can't drop the
> +	 * rq lock or fail, do a little dancing from our side. See
> +	 * move_task_to_local_dsq().
> +	 */
> +	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
> +	list_del_init(&p->scx.dsq_node);
> +	dsq->nr--;
> +	p->scx.holding_cpu = raw_smp_processor_id();
> +	raw_spin_unlock(&dsq->lock);
> +
> +	rq_unpin_lock(rq, rf);
> +	double_lock_balance(rq, task_rq);
> +	rq_repin_lock(rq, rf);
> +
> +	moved = move_task_to_local_dsq(rq, p);

you might be able to avoid the double_lock_balance() by using 
move_queued_task(), which internally hands off the old rq lock and 
returns with the new rq lock.

the pattern for consume_dispatch_q() would be something like:

- kfunc from bpf, with this_rq lock held
- notice p isn't on this_rq, goto remote_rq:
- do sched_ext accounting, like the this_rq->dsq->nr--
- unlock this_rq
- p_rq = task_rq_lock(p)
- double_check p->rq didn't change to this_rq during that unlock
- new_rq = move_queued_task(p_rq, rf, p, new_cpu)
- do sched_ext accounting like new_rq->dsq->nr++
- unlock new_rq
- relock the original this_rq
- return to bpf

you still end up grabbing both locks, but just not at the same time.

plus, task_rq_lock() takes the guesswork out of whether you're getting 
p's rq lock or not.  it looks like you're using the holding_cpu to 
handle the race where p moves cpus after you read task_rq(p) but before 
you lock that task_rq.  maybe you can drop the whole concept of the 
holding_cpu?

thanks,
barret


> +
> +	double_unlock_balance(rq, task_rq);
> +#endif /* CONFIG_SMP */
> +	if (likely(moved))
> +		return true;
> +	goto retry;
> +}


