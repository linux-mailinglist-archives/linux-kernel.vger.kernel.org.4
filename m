Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B31B6F861D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjEEPqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjEEPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:46:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F4816097;
        Fri,  5 May 2023 08:46:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-64115e652eeso20656998b3a.0;
        Fri, 05 May 2023 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683301565; x=1685893565;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14XV5Ll65TOApPPeoQLTwgb99K7woaMphSjWr5nwqL0=;
        b=dEFGTEXubye+Kebcakt9ySML0/ViMX0kAK0i0JB8BNXCG68HT7MXaKjwIwrcfpiREY
         ekKSopDtQHkkjVLiHgNbP0Ivn5Gv7Q++qsYz8+szcxNYA1Ckc9f8/pJWSiylf4ksdfbV
         lvHvt+x2BSq+/arN9f5IV/5sVHpK6nGvVGD9sG/Zw8KqZmlz/Rg89nj9wl/rBCIuU9Qo
         palpZYvYcUlJRVQa2M4J4OxqHbWyk51bzOP5sLyJO7dfHQqAisZ9rKKPZUFIzBrFIMsW
         KUFXVdiuouh3stEV4r3N7ipwjDIAprdo2w4Wx4n9t0Q/jrMraN/yLu7FYe/uxoXA5wZA
         hdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683301565; x=1685893565;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=14XV5Ll65TOApPPeoQLTwgb99K7woaMphSjWr5nwqL0=;
        b=ZHoAtJWkXParsJIpEI0BFb/FP05NhdAn97xnVfHFBLjtC9yz85X0RA+kWrzEW1VkEp
         V9FSIF0uz8SCBPK7otWFwHA6rBuxkZBVlLcZCOeg2tKpsC9mEQ3lzvxVtDRG2c0bYY0e
         EdljISNjqzIECQ7SNosLx8jF6n/uDr9BCS8Bbr0MAMQEweeuYGnukhEmTxzvUI4wFLVL
         DqJL5NRxwjvdIOPPBI7bVAemERB4gfusZYJ6HtDBYEOq6PThKwzcf/EKRnu1AuipTVtl
         jRoj+PC94hjZ7udplaFzyIW2HRdnU5eFXKMg+1zZC5lU+43XqjNLPr7utTiP3uUx5zCA
         XgPA==
X-Gm-Message-State: AC+VfDyNyeER+h7Q2vypYkEVAqFr6NX6W9dmJF2SuOlqXlQISTLmbmg/
        IY2KWHnfwZowg8umZ9tdA4o=
X-Google-Smtp-Source: ACHHUZ60IvK6iB/d/fxfnRozqHgaFRsFR1B6l4caTbh7weLnGyVxRIX7cJR6k4/JBKNJNIEXid/j/g==
X-Received: by 2002:a05:6a20:258e:b0:f0:3fc4:744f with SMTP id k14-20020a056a20258e00b000f03fc4744fmr2720340pzd.8.1683301564611;
        Fri, 05 May 2023 08:46:04 -0700 (PDT)
Received: from [10.200.10.82] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id m6-20020aa79006000000b00640e12b6464sm1837486pfo.178.2023.05.05.08.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 08:46:04 -0700 (PDT)
Message-ID: <dbba1dda-4117-909e-4fb5-c6a6bc4fdb4e@gmail.com>
Date:   Fri, 5 May 2023 23:45:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] maple_tree: Make maple state reusable after
 mas_empty_area()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230504175509.2195838-1-Liam.Howlett@oracle.com>
 <4912002a-4fa8-c1c0-a8c4-690b6dd76449@gmail.com>
 <20230505131620.2o2cv5bj6jxwlztz@revolver>
From:   Peng Zhang <perlyzhang@gmail.com>
Cc:     Michael Keyes <mgkeyes@vigovproductions.net>,
        Stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Tad <support@spotco.us>
In-Reply-To: <20230505131620.2o2cv5bj6jxwlztz@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/5 21:16, Liam R. Howlett 写道:
> * Peng Zhang <perlyzhang@gmail.com> [230504 23:23]:
>>
>>
>> 在 2023/5/5 01:55, Liam R. Howlett 写道:
>>> Do not update the min and max of the maple state to the slot of the leaf
>>> node.  Leaving the min and max to the node entry allows for the maple
>>> state to be used in other operations.
>>>
>>> Users would get unexpected results from other operations on the maple
>>> state after calling the affected function.
>>>
>>> Reported-by: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
>>> Reported-by: Tad <support@spotco.us>
>>> Reported-by: Michael Keyes <mgkeyes@vigovproductions.net>
>>> Link: https://lore.kernel.org/linux-mm/32f156ba80010fd97dbaf0a0cdfc84366608624d.camel@intel.com/
>>> Link: https://lore.kernel.org/linux-mm/e6108286ac025c268964a7ead3aab9899f9bc6e9.camel@spotco.us/
>>> Fixes: Fixes: 54a611b60590 ("Maple Tree: add new data structure")
>>> Cc: <Stable@vger.kernel.org>
>>> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>>> ---
>>>    lib/maple_tree.c | 15 +--------------
>>>    1 file changed, 1 insertion(+), 14 deletions(-)
>>>
>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>> index 110a36479dced..1c4bc7a988ed3 100644
>>> --- a/lib/maple_tree.c
>>> +++ b/lib/maple_tree.c
>>> @@ -5285,10 +5285,6 @@ static inline int mas_sparse_area(struct ma_state *mas, unsigned long min,
>>>    int mas_empty_area(struct ma_state *mas, unsigned long min,
>>>    		unsigned long max, unsigned long size)
>>>    {
>>> -	unsigned char offset;
>>> -	unsigned long *pivots;
>>> -	enum maple_type mt;
>>> -
>>>    	if (min >= max)
>>>    		return -EINVAL;
>>> @@ -5311,18 +5307,9 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
>>>    	if (unlikely(mas_is_err(mas)))
>>>    		return xa_err(mas->node);
>>> -	offset = mas->offset;
>>> -	if (unlikely(offset == MAPLE_NODE_SLOTS))
>>> +	if (unlikely(mas->offset == MAPLE_NODE_SLOTS))
>>>    		return -EBUSY;
>>> -	mt = mte_node_type(mas->node);
>>> -	pivots = ma_pivots(mas_mn(mas), mt);
>>> -	if (offset)
>>> -		mas->min = pivots[offset - 1] + 1;
>>> -
>>> -	if (offset < mt_pivots[mt])
>>> -		mas->max = pivots[offset];
>>> -
>>>    	if (mas->index < mas->min)
>>>    		mas->index = mas->min;
>> This will bring new bugs, mas->index should take the maximum
>> value with mas->index and mas_safe_min(mas, pivots, offset),
>> otherwise there will be overwriting allocation.
> 
> Yes, you are right.  Both mas->index and mas->last should be set when
> the gap is found, but we aren't currently doing this.
> 
>>
>> Maybe you have forgotten, I have posted a patch[1] with the same
>> function last week. I didn't know of a place where mas was used
>> after mas_empty_area() before. That patch does not introduce new
>> bugs, but the code style has not been updated yet. If using this
>> patch will bring more conflicts with my patch set, so what should
>> I do? 😁
>>
>> [1] https://lore.kernel.org/lkml/20230425110511.11680-3-zhangpeng.00@bytedance.com/
> 
> I did forget about that, my apologies.  I really wish I had remembered
> instead of tracking down the same bug.
> 
> This has become an issue because the maple state is reused for the stack
> guard checks.
> 
> We should use your patch as you sent it first and both need revisions.
> We need this soon and it will need to be backported.
> 
> Can you please take it out of your series and make the necessary
> adjustments and send v2?  It seems isolated enough that it won't be
> difficult.  Be sure to Cc everyone I have on my patch and include the
> fixes tag so it can be backported as necessary.
> 
> In the future, I'd like mas->index/mas->last to point to the gap located
> to better align with mas_*_range() interface that will soon be added.
> It makes more sense to record the entire gap found when returning from
> the search.  I think this entire area needs modernisation/attention and
> optimisation, but for now, we should fix the bug.
Yes, alignment can be done in mas_*_range() interface. When you
post the code, I can review it. I am very interested in various
data structures especially maple tree and have read most of maple
tree code and verify its correctness. If there is work around
maple tree in the future, I can help a little. I have some small
maple tree optimization ideas, but I need some time to verify that
it works. Also, I found that many codes written in maple tree are
very complicated, and it will be difficult to maintain, so I will
make some simplifications appropriately.

Thanks,
Peng
> 
> Thanks,
> Liam
> 
> 
