Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376BA7501D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjGLIjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjGLIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:39:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC41FD8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:39:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6686a05bc66so3956290b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689151153; x=1691743153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zt4C+fSx4eQCFszlz/rLS6LMrT/IEricrnc1zF5EyqI=;
        b=a4snYDwdw6ASu6rDZhN8YRg0BLT3cPZm9UTnrFRByhbsfvRMLYeufF9gfDHGQBq5lc
         evCgn8bWYwwZBXnHWkT+zM3A68ILIHvnA4qdJbO9UvLuRMS3gx5Bh2UEcumc0LrDnsR+
         8EQDRa15VfT3N+x1x9+bgVoQoZzES3wrN8XT93JUXrYasdK+Ghf2/T3cO+IclDnshDtG
         mWTtXhSnVkULos1GeQrnevST6MRDTdeKSWO23SmNkeQV90OJlS2idW3CNTXumJP0U0Yw
         a0ffYfNuADjtWfAmFD1aentSf3v5+lasHki6PUUEh15mtoc/i+iquAiGTZcNpm7xyNpZ
         kBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689151153; x=1691743153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zt4C+fSx4eQCFszlz/rLS6LMrT/IEricrnc1zF5EyqI=;
        b=h4vSQXdosY/wbRo+wo4ULDqqx5XjQvAFl75Vx6TW9SvhlHMyufsUhQEo3hkwsW7jh+
         JJUGgvh0jme5R3p2r7LienNGqf5d8hcXJoplU7nbVEWqC+eWQujlhV55nN3Cv6lhygm9
         jN2H6BoBYTyj1EkPb7Dr7nIykmnRwohD6zqpNqxMDpWeWK+9OVrGcst5Jl4bal1kCP6p
         UMgEeDP2NrMosDCwGtOP0zkZkojIhRm/VThrCTQYG2ZL979TCqTD63L89KxClJ2WUtaZ
         URGElGmmJexQFGhjq/1A+pHXp59CPXOjsqN0S9wjfed73+ERTENQ2FfDUg1XaolcObVR
         sNCg==
X-Gm-Message-State: ABy/qLbgRMsipYvLgqtjokwmDxjcRuMr/5KPERcmSHyPnLMTXu98+9zW
        /P1ueA4Oy6aL01sPqq6An67ovw==
X-Google-Smtp-Source: APBJJlFWVKPCJ0Ib9rCVQPkkiH0rIChaI+FyrhyKhqvQmTTsmFLUzaCCGGtx1WEYh80pLBqKVTkC1A==
X-Received: by 2002:a05:6a20:3ca1:b0:131:44d2:cea3 with SMTP id b33-20020a056a203ca100b0013144d2cea3mr11536581pzj.57.1689151152915;
        Wed, 12 Jul 2023 01:39:12 -0700 (PDT)
Received: from [10.94.58.170] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c19-20020aa781d3000000b006829b28b393sm3013426pfn.199.2023.07.12.01.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 01:39:11 -0700 (PDT)
Message-ID: <6111b87c-b68c-2ba9-ac60-333af67082fd@bytedance.com>
Date:   Wed, 12 Jul 2023 16:39:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/7] sched/fair: Add SHARED_RUNQ sched feature and
 skeleton calls
Content-Language: en-US
To:     David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com, clm@meta.com,
        tj@kernel.org, roman.gushchin@linux.dev, kernel-team@meta.com
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-5-void@manifault.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230710200342.358255-5-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/23 4:03 AM, David Vernet wrote:
> @@ -6467,6 +6489,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   dequeue_throttle:
>   	util_est_update(&rq->cfs, p, task_sleep);
>   	hrtick_update(rq);
> +
> +	if (sched_feat(SHARED_RUNQ))
> +		shared_runq_dequeue_task(p);

Would disabling SHARED_RUNQ causing task list nodes left
in the shared stateful runqueue?
