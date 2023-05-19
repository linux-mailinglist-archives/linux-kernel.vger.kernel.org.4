Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847C2708D46
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 03:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjESBUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 21:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjESBUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 21:20:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A0E171C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:20:08 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QMpmw34YQz18LYw;
        Fri, 19 May 2023 09:15:28 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 09:19:50 +0800
Message-ID: <8b102796-2a90-de0c-9889-4b8b8aa8a98d@huawei.com>
Date:   Fri, 19 May 2023 09:19:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] mm: page_alloc: set sysctl_lowmem_reserve_ratio
 storage-class-specifier to static
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230518141119.927074-1-trix@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230518141119.927074-1-trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/18 22:11, Tom Rix wrote:
> smatch reports
> mm/page_alloc.c:247:5: warning: symbol
>    'sysctl_lowmem_reserve_ratio' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   mm/page_alloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Missing this one, Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1023f41de2fb..8032fffa425a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -244,7 +244,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
>    * TBD: should special case ZONE_DMA32 machines here - in those we normally
>    * don't need any ZONE_NORMAL reservation
>    */
> -int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES] = {
> +static int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES] = {
>   #ifdef CONFIG_ZONE_DMA
>   	[ZONE_DMA] = 256,
>   #endif
