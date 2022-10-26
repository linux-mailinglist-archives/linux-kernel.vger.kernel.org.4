Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F4660E265
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbiJZNon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiJZNoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:44:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A8EF20
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:44:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r6-20020a1c4406000000b003cf4d389c41so568362wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OyA2qrkg2v5gkKnTd58IzjBTBTzDkYj25MMbNU3XjYc=;
        b=PYo5iL75nUpNGpmxlciuKA348rtZZuLdjrL1B4w+c7/EPMYhKKgUhijwgww3YySE38
         fwxmJXw9uKBZbl+Ax/lNSAXWVp1S/spgRhHvw4NUox0VME97nISx2q9j0xN1GWLOvT22
         wP8HSDeUg6/09OGyeoHV0ps4aBM9iTgeurbT2K8YX1l0/uluh/lZnuyuGKbV1vZLQvbW
         cjBpPW3McN7Qsz2xZi15FN3egWorioScfwIC/+2sOytrGGkk0Fb6YQOwcvkBKXg0P6ay
         W+y1pFgdhVGWSER+WAJNCTSNeQVIXyAGqkVlJYO91eYxiT2tkYYw2C/plJ3aFgGhoj76
         m3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyA2qrkg2v5gkKnTd58IzjBTBTzDkYj25MMbNU3XjYc=;
        b=3gaP/s+27Fv5+49vxRrshZ3Z6yrbe4wgn0ok+/jdX5eU73rAbg+W89e8ArxEBz2nRa
         WNG1DDAfMi65GMgck91BH20k//MP4m8Khwpgkv2B+yUIvAErzb4X/I3v2o/nxx/ucSqC
         bvJO8ec2f1rTsB7LPJz//2X+HtQ8f3Vskk5jikAgeCzXWF4STKne1qkH6KL/pWHM5nE4
         IcfHokS5Z6K2o83KmVRJEIvz0e3rwfFbOQVYbqvFKL+jS41ApJDBtogR9bbrBPV+S4/H
         7jlzNJrWr71ZDMxSLNVjiTtQ0uWpb9Hh6DFZMivX74TgZldn7yBOaa4EWKUWegkSf0jg
         f1Mw==
X-Gm-Message-State: ACrzQf2knwuK5AnTHU2t3UkWPSETmcpMh2pZqRoLUNcDS4CV3Za/QZjP
        qgsuANlP9mainx9x0XbXZhg6WgAXRklZom7f
X-Google-Smtp-Source: AMsMyM68ArWQVEvwrzZgCqaiRtXg0TuUH5ba+A9oWWptJ1v9Fv5Od9sxwjpzL9nWVfIweRuZps4fWA==
X-Received: by 2002:a05:600c:5252:b0:3c6:f478:96db with SMTP id fc18-20020a05600c525200b003c6f47896dbmr2595614wmb.116.1666791868141;
        Wed, 26 Oct 2022 06:44:28 -0700 (PDT)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c08a400b003c65c9a36dfsm1752806wmp.48.2022.10.26.06.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 06:44:27 -0700 (PDT)
Message-ID: <3eb9b612-e765-7ad0-aed8-a50e28677e9c@linaro.org>
Date:   Wed, 26 Oct 2022 15:44:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH V13 4/4] LoongArch: Enable
 ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>, Guo Ren <guoren@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>
References: <20221024070105.306280-1-chenhuacai@loongson.cn>
 <20221024070105.306280-5-chenhuacai@loongson.cn>
 <CAJF2gTSN3zzvgAdiM8rYc3EGFxR4JJnHSh12mvsfUOQsqRRvkg@mail.gmail.com>
 <CAAhV-H40fcUW3jwGZXpPNjbpizXb85zytCpKGHvEGwoRpG3c0Q@mail.gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAAhV-H40fcUW3jwGZXpPNjbpizXb85zytCpKGHvEGwoRpG3c0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 26/10/22 14:59, Huacai Chen wrote:
> On Mon, Oct 24, 2022 at 4:04 PM Guo Ren <guoren@kernel.org> wrote:
>> On Mon, Oct 24, 2022 at 3:05 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>>>
>>> From: Feiyang Chen <chenfeiyang@loongson.cn>
>>>
>>> The feature of minimizing overhead of struct page associated with each
>>> HugeTLB page is implemented on x86_64. However, the infrastructure of
>>> this feature is already there, so just select ARCH_WANT_HUGETLB_PAGE_
>>> OPTIMIZE_VMEMMAP is enough to enable this feature for LoongArch.
>>>
>>> To avoid the following build error on LoongArch we should include linux/
>>> static_key.h in page-flags.h. This is straightforward but the build
>>> error is implicitly a LoongArch-specific problem, because ARM64 and X86
>>> have already include static_key.h from their arch-specific core headers.

>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>>> index 0b0ae5084e60..1aafdc73e399 100644
>>> --- a/include/linux/page-flags.h
>>> +++ b/include/linux/page-flags.h
>>> @@ -9,6 +9,7 @@
>>>   #include <linux/types.h>
>>>   #include <linux/bug.h>
>>>   #include <linux/mmdebug.h>
>>> +#include <linux/static_key.h>
>> Em... riscv needn't this.

Would guarding the header suffice and make riscv OK with this patch?

  #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
  #include <linux/static_key.h>
  #endif

> I found that after 36d4b36b69590fed99356a4426c940a25 (" lib/nodemask:
> inline next_node_in() and node_random()"), build errors have gone. But
> I think this is just an accident. Because that commit adds random.h
> inclusion in nodemask.h, then asm-offsets.c --> sched.h --> nodemask.h
> --> random.h --> once.h --> jump_label.h. If one day this chain is
> adjusted, then build errors come again.
> 
> On the other hand, page-flags.h is obviously using some static_key
> macros, including static_key.h is straightforward for building.
> 
> Huacai
