Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D8474D3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjGJKwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGJKwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:52:47 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9C0E0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:52:33 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56661fe27cbso3033897eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688986353; x=1691578353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qWr+V3gYZrsNg0XRx3MW3g+BVG6UNjjUpqVndfuvns=;
        b=QgNE2wco+U0ham6nOIpQGx2HHG7POV14PtvoYUO9gc75CiqvOv8695t58wgZJW7WBv
         mMPDnpEOZ8USpDasHFbpQDc+vevRi0W8mXTa5AeOvt7GxA16VFO77yHX6IwoPfKCFBI4
         t7DiF1xn2V3GQtf1ATFAmgaJEkto4JVHETPw27/mRnMLh0STzicLHdxebmkTlpRPpCEU
         fRHsu79dTwDZgqgZR7JC2XYgmajfjqvz1Tc/LwD0gjfumyOb0sZMgUsSDH7vpgf1R5j7
         p21EFrHYmYIBgog0nYpjUU8hXFgGb5r5a2xCtINjlMyZ1X7Pcbdszu5gqLcPz2vvKm9H
         +fWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688986353; x=1691578353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1qWr+V3gYZrsNg0XRx3MW3g+BVG6UNjjUpqVndfuvns=;
        b=j2iKj4ssbsYdDiSdY03tfIwCC8p1N04EIHK7x9dRKsnO/ZHylskq3aHP2c3LuWFZ5F
         RZZqdMcXSUjo5nEYMq1qi8dMPgC0/l5DpSIFAsx5BWnU8w2Rr8r0P5atzAh2lvIYVhAH
         N/cdvZapEKSMPMESag3dDtpnlh39UOPeir8sRJ/NQWaCnaoQkUXeldDSoEbhTQ2mgFtQ
         d+l30/EfgcJ+P5MjovkEmmPm6IvAKabNI3Xn8eo9vSOQHGbKHI6VvW1NvpKDHbo6IDFz
         5bQAISMqhG5DVX/6CalDhEjiwaPwtUiiiXF3COO0AdonK62sxqqmEdKMnmvd40rJizQl
         xv+A==
X-Gm-Message-State: ABy/qLbMjv8saJJjXTXF77u4nBbrcE5oYqkHHrMywW9qOMtYJjS98p31
        EdjUHyRERBuy/c+K4m3HX6M7hg==
X-Google-Smtp-Source: APBJJlH1cWx4gMVcMxl6FnFBdryk+fIRvyMddabfNZ6Oiv3Gf66K+tZmCS8MES8xlyzAsEEBq6cK8w==
X-Received: by 2002:a05:6808:3d3:b0:3a3:d4e9:7d18 with SMTP id o19-20020a05680803d300b003a3d4e97d18mr10935100oie.2.1688986353095;
        Mon, 10 Jul 2023 03:52:33 -0700 (PDT)
Received: from [10.90.35.114] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id z2-20020a637e02000000b00553ad4ae5e5sm7065863pgc.22.2023.07.10.03.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 03:52:32 -0700 (PDT)
Message-ID: <96a737e5-5545-04ed-e533-e322ffe20fce@bytedance.com>
Date:   Mon, 10 Jul 2023 18:52:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: kfence: allocate kfence_metadata at runtime
To:     Marco Elver <elver@google.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20230710032714.26200-1-zhangpeng.00@bytedance.com>
 <CANpmjNOHz+dRbJsAyg29nksPMcd2P6109iPxTem_-b2qfUvXtw@mail.gmail.com>
 <ZKvbqidp7s8a/17O@elver.google.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <ZKvbqidp7s8a/17O@elver.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/10 18:21, Marco Elver 写道:
> On Mon, Jul 10, 2023 at 12:19PM +0200, Marco Elver wrote:
>> On Mon, 10 Jul 2023 at 05:27, 'Peng Zhang' via kasan-dev
>> <kasan-dev@googlegroups.com> wrote:
>>>
>>> kfence_metadata is currently a static array. For the purpose of
>>> allocating scalable __kfence_pool, we first change it to runtime
>>> allocation of metadata. Since the size of an object of kfence_metadata
>>> is 1160 bytes, we can save at least 72 pages (with default 256 objects)
>>> without enabling kfence.
>>>
>>> Below is the numbers obtained in qemu (with default 256 objects).
>>> before: Memory: 8134692K/8388080K available (3668K bss)
>>> after: Memory: 8136740K/8388080K available (1620K bss)
>>> More than expected, it saves 2MB memory.
>>>
>>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>>
>> Seems like a reasonable optimization, but see comments below.
>>
>> Also with this patch applied on top of v6.5-rc1, KFENCE just doesn't
>> init at all anymore (early init). Please fix.
> 
> Forgot to attach .config -- attached config.
> 
> All I see is:
> 
> [    0.303465] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [    0.304783] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
> [    0.316800] NR_IRQS: 4352, nr_irqs: 488, preallocated irqs: 16
> [    0.318140] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.320001] kfence: kfence_init failed
> [    0.326880] Console: colour VGA+ 80x25
> [    0.327585] printk: console [ttyS0] enabled
> [    0.327585] printk: console [ttyS0] enabled
> 
> around KFENCE initialization.
Thanks for your review and testing, I'll take a look at the issues later.
> 
>>> ---
>>>   mm/kfence/core.c   | 102 ++++++++++++++++++++++++++++++++-------------
>>>   mm/kfence/kfence.h |   5 ++-
>>>   2 files changed, 78 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
>>> index dad3c0eb70a0..b9fec1c46e3d 100644
>>> --- a/mm/kfence/core.c
>>> +++ b/mm/kfence/core.c
>>> @@ -116,7 +116,7 @@ EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
>>>    * backing pages (in __kfence_pool).
>>>    */
>>>   static_assert(CONFIG_KFENCE_NUM_OBJECTS > 0);
>>> -struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
>>> +struct kfence_metadata *kfence_metadata;
>>>
>>>   /* Freelist with available objects. */
>>>   static struct list_head kfence_freelist = LIST_HEAD_INIT(kfence_freelist);
>>> @@ -643,13 +643,56 @@ static unsigned long kfence_init_pool(void)
>>>          return addr;
>>>   }
>>>
>>> +static int kfence_alloc_metadata(void)
>>> +{
>>> +       unsigned long nr_pages = KFENCE_METADATA_SIZE / PAGE_SIZE;
>>> +
>>> +#ifdef CONFIG_CONTIG_ALLOC
>>> +       struct page *pages;
>>> +
>>> +       pages = alloc_contig_pages(nr_pages, GFP_KERNEL, first_online_node,
>>> +                                  NULL);
>>> +       if (pages)
>>> +               kfence_metadata = page_to_virt(pages);
>>> +#else
>>> +       if (nr_pages > MAX_ORDER_NR_PAGES) {
>>> +               pr_warn("KFENCE_NUM_OBJECTS too large for buddy allocator\n");
>>
>> Does this mean that KFENCE won't work at all if we can't allocate the
>> metadata? I.e. it won't work either in early nor late init modes?
>>
>> I know we already have this limitation for _late init_ of the KFENCE pool.
>>
>> So I have one major question: when doing _early init_, what is the
>> maximum size of the KFENCE pool (#objects) with this change?
>>
>>> +               return -EINVAL;
>>> +       }
>>> +       kfence_metadata = alloc_pages_exact(KFENCE_METADATA_SIZE,
>>> +                                           GFP_KERNEL);
>>> +#endif
>>> +
>>> +       if (!kfence_metadata)
>>> +               return -ENOMEM;
>>> +
>>> +       memset(kfence_metadata, 0, KFENCE_METADATA_SIZE);
>>
>> memzero_explicit, or pass __GFP_ZERO to alloc_pages?
>>
>>> +       return 0;
>>> +}
>>> +
>>> +static void kfence_free_metadata(void)
>>> +{
>>> +       if (WARN_ON(!kfence_metadata))
>>> +               return;
>>> +#ifdef CONFIG_CONTIG_ALLOC
>>> +       free_contig_range(page_to_pfn(virt_to_page((void *)kfence_metadata)),
>>> +                         KFENCE_METADATA_SIZE / PAGE_SIZE);
>>> +#else
>>> +       free_pages_exact((void *)kfence_metadata, KFENCE_METADATA_SIZE);
>>> +#endif
>>> +       kfence_metadata = NULL;
>>> +}
>>> +
>>>   static bool __init kfence_init_pool_early(void)
>>>   {
>>> -       unsigned long addr;
>>> +       unsigned long addr = (unsigned long)__kfence_pool;
>>>
>>>          if (!__kfence_pool)
>>>                  return false;
>>>
>>> +       if (!kfence_alloc_metadata())
>>> +               goto free_pool;
>>> +
>>>          addr = kfence_init_pool();
>>>
>>>          if (!addr) {
>>> @@ -663,6 +706,7 @@ static bool __init kfence_init_pool_early(void)
>>>                  return true;
>>>          }
>>>
>>> +       kfence_free_metadata();
>>>          /*
>>>           * Only release unprotected pages, and do not try to go back and change
>>>           * page attributes due to risk of failing to do so as well. If changing
>>> @@ -670,31 +714,12 @@ static bool __init kfence_init_pool_early(void)
>>>           * fails for the first page, and therefore expect addr==__kfence_pool in
>>>           * most failure cases.
>>>           */
>>> +free_pool:
>>>          memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
>>>          __kfence_pool = NULL;
>>>          return false;
>>>   }
>>>
>>> -static bool kfence_init_pool_late(void)
>>> -{
>>> -       unsigned long addr, free_size;
>>> -
>>> -       addr = kfence_init_pool();
>>> -
>>> -       if (!addr)
>>> -               return true;
>>> -
>>> -       /* Same as above. */
>>> -       free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
>>> -#ifdef CONFIG_CONTIG_ALLOC
>>> -       free_contig_range(page_to_pfn(virt_to_page((void *)addr)), free_size / PAGE_SIZE);
>>> -#else
>>> -       free_pages_exact((void *)addr, free_size);
>>> -#endif
>>> -       __kfence_pool = NULL;
>>> -       return false;
>>> -}
>>> -
>>>   /* === DebugFS Interface ==================================================== */
>>>
>>>   static int stats_show(struct seq_file *seq, void *v)
>>> @@ -896,6 +921,10 @@ void __init kfence_init(void)
>>>   static int kfence_init_late(void)
>>>   {
>>>          const unsigned long nr_pages = KFENCE_POOL_SIZE / PAGE_SIZE;
>>> +       unsigned long addr = (unsigned long)__kfence_pool;
>>> +       unsigned long free_size = KFENCE_POOL_SIZE;
>>> +       int ret;
>>> +
>>>   #ifdef CONFIG_CONTIG_ALLOC
>>>          struct page *pages;
>>>
>>> @@ -913,15 +942,29 @@ static int kfence_init_late(void)
>>>                  return -ENOMEM;
>>>   #endif
>>>
>>> -       if (!kfence_init_pool_late()) {
>>> -               pr_err("%s failed\n", __func__);
>>> -               return -EBUSY;
>>> +       ret = kfence_alloc_metadata();
>>> +       if (!ret)
>>> +               goto free_pool;
>>> +
>>> +       addr = kfence_init_pool();
>>> +       if (!addr) {
>>> +               kfence_init_enable();
>>> +               kfence_debugfs_init();
>>> +               return 0;
>>>          }
>>>
>>> -       kfence_init_enable();
>>> -       kfence_debugfs_init();
>>> +       pr_err("%s failed\n", __func__);
>>> +       kfence_free_metadata();
>>> +       free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
>>> +       ret = -EBUSY;
>>>
>>> -       return 0;
>>> +free_pool:
>>> +#ifdef CONFIG_CONTIG_ALLOC
>>> +       free_contig_range(page_to_pfn(virt_to_page((void *)addr)), free_size / PAGE_SIZE);
>>> +#else
>>> +       free_pages_exact((void *)addr, free_size);
>>> +#endif
>>
>> You moved this from kfence_init_pool_late - that did "__kfence_pool =
>> NULL" which is missing now.
