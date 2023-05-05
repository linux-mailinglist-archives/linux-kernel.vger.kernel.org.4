Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A496F82F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjEEM3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEEM3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:29:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E21E1A60A
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:28:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ab13da70a3so16275325ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 05:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683289722; x=1685881722;
        h=content-transfer-encoding:in-reply-to:to:from:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ByJNnXSDRlq4gYdZRhAq3Xelfx/hEVGCr+0oMdNmBnI=;
        b=DMdHzFAvgx+VnA44zfWzCcq4X4hotlnfhegf8lM8tTPYFyZ1bUNUNjtjbPkVOIM5vb
         8jKAm8xshSqZwZl5xuMDnliuDTYDewOHZ2zHqPUNYv8sdWc6mnSYfovi4VZMwh/zHI3B
         66CY8T5ve6MCj70+Au+M0ymHLbZ7FG7lVBoaOIu8NSTJmxg80sfht7TOMxl94fjTB0cg
         ncIOTUASX31KN65+PUWp5lj1yHEB9IhJn5AVnPGzzNt2eg4BkJxLFVjgDe6d/O7mJxbW
         Q/B/Z/OHCfb81cSFds4NuiyRCfovw0w5bdwXbttZXKXMSiytz7CtjpKTYoDzqZlDATXq
         VdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683289722; x=1685881722;
        h=content-transfer-encoding:in-reply-to:to:from:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByJNnXSDRlq4gYdZRhAq3Xelfx/hEVGCr+0oMdNmBnI=;
        b=gfUIE+agArldxNZ5KgkhEfgZ+3/Y79qw4Ne5ZmvSXkgzT5WesMJWLSoc10KUp/fuJL
         Ogwk5ZgfQvrKUD2Vm/TheLZDDn1LiXlz5OwTiHZuAV4n9rTK7Vnmp0QVH7Oyd7AeEbdx
         UmfTZ4DW6KNEio0FZeqI9Wa3in0BtDZlPa51fU1m+bAduxDhZdIrMLJQZJopTu0ffMNW
         EjBSeA5HGAuWH+WAXZVYo79oS4+oNMwAa87lxlFuKwaXWQh1/kI80hVa9GIbE2VL+L5P
         x2KHLpaP82W/VkOGBXbNWe2VpzKWordY4TICEVeFzWKLetynflZk724y3enmARnFf+nq
         zEbg==
X-Gm-Message-State: AC+VfDzii8euoqfjYJwXFZ2Lq1HZ+pjQbvmycmVJvlLcJy/W6sRH11Wa
        pTrC10eTDswEDOLvV15i1zwcKw==
X-Google-Smtp-Source: ACHHUZ4FrAb92tjqO0ADnTNF5JsiyFdayX/NIZ5p8gO0l1i/VTai1+/XNgLbTE+AUc4JW8p9H4Gl4Q==
X-Received: by 2002:a17:902:a589:b0:1a6:d8a3:3346 with SMTP id az9-20020a170902a58900b001a6d8a33346mr1130936plb.31.1683289721733;
        Fri, 05 May 2023 05:28:41 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090282cb00b001a1ccb37847sm1669244plz.146.2023.05.05.05.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 05:28:41 -0700 (PDT)
Message-ID: <8d8c2ed5-c29b-8ea6-84b3-3335d0682d0d@bytedance.com>
Date:   Fri, 5 May 2023 20:28:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [QUESTION FOR ARM64 TLB] performance issue and implementation
 difference of TLB flush
Content-Language: en-US
Cc:     Will Deacon <will@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <2eb026b8-9e13-2b60-9e14-06417b142ac9@bytedance.com>
 <ZEokfJSM9a4ZZvQv@FVFF77S0Q05N>
 <369d1be2-d418-1bfb-bfc2-b25e4e542d76@bytedance.com>
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <369d1be2-d418-1bfb-bfc2-b25e4e542d76@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found that in `ghes_unmap` protected by spinlock, arm64 and x86 have
different strategies for flushing tlb.

# arm64 call trace:
```
holding a spin lock
ghes_unmap
  clear_fixmap
   __set_fixmap
    flush_tlb_kernel_range
```

# x86 call trace:
```
holding a spin lock
ghes_unmap
  clear_fixmap
   __set_fixmap
    mmu.set_fixmap
     native_set_fixmap
      __native_set_fixmap
       set_pte_vaddr
        set_pte_vaddr_p4d
         __set_pte_vaddr
          flush_tlb_one_kernel
```

As we can see, ghes_unmap in arm64 eventually calls
flush_tlb_kernel_range to broadcast TLB invalidation. However, on
x86, ghes_unmap calls flush_tlb_one_kernel.

Why arm64 needs to broadcast TLB invalidation in ghes_unmap, while only
one CPU has accessed this memory area?

Mark Rutland said in 
https://lore.kernel.org/lkml/369d1be2-d418-1bfb-bfc2-b25e4e542d76@bytedance.com/

> The architecture (arm64) allows a CPU to allocate TLB entries at any time for any
> reason, for any valid translation table entries reachable from the 
> root in
> TTBR{0,1}_ELx. That can be due to speculation, prefetching, and/or other
> reasons.
>
> Due to that, it doesn't matter whether or not a CPU explicitly accesses a
> memory location -- TLB entries can be allocated regardless.
> Consequently, the
> spinlock doesn't make any difference.
>

arm64 broadcast TLB invalidation in ghes_unmap, because TLB entry can be
allocated regardless of whether the CPU explicitly accesses memory.

Why doesn't x86 broadcast TLB invalidation in ghes_unmap? Is there any
difference between x86 and arm64 in TLB allocation and invalidation 
strategy?

Thanks,
Gang Li
