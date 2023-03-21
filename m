Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D81E6C290D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 05:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCUEPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 00:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCUEPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 00:15:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1271F9749
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 21:14:15 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id u20so7774801pfk.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 21:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679372054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ghHN1vnHe3Q9LXpob6M+hS+NoZYTu49dwl+0ycHuL0=;
        b=Vz4Mi71IS1jUt5Zhvv0Dc+xaMYo4P8xGzFl5kfyrCt/eRYimjDTOhrzD3cQ1x1o9Hn
         6/cxXFCC5/XM1C8y1pWrmXI+0M5YjPPu1vfRTTmULDr2GJBKn6Mr6J6GflYMBytxXmeA
         EHafLzYTjnYNVd9N1oC+8bZyfOnxgNR8uwK+FGiy6PXCdRJccnSRUgNq8w7Z+9pO8bQQ
         QEnZfJuygmjMu1TEPXOAiGDv3wBBpQWVpwFGIj+NcExyWaJ1I2We+Id88spZX1fSO6OO
         OLogew8Q1HKsg+Pp4rlLbmyhzw4DvruJzwNtHQkjUfojvyiUqZOJfJIf8GH9M6Ibp3/y
         3Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679372054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ghHN1vnHe3Q9LXpob6M+hS+NoZYTu49dwl+0ycHuL0=;
        b=ImQ+EHN7Q0lROokWmC6qxjDsxJQ44uIOoFn1xW85zXr+uITDnNqWjhZlCIcUagQzR0
         VqojxEdjFFG2ukGXFbvKJb+SWpSctdxRHlmwojaOrXPY94IvV2K325vPO54IcQ1CjGl3
         ZeJlD7rwaMlbC8GBJSTwx54dj7ScjgNpbXTRQTl1OVW+FcBMx8GjrMIYqwFJOKzCuvTl
         zxi5BBueKxSxu+5Enx3qm+fD6kdy7SM7+S4S972RClx65RtYh1NN8LNFArVZBjLYqz9n
         d02xDkgxc/lK6bfClFuB/3rkpBckd7r1wDUlS1oedmAPpjwzhWtPF9Rd57fheozDG6lm
         lwGw==
X-Gm-Message-State: AO0yUKUULD5uE08Nku0t4/wAiP6OramKVvwwMU9ybV9xzRkNRt9w3Xz2
        9hOW3MTTLHvGpy2/vSkjPzFj1w==
X-Google-Smtp-Source: AK7set+88TsZpxLEl3e1Iab18TCKxNejBApLddSLDzEAgh6qy+6yS20Ox7GwvSIeuZJ/GDQ5OLnbtA==
X-Received: by 2002:a62:6304:0:b0:627:a283:5a04 with SMTP id x4-20020a626304000000b00627a2835a04mr823381pfb.27.1679372054389;
        Mon, 20 Mar 2023 21:14:14 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:1c2a:1cd4:8b91:108f:bf15? ([2404:9dc0:cd01::1a])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79117000000b005a8173829d5sm5135483pfh.66.2023.03.20.21.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 21:14:14 -0700 (PDT)
Message-ID: <974ef73e-ab4f-7b24-d070-c981654e8c22@bytedance.com>
Date:   Tue, 21 Mar 2023 12:14:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: kfence: fix PG_slab and memcg_data clearing
To:     Muchun Song <songmuchun@bytedance.com>, glider@google.com,
        elver@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        sjpark@amazon.de, jannh@google.com, muchun.song@linux.dev,
        roman.gushchin@linux.dev
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230320030059.20189-1-songmuchun@bytedance.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230320030059.20189-1-songmuchun@bytedance.com>
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


在 2023/3/20 11:00, Muchun Song 写道:
> It does not reset PG_slab and memcg_data when KFENCE fails to initialize
> kfence pool at runtime. It is reporting a "Bad page state" message when
> kfence pool is freed to buddy. The checking of whether it is a compound
> head page seems unnecessary sicne we already guarantee this when allocating
> kfence pool, removing the check to simplify the code.
>
> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> Fixes: 8f0b36497303 ("mm: kfence: fix objcgs vector allocation")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/kfence/core.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 79c94ee55f97..d66092dd187c 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -561,10 +561,6 @@ static unsigned long kfence_init_pool(void)
>   		if (!i || (i % 2))
>   			continue;
>   
> -		/* Verify we do not have a compound head page. */
> -		if (WARN_ON(compound_head(&pages[i]) != &pages[i]))
> -			return addr;
> -
>   		__folio_set_slab(slab_folio(slab));
>   #ifdef CONFIG_MEMCG
>   		slab->memcg_data = (unsigned long)&kfence_metadata[i / 2 - 1].objcg |
> @@ -597,12 +593,26 @@ static unsigned long kfence_init_pool(void)
>   
>   		/* Protect the right redzone. */
>   		if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
> -			return addr;
> +			goto reset_slab;
>   
>   		addr += 2 * PAGE_SIZE;
>   	}
>   
>   	return 0;
> +
> +reset_slab:
> +	for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
> +		struct slab *slab = page_slab(&pages[i]);
> +
> +		if (!i || (i % 2))
> +			continue;
> +#ifdef CONFIG_MEMCG
> +		slab->memcg_data = 0;
> +#endif
> +		__folio_clear_slab(slab_folio(slab));
> +	}
Can this loop be simplified to this?

	for (i = 2; i < KFENCE_POOL_SIZE / PAGE_SIZE; i+=2) {
		struct slab *slab = page_slab(&pages[i]);
#ifdef CONFIG_MEMCG
		slab->memcg_data = 0;
#endif
		__folio_clear_slab(slab_folio(slab));
	}

> +
> +	return addr;
>   }
>   
>   static bool __init kfence_init_pool_early(void)
> @@ -632,16 +642,6 @@ static bool __init kfence_init_pool_early(void)
>   	 * fails for the first page, and therefore expect addr==__kfence_pool in
>   	 * most failure cases.
>   	 */
> -	for (char *p = (char *)addr; p < __kfence_pool + KFENCE_POOL_SIZE; p += PAGE_SIZE) {
> -		struct slab *slab = virt_to_slab(p);
> -
> -		if (!slab)
> -			continue;
> -#ifdef CONFIG_MEMCG
> -		slab->memcg_data = 0;
> -#endif
> -		__folio_clear_slab(slab_folio(slab));
> -	}
>   	memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
>   	__kfence_pool = NULL;
>   	return false;
