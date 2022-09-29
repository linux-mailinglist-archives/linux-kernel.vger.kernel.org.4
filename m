Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AFB5F0183
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiI2Xot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiI2Xon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:44:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8A32655
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=weMNaiaK5YtMIL2G69H6VPatYPNxvKo6/oNHfhmqJAs=; b=rqczntFGVo8/t0grC93B83nTLi
        EfKaeZpTf+RMVrbIozZ6cCA7xkQRPvwe7/Npa1fQVfL6+hiS77gTHcVd5tSrNc2AEv7tG53Hyj87B
        kPtvTVv/jFN5OBL81p7nDLTeG4G+WreITj8Hg5B8V4S3Qq636t7JYKdyEHABHPobbcXILMh4EOJrk
        L4sJbTIpHXUQXWuEBsLWVgOGrNGLONIRK7cyJz+elKUvLVUl1dhs/cne7coR/V9Jik2HG4gBySlKB
        fUtS0u+mvNm5EQ5T8VI2XGKTtjvbMQdRODY5Y6lDfeteP7z0XQ05uBp7R3EaPoZiCHlG+vr9vIKWe
        4CPCdjaA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oe3CT-006498-Vb; Thu, 29 Sep 2022 23:44:22 +0000
Message-ID: <8b744304-a1a2-f75e-dfc5-784961825a7a@infradead.org>
Date:   Thu, 29 Sep 2022 16:44:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] x86/mm/tlb: fix error word 'clleared' to 'cleared'
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>
Cc:     Xin Hao <xhao@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220929091040.45390-1-xhao@linux.alibaba.com>
 <651530a9-2dc1-c781-a1b5-1e712684f94d@infradead.org>
 <FD6D2974-13DD-4FE6-B175-E0BBF5306BD8@vmware.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <FD6D2974-13DD-4FE6-B175-E0BBF5306BD8@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/22 15:58, Nadav Amit wrote:
> On Sep 29, 2022, at 2:36 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> ⚠ External Email
>>
>> Hi--
>>
>> I would say let's fix the sentence grammar, but I don't know
>> what "cleared set" means.
>>
>>
>> On 9/29/22 02:10, Xin Hao wrote:
>>> Just correct the wrong word 'clleared' to 'cleared'
>>>
>>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>>> ---
>>> arch/x86/include/asm/tlbflush.h | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
>>> index cda3118f3b27..c80a15ef0cbc 100644
>>> --- a/arch/x86/include/asm/tlbflush.h
>>> +++ b/arch/x86/include/asm/tlbflush.h
>>> @@ -291,7 +291,7 @@ static inline bool pte_flags_need_flush(unsigned long oldflags,
>>>              diff &= ~_PAGE_ACCESSED;
>>>
>>>      /*
>>> -      * Did any of the 'flush_on_clear' flags was clleared set from between
>>> +      * Did any of the 'flush_on_clear' flags was cleared set from between
>>
>> It should be more like:
>>
>>         * Were any of the 'flush_on_clear' flags changed between
>>
>> X86 people, does that make sense to you?
> 
> It’s not a test whether the flags are changed, but whether they are cleared.
> 
> Let’s see if we can make it clearer with shorter sentences. How about:
> “Consider the ‘flush_on_clear’ flags that are set on ‘oldflags’; Flush if
> any of these flags is cleared on ’newflags’”.
> 

Sounds good. Thanks for your help.

-- 
~Randy
