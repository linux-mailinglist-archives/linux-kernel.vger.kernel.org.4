Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58B25B6965
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiIMIVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiIMIVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:21:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2D2A5AC56
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:20:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08EE0D6E;
        Tue, 13 Sep 2022 01:20:56 -0700 (PDT)
Received: from [10.162.42.9] (unknown [10.162.42.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B1A83F73B;
        Tue, 13 Sep 2022 01:20:47 -0700 (PDT)
Message-ID: <8f70a514-7ced-9359-d169-ac928578980f@arm.com>
Date:   Tue, 13 Sep 2022 13:50:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/16] mm/page_alloc: add __init annotations to
 init_mem_debugging_and_hardening()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     david@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-6-linmiaohe@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220909092451.24883-6-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/22 14:54, Miaohe Lin wrote:
> It's only called by mm_init(). Add __init annotations to it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  include/linux/mm.h | 2 +-
>  mm/page_alloc.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 364bcadb4d20..c2277f5aba9e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3093,7 +3093,7 @@ extern int apply_to_existing_page_range(struct mm_struct *mm,
>  				   unsigned long address, unsigned long size,
>  				   pte_fn_t fn, void *data);
>  
> -extern void init_mem_debugging_and_hardening(void);
> +extern void __init init_mem_debugging_and_hardening(void);
>  #ifdef CONFIG_PAGE_POISONING
>  extern void __kernel_poison_pages(struct page *page, int numpages);
>  extern void __kernel_unpoison_pages(struct page *page, int numpages);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c81f06d8a4f5..3497919f4ef5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -903,7 +903,7 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
>   * order of appearance. So we need to first gather the full picture of what was
>   * enabled, and then make decisions.
>   */
> -void init_mem_debugging_and_hardening(void)
> +void __init init_mem_debugging_and_hardening(void)
>  {
>  	bool page_poisoning_requested = false;
>  
