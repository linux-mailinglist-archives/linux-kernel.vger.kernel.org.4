Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017F96A5433
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjB1IOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjB1IOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:14:02 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1470244A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:14:01 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id w23so9573946qtn.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=gkey;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXRdhCEXMlGB5lNHF9//ZdA+y9hcVbYZTUEjsU0VNGc=;
        b=VxjSSyvpsYSpozIxQT3aunHdhIMiXppCH6rmM5eswS8duzm1uyHQDE4TXyDRel3meh
         8SAU/89YXPJG0cOP+P77/6Q+PLfVnHGS0kQUQV4j/aE6cwcZYuQHr8jnY4Tk20t3Eg1q
         1ra+7vqix9ZZ2BonAXmoBwe2eivo1gmaYjYx2pcI1r1tvg9EPjrPri43mgOX9LzB5WqC
         6YoFnf5+29hVwMSI3y0Ea1WHCALA4z35bzPbFObbxvStKiHC3EJW931B5iGm0v8vismU
         jaPVcM5EYeV/8FJSk684bAV7GehZ5cPuJBxzk9Jn+VknSwKzmzb1Pf5mE1hfLFEOx6Zp
         OdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXRdhCEXMlGB5lNHF9//ZdA+y9hcVbYZTUEjsU0VNGc=;
        b=YUt0MIBfQiX1GbD4n6KC/jLoDx3rGW5vNbCkrRhN+Cvk9qZ1pMO/mO9I3OpaiE8xOF
         /SzEVvAge8Oq8sFYiaxrAsXf6eCj5tx2PjArm4LuFdXXZ1PpCouUzvuENI4hjtgU7XoQ
         tUQf/78sV9s5jx/hFADh//RS9dL/UAGvSJHhE8iXnxsBG3fufO5WumlQipvaJLu0PP3G
         9bMtTXEE5Osfbbgr8P02p0xRUXJGOimExa20m2h1QFOpu8ajBl0uqJY4U746OlNZQorE
         kRMCDzwYqhoo+7nJT7m1lKXL3REXqxR2F3QzttHfCi8mCBJgVcs5CtaRTjL7QGXtl8AS
         x95w==
X-Gm-Message-State: AO0yUKVFEM1fLebV2Q340/me9rssEyNPCSdtvieWzpmM0ZD2t9QcRUFC
        8zhpoH2xsEzKO3+AySK6NPZvgQ==
X-Google-Smtp-Source: AK7set+Xe/rkULJxJfT7b2ySpgC3hYW/tKQFegSGP+xjrKOakrGjPPw2PrX6H4zosJ2dOdQZME2RRw==
X-Received: by 2002:ac8:580f:0:b0:3bf:aa66:b9e2 with SMTP id g15-20020ac8580f000000b003bfaa66b9e2mr3851561qtg.37.1677572040971;
        Tue, 28 Feb 2023 00:14:00 -0800 (PST)
Received: from ghost.leviathan.sladewatkins.net (pool-100-4-177-83.albyny.fios.verizon.net. [100.4.177.83])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8764e000000b003b86b962030sm6058952qtr.72.2023.02.28.00.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 00:14:00 -0800 (PST)
From:   "Slade's Kernel Patch Bot" <slade@sladewatkins.com>
X-Google-Original-From: Slade's Kernel Patch Bot <KernelPatchBot@sladewatkins.net>
Message-ID: <61c530c1-16fd-e002-2d93-456d913f2925@sladewatkins.net>
Date:   Tue, 28 Feb 2023 03:13:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] sched: Fix rq nr_uninterruptible count
Content-Language: en-US
To:     zhenggy <zhenggy@chinatelecom.cn>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Slade Watkins <srw@sladewatkins.net>
References: <9b271641-ea59-daa5-333c-1dd1f02cdb52@chinatelecom.cn>
In-Reply-To: <9b271641-ea59-daa5-333c-1dd1f02cdb52@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 02:08, zhenggy wrote:
> When an uninterrptable task is queue to a differect cpu as where
> it is dequeued, the rq nr_uninterruptible will be incorrent, so
> fix it.
> 
> Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>
> ---
>  kernel/sched/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 25b582b..cd5ef6e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4068,6 +4068,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
>  {
>  	unsigned long flags;
>  	int cpu, success = 0;
> +	struct rq *src_rq, *dst_rq;
> 
>  	preempt_disable();
>  	if (p == current) {
> @@ -4205,6 +4206,16 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
>  			atomic_dec(&task_rq(p)->nr_iowait);
>  		}
> 
> +		if (p->sched_contributes_to_load) {
> +			src_rq = cpu_rq(task_cpu(p));
> +			dst_rq = cpu_rq(cpu);
> +
> +			double_rq_lock(src_rq, dst_rq);
> +			src_rq->nr_uninterruptible--;
> +			dst_rq->nr_uninterruptible++;
> +			double_rq_unlock(src_rq, dst_rq);
> +		}
> +
>  		wake_flags |= WF_MIGRATED;
>  		psi_ttwu_dequeue(p);
>  		set_task_cpu(p, cpu);

This is Slade's kernel patch bot. When scanning his mailbox, I came across this message, which appears to have an odd format for its text ("text/plain; charset=gbk"). Emailed patches should be in ASCII or UTF-8 encoding. If you're using an email client, make sure it's configured to use either of the two formats.

You can learn more in the kernel's documentation here: https://www.kernel.org/doc/html/latest/process/email-clients.html

If you believe this is an error, please address a message to Slade Watkins <srw@sladewatkins.net>.

Thank you,
-- Slade's kernel patch bot
