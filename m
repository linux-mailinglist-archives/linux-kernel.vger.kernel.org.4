Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36DB61145D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJ1OU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJ1OUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:20:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAF748E89
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:20:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p8so8494898lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8rtTsgQEQ98uqnUW/cLp215q8QkVCdpzvy4SgEkrnQ4=;
        b=Og179Q/tPfWzlgy5vkUpw+wc/4mfDHAkQmgi3+V89vSw1I1swbYLO6Yz/vbmhf3CQ/
         HlSn0hFFw+SJZBFqpiV06P2NeinwdqqB14eTw2QHB3CEawUCKuTczrX71nP4LuChjiSP
         7ssQ/IdiOCz8g2wB3CYaLW4o//zKKZ6ekrG8U5jUZlzNDtBGhhf8Z1vj+HxpzW7BN/90
         eOLBYhRg/KMXhomja8SdVkTOkoDT9or57mBda3VeTNlReo4T0wzoNc6IlufCxeTbOAJg
         4DZkS4LXCVsM8c/GF61gLVwzGzC6bXB5R/BXcuhaH+ng9pBjggDJSAw6xRnCWRv+R9DU
         zVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rtTsgQEQ98uqnUW/cLp215q8QkVCdpzvy4SgEkrnQ4=;
        b=BgtaGSVrUYbHS9pyS667OY5paRq8LBSiZxBmgWFGwlb5rp1YA3KRfLAMektcNVkuqv
         ktFzKuhIbNAZQYSgi/s8TujsI2Oa8HuAgdKIc9OaD3k9+ptaztvafvRPCEul/Akyl3ds
         awgJ6csAYTNXe5wO9SD/bHvtFXxrFoKz3iNwB//3HM8Jf9gKLMw/FAfqoRNK8GZIgwAI
         a8+N3RmPnLfp9ldeajqHuSvbQ52yKZFMyLsxYgkJUzvmSDdPFeZGZP3w0NKsfDU8XYlo
         zq5sZFZEAcFAc0I6JbWl7b3XzH+psW5Ok0aAIw82gtRAYEVkkKiatBL+1FeDwAZazg4T
         pC/g==
X-Gm-Message-State: ACrzQf3CMX3sjCCZ48fCfd5Gu5zy+0ZDoZh3HGHNr+FCWnjCORBQ4fEV
        Smk+au9BO+l2oTMW/jUjwxUhXVYTlU9bzlIZ
X-Google-Smtp-Source: AMsMyM4y+P1sjQhcJjzjQ+66DWheKSzXelagIcJ6228cTMTMEiu2nolZM6wfw2RgfBKZ/zEKGQXEmw==
X-Received: by 2002:a05:6512:6d4:b0:4a2:f89:db7d with SMTP id u20-20020a05651206d400b004a20f89db7dmr19764286lff.125.1666966820641;
        Fri, 28 Oct 2022 07:20:20 -0700 (PDT)
Received: from ?IPV6:2a02:6b8:0:107:3e85:844d:5b1d:60a? ([2a02:6b8:0:107:3e85:844d:5b1d:60a])
        by smtp.gmail.com with ESMTPSA id b3-20020ac25e83000000b004acb2adfa1fsm578823lfq.307.2022.10.28.07.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:20:20 -0700 (PDT)
Message-ID: <c6fbc75a-4e8c-05f4-c1d9-53693a7c604f@gmail.com>
Date:   Fri, 28 Oct 2022 17:20:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] x86/kasan: map shadow for percpu pages on demand
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kernel test robot <yujie.liu@intel.com>
Cc:     Seth Jenkins <sethjenkins@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
References: <864b4fbe-4462-9962-7afd-9140d5165cdb@intel.com>
 <20221027213105.4905-1-ryabinin.a.a@gmail.com>
 <3a372c25-7ce1-e931-8d7e-a2e14b82c8f0@intel.com>
Content-Language: en-US
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <3a372c25-7ce1-e931-8d7e-a2e14b82c8f0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/22 05:51, Yin, Fengwei wrote:
> Hi Andrey,
> 

>>  void __init kasan_init(void)
>>  {
>>  	int i;
>> @@ -393,9 +405,6 @@ void __init kasan_init(void)
>>  		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
>>  		shadow_cpu_entry_begin);
>>  
>> -	kasan_populate_shadow((unsigned long)shadow_cpu_entry_begin,
>> -			      (unsigned long)shadow_cpu_entry_end, 0);
>> -
> There will be address in the range (shadow_cpu_entry_begin, shadow_cpu_entry_end)
> which has no KASAN shadow mapping populated after the patch. Not sure whether
> it could be a problem. Thanks.
> 


This shouldn't be a problem. It's vital to have shadow *only* for addresses with mapped memory.
Shadow address accessed only if the address itself accessed. So the difference between not having shadow
for address with no mapping vs having it, is whether we crash on access to KASAN shadow or crash few
instructions later on access to the address itself.
