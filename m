Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96C96E9CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjDTT4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDTT4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:56:20 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B119B1719
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:56:17 -0700 (PDT)
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B754B3F32E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682020574;
        bh=KY8pyxGxgnrPoci4ERroAXYkodzTSNhkVt9Dm2/aozU=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=I9Vw3yxW2OHnKEaXR1b2E97GskUAuGI/i/3VWY3pQxOW5Jta1AhPqGAae9Jj/icxV
         jrsiMDDME1ZamHFH0vKILVPc/9S6wdHzWcMDzD3Kj5a9aad/AFuAZmQkUcAfXgV53J
         yHDmiYzDLUjQJKbY3cuqcI6VLGDjKBt2k417vD8gsmh3Yovf1vuRrMRem2sfAuE9kl
         aMVzRM4/5YZo5ALLlCUalp1UMPj9vBue1b1jJ95LdtUenaf6RU1huSlxmJFkxofVvl
         Y+C10M+tZuCkczh51SDt0HtL8rclaYJzp7hF7LnBXBXZOotM1keBdTaKiilDGw3cfQ
         P+VlL5cRCXP2Q==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4edb884cd9dso437130e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682020574; x=1684612574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KY8pyxGxgnrPoci4ERroAXYkodzTSNhkVt9Dm2/aozU=;
        b=GVBHg2rocXZeMy1v51ATyI9dlsvq+fDomonEWYQWI29jgxFzY9QyyGaTSgRDYrdb4p
         jSwtspfgL1h1KU0A1+iG2u4WWf4dZVILmQimYSfqirslpHH43IdFcIBctrqDZe/bk26w
         U4FyCGC9IOZsCb6QcRpkNGKVAgyYmLPXKVQgPfVSUYiNvhSqJwjuQXtMjJjTv0k8pWAb
         eQRPiBfK9TnflrXx9FSSZtyvitDoSHGm/AQLeZidrXdHywHXS5TwmyA0AC08ybcHOJcs
         GIcMgz7Fa7dyffOMl0BxP1EkDN67uu0LbsMrlvOB9ThFwWNHiPNng6bM+ONYkxHSvhyn
         TDhw==
X-Gm-Message-State: AAQBX9e2SWloDvtNG5Li8IBog16Eto0MaXKy64YYPZH8TNy+GWTTM73t
        KMZttGu+DMo9oiE0J8lzOF7KN5qPc0MKyxwY0y6VfBvTSoEwy4swm+8qJZFd3oH2ZRAgaLurMhr
        ci4ay9AU8WXIrMNRe/IIS/K2yJEESGyh+wJOoJcSXgA==
X-Received: by 2002:a2e:8186:0:b0:2a8:c520:da1d with SMTP id e6-20020a2e8186000000b002a8c520da1dmr27696ljg.29.1682020574192;
        Thu, 20 Apr 2023 12:56:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350bDLsLvp+oWYK/fyJ2cVwarlebgReTM1tn6IZNxN3QkyDz5UK7a9YKViInNF4EfwLJh3U/R7A==
X-Received: by 2002:a2e:8186:0:b0:2a8:c520:da1d with SMTP id e6-20020a2e8186000000b002a8c520da1dmr27670ljg.29.1682020573776;
        Thu, 20 Apr 2023 12:56:13 -0700 (PDT)
Received: from localhost (uk.sesame.canonical.com. [185.125.190.60])
        by smtp.gmail.com with ESMTPSA id m2-20020a2e97c2000000b00295a3a64816sm354917ljj.2.2023.04.20.12.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:56:13 -0700 (PDT)
Date:   Thu, 20 Apr 2023 21:56:11 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 28/32] sched_ext: Implement core-sched support
Message-ID: <ZEGY28sZgvEL7ssi@righiandr-XPS-13-7390>
References: <20230317213333.2174969-1-tj@kernel.org>
 <20230317213333.2174969-29-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317213333.2174969-29-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 11:33:29AM -1000, Tejun Heo wrote:
...
>  
> +static int balance_scx(struct rq *rq, struct task_struct *prev,
> +		       struct rq_flags *rf)
> +{
> +	int ret;
> +
> +	ret = balance_one(rq, prev, rf, true);
> +
> +	/*
> +	 * When core-sched is enabled, this ops.balance() call will be followed
> +	 * by put_prev_scx() and pick_task_scx() on this CPU and pick_task_scx()
> +	 * on the SMT siblings. Balance the siblings too.
> +	 */
> +	if (sched_core_enabled(rq)) {
> +		const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));

balance_scx() should be a no-op if CONFIG_SCHED_SMT is undefined or we
may get a build error here.

For example with a minimal ppc64le config (and CONFIG_SCHED_SMT off) I
can reproduce this:

 ./arch/powerpc/include/asm/smp.h:139:22: error: implicit declaration of function 'cpu_smt_mask'; did you mean 'cpu_cpu_mask'? [-Werror=implicit-function-declaration]

So maybe have something like this (or similar):

#ifdef CONFIG_SCHED_SMT
...
#else
static inline int balance_scx(struct rq *rq, struct task_struct *prev,
		       struct rq_flags *rf)
{
	return 0
}
#endif

Thanks,
-Andrea
