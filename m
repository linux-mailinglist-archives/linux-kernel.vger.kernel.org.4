Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174F8749B39
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjGFL6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGFL6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:58:11 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CDA128;
        Thu,  6 Jul 2023 04:58:09 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="111327889"
X-IronPort-AV: E=Sophos;i="6.01,185,1684767600"; 
   d="scan'208";a="111327889"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 20:58:07 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 59C27D29E1;
        Thu,  6 Jul 2023 20:58:05 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7C09FD8BB4;
        Thu,  6 Jul 2023 20:58:04 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3DF9170BCD;
        Thu,  6 Jul 2023 20:58:01 +0900 (JST)
Message-ID: <7956e695-3eac-25ef-4412-3a0ff33e3574@fujitsu.com>
Date:   Thu, 6 Jul 2023 19:58:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] memory tier: rename destroy_memory_type() to
 put_memory_type()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com
Cc:     ying.huang@intel.com, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230706063905.543800-1-linmiaohe@huawei.com>
From:   Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <20230706063905.543800-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27734.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27734.006
X-TMASE-Result: 10--10.827800-10.000000
X-TMASE-MatchedRID: 6Yvl3or3fgqPvrMjLFD6eAdJO1X873z+vWY9kbV8t/dWjSWvFszxq4P+
        YDa/Dhu95ZHdquAwKoEnZc8nHRklybmvMSppeWbNP0HVIeixJdAJlr1xKkE5ucC5DTEMxpeQfiq
        1gj2xET/FG6rPbKnpuiGGQs/f4Ygppx4mVJ23D0QRW4LR41Fi8m/5EOWkmXj5uBsk5njfgGw/SZ
        9wNeO8j2KgELVYfwoyHTR6rEcRrh5RPwES1RXV2rFpbR9jggy4UkCyfz2KH3gUXxbGG4P7rKPFj
        JEFr+olA9Mriq0CDAgBi3kqJOK62b+/RSFMoL2cxEHRux+uk8h+ICquNi0WJB9Sfbb9LDx9HkQb
        WPBv7SBkTYeysB4rr6sHUYWV14SWftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/6 14:39, Miaohe Lin wrote:
> It appears that destroy_memory_type() isn't a very good name because
> we usually will not free the memory_type here. So rename it to a more
> appropriate name i.e. put_memory_type().
> 
> Suggested-by: Huang, Ying <ying.huang@intel.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   drivers/dax/kmem.c           | 4 ++--
>   include/linux/memory-tiers.h | 4 ++--
>   mm/memory-tiers.c            | 6 +++---
>   3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 898ca9505754..c57acb73e3db 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -264,7 +264,7 @@ static int __init dax_kmem_init(void)
>   	return rc;
>   
>   error_dax_driver:
> -	destroy_memory_type(dax_slowmem_type);
> +	put_memory_type(dax_slowmem_type);
>   err_dax_slowmem_type:
>   	kfree_const(kmem_name);
>   	return rc;
> @@ -275,7 +275,7 @@ static void __exit dax_kmem_exit(void)
>   	dax_driver_unregister(&device_dax_kmem_driver);
>   	if (!any_hotremove_failed)
>   		kfree_const(kmem_name);
> -	destroy_memory_type(dax_slowmem_type);
> +	put_memory_type(dax_slowmem_type);
>   }
>   
>   MODULE_AUTHOR("Intel Corporation");
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index fc9647b1b4f9..437441cdf78f 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -33,7 +33,7 @@ struct memory_dev_type {
>   #ifdef CONFIG_NUMA
>   extern bool numa_demotion_enabled;
>   struct memory_dev_type *alloc_memory_type(int adistance);
> -void destroy_memory_type(struct memory_dev_type *memtype);
> +void put_memory_type(struct memory_dev_type *memtype);
>   void init_node_memory_type(int node, struct memory_dev_type *default_type);
>   void clear_node_memory_type(int node, struct memory_dev_type *memtype);
>   #ifdef CONFIG_MIGRATION
> @@ -68,7 +68,7 @@ static inline struct memory_dev_type *alloc_memory_type(int adistance)
>   	return NULL;
>   }
>   
> -static inline void destroy_memory_type(struct memory_dev_type *memtype)
> +static inline void put_memory_type(struct memory_dev_type *memtype)
>   {
>   
>   }
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 1719fa3bcf02..c49ab03f49b1 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -560,11 +560,11 @@ struct memory_dev_type *alloc_memory_type(int adistance)
>   }
>   EXPORT_SYMBOL_GPL(alloc_memory_type);
>   
> -void destroy_memory_type(struct memory_dev_type *memtype)
> +void put_memory_type(struct memory_dev_type *memtype)
>   {
>   	kref_put(&memtype->kref, release_memtype);
>   }
> -EXPORT_SYMBOL_GPL(destroy_memory_type);
> +EXPORT_SYMBOL_GPL(put_memory_type);
>   
>   void init_node_memory_type(int node, struct memory_dev_type *memtype)
>   {
> @@ -586,7 +586,7 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>   	 */
>   	if (!node_memory_types[node].map_count) {
>   		node_memory_types[node].memtype = NULL;
> -		destroy_memory_type(memtype);
> +		put_memory_type(memtype);
Hi Maohe,

I didn't find that destroy_memory_type(memtype) is called here on 
mainline kernel. Did I miss something?

Other than that, it looks good to me.
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang

>   	}
>   	mutex_unlock(&memory_tier_lock);
>   }
