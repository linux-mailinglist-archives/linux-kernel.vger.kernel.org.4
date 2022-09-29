Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138795EFF56
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiI2VhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiI2VhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:37:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715A511C15A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/v5uv/MN1Okoi7sbqFRNP3ZgEoChKUKNtV0vYzTFxUM=; b=jaH5lDgBJMkA2RCtvDReLzU6gn
        dJnMI9bw78SVOf+viMLe8qDz9C8wMWWmw00rd37HhI7Dmu920o/aI2nCH7F+IYjUuSBFz9petPlwX
        CkW12bU3JgVTxZsGfXHARPTIoObPualUN+d4B0QHTYyFWTMkQIoGkxkO4UYmtwcOikMJrYG8S8b2Z
        ZOOsyiTI6yjDCEuIZ/3md//4zsmqeXOZiPsBnqhuBWGJLmuZ52EyjmecAHCPxgR/qACL1Rl8bPutu
        AYqrQ3ezR0Mj/pwMMcPRK5wMbp0u8u7HUr1blV+9JvGfh90zMTs9l2xWFTKSd2PQ413Vqf3Jw8hTU
        ucEQJB1g==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oe1DD-005XRl-9L; Thu, 29 Sep 2022 21:36:55 +0000
Message-ID: <651530a9-2dc1-c781-a1b5-1e712684f94d@infradead.org>
Date:   Thu, 29 Sep 2022 14:36:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] x86/mm/tlb: fix error word 'clleared' to 'cleared'
Content-Language: en-US
To:     Xin Hao <xhao@linux.alibaba.com>, namit@vmware.com
Cc:     tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220929091040.45390-1-xhao@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220929091040.45390-1-xhao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

I would say let's fix the sentence grammar, but I don't know
what "cleared set" means.


On 9/29/22 02:10, Xin Hao wrote:
> Just correct the wrong word 'clleared' to 'cleared'
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  arch/x86/include/asm/tlbflush.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index cda3118f3b27..c80a15ef0cbc 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -291,7 +291,7 @@ static inline bool pte_flags_need_flush(unsigned long oldflags,
>  		diff &= ~_PAGE_ACCESSED;
> 
>  	/*
> -	 * Did any of the 'flush_on_clear' flags was clleared set from between
> +	 * Did any of the 'flush_on_clear' flags was cleared set from between

It should be more like:

	 * Were any of the 'flush_on_clear' flags changed between

X86 people, does that make sense to you?


>  	 * 'oldflags' and 'newflags'?
>  	 */
>  	if (diff & oldflags & flush_on_clear)
> --
> 2.31.0

-- 
~Randy
