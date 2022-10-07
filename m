Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5AA5F7B02
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJGPus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiJGPun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:50:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170D695AC9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:50:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b2so12236404eja.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNTmuNCWLOBt7Dn0WJ9AWpiVdld1LXssI0yIAz367cA=;
        b=epIDQ6A1NNQAad6uG5hDVw65y+OS+Gi7r1NkL6k7hU1W/gPZkSZiyNbfyA0m4OrKJm
         cTosb3yx0utfeygMpBS7Flbe00GJQoiNG6p9H+qj7AysMK77myuofqRcnU+LG/eutpD+
         uMd/EYLzhOPPCW4x01BjMJUqSR2lS5UlXEYQ7PSp0MXWOGw8XWX8LYCMLEUkFEvhz/SD
         FJD0CGHm2PKwIBO7oDsO+y10ko8spzKUhV9D2BMcwJi7182EGQp8PyWD6hFxFa9kgIP9
         7QkRRP9UkyncU0vPYiPS2IFymQcQ8T00hoP8p6TbvBWY/fdj6SWQqN7+JWt9z45KV05J
         Y96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNTmuNCWLOBt7Dn0WJ9AWpiVdld1LXssI0yIAz367cA=;
        b=nTEh2IY8aCAZ0oUlxd354QXKHt8Zy/Y/8a8uGa5MHanCC49HubA+EHzL6tRWXfDOpP
         DZf0waHtMMfgMq3s4a2i2kvQ6sEC1ajpTYCpQj3WIrR+Lcl4wCPXjclu0nrIkIwArVdU
         xe7eJfoyENhyMlD6VW7piqCjZ2TtLcRz+7EvjjCCT9lUC7zSZFIN2Gr7HkxC3Jma8lwW
         PGD57et4KmCb3tWB5P1Xvii0i/im1V/GvVMwwgOpufDwR1vWxDjPUPD6roTfczIBD6B6
         KWsQSMsCUI2jnA7vUA22UtROTUZcLOsEbFa79fnvqUf3E2FcTSrAf21M9j/nTFhrVnEb
         Vvpw==
X-Gm-Message-State: ACrzQf2ww9JPTDtAYY3fsQPcqWpHzwxmsPqFdLR9O5IxYhpV6TI9j5mC
        c3rcc5hz6LoAQeEvHyNL4G33O1BkknEmGA==
X-Google-Smtp-Source: AMsMyM6Df+6E0+r6CgIGkIXFZqhXP/GHw9Pf0It4zNF+xakRMXSZw9LtRpRSeR3bhbNF8kZlo/hI1g==
X-Received: by 2002:a17:907:62a1:b0:781:b320:90c0 with SMTP id nd33-20020a17090762a100b00781b32090c0mr4432995ejc.255.1665157840495;
        Fri, 07 Oct 2022 08:50:40 -0700 (PDT)
Received: from [192.168.1.93] (adsl-75.176.58.241.tellas.gr. [176.58.241.75])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b00782cd82db09sm1395373ejg.106.2022.10.07.08.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 08:50:40 -0700 (PDT)
Message-ID: <677bc264-c507-3bed-6d51-0d010a0dd449@gmail.com>
Date:   Fri, 7 Oct 2022 18:50:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] xen/virtio: Convert PAGE_SIZE/PAGE_SHIFT/PFN_UP to Xen
 counterparts
Content-Language: en-US
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
References: <20221006120912.1948459-1-olekstysh@gmail.com>
 <96a16b32-0950-b538-65e5-9955ed8cc529@gmail.com>
 <b3b8047e-b4a5-1e75-2a55-a7beecf8ca7d@epam.com>
 <7f54bdab-c68f-0d38-93f4-007408151f01@gmail.com>
 <816da52a-f646-c114-fa6d-9320152a0e79@epam.com>
From:   Xenia Ragiadakou <burzalodowa@gmail.com>
In-Reply-To: <816da52a-f646-c114-fa6d-9320152a0e79@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/7/22 16:43, Oleksandr Tyshchenko wrote:
> 
> On 07.10.22 10:15, Xenia Ragiadakou wrote:
>>
>> On 10/7/22 00:13, Oleksandr Tyshchenko wrote:
>>
>> Hi Oleksandr
> 
> 
> Hello Xenia
> 
> 
>>
>>>
>>> On 06.10.22 20:59, Xenia Ragiadakou wrote:
>>>
>>> Hello Xenia
>>>
>>>>
>>>> On 10/6/22 15:09, Oleksandr Tyshchenko wrote:
>>>>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>>>
>>>>> Although XEN_PAGE_SIZE is equal to PAGE_SIZE (4KB) for now, it would
>>>>> be more correct to use Xen specific #define-s as XEN_PAGE_SIZE can
>>>>> be changed at some point in the future.
>>>>>
>>>>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>>> ---
>>>>> Cc: Juergen Gross <jgross@suse.com>
>>>>> Cc: Xenia Ragiadakou <burzalodowa@gmail.com>
>>>>>
>>>>> As it was proposed at:
>>>>> https://urldefense.com/v3/__https://lore.kernel.org/xen-devel/20221005174823.1800761-1-olekstysh@gmail.com/__;!!GF_29dbcQIUBPA!zHt-xZ_7tZc_EM6zva21E_YgwIiEeimFWfsJIpPwAu-TBcnzQhXHqlKzmXmwIcI6uIx_arHNZiaZeHt_428_8p-DyMpd$
>>>>>
>>>>> [lore[.]kernel[.]org]
>>>>>
>>>>> Should go in only after that series.
>>>>> ---
>>>>>     drivers/xen/grant-dma-ops.c | 20 ++++++++++----------
>>>>>     1 file changed, 10 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
>>>>> index c66f56d24013..5392fdc25dca 100644
>>>>> --- a/drivers/xen/grant-dma-ops.c
>>>>> +++ b/drivers/xen/grant-dma-ops.c
>>>>> @@ -31,12 +31,12 @@ static DEFINE_XARRAY_FLAGS(xen_grant_dma_devices,
>>>>> XA_FLAGS_LOCK_IRQ);
>>>>>       static inline dma_addr_t grant_to_dma(grant_ref_t grant)
>>>>>     {
>>>>> -    return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant <<
>>>>> PAGE_SHIFT);
>>>>> +    return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant <<
>>>>> XEN_PAGE_SHIFT);
>>>>>     }
>>>>
>>>> With this change, can the offset added to the dma handle, generated by
>>>> grant_to_dma(), be the offset in the page? Couldn't it corrupt the
>>>> grant ref?
>>>
>>>
>>> Good point, indeed, I think it could corrupt if guest uses a different
>>> than Xen page granularity (i.e 64KB).
>>>
>>>
>>>>
>>>>>       static inline grant_ref_t dma_to_grant(dma_addr_t dma)
>>>>>     {
>>>>> -    return (grant_ref_t)((dma & ~XEN_GRANT_DMA_ADDR_OFF) >>
>>>>> PAGE_SHIFT);
>>>>> +    return (grant_ref_t)((dma & ~XEN_GRANT_DMA_ADDR_OFF) >>
>>>>> XEN_PAGE_SHIFT);
>>>>>     }
>>>>>       static struct xen_grant_dma_data *find_xen_grant_dma_data(struct
>>>>> device *dev)
>>>>> @@ -79,7 +79,7 @@ static void *xen_grant_dma_alloc(struct device
>>>>> *dev, size_t size,
>>>>>                      unsigned long attrs)
>>>>>     {
>>>>>         struct xen_grant_dma_data *data;
>>>>> -    unsigned int i, n_pages = PFN_UP(size);
>>>>> +    unsigned int i, n_pages = XEN_PFN_UP(size);
>>>>>         unsigned long pfn;
>>>>>         grant_ref_t grant;
>>>>>         void *ret;
>>>>> @@ -91,14 +91,14 @@ static void *xen_grant_dma_alloc(struct device
>>>>> *dev, size_t size,
>>>>>         if (unlikely(data->broken))
>>>>>             return NULL;
>>>>>     -    ret = alloc_pages_exact(n_pages * PAGE_SIZE, gfp);
>>>>> +    ret = alloc_pages_exact(n_pages * XEN_PAGE_SIZE, gfp);
>>>>>         if (!ret)
>>>>>             return NULL;
>>>>>           pfn = virt_to_pfn(ret);
>>>>>           if (gnttab_alloc_grant_reference_seq(n_pages, &grant)) {
>>>>> -        free_pages_exact(ret, n_pages * PAGE_SIZE);
>>>>> +        free_pages_exact(ret, n_pages * XEN_PAGE_SIZE);
>>>>>             return NULL;
>>>>>         }
>>>>>     @@ -116,7 +116,7 @@ static void xen_grant_dma_free(struct device
>>>>> *dev, size_t size, void *vaddr,
>>>>>                        dma_addr_t dma_handle, unsigned long attrs)
>>>>>     {
>>>>>         struct xen_grant_dma_data *data;
>>>>> -    unsigned int i, n_pages = PFN_UP(size);
>>>>> +    unsigned int i, n_pages = XEN_PFN_UP(size);
>>>>>         grant_ref_t grant;
>>>>>           data = find_xen_grant_dma_data(dev);
>>>>> @@ -138,7 +138,7 @@ static void xen_grant_dma_free(struct device
>>>>> *dev, size_t size, void *vaddr,
>>>>>           gnttab_free_grant_reference_seq(grant, n_pages);
>>>>>     -    free_pages_exact(vaddr, n_pages * PAGE_SIZE);
>>>>> +    free_pages_exact(vaddr, n_pages * XEN_PAGE_SIZE);
>>>>>     }
>>>>>       static struct page *xen_grant_dma_alloc_pages(struct device *dev,
>>>>> size_t size,
>>>>> @@ -168,7 +168,7 @@ static dma_addr_t xen_grant_dma_map_page(struct
>>>>> device *dev, struct page *page,
>>>>>                          unsigned long attrs)
>>>>>     {
>>>>>         struct xen_grant_dma_data *data;
>>>>> -    unsigned int i, n_pages = PFN_UP(offset + size);
>>>>> +    unsigned int i, n_pages = XEN_PFN_UP(offset + size);
>>>>
>>>> The offset, here, refers to the offset in the page ...
>>>>
>>>>>         grant_ref_t grant;
>>>>>         dma_addr_t dma_handle;
>>>>>     @@ -200,8 +200,8 @@ static void xen_grant_dma_unmap_page(struct
>>>>> device *dev, dma_addr_t dma_handle,
>>>>>                          unsigned long attrs)
>>>>>     {
>>>>>         struct xen_grant_dma_data *data;
>>>>> -    unsigned long offset = dma_handle & (PAGE_SIZE - 1);
>>>>> -    unsigned int i, n_pages = PFN_UP(offset + size);
>>>>> +    unsigned long offset = dma_handle & ~XEN_PAGE_MASK;
>>>>
>>>> ... while, here, it refers to the offset in the grant.
>>>> So, the calculated number of grants may differ.
>>>
>>> Good point, I think you are right, so we need to additionally use
>>> xen_offset_in_page() macro in xen_grant_dma_map_page(),
>>>
>>> something like that to be squashed with current patch:
>>>
>>>
>>> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
>>> index 9d5eca6d638a..bb984dc05deb 100644
>>> --- a/drivers/xen/grant-dma-ops.c
>>> +++ b/drivers/xen/grant-dma-ops.c
>>> @@ -169,7 +169,7 @@ static dma_addr_t xen_grant_dma_map_page(struct
>>> device *dev, struct page *page,
>>>                                             unsigned long attrs)
>>>     {
>>>            struct xen_grant_dma_data *data;
>>> -       unsigned int i, n_pages = XEN_PFN_UP(offset + size);
>>> +       unsigned int i, n_pages = XEN_PFN_UP(xen_offset_in_page(offset)
>>> + size);
>>>            grant_ref_t grant;
>>>            dma_addr_t dma_handle;
>>>
>>> @@ -191,7 +191,7 @@ static dma_addr_t xen_grant_dma_map_page(struct
>>> device *dev, struct page *page,
>>>                                    xen_page_to_gfn(page) + i, dir ==
>>> DMA_TO_DEVICE);
>>>            }
>>>
>>> -       dma_handle = grant_to_dma(grant) + offset;
>>> +       dma_handle = grant_to_dma(grant) + xen_offset_in_page(offset);
>>>
>>>            return dma_handle;
>>>     }
>>>
>>> Did I get your point right?
>>>
>>
>> I think it 's more complicated than that.
>> Let's say that the offset in page is > XEN_PAGE_SIZE, then the
>> calculation of the number of grants won't take into account the part
>> of the offset that is multiple of the XEN_PAGE_SIZE i.e it will
>> calculate only the strictly necessary number of grants.
>> But xen_grant_dma_map_page() grants access to the whole page because,
>> as it can be observed in the code snippet below, it does not take into
>> account the page offset.
>>
>> for (i = 0; i < n_pages; i++) {
>>    gnttab_grant_foreign_access_ref(grant + i, data->backend_domid,
>> xen_page_to_gfn(page) + i, dir == DMA_TO_DEVICE);
>> }
> 
> 
> Thanks, valid point. Agree it's indeed more complicated. I will comment
> on that later. I have just pushed another fix, it is not related to
> XEN_PAGE_SIZE directly, but also about page offset > PAGE_SIZE
> 

I got a little bit confused with the order that the patches will be 
applied :)
IIUC the above scenario cannot happen, i.e the offset to be > PAGE_SIZE, 
because this callback is used to map for transfer a portion of a single 
page.

> so touches the same code and should be prereq:
> 
> https://lore.kernel.org/all/20221007132736.2275574-1-olekstysh@gmail.com/
> 
> 
>>
>>>>
>>>>
>>>>> +    unsigned int i, n_pages = XEN_PFN_UP(offset + size);
>>>>>         grant_ref_t grant;
>>>>>           if (WARN_ON(dir == DMA_NONE))
>>>>
>>>
>>> Thank you.
>>>
>>>
>>

-- 
Xenia
