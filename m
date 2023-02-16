Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C06698E96
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjBPIW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBPIW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:22:26 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA2E2686E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:22:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id mg23so1201571pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hh4/is4PFD339p+Vzvq5d2pFw4nO4v+SgFREe+8IyEg=;
        b=leRIznFw82AuY/38fwOPZ5k1ZasfpPUFPxEMdHvxjaTV/izRviWI93SVYSemn06ZiP
         iKYji5pNZw3QVORYMVDSIhgegTaTarHm/oiu7lEP3Mo2iNdYnjCd07DTEOCy5u5AmleY
         IKq8Spscrmcqf7l0pcW1VHS2Ypk/ZuGgXJvrhhQ8Z1lqmrom4/jkCaJ+6JOrBYnFEGyw
         duECIB8H2/YNxnXsouhwxE+B62wk4CEduaWNxgsEW7M2Gx4Y39NV9xr/AxF4P6JtYnAr
         Xa0edaaBhRES9c2vkUz0iSdk+IU5ig+cav5Vc8/ronq2Qr/DfXyt5viO1vCrQUdwwGst
         o41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hh4/is4PFD339p+Vzvq5d2pFw4nO4v+SgFREe+8IyEg=;
        b=ZzOWgB0DKEqy3uMh5nVlzGjknNs32fAWUfK9YuBSfWHYwKXZSZPtU/+AFtLrMYMpJB
         ltOF90gifAFf8YdyXYwICGJTQ26fR1cYnJjtDqv1V/R/SmyPx2Onel1AKe80rLRULzZ4
         0ijAN5hkdN8tEMlXSdZS6fSbnPcV+YyskAF/hPUzAZM+PeqNl1cG3yZjJYtQ2OthxsBE
         17gxFz2MWoHx4LQXiHAFhUmZqzDpPSlp5Y2P8tpBwEOpLJUmqmNjcryqnmC66m7hyULq
         xt5TbY/jA4jB3mj8ZBP0mW/T81KWOvh29CBb3coKk8FEfXlHwXASrwYtWm60x2q6duAk
         4XdQ==
X-Gm-Message-State: AO0yUKXnmPAhIrYD7rAyAcrfCl8M2Cp7K2jFxq4S2jifV867q70Z/v56
        SxVnsxoFlkjY9dmiCeacENJW20fRNMmz0TBD
X-Google-Smtp-Source: AK7set/d+zMI0EwCIMY3z/YEUs1RRSFePHgdVadW/XyJYsdqUtR/e2S9+DhFY9ivkfaYiVy4Pxy2QA==
X-Received: by 2002:a17:902:e5ce:b0:19a:f556:e386 with SMTP id u14-20020a170902e5ce00b0019af556e386mr797120plf.0.1676535723190;
        Thu, 16 Feb 2023 00:22:03 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b0018099c9618esm673838pla.231.2023.02.16.00.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 00:22:02 -0800 (PST)
Message-ID: <767893ef-f8c2-c478-f1a0-e785bbf2da09@bytedance.com>
Date:   Thu, 16 Feb 2023 16:21:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH 0/2] handle memoryless nodes more appropriately
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        rppt@kernel.org, willy@infradead.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
References: <20230215152412.13368-1-zhengqi.arch@bytedance.com>
 <Y+0KKnN8BU6ky6oP@dhcp22.suse.cz>
 <3426457c-99bf-9f7c-f663-c29474d9fa73@bytedance.com>
 <Y+3gb/blCDJnQ0Ik@dhcp22.suse.cz>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Y+3gb/blCDJnQ0Ik@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/16 15:51, Michal Hocko wrote:
> On Thu 16-02-23 07:11:19, Qi Zheng wrote:
>>
>>
>> On 2023/2/16 00:36, Michal Hocko wrote:
>>> On Wed 15-02-23 23:24:10, Qi Zheng wrote:
>>>> Hi all,
>>>>
>>>> Currently, in the process of initialization or offline memory, memoryless
>>>> nodes will still be built into the fallback list of itself or other nodes.
>>>>
>>>> This is not what we expected, so this patch series removes memoryless
>>>> nodes from the fallback list entirely.
>>>>
>>>> Comments and suggestions are welcome.
>>
>> Hi Michal,
>>
>>>
>>> This is a tricky area full of surprises and it is really easy to
>>
>> Would you mind giving an example of a "new problem"?
> 
> The initialization is spread over several places and it is quite easy to
> introduce bugs because it is hard to review this area. Been there done
> that. Just look into the git log.

I understand your concern, but should we therefore reject all revisions
to this?

> 
>>> introduce new problems. What kind of problem/issue are you trying to
>>> solve/handle by these changes?
>>
>> IIUC, I think there are two reasons:
>>
>> Firstly, as mentioned in commit message, the memoryless node has no
>> memory to allocate (If it can be allocated, it may also cause the panic
>> I mentioned in [1]), so we should not continue to traverse it when
>> allocating memory at runtime, which will have a certain overhead.
> 
> Sure that is not the most optimal implementation but does this matter in
> practice? Can you observe any actual measurable performance penalty?

No, and the original reason for noticing this place was the panic I
mentioned in [1] (< NODE_MIN_SIZE). And if we had handled the memoryless 
node's zonelist correctly before, we wouldn't have had that panic at
all.

> Currently we are just sacrificing some tiny performance for a
> simplicity.
Hmm, I don't think my modification complicates the code.

>   
>> Secondly, from the perspective of semantic correctness, why do we remove
>> the memoryless node from the fallback list of other normal nodes
>> (N_MEMORY), but not from its own fallback list (PATCH[1/2])? Why should
>> an upcoming memoryless node continue exist in the fallback list of
>> itself and other normal nodes (PATCH[2/2])?
> 
> I am not sure I follow. What is the semantic correctness issue?

Sorry for the ambiguity, what I meant was that memoryless nodes should
never have been built into any fallback list, not just for performance
optimizations.

> 

-- 
Thanks,
Qi
