Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAFE5F031B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 05:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiI3DGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 23:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiI3DGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 23:06:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D7510C7A6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 20:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=DHoxbDYBDL9k7m/rvR/V3CwrQxlP3ygdvVPvMeg5i80=; b=3px+hM/OCOrV6L5mN5EQkp4qi5
        XykN/VQduELLGS57D9ockO2T7CcsIaJiShTPCtRLD3xvYDLVAkHQA8nCAXYcXZ8UlwIkBG6h3N38a
        pp/Vp6uqNlus7Un5RzAaB0DI14jNujgwMRFk6VxCgCWg/m9v/eOTYIqKnmJGWYC7aufwSRy3zn5yC
        9f4rxyJJT03YJRqI6cq0m29yD8NtGGJtRalpUxVlBJFRIYzJZOEyVMg/NcDStzVHQxYvahO309ggQ
        j86IgHVwT1bL5Lm0tfP8crGaCAPkSS7I+h9CdD8AGRcB7cb3GLPcHp1qppgrUu76iFFTV4i1uVwom
        j8HtMPUw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oe6Ln-006rBt-DC; Fri, 30 Sep 2022 03:06:07 +0000
Message-ID: <5b329c5f-c4b6-5d58-422e-b90df66e13cb@infradead.org>
Date:   Thu, 29 Sep 2022 20:06:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] x86/mm/tlb: update some comments in
 pte_flags_need_flush
Content-Language: en-US
To:     Xin Hao <xhao@linux.alibaba.com>, namit@vmware.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        hpa@zytor.com, jroedel@suse.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220930022434.51850-1-xhao@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220930022434.51850-1-xhao@linux.alibaba.com>
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



On 9/29/22 19:24, Xin Hao wrote:
> There just changed the comment about 'flush_on_clear' check, which make
> the explanation more reasonable.
> 
> Suggested-by: Nadav Amit <namit@vmware.com>
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> Changes from v2
> (https://lore.kernel.org/lkml/20220929091040.45390-1-xhao@linux.alibaba.com/)
> - fix some comments suggested-by Nadav Amit <namit@vmware.com> and
> Randy Dunlap <rdunlap@infradead.org>
> 
>  arch/x86/include/asm/tlbflush.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index cda3118f3b27..2a17698fb194 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -291,8 +291,8 @@ static inline bool pte_flags_need_flush(unsigned long oldflags,
>  		diff &= ~_PAGE_ACCESSED;
> 
>  	/*
> -	 * Did any of the 'flush_on_clear' flags was clleared set from between
> -	 * 'oldflags' and 'newflags'?
> +	 * Consider the 'flush_on_clear' flags that are set on 'oldflags',
> +	 * Flush if any of these flags is cleared on 'newflags'.
>  	 */
>  	if (diff & oldflags & flush_on_clear)
>  		return true;
> --
> 2.31.0

-- 
~Randy
