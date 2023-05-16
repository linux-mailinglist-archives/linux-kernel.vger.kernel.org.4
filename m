Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF68B7043E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 05:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjEPDQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 23:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEPDQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 23:16:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB0765AD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 20:16:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ab0c697c84so103743175ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 20:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684206985; x=1686798985;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WgtD6NWn+yBw7bCSBz6q/JMuhsMH9v6AcBcOE2Ac/FU=;
        b=d3u7Oa9Bgv2nPkzbBtkLeZfQ6NonojKT6HDw4rH5DO7A/Fc1RDMOQNH1HYXPAXIvL9
         gVwE12SdoEoazAUejjI26GczAv0kNxnT2sk3AwkfabuAtRiLEKYobWoTzhzRmf1yZD/i
         akatatQJ7DfG41KD7QZiFZBptLLuezlzAVq4DO9zj0CXaW7d7GO6pi3L5xxK9pjc++LG
         eSxrBk8j7CRreZMUkRoVr+50hTqKoU7AiYeov7G2XEkVuunz2qNp80k3OPnOCWIlgigR
         BPTT5Cnrf2J+vOesWfqA6doBuAt+MGOvwI3vZyo4+2tzKS6YYsJ5kPbsqwW8bnyjHgn8
         x8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684206985; x=1686798985;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgtD6NWn+yBw7bCSBz6q/JMuhsMH9v6AcBcOE2Ac/FU=;
        b=D9BKmjNSOqWY6ks3jw/ZedWScDV4rqwaNIP+smCUCK6BT5e8PGFDBtWluVX0Xb5S5g
         2gq1lCdI0aITNJ69PmFhysqyWhiFReJska3L1KcvrpUm+MMhb9YC+4MSgKLoreBSl1id
         1c8wBDh/IH41XCEkisQdK5SKawH4c+mWc2sJORX/d81QqzxJzoQ/yEomianKPojSkieu
         woffZJKwISkXs1RW5+1R8EzB8D07hKohkw5tC+WipYJC9zg8y2viwO/5dMaSzUl2xIYv
         Mm+qJRLaH7Miyxl0FR8/Pq0Cr9oxiDwPESD86Qa71UwXymdJvrM/2GpzwybXgh2QF/yb
         z79Q==
X-Gm-Message-State: AC+VfDy989TfS0LMuiqv3aJ8CFveL1kQg+4EoBS0CfGQEo7dBBxm/xc9
        s9Zp65vkkGJKGwAiQuk4LtOpqg==
X-Google-Smtp-Source: ACHHUZ4jctqSgC3lzNkJy+uVZdxEdM4N6x3K7ATaLKzbLOLrls8GqOGYgbDiaxuhoHzg9Oa3X4kVOQ==
X-Received: by 2002:a17:902:a503:b0:1ae:197f:dba9 with SMTP id s3-20020a170902a50300b001ae197fdba9mr6390946plq.2.1684206985109;
        Mon, 15 May 2023 20:16:25 -0700 (PDT)
Received: from [10.70.247.178] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id iy3-20020a170903130300b001a68d45e52dsm14247279plb.249.2023.05.15.20.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 20:16:24 -0700 (PDT)
Message-ID: <b30aa10f-7abc-11a0-552d-56fc88d534f7@bytedance.com>
Date:   Tue, 16 May 2023 11:16:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
From:   Gang Li <ligang.bdlg@bytedance.com>
Subject: Re: [QUESTION FOR ARM64 TLB] performance issue and implementation
 difference of TLB flush
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
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
 <369d1be2-d418-1bfb-bfc2-b25e4e542d76@bytedance.com>
 <8d8c2ed5-c29b-8ea6-84b3-3335d0682d0d@bytedance.com>
Content-Language: en-US
In-Reply-To: <8d8c2ed5-c29b-8ea6-84b3-3335d0682d0d@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On 2023/5/5 20:28, Gang Li wrote:
> Hi,
> 
> I found that in `ghes_unmap` protected by spinlock, arm64 and x86 have
> different strategies for flushing tlb.
> 
> # arm64 call trace:
> ```
> holding a spin lock
> ghes_unmap
>   clear_fixmap
>    __set_fixmap
>     flush_tlb_kernel_range
> ```
> 
> # x86 call trace:
> ```
> holding a spin lock
> ghes_unmap
>   clear_fixmap
>    __set_fixmap
>     mmu.set_fixmap
>      native_set_fixmap
>       __native_set_fixmap
>        set_pte_vaddr
>         set_pte_vaddr_p4d
>          __set_pte_vaddr
>           flush_tlb_one_kernel
> ```
>
> arm64 broadcast TLB invalidation in ghes_unmap, because TLB entry can be
> allocated regardless of whether the CPU explicitly accesses memory.
> 
> Why doesn't x86 broadcast TLB invalidation in ghes_unmap? Is there any
> difference between x86 and arm64 in TLB allocation and invalidation 
> strategy?
> 

I found this in Intel® 64 and IA-32 Architectures Software Developer
Manuals:

> 4.10.2.3 Details of TLB Use
> Subject to the limitations given in the previous paragraph, the
> processor may cache a translation for any linear address, even if that
> address is not used to access memory. For example, the processor may
> cache translations required for prefetches and for accesses that result
> from speculative execution that would never actually occur in the
> executed code path.

Both x86 and arm64 can cache TLB for prefetches and speculative
execution. Then why are their flush policies different?

Thanks,
Gang Li
