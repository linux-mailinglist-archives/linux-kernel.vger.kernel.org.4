Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5D0737CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjFUHhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjFUHhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:37:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4317F95
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:37:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b53e1cd0ffso23467455ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687333024; x=1689925024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6UWVKtOhSNf8+Qb6s/x3NVKgbGYZ27trtRsrPVMZbc=;
        b=ajjSlZ2pVqA0Drxuy0LPBr1g6/r/CnSseKH0hEXibflbG47ydQhn6IKbtqisVrlIll
         P8aKz3R6NfKWprnRU0z7Z0892fvKw0iFl4+L/Xmn9IHD9wPj7GHeDZI3hBw8r/LKz53b
         l6NmBDTWSqayISA+lWHBQvLY1Cw3YlSOewxqvyNCHzWCbwJhch0/FecllswP3VVAJ4LQ
         fEVENBVclMWJNoHbanlDGxXE9aIMmfvHQvlR4CNoiXl9+04mRpKYFPayS/lYKCE0k9dP
         7Q2vxOei6wvcuxrCjYAQX7DB++SRDlhwKTh7tKA52w8BwrYpo0JjprDVkh+HHm0NcBp5
         xbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687333024; x=1689925024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6UWVKtOhSNf8+Qb6s/x3NVKgbGYZ27trtRsrPVMZbc=;
        b=U1X/mOTYjtegnvTgkl+VKVEWpqgSN/rN48Ude1HSQocQze3SBc9Ub0iW4FCKrhLTz7
         9ZI86ARXNVu5XE/U6NNhIflqBhkQLztg82uelvQkx9r1fR64ukUsFLJhNu6n956ENUR3
         3uvFE+Lv1J+K8s2HQP0olNL/GmSNb+LiwO44iK3QJ65x+zvLjker6jMNJif/2nX9Terz
         Kgf4aa00p68KEny7E4UH7hfp+055sxtTERge7o6qo7b3j6tb7BcsPVD1K2Mhlbjaaksv
         aWzQ9gWTWeZgDAxwbAgRbRUssRSDwkB1YiKPs7bY8Zozg2vCGK9Ml/nBSMNx2e9TTCZG
         exGA==
X-Gm-Message-State: AC+VfDxCuAnKGaFa4Se4Zb0FBClnoUYdI76qzpVIeUbJ+CG/fZweN2nC
        91jPJEWKsiqt0b0VGs47+MKp3A==
X-Google-Smtp-Source: ACHHUZ7AzJu+yamwln6Zw/qda+kLCR+13+12pD29yTJvwzi7N6r3mLLSRcnKXQ3t0c1w17RK7+dxDw==
X-Received: by 2002:a17:903:2348:b0:1ac:921c:87fc with SMTP id c8-20020a170903234800b001ac921c87fcmr13152510plh.32.1687333023741;
        Wed, 21 Jun 2023 00:37:03 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:11bb:1457:9302:1528:c8f4? ([240e:694:e21:b::2])
        by smtp.gmail.com with ESMTPSA id g16-20020a1709029f9000b001b04aee1f99sm2758852plq.228.2023.06.21.00.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 00:37:03 -0700 (PDT)
Message-ID: <0a2c3d52-a964-d987-5808-88f09515d5be@bytedance.com>
Date:   Wed, 21 Jun 2023 15:36:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] sched/fair: fix possible active balance misbehavior
To:     Miaohe Lin <linmiaohe@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20230621065331.3793767-1-linmiaohe@huawei.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230621065331.3793767-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaohe,

On 6/21/23 2:53 PM, Miaohe Lin wrote:
> In LBF_DST_PINNED case, env.dst_cpu won't be equal to this_cpu. So when
> need_active_balance() returns true, env.dst_cpu should be used to do the
> active balance stuff instead of this_cpu.

Active LB is the last resort to balance loads, which means no task
found can be moved to the local group before we actually do active lb.
So I don't think there is much difference between this cpu and the
selected new dst_cpu, as they are both in the local sched group and
the sched group is treated as a whole in point of view of balancing.

Best,
	Abel

> 
> Fixes: 88b8dac0a14c ("sched: Improve balance_cpu() to consider other cpus in its group as target of (pinned) task")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   kernel/sched/fair.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5e90e9658528..28ff831ee847 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10968,14 +10968,14 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>   			/*
>   			 * Don't kick the active_load_balance_cpu_stop,
>   			 * if the curr task on busiest CPU can't be
> -			 * moved to this_cpu:
> +			 * moved to env.dst_cpu:
>   			 */
> -			if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
> +			if (!cpumask_test_cpu(env.dst_cpu, busiest->curr->cpus_ptr)) {
>   				raw_spin_rq_unlock_irqrestore(busiest, flags);
>   				goto out_one_pinned;
>   			}
>   
> -			/* Record that we found at least one task that could run on this_cpu */
> +			/* Record that we found at least one task that could run on env.dst_cpu */
>   			env.flags &= ~LBF_ALL_PINNED;
>   
>   			/*
> @@ -10985,7 +10985,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>   			 */
>   			if (!busiest->active_balance) {
>   				busiest->active_balance = 1;
> -				busiest->push_cpu = this_cpu;
> +				busiest->push_cpu = env.dst_cpu;
>   				active_balance = 1;
>   			}
>   			raw_spin_rq_unlock_irqrestore(busiest, flags);
