Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873325B6927
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiIMIDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiIMIDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:03:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C05E5A819
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:03:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D420B106F;
        Tue, 13 Sep 2022 01:03:45 -0700 (PDT)
Received: from [10.162.42.9] (unknown [10.162.42.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 657083F73B;
        Tue, 13 Sep 2022 01:03:37 -0700 (PDT)
Message-ID: <84fa2ddf-488f-f66b-486b-01d7f896f7fb@arm.com>
Date:   Tue, 13 Sep 2022 13:33:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/16] mm: remove obsolete macro NR_PCP_ORDER_MASK
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     david@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-4-linmiaohe@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220909092451.24883-4-linmiaohe@huawei.com>
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
> Since commit 8b10b465d0e1 ("mm/page_alloc: free pages in a single pass
> during bulk free"), it's not used anymore. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

With those additional changes suggested by Matthew earlier

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  include/linux/mmzone.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index d907a29cc429..6950179a20a2 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -569,7 +569,6 @@ enum zone_watermarks {
>   * in the least significant bits.
>   */
>  #define NR_PCP_ORDER_WIDTH 8
> -#define NR_PCP_ORDER_MASK ((1<<NR_PCP_ORDER_WIDTH) - 1)
>  
>  #define min_wmark_pages(z) (z->_watermark[WMARK_MIN] + z->watermark_boost)
>  #define low_wmark_pages(z) (z->_watermark[WMARK_LOW] + z->watermark_boost)
