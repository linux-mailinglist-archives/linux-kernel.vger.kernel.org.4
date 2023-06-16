Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B265732A27
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343674AbjFPIrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjFPIrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:47:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B3D1FEC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:47:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-25e8b2931f2so415462a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1686905242; x=1689497242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14jtraihfDQYuZKnWqtYB4vhXjv2bj/la1fKtOJoayo=;
        b=d+2AVHZsTy1E9KJtZsJvVVIyla7VzuCveJTq0FID83gOrCC7aVgr8vXcIuC65p7y+t
         HYPlVbzUYU+h2icnfnip4UwI5FywmONNI/kPFPFF9vEj5fRZqpJto8QVv7mdi7rS3MHK
         W7KuNCQkLcdtegaVBZfWp4lrUveeUdg658RxbJ34/yLhNlXG/c4U8fEcYhZo838ulhVy
         WDHZ1HXAlUmVqKGCI+DDDEw1E35RTcqsghoZOYqGHbPZgXWCsXKHUGVBCn9e1liIIzGd
         TBbUtCAJxZ1XmbK4m0E4CTseD8E3dPQoVkuN312wIj9IxC05IkX7dpdKJL2xuH6fjvRo
         VUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686905242; x=1689497242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=14jtraihfDQYuZKnWqtYB4vhXjv2bj/la1fKtOJoayo=;
        b=QERU0cacAuMBBCz7EVqTQEsUqf6TOPYhd5lKxS8ulRvgal5VB3EwbqiI0MJvTt9pfj
         blaj6efoJNVPnKZurFpc1hHgIpqVy8iD1STK8kDq8+OG7VtZnS1M9dqRhiRdvXY9NpEd
         vZIp6J0cN5/cqmYs2QVdcXUpfwp1JBd5F1+dSkDBoNlAWGAvRhqnozaaa3LRr6ftbyVn
         liAPZ1K/Uic15SKdxN9KqlXLln7Nas74mlH9zGj7Cs7OMdTuvJD0895FyMs12Ofn8XTE
         QhNjwcUPkBwAYvet1Rzj3wHYWiUiJMEOu1Q6dLY/hQqjXKAhtpjaB4kF7CgPHFV6MV68
         XPHA==
X-Gm-Message-State: AC+VfDxwFJ8M+JuY7m1gc/goQOzZPjUX9Nd1sZ/bFGDV16b6DIvNVqJB
        41+AxiM8Niu/ych9T0xErFFX9GErMJzAEods95u352c5
X-Google-Smtp-Source: ACHHUZ4mlwtlcw7qmHw9X64xtozPVzjrxFtFRk+MgSU1GT/TXSW1rB9S5VYSXnTACzY4ffxsNkgzLg==
X-Received: by 2002:a17:90b:368b:b0:258:d910:6196 with SMTP id mj11-20020a17090b368b00b00258d9106196mr1188311pjb.14.1686905242108;
        Fri, 16 Jun 2023 01:47:22 -0700 (PDT)
Received: from [10.54.24.10] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b0054fe07d2f3dsm3373691pgd.11.2023.06.16.01.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 01:47:21 -0700 (PDT)
Message-ID: <69cea432-f784-a734-f93e-50b0f897767c@shopee.com>
Date:   Fri, 16 Jun 2023 16:47:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] mm/memcontrol: add check for allocation failure in
 mem_cgroup_init()
To:     Michal Hocko <mhocko@suse.com>
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230615073226.1343-2-haifeng.xu@shopee.com>
 <ZIrLLmb+o77Wy2sY@dhcp22.suse.cz>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZIrLLmb+o77Wy2sY@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
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



On 2023/6/15 16:26, Michal Hocko wrote:
> On Thu 15-06-23 07:32:26, Haifeng Xu wrote:
>> If mem_cgroup_init() fails to allocate mem_cgroup_tree_per_node, we
>> should not try to initilaize it. Add check for this case to avoid
>> potential NULL pointer dereference.
> 
> Technically yes and it seems that all users of soft_limit_tree.rb_tree_per_node
> correctly check for NULL so this would be graceful failure handling. At
> least superficially because the feature itself would be semi-broken when
> used. But more practically this is a 24B allocation and if we fail to
> allocate that early during the boot we are screwed anyway. Would such
> a system have any chance to boot all the way to userspace? Woul any
> userspace actually work?
> 

The memory request is too small and It's unlikely to fail during early init.
If it fails, I think the system won't work.

> Is this patch motivated by a code reading or is there any actual
> practical upside of handling the error here?
>  

There is no real world problem, just from code review.

>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>  mm/memcontrol.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index c73c5fb33f65..7ebf64e48b25 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -7422,6 +7422,8 @@ static int __init mem_cgroup_init(void)
>>  		struct mem_cgroup_tree_per_node *rtpn;
>>  
>>  		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
>> +		if (!rtpn)
>> +			continue;
>>  
>>  		rtpn->rb_root = RB_ROOT;
>>  		rtpn->rb_rightmost = NULL;
>> -- 
>> 2.25.1
> 
