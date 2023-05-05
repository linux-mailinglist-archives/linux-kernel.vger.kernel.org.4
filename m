Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749636F8061
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjEEJte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEEJt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:49:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8420919D4A
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 02:49:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ab032d9266so14167255ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683280141; x=1685872141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vm+Mx1O/33em24isLrPoWSjqhWN3P6cMGh6S3cQOeBs=;
        b=K5dNnmWZhIQMO7t0l+k5rLsSEpT3489zwAXuyncph4IYDcGCRFS7SwvP9jMZ4PW36U
         SCyOT0O7vkkL/y2HxA667m57oR9sqPgwyckHmW77kL/CpFPucQ6NyNi53R6QtUdkTVBO
         8+EGT4bDnngBge2dXcANe3cTx9jjjZmlclIcG4F5KzKBtuaYxpvJQL/lEUiC6Khigyzt
         X//nJHJWxpjlTY4sdyXbI8q8E1wxfWEfacGfkPIOsivV5JTEuu+Zk78lvOUiEjb/dyT2
         qj1qn1fvfKXyFZUWngDFkiXoLzZf1Nt4ge6SNkMnE7eAq53LgbwyT09PyHmswEcSosLB
         iRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683280141; x=1685872141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vm+Mx1O/33em24isLrPoWSjqhWN3P6cMGh6S3cQOeBs=;
        b=IR8R3sXs0Dx6Osot2zsLwt1jHpsqB0eAf2cpRIF/UzyTz5cWdmxsxyu+K+UXl4qutQ
         7Kvtio5a2keYpDofsuhTHLtHy1rItBFwdHpjvzF7qxfBQ7X3yTiKs7/P1yIb0pfAdYNm
         oU0DVe43lAdhEsu71j7IIbF20s5VLDdLF+ZB5SOXOzMm2NjapTfnzDjhHuFSHN2kjMHQ
         Kn+I0dZY/18bBM3L2AlQ4gF0KgkZ+gIYyRty1TemGoortWbClqBPZ3FStiTf1HynH5hu
         TyuRqnUhyujBiE6P7YHXoc4/c/+TXlcGBLcMbsSLxVqapGGwq1ub552VlnEXdc7PmdHY
         jBjw==
X-Gm-Message-State: AC+VfDzDBMLBdNA3p5PjiW+tlK9gIap+sk59XoR8ehAN9seq5F7Qw9rt
        UTDWuBYgYHfbl5DItFphHJBZtQ==
X-Google-Smtp-Source: ACHHUZ6/yA9/ssQzotlpriqTWOG++NDiq7TV+FLq/ZquBGcuRvRbUXgQFiyBO+LgEzdVVCPZ42cEiQ==
X-Received: by 2002:a17:902:ceca:b0:1ab:19f6:ef00 with SMTP id d10-20020a170902ceca00b001ab19f6ef00mr1068084plg.3.1683280140992;
        Fri, 05 May 2023 02:49:00 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b001aaffe15f39sm1312598plh.30.2023.05.05.02.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 02:49:00 -0700 (PDT)
Message-ID: <369d1be2-d418-1bfb-bfc2-b25e4e542d76@bytedance.com>
Date:   Fri, 5 May 2023 17:48:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [QUESTION FOR ARM64 TLB] performance issue and implementation
 difference of TLB flush
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        Gang Li <ligang.bdlg@bytedance.com>
Cc:     Will Deacon <will@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <2eb026b8-9e13-2b60-9e14-06417b142ac9@bytedance.com>
 <ZEokfJSM9a4ZZvQv@FVFF77S0Q05N>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <ZEokfJSM9a4ZZvQv@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series accidentally lost CC. Now I forward the lost emails to the
mailing list.

On 2023/4/28 17:27, Mark Rutland wrote:
> 
> 
> Hi,
> 
> Just to check -- did you mean to drop the other Ccs? It would be good to keep
> this discussion on-list if possible.
> 
> On Fri, Apr 28, 2023 at 01:49:46PM +0800, Gang Li wrote:
>> On 2023/4/27 15:30, Mark Rutland wrote:
>>> On Thu, Apr 27, 2023 at 11:26:50AM +0800, Gang Li wrote:
>>>> 1. I am curious to know the reason behind the design choice of flushing
>>>> the TLB on all cores for ARM64's clear_fixmap, while AMD64 only flushes
>>>> the TLB on a single core. Are there any TLB design details that make a
>>>> difference here?
>>>
>>> I don't know why arm64 only clears this on a single CPU.
>>
>> Sorry, I'm a bit confused.
>>
>> Did you mean you don't know why *amd64* only clears this on a single
>> CPU?
> 
> Yes, sorry; I meant to say "amd64" rather than "arm64" here.
> 
>> Looks like I should ask amd64 guy 😉
> 
> 😉
> 
>>> On arm64 we *must* invalidate the TLB on all CPUs as the kernel page tables are
>>> shared by all CPUs, and the architectural Break-Before-Make rules in require
>>> the TLB to be invalidated between two valid (but distinct) entries.
>>
>> ghes_unmap is protected by a spin_lock, so only one core can access this
>> mem area at a time. I understand that there will be no TLB for
>> this memory area on other cores.
>>
>> Is it because arm64 has speculative execution? Even if the core does not
>> hold the spin_lock, the TLB will still cache the critical section?
> 
> The architecture allows a CPU to allocate TLB entries at any time for any
> reason, for any valid translation table entries reachable from the root in
> TTBR{0,1}_ELx. That can be due to speculation, prefetching, and/or other
> reasons.
> 
> Due to that, it doesn't matter whether or not a CPU explicitly accesses a
> memory location -- TLB entries can be allocated regardless. Consequently, the
> spinlock doesn't make any difference.
> 
> Thanks,
> Mark.
> 

