Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F736D17BD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCaGrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCaGrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:47:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2166C10F6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:47:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ew6so85717642edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680245228; x=1682837228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jua4gde8du/TNpJ/ggqcjgKQp6GcI0FDmy/rSVOi32s=;
        b=NxEF3sYvh1iIM5RIATjDcILbq1foy1eGmaSEMRyr1IUhrIR67C+d2kIl2JNuL7ZGHF
         lEi46w9nGSGORYDZjZ7AHi72saYCISE5nfM/pSAv2M7bukwAoL3Q1lU9c3jPNQo/kTOS
         4qZTDP/wo2qU5TKnAs68YD8kZTk9A29W3QR1saT875LRiVpgiMS5COKsYYXSZ9SzYN5K
         PXuZyAy3ZEB07qAGrzi3XfPnfZhkKlwJi+tEbQWqAh9UmPIVGCuxJALqFOwlzm0nCiNy
         J50EymvdjXSL5NIOBkf+NKnkSZnvgsuVbuNB8XEh66Ec9n++sQGlE0s7M5tWiRptqyII
         EXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680245228; x=1682837228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jua4gde8du/TNpJ/ggqcjgKQp6GcI0FDmy/rSVOi32s=;
        b=PwLbMmVPWoDJEw2G7iaQNccgyXIa+XHwX1PMxbguhEEhaI55BDDa2qIPV/Ib7MkqSq
         g1pmRVFUDE1ECZEd+hwW+rHkP2GgT1dre+rNYFfxJGQxC1tfYXJjuksx9H16SINQ5zkH
         mET+9JhD6tS5OLp1rdE2tUxx+pUgyxHUrDCQqf0e/+3UJscTI5m6ldWZQY3f/xe/S7T8
         uNYm6xDr2oAKjRW86lTw6JDzyDFslFhPFyNgnQ06rTPdCfUPOn+6gKEIip/KAqI4IgJ5
         CaYu128UpxpoNKv0fBwevjGEqy66yxPK9BnmLzXznGfstPvARKDjQNuyQ9uoA9kXn+S1
         6x1w==
X-Gm-Message-State: AAQBX9cm/fdKIpRRXczHE14IvSNlU0SL2H2Hpw8D8skl/qM3/G7KG0zD
        LIDjszr8ShVnZP99Eeyd/QtqrL02O6guzA==
X-Google-Smtp-Source: AKy350b2Iqmv44lD93m8YIgp3BTPaucZOgE+Uv7xecc4F3v+HsnNCqRs5RdZSfBP0Lw8Hr6y9hu4dw==
X-Received: by 2002:a05:6402:2803:b0:502:e50:3358 with SMTP id h3-20020a056402280300b005020e503358mr5398408ede.3.1680245228301;
        Thu, 30 Mar 2023 23:47:08 -0700 (PDT)
Received: from [192.168.10.16] ([37.252.81.51])
        by smtp.gmail.com with ESMTPSA id d7-20020a50cd47000000b005027ecc148esm277087edj.65.2023.03.30.23.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 23:47:08 -0700 (PDT)
Message-ID: <d7354d2d-8464-2cdd-a42c-582ea518c76b@gmail.com>
Date:   Fri, 31 Mar 2023 10:47:06 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] mm: khugepaged: Fix kernel BUG in
 hpage_collapse_scan_file
Content-Language: en-US
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, himadrispandya@gmail.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        shy828301@gmail.com,
        syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com
References: <20230330155305.423051-1-ivan.orlov0322@gmail.com>
 <20230331013301.ecgkjymaf3ws6rfb@google.com>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20230331013301.ecgkjymaf3ws6rfb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/23 05:33, Zach O'Keefe wrote:

> Thanks, Ivan.
> 
> In the process of reviewing this, I starting thinking if the !shmem case was
> also susceptible to a similar race, and I *think* it might be. Unfortunately, my
> time has ran out, and I haven't been able to validate ; I'm less familiar with
> the file-side of things.
> 
> The underlying problem is race with truncation/hole-punch  under OOM condition.
> The nice do-while loop near the top of collapse_file() attempts to avoid this
> scenario by making sure enough slots are available. However, when we drop xarray
> lock, we open ourselves up to concurrent removal + slot deletion. Those slots
> then need to be allocated again -- which under OOM condition is failable.
> 
> The syzbot reproducer picks on shmem, but I think this can occur for file as
> well. If we find a hole, we unlock the xarray and call
> page_cache_sync_readahead(), which if it succeeds, IIUC, will have allocated a
> new slot in our mapping pointing to the new page. We *then* locks the page. Only
> after the page is locked are we protected from concurrent removal (Note: this is
> what provides us protection in many of the xas_store() cases ; we've held the
> slot's contained page-lock since verifying the slot exists, protecting us from
> removal / reallocation races).
> 
> Maybe I'm just low on caffeine at the end of the day, and am missing something,
> but if I had more time, I'd be looking into the file-side some more to verify.
> Apologies that hasn't occurred to me until now ; I was looking at one of your
> comments and double-checked why I *thought* we were safe.
> 
> Anyways, irrespective of that looming issues, some more notes to follow:
> 
>> The 'xas_store' call during page cache scanning can potentially
>> translate 'xas' into the error state (with the reproducer provided
>> by the syzkaller the error code is -ENOMEM). However, there are no
>> further checks after the 'xas_store', and the next call of 'xas_next'
>> at the start of the scanning cycle doesn't increase the xa_index,
>> and the issue occurs.
>>
>> This patch will add the xarray state error checking after the
>> 'xas_store' and the corresponding result error code. It will
>> also add xarray state error checking via WARN_ON_ONCE macros,
>> to be sure that ENOMEM or other possible errors don't occur
>> at the places they shouldn't.
> 
> Thanks for the additions here. I think it's worthwhile providing even more
> details about the specifics of the race we are fixing and/or guarding against to
> help ppl understand how that -ENOMEM comes about if the do-while loop has
> "Ensured" we have slots available (additionally, I think that comment can be
> augmented).
> 
>> Tested via syzbot.
>>
>> Reported-by: syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com
>> Link: https://syzkaller.appspot.com/bug?id=7d6bb3760e026ece7524500fe44fb024a0e959fc
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> ---
>> V1 -> V2: Add WARN_ON_ONCE error checking and comments
>>
>>   mm/khugepaged.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 92e6f56a932d..8b6580b13339 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -55,6 +55,7 @@ enum scan_result {
>>   	SCAN_CGROUP_CHARGE_FAIL,
>>   	SCAN_TRUNCATED,
>>   	SCAN_PAGE_HAS_PRIVATE,
>> +	SCAN_STORE_FAILED,
>>   };
> 
> I'm still reluctant to add a new error code for this as this seems like quite a
> rare race that requires OOM to trigger. I'd be happier just reusing SCAN_FAIL,
> or, something we might get some millage out of later: SCAN_OOM.
> 
> Also, a reminder to update include/trace/events/huge_memory.h, if you go that
> route.
> 
>>   
>>   #define CREATE_TRACE_POINTS
>> @@ -1840,6 +1841,15 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>>   					goto xa_locked;
>>   				}
>>   				xas_store(&xas, hpage);
>> +				if (xas_error(&xas)) {
>> +					/* revert shmem_charge performed
>> +					 * in the previous condition
>> +					 */
> 
> Nit: Here, and following, I think standard convention for multiline comment is
> to have an empty first and last line, eg:
> 
>   +					/*
>   +					 * revert shmem_charge performed
>   +					 * in the previous condition
>   +					 */
> 
> Though, checkpatch.pl --strict didn't seem to care.
> 
>> +					mapping->nrpages--;
>> +					shmem_uncharge(mapping->host, 1);
>> +					result = SCAN_STORE_FAILED;
>> +					goto xa_locked;
>> +				}
>>   				nr_none++;
>>   				continue;
>>   			}
>> @@ -1992,6 +2002,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>>   
>>   		/* Finally, replace with the new page. */
>>   		xas_store(&xas, hpage);
>> +		/* We can't get an ENOMEM here (because the allocation happened before)
>> +		 * but let's check for errors (XArray implementation can be
>> +		 * changed in the future)
>> +		 */
>> +		WARN_ON_ONCE(xas_error(&xas));
> 
> Nit: it's not just that allocation happened before -- need some guarantee we've
> been protected from concurrent removal. This is what made me look at the file
> side.
> 
>>   		continue;
>>   out_unlock:
>>   		unlock_page(page);
>> @@ -2029,6 +2044,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>>   	/* Join all the small entries into a single multi-index entry */
>>   	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
>>   	xas_store(&xas, hpage);
>> +	/* Here we can't get an ENOMEM (because entries were
>> +	 * previously allocated) But let's check for errors
>> +	 * (XArray implementation can be changed in the future)
>> +	 */
>> +	WARN_ON_ONCE(xas_error(&xas));
> 
> Ditto.
> 
> Apologies I won't be around to see this change through -- I'm just out of time,
> and will be shutting my computer down tomorrow for 3 months.  Sorry for the poor
> timing, for raising issues, then disappearing. Hopefully I'm wrong and the
> file-side isn't a concern.
> 
> Best,
> Zach
> 
>>   xa_locked:
>>   	xas_unlock_irq(&xas);
>>   xa_unlocked:
>> -- 
>> 2.34.1
>>

Hello, Zach! Thank you very much for the detailed review! I thought that 
locking is our guarantee to not get an -ENOMEM, but I didn't have the 
deep understanding of the problem's cause, due to the fact I'm just 
starting my memory management journey :) In any case, I will do a 
research about this problem, and hopefully after you get out of the 
vacation you will see a new patch fully fixes this problem. Have a nice 
vacation! Thanks again!
