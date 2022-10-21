Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28276074DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiJUKRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiJUKRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:17:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9DC2514EA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:16:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id iv17so1853854wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5cnDmrVndRxKiTHUVemxonBJmpJGHILsZC3ogF/MOw=;
        b=JPtq+/IRujntwIE/R0H50vcNFzBxZsG6vivxycGAXnEB2uRQt6ffZwiejqzB7e2thQ
         NUlcGdmwHolJLIyBZw0eVbnviS2rST1avPMOUkg8ACV8YerSEMWgInAYBS94wGapJw4i
         bfRlNjVOU9KrSi7RqliTvkKJa7cZtLfpxfwmxtE2ad1zmQef69xoS1eIddjy6V/CVYIV
         OSX1sAbFVNxDQkT8WjHl639ubVOThBYSN7UldhIlgneUKM+K/ZRScAH6fxsbB5g0MWT/
         301O4bxqIRd29ca4wje7C/60v3tVfhwf0S5eO9cBOGxlGkTMgxAyQO3qnOla5YK5a34j
         LIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5cnDmrVndRxKiTHUVemxonBJmpJGHILsZC3ogF/MOw=;
        b=SHqLaNQ0X7Ohy664+aFCweqvJ4oE+x+NtPWLOdwuRp0y63lPuTEt1xsKG3yaMlOazj
         ceOpKZpGvmyaA0n9P1/GBlRptV+El/bmkzukG0iUSAS9j8GGqSMQQuBzRvCKGVM+cfKD
         ZVOi/I27GOa0fA4q1t7jFNtPplwLa6Qn4BfMmt4cejW6qjB2KuXn0mGthOx4wZnbZycW
         fz5nSiTJD4mZWKn2B/ZJFGvRMcVH+Pej2kf5p6xRIvGfNSfpMmR3MRlLv8O0EKZOhnmb
         vZur4qAYjAylRF19q3cc01pNcCmPNovgEernt13RNRr+61QzXZnKzLe0MfteP+43oAe4
         xT5g==
X-Gm-Message-State: ACrzQf2mHcyYBLknoufJY1VV/dUv906E2A/iLI/RpihBt518BQdSfN06
        p+0IYG60Y8cQ7040oyuygwCyWQ==
X-Google-Smtp-Source: AMsMyM7lFiRw/3BBe90FzLXlb+jXp4Bsd46molv2+M4Io/03D653ZKfrdrAMjZSj/Yk+qHqfl4wzbA==
X-Received: by 2002:a7b:c841:0:b0:3c6:ce2f:3438 with SMTP id c1-20020a7bc841000000b003c6ce2f3438mr12545988wml.51.1666347414085;
        Fri, 21 Oct 2022 03:16:54 -0700 (PDT)
Received: from [10.50.0.10] (ec2-54-194-108-71.eu-west-1.compute.amazonaws.com. [54.194.108.71])
        by smtp.gmail.com with ESMTPSA id ay41-20020a05600c1e2900b003c6f0ebf988sm2166623wmb.30.2022.10.21.03.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 03:16:53 -0700 (PDT)
Message-ID: <1ca11693-17c2-7260-b642-70b033c64b30@linaro.org>
Date:   Fri, 21 Oct 2022 12:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH V12 4/4] LoongArch: Enable
 ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>
References: <20221020072317.492906-1-chenhuacai@loongson.cn>
 <20221020072317.492906-5-chenhuacai@loongson.cn>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221020072317.492906-5-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/22 09:23, Huacai Chen wrote:
> From: Feiyang Chen <chenfeiyang@loongson.cn>
> 
> The feature of minimizing overhead of struct page associated with each
> HugeTLB page is implemented on x86_64. However, the infrastructure of
> this feature is already there, so just select ARCH_WANT_HUGETLB_PAGE_
> OPTIMIZE_VMEMMAP is enough to enable this feature for LoongArch.
> 
> To avoid the following build error on LoongArch we should include linux/

s/should/have to/

> static_key.h in page-flags.h.

This looks like 2 different changes in a single patch.. The first is a
generic "fix missing include" and the second is LoongArch specific.

Splitting in 2 would ease backport cherry-picks.

> In file included from ./include/linux/mmzone.h:22,
> from ./include/linux/gfp.h:6,
> from ./include/linux/mm.h:7,
> from arch/loongarch/kernel/asm-offsets.c:9:
> ./include/linux/page-flags.h:208:1: warning: data definition has no
> type or storage class
> 208 | DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> | ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/page-flags.h:208:1: error: type defaults to 'int' in
> declaration of 'DECLARE_STATIC_KEY_MAYBE' [-Werror=implicit-int]
> ./include/linux/page-flags.h:209:26: warning: parameter names (without
> types) in function declaration
> 209 | hugetlb_optimize_vmemmap_key);
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/page-flags.h: In function 'hugetlb_optimize_vmemmap_enabled':
> ./include/linux/page-flags.h:213:16: error: implicit declaration of
> function 'static_branch_maybe' [-Werror=implicit-function-declaration]
> 213 | return static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> | ^~~~~~~~~~~~~~~~~~~
> ./include/linux/page-flags.h:213:36: error:
> 'CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON' undeclared (first
> use in this function); did you mean
> 'CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP'?
> 213 | return static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> | CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> ./include/linux/page-flags.h:213:36: note: each undeclared identifier
> is reported only once for each function it appears in
> ./include/linux/page-flags.h:214:37: error:
> 'hugetlb_optimize_vmemmap_key' undeclared (first use in this
> function); did you mean 'hugetlb_optimize_vmemmap_enabled'?
> 214 | &hugetlb_optimize_vmemmap_key);
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> | hugetlb_optimize_vmemmap_enabled
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/Kconfig     | 1 +
>   include/linux/page-flags.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 6f7fa0c0ca08..0a6ef613124c 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -52,6 +52,7 @@ config LOONGARCH
>   	select ARCH_USE_QUEUED_RWLOCKS
>   	select ARCH_USE_QUEUED_SPINLOCKS
>   	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> +	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>   	select ARCH_WANT_LD_ORPHAN_WARN
>   	select ARCH_WANTS_NO_INSTR
>   	select BUILDTIME_TABLE_SORT
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 0b0ae5084e60..1aafdc73e399 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -9,6 +9,7 @@
>   #include <linux/types.h>
>   #include <linux/bug.h>
>   #include <linux/mmdebug.h>
> +#include <linux/static_key.h>
>   #ifndef __GENERATING_BOUNDS_H
>   #include <linux/mm_types.h>
>   #include <generated/bounds.h>

Preferably splitting in 2 distinct patches (for each):

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

