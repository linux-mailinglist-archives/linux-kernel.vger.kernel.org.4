Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8BF5B6C44
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiIMLRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiIMLR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:17:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E56758099
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:17:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56CDD1063;
        Tue, 13 Sep 2022 04:17:34 -0700 (PDT)
Received: from [10.163.58.193] (unknown [10.163.58.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B63B03F71A;
        Tue, 13 Sep 2022 04:17:25 -0700 (PDT)
Message-ID: <5ca3fb8f-2dbd-f6e1-8482-7e2fa4729b19@arm.com>
Date:   Tue, 13 Sep 2022 16:47:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 16/16] mm/page_alloc: fix obsolete comment in
 deferred_pfn_valid()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     david@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-17-linmiaohe@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220909092451.24883-17-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/22 14:54, Miaohe Lin wrote:
> There are no architectures that can have holes in the memory map within
> a pageblock since commit 859a85ddf90e ("mm: remove pfn_valid_within()
> and CONFIG_HOLES_IN_ZONE"). Update the corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>


> ---
>  mm/page_alloc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 262e8972e019..4cc0232020d2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1929,11 +1929,7 @@ static inline void __init pgdat_init_report_one_done(void)
>  /*
>   * Returns true if page needs to be initialized or freed to buddy allocator.
>   *
> - * First we check if pfn is valid on architectures where it is possible to have
> - * holes within pageblock_nr_pages. On systems where it is not possible, this
> - * function is optimized out.
> - *
> - * Then, we check if a current large page is valid by only checking the validity
> + * We check if a current large page is valid by only checking the validity
>   * of the head pfn.
>   */
>  static inline bool __init deferred_pfn_valid(unsigned long pfn)
