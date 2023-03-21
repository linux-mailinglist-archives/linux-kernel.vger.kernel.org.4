Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036B36C284D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCUCly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCUClw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:41:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE5265AA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 19:41:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so3724786pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 19:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1679366511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEkJyYt73vejLSpG2+x8Ouk/b+GBlTD7f0hr6+7FBys=;
        b=EPNaKpwDedmJIHjvq//QFdMZJ1bwSI6kGwROkrd4BE2qCSHOgENUIKyNMNO3GMZm90
         peuHU4GCfLn4X/rjSkIWVJcazbUFJevTL66PwPCgHGZsU1zigewsuD5oruZvte+U141p
         Hugu8vxs1/RvD3ssusgS67w5W8cUzUmTh+FZXgAzZdJGFNrqSefGc/yaMmtv0+o9Tw7S
         TVms7IxFiSARjYd2eUlbSYruuKA+xreCtibVaikE+pn2HyW4nMQ16WTQGKZgcZiXdqem
         Bddx7U3M0hPB1Xc4DJbO3WRbsa2uWdNsqbmMnkDKyOtNsMlMfhdZ+I/mhcU1ayZvD2Ye
         AEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679366511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HEkJyYt73vejLSpG2+x8Ouk/b+GBlTD7f0hr6+7FBys=;
        b=HYpzKeTyXymBrOAKHtRytKAZbFJx8eTJ62YTSRrypY25A+/hPep0i4VFinzRYvIe76
         1UtN55Ofsg3WXtlmc0nCBJaRdivzQNAXgKnhq8hUQ4XcJ4UI1mubkiClFo4GqM/LWFJ8
         q+wYmy+XLRUg0r4KxtKAWa2NXjrmaFzmSp55W8M0i962PSOvuh437fLfa3bL7R/huxtB
         JI5ZvUIjr6l7Vg2f65hlnX5eoy/Krg/werELViD0utnM+dCjE/fF0USZOIe66JKsAg1c
         N7YSSGvYKTlWmw1gkBxQfVju8qUJucecvieyZISUCQQfR2j0V6NftJQXVsaa7XTe0Olq
         r4VA==
X-Gm-Message-State: AO0yUKWisPSR7xb+q7mAfdDj9wq/fOFWdh+YouDkY7mTg/QEXLMQIzKf
        67elRfp9NtXDrLqhpHfOkPek+A==
X-Google-Smtp-Source: AK7set+7Allahs6jz++T+GpHLmunKF6U2IvwRRyY0XJ3UBLtK8KojpT1JqDPIX/pfX8LcN/dzZJ0Rg==
X-Received: by 2002:a17:902:e195:b0:1a0:485c:a6c with SMTP id y21-20020a170902e19500b001a0485c0a6cmr602540pla.8.1679366510603;
        Mon, 20 Mar 2023 19:41:50 -0700 (PDT)
Received: from [10.54.24.141] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902bf4800b0018b025d9a40sm7341062pls.256.2023.03.20.19.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 19:41:49 -0700 (PDT)
Message-ID: <d1d0429a-0cf6-51f5-81ce-6eb0ad340540@shopee.com>
Date:   Tue, 21 Mar 2023 10:41:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [RFC] memcg, oom: clean up mem_cgroup_oom_synchronize
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, shakeelb@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230315070302.268316-1-haifeng.xu@shopee.com>
 <ZBRTV12GNtiSlOr3@dhcp22.suse.cz>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZBRTV12GNtiSlOr3@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/17 19:47, Michal Hocko wrote:
> On Wed 15-03-23 07:03:02, Haifeng Xu wrote:
>> Since commit 29ef680ae7c2 ("memcg, oom: move out_of_memory back to
>> the charge path"), only oom_kill_disable is set, oom killer will
>> be delayed to page fault path. In the charge patch, even if the
>> oom_lock in memcg can't be acquired, the oom handing can also be
>> invoked. In order to keep the behavior consistent with it, remove
>> the lock check, just leave oom_kill_disable check behind in the
>> page fault path.
> 
> I do not understand the actual problem you are trying to deal with here.
> 
>> Furthermore, the lock contender won't be scheduled out, this doesn't
>> fit the sixth description in commit fb2a6fc56be66 ("mm: memcg:
>> rework and document OOM waiting and wakeup"). So remove the explicit
>> wakeup for the lock holder.
>>
>> Fixes: fb2a6fc56be6 ("mm: memcg: rework and document OOM waiting and wakeup")
> 
> The subject mentions a clean up but the fixes tag would indicate an
> acutal fix.
> 
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>  mm/memcontrol.c | 11 ++---------
>>  1 file changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 5abffe6f8389..360fa7cf7879 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1999,7 +1999,7 @@ bool mem_cgroup_oom_synchronize(bool handle)
>>  	if (locked)
>>  		mem_cgroup_oom_notify(memcg);
>>  
>> -	if (locked && !memcg->oom_kill_disable) {
>> +	if (!memcg->oom_kill_disable) {
>>  		mem_cgroup_unmark_under_oom(memcg);
>>  		finish_wait(&memcg_oom_waitq, &owait.wait);
>>  		mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,
> 
> Now looking at the actual code I suspect you in fact want to simplify
> the logic here as mem_cgroup_oom_synchronize is only ever triggered whe
> oom_kill_disable == true because current->memcg_in_oom is never non NULL
> otherwise. So the check is indeed unnecessary. Your patch, however
> doesn't really simplify the code much. 
> 
> Did you want this instead?
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 12559c08d976..a77dc88cfa12 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1999,16 +1999,9 @@ bool mem_cgroup_oom_synchronize(bool handle)
>  	if (locked)
>  		mem_cgroup_oom_notify(memcg);
>  
> -	if (locked && !READ_ONCE(memcg->oom_kill_disable)) {
> -		mem_cgroup_unmark_under_oom(memcg);
> -		finish_wait(&memcg_oom_waitq, &owait.wait);
> -		mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,
> -					 current->memcg_oom_order);
> -	} else {
> -		schedule();
> -		mem_cgroup_unmark_under_oom(memcg);
> -		finish_wait(&memcg_oom_waitq, &owait.wait);
> -	}
> +	schedule();
> +	mem_cgroup_unmark_under_oom(memcg);
> +	finish_wait(&memcg_oom_waitq, &owait.wait);
>  
>  	if (locked) {
>  		mem_cgroup_oom_unlock(memcg);
> 

Yes, the chance that someone else disable the oom_kill_disable again in the page fault path
is quite low.

>> @@ -2010,15 +2010,8 @@ bool mem_cgroup_oom_synchronize(bool handle)
>>  		finish_wait(&memcg_oom_waitq, &owait.wait);
>>  	}
>>  
>> -	if (locked) {
>> +	if (locked)
>>  		mem_cgroup_oom_unlock(memcg);
>> -		/*
>> -		 * There is no guarantee that an OOM-lock contender
>> -		 * sees the wakeups triggered by the OOM kill
>> -		 * uncharges.  Wake any sleepers explicitly.
>> -		 */
>> -		memcg_oom_recover(memcg);
>> -	}
> 
> Hmm, so this seems unneded as well for the oom_kill_disable case as
> well. Rather than referring to fb2a6fc56be66 it would be better to
> why the explicit recovery is not really needed anymore.
> 
>>  cleanup:
>>  	current->memcg_in_oom = NULL;
>>  	css_put(&memcg->css);
> 

Thank you for your suggestion. I'll post an official patch later.
