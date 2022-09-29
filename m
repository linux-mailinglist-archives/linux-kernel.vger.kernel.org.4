Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8385EEC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbiI2DHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiI2DHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:07:30 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA58125798
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 20:07:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b21so115642plz.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 20:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=nlPYCYLrKf8BOWfnFv9EjPVqcb26DzV5stt4LLI2CDM=;
        b=4L2laas/SoKdhxhVxl+/F8y6nx9qUa1Huiffa6tBPNFMIWEshndl3pqLfSpRqDQX/3
         IEUbaHhzvvSwyrF2h3r6e/9CqzsUMPfgDFweV7jXUEQqZzNYI6ZNcs0y1kDpQSlRntuw
         CK8MM9zPBQ+ImfI6fiCJFVD0/pnRIy6ZKaBwndKQ1ZGlJq0gSnU7t6ezF0jjR1rjnpKK
         7tmNJZT6UeI6bSuNMWaa3fz7NFKSD4I/XvZW1/WM1/aeMgYkkNASUOaRSzYhPRm5Yfil
         L420uq+cr/JX02fGUPK6ss1k1OTUmO1g96WH78aI5ondO9OmAw5KWdGXuXmhsjbKIKRw
         0KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nlPYCYLrKf8BOWfnFv9EjPVqcb26DzV5stt4LLI2CDM=;
        b=BVfD5KeA1wnJp0mqu9IunwatN1RQbXiOHNImYkHG/TK6lCzrzsUYCY42u36z3i6j77
         DgOFJxmZSJpK3HuFB3rSkgdVX2AlGUNIbeUf6T3Hlgl2+eo0G+bxgJRmO5OFJFD4Ps7g
         iEPFHXsUiaGX7sePIFX0bEWxHnZBxiDIdo1ztTaqtSk7Qbq9vLU7inyqVD7LtK1lFEFG
         1+vTtDWOSJedLyxhHV4P+W2Lv2uXf+TBx/XO3kYcEWkCIEG2Ta8M7LiH4CCQa/MhyI8G
         chDMTTlLENtwTrMI/N8dIDcGMRPdrOymdKiihgMXH6O0vSD0J5F2lZPFxlkIszWv2wPy
         cRiw==
X-Gm-Message-State: ACrzQf3Px61d6gFV5Aajp/Iqc17i7QsZRJxa72FWWGOS0inR3p+7aFA0
        2G0+bV5ZeuIgub8o9v6/GOj0MQ==
X-Google-Smtp-Source: AMsMyM4LKaaEF0SWBwjnD1Ml7WKbUkhBqq+WBwyz0b04D1NRDj/GROspVOFfMIMEBWLmwBw4fHkakA==
X-Received: by 2002:a17:902:7c11:b0:178:a6ca:4850 with SMTP id x17-20020a1709027c1100b00178a6ca4850mr1213656pll.111.1664420849420;
        Wed, 28 Sep 2022 20:07:29 -0700 (PDT)
Received: from [10.4.189.225] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m10-20020a62a20a000000b0053ebafa7c42sm4820102pff.79.2022.09.28.20.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 20:07:28 -0700 (PDT)
Message-ID: <c41a3cb6-aef9-d8a9-ab0b-b9c8013ee1d8@bytedance.com>
Date:   Thu, 29 Sep 2022 11:07:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH v2] mm: use update_mmu_tlb() on the second thread
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        muchun.song@linux.dev, maobibo@loongson.cn
Cc:     chris@zankel.net, jcmvbkbc@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20220926115621.13849-1-zhengqi.arch@bytedance.com>
 <b5823e18-6139-c16e-a2df-1aa3e88927fa@redhat.com>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <b5823e18-6139-c16e-a2df-1aa3e88927fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/26 22:34, David Hildenbrand wrote:
> On 26.09.22 13:56, Qi Zheng wrote:
>> As message in commit 7df676974359 ("mm/memory.c: Update local TLB
>> if PTE entry exists") said, we should update local TLB only on the
>> second thread. So in the do_anonymous_page() here, we should use
>> update_mmu_tlb() instead of update_mmu_cache() on the second thread.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> v1: 
>> https://lore.kernel.org/lkml/20220924053239.91661-1-zhengqi.arch@bytedance.com/
>>
>> Changelog in v1 -> v2:
>>   - change the subject and commit message (David)
>>
>>   mm/memory.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 118e5f023597..9e11c783ba0e 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4122,7 +4122,7 @@ static vm_fault_t do_anonymous_page(struct 
>> vm_fault *vmf)
>>       vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>>               &vmf->ptl);
>>       if (!pte_none(*vmf->pte)) {
>> -        update_mmu_cache(vma, vmf->address, vmf->pte);
>> +        update_mmu_tlb(vma, vmf->address, vmf->pte);
>>           goto release;
>>       }
> 
> 
> Staring at 7df676974359, it indeed looks like an accidental use [nothing 
> else in that patch uses update_mmu_cache].
> 
> So it looks good to me, but a confirmation from Bibo Mao might be good.

Thanks, and Hi Bibo, any comments here? :)

> 

-- 
Thanks,
Qi
